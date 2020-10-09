Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 347642897C9
	for <lists+linux-iio@lfdr.de>; Fri,  9 Oct 2020 22:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732975AbgJIUE5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Oct 2020 16:04:57 -0400
Received: from mail-co1nam11on2089.outbound.protection.outlook.com ([40.107.220.89]:6880
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390711AbgJIUDW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 9 Oct 2020 16:03:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nd4wVcWmAsAZ8f5K3pkh8IhEOa1m93ZUuxFiTHc8QiqGOR8qjOIOHHw3CI0dsg+5iQenyohOaFzuuZI05ZGrvKCggzbLM0+iiktdMK/+DWpUwbeFobMSz4BuA/HmA5pQRGA8je/1VPH81Mftepjzz/asp01KJlFqrTxDitvqnMcLjp6Iy9w2HobsrDqoDUjbU0tBjSmcxjy6LVELcJCDlRXLQhkw3N/IxK0jkMf7EOorzqYfrbQGAChaO/MpGjSpg4ZRpbR/wTZaIg1KoJrHWfuca6zmr9ELfuzkZI9VAOpV+4/fuadridWH2oixkf0wXSeC74AIn7IbvUypFDc3yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CaZNTXdFuKcmeeO+nus8QT5cdZa1JLd+vECe5x6yChg=;
 b=YivPqcia7BhPot0vYnCc4B4E57nYvu4Y+3toX9Vt/pThoj9E43e3CbfddmWrUM7NQ8cyMk+8bi3+LrzMfdhxPMZfBZS/FAX56X7c4t/KNDs1ng7RRbw0kLiH4VyTVlcE3iOYsUwE8FcOZ/e7aFi+olhy/Sc1ZqRr+WlGc6U148yu7yYHdojXaMukK8SKWfiLTp87gchocdFIbh/+t6w1/obX14xFnIhUkJElUhYVjJXiUh5fwzW8L5AHH99r2jRncB63b7SFxrMhWE3AHfhdqiCRKGyjr+jeP+8H45pf3wij80gW+evXSbvSqtsFiGot/ANe6hnKG5B8V5aQWWM18w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CaZNTXdFuKcmeeO+nus8QT5cdZa1JLd+vECe5x6yChg=;
 b=Gt1fZvDjGFo/lyvVcPiO33l4cIOyKxm850XPMiSL0C0PidQtd4zr+8nubVvKPyYseKtW05IyNGStu1OhO4vBN28bd3uVC/K7fAmtnm7N/qVZn7wDvRd6cKjMZthbGlKww4ElkmWtO7PVaeOM9TZ/UEdd2vOCdduIcKNdKIhskXQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22)
 by CH2PR12MB4040.namprd12.prod.outlook.com (2603:10b6:610:ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Fri, 9 Oct
 2020 20:02:36 +0000
Received: from CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::a110:b7c8:73bd:d60]) by CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::a110:b7c8:73bd:d60%8]) with mapi id 15.20.3455.027; Fri, 9 Oct 2020
 20:02:36 +0000
From:   Sandeep Singh <Sandeep.Singh@amd.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        srinivas.pandruvada@linux.intel.com, jic23@kernel.org,
        linux-iio@vger.kernel.org, hdegoede@redhat.com,
        Nehal-bakulchandra.Shah@amd.com, andy.shevchenko@gmail.com,
        mail@richard-neumann.de, m.felsch@pengutronix.de,
        rdunlap@infradead.org
Cc:     Shyam-sundar.S-k@amd.com, Sandeep Singh <sandeep.singh@amd.com>
Subject: [PATCH v8 4/4] SFH: Create HID report to Enable support of AMD sensor fusion Hub (SFH)
Date:   Sat, 10 Oct 2020 01:31:38 +0530
Message-Id: <20201009200138.1847317-5-Sandeep.Singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201009200138.1847317-1-Sandeep.Singh@amd.com>
References: <20201009200138.1847317-1-Sandeep.Singh@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MAXPR0101CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::24) To CH2PR12MB4101.namprd12.prod.outlook.com
 (2603:10b6:610:a8::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jatayu.amd.com (165.204.156.251) by MAXPR0101CA0038.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:d::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23 via Frontend Transport; Fri, 9 Oct 2020 20:02:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b532a468-9adf-4f62-5726-08d86c8e4461
X-MS-TrafficTypeDiagnostic: CH2PR12MB4040:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4040D5AF7C3A05DA9154873EE0080@CH2PR12MB4040.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zg2eXVw4ZAgnYMgACcHbYHkC0UBYiWJEm3GZMF/DRHDHQbSX181Kx6l6yOyVedSos+JGWWscTTqnD5EZ2tSUUgICl8H4aUE7uDPQmpRdVyXzcr3vmX/w3Rdl4OPc1Tll4Y9veZDr/ALevPqHmO+hSb/WTt2XlWo8nvvy24tCr6sz+CwU1uBfXq4FojCVht8NA3omvODiiExusaSirvevGq4bg8vtum0HpF8st59lrD+goEQnqPNhx/76TmEjNnygHBUKM029Ntf5qQ/sbUjiAKjIg81u6PsyghRuqjWO/kZEum/1ZCGz5FZJEq5c1ch771Nxnn00HI0JnSkrz+F4niYpd2IS4DDrYk2z+hHK1+u0CJafiNjnmNN6pZ//g8NN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(86362001)(83380400001)(316002)(4326008)(2906002)(36756003)(26005)(478600001)(8676002)(52116002)(7696005)(16526019)(186003)(956004)(2616005)(7416002)(1076003)(8936002)(30864003)(5660300002)(66946007)(66476007)(66556008)(6486002)(921003)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: V1EuwvLL/IB52T7v0cWqCXLQc0z0olxEkzIFXsh51jd7mwo0GyJZk1UZu1H09F6cLsUASmbjeSEuuyMxTftmPpRRxM5kHgzO6cm1KXXIM3iikhlif5LKsNIc2QMkjJGslBvkztHdOWBFdW+ymSJpVxBMwHSblcxQc4PiUqzdNbz5mJUUxm9eEILnhD0fbTavok9wqiHzmg7ic9uNcpRuc5kUu943YJUiw2xYRNHzHn7HW5mTTe9/l/2KJe8Iyi8xe8M5QKMZ9eRaM7AZPP7VDOSYuNl8Sob2GwyF3/btxRHOQIn7tLqtt5f/zgrhMMYrmXP30B9rZdy19Nd2heOWNNUgkeKWLk22I+uvCsN9znQYpSsKjWBtbDpK8ePqb3Ucd2sRPqNFd+Ifoz5NgnxEY//WekLsPe2F/2s2ksYinCEC/o25GtC7r1ikqYsbhvFzHSWhFbJzTicBu/tkdj82bqHBdBTgPjgSNxa+xoDnqyjWUK1XHw9E+pQmCc+jKAJp+dVg6AeRG6pGopkNGYnAONxCSQD3i1OG/MULkdp0ZQo82UVQmaXbPSk0c+77JvJ9zbuhcNvybysS2Kz9PnFhrKNRf1lQZQhQq8804m8OAkr3OWH824Jr+m6pv1Plijr619cYlL/dJ6BH/9HVI/3eJQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b532a468-9adf-4f62-5726-08d86c8e4461
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2020 20:02:36.3272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M2jrnjNzglhH8IQ2RMGZfuWA1KlOewKey5OmGU5WcsLSwyHlXvKa1O4BKfLXOVmU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4040
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Sandeep Singh <sandeep.singh@amd.com>

Communication between HID devices and HID core is mostly done
via HID reports. HID reports are formed based on the data received
from the PCI layer into the HID report descriptors.

Co-developed-by: Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
Signed-off-by: Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
Signed-off-by: Sandeep Singh <sandeep.singh@amd.com>
---
 .../hid_descriptor/amd_sfh_hid_desc.c         | 224 ++++++
 .../hid_descriptor/amd_sfh_hid_desc.h         | 121 ++++
 .../hid_descriptor/amd_sfh_hid_report_desc.h  | 645 ++++++++++++++++++
 3 files changed, 990 insertions(+)
 create mode 100644 drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c
 create mode 100644 drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h
 create mode 100644 drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h

diff --git a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c
new file mode 100644
index 000000000000..6e3ad66e57a4
--- /dev/null
+++ b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c
@@ -0,0 +1,224 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  AMD SFH Report Descriptor generator
+ *  Copyright 2020 Advanced Micro Devices, Inc.
+ *  Authors: Nehal Bakulchandra Shah <Nehal-Bakulchandra.Shah@amd.com>
+ *	     Sandeep Singh <sandeep.singh@amd.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include "amd_sfh_pcie.h"
+#include "amd_sfh_hid_desc.h"
+#include "amd_sfh_hid_report_desc.h"
+
+#define	AMD_SFH_FW_MULTIPLIER (1000)
+#define HID_USAGE_SENSOR_PROP_REPORTING_STATE_ALL_EVENTS_ENUM	0x41
+#define HID_USAGE_SENSOR_PROP_POWER_STATE_D0_FULL_POWER_ENUM	0x51
+#define HID_DEFAULT_REPORT_INTERVAL				0x50
+#define HID_DEFAULT_MIN_VALUE					0X7F
+#define HID_DEFAULT_MAX_VALUE					0x80
+#define HID_DEFAULT_SENSITIVITY					0x7F
+#define HID_USAGE_SENSOR_PROPERTY_CONNECTION_TYPE_PC_INTEGRATED_ENUM  0x01
+/* state enums */
+#define HID_USAGE_SENSOR_STATE_READY_ENUM                             0x02
+#define HID_USAGE_SENSOR_STATE_INITIALIZING_ENUM                      0x05
+#define HID_USAGE_SENSOR_EVENT_DATA_UPDATED_ENUM                      0x04
+
+int get_report_descriptor(int sensor_idx, u8 *rep_desc)
+{
+	switch (sensor_idx) {
+	case accel_idx: /* accel */
+		memset(rep_desc, 0, sizeof(accel3_report_descriptor));
+		memcpy(rep_desc, accel3_report_descriptor,
+		       sizeof(accel3_report_descriptor));
+		break;
+	case gyro_idx: /* gyro */
+		memset(rep_desc, 0, sizeof(gyro3_report_descriptor));
+		memcpy(rep_desc, gyro3_report_descriptor,
+		       sizeof(gyro3_report_descriptor));
+		break;
+	case mag_idx: /* Magnetometer */
+		memset(rep_desc, 0, sizeof(comp3_report_descriptor));
+		memcpy(rep_desc, comp3_report_descriptor,
+		       sizeof(comp3_report_descriptor));
+		break;
+	case als_idx: /* ambient light sensor */
+		memset(rep_desc, 0, sizeof(als_report_descriptor));
+		memcpy(rep_desc, als_report_descriptor,
+		       sizeof(als_report_descriptor));
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+u32 get_descr_sz(int sensor_idx, int descriptor_name)
+{
+	switch (sensor_idx) {
+	case accel_idx:
+		switch (descriptor_name) {
+		case descr_size:
+			return sizeof(accel3_report_descriptor);
+		case input_size:
+			return sizeof(struct accel3_input_report);
+		case feature_size:
+			return sizeof(struct accel3_feature_report);
+		}
+		break;
+	case gyro_idx:
+		switch (descriptor_name) {
+		case descr_size:
+			return sizeof(gyro3_report_descriptor);
+		case input_size:
+			return sizeof(struct gyro_input_report);
+		case feature_size:
+			return sizeof(struct gyro_feature_report);
+		}
+		break;
+	case mag_idx:
+		switch (descriptor_name) {
+		case descr_size:
+			return sizeof(comp3_report_descriptor);
+		case input_size:
+			return sizeof(struct magno_input_report);
+		case feature_size:
+			return sizeof(struct magno_feature_report);
+		}
+		break;
+	case als_idx:
+		switch (descriptor_name) {
+		case descr_size:
+			return sizeof(als_report_descriptor);
+		case input_size:
+			return sizeof(struct als_input_report);
+		case feature_size:
+			return sizeof(struct als_feature_report);
+		}
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+static void get_common_features(struct common_feature_property *common, int report_id)
+{
+	common->report_id = report_id;
+	common->connection_type = HID_USAGE_SENSOR_PROPERTY_CONNECTION_TYPE_PC_INTEGRATED_ENUM;
+	common->report_state = HID_USAGE_SENSOR_PROP_REPORTING_STATE_ALL_EVENTS_ENUM;
+	common->power_state = HID_USAGE_SENSOR_PROP_POWER_STATE_D0_FULL_POWER_ENUM;
+	common->sensor_state = HID_USAGE_SENSOR_STATE_INITIALIZING_ENUM;
+	common->report_interval =  HID_DEFAULT_REPORT_INTERVAL;
+}
+
+u8 get_feature_report(int sensor_idx, int report_id, u8 *feature_report)
+{
+	struct accel3_feature_report acc_feature;
+	struct gyro_feature_report gyro_feature;
+	struct magno_feature_report magno_feature;
+	struct als_feature_report als_feature;
+	u8 report_size = 0;
+
+	if (!feature_report)
+		return report_size;
+
+	switch (sensor_idx) {
+	case accel_idx: /* accel */
+		get_common_features(&acc_feature.common_property, report_id);
+		acc_feature.accel_change_sesnitivity = HID_DEFAULT_SENSITIVITY;
+		acc_feature.accel_sensitivity_min = HID_DEFAULT_MIN_VALUE;
+		acc_feature.accel_sensitivity_max = HID_DEFAULT_MAX_VALUE;
+		memcpy(feature_report, &acc_feature, sizeof(acc_feature));
+		report_size = sizeof(acc_feature);
+		break;
+	case gyro_idx: /* gyro */
+		get_common_features(&gyro_feature.common_property, report_id);
+		gyro_feature.gyro_change_sesnitivity = HID_DEFAULT_SENSITIVITY;
+		gyro_feature.gyro_sensitivity_min = HID_DEFAULT_MIN_VALUE;
+		gyro_feature.gyro_sensitivity_max = HID_DEFAULT_MAX_VALUE;
+		memcpy(feature_report, &gyro_feature, sizeof(gyro_feature));
+		report_size = sizeof(gyro_feature);
+		break;
+	case mag_idx: /* Magnetometer */
+		get_common_features(&magno_feature.common_property, report_id);
+		magno_feature.magno_headingchange_sensitivity = HID_DEFAULT_SENSITIVITY;
+		magno_feature.heading_min = HID_DEFAULT_MIN_VALUE;
+		magno_feature.heading_max = HID_DEFAULT_MAX_VALUE;
+		magno_feature.flux_change_sensitivity = HID_DEFAULT_MIN_VALUE;
+		magno_feature.flux_min = HID_DEFAULT_MIN_VALUE;
+		magno_feature.flux_max = HID_DEFAULT_MAX_VALUE;
+		memcpy(feature_report, &magno_feature, sizeof(magno_feature));
+		report_size = sizeof(magno_feature);
+		break;
+	case als_idx:  /* ambient light sensor */
+		get_common_features(&als_feature.common_property, report_id);
+		als_feature.als_change_sesnitivity = HID_DEFAULT_SENSITIVITY;
+		als_feature.als_sensitivity_min = HID_DEFAULT_MIN_VALUE;
+		als_feature.als_sensitivity_max = HID_DEFAULT_MAX_VALUE;
+		memcpy(feature_report, &als_feature, sizeof(als_feature));
+		report_size = sizeof(als_feature);
+		break;
+	default:
+		break;
+	}
+	return report_size;
+}
+
+static void get_common_inputs(struct common_input_property *common, int report_id)
+{
+	common->report_id = report_id;
+	common->sensor_state = HID_USAGE_SENSOR_STATE_READY_ENUM;
+	common->event_type = HID_USAGE_SENSOR_EVENT_DATA_UPDATED_ENUM;
+}
+
+u8 get_input_report(int sensor_idx, int report_id, u8 *input_report, u32 *sensor_virt_addr)
+{
+	struct accel3_input_report acc_input;
+	struct gyro_input_report gyro_input;
+	struct magno_input_report magno_input;
+	struct als_input_report als_input;
+	u8 report_size = 0;
+
+	if (!sensor_virt_addr || !input_report)
+		return report_size;
+
+	switch (sensor_idx) {
+	case accel_idx: /* accel */
+		get_common_inputs(&acc_input.common_property, report_id);
+		acc_input.in_accel_x_value = (int)sensor_virt_addr[0] / AMD_SFH_FW_MULTIPLIER;
+		acc_input.in_accel_y_value = (int)sensor_virt_addr[1] / AMD_SFH_FW_MULTIPLIER;
+		acc_input.in_accel_z_value =  (int)sensor_virt_addr[2] / AMD_SFH_FW_MULTIPLIER;
+		memcpy(input_report, &acc_input, sizeof(acc_input));
+		report_size = sizeof(acc_input);
+		break;
+	case gyro_idx: /* gyro */
+		get_common_inputs(&gyro_input.common_property, report_id);
+		gyro_input.in_angel_x_value = (int)sensor_virt_addr[0] / AMD_SFH_FW_MULTIPLIER;
+		gyro_input.in_angel_y_value = (int)sensor_virt_addr[1] / AMD_SFH_FW_MULTIPLIER;
+		gyro_input.in_angel_z_value =  (int)sensor_virt_addr[2] / AMD_SFH_FW_MULTIPLIER;
+		memcpy(input_report, &gyro_input, sizeof(gyro_input));
+		report_size = sizeof(gyro_input);
+		break;
+	case mag_idx: /* Magnetometer */
+		get_common_inputs(&magno_input.common_property, report_id);
+		magno_input.in_magno_x = (int)sensor_virt_addr[0] / AMD_SFH_FW_MULTIPLIER;
+		magno_input.in_magno_y = (int)sensor_virt_addr[1] / AMD_SFH_FW_MULTIPLIER;
+		magno_input.in_magno_z = (int)sensor_virt_addr[2] / AMD_SFH_FW_MULTIPLIER;
+		magno_input.in_magno_accuracy = (u16)sensor_virt_addr[3] / AMD_SFH_FW_MULTIPLIER;
+		memcpy(input_report, &magno_input, sizeof(magno_input));
+		report_size = sizeof(magno_input);
+		break;
+	case als_idx: /* Als */
+		get_common_inputs(&als_input.common_property, report_id);
+		als_input.illuminance_value =  (int)sensor_virt_addr[0] / AMD_SFH_FW_MULTIPLIER;
+		report_size = sizeof(als_input);
+		memcpy(input_report, &als_input, sizeof(als_input));
+		break;
+	default:
+		break;
+	}
+	return report_size;
+}
diff --git a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h
new file mode 100644
index 000000000000..ac9a01cc1454
--- /dev/null
+++ b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h
@@ -0,0 +1,121 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * HID report descriptors, structures and routines
+ * Copyright 2020 Advanced Micro Devices, Inc.
+ * Authors: Nehal Bakulchandra Shah <Nehal-bakulchandra.shah@amd.com>
+ *	    Sandeep Singh <Sandeep.singh@amd.com>
+ */
+
+#ifndef AMD_SFH_HID_DESCRIPTOR_H
+#define AMD_SFH_HID_DESCRIPTOR_H
+
+enum desc_type {
+	/* Report descriptor name */
+	descr_size = 1,
+	input_size,
+	feature_size,
+};
+
+struct _hid_report_descriptor {
+	u8 bDescriptorType;
+	u8 wDescriptorLength;
+};
+
+struct common_feature_property {
+	/* common properties */
+	u8 report_id;
+	u8 connection_type;
+	u8 report_state;
+	u8 power_state;
+	u8 sensor_state;
+	u32 report_interval;
+} __packed;
+
+struct common_input_property {
+	/* common properties */
+	u8 report_id;
+	u8 sensor_state;
+	u8 event_type;
+} __packed;
+
+struct _hid_device_descriptor {
+	u8 bLength;
+	u8 bDescriptorType;
+	u8 bcdHID[2];
+	u8 bCountryCode;
+	u8 bNumDescriptors;
+	struct _hid_report_descriptor *reports;
+};
+
+struct accel3_feature_report {
+	struct common_feature_property common_property;
+	/* properties specific to this sensor */
+	u16 accel_change_sesnitivity;
+	s16 accel_sensitivity_max;
+	s16 accel_sensitivity_min;
+} __packed;
+
+struct accel3_input_report {
+	struct	common_input_property common_property;
+	/* values specific to this sensor */
+	int in_accel_x_value;
+	int in_accel_y_value;
+	int in_accel_z_value;
+	/* include if required to support the "shake" event */
+	u8 in_accel_shake_detection;
+} __packed;
+
+struct gyro_feature_report {
+	struct common_feature_property common_property;
+	/* properties specific to this sensor */
+	u16 gyro_change_sesnitivity;
+	s16 gyro_sensitivity_max;
+	s16 gyro_sensitivity_min;
+} __packed;
+
+struct gyro_input_report {
+	struct	common_input_property common_property;
+	/* values specific to this sensor */
+	int in_angel_x_value;
+	int in_angel_y_value;
+	int in_angel_z_value;
+} __packed;
+
+struct magno_feature_report {
+	struct common_feature_property common_property;
+	/*properties specific to this sensor */
+	u16 magno_headingchange_sensitivity;
+	s16 heading_min;
+	s16 heading_max;
+	u16 flux_change_sensitivity;
+	s16 flux_min;
+	s16 flux_max;
+} __packed;
+
+struct magno_input_report {
+	struct	common_input_property common_property;
+	int in_magno_x;
+	int in_magno_y;
+	int in_magno_z;
+	int in_magno_accuracy;
+} __packed;
+
+struct als_feature_report {
+	struct common_feature_property common_property;
+	/* properties specific to this sensor */
+	u16 als_change_sesnitivity;
+	s16 als_sensitivity_max;
+	s16 als_sensitivity_min;
+} __packed;
+
+struct als_input_report {
+	struct common_input_property common_property;
+	/* values specific to this sensor */
+	int illuminance_value;
+} __packed;
+
+int get_report_descriptor(int sensor_idx, u8 rep_desc[]);
+u32 get_descr_sz(int sensor_idx, int descriptor_name);
+u8 get_feature_report(int sensor_idx, int report_id, u8 *feature_report);
+u8 get_input_report(int sensor_idx, int report_id, u8 *input_report, u32 *sensor_virt_addr);
+#endif
diff --git a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h
new file mode 100644
index 000000000000..44271d39b322
--- /dev/null
+++ b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h
@@ -0,0 +1,645 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * HID  descriptor stuructures
+ * Copyright 2020 Advanced Micro Devices, Inc.
+ * Authors: Nehal Bakulchandra Shah <Nehal-bakulchandra.shah@amd.com>
+ *	    Sandeep Singh <Sandeep.singh@amd.com>
+ */
+
+#ifndef AMD_SFH_HID_REPORT_DESCRIPTOR_H
+#define AMD_SFH_HID_REPORT_DESCRIPTOR_H
+
+// Accelerometer 3D Sensor
+static const u8 accel3_report_descriptor[] = {
+0x05, 0x20,          /* Usage page */
+0x09, 0x73,          /* Motion type Accel 3D */
+0xA1, 0x00,          /* HID Collection (Physical) */
+
+//feature reports(xmit/receive)
+0x85, 1,           /* HID  Report ID */
+0x05, 0x20,	   /* HID usage page sensor */
+0x0A, 0x09, 0x03,  /* Sensor property and sensor connection type */
+0x15, 0,           /* HID logical MIN_8(0) */
+0x25, 2,	   /* HID logical MAX_8(2) */
+0x75, 8,	   /* HID report size(8) */
+0x95, 1,	   /* HID report count(1) */
+0xA1, 0x02,	   /* HID collection (logical) */
+0x0A, 0x30, 0x08, /* Sensor property connection type intergated sel*/
+0x0A, 0x31, 0x08, /* Sensor property connection type attached sel */
+0x0A, 0x32, 0x08, /* Sensor property connection type external sel */
+0xB1, 0x00,       /* HID feature (Data_Arr_Abs) */
+0xC0,		  /* HID end collection */
+0x0A, 0x16, 0x03, /* HID usage sensor property reporting state */
+0x15, 0,          /* HID logical Min_8(0) */
+0x25, 5,	  /* HID logical Max_8(5) */
+0x75, 8,	  /* HID report size(8) */
+0x95, 1,          /* HID report count(1) */
+0xA1, 0x02,	  /* HID collection(logical) */
+0x0A, 0x40, 0x08, /* Sensor property report state no events sel */
+0x0A, 0x41, 0x08, /* Sensor property report state all events sel */
+0x0A, 0x42, 0x08, /* Sensor property report state threshold events sel */
+0x0A, 0x43, 0x08, /* Sensor property report state no events wake sel */
+0x0A, 0x44, 0x08, /* Sensor property report state all events wake sel */
+0x0A, 0x45, 0x08, /* Sensor property report state threshold events wake sel */
+0xB1, 0x00,	  /* HID feature (Data_Arr_Abs) */
+0xC0,		  /* HID end collection */
+0x0A, 0x19, 0x03, /* HID usage sensor property power state */
+0x15, 0,	  /* HID logical Min_8(0) */
+0x25, 5,	  /* HID logical Max_8(5) */
+0x75, 8,	  /* HID report size(8) */
+0x95, 1,	  /* HID report count(1) */
+0xA1, 0x02,	  /* HID collection(logical) */
+0x0A, 0x50, 0x08, /* Sensor property power state undefined sel */
+0x0A, 0x51, 0x08, /* Sensor property power state D0 full power  sel */
+0x0A, 0x52, 0x08, /* Sensor property power state D1 low power sel */
+0x0A, 0x53, 0x08, /* Sensor property power state D2 standby with wake sel */
+0x0A, 0x54, 0x08, /* Sensor property power state D3 sleep with wake  sel */
+0x0A, 0x55, 0x08, /* Sensor property power state D4 power off sel */
+0xB1, 0x00,       /* HID feature (Data_Arr_Abs) */
+0xC0,		  /* HID end collection */
+0x0A, 0x01, 0x02, /* HID usage sensor state */
+0x15, 0,	  /* HID logical Min_8(0) */
+0x25, 6,	  /* HID logical Max_8(6) */
+0x75, 8,	  /* HID report size(8) */
+0x95, 1,	  /* HID report count(1) */
+0xA1, 0x02,	  /* HID collection(logical) */
+0x0A, 0x00, 0x08, /* HID usage sensor state unknown sel */
+0x0A, 0x01, 0x08, /* HID usage sensor state ready sel */
+0x0A, 0x02, 0x08, /* HID usage sensor state not available sel */
+0x0A, 0x03, 0x08, /* HID usage sensor state no data sel */
+0x0A, 0x04, 0x08, /* HID usage sensor state initializing sel */
+0x0A, 0x05, 0x08, /* HID usage sensor state access denied sel */
+0x0A, 0x06, 0x08, /* HID usage sensor state error sel */
+0xB1, 0x00,	  /* HID feature (Data_Arr_Abs) */
+0xC0,		  /* HID end collection */
+0x0A, 0x0E, 0x03, /* HID usage sensor property report interval */
+0x15, 0,	  /* HID logical Min_8(0) */
+0x27, 0xFF, 0xFF, 0xFF, 0xFF, /* HID logical Max_32 */
+
+0x75, 32,	  /* HID report size(32) */
+0x95, 1,	  /* HID report count(1) */
+0x55, 0,	  /* HID unit exponent(0) */
+0xB1, 0x02,	  /* HID feature (Data_Arr_Abs) */
+0x0A, 0x52, 0x14, /* Sensor data motion accel and mod change sensitivity ABS) */
+
+0x15, 0,		/* HID logical Min_8(0) */
+0x26, 0xFF, 0xFF,	/* HID logical Max_16(0xFF,0xFF) */
+
+0x75, 16,		/* HID report size(16) */
+0x95, 1,		/* HID report count(1) */
+0x55, 0x0E,		/* HID unit exponent(0x0E) */
+0xB1, 0x02,		/* HID feature (Data_Arr_Abs) */
+0x0A, 0x52, 0x24,	/* HID usage sensor data (motion accel and mod max) */
+
+0x16, 0x01, 0x80,	/* HID logical Min_16(0x01,0x80) */
+
+0x26, 0xFF, 0x7F,	/* HID logical Max_16(0xFF,0x7F) */
+
+0x75, 16,		/* HID report size(16) */
+0x95, 1,		/* HID report count(1) */
+0x55, 0x0E,		/* HID unit exponent(0x0E) */
+0xB1, 0x02,		/* HID feature (Data_Arr_Abs) */
+0x0A, 0x52, 0x34,	/* HID usage sensor data (motion accel and mod min) */
+
+0x16, 0x01, 0x80,	/* HID logical Min_16(0x01,0x80) */
+
+0x26, 0xFF, 0x7F,	/* HID logical Max_16(0xFF,0x7F) */
+
+0x75, 16,		/* HID report size(16) */
+0x95, 1,		/* HID report count(1) */
+0x55, 0x0E,		/* HID unit exponent(0x0E) */
+0xB1, 0x02,		/* HID feature (Data_Arr_Abs) */
+
+//input report (transmit)
+0x05, 0x20,		 /* HID usage page sensors */
+0x0A, 0x01, 0x02,	 /* HID usage sensor state */
+0x15, 0,		 /* HID logical Min_8(0) */
+0x25, 6,		 /* HID logical Max_8(6) */
+0x75, 8,		 /* HID report size(8) */
+0x95, 1,		 /* HID report count (1) */
+0xA1, 0x02,		 /* HID end collection (logical) */
+0x0A, 0x00, 0x08,	 /* HID usage sensor state unknown sel */
+0x0A, 0x01, 0x08,	 /* HID usage sensor state ready sel */
+0x0A, 0x02, 0x08,	 /* HID usage sensor state not available sel */
+0x0A, 0x03, 0x08,	 /* HID usage sensor state no data sel */
+0x0A, 0x04, 0x08,	 /* HID usage sensor state initializing sel */
+0x0A, 0x05, 0x08,	 /* HID usage sensor state access denied sel */
+0x0A, 0x06, 0x08,	 /* HID usage sensor state error sel */
+0X81, 0x00,		 /* HID Input (Data_Arr_Abs) */
+0xC0,			 /* HID end collection */
+0x0A, 0x02, 0x02,	 /* HID usage sensor event */
+0x15, 0,		 /* HID logical Min_8(0) */
+0x25, 5,		 /* HID logical Max_8(5) */
+0x75, 8,		 /* HID report size(8) */
+0x95, 1,		 /* HID report count (1) */
+0xA1, 0x02,		 /* HID end collection (logical) */
+0x0A, 0x10, 0x08,	 /* HID usage sensor event unknown sel */
+0x0A, 0x11, 0x08,	 /* HID usage sensor event state changed sel */
+0x0A, 0x12, 0x08,	 /* HID usage sensor event property changed sel */
+0x0A, 0x13, 0x08,	 /* HID usage sensor event data updated sel */
+0x0A, 0x14, 0x08,	 /* HID usage sensor event poll response sel */
+0x0A, 0x15, 0x08,	 /* HID usage sensor event change sensitivity sel */
+0X81, 0x00,		 /* HID Input (Data_Arr_Abs) */
+0xC0,			 /* HID end collection */
+0x0A, 0x53, 0x04,	 /* HID usage sensor data motion Acceleration X axis */
+0x17, 0x00, 0x00, 0x01, 0x80, /* HID logical Min_32 */
+
+0x27, 0xFF, 0xff, 0XFF, 0XFF, /* HID logical Max_32  */
+
+0x75, 32,		/* HID report size(32) */
+0x95, 1,		/* HID report count (1) */
+0x55, 0x0E,		/* HID unit exponent(0x0E) */
+0X81, 0x02,		/* HID Input (Data_Arr_Abs) */
+0x0A, 0x54, 0x04,	/* HID usage sensor data motion Acceleration Y axis */
+0x17, 0X00, 0X00, 0x01, 0x80, /* HID logical Min_32 */
+
+0x27, 0xFF, 0xFF, 0XFF, 0XFF, /* HID logical Max_32 */
+
+0x75, 32,		/* HID report size(32) */
+0x95, 1,		/* HID report count (1) */
+0x55, 0x0E,		/* HID unit exponent(0x0E) */
+0X81, 0x02,		/* HID Input (Data_Arr_Abs) */
+0x0A, 0x55, 0x04,	/* HID usage sensor data motion Acceleration Z axis */
+0x17, 0X00, 0X00, 0x01, 0x80, /* HID logical Min_32 */
+
+0x27, 0XFF, 0XFF, 0xFF, 0x7F, /* HID logical Max_32 */
+
+0x75, 32,		/* HID report size(32) */
+0x95, 1,		/* HID report count (1) */
+0x55, 0x0E,		/* HID unit exponent(0x0E) */
+0X81, 0x02,		/* HID Input (Data_Arr_Abs) */
+
+0x0A, 0x51, 0x04,	/* HID usage sensor data motion state */
+0x15, 0,		/* HID logical Min_8(0) False = Still*/
+0x25, 1,		/* HID logical Min_8(1) True = In motion */
+0x75, 8,		/* HID report size(8) */
+0x95, 1,		/* HID report count (1) */
+0X81, 0x02,		/* HID Input (Data_Arr_Abs) */
+0xC0			/* HID end collection */
+};
+
+const u8 gyro3_report_descriptor[] = {
+0x05, 0x20,		/* Usage page */
+0x09, 0x76,		/* Motion type Gyro3D */
+0xA1, 0x00,		/* HID Collection (Physical) */
+
+0x85, 2,		/* HID  Report ID */
+0x05, 0x20,		/* HID usage page sensor */
+0x0A, 0x09, 0x03,	/* Sensor property and sensor connection type */
+0x15, 0,		/* HID logical MIN_8(0) */
+0x25, 2,		/* HID logical MAX_8(2) */
+0x75, 8,		/* HID report size(8) */
+0x95, 1,		/* HID report count(1) */
+0xA1, 0x02,		/* HID collection (logical) */
+0x0A, 0x30, 0x08,	/* Sensor property connection type intergated sel */
+0x0A, 0x31, 0x08,	/* Sensor property connection type attached sel */
+0x0A, 0x32, 0x08,	/* Sensor property connection type external sel */
+0xB1, 0x00,		/* HID feature (Data_Arr_Abs) */
+0xC0,			/* HID end collection */
+0x0A, 0x16, 0x03,	/* HID usage sensor property reporting state */
+0x15, 0,		/* HID logical Min_8(0) */
+0x25, 5,		/* HID logical Max_8(5) */
+0x75, 8,		/* HID report size(8) */
+0x95, 1,		/* HID report count(1) */
+0xA1, 0x02,		/* HID collection(logical) */
+0x0A, 0x40, 0x08,	/* Sensor reporting state no events sel */
+0x0A, 0x41, 0x08,	/* Sensor reporting state all events sel */
+0x0A, 0x42, 0x08,	/* Sensor reporting state threshold events sel */
+0x0A, 0x43, 0x08,	/* Sensor reporting state no events wake sel */
+0x0A, 0x44, 0x08,	/* Sensor reporting state all events wake sel */
+0x0A, 0x45, 0x08,	/* Sensor reporting state threshold events wake sel */
+0xB1, 0x00,		/* HID feature (Data_Arr_Abs) */
+0xC0,			/* HID end collection */
+0x0A, 0x19, 0x03,	/* HID usage sensor property power state */
+0x15, 0,		/* HID logical Min_8(0) */
+0x25, 5,		/* HID logical Max_8(5) */
+0x75, 8,		/* HID report size(8) */
+0x95, 1,		/* HID report count(1) */
+0xA1, 0x02,		/* HID collection(logical) */
+0x0A, 0x50, 0x08,	/* Sensor  power state undefined sel */
+0x0A, 0x51, 0x08,	/* Sensor  power state D0 full power  sel */
+0x0A, 0x52, 0x08,	/* Sensor  power state D1 low power sel */
+0x0A, 0x53, 0x08,	/* Sensor  power state D2 standby with wake sel */
+0x0A, 0x54, 0x08,	/* Sensor  power state D3 sleep with wake  sel */
+0x0A, 0x55, 0x08,	/* Sensor  power state D4 power off sel */
+0xB1, 0x00,		/* HID feature (Data_Arr_Abs) */
+0xC0,			/* HID end collection */
+0x0A, 0x01, 0x02,	/* HID usage sensor state */
+0x15, 0,		/* HID logical Min_8(0) */
+0x25, 6,		/* HID logical Max_8(6) */
+0x75, 8,		/* HID report size(8) */
+0x95, 1,		/* HID report count(1) */
+0xA1, 0x02,		/* HID collection(logical) */
+0x0A, 0x00, 0x08,	/* HID usage sensor state unknown sel */
+0x0A, 0x01, 0x08,	/* HID usage sensor state ready sel */
+0x0A, 0x02, 0x08,	/* HID usage sensor state not available sel */
+0x0A, 0x03, 0x08,	/* HID usage sensor state no data sel */
+0x0A, 0x04, 0x08,	/* HID usage sensor state initializing sel */
+0x0A, 0x05, 0x08,	/* HID usage sensor state access denied sel */
+0x0A, 0x06, 0x08,	/* HID usage sensor state error sel */
+0xB1, 0x00,		/* HID feature (Data_Arr_Abs) */
+0xC0,			/* HID end collection */
+0x0A, 0x0E, 0x03,	/* HID usage sensor property report interval */
+0x15, 0,		/* HID logical Min_8(0) */
+0x27, 0xFF, 0xFF, 0xFF, 0xFF,	/* HID logical Max_32 */
+
+0x75, 32,		/* HID report size(32) */
+0x95, 1,		/* HID report count(1) */
+0x55, 0,		/* HID unit exponent(0) */
+0xB1, 0x02,		/* HID feature (Data_Arr_Abs) */
+0x0A, 0x56, 0x14,	/* Angular velocity and mod change sensitivity ABS)*/
+
+0x15, 0,		/* HID logical Min_8(0) */
+0x26, 0xFF, 0xFF,	/* HID logical Max_16(0xFF,0xFF) */
+
+0x75, 16,		/* HID report size(16) */
+0x95, 1,		/* HID report count(1) */
+0x55, 0x0E,		/* HID unit exponent(0x0E) */
+0xB1, 0x02,		/* HID feature (Data_Arr_Abs) */
+0x0A, 0x56, 0x24,	/* Sensor data (motion angular velocity and mod max) */
+
+0x16, 0x01, 0x80,	/* HID logical Min_16(0x01,0x80) */
+
+0x26, 0xFF, 0x7F,	/* HID logical Max_16(0xFF,0x7F) */
+
+0x75, 16,		/* HID report size(16) */
+0x95, 1,		/* HID report count(1) */
+0x55, 0x0E,		/* HID unit exponent(0x0E) */
+0xB1, 0x02,		/* HID feature (Data_Arr_Abs) */
+0x0A, 0x56, 0x34,	/* HID usage sensor data (motion accel and mod min) */
+
+0x16, 0x01, 0x80,	/* HID logical Min_16(0x01,0x80) */
+
+0x26, 0xFF, 0x7F,	/* HID logical Max_16(0xFF,0x7F) */
+
+0x75, 16,		/* HID report size(16) */
+0x95, 1,		/* HID report count(1) */
+0x55, 0x0E,		/* HID unit exponent(0x0E) */
+0xB1, 0x02,		/* HID feature (Data_Arr_Abs) */
+
+//Input reports(transmit)
+0x05, 0x20,		/* HID usage page sensors */
+0x0A, 0x01, 0x02,	/* HID usage sensor state */
+0x15, 0,		/* HID logical Min_8(0) */
+0x25, 6,		/* HID logical Max_8(6) */
+0x75, 8,		/* HID report size(8) */
+0x95, 1,		/* HID report count (1) */
+0xA1, 0x02,		/* HID end collection (logical) */
+0x0A, 0x00, 0x08,	/* HID usage sensor state unknown sel */
+0x0A, 0x01, 0x08,	/* HID usage sensor state ready sel */
+0x0A, 0x02, 0x08,	/* HID usage sensor state not available sel */
+0x0A, 0x03, 0x08,	/* HID usage sensor state no data sel */
+0x0A, 0x04, 0x08,	/* HID usage sensor state initializing sel */
+0x0A, 0x05, 0x08,	/* HID usage sensor state access denied sel */
+0x0A, 0x06, 0x08,	/* HID usage sensor state error sel */
+0X81, 0x00,		/* HID Input (Data_Arr_Abs) */
+0xC0,			/* HID end collection */
+0x0A, 0x02, 0x02,	/* HID usage sensor event */
+0x15, 0,		/* HID logical Min_8(0) */
+0x25, 5,		/* HID logical Max_8(5) */
+0x75, 8,		/* HID report size(8) */
+0x95, 1,		/* HID report count (1) */
+0xA1, 0x02,		/* HID end collection (logical) */
+0x0A, 0x10, 0x08,	/* HID usage sensor event unknown sel */
+0x0A, 0x11, 0x08,	/* HID usage sensor event state changed sel */
+0x0A, 0x12, 0x08,	/* HID usage sensor event property changed sel */
+0x0A, 0x13, 0x08,	/* HID usage sensor event data updated sel */
+0x0A, 0x14, 0x08,	/* HID usage sensor event poll response sel */
+0x0A, 0x15, 0x08,	/* HID usage sensor event change sensitivity sel */
+0X81, 0x00,		/* HID Input (Data_Arr_Abs) */
+0xC0,			/* HID end collection */
+0x0A, 0x57, 0x04,	/* Sensor data motion Angular velocity  X axis */
+0x17, 0x00, 0x00, 0x01, 0x80,	/* HID logical Min_32 */
+
+0x27, 0xFF, 0xFF, 0xFF, 0x7F,	/* HID logical Max_32 */
+
+0x75, 32,		/* HID report size(32) */
+0x95, 1,		/* HID report count (1) */
+0x55, 0x0E,		/* HID unit exponent(0x0E) */
+0X81, 0x02,		/* HID Input (Data_Arr_Abs) */
+0x0A, 0x58, 0x04,	/* Sensor data motion Angular velocity  Y axis */
+0x17, 0x00, 0x00, 0x01, 0x80, /* HID logical Min_32 */
+
+0x27, 0xFF, 0xFF, 0xFF, 0x7F, /* HID logical Max_32 */
+
+0x75, 32,		/* HID report size(32) */
+0x95, 1,		/* HID report count (1) */
+0x55, 0x0E,		/* HID unit exponent(0x0E) */
+0X81, 0x02,		/* HID Input (Data_Arr_Abs) */
+0x0A, 0x59, 0x04,	/* Sensor data motion Angular velocity  Z axis */
+0x17, 0x00, 0x00, 0x01, 0x80, /* HID logical Min_32 */
+
+0x27, 0xFF, 0xFF, 0xFF, 0x7F, /* HID logical Max_32 */
+
+0x75, 32,		/* HID report size(32) */
+0x95, 1,		/* HID report count (1) */
+0x55, 0x0E,		/* HID unit exponent(0x0E) */
+0X81, 0x02,		/* HID Input (Data_Arr_Abs) */
+
+0xC0,			/* HID end collection */
+};
+
+const u8 comp3_report_descriptor[] = {
+0x05, 0x20,		/* Usage page */
+0x09, 0x83,		/* Motion type Orientation compass 3D */
+0xA1, 0x00,		/* HID Collection (Physical) */
+
+0x85, 3,		/* HID  Report ID */
+0x05, 0x20,		/* HID usage page sensor */
+0x0A, 0x09, 0x03,	/* Sensor property and sensor connection type */
+0x15, 0,		/* HID logical MIN_8(0) */
+0x25, 2,		/* HID logical MAX_8(2) */
+0x75, 8,		/* HID report size(8) */
+0x95, 1,		/* HID report count(1) */
+0xA1, 0x02,		/* HID collection (logical) */
+0x0A, 0x30, 0x08,	/* Sensor property connection type intergated sel */
+0x0A, 0x31, 0x08,	/* Sensor property connection type attached sel */
+0x0A, 0x32, 0x08,	/* Sensor property connection type external sel */
+0xB1, 0x00,		/* HID feature (Data_Arr_Abs) */
+0xC0,			/* HID end collection */
+0x0A, 0x16, 0x03,	/* HID usage sensor property reporting state */
+0x15, 0,		/* HID logical Min_8(0) */
+0x25, 5,		/* HID logical Max_8(5) */
+0x75, 8,		/* HID report size(8) */
+0x95, 1,		/* HID report count(1) */
+0xA1, 0x02,		/* HID collection(logical) */
+0x0A, 0x40, 0x08,	/* Sensor reporting state no events sel */
+0x0A, 0x41, 0x08,	/* Sensor reporting state all events sel */
+0x0A, 0x42, 0x08,	/* Sensor reporting state threshold events sel */
+0x0A, 0x43, 0x08,	/* Sensor reporting state no events wake sel */
+0x0A, 0x44, 0x08,	/* Sensor reporting state all events wake sel */
+0x0A, 0x45, 0x08,	/* Sensor reporting state threshold events wake sel */
+0xB1, 0x00,		/* HID feature (Data_Arr_Abs) */
+0xC0,			/* HID end collection */
+0x0A, 0x19, 0x03,       /* HID usage sensor property power state */
+0x15, 0,		/* HID logical Min_8(0) */
+0x25, 5,		/* HID logical Max_8(5) */
+0x75, 8,		/* HID report size(8) */
+0x95, 1,		/* HID report count(1) */
+0xA1, 0x02,		/* HID collection(logical) */
+0x0A, 0x50, 0x08,	/* Sensor power state undefined sel */
+0x0A, 0x51, 0x08,	/* Sensor power state D0 full power  sel */
+0x0A, 0x52, 0x08,	/* Sensor power state D1 low power sel */
+0x0A, 0x53, 0x08,	/* Sensor power state D2 standby with wake sel */
+0x0A, 0x54, 0x08,	/* Sensor power state D3 sleep with wake  sel */
+0x0A, 0x55, 0x08,	/* Sensor power state D4 power off sel */
+0xB1, 0x00,		/* HID feature (Data_Arr_Abs) */
+0xC0,			/* HID end collection */
+0x0A, 0x01, 0x02,	/* HID usage sensor state */
+0x15, 0,		/* HID logical Min_8(0) */
+0x25, 6,		/* HID logical Max_8(6) */
+0x75, 8,		/* HID report size(8) */
+0x95, 1,		/* HID report count(1) */
+0xA1, 0x02,		/* HID collection(logical) */
+0x0A, 0x00, 0x08,       /* HID usage sensor state unknown sel */
+0x0A, 0x01, 0x08,       /* HID usage sensor state ready sel */
+0x0A, 0x02, 0x08,       /* HID usage sensor state not available sel */
+0x0A, 0x03, 0x08,       /* HID usage sensor state no data sel */
+0x0A, 0x04, 0x08,       /* HID usage sensor state initializing sel */
+0x0A, 0x05, 0x08,       /* HID usage sensor state access denied sel */
+0x0A, 0x06, 0x08,       /* HID usage sensor state error sel */
+0xB1, 0x00,		/* HID feature (Data_Arr_Abs) */
+0xC0,			/* HID end collection */
+0x0A, 0x0E, 0x03,	/* HID usage sensor property report interval */
+0x15, 0,		/* HID logical Min_8(0) */
+0x27, 0xFF, 0xFF, 0xFF, 0xFF,	/* HID logical Max_32 */
+0x75, 32,		/* HID report size(32) */
+0x95, 1,		/* HID report count(1) */
+0x55, 0,		/* HID unit exponent(0) */
+0xB1, 0x02,		/* HID feature (Data_Arr_Abs) */
+0x0A, 0x71, 0x14,	/* Orientation  and mod change sensitivity ABS)*/
+0x15, 0,		/* HID logical Min_8(0) */
+0x26, 0xFF, 0xFF,	/* HID logical Max_16(0xFF,0xFF) */
+0x75, 16,		/* HID report size(16) */
+0x95, 1,		/* HID report count(1) */
+0x55, 0x0E,		/* HID unit exponent(0x0E) */
+0xB1, 0x02,		/* HID feature (Data_Arr_Abs) */
+0x0A, 0x71, 0x24,	/* Sensor data (motion orientation  and mod max) */
+0x16, 0x01, 0x80,	/* HID logical Min_16(0x01,0x80) */
+0x26, 0xFF, 0x7F,	/* HID logical Max_16(0xFF,0x7F) */
+0x75, 16,		/* HID report size(16) */
+0x95, 1,		/* HID report count(1) */
+0x55, 0x0F,		/* HID unit exponent(0x0F) */
+0xB1, 0x02,		/* HID feature (Data_Arr_Abs) */
+0x0A, 0x71, 0x34,	/* Sensor data (motion orientation  and mod min) */
+0x16, 0x01, 0x80,	/* HID logical Min_16(0x01,0x80) */
+0x26, 0xFF, 0x7F,	/* HID logical Max_16(0xFF,0x7F) */
+0x75, 16,		/* HID report size(16) */
+0x95, 1,		/* HID report count(1) */
+0x55, 0x0F,		/* HID unit exponent(0x0F) */
+0xB1, 0x02,		/* HID feature (Data_Arr_Abs) */
+0x0A, 0x84, 0x14,	/* Maganetic flux and change sensitivity ABS) */
+0x15, 0,		/* HID logical Min_8(0) */
+0x26, 0xFF, 0xFF,	/* HID logical Max_16(0xFF,0xFF) */
+0x75, 16,		/* HID report size(16) */
+0x95, 1,		/* HID report count(1) */
+0x55, 0x0E,		/* HID unit exponent(0x0E) */
+0xB1, 0x02,		/* HID feature (Data_Arr_Abs) */
+0x0A, 0x84, 0x24,	/* Maganetic flux and mod change sensitivity Max) */
+0x16, 0x01, 0x80,	/* HID logical Min_16(0x01,0x80) */
+0x26, 0xFF, 0x7F,	/* HID logical Max_16(0xFF,0x7F) */
+0x75, 16,		/* HID report size(16) */
+0x95, 1,		/* HID report count(1) */
+0x55, 0x0F,		/* HID unit exponent(0x0F) */
+0xB1, 0x02,		/* HID feature (Data_Arr_Abs) */
+0x0A, 0x84, 0x34,	/* Maganetic flux and mod change sensitivity Min */
+0x16, 0x01, 0x80,	/* HID logical Min_16(0x01,0x80) */
+0x26, 0xFF, 0x7F,	/* HID logical Max_16(0xFF,0x7F) */
+0x75, 16,		/* HID report size(16) */
+0x95, 1,		/* HID report count(1) */
+0x55, 0x0F,		/* HID unit exponent(0x0F) */
+0xB1, 0x02,		/* HID feature (Data_Arr_Abs) */
+
+//Input reports(transmit)
+0x05, 0x20,		/* HID usage page sensors */
+0x0A, 0x01, 0x02,	/* HID usage sensor state */
+0x15, 0,		/* HID logical Min_8(0) */
+0x25, 6,		/* HID logical Max_8(6) */
+0x75, 8,		/* HID report size(8) */
+0x95, 1,		/* HID report count (1) */
+0xA1, 0x02,		/* HID end collection (logical) */
+0x0A, 0x00, 0x08,	/* HID usage sensor state unknown sel */
+0x0A, 0x01, 0x08,	/* HID usage sensor state ready sel */
+0x0A, 0x02, 0x08,	/* HID usage sensor state not available sel */
+0x0A, 0x03, 0x08,	/* HID usage sensor state no data sel */
+0x0A, 0x04, 0x08,	/* HID usage sensor state initializing sel */
+0x0A, 0x05, 0x08,	/* HID usage sensor state access denied sel */
+0x0A, 0x06, 0x08,	/* HID usage sensor state error sel */
+0X81, 0x00,		/* HID Input (Data_Arr_Abs) */
+0xC0,			/* HID end collection */
+0x0A, 0x02, 0x02,	/* HID usage sensor event */
+0x15, 0,		/* HID logical Min_8(0) */
+0x25, 5,		/* HID logical Max_8(5) */
+0x75, 8,		/* HID report size(8) */
+0x95, 1,		/* HID report count (1) */
+0xA1, 0x02,		/* HID end collection (logical) */
+0x0A, 0x10, 0x08,	/* HID usage sensor event unknown sel */
+0x0A, 0x11, 0x08,	/* HID usage sensor event state changed sel */
+0x0A, 0x12, 0x08,	/* HID usage sensor event property changed sel */
+0x0A, 0x13, 0x08,	/* HID usage sensor event data updated sel */
+0x0A, 0x14, 0x08,	/* HID usage sensor event poll response sel */
+0x0A, 0x15, 0x08,	/* HID usage sensor event change sensitivity sel */
+0X81, 0x00,		/* HID Input (Data_Arr_Abs) */
+0xC0,			/* HID end collection */
+0x0A, 0x85, 0x04,	/* Sensor data orientation magnetic flux X axis */
+0x17, 0x00, 0x00, 0x01, 0x80,	/* HID logical Min_32 */
+0x27, 0xFF, 0xFF, 0xFF, 0x7F,	/* HID logical Max_32 */
+0x75, 32,		/* HID report size(32) */
+0x95, 1,		/* HID report count (1) */
+0x55, 0x0D,		/* HID unit exponent(0x0D) */
+0X81, 0x02,		/* HID Input (Data_Arr_Abs) */
+0x0A, 0x86, 0x04,	/* Sensor data orientation magnetic flux Y axis */
+0x17, 0x00, 0x00, 0x01, 0x80,	/* HID logical Min_32 */
+0x27, 0xFF, 0xFF, 0xFF, 0x7F,	/* HID logical Max_32 */
+0x75, 32,		/* HID report size(32) */
+0x95, 1,		/* HID report count (1) */
+0x55, 0x0D,		/* HID unit exponent(0x0D) */
+0X81, 0x02,		/* HID Input (Data_Arr_Abs) */
+0x0A, 0x87, 0x04,	/* Sensor data orientation magnetic flux Z axis */
+0x17, 0x00, 0x00, 0x01, 0x80,	/* HID logical Min_32 */
+0x27, 0xFF, 0xFF, 0xFF, 0x7F,	/* HID logical Max_32 */
+0x75, 32,			/* HID report size(32) */
+0x95, 1,			/* HID report count (1) */
+0x55, 0x0D,			/* HID unit exponent(0x0D) */
+0X81, 0x02,			/* HID Input (Data_Arr_Abs) */
+0x0A, 0x88, 0x04,	/* Sensor data orientation magnetometer accuracy */
+0x17, 0x00, 0x00, 0x01, 0x80,	/* HID logical Min_32 */
+0x27, 0xFF, 0xFF, 0xFF, 0x7F,	/* HID logical Max_32 */
+0x75, 32,			/* HID report size(32) */
+0x95, 1,			/* HID report count (1) */
+0X81, 0x02,			/* HID Input (Data_Arr_Abs) */
+0xC0				/* HID end collection */
+};
+
+const u8 als_report_descriptor[] = {
+0x05, 0x20,	/* HID usage page sensor */
+0x09, 0x41,	/* HID usage sensor type Ambientlight  */
+0xA1, 0x00,	/* HID Collection (Physical) */
+
+//feature reports(xmit/receive)//
+0x85, 4,		/* HID  Report ID */
+0x05, 0x20,		/* HID usage page sensor */
+0x0A, 0x09, 0x03,	/* Sensor property and sensor connection type */
+0x15, 0,		/* HID logical MIN_8(0) */
+0x25, 2,		/* HID logical MAX_8(2) */
+0x75, 8,		/* HID report size(8) */
+0x95, 1,		/* HID report count(1) */
+0xA1, 0x02,		/* HID collection (logical) */
+0x0A, 0x30, 0x08,	/* Sensor property connection type intergated sel */
+0x0A, 0x31, 0x08,	/* Sensor property connection type attached sel */
+0x0A, 0x32, 0x08,	/* Sensor property connection type external sel */
+0xB1, 0x00,		/* HID feature (Data_Arr_Abs) */
+0xC0,			/* HID end collection */
+0x0A, 0x16, 0x03,	/* HID usage sensor property reporting state */
+0x15, 0,		/* HID logical Min_8(0) */
+0x25, 5,		/* HID logical Max_8(5) */
+0x75, 8,		/* HID report size(8) */
+0x95, 1,		/* HID report count(1) */
+0xA1, 0x02,		/* HID collection(logical) */
+0x0A, 0x40, 0x08,	/* Sensor reporting state no events sel */
+0x0A, 0x41, 0x08,	/* Sensor reporting state all events sel */
+0x0A, 0x42, 0x08,	/* Sensor reporting state threshold events sel */
+0x0A, 0x43, 0x08,	/* Sensor reporting state no events wake sel */
+0x0A, 0x44, 0x08,	/* Sensor reporting state all events wake sel */
+0x0A, 0x45, 0x08,	/* Sensor reporting state threshold events wake sel */
+0xB1, 0x00,		/* HID feature (Data_Arr_Abs) */
+0xC0,			/* HID end collection */
+0x0A, 0x19, 0x03,	/* HID usage sensor property power state */
+0x15, 0,		/* HID logical Min_8(0) */
+0x25, 5,		/* HID logical Max_8(5) */
+0x75, 8,		/* HID report size(8) */
+0x95, 1,		/* HID report count(1) */
+0xA1, 0x02,		/* HID collection(logical) */
+0x0A, 0x50, 0x08,	/* Sensor power state undefined sel */
+0x0A, 0x51, 0x08,	/* Sensor power state D0 full power  sel */
+0x0A, 0x52, 0x08,	/* Sensor power state D1 low power sel */
+0x0A, 0x53, 0x08,	/* Sensor power state D2 standby with wake sel */
+0x0A, 0x54, 0x08,	/* Sensor power state D3 sleep with wake  sel */
+0x0A, 0x55, 0x08,	/* Sensor power state D4 power off sel */
+0xB1, 0x00,		/* HID feature (Data_Arr_Abs) */
+0xC0,			/* HID end collection */
+0x0A, 0x01, 0x02,	/* HID usage sensor state */
+0x15, 0,		/* HID logical Min_8(0) */
+0x25, 6,		/* HID logical Max_8(6) */
+0x75, 8,		/* HID report size(8) */
+0x95, 1,		/* HID report count(1) */
+0xA1, 0x02,		/* HID collection(logical) */
+0x0A, 0x00, 0x08,	/* HID usage sensor state unknown sel */
+0x0A, 0x01, 0x08,	/* HID usage sensor state ready sel */
+0x0A, 0x02, 0x08,	/* HID usage sensor state not available sel */
+0x0A, 0x03, 0x08,	/* HID usage sensor state no data sel */
+0x0A, 0x04, 0x08,	/* HID usage sensor state initializing sel */
+0x0A, 0x05, 0x08,	/* HID usage sensor state access denied sel */
+0x0A, 0x06, 0x08,	/* HID usage sensor state error sel */
+0xB1, 0x00,		/* HID feature (Data_Arr_Abs) */
+0xC0,			/* HID end collection */
+0x0A, 0x0E, 0x03,	/* HID usage sensor property report interval */
+0x15, 0,		/* HID logical Min_8(0) */
+0x27, 0xFF, 0xFF, 0xFF, 0xFF,	/* HID logical Max_32 */
+0x75, 32,		/* HID report size(32) */
+0x95, 1,		/* HID report count(1) */
+0x55, 0,		/* HID unit exponent(0) */
+0xB1, 0x02,		/* HID feature (Data_Arr_Abs) */
+0x0A, 0xD1, 0xE4,	/* Light illuminance and sensitivity REL PCT) */
+0x15, 0,		/* HID logical Min_8(0) */
+0x26, 0x10, 0x27,	/* HID logical Max_16(0x10,0x27) */
+0x75, 16,		/* HID report size(16) */
+0x95, 1,		/* HID report count(1) */
+0x55, 0x0E,		/* HID unit exponent(0x0E) */
+0xB1, 0x02,		/* HID feature (Data_Arr_Abs) */
+0x0A, 0xD1, 0x24,	/* Sensor data (Light illuminance and mod max) */
+0x15, 0,		/* HID logical Min_8(0) */
+0x26, 0xFF, 0xFF,	/* HID logical Max_16(0xFF,0xFF) */
+0x75, 16,		/* HID report size(16) */
+0x95, 1,		/* HID report count(1) */
+0x55, 0x0F,		/* HID unit exponent(0x0F) */
+0xB1, 0x02,		/* HID feature (Data_Arr_Abs) */
+0x0A, 0xD1, 0x34,	/* Sensor data (Light illuminance and mod min) */
+0x15, 0,		/* HID logical Min_8(0) */
+0x26, 0xFF, 0xFF,	/* HID logical Max_16(0xFF,0xFF) */
+0x75, 16,		/* HID report size(16) */
+0x95, 1,		/* HID report count(1) */
+0x55, 0x0F,		/* HID unit exponent(0x0F) */
+0xB1, 0x02,		/* HID feature (Data_Arr_Abs) */
+
+//Input reports (transmit)
+0x05, 0x20,		/* HID usage page sensors */
+0x0A, 0x01, 0x02,	/* HID usage sensor state */
+0x15, 0,		/* HID logical Min_8(0) */
+0x25, 6,		/* HID logical Max_8(6) */
+0x75, 8,		/* HID report size(8) */
+0x95, 1,		/* HID report count (1) */
+0xA1, 0x02,		/* HID end collection (logical) */
+0x0A, 0x00, 0x08,	/* HID usage sensor state unknown sel */
+0x0A, 0x01, 0x08,	/* HID usage sensor state ready sel */
+0x0A, 0x02, 0x08,	/* HID usage sensor state not available sel */
+0x0A, 0x03, 0x08,	/* HID usage sensor state no data sel */
+0x0A, 0x04, 0x08,	/* HID usage sensor state initializing sel */
+0x0A, 0x05, 0x08,	/* HID usage sensor state access denied sel */
+0x0A, 0x06, 0x08,	/* HID usage sensor state error sel */
+0X81, 0x00,		/* HID Input (Data_Arr_Abs) */
+0xC0,			/* HID end collection */
+0x0A, 0x02, 0x02,	/* HID usage sensor event */
+0x15, 0,		/* HID logical Min_8(0) */
+0x25, 5,		/* HID logical Max_8(5) */
+0x75, 8,		/* HID report size(8) */
+0x95, 1,		/* HID report count (1) */
+0xA1, 0x02,		/* HID end collection (logical) */
+0x0A, 0x10, 0x08,	/* HID usage sensor event unknown sel */
+0x0A, 0x11, 0x08,	/* HID usage sensor event state changed sel */
+0x0A, 0x12, 0x08,	/* HID usage sensor event property changed sel */
+0x0A, 0x13, 0x08,	/* HID usage sensor event data updated sel */
+0x0A, 0x14, 0x08,	/* HID usage sensor event poll response sel */
+0x0A, 0x15, 0x08,	/* HID usage sensor event change sensitivity sel */
+0X81, 0x00,		/* HID Input (Data_Arr_Abs) */
+0xC0,			/* HID end collection */
+0x0A, 0xD1, 0x04,	/* HID usage sensor data light illuminance */
+0x17, 0x00, 0x00, 0x01, 0x80,	 /* HID logical Min_32 */
+0x27, 0xFF, 0xFF, 0xFF, 0x7F,	 /* HID logical Max_32 */
+0x55, 0x0F,		/* HID unit exponent(0x0F) */
+0x75, 32,		/* HID report size(32) */
+0x95, 1,		/* HID report count (1) */
+0X81, 0x02,		/* HID Input (Data_Arr_Abs) */
+0xC0			/* HID end collection */
+};
+#endif
-- 
2.25.1

