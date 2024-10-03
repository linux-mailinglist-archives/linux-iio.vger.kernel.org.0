Return-Path: <linux-iio+bounces-10036-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E45598EF22
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 14:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A637B230EA
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 12:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C2F176242;
	Thu,  3 Oct 2024 12:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="hgHN5/ec"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B00F16F8E9;
	Thu,  3 Oct 2024 12:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727958193; cv=fail; b=qcdp5f8fq52j+cL24//kt9r9WxJ4EsFce7KTzwt8kDyVVH/MGZZF+XP0g8Shr7+uCjYpoUyFYeuPbVvRQmThTH3hEPG6nWEPlzz5cEKevtjclIsLjrtE4H9bllyyzwtGk4Z9rbsVWAuKxieH7VuanMPxS09ufkb7vzdAxKRRQ4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727958193; c=relaxed/simple;
	bh=EUwdxRn1Qbw26Se+lPSHVv0hMiaLpZf8U3JDDQyB0A0=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=NJw64tSCyEimAH7lxpfeRQnXoYAE8k3VrdJaz8fz/p7nhN3YXmprKDd9PbPWaWQGPBTLMHlI6sQ4f6Npola6theOsV1MISwmWiIxpQIdhAzhVi4EVjsd7BijDqvoErRrEyIqtRpn5q4vzA9UUGzN9C4Qfnz6mdlKKt18Vwtdzyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=hgHN5/ec; arc=fail smtp.client-ip=40.107.20.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fOWgArJi9yzzbQrARNSI59JNVKDjavBrXMRuei1UyfBk/R72tZ6jfd/35yQvgGvkVbjjS6TgMuxteqpPglJvTgSHT5pL0kos+TA9PjX8ulX4y5nYiaF9L2752mRYjViOM3CPZ6YNyBzSEu6ilWEZ0dmT4NAB18GP/aC73nnTW0fdqXz/l0KOiVsw6VpsEOr+r/DGTL9Zj4EN9KZQ9lp1++P+8Yu8LHdpUbYjq+ujcxlZOf5Jjxj/9VWFtiYbBnUrtT5mYaVHU+Qa9axJd1+dd2H5+/AAYZLKssmc0+TlQUDQdRRfFxf1/9UkGD8ts6kDysmxjukm0P7LRs4N7SQ9jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WcB2d/7qrT6iffsIVltppIfiNtlvJGfWJdCrkUR40A=;
 b=o1KowjBSpUKhQP4fmXz5F4B9xlFL9bxcyH9vFCdgC3ZTmHblrov1MAa5Y8Pdwrpr2R2uDg72jWLwPCSm3cNMNdYxqRmllraJGF7cr34W5bl9R/WAQSqKHXgA7QGWnYBfYQxOiX52I56e+YI8CqtjdyIEqnrnmUHYjHwgQqq7INNhgSuGD8xwqXcPzJLY3LnJuBys2RoEbw32LHs5Alsem/u9QQlHrdE221G6BpLpNRaEP0pjYyAf99x//RmM1+LlDMYEVi9nLBB4uzlTihUkOlVSvq4qHXVdmvGFgP2NTIW0ftenMsn1lpMKsi3e6/T1yGLJhzpIZzcWG4GETLfAHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WcB2d/7qrT6iffsIVltppIfiNtlvJGfWJdCrkUR40A=;
 b=hgHN5/ec80ZIyTkVHHXkLatEKc0ztxBKT/Wypb+Rpe9IJng5nDEe8apB9h6jMQJhAfcHdF6w7yBWNJThal5ul4AiJyDk/Wnk7S25vHG5I3nHqilaImblWRaATza6ZEArfOlrLYDgJolfJBo+XNlOOetQBnL6eVL4QmytllErW68=
Received: from DU2PR04CA0010.eurprd04.prod.outlook.com (2603:10a6:10:3b::15)
 by GVXPR02MB11063.eurprd02.prod.outlook.com (2603:10a6:150:217::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Thu, 3 Oct
 2024 12:23:05 +0000
Received: from DU6PEPF0000A7E3.eurprd02.prod.outlook.com
 (2603:10a6:10:3b:cafe::b6) by DU2PR04CA0010.outlook.office365.com
 (2603:10a6:10:3b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16 via Frontend
 Transport; Thu, 3 Oct 2024 12:23:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU6PEPF0000A7E3.mail.protection.outlook.com (10.167.8.41) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Thu, 3 Oct 2024 12:23:05 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 14:23:03 +0200
Received: from se-intmail02x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 3 Oct 2024 14:23:03 +0200
Received: from pc55303-2334.se.axis.com (pc55303-2334.se.axis.com [10.94.180.8])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 563F81D5;
	Thu,  3 Oct 2024 14:23:03 +0200 (CEST)
Received: by pc55303-2334.se.axis.com (Postfix, from userid 18269)
	id 4FB89232D127; Thu,  3 Oct 2024 14:23:03 +0200 (CEST)
From: Emil Gedenryd <emil.gedenryd@axis.com>
Subject: [PATCH v4 0/2] iio: light: opt3001: add support for TI's opt3002
 light sensor
Date: Thu, 3 Oct 2024 14:22:15 +0200
Message-ID: <20241003-add_opt3002-v4-0-c550dc4591b4@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHeM/mYC/13MQQ6DIBRF0a00jEvz+YBCR91H0zQIWBlUjBhjY
 9x70U60w/eSc2eSfB98ItfTTHo/hhRim4c4n4htTPvyNLi8CQIKUKioce4Zu4EDIBUgJVpmsC5
 LkkXX+zpMW+3+yLsJaYj9Z4uPbH1/HQ3y0BkZBWqk8cgqjaKubmYK6WLjm6yZEXeU8SPFTAvtQ
 dRKAC/gj/I9LY6UZ6qVqJgG6wpld3RZli/4ULzCGwEAAA==
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andreas Dannenberg <dannenberg@ti.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Emil Gedenryd <emil.gedenryd@axis.com>,
	<kernel@axis.com>, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.1
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E3:EE_|GVXPR02MB11063:EE_
X-MS-Office365-Filtering-Correlation-Id: b441806a-34c7-4aff-e8a7-08dce3a621fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXRLaXhncjI1amlPeGM1cWE5aU5FUkVpMmRBYlRpbE1qcGdoeUozT0x2TkZH?=
 =?utf-8?B?RHM4MWZZRTZmcjNlaHVia0ZYM2xLMUhRWVR1UG5IcTFoNjcwOW5JRW16MFUv?=
 =?utf-8?B?QWQzMGJ3RGJDdUtmalZ5VjlKb0JYTkdWS3ZZMENXR1loU0U4d3V2MTVsV3p2?=
 =?utf-8?B?VUlFdXl1NVVJNnlGMStEb1B5R2pQSFFXcVNZYW9vNytSS1VDaDZzdlhLNmYr?=
 =?utf-8?B?SDJsYkJTTVFkSWl2RzJPQ3JLRGxubHlnd1NGY2tIS2Y1UW9KYzBxNnhpZjNl?=
 =?utf-8?B?bmlNakVlZjRiU2xzTEJ0a01vM0ZzWHc2US80a2pkTE84SEUzeDFGUWpOaXFJ?=
 =?utf-8?B?SUhZQjJWaGEzRlBkTndpUGFDeER3bDBJR0plWk1Gb0J0TzZ1VEJpdW44OXoz?=
 =?utf-8?B?b01BZlBuZW9RcUppcUZKM3BTTVhzcWtSMXRXR1V1RDhDMmVhUFlER2NGMEdH?=
 =?utf-8?B?ZzlHRk0zYWhiU0RtbHB6S1NON1ZEL1VXYVFySE82M0lrLzl3NWg5OElNdE5z?=
 =?utf-8?B?cTRhUU1kY25SSDh4N3NCYXNJV3lFUFRJdTJpTnd4MzB4Rk5jbWdoaGFQODMr?=
 =?utf-8?B?NjByWHZheThlQUFDd3VrS1JneEtHRnNQb2RxbWtOblRTb3l3Q2ZTNjRBdmd0?=
 =?utf-8?B?Mm9GeUM0cFRsa2RlSVVkbmdRWGJLYUNjMStjRVBJb3M2eis3VnZ1dmFCUHRo?=
 =?utf-8?B?MVNFYlU5NkdBUk91Yktidkd5VHllNEROUzVrd3lDdVF6L09FK0ZoWm1HNlZM?=
 =?utf-8?B?WDg1QmVhRVF1a3NjTWhHOVhwVUkra2M4M0FJUDRxZFFXemN5MGRxcUhjS0tB?=
 =?utf-8?B?L0NTcGpJNU8yM2pSeE5SMTNFb3lXMk80dmk1cVNVZ0M0V1NiUUJNQkxrdDBp?=
 =?utf-8?B?aGNSRFVJNE5CU1puZUhsNVBMMTVMcSt0QzljQlFIT3pmdVc5N2ovdFB5L3VP?=
 =?utf-8?B?ZThNVk16ekFGbUVLWGNOTnFmQUQ4aHpXcWhCQTBISDkyZ0xMUEZuU0UxcGlp?=
 =?utf-8?B?REJzbXByS2MvZ25Qb2hSUVFVNFI5QldlOHJtSndzL2lCZ083TStSS0kyU3Z2?=
 =?utf-8?B?Vjl3TDgwUHF3WFBGZTdLRllrVk0zWTVtQVhEUEJQdlJJYlZZT3JCOE9RUHFn?=
 =?utf-8?B?VERKTDBTUmwyeHRzTnFSMVltZWlhWlhoZjhkZVRiQzVMcmxaT09JN1RnQmsx?=
 =?utf-8?B?N0hQZDR6QnZ2L205cEhVemhsWUQyc2ZYRWx1ckMybmV0dkx2ZUNqOWlETHl6?=
 =?utf-8?B?YjhMVjJIb3ZDM2YrZkFMQ3JsOCs0MUZCL1FGRUJ5YTZIRU12ckM2SFkyRUlx?=
 =?utf-8?B?T0VnS1kxdmY2Uy9EcytTYTNFNlIrUmREdzFhNmdXSHlrRlBZRU5uOG44RHJa?=
 =?utf-8?B?QjlGakk2QytWNHlSaVQwakJHckVlbUUzak81RnNOcUIxaTkydmFhY00vd2c5?=
 =?utf-8?B?VGhZRnpKMytZUlFWejZnVW5KcGl0N0twWFhVMXpSMlgxTStER3hBQlo3Y2l2?=
 =?utf-8?B?dzBuVk5ZaUZZTXBCMVpWZ0hiVFY4NmxNWGJ6Z25qc2RvZnk1ZStmdzVQY0tO?=
 =?utf-8?B?MEhXcUNCenFSNzcvdVpIV01uTWxCMEgrQXl3bEdFa2h3YWk4SS93UVYxTVg5?=
 =?utf-8?B?ZUJRVitQYnNiUk9ydE1vRjBJdlVSZWtEYTRodHQwUDlEajRGZnBhVzJlazNH?=
 =?utf-8?B?R0wyT2xpamJSTW1OK3VBKzFXRUsvU200S1JLOXhtOTlSa2poVVAvaHFDWHJt?=
 =?utf-8?B?QnFnZnJ1bkZMOVBhU1RtMmJrcGF4K0FsV3JGMzFCVFFPTmI4UU9qWlkzTmkw?=
 =?utf-8?B?eXNLa05HNTF6cU15K1ZBUmp0eFp5dFBkaDNFcHBPRXZFNTdoMUNlV3BpMlZo?=
 =?utf-8?Q?ePdoELSk0kvH2?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 12:23:05.3572
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b441806a-34c7-4aff-e8a7-08dce3a621fe
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E3.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR02MB11063

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
Changes in v4:
- Drop applied patch: "iio: light: opt3001: add missing full-scale range value"
- Add num_channels field to opt3001_chip_info
- Use i2c_get_match_data() instead of device_get_match_data()
- Link to v3: https://lore.kernel.org/r/20240916-add_opt3002-v3-0-984b190cd68c@axis.com

Changes in v3:
- Include difference between opt3001 and opt3002 in commit message for
  dt-binding patch.
- Remove whitespace between tags in commit message for opt3002 patch.
- Rename opt300x_chip_info to opt3001_chip_info.
- Add documentation for mathematical constants in opt3001_chip_info.
- Only check return value after opt3001_read_id if chip has id register
  in opt3001_probe.
- Change opt3002 channel mask to IIO_CHAN_INFO_RAW.
- Link to v2: https://lore.kernel.org/r/20240913-add_opt3002-v2-0-69e04f840360@axis.com

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
Emil Gedenryd (2):
      dt-bindings: iio: light: opt3001: add compatible for opt3002
      iio: light: opt3001: add support for TI's opt3002 light sensor

 .../devicetree/bindings/iio/light/ti,opt3001.yaml  |   4 +-
 drivers/iio/light/Kconfig                          |   2 +-
 drivers/iio/light/opt3001.c                        | 189 +++++++++++++++++----
 3 files changed, 160 insertions(+), 35 deletions(-)
---
base-commit: e2df62bb0fadc8ae16aa3bb88ee05ee7e037046b
change-id: 20240828-add_opt3002-40552c1a2f77

Best regards,
-- 
Emil Gedenryd <emil.gedenryd@axis.com>


