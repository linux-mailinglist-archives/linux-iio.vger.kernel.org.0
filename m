Return-Path: <linux-iio+bounces-24565-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68058BA9E31
	for <lists+linux-iio@lfdr.de>; Mon, 29 Sep 2025 17:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 123A516843C
	for <lists+linux-iio@lfdr.de>; Mon, 29 Sep 2025 15:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD20E30C0F6;
	Mon, 29 Sep 2025 15:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="S5/shLZ+"
X-Original-To: linux-iio@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011042.outbound.protection.outlook.com [40.107.130.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC0930B520;
	Mon, 29 Sep 2025 15:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161346; cv=fail; b=GzRKd+M1j7z8roUHkDWKjnWZEJ0eFrE0U7MbmUIaGaCnksLLY2ziDPQe2pUbUUY+mEbb2UnCZwv42U9Xx4UYbIGPpmA8jFuTumixdN7YowngI/9TlT6OfKWKHpVXt4ttzh6qccgDaLJZnOLQASxAsDKS02BovLTV4az+h5Ns4KE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161346; c=relaxed/simple;
	bh=zmEdBOdXrmXtSYUu4wjBgNzGVLwAKIKn1XGQnjaeWd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Jo1yHKPAeyDZY+2ZZgvttYJtu7AHVyKQ1W1XW4MQhqGsbPZxqpciUQQUi6yB66Tp/BVpSS7BWk4N362488wmbKnVkBf3zt3eDvsujAJsDFCoqs9wolT3VH5urBqEdb/RFwgs4348lNqfR6W4ZkaKIydqQ38/WMi3PwLYs1JEfTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=S5/shLZ+ reason="signature verification failed"; arc=fail smtp.client-ip=40.107.130.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GePwEO8dAgQBsOAZr/JjlRiT0EYu5rOGj1vqjQ1fpVHq1pILr/aUW0/m4YAW4mC8cNbqH7hQAIJ3m/HOvRHADsLZKGmZ1Loh+MniZcDoycYizDoL6oHbhmSj9QWQT7egNMcM59JAryL5kZo3ajuAnuDcj35fuZa+JRrxpfIm5uIJ/+R/Y96mi/jPcCIA0SdMV6HA5uMrFGcbeD3v8MpfwKDrAWr9iStc6T4jdJX21O+rs49ibMnEpbgRwPBrUymKVucZo45vy0sRrgoQs2ob2n1wKMkVZ16ghmixtzz/w1We8jhqlcXQCpgjPzCc4HKl3yRod3KegIE9J2nQyqOniw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gjx70aNsAz5pBUeuu87oLz+n5LPUNkJpjJs6sUAapG4=;
 b=Z4RNA6eubhtfXY469O/tlNpJPQJf9YuKBD3IV0TwHjJKqHgBeQZx7/N+sXycaoFrrFUoqqwXPx+k/d2q7MJhdXo735ZwZRiEuNGe//O8EJJ9XCwQX4vlgA+9L1XB8Bsv9zV7d6E6nbgBpl7mM+/exBO/xVQSt9qTp3kWldluvKUP0D5uE2lZa89+OnyL7tXUht6JNG/N8qeLCovD333U7ctRAn0v1hWbwRGJEzXFY3onLm8+gaX/Aqe2tP5eTjPuEEhVl0vE1fHZfLgo2zBHMYqWcW+bFGqZZG6yX109YSiopI36SviT6c+CZQFUOQKHyWWUsopWiiZT2OrXryRiZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gjx70aNsAz5pBUeuu87oLz+n5LPUNkJpjJs6sUAapG4=;
 b=S5/shLZ+ci05spD9pW2M3aNcBQybVUqGDb7s+aBsg+Uw08FOamxZmJcdJeTZySw+PJowshDb4322s8cIoFD1FyxR0ulbgsuKOA1BsKjhBkf4s5IuswwgbV2ZJTe87gaZzKB2msPsJf8rrcz3GElWCPe7gAFCF09YqdG/Xm6nD1DCKWuFL/sMN4pZV7+wIBt+P5R3cA0apf1f3f+L9On3mcRNyeicnGXFjN97gIRlH9rPh83heNyAMxJeU3/4RUnwf6zvPMD20Rb6d7Ja005oTPIIdVAhrXvWhiLHKxiStIHbSPmWhQxGxjvnhD7F0mmEC+mTeqwv9XicOmLWGWc6tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by DB9PR04MB9498.eurprd04.prod.outlook.com (2603:10a6:10:360::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Mon, 29 Sep
 2025 15:55:40 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9160.014; Mon, 29 Sep 2025
 15:55:40 +0000
Date: Mon, 29 Sep 2025 11:55:31 -0400
From: Frank Li <Frank.li@nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-iio@vger.kernel.org, Carlos Song <carlos.song@nxp.com>
Subject: Re: [PATCH v2 2/4] i3c: master: svc: Add basic HDR mode support
Message-ID: <aNqr8+ehPehq41gw@lizhi-Precision-Tower-5810>
References: <20250924-i3c_ddr-v2-0-682a0eb32572@nxp.com>
 <20250924-i3c_ddr-v2-2-682a0eb32572@nxp.com>
 <87seg5i810.fsf@bootlin.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87seg5i810.fsf@bootlin.com>
X-ClientProxiedBy: BYAPR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::35) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|DB9PR04MB9498:EE_
X-MS-Office365-Filtering-Correlation-Id: ca098363-2d7a-402c-96c3-08ddff70a330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?gp8wjPUhrt1isGwd/t7A2F8ntzNpHiwLOT7c+KetovEUIbKXIE2de8hCgT?=
 =?iso-8859-1?Q?eA9zwERR+z5h+hc03ryDCGr8n2x+sQBs2IvZKET4A8+6hw+Wc+fNLugxOw?=
 =?iso-8859-1?Q?qqbKELIq/AlEvim8TTj3OqC7dm2HY7lxxSklybsP46pogotL6PBlSDX45h?=
 =?iso-8859-1?Q?L+rVEQBgteTtGEdLAQs6JiHKz13GRizDUQt5us5cRxv+TUO1UixkKXwuhP?=
 =?iso-8859-1?Q?pSzA2gmidUQEGvGU2xaI7a9j91P9/drsJcm3LrzkLqjCtkGjgOqtEdVCOt?=
 =?iso-8859-1?Q?DFsDH+RQzokRdVHoA0PP2WAMGmUOU1u1XzvPX+DXN9TNEiiC3hfcVTJwdl?=
 =?iso-8859-1?Q?LS3DYRUIbg7M+cHBQWWkVvnBUN9rC8sRnYd9qUIhZn5ROzB058bov7tq30?=
 =?iso-8859-1?Q?Yf8cD/oDI9DFpHtR9DBTuPDAcFNHe0FAzeLOxxNupktNY5fPG8SoVtyqie?=
 =?iso-8859-1?Q?b094TFidTDdWboaQtKvYW3UDfwSUc+PZ+s2Qx8cmeK+zclz98IIcn7J+o/?=
 =?iso-8859-1?Q?45/E1N9F+dp+tkxBH/KmYE233TLJBZ5JjRopx4ETL+rgF0+ZW6CP+sLaFb?=
 =?iso-8859-1?Q?ScW3dyfPwrO5pD0Rctl9M/uWMBTKh5dYp83czMu0wfb//J/v6xtA+Sy/g0?=
 =?iso-8859-1?Q?dlDK6Ju2LJkCmBpeZgl/MF3YC9e5R1WbXsFw1vOkCCH3mSiy4mvC6BkQJH?=
 =?iso-8859-1?Q?IHNoIM/U8BR3WuHRI9jzpQ7AhoiRyJHjNw6Qs+TWw0YTg0ZgMrm5bGQ8Cu?=
 =?iso-8859-1?Q?yL2HFHapUo51dXWQ4bszw2QDY0Q7nwoGNXve/vUbSv/ex+Tj04mL6y43cu?=
 =?iso-8859-1?Q?gfo6A+PZDBlqO4jqC733CCZSrBnHDnHZzi7gpdfkIwoqJ64AwRRWFiJW5B?=
 =?iso-8859-1?Q?CetLtLNJJtsbf1KJhLIIKQqHJhTjqubuK5qNrrd9C7idGuRliYZkHmj0zF?=
 =?iso-8859-1?Q?1pVE7tU6PuVU4Uiozw6v+mghVMb9NLBB4TrUFNVEVl35XFJZ1QPJi7IV1s?=
 =?iso-8859-1?Q?pbBsA/uShpMmFFHYZaD6X1jTWk0Dj8uBLYuXZH1zXNukNxXyqDNntGxQX2?=
 =?iso-8859-1?Q?FZB4Tx6x0rOR7wYHewi5qE9Xz0zV89WXRp3shwh2+4vCkJmsk3+aegUjkq?=
 =?iso-8859-1?Q?c8q1Gnl8QowSvQ9ZVXjL/cJa4HYal8y07pe2Yta2OPunOWeAqOC3sff0vZ?=
 =?iso-8859-1?Q?N6Zz7neJXkFV5WTRPRADjtXPW1Wv87hwq1ugD9H5bbBcOkQc/0FP4r5LBJ?=
 =?iso-8859-1?Q?L5Byu3AxpKSlLSLHLRnAmLuGJMoSzmZovOKshqSLPwHUoPVOuFUGdF0fgz?=
 =?iso-8859-1?Q?8x29Vob/ZikM1MUKTU84TPnIrW6UqS7BDbClwIyVsnk+jP+CvrFM/geII4?=
 =?iso-8859-1?Q?XM6B4Q8WBCFinQvH3WI+Yggie/zdsIarlO+8KGh7du2SP9mruQP8al6DMP?=
 =?iso-8859-1?Q?nM8kZHNESK0h9YAejXOjcjPgxPqaWpLufBY3hB/sbmfWQhaM5XLQDRRauU?=
 =?iso-8859-1?Q?6xCD7CTsoteIINQdDnS+6etjIK3sKVz+nfW3VS1I9wLqzZkltwKdaCF5mL?=
 =?iso-8859-1?Q?zVaoMmKL6r2dSkqllhzgw9qrop8E?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?8iFA0cspuBg9gNQBc53hqrhmU56sIzLC0Ph6s7Y5vkC0S6GJnysSqkvUCg?=
 =?iso-8859-1?Q?f9G6xELZa+Z5QzVhh3Oa0YZhOx+kI3Mr1648i7dXZbMDq86oWJclGt9yzi?=
 =?iso-8859-1?Q?Z6hsAgxQtPTeex+4QV851Lg2GMdDcBfjGoCuIxpyevZNgS7hzdlyKgpchq?=
 =?iso-8859-1?Q?Y978YQAQ+LCcS4mFLdfMYjfaK/R38scSu5EVJcJC95XXrK/7ZrDLeJzWpk?=
 =?iso-8859-1?Q?Qxd1cOa8I7vPlMIKLaw8tuHklh/dNs0BSbaU7l3CNVwXVAi6VZB5oPizxL?=
 =?iso-8859-1?Q?S5IPngU4j/8nePa0/TlJbi+GLT92t382YThqtkt21oGpP1y/d8zEbNH73u?=
 =?iso-8859-1?Q?IAScdRhTDYaA34J6Y8pbDfgEfXY6TbPicHeiiYt8JgV8Vju77Mymny+A2M?=
 =?iso-8859-1?Q?slXut1ss1MDjm72jX1BTI5on+azwn48IUpQPtI68fHQJbsMN73JsKs+iI7?=
 =?iso-8859-1?Q?GJc6BeeArt4mnm3ZtfV2Vx9AARyGtwe+x4yhxUFmvTu1ZcbRfvN0jBzRAI?=
 =?iso-8859-1?Q?P2IjesV2q5+W820VE1OzNSjWBcQ48haEc/cLnXq9qMCn1/tdYLQos2lfEe?=
 =?iso-8859-1?Q?WyaMoFZAfnJ93w5eJFHhBp3nccsI4WGVUYuM8DwnKb7nCAOg5od4E1Vmve?=
 =?iso-8859-1?Q?K6RISsEwXk9UInkfpTsJ2Igl+DB7/fLaJWN+4fw8zBVpuImzuK6wwnFt8F?=
 =?iso-8859-1?Q?lrJ1w7r2hb8JNb4CM2uMuOu6BNe1PXkOh879LfbsUdXgcHwM0Bti3ZFHcP?=
 =?iso-8859-1?Q?ti40Tx1ETInX8BueVf5RqbKyOWFS+ZcxBt8TbslrkB5xdFixjSIimhifOf?=
 =?iso-8859-1?Q?cRfPzfeyH9HwAZzl2PgCv7F3uXG1aSJSnUZl+dzXq9u9r8wmo7rmQc8T5v?=
 =?iso-8859-1?Q?xvdGRjmdqKBD27JFK98eNXDscf3XJ8XbyCke0icjAfT7wa25EPhE5B7h3S?=
 =?iso-8859-1?Q?DxG61HSzda+LaKHix+vRzx4qaMygmaf43xp5TkEN4ZEZq47c6hLMHtLdfY?=
 =?iso-8859-1?Q?CjQkeRwNdaJ0WrJDBIGswgz21MIx6Apj8/8hpNddmeaezp0nOZ0i8e7eTw?=
 =?iso-8859-1?Q?pKo2W5uSevu1A+2Owfu0CzxcD1Qb1xbb3BhBFmdpzgNg5BeHavKahUwYtR?=
 =?iso-8859-1?Q?TJQgtpmyoGs2AfrMUJ5YhzQrz2XND6Sy8wOEJP1gkCBuLBJt0W+Guu2arK?=
 =?iso-8859-1?Q?/FhxIemuGqyDUcJJdPbGUubUAqYaUw9fCPHsZjYydbWuqA6tol0LwOdsoS?=
 =?iso-8859-1?Q?NRJto0rJ+Ij6RDH9xMz1LklaLbCPIybKD2IouOldkQv1p3eg4IpSgtbmHs?=
 =?iso-8859-1?Q?EihQYsbfWm4Jfri+aO8hcPExEBUw2k0/4FMaGn95zE8SVdw/IhYNB7jV/M?=
 =?iso-8859-1?Q?mVTu8lBhMSvDDXEwZ5MjK7rclWGfftLexxiZMuECFkiaq26xrxtFoIG5gP?=
 =?iso-8859-1?Q?bHCa1fHy8ZXsxKSCs1igJSN1CHmQvCVOQGXSloWM4N2TeCr39mDalKlrxM?=
 =?iso-8859-1?Q?8CoIqlWb/EX7kxbyUD0pQXJcabva8PqGDPeoTRCBlJSwHRZvJiB6G336IT?=
 =?iso-8859-1?Q?7BoEEKrR+lI0vlhocLPqaKY8NAB98odpeI1IsMk7clQnlo3WNIVOM++CIT?=
 =?iso-8859-1?Q?A0OpS8FYkJF2tXJPjBtNWvIqlIm3prac1/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca098363-2d7a-402c-96c3-08ddff70a330
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 15:55:40.2475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w3usj7mfXi63Vpy4S3+bxSDdXpsw7A59rD1MQZB0VC9PvzxvlAS0txr3QDbZyXSJRjkFRM09hRZxz+j9Lj5K7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9498

On Mon, Sep 29, 2025 at 05:38:03PM +0200, Miquel Raynal wrote:
> Hi Frank,
>
...

> > @@ -1858,7 +1913,7 @@ static const struct i3c_master_controller_ops svc_i3c_master_ops = {
> >  	.do_daa = svc_i3c_master_do_daa,
> >  	.supports_ccc_cmd = svc_i3c_master_supports_ccc_cmd,
> >  	.send_ccc_cmd = svc_i3c_master_send_ccc_cmd,
> > -	.priv_xfers = svc_i3c_master_priv_xfers,
> > +	.i3c_xfers = svc_i3c_master_i3c_xfers,
>
> Didn't you change this name in patch 1? If you kept both naming, it's
> fine, otherwise you must do the switch in patch 1 as well to make sure
> you don't break the build in the middle of the series.

We keep both API for while. After first patch apply, I change all drivers
to i3c_xfers, then remove old .priv_xfers.

Frank

>
> >  	.i2c_xfers = svc_i3c_master_i2c_xfers,
> >  	.request_ibi = svc_i3c_master_request_ibi,
> >  	.free_ibi = svc_i3c_master_free_ibi,
> > @@ -1947,6 +2002,8 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
> >
> >  	svc_i3c_master_reset(master);
> >
> > +	master->base.mode_mask = BIT(I3C_SDR) | BIT(I3C_HDR_DDR);
> > +
> >  	/* Register the master */
> >  	ret = i3c_master_register(&master->base, &pdev->dev,
> >  				  &svc_i3c_master_ops, false);
>
> Thanks,
> Miquèl

