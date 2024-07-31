Return-Path: <linux-iio+bounces-8116-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92986943911
	for <lists+linux-iio@lfdr.de>; Thu,  1 Aug 2024 00:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 121681F225D5
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 22:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1AF16D4FF;
	Wed, 31 Jul 2024 22:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ofUtFY3z"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2020.outbound.protection.outlook.com [40.92.19.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15DB16C68F;
	Wed, 31 Jul 2024 22:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722465606; cv=fail; b=Hsf2uJGBXFy3WCYNU+G10AkzpbBgWqwj0nz4moqS15lqtbaJMl5zx4ILkyvx0bRm2c6e+D9ysAkAwbFosbWZgytc4VTdT4epu374VTMlkMFuLerWSZP2ZaSKlc8KmGRHZ0QrjFiuoGLrAaelIYHbwjqbKR3o/iL1rman03yBvlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722465606; c=relaxed/simple;
	bh=1ZydNY8SjoSqifOxDHGde9j2h9FcB+Vty2THSERCk8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Tm9+JS43Vy7QWguujsJHHvI+vU6S2QlBiSswybteR/1DSyMZKJ+8EC9g10srhdOLwD+ak+WNw/iqwH/3O5lMn++KDG7CMideZ7VpB6E8cBhss9t23bA4GnyOMYHibg96wfoijJum3nNxbzSpjpsqhwEJoSa7gtbrYyBIX53B6To=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ofUtFY3z; arc=fail smtp.client-ip=40.92.19.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G3s3C3GStgZeTUVS2HuKId2dD81jrSXmv/OFgI4a2ZMaGTIcLbvQzhwwMdKVJGa0en8YkCnjd/jMeTd5ShGA4ptT5Fe7aHG3X+xNumFSaSJT5wfFuBg7Sx2eorz8U6d9igiECLnlHVytgH0A1IkumhuI5WPHAzQ6brIFAsBMSfiPV8AgxhcXjdknJav+whrhRxvYsqKZgftMzpWhZkBkw/On3GxN6aUMSEMTEciurGjpY+k3LzYUikDD1ifuQfGAi1NEjKLzrhmwgDDV9lBNErkTCQzbk3rA1ZPRs+2oSY8qfbWrWP9w/43q47Bm3Z6P3fmJv3XSDly1s1AD3royaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1FA1o4i95AVVRJrczX4tzY5tn76EAX2KNT0b9oySDjI=;
 b=ocTl931dxhumzh3OUCkTL8v2eUpk+quEbA59abvMKN8GY7nPuf0BnlfSx6pyobASr+GG0pZ3QuaUr7gIa07sxUPgsKYTPy5V16YCSGdw7+U0mDK/UveBH8j/n7nUkc2RG3HxeTJBe7UCxXDHJTzkPgHcN2Gc5dskauO13uKiKzOcnNyqPk9GhGz7L+DNPYc7zhsWeMu7XHtK8JZSz3n1b6hoYpdQ/TbseiAHuEm2Xq+0jtkWsOXDg5HL82L72mwfwsYkRH09O2KcMP1DOmPAo16P3ZSBvj+bp+W16wW3lhss6bmTJhBxfLyvPGjTEjrdMDVPVHugBdfkiIg66rUl2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FA1o4i95AVVRJrczX4tzY5tn76EAX2KNT0b9oySDjI=;
 b=ofUtFY3zvyxNbVNGhpEkuUvhxPFQ/FWNbJveBy/xQZgzAUKexs/V3wMYdmq/qAAtua3bffFxZ4Zk7uMYXH76i93lsn8TvYFPYd4XNxtA33V+AUOoBda6qc7UGG1USpoWxUs7InmozemIuanuGz6S8pdf517464l7im/PDtO/KrzIZvvKj7H7DgsZ414t9MFkXxpAvqGjKLnFXWIn4umwNzzfCA2S5sOhMp7tDdLS36bRs6E3y5JBscbJQINrWR3DD/h9LLmAHO4c6aTxJ4UUEquXElMB09BACNrFpyAdQ4BFyxJZmFDUajpXAqIFVv1yfYZRU20rTdK1nwog4mAY9g==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SA1PR20MB5151.namprd20.prod.outlook.com (2603:10b6:806:256::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 31 Jul
 2024 22:40:01 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%5]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 22:40:01 +0000
Date: Thu, 1 Aug 2024 06:39:30 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
	Inochi Amaoto <inochiama@outlook.com>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	=?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: adc: sophgo,cv18xx-saradc.yaml:
 Add Sophgo SARADC binding documentation
Message-ID:
 <IA1PR20MB495336386180CEF6A5ABA73DBBB12@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <20240731-sg2002-adc-v3-0-5ac40a518c0a@bootlin.com>
 <20240731-sg2002-adc-v3-1-5ac40a518c0a@bootlin.com>
 <IA1PR20MB495346557FA84CC694D184A0BBB12@IA1PR20MB4953.namprd20.prod.outlook.com>
 <184916b4-8e7b-4ed1-913e-dc03e5f61364@bootlin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <184916b4-8e7b-4ed1-913e-dc03e5f61364@bootlin.com>
X-TMN: [1QsKIOVjkOSqrrdV2CQxQd8MnTwGMQNEMHcF3sXPAM8=]
X-ClientProxiedBy: SI2PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:196::7) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <lr3gq4fulzvaywfmbrhqqb2n3uwfr4ksc6qgbrxezefci72wow@qq5ospvyugq4>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SA1PR20MB5151:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dd9b037-7251-4c09-2b05-08dcb1b1b6a3
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|461199028|8060799006|5072599009|4302099013|3412199025|440099028|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info:
	qWUCWo6f45jicKSwEthkVtivGgr6f95ykpZ5IT2QuTb7pUjzb0p5naxxAJdXZiUXjN7DTwmxjwykhIwEW9qQtDcIST/8Ohw2QGmQnsoYNpmMzyal+LlB63tsaHgj+ea2br8UlSBcOYtFRwH+D4a/l0N7GXet64saTL8unpxMfA0C7Y5ZaQw+5J2hwhtiskyoUpOVWjLJH4TZQKElA71UgMJBs7fnttTWdhgUuW3Lrf2xly8QM1IUIAmGDz/1GYi2MMACsqItymLhL7fTGE3ruPYY0HCOQ85+0wA5gOiCEJZKhRIhbBB2V96NTncAx5pWK/s0rb+uVBJjLwEi4CiZipMHmInnXtzvpECG/LhLNBhgmaLS8+RfBUGd6lkBSJyIUDLmXhvjY3A0I70iTzvH+4sD36t0Dzy1r/kBdWT+r8wRZ1DH3ubN+XA6gUelLYrpLzg9y8Yo/pgwN0CD6ugiS1JQkaMOdV3tWVl7i9u7Xlj/+o2oTMWWunjcmgdeJQ7CK5koaZFXtV6MqjNs77Y5iTMAp5sVqHV9UPaZiLsiW/dwCQAPC0AGokOhbJr0Ks1pK3DiZTo0OROxYCVY3rEtQJ2CVlkeN6yznmsKCDNfbFVIHyfX4G7oEK0I99/3hgXf9kCne/jnaVnofqQWVNPZbsr0Ly75hKzQOTMCffSQjXCJkgLTpbMD0+lfhWue8pV4EO7W6tt+v7i8pqTA5t/1B6yaAbXLFzAtTnKeQz6cq2dQquiivS3Zk/ek8NylRF76DAShn5b+gVOwbeWDKCk+zTZes/5aD+tPJ94XU6Gbw9R7/HwEfXaNQTpyNPyx8qiPKthO3N0nVDnoch/0J0tyXA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xWiZ303fSPSk6N0j08tIYKL8tJxOODyKPn+dECvqNzOpomN46b1RPsFDahx1?=
 =?us-ascii?Q?6lrqtKDePY5qLfk9RkTnk67UCDfaUXcGjJaORAO/bC/XwY6fbcQjQ7UWDs8z?=
 =?us-ascii?Q?Lbz7ZbXiCQBfIFZtDIL11f8+Ye9TYrv6C+ZxT5WkyIiUpJrDDN+Saqf2nD21?=
 =?us-ascii?Q?5Bqm0JNgOK9yJ6dZS3zBrYsYF7uAXCzE+uU3LG1275nTI4NFQf0rqh1M/txZ?=
 =?us-ascii?Q?07t1+BrfNIy6tPAGnYH8c8S1S3Iak6UBelra25sLj+CuFpbAUmSfnYyHa4F7?=
 =?us-ascii?Q?w6szTPn1kwTpg06sYiCv0G6ZmuFG8qQPbKobssRlM8nRJLm5HNNtbkcH9OxP?=
 =?us-ascii?Q?KxbLqCJaG1uERO+mrVprLsZ/Nhng5L0Ju6GjyJI+9e5t+MyVskQcfTcnppSw?=
 =?us-ascii?Q?gxLZbrIZ4R2HtxUmNkFw8akFY71wmdbfKLzna052/mj+SVKhRn+dUyPFUU0W?=
 =?us-ascii?Q?q9tJB9dDaK8ZKQ3nV9ovhhXTrxcndw518AJOxAP2YRoC2L0Tn6Ni+rLaSMLp?=
 =?us-ascii?Q?rovbwnfns5dX1AUHppLYBjJbxPWmzi41JYA29nvJVRoPJJX44JcnhbECIfSn?=
 =?us-ascii?Q?Vgn2vSRuH+HS36+8pr6ivuEyLZxXPOk5BSjYAufkfMlS0BfiSgG0x0Qauy3J?=
 =?us-ascii?Q?tyirXHVVhgP80tZgi3gQcRUuDqOT2B957Bxd37TKvznmRCC+dLUuDocH4NYo?=
 =?us-ascii?Q?+xiNMoveWc+Om0MFHEjYkGcjmhZGCbmfCdYR8GIDFrK6fVHYgblA3COMyy9G?=
 =?us-ascii?Q?xNlOJ8a4FRbUY0vsjBA+O3VVARP+Vt+wqXVzzXKdKVeAt/XYwGId49sHWjru?=
 =?us-ascii?Q?HAAN/v6F6pA4d+rhhhYRiR2fznDf8m5DlkkXKJ91hzK+DVB4YXrgsHzE4F5j?=
 =?us-ascii?Q?hXMSXew8hJ82t+Yrf9C83XZtywjJk8xBH5YyBPSTDG+cuOACiUYERmDzPhts?=
 =?us-ascii?Q?JZdvv5joQrm8MLbdxWHQV4FcdhqrwXqf/Q7FTRznfaCiGXJJ7iG8BU0HdiRU?=
 =?us-ascii?Q?eff4Pj2/aZ2unMzzTg4Vifwl7hOAP0bo7lXhikM0mWRyEBVN1ev4P49JmPU6?=
 =?us-ascii?Q?esB2Ep7dLvrJrH6C8vgZM8KFwx0Vd0kYRnCyJvNgEfmxHM4xE6/h2S53k7Uh?=
 =?us-ascii?Q?IFKLj1UgIC0/na/8DjqfRH+xA1kKJg9aZiv5gAo5GhQ2FZOoacAjDIkvkMS3?=
 =?us-ascii?Q?TJeKYjAuyMKGL1IcL+hVJwcsSqWdqjSqzhv3FuYHxaoVetviRSlfCMdTGMOh?=
 =?us-ascii?Q?yNVMtPJix3GyPIpqcPCp?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dd9b037-7251-4c09-2b05-08dcb1b1b6a3
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 22:40:01.4763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB5151

On Wed, Jul 31, 2024 at 04:48:01PM GMT, Thomas Bonnefille wrote:
> 
> 
> On 7/31/24 2:41 PM, Inochi Amaoto wrote:
> > On Wed, Jul 31, 2024 at 02:24:14PM GMT, Thomas Bonnefille wrote:
> > > The Sophgo SARADC is a Successive Approximation ADC that can be found in
> > > the Sophgo SoC.
> > > 
> > > Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> > > ---
> > >   .../bindings/iio/adc/sophgo,cv18xx-saradc.yaml     | 48 ++++++++++++++++++++++
> > >   1 file changed, 48 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-saradc.yaml
> > > new file mode 100644
> > > index 000000000000..79d8cb52279f
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-saradc.yaml
> > > @@ -0,0 +1,48 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/adc/sophgo,cv18xx-saradc.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title:
> > > +  Sophgo CV18XX SoC series 3 channels Successive Approximation Analog to
> > > +  Digital Converters
> > > +
> > > +maintainers:
> > > +  - Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> > > +
> > > +description:
> > > +  Datasheet at https://github.com/sophgo/sophgo-doc/releases
> > > +
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> > > +      - items:
> > > +          - const: sophgo,cv1800b-saradc
> > 
> > There is no need to use "oneOF" and "items"
> > 
> 
> Thank you very much, I'll do that.
> 
> > Suggestions: add a compatible like "cv1800-saradc" as fallback
> > and add use "sophgo,cv1800b-saradc" as specific compatible.
> > Use the "cv1800-saradc" in the cv18xx.dtsi and override the
> > compatible with specific one if necessary.
> > 
> 
> If I understand correctly, maintainers doesn't want the use of wildcards as
> generic compatibles [1]. They prefer to use the most basic SoC as the
> generic compatible.
> Is the CV1800 a real SoC or is it just a kind of wildcard to say CV18* ?

Yeah, that is the wildcard too. 

> 
> > For example:
> > - items:
> >      - enum:
> >          - sophgo,cv1800b-saradc
> >      - const: sophgo,cv1800-saradc
> > - const: sophgo,cv1800b-saradc
> > 
> 
> To avoid the issue of falling back on a wildcard I planned to do this
> instead:
> properties:
>   compatible:
>     const: sophgo,cv1800b-saradc
> 

I have read the link, it seems the upstream may prefer this solution.
Let's use cv1800b as the basic fallback.

> 
> 
> > Regards,
> > Inochi
> 
> [1] : https://lore.kernel.org/all/20240708165719.000021b9@Huawei.com/
> 
> Thank you for your comments :)
> Thomas

