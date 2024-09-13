Return-Path: <linux-iio+bounces-9488-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B10977CAA
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 11:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 444D01F271F0
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 09:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73F11D79BA;
	Fri, 13 Sep 2024 09:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="UZOPRubb"
X-Original-To: linux-iio@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011051.outbound.protection.outlook.com [52.101.65.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877A01D67B4;
	Fri, 13 Sep 2024 09:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726221450; cv=fail; b=pqvA2//Jbn7sUreoxEua+5yWer8GnYZeFO2X5MXsRhbb1tmQIpR7Se8QsKurOPMPgl9ucpyb5fDYiRFTLshxnJRGmyJwZtkNs5KJvDI0C8czWIPkYcpYIhQvjiP9v3uT4rs+WQE7NyC6nrtY6CAavAdJgHU4wT9YH9p/uencLh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726221450; c=relaxed/simple;
	bh=dF0mQWF2uHB7fKRP5wdn64sGSblH4UPWUULuIHWx/wk=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=K/SA6/ubOt02cBRQh70uGpYkghSNLQMT/MTEa39FHami/OJ1Ky3ndagzl4gLTdjGgXUby3krV4WHRYenjoJvS2DAfI0QemF+b+ksDUtNHsuGIKn4xi/ZbZ/2rLYdYeG+55IRHQdw3CbCTfWNtbnwXXezzos914V5HUvHfmNq8h0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=UZOPRubb; arc=fail smtp.client-ip=52.101.65.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aAJXuejLGgy+mXyvP1co/XkjMQ/z+CdD07TG5rBEpm0gpH8vhbUx8yBga0+ZE6TWTQHM1zjlyNRTQVToEnq9ud7S1560IMx1tvhuNKl0Zq79dvhb6gtXokbmWPQHA/9iaRxPdA/1gEEYheyIDV3YT7VWgKkmQdqCWiM43n1/O6T9TbB1ITrghX6w5RBwSSm/c/6itCx/Ubak5ZR6CNbIw66ZQuRTndMV3NaHrpxhO5szIM+bMyCMI2RziJIpirQiFSybOtRAFOdpF7asl1bVLMUKmAosa3SneweBkLSF0uWtG9t6RuuqNKs8OP4BVepH9R/ij8pe+MwhxBRW1KjVCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VWqt0Twrzl+SisV7LXxvSu18NBE8+V2wEunYa2woBA=;
 b=bxtMlfPEhXhQ+649sOQR40Sxj05YinuM0sttFahv5Veea08VLG49V+boHOBqjhHV5zHfmG5+WcgDDiTinX1Avdx8Hbykb4Nb33VGXt/wUqWiseNY1mWRPFQCWS1mvK5a1KScMVSdCbJM4cwpm9NgKb2YSJ47wU/N2sKkXjeyFaz0K7yrCbH5TuDrwYb/9hjmUofyYih+b2AHT8gTHslQ4gblRhOy2iu8MILu8lRb12cmpcbWwjdGjf01PrxXcs87AskINB4/IwLWqvjvxqpgamtjmIAp3vgHU2+M4AGjYQy4N22zi/Pta3ewT1i/l79AqPv3sd9uW/AyJBpc8H2MIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VWqt0Twrzl+SisV7LXxvSu18NBE8+V2wEunYa2woBA=;
 b=UZOPRubbHqtR+lKq8jfmjyfp69+LnMOJ/4nWBXKGpNdshaAkPT6gDiWp4JuSSjrJFqWM5Xteu2wgPgAErIes64lzCATyg9FLKZACwZLuWdYhMubnl2rM4hw3GIQin10JVSbI0R3Fd+wMbM1K/2mkwZHTKDGhN68dyIdyo2YFPL0=
Received: from DU7P250CA0006.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:54f::21)
 by DU0PR02MB9267.eurprd02.prod.outlook.com (2603:10a6:10:470::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Fri, 13 Sep
 2024 09:57:25 +0000
Received: from DU6PEPF0000B61E.eurprd02.prod.outlook.com
 (2603:10a6:10:54f:cafe::fd) by DU7P250CA0006.outlook.office365.com
 (2603:10a6:10:54f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Fri, 13 Sep 2024 09:57:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU6PEPF0000B61E.mail.protection.outlook.com (10.167.8.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 13 Sep 2024 09:57:25 +0000
Received: from SE-MAIL21W.axis.com (10.20.40.16) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Sep
 2024 11:57:22 +0200
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAIL21W.axis.com
 (10.20.40.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Sep
 2024 11:57:22 +0200
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 13 Sep 2024 11:57:22 +0200
Received: from pc55303-2334.se.axis.com (pc55303-2334.se.axis.com [10.94.180.8])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id F26F3248;
	Fri, 13 Sep 2024 11:57:21 +0200 (CEST)
Received: by pc55303-2334.se.axis.com (Postfix, from userid 18269)
	id EECEF22FBCF7; Fri, 13 Sep 2024 11:57:21 +0200 (CEST)
From: Emil Gedenryd <emil.gedenryd@axis.com>
Subject: [PATCH v2 0/3] iio: light: opt3001: add support for TI's opt3002
 light sensor
Date: Fri, 13 Sep 2024 11:57:01 +0200
Message-ID: <20240913-add_opt3002-v2-0-69e04f840360@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG0M5GYC/1XMQQ6CMBCF4auQWVszHWkAV97DEDNAkVlISUsaD
 Ondrbhy+b/kfTsE68UGuBY7eBsliJtz0KmAfuL5aZUMuYGQSqypVjwMD7esF0RSJRpDvWYaqwr
 yY/F2lO3Q7m3uScLq/PvAo/6uP6dB8+dErVCxYUu6a6gcuxtvEs69e0GbUvoAhxFj86UAAAA=
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andreas Dannenberg <dannenberg@ti.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Emil Gedenryd <emil.gedenryd@axis.com>,
	<kernel@axis.com>
X-Mailer: b4 0.14.1
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61E:EE_|DU0PR02MB9267:EE_
X-MS-Office365-Filtering-Correlation-Id: f0812a2b-14d6-45ef-bbd7-08dcd3da786d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVgvZjF2anV4NzlNMnFmVDl0S3RhVXkrZnJnWGNOUEl4TEd0V1ZGekp6a3hW?=
 =?utf-8?B?bDhKZ3IxTTBtRXpEa0w5SUg2SHBuclNHM2EzMzhrcjl5S3BwVk56Um8vTzJt?=
 =?utf-8?B?V2d0TEtYcVdCODJldjVYTWJVd0dWdGNoeFVwRUV3Z1ZNOG9xVmlKMFdzZUdq?=
 =?utf-8?B?OFZnRTIyY0tlM29sWG9oYTIxT2crbkU0TWxYYTJuT2loVXdZMFhHNzV4QlND?=
 =?utf-8?B?Z1ZkRENTYjBzdnpZb1FCVE0vV2hpMndJeld3Qzh3TmFqdGZRTmNBVmFjelZr?=
 =?utf-8?B?TnJpMm5jbTZ3RmVnSjFXbk5pdGFLanZvRDZ1RWZiT3NOTTIvZ1ZxZk5IaTBa?=
 =?utf-8?B?UFg4QlVxNGwxT3NROFZmTkZuaHgvQnZCamc5N2dXMmxlV3ZqSjMwcDBKY2RJ?=
 =?utf-8?B?WklBQk1RR0R0anBoSmliK0ozT0FWbWZ0WkREbmFiWFR6SFpKTHAvYmM3dS8z?=
 =?utf-8?B?TjRsTy9YZFU1OHJrbmNUdG5uRndSVENHek85eVdnd1JKQjNHSXllaUlyS1l2?=
 =?utf-8?B?TG40RU1xY3VQTU95b09LTjM0c3J3Z0xMM0dLbnhsUHBGVVRTY1U1L1BjK1Qx?=
 =?utf-8?B?UjBsK0NKV0ZsVWJMS1ZIVjBYTzdNVlFCYUQybk1Ga2dqVGZWSWRxbndLQ3pr?=
 =?utf-8?B?NVh0blZRWmM4b215V21oQUlBQ3VPUjZOT3R0SmJ0b0JLYWlXVVdGaHpSR2Nl?=
 =?utf-8?B?QjI1NndLUDNFS1N4amoycE9SbDdwbEFIS3VxcGtFWnlCV2l6Wmt6QSs4b0hM?=
 =?utf-8?B?ZVRiaGhySy93ZlRiTGxNdXFBU3NNNTVWRjlYU0JrWWJYcE0waGczNVoxdWtL?=
 =?utf-8?B?NUdrN0MzR3MvZG1yZkgvU0dwa2liYVFmbWVtZWRUS0hhWkdhUnJySWtCSnB3?=
 =?utf-8?B?OGQ0azdxOTAzNVNsTG9rQUlwWTdydWRjL0NzL05DVGRYSEp3dXczejEyWS9j?=
 =?utf-8?B?Wnh2ZFNYQTdzalduNTJBUmpYWFFpOU1DM2JYK1NmcFpUd3Q0Q0ljZmVVb1ZX?=
 =?utf-8?B?dmVodXVGUUJQMVF2bjZxWkczQXpjK3dBYXFadzBBL2J4RjJYSFlqaklyYTVB?=
 =?utf-8?B?RHZ6cWRNYUsyaHByVUpjS05sWC8xOXF2bk1nZ2NaQk5kekp6SWIycDFGQnc0?=
 =?utf-8?B?MWRiSVJ5MDZIaVZiVUVBZTVPVjFjc0d5L05UdU9iYVNOcVZGZy80Ums4N3BV?=
 =?utf-8?B?eS9qbGFJcDJ3em1yVkxRMndJMWtneTlQL1hCdjlkK3kyOE1LUVB3UFBBalZM?=
 =?utf-8?B?bWRla21acXdoQ2E0Mm9mWnZxckFwc2JpRHhuZFBsV2JXN3R5M2ZrdGVWRno1?=
 =?utf-8?B?TUhvVXdkUDdYdzlCaGVrY1ovMjFVTmlsMVRLR1hYUSt1dnNaTE1DN095RjVu?=
 =?utf-8?B?WkJWMmdHVEUvRFo0QmZlejVnQ05BK2Vid3BDb0Exc2xVMDUrNS9XanQ2TjBa?=
 =?utf-8?B?d3ZuejN4cUI0OVYrT3ljTXNtNnBRV0d0L0JFQ3hXYjBFQjc4Skd3TmNpbFJB?=
 =?utf-8?B?ZVp3eitZMW5URUgyZE41L01Id0FMVWducnFqOUJBWGRqRGw0R2N5V2pNMkh4?=
 =?utf-8?B?ZVZmcTJyRzJ5aU9CQzFRNUgxbmZ6dVA1cDgvS1dEWm40S3czUGkrWTRHTGFh?=
 =?utf-8?B?TkFCU29KZGZHKzZKOWdzZkZEa2djM0xNdFlaVjhOcWw5MjVlaHdiME5Qb2Ri?=
 =?utf-8?B?bldrM3BBdm0vMjJ1bm1xK1pGTDdJcFMyUEdJR01MRThpTTZGS3JFUXljd0Fs?=
 =?utf-8?B?SGhsVks2NGRkc3UyUnF1bXhrQkZnRmdnWUt1OVFXWnhDOHQ2YzRodUxSTzRn?=
 =?utf-8?B?bVJmTzFDVGVXdlFiV2pMRVJVOUtwdG9kYmVxbkFPa1NncTdNZHE1YlZOQ0xi?=
 =?utf-8?B?dml3UHh4UFVrMnFqeWJ5eVpKNGlUcDUzSHRCb0dQc3gvNk5makZCL1RyL256?=
 =?utf-8?Q?cb2Mdrfds83mdb2fzMafXZ+WKwrmoEzc?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 09:57:25.5775
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0812a2b-14d6-45ef-bbd7-08dcd3da786d
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B61E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB9267

TI's opt3002 light-to-digital sensor provides the functionality
of an optical power meter within a single device. It shares a lot of
similarities with their opt3001 model but has a wide spectral bandwidth,
ranging from 300 nm to 1000 nm.

This patch set adds support for the TI opt3002 by extending the opt3001
driver. In addition, a missing full-scale range value for the opt3001 is
added, resulting in higher precision when setting event trigger values.

Datasheet: http://www.ti.com/product/OPT3002

Signed-off-by: Emil Gedenryd <emil.gedenryd@axis.com>
---
Changes in v2:
- Move dt-binding patch to before implementation.
- Fix dt-binding compatible definition.
- Clarify bug description for missing full-scale range value.
- Remove model enum from chip info and all in-function switch-case
  statements.
- Move model-specific channels and mathematic constants to chip info.
- Add valid match data to opt3001_id array
- Skip call to function opt3001_read_id() if model doesn't have a device
  id register.
- Link to v1: https://lore.kernel.org/r/20240905-add_opt3002-v1-0-a5ae21b924fb@axis.com

---
Emil Gedenryd (3):
      iio: light: opt3001: add missing full-scale range value
      dt-bindings: iio: light: opt3001: add compatible for opt3002
      iio: light: opt3001: add support for TI's opt3002 light sensor

 .../devicetree/bindings/iio/light/ti,opt3001.yaml  |   4 +-
 drivers/iio/light/Kconfig                          |   2 +-
 drivers/iio/light/opt3001.c                        | 173 +++++++++++++++++----
 3 files changed, 145 insertions(+), 34 deletions(-)
---
base-commit: 5be63fc19fcaa4c236b307420483578a56986a37
change-id: 20240828-add_opt3002-40552c1a2f77

Best regards,
-- 
Emil Gedenryd <emil.gedenryd@axis.com>


