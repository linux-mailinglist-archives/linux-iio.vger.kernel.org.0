Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1D37A1542
	for <lists+linux-iio@lfdr.de>; Fri, 15 Sep 2023 07:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjIOFRy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Sep 2023 01:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbjIOFRx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Sep 2023 01:17:53 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CB4271E;
        Thu, 14 Sep 2023 22:17:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjNlOf8DZqJ3Y10mIIF4UPCi+IGYe3k5w9mf1PKNCWrMn28+ODZ5+OZSB0uCDWjBya4nkqupQdBvI2Ulrh/OJNDyWxRVU36lnNyjp1TEK+gAUprJW1fISHuIQwlJo68ryBBjnw3OBQPzWh5YWDFTKqoxswXd/rXQP5atH3RQkl2l6kg9SFBSCeg41xix6Wyiazsg+RonKsnLUuM8SRjIDHaYL0xNQvYKm3fFDdbWlRLij56SbLxso3qsxxqhl80vT8vf7T78O1tWvm5/hdt4B5MeITk6Fmn6kn+JxDzheyP+n9+2ARB8H0IuEHw5mrc5zT8NyALratyrQ2fPpBpnIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/BjVjzAJB7A3O5Ec7LWjrn0PESlN8X3HAxGueCUxso=;
 b=lUAkDwxm7m0W0CqTR6yx7Fv9jxNJobvrqZisc8SXfsiR2DsdLfqaTtDb2FfPbtYG6WAqUZfQhflAba0eIW4r6GRJExkiLfuWOykHYNbs2Ugj8FBi1ejAITduLXL/98N7O4J1ULqCSs1JJ2x7hzAaJ96idpB9nOdVn3XtUpWHaFy6AIM8sfcQSokW2QY4Di6ctcpw4Af3CYCGYobYYsYk7qQj9udga5Zaoj4TXKi9Dxe9RnYqh/ig8/XjXTs5Et62nmWzoP7f3rWPqhgejbuMOM6pObmQ1/DavWmGsK+JDiHAtlQQBxZXdWzwzlmTWPGLc0LGAiWmomr2wpVoYakkZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/BjVjzAJB7A3O5Ec7LWjrn0PESlN8X3HAxGueCUxso=;
 b=q0Qc/v5tk/dQeB8Z3a9Dc0TRbdIxDPrKq3/vu4VUz2JxAGn68t1jHQYezhEQnY4r+sx1fe0gPKBuR5XbPZbdfxhg50vsK6uekP+ZRxF6yH5vNpiK4goEQjNrf28R/dlau/YFqBQ1FOrdQBpjdrbi1T5wbc9IqMfKvyY3AWiN/CU=
Received: from SA9PR13CA0098.namprd13.prod.outlook.com (2603:10b6:806:24::13)
 by SJ0PR12MB6880.namprd12.prod.outlook.com (2603:10b6:a03:485::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.33; Fri, 15 Sep
 2023 05:17:40 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:24:cafe::91) by SA9PR13CA0098.outlook.office365.com
 (2603:10b6:806:24::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 05:17:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 15 Sep 2023 05:17:40 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Sep
 2023 00:17:34 -0500
From:   Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To:     <jikos@kernel.org>, <benjamin.tissoires@redhat.com>,
        <jic23@kernel.org>, <lars@metafoo.de>,
        <srinivas.pandruvada@linux.intel.com>,
        <linux-input@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH 3/8] HID: amd_sfh: Add support for light color temperature
Date:   Fri, 15 Sep 2023 10:46:58 +0530
Message-ID: <20230915051703.1689578-4-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|SJ0PR12MB6880:EE_
X-MS-Office365-Filtering-Correlation-Id: b28e7e7a-af81-48dd-f10d-08dbb5ab1543
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7m86hZaxu3E6aGRk66GSCBSCLpfEkkxfNsH44JQaT7sVIEV0Q6QDf5PrdHdmahInzU0sq69gRISJzqz30xucXvK7UPmcWxkgcYTYwtQsqepRosdFq6icLqKtf73KXewSg0mqTrJRVDwYDkyLIAFm3v0K3qoBOovo3I9sXXEjtHMOo0JOrmlkV+U8obQlTdVdBldDBwGRpiN88NmHanfcvrHfCh41eUTznn/YP3q/Xi8qqIInumwSsaqFqMMNnwqLcuhv/8y4eHe7uHZq+MA9X5UwcFo9USLavvg2Fy2309WHGlGWlbK5a+RXKIOqBql9YC69r9mk1wc/A03rSH4D21jJW++yeJq1FsiRa7YX2HjpnPWVq2b8kiX8HyaDcZnzN0czsFRAm5UUh6hCfUoN8KZdK+gurUMhJY2QSfvbZXruGL8gDtwSyNiZgr01mSh4h3+2SXgjmDNod6iCMNTy3w6Qt4o7Be1E1lOcmPYDvTnciL4DrPpK48AbA/4CU5B1ttTJjmeLCpJnQUR8VegVparG//MFcvacIkoWfqZ0G1lvo+oFrTa9AK0vCw09yIgRzFNw78N56xv0vyyyB/u9Yv8mtlKe9NVT/DO63gyeliL550jL7jTwB/5i3B8k96CROXyrwPYDxpvQMoaEaQen85WZ28aBQ9w86kt05y5NEOkec7xWyeS/viCoup2Mnahh125Qy65ovhnu7VeABSjHkRu33MAABGZ6edxfuB8K7hLiBwfA79df+O8clak1A7DwYYaihaULmHXmU1kJhGojmg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(136003)(39860400002)(1800799009)(451199024)(186009)(82310400011)(46966006)(36840700001)(40470700004)(41300700001)(81166007)(6666004)(7696005)(47076005)(36756003)(86362001)(356005)(40480700001)(316002)(36860700001)(26005)(82740400003)(2616005)(336012)(16526019)(2906002)(40460700003)(8936002)(5660300002)(110136005)(426003)(70586007)(4326008)(478600001)(70206006)(1076003)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 05:17:40.3241
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b28e7e7a-af81-48dd-f10d-08dbb5ab1543
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6880
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

