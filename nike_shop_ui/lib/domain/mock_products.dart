import 'package:nike_shop_ui/domain/product.dart';
import 'package:nike_shop_ui/gen/assets.gen.dart';

const mockProducts = <Product>[
  Product(
    title: 'Nike PhantomVNM\nClub FG',
    subtitle: 'PHANTOM PROJECT',
    price: '\$69.99',
    category: 'Football',
    image: Assets.nikePhantom,
  ),
  Product(
    title: 'Nike Epic\nReact Flyknit 2',
    subtitle: 'EPIC REACT',
    price: '\$79.99',
    category: 'Running',
    image: Assets.nikeFlyknit,
  ),
  Product(
    title: 'Nike Air Zoom\nPegasus 36',
    subtitle: 'ZOOM PROJECT',
    price: '\$89.99',
    category: 'Running',
    image: Assets.nikePegasus36,
  ),
  Product(
    title: 'Nike Air Max\n1999',
    subtitle: 'AIRMAX PROJECT',
    price: '\$99.99',
    category: 'Casual',
    image: Assets.nikeAirmax,
  )
];
