Return-Path: <linux-iio+bounces-20676-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10883ADA028
	for <lists+linux-iio@lfdr.de>; Sun, 15 Jun 2025 00:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F9C01893308
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 22:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD34E1FE474;
	Sat, 14 Jun 2025 22:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="FMZV+Yw/"
X-Original-To: linux-iio@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011013.outbound.protection.outlook.com [40.107.130.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8D61F4C87;
	Sat, 14 Jun 2025 22:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749938760; cv=fail; b=iaHycj3Z6EJ3sPoIzEcZb8LRFAcUnRxZu0y8gxIppkDZLaepj8gwqzfnF6AWUOF2hGmxRt/yBaZJNDIXvv3bw9xfRN+TZylw+cvMiyMoZeV4WSVA8MvGVtc5D+g+J93cowojmq8LTDgw3NYxNO8kXklSSOJGQAuLaC+Z5RNWg8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749938760; c=relaxed/simple;
	bh=lw9y1RB55ovq5I5cNNsBrDVqrXJFdSmlCQj/BEr9CKY=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qu5+SCAfNq14jEeyNNiwJRBIICpswhV3ll6SfQhN3Rr/4OSbVhJDY83Y6J/ilDwGTab1HpRmlnnw6nTeIzVuZ+8L1GfwYNY/OXvsUJx6j+gcKgh14nJWBZzFohsdci/y/Mc5i5DMVkIUHnypeMoFeX9qIFOUFd+gopMjBs0ssiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=FMZV+Yw/; arc=fail smtp.client-ip=40.107.130.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o/i+u2mOBmGMwaHfCpZUcmUWHjEyCGnYuW/pxT6BGe3JHV5EXObJmDIEjbpdiN1Go6DlpbrnFIiw1NJTE31fgOlxAJZLluKqGVt8f9RWaAACjoz+uHSZP32WnPVBWqxIFejJLp+pbn2NohB7tXaCD+rZGadZFVRwpZ+Ova/S2ynA9rKDjjnqq8EjUCsay1w0SvbnO6yitktRDsxbCf78QVybTJJUuP6osXC58yew+jAXW63SF0ogQEM+UqeeDVeUfDHyxuOlYhhj8FU2sTAV7HlHZkxibb2oFjRkNQUqqpEMUtzrAyvfwMJzVwpZ841Qc4BQn7Xsh69cpypQSYCsCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Smyir04yqryK0ieEx0BYnnQFFN1SNAENJX7sILJSthw=;
 b=X4tbGIT7fLZ9Xf4yKRwnAl8z7gNrcKjZSAxSlJPbgs5D1ebcxJh6gKUd/NsaV8ynOBFS+JsPJ7WENC/AL3z3HRIbLOwetvNY/qyEIYbEUtatnIVU4ULZG6qRUW1AUSxhc5R2RyocS/bWWrtxOjQxW8sJKZUsSJ68kbOfPdoP3Tusu5eHaGngwV0g/4isB73RlwnNynX/166UOrJHB7lg7i2NCJ9nA5OgAg25JyuLYlrAjscaT4qby3eYFcDzjzqVop7A3o8ytY2ki6VjURrtwNWTtyrQ/S9Sng4jCjlHAan1+ZcqWELaZ1mZP0RqIbffWdI2GwvufAmZmLibe4Swfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Smyir04yqryK0ieEx0BYnnQFFN1SNAENJX7sILJSthw=;
 b=FMZV+Yw/1TP4GhGUNju3AGvrtDnf4b9054/LXvBcjn+xW8XdHGJPvpyChVMtaHTF9sWiZbCzO3cuWU8XIE9wWtufaSjF8f9ByxeyRVrZLtqk4LcXri0trJFbirUccXSQ/gu6xBI60C0m3KwgX8u7yhuTccJ3rPfTbtL+Kat63jI=
Received: from AM9P193CA0030.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::35)
 by PA4PR02MB7022.eurprd02.prod.outlook.com (2603:10a6:102:104::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Sat, 14 Jun
 2025 22:05:54 +0000
Received: from AMS1EPF0000004E.eurprd04.prod.outlook.com
 (2603:10a6:20b:21e:cafe::f7) by AM9P193CA0030.outlook.office365.com
 (2603:10a6:20b:21e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.26 via Frontend Transport; Sat,
 14 Jun 2025 22:05:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS1EPF0000004E.mail.protection.outlook.com (10.167.16.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Sat, 14 Jun 2025 22:05:54 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Sun, 15 Jun
 2025 00:05:53 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>, <kernel@axis.com>,
	<linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 3/3] iio: Add driver for Nicera D3-323-AA PIR sensor
In-Reply-To: <pndldqwiihi.fsf@axis.com> (Waqar Hameed's message of "Fri, 16
	May 2025 19:16:25 +0200")
References: <cover.1746802541.git.waqar.hameed@axis.com>
	<c5184074d85b68ca35ccb29ab94d774203b93535.1746802541.git.waqar.hameed@axis.com>
	<20250511131432.1c6e381c@jic23-huawei> <pndldqwiihi.fsf@axis.com>
User-Agent: a.out
Date: Sun, 15 Jun 2025 00:05:53 +0200
Message-ID: <pnd7c1enflq.fsf@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004E:EE_|PA4PR02MB7022:EE_
X-MS-Office365-Filtering-Correlation-Id: 060b3cce-9ddb-4847-2e6c-08ddab8fa1ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PPLqaHzL1cTTH9ugoPlXRD0NWYMxG6uRBum4G7EH30QJlH6ldQ2iD8Zx0eJ9?=
 =?us-ascii?Q?fW2LCzi0dmiM1Xtcfi1z1hwd0lAUdLBHrrFeKdyFoBw4iLnpjJP7DgEa4gOE?=
 =?us-ascii?Q?UrHCXgQeAG63VUADjIEq+f49E1g14aQv6z1TWJdfhyx1OhglG9ZvIhoZsLmm?=
 =?us-ascii?Q?yERyzgKlb9EOlZ6QUyM5yMh93cv7b3PMsTero4libRKy0nruXlpGRhzrkouG?=
 =?us-ascii?Q?doZLxfYHbNDKBTC8pgs79Jf1aGxYr0MXuJ2EC6G2Mo4Z+cITV65CUmGtHwKA?=
 =?us-ascii?Q?f2AWGrm2zHi8wQU3w26ayL3g69hS3Nf1ewbb4HinF1OeacZyYhvMPrk91T3O?=
 =?us-ascii?Q?xB/bocD9jewsRzUJ3x/v5Z2S/pdEoPNOv272lhVH5RT5qWtyERHrGSmrkHNs?=
 =?us-ascii?Q?NiPAhrO8OD78DhwK38O7e11iyaRwhjc3dPWF5tIYjfqOChc7VO6uCUEiUK+R?=
 =?us-ascii?Q?6COHFXRr23cdREnXaMKm3pUXjUUKgxBwiRe2oksGKjpG8ABC4PFNgVuAg8SJ?=
 =?us-ascii?Q?fN7kvbw4ZzKRLV+7TiJXKdI5A+7ue+Y5SbZMVDzFeAn42zXHxeyYFLdQIVoV?=
 =?us-ascii?Q?N7X6HUE01SYtkgeymG2cJVgMBLZEfS/yiGHEQLxU5HHPHoUU5VAOyHtDsX6L?=
 =?us-ascii?Q?FDjs0wlUmnS5bn8wSdn5h4a0jlBRHa1JwCGg0Yrkz15PmuxWsAf26xE9bn+0?=
 =?us-ascii?Q?jxm54JAOnEnwvMRUDW+EcJbzm5Q8kMYtbHb/z3K9IgcwUk2leONMjokp16XJ?=
 =?us-ascii?Q?oaK/BehqabANNEtSS6L6lqVrZW7aINNWinjAptnjVcD/8LOfkGgv/Mykmm76?=
 =?us-ascii?Q?Vd3LxEp1SFXDZKacJ7s1WyJzxCqgqIsrtAbz2rpAVJISuhf636yhLezvsGSJ?=
 =?us-ascii?Q?H4TJ+w9V1O1kYJIj4lT3eEhCsSQ1CrfRVslPXfGibCAsy2EgGMoIeuDUYi9R?=
 =?us-ascii?Q?6gxAR4AxuOmC6fHVyNEDtbBXzvPZSmeLK/9itsT39lnRaHves2TPe3xp4ZiX?=
 =?us-ascii?Q?ZJlh43UNyZLeSNayUr4ut0bgREuHSPN3DS0vlRwyd2BYA4IF3Ei2yGFvpAKB?=
 =?us-ascii?Q?QfzG/D/yUzFJn188pYwwF6yIWUVGNyu3Va832YzYYcbq5AmX3frPcCFgnXEy?=
 =?us-ascii?Q?v1Am2kwZfNviQ8CXBcV5/uLUqlq1POtv+xE7sH8pnQDEno3LcNXMgwE1MYUW?=
 =?us-ascii?Q?SKg31XCiL3rutowY9i4lNtmS8df0VImX5RaEe87ZTrNOaW8JdF3dzQagIhvs?=
 =?us-ascii?Q?rylw6cY8pftd7KJOhP5ifyUe56m6rTY8a34KSon2SmTd5y6jLegx6Yp9FGzo?=
 =?us-ascii?Q?Vx386kxRGC9q/Sh5f6uWpO2OA1NHR2l+j2s4Fzy66Ib4v/9BKKqN5NwCo/j1?=
 =?us-ascii?Q?7nU+aTD7SJNg/FKRFqrhcIkEjb/Dl0HTn9S58RIRfIyIaVXZ3Ytr/6Uj97Jk?=
 =?us-ascii?Q?H1dAdyWNHoerkcRO4Wt4qf2N0DkyVTBudxwsClvMMJr1kTnAW1Lxd+tU6odg?=
 =?us-ascii?Q?Ul0zpn4y4Ry5VO2enroag6091wA5yWEX9RvK?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2025 22:05:54.1441
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 060b3cce-9ddb-4847-2e6c-08ddab8fa1ed
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB7022

On Fri, May 16, 2025 at 19:16 +0200 Waqar Hameed <waqar.hameed@axis.com> wrote:

> On Sun, May 11, 2025 at 13:14 +0100 Jonathan Cameron <jic23@kernel.org> wrote:

[...]

>>> +
>>> +/*
>>> + * Register bitmap.
>>> + * For some reason the first bit is denoted as F37 in the datasheet, the second
>>> + * as F38 and so on. Note the gap between F60 and F64.
>>> + */
>>> +#define D3323AA_REG_BIT_SLAVEA1		0	/* F37. */
>>> +#define D3323AA_REG_BIT_SLAVEA2		1	/* F38. */
>>> +#define D3323AA_REG_BIT_SLAVEA3		2	/* F39. */
>>> +#define D3323AA_REG_BIT_SLAVEA4		3	/* F40. */
>>> +#define D3323AA_REG_BIT_SLAVEA5		4	/* F41. */
>>> +#define D3323AA_REG_BIT_SLAVEA6		5	/* F42. */
>>> +#define D3323AA_REG_BIT_SLAVEA7		6	/* F43. */
>>> +#define D3323AA_REG_BIT_SLAVEA8		7	/* F44. */
>>> +#define D3323AA_REG_BIT_SLAVEA9		8	/* F45. */
>> Perhaps these can be represented as masks using GENMASK() rather than
>> bits.  A lot of this will be hidden away if you follow suggesting to
>> only expose that you are using a bitmap to bitbang in the read/write
>> functions.
>
> Yes, that would be the natural thing to do when moving the bitmap stuff
> to the read/write functions (as answered below).

Since `bitmap_write()` needs an offset (and size), I didn't use
`GENMASK()` in v2 and thought it would be more clear this way. I'm still
open for suggestions though.

