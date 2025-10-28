Return-Path: <linux-iio+bounces-25598-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0224AC1581D
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 16:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 99E8A5806C5
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 15:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F442342169;
	Tue, 28 Oct 2025 15:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AxbgFCu9"
X-Original-To: linux-iio@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013022.outbound.protection.outlook.com [40.107.159.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69234C133;
	Tue, 28 Oct 2025 15:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761665486; cv=fail; b=FpZLUCbgneaFNhtCjVd8XuDwqOGHOMJEVsEiQAgn9cPeevN6uOjQqGyfmQFlclmfRDGTEkImGYPiHbwGaSQIz8LiQs9B8kGR6X6NZQmlw/chxbuFXT95KMRfFHxoqevvcIevl5hfGPvK9ARzD1MuERlfeMlpr66b7BMoyLq1of4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761665486; c=relaxed/simple;
	bh=4x5q0IIg6nq47+ykD2TGSyEdSLof2c/IRPgFvkJaago=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o9McMoQqlmpvpWuaJ6hnGVoedkDT7HAcJuE+SJieMrFfDugi5W2NzpQdWWL4rz1UsHVksvfwN9HqnSJGJt3E7/J3pWFaC36IfFy/Q3CXVcsdCjXrq2GQ9UCvmEKq4EG8Cvd97e9ticYCWM62mvrqBeNVMxgX6EtUZVja8cnTwD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AxbgFCu9; arc=fail smtp.client-ip=40.107.159.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=snVfrzKqcArVIVU/Qu3RhGpylie58Wu1RiGj7YcyAmU51jOFILTCf0KGHqG/nEjbG+yiuK+qIomXyfNlL5X3iXdrgYPakyXnLZGlMalsq8K/WvAjk8NXcV9GAKRaGEFvt1J/vzmKw1fyeAj6TH2pF2pv0ysEx0gwTePsJKP1/BbzgYzYNzezca+zkw0E8DryWf7Jfamzfsh783zZI50tHblKqnIRMxThX/rUyWWSVJWA9fIq6t9cO6f3mP7aGmBb1rqK+jkB+d0Ft/49i9FLxL6Vx3f5EqsouEP+NLymKPKXJu3Zvr+1eJPrYODk+9fXzOP0+Ruibq3udQPuiNMd1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OGhDkY5bOx5lRYv4cA2s0Y50rJQqDo5Zss0C9KinIVI=;
 b=qrnbcgvi4xqAGRjcmFcBscGjXqc/o95/pASzQzntKeo8qu2EDJEdLVxuNpRRAA4G6Nrr7vYGuqJMuIbJhGtcxxMd3e+es/1o8/qtO0QzuC4sT/Z/lHN5xSswlkfyknTg09uuWo20nJ/sxSTyjrbwL8JbAzlhWpFlHqUVDfH1K0sNgBbtli04wDLB1AxfyVnq4EyDULGYJEmiKt/Fp13v4izKHDhZCWlxNdB+/zlKy925DeKRwVzG1b72AXzrbSUVcN2V/P6niB5rVuBvmuHZTpVPfIlfrJmJja1pE3TIm5p3TT11SH+qHiuo0lM+bAtmSqfp1eSuKy4WlrF1kUzcFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGhDkY5bOx5lRYv4cA2s0Y50rJQqDo5Zss0C9KinIVI=;
 b=AxbgFCu9iKtLzz7s3xRtpMENoZxynj63PhGTfqC7tzGAo9kM4fS6JV23h/NBF9gZnynEcmWuyFZNNux4UCAadAV/cGzP2F0FRi89H/Wg3q+K3I0CWpKcu5+LkTFBn37uzg1NW6PFNAxWdeEmXz95luUiAoLlx/744beuwk1CjAII+C7ml6LEcCZnEKD0xKIeNCy5XSvhqSOqckQuIqFeZlQlYvXGZZ+kIsrwUY7W5HPqiurA/zBo4HU666k1cA9iPMO3uYihrcNpCOYtEIKeWHvUOmhEXycVZtQCooQpe1jBvL05kMR0TKYWstyBy9Yxa61gE6Dv3bIfSaww3eec1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GV2PR04MB11376.eurprd04.prod.outlook.com (2603:10a6:150:29f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 15:31:21 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 15:31:21 +0000
Date: Tue, 28 Oct 2025 11:31:11 -0400
From: Frank Li <Frank.li@nxp.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-iio@vger.kernel.org, joshua.yeong@starfivetech.com,
	devicetree@vger.kernel.org, Carlos Song <carlos.song@nxp.com>,
	Adrian Fluturel <fluturel.adrian@gmail.com>
Subject: Re: [PATCH v7 5/5] iio: magnetometer: Add mmc5633 sensor
Message-ID: <aQDhv/r0l0oOjb9t@lizhi-Precision-Tower-5810>
References: <20251027-i3c_ddr-v7-0-866a0ff7fc46@nxp.com>
 <20251027-i3c_ddr-v7-5-866a0ff7fc46@nxp.com>
 <aQCgD3iVOXoNr7uY@smile.fi.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQCgD3iVOXoNr7uY@smile.fi.intel.com>
X-ClientProxiedBy: SJ0PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::35) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GV2PR04MB11376:EE_
X-MS-Office365-Filtering-Correlation-Id: 870cc839-d95f-44ef-84b2-08de16370bbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T6cGEPdkSdC2CCoKbeyIPA2aTZxS0NOjQNw327WTfIrbwCw9z6P5BaOS4kAC?=
 =?us-ascii?Q?O8JBBgPS0/TL62FOSN1WHbNNAcAKJ1GmTwDvVaSn55u5ePwv4fB5vC/51RUm?=
 =?us-ascii?Q?TFbmAlphnPKv12KIg6TasswTCffw0iPtbg8Aa0Tg65vejzzKnOesfBhMnRPs?=
 =?us-ascii?Q?pYyAsCj4oqt6Am7JztCQO0PxihLmaO1ouHibv79++lyj9Kyv+Ma8ewnIMIry?=
 =?us-ascii?Q?rHPbkuTG9tusyfLxPa42EiaBx/FsZp89clA5nxPZSET+cWm9zdKtQcNAAjih?=
 =?us-ascii?Q?mcl4QfujqKuNLmSMhtVZxIqRMxRd9MrNxQ4zKyiLAcKkN4Y0WVWtNzfiLi0S?=
 =?us-ascii?Q?7m2vzH7o4ve8OjPctUnrXYDgBVh7J8J0wguUP8rJDfmyG7U8oc2EcguboL80?=
 =?us-ascii?Q?6mN3MmHarWFdszidTnAX+G9lVHw+vsfRCYskXbaHR/XJgSHUNSZDF8JWRRtn?=
 =?us-ascii?Q?3hGe5jB6M7QuDDNHZWGIPaNLSafBszN2zLIZwhc9Q7HkAHu6V39NTPv9sZmI?=
 =?us-ascii?Q?F4l/DfVC68URssdxZiwS9XbyKvATebp4wz4I0GsDij1eQNXOzVVN/HyWkUVj?=
 =?us-ascii?Q?EKfzoCWjY8YY5WG2LBccuYFxDcXnb7eE4We3QtYag2LdFrMvOxEiK6IyHfi2?=
 =?us-ascii?Q?nlH8JyAlPYGJj+V9sSMYhmi66laLFJSrgNcm1Yuh0qTtmmdywpaiE/hM5R62?=
 =?us-ascii?Q?QCr42wJoKMazgAciABxKzwgUPzJhpn+4Ijds+/AMaEsTB5qKAjyn4Qldw4r3?=
 =?us-ascii?Q?qFP2NzMQHRjMxjWPT8pYAPBudNepXowYQeOWHLfFAEEjAstH3C1+4/FtrjwN?=
 =?us-ascii?Q?ke+q2STGo5gww46b68K+5ChW9fIso2Tus8RtUsfHhrzXo7J3BNmrgb81lSz5?=
 =?us-ascii?Q?TUkAYNp46TrEzEFgmiKvxD8wVTG04Uhm/X+sC0m2h5bIiM5BFWZcNiPpg5qh?=
 =?us-ascii?Q?gUb2+SqU1McEwhl8dp1xu79WUtpuB+9jzqsbWySyqOyGMDQ1pfywqZx8MiuU?=
 =?us-ascii?Q?2lS1U1GWqGh0uemjcxXhWXMOu+ThVpYBTZuQztJUIgseQT8ZrFQdRlHbsEVq?=
 =?us-ascii?Q?/Om9dfuppJpf7TUQq53vDZqc+LJwpaKQb6HC4hSYMc3dB5VIUaN/eI7uIFLR?=
 =?us-ascii?Q?04mfDIl+nVfyE1bRnhDsR7gYl+O+J6ud9HfX6LBtw8SXhvZ52ztU1jnKhUYw?=
 =?us-ascii?Q?ND0uhOcbxe+NslFPtPTPdtjzpzYElwV/QZxMfAPQWJI/aLjVAsvNlUvvxGwL?=
 =?us-ascii?Q?7ClbcIJB0WWSrkMyHqL5d/QcwH2Ylj0Pf+JxR0U/FrWfflBBmTXXRCb0p2l5?=
 =?us-ascii?Q?2dd0uKQSwv15TXOVDZjE8rqedaj81RR7ITGti8+Eii8KqGZzvRcY2soG3xz4?=
 =?us-ascii?Q?7flwrpFybcUfFTMl4s0xc3u+Qlbj3fQTB7LQumYeyrddHBY0aO8fca1j4hg0?=
 =?us-ascii?Q?m18m6z0oJ6PUkWNwPnDiUIA+f3AyHbBv3tGAsdwMZBfhiukilYSPRHH4p9jF?=
 =?us-ascii?Q?+BSZ+gM3jvhDhJDCYHVTtTHerA200kaC0UkB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?abJmmUQ2sMsEVpGv6T9zl8VjjBdpR2Hjlk1GNkmfAjVgiW6dKQ7MDv6Rg3t3?=
 =?us-ascii?Q?PmJTHwlEi2nZp/8CWhEktu1fYVenLb9lUaxUtC1ZVKMnCJf6lyfu6CMzPoN9?=
 =?us-ascii?Q?7ljFZj5zd5A2Nm9PYm+UsMelEUh16yhrw/xOKyLPjHGR1LyJeKLiKvSYb6ol?=
 =?us-ascii?Q?KwNS04UzDLNi7VWSk+AmILg/kXyg+aIddIhZYt7oDQJSHLMY+7YeYyTlwRhO?=
 =?us-ascii?Q?Ta6Zj2jKoQl9UYwFgqCKT1O/6AE3GuzDHPmjmkUvR4lmM4nT+QBFnblwQXWe?=
 =?us-ascii?Q?gjGjGOhnHdDY+54PD7OLjkktVM/DQO2w1RMe75K6KdjSGQWbTQyIYPVloBEc?=
 =?us-ascii?Q?rjn/d9eMVmNZNbeOQCQsZxtEGVg0NK23cnDIkAspiUjvRGl3TPtitDoFHytw?=
 =?us-ascii?Q?ypxmYh73NUWMMfqZr/Lk+tNWBsKqhF1USFVU+X2cW3ZD9KsoC3w407vXbQli?=
 =?us-ascii?Q?83fCN6dMiLqG+C8g2tg1+1OiBBSZHsds2w+xCNhcKjL5vBPKiHvv20RdVPS4?=
 =?us-ascii?Q?iHjFDFR5am4WmFJwj5SqWQHFzh8r1b4+IYXDhkpM779/WfZARIyHZ6XON1zd?=
 =?us-ascii?Q?s48X7EVZ0ZLQp5P7dHDv6Lb7CkFVb0sv5dlezrWXJm8mNqQrxEueBXrJOyoZ?=
 =?us-ascii?Q?fi/vZIxVjbrh/OQ8268Dtmv/SVkSDokkEJqKOzXbMrDuZm8Y7KcxPbL4prYt?=
 =?us-ascii?Q?rzqExndE6mT6FpV6gc1WA77o2ZbbpvybUala98mOrEpKlCfDRpreigP9+Up3?=
 =?us-ascii?Q?38Gs+Q/ZOVyLLxuAnuF4xqYVtV6mGWHLFRDRsL/AQOeBPQ66Yk9V4GmCUmXh?=
 =?us-ascii?Q?ZonggAWdXZ0srLM1nGpQMSJ91V1yVbpLmS7w0UFNqhuP5toYv6sW1UHVJXgv?=
 =?us-ascii?Q?XcKaai18p4gSzXcd6FMURy1U1UzwRGnc5afUEQ5igdvu6vX9YOlC7nyueL95?=
 =?us-ascii?Q?MqNoG2IFDIvzP0sWVDl0wgZZf+xUdFZs79FnUdB18NrQTvcYLnYxTqgxvbaz?=
 =?us-ascii?Q?KceQTg6JRhrWMb4j4lupgsyVJIjyVZhEdC1GmFVNyPVVmg1s9vsbWJy75vv0?=
 =?us-ascii?Q?Oxf8OnG8MEuzOTZziyef6ujRamD5p2CN41B0hogKEPUdypEiAtqyKYVUKskR?=
 =?us-ascii?Q?YcrU/GAhZmMktEhI0Bq3werwuSyvRGjwkJW39rdkWAtqc4SLliWfPuZpNAvg?=
 =?us-ascii?Q?EPaRMASNGy0yjAOjylkO964yhSf5XE3AOgS7aj6xHWejOZ0kDeBNoS1btb1e?=
 =?us-ascii?Q?sK8WK91ks10Z44sZSp/jMZ1AglHkxqUVW8xAUFBOdj6w3ktVCO0t5V3WOEa/?=
 =?us-ascii?Q?d5RCGczpvwRr86X8yNbof31tJ47dBquKO0npmYcuNPJLOekMbDCnmjn1PT63?=
 =?us-ascii?Q?BVvHilujVR0oPAqGvrHCKtNb0tnBWaFTJ7UnmexqQzAfnE+35nnZQGO4MOij?=
 =?us-ascii?Q?Ef7kLsDEuSI/YMghn+shEwxqYVr6DFaWuf2+Sgfncoq449NHlqcHyfKH/rz2?=
 =?us-ascii?Q?z8a7wAPjtWKRTJR9nbFxit63hJxF47Ogb4irkSY7Nrug/tNqBSk3kJcbHcl0?=
 =?us-ascii?Q?mvYUkJDtJZJ0FreZKGs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 870cc839-d95f-44ef-84b2-08de16370bbd
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 15:31:21.0892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: phGpwvMtWw3f7rnIJ4hjvKNzOSqvfF3PVRLX1p6/BL5tblLoHAhoTK8MqVE40qtWh4QAuMCKCvd7C7t68RRA6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11376

On Tue, Oct 28, 2025 at 12:50:55PM +0200, Andy Shevchenko wrote:
> On Mon, Oct 27, 2025 at 04:08:33PM -0400, Frank Li wrote:
> > Add mmc5633 sensor basic support.
> > - Support read 20 bits X/Y/Z magnetic.
> > - Support I3C HDR mode to send start measurememt command.
> > - Support I3C HDR mode to read all sensors data by one command.
>
> ...
>
> + time.h // for time constants
>
> ...
>
> > +struct mmc5633_data {
> > +	struct device *dev;
> > +	struct i3c_device *i3cdev;
> > +	struct mutex mutex; /* protect to finish one whole measurement */
> > +	struct regmap *regmap;
>
> regmap has struct device, i3c_device presumable also, and here is struct
> device. Don't we have some overhead?

i3cdev is used for check it is i2c host or i3c host. If device connect to
i2c host, i3cdev will be NULL.

Only if connect to i3c host, driver can use i3c transfer api. The HDR
command is quite difference with SDR or I2C, which hard to wrap into regmap.

Anyway we need varible to indicate i3c or i2c. struct i3c_device *i3cdev
will be simple and needn't force convert struct device in regmap.

>
> > +};
>
> ...
>
...
>
> > +static int mmc5633_common_probe(struct device *dev, struct regmap *regmap,
> > +				char *name, struct i3c_device *i3cdev)
> > +{
> > +	struct mmc5633_data *data;
> > +	struct iio_dev *indio_dev;
> > +	int ret;
> > +
> > +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
>
> > +	dev_set_drvdata(dev, indio_dev);
>
> If you use regmap stored device this won't be needed. See below.
>
> > +	data = iio_priv(indio_dev);
> > +
> > +	data->regmap = regmap;
> > +	data->i3cdev = i3cdev;
> > +	data->dev = dev;
> > +
> > +	ret = devm_mutex_init(dev, &data->mutex);
> > +	if (ret)
> > +		return ret;
> > +
> > +	indio_dev->info = &mmc5633_info;
> > +	indio_dev->name = name;
> > +	indio_dev->channels = mmc5633_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(mmc5633_channels);
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +
> > +	ret = mmc5633_init(data);
> > +	if (ret < 0)
> > +		return dev_err_probe(dev, ret, "mmc5633 chip init failed\n");
> > +
> > +	return devm_iio_device_register(dev, indio_dev);
> > +}
> > +
> > +static int mmc5633_suspend(struct device *dev)
> > +{
> > +	struct mmc5633_data *data = iio_priv(dev_get_drvdata(dev));
>
> Than regmap will be derived directly from a device.

I have not got your idea. Can you point me a example?

Frank
>
> > +	regcache_cache_only(data->regmap, true);
> > +
> > +	return 0;
> > +}
> > +
> > +static int mmc5633_resume(struct device *dev)
> > +{
>
> Ditto.
>
> > +	struct mmc5633_data *data = iio_priv(dev_get_drvdata(dev));
> > +	int ret;
> > +
> > +	regcache_mark_dirty(data->regmap);
> > +	ret = regcache_sync_region(data->regmap, MMC5633_REG_CTRL0,
> > +				   MMC5633_REG_CTRL1);
> > +	if (ret < 0)
> > +		dev_err(dev, "Failed to restore control registers\n");
> > +
> > +	regcache_cache_only(data->regmap, false);
> > +
> > +	return 0;
> > +}
>
> ...
>
> > +	return mmc5633_common_probe(dev, regmap, client->name, NULL);
>
> dev can be derived from regmap.
>
> ...
>
>
> > +	return mmc5633_common_probe(dev, regmap, "mmc5633_i3c", i3cdev);
>
> Ditto.
>
> struct i3c_device doesn't have a name, does it?
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

