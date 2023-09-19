Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E667A5C2B
	for <lists+linux-iio@lfdr.de>; Tue, 19 Sep 2023 10:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjISIMI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Sep 2023 04:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbjISIMC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Sep 2023 04:12:02 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9A4197;
        Tue, 19 Sep 2023 01:11:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehU/6wETGHNHtJ2nd84PXweGTbXEpXYW38Nun85TU8NG/LWv8Lq1i2zta3ahc/+fYDDMLCqQYF3HoVWcqBU7laNCvRMleSZx0iPuuHbzTfiqwfTLFKTm7qBJ1Fbnu6kRhFhex1UXcWFnEuH473mbPf9fTvadMKlxVKEJUnN/pS8LWJx/gTO+y7m0zrXqroicmxcdU1/Mb6pqZin6YMvTvGfzMnqv53oHerF8VBsrDPavKdwlnSxYAHDT0b/bXwfK8LpbBykPNZqowrnF5tYFk906sQPiVS2Lof9wzQBy9vIIb7mUFv3sLy2bTI8sTrKokMjGLzoVmWMXsXqNk6JjqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BRttNnP96aTPXTUOo6HAVcO1CoeD7W1mXfqZ/tJJmZU=;
 b=HfpDXpW79wYDU7LoLoTp+hcredY9MQzgWkWG+QIUcGWc0zhj60XslFozbVssukvGL4AyBj/G3ijJkXbQyihgoP2WbTK7Xv/5u7zLfyFbdAhbAuIwcTqihzilUPe0sWT3RlUi3kixKkGSKxY6VfnzRb5g/OIXPgOCX9DXlv6meE9qguYlCGb8ldDIINsH47fIzxPbuzwFGHVU57mUm86GM9vb67LHGyhRpkp++eUellLIIKz6Obq0/Nj59d8Yz1LqgPacr8o3/+JS6AF0ryihREgCwFdk7MKZ1IFUvHoap2TG68KBEPHY7ORX/Wb4zhGNVfrdeIL46edYgeHsOCujfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BRttNnP96aTPXTUOo6HAVcO1CoeD7W1mXfqZ/tJJmZU=;
 b=UjCrodRmUoQFN/LDbeMM84Jt7dKCrbA/mXBiRPBpGDRqTD4wH5OaFaLv6CKLr4BlSyUWA9qj2cy9omjs83aFPfRq3lSa9WZG0YhJfK13CZmRkqlEWLzBnFPGklcqnLyVauH1pPYl9bkqQn7OAtA5MByRHa01l/Fll5W9ilIczpw=
Received: from MW4PR04CA0062.namprd04.prod.outlook.com (2603:10b6:303:6b::7)
 by MN2PR12MB4046.namprd12.prod.outlook.com (2603:10b6:208:1da::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Tue, 19 Sep
 2023 08:11:48 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:303:6b:cafe::c0) by MW4PR04CA0062.outlook.office365.com
 (2603:10b6:303:6b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Tue, 19 Sep 2023 08:11:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Tue, 19 Sep 2023 08:11:47 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 03:11:44 -0500
From:   Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To:     <jikos@kernel.org>, <benjamin.tissoires@redhat.com>,
        <jic23@kernel.org>, <lars@metafoo.de>,
        <srinivas.pandruvada@linux.intel.com>,
        <linux-input@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v2 9/9] HID: amd_sfh: Add light chromaticity for SFH1.1
Date:   Tue, 19 Sep 2023 13:40:54 +0530
Message-ID: <20230919081054.2050714-10-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230919081054.2050714-1-Basavaraj.Natikar@amd.com>
References: <20230919081054.2050714-1-Basavaraj.Natikar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|MN2PR12MB4046:EE_
X-MS-Office365-Filtering-Correlation-Id: ee221716-0782-4b78-397f-08dbb8e811f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nLA5dWu7yMjcGNYl0aKJ4izDVz7JBTJ6SH2o26b75irPAespa+0wYsc3dZgRq6JghCMgxpB+Inr85Hnf96kIK3l9BlvnVQDyyOkeRHMxCmRIauqlKIy0U8Vu45rv2PkoYjQTcte/rGQ/xULQw8dUuO8NoXL8oBBig2iG56u20t7nK/QooQNXBpoIPR66e0BcN88Yx0EwitASJVGuI3wufiLim3zje262wcenBDbrxD8iO1js6VTFnRT95fmd5ivG3HtDpwuI+QNv8C0iyEvxZ6FGCDhTAQ2kWol9hxTrk9Yf8WdweI7FLvHqTCUwjpGxxvME3fAwfqhlIMhre1DewV75u20LOTKM306GB4i4T6pxRfrGw6X65XkKZQEduhRUQiiNuk6ddHJeCjcyFADRlXMabmfHYK1wK/JxmEkdwcIEi5K123OJKkAa+8MC5fQqBqjClrFw66SVxXkADQwWAq8RXy3cHtbIUW/RM7PlglBhhBFChpEaxbRsflqpjvfP3drO+OEscEpIqk5MaTTqBnxMPDriWzVTRT0PAXNisZ+gE+n5awFkPHxOvZao8EX78VgpC1iAvQcsuvJKwBYsc9Xrx6PPFGwUJjziCuVZwLd0CWRjTwlfMQqy+brFD4H2FhRlbRbjCaCppfNonsOF7Mpdx4PjADCCixgU0rHbDG10ZxFGR3MP4UICqDn4gm/5h2PJt1zSgfFWDXzhH6rRHEfNmHh0FsBkja0/aBIFw3cmHqtrPIcflqBBkvdKmSqNOrgP4xAnOwiHa2Bzx3B6lg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199024)(82310400011)(1800799009)(186009)(46966006)(36840700001)(40470700004)(2906002)(40460700003)(83380400001)(1076003)(36756003)(86362001)(7696005)(6666004)(478600001)(2616005)(426003)(336012)(16526019)(26005)(40480700001)(8936002)(8676002)(4326008)(36860700001)(41300700001)(47076005)(5660300002)(316002)(356005)(81166007)(110136005)(70206006)(70586007)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 08:11:47.4832
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee221716-0782-4b78-397f-08dbb8e811f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In most cases, ambient color sensors also support the x and y light
colors, which represent the coordinates on the CIE 1931 chromaticity
diagram. Thus, add light chromaticity x and y for SFH1.1.

Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c      | 5 ++++-
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c
index f100aaafa167..8a037de08e92 100644
--- a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c
+++ b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c
@@ -238,8 +238,11 @@ static u8 get_input_rep(u8 current_index, int sensor_idx, int report_id,
 		als_input.illuminance_value = float_to_int(als_data.lux);
 
 		memcpy_fromio(&binfo, mp2->vsbase, sizeof(struct sfh_base_info));
-		if (binfo.sbase.s_prop[ALS_IDX].sf.feat & 0x2)
+		if (binfo.sbase.s_prop[ALS_IDX].sf.feat & 0x2) {
 			als_input.light_color_temp = als_data.light_color_temp;
+			als_input.chromaticity_x_value = float_to_int(als_data.chromaticity_x);
+			als_input.chromaticity_y_value = float_to_int(als_data.chromaticity_y);
+		}
 
 		report_size = sizeof(als_input);
 		memcpy(input_report, &als_input, sizeof(als_input));
diff --git a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h
index 6f6f5db150c3..656c3e95ef8c 100644
--- a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h
+++ b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h
@@ -147,6 +147,8 @@ struct sfh_als_data {
 	struct sfh_common_data commondata;
 	u32 lux;
 	u32 light_color_temp;
+	u32 chromaticity_x;
+	u32 chromaticity_y;
 };
 
 struct hpd_status {
-- 
2.25.1

