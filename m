Return-Path: <linux-iio+bounces-12172-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB729C49A3
	for <lists+linux-iio@lfdr.de>; Tue, 12 Nov 2024 00:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACB7F284B84
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 23:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6F217C990;
	Mon, 11 Nov 2024 23:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="To+CR+OB"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2052.outbound.protection.outlook.com [40.107.241.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8445015B122;
	Mon, 11 Nov 2024 23:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731367250; cv=fail; b=FYV30nHFBUk48avk/Kq2Bxj28/39PysHBXNYeHhWD2tWCvFEMtL9qwXwPrqnIlYZRH4WorE2r18+p1XTh2eUdj8NmCQ98FHoia+qL5H/rj38LpXx3uAgYlqqNeyL+HyhHhlEvc1KMwy9wSlu/hhpObd6fvOzHNLHDhW1QMCBIu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731367250; c=relaxed/simple;
	bh=jFUaWtVQnVO2kBv26tEwGn9yJNV1k8M0g8mIWITdq6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cterZKQslSYAd1wB3pyxoNNVNxzsSna4w3xTiYsGnH9XrztGubAOKfahPBVjk/GGawW5VCfv1HQ1vHzuxID2MBWfeyixsPsvYPPXSULKxS6DYVFGmFnuBpxNNSZRJHs+/UjTUfpBBBAsAZGencTsUepupGhFHP/+zBc2d7ZJK3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=To+CR+OB reason="signature verification failed"; arc=fail smtp.client-ip=40.107.241.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=icj4HU38sAdGiXn+7pC4Gfz+HOuOKfq2kvO6aCTvmjHL7rfwwK7YjhR6fi0F3nrH2LVPSmqMVlgNud1rTzV/QKHph4zen7RLOl4e4BU3vPpNkFeHLBfDYbymvtVZ1qKab6nNvzmfWuiEeiFJwsSWfnrfeRMZNPCXUH7iZODuE6CAdZ9BtFvM2RT9ol7JK3+PdhB9wF7ihRmLIfC3jFE98Y51cO2OxWFloLYyXh/Vf9yVERHcroOfrgy84UeZFfYG4er9rxgDu4cnNFWU6W89ZV/BbNAWst+Noy23UnWHR5FqkN7XBIAFSjaHDDer8TbEUn40HSxrU1A5D8SH+LABQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CdNOXsJ5WfUqKJ4zGFjcloh1UT4Dld+hPnaVq7K+fu8=;
 b=t3cHKIN1+EkT7ZgWzfn8NAG2T8VOYYldieD0aE8euGaUvI5amyA+bZT8Lh/5M1sxB8pY5hMoJpaUdxz8n29RU2lHkfskkWgcMFmXG1Fufoa8WXmOoyu0YR6Gb87K/LEqdBvaKe/0tsPhfWymLLpAGp9mWgTGMHBwarfOOmlNuSn8owlNVO7XmQ7KdjCZ3ZpCsnX7diVsZYpm0/OJKV3zp/90oXQGa3zYmJ2D1nhNLiTqDoDJgMsPURNvGojGpNhcUrLyAQgKQyJBP7AKtQ0ypMLtmdRV0gR82y5bL9+6whGl1x3TXJZkxhekfGTG92vfM/NYyepNdA/hm3nA1uxa3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdNOXsJ5WfUqKJ4zGFjcloh1UT4Dld+hPnaVq7K+fu8=;
 b=To+CR+OBOuSBZEgS9dUDg4YnYrPCMcFJ8i2msJVZbbJ/4vsl+jgpsZ1PWrKK9vtdDsrtJqaJpl0I4SQwSIR6bc/9M4HGOwh2kmSMyR9FY8KwJajdFypTb2XZR+Kpbcplf2AFlJKj2mJhy8IlsildIysN2nEcIoCAqMUZWMa75cUe2zjqyEPSsibbBFmskgfrQffZsbfLYdAhoQVHzHdRsArYFc9NEGZy+wiYWyOdPEAKNxphQiqSO6O6j99NykfkS6vVviyftb1zkWXS/ss5NHsptyP5lc4yD4gtKjkELPlJILklGfvTYtSdly1ctpX5f9PpWX1fI3NA9MW/5XIfpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA2PR04MB10124.eurprd04.prod.outlook.com (2603:10a6:102:407::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27; Mon, 11 Nov
 2024 23:20:44 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 23:20:44 +0000
Date: Mon, 11 Nov 2024 18:20:37 -0500
From: Frank Li <Frank.li@nxp.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jean Delvare <jdelvare@suse.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v3 4/5] hwmon: tmp108: Add support for I3C device
Message-ID: <ZzKRRdXpeHVyUDOM@lizhi-Precision-Tower-5810>
References: <20241111-p3t1085-v3-0-bff511550aad@nxp.com>
 <20241111-p3t1085-v3-4-bff511550aad@nxp.com>
 <41995c8a-8b05-4c56-b4a3-5f275a88b899@roeck-us.net>
 <e8921251-02bb-409e-88d0-d635e7d08929@roeck-us.net>
 <f2690f72-9b50-438d-8301-9e93b03de3e4@roeck-us.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f2690f72-9b50-438d-8301-9e93b03de3e4@roeck-us.net>
X-ClientProxiedBy: SA9P223CA0011.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA2PR04MB10124:EE_
X-MS-Office365-Filtering-Correlation-Id: cfd29f44-8443-427f-f68a-08dd02a7775f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?aI3dJiKGB+VxPKusjVUozUUPv31hXGVkTpSbAAxRj1bRln8jvJ69ZSpO4u?=
 =?iso-8859-1?Q?scrF7bWws5DBrxNSWx6B8/VkXYOvOSJFwmT89whW8UvQxUSht43MchbZR1?=
 =?iso-8859-1?Q?Gh8FcpBtSMNUG/jSBOrkvz8SrTWvMCfXAV3K9XzUsCemRjgNAdaext+nKx?=
 =?iso-8859-1?Q?lr12ZpwoPBY+2/f3RiaPnJyKLNwNsjg3pUTnZa0Tlxf98eB4cfCdVBjBbq?=
 =?iso-8859-1?Q?R/yiJlWi/sEwpXlxlMmTpC45QKuX+4ZGxsQ5lGsyB7+jSWG9H4QS2AKvbw?=
 =?iso-8859-1?Q?qHmYjxWg9eDpjvVHY2MoyY13b0PKhJqLkpbOBnOMTd/nadMV3AbkOmP7ic?=
 =?iso-8859-1?Q?H3XKAhY9TMkYjjBX7XTSkFDmw8a/In3slvDM/2jSjzaTFJfiI/V0qh5PVj?=
 =?iso-8859-1?Q?4slCTS0pd+VzV1CX6vg5sotx/3PVy5NnC+S65Q/4rV6+JkHfC1SdkhPkIG?=
 =?iso-8859-1?Q?GrOqKbXv9UPgUTlHTXFs0VLcFhlaD/iDUF2qvULPTpRedvzUjgZ/GdxpYQ?=
 =?iso-8859-1?Q?PuneROTwaIRHt3rAhfpVJTYn0Ec610zW0nQ8JRo4n2EFFk27WVpj2zNT2D?=
 =?iso-8859-1?Q?LXG8fcUqakxVAMl4+odumHKvhdNEValu0LgSWaMHhJR2KO7FmhHWoO4gYK?=
 =?iso-8859-1?Q?fWNkS+6eGz14WywsKRdJOay3u66EeyrSP7EKEqjYLqTVy0ct0XU/8Jl/ex?=
 =?iso-8859-1?Q?aZv/1J+Or5IT0qlYX8GtQ2xffCa3qgzRWKtxccLReCihEuEE58buibEiyb?=
 =?iso-8859-1?Q?Fe3q6efCpLj1mEH8JHtsVfV2ly046veswKjXgMa8j5ioTsDmhb13lbtsMw?=
 =?iso-8859-1?Q?q5gqFyNzQs3+ZlYKMNtjOKhcmBWIuDYyuhVhcbvdhnqQSlnAmP95n4eNAB?=
 =?iso-8859-1?Q?aZ2YN0BefvhhtxYo1hODbEBoLQgNNJYT6UxsxlN8A3djC+Db95xNElBIVK?=
 =?iso-8859-1?Q?MEB3j4I2YT+/ectbtxaRqYJXqmI5UMQu0gM7gSJscF+JQGppICxQyLI+Ay?=
 =?iso-8859-1?Q?eZblYaTLf/pst+2HDuV31RD4fS6a7xWuxrqq6Xh4n2BlDyqyVNyqkVdwzO?=
 =?iso-8859-1?Q?Lz1ipdw9y5ZCsH6U2oUTKhMrVTv7VD/lJy5XYnaOY+6inYNRCqOh/Yjpb8?=
 =?iso-8859-1?Q?MTyCUVHqV3bvlVT0me1XDZ6Xxf64XbwNVvqJZnyisnjak+nVmVeqVy6ssE?=
 =?iso-8859-1?Q?eU3VCydCULUGVC4aO3LoQfCvmI8KXI7IJVRhxMGtXFs14bB0LezZiTMyzX?=
 =?iso-8859-1?Q?AjKgO95dtlIJx9CMCV+WiX+D1fEB9kw6+4tRjwMTrTYDFuJcZzl+NFyE/l?=
 =?iso-8859-1?Q?PfpJI3oWNKj22HrpgzYgFQnCcNVVSYqk6Mo85zEshMt2WRWe1dYBl4ZTtQ?=
 =?iso-8859-1?Q?qvF6965QbJEaCacuzGW6rLQK3BqjTWD/PPiARHKCrQYch3vmMz7cY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?WJXUIJhHuhJhPftUvXh7DQ1T0b0zUC0MhIgji1WJxXgifp89DsRDz/OaJ2?=
 =?iso-8859-1?Q?BGKr+Q7XwDISV24XoI0JAPHY6nkF/pBNioHAHV0poGiAf3ELYi3PQJKLxe?=
 =?iso-8859-1?Q?jCmfyn2+u+YmPrHk9IlQI2KZyQIhWd3tXPA6qFQPabai22QIAMDhic45Qi?=
 =?iso-8859-1?Q?C/k5gPmU3sNb0ednfkG+xutDp7k+EGrj1VwTSSuLU7s1ZzZFXmhDeBjCxa?=
 =?iso-8859-1?Q?TTQW08yUOyVDIQHoRY4purxorqezHYnvGTQCuj/6Mhzhl4Eca0F9lFclTD?=
 =?iso-8859-1?Q?6BO5iW27ujr3wVhdklea6lTH0QSQovBgCggCBIH4yVgMNoRIJPbgsuF/nZ?=
 =?iso-8859-1?Q?7tMmPyHda5sIm1M2n2WLNzSC2SJAAEzzS8TaCAuUfGjcCjKRVsyYkWOgw5?=
 =?iso-8859-1?Q?g+mvIND7I5uPs1UxVN+gUVAWPcraOdnsOJYHH+3oHT0fluZZfJWPoiZtKs?=
 =?iso-8859-1?Q?prNdJBFXQ9aOVCf1rlEACgWHkFwCZf6n8/1lCj5MYuDs7w8HH2nYzGrf1I?=
 =?iso-8859-1?Q?s2NACeqteNfQHo/Vm9TRBwOTwQvswoBDMQ45e+MSMED1yXG3o9VpP8vn1O?=
 =?iso-8859-1?Q?VShLXyEWmT0uuxFtU45K6bOfK2Qpl5GII+Oz4RBovGIl5uleejFpcGDtsk?=
 =?iso-8859-1?Q?iQL/PtGq4wwMsY1/tTcxyFDjs+lOmDJ9PTota7cRKCw8As10GC+s4ABqrq?=
 =?iso-8859-1?Q?zet9Ev+OIP8yUWhh/zkrj2/Pm9uNInC/7ZpTNJHAErehSUa48/1/4o/yui?=
 =?iso-8859-1?Q?osCGQXxunGwo72czEc8Xy3bgBddz3vN0XwELTbo38rEI6q4qUnj6br0Q1j?=
 =?iso-8859-1?Q?xN94drEMhYil8hqgGnolWxU+DaBiMBN/DDaRbbxmpqquK/gRBjLgPTADqL?=
 =?iso-8859-1?Q?kJfNZ1OZ4Jj8R1zpWmjt86KWlZeVGu6TgrNW0wuvgx0YgSylpA6R0dUh9n?=
 =?iso-8859-1?Q?I2sF7j9SU0/SAr4Iq9otgz2YAvjSDplTAXH0rmwHZY3VG+IAH23oO01s/7?=
 =?iso-8859-1?Q?rfyl6Mhni/dvmvQYADQWiQI/4ivKkJgBpdqDcctRx65FEnZL9ELystZzsD?=
 =?iso-8859-1?Q?Mans4/5BxLCztJqHKs8ngcOimyzk15Mfbayj4BCuhsmcW85jJ2olhHlmcp?=
 =?iso-8859-1?Q?rYGA7fBsuYBbg51+RuHIAwiCoSFdNBoW67cnBXvzXpIHi+XfXvxcxhI+Rs?=
 =?iso-8859-1?Q?BY+RIBvgOwwN+R02BzzvZFvm+cOpwDv1qNWmqrC/+nhX9KmLx3BmM112Hk?=
 =?iso-8859-1?Q?gGGfdV6h95ENIGNQ4DDIMjsR/gNBwvwDF9D80lzObh/CvnOzaw73ysY1uM?=
 =?iso-8859-1?Q?3H+GBiaW1AGiTfkIeAS6b0Km0tBFF5skpI2Wmt0mkdP3O2TvCe4RQwUVSX?=
 =?iso-8859-1?Q?oFGGlQaLQ/fM/3Xevvg2Ai7jwJoCuqrJR0EhBUFbMwr8KjCfothYZGGg5D?=
 =?iso-8859-1?Q?iun/AWvdxvWHrefjgXOixkxfImjUaAQnGOUUzNk2CH1nzORBMiOH6+KbRY?=
 =?iso-8859-1?Q?yflO0hBMV/l0kn7n/k0FnCxdQH9qb2OTgtffVgTTI+/xFiWCrNUgTsz10p?=
 =?iso-8859-1?Q?R/PDm14fQ3cHyhBlrHELdTX52v+oG2SHzLnfjEzZnY/3m11Ehe1y2QGXzP?=
 =?iso-8859-1?Q?1R/ktGA0AEkZg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfd29f44-8443-427f-f68a-08dd02a7775f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 23:20:44.4769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cb26fKPzWuO/Q1HjWLMdrFe3Z+uq9z6nHYzORRe4QIK9KIyacEC1KaLxWc0yQas7ySk65g4gjCMgwRPczvreEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10124

On Mon, Nov 11, 2024 at 10:37:04AM -0800, Guenter Roeck wrote:
> On 11/11/24 10:10, Guenter Roeck wrote:
> > On 11/11/24 10:04, Guenter Roeck wrote:
> > [ ... ]
> > > > +static int p3t1085_i3c_probe(struct i3c_device *i3cdev)
> > > > +{
> > > > +    struct device *dev = i3cdev_to_dev(i3cdev);
> > > > +    struct regmap *regmap;
> > > > +
> > > > +    regmap = devm_regmap_init_i3c(i3cdev, &tmp108_regmap_config);
> > > > +    if (IS_ERR(regmap))
> > > > +        return dev_err_probe(dev, PTR_ERR(regmap),
> > > > +                     "Failed to register i3c regmap\n");
> > > > +
> > > > +    return tmp108_common_probe(dev, regmap, "p3t1085_i3c");
> > > > +}
> > > > +
> > > > +static struct i3c_driver p3t1085_driver = {
> > > > +    .driver = {
> > > > +        .name = "p3t1085_i3c",
> > > > +    },
> > > > +    .probe = p3t1085_i3c_probe,
> > > > +    .id_table = p3t1085_i3c_ids,
> > > > +};
> > > > +module_i3c_driver(p3t1085_driver);
> > > > +#endif
> > >
> > > While looking at i3c code, I found module_i3c_i2c_driver(). Can we use
> > > that function to register both i2c and i3c in one call ?
> > >
> > Answering my own question: No, because devm_regmap_init_i3c()
> > does not provide a dummy function if i3C is not enabled.
> >
>
> I do have another concern, though: What happens if the i2c part of the driver
> registers and the i3c part fails to register ? module_i3c_i2c_driver() handles
> that situation by unregistering the i2c driver, but I don't really know
> what happens if a single module registers two drivers and one of them fails.

After use module_i3c_i2c_driver(), and remove #ifdef I3C, and disable I3C
in config, build passed.

It possible cause by

static inline int i3c_i2c_driver_register(struct i3c_driver *i3cdrv,
					  struct i2c_driver *i2cdrv)
{
	int ret;

	ret = i2c_add_driver(i2cdrv);
	if (ret || !IS_ENABLED(CONFIG_I3C))
		return ret;

^^^ !IS_ENABLED(CONFIG_I3C) is true, so linker skip below part. So no
ref to i3cdrv, so linker remove all related codes.

I use aarch64-linux-gnu-gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0.

Did you met error if use module_i3c_i2c_driver()?


	ret = i3c_driver_register(i3cdrv);
	if (ret)
		i2c_del_driver(i2cdrv);

	return ret;
}

>
> Thanks,
> Guenter
>

