Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC9C7A153F
	for <lists+linux-iio@lfdr.de>; Fri, 15 Sep 2023 07:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbjIOFRo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Sep 2023 01:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbjIOFRn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Sep 2023 01:17:43 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC172710;
        Thu, 14 Sep 2023 22:17:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8fkpGmR5YPjlCBdDAH7o0vKYpMWjPIqBSKTxbKQi/rGW2D0d2QmT2ESCvOv0q4OB9gMqMNzN93yr9RM/Es7eBmICa2WpdNUCYpJshsXPxGpWTg2UHDGwypDGbA38WtEQ68O4tElaM0hwRgkQixvo4ixSeu5ieFimQEqLJnt4daQ+7Ysrg4Xm11aqb69Nb62Pw6fJAwax7dGqTodKBIMADOolVwHduwSeMDhaY4brfZ3V0bzmX0prcDpx/DNF8FyWd/O+CFj97AbDBZF+eovj5Xv6ZLVzXM1S8JPJuSe/nWrohH88sI1nk1/skZWRmSJHpxRKacaDyoj+F4m7N6Sbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=szscW+H/lvO7RzJiks8ZmmTn3miMxUiMGEQWZI07Tz0=;
 b=fpnPr9HhJAwY98Kd4C8tN1TTXvL9UdKxR78xigWy5NUFfH1xlIBJi7lUv8G1Gwnw0NJwv4S0gnkaoI6KbsKSbs40AzhzbSxu7sbuAVrsqS2uj123yUbn5sI7F4C+oNI1uPhKX9enAlA8atDjqdQ9+GulXHOXlqflHhPy3HKoKaCMRK96kSOhLSYrc5cmCn85KvxLIIeyDTQ0c+vSyZPj6wZWtP+0oRX+igCDgE8gR+G6gFfcsEPMRUC5NI54as59yYVPKmW+7PjgAoBdaY2C40Hc9O6OQYr7FN4Q8Ws41F5LBPSjGmFE69BgdUBJI4mTfsXYBmBrr0xRE+5qWbSoLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szscW+H/lvO7RzJiks8ZmmTn3miMxUiMGEQWZI07Tz0=;
 b=WWFp60x1prxKCEKQ/qCc9aFGCY+8lTKK3dA/YaMZW7sZT2IM9LZRdEjaBYuHWUK9N7gJOH3NjAwFlw7yjl6hVlWiMiwVdnPjC5Orc74VZoHWpBBFIr4qUpJdajsHn5bhIYafNNBTcWEEXGyLEZtTVZqJGW17Z0mZPPlFH/xYmhg=
Received: from SN6PR2101CA0001.namprd21.prod.outlook.com
 (2603:10b6:805:106::11) by PH0PR12MB5434.namprd12.prod.outlook.com
 (2603:10b6:510:d5::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Fri, 15 Sep
 2023 05:17:35 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:805:106:cafe::cd) by SN6PR2101CA0001.outlook.office365.com
 (2603:10b6:805:106::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.8 via Frontend
 Transport; Fri, 15 Sep 2023 05:17:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 15 Sep 2023 05:17:34 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Sep
 2023 00:17:31 -0500
From:   Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To:     <jikos@kernel.org>, <benjamin.tissoires@redhat.com>,
        <jic23@kernel.org>, <lars@metafoo.de>,
        <srinivas.pandruvada@linux.intel.com>,
        <linux-input@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH 2/8] iio: hid-sensor-als: Add light color temperature support
Date:   Fri, 15 Sep 2023 10:46:57 +0530
Message-ID: <20230915051703.1689578-3-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|PH0PR12MB5434:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bbd68b1-b6d0-4cbc-3224-08dbb5ab11fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: foK2+KH4Dbm9dZoLt3cBzlq1IhnDnqUWb64kWtC5K20DVmLyrg5E4MVhl793Vk1xqvUCVi1i6NtRNIET7EeAjltHxY9Tripg2/NAGUdHzGzQvPAQYRYlipQ7nDsnKJsZ6aZmmlZIKYMCvcPqM8If6I1wquF750h5XIMO+rjYw51904IMmO1HG07Nlvoo7+dmWKiRnalcT3dbLF0viN9onWecVXSV/Bth8inj1BAkG0v6/vbXIjjC5blbO88yRolH83LsI3WSmFAHZHCbnF2ys4GW2IJVIcBKEwiSYjP4RAXGpEAY5oFb+le+AfKVG42m1RJzUwBYYd0NPIrMircfaNDJEVMo4EJyYkucFIXAZR8aFC8CIthoQkm9ttNtg4QmV+SCl2IINPpuJaUOzf0d31NttH3f69Qe5P+ZTrPK8T23h4AKL6GhUt65VBmVIw24qfLtQ5gjZKQrvNshxZaQTSvwmkT7XBm6rHshCikjmHE4CWM8jn67eigAMuQIPeoXurMMO9CxFkVPnUEaw+6GASXDt9fdUI8IWGc2jW3SqL3Dca8yyaUOa/6AjIo1MjbvmJHL1iZrGDLeTSWK57nVPaBtceVFBi/h3yTT7bT0CA9oib0DS2ftafDbe0BbuqSVQAocvA/6sd3+iFj6a3q3fD2UNaOOnD2zltHUEjq/oHf82Yjw1AS4k/c1nnOERJtpOs5Hn0tfy12CIe6CXK5AZFPGG/5UrXKuyr1YDxvyhzYe/NXejxmHzdqE+YDaYJmYGr8MWGj0+zS1cCeSVlKzLg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(396003)(346002)(82310400011)(1800799009)(186009)(451199024)(46966006)(36840700001)(40470700004)(41300700001)(47076005)(8936002)(40480700001)(478600001)(36860700001)(8676002)(4326008)(70206006)(110136005)(1076003)(70586007)(16526019)(6666004)(2616005)(7696005)(336012)(426003)(26005)(316002)(40460700003)(2906002)(5660300002)(81166007)(86362001)(356005)(82740400003)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 05:17:34.8142
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bbd68b1-b6d0-4cbc-3224-08dbb5ab11fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5434
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
 drivers/iio/light/hid-sensor-als.c | 33 ++++++++++++++++++++++++++++++
 include/linux/hid-sensor-ids.h     |  1 +
 2 files changed, 34 insertions(+)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index 48879e233aec..220fb93fea6d 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -16,6 +16,7 @@
 enum {
 	CHANNEL_SCAN_INDEX_INTENSITY = 0,
 	CHANNEL_SCAN_INDEX_ILLUM = 1,
+	CHANNEL_SCAN_INDEX_COLOR_TEMP,
 	CHANNEL_SCAN_INDEX_MAX
 };
 
@@ -65,6 +66,18 @@ static const struct iio_chan_spec als_channels[] = {
 		BIT(IIO_CHAN_INFO_HYSTERESIS_RELATIVE),
 		.scan_index = CHANNEL_SCAN_INDEX_ILLUM,
 	},
+	{
+		.type = IIO_TEMP,
+		.modified = 1,
+		.channel2 = IIO_MOD_TEMP_AMBIENT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
+			BIT(IIO_CHAN_INFO_SCALE) |
+			BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+			BIT(IIO_CHAN_INFO_HYSTERESIS) |
+			BIT(IIO_CHAN_INFO_HYSTERESIS_RELATIVE),
+		.scan_index = CHANNEL_SCAN_INDEX_COLOR_TEMP,
+	},
 	IIO_CHAN_SOFT_TIMESTAMP(CHANNEL_SCAN_INDEX_TIMESTAMP)
 };
 
@@ -103,6 +116,11 @@ static int als_read_raw(struct iio_dev *indio_dev,
 			min = als_state->als_illum[chan->scan_index].logical_minimum;
 			address = HID_USAGE_SENSOR_LIGHT_ILLUM;
 			break;
+		case  CHANNEL_SCAN_INDEX_COLOR_TEMP:
+			report_id = als_state->als_illum[chan->scan_index].report_id;
+			min = als_state->als_illum[chan->scan_index].logical_minimum;
+			address = HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE;
+			break;
 		default:
 			report_id = -1;
 			break;
@@ -223,6 +241,10 @@ static int als_capture_sample(struct hid_sensor_hub_device *hsdev,
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
@@ -256,6 +278,17 @@ static int als_parse_report(struct platform_device *pdev,
 			st->als_illum[i].report_id);
 	}
 
+	ret = sensor_hub_input_get_attribute_info(hsdev, HID_INPUT_REPORT, usage_id,
+						  HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE,
+						  &st->als_illum[CHANNEL_SCAN_INDEX_COLOR_TEMP]);
+	if (ret < 0)
+		return ret;
+	als_adjust_channel_bit_mask(channels, CHANNEL_SCAN_INDEX_COLOR_TEMP,
+				    st->als_illum[CHANNEL_SCAN_INDEX_COLOR_TEMP].size);
+
+	dev_dbg(&pdev->dev, "als %x:%x\n", st->als_illum[CHANNEL_SCAN_INDEX_COLOR_TEMP].index,
+		st->als_illum[CHANNEL_SCAN_INDEX_COLOR_TEMP].report_id);
+
 	st->scale_precision = hid_sensor_format_scale(usage_id,
 						      &st->als_illum[CHANNEL_SCAN_INDEX_INTENSITY],
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

