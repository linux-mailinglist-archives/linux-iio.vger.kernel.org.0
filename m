Return-Path: <linux-iio+bounces-9618-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 967AC97A4AF
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2024 17:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 050ABB2E790
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2024 14:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B40158DC8;
	Mon, 16 Sep 2024 14:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="SiveK8zF"
X-Original-To: linux-iio@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010003.outbound.protection.outlook.com [52.101.69.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723B9158555;
	Mon, 16 Sep 2024 14:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726498668; cv=fail; b=LPjuRZockn+86UxtU/peLG5wgPDUVZoNQuwN9YA6NqKgaQlIrQPAbbYmCBjAeBDoDcXLmeUmzFMuXCTSYn2LtQwJxe2JQbMYfHi8GWt35nzUNBFNF/rkrl+DrivIvueVHL5YD33DlV3meGiQCfvvSIZIFyOAYfKujeQJIlfwa6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726498668; c=relaxed/simple;
	bh=BFsgiV0szUia/JrgVkwgeH0CdGJobFRrq92ncL50l8Y=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=slWuy2EhFwBMArckaRIUTQYEOtiJJoRzNnDre8lgsdxZqEtRmWGX9EE2AZICtWkZojWUNTt5G97HHIRNYQO5Z2Bei+Cx3Dco3aJcqtx1XSHw27jgPI3JEwdW/JVplvjJnsWTz2+l5ktBQDeEnZqsEiyokgt32Uwkmbya8tbcMV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=SiveK8zF; arc=fail smtp.client-ip=52.101.69.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3255bJW7NvZe/oUPjtFAjPPzEUglVSrnwdxsJJ4LQP3UQxQ1BSMpFPp6/Vhe9WGk6cyp6VKuZpP4R0MRX+CLQI36QqWCk5lvUzaHdpEh+qBfKkyKqT/XiaTlJYG5ACynyDRIiWXtOi28RUe0nOhXWhemINvXmWcs5fUW87yYif8Z5whYMHOsK42l4gMj+oYOcb5tyoVPPhS886P87C+8M1ca/PqSWy7fPlJHJKxqSVytC47LBh1KIQNlpvsBbZfvmuwneVAStzJQPmR6TZI/QtyR9XkvHVPIwUe+73E0LZqmG+VzfbWFIOtvwMim/cBwkYeORpCu2Nk1SQGXL/2ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UIkf4JCrdK2epOaJ6vbEhtRvdI2tymI9MDcG1Z1zIpQ=;
 b=PidJwSUSFHI7UCoIsiGj7ZP4XW4cOJ7G+WE/xc4fzPNiGDZGNOY36XziUkO+zf+YlAuCv5m6zQtaodkd7zDYT/zmgtY344gH3UzLYsWEIB+/1Vlbuy+pbwGiyrPBvPVHy+yGCZjEzKioksZcIV3f+AAOxpIQ8vV49q3Kb+simaSQZIVjr6LvFfEXYPnX6ZqsLbGJlzu5bXfwSjBTXzXd1XLzmMGtwvJKSy0IiKr18A4Ws/Z+hqaAEFDZwf9VOsVKvXspl/P7oZ+yddH1Sy3zp/am5dUfYzr3D09BtdH9ZWLVEzdwoEyfIapuzd3YaBDJe8D2QYLIYYYackwyzV9GoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIkf4JCrdK2epOaJ6vbEhtRvdI2tymI9MDcG1Z1zIpQ=;
 b=SiveK8zFt+p6vGWp0q7TD6WoFeKMs8xjmFyyoTkx03sUQsfJO0XiJ/pa5JmAr20QEJ6XtZstYAl5aXZliEnYUpTbny84vHclP/wumIeHQYfoLfLxwaxgRRlmUPC8rpEebkKzcc4uHMm2J6HKVDNLEALge60MpGZGAXykNO/axy4=
Received: from AM0PR08CA0027.eurprd08.prod.outlook.com (2603:10a6:208:d2::40)
 by GV2PR02MB8628.eurprd02.prod.outlook.com (2603:10a6:150:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 14:57:40 +0000
Received: from AM3PEPF00009B9E.eurprd04.prod.outlook.com
 (2603:10a6:208:d2:cafe::31) by AM0PR08CA0027.outlook.office365.com
 (2603:10a6:208:d2::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Mon, 16 Sep 2024 14:57:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM3PEPF00009B9E.mail.protection.outlook.com (10.167.16.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 16 Sep 2024 14:57:39 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Sep
 2024 16:57:37 +0200
Received: from se-intmail02x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 16 Sep 2024 16:57:37 +0200
Received: from pc55303-2334.se.axis.com (pc55303-2334.se.axis.com [10.94.180.8])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 4F08F16F;
	Mon, 16 Sep 2024 16:57:37 +0200 (CEST)
Received: by pc55303-2334.se.axis.com (Postfix, from userid 18269)
	id 4B7AC22FBD55; Mon, 16 Sep 2024 16:57:37 +0200 (CEST)
From: Emil Gedenryd <emil.gedenryd@axis.com>
Subject: [PATCH v3 0/3] iio: light: opt3001: add support for TI's opt3002
 light sensor
Date: Mon, 16 Sep 2024 16:56:36 +0200
Message-ID: <20240916-add_opt3002-v3-0-984b190cd68c@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACRH6GYC/1XMSw6DIBSF4a0YxqW5XMBHR91H0zSIUBlUDBhiY
 9x70U50eE7yfwuJJjgTya1YSDDJReeHPPilILpXw9tQ1+VNEFBAjTVVXffy48QBkAqQEjVTaKu
 K5GIMxrp51x7PvHsXJx++O57Y9v6dBuTJSYwCVVIZZG2DwrZ3Nbt41f5DNibhIWX8nGJOy8aAs
 LUAXsIhXdf1BwHXAqngAAAA
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andreas Dannenberg <dannenberg@ti.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Emil Gedenryd <emil.gedenryd@axis.com>,
	<kernel@axis.com>
X-Mailer: b4 0.14.1
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9E:EE_|GV2PR02MB8628:EE_
X-MS-Office365-Filtering-Correlation-Id: e395b094-d80b-4051-d4d0-08dcd65fe8f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Sk1XcUg4ZVFiektjTEJGdXVRR3BTWXBsQXFJL3pWUk9UcVRieTJibUt5elhu?=
 =?utf-8?B?aXBqdk05cjZIU3FTZEE5dGZWQ2pjWFBRSWE2WHEvWDFDejFYQXdEdmJ5MllP?=
 =?utf-8?B?YmJLb242T3lQNE9JWFNpS0FReWZQMXRPci9mclhqZzhDR2RUTTRvcEpCWWhp?=
 =?utf-8?B?Q3gvQUczWGxsaHM4c1pxRGlHYS9YemJOZGp6WWVJQTU5dHhqbjRDcXlqS3Bu?=
 =?utf-8?B?ZnFSZ1A3c3NpbEhlZEpxTDNZS1RiY2EvcHo3OGFtNEx1QVdESGc0YmZuY01Q?=
 =?utf-8?B?QU16bXVVU0tBUVBmR09GaTZWT1hmQVJrSVZYUmxPUmQ5YndocEk0TGg2eFp5?=
 =?utf-8?B?L1E3T0xPSzFHdUlvaFYydzBiVzlpMU10bXJmQ0cwbVN3NnFBQVNJaFV6LzEv?=
 =?utf-8?B?NWFnc3M4NDE5ZVV1RzhNb3BCMkJpZW9CZzhLTnoxZmNodklkcEtWKzBZUFdj?=
 =?utf-8?B?bGNwNlV0RVhrSGpJanpwVHdzYndib3grREo5WVk5MFNHWGxRRm85cSs4VmZC?=
 =?utf-8?B?MlNOQVd1aHBHSmRvZmRHQlMyMzJDUmlWQnFkdDdsQkU0N1p0bXZreFdUbHJp?=
 =?utf-8?B?Q2pzSU82WGpFY294KzYwWGZ1ajhCQ2ZkQXVMbUdzM0Nhb2dhRW4rZ0Qrc2tl?=
 =?utf-8?B?R1ZnWUovSGVQOTVFRDZjWXV4R0xtZ01PMDI4ancvdjY1VEYveXpFVTJzbHNr?=
 =?utf-8?B?blZMVHAzMW93R21EWXN2c1cvSCtwVzQ0Nlc3THd6VmQ4d0R1dUxaUjY1QjFi?=
 =?utf-8?B?YlF1Umg0YTh0c2U4MjVBa0pJQmFOaVJnVlRYSDZCYUgvOWZtUVBiUXFON0R4?=
 =?utf-8?B?MUFQbXdEUkZIamQyNFBEODNUK0xRMy9ZT0JybmJsaUdTeHloT045TG52Umta?=
 =?utf-8?B?Sm13REJWZnNkWHF5dlM4VjNxb2JTbUEzOXhvblV5UnJ5NVNmaldkcGRkRVR5?=
 =?utf-8?B?elpIUFYxcllRc0YwM3NiMDZENDN3ZGlneFNYOEU2OTU4c1c0Y0RSditrSUVP?=
 =?utf-8?B?ZXNodVRwaHl1L0hOSFpCT3RaSm14M2ZmWVNyaGRkKzFydkUvR1BYemNrNzNr?=
 =?utf-8?B?cEV1VmlrZE5iV2RJNTd3emJSbTlmc1l5V2IwNDhnM05mNUJPenlmeGxEc0FD?=
 =?utf-8?B?QUtiZGt5OGUrczlncVlBVGZyWGlTWDFqUUk5UXZESFRDbGdLTVBhUVcyenps?=
 =?utf-8?B?ZXpmQ3FlL2ptZzFQM3d2Z2k2VVhRZFdjMEJBdWwva2lxdDR2ZnlrQkQ0NHNI?=
 =?utf-8?B?M2Y4dDBZZ3AvV2RpOHBpOG1oclk5ZGZGTFBBTzVjT05jVHZ3cGdIaW1pZUlM?=
 =?utf-8?B?WWlXemNaZEpCUUROTGJ3U2pmdFVXb3lwTTZ3UGV5RUFTRFRDeWVNZXZ1ZVBa?=
 =?utf-8?B?cWViMklPcE5QZEMzV0JLbkt6NUxtSnVKQy80S0k5WGhCL0lFZSs0U3VaWFNm?=
 =?utf-8?B?NzR5S0dUWmtCOUlTQXc3bytoai85QWtLQ25sSVVOQ1RTTjEvbWxGTmQ1MDBw?=
 =?utf-8?B?Z01SLzFVSzYwcEw5aGoxUUNBejZSTEVpQkk4Rm5ia1orb0xJZWFaVjA1YUxN?=
 =?utf-8?B?cUVPeFYwZGFqZmIvZWJmS0E2SW5zNEN6Qzk3bVFuN2xFTFJ4UnBRamdvV2U1?=
 =?utf-8?B?Y1FPWTFNSEpWbXgyMUpsTytnNXYzMGQyL2pQZm44SG5NTk5HRm5BNWNBczZQ?=
 =?utf-8?B?MkhTOC95aU1uOEhLVzFWMXFHVEViSkZiZnEwNUNoNWpEQjBUZGN0d2VSMzdk?=
 =?utf-8?B?UWNUbVpQRkorcXFGNFd0ZFFkUU5YanZKVGw1cHB4c3VVK0ZTUGRDejM2OUh1?=
 =?utf-8?B?OWg1bkkrMURwNWFxSjRhV1pJSWlIZ1JrUGladUhKNWdtZUdMR2hXalVtVERX?=
 =?utf-8?B?MklJS01CamlPM1Q1QVRsNXYyVk1INVNJYkF1bzg0K01iSisxT0h4ZUhPZEw4?=
 =?utf-8?Q?erce7fN8QeYgonfcV74gcvnFzHtbm82a?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 14:57:39.7764
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e395b094-d80b-4051-d4d0-08dcd65fe8f2
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB8628

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
Emil Gedenryd (3):
      iio: light: opt3001: add missing full-scale range value
      dt-bindings: iio: light: opt3001: add compatible for opt3002
      iio: light: opt3001: add support for TI's opt3002 light sensor

 .../devicetree/bindings/iio/light/ti,opt3001.yaml  |   4 +-
 drivers/iio/light/Kconfig                          |   2 +-
 drivers/iio/light/opt3001.c                        | 190 +++++++++++++++++----
 3 files changed, 161 insertions(+), 35 deletions(-)
---
base-commit: 5be63fc19fcaa4c236b307420483578a56986a37
change-id: 20240828-add_opt3002-40552c1a2f77

Best regards,
-- 
Emil Gedenryd <emil.gedenryd@axis.com>


