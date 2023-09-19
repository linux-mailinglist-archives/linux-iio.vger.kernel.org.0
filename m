Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60BC27A5C13
	for <lists+linux-iio@lfdr.de>; Tue, 19 Sep 2023 10:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjISILg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Sep 2023 04:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjISILd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Sep 2023 04:11:33 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2129D18D;
        Tue, 19 Sep 2023 01:11:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lq/A83rcvLCvjCjoKnuSze+rZH+tfe9ZP4rRWCK6kGOQJvLagIRSLPqYq8IykuLK5Qi59DThb5q0QwODrtkdbpdLGzeMOD5l/I1BqOHuK0Tx9HYXPJBBk0O9T8AljIP+gztGPYhFz7sxGjOp3whnFPPnN+LtagrmCcz5nhXwPlIqjcciDiJKQtiyhRCtN8jkM/L1yY6qKQDcXOKRmSfz4PoTOOBGTbXAFiTqjRQJ0UbEQ6OwNO/rtNkoM9SDR/qlYdhonILFOBVyeLgnNvUc2qK5VdJHwH0VoAaBSk+jFrtEflXCQsdSOl3R67WZbSZozUh7A+9YZ43O717dHzhtAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9DG4gCSDnInNq1X5cgRxW9hJa63Lj0CGrBitDCFBamA=;
 b=jndP5Dh3wg3iK8ja3sbevo34Qptff/e7qPpgX0SMv1LlAjSKaK7siNrj39gKyphT4XQciz8VHOu9OJwOA4d2YzWXurO9u12M0Tx9LyhGxjNUmMPQTjqX2CZ4RHrSTjQOTc3bjGjIyvv2XfU2EXYwgYyHvVGUcn9xT8RMzt/B/CxhR8acp6AFpnLa+NNKYONaPlTWmu36tYD+VWicnNFNR9EhEe6z3YYome0Jfn7jDcoeDTV23d+8LZUcRiX89T4vycP/TiFLezKyJikWdjXRMqE+dUO7Gb0ZpsNug/MU3eeppMD9SzrYRcjfDbJhFcdaNEeIOQBeOkoCEC+ZvbCyjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DG4gCSDnInNq1X5cgRxW9hJa63Lj0CGrBitDCFBamA=;
 b=vf4tP6pjtDC7eWrBSDMvGCbopuNAtezUyT9PK5PgC+VtoOI3Aa5zE8yx5o+RCETopX40oL5EqMGl/oukr6XzHmnIgY8ZJfO1DO7A0pa2CcVgxuHaV1krRWTB68CfSETPX8XF7numPniWlkReDu+JUmtn/a8Y0QdMC1cCTn8K85M=
Received: from MW4PR04CA0148.namprd04.prod.outlook.com (2603:10b6:303:84::33)
 by PH0PR12MB7929.namprd12.prod.outlook.com (2603:10b6:510:284::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Tue, 19 Sep
 2023 08:11:24 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:303:84:cafe::c4) by MW4PR04CA0148.outlook.office365.com
 (2603:10b6:303:84::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Tue, 19 Sep 2023 08:11:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Tue, 19 Sep 2023 08:11:23 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 03:11:20 -0500
From:   Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To:     <jikos@kernel.org>, <benjamin.tissoires@redhat.com>,
        <jic23@kernel.org>, <lars@metafoo.de>,
        <srinivas.pandruvada@linux.intel.com>,
        <linux-input@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v2 1/9] iio: hid-sensor-als: Use channel index to support more hub attributes
Date:   Tue, 19 Sep 2023 13:40:46 +0530
Message-ID: <20230919081054.2050714-2-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|PH0PR12MB7929:EE_
X-MS-Office365-Filtering-Correlation-Id: 2674ec1e-15f4-4a1c-3a3b-08dbb8e803e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nenf/s68h2krOG3/g0AZC6BcPzGVOmlKcP+RrYBiBd+hlEcKtjiPiJL0PRpfn5GlZXqMsQi0Kz4iOJ9CMfpsnYCby7xTtRlspGTNWzBf8cgo0n0RaxhEDbCidNFiJr7Yqq7yEUyk9NMkfnNqiQia06qeKmDp1IivQZ/Jjy2CAQJ+jtskEYESJ9DxAZnhdRTHJAFAF2YaGyAZhRIFEvt0bJF1YYXBLhNGkCYyQqqLa/vBZqspwSmqMc8jhzvJo0Q4JT9QbMGyTSy6zy5NiJN170A2Zt8cBA6BuG8ZwvQFJtFxaxmg1aHlcTt5d/18Kujz2Q3sWmzkaDJMgyVumTk+RhG60bSn92ay5E+cWjMxjOFMV3xh4YNfsCWXH75pjkZHaDCsTNL2ctsvWRlJNyMONE4ifj5zZ9SX68AHpdDDgbOiWFbeAOusgef+/CJdawr+QJYTEUhECCrDRl0QEVoX/WJCNG5y38jerMCqMwrQNjSxg6KiiOgxeOzpmKqXSjwH2Tg8gHIMb3zFubFAuuz6XJc3DLR9+qbx31wpz+oZSnuWt8WRJFjmZqjynS8vfJb662DQYnjiJl7f2AZTOAW9lqrwz++cK2fL4sEqFeqnjHxAl5Z2lgpDlfyrhyo++4tT+Dqx+CDqWiuokcgGUO47K28EeVYxug/AaH6GOXyWMMg4XX40bJqG0kB+nEV1qH4WUMTM2nkxULlG5t+7xKCRqfPt2EQHd1cZzOfQRi22crbtRpz5CNTsj+0IOoFt9TlG7lVNVCXgG6pwyKr3N4N+MQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199024)(186009)(82310400011)(1800799009)(46966006)(36840700001)(40470700004)(40480700001)(5660300002)(7696005)(86362001)(316002)(41300700001)(70206006)(70586007)(110136005)(6666004)(478600001)(8936002)(8676002)(16526019)(2616005)(356005)(81166007)(26005)(82740400003)(2906002)(36860700001)(36756003)(336012)(426003)(47076005)(40460700003)(1076003)(83380400001)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 08:11:23.8772
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2674ec1e-15f4-4a1c-3a3b-08dbb8e803e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7929
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Sensor hub attributes can be extended to support more channels. Repeat
the reading for the two existing channels and store them separately. It
still operates in the same manner as before where there was just one
entry. So in order to support more sensor hub attributes for ALS use
channel index to get specific sensor hub attributes.

Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 drivers/iio/light/hid-sensor-als.c | 38 ++++++++++++++++--------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index eb1aedad7edc..efb1f8862b28 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -24,7 +24,7 @@ enum {
 struct als_state {
 	struct hid_sensor_hub_callbacks callbacks;
 	struct hid_sensor_common common_attributes;
-	struct hid_sensor_hub_attribute_info als_illum;
+	struct hid_sensor_hub_attribute_info als[CHANNEL_SCAN_INDEX_MAX];
 	struct {
 		u32 illum[CHANNEL_SCAN_INDEX_MAX];
 		u64 timestamp __aligned(8);
@@ -99,8 +99,8 @@ static int als_read_raw(struct iio_dev *indio_dev,
 		switch (chan->scan_index) {
 		case  CHANNEL_SCAN_INDEX_INTENSITY:
 		case  CHANNEL_SCAN_INDEX_ILLUM:
-			report_id = als_state->als_illum.report_id;
-			min = als_state->als_illum.logical_minimum;
+			report_id = als_state->als[chan->scan_index].report_id;
+			min = als_state->als[chan->scan_index].logical_minimum;
 			address = HID_USAGE_SENSOR_LIGHT_ILLUM;
 			break;
 		default:
@@ -242,22 +242,24 @@ static int als_parse_report(struct platform_device *pdev,
 				struct als_state *st)
 {
 	int ret;
+	int i;
+
+	for (i = 0; i <= CHANNEL_SCAN_INDEX_ILLUM; ++i) {
+		ret = sensor_hub_input_get_attribute_info(hsdev,
+						HID_INPUT_REPORT,
+						usage_id,
+						HID_USAGE_SENSOR_LIGHT_ILLUM,
+						&st->als[i]);
+		if (ret < 0)
+			return ret;
+		als_adjust_channel_bit_mask(channels, i, st->als[i].size);
+
+		dev_dbg(&pdev->dev, "als %x:%x\n", st->als[i].index,
+			st->als[i].report_id);
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
+	st->scale_precision = hid_sensor_format_scale(usage_id,
+				&st->als[CHANNEL_SCAN_INDEX_INTENSITY],
 				&st->scale_pre_decml, &st->scale_post_decml);
 
 	return ret;
-- 
2.25.1

