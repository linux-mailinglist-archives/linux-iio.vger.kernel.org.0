Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE33F7A5C16
	for <lists+linux-iio@lfdr.de>; Tue, 19 Sep 2023 10:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjISILn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Sep 2023 04:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjISILi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Sep 2023 04:11:38 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2748412F;
        Tue, 19 Sep 2023 01:11:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYZzdvUaiYb1Bv/eoegpxU+3bjv8PbECSqOagvyRLuJvSCA50GTgY6f+mOz8aieeu2eZ1B57xiXGgHuJjfgvK5RKM8ZVnlE44vsuWpJgB7PqJdrpFsKuVBD13/MbWK3FiDgkk4YMobPv+cG96DkNJBrQyREw4pABT5OhZazVqPoY+ptKRVhWhH8XuYL32TVDyWTfa8HOerLIR388VagSHnF7Sh3x1rboCdq9CuO0xVVvscVX8yRHs0kT2klb+GrOmuTwZKhDz8fAPzw3smbZ507W1zXiCW4jUBksgZ171+y0wnPu+VEAESypaIVLuqDWlxYrMZPAByhnZce5PWn0xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0+iO/szdrPTOM8xx79lFjdVBbP/nOVbTPGqV5IBkEA=;
 b=JO5Eu1Z+Sb3mtzNfX8HLAGsakzJ4UB63LgrhMJFfm2Z661VJKGuqh0ckL5XZUwERz8DZ7FA+cQcC7oDN5fbhdRQte9sXrsfsWDz0M+ZAMIRSjDv8zGBJJrt0S/mVIuvgIbwOXu3qGWYu1UauwtUKWmp/DuiUfQPAOWjjtPY258TC8n9ZPm3ybqeOtEp6E9gzwlahoMsi/faZfy3kmJ3ZN1DuD5ndkdKpbHMo46jWndfgeuPfU3ZybZrj3SU8+dro1ZgDQzczdbswwujKUx+ABR/HkO/cpJQYwJUSTg684DKAdUKJds1pywEVitTcFBeuHhT0j77AefSWbvALYzLYOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0+iO/szdrPTOM8xx79lFjdVBbP/nOVbTPGqV5IBkEA=;
 b=kFWfXnsKRNzaxUc7aEQLVut3MGmEs3YdWlroAFTa9l7xyJZ6/JWd+Py74I3GAF/UpFnuC3njS2h7EyOH6uGjQF+kRczL9G3wZNs5x+aqYyr4ewCThjbjJwdKGG3bI1G8qdH3oZMkpqrh8S2cBHCR/oUPY5AM0z5MC0GvqjnUK58=
Received: from MW4PR04CA0156.namprd04.prod.outlook.com (2603:10b6:303:85::11)
 by SA3PR12MB8439.namprd12.prod.outlook.com (2603:10b6:806:2f7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Tue, 19 Sep
 2023 08:11:29 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:303:85:cafe::b6) by MW4PR04CA0156.outlook.office365.com
 (2603:10b6:303:85::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Tue, 19 Sep 2023 08:11:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Tue, 19 Sep 2023 08:11:28 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 03:11:26 -0500
From:   Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To:     <jikos@kernel.org>, <benjamin.tissoires@redhat.com>,
        <jic23@kernel.org>, <lars@metafoo.de>,
        <srinivas.pandruvada@linux.intel.com>,
        <linux-input@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v2 3/9] iio: hid-sensor-als: Add light color temperature support
Date:   Tue, 19 Sep 2023 13:40:48 +0530
Message-ID: <20230919081054.2050714-4-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|SA3PR12MB8439:EE_
X-MS-Office365-Filtering-Correlation-Id: ebb32687-005c-47a6-5b4c-08dbb8e806f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: itQZSu/AyruKdcnqcGmaiutOPx54VAgsEDqWo98+LuK761DPNXxeHuT2Al9sQjlIu0jra0sBj17hRE7TG3B+RCqdYDIGRrSpbt2DaiTT7JTuCIQJIgonQa2v9aP2a2Rh4oG90xxoRgJy+56Zhz4ckMmLiCnIoJGCVZam5Dx3G6gYso0yKbel2xZp2MkBqUjqCJVsE0eDnLgSB0yLSLUWKRQQxL2ICwqWLx3rhq5ZzSMrX3/QocyT7lniEfsK6CiEyMvq7OUgJZjzfxdc54zqG/4SG5aOU1quARs4tcw1ZhflLrM6jVu60Ab/PYecE/cJn2E8MRYca6/azDCvYg+TdVYs1b+ayICMzGMQAx7qz9y62lta+Zq4KkkllbvE4jmBRBmBgtPjk1ldIRiPeEk/G4Y/zDXyJffpTHCtbF0OGHxQE2juBF1+d6iTGzqB1S2Jcn6QZ8nUx5Z/2OnUJPq59FXkDGuqGr2SJiDrzRYh14DE8RWI/a9Q3Vrvt54n0Ctfl3+8bEtIe1h3XbYhx6pCHvW3NcZ9XiIzWR0tZEePmMNFFGfeEx2eOrjQlA50i8k2NSvCiK/kgO6eEH5oxelkFqIxxXNC+C0zthBsxEnDL1LboBS6BG5GqeJjf4+spb6OI91g+fSYq1WhO5gjKUnDFAfZd0++kRu+9fnXQQ5/hE/MdlJKewWKKQTGut6evGDhpCd1o3goMiW3FoswlBQefF0acbCanq5TpFyf59RlwkzGr8QLfbnclFAY2E60ujw2HLgHiRyEHJxC+77BLsze2Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(39860400002)(136003)(82310400011)(1800799009)(186009)(451199024)(46966006)(40470700004)(36840700001)(26005)(5660300002)(16526019)(1076003)(8676002)(8936002)(4326008)(82740400003)(40460700003)(2616005)(2906002)(86362001)(36756003)(81166007)(356005)(47076005)(36860700001)(83380400001)(426003)(336012)(40480700001)(7696005)(70586007)(70206006)(110136005)(6666004)(478600001)(41300700001)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 08:11:28.9888
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb32687-005c-47a6-5b4c-08dbb8e806f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8439
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
 drivers/iio/light/hid-sensor-als.c | 37 ++++++++++++++++++++++++++++--
 include/linux/hid-sensor-ids.h     |  1 +
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index efb1f8862b28..16a3f1941c27 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -14,8 +14,9 @@
 #include "../common/hid-sensors/hid-sensor-trigger.h"
 
 enum {
-	CHANNEL_SCAN_INDEX_INTENSITY = 0,
-	CHANNEL_SCAN_INDEX_ILLUM = 1,
+	CHANNEL_SCAN_INDEX_INTENSITY,
+	CHANNEL_SCAN_INDEX_ILLUM,
+	CHANNEL_SCAN_INDEX_COLOR_TEMP,
 	CHANNEL_SCAN_INDEX_MAX
 };
 
@@ -65,6 +66,16 @@ static const struct iio_chan_spec als_channels[] = {
 		BIT(IIO_CHAN_INFO_HYSTERESIS_RELATIVE),
 		.scan_index = CHANNEL_SCAN_INDEX_ILLUM,
 	},
+	{
+		.type = IIO_COLORTEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
+		BIT(IIO_CHAN_INFO_SCALE) |
+		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+		BIT(IIO_CHAN_INFO_HYSTERESIS) |
+		BIT(IIO_CHAN_INFO_HYSTERESIS_RELATIVE),
+		.scan_index = CHANNEL_SCAN_INDEX_COLOR_TEMP,
+	},
 	IIO_CHAN_SOFT_TIMESTAMP(CHANNEL_SCAN_INDEX_TIMESTAMP)
 };
 
@@ -103,6 +114,11 @@ static int als_read_raw(struct iio_dev *indio_dev,
 			min = als_state->als[chan->scan_index].logical_minimum;
 			address = HID_USAGE_SENSOR_LIGHT_ILLUM;
 			break;
+		case  CHANNEL_SCAN_INDEX_COLOR_TEMP:
+			report_id = als_state->als[chan->scan_index].report_id;
+			min = als_state->als[chan->scan_index].logical_minimum;
+			address = HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE;
+			break;
 		default:
 			report_id = -1;
 			break;
@@ -223,6 +239,10 @@ static int als_capture_sample(struct hid_sensor_hub_device *hsdev,
 		als_state->scan.illum[CHANNEL_SCAN_INDEX_ILLUM] = sample_data;
 		ret = 0;
 		break;
+	case HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE:
+		als_state->scan.illum[CHANNEL_SCAN_INDEX_COLOR_TEMP] = sample_data;
+		ret = 0;
+		break;
 	case HID_USAGE_SENSOR_TIME_TIMESTAMP:
 		als_state->timestamp = hid_sensor_convert_timestamp(&als_state->common_attributes,
 								    *(s64 *)raw_data);
@@ -258,6 +278,19 @@ static int als_parse_report(struct platform_device *pdev,
 			st->als[i].report_id);
 	}
 
+	ret = sensor_hub_input_get_attribute_info(hsdev, HID_INPUT_REPORT,
+				usage_id,
+				HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE,
+				&st->als[CHANNEL_SCAN_INDEX_COLOR_TEMP]);
+	if (ret < 0)
+		return ret;
+	als_adjust_channel_bit_mask(channels, CHANNEL_SCAN_INDEX_COLOR_TEMP,
+				st->als[CHANNEL_SCAN_INDEX_COLOR_TEMP].size);
+
+	dev_dbg(&pdev->dev, "als %x:%x\n",
+		st->als[CHANNEL_SCAN_INDEX_COLOR_TEMP].index,
+		st->als[CHANNEL_SCAN_INDEX_COLOR_TEMP].report_id);
+
 	st->scale_precision = hid_sensor_format_scale(usage_id,
 				&st->als[CHANNEL_SCAN_INDEX_INTENSITY],
 				&st->scale_pre_decml, &st->scale_post_decml);
diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
index 13b1e65fbdcc..8af4fb3e0254 100644
--- a/include/linux/hid-sensor-ids.h
+++ b/include/linux/hid-sensor-ids.h
@@ -21,6 +21,7 @@
 #define HID_USAGE_SENSOR_ALS					0x200041
 #define HID_USAGE_SENSOR_DATA_LIGHT				0x2004d0
 #define HID_USAGE_SENSOR_LIGHT_ILLUM				0x2004d1
+#define HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE		0x2004d2
 
 /* PROX (200011) */
 #define HID_USAGE_SENSOR_PROX                                   0x200011
-- 
2.25.1

