Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64EA07A5C1A
	for <lists+linux-iio@lfdr.de>; Tue, 19 Sep 2023 10:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbjISILr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Sep 2023 04:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjISILo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Sep 2023 04:11:44 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F215A11A;
        Tue, 19 Sep 2023 01:11:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MlKMkJ/3WJGXAv/ImgxACyrtiBwtJcuaAjSU81+oIEK+g5X/3Ya5doGxEt6m0GzKxxrMw39oDS68BcMLgXLRWtXluyzur4Nj42yC8g058KvxwxsMok06qP7ZQ0ncTejTUk55fUuZY6b0vS6JX8lfQ6Uor452wNwNYzkHRpnYMVZj2zh9jBzL9MLm6dvL15CZMizRo3bwcvMxxcT4ykriOywGPOpi3GSF80MV/ZM0/bLGBS8Aq+chblrPatnZ+dnz6BDvSJT3vQxXuYo/+Y0Zd15MuJtg6L5uX32TNPgCRoX3RMxWuEk9Z1ofjMZtn8leZYHa6U6re4B/4pCZCK3Azw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/BjVjzAJB7A3O5Ec7LWjrn0PESlN8X3HAxGueCUxso=;
 b=GjBC0NCrBHB169lRaz3dEcSU93FMljuVQ20sqjQjYnrUJKI0aB8SbFYT2BTfTUlmAnYAd7KWAtrS7rf2qx/GSA3W1T0wgbVUNlLbUGzBajEWPNsXyqSFN/iGgvRHJabGMy33hTpu0jrAnMaVaSymdYxyHaGaeSoexCpvo+EdfbDdVBR8WdVDZ6xdBa0uJjQ0iddh5wv+aqGTV6bcvR524HywevhLkN9qEX5kAEdRy5EQmkaN4WctW6kq4PM/FAlRBq4GlkN7UQY6/TIBd/nl1J3qdRmI7+nYbg7ZscrtB4E1Te02Xe30pTECccMOpPh/64E/m30/e0jtwmK03yc6kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/BjVjzAJB7A3O5Ec7LWjrn0PESlN8X3HAxGueCUxso=;
 b=txFGxU6/7yPZqBu6N36jlFFij/01bcn2beFHD8qHsnOK8lHCilIgfpsbdUOJr1ry3MDgTSjXMXyjlOuGq8ldpvrduJWXtWoQ3Av1pgiSit6uZN2thsXXMFzhQFsL/MWQgBwIp8jxq653iXsET7oubRQwJrZPxMaTnH3K08yTAqg=
Received: from MW4PR04CA0063.namprd04.prod.outlook.com (2603:10b6:303:6b::8)
 by DS0PR12MB7876.namprd12.prod.outlook.com (2603:10b6:8:148::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Tue, 19 Sep
 2023 08:11:33 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:303:6b:cafe::d6) by MW4PR04CA0063.outlook.office365.com
 (2603:10b6:303:6b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28 via Frontend
 Transport; Tue, 19 Sep 2023 08:11:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Tue, 19 Sep 2023 08:11:32 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 03:11:29 -0500
From:   Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To:     <jikos@kernel.org>, <benjamin.tissoires@redhat.com>,
        <jic23@kernel.org>, <lars@metafoo.de>,
        <srinivas.pandruvada@linux.intel.com>,
        <linux-input@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v2 4/9] HID: amd_sfh: Add support for light color temperature
Date:   Tue, 19 Sep 2023 13:40:49 +0530
Message-ID: <20230919081054.2050714-5-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|DS0PR12MB7876:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f9e5029-fbda-45f4-794d-08dbb8e808db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /8K3XuBTg+aiNnUu6WjVzZIqYuorS2S8XjvsZZsNXNbhQ+ohypon/uZKKbEQ0H7joNPpUFPwzJbSbReUAIh21wcCXdHKJ9XRDAXeTSDfgnAhnADaWMFIfzF6eV9M+UkOhBUsmDgV3zZl1gDBlkaSGrzLw6qzpqHV6kC0tb83xPK+Wq/1nlTIy0F5HkcWWeOUtdQUVPpFyf9U+L7woRhDYvGGPOtoJax/YSx0nJCFDP3LFohRyG9d7IWFdo8CtQaNKBZ0TLn0OCJCnQF2b7aivN8yYJUnxUmVbmHWSDYD2JWyI9rBu8pBTuwTUupkOpdAWC/WNX1bHtGG02EMeee2eSTCx4FIjrB0FT5JkzLPmscUsLapHvAPnjQlTUUeRA+ItYbN5aQxNsU0ziePY+uK4c+41AJQry7kCNg1La4xTzS4FQ/CusgPjgSh0vUjnQlyQbQGNG+je8xnsYuR+1kHloRUVy+8UpRpf9XSCJAXr7LWqe2CxJOEyS9eoWOCyraL9oL8L92Pg8O7YcIArXTv4O9bbvRKLQWYIlTDUSATr+3v/Rk2GgOhZDHXq7PnpXmc7gOVv5Pm2lciedapIbqqP/TI0VCjUbD2htTLWd2q0VtCFgS+7Q36PvNUHPpNHRvy+whPLxGr5lyEmvLo2g9GKhvIewmbH1RcFb7r5g2CEICKy1s0Hkr4P+elQRh/U7Hlk/v0GXOLcln9euESj0Jtntcu/oyYFS5zUKQbw55g2gCZIFNIgQR3W9QZAotJQuxH47Uoof0XxPC41O7w/z5mMw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199024)(186009)(82310400011)(1800799009)(40470700004)(46966006)(36840700001)(6666004)(40480700001)(7696005)(86362001)(316002)(41300700001)(70586007)(70206006)(110136005)(478600001)(5660300002)(8936002)(8676002)(2616005)(356005)(81166007)(82740400003)(16526019)(26005)(2906002)(36860700001)(426003)(36756003)(336012)(47076005)(40460700003)(1076003)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 08:11:32.1862
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f9e5029-fbda-45f4-794d-08dbb8e808db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7876
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In most cases, ambient color sensors also support light color temperature.
As a result, add support of light color temperature.

Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c  | 4 ++++
 drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h  | 1 +
 .../amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h   | 7 +++++++
 3 files changed, 12 insertions(+)

diff --git a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c
index 8716a05950c8..b7e732ec4806 100644
--- a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c
+++ b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c
@@ -257,6 +257,10 @@ static u8 get_input_report(u8 current_index, int sensor_idx, int report_id,
 		else
 			als_input.illuminance_value =
 				(int)sensor_virt_addr[0] / AMD_SFH_FW_MULTIPLIER;
+
+		if (sensor_idx == ACS_IDX)
+			als_input.light_color_temp = sensor_virt_addr[1];
+
 		report_size = sizeof(als_input);
 		memcpy(input_report, &als_input, sizeof(als_input));
 		break;
diff --git a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h
index ebd55675eb62..a7fc50deca4d 100644
--- a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h
+++ b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h
@@ -99,6 +99,7 @@ struct als_input_report {
 	struct common_input_property common_property;
 	/* values specific to this sensor */
 	int illuminance_value;
+	int light_color_temp;
 } __packed;
 
 struct hpd_feature_report {
diff --git a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h
index 697f2791ea9c..26e994e54ded 100644
--- a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h
+++ b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h
@@ -641,6 +641,13 @@ static const u8 als_report_descriptor[] = {
 0x75, 32,		/* HID report size(32) */
 0x95, 1,		/* HID report count (1) */
 0X81, 0x02,		/* HID Input (Data_Arr_Abs) */
+0x0A, 0xD2, 0x04,	/* HID usage sensor data light temperature */
+0x17, 0x00, 0x00, 0x01, 0x80,	 /* HID logical Min_32 */
+0x27, 0xFF, 0xFF, 0xFF, 0x7F,	 /* HID logical Max_32 */
+0x55, 0x0,		/* HID unit exponent(0x0) */
+0x75, 32,		/* HID report size(32) */
+0x95, 1,		/* HID report count (1) */
+0X81, 0x02,		/* HID Input (Data_Arr_Abs) */
 0xC0			/* HID end collection */
 };
 
-- 
2.25.1

