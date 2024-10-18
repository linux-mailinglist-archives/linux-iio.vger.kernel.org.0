Return-Path: <linux-iio+bounces-10726-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A049A4072
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 15:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A525B21BDF
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 13:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FAD1D967B;
	Fri, 18 Oct 2024 13:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="pTsqqd/d"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2081.outbound.protection.outlook.com [40.107.22.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45DDF9E6;
	Fri, 18 Oct 2024 13:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729259583; cv=fail; b=XXdHL5/ELQh9zPO957QfTb8ecaw4RJmPuX3lJlWfEqa3nfNGFYFwKoTDK5RYYqNWeO+yis3NEGds1jVoO/Z69c4zliwSudVqExYgg1UNYf1mDJu31rIS9Fn0z5ZQyIDEVaus92iQvzOCY6sbzTvuorPHoVeZ1w67LFYdpAvJdF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729259583; c=relaxed/simple;
	bh=+Gs6kudhE91YXhn6dp0NnyfwnCi2uWdXZB1dOb8Z9u0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g4tEQofUNY6hY1kWlj4awIMdZKl/QgQf0ea/uUtyr4sUgoFn1XSJQQimpa8BBQu33K9jGCQz792z+aIqD89oZtUmiDjRPUWhIafNfwqZmwjiYmok1QVek3mPHanOfn3i/KNjiDXy0Hl0rNpQ4FciDAfalax3TKtPA8yg3vx+XCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=pTsqqd/d; arc=fail smtp.client-ip=40.107.22.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ctilzylKurQO5um22UZhd/g8DOvpK9w1gh9jpPyAUu15bmrMjManh+ZjptpLzFkoNpPL4ZgKo24wSsoZ8oDB/DHKX62BHPFOL32Bw/bGEL2ZcrU9XG3j6wfNMyHFLiZIX8Zdph36Q+dFpqMdxcAiQhmqOuFgcgsIesOh4GAkokCzd2yx0W8WoOBDWSGRO/A4NW9GJ6xltZfrTOEohFKI7beZ/WGpflarBMvmwUX1MfArAvYTSjRsxfuDnNnQKf1qEI8tNR0Fdlh7qOxibKrzjdRHgb0i0rsvzNJq5OHCbEbCt7J2kQ4iHLMuyRpKhpVYaQ12M8QsAjz49p09NPfd7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FP20sbrCXC5zvJNLX6024S6cqNVg+WSVWToLRR8jQLo=;
 b=oGc/Rww7R7/bVHn6qMJ+oGR3RiHIVvtXtKWVeQ+6HoPFMgDG1zhnVKUKJGo1ew4hlf7Dom76yozS+MorNcutDgjmge+GtzLzi+djKj+Uw4v2WPDPLroJmGbz4rxw9qGew8tn7INITV5ZJygOIR/Vwx42f8LqjZXi0Pc7PSfzev1eskqfiVzjQ5yXp2pJGcGkJp8RHbvOk5z8AlkHsEj0c1sj6bm/Ki2xpB572mRik4gs/c73nyyULlXX+zkKmVgxK25ydOlqMEMdg7GrKL6ymsc8JULyiJysF1lfmZuOj4uyqlW1UDVy6Fu1CnlxPXnt7IvFbKymBUbdkSPbOssf2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FP20sbrCXC5zvJNLX6024S6cqNVg+WSVWToLRR8jQLo=;
 b=pTsqqd/dpxBkevnhg76ZEAl0X0Tu8AQLFkGbsV4eHC2ZcZ3rIiIUFE2dP/JJY56NbWmjn25U55Ru3CCB8H00ttvxhta/Auz4yr2DRrh6jzmsoXjzfg+QflhOxcME5pxYdgakLd+L9ha4RLH+Np5oAJHoczg4WgGjlhjcd+RCmI31GpEX9evVIcRdUHfOzC3LtZ4wOhXVhuN9g0bv7qxBdKNQXZNsExGgrGNFTBOvqoGKgIwYQGcz/SVhTHSNHlj73Jshy+YUKw08yJxuJWjHVIqXyXX0hr2hX9Rw36+y3qLe4vcEaKpPEuPBCN9P8/dxXBMmsgtO1iCJDsn8neLmoA==
Received: from DB6PR0301CA0070.eurprd03.prod.outlook.com (2603:10a6:6:30::17)
 by DB4PR10MB7543.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3cd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.11; Fri, 18 Oct
 2024 13:52:56 +0000
Received: from DB5PEPF00014B9E.eurprd02.prod.outlook.com
 (2603:10a6:6:30:cafe::37) by DB6PR0301CA0070.outlook.office365.com
 (2603:10a6:6:30::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23 via Frontend
 Transport; Fri, 18 Oct 2024 13:52:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.205)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.205 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 DB5PEPF00014B9E.mail.protection.outlook.com (10.167.8.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 13:52:56 +0000
Received: from FE-EXCAS2001.de.bosch.com (10.139.217.200) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 18 Oct
 2024 15:52:55 +0200
Received: from LR-C-0008DVM.rt.de.bosch.com (10.139.217.196) by
 FE-EXCAS2001.de.bosch.com (10.139.217.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 15:52:54 +0200
From: <Jianping.Shen@de.bosch.com>
To: <jic23@kernel.org>, <lars@metafoo.de>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <dima.fedrau@gmail.com>,
	<marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Jianping.Shen@de.bosch.com>, <Christian.Lorenz3@de.bosch.com>,
	<Ulrike.Frauendorf@de.bosch.com>, <Kai.Dolde@de.bosch.com>
Subject: [PATCH v9 0/2] iio: imu: smi240: add bosch smi240 driver
Date: Fri, 18 Oct 2024 15:52:32 +0200
Message-ID: <20241018135234.5446-1-Jianping.Shen@de.bosch.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9E:EE_|DB4PR10MB7543:EE_
X-MS-Office365-Filtering-Correlation-Id: d502f0ac-49dd-4889-f015-08dcef7c2bb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NzBGRWNpcEJSRDVZMm1tbnBkVHhrQjJZR2ZmV2hsSTlWK29wQ0xWYVc5SlJT?=
 =?utf-8?B?N1J3WG9tdzdUZzJUS2pIcGROdmVxUlVHeVRHa3JQQnlKcC9SMkREazB1UU9v?=
 =?utf-8?B?RUw5ODdsVWFFQVhwTzBQSHNJYjZ3UHlieCt5YW84R0djYnlKNHY4cWVBakxh?=
 =?utf-8?B?UHNJTWdmZmFJMW1ENHRtaUFMY3Z2WnRjeGdTOUs5dXZrMGIxY1RLQ0RPRHFL?=
 =?utf-8?B?VGF4dDFtd25uYmVtZFZvM2pUYmxKU1pUQm1YWi9HcTkxWFpPdU9kakxEczBh?=
 =?utf-8?B?aHZqQnprWVhYMkZpNUgyajJzTEZXdERJVENRaDhKUExXbWhrUWRZMWVQT1dB?=
 =?utf-8?B?U0NlRThQMUx1dWI0VkpkMFBDd3lKZGc4WXBya3BWeC9tU0tiN2p0TEdtaVA0?=
 =?utf-8?B?T2JPMTk5dG9wM09HV0l1UkNSRkQvSktOOWdIQnhmUmNOYnlpMFUzOWVEUEVZ?=
 =?utf-8?B?bGdQa3RyZjJleDBlN1JyRmZpS1hiQzJzSHZ5d2xrTE8zV3lqSmkzU1RwVkhJ?=
 =?utf-8?B?c05KSzk5K3NHR2VNWkNnMTZScndUeDVCbHFJWkgrVUt1eTBWeXBFMTNMeS9a?=
 =?utf-8?B?MWN5eVhtVUYvQXlzeEpnbWRWN1Y0cjdHblhQbVBHZklNdzZZc0lvcTJrUmdj?=
 =?utf-8?B?R0d6NHNGcnBwdlhIak93U2g3NTZzbGNqZUZVOUZCQVJ5YVYrRzNXUTMxbmUw?=
 =?utf-8?B?UCtBRGRoNXhFbFh6ajhtWFpEb01hYVUyb2tDWkVoUm9nWElaVVVDS28vSExt?=
 =?utf-8?B?KzNIK0JCNkxpbUlqbk9kbjlPRnlNemlCNTZJMENUUVdyVDRuK2RzWkEyTlAy?=
 =?utf-8?B?ejNFcUlqMjJWTXpwMStsMzJYeVFKQ2NTSkFtQkdic2FlelFkbVlrNEh4L0pX?=
 =?utf-8?B?UnV2bnoxUUFVYmNPRFRTclRZR29qcVAxem0wOXNxaHJQTlU4eENXS0NzM09y?=
 =?utf-8?B?dlFDMDlpbkR1TnpLMDFDVEVQQXUrS2hIVTBMSzJmam5MRDZxQXlhMkJvbHdU?=
 =?utf-8?B?YkFwbXMrR0tqOGtKSEIvRklyOFBmL3hvNXJFRlYxNVZLalJvZE5qejBCSGJF?=
 =?utf-8?B?WGYyZ0U1RFkzY2pndFdJWkM5MHNmZW5sUmlJSVZmNXViM0hsdUVkamlPdU5Z?=
 =?utf-8?B?cXYyTkJzeHVPTkVmQ2dqQUVoTDdYTVhSK0xkVHNpbkFLSkZ4Zk1LbmxQQ3Bq?=
 =?utf-8?B?dEZ3cTNydWtBVkJlWlhpSGVTWFhoL1JkcUNDWDg4V0QrLzl3N3Y1K1A1Y21K?=
 =?utf-8?B?SFRsRVllTGFDOUJza05JU0lpWnB5WUtsbTdrN1BMN3hYcFh0cEhLcUN4SFpa?=
 =?utf-8?B?QjYvMXczZVA2WWNkOU1ERkFtaWVKbmZyRUpvaHBkSkJEaXN6a29SN3FoRDd4?=
 =?utf-8?B?bzhJMUpudlQ5azczTERHamxROFpHUXdzck9SaWpjdmZXM3lvL0Zpb2VDMEJM?=
 =?utf-8?B?aUg3ekFyMW1jWnUyUFVSek5MVkRvMk92dk4zMVVNZ0EyQUVHOXRSZU45RUF1?=
 =?utf-8?B?Mlkyc21ZU0pWMGJFNi9uUDkxOUNWMVBwSHh0dk1aTGF0dGQvb0wwMllQZE1Q?=
 =?utf-8?B?bW9EcXZmTFpQamp6aW1TR2hOZktCcENkS3dBdWNMNWNyc0FXV1Ewam9wWFVN?=
 =?utf-8?B?SUF6VjdLZCtyNFo3NzMvL0tsd1RYRUdYS3NDM3NzNk1MeHdLUGMwQWVBVGEw?=
 =?utf-8?B?WllFZ0NGbkpFb0RLMTJBWnkraGpnUnU1MG0rakh6OVdCUjlLejlaL3pPZHBL?=
 =?utf-8?B?bm9CUEdRVGtGcHlhVHZPK2NQRE9Yb2w2elJuVW43OHR3WnhjaFkvZDVGbkZZ?=
 =?utf-8?B?eEZLZ3VNK1l2dnRpekYxc09GTFl0N29YNXpUT3djMHdrQkhJcEJKcmV0VnN1?=
 =?utf-8?B?ejFBMWN6eWdHT243b3k4WWhzUmk4MzRuc25IcVp1YS9pUDdkdGcyZERMbHpr?=
 =?utf-8?Q?/ZzMzvA1cLs=3D?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 13:52:56.7026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d502f0ac-49dd-4889-f015-08dcef7c2bb3
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB7543

From: Shen Jianping <Jianping.Shen@de.bosch.com>

Add the iio driver for bosch imu smi240. The smi240 is a combined
three axis angular rate and three axis acceleration sensor module
with a measurement range of +/-300°/s and up to 16g. This driver
provides raw data access for each axis through sysfs, and tiggered
buffer for continuous sampling. A synchronous acc and gyro sampling
can be triggered by setting the capture bit in spi read command.

dt-bindings: 
v1 -> v2
    - Add more detail in description
    - Add maintainer
    - Add vdd and vddio power supply
    - Use generic node name
    - Order the properties according to DTS coding style

v2 -> v3
    - Improve description
    - Improve supply definition
    - Make supply definition as required
    - Add supply definition in example

v3 -> v4
    - No changes

v4 -> v5
    - No changes

v5 -> v6
    - Fix checkpatch findings

v6 -> v7
    - No changes

v7 -> v8
    - No changes

v8 -> v9
    - No changes

imu driver:
v1 -> v2
    - Use regmap for register access
    - Redefine channel for each singel axis
    - Provide triggered buffer
    - Fix findings in Kconfig
    - Remove unimportant functions

v2 -> v3
    - Use enum für capture mode
    - Using spi default init value instead manual init 
    - remove duplicated module declaration
    - Fix code to avoid warning

v3 -> v4
    - Use DMA safe buffer
    - Use channel info instead of custom ABI
    - Fix other findings

v4 -> v5
    - Merge the implementation in one simple file
    - Add channel info for acc/gyro data channel
    - Fix other findings

v5 -> v6
    - Fix checkpatch findings
    - Fix review findings

v6 -> v7
    - Fix offset and scale

v7 -> v8
    - Use memcpy in spi write to keep CPU endian
    - Fix some minor findings

v8 -> v9
    - remove unnecessary cpu_to_le16 for reg value in spi response
    - use REGMAP_ENDIAN_NATIVE in regmap config to avoid regmap to flip the reg value when passing to spi write

Shen Jianping (2):
  dt-bindings: iio: imu: smi240: add Bosch smi240
  iio: imu: smi240: add driver

 .../bindings/iio/imu/bosch,smi240.yaml        |  51 ++
 drivers/iio/imu/Kconfig                       |  14 +
 drivers/iio/imu/Makefile                      |   2 +
 drivers/iio/imu/smi240.c                      | 622 ++++++++++++++++++
 4 files changed, 689 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml
 create mode 100644 drivers/iio/imu/smi240.c

-- 
2.34.1


