Return-Path: <linux-iio+bounces-25039-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACFEBD5FDB
	for <lists+linux-iio@lfdr.de>; Mon, 13 Oct 2025 21:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB4D54F04E6
	for <lists+linux-iio@lfdr.de>; Mon, 13 Oct 2025 19:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACD42DA760;
	Mon, 13 Oct 2025 19:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WD+1W5E6"
X-Original-To: linux-iio@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013066.outbound.protection.outlook.com [40.107.159.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4A41D5141;
	Mon, 13 Oct 2025 19:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760384684; cv=fail; b=ES9OSC+Xo+Z8zw9Gq43SA4Tb6UQi0wGY5k7ibrwg4w4/h/29zH+A9/DXw6j479z/Dkh5W/5MTSsvRoblxagqtS274X96i2zcK7AAQ+s1yNRCnP70M+4wtDFbKluRtPVTBIX5yJdtvRH9MOR1zLaN8OPzfON44GFEDkdPO9wuDKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760384684; c=relaxed/simple;
	bh=0cBC8s8X0ZMfOVPXl1cPWPc6OBh2L1xR2a27P9G8H68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ojVtnaCPq2tRr7fVxdi/D6qV+l5lpUxWyGAIHxuD4oI3wdiKWLIQYF80H2GBXWkJmcilNgRMd/I5wSziGo2u4dsijgsLKd4qG1rzZOcpCS9ZuPRL6Eg3uPknOiza9sZRlZ6l8yeyPqbaz60wwok23xyqzOOtAjgkaN+11SHmt4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WD+1W5E6; arc=fail smtp.client-ip=40.107.159.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QGW01dBl8tmlrzvWWhQv5b4O4WSOo3BUnr9mcQ6biKFMIsLo8tUOpDVzT46tnRoGaqiTN2X/9Zu+iT73kLFGCk1mFE2UVfN06c8QaKLceOKDpQcI++sgIEbOJG7bAhtLJDlKAPrTNQ9fJxrpyYD/u3mxZhYrO8Hl8XnPhdr9C75uX/a4l67Nz8+ohdjUpa9oxqq2aL46JY+Fp30Sp1Ot1AfTLDmr7c9hh/44FTB4Y4ThWgjxFjSvDFR8UDFYzf+aIbr7CwcFIVZ1Shsjg9vxXqP3e4oKH6IFQynJEe+g/dZb3XgyvbwDjFJavVEOUoIXBAzR+FK7SLyPRHvEWYhJJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HoXbTrVND36dY9HjFOBUseUx4yyZdjyVaUpQhu304aA=;
 b=k6rMjqB7reP0cyTc9G1/r4tTytLYOzST5GASVTokPqseibEvnYzFjjV4MjPh46+ibXCMreVTtR0iC8cCcHtovFK6+S58AgXCKbsX3RVyTO+9DSQBtPNLPbyGX6zXjeFXnReS24677xyuKz2iO6e1zmmKjUFK3jEs84OGynyUsrAEoBu66PmCl6ss4pRAr+XuHongOo1RyuDJrCmoFj3s87P2b9+U3xVSVWYLm2umcWvHAyLNqXUWGp9yhbYX8mjOxzOPdKQHu83X82iAFj2n2lmLP4pciGokMOKkpnDuZJgIjCG8cgKhmFGE0oNb6OJGeK2cOxkhclY27UvBUY5vQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HoXbTrVND36dY9HjFOBUseUx4yyZdjyVaUpQhu304aA=;
 b=WD+1W5E6sOIDEvzMWZvQ+Tdvmddn451XIoSudl30B/LvNfP3FiB07da0vhaUkL1hh3YnCZPVeCFoOeYjEqRUtcegytFs77jKj4sFMZbKUCusPF34+yFtowFjZwuJgcmfTsXKQkZj0YS4HaRXqCmR0XVrkqKuuRXinuVK36iEz2bQIpjlmkdWI8k+tvMJSFKvgrw6ldMW8zmPw4YiJ5alWzLh7IFE1esrWJXR124HVoR40uC2PnIjF5dHMPf3UQbHNovRZ0ZvaW5DKf7zohJiiZurz8SPliHBR5/VLjPsgdWDUfP7yfBg4EFk3L062egTMeYXnQwyZ+WFOqKpS2hnyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by VI0PR04MB10096.eurprd04.prod.outlook.com (2603:10a6:800:24c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 19:44:38 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 19:44:38 +0000
Date: Mon, 13 Oct 2025 15:44:30 -0400
From: Frank Li <Frank.li@nxp.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-iio@vger.kernel.org, joshua.yeong@starfivetech.com,
	devicetree@vger.kernel.org, Carlos Song <carlos.song@nxp.com>,
	Adrian Fluturel <fluturel.adrian@gmail.com>
Subject: Re: [PATCH v5 5/5] iio: magnetometer: Add mmc5633 sensor
Message-ID: <aO1WnvWaTDhU9PNo@lizhi-Precision-Tower-5810>
References: <20251007-i3c_ddr-v5-0-444184f7725e@nxp.com>
 <20251007-i3c_ddr-v5-5-444184f7725e@nxp.com>
 <20251012180119.312191fd@jic23-huawei>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251012180119.312191fd@jic23-huawei>
X-ClientProxiedBy: PH7PR10CA0022.namprd10.prod.outlook.com
 (2603:10b6:510:23d::6) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|VI0PR04MB10096:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c41be08-ca5d-48af-5b73-08de0a90f1ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lUl3tEnvTNDARvTWFuI5Vr6eEGowjr/7l3Ud3AEWSyDYkrgZk0A3FbdTHL+E?=
 =?us-ascii?Q?aSfn8mTBNO4yaX6tSRaO6Oyl75Ug5t1xnVnHWOjb+9If5p6UyfBrKhbOQkDi?=
 =?us-ascii?Q?IZ6v0EYqvJQaD60ndeqSqzgqLTHmRHiUBcBQgQsHKFwFDN+l3bMBflbU2F8q?=
 =?us-ascii?Q?8lnerEMMNdAvBT7CWk7izXn433rJn/gsxaCloTkeP1Kuf8PUg10cPaNPtJqu?=
 =?us-ascii?Q?OBiZr9/BZ++0VzV4EZAfYXQDIr9E5klMue8UV9hIQ1eQ5+wUZTowAUiAR8MI?=
 =?us-ascii?Q?WTjvx+03nUuzO887w6gULfCZfDoNHAotwpVQMMovMGaNXVGPqoHLatS26KAz?=
 =?us-ascii?Q?twDFyqqRz1e9epo7DKZ1+pPCIrrLjnQMLqCMzzDDVRazMdFAoanbi0iSW+aT?=
 =?us-ascii?Q?GGfZkvslxXKoO7OgJ3ECjLKgLD95wsIuKo1Ma3JOMiBlSIjTf5wFCVz+9V4v?=
 =?us-ascii?Q?ZOYbylCaSGdoxWqDCead6m/Im/e0sDPkofPKxoIRboXxQHNnIINhmWzXgyB+?=
 =?us-ascii?Q?z4YnoXDIXNVG+yCF4D55WmgT4Kqw4WESw9oG06M5oSS8RpJckVgfRlWmDNrn?=
 =?us-ascii?Q?NkdhPkRVL5bzFVoHOIvxpnWlfuR6qdyOqq84T2SfhIgYoiSu2Y0ln9n1hF2/?=
 =?us-ascii?Q?MUYzmyV8LkhMaq6GUpTDd8Pcq0gc0BZYl3+i+bavaDyVyPgIxFSjgNT2Z/Rk?=
 =?us-ascii?Q?K1rYSrNTFoP1WRpmcGOOzNNZnln/JjaR2tKW7+tD38hNRsk+UJi9NXIOXl6j?=
 =?us-ascii?Q?YfxnXzYwkih4CX4K4UWyzj51LMy3NAhk24UB+p34PkYp/NNs0b/LlSG28U+b?=
 =?us-ascii?Q?XlSu+vwyG4lmCzOeEXkSIJQFKpi4ugw9tncz4PJ+fYZVml+uFxIUGT54/RFr?=
 =?us-ascii?Q?mspBnCD7MCcpgN21qoUfsOY1VuhNn3XoY5KNpaNU1wpG8AjQAy1bDtNtaqNh?=
 =?us-ascii?Q?U+DOu/vapMBF3Smq09TAKxRZdDW2e74AnytUY41wz1AERs2FN1NkQrK57YA/?=
 =?us-ascii?Q?FqbbD7F8iWO+TU4VCg+G0sVi2ydH3qvuxhzoUsB64wH/j74SyLhtDhpHjBSm?=
 =?us-ascii?Q?g/4h3U4OwKABnd+9D0RblJtVcLTXuPt+Ii4dAGGANEHmRgE6jDYe1CYJa+s6?=
 =?us-ascii?Q?L9Q4BAO6uDdivi3sKyZLvyLSamlPbxiPiq9YOHbdEiM34rmTjftTzOhV2fHN?=
 =?us-ascii?Q?ZrdrAqswv38jD8SMhMLDAOKr3n00wdJ3ntIvBq6sDmjnk/rS3MPNbJNMzjJs?=
 =?us-ascii?Q?y2gjwnZtXi8ppKLcIXjyFPR1RVi47SsKgUx6RWVI3jZJIvxbIYyewtEawLHT?=
 =?us-ascii?Q?/5WYJ+AovcCiMbkGcIcROqw6l4hhzVlg9p8dyKaP16Ax22tPfi1+8C9r/voL?=
 =?us-ascii?Q?xAlu2LfSryfcgA7pTLFJF3EK0Vg6YINd/wwbhP71zFZPVMGz2faG5z0PddFS?=
 =?us-ascii?Q?I/r/k1f4BMTAumQSd1NODjAs9FqP8mFqxbe1ASn3wPEC+5Bu7Q5xSg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gAHJ9I4jMK69h8kYL5E0OsUAH+rLCDld9tL6NZyja9gdQwU8mJFera0qfS66?=
 =?us-ascii?Q?76mFVqErLJOGyvU8Cnjugs4ZACzIII6QExjMaKK3t/T/MfwoTS20EN9nZheM?=
 =?us-ascii?Q?hrExm/6PgYGGR74k1JK2hFFQcZJiPyEi4w/gKgG7d5NjOTuQ5De8vxMprnXq?=
 =?us-ascii?Q?8W6NkHDTXDDsd6YQC3jpvTc/DaptNgtqzlHwQoHldRp67AA8r/L+Islv6Zs8?=
 =?us-ascii?Q?mOvFeKbdzwDpmomXjx4tm8lsglA/0POlQ52wN7R7FHSjuqXryADN0WWsQpbr?=
 =?us-ascii?Q?oMW+8az7kdOZ/BE8tI4YZDuJXU6lwTUarimeiS8EeDE9+043ajxx8pSmILg8?=
 =?us-ascii?Q?rJr9g7U5fBIdL9xt0hvu0N3C1405ZICB2j4RIGvSR+9vYsvMDI7L+bEt87q8?=
 =?us-ascii?Q?4figWYD4Qccn1Wy1aOaTdmHqpOAtUkuEyAMQEx5to5hIdTwA3bbnI73QqKAQ?=
 =?us-ascii?Q?y9Yldg9Si5cdQCAhcixIuTPqLOW2lnJeNU0h9PcU11gWqzMBkIVSOsJy1mYj?=
 =?us-ascii?Q?xBrwsw3eKAoYeoYe+6pU0/+Zso1Aig49E3i9nR9X1PtSU9CRQchMFbAeABDV?=
 =?us-ascii?Q?8BfVDTusNR/ruMLIpxrzkw2cb9Aor1IdhWS523WXu0vbsKMO1E8q4XeJIpdW?=
 =?us-ascii?Q?UBc1jnwKWBzVa33iTj/YN/GAyhej+IvyeAwxU6FyKmFZO2VsJsIqAkBecorJ?=
 =?us-ascii?Q?K7D8/mCP0xLHfgtMZlrddc8FB4BISHh8aTAdBBqcIeC6DTb5R9x+/LMU3Ssn?=
 =?us-ascii?Q?TdMsFdGmdR0ZIENZkV0hBgNXZJEVvoJmOSG63Y3fwf7QkzjK3nRwzw6H43mG?=
 =?us-ascii?Q?wBERFF5++qDy9VCJ/c435xLFo7KzkxWTC9wUvO/e9Zx8sYC34ev3DhlNX7+T?=
 =?us-ascii?Q?B4jn6eYVJrhQDwH+oUg1a6DNPLvkSxaIb15I5ISadUXvkkzkAaxEw1CGBRtB?=
 =?us-ascii?Q?njCgyyFCVFosGLnMNqXG/E0HVyyU0PVoyPpgV9P3CmEfxeqR8dBX2nmhekEc?=
 =?us-ascii?Q?rfJEUXAT2cxZe+gc4SYAMXJ8yJJdDihIMlypeMf3h4WSuOnPLapmhGdUtZBm?=
 =?us-ascii?Q?njgrgW8pmXN6hKfTQjKIBSwFBzpdP5UVUqm2FhY9EzaQAvWwwKeCtrAL/b9f?=
 =?us-ascii?Q?oPO8nGC8kER3jRxjrARf+d++WFp0r2AO6B72l7HXPNe+wfskFgbazROJcFJc?=
 =?us-ascii?Q?Hhhn0vFzQasBY5Rw3IfIVh9KYe153wXcsnyNJ/rE8jdErT3Xbt2SgvTZu4cv?=
 =?us-ascii?Q?XrHNFSsMyNiLIdhJd+OeGhja3+ZTXKXVrNFTynWEB+fmscV9GeTRZV/KXEj2?=
 =?us-ascii?Q?oBCUgv5LnPV679cFxWXMXpxDaSC++AyqpodJHaKhuGrqCwWUIc2e4Dgf7tas?=
 =?us-ascii?Q?a1pm70xMZdz3amuK7Ne+w39qt67JnOom8pwTpxLaq07gBMfOIrjGY1FIJ7ZG?=
 =?us-ascii?Q?6L1uKFvVhun7eLQSjQaYcnuYDdnvmZtQ+hQs1z79gbMCf4Nbo59fIan3prTV?=
 =?us-ascii?Q?nDIrtTTxYz6Eme9DeBz7HRpFyzvo0qx5gP4/R4G40HQzH1fbFZtohx9HrHX2?=
 =?us-ascii?Q?M7OKhM0+BShqTpPi/zHB4IbV3g3Hl2d/lkJWwhfz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c41be08-ca5d-48af-5b73-08de0a90f1ab
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 19:44:38.1434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qTT3N9/2YH67wVcSoQT3OKiYni0Dfi9ZcRxGjekbjdXeNdnRvEUj+u9N800FjeHUGLYVlPVUF7i4/u3h2/UPeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10096

On Sun, Oct 12, 2025 at 06:01:19PM +0100, Jonathan Cameron wrote:
> On Tue, 07 Oct 2025 16:06:17 -0400
> Frank Li <Frank.Li@nxp.com> wrote:
>
> > Add mmc5633 sensor basic support.
> > - Support read 20 bits X/Y/Z magnetic.
> > - Support I3C HDR mode to send start measurememt command.
> > - Support I3C HDR mode to read all sensors data by one command.
> >
> > Co-developed-by: Carlos Song <carlos.song@nxp.com>
> > Signed-off-by: Carlos Song <carlos.song@nxp.com>
> > Co-developed-by: Adrian Fluturel <fluturel.adrian@gmail.com>
> > Signed-off-by: Adrian Fluturel <fluturel.adrian@gmail.com>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
>
> Until now I missed the ACPI IDs that look to be almost certainly invalid.
> See below.
>
>
> > ---
> > Change in V4
> > - use { 1, 2000 }
> > - Add _US for timeout
> > - Use GEN_MASK for MMC5633_CTRL1_BW_MASK
> > - Use { } for terminator.
> > - remove !!
> > - fix mix tab and space
> > - add mmc5603 (merge https://lore.kernel.org/all/20251003000731.22927-1-fluturel.adrian@gmail.com/)
> > - add tempature measure support
> >
> > Change in v3
> > - remove mmc5633_hw_set
> > - make -> Make
> > - change indention for mmc5633_samp_freq
> > - use u8 arrary to handle dword data
> > - get_unaligned_be16() to get raw data
> > - add helper function to check if i3c support hdr
> > - use read_avail() callback
> >
> > change in v2
> > - new patch
>
> > diff --git a/drivers/iio/magnetometer/mmc5633.c b/drivers/iio/magnetometer/mmc5633.c
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..9b04cba6dbf633b7e0d136629a5aebffd072a68d
> > --- /dev/null
> > +++ b/drivers/iio/magnetometer/mmc5633.c
>
>
> > +static int mmc5633_write_raw(struct iio_dev *indio_dev,
> > +			     struct iio_chan_spec const *chan, int val,
> > +			     int val2, long mask)
> > +{
> > +	struct mmc5633_data *data = iio_priv(indio_dev);
> > +	int i, ret;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		i = mmc5633_get_samp_freq_index(data, val, val2);
> > +		if (i < 0)
> > +			return -EINVAL;
> > +
> > +		scoped_guard(mutex, &data->mutex) {
> > +			ret = regmap_update_bits(data->regmap, MMC5633_REG_CTRL1,
> > +						 MMC5633_CTRL1_BW_MASK,
> > +						 FIELD_PREP(MMC5633_CTRL1_BW_MASK, i));
> > +			if (ret)
> > +				return ret;
> > +		};
> > +		return ret;
>
> Trivial but to get here it must be 0 so make that apparent via
> 		return 0;
> Then everyone can see the 'good' exit really easily.
>
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
>
> > +static const struct i2c_device_id mmc5633_i2c_id[] = {
> > +	{ "mmc5603" },
> > +	{ "mmc5633" },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, mmc5633_i2c_id);
> > +
> > +static const struct acpi_device_id mmc5633_acpi_match[] = {
>
> Guess I missed these in previous versions. Sorry about that!
>
> Where do these come from?

Copy from drivers/iio/magnetometer/mmc35240.c

>
> MMC is not a registered PNP ID according to
> https://uefi.org/PNP_ID_List?pnp_search=mmc
>
> So are these in the wild? If they are provide the DSDT snippet
> and a reference for where.  Also add a comment after the ID to provide
> one device on which it is used.
>
> ACPI IDs can take two valid forms. (1)   A 4 letter prefix that is
> a registered ACPI ID.  e.g. HISI is the HiSilicon one I use for
> the day job. And 4 digits that must be unique.  Typically each company
> has a tracker for this and a process to get one assigned.
> (2) A 3 letter PNP ID.  Similar otherwise.  Memsic has neither
> unless issued very recently.
>
> So if these turn up on a device that uses ACPI either the manufacturer
> of that should get MEMSIC to follow process to get an ID or use their
> own.  It's common to find random sensors with IDs from device manufacturers
> for this reason.  Here NXP could use their own ID for example.
> They have a registered PNP ID which is the obvious NXP.  To do that
> though you need to make sure you get a unique ID.

I can remove acpi part. Add it when someone really use it. I don't use this
now.

Frank
>
>
>
> > +	{ "MMC5603", 0 },
> > +	{ "mmc5633", 0 },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(acpi, mmc5633_acpi_match);
> > +
> > +static struct i2c_driver mmc5633_i2c_driver = {
> > +	.driver = {
> > +		.name = "mmc5633_i2c",
> > +		.of_match_table = mmc5633_of_match,
> > +		.acpi_match_table = mmc5633_acpi_match,
> > +		.pm = pm_sleep_ptr(&mmc5633_pm_ops),
> > +	},
> > +	.probe = mmc5633_i2c_probe,
> > +	.id_table =  mmc5633_i2c_id,
>
> Really trivial but there is a extra space after the =
>

