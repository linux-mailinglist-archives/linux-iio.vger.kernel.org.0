Return-Path: <linux-iio+bounces-12166-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4159C491D
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 23:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46389B24844
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 22:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F471BC9ED;
	Mon, 11 Nov 2024 22:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AiAGiDhY"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2051.outbound.protection.outlook.com [40.107.22.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB731B654A;
	Mon, 11 Nov 2024 22:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731362409; cv=fail; b=c49zxHX1meHVoENE46IHMM88I3m6j+LfKBnNBjIAUb5q67ABgNSWDCfX11Gq282hhe5YBGwwW5sYrpjFR7swg1YqtCv4XQNjG4jmFQUss3rqeA67zfEDm3VLNuM0KPwk3bCLDr/CoWYTEwtUr3gwrwm1AT87TLdfagy7vNANKuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731362409; c=relaxed/simple;
	bh=FFGJr08QbUH77iRYXHLZw6jy0LQbBzLG89bnZrMoR60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oyCRFVKqNqmpzKNB8gCs0HSNo2b6txpD3vpEdfXcDgyE4UpsI+/Z20EGvpYxjb4C0hlRib+rWP0V3xUfVoGm8m28xdeD1ljWgbrGRGQtqYkGb4OtIYXci5irAaJGIYl0uc1WdHa5PE7DfspZaLOh8GzEv5VJJI8vxsK6S2MxOSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AiAGiDhY; arc=fail smtp.client-ip=40.107.22.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SdULudpxprT+lxncZJ8wqEhIFlzNTspDFsc8q9Vkl/86OOAFu6GOiv9h+RVnXmyqunNxyMXOMjzqwzMBdSgrH+fCfn89YF9Elyesj3SFtSkhkB3KqhWayZ0HyICodUgicWnBJ5NKWD5WwwvJDU699wM35LPb502N1p2p6BejrjuJJmJaEBAMv2rSNrNdgWbF+gJfZeA5fpggsJFjvR5IeBNfbDBYF7xvhjCZPC8u+MevmNNVwGWEjjSHEg0mrqtBhZK228uuETufUVLETm+12cWA8WPHg1+xKL4xJfW7GE8+lEyT7E+hbe5raCYTN1pgiUM2nXJ9XamLzm8qGe+fsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FFGJr08QbUH77iRYXHLZw6jy0LQbBzLG89bnZrMoR60=;
 b=pklY+LZpGVMLqJdeknF1piBAzy2oneM3Yt6v/Uehi50b+ga+QlD1dbGbHic38vtwZWk0c1tK7vzftDBVBE4k1IUz3T5RWCS+XWxGUsNnbY+LbgOccraxMUjPS6arSJdUuYToaLOsJ96MzcbzUx3uxip5XNuPYjAGWFNUh/KKkJQVQove1rxTEyXo5xhOfNOWqkGGG5vx0TMIl+jQi3kMZEESKRTgoZvVygkLDVZeS5OhvajmuIY/RFQ74k+DmuitSnWZYvSG15i3xlDIajMdWXoAbLVbYOae8xatn1SKUZ6EQ1XithMQcHxIOIa1pTWoeH4kIhc4XCejQcWUBXaUEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFGJr08QbUH77iRYXHLZw6jy0LQbBzLG89bnZrMoR60=;
 b=AiAGiDhYwCmXNF5/PbyGoUqDnn3x00ZeSaJGtLS2ic2x1zvYpexqwZkqf3vDShurB5By3nRCzL+zK5PfKIRWcjvhaBp0q3HSvgXUIsXBaP4LLJ5qmOXyfAxcYFi3iO9X9T7dNVrZn7Cmu+vdUI9hUrxH8KAn0EY1wBgIwalybhv2BXISkKFVi/Gmidj8+Mpp+gJL0QX7uQTO5gc53ycGpdk/ettbUHKEjLGjpc5gFGkd8z2IQ/PGsHTrbwdwID2GoPlkVblL+askMC+9GA+1vALegdeBVo9fsgoF2ii6DfRKYQ9e2Ds2fxnnG92IapzCpCt8NPQios2Iadg21fpjYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8192.eurprd04.prod.outlook.com (2603:10a6:102:1cd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 22:00:04 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 22:00:04 +0000
Date: Mon, 11 Nov 2024 16:59:55 -0500
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
Subject: Re: [PATCH v3 3/5] hwmon: tmp108: Add helper function
 tmp108_common_probe() to prepare I3C support
Message-ID: <ZzJ+W5XAGa2tJXaa@lizhi-Precision-Tower-5810>
References: <20241111-p3t1085-v3-0-bff511550aad@nxp.com>
 <20241111-p3t1085-v3-3-bff511550aad@nxp.com>
 <d1221ad1-2705-41b3-9dc9-05a3038e0cf2@roeck-us.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1221ad1-2705-41b3-9dc9-05a3038e0cf2@roeck-us.net>
X-ClientProxiedBy: BYAPR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::48) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8192:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bbd545b-3fb4-45f5-7974-08dd029c3296
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M24PRYGuOM7lRX79aREOrgcha5rVYCIMGpCBG7Key/ZE3gYj752ywjO1yApB?=
 =?us-ascii?Q?FP6sHlqTo6hczawJTaClxrsnr+wTBy5UKj/SDWLjhCdZ4ANAbkk0TWIqfhc4?=
 =?us-ascii?Q?SOuYGEPc0ofhWN87fIe0939eX3IyDMR7+7Zu7gzDWartaiMMR887x/FWa9uU?=
 =?us-ascii?Q?7cJxdOAL+bgocoMvmvMId86CIThecyYtKsiBOaOktViFh5SXQ3mXNJdJQQj6?=
 =?us-ascii?Q?3aY+0Lf7tpsK+/rr2sC6v0gqFbDDokzK0P8QGpBBcMLHzamPKtZf3aV0QiO7?=
 =?us-ascii?Q?Zbn4rECa4QM1kgfw13utjDPub7m5hxVIYQ68Qsg+X8H/HCE2yQmg25ckmDIR?=
 =?us-ascii?Q?TKQ04GxdNS2a8yh755EyrbjtgoaR4kBBruHAJyK3g1H5xY9s0U9PyIkKkAYp?=
 =?us-ascii?Q?C95knQQw8WOhpON6qBVz3O2NJ/fGSYhM9Wj4l3cKTS5iiJGl+TeceogU7RUC?=
 =?us-ascii?Q?pfHqljQE1vyLKxaUfjNMz03aWLjrfRC0nZaSZ7QJnGzYQw3Aatn8ZcF8A0Wm?=
 =?us-ascii?Q?dBUikod7gr++o9IBz4qnv1/lUtWyn7nBoWVP9n8HtrbzCxCrLnHsgBofrq+w?=
 =?us-ascii?Q?E1PuMzc7cFMQ1s5olN0gXwDY+jP5UTwWAr6ADLx2tjYG43kMsJtTIa5sW105?=
 =?us-ascii?Q?78XQsUh4xl2eLg2wHrtPT6gcbP2s51MZbt4+YK3++FXnXx85kv2W0Q8OL2tW?=
 =?us-ascii?Q?2xVOWDcX1pMDEgHAng+ebHeaGqjk2UWlPXH8NLiUKhKqlBeUcsFXqXatsaRO?=
 =?us-ascii?Q?H9GLXVKLWdPdMRywN9oc174TdfiYBUAp4BB456kaewO0U3QdqmViSB+qc0Np?=
 =?us-ascii?Q?IQl4h7xrO/KgdOdy67B2ZKomDLbVIxCv7KRDyX3/IO2ou6fVBNpXs8iR+Tih?=
 =?us-ascii?Q?2ohbvTuQYsEleu+xOsKJxWXnZiTm54UgpAdimlx8FanLV4dzyBzQgzsnbZU1?=
 =?us-ascii?Q?Hk16iOTqsrM1klw0h3Jh2KK8yKDeXVzGZhA6CuV/xlezoBOMRHb7pjJY4UVu?=
 =?us-ascii?Q?V++RnjF8evyght0lPzxaIUaNpmbk5q+phUECM020gHEn2BaxvOUfQifVUB0q?=
 =?us-ascii?Q?FHSNA/eupW8D90cLAGCus53/6JzMMT1DgfaFnw02otukYwWXpSlmpdsLNVSA?=
 =?us-ascii?Q?xGO8BTN1YkJfPCEZP3kUNjkbLl3+B4LcYQUAkBany0J3sIEGIaVcqU/0KDV0?=
 =?us-ascii?Q?RMuowVpWA/g53u94LPzNd4bk3fu/7Xhl0hxBNsvEOrSr+G22/iTKz1+r4Hw+?=
 =?us-ascii?Q?N57wXYJTq3bEbbUA1bbaqONiKkOlIRmmios2VtiUtU1f8rCOPUaBm0UMEVpb?=
 =?us-ascii?Q?35EThSDEXewy5+6PJJfoc7aZ9GeJAlp04/qABT/GnMnYoIpiu+3fdNibXcwb?=
 =?us-ascii?Q?uMj7muw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kfjg9tbFHQoag926pW3IFGmpaxz5ccMOTQGVc1a42jydIN92cOYj5OZ8RIfI?=
 =?us-ascii?Q?rO+hBINKsNC1q0PUA91+FGe3qRlTGVtLpSFtrsgnZriFuaYMXEFcg95054iS?=
 =?us-ascii?Q?lSIRFQ4B1qhN543/gx70SFZJb+w/oNy9NixODSfYe+ZQHhzmzORydzFbiVGa?=
 =?us-ascii?Q?ZpJq1GOJ7rx7ak2PKrOWKSqe5RA6EnXz5ZHjnXmk83/lsdNp7H+3pF4HlXeS?=
 =?us-ascii?Q?xwKmhmTfbvLa2int0PanubrqDbVPrYkafXG2hczMH9nw+KVMISdC687GjjO4?=
 =?us-ascii?Q?jh6TxYAwPSdoxL489UuZRNilIiD1R2NBjzxmad1F4idLBYOKSE3xLgbRawbk?=
 =?us-ascii?Q?STeYuUjIwdGmEc8sTmxEydNSucjGM8EhVZWno2BRFFOF77wkmnFVw9pZ26i4?=
 =?us-ascii?Q?7ZC9sGJC+eoST3le+ZOYehV3qGjDFyS66uvJmLOKlpcLOmxiEOgNb6NGEsKB?=
 =?us-ascii?Q?9vYEj6r+D84yGLvylVFLNPvLkOJ0Sm5m6yyr5OME1VsCGX1KLZjNijrIQGf8?=
 =?us-ascii?Q?3kb88y7NOz2EUw+ZPdohBmyHygxMo3OCFotiW6STK9jDUPNRitkVr4th5Azo?=
 =?us-ascii?Q?ibRNcaH2m/0Aiboo8szK6UiSDaDpm1erX+PH3nVBJqjy/N8kGURnMcTbqy9a?=
 =?us-ascii?Q?983cRTPgN9g7laBpVwvOLHrq7bgbOMLrQVhIvQKRgcstmZyvmzY/qXyHqgD1?=
 =?us-ascii?Q?1Pur6ARq9yPtEUDOeRK3ENXjM3XU9UJKBiT6/TtgW0y8AB9vEZz+/wv+Gl5v?=
 =?us-ascii?Q?vGhgYz7/WivT82doj2lap05i/+likY7Qf4JtEIgpydG8Nx1ut2kqBRb62dzr?=
 =?us-ascii?Q?aJGPo70K+qk67pYecEVcIJhJQ6rUJvxOYDDutKp3R253jm7rVFM6JOxK/nJR?=
 =?us-ascii?Q?GJu3E6/xK/czBb+v9q9YjCIEVavUdajZRera2hv2PO3qmRS3+mP5+NJnmdb3?=
 =?us-ascii?Q?GvJC5ZhJ+Je4uBQMVFEYYgcKXbf2NfA15Ohzh6FoyLOIgEFfuC+qeMWJUUF5?=
 =?us-ascii?Q?aY3vlMMvGrMBy1H0bFyzxgmes97H1r/L81TScG1iKy8swY+gCLPszn5dHy/V?=
 =?us-ascii?Q?8D18xxlRHgyEQnggbAjTnJXNnJbqD4eO2hWJAKvU/wlWx0UkR28XKq8QJ/NX?=
 =?us-ascii?Q?EKAFFeMEThb8nqnmcXm4qCP+fgGKGYqQxgW50C8ua+ofIgK4tK8I09POOePS?=
 =?us-ascii?Q?H9WyjLHVdwZ6AZetqhWnFtFj6eznMLc/a0OQPEroUAWnG6/voHwZmD6KK8y4?=
 =?us-ascii?Q?KjXh88UeAYF61rFmyfCoL3gFCIaeEX63dJbJ+WhEQXWERbEhsFpPG5gFJ39f?=
 =?us-ascii?Q?uLt2BhQ2T+vTDQj0e7ttYzzkg4JFV+mh7ljQ9nY665kcwH/i1safeM2kNqhK?=
 =?us-ascii?Q?EZgFsiHG2+aELyS8C6AdRsY8bxrqXEU1AUgR4nM9DyURmnUdxk6D321di7v4?=
 =?us-ascii?Q?wEWzbEI0goDuHl8WcpvZmstuo76UTnodW+wvbepRVed7cQwNHXQNjUSGWOeE?=
 =?us-ascii?Q?nmRJbobSq/XVU7DCajyL7JgB+F6ITRku6nKXQJpovUdDztLTmm5+bmvlJQHl?=
 =?us-ascii?Q?Y1RgmSFyKnaa9d404wg19h+KNUCjibXPrpnYzHYQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bbd545b-3fb4-45f5-7974-08dd029c3296
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 22:00:04.5644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EUpkiiiR0EWqU7u67ciIUQ6uNfb5sab/QZGdz1C5yJx3ID87Z9/RPxOvNERsoo8bSoEuRrhHpwESY+ETN2AQ9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8192

On Mon, Nov 11, 2024 at 11:44:08AM -0800, Guenter Roeck wrote:
> On 11/11/24 09:32, Frank Li wrote:
> > Add help function tmp108_common_probe() to pave road to support i3c for
> > P3T1085(NXP) chip.
> >
> > Use dev_err_probe() to simple code.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
>
> I applied the first two patches of the series, but I am holding back this
> and the subsequent patches since I don't know how the kernel handles having
> two drivers in a single module, and one of them fails to instantiate. I did
> not find a matching example elsewhere in the kernel. We may have to use
> the method used by the st_lsm6dsx driver - essentially splitting the driver
> into three parts (i2c, i3c, and common). That would be overkill; the alternative
> might be something like the approach used by module_i3c_i2c_driver(), but with
> a set of #ifdefs around (some of) the i3c code.

Thanks, let me think more about this.

>
> Guenter
>

