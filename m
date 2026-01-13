Return-Path: <linux-iio+bounces-27679-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DE9D1AC61
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jan 2026 19:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E586730194E7
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jan 2026 18:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A38320A30;
	Tue, 13 Jan 2026 18:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ch6zJ6YW"
X-Original-To: linux-iio@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010030.outbound.protection.outlook.com [52.101.84.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F40A287516;
	Tue, 13 Jan 2026 18:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768327277; cv=fail; b=ShqX4L9V3zCeDXpBRk7yS4E/s6QUaIQkPR/PknSg8+zu7wXSnF0qSCxqVkwDfQf7RordpsrWcPVWu5UJF0uXxKkF57D3FGra37NCYaUiCvyBbVx9EG2drpc0Hq10TLL0+tWlBI30kftYhr0GF1R6LpDwopr7nKxGTA3ypgftPIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768327277; c=relaxed/simple;
	bh=9q9TXLcLlF225MGwC4DXfTLY/k9gQVOtPvh/2Jh+Rag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qrWL+ntssThC9SLhDfj+FSOPtIRPua3hARhrQHC70dWjUsapdjLc/XdJXoIKg/JPdo+A79KGj58YfWxiDoQXvuTooyNS671P4UV/DWnmqcxY9i3T/wxx3FzLUPmTcmKSH9mGD/uGJaydbyFe5HI1Lm/iE+mII7rAsV4yDVmVB0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ch6zJ6YW; arc=fail smtp.client-ip=52.101.84.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZsMjpq6yFqcR7vRWsM89JrxqVs2spdl3pj7aqk1qNm9B8QofN96eyYvqGn3QgjzvNN0hSnyeuhCqXrGZIqAewJ7YMcgwLQpeTuRyR7WGIf35/hvznXAByubhgUcPXVafFsIBboBJtbh6ow2SlslRi65a/OGTEsbYvnIYE1z6Md3uDJmL6DtzDG27BDK+Rcp7BGc5rzW3S8uJDVr7RaSiYTVDALeRRa2xRlxh4LUd/66v9J7WfQ4Dj5R98dgS6V8hJDj2oZVXqbmy/wBMazMkYtrauFcSkEk8vnBV6i2RKBdLRox6ofe+wKqByQT6tgnGhQ90HVxYVy1yVEedp5w0mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5lWxA0yC/GemjhCYBLKnakj6PrjtwE4C1eqLIoP3iN0=;
 b=k4myOFHIdl5hgzRDV1Ya3YLZpc1UEXo8L8rrT+SiJLjVB9dFoXTyX9IQvuzWOCxdMcaQkeFdsU2+Xuri8doCP1xk4E0P4EFrNK0ozBJOMGU/M7g6kgcEMGaD9ebfQaibmoI9jkSL8awLCJJPoGRUozOlXAFHRHVYtizkTpOa5fVpMhI8EAuZj94tWN5QzO353Q/GwbAFxhWuixRJKe1vtFaHTDR1U3XhxfAyl4mi/bf+s3Yglhvcf2+U4VWjQZXOFxewcn24FH/lGsWnee90FtkGWt33idAPCrQoNjGNczXWCpCzQyllatWps8f6N4xgCSdKOKu4GHw6lg1KqJKVXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5lWxA0yC/GemjhCYBLKnakj6PrjtwE4C1eqLIoP3iN0=;
 b=Ch6zJ6YWzvfyhgdnN7lPGnYz1n8J9dp8DVWGbaOHucSG7qpPtaCpGSYcB1XOz8sLBdwlJosdhdTJhjWnRw4sSFbXCjz3TUGN156Vl1dccP1r10gCGVapS0kk3UkXg9INRnYWuDsI1jdy9g5TWlNL33+De22zi5Uj6fyJYo1z+p96YNclq3TamcS0zr0wPQuRB4zuIxw4Wj6BZ9iIa7Q7/cCCjy0ckjrgcJDTLAe0s2fuH8l8NuIspRPFHvbHDAG9S1GJX2POWZNZ9KXyJdpVKTVAonZzpkBgObayCoLMlxlaXsxo3Iq+3w3L4KeFHgeqPSqj2HUS+4Ab3j3Y58qwsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com (2603:10a6:20b:42f::17)
 by VI0PR04MB11920.eurprd04.prod.outlook.com (2603:10a6:800:306::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Tue, 13 Jan
 2026 18:01:08 +0000
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e]) by AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e%4]) with mapi id 15.20.9499.002; Tue, 13 Jan 2026
 18:01:08 +0000
Date: Tue, 13 Jan 2026 13:01:01 -0500
From: Frank Li <Frank.li@nxp.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: wbg@kernel.org, robh@kernel.org, conor+dt@kernel.org,
	krzk+dt@kernel.org, s32@nxp.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 3/3] counter: Add STM based counter
Message-ID: <aWaIXRLxGBh0bjuQ@lizhi-Precision-Tower-5810>
References: <20260113165220.1599038-1-daniel.lezcano@linaro.org>
 <20260113165220.1599038-4-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113165220.1599038-4-daniel.lezcano@linaro.org>
X-ClientProxiedBy: PH0PR07CA0079.namprd07.prod.outlook.com
 (2603:10b6:510:f::24) To AS8PR04MB8948.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8948:EE_|VI0PR04MB11920:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dbf705d-f60b-4e0a-4c2d-08de52cdba45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|52116014|366016|1800799024|38350700014|18082099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2roUoobTGeMsFWcceOHncRT+mrLLcZi3QLO50hYrxjUiN4qGKOGyV/DWopty?=
 =?us-ascii?Q?dDDCGeSXzP1l0mGBl+Q/XcwKQlfqAeoXkA15Eyigq0fz8ssmJM1itm5Z5orG?=
 =?us-ascii?Q?MzDwFtgpjO+yNtyd0BEur8iiT9VRDg3Mn9XZ7hHjEEEj2Ydq65ZISN+et3Kb?=
 =?us-ascii?Q?jjx4t3o4h75s5F64i6SwGtmTWIlb7ogsJRpBNeKnYe6vrEduDdNkG+dR0q4C?=
 =?us-ascii?Q?B4zmWLeY8zKO4pRfLyJ4oHvOm+e7LfgLEw9csGQ3Z13CkANtmzedH835YJGv?=
 =?us-ascii?Q?va2Lm4ORcfCuNhWTaU8uUTWiRAjdxAhrU3fE6hJF3BUQ0Y3mBCJFxyC7F3PZ?=
 =?us-ascii?Q?XxwBt4Al862sFkTVEeRi9kpbrmZTwKiPF1+yPF+TI0vqROHrcUzDSeTNieG9?=
 =?us-ascii?Q?WbUJ49SE0VBiETeXk/tT1lLFtNfSCVg4wiye2XgC/ZdZRrflm9WgKJnoByQh?=
 =?us-ascii?Q?Omm97xRMEjgvompUMI9OemvzgqTHdaVQGEDULr+Ipcpd9oW3FIdtgHfvkXds?=
 =?us-ascii?Q?SYzv93slwVp59wgID85yfbENDglkuh13gwJIN88LSS2KNCeb/T2x9sRsaNSO?=
 =?us-ascii?Q?03Bx2TTPebf4ua4ujsoCMjLd0RfIALQSpLN2rvR/5oGeewEoUAqagrSrP+TV?=
 =?us-ascii?Q?tvwwpHHyqc+tpyVYHxX0nT9m95ibUwUZGM8Fb4BZPi5fJxm1z7UMBEg/vJKq?=
 =?us-ascii?Q?NfPZey0KDUlqfjC38716dFUz/VEHC59EdOZyLX9XM15VVh4BQ20zX8sT6uVe?=
 =?us-ascii?Q?m2v9gu+8nc7BS4jD6aEUOJYiVa7lbShlIA02xRsZU1Qy+kxyRvwPhPl6vZ9E?=
 =?us-ascii?Q?WuDGxPyd6megiBUgD8Z4j5lWvLWuCaZZlqkeySCl7sO3bvKv121k0cF0GbZF?=
 =?us-ascii?Q?oqrjlBBIDNIta+sH0pU+ZtDcWFz0ExjeHav3en6Ogrk3bTtn4sWVK7p9LOr+?=
 =?us-ascii?Q?quDZzFIrCUviQT/XGolYCMRmhJdP2lugMap9BfG84VW5GGL/3gV0aXVdEqi8?=
 =?us-ascii?Q?ZlF/CRhulX1ncJ5yT4Z0/mn9a6RmudKXM7w0S97piqxzQDPABZJfdomb+nOB?=
 =?us-ascii?Q?ZMac3tlcs6exx0DeGmvfLAYqNucOCkghI/QLiw983XnmoVmEvCikpujmAa6h?=
 =?us-ascii?Q?qGZpo2y47YcXLc23zlshactYTWe89dRn6TUeKOAd+I8nl1Kdvzrr0gnfxw+A?=
 =?us-ascii?Q?q+NqAXR2egEjbCHXdsIz+KjCguL7hhL9bgSojhlxKouD++p4iJ7/C3u4kVoX?=
 =?us-ascii?Q?zrjxQaarNak1CXPuymtKaTWeRznk6nXfJkCfudcec2q6eApkisOdHkxMpPr0?=
 =?us-ascii?Q?gfFmyPJSC8Uz62TLfu8hTt2sXfqEO3ThzbYYZoYC5M5d9e/kCo/1ml4QpNmw?=
 =?us-ascii?Q?xFOFeUMy2bLgsSVyGkZyetwYPOQOKy/cF2AxWj+5QJhFHjaWy0CFP+uYke+Q?=
 =?us-ascii?Q?jHDcVn7BEf1vPMtIJ2+lT0TSQJ91ZX2jhVqMw7rvg2y3hlefvAEh6KWH7+IQ?=
 =?us-ascii?Q?LLJTpf3MecQ3bgxTanB9alCaSQKj6zbg0F3H?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8948.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(52116014)(366016)(1800799024)(38350700014)(18082099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6VJEkQs3aEqEDYmYI4GiV8XNiWy9v8EEiQHUdT9CuDKwYNM+nq8a41z6eSUU?=
 =?us-ascii?Q?AKjCzWT/C0zcR4nV+0hxFRWtP/iGfvIPITJ0HrsTBJOLPYRew0+WL31dLshs?=
 =?us-ascii?Q?cGxV4smBwqRl3XUgFArrpDbPHXNmi/mI/4oaULBFuUl/5/wur7TRg/AxdqXZ?=
 =?us-ascii?Q?/yrjeCdww++Afi1sKRv+NWvW/kFgafy12BzwA7sjkSGsHdBJAWQDF465uzWl?=
 =?us-ascii?Q?qgcpLSIa8uHueV1jtEt/fWmBPQWWL/1cgdU/fl61wJglVfs8Cc7jXBwsULLs?=
 =?us-ascii?Q?BI9g3N43mJWO1aKk8ncMrsO29N2640LNlo1TorUQADJ4UQuUBwt9ess95S9E?=
 =?us-ascii?Q?dhYVUgL6QckIuu5BQi3Gd1jCiQViiYsh2yTEER6fdRhpFNau5Rz3w7JmzEtp?=
 =?us-ascii?Q?XRgFBOhy64Rtj87Oecy39SeAIdJipGDx8BpC77i9X0dJsKrw6A5H28XOnfk0?=
 =?us-ascii?Q?x0IgXknT59M7Ua5+FcwEnvp3x8McnjFbELQdi20WSB7QAutyElN5G0ssE6BU?=
 =?us-ascii?Q?Tmj4mur8VQc6FKBwFUsFpa28C+l7Vs4o3rImb1cotD5DSYlcl2fjDy6XVdid?=
 =?us-ascii?Q?mcst5Xw8UxAfa6z48sHAXGRS8VObEbkFjuPo8xjcyyJcO1tbq0pVsA2/Zbmg?=
 =?us-ascii?Q?q6Dyy7/uff9n0w71xrY4xSGOC+ZyH/mFMw4OIG6d+Gwy8eOwX03XzSsLCpHH?=
 =?us-ascii?Q?zWuPzG/EUq7DEM9EpBN8TjThuoK4pRM9vsbJnHR8fQdIz7rfUDTic2YiY5XX?=
 =?us-ascii?Q?EqH56Z4ViCldmYK7T7NgQ2nstpj6+WdngVQfUwWmY0jVBAQO8ezChLfcYl1B?=
 =?us-ascii?Q?F9qW5TJaj3zoLoNYKDpPMwQDXxGXYEPSBvjDZ5OA101My1j/O0kvAG/TEpRP?=
 =?us-ascii?Q?nmcbWtG/uGqq7LfSRA/jEsM/K5IywcWAjHN8l2XX1vEl5BI4uy90mggGqkQX?=
 =?us-ascii?Q?kF7OUpEcBwNRHMCck3HxzqVtSj38+YMk2+VbytmDRr16UiySKAerjiyJzF7I?=
 =?us-ascii?Q?MNvpIYTIewdhaOsw5J6B4/37aswzHOuKrBfeeeUtawEWSXpHh7pfgPCwpCxL?=
 =?us-ascii?Q?R1ZIiSwwX11nrRSe5uqEHM3bTUEeenhBL50Sde4ZwH6C3xtrEUkEeQKJh9oR?=
 =?us-ascii?Q?MJl1z66ewMGb1+IiDJ/t5asLdgcUoIfACK1Z9jUAYoE53oy32imtltfi9IkI?=
 =?us-ascii?Q?ZUHRrbB3R/IxtAUEpuidEcqpjYveXzDeH0M5nXJNGz6N4nKg4+qv/b2QszP/?=
 =?us-ascii?Q?yR1giKGQEB+DbXOyGtrYg1/fROnSSwNg717HLsqK061H+STA0jnYT7vyldJ7?=
 =?us-ascii?Q?4jM4xOyXk80GeT3PeWkcXI6fpcvYu4bojxu3TM6TTBnKVhFUe9xGo7foHR6r?=
 =?us-ascii?Q?CUhsBu/da6utZcwxTI6o8ES4JY/wby+nnrlZMq3UWMwTr9X/lCnLXWn315Uz?=
 =?us-ascii?Q?OoUmA2BmmEtt+vKFpBx3hoJwM3DRxv7ancuxx5N4j6V2B+dNuHRFbE3eDK2u?=
 =?us-ascii?Q?L/rb5Glh2ztEymhnIV3QTku1hmgLrcsKxvkLbtAHbsbXV4S61EACe8gajJXj?=
 =?us-ascii?Q?2eiRN3sJ8UHMykclXiUMk0u4yuJQkYqCb4CzbT3vS5ETNb/vQXZX/zmPtLz5?=
 =?us-ascii?Q?RV9uqeYtidGy7WXw0/cw2HLAbg6b4rJwKWrpskb2HLM7PjlqLOQuT5tPfPIT?=
 =?us-ascii?Q?c65QsjLCA3CLJr1+0CKqx93uEurpY4Bpf8NX6e7VVWqMX8E2F5LRKnsmaDLQ?=
 =?us-ascii?Q?FokzPfDrJg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dbf705d-f60b-4e0a-4c2d-08de52cdba45
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 18:01:08.3078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wCc0AkktLoc5VRs2f3OvJQqOJHw1NNUChY8Etw0YH6IrPqg8uKp5GuQZEICJHw8UGvPfMvco56JBMEZRGJfOaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11920

On Tue, Jan 13, 2026 at 05:52:20PM +0100, Daniel Lezcano wrote:
> The NXP S32G2 automotive platform integrates four Cortex-A53 cores and
> three Cortex-M7 cores, along with a large number of timers and
> counters. These hardware blocks can be used as clocksources or
> clockevents, or as timestamp counters shared across the various
> subsystems running alongside the Linux kernel, such as firmware
> components. Their actual usage depends on the overall platform
> software design.
>
> In a Linux-based system, the kernel controls the counter, which is a
> read-only shared resource for the other subsystems. One of its primary
> purposes is to act as a common timestamp source for messages or
> traces, allowing correlation of events occurring in different
> operating system contexts.
>
> These changes introduce a basic counter driver that can start, stop,
> and reset the counter. It also handles overflow accounting and
> configures the prescaler value.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/counter/Kconfig       |  10 +
>  drivers/counter/Makefile      |   1 +
>  drivers/counter/nxp-stm-cnt.c | 432 ++++++++++++++++++++++++++++++++++
>  3 files changed, 443 insertions(+)
>  create mode 100644 drivers/counter/nxp-stm-cnt.c
>
> diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
> index d30d22dfe577..bf5b281f194c 100644
> --- a/drivers/counter/Kconfig
> +++ b/drivers/counter/Kconfig
> @@ -90,6 +90,16 @@ config MICROCHIP_TCB_CAPTURE
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called microchip-tcb-capture.
>
> +config NXP_STM_CNT
> +	tristate "NXP System Timer Module Counter driver"
> +	depends on ARCH_S32 || COMPILE_TEST
> +	help
> +	  Select this option to enable the NXP System Timer Module
> +	  Counter driver.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called nxp_stm_cnt.
> +
>  config RZ_MTU3_CNT
>  	tristate "Renesas RZ/G2L MTU3a counter driver"
>  	depends on RZ_MTU3
> diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
> index 40e644948e7a..196b3c216875 100644
> --- a/drivers/counter/Makefile
> +++ b/drivers/counter/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_I8254)			+= i8254.o
>  obj-$(CONFIG_INTEL_QEP)			+= intel-qep.o
>  obj-$(CONFIG_INTERRUPT_CNT)		+= interrupt-cnt.o
>  obj-$(CONFIG_MICROCHIP_TCB_CAPTURE)	+= microchip-tcb-capture.o
> +obj-$(CONFIG_NXP_STM_CNT)		+= nxp-stm-cnt.o
>  obj-$(CONFIG_RZ_MTU3_CNT)		+= rz-mtu3-cnt.o
>  obj-$(CONFIG_STM32_TIMER_CNT)		+= stm32-timer-cnt.o
>  obj-$(CONFIG_STM32_LPTIMER_CNT)		+= stm32-lptimer-cnt.o
> diff --git a/drivers/counter/nxp-stm-cnt.c b/drivers/counter/nxp-stm-cnt.c
> new file mode 100644
> index 000000000000..dc2a666b323a
> --- /dev/null
> +++ b/drivers/counter/nxp-stm-cnt.c
> @@ -0,0 +1,432 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2018,2021-2025 NXP
> + * Copyright 2025 Linaro Limited
> + *
> + * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
> + *
> + * NXP S32G System Timer Module counters:
> + *
> + *  STM supports commonly required system and application software
> + *  timing functions. STM includes a 32-bit count-up timer and four
> + *  32-bit compare channels with a separate interrupt source for each
> + *  channel. The timer is driven by the STM module clock divided by an
> + *  8-bit prescale value (1 to 256). It has ability to stop the timer
> + *  in Debug mode
> + *
> + */
> +#include <linux/atomic.h>
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/counter.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm.h>
> +#include <linux/slab.h>
> +
> +#define STM_CR(__base)		(__base)
> +#define STM_CR_TEN		BIT(0)
> +#define STM_CR_FRZ		BIT(1)
> +#define STM_CR_CPS_MASK         GENMASK(15, 8)
> +
> +#define STM_CCR0(__base)	((__base) + 0x10)
> +#define STM_CCR_CEN		BIT(0)
> +
> +#define STM_CIR0(__base)	((__base) + 0x14)
> +#define STM_CIR_CIF		BIT(0)
> +
> +#define STM_CMP0(__base)	((__base) + 0x18)
> +
> +#define STM_CNT(__base)		((__base) + 0x04)
> +
> +#define STM_ENABLE_MASK	(STM_CR_FRZ | STM_CR_TEN)
> +
> +struct nxp_stm_context {
> +	u32 counter;
> +	u8 prescaler;
> +	bool is_started;
> +};
> +
> +struct nxp_stm_cnt {
> +	void __iomem *base;
> +	atomic_t nr_wraps;
> +	struct nxp_stm_context context;
> +};
> +
> +static void nxp_stm_cnt_enable(struct nxp_stm_cnt *stm_cnt)
> +{
> +	u32 reg;
> +
> +	reg = readl(STM_CR(stm_cnt->base));
> +
> +	reg |= STM_ENABLE_MASK;
> +
> +	writel(reg, STM_CR(stm_cnt->base));
> +}
> +
> +static void nxp_stm_cnt_disable(struct nxp_stm_cnt *stm_cnt)
> +{
> +	u32 reg;
> +
> +	reg = readl(STM_CR(stm_cnt->base));
> +
> +	reg &= ~STM_ENABLE_MASK;
> +
> +	writel(reg, STM_CR(stm_cnt->base));
> +}
> +
> +static void nxp_stm_cnt_ccr_disable(struct nxp_stm_cnt *stm_cnt)
> +{
> +	writel(0, STM_CCR0(stm_cnt->base));
> +}
> +
> +static void nxp_stm_cnt_ccr_enable(struct nxp_stm_cnt *stm_cnt)
> +{
> +	writel(STM_CCR_CEN, STM_CCR0(stm_cnt->base));
> +}
> +
> +static void nxp_stm_cnt_cfg_overflow(struct nxp_stm_cnt *stm_cnt)
> +{
> +	/*
> +	 * The STM does not have a dedicated interrupt when the
> +	 * counter wraps. We need to use the comparator to check if it
> +	 * wrapped or not.
> +	 */
> +	writel(0, STM_CMP0(stm_cnt->base));
> +}
> +
> +static u32 nxp_stm_cnt_get_counter(struct nxp_stm_cnt *stm_cnt)
> +{
> +	return readl(STM_CNT(stm_cnt->base));
> +}
> +
> +static void nxp_stm_cnt_set_counter(struct nxp_stm_cnt *stm_cnt, u32 counter)
> +{
> +	writel(counter, STM_CNT(stm_cnt->base));
> +}
> +
> +static void nxp_stm_cnt_set_prescaler(struct nxp_stm_cnt *stm_cnt, u8 prescaler)
> +{
> +	u32 reg;
> +
> +	reg = readl(STM_CR(stm_cnt->base));
> +
> +	FIELD_MODIFY(STM_CR_CPS_MASK, &reg, prescaler);
> +
> +	writel(reg, STM_CR(stm_cnt->base));
> +}
> +
> +static u8 nxp_stm_cnt_get_prescaler(struct nxp_stm_cnt *stm_cnt)
> +{
> +	u32 reg = readl(STM_CR(stm_cnt->base));
> +
> +	return FIELD_GET(STM_CR_CPS_MASK, reg);
> +}
> +
> +static bool nxp_stm_cnt_is_started(struct nxp_stm_cnt *stm_cnt)
> +{
> +	u32 reg;
> +
> +	reg = readl(STM_CR(stm_cnt->base));
> +
> +	return !!FIELD_GET(STM_CR_TEN, reg);
> +}
> +
> +static void nxp_stm_cnt_irq_ack(struct nxp_stm_cnt *stm_cnt)
> +{
> +	writel(STM_CIR_CIF, STM_CIR0(stm_cnt->base));
> +}
> +
> +static irqreturn_t nxp_stm_cnt_irq(int irq, void *dev_id)
> +{
> +	struct counter_device *counter = dev_id;
> +	struct nxp_stm_cnt *stm_cnt = counter_priv(counter);
> +
> +	nxp_stm_cnt_irq_ack(stm_cnt);
> +
> +	atomic_inc(&stm_cnt->nr_wraps);
> +
> +	counter_push_event(counter, COUNTER_EVENT_OVERFLOW, 0);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void nxp_stm_cnt_start(struct nxp_stm_cnt *stm_cnt)
> +{
> +	nxp_stm_cnt_cfg_overflow(stm_cnt);
> +	nxp_stm_cnt_enable(stm_cnt);
> +	nxp_stm_cnt_ccr_enable(stm_cnt);
> +}
> +
> +static void nxp_stm_cnt_stop(struct nxp_stm_cnt *stm_cnt)
> +{
> +	nxp_stm_cnt_disable(stm_cnt);
> +	nxp_stm_cnt_irq_ack(stm_cnt);
> +	nxp_stm_cnt_ccr_disable(stm_cnt);
> +}
> +
> +static int nxp_stm_cnt_prescaler_read(struct counter_device *counter,
> +				      struct counter_count *count, u8 *val)
> +{
> +	struct nxp_stm_cnt *stm_cnt = counter_priv(counter);
> +
> +	*val = nxp_stm_cnt_get_prescaler(stm_cnt);
> +
> +	return 0;
> +}
> +
> +static int nxp_stm_cnt_prescaler_write(struct counter_device *counter,
> +				       struct counter_count *count, u8 val)
> +{
> +	struct nxp_stm_cnt *stm_cnt = counter_priv(counter);
> +
> +	nxp_stm_cnt_set_prescaler(stm_cnt, val);
> +
> +	return 0;
> +}
> +
> +static int nxp_stm_cnt_count_enable_write(struct counter_device *counter,
> +					  struct counter_count *count, u8 enable)
> +{
> +	struct nxp_stm_cnt *stm_cnt = counter_priv(counter);
> +
> +	if (enable)
> +		nxp_stm_cnt_start(stm_cnt);
> +	else
> +		nxp_stm_cnt_stop(stm_cnt);
> +
> +	return 0;
> +}
> +
> +static int nxp_stm_cnt_count_enable_read(struct counter_device *counter,
> +					 struct counter_count *count, u8 *enable)
> +{
> +	struct nxp_stm_cnt *stm_cnt = counter_priv(counter);
> +
> +	*enable = nxp_stm_cnt_is_started(stm_cnt);
> +
> +	return 0;
> +}
> +
> +static struct counter_comp stm_cnt_count_ext[] = {
> +	COUNTER_COMP_COUNT_U8("prescaler", nxp_stm_cnt_prescaler_read, nxp_stm_cnt_prescaler_write),
> +	COUNTER_COMP_ENABLE(nxp_stm_cnt_count_enable_read, nxp_stm_cnt_count_enable_write),
> +};
> +
> +static int nxp_stm_cnt_action_read(struct counter_device *counter,
> +				   struct counter_count *count,
> +				   struct counter_synapse *synapse,
> +				   enum counter_synapse_action *action)
> +{
> +	*action = COUNTER_SYNAPSE_ACTION_RISING_EDGE;
> +
> +	return 0;
> +}
> +
> +static int nxp_stm_cnt_count_read(struct counter_device *dev,
> +				  struct counter_count *count, u64 *val)
> +{
> +	struct nxp_stm_cnt *stm_cnt = counter_priv(dev);
> +	u32 w1, w2, cnt;
> +
> +	do {
> +		w1 = atomic_read(&stm_cnt->nr_wraps);
> +		cnt = nxp_stm_cnt_get_counter(stm_cnt);
> +		w2 = atomic_read(&stm_cnt->nr_wraps);
> +	} while (w1 != w2);

Still have problem. Does hardware have overflow flags? This way is just
work for hardware overflow

CPU1

	w1  = 0
        count = 0xffff,ffff
	w2 = 0


when count wrap to 0, triger irq, but irq handle have latency at CPU0,
CPU0 have not chance to sevice irq. you can add printk at irq sevice to
create corner case.

So CPU1 get

	w1= 0
	count = 0
	w2=0

so counter still suddently change to 0.

Frank
> +
> +	*val = ((u64)w1 << 32) | cnt;
> +
> +	return 0;
> +}
> +
> +static int nxp_stm_cnt_count_write(struct counter_device *dev,
> +				   struct counter_count *count, u64 val)
> +{
> +	struct nxp_stm_cnt *stm_cnt = counter_priv(dev);
> +
> +	nxp_stm_cnt_set_counter(stm_cnt, 0);
> +	atomic_set(&stm_cnt->nr_wraps, 0);
> +
> +	return 0;
> +}
> +
> +static const enum counter_function nxp_stm_cnt_functions[] = {
> +	COUNTER_FUNCTION_INCREASE,
> +};
> +
> +static int nxp_stm_cnt_function_read(struct counter_device *counter,
> +				     struct counter_count *count,
> +				     enum counter_function *function)
> +{
> +	*function = COUNTER_FUNCTION_INCREASE;
> +
> +	return 0;
> +}
> +
> +static int nxp_stm_cnt_watch_validate(struct counter_device *counter,
> +				      const struct counter_watch *watch)
> +{
> +	switch (watch->event) {
> +	case COUNTER_EVENT_OVERFLOW:
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct counter_ops nxp_stm_cnt_counter_ops = {
> +	.action_read = nxp_stm_cnt_action_read,
> +	.count_read  = nxp_stm_cnt_count_read,
> +	.count_write = nxp_stm_cnt_count_write,
> +	.function_read = nxp_stm_cnt_function_read,
> +	.watch_validate = nxp_stm_cnt_watch_validate,
> +};
> +
> +static struct counter_signal nxp_stm_cnt_signals[] = {
> +	{
> +		.id = 0,
> +		.name = "Counter wrap signal",
> +	},
> +};
> +
> +static const enum counter_synapse_action nxp_stm_cnt_synapse_actions[] = {
> +	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
> +};
> +
> +static struct counter_synapse nxp_stm_cnt_synapses[] = {
> +	{
> +		.actions_list = nxp_stm_cnt_synapse_actions,
> +		.num_actions = ARRAY_SIZE(nxp_stm_cnt_synapse_actions),
> +		.signal = nxp_stm_cnt_signals,
> +	},
> +};
> +
> +static struct counter_count nxp_stm_cnt_counts[] = {
> +	{
> +		.id = 0,
> +		.name = "System Timer Module Counter",
> +		.functions_list = nxp_stm_cnt_functions,
> +		.num_functions = ARRAY_SIZE(nxp_stm_cnt_functions),
> +		.synapses = nxp_stm_cnt_synapses,
> +		.num_synapses = ARRAY_SIZE(nxp_stm_cnt_synapses),
> +		.ext = stm_cnt_count_ext,
> +		.num_ext = ARRAY_SIZE(stm_cnt_count_ext),
> +	},
> +};
> +
> +static int nxp_stm_cnt_suspend(struct device *dev)
> +{
> +	struct nxp_stm_cnt *stm_cnt = dev_get_drvdata(dev);
> +
> +	stm_cnt->context.is_started = nxp_stm_cnt_is_started(stm_cnt);
> +
> +	if (stm_cnt->context.is_started) {
> +		nxp_stm_cnt_stop(stm_cnt);
> +		stm_cnt->context.prescaler = nxp_stm_cnt_get_prescaler(stm_cnt);
> +		stm_cnt->context.counter = nxp_stm_cnt_get_counter(stm_cnt);
> +	}
> +
> +	return 0;
> +}
> +
> +static int nxp_stm_cnt_resume(struct device *dev)
> +{
> +	struct nxp_stm_cnt *stm_cnt = dev_get_drvdata(dev);
> +
> +	if (stm_cnt->context.is_started) {
> +		nxp_stm_cnt_set_counter(stm_cnt, stm_cnt->context.counter);
> +		nxp_stm_cnt_set_prescaler(stm_cnt, stm_cnt->context.prescaler);
> +		nxp_stm_cnt_start(stm_cnt);
> +	}
> +
> +	return 0;
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(nxp_stm_cnt_pm_ops, nxp_stm_cnt_suspend,
> +				nxp_stm_cnt_resume);
> +
> +static int nxp_stm_cnt_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct counter_device *counter;
> +	struct nxp_stm_cnt *stm_cnt;
> +	struct clk *clk;
> +	void __iomem *base;
> +	int irq, ret;
> +
> +	base = devm_of_iomap(dev, np, 0, NULL);
> +	if (IS_ERR(base))
> +		return dev_err_probe(dev, PTR_ERR(base), "Failed to iomap %pOFn\n", np);
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return dev_err_probe(dev, irq, "Failed to get IRQ\n");
> +
> +	clk = devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(clk))
> +		return dev_err_probe(dev, PTR_ERR(clk), "Clock not found\n");
> +
> +	counter = devm_counter_alloc(dev, sizeof(*stm_cnt));
> +	if (!counter)
> +		return -ENOMEM;
> +
> +	stm_cnt = counter_priv(counter);
> +
> +	stm_cnt->base = base;
> +	atomic_set(&stm_cnt->nr_wraps, 0);
> +
> +	counter->name       = "stm_counter";
> +	counter->parent     = &pdev->dev;
> +	counter->ops        = &nxp_stm_cnt_counter_ops;
> +	counter->counts     = nxp_stm_cnt_counts;
> +	counter->num_counts = ARRAY_SIZE(nxp_stm_cnt_counts);
> +
> +	ret = devm_request_irq(dev, irq, nxp_stm_cnt_irq, IRQF_TIMER | IRQF_NOBALANCING,
> +			       dev_name(&counter->dev), counter);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Unable to allocate interrupt line\n");
> +
> +	ret = devm_counter_add(dev, counter);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to register counter\n");
> +
> +	platform_set_drvdata(pdev, stm_cnt);
> +
> +	return 0;
> +}
> +
> +static void nxp_stm_cnt_remove(struct platform_device *pdev)
> +{
> +	struct nxp_stm_cnt *stm_cnt = platform_get_drvdata(pdev);
> +
> +	if (nxp_stm_cnt_is_started(stm_cnt))
> +		nxp_stm_cnt_stop(stm_cnt);
> +}
> +
> +static const struct of_device_id nxp_stm_cnt_of_match[] = {
> +	{ .compatible = "nxp,s32g2-stm-cnt", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, nxp_stm_cnt_of_match);
> +
> +static struct platform_driver nxp_stm_cnt_driver = {
> +	.probe  = nxp_stm_cnt_probe,
> +	.remove = nxp_stm_cnt_remove,
> +	.driver = {
> +		.name           = "nxp-stm-cnt",
> +		.pm		= pm_sleep_ptr(&nxp_stm_cnt_pm_ops),
> +		.of_match_table = nxp_stm_cnt_of_match,
> +	},
> +};
> +module_platform_driver(nxp_stm_cnt_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Daniel Lezcano");
> +MODULE_DESCRIPTION("NXP System Timer Module counter driver");
> +MODULE_IMPORT_NS("COUNTER");
> --
> 2.43.0
>

