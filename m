Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7D77A1547
	for <lists+linux-iio@lfdr.de>; Fri, 15 Sep 2023 07:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjIOFSD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Sep 2023 01:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbjIOFSD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Sep 2023 01:18:03 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE659273D;
        Thu, 14 Sep 2023 22:17:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gqinrb9mGJxtsqh8zCFtCOu4qFfNSIGOk4KlTVIJUoediLDXH9QFe6RhE1xq37zmC3i4NWwhUcC94i19FC7Xin2h+VYKWVuBPfxjxaPR6SoSRu76hYRZylt2Il32Lqza1d8PQ90CFxmBduSbw8+G8GYCnYgwfim0Yt3FjD3s+vZ8uI6CLek1HB+rMtq8G0xXFul1gFdPnrXZqpiklbV1TlbWPFJVJ6esh5Q9bpg7rH7nsAjnuAT3rpyCreJUzOVfg1y3ALbVdInkuODDDAIv3Gzk4zz2YFTpIcNPszdTKhTi5tLqvmVN0MVtlSHm1WAi0I27x7b5zFuJOO38EM+PwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6SYNI5KhPfkUW0S1N8Zeq2VkK4MmJnF7ioBLAkD8gCs=;
 b=lORQWz+S9pmkJoD1UZPzHgtLaNeRSjKIzk8/98ilhsZ7VhJJHz/EPnZGY9xZF052oJRdpLM5pSRls04FPWVeDe2f2Up0HdQVbiQtXbUQ1VPwyL+fSObbLKtziMZEYn/4fd5QKiIfZU8xLXHd5I3G9vbd9P++qNGkxv2TDMU6qv/C3yw5tfrrF3V3EaPEvdr4Zrn7M30tGXhTbZxU+ztT+h841XdfBKXKIfiAqp4THozStMIuD3QqT5ngxHiaO7aq5PpoZ+pXF14OC7xqidEIfKfFoWabnVACuTWDvfFSgGbRuwl5RmhAk+GtPh0uNCLA10ejtwudWlWw6pdpBtPzBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6SYNI5KhPfkUW0S1N8Zeq2VkK4MmJnF7ioBLAkD8gCs=;
 b=ZILOg6KAWS7gJozkqH85f9UcexBwms1QYkUziSNOw5E7QK8Ol12BsRR/Q+vWjxAgQZI3MRVsrFOdE9VcL6SkpAPffan8buLiew57rRITg4NmkemNNGUKJtMNfJZvMYZlxbfOHRSbYV/KBffa0LcgenK6JK4Z2YOfbbLCk5cLIVY=
Received: from SA9PR13CA0106.namprd13.prod.outlook.com (2603:10b6:806:24::21)
 by MW6PR12MB9000.namprd12.prod.outlook.com (2603:10b6:303:24b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Fri, 15 Sep
 2023 05:17:47 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:24:cafe::6) by SA9PR13CA0106.outlook.office365.com
 (2603:10b6:806:24::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Fri, 15 Sep 2023 05:17:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 15 Sep 2023 05:17:46 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Sep
 2023 00:17:44 -0500
From:   Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To:     <jikos@kernel.org>, <benjamin.tissoires@redhat.com>,
        <jic23@kernel.org>, <lars@metafoo.de>,
        <srinivas.pandruvada@linux.intel.com>,
        <linux-input@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH 6/8] iio: hid-sensor-als: Add light chromaticity support
Date:   Fri, 15 Sep 2023 10:47:01 +0530
Message-ID: <20230915051703.1689578-7-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|MW6PR12MB9000:EE_
X-MS-Office365-Filtering-Correlation-Id: 97af09c7-2697-469c-3add-08dbb5ab1939
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iWQEppS7HxtWuEnB5kRNNU8i5UyRyjmObu6fcuZ4HD9JHJdLauLINZVElTE/KKLXCtyp2tJNOoQBe6bzfm/fSSpO+UIQmoKrvEK/sJN1Xfz3dc9VjvSIHafsCxzHsHN4LaPOm0v+kX5veyGw4tyr1Xadq9BnEqbHnKc7kiUB8JKLQqMs6okW6NFPpQu/VFdVaFWlRpo+Sll2yDwZ4ZJwRJZAs+Dm8eE2A78i2KnlBlGA27CbtkMlQ9XDv4/I/aJ29Vwh+rOvPZpd3gcuAGHpoh7gQzUv85sPPcrVg4fBMZsRoNSZM58bBvQ1nJ/zTG2jeOPbNpAyRRGrREWwK+EQrEvw8ady52jq/sw/IiPJCvoappTyDw/g2oQwD0/nL17ip5iwuYbaQyMlM98lRzM2Me+kwvTdgxHvdCpLd4ep/uXWtirS2E4w+3/QeBI4sH+n9r3b8npU3jk/FrTAqw5EzV1YT9xELELhVaKHzL129m8lvuGIVHj667Nc8INSKtwXUWMyidtHFqv4QOHCZIIIWdyXXVcgMNxlu8dwNTNKSSFwu8G1g9S5rEU+PK0hhYZT17d9xEXyNCVm7aKAZs/cTv1qS2cVAbajkmn4+0nLfsRpTwi4eUa8+egnRK0m39EXDr3MXHdRbVe5ZdB4DYWi6I8UNZyMKc3EaQ3CirzhCYN/UIAmB42OkRxj9lNcbWiNKfVJrVPSCi68xsTTSlBPSSeOhY91MTaCZMGXKwzm/rZQcFscGjeNYocZvB/+MBADdKwzNvuDtfwDabVOnM+k9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(39860400002)(346002)(82310400011)(451199024)(1800799009)(186009)(40470700004)(46966006)(36840700001)(8936002)(8676002)(4326008)(7696005)(6666004)(41300700001)(5660300002)(478600001)(316002)(70586007)(70206006)(2906002)(110136005)(26005)(16526019)(1076003)(2616005)(336012)(426003)(47076005)(36860700001)(36756003)(40480700001)(356005)(40460700003)(82740400003)(81166007)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 05:17:46.9804
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97af09c7-2697-469c-3add-08dbb5ab1939
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9000
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
 drivers/iio/light/hid-sensor-als.c | 61 ++++++++++++++++++++++++++++++
 include/linux/hid-sensor-ids.h     |  3 ++
 2 files changed, 64 insertions(+)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index 220fb93fea6d..e1a2cc83b892 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -17,6 +17,8 @@ enum {
 	CHANNEL_SCAN_INDEX_INTENSITY = 0,
 	CHANNEL_SCAN_INDEX_ILLUM = 1,
 	CHANNEL_SCAN_INDEX_COLOR_TEMP,
+	CHANNEL_SCAN_INDEX_CHROMATICITY_X,
+	CHANNEL_SCAN_INDEX_CHROMATICITY_Y,
 	CHANNEL_SCAN_INDEX_MAX
 };
 
@@ -78,6 +80,30 @@ static const struct iio_chan_spec als_channels[] = {
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
 
@@ -121,6 +147,16 @@ static int als_read_raw(struct iio_dev *indio_dev,
 			min = als_state->als_illum[chan->scan_index].logical_minimum;
 			address = HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE;
 			break;
+		case  CHANNEL_SCAN_INDEX_CHROMATICITY_X:
+			report_id = als_state->als_illum[chan->scan_index].report_id;
+			min = als_state->als_illum[chan->scan_index].logical_minimum;
+			address = HID_USAGE_SENSOR_LIGHT_CHROMATICITY_X;
+			break;
+		case  CHANNEL_SCAN_INDEX_CHROMATICITY_Y:
+			report_id = als_state->als_illum[chan->scan_index].report_id;
+			min = als_state->als_illum[chan->scan_index].logical_minimum;
+			address = HID_USAGE_SENSOR_LIGHT_CHROMATICITY_Y;
+			break;
 		default:
 			report_id = -1;
 			break;
@@ -245,6 +281,14 @@ static int als_capture_sample(struct hid_sensor_hub_device *hsdev,
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
@@ -289,6 +333,23 @@ static int als_parse_report(struct platform_device *pdev,
 	dev_dbg(&pdev->dev, "als %x:%x\n", st->als_illum[CHANNEL_SCAN_INDEX_COLOR_TEMP].index,
 		st->als_illum[CHANNEL_SCAN_INDEX_COLOR_TEMP].report_id);
 
+	for (i = 0; i < 2; i++) {
+		int next_scan_index = CHANNEL_SCAN_INDEX_CHROMATICITY_X + i;
+
+		ret = sensor_hub_input_get_attribute_info(hsdev, HID_INPUT_REPORT, usage_id,
+							  HID_USAGE_SENSOR_LIGHT_CHROMATICITY_X + i,
+							  &st->als_illum[next_scan_index]);
+		if (ret < 0)
+			return ret;
+
+		als_adjust_channel_bit_mask(channels, CHANNEL_SCAN_INDEX_CHROMATICITY_X + i,
+					    st->als_illum[next_scan_index].size);
+
+		dev_dbg(&pdev->dev, "als %x:%x\n",
+			st->als_illum[next_scan_index].index,
+			st->als_illum[next_scan_index].report_id);
+	}
+
 	st->scale_precision = hid_sensor_format_scale(usage_id,
 						      &st->als_illum[CHANNEL_SCAN_INDEX_INTENSITY],
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

