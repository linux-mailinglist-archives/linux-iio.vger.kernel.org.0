Return-Path: <linux-iio+bounces-23757-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E32FB451D4
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 10:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22EF3B60FF9
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 08:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812E227D782;
	Fri,  5 Sep 2025 08:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1hkJMX4o"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FBC27932D;
	Fri,  5 Sep 2025 08:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757061723; cv=fail; b=AYuqZQN3YGL17mZd+GxiWdFCzmQuFo9BtvOVVMQeP3E0a6UUGv6qpSxCAJcRlvFXzSDEiFiUEbRMZaSM5DJZjDV7fDT+4V3oKyCZRYFC7u4QBZEzpbXlZ4L6266hToTDKaWjdIcJZmWdkwqbw6LYNlHlm9KOB5szv/Sf0UucHoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757061723; c=relaxed/simple;
	bh=hI1QhKE9ngNSTVbsYbJaaNM7S8C+MJKCTJmnTa8b1D8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b3aV2K3bfRFPG87eUjYmg49m4EqYrNYuSd8FtEspsZOIdUlVUMaAxHCNM+hlIa7q4jpb8hzOfTY5/0sTL62kp09BQKDQuOO56jT4KOWs8jt7Kq9K1GBk6lYI9BkfmGkBYZzxrR8mJbd1udJnY8yA3vl0rfFEOmyuWoZpx3zeaqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1hkJMX4o; arc=fail smtp.client-ip=40.107.223.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FKm8jkdfcXQaH1cckRX66C/Y0ATnEAyMdgDvKplG/Oq2/I8JCYk4ex1t55fFL8+bjambCOqKCC1UZA1X/NKGIlKFhBwddwRbugcu96jVnQ79qKxmIwNl/jl37qncvtBzR+/zjVq3lwoTf0G0jOjCe6LyL1NRqrBdDfynxePSReurqqGc+AlOiu8xXmrjkJqv1+Y4L3UZtsiqPISFnznSGlivvaxa0MIaGkz8nwfWkhfXysUBU+DXQ/4R5vpNCPW3kOp6ofA9YdelZTPxwh66zC+KRWJJgVEMhAozjNeapV3Qi4y3livPOl0GorAcJ4cUYBQ4ZBRO3kJw62qNTmGsEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11flfxD6snKsgNRqsfOH3e4lFmVKHQ8Q08YlCY29lOU=;
 b=PFwv0lrIQffmUyFZu8HCi3obFkwOUrFGLVuHL91TFxp1+vpFzQmsavoAFE5kbHZdYft3OZ56pggs834nqhkNuc6aqFhAwUfrR3ic7stbUUco8F94Y93CzYo+ijn/8VHyabT23bX9fIkghCR5MR/OtV+N807GLaSTSAacXvh4utjyrN2rc+wb5mvmSvH6qqmaASfBMNHlTnMf+egTHRFO/Iwyh/qjSlXHvm47HehbACA3u8sINApbG32ibTUBhnsxrZsdHH541ewyTqi7kGikhKEIng4hxZbLS2PgwnOc0ZltNexKeLFbYc3KwYE+jO5whfj6wEXpnyHonSPKdX59Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11flfxD6snKsgNRqsfOH3e4lFmVKHQ8Q08YlCY29lOU=;
 b=1hkJMX4oJ1rWqB76wpDk2iJUzWiOqVgq4MAyu6vmBYPvvkvORc4Fit+BFrgviJfkUu2hsnP4Wk245IZRMo0GKzyZEAih7YEIOke+JapUlhKl9yoX323RiQ+74Xx1OjQCcMFvbXtoBAmEf1DUIPIfdP7MjUQhApWwMux2TI/DuCI=
Received: from SJ0PR03CA0246.namprd03.prod.outlook.com (2603:10b6:a03:3a0::11)
 by LV3PR12MB9437.namprd12.prod.outlook.com (2603:10b6:408:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 08:41:57 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::5d) by SJ0PR03CA0246.outlook.office365.com
 (2603:10b6:a03:3a0::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.19 via Frontend Transport; Fri,
 5 Sep 2025 08:41:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Fri, 5 Sep 2025 08:41:56 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 5 Sep
 2025 03:41:55 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 5 Sep
 2025 03:41:54 -0500
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 5 Sep 2025 03:41:53 -0500
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Andy Shevchenko <andy@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>, David Lechner
	<dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Rob Herring <robh@kernel.org>, Salih Erim
	<salih.erim@amd.com>, Zhang Rui <rui.zhang@intel.com>, "open list:OPEN
 FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, "open
 list:THERMAL" <linux-pm@vger.kernel.org>
Subject: [PATCH 0/6] xilinx: Add support for Xilinx Sysmon IP
Date: Fri, 5 Sep 2025 10:41:43 +0200
Message-ID: <cover.1757061697.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1917; i=michal.simek@amd.com; h=from:subject:message-id; bh=hI1QhKE9ngNSTVbsYbJaaNM7S8C+MJKCTJmnTa8b1D8=; b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTsWuRxNPon26Elu6e1TfyzPoOlYW/jOdOS41Itt7RS/ rOLCy682FHKwiDGwSArpsgynUnHYc23a0vFlkfmw8xhZQIZwsDFKQATEbjEyHBGNkrMeXc4c/Np zilvdLqXvgqoOH79m57RIrGQf4s845cw/E9MfnBp/5I7Dhca7vLVf+L//vbClrsypj/dIlh5zn1 e/IsFAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|LV3PR12MB9437:EE_
X-MS-Office365-Filtering-Correlation-Id: 352cef9a-46f4-44cd-e1c0-08ddec58126c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gxqmo4ukZv1uTc+bfwt4sI0bnnyEPHClezdAr1x3RFi9RCGGIJEo+VkXlJ5s?=
 =?us-ascii?Q?nBz+4rKC4xeAEeRg0xOHlj0HEIKHi2XoYyp9JiY9SN4ufcGGFTXouvV+43fl?=
 =?us-ascii?Q?kJjDsAufq79ZjtGxcVOd1m8WHVKCKvnl9ESskbllxNkA1CdoNMX2K7ZXCupL?=
 =?us-ascii?Q?ILeIbzavz5e+GIJ+quHptc/zMOXSgkoWt1QFywyeQqoI+INUUpRDKPqObrj2?=
 =?us-ascii?Q?LKr+4o4afMDVmUQjc+qbltTqt3YnAcG9BSSKJ2bNjnKRwuCL0SUJozgcdeJr?=
 =?us-ascii?Q?j7tLVGFBWkVV8JAkOsPKB58vveeWKB0C6L6jc4XdytFHYlDlUXd36pcv8A0t?=
 =?us-ascii?Q?GNTaZlGDYWAUgQ0ZNXQWvV/MbeUacqgdWbkBgaSPDtoeb3//RHRABx44GFM/?=
 =?us-ascii?Q?L4MWouS0tSII+K/H9jwpPlMxqrMg5U8LqTZh8tg8eqIX1G/XB2WvZjYksUFn?=
 =?us-ascii?Q?6mE7efRZkQnkRLy3tbW9YNYGC1PcmAvcinV4yJVtxTXwiWPZ0t+LkNsEgWiw?=
 =?us-ascii?Q?DODH4+Yp+w3scbQpcFbutYyRazwvRoteBZXpsOoA7uqfAS2o+/ufzpViPUbm?=
 =?us-ascii?Q?jJMDnjRnA9rdzLXQoaP5ONMlsU3BwuSA/8/jqH/0Fpn4afzGNeASWCTqclYr?=
 =?us-ascii?Q?CytZLqjDqG2vg6ZAVnbBfP43v28PQjvEllIMPWWseZNFy0ytROOeexKXIvwX?=
 =?us-ascii?Q?iUG/htLNmqwRuwhGQ6G5TtZHyEtOetf5uu6RjnlOY0GtU2HtYdEnvx8qppQQ?=
 =?us-ascii?Q?NurdCserkbmOa+LTWkxJ73w7UPe61oapgaJb/q6RgdrQOwWvCO7aHFx9Qmo6?=
 =?us-ascii?Q?Z4GGxFDd1fLy1u8iAe3ZHX5O/YfR/dK1m33jO4P81apREgV5pV1k3dNFamul?=
 =?us-ascii?Q?1y79kCt0zgrmlMsFwB3OQ+DSdw4gJtCqagavK/IFOqgsjirla+E3gorNgTVr?=
 =?us-ascii?Q?NoWQnU5oLjgJl+gqOkqzlhuHueX281SNxK93jnlkZvnX6PTQj1AMArQ4R4d1?=
 =?us-ascii?Q?BQ3dMvx4vGOLor6cNNU4mxbuJgT6rGxzhK0xBRflyLL1No+drSQZWrgJAaGq?=
 =?us-ascii?Q?Rv1tJnEcLNyiUwzLoLQdPKrlwSFOXkFZo+LZcGYZKcgqLVzwlq7yjXl1UG3A?=
 =?us-ascii?Q?pbD7E1qL9OHgcLvlWxB4GYV3DezPQRHLctjaEMYGkSf/Ba7AOITKgNIzMRHa?=
 =?us-ascii?Q?JfsVbqGSth1PzeY3OaPW9O/UKyMY4XQXyTMNXYMvRK6Myh8kF0aoS+PjtKy3?=
 =?us-ascii?Q?ecfprOKyKV/LR9COaoDF8//zE17Ixz+nykW9MCRulll5M6YAkDj3XGO/m5ox?=
 =?us-ascii?Q?zVhUOgYxif9hbwjcL95M5Ua5Wlbq3MPzPBxeunRIUxoekflXj5Rgqe0HSZR2?=
 =?us-ascii?Q?Zsgb6cAqDNqcywgt9ErAteocgRZ5sC5CejyQObJg6JGp0BJaA4+GdO0n56FS?=
 =?us-ascii?Q?NXH3LbW6kw2QKUvsZJCxAIOxiX8Bt++Q/dG/Kx47lNwMetdQ6HtdYIPRhr1h?=
 =?us-ascii?Q?g4CBRdkauLWQtqrTNM8NihgIw1kFFTdvxHPS?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 08:41:56.5536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 352cef9a-46f4-44cd-e1c0-08ddec58126c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9437

Hi,

the series is adding support for Xilinx Sysmon IP available on Versal SOCs.
The series also contains thermal driver which is using Sysmon for providing
temperature information.
As the part of it is also monitoring AI engine.

Thanks,
Michal


Anish Kadamathikuttiyil Karthikeyan Pillai (2):
  iio: adc: versal-sysmon: Support AI Engine thermal monitoring
  thermal: versal-thermal: Support thermal management in AI Engine

Salih Erim (4):
  dt-bindings: iio: xilinx: Add Documentation for Sysmon
  iio: versal-sysmon: add driver for Versal Sysmon
  dt-bindings: thermal: versal: Add description for Versal Thermal
  thermal: versal-thermal: Add Versal thermal driver

 .../bindings/iio/adc/xlnx,versal-sysmon.yaml  |  235 +++
 .../bindings/thermal/xlnx,versal-thermal.yaml |   45 +
 MAINTAINERS                                   |   13 +
 drivers/iio/adc/Kconfig                       |   15 +
 drivers/iio/adc/Makefile                      |    2 +
 drivers/iio/adc/versal-sysmon-core.c          | 1379 +++++++++++++++++
 drivers/iio/adc/versal-sysmon.c               |  297 ++++
 drivers/iio/adc/versal-sysmon.h               |  278 ++++
 drivers/thermal/Kconfig                       |   12 +
 drivers/thermal/Makefile                      |    1 +
 drivers/thermal/versal_thermal.c              |  221 +++
 include/linux/iio/adc/versal-sysmon-events.h  |   56 +
 12 files changed, 2554 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/xlnx,versal-sysmon.yaml
 create mode 100644 Documentation/devicetree/bindings/thermal/xlnx,versal-thermal.yaml
 create mode 100644 drivers/iio/adc/versal-sysmon-core.c
 create mode 100644 drivers/iio/adc/versal-sysmon.c
 create mode 100644 drivers/iio/adc/versal-sysmon.h
 create mode 100644 drivers/thermal/versal_thermal.c
 create mode 100644 include/linux/iio/adc/versal-sysmon-events.h

-- 
2.43.0


