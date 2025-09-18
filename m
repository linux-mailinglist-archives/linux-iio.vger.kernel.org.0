Return-Path: <linux-iio+bounces-24242-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1568B834E5
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 09:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FA903B2AB8
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 07:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A783A2E03E0;
	Thu, 18 Sep 2025 07:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ST.COM header.i=@ST.COM header.b="WA7PPrtt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA7B2D9EDD;
	Thu, 18 Sep 2025 07:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758180179; cv=fail; b=RAA/8+GDuLxaVTy60l8Vj0Zm4vKUb7ZwJExyymXOOXx6bZQpwagyzsHuvNgJstTdABd8CQzKWs1hJLqzyNk4UaGuIM36w1duYFP5XDQdBrqvTC9lBGYxYgW/WFT67zfiU2X7aYjn3OpJEQdwRD1Rv6NUmWWSQAtR08gbROQque0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758180179; c=relaxed/simple;
	bh=TwWtELCC7luNRCVoEZZperjhGowP1Yf5pLrpFiOqqCc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ch46OTYdAIVb12LmEZ+vHW74RNlU1tqxoTnm3R2It3oMzCLNCrJjL62XXOAIca7MuF8v3FrUS90fHuy24TKUpy8RCxNjYpmiVWogiOlIldJMwRUIPJPy8r4KlPqZUkRK686FNiiwJQoon4Cdbhp+Lvg6Zj7GI/nyu5LDNqpvVoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=st.com; spf=pass smtp.mailfrom=st.com; dkim=pass (2048-bit key) header.d=ST.COM header.i=@ST.COM header.b=WA7PPrtt; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I6vW32020607;
	Thu, 18 Sep 2025 09:22:38 +0200
Received: from am0pr02cu008.outbound.protection.outlook.com (mail-westeuropeazon11013030.outbound.protection.outlook.com [52.101.72.30])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 497fxuyav9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 09:22:38 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S6OomR78e/kiafnJuhSx5GG0a53TV1oRI2ZRFCMgGocrQfivYiw5xLa+2wK4Jk3buBJoxCBgGWNX0DuDknzbMNXPIv0r8gbOXzEcmWpyEg1hcA/YxWPsBdDXVzUw5U1POAVHfMIpzYYnAU8kjMB8eGg2f2jGltktCwuLTyF3b4M+EWH9HOE2DTnmJnka1ncP4ZZyB/0aY+8bQuUFJEgNu5wbP9XPjMBHenISpW5xWpZB6s81uiSg62W0AQ6hx7wc1EgS5FupenxVhx9TgMjk5w0kcMXSnECdm7WUnXQq/lhE8QGKQliKsc5/ObjiLg29mpiABpv0Rp1tKbvgN0bqZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OfEfftbbkQaxo3BQ3ql6jAtM8fgKvYHhOwqSd7ZFjYQ=;
 b=XzTbz30c6qvOlWKKc2e43vddDEjIMETfY1TRfCnBNshzx7v/SOJ4hp7G4ByUa4kV7A02rcfvNtkqSeer3LtGLIf3ctoIU8n42H5shvHdB6jqn2oa3e4SNmdIXy+/CX57n2VJvyn6jwDE5xzVXLa2KpECqQngyyTNfuE98NFaIar/AfQfeT4Vch4xeNPm9h1eDHRFaUhd6K6RnaLBSwGqzHWsL8X/Q/XI+VoxKy2tRlyRjz52WXQi6GofAfnbAofpeOP0lLTi0h5brjjpgLpAxB+f1xcTR3EUPDya6Eoz6hTgPZU1KBApECVVJ2aEAWm9bWOw3ihJfwtLk7i5LvdApA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.43) smtp.rcpttodomain=amd.com smtp.mailfrom=st.com; dmarc=fail
 (p=reject sp=reject pct=100) action=oreject header.from=st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ST.COM; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OfEfftbbkQaxo3BQ3ql6jAtM8fgKvYHhOwqSd7ZFjYQ=;
 b=WA7PPrtt2Ic4lcvxkbQs1aqEdOfoxLmaafnl91wLBduxn8lRA9KnvrqspeUJgWP68uxqZFF9Mh1J1R8W1dHUcpKV2e4CSbGgCH0/8aS+8DWTo5NaCv6/dYA9H10zOpqC7Ft3GFfUaTLwheM5hzC9cXMKoQOH8KwTPRUglOUekWMTe8saB+4fx7QEg3+lj9ZEz25OJnVob1ygXJ/f/V82UC/zNzRjR0ffZS8q12QfMT2kwZ/U50/22wD4pYGf5mpaZIJnKqhJo/h1QvnIn3IiuA18EPfjWmCQ8PYlmL98mSa/hIR/CXvuxz+b8Ibbl6KYFs7B6p5Nz4YbEgeb8PM1OQ==
Received: from AS4P191CA0029.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d9::12)
 by DB9PR10MB5617.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 07:22:33 +0000
Received: from AMS0EPF000001B0.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d9:cafe::de) by AS4P191CA0029.outlook.office365.com
 (2603:10a6:20b:5d9::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 07:22:32 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.43)
 smtp.mailfrom=st.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=oreject header.from=st.com;
Received-SPF: Fail (protection.outlook.com: domain of st.com does not
 designate 164.130.1.43 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.43; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.43) by
 AMS0EPF000001B0.mail.protection.outlook.com (10.167.16.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 07:22:32 +0000
Received: from SHFDAG1NODE2.st.com (10.75.129.70) by smtpO365.st.com
 (10.250.44.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 18 Sep
 2025 09:20:07 +0200
Received: from SHFDAG1NODE3.st.com (10.75.129.71) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 18 Sep
 2025 09:22:32 +0200
Received: from SHFDAG1NODE3.st.com ([fe80::418e:e217:3414:9d83]) by
 SHFDAG1NODE3.st.com ([fe80::418e:e217:3414:9d83%4]) with mapi id
 15.01.2507.057; Thu, 18 Sep 2025 09:22:32 +0200
From: Mario TESI <mario.tesi@st.com>
To: "Guntupalli, Manikanta" <manikanta.guntupalli@amd.com>,
        Jorge Marques
	<gastmaier@gmail.com>
CC: David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko
	<andriy.shevchenko@intel.com>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "Simek,
 Michal" <michal.simek@amd.com>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "nuno.sa@analog.com"
	<nuno.sa@analog.com>,
        "andy@kernel.org" <andy@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Pandey,
 Radhey Shyam" <radhey.shyam.pandey@amd.com>,
        "Goud, Srinivas"
	<srinivas.goud@amd.com>,
        "manion05gk@gmail.com" <manion05gk@gmail.com>
Subject: Re: [PATCH] iio: imu: lsm6dsx: Add shutdown callback support for I3C
 interface
Thread-Topic: [PATCH] iio: imu: lsm6dsx: Add shutdown callback support for I3C
 interface
Thread-Index: AQHb+i+8xK2s1GBMXUK4mOoG9AwzB7Q8c6QAgACdMwCAAK9QQIAAB8qAgAmwZzCAAaGzgIABJMYggDoMRICAFJpPog==
Date: Thu, 18 Sep 2025 07:22:31 +0000
Message-ID: <2fb3ffd8fbf54a6c960e25bce4613e5a@st.com>
References: <20250721110741.2380963-1-manikanta.guntupalli@amd.com>
 <aH4mwkh80TUTNXtS@smile.fi.intel.com>
 <83798680-8e3f-4899-8c58-d7da5587653e@baylibre.com>
 <DM4PR12MB61095749195041654F6D560D8C5CA@DM4PR12MB6109.namprd12.prod.outlook.com>
 <3d7w3rczrdics77nt7lig5rsj2bmfubpwzhffarzlxmo5w2g4a@baewpltdovhk>
 <DM4PR12MB610930805348D91ACAE876A18C25A@DM4PR12MB6109.namprd12.prod.outlook.com>
 <5pmqumpue7h4us265co6pya37434t4jvf3b655gtjcohlyhash@3ggx7e2maud6>
 <DM4PR12MB6109B8CCEBF5D334662E6CEE8C24A@DM4PR12MB6109.namprd12.prod.outlook.com>,<IA1PR12MB6092EC3ADBEC4032CF52000E8C03A@IA1PR12MB6092.namprd12.prod.outlook.com>
In-Reply-To: <IA1PR12MB6092EC3ADBEC4032CF52000E8C03A@IA1PR12MB6092.namprd12.prod.outlook.com>
Accept-Language: it-IT, en-US
Content-Language: it-IT
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B0:EE_|DB9PR10MB5617:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eecb5d3-6cc2-40a4-34e3-08ddf684224f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|19092799006|376014|7416014|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?Windows-1252?Q?V5s1ST+kAJpXmUV6H2K6Ke9e7L8SzWHqRFi5ZxCE4wuLjRC/O8YFr8+7?=
 =?Windows-1252?Q?PNgofFY0JMsxz5cPRGUzZZe4kMaY86gZtIplUovz5U91zxNW7tK9jC4Y?=
 =?Windows-1252?Q?ACDM6aLSuQROGJbMgJNucNV9CaAZgeywgiKHD0wheAVeiiYRELqEimD+?=
 =?Windows-1252?Q?lGwb+7EZBY/QmYVVzDt5cfvU4l8oQsHaQOdprjWfhaI16tugTHGyJ4s2?=
 =?Windows-1252?Q?JA/pbioHrE7GxRLe2dyhU3qy50aNvNKRX76SsAcndQSbtRbf02Ak6+8k?=
 =?Windows-1252?Q?DLCYkms9VjElQF4JeTfWgm9R8SqKI99/dGd9sO/2WiCbCvITPCpJspqk?=
 =?Windows-1252?Q?XZL446xO5ALpOVspAbEQkuO0MO3Erq89CTEetWi5uG0tvLR5IxJQs0g8?=
 =?Windows-1252?Q?SxkUBExeLgpqfyGaw/EJXBYnxPp04Q1ZpHTsQgCuOueAE2BD7sWvPJjM?=
 =?Windows-1252?Q?XlKo1VOQFg3Fw0aC/EaT2MC488vNTGGRPeOp0KkBIPfat+CLOlgdewQ5?=
 =?Windows-1252?Q?//78LKeUGc57xGe7+8lTE6wb56rGTWsI2b5zbsZZGxdawRG5wrxsVaeT?=
 =?Windows-1252?Q?SnicrDaE4OX8xW24iMNmRyYylRvzEGk0lc7JiqPoqhf1NG3KnXLYk2Qc?=
 =?Windows-1252?Q?vWjoQ8sR4NugRzVqS4G0J2b+tG60U7q1wbg7F1lIYM0KjTRafAT6eRyY?=
 =?Windows-1252?Q?/S6cgGO6Vso/BXXD2APnAsKiHHMfeynd+ihaCPTq6QgpwXw2qH4Jwwr4?=
 =?Windows-1252?Q?EfKRNoGJAKKP/0B3c4d+IEF4+BjRG3sAL/BcGBMPaZv7CgGrTHst6p6G?=
 =?Windows-1252?Q?bwceCBIyf+W4WUB2X9+IQbdCYSgNLDanMAGoHVgLDCj43UfdJbSEmd8/?=
 =?Windows-1252?Q?9zTPf6F9q+gv7te5EEHjuz+NsQE4UOJUca0ADzfbTsPFGW4U6Gc6dluT?=
 =?Windows-1252?Q?76TLhpRRPgAmOyk1azYX1niMCUqbmIyJ7qxz09WvCdWpuUF7FEJh7fK5?=
 =?Windows-1252?Q?oVRy+oCICDsex8rCaBGqow9Uac2J/qpR39te9LS4sqc4gDoPp40JA48H?=
 =?Windows-1252?Q?eqbnia+HOcwdffD8QEDYamgpc0zTXtQF6XAGM2dz9uoKMCThLi2WObyB?=
 =?Windows-1252?Q?Zq13KVUpS/NdmLDJpBnHHrUxk0VR+NqLoGfi/JXVWuBU1OcPbhXzwcUg?=
 =?Windows-1252?Q?SAgjJmYctG97RQ5NWkxPerq2rCaIUUVXc20d3vv9nwC9uukxNN4GQsnL?=
 =?Windows-1252?Q?K8ya12muaILgpbULzc1ic/Gx6OqXXLVyogexG54oacwqlNtwZcZrBR6c?=
 =?Windows-1252?Q?7qTa+68ec/V3IvlMaXqbuNn5SjN+hp4rkda2xq2Z51avwZ9iMRRhHICD?=
 =?Windows-1252?Q?mBiw68voxVpPcbbHI9SrI/dSLf8Z1OijJAlCbMfMlnrvkWxc0V4JeTtW?=
 =?Windows-1252?Q?NvX2pHqaPLpSHvp9sGClUwF6lGf1c8ILmUGseBpsOQ8ge0ZLx0u/CnOl?=
 =?Windows-1252?Q?+Ctc6UzdcVQsEYK/WCBfS7LiACF56e7HZTFUteYODeXpVkL3THS662Yz?=
 =?Windows-1252?Q?tfBrELnRQJWCySmMTtttjxfj/bw9ayC097RcJYZvKZ6Jh84BC/XdG4nl?=
 =?Windows-1252?Q?pODIDrQYwX4y/SA93g/+3AWP?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.43;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(19092799006)(376014)(7416014)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: ST.COM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 07:22:32.7394
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eecb5d3-6cc2-40a4-34e3-08ddf684224f
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.43];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B0.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5617
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXxwad+DJzYsrg p6Cwvc5RKsi3Nym1JY/HjTlVZVYXkEdugodH55DyhVyUFkSu03UVZh/f3nyM9SXmjDLYFTqiWQg m+8I7OA9J2ejY+GO2GAWeGM4wwa6Jczp7CHPQD39+r609GR+fZQ3KO0PNS5a4Zq10AYhv1YfZm9
 cy2/3QtnvgPDHham00UQZvWxBqPZlIrXwqk3JgpCJ3Exrtu1071i9IgGfhYdE0FeKU29N+rzxYq P23hvOFH+/JQ6xgEZBbaFitHYRwTTzI/u6jpiUgE6h1PgMQFnGYAs5IHXrQe/M7F1dXbtMUTKpe QZ+1eHkAFgF/NpW6OOobpfgnS7ntMjq0KfaeJ5V/4mTcV28F84CuMX99dnNDzxz1iENvSJxMCax 6f2c6RX+
X-Authority-Analysis: v=2.4 cv=TtLmhCXh c=1 sm=1 tr=0 ts=68cbb33e cx=c_pps a=nf5VWOPwvPMO08Lxccx+zQ==:117 a=peP7VJn1Wk7OJvVWh4ABVQ==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=LPqyBTA0yuoA:10 a=N659UExz7-8A:10 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=obOf4eooljYA:10 a=zd2uoN0lAAAA:8 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=pGLkceISAAAA:8 a=8b9GpE9nAAAA:8 a=IpJZQVW2AAAA:8
 a=QyXUC8HyAAAA:8 a=TGkvw9MNnwvAkiimfFoA:9 a=pILNOxqGKmIA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: a3Zd7W2sXl0NBOkDOdZN1Mrssvrn2s1d
X-Proofpoint-GUID: a3Zd7W2sXl0NBOkDOdZN1Mrssvrn2s1d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 malwarescore=0 spamscore=0 clxscore=1011 adultscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202

Hi Manikanta,

The mainline lsm6dsx driver supports several IMUs, but on the I3C bus, it s=
upports two: lam6dso and lam6dsr.
This is very strange because the software reset doesn't reset the dynamic a=
ddress on such devices; only an RSTDAA or a power cycle can reset it. Looki=
ng at how the I3C master works, the first thing it requests during the prob=
e phase is an RSTDAA, which is sufficient to reset the I3C address. Therefo=
re, the IMU sensors should then participate in the new assignment with the =
ENTDAA or SETDASA command (in case of assigned address). The software reset=
 you perform during shutdown likely deactivates the sensor, which solves an=
y issues that may exist with the various I3C drivers (many of which are und=
er development or debugging). It would be interesting to evaluate the I3C t=
race when the issue occurs and also a register dump to better understand wh=
ere to focus.

Best Regards,
Mario

________________________________________
Da: Guntupalli, Manikanta <manikanta.guntupalli@amd.com>
Inviato: venerd=EC 5 settembre 2025 07:29:18
A: Jorge Marques; Mario TESI
Cc: David Lechner; Andy Shevchenko; git (AMD-Xilinx); Simek, Michal; lorenz=
o@kernel.org; jic23@kernel.org; nuno.sa@analog.com; andy@kernel.org; linux-=
iio@vger.kernel.org; linux-kernel@vger.kernel.org; Pandey, Radhey Shyam; Go=
ud, Srinivas; manion05gk@gmail.com
Oggetto: RE: [PATCH] iio: imu: lsm6dsx: Add shutdown callback support for I=
3C interface

[Public]

+ @mario.tesi@st.com

Hi @mario.tesi,
We are observing an enumeration issue with the LSM6DSX sensor on I3C,
since enumeration occurs only there. During a kexec reboot, the LSM6DSX
does not respond to CCC commands during enumeration.
Adding a software reset in shutdown() resolves this and allows enumeration =
to succeed.

Could you please confirm this behavior of the LSM6DSX on I3C from your side=
 ?
Your confirmation will help us decide whether to proceed with just the soft=
ware
reset in the driver or consider additional steps.

> -----Original Message-----
> From: Guntupalli, Manikanta <manikanta.guntupalli@amd.com>
> Sent: Wednesday, July 30, 2025 11:58 AM
> To: Jorge Marques <gastmaier@gmail.com>
> Cc: David Lechner <dlechner@baylibre.com>; Andy Shevchenko
> <andriy.shevchenko@intel.com>; git (AMD-Xilinx) <git@amd.com>; Simek, Mic=
hal
> <michal.simek@amd.com>; lorenzo@kernel.org; jic23@kernel.org;
> nuno.sa@analog.com; andy@kernel.org; linux-iio@vger.kernel.org; linux-
> kernel@vger.kernel.org; Pandey, Radhey Shyam
> <radhey.shyam.pandey@amd.com>; Goud, Srinivas <srinivas.goud@amd.com>;
> manion05gk@gmail.com
> Subject: RE: [PATCH] iio: imu: lsm6dsx: Add shutdown callback support for=
 I3C
> interface
>
>
> Hi,
>
> > -----Original Message-----
> > From: Jorge Marques <gastmaier@gmail.com>
> > Sent: Tuesday, July 29, 2025 6:19 PM
> > To: Guntupalli, Manikanta <manikanta.guntupalli@amd.com>
> > Cc: David Lechner <dlechner@baylibre.com>; Andy Shevchenko
> > <andriy.shevchenko@intel.com>; git (AMD-Xilinx) <git@amd.com>; Simek,
> > Michal <michal.simek@amd.com>; lorenzo@kernel.org; jic23@kernel.org;
> > nuno.sa@analog.com; andy@kernel.org; linux-iio@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Pandey, Radhey Shyam
> > <radhey.shyam.pandey@amd.com>; Goud, Srinivas <srinivas.goud@amd.com>;
> > manion05gk@gmail.com
> > Subject: Re: [PATCH] iio: imu: lsm6dsx: Add shutdown callback support
> > for I3C interface
> >
> > On Tue, Jul 29, 2025 at 12:02:56PM +0000, Guntupalli, Manikanta wrote:
> > > [AMD Official Use Only - AMD Internal Distribution Only]
> > >
> > > Hi @Jorge Marques,
> > >
> > > > -----Original Message-----
> > > > From: Jorge Marques <gastmaier@gmail.com>
> > > > Sent: Tuesday, July 22, 2025 1:27 PM
> > > > To: Guntupalli, Manikanta <manikanta.guntupalli@amd.com>
> > > > Cc: David Lechner <dlechner@baylibre.com>; Andy Shevchenko
> > > > <andriy.shevchenko@intel.com>; git (AMD-Xilinx) <git@amd.com>;
> > > > Simek, Michal <michal.simek@amd.com>; lorenzo@kernel.org;
> > > > jic23@kernel.org; nuno.sa@analog.com; andy@kernel.org;
> > > > linux-iio@vger.kernel.org; linux- kernel@vger.kernel.org; Pandey,
> > > > Radhey Shyam <radhey.shyam.pandey@amd.com>; Goud, Srinivas
> > > > <srinivas.goud@amd.com>; manion05gk@gmail.com
> > > > Subject: Re: [PATCH] iio: imu: lsm6dsx: Add shutdown callback
> > > > support for I3C interface
> > > >
> > > > On Tue, Jul 22, 2025 at 07:32:54AM +0000, Guntupalli, Manikanta wro=
te:
> > > > > [AMD Official Use Only - AMD Internal Distribution Only]
> > > > >
> > > > > Hi @David Lechner,
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: David Lechner <dlechner@baylibre.com>
> > > > > > Sent: Tuesday, July 22, 2025 2:31 AM
> > > > > > To: Andy Shevchenko <andriy.shevchenko@intel.com>; Guntupalli,
> > > > > > Manikanta <manikanta.guntupalli@amd.com>
> > > > > > Cc: git (AMD-Xilinx) <git@amd.com>; Simek, Michal
> > > > > > <michal.simek@amd.com>; lorenzo@kernel.org; jic23@kernel.org;
> > > > > > nuno.sa@analog.com; andy@kernel.org;
> > > > > > linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > > > > Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>; Goud,
> > > > > > Srinivas <srinivas.goud@amd.com>; manion05gk@gmail.com
> > > > > > Subject: Re: [PATCH] iio: imu: lsm6dsx: Add shutdown callback
> > > > > > support for I3C interface
> > > > > >
> > > > > > On 7/21/25 6:38 AM, Andy Shevchenko wrote:
> > > > > > > On Mon, Jul 21, 2025 at 04:37:41PM +0530, Manikanta Guntupall=
i
> wrote:
> > > > > > >> Add a shutdown handler for the ST LSM6DSx I3C driver to
> > > > > > >> perform a hardware reset during system shutdown. This
> > > > > > >> ensures the sensor is placed in a well-defined reset state,
> > > > > > >> preventing issues during subsequent reboots, such as kexec,
> > > > > > >> where the device may fail to respond correctly during enumer=
ation.
> > > > > > >
> > > > > > > Do you imply that tons of device drivers missing this? I
> > > > > > > don't think we have even 5% of the drivers implementing the f=
eature.
> > > > > > >
> > > > > > In the IIO drivers I've worked on, we always do reset in the
> > > > > > probe() function. The
> > > > > > shutdown() function might not run, e.g. if the board loses
> > > > > > power, so it doesn't fix 100% of the cases.
> > > > >
> > > > > Thank you for the input.
> > > > >
> > > > > You're absolutely right =97 shutdown() may not cover all cases li=
ke power
> loss.
> > > > However, in scenarios such as a warm reboot (kexec), the situation =
is different.
> > > > >
> > > > > Before the probe is called in the next boot, device enumeration
> > > > > takes place. During
> > > > this process, the I3C framework compares the device=92s PID, BCR,
> > > > and DCR values against the ones registered in the driver:
> > > > >
> > > > > static const struct i3c_device_id st_lsm6dsx_i3c_ids[] =3D {
> > > > >         I3C_DEVICE(0x0104, 0x006C, (void *)ST_LSM6DSO_ID),
> > > > >         I3C_DEVICE(0x0104, 0x006B, (void *)ST_LSM6DSR_ID),
> > > > >         { }
> > > > > };
> > > > >
> > > > > Only if this matching succeeds, the probe will be invoked.
> > > > >
> > > > > Since the sensor reset logic is placed inside the probe, the
> > > > > device must be in a
> > > > responsive state during enumeration. In the case of kexec, we
> > > > observed that the sensor does not respond correctly unless it is
> > > > explicitly reset
> > during shutdown().
> > > > Hence, adding the reset in shutdown() addresses this specific case
> > > > where the probe isn't reached due to failed enumeration.
> > > > >
> > > > Hi Manikanta,
> > > >
> > > > During i3c bus init, the CCC RSTDAA is emitted to reset all DAs of
> > > > all devices in the bus (drivers/i3c/master.c@i3c_master_bus_init
> > > > -> i3c_master_rstdaa_locked). Is the LSM6DSX not compliant with tha=
t?
> > > LSM6DSX is compliant with RSTDAA CCC.
> > >
> > > >
> > > > I get your solution but find odd to use the same method as in the p=
robe.
> > > > In the probe, you would, in general, reset the device logic, but
> > > > leave the i3c peripheral logic intact, because you don't want to
> > > > undo whatever the controller has set-up for the current bus
> > > > attached devices (ibi config, da, max devices speed, all the good i=
3c stuff).
> > > > For this device, the st_lsm6dsx_reset_device seems to flush a
> > > > FIFO, do a software reset, and reload a trimming parameter; which
> > > > are necessary to solve the bug you are observed?
> > > Only software reset necessary to solve the bug.
> > >
> > > >
> > > > If possible, please explain better why the device won't enumerate
> > > > correctly after a reboot without the reset. If it is a device bug,
> > > > explicitly state that and that it is not compliant. Also, take a
> > > > look at fig.100 of the
> > i3c spec basic 1.1.1.
> > > >
> > > > Thank you for looking into this, this type of corner case is usuall=
y overlooked.
> > > It appears that the sensor device is entering a deep sleep or
> > > low-power state and
> > is not responding to CCC commands. However, after a software reset,
> > the sensor starts responding to CCCs as expected.
> > It should, from the silicon pov, definitely respond to CCCs, even on lo=
w-power
> states.
> > Could you confirm with stm32 the behaviour you are observing?
> > Inform them if it occurs under under i2c/i3c dual support, only i3c, or=
 both.
> > It sounds a little the messages are being filtered by the spike filter =
when it
> shouldn't?
> > >
> > > Shall we proceed with only the software reset changes along with an
> > > improved
> > description, or do you recommend any additional modifications?
> > Confirm if this is a silicon issue first, if so, a note from st should =
be issued also.
> We are unable to verify the behavior on any silicon other than ours. It w=
ould be
> helpful if someone with access to a different silicon could confirm this =
behavior.
>

Thanks,
Manikanta.


