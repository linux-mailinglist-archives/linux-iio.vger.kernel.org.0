Return-Path: <linux-iio+bounces-8099-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FD0942ED5
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 14:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C823E1C214BF
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 12:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116CD1B011A;
	Wed, 31 Jul 2024 12:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="SKk6NUS0"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02olkn2089.outbound.protection.outlook.com [40.92.43.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C25A1B0116;
	Wed, 31 Jul 2024 12:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.43.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722429712; cv=fail; b=UnRorNK1ifTLNkwolBdGklBeaSnE02Npnxyu9iw/3WhrDviLRNl3AgViHm0zhlyH5zLJfkbauie/lv2XaUT6NOw+qwP4g5HN2gYmuGSlF7n8uaxtoBa5VHjcb5v2iG0GUaJq1MkVwqtj7+ffrlAY5/YZXyCWTXCmEQxebM6/CCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722429712; c=relaxed/simple;
	bh=BhTl5Xl6UMBxaqO357EDsNoFxHi++2iBX/bRFkGT2Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uJWRM7QorYUJwSt3u9+Hb2s2B0Q+vsPeSbvEvw3nhRRyy/wPC7/S4bwpWBbz4Eoev068XvSTSvfLHFHQpBBuiVCf0QyFY7A0vcIenOi3QgyGB1zrBh/EBiuP12TJpt9t6rae7QnRdfvr1zo4xwFX8M4cc2b3QxJLsmbouXXPeqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=SKk6NUS0; arc=fail smtp.client-ip=40.92.43.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vRUVbAgqr/A9Av5uc+U4S4yoMMdLGa8o54uhBhgIibzPJpUbESqgp9mF5XWLVjEFnL/WLIprWZm3XNNvnJQ4jEI145+X1aW2P7UXgBaDufAYlfF7qK8x2aw7pRS4jok79cXwXx9pyMVRBWz6qAOJ8JPujbMjhGxWysJgXVvMe1fsYuoTbQCqLXj5hFWY58Up4ntgzRSCkOpLklhQxd2eHLFSudSHKJBsRhiLQvw59PUviqJnHvprA3XZ0bsFrRp2HmoLoTSJkKB+ClDnniIbittcDqZdvX1CI7/KAqPlIWdBK/BM9IfHXKoVmwxr6eqWDE8zThMQma2HMDqKYA7QEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvAHz4yQAL4uahyHS2xJojklvKG1O9ltEKPyNhuvyus=;
 b=IIHlh7ZN68gBwVdRqudv9WJdaBCMTxmDSSKaKRVX82xDQVX7RaKo7kKtlqP5pacWgonmmY1kFOry0GP3mivXCGrKhDjKdXbnNYycxvbwUAacDnOTsMst3VkKEDWOgxLwj7YsXLq67Ikemf3R61ERODk5IodbdUtExiXsHRTghosggyEqD6TCHSLGUqnJ/HpMkM9I4ZhenMInJoKFZbV6mAO/LbyAtFD1O3s6Two04o4VMMzmsjo0pk2ag2h7S2E94iL5F941MTLKqN3J9d2pZWFodudZb3s6z0PETpCCAiGJ8S/EUpX7VjvLabk08bJ83qPjgCFuFdgncUKOhEja2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvAHz4yQAL4uahyHS2xJojklvKG1O9ltEKPyNhuvyus=;
 b=SKk6NUS0o1Qd1awIM7JuslDyjU7M96InRt1m4lDbDxS4OuIMooJ+Rfx/FY59+DQkE+Csiik56g4BkI0mUcBFIGsykwvDwY4QuZh6UR4xf7/U/frMxQFmkozKbfxQjCi+0xKT27ZFUgeErQk7RIPOHD0Y4HdiuufzGkjb8ViMdbyTGRg2b3vI5WZIWtKZcpn/oXHwhWttEc9B/9MYn6e+yFJoKR+N8bgxWx0KANfmFfrCO0FHV1skS571Xp7pmBIMGzZmvaf+/7oPyXhVG3X+ivZtGCd4hB0jdl4fE1qtTIK81yMNnd1lk3+WVp6tHzUNRpjFjly1eadb91ttVdkNcQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by IA1PR20MB5075.namprd20.prod.outlook.com (2603:10b6:208:3a4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Wed, 31 Jul
 2024 12:41:48 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%5]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 12:41:48 +0000
Date: Wed, 31 Jul 2024 20:41:16 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, 
	Inochi Amaoto <inochiama@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	=?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: adc: sophgo,cv18xx-saradc.yaml:
 Add Sophgo SARADC binding documentation
Message-ID:
 <IA1PR20MB495346557FA84CC694D184A0BBB12@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <20240731-sg2002-adc-v3-0-5ac40a518c0a@bootlin.com>
 <20240731-sg2002-adc-v3-1-5ac40a518c0a@bootlin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731-sg2002-adc-v3-1-5ac40a518c0a@bootlin.com>
X-TMN: [O8KHsFodLQH44roKyqQXHZHp3CaipKc2f0C+yFNzIe8=]
X-ClientProxiedBy: SGXP274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::23)
 To IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <c2damdamehfyjniarkoozv3stf3hqmnpezlexufpz2pwtybvyq@nrsje5mdntw5>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|IA1PR20MB5075:EE_
X-MS-Office365-Filtering-Correlation-Id: 443afc85-63dc-440d-32b5-08dcb15e2458
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|19110799003|8060799006|4302099013|3412199025|440099028|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info:
	O3lyaCQeQH4z1XiBggPxMYv8mlc4ueWsV4fW9rbpWo1IP0vuiDouN+Q0qMVxKTEZfphExbnN72P8iZ1NCFOXKbg2sgCMFrTxc2gAbU3MzFZGsaR3BOU1HMcA47xqTCN/P8Dx0pl7ssfat84IIi5hPRONFo8Mk6dcAAEhD17njkixokIY+/tw2ido7hjHt9FIVLwEL4K6GgORamIyQhy8GeMqLnewqA4RZMyH6aliNWmv4SzLSIZNH6iIxoXdAkClMBcdeuZA2T7hLXR/cQJnIXsdzzEDoDi9prDP4eDJid6vibmAuUmPsBUaNKBjsRXX/D00s37+DYD7QnWLkOIRBSn0lJNTvDAkp0xYZnuGFUrJDaaYTqLilYkYRlgZJF3hTkLL8mU8BLWJ9Nau8a3NzMtOdmZvzl70g+G0auFKYf+ntPqcWUYEum75uQUPrevVk6NMIdo1TEyLgGmOCgVW525SF/RrqrbrkPjIxOmWWkiCLPbLrgIvNHIX8xsS9VflRBQInej78kNsuX+OHiEQVRc1F0mwhHxiPNxOGRNLfenaf4GWl+KNnpHignOH/2ewE7EvJSkZtZg5XbLaRXe3Pl6M4waMjJj7sOVOSfPQP9+8SwfSHS7Sqxkl2AV/EUe6A2Z53NN7N6gnlglkBjX6frb4ZZDlVqF1TNOLq6ZX69gcKkWu8Q0zlV4KNtlgzB0ADra7lA0YdKhKfXXsz+9ZVklnnbeVaXoKsXmnhkDQV39+JesFQBMU+swK45g/q7kcOAcJ28wZmZiwYnYDmnPOiPHmzzlXp98EPqyctz/hgXWG82KrM7rUPtZvHwla+6GVSB5dM0Xuh9N6RrqB9iTTTA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GxKNvLDoQLiSzoOlDcFxRSjdkg64XnYBxRwVazbUzef/IsqI6KbsbajYFuEx?=
 =?us-ascii?Q?g7QMSriK41ewpqy1V2/aLdIhuM04pDYr1wU2jqstVa8oMAvSGBY+pixeMCZ3?=
 =?us-ascii?Q?LgMWi75i+qYpxXOVxP0IxJGDNPn/IiFH5IQuuPKUdcGn2vPaNI0qduhTZoh6?=
 =?us-ascii?Q?S7C63Tv92/CyLRkt4MnM2x8qb2QoRItorD5rV/1nNECie0B14PBt7nzjDzPg?=
 =?us-ascii?Q?ya5Cvm3tKiJyZ332dMmeSZUbiCXOgLvIBAuIpoxz97aNUlFmn5vthgULP3Se?=
 =?us-ascii?Q?LVQa0MJ4B6/tifr3TGyvcNvXb67apciQ8ZVmN/3fZxfPVTRAlbThcijHORUH?=
 =?us-ascii?Q?ctWpZYEVpD6mFGqAceAMbcrvAPni8KvZ1ppNv5ldvCOgNfg42AkbS+1gCK5Z?=
 =?us-ascii?Q?8NVk69XEgemDNiI9luyEF64Il8dRVs6tRA8zZqp4+tzme2K+D7roNnIcfG1d?=
 =?us-ascii?Q?D0ml63g+5OsmHVvYnaR7X70OC+d+i5P292wJsg0dMEFS8JAzKdx4An1zlT+I?=
 =?us-ascii?Q?GEKNjRC9EdrzZYrerna2aw/rJiMkGJpjG9La1pUA0WD4mm6T7BXSJRTZbkrc?=
 =?us-ascii?Q?np1FrBb0rlvt4M6PPD6283NXYPCEwwQ8WT+h5e3TXmJm1JgKvYMUUbTvA4R8?=
 =?us-ascii?Q?OJvTWILV871b7bU/QGKRXpkWLqhqOehvwGkGu+65ewHelk+1ZKJb3ikmv91n?=
 =?us-ascii?Q?Z4zUxFF4JPHIQ0r3tmnLkx0rYlzJt7HtTni1rrcPse0bBUoypVqcqKGT3+nv?=
 =?us-ascii?Q?eZBIuAgW8Umt17l+sLoxWfo78sPDDh/guKiXhQ0rH4wyaWA7lLi5wPnXN4wQ?=
 =?us-ascii?Q?1KQG3k6g50vtdAJpzoomK3F2kwnxV+TFcuyH0y7HPCgWZTuAV2RGl/vf2n8/?=
 =?us-ascii?Q?y+5OM7+Eznm2fNyM6St0Ukyh5WQr9zXt/W1aL4WDWHfXEFxiiqqARgveZW+C?=
 =?us-ascii?Q?ycobQy646dUAhXhod7f74EnaHdhE+m/MH6cXSg5o9c5jZYbW4dl0QgcYNGpH?=
 =?us-ascii?Q?ldFebpEGf6B5aqVSylWmci5zsB+Mtx7urjvNQYx1iq0x7Sx2g4nf38Y+Btpb?=
 =?us-ascii?Q?eW35psLqBi2WChyaCOpai+1MjfNLUbaCKwyV/SrxiVh6N265baHjrxY/oMgv?=
 =?us-ascii?Q?uOrWdcs6iB1EKqeeQUWrWfZ9gryTsqtdGSe3r3xGpQCu01aKwKEsn1FsIVMA?=
 =?us-ascii?Q?1hZZl83DLlFoXCFVn4VIYu4bJcPuTR4Vw+PJfnk6xe94jGQ6CSrMfuOoo8at?=
 =?us-ascii?Q?ZNYBXYmv2Z7as2ajeBqf?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 443afc85-63dc-440d-32b5-08dcb15e2458
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 12:41:47.7235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR20MB5075

On Wed, Jul 31, 2024 at 02:24:14PM GMT, Thomas Bonnefille wrote:
> The Sophgo SARADC is a Successive Approximation ADC that can be found in
> the Sophgo SoC.
> 
> Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> ---
>  .../bindings/iio/adc/sophgo,cv18xx-saradc.yaml     | 48 ++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-saradc.yaml
> new file mode 100644
> index 000000000000..79d8cb52279f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-saradc.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/sophgo,cv18xx-saradc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title:
> +  Sophgo CV18XX SoC series 3 channels Successive Approximation Analog to
> +  Digital Converters
> +
> +maintainers:
> +  - Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> +
> +description:
> +  Datasheet at https://github.com/sophgo/sophgo-doc/releases
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: sophgo,cv1800b-saradc

There is no need to use "oneOF" and "items"

Suggestions: add a compatible like "cv1800-saradc" as fallback
and add use "sophgo,cv1800b-saradc" as specific compatible.
Use the "cv1800-saradc" in the cv18xx.dtsi and override the
compatible with specific one if necessary.

For example:
- items:
    - enum:
        - sophgo,cv1800b-saradc
    - const: sophgo,cv1800-saradc
- const: sophgo,cv1800b-saradc

Regards,
Inochi

