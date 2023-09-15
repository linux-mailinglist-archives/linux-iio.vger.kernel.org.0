Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03437A154A
	for <lists+linux-iio@lfdr.de>; Fri, 15 Sep 2023 07:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbjIOFSG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Sep 2023 01:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbjIOFSE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Sep 2023 01:18:04 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFECE2715;
        Thu, 14 Sep 2023 22:17:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8NVh1ESSg6okQna9JDlEkReg81nXI7KmIIVBM4K23YBgWsVADSU54Ls/ZZYivJS1xXbva6hwPlaWZyMAmVBiBZdjoY80zYoRLUj4hNEAbbc3q/9g4Kyj2lSdI94mw0v+t2WF5S1OEEKgxWkvFOKI67e9aebEhRIQp+yQpbNiJvn1L5EPUW3JGl7wBt0cuzvMakiraarqkP0IyFDepR+mQp28OpTvTHCmRa9gq0oqi3CY/6jIw9GLXN15PGk/fLaA2c4URM888NwfIL16tB5UDtCi1uCNLYLzAZ1i3E6//hdQ4GVRiXX11z2hGoSwQniGvWZveDPgCqod9aIlhgxRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uaW9ndZ6fil1wmCgqAoOdbhpctkg3+X8/ea5itEqowc=;
 b=mu87kFxElD0SL6Yl6gKFQzUZDAc04SJOvM2fWUrWRKiVxA9xteNHfRIQRsxcXURYHX/UBtw2nsrWlcuWLc10BwgN1FUGjMnbipj5GllatOTRO/yUiE1YP6cGNROfljruJMP9nEUL+BvyIbF+ko5W3CxgVHVGCYTVd09j6Nfnul1q/VfOsCJyd68eNrVN0LiDfOS2LW8kX/aqxDMcHllCEy0xFplTsjjvnsfccK9afStkjtQqsyhiC456eEWZ3dRN9KbheLsIde6sgf6EsquLqYfvn6bIJ6Xz8mY5dcyb1Ua+mG3+QmTpgjSFg4hJIZ35Q0ZKX7kGKK6HFsxB3klMfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uaW9ndZ6fil1wmCgqAoOdbhpctkg3+X8/ea5itEqowc=;
 b=2dvUm8YbKBxCXDwth2/DWKDeknIUzTqYNUbVmoJWJq8irQoiDdpJAZaHmgsYqtRTUbl4iSVXqAvbCrTsiqtiu2ka6iin1TLc025VGCMW6MOdnZrVfYh0olDrvk6cBAtggNjf6wbdqKntaeju0AguUwjP9ewEfw8+Wh+l34Xoq24=
Received: from SN7PR04CA0174.namprd04.prod.outlook.com (2603:10b6:806:125::29)
 by PH8PR12MB7230.namprd12.prod.outlook.com (2603:10b6:510:226::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 15 Sep
 2023 05:17:50 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:125:cafe::82) by SN7PR04CA0174.outlook.office365.com
 (2603:10b6:806:125::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 05:17:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 15 Sep 2023 05:17:49 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Sep
 2023 00:17:46 -0500
From:   Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To:     <jikos@kernel.org>, <benjamin.tissoires@redhat.com>,
        <jic23@kernel.org>, <lars@metafoo.de>,
        <srinivas.pandruvada@linux.intel.com>,
        <linux-input@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH 7/8] HID: amd_sfh: Add light chromaticity support
Date:   Fri, 15 Sep 2023 10:47:02 +0530
Message-ID: <20230915051703.1689578-8-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230915051703.1689578-1-Basavaraj.Natikar@amd.com>
References: <20230915051703.1689578-1-Basavaraj.Natikar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|PH8PR12MB7230:EE_
X-MS-Office365-Filtering-Correlation-Id: b8cf621b-55bc-4845-eac4-08dbb5ab1ae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f+zzeWyyIeqtiMCUvpTRCJCFV6sX3LVzuV/FN8KPpmRGBYkFhGYmO/FwidJ1IJkoeCxv6mCSS/ph5bp45kaiu8btOB8Xxh9l6IoWQzDMgQ/O4+7n1OsskVMdOQZkOqnAHIJVapI9wcxyJyZGJuatxEiwo+zxxL/3Crz3jq3+rqzUXxXQUReFAisZI6RjO24QXS5bk5Kxiy1BFfEZjeTniKWxYfUXrWGiHB9Pe5Rl264aAqa6fqzA7DiLVDFluh49fAooS4vdxNWYBfPX7ep54OBhSJmv+Dqud6dZAxy1Lech1ETKGrkonRUNo58i6H0FjC2SdfbS+JAnSCV3nS/FL6EYAzvBmsdPGhl68EWZbY4ohR0QwH8eXrKfkZ6Gg//6XqMMwImnj/pRQlB6701Jz5JNylaQzcGJPtnwF213WauysITo2SVXrolLdkdJEh19banDtNIj10PxOdWSpRgMIKvJPKulEcnpr+qngzxMAHv65tDUW/2xJ0E5DBBERgvsw+5G9X3Y35M+PmImOT062ADOgvBQ4Qd9R+UyfYVszHIqbpgzqhJ2yQvjBvkCr6oETqG1WjXlJyE7MMaYMjAmhr3qROTekPlfTWieJxEnCSrBqwOxBoZuzZKOA9HuIj3lKv5516DiTDYZT4Yysnkd+qjVEa7B3vFjA1ov02BZSMTUjHAkZ20y4IHmvZ2m4qfn9BhceoxM8bCWPM+ki08PTdf2nszYC5Fetu6e+zfZC6Xb5qCMCcDa+D3TIVr0hXYbzLXvQ3sHrXx8xUBJ5mtExg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(346002)(39860400002)(1800799009)(451199024)(186009)(82310400011)(46966006)(40470700004)(36840700001)(36860700001)(47076005)(2906002)(40460700003)(36756003)(86362001)(82740400003)(41300700001)(81166007)(40480700001)(336012)(70206006)(110136005)(478600001)(316002)(8676002)(2616005)(8936002)(4326008)(1076003)(6666004)(7696005)(70586007)(356005)(426003)(83380400001)(5660300002)(16526019)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 05:17:49.7808
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8cf621b-55bc-4845-eac4-08dbb5ab1ae6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7230
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

