Return-Path: <linux-iio+bounces-8643-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B418B958F17
	for <lists+linux-iio@lfdr.de>; Tue, 20 Aug 2024 22:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBB76B22D61
	for <lists+linux-iio@lfdr.de>; Tue, 20 Aug 2024 20:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5881BBBE0;
	Tue, 20 Aug 2024 20:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="RItEfJjm"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2077.outbound.protection.outlook.com [40.92.22.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A72B18E35A;
	Tue, 20 Aug 2024 20:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724184934; cv=fail; b=RVK59JkAAALNeHgx8t9JqU/N5H5hyCSYXsHGH2mU4gQN+EKacv6E+DCV00zPk2VRt4wij1ocsIjdsHOk93m3GhZ8HY5wlr8bolkXIzmgrvc123AmFFSRfQSwAaAdLiK+P/bo+lSTLooBHuZO0BI94w/3Vr31nDYwOaOPl8pXxCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724184934; c=relaxed/simple;
	bh=Vz/JJXotSjkGn6BOAUbvWVdAobtBIJcGvpAci5D7MlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YPRGvYWEELTGhxKDbJlt5C4H5A23CWmvUCsxFnl8WVBD4owkM26vdm4mOY+nH9D89CTy5t3v6eACIVZTZnR4cZN00XYCJi5EUGYlTzgJqEE4cqRnFlCgwiWNIv0bGyeCY8gpB9syDHq5FxNwKT6Ix1Tg33C5SKns5COYgY2r6vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=RItEfJjm; arc=fail smtp.client-ip=40.92.22.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GT3kFQp8t/jF0TA3+0ocgwXsKyeNNlCVUdX538EbZdpucFq2SBOn1gMNH9tF5caK702WMxCZTaqjkYtKoB7yqAHlaPQlqtknIgQvU6mbaVU8To9GllOBN+NVYw6aEWdy0TJ2sbGp83SvFQh675UmwyDHpBQTD9RQEnnSnuWzhXlz4uwivvY7iC/h7tUhOcGLEcCbWbXlevOTI882RL9FpKgYB9hVD7m7BJf7D5rzx0sIybOHJPCJuS/p8BzoFiFygvakVdcdd3xxhdHMzSXOp9rgxyibSVpVHlyl5JlNrjOMBSNao4Kazafnzt27uUsBXZ+4XiY8tJ2ZDu8mzSgJPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xtTxkhtq/3KvI+0CpDzaYErfU/NeCN1ozeNgp+6Lzw=;
 b=cdwzIrfpXzQHulpO1Rrlowja25g1MLaxLl30lsXYxcAOpj0vEqaSdVmpdtH2zgorVWEbGsTxJjBgnIc51Lq9cyXEPA9dffAAcEq0iQ89j5FiVQp/9v/jdSBNs/hXgWXNMbZlmOrHO3Qma/+7js9phgS2pGZmQAMYX+4F6BtiDH2TZ6s9V0e88lkrB2phQGd2SRYyQn4Xb22ZMVnPqQDheRje9NWD2+kNYgOpLiqU3XXNa47Z1ChZzG+2SIuyUNeFUMkedSgNNbtw2KMLeS4lCB0A0jhXmcSaxKw7e6KADNzC2OpdAEHn9DB+FrXVfApSoDIAlhYZQjXT8W0X7TUOFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xtTxkhtq/3KvI+0CpDzaYErfU/NeCN1ozeNgp+6Lzw=;
 b=RItEfJjmLTQy4O6IDrhZgHcepRbHLQel7DG8OaeiQH47ud7bMBlWEK6ci2TS8xNpUzFYgQaefvhk7hRFcEoSvkZzT26o7qNTsNMdSIsMY9yHmbvWBGKl/JPUkgLk2Ltg0BWAP4y0/bzwedTt0Uctlb6N711DCUgdqxEdy2NdksP3B938uxgBjV2Zl5lfp76vg1cRmEELP4YHW7fUMZtRXrV1w2md7bDnIDBzlFxdqGJ/qYFVtkR0gazojKPHkBUUzRGJ7Ir4a0fggDkQoCEZ9HlJpK0EhVIKw9Pbe0rffBFVm5dozS7Tobnyenh494fR3liAi8vStBmPztytXAQTzQ==
Received: from MN2PR16MB2941.namprd16.prod.outlook.com (2603:10b6:208:e1::15)
 by SA1PR16MB6485.namprd16.prod.outlook.com (2603:10b6:806:3dd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 20:15:29 +0000
Received: from MN2PR16MB2941.namprd16.prod.outlook.com
 ([fe80::9d62:95ae:c373:c490]) by MN2PR16MB2941.namprd16.prod.outlook.com
 ([fe80::9d62:95ae:c373:c490%4]) with mapi id 15.20.7849.019; Tue, 20 Aug 2024
 20:15:29 +0000
Date: Tue, 20 Aug 2024 15:15:25 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Chris Morgan <macroalpha82@gmail.com>, linux-sunxi@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	quentin.schulz@free-electrons.com, mripard@kernel.org,
	tgamblin@baylibre.com, aidanmacdonald.0x0@gmail.com,
	u.kleine-koenig@pengutronix.de, lee@kernel.org, samuel@sholland.org,
	jernej.skrabec@gmail.com, sre@kernel.org, wens@csie.org,
	conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
	lars@metafoo.de, jic23@kernel.org, jonathan.cameron@huawei.com
Subject: Re: [PATCH V3 05/15] dt-bindings: power: supply: axp20x: Add
 input-current-limit-microamp
Message-ID:
 <MN2PR16MB2941EF5AF5C003640B20CDFFA58D2@MN2PR16MB2941.namprd16.prod.outlook.com>
References: <20240819164619.556309-1-macroalpha82@gmail.com>
 <20240819164619.556309-6-macroalpha82@gmail.com>
 <ro43ccn3w2qsvcnjej7appuasuqphtf54vkyrsex6ypr4dlwhh@vi2jg4nemkvl>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ro43ccn3w2qsvcnjej7appuasuqphtf54vkyrsex6ypr4dlwhh@vi2jg4nemkvl>
X-TMN: [UTHmWfeBMkc8EC4o5S+MvTGpvpRHALn+zl7kQcrfd+4=]
X-ClientProxiedBy: SN7PR04CA0117.namprd04.prod.outlook.com
 (2603:10b6:806:122::32) To MN2PR16MB2941.namprd16.prod.outlook.com
 (2603:10b6:208:e1::15)
X-Microsoft-Original-Message-ID: <ZsT5XdPIEDDj0bht@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR16MB2941:EE_|SA1PR16MB6485:EE_
X-MS-Office365-Filtering-Correlation-Id: 08083015-658f-48f3-1145-08dcc154d5f0
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|461199028|15080799003|5072599009|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	5WXc2mpJe6HX6UnbQQ5PKZk28b6HC9b/W6znLUO+u+3GB3yF02K3gvs5V4nRIYCT2geocJjo1rY/zbTbSV51U7ON4T0GCq4GMgwv2Gmlu7LCZHT2r0oFSoKv4r5DZhZhohkutYI44q4FnW5R/GKVTnUmmU0lAiAncSXwE+vBmCAPkOHzoGrX1Vc71hq23VmbocQNfJB1taqnE6Aga8XWT0nwyuUGaNo1UN1SxoxBPkrPtdXKONtRGJRf76btqlzllfYZ2LYFAmTk5oxfROhXe8ynfJSyM1Nc1uakB1i0fc4oE5QAsqsWU7YoZgzhxUBznAx9DHWEzQSp0LvZeD/UBrvbAxCJa4hbnRfeI4oz9//6lQtPiO3tTGdg+K1frL3Df4doKcFl1y1eLOYN4GQRIsyZez5DUF6DhaaVzD6UGji9QUBHKAIkvKm6neZzA/OmkJjPAEhK9XdmViZn1p0wJKFW7OJmvtnNBl1Znc7N2te2VFtzxkcNQLcUNI2DrXMFAagXIQYEFL/9fhQZUrP/FM4ULiN12Qa99fud/7EMiqTnJeI6Eqa/t0vW5sVL9JJtZcIDEdS9WJ/8dpFRAZg9OkdyqsrsLmE9EGNIn/0OgxSynOGqb9xo8AfzShBfozGRFZ+hYR02LrFmPcHq2vlMQiIvy9Qm8wv9NSjPx+exxD07QKM8jXp4Unw9oMfjDI6UKEvc4+599qYSuJHnPi2bfA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZkHz7ZItxQmQeB3l1KB1mv9CKhwf0jim7lctG+MbUXRM0zUsnXew93QUFkbV?=
 =?us-ascii?Q?D55x9l42jO/vFAXQpTpeyrLKtrb9VPxUSR87dbM/8Ut+cFeeWEQhgSg7aV/4?=
 =?us-ascii?Q?BvfKc9XbEWHrg+sZzR1MTqJz+xhxSKJSQPvRKqIjjCx4EQy0rgJWaAedBABh?=
 =?us-ascii?Q?IaVdpY1wX0qX5KjKNz/ydrpa3HulR7sAROveOLV62iLyEXc7gvsxVl42B/IS?=
 =?us-ascii?Q?wMo7HEje5knUTZpxpCF+GT3AqcEFRc26pxPqWkrjNPWVOfuDJKBGmU5kvvnu?=
 =?us-ascii?Q?7Bg5wNNMWiEynjQfPPFghxxk58bOAfxuSjbg5MxrOUfr0tpmI0Ukg99ZCIrC?=
 =?us-ascii?Q?k2wervOM8VuK38gblk+StJPRvVhlHTPQg1aK+7kWGh8PdBTM4KWynCVldlo5?=
 =?us-ascii?Q?vFZD4R87R5BdlRTBvBGAJshMEjpBRbYFP05fslq0wM6IXag7lpCzlkpL2BE6?=
 =?us-ascii?Q?O6COB8YWX40/v2cRK4PoVmtetphAnsMTHZYfia/e3iCbqQkHhJ5yZwvKBTEv?=
 =?us-ascii?Q?5tn+cdocoXxht4vq7ZwuDx9vT7llnNgzWAwmSHpXt6LJ6jIw6nn1QX2rmqPa?=
 =?us-ascii?Q?VFkghrf82+i9umBbWmV3IOdnW/Y86ln/dvpRv3NmBt93IeXPSddK4cWwt3nI?=
 =?us-ascii?Q?TPO/nW9W4dvHuz50Zkss2TRkQdIDl2PR8N4hayfMdrGSRtuCm6Ub3Gktk5r/?=
 =?us-ascii?Q?108JriyJfE2oilD/yRFmW1Uy8lrFm25eDZZiJn7CB7pwBROyKM7BAhm6erUk?=
 =?us-ascii?Q?I7P5fSX6ddBh5EvTZ1WKAX8zOINFvkQhFZ5HFCD6jX9FUAVMxHLXD1e1dUfv?=
 =?us-ascii?Q?3dqsKDUqUFOzHlPeotVZzer5oILgXHsrngOo3ewdc30+qKEpB5WQMNzoVz2K?=
 =?us-ascii?Q?f2BX8yqWOFAnwhXNKl/BEX7JIKB8r1pLRzXnij3uyx9j37XanAlvV/fgM5A8?=
 =?us-ascii?Q?wVM4nGu+anXEspj53w2MB68JqVnGgYxWA4k0UwVCiqgiGdsMAldJ+8Za+tAl?=
 =?us-ascii?Q?CZfc2HDhKXC3SM6LbRd9+fDMadWfvKEJmBQDsaqgSLTRHQV2189watx2smhc?=
 =?us-ascii?Q?XoDd2X9RV9e2hZT3yRgVj6GOMtp8LeYy1eHSc/QUgn6VI81CMwCFgLg0IUHP?=
 =?us-ascii?Q?/Hl2Yk1WgoIAZaEQUHlC4fSU0MA4DX3+XHkCjsWnDCavHmUI7nH9zzmjjzWb?=
 =?us-ascii?Q?hx22UoPMqD9EKO1ZE8w1whgGdqwryVGUJ9GsUJxNEZ6ig0tXNhRflWOvaxNZ?=
 =?us-ascii?Q?fe89jvB5T41A3f+k1VrzqBkmM5pRwszUe6po8HKs2w=3D=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-559fc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 08083015-658f-48f3-1145-08dcc154d5f0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR16MB2941.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 20:15:29.5081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR16MB6485

On Tue, Aug 20, 2024 at 09:42:06AM +0200, Krzysztof Kozlowski wrote:
> On Mon, Aug 19, 2024 at 11:46:09AM -0500, Chris Morgan wrote:
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Allow specifying a hard limit of the maximum input current. Some PMICs
> > such as the AXP717 can pull up to 3.25A, so allow a value to be
> > specified that clamps this in the event the hardware is not designed
> > for it.
> > 
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > ---
> >  .../x-powers,axp20x-usb-power-supply.yaml     | 69 ++++++++++++++++++-
> >  1 file changed, 66 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
> > index 34b7959d6772..9cc300e78f60 100644
> > --- a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
> > +++ b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
> > @@ -15,9 +15,6 @@ maintainers:
> >    - Chen-Yu Tsai <wens@csie.org>
> >    - Sebastian Reichel <sre@kernel.org>
> >  
> > -allOf:
> > -  - $ref: power-supply.yaml#
> > -
> >  properties:
> >    compatible:
> >      oneOf:
> > @@ -31,8 +28,74 @@ properties:
> >            - const: x-powers,axp803-usb-power-supply
> >            - const: x-powers,axp813-usb-power-supply
> >  
> > +  input-current-limit-microamp:
> > +    description:
> > +      Optional value to clamp the maximum input current limit to for
> > +      the device. If omitted, the programmed value from the EFUSE will
> > +      be used.
> 
> minimum: 100000
> maximum: 4000000
> (or whatever the values are)

It varies based on the compatible string. I've added all of the
restrictions below. Basically all but the axp717 have a table
of values available (as an enum), and the axp717 which is added
in a subsequent commit gets added as a minimum/maximum with a
description noting that steps are in values of 50000.

Thank you.

> 
> Best regards,
> Krzysztof
> 

