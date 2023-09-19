Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FC37A5C29
	for <lists+linux-iio@lfdr.de>; Tue, 19 Sep 2023 10:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjISIMF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Sep 2023 04:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjISILy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Sep 2023 04:11:54 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2082.outbound.protection.outlook.com [40.107.212.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC2F128;
        Tue, 19 Sep 2023 01:11:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNYBKre6EX4TDFPDBuTGvjinLu17+UR4+s9YCvGiVO7XgoxHPJeOYb4UJ2QyH9W+R+Yo+uB7pZ7qeAJ+AoGbibCvp7ybiEm+j+aC8snu+PVmXciMfrkUjeW+4RN+gvpeZuojXMpQ5FjmMLAIRgu+0xUYbAA7RaCMooY95remTljdo7yAyYjcmAz4+jqVGaHioa60d6GFWFeZGmoXsOwvTLveGL4c2szgMouWv/zH8Ihbr7yI6tBe7T6leAI1A7Fs0RHbv2ngKDm6EJNcBK6gbk+VqgOiOC9tcCcXFhcUUc2s/kXiE+p3BbOqmUATWEmY83ixXWeE3GHC9AEPIw6fmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uaW9ndZ6fil1wmCgqAoOdbhpctkg3+X8/ea5itEqowc=;
 b=RSAX6T6AXKAYi1K2ng59Fq83MD6IJUY6hMgXCLYsIgsBty6+CCK98EqfSN9kTNZobYCAhWgHziTuevV0FldSAUUm0OmKmGDEfVqP9RjDvGIomSlzEO8B1AZK4yGA6NcjwTnPi7zglIYf8FGrmGlewFJCmFSSVWRjey6UMcTUSgbPlqZs8N70gbfHd2oRN83szrLuGPDFUCDzXk6QCvCpvx7UfZ1dZlNnPpGATPfQ4qBlmUvpT3VLRD0IyNkqTvf+9D+BXOfc5OXjb7gKIiHtYODY/4DLGgIMBKhz4qvLYgER2N81UQJcWf7y4Ci74AaF222hxDi2V4hEI2TgTNQndw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uaW9ndZ6fil1wmCgqAoOdbhpctkg3+X8/ea5itEqowc=;
 b=Q3BZKuiXB63gdj2HgeNKyHbBcY5AJO+DvZd5aR5EZsd9jgQiQkewkXWO2L6k0iFjUC4kJpcvn7GxZ5H5Oayu8DMRNyzqQrXYrWWJ3NbHEdHCV2lOe45sNZcbtAUQVbqDJu2rah7dTLNBwmdYSDnexmMGZVH7b6Oo8kUk/AsHVso=
Received: from BYAPR21CA0017.namprd21.prod.outlook.com (2603:10b6:a03:114::27)
 by PH7PR12MB5950.namprd12.prod.outlook.com (2603:10b6:510:1d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Tue, 19 Sep
 2023 08:11:45 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a03:114:cafe::b) by BYAPR21CA0017.outlook.office365.com
 (2603:10b6:a03:114::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.4 via Frontend
 Transport; Tue, 19 Sep 2023 08:11:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Tue, 19 Sep 2023 08:11:44 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 03:11:40 -0500
From:   Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To:     <jikos@kernel.org>, <benjamin.tissoires@redhat.com>,
        <jic23@kernel.org>, <lars@metafoo.de>,
        <srinivas.pandruvada@linux.intel.com>,
        <linux-input@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v2 8/9] HID: amd_sfh: Add light chromaticity support
Date:   Tue, 19 Sep 2023 13:40:53 +0530
Message-ID: <20230919081054.2050714-9-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|PH7PR12MB5950:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b6be82e-0aa7-4abb-b86e-08dbb8e81042
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y2cecF5sXQr3DyAxLWlZBLY/QA49a8cpOeCMcKd+Xl6k6KQewdtoAzeQojnjIQ1RVkLWuvnpIZl++ejzWaLPs1tpmFrePrCIqRX+/A/OT47sLQtS0xMpNU5u28pcF9T8BBDz8uiGEWv3c6yx9oTbIvZHUS+vUvU88icouAigeG6SAsW6SFEzf4raGCqXbYjRpaS6lAt2bkQiEVwIAdJe3wtxUGcUICFSHhPWH5YTJwl+I4o2AMpBaGmPTrLA8kubgDm11/AFWmC8pnufOI6dTiiwMM/PHnRhVbl6njUOmS+0UdF+4hx6emb1X4xFilRAddsynHjQ+S57+OQDvjAzLEEfxPOy2hClM/Xya7oIsfccyrz+mk55jYjyvVAHLSk8x/ZId2aMgfgljUZm1lmSdLUu19ywuaYf4OY5+gXcqKU3K063T8mDmmzFgLtsR9kZ1wt30NZK7l+4ZOVajYHsYyltzxkIrzdlRJ9bHsPHilyK9LJPfE06N/jSi1+e+b8pfvVTl53uOwYBKi5Wxzu2qdIIUAmHNXi+wY+15iPnNpKSpLFRaSwtjFOOAS1Va8wUjVIHtmvYdUQlq/by9uMZCMX+eB0OPd9hMUBsr1jk+4ljmv/8h48yp/iK/a6bujyyhbgvu/4k8eyy6/tXySLROlpmaJYGsnhK9KUbdUM7L9wsiHSr7oFFZY2/svN+KdEWPOZUKmKln8cum8U2Qse8tO+IPCC+yK1/ILc2gBgYSjZ20BcjM4G/nvFWMsehis3uWvOAi114bgg2za/Azzhobw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(39860400002)(396003)(1800799009)(82310400011)(186009)(451199024)(40470700004)(36840700001)(46966006)(356005)(81166007)(26005)(82740400003)(8936002)(2616005)(16526019)(8676002)(1076003)(40460700003)(4326008)(83380400001)(36860700001)(2906002)(36756003)(47076005)(336012)(426003)(40480700001)(5660300002)(86362001)(7696005)(478600001)(6666004)(316002)(70206006)(70586007)(110136005)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 08:11:44.6226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b6be82e-0aa7-4abb-b86e-08dbb8e81042
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5950
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
diagram. Thus, add light chromaticity x and y.

Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 .../amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c  |  5 ++++-
 .../amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h  |  2 ++
 .../hid_descriptor/amd_sfh_hid_report_desc.h       | 14 ++++++++++++++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c
index b7e732ec4806..ef1f9be8b893 100644
--- a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c
+++ b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c
@@ -258,8 +258,11 @@ static u8 get_input_report(u8 current_index, int sensor_idx, int report_id,
 			als_input.illuminance_value =
 				(int)sensor_virt_addr[0] / AMD_SFH_FW_MULTIPLIER;
 
-		if (sensor_idx == ACS_IDX)
+		if (sensor_idx == ACS_IDX) {
 			als_input.light_color_temp = sensor_virt_addr[1];
+			als_input.chromaticity_x_value = sensor_virt_addr[2];
+			als_input.chromaticity_y_value = sensor_virt_addr[3];
+		}
 
 		report_size = sizeof(als_input);
 		memcpy(input_report, &als_input, sizeof(als_input));
diff --git a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h
index a7fc50deca4d..882434b1501f 100644
--- a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h
+++ b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h
@@ -100,6 +100,8 @@ struct als_input_report {
 	/* values specific to this sensor */
 	int illuminance_value;
 	int light_color_temp;
+	int chromaticity_x_value;
+	int chromaticity_y_value;
 } __packed;
 
 struct hpd_feature_report {
diff --git a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h
index 26e994e54ded..67ec2d6a417d 100644
--- a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h
+++ b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h
@@ -648,6 +648,20 @@ static const u8 als_report_descriptor[] = {
 0x75, 32,		/* HID report size(32) */
 0x95, 1,		/* HID report count (1) */
 0X81, 0x02,		/* HID Input (Data_Arr_Abs) */
+0x0A, 0xD4, 0x04,       /* HID usage sensor data light chromaticity_x */
+0x17, 0x00, 0x00, 0x01, 0x80,	 /* HID logical Min_32 */
+0x27, 0xFF, 0xFF, 0xFF, 0x7F,	 /* HID logical Max_32 */
+0x55, 0x0,		/* HID unit exponent(0x0) */
+0x75, 32,		/* HID report size(32) */
+0x95, 1,		/* HID report count(1) */
+0X81, 0x02,		/* HID Input (Data_Var_Abs) */
+0x0A, 0xD5, 0x04,       /* HID usage sensor data light chromaticity_y */
+0x17, 0x00, 0x00, 0x01, 0x80,	 /* HID logical Min_32 */
+0x27, 0xFF, 0xFF, 0xFF, 0x7F,	 /* HID logical Max_32 */
+0x55, 0x0,		/* HID unit exponent(0x0) */
+0x75, 32,		/* HID report size(32) */
+0x95, 1,		/* HID report count (1) */
+0X81, 0x02,		/* HID Input (Data_Var_Abs) */
 0xC0			/* HID end collection */
 };
 
-- 
2.25.1

