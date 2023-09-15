Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09F67A153D
	for <lists+linux-iio@lfdr.de>; Fri, 15 Sep 2023 07:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbjIOFRl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Sep 2023 01:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbjIOFRk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Sep 2023 01:17:40 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91770269D;
        Thu, 14 Sep 2023 22:17:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZsVtkuZjqiUtooRx7fT8fOanF8J/FQhPHD6YxjzIK2H1OFNc6DB84710pQ0v/gT/qaKC+tnk6Oe11a4DuHFEc/1YhU7NNjEvNZ3qPdUDFkrU8c/sKDaMopuDQMY5bZOYoLx81aZWH15KRzbOChJilYF9VuqGlLq2XIkVBFq2r0V63fBuWolfTQF+n9bTp8Ea8CJgwqcWhLCfTJSWTfl8pF3jZt/1l1Qi53UyeFb7bKI3VjkVxSA0lE7tayrpjpNodEn6KPCeSwZ+kW++n8m6xGNwycEGpNJpj4W5Vfuqe3N2Vby4RlZ+mdDwmlhDkoicDdLh6Xnl008IUzBZ22dCZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oykly3kq3U5cbSPPswSH0C90KCIoiMGc9Un794pwubI=;
 b=ip4JEz0D1PLt4d+SV21Og5+CjcYZNRwUx5fOPQ4m9TA9j7xuXIu+R+nVpRdrOhvPRcooOGQe6J87lQxaNoSe1sk87qXDM3lBDypTqMfJoDF6CeN6GbbBeUEn8+jsZwi3s6pWdBMtaC7lPOm+o4e9JHd5fO8Hq7K1pV0RS0YYrxQMzSuqOWLC+ST2xxY9+S+1/W0Dgj1l3Cp7bzRny1CrbdY5E1b4lvd9PU0ngNw49sQKt1prHderwnYhU22c6QxdacQM83DAijpkVWfhJYt7HkaTKALRj0XKD0FmCE+hu92SwhqZ3voe/g1x7hXwwERhKoR9lJIc6MnfOgldeVOWeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oykly3kq3U5cbSPPswSH0C90KCIoiMGc9Un794pwubI=;
 b=wCcaH43b/aPLKsRHY72NpvoJDtieaQWfagLWE4T21SOsKfoTA4qDlG0F8wX5MqrYlIXxhu2g7zsupU97wZTqEWn9vTPPYItHDNWmSWYh/ioYTSjzpTSuOC4n3AiW1MGRDvAgeNuQ5BcS7y4N113bsuzi+HDnY+FsK6oTlPbpmEE=
Received: from SA9PR10CA0026.namprd10.prod.outlook.com (2603:10b6:806:a7::31)
 by CY5PR12MB6429.namprd12.prod.outlook.com (2603:10b6:930:3b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Fri, 15 Sep
 2023 05:17:32 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:a7:cafe::90) by SA9PR10CA0026.outlook.office365.com
 (2603:10b6:806:a7::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 05:17:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 15 Sep 2023 05:17:32 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Sep
 2023 00:17:29 -0500
From:   Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To:     <jikos@kernel.org>, <benjamin.tissoires@redhat.com>,
        <jic23@kernel.org>, <lars@metafoo.de>,
        <srinivas.pandruvada@linux.intel.com>,
        <linux-input@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH 1/8] iio: hid-sensor-als: Use channel index to support more hub attributes
Date:   Fri, 15 Sep 2023 10:46:56 +0530
Message-ID: <20230915051703.1689578-2-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|CY5PR12MB6429:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f63468e-7d02-4548-9677-08dbb5ab1057
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FYS6GVco9SBvOrB01FJ9z8lFEcMGj2ljKXoMmHR3pUYPfyg7yP0GXLrLoEdYkaEht0s3Gzxh9hK2HXRAo/JVYGAOPNWERnB3bNURwB8pVwu8oNoZOwtgR+iivYybxgVYFZT8Q13SiLnIQnhC1dE+UbobQfsmmdkyA7HzFPK1j/QRuH13Sjwl1/KVns8FYazcoCU6mTfcal3WJFP/U+N573AAJdf3yw2hZXntJmguuXaO/JKlCXrjeyiier3PxOKK5PLkmO13HRHK5pu1trFAwNyFVKmDmLDJgs8s2vlfbmc2IuyYWc44Am33DTnQk/KZy0wrkAWk6jXzoUEaexO9fKWaGGOGdNs+C7hSdvURKKkggwmWgCdeBbY0VmpBzAb5gZQU6DgvdSVCAgg7JKFcDxEWFkXS7lhYSGFMLORP+xjRFnC1E5VdsH7WSxo031/t2wsy3KfHtrK9ljIrkYIaRpcHpabLUSlvFkbcAKFpJaFsiVfQGi2bkyajNSzc9Zy3OUGkBnBXSLzOEpin0cact5C7wn9xEAVXS3zUZhD6CaNu8ORaesH8o9PewJmS6Nyj6gQMfXwI7KGP4zjkUiNXlIzAO786faxrQ5iIsHpnzMqzg1YtpMfMmMABFhr03iAdUO0UPYF5b+WKomDD/wl0ZpKiZZTrlJJsIMl96Z4QbiIf0H5g00xD59B+zFGj8QOXUyO8+q3L5lPswnFh9ifxFpVFXCA84aKk7tq0n4jtCl0GZb7K1biWR7ZLpQe6FFloT8cvxDSKWO4YAjrAM2NT0A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(346002)(136003)(39860400002)(186009)(451199024)(82310400011)(1800799009)(36840700001)(46966006)(40470700004)(36756003)(86362001)(40460700003)(40480700001)(8936002)(478600001)(6666004)(1076003)(426003)(336012)(26005)(5660300002)(16526019)(70206006)(70586007)(7696005)(316002)(110136005)(41300700001)(2616005)(4326008)(8676002)(2906002)(36860700001)(47076005)(356005)(81166007)(82740400003)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 05:17:32.0642
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f63468e-7d02-4548-9677-08dbb5ab1057
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6429
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Sensor hub attributes can be extended to support more channels. So in
order to support more sensor hub attributes for ALS use channel index to
get specific sensor hub attributes.

Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 drivers/iio/light/hid-sensor-als.c | 38 +++++++++++++++---------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index eb1aedad7edc..48879e233aec 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -24,7 +24,7 @@ enum {
 struct als_state {
 	struct hid_sensor_hub_callbacks callbacks;
 	struct hid_sensor_common common_attributes;
-	struct hid_sensor_hub_attribute_info als_illum;
+	struct hid_sensor_hub_attribute_info als_illum[CHANNEL_SCAN_INDEX_MAX];
 	struct {
 		u32 illum[CHANNEL_SCAN_INDEX_MAX];
 		u64 timestamp __aligned(8);
@@ -99,8 +99,8 @@ static int als_read_raw(struct iio_dev *indio_dev,
 		switch (chan->scan_index) {
 		case  CHANNEL_SCAN_INDEX_INTENSITY:
 		case  CHANNEL_SCAN_INDEX_ILLUM:
-			report_id = als_state->als_illum.report_id;
-			min = als_state->als_illum.logical_minimum;
+			report_id = als_state->als_illum[chan->scan_index].report_id;
+			min = als_state->als_illum[chan->scan_index].logical_minimum;
 			address = HID_USAGE_SENSOR_LIGHT_ILLUM;
 			break;
 		default:
@@ -242,23 +242,23 @@ static int als_parse_report(struct platform_device *pdev,
 				struct als_state *st)
 {
 	int ret;
+	int i;
+
+	for (i = 0; i <= CHANNEL_SCAN_INDEX_ILLUM; ++i) {
+		ret = sensor_hub_input_get_attribute_info(hsdev, HID_INPUT_REPORT, usage_id,
+							  HID_USAGE_SENSOR_LIGHT_ILLUM,
+							  &st->als_illum[i]);
+		if (ret < 0)
+			return ret;
+		als_adjust_channel_bit_mask(channels, i, st->als_illum[i].size);
+
+		dev_dbg(&pdev->dev, "als %x:%x\n", st->als_illum[i].index,
+			st->als_illum[i].report_id);
+	}
 
-	ret = sensor_hub_input_get_attribute_info(hsdev, HID_INPUT_REPORT,
-			usage_id,
-			HID_USAGE_SENSOR_LIGHT_ILLUM,
-			&st->als_illum);
-	if (ret < 0)
-		return ret;
-	als_adjust_channel_bit_mask(channels, CHANNEL_SCAN_INDEX_INTENSITY,
-				    st->als_illum.size);
-	als_adjust_channel_bit_mask(channels, CHANNEL_SCAN_INDEX_ILLUM,
-					st->als_illum.size);
-
-	dev_dbg(&pdev->dev, "als %x:%x\n", st->als_illum.index,
-			st->als_illum.report_id);
-
-	st->scale_precision = hid_sensor_format_scale(usage_id, &st->als_illum,
-				&st->scale_pre_decml, &st->scale_post_decml);
+	st->scale_precision = hid_sensor_format_scale(usage_id,
+						      &st->als_illum[CHANNEL_SCAN_INDEX_INTENSITY],
+						      &st->scale_pre_decml, &st->scale_post_decml);
 
 	return ret;
 }
-- 
2.25.1

