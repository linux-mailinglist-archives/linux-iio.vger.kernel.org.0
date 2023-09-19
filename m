Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FC77A5C26
	for <lists+linux-iio@lfdr.de>; Tue, 19 Sep 2023 10:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjISIME (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Sep 2023 04:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjISILw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Sep 2023 04:11:52 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC8A12F;
        Tue, 19 Sep 2023 01:11:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHHnS2cfsJTN1Um8Q0OUZ74VY1GerowZSbg2+FPVw0veh9woZKtqX0CXOMW+TpNjGINnXndAnf1A/gxQ91E7CML8Xo47wRUEzxrSP3qCoOsMnUkB7HMu3BHxeAomiTA26fNbbJG/3BWX/Xd2xlGi9NY/VeTv1nxahYLBVOYzI75+/pvq7BASPKihSjgh3vGmPKFj599rrc608t7UAYNpfWqUvcR339vwfhqiXOhRRGtEWm5K6w+5Bh6EtnwNxrgE96QnnUS2DxxFYNf09pLuk+IEXwQEi3jVVdNNA4lza9CibuJFAD7UtfKbm428KF32DlNaE4nWFRUanKUcxl3L0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/T/GD34c7wjZ4oKhiB7EyqZT6/B6WlMHqs7N1WAK9s=;
 b=dAhNRAhcJ6puTFT51DJhI0xM9lm15UuITgJ3U/55VMQJnTvBL+Lg1aTxzjzE0CCv58Pi7R5DJvQnMASk/mkuDywe5d0qz5D0TjbxoNmpbL/Q1Ws67GLBzWv7aPTqcyVWoKihnkwYLynsYR1t5IwwVrjqT/qiBxjctxTMY33A7B2DB4NOxB+/Ao3hQgegk2SBBgrygh5mrk/dwd/YM/2GWWAMO9TSGIvWz7jYHG+3Ug/TjxdxyTUdbIlNOduWFFZbvC5C5VGMooYDPr6Q3Abhk3xzWBj9ZxEe2V551yLWMkw8FTFr7Hu1yWXKwpPboSXfGQDW4OUhcxd/iRQiSTZr4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/T/GD34c7wjZ4oKhiB7EyqZT6/B6WlMHqs7N1WAK9s=;
 b=jfJQRuAALqOWswnQB1zHGTajGFUa0Db7Yzl69ySBLFjnkXzMAchOkLYccV7VBwfXYeIGAto/q+ddBhCrdlMXMHZLD7JX1PKR2/PvPhInTqd0+xkAOYPYj966duMVMP+AqNWn+L6wgCUlrWd+IMMVMs1ana9oXuvGndVL4wDdsz8=
Received: from MW4PR03CA0042.namprd03.prod.outlook.com (2603:10b6:303:8e::17)
 by IA0PR12MB8713.namprd12.prod.outlook.com (2603:10b6:208:48e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Tue, 19 Sep
 2023 08:11:41 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:303:8e:cafe::7f) by MW4PR03CA0042.outlook.office365.com
 (2603:10b6:303:8e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28 via Frontend
 Transport; Tue, 19 Sep 2023 08:11:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Tue, 19 Sep 2023 08:11:40 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 03:11:37 -0500
From:   Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To:     <jikos@kernel.org>, <benjamin.tissoires@redhat.com>,
        <jic23@kernel.org>, <lars@metafoo.de>,
        <srinivas.pandruvada@linux.intel.com>,
        <linux-input@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v2 7/9] iio: hid-sensor-als: Add light chromaticity support
Date:   Tue, 19 Sep 2023 13:40:52 +0530
Message-ID: <20230919081054.2050714-8-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|IA0PR12MB8713:EE_
X-MS-Office365-Filtering-Correlation-Id: 7675cbf1-2d4f-4e1d-e4a1-08dbb8e80e14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yC7r3u5nqLLvyzhuhDvtF6gd4eGt+B5/F7PTDOTHFTgUbGavjzj3GJsgEVV/VEHefnZm/RsZnLGeyLNsROChWw7UmhBVWGDWWhm1/TRCh8TlAgvBTyDXKA85/ThY9IOEMJMU2FthV+4jpzDRzRPsVHRyJhdCyQqnBV0ay1+Bn+VtKgsrbkpCoEZ0hUwHjoGYRqGgObBBCGlTSwZf3z6by2fwlo7MTAH7LPnkVALRu6RP2hl7TkLY4PdFFnV5WvfBym3eEgXqGIy5d5hDcTShAK8Dqf5zjkx5+QOOYUMvOXOl7Om6ihZNG3mFQ514PcsVfuOjynHwWOj+fXVOWTV7vhXv+UFRHmcXBLepoBdxqI2KbJJHQlNSkpd4e8PittugIIYh7utWiim+uUa3i/2FsFoevm/5vZXWsU8nrZBM3R93nznHMKAa55Cok7UvOJr+6gyjlopwy7XjD707+PcO/afofeUA82gq4Vs3aWC/CpTGGv0/XfGAV4CENnv4QBNVHbxw3LFbNrfWGakZE5D6MHwXFuXwYpeffHs22OGCBHSs3pYmzhOyO+wKq5wjJG0QbCsDHiv203JHwqI8lqBob3awbrCy6nZIWFmRgQ3Yymw+EkdwGMNkvYUxlqAFETpW9HhEmw7M8pan5SGZ1gKrJY4MyElaXFoRUnv4Bap/Xm9tGo81/M2Dx9N29Fu+Q7IwDKZyd6Tiw7Nbk6HEDQEFgHdr+qqT5zRuxcjDxvc9ugQ31VAWjMs7nui0tHwYx3wF8ucpV/3rFQ7nZfrVX6Nagg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(82310400011)(1800799009)(186009)(451199024)(40470700004)(36840700001)(46966006)(356005)(26005)(81166007)(16526019)(82740400003)(2616005)(8936002)(8676002)(4326008)(1076003)(40460700003)(47076005)(36860700001)(2906002)(426003)(36756003)(336012)(5660300002)(40480700001)(86362001)(7696005)(478600001)(6666004)(316002)(70206006)(70586007)(110136005)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 08:11:40.9824
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7675cbf1-2d4f-4e1d-e4a1-08dbb8e80e14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8713
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
 drivers/iio/light/hid-sensor-als.c | 63 ++++++++++++++++++++++++++++++
 include/linux/hid-sensor-ids.h     |  3 ++
 2 files changed, 66 insertions(+)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index 16a3f1941c27..c9d114ff080a 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -17,6 +17,8 @@ enum {
 	CHANNEL_SCAN_INDEX_INTENSITY,
 	CHANNEL_SCAN_INDEX_ILLUM,
 	CHANNEL_SCAN_INDEX_COLOR_TEMP,
+	CHANNEL_SCAN_INDEX_CHROMATICITY_X,
+	CHANNEL_SCAN_INDEX_CHROMATICITY_Y,
 	CHANNEL_SCAN_INDEX_MAX
 };
 
@@ -76,6 +78,30 @@ static const struct iio_chan_spec als_channels[] = {
 		BIT(IIO_CHAN_INFO_HYSTERESIS_RELATIVE),
 		.scan_index = CHANNEL_SCAN_INDEX_COLOR_TEMP,
 	},
+	{
+		.type = IIO_CHROMATICITY,
+		.modified = 1,
+		.channel2 = IIO_MOD_X,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
+		BIT(IIO_CHAN_INFO_SCALE) |
+		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+		BIT(IIO_CHAN_INFO_HYSTERESIS) |
+		BIT(IIO_CHAN_INFO_HYSTERESIS_RELATIVE),
+		.scan_index = CHANNEL_SCAN_INDEX_CHROMATICITY_X,
+	},
+	{
+		.type = IIO_CHROMATICITY,
+		.modified = 1,
+		.channel2 = IIO_MOD_Y,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
+		BIT(IIO_CHAN_INFO_SCALE) |
+		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+		BIT(IIO_CHAN_INFO_HYSTERESIS) |
+		BIT(IIO_CHAN_INFO_HYSTERESIS_RELATIVE),
+		.scan_index = CHANNEL_SCAN_INDEX_CHROMATICITY_Y,
+	},
 	IIO_CHAN_SOFT_TIMESTAMP(CHANNEL_SCAN_INDEX_TIMESTAMP)
 };
 
@@ -119,6 +145,16 @@ static int als_read_raw(struct iio_dev *indio_dev,
 			min = als_state->als[chan->scan_index].logical_minimum;
 			address = HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE;
 			break;
+		case  CHANNEL_SCAN_INDEX_CHROMATICITY_X:
+			report_id = als_state->als[chan->scan_index].report_id;
+			min = als_state->als[chan->scan_index].logical_minimum;
+			address = HID_USAGE_SENSOR_LIGHT_CHROMATICITY_X;
+			break;
+		case  CHANNEL_SCAN_INDEX_CHROMATICITY_Y:
+			report_id = als_state->als[chan->scan_index].report_id;
+			min = als_state->als[chan->scan_index].logical_minimum;
+			address = HID_USAGE_SENSOR_LIGHT_CHROMATICITY_Y;
+			break;
 		default:
 			report_id = -1;
 			break;
@@ -243,6 +279,14 @@ static int als_capture_sample(struct hid_sensor_hub_device *hsdev,
 		als_state->scan.illum[CHANNEL_SCAN_INDEX_COLOR_TEMP] = sample_data;
 		ret = 0;
 		break;
+	case HID_USAGE_SENSOR_LIGHT_CHROMATICITY_X:
+		als_state->scan.illum[CHANNEL_SCAN_INDEX_CHROMATICITY_X] = sample_data;
+		ret = 0;
+		break;
+	case HID_USAGE_SENSOR_LIGHT_CHROMATICITY_Y:
+		als_state->scan.illum[CHANNEL_SCAN_INDEX_CHROMATICITY_Y] = sample_data;
+		ret = 0;
+		break;
 	case HID_USAGE_SENSOR_TIME_TIMESTAMP:
 		als_state->timestamp = hid_sensor_convert_timestamp(&als_state->common_attributes,
 								    *(s64 *)raw_data);
@@ -291,6 +335,25 @@ static int als_parse_report(struct platform_device *pdev,
 		st->als[CHANNEL_SCAN_INDEX_COLOR_TEMP].index,
 		st->als[CHANNEL_SCAN_INDEX_COLOR_TEMP].report_id);
 
+	for (i = 0; i < 2; i++) {
+		int next_scan_index = CHANNEL_SCAN_INDEX_CHROMATICITY_X + i;
+
+		ret = sensor_hub_input_get_attribute_info(hsdev,
+				HID_INPUT_REPORT, usage_id,
+				HID_USAGE_SENSOR_LIGHT_CHROMATICITY_X + i,
+				&st->als[next_scan_index]);
+		if (ret < 0)
+			return ret;
+
+		als_adjust_channel_bit_mask(channels,
+					CHANNEL_SCAN_INDEX_CHROMATICITY_X + i,
+					st->als[next_scan_index].size);
+
+		dev_dbg(&pdev->dev, "als %x:%x\n",
+			st->als[next_scan_index].index,
+			st->als[next_scan_index].report_id);
+	}
+
 	st->scale_precision = hid_sensor_format_scale(usage_id,
 				&st->als[CHANNEL_SCAN_INDEX_INTENSITY],
 				&st->scale_pre_decml, &st->scale_post_decml);
diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
index 8af4fb3e0254..6730ee900ee1 100644
--- a/include/linux/hid-sensor-ids.h
+++ b/include/linux/hid-sensor-ids.h
@@ -22,6 +22,9 @@
 #define HID_USAGE_SENSOR_DATA_LIGHT				0x2004d0
 #define HID_USAGE_SENSOR_LIGHT_ILLUM				0x2004d1
 #define HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE		0x2004d2
+#define HID_USAGE_SENSOR_LIGHT_CHROMATICITY			0x2004d3
+#define HID_USAGE_SENSOR_LIGHT_CHROMATICITY_X			0x2004d4
+#define HID_USAGE_SENSOR_LIGHT_CHROMATICITY_Y			0x2004d5
 
 /* PROX (200011) */
 #define HID_USAGE_SENSOR_PROX                                   0x200011
-- 
2.25.1

