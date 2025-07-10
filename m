Return-Path: <linux-iio+bounces-21534-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AA4B0075D
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 17:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0122F64308E
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 15:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EA82777E8;
	Thu, 10 Jul 2025 15:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oDt3CBFZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012015.outbound.protection.outlook.com [52.101.71.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277FD274B33;
	Thu, 10 Jul 2025 15:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752161598; cv=fail; b=PLb0/PQN4Rl9IdE/wCpZzjdgWmwEusbANYwsabRNknNwzTEP8oV7Oe4Xd6ScfNEMer+fPvP9wg/LVxWV50Svl5kw+PMvxRwzSHu0ZvlcJkLEooWQLXjiyJBFveNJF4NoVOH0m+V7toN1pqq8Ah8580Ammr/+4NK5vD+zKyxSfDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752161598; c=relaxed/simple;
	bh=DqJg6hXPEJstLrctYfeBUeZ+/CGVUlgS0+HollXB1vU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pdBmVQEy3k7oI4E6slhz1h0t2Ar75psGTCkFumr8LedN2ZjdKNhvndldVrjmMPohyZFadGyMq5aIiezckh7gtEdvFU9qoQG6Yb7QI4ZZEKEgkwFQ4FwDgJ8wn1eFR46KywUoN1ZgrnzzbRi7v9wZcALGEY1HvxVcnkrkGR3qtI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oDt3CBFZ; arc=fail smtp.client-ip=52.101.71.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X3pKsqlEd0EpgRh6lpTTSfYSBvpA9ka9rFGaoAkd06xkm0lu/b7IYQ6V/nkAKF4Z+ezQkivyzPaOVO0ZLVVqKvZSaIaa+N7kP+FcvNlJEeLgxqAD+7gxIhw8KCzMm7UACm8PvzEQgGichL5urQ+MbTorhiCTjCHKB9ZT4zeYx/5kZNSE1frFXoUwhct+7K7AJ6kE0YjpfnDd9Bq2g266dNxCE3fdnVkBqss999GWqZdHkZJJMJUqEOSFuswprCbTaHZW7hpK4s1n71z+uEN9Yq/MUTCMm6a3vliL9YunhjTU5Ugnt5vka2BWzhgfj9qW1bIhs7SjRRkDEFY6ZawSTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AuTxwu4xty9p6t27whopZPjxkLn2qL+WIqfB8e8v1Bw=;
 b=cRxecToZLhv8EyfDOE8/YDNhxXIu2m/eFCGsK15P7PBvC4W5LGs6qs8ILmtDii52Vpf1ThFWo42TLHOUM0swqInBimqxvhXe2S7cEMVGpVeRZvWrbtESGxK0dZRtMyaLh13slBBwHKUbOU0Q2EuAGZMtM792UgXmKyUFub5MnByDi2sO0KnbNLexjkMVH50LMJ5qwxg+PffvnG9U5WGK5a5LTNYI/8DyGFy+ITmA7Mw8ihqKeHKcHkH88C+62Elw5Ac67CFFdBJjLrJgZ+mDVd8F0fTFfPWuxUYkX89JjoOQUKKPqsrJM6tOyVEuDZwRgF6POQyIafI/KyykKCb/rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AuTxwu4xty9p6t27whopZPjxkLn2qL+WIqfB8e8v1Bw=;
 b=oDt3CBFZegyJhtkzdqmeqP42oboyWzuaCh+WoMDoSzzl9SdkVSzXVN4YMdus0IlGmSHwXD2kY1F2PzUvJ7XfrcUwykj+0Wy9wKTTq0aaiJIg5ryyNaYm7MBbe/j+U+ZR3bKvfeDhROXGKDWcEpEkR7mxYmbLw4BqToFG8L/MTG/GgFe+d9yxUuZ/txAc1iGiKl6apxEEAZRCg4rUsahF7bSw7VKHMLzDq+E1sZbKRenmMc2AGArZ45e9P40nk4fb4PkJcAlQLwLCqflgvzTyRgpae/wxSsKbfuA5Fgqg3rSnPUG4gJSAY2YEfUmoxKBNJ69oQVYvrcepHFqtVfYqLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10781.eurprd04.prod.outlook.com (2603:10a6:800:26c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Thu, 10 Jul
 2025 15:33:13 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8901.023; Thu, 10 Jul 2025
 15:33:13 +0000
Date: Thu, 10 Jul 2025 11:33:07 -0400
From: Frank Li <Frank.li@nxp.com>
To: Primoz Fiser <primoz.fiser@norik.com>
Cc: Haibo Chen <haibo.chen@nxp.com>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-iio@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de, andrej.picej@norik.com
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: imx93: Add calibration
 properties
Message-ID: <aG/dM1G30FDfd6hC@lizhi-Precision-Tower-5810>
References: <20250710073905.1105417-1-primoz.fiser@norik.com>
 <20250710073905.1105417-2-primoz.fiser@norik.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710073905.1105417-2-primoz.fiser@norik.com>
X-ClientProxiedBy: AM0PR02CA0196.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10781:EE_
X-MS-Office365-Filtering-Correlation-Id: d1a12265-f047-446d-5091-08ddbfc7150e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c5DcHGn1hMN4yWgSsP8vxMMZn1PmnqyQuZR7R9qv6d8d0K92DCurTlpWeOEa?=
 =?us-ascii?Q?wXy8VwSjoKYnVfckVQUpj2v/KvKICk3w/Ns9h6IJqOAN2nXGZQhsTzPDplXh?=
 =?us-ascii?Q?i8oMIe4hlr3sGEWIq67L0l12H6OIAVKmYXAq34QcQh7gJD0BdoQC9kvy6POK?=
 =?us-ascii?Q?B9KB0zmcR5ksiRckdTn2bQlIlIam21nSRfzrpCcC61xM/nx+VqHRMe+eCqVT?=
 =?us-ascii?Q?1bFxnsRylKYqQLtMJy+SMsznucgIwSKCxONhkI+7TXnGefspEwaFL9552Afb?=
 =?us-ascii?Q?IMflsrAGu2yZKuFGqG+nI/bT/1lshEp3lHeo2t0g/vwNGTVvtaYbxOG0zynr?=
 =?us-ascii?Q?W535CHE/IiwRG7MsE3xK2wdoBr6+kX+q4KWWeoKcatLD4mHBzcnu2PwQEgUZ?=
 =?us-ascii?Q?UjzajArBScdUPdLA+g44GCD0fX3VLI21E5yrQzffY67jKuyzUtLsANVTatul?=
 =?us-ascii?Q?F1xD4nWVEJEAZ+coJfeMhiIIz9juRm4icWn0CAxi0RzFGzdNFr9B5IdhCPWq?=
 =?us-ascii?Q?xLODwXpZ+4ptnOz40NOIPb25FxM0icZUPv3cR+ULb/JdaeQ+sxcp8d9GYIna?=
 =?us-ascii?Q?WKa/B5FcTsk3wURmsLyzh4Cb5KFry8d+mT4EJXKOxV5BEDip+fk+Vsm+ipK6?=
 =?us-ascii?Q?xak5RaVfyPyjlAfMlhGPT5lnCNoZqw+uiGmcqQiEEedVUONibF4/vsLXz/yG?=
 =?us-ascii?Q?L5b7/ZKCEwWijc0bEC2olBT9w0y6tN1F3CbdZoRHZWE+k7/WLicRBkP6x5QJ?=
 =?us-ascii?Q?UX7aI3SGwekBXs/xgL7gA03pDp8YBomVWzl/fCm1SlCSmCuF1ZPh8P/0KH+E?=
 =?us-ascii?Q?ow4ISBH3B70g4ZyYUU3+mdSZ/ZOMwtEa4qMK5CxCt1tX2weegf7JhPpaV/gu?=
 =?us-ascii?Q?IsZecYTTI91dt+58MIb8M6MmOYuwgjRgFIk3sKzvGHoNeE/NiLMDAW34BZG1?=
 =?us-ascii?Q?MheTBdUWQd7+REKONrEFqAZ6adLBKLTe3fqln1wtEGF/GpYIA4K5O53fRTzg?=
 =?us-ascii?Q?iO0kCM95qxfxoD4FtoQHi62JGYbh4y53SY7eSa8VcjZQTuvxeCvcECwL8EIC?=
 =?us-ascii?Q?eezDKEwDZ0o0ogF4cImEAGm7ad54jO/EumL1azwl3VKHtcTPD+LIz+QIj/am?=
 =?us-ascii?Q?qdgYgUlLSL+RuGotm28yvZ20UV98Xy79umcjvcHwCTJY+NOBn2YoxS8PIO5g?=
 =?us-ascii?Q?X90eUCMAu+8J7t3pupx4x9h9r/iZWXrT8/O0j5lQO3xzbxjnG03JZbSOBSQy?=
 =?us-ascii?Q?JNMTsuNSgGYmGQitMRvequycXwvoCSl/NHfCYJPHeHH8zxw9du6iJn+Tb4Io?=
 =?us-ascii?Q?JFbOWo/vuPYzVeXsP0/P/DvOgPLWY1CUgCL5EVhs21NHnjw0Odae1W1CN/Rv?=
 =?us-ascii?Q?JD4V4g5rUAX6WV6q8Zmmybq/PxD1h9NDj+kUO6j3uBRoMoGHZROTE0s1BQak?=
 =?us-ascii?Q?rRgSf+ycGAW+H/jj33cRt4f8Zmb8BJkGQdynijIT4CF/tWg6wZlXLA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NmQaC+aA67mLdc0e2kQLNCH8ur8PvBRk6ejmcS2lbakYoeLh6brkQxSiq0FP?=
 =?us-ascii?Q?mYcJ7bMDRx70ghxoTZOUxbMaYAMfM3u6NDU31SDb/H4fsB299EpE2apEYkSd?=
 =?us-ascii?Q?NtAhmH7M/PCK1gIPfbFapPO9plPujYWh5MZCTSA9UILbyC/zZmPgEaRgGIxv?=
 =?us-ascii?Q?w+nqNFiZ5GQVXza4h1fCyb4df28SPCMZ4dtSl+WXnfevNysy4shbq49h63ks?=
 =?us-ascii?Q?1K3XcLywfwpjq4x/CvNzZc/FHY5juZjsHhaixku4pWjLLLxx2j+4WO0wMT+L?=
 =?us-ascii?Q?grqGQUrXBGVj7HD9LCbX7RgGsgFxpGMIXhoQMhupgvr+k6It7EoHdOZyVH41?=
 =?us-ascii?Q?30w46G/ERLilvMlk8roKLOHDt8ZTzlUh6Fr71mh86+um7rlwaeWgWcEbjpoD?=
 =?us-ascii?Q?AT6Ps7BdYFjKSAKsUc1hjnZw8xCJQmGWZ5tS5vuGQNz/UvSmnV9hpThTjqqA?=
 =?us-ascii?Q?FdcZMmswS6naqTfz0nmmbxSKUgu5rwm7FxHEG26O6aYy6zOUhxkIsiIqv2WF?=
 =?us-ascii?Q?tGYEPKIRXtOAQXkXQct+R2jDJgvG3p3bKX2XXEgfiPPQAxunwxlysj5j9G7c?=
 =?us-ascii?Q?UPmo/7yWY9Bcd8+6W74AhgNkrJRhDgYJkknaVFI2sF302kTQ3QmY9HqBCkBa?=
 =?us-ascii?Q?rdVahD2qzK3prDG6uBJ/wYnXfCTO7RAMl1vODzi1f61kKJa0CrsfyJ+OrumI?=
 =?us-ascii?Q?ebC1hBEsJqjHV3h3Q/Y04SgDimK6+WA9edpiDI9ujgPZ+9gwg0B84d0vcNcL?=
 =?us-ascii?Q?LeuAnw2ossMZKX0pcg5VKgsjjrIdezwNyt8an/mv9ZWduP62xwnIg1ZB6G9e?=
 =?us-ascii?Q?AsPxNd8whMxw/RN7hUtO+NrZ6txP76LSQYE5+IVEjTQhW0ugkiLh//GMcgWL?=
 =?us-ascii?Q?cdr9/SLK9/qO/sqGCPgU0uLt7qobACV7Viq+xImuJgeIlzAyA/x73zgoWPss?=
 =?us-ascii?Q?bMtQE9sEb3gAH09WrS23olL9wc78ybSRz85knuu7/HNuSJyeiuNpiJGz9lhU?=
 =?us-ascii?Q?XgCPf+3Y5SBW1Q7e/g0x7Q7Tm2v1byOGnXLTNTyTKmcC/Gai2WbGopH2OCSO?=
 =?us-ascii?Q?VWM8bqaM09/pM7WarFWdFCo32gc7xd4fRNrprztF2X5JViCABTcKR1WvSSUE?=
 =?us-ascii?Q?aH/oL3Sj5kPCKY5P5Ioc6kExT1ic0mMnXuad/oinwxxuk+0uA2HrXm67We2p?=
 =?us-ascii?Q?40FeFjKmzi1sH09MGiFFTuklSjXiXidevyU3ur80iz3vKNypGxiUMYr1U5cC?=
 =?us-ascii?Q?knG4ncZyJUfbByQZp0MPWbEIih/bzfbkb0M2VK4hoR5tMjbb/jdHKEhwiJ4F?=
 =?us-ascii?Q?y46HYlfU58DQxvHPywgs0IdlEngzclRimjIJbTfr5m7lvCtkf4PkT5cdHnZl?=
 =?us-ascii?Q?VpnY2+9at/R5ynlNDos3RV88pmsYmJ94G06Oh3DQBJfmt1gBxo16kUn6PY+s?=
 =?us-ascii?Q?DlBZsUVhN3C7YaQY/KhsFJkdbjA0k/WAeeFDqKKlCrt7yFKjkQ4dvMVFBeuI?=
 =?us-ascii?Q?35LB7z0k6AXq1S1CwRSRqf+DFCgM79gv2NYFeU3/hoEWme+Wi8FJIljivSC2?=
 =?us-ascii?Q?e0WmrBP6YIrnppITaWVF6h/pAd790fPrV1CsWBY9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a12265-f047-446d-5091-08ddbfc7150e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 15:33:13.0729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xWJ8AWRsgmmok4MYg0x3dTZPP46rLlVMDmOpz0VR6dfKDw0uLfALrzmbxpvWfJuNHVyGTq6lQqW2BT0b1AONCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10781

On Thu, Jul 10, 2025 at 09:39:03AM +0200, Primoz Fiser wrote:
> From: Andrej Picej <andrej.picej@norik.com>
>
> Document i.MX93 ADC calibration properties and how to set them.
>
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
> ---
>  .../bindings/iio/adc/nxp,imx93-adc.yaml       | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
> index c2e5ff418920..d1c04cf85fe6 100644
> --- a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
> @@ -52,6 +52,27 @@ properties:
>    "#io-channel-cells":
>      const: 1
>
> +  nxp,calib-avg-en:
> +    default: 1
> +    description:
> +      Enable or disable calibration averaging function (AVGEN).
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 0, 1 ]

bool type should be enough

> +
> +  nxp,calib-nr-samples:
> +    default: 512
> +    description:
> +      Selects number of samples (NRSMPL) to be used during calibration.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 16, 32, 128, 512 ]
> +
> +  nxp,calib-t-sample:
> +    default: 22
> +    description:
> +      Selects sample time (TSAMP) of calibration conversions in ADC clock cycles
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 8, 16, 22, 32 ]

Need some judgement in commit message, such as difference board need
difference nxp,calib-nr-samples value.

Frank
> +
>  required:
>    - compatible
>    - reg
> --
> 2.34.1
>

