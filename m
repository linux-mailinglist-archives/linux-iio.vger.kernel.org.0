Return-Path: <linux-iio+bounces-12158-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BE29C45D2
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 20:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21B5CB236A2
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 19:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BE61AB6FD;
	Mon, 11 Nov 2024 19:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="enN0HYOI"
X-Original-To: linux-iio@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012031.outbound.protection.outlook.com [52.101.66.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1DB1AB515;
	Mon, 11 Nov 2024 19:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731353088; cv=fail; b=WmGs+1EERgNctDk82dyVkcqjcIKa3pBk8ekyABtFVJBJ/iTOiFnTnAEtUQ2PX7VBCmV+OMN3PKTYYqqQMTxdAtB87NQ3ljHAxfD07dNnOqT9Hx4FEakGQSi+lAZNV+7MLeUbewLV85es14yT0z+a5RGiC89qc+xnBZg2vh1RoqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731353088; c=relaxed/simple;
	bh=NdTaeTFk0fNlNVtzi7Tnh8YdbovoxP1qgeEYPFT2GFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=URAs2YxXVCAqHb7uSUHQBqROvaKEC6EzzJwmjjr0PNEBw+nqyX30gfqlWmfLPzamm1TIZ6MUh4uMRbmdiZKwkVzp391qYV0mFEDyJ7LJv7+uJJ2CFy7QzxVInqMrl5DYmlAaXo2nTccHCj9MWgPknJ9UepF2pyd4N2fANL9ybcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=enN0HYOI; arc=fail smtp.client-ip=52.101.66.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AcR+CrFTF5L2uWXsG4IHIcqiOPXlfzlErjDObvl5PwF3LeSic3YI4uR7HZcdFvIMs7Pf5Ee5WNYxYBjBmaRK8lG3+EL7NLq3XXtZTuaD75y6mndrOEBI93wEmy88GA/dyXV2vdB9gsE3Xv0oEkTr2rYPuFTTGHPyQrlzM3/rKwn2sS9cTKkd6JAxseMl8a+PTKolAAEpuceaZEQj6qEmK5GQi7y5p13pEIqwF6GtwPdW++Voy13UD7ke1cltDEiP4z86WXRVzlykkjGc4l9QexTm25RppOC0PZT8HT6OK1f+SSdJy/Jo8RqfwsIlWCmx3IYymw4RiTi/2I5yNfKS9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zIGlxsUzD18y4KL9f6ulpi7FZ2vNeWVymDj4IADuKWo=;
 b=zCRl6qYgS10lMpwXfCZ9ZNfdimiHlvNeD+LGT3f5HrGEHN+iObPZIk/tpbAtuJVb9xrYLMBfDdxxVkpZa3hoqiF3Bm2Cypzk08dnPg6KOa8uFT2hSTqQrZXfPaArkTgsnRKjQ6PIMLFPVPtaXe736zxdXkP9HkCcqtCT946iJCcECjHdeYSOm1CRNC1tJJHvYBIo0WSI+9dhXEVlO2nbxyl9pSJB2ZNj9Rr+Jnjuv8fcjN2lMWRRoQTbxDilW0x1ypiEtQdMOTOrO411Aeoa4svLz8nvj8eJLqnRca+Sbml4hLEzAWcKvsLNO1awy2/dSVMnvj6C24TwcKX68V63vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zIGlxsUzD18y4KL9f6ulpi7FZ2vNeWVymDj4IADuKWo=;
 b=enN0HYOIYZ0hjNj/XSZCU2jFUnGXQueqK73Swy+5SX23heQRTs9PG3F1m/59mB/A2QkPPeb0xkUlQRF2aXcEKjrtl/+KRgdue4kX08dTKeWI8/HMaywrU7Rm9wQZTzoBDRrWEZLH6EWfuzPmTPwnI5k0ZprpfRgqOkbukBvqcKtdHN3eeG1d/1I5KtJg9UvZWDodmMf6c6bylgdlYJXEWhep7P5wrzPyfnD40c/V9ESH1kYvfhKT9T9Z6zjXh5nmKFLIXmJQMpirsS4IUVoqsZtPHecHoftAVbcvY3DQaIpLKb1AInvm2Yc0B0VzRBcUqYTES9dhPoqOtGwC1ufBTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBAPR04MB7207.eurprd04.prod.outlook.com (2603:10a6:10:1b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 19:24:42 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 19:24:42 +0000
Date: Mon, 11 Nov 2024 14:24:33 -0500
From: Frank Li <Frank.li@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 5/5] arm64: dts: imx93-9x9-qsb: add temp-sensor
 nxp,p3t1085
Message-ID: <ZzJZ8d9pG3O47wIP@lizhi-Precision-Tower-5810>
References: <20241111-p3t1085-v3-0-bff511550aad@nxp.com>
 <20241111-p3t1085-v3-5-bff511550aad@nxp.com>
 <20241111191311.qallf3xrz2vlylak@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111191311.qallf3xrz2vlylak@pengutronix.de>
X-ClientProxiedBy: SJ0PR03CA0131.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBAPR04MB7207:EE_
X-MS-Office365-Filtering-Correlation-Id: d0304b7f-b449-4205-0092-08dd02867e58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fCmEnDegKpRAVEi1rH4+2xl7WQzzTYUqKzjeKid08AtKlWmh5xGMTohEl8ge?=
 =?us-ascii?Q?uaTDfNabdeqynjVS6lbI4OjhIEgWbtPsYja2s0t6nwBgYoORrUGyprbodIxw?=
 =?us-ascii?Q?mp7t/MeYnzsw6I7C4DKeBnJ1PYBe8q13wcPTIkd13K31s1dFW4SUzDVyiEPA?=
 =?us-ascii?Q?3bhWrlO5rNa5/YFUpOUkRFLpk6farVRux/uVK3fPWTW1UxomvGrLQISFIwsL?=
 =?us-ascii?Q?tLrU7TPXfhJPYzA2VDeKOHcRozc8UYn3jxFSZOTv03ODEkGyWDHAfHW5uGEt?=
 =?us-ascii?Q?FAyL3XY9zw9RoerVzvwCycka6Ssii4K7FUJ1YIE4Hj6OR44+r1zbD9s2fMCl?=
 =?us-ascii?Q?LqtgN7N2WgrG9xSs04kPu4lriaCHa8PTpx0lMjnugq5R7etZCLQGwci5YZgf?=
 =?us-ascii?Q?WVk77e94a+/kPxXy1Gasf+rCKrKp72r/HItezM0eckLCQ6BuOrfAkjD/gHKU?=
 =?us-ascii?Q?7WNQxhKgLoE+yKt7uPB4wWA3DUPi8uPpnxnej0kvIRb7Cimz2pkcc+XbRn1h?=
 =?us-ascii?Q?sXl8eTSDAN7d6ebaY2AK13AX3jsJAjOlDCTdWW7bnMqLEADp/BFjkhpJ2cbV?=
 =?us-ascii?Q?k7CLN7cAF14xHIsZrLXkgN1nhBJU9nUOTcrVycAyTMSXBs10kPnuUN1wGvdJ?=
 =?us-ascii?Q?0K5ZJhumQlHLKA8g0y3zqbh7dot1kbCxroaWE/nJuHgI5sr/Mj626MHJ80hr?=
 =?us-ascii?Q?rYOEC297Eh2vkOcbyyFzUt6nEx5/TQoSrkwH7WAD6TAEnpxK5DhNDEKkqRL0?=
 =?us-ascii?Q?P8OOXoDxD7doup/LIN7Ol0dB7oaU+KC7miN/aKNzQt5vznEkXg8iFaUTsx+s?=
 =?us-ascii?Q?l3IEF8BBscr5ICbEA6po2eXMjpcVtznuym5e/g+HdoLt65lOftgnML4l9ogR?=
 =?us-ascii?Q?PS15AyE1R7tXMXT9y6KkHTDl0zRTgqh44KahgEPrLSOHaq2c0s7dTFVRfAg4?=
 =?us-ascii?Q?0B1cT7fdisYxlyVFe3mcdZ2iA9MIpUuaODtcXc+fqzIM9jwLxuRL0kqBzNi4?=
 =?us-ascii?Q?EoB6EAoHQ3XIqhE6txaPQk8FMMJrdfCMJz7zEvLsIOmUSQSoz7Fl1dWZLrEu?=
 =?us-ascii?Q?sjLDVHEJ8g+tTNKCXZM0Nl3QnO5U9graaQH3g+62p3TERK84M657/EYEJ5RS?=
 =?us-ascii?Q?nDixEcnypKLDb74kN4MDJ8Zje9CRMMuP3KxIM/ieF2h5HpOi65+RQcl47FXf?=
 =?us-ascii?Q?qGmRlO7HFaHYFsc8kgDujcSFiZO2D8rRzb3dcnP86KdZUOz/dTizKCPUkWrr?=
 =?us-ascii?Q?QiJgYtY2HyR98/MBrAMSjDMmuY8tC8KoWGGEke1LXTw787lS8zZLKDZqQPLB?=
 =?us-ascii?Q?tsPUN3cZ73kinqlGePnXFlU08sBn7njaOkUvf4xEsTXb27Mcy4yP7GLQ5gXm?=
 =?us-ascii?Q?PuLAK7c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ud74NM8U6ZdrMXp5YIyF57TY44oY2saiTomusOwsec9Fn8jUuQ+/AJ8VXTb8?=
 =?us-ascii?Q?RoUh94FDo8/pgihqPSEK8Km8D/lXio5h6nkWb8zG0xAUOC4tv86CNiIlA9Tg?=
 =?us-ascii?Q?hK2yRDaEzWsu3PcUv0kFsj0dJwU4gcqKlbQQLXXnuYparxutVG07ViazUjyt?=
 =?us-ascii?Q?rcHl4OFNfdyhqHYfcslt4gGUhBxvzF0qeLPmZsAt7hIJjEaHyseQLvEG+cDC?=
 =?us-ascii?Q?jmYa0JsUS3JhggQL6TRKT4o5nnRPCmWsCb0UObkotKI0PE5i8Pby9wbKqDf7?=
 =?us-ascii?Q?3VqsJ5vd0FG/DSzNqfHnXZSvcXWYr7e42tntr6/oigUelV5B6VynKI2fbW+O?=
 =?us-ascii?Q?UCNrk6rZKLJ8IuGI6DvuXvd/hRcR5VR8jJAKVFOWvYfx0PoewlOgDs4ZpKIV?=
 =?us-ascii?Q?Mw1y6vqc966eHMPa20xytsXNBQkkYBsWw43sNss8RICMT3+y1eIAKMOp3acL?=
 =?us-ascii?Q?ArMhDHQQcB3MLQMkwjjPYHZt9Ozsxc9tXNk4mvDqC8zu4kZt1FfVPFGM23ar?=
 =?us-ascii?Q?iFHVf/nLiY39mpiwQ0PQKdP2pV72rAJLyT+BjmMbAOnC+OyUYpyY+wNf37N6?=
 =?us-ascii?Q?cvZDQEF4hngq9doiR77vbb78io5LZAi3C1WEs621iPKxBbltsR+uL+JF+edw?=
 =?us-ascii?Q?vdvRRp3m1WxCuHeJjvr4WoIdwzy4qlMzLGUGEW3ZRw8uDVGYvZb4KVK6Xm7a?=
 =?us-ascii?Q?t2uo/AIfuK8bccyjKpBXCcUagkXzuUbEwf0u2ddvoWAcKRr3dZbiXjIkB1rY?=
 =?us-ascii?Q?1Y0cTnI01rvei90yvJ8h7LfAwo1ZvR0xCf0PdgG1OxU2/mpBsNuDiaZq37OJ?=
 =?us-ascii?Q?NE9uxLS6MwA7iX6ig45SkOv+7trEt8L9RpzWeqaVE4AJlqXv9S2Qw/O+02Qy?=
 =?us-ascii?Q?7s6VzJROzgO3t8xhQynp24rIa8W8J04FEbc08asccXHJSGS3meFWpdINjA5/?=
 =?us-ascii?Q?krROoR42F2xiWzNCrfgf6YQw6TS+CaLiqEtDjdeLCwJhN4mIzB1d5fhBgFvr?=
 =?us-ascii?Q?NiQ6FWCCV0efusp4tWaFrsuolOhUX0H6tJ7cDtO0o8zMpTtqC2w7JkTa4Gff?=
 =?us-ascii?Q?u2lllmJ8vRojh3qb1nSf1LXVvWuLZP4bKVGtoRkahHrMasnad2nXPtsgOVUK?=
 =?us-ascii?Q?+/Mkkxsmmpb/wlHKwvD6UBTkyLhdQq4TIcJL8CMw6U/EQwTreIxljpj7NlbX?=
 =?us-ascii?Q?rutIyQca4H9qQ95WGh48pxlLvky16wRGSSkqZd0KehS7Ru2PmDfhWdPfX0aI?=
 =?us-ascii?Q?ak82+7+pwmxsONVd9Zy5KdD4cdyLzPf6gZiLjIMMOCiZ6s6MFNpdHDmOtr56?=
 =?us-ascii?Q?QSYnuR6mPQdJtkFSrJ6C3GXK4yBCGLngHGydtVo/jbMhhNDiKtqkY+DLQOWR?=
 =?us-ascii?Q?UE/mZ2NFiYMzZOJkSnr9InbzxqEev4ermbA6Csra3kW6fxfaYctPKRXDfjAy?=
 =?us-ascii?Q?v6HSyx6mX6ARbl+uF+YgOvmINV9M0iIJSBd++IQEOWmUeDHf7vorufxL2dbk?=
 =?us-ascii?Q?e1mPRNSBzSZcn8Mqyoxu20FN2HblTlDIWRaTJNBXEL2dWuUXmKQXkUQQXoKn?=
 =?us-ascii?Q?kIStEnv4jFU9iqFINdg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0304b7f-b449-4205-0092-08dd02867e58
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 19:24:42.6213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iXFWybtMzHzIzhN+nZ9mRDrMxqUZJimLI5/vm9kJegPaiocMSHXCBP33EZCt21zfrQLzqOc7DJ+7O2LT+Xq18A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7207

On Mon, Nov 11, 2024 at 08:13:11PM +0100, Marco Felsch wrote:
> Hi,
>
> On 24-11-11, Frank Li wrote:
> > Add temp-sensor nxp,p3t1085 for imx93-9x9-qsb boards.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > change from v1 to v3
> > - none
> > ---
> >  arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
> > index 20ec5b3c21f42..36f2995acbe29 100644
> > --- a/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
> > @@ -221,6 +221,11 @@ wm8962: audio-codec@1a {
> >  		>;
> >  	};
> >
> > +	p3t1085: temperature-sensor@48 {
> > +		compatible = "nxp,p3t1085";
> > +		reg = <0x48>;
> > +	};
>
> Out of curiosity, did you tested that the I3C is working on a real
> device, since you added the node here as I2C device? If not, please skip
> adding the I3C part and keep it as TODO for later.

Yes, it work as i3c. I3C device can auto probe according to PID
information, needn't add dt node for i3c device if it needn't power-supply
or some special settings.

Frank

>
> Regards,
>   Marco
>
> >  	ptn5110: tcpc@50 {
> >  		compatible = "nxp,ptn5110", "tcpci";
> >  		reg = <0x50>;
> >
> > --
> > 2.34.1
> >
> >
> >

