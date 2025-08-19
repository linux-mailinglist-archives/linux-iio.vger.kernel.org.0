Return-Path: <linux-iio+bounces-22999-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C7CB2C815
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 17:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB3035C410E
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 15:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E457427FB2D;
	Tue, 19 Aug 2025 15:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nOjVpYf1"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2077.outbound.protection.outlook.com [40.107.101.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDEE27F18F;
	Tue, 19 Aug 2025 15:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755615918; cv=fail; b=lGRnWr36C1dB+xs+2nVLOc4/P1Zkv8T3VYU8J0qr7A0NC9btI1zak3yOtFxZ5QpGq1TEgop/o4lLRjaP3cBPCWI1kF5yWqzs2EKKPY11/a94eoqJuTKZBbTgRBBCekav5O3nNxeXzh/ai1rEhMQOkPMpDDqFwG7B31/3TYsFga4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755615918; c=relaxed/simple;
	bh=BOeZQEkuzH4H4Zb2M5ex+1BSGiLSzTz2Y8uLYAIvCok=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WkSGFz8aQ2EnTK2Kk9AQmezrFn8XV7hRK+GJydAHs6wS/dzkRchC9SHtssL/dJjBO6J4Q6AcWrJbOArYFcbuBzQMC6fxpmygMxZE5TFwUZPN0m9M7V+bFVFhOMD+dPDZ8vkFsyraZ8XwKUXCmQ0lVqR0vn2kQFU/BPknurOH3aA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nOjVpYf1; arc=fail smtp.client-ip=40.107.101.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vDxpsz3oTrU5CVl1Ke4h2zJYrvp1LQTtr/XoHls+oLG6QR2xxjEWqf4fDxurLjjbxKULC7mBGgP1RSptLIv3WwfGT9w9Zwbl7bclDfgBs228NuDGMd4qZ01mWFPzgSIdTDstf0MrHXASPOG+OFU8X5W4IHXO82/arbNuLt1PNO02rUBecONJvYQdCk82c/I0h90CNLhLlLvwKA0Rw3e2qPcDLDJ2w8cPs8K6vTpZjbxzF38QmNQvGZFyVfVOq4QajMu3KG8FvkXWID1A+03EnROkJfMz8BrV+kpe1sTLT1f1YOm8zRFxv5Uj9QMpEeiNbvTaVq/HFjPc2GmxIzq3HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EUj+GcilTQNry3tbuJmUG8ur83xO/rILt9yNghGiIFA=;
 b=T3AXFOJx6/A6h3SWqI6ljwoR6Vqs67OLD/7Z09odOKz2NPV+wAHokJI0hwwImpVjXZu51HIM94lCMbqirlSMs1mPSCHIQao+tDY8wPh3D56fn6mQh4hPbG+X7taweDBlFValf1jqanzQppjqZvSsIxxB0QugQNhV00pAu9cEIC9sKXBsjzZYSmth6IiOl10CKBIF0JpRo0BcXxRd9NwB49k2EJY3T1/BhtrrIx5SN5kH7wsiWRaeH0nF/BDj7BhkLFe9YQiF3qwRN44FDkToIFITyZTmIZA+LFkhgutCqO9kqjUC8c3PAI8NIdctajCecYA7CPsb062ze7XmsSIafw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUj+GcilTQNry3tbuJmUG8ur83xO/rILt9yNghGiIFA=;
 b=nOjVpYf1K+D/lchixbN7ahuEgbXkFxH2vNGPq531oLl7ILnqtJdI9NG+bu/SaUt+D81Pu6MMRzxsdFlJy0ddcngdExXVb+a+4IkRmY+9emFt9Yd5YzPtmr0JqkOlfbp1P0+ZsR+HiE9/WABUCBmhurHFbqOhptiUiWa240DumIc=
Received: from BN0PR02CA0033.namprd02.prod.outlook.com (2603:10b6:408:e5::8)
 by CYYPR12MB8937.namprd12.prod.outlook.com (2603:10b6:930:cb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 15:05:12 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:408:e5:cafe::57) by BN0PR02CA0033.outlook.office365.com
 (2603:10b6:408:e5::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.13 via Frontend Transport; Tue,
 19 Aug 2025 15:05:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Tue, 19 Aug 2025 15:05:12 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Aug
 2025 10:05:11 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Aug
 2025 10:05:11 -0500
Received: from xirsalihe40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 19 Aug 2025 10:05:10 -0500
From: Salih Erim <salih.erim@amd.com>
To: <salih.erim@amd.com>, <conall.ogriofa@amd.com>, <jic23@kernel.org>
CC: <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
	<michal.simek@amd.com>, <linux-iio@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: [PATCH] MAINTAINERS: Update xilinx-ams driver maintainers
Date: Tue, 19 Aug 2025 16:04:48 +0100
Message-ID: <20250819150448.1979170-1-salih.erim@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: salih.erim@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|CYYPR12MB8937:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d7fd2a4-8901-40a7-5e1a-08dddf31cbc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y6ZfhsIoYVuFmkFgs2vRTOBXAv1WyxV7VGFRFuGMpI9QSwObNLD2zu6UkDiP?=
 =?us-ascii?Q?BtxEWv6HRGsBw0n5a9bWv6xUTso459tVm0gXSUxKPsZLr3huApZXDSyngzfQ?=
 =?us-ascii?Q?fIUhHyvgHp9z2zQNqhXzX71ntk+oY9yf5YBitmikAL4byrcmbMCG5FB01gt3?=
 =?us-ascii?Q?G9xLlXu8W6ZagQ9AdZOhxBBRHmHb1f728suUKO2tT/6hAcNwMCXAedEiHXrX?=
 =?us-ascii?Q?Oza3Qdia0mD6eeS7QgEHBp1f7HFQtmPuJW/JK1wYPmMmvb7Wd6puEvzE/Xtg?=
 =?us-ascii?Q?asYr1PG2XdE3ftWZAPMhOE34am1lnZw15UXvayCwBDwkPWrf5UMJ/WvQZ1vZ?=
 =?us-ascii?Q?Cw1d9PRp/+1xt5Eg8UMvaDfPHLFFqQkxJIX3x8cNvcDiHFjOPO1DYALatk0a?=
 =?us-ascii?Q?pmjf7+khvHQ/NR6wKpB3xNa0kskeflF3jMm7Ybh0BgwnMD9Wyv52nfWN3Yhq?=
 =?us-ascii?Q?aGQrj5uQTCcyJhw7gzu5ugY0QRjm2CPtk64SzDVgpz7PSLAh3JMEVD5dqkUc?=
 =?us-ascii?Q?rbacFdQ9BOBHZIMcjgQoRw1g5cbseZMyezjBFr0a+VggDug8CG98JZ9Fm6+/?=
 =?us-ascii?Q?b2eLrRkzPgIayNdJ7NYbeEz20sOvocJMHtiSAj/9Jaii28wEy+BjJF1Z0W4+?=
 =?us-ascii?Q?zZgA3V5zrcg41ZXqp3RVtL80gcPJB93kDmH+Vk1mQIWUrD50d+ud//22nGB0?=
 =?us-ascii?Q?R0F86WWYNd9ekeL8ughRc72Re0rnZ2VKLGuwjac2IRca/JoMflEzqziqr6ol?=
 =?us-ascii?Q?L0ZWg5Adat2wwX3T6XNkmRqjCNY6abs2DrEkaHsi/AoFMnZALTPlsIR6zuTX?=
 =?us-ascii?Q?yXxSzxYgRB0/l0n+1pNBzj+hNSBTP3iyXZk/924tm07J6N6ddsZ9Dx2pqOl4?=
 =?us-ascii?Q?Km9KUUUYCw9PUy9cTQC2ZfQqprO3KAGvt8bZ18AwXoSe8ZjINSnh0hwV23gG?=
 =?us-ascii?Q?4geokLRDUWqtxBy+ePZly7o/reShBoPOi0fUDSOYvXId7edvHSAgwdmDO6Z9?=
 =?us-ascii?Q?2E1BWdwJKQ8zTWp+y9xcz9UP6+zwNHYrEtCmXR+voqfGxQrlJdKpo4XaYmN1?=
 =?us-ascii?Q?nqEvOuihWx82deu5yQJi48GCeZVNF9I0zGrXQ32JqAvMQRvGGfXPyAhTSXd2?=
 =?us-ascii?Q?NB9eFammUXwqj/GBQiznGTLsrokbpTbaer3wlDDkwaFMyQBc1sx5WaQdxgoX?=
 =?us-ascii?Q?3DBevr/Rj7RXVZA5AghG4cqJ6AaYjUGGTlkhJfYBN6R6yIrkWDm16UUIVYb6?=
 =?us-ascii?Q?Fpo2A8dXwm4zyEA5+stx99Z7UULkXSjAaYURuZqy4g9jb3o4CtW8ky3o3CpN?=
 =?us-ascii?Q?GahQ4ZVPQQz1hhQbPUHh+W/4g/2QPauqH54VAO7K8Wv81i8LwTHuhqlW0orH?=
 =?us-ascii?Q?Hi5WYDrkb7z8SQA+OL5gTF6JrBhQtUcVtXS7VoHF6QVOpsFxVuwOlRbSxRBx?=
 =?us-ascii?Q?IakycHtNRKJSmH4OjlG4f7tnVceU0ucoUUOVQ53g2OZSpa39ejbIFA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 15:05:12.0983
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d7fd2a4-8901-40a7-5e1a-08dddf31cbc3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8937

Removes Anand Ashok from maintainers and adds Salih
and Conall as new maintainers.

Signed-off-by: Salih Erim <salih.erim@amd.com>
---
 Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml | 3 ++-
 MAINTAINERS                                                    | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml b/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
index a403392fb263..3ae1a0bab38f 100644
--- a/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
@@ -7,7 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Xilinx Zynq Ultrascale AMS controller

 maintainers:
-  - Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
+  - Salih Erim <salih.erim@amd.com>
+  - Conall O'Griofa <conall.ogriofa@amd.com>

 description: |
   The AMS (Analog Monitoring System) includes an ADC as well as on-chip sensors
diff --git a/MAINTAINERS b/MAINTAINERS
index daf520a13bdf..b4b27a31a782 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27537,7 +27537,8 @@ F:	include/uapi/linux/dqblk_xfs.h
 F:	include/uapi/linux/fsmap.h

 XILINX AMS DRIVER
-M:	Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
+M:	Salih Erim <salih.erim@amd.com>
+M:	Conall O'Griofa <conall.ogriofa@amd.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
--
2.34.1


