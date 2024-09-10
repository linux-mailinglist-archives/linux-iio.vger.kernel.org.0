Return-Path: <linux-iio+bounces-9429-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8105973654
	for <lists+linux-iio@lfdr.de>; Tue, 10 Sep 2024 13:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07F571C24745
	for <lists+linux-iio@lfdr.de>; Tue, 10 Sep 2024 11:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD4918EFD2;
	Tue, 10 Sep 2024 11:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="XOeXQdzh"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060.outbound.protection.outlook.com [40.107.22.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96B117CA09;
	Tue, 10 Sep 2024 11:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725968245; cv=fail; b=UcbQ92AbadUCvBELdua/WpwNw3Amrj1ct3eG+ftKNXkATd71Q6qfAwaJO6tJVY9jpdJ4TQPfuQ1L40EhdwCqB8sMU58Qc0ph6VAI4KxTYRPfdfHS1EunXO/o/9xyWDg1etFUffWHoO2w4wFFjRpFTymja7RAhAAkejVtk/3bhow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725968245; c=relaxed/simple;
	bh=LbWwPbLfIUBFNO9Mr24vihcmuhsWxZ0i38tsXqtTS68=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J3nRH9BJYpe/mWyGpA0nd2Y08yo9tvQmTgonIwqwGDZu7mJgMMbVO0aiLXH97oYwChvVlHmSQRnPcgUf511qYrSwpOG3eHSDTsIV+JFhdOC8bu67tgWTQAkMFxQT5D6VN43f9n0xMTXDYZ2BJRrhwoBPNMET53DVZOBmP4F0D1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=XOeXQdzh; arc=fail smtp.client-ip=40.107.22.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yTskfcBOlD3wtMJu6JjeLQ9RIDEUBFhYRxwAP9AkDSuUxyTTXUkSvB0g844pbD1pC95BsFE0YgwXGBs1v0moyhcpQLGxu4zAbe9HYCWOEFBLsqNo0LRUCJdFgjKFRK2oUgy8b9RsqYCvOkWT++4pkKEqo64L4ZM1noaEZYChMUpzETmm+7/Tl4L2YCPtS46kdjtchwBnAXw5kUK4e3Ll1KUtWMESY6L/PWeeNdTHr7ryA7R8v7fyUd0tFLNXNcsXa88Gv5BFBwTvR49NMPvwDvsgmjAwAtZWJhhMM+P5gxht2JIWsLh/THI8LVrnPpotKSC6JKoQbZYYzzyqllPJTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Piy1MkeBcNMKDCWplxiGBSPyipXGsvXSvRxsOuXYw4Q=;
 b=Wo64f+OEXl4qEEfvq90BkZlj1dcBA7jSGLdSoLlTxASr0DH1zwTDNu7XvdYBkbnnI8KQJrGmS3HgWuK+gptC/pQEZ+Y+OiLdS0Rahmjv3sal2qLjedrzz/UwnJ8ECEZT6kA79UbdcSHmUFeKXNkG9NSLGzaRueamFtYnwDllUqfqljBgAfSoyDIkuYjYEFhPSPfld4l/azo5QGcz7yFsMvunUi3e3xAEcpb8aAWOzYCwYW/EoINfFe+MWht5gqZ7p8G5HWWMBLVIofm9VPD40/bQwRsWOm0iH1JpI56VkFnLm0w17ZITvzuYYl7Cb0t1JKNpTWiZlWgsFLiHsEYX/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Piy1MkeBcNMKDCWplxiGBSPyipXGsvXSvRxsOuXYw4Q=;
 b=XOeXQdzh41pK9DSY9vbiBq7aDsOrSr4ja5KfC9f2GHhJ/FxwPUBXCWVY2y00MH9J48rjjXbtkZ0glUwxR4U2WkzyTKhv4XyrrI8Y/LtzzJKiORpbug7e7zz7GjXA2JLyX555HhXJABIQ9F2puIJECCiQC2C8KHhoFh0qCWcjK0dVhmTZ9KufBKKORqmG2vmp/lSvojtSy8aVQfzTNlGAqPg+mpDV/uLuYMtrF35c2UiKOfsvTjBL9Bi7HVWYPMeXfztpW0O3E9sLoB1uJzZqlf8oGewAGxkKJ1K0UP+zcLwVnIHZWecZt+NjBLanCUB+QSsoHL9LPlLHHVutVdQA6Q==
Received: from DUZPR01CA0056.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::7) by DB9PR10MB5572.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:30c::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Tue, 10 Sep
 2024 11:37:18 +0000
Received: from DB1PEPF000509E4.eurprd03.prod.outlook.com
 (2603:10a6:10:469:cafe::db) by DUZPR01CA0056.outlook.office365.com
 (2603:10a6:10:469::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Tue, 10 Sep 2024 11:37:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.205)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.205 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 DB1PEPF000509E4.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 10 Sep 2024 11:37:18 +0000
Received: from SI-EXCAS2000.de.bosch.com (10.139.217.201) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 10 Sep
 2024 13:37:04 +0200
Received: from LR-C-0008DVM.rt.de.bosch.com (10.139.217.196) by
 SI-EXCAS2000.de.bosch.com (10.139.217.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Sep 2024 13:37:04 +0200
From: <Jianping.Shen@de.bosch.com>
To: <jic23@kernel.org>, <lars@metafoo.de>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <dima.fedrau@gmail.com>,
	<marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Jianping.Shen@de.bosch.com>, <Christian.Lorenz3@de.bosch.com>,
	<Ulrike.Frauendorf@de.bosch.com>, <Kai.Dolde@de.bosch.com>
Subject: [PATCH v6 0/2] iio: imu: smi240: add bosch smi240 driver
Date: Tue, 10 Sep 2024 13:36:48 +0200
Message-ID: <20240910113650.4733-1-Jianping.Shen@de.bosch.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E4:EE_|DB9PR10MB5572:EE_
X-MS-Office365-Filtering-Correlation-Id: 89df0d90-a06d-4a36-5bff-08dcd18ced34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0dNdjN3cGZzZ3d2SHNic1dYeUVZaEJkYWR3RkYyaXBwdUhFTWpTSXdDUGJs?=
 =?utf-8?B?Q0dXbkYweCsxd3kxTVlqOEhaVW9YLzNsYy9rSVY3cEFMNzBRR0trMnpibW5F?=
 =?utf-8?B?S2xWdHU3VVluaU9iT2NKUGNzRTBvNHkxQmdKSys5TkR1RTJZQ1ZHOXlSTXpx?=
 =?utf-8?B?UzUvQkJTYng0Q0J4dDlHQUc3U0ptaUxIbDI5VnZoOEtQRUVDZzc0ZXNYQ1Fr?=
 =?utf-8?B?Tllna0VlVDZoejhHZFdTNVhwU0FnN0ZSRTVaK1J2YWNVMEQ1c2hqZjVkQmZF?=
 =?utf-8?B?b2JNTEIvbVJaLzRwYXdQeEkwOGRCZGdUZmR6T044SFZocWVKcFdXdXdBcHVu?=
 =?utf-8?B?bWlhVk9QVkZ2T3dDc05SNVoyYmV2YWRZcDBJMnd0ejNVbER2L2taMlBQSVR0?=
 =?utf-8?B?eStSSjRZNkJjYXJtVUdJN2tTRy93cWtValNJUngwOVYxVUFGQnYwYUZvTHAy?=
 =?utf-8?B?bllEWmJwT0dFVGpRTnM5K09hZHp3TDhzM1dva2tjNFlGM3B2ZjN0dkRzKzBh?=
 =?utf-8?B?Q3gyY0c2R3pWOTVralV1aWphVjJZdy94MFNFZG1KeEFaS3B3Y2pXZGhvb2sv?=
 =?utf-8?B?ejNONkZ3MkVFM2xXS01aTk04aTlMbTdFdmM4M0R0clBtM0R6ZHM2N052dER2?=
 =?utf-8?B?eDdjNU43aXQzNXh3R0ppTkNtcDFIQjlzWWVRbWx0L0dDQTVxOFAwdmZWTVdy?=
 =?utf-8?B?U09YK3d3SUtFdVNoT09icHlNN0xHQm1kNEJVNndSR3JtazlBYW1YRzNSUGsx?=
 =?utf-8?B?elUxc0Y1OFYzV0NwKzAwSGZCeXlvVnRraldxak5MSkVtd1dVZzdmeFQva0Fl?=
 =?utf-8?B?Q016dStFV0RZTEdTNGpWL25MYzlxUXhnK0Z1eG5Oa3REVW5pbTRKZ0U2eW4w?=
 =?utf-8?B?K2VLalk4ZnI5NkRUeWtJMklOMTZkU05wSllGeFVCYTY1WGVuSWErZkZOWlQr?=
 =?utf-8?B?d3ZVcllOL1JlM2ZZMnF4c2hMaFgrV2xJVFZaUEZqWTFVNFdsS3oyeVFocDJK?=
 =?utf-8?B?cDV3ZEdvV3BDUEpqc2JPYlZmWWdNMGNyM2xFb2FrRGJBZlVvR2dWUnJ1dlNm?=
 =?utf-8?B?SldsdklvSkFEaDZnT25FQy96eUFWMWFIZWxQTU9UU1g2MUVIMFROSU1Pc2pL?=
 =?utf-8?B?TWRBL3JSa1lBOEhFTTVONkpZemQ3ZWFsUjk0MGhYdkFiSSs2VnhURmIrdUdP?=
 =?utf-8?B?S21SdVpTQ2FOSHRYVTNVanZvOEhJV2tJelpwQUVBaHI2NTFVV3pPL3Qxdmxp?=
 =?utf-8?B?NlJGUS9tUzBpeXlCdStSUDB2TmJRSkZEdEIrYkpRT1RVcW1QbVhIeGlxdmZl?=
 =?utf-8?B?Tk9JaEIxYnRFQjIyQmQ1UUpRSnpyakZxRUNLci9OT1hCNVo3dWRDb1EzbUxq?=
 =?utf-8?B?bVdSc3orQ2svR2d1OGtkNDRzOFpzcHA0a1ZNT3UxQ0lpeUxpbEVjSUhqdDRt?=
 =?utf-8?B?OWZtNnpldE1YTS8raUtpakUzMUsyS2t4dFJXdFhkcUJyTGxlNFZkWXhyVTBa?=
 =?utf-8?B?RmErblZGWlJaMWd2dkZRU0RFODhpWDNIUE1VWnUyQ3dJbzZpcUVzWjl3YmtI?=
 =?utf-8?B?anQ1aWZYUnhsRUdKNDFKYW8zdW5CazNjemV6S3orMEpodnpWUHA5TVkvVjBp?=
 =?utf-8?B?MEhXUWdqK3lSVGw0RFFWNHRkK3VJcm1INFpSK09IQzZ0ZnJGcEhqNy9OK2do?=
 =?utf-8?B?M1NDWW5YcU5UeXM2a2lzNHlZNFh5Sk1iNGhzLy9oVUhyT3VLaWpBTDRNSllz?=
 =?utf-8?B?WVUxd3hCSzZEWjZVM2txeHNWUmVxWjllc0F2TmVpcmdWWDFHL3JXdHFXV1JH?=
 =?utf-8?B?N0ExRDVFeTdVVS9BTXlDUlhyV3hmYVIvbUlEeG94SFQvcGpTM1hIYWQ5SkVh?=
 =?utf-8?B?eW52RWIvM0VxRHhpNG5ua1RKY3hmM2tTZStNaTdOY21pU0ExWkdLU3hXOUY1?=
 =?utf-8?Q?H5G46h1+NygwOxQ4YT925b4HDVdpAykT?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 11:37:18.3932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89df0d90-a06d-4a36-5bff-08dcd18ced34
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E4.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5572

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

Shen Jianping (2):
  dt-bindings: iio: imu: smi240: add Bosch smi240
  iio: imu: smi240: add driver

 .../bindings/iio/imu/bosch,smi240.yaml        |  51 ++
 drivers/iio/imu/Kconfig                       |  14 +
 drivers/iio/imu/Makefile                      |   2 +
 drivers/iio/imu/smi240.c                      | 597 ++++++++++++++++++
 4 files changed, 664 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml
 create mode 100644 drivers/iio/imu/smi240.c

-- 
2.34.1


