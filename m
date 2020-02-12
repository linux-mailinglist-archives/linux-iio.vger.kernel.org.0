Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3E41159F59
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2020 04:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgBLC5X (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 Feb 2020 21:57:23 -0500
Received: from mail-bn7nam10on2074.outbound.protection.outlook.com ([40.107.92.74]:14167
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727600AbgBLC5W (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 11 Feb 2020 21:57:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VTYjtwa17Tgbng9R3AjyXAmUmzPu/1ChQ8TbC9VpkiBjPEyoZM9hSti1qYUkR9/jBbv5v1KzQophtzXrRGpuMNgpV3mUFMzXsRxx8+IhsM4mkG1DtY3CF1xBLRqo+uLC4Re1HX/ruSeLYLCY0CurJtHtiRGDzPKM7t2NybVVth4ggkL+8t4+CCv2ZnEPheDA1oAT0fItSNEIkUCxuuez4wso+cmUYttXTv05BBcoNfBTL7ngyF4MLXIDxM9B71pZSZ3ZhDQ0PYKyAfaISmYPRCr7xHedziYGVLU+AHbAMPgXI1BjblKLnJ7qXF7kCZsbga+gcaqRxdQeV0Z5oqSpqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jSK+FNao8F9FoLLkewxeLd7wECELFCnE200juhmq7tI=;
 b=kzDvLha2Fhj9G+6aNcMyh9ziC+lOAQuBfJ8Znjt4DwgW59RneIb4BvgfC8JDPzMO549XPRezH0tyV7Tx2zOK2BqKsUZyQyerocAZcuuK0PWxdn5bGBCDepwSVZ0Ggy+N1k64wdfu2FhuKMRdKvQ8iF/XcepMp/zieb1xhoJqJ2srJFuDDuPrU043TJ+2Qh+EJ84f8aTXVSn3dNRF2aZ+p+6YFV1/MXRlTkHHITQW1PhjOoDCR4IPHnpXWih2bxd455Uz3xR9SdSBvI5dteMx/XjzOsrt/W/NlkbiHM0I1qJb38Wz4HRpsGUAZ065zM0hh06X98YOo9k27N2BRcR5Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jSK+FNao8F9FoLLkewxeLd7wECELFCnE200juhmq7tI=;
 b=cezhPZWcoiv/9svO4bUJyrHI8xs7nFR3kqay409hMHIRNRhW4jt7iVX4NmhKwyDJlyiG7CHI5zqUKzg8iU4Uky6SHXLIjLUMPc7npBvm0hZV9R7Qj7wWBwvNn21AA/DRHM0x97s3xRokrSnkV19YzsJ0n5+cSn1CpFJlQGiLo3Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sandeep.Singh@amd.com; 
Received: from MN2PR12MB3598.namprd12.prod.outlook.com (20.178.244.84) by
 MN2PR12MB3343.namprd12.prod.outlook.com (20.178.240.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.28; Wed, 12 Feb 2020 02:57:12 +0000
Received: from MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::10ce:b4fb:586d:8b9c]) by MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::10ce:b4fb:586d:8b9c%3]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 02:57:12 +0000
From:   Sandeep Singh <Sandeep.Singh@amd.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        srinivas.pandruvada@linux.intel.com, jic23@kernel.org,
        linux-iio@vger.kernel.org, Nehal-bakulchandra.Shah@amd.com
Cc:     Shyam-sundar.S-k@amd.com, Sandeep Singh <sandeep.singh@amd.com>
Subject: [PATCH v3 5/5] SFH: Create HID report to Enable support of AMD sensor fusion Hub (SFH)
Date:   Wed, 12 Feb 2020 08:26:37 +0530
Message-Id: <1581476197-25854-6-git-send-email-Sandeep.Singh@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581476197-25854-1-git-send-email-Sandeep.Singh@amd.com>
References: <1581476197-25854-1-git-send-email-Sandeep.Singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: MA1PR0101CA0016.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::26) To MN2PR12MB3598.namprd12.prod.outlook.com
 (2603:10b6:208:d1::20)
MIME-Version: 1.0
Received: from andbang2.amd.com (165.204.156.251) by MA1PR0101CA0016.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2707.21 via Frontend Transport; Wed, 12 Feb 2020 02:57:09 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 478e7ecb-6832-4307-681c-08d7af67424b
X-MS-TrafficTypeDiagnostic: MN2PR12MB3343:|MN2PR12MB3343:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB33436F6E100046CFF5CCDB77E01B0@MN2PR12MB3343.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 0311124FA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(189003)(199004)(6636002)(81166006)(6666004)(2906002)(81156014)(8676002)(6486002)(8936002)(86362001)(956004)(36756003)(66946007)(66556008)(4326008)(5660300002)(7696005)(66476007)(2616005)(52116002)(16526019)(316002)(26005)(30864003)(478600001)(186003)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3343;H:MN2PR12MB3598.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MnIJ4gvgKAKsSuHhB2BxhDKbXV6K0Kye2OYXmxKU34HUXj6r7+F+WQeXncDuJnhxYqAHz154Y8tW/sPBrfLSLf14vetQq3Jsve8QcFk0xo7F1rLUTYDWwumFtKzwBhNYDKLvXf978yI1j4BjDapnFrqV3+6rW66iJ+ShpxN3pMqJfFSDDHFFQH3jJ2NpEDw0Xk5TJX+OvYinFPeM1zrinrCva3oUWtPs8+EJ37d28zQBmlENRVv8xbbUxDvY++vshNNbsid8HSZB0XDhJHyBJrDGeMoilENpvPJgYlDU5Y/Qox1OQef5eSoJ+yLdSOjol5awmUBVwmoP7YkJKTXheoiX+9gpp6XrFV0hWE4EEO7DrhIXHpxp1q+34T9mnkbLPS4oZERPeXKEibaZTNMfoFsO+bvk+J5rlGmI5rY49uONOh4swg3PRHpX92Qo2Gu+
X-MS-Exchange-AntiSpam-MessageData: b3rTO7ZR6+4fy0xoieVjBx+LG7my471KbD9ipm5EaCqJZr7j5P4jaIwA9JYFGCjqv9A/P8t3BcJ/mGcKXF/vhevq9JrKiI92H+UKIEDjrQFC2FQraBFCFVMEIP22WlYVh4MsJOYHms+5MAJBf3lzLQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 478e7ecb-6832-4307-681c-08d7af67424b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2020 02:57:12.7153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FW9etP6WI3mqRLyyUjtjvoo/SdE8ay3fpMf9tOruvTdGEs+7/hJcoQbIBRzmzCn2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3343
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Sandeep Singh <sandeep.singh@amd.com>

This part of module will define the data into HID reports.
Get data from PCIe driver and populate that data into
reports. HID core communication between devices and
HID core is mostly done via HID reports.

Signed-off-by: Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
Signed-off-by: Sandeep Singh <sandeep.singh@amd.com>
---
 .../hid_descriptor/amd_sfh_hid_descriptor.c        | 275 +++++++++
 .../hid_descriptor/amd_sfh_hid_descriptor.h        | 125 ++++
 .../hid_descriptor/amd_sfh_hid_report_descriptor.h | 642 +++++++++++++++++++++
 3 files changed, 1042 insertions(+)
 create mode 100644 drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_descriptor.c
 create mode 100644 drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_descriptor.h
 create mode 100644 drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_descriptor.h

diff --git a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_descriptor.c b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_descriptor.c
new file mode 100644
index 0000000..766b0ed
--- /dev/null
+++ b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_descriptor.c
@@ -0,0 +1,275 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ *  AMD SFH Report Descriptor generator logic
+ *  Author: Nehal Bakulchandra Shah <Nehal-Bakulchandra.Shah@amd.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include "amd_sfh_hid_descriptor.h"
+#include "amd_sfh_hid_report_descriptor.h"
+#include "amd_mp2_pcie.h"
+
+#define	AMD_SFH_FIRMWARE_MULTIPLIER (1000)
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
+	case ACCEL_IDX: /* accel */
+		memset(rep_desc, 0, sizeof(accel3_report_descriptor));
+		memcpy(rep_desc, accel3_report_descriptor,
+		       sizeof(accel3_report_descriptor));
+		break;
+
+	case GYRO_IDX: /* gyro */
+		memset(rep_desc, 0, sizeof(gyro3_report_descriptor));
+		memcpy(rep_desc, gyro3_report_descriptor,
+		       sizeof(gyro3_report_descriptor));
+		break;
+
+	case MAG_IDX: /* Magnetometer */
+		memset(rep_desc, 0, sizeof(comp3_report_descriptor));
+		memcpy(rep_desc, comp3_report_descriptor,
+		       sizeof(comp3_report_descriptor));
+		break;
+
+	case AMBIENT_LIGHT_IDX: /* ambient light sensor */
+		memset(rep_desc, 0, sizeof(als_report_descriptor));
+		memcpy(rep_desc, als_report_descriptor,
+		       sizeof(als_report_descriptor));
+		break;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(get_report_descriptor);
+
+u32 get_descriptor_size(int sensor_idx, int descriptor_name)
+{
+	switch (sensor_idx) {
+	case ACCEL_IDX:
+		if (descriptor_name == descr_size)
+			return sizeof(accel3_report_descriptor);
+		else if (descriptor_name == input_size)
+			return sizeof(struct accel3_input_report);
+		else if (descriptor_name == feature_size)
+			return sizeof(struct accel3_feature_report);
+		break;
+
+	case GYRO_IDX:
+		if (descriptor_name == descr_size)
+			return sizeof(gyro3_report_descriptor);
+		else if (descriptor_name == input_size)
+			return sizeof(struct gyro_input_report);
+		else if (descriptor_name == feature_size)
+			return sizeof(struct gyro_feature_report);
+		break;
+
+	case MAG_IDX:
+		if (descriptor_name == descr_size)
+			return sizeof(comp3_report_descriptor);
+		else if (descriptor_name == input_size)
+			return sizeof(struct magno_input_report);
+		else if (descriptor_name == feature_size)
+			return sizeof(struct magno_input_report);
+		break;
+
+	case AMBIENT_LIGHT_IDX:
+		if (descriptor_name == descr_size)
+			return sizeof(als_report_descriptor);
+		else if (descriptor_name == input_size)
+			return sizeof(struct als_input_report);
+		else if (descriptor_name == feature_size)
+			return sizeof(struct als_feature_report);
+		break;
+
+	default:
+		pr_info("Unknown Sensor index detected");
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(get_descriptor_size);
+
+u8 get_feature_report(int sensor_idx, int report_id, u8 *feature_report)
+{
+	u8 report_size = 0;
+	struct accel3_feature_report acc_feature;
+	struct gyro_feature_report gyro_feature;
+	struct magno_feature_report magno_feature;
+	struct als_feature_report als_feature;
+
+	if (!feature_report)
+		return report_size;
+
+	switch (sensor_idx) {
+	case ACCEL_IDX: /* accel */
+		acc_feature.common_property.connection_type =
+		HID_USAGE_SENSOR_PROPERTY_CONNECTION_TYPE_PC_INTEGRATED_ENUM;
+		acc_feature.common_property.report_state =
+			HID_USAGE_SENSOR_PROP_REPORTING_STATE_ALL_EVENTS_ENUM;
+		acc_feature.common_property.power_state =
+			HID_USAGE_SENSOR_PROP_POWER_STATE_D0_FULL_POWER_ENUM;
+		acc_feature.common_property.sensor_state =
+			HID_USAGE_SENSOR_STATE_INITIALIZING_ENUM;
+		acc_feature.common_property.report_interval =
+					HID_DEFAULT_REPORT_INTERVAL;
+		acc_feature.accel_change_sesnitivity =
+						HID_DEFAULT_SENSITIVITY;
+		acc_feature.accel_sensitivity_min = HID_DEFAULT_MIN_VALUE;
+		acc_feature.accel_sensitivity_max = HID_DEFAULT_MAX_VALUE;
+		memcpy(feature_report, &acc_feature, sizeof(acc_feature));
+		report_size = sizeof(acc_feature);
+		break;
+
+	case GYRO_IDX: /* gyro */
+		gyro_feature.common_property.connection_type =
+		HID_USAGE_SENSOR_PROPERTY_CONNECTION_TYPE_PC_INTEGRATED_ENUM;
+		gyro_feature.common_property.report_state =
+			HID_USAGE_SENSOR_PROP_REPORTING_STATE_ALL_EVENTS_ENUM;
+		gyro_feature.common_property.power_state =
+			HID_USAGE_SENSOR_PROP_POWER_STATE_D0_FULL_POWER_ENUM;
+		gyro_feature.common_property.sensor_state =
+			HID_USAGE_SENSOR_STATE_INITIALIZING_ENUM;
+		gyro_feature.common_property.report_interval =
+					HID_DEFAULT_REPORT_INTERVAL;
+		gyro_feature.gyro_change_sesnitivity = HID_DEFAULT_SENSITIVITY;
+		gyro_feature.gyro_sensitivity_min = HID_DEFAULT_MIN_VALUE;
+		gyro_feature.gyro_sensitivity_max = HID_DEFAULT_MAX_VALUE;
+		memcpy(feature_report, &gyro_feature, sizeof(gyro_feature));
+		report_size = sizeof(gyro_feature);
+		break;
+
+	case MAG_IDX: /* Magnetometer */
+		magno_feature.common_property.report_id = report_id;
+		magno_feature.common_property.connection_type =
+		HID_USAGE_SENSOR_PROPERTY_CONNECTION_TYPE_PC_INTEGRATED_ENUM;
+		magno_feature.common_property.report_state =
+			HID_USAGE_SENSOR_PROP_REPORTING_STATE_ALL_EVENTS_ENUM;
+		magno_feature.common_property.power_state =
+			HID_USAGE_SENSOR_PROP_POWER_STATE_D0_FULL_POWER_ENUM;
+		magno_feature.common_property.sensor_state =
+			HID_USAGE_SENSOR_STATE_INITIALIZING_ENUM;
+		magno_feature.common_property.report_interval =
+					HID_DEFAULT_REPORT_INTERVAL;
+		magno_feature.magno_headingchange_sensitivity =
+						HID_DEFAULT_SENSITIVITY;
+		magno_feature.heading_min = HID_DEFAULT_MIN_VALUE;
+		magno_feature.heading_max = HID_DEFAULT_MAX_VALUE;
+		magno_feature.flux_change_sensitivity = HID_DEFAULT_MIN_VALUE;
+		magno_feature.flux_min = HID_DEFAULT_MIN_VALUE;
+		magno_feature.flux_max = HID_DEFAULT_MAX_VALUE;
+		memcpy(feature_report, &magno_feature, sizeof(magno_feature));
+		report_size = sizeof(magno_feature);
+		break;
+
+	case AMBIENT_LIGHT_IDX:  /* ambient light sensor */
+		als_feature.common_property.report_id = report_id;
+		als_feature.common_property.connection_type =
+		HID_USAGE_SENSOR_PROPERTY_CONNECTION_TYPE_PC_INTEGRATED_ENUM;
+		als_feature.common_property.report_state =
+			HID_USAGE_SENSOR_PROP_REPORTING_STATE_ALL_EVENTS_ENUM;
+		als_feature.common_property.power_state =
+			HID_USAGE_SENSOR_PROP_POWER_STATE_D0_FULL_POWER_ENUM;
+		als_feature.common_property.sensor_state =
+				HID_USAGE_SENSOR_STATE_INITIALIZING_ENUM;
+		als_feature.common_property.report_interval =
+						HID_DEFAULT_REPORT_INTERVAL;
+		als_feature.als_change_sesnitivity = HID_DEFAULT_SENSITIVITY;
+		als_feature.als_sensitivity_min = HID_DEFAULT_MIN_VALUE;
+		als_feature.als_sensitivity_max = HID_DEFAULT_MAX_VALUE;
+		memcpy(feature_report, &als_feature, sizeof(als_feature));
+		report_size = sizeof(als_feature);
+		break;
+	}
+	return report_size;
+}
+EXPORT_SYMBOL_GPL(get_feature_report);
+
+u8 get_input_report(int sensor_idx, int report_id,
+		    u8 *input_report, u32 *sensor_virt_addr)
+{
+	u8 report_size = 0;
+	struct accel3_input_report acc_input;
+	struct gyro_input_report gyro_input;
+	struct magno_input_report magno_input;
+	struct als_input_report als_input;
+
+	if (!sensor_virt_addr || !input_report)
+		return report_size;
+
+	switch (sensor_idx) {
+	case ACCEL_IDX: /* accel */
+		acc_input.common_property.report_id = report_id;
+		acc_input.common_property.sensor_state =
+					HID_USAGE_SENSOR_STATE_READY_ENUM;
+		acc_input.common_property.event_type =
+				HID_USAGE_SENSOR_EVENT_DATA_UPDATED_ENUM;
+		acc_input.in_accel_x_value = (int)sensor_virt_addr[0] /
+						AMD_SFH_FIRMWARE_MULTIPLIER;
+		acc_input.in_accel_y_value = (int)sensor_virt_addr[1] /
+						AMD_SFH_FIRMWARE_MULTIPLIER;
+		acc_input.in_accel_z_value =  (int)sensor_virt_addr[2] /
+						AMD_SFH_FIRMWARE_MULTIPLIER;
+		memcpy(input_report, &acc_input, sizeof(acc_input));
+		report_size = sizeof(acc_input);
+		break;
+
+	case GYRO_IDX: /* gyro */
+		gyro_input.common_property.report_id = report_id;
+		gyro_input.common_property.sensor_state =
+			HID_USAGE_SENSOR_STATE_READY_ENUM;
+		gyro_input.common_property.event_type =
+			HID_USAGE_SENSOR_EVENT_DATA_UPDATED_ENUM;
+		gyro_input.in_angel_x_value = (int)sensor_virt_addr[0] /
+						AMD_SFH_FIRMWARE_MULTIPLIER;
+		gyro_input.in_angel_y_value = (int)sensor_virt_addr[1] /
+						AMD_SFH_FIRMWARE_MULTIPLIER;
+		gyro_input.in_angel_z_value =  (int)sensor_virt_addr[2] /
+						AMD_SFH_FIRMWARE_MULTIPLIER;
+		memcpy(input_report, &gyro_input, sizeof(gyro_input));
+		report_size = sizeof(gyro_input);
+		break;
+
+	case MAG_IDX: /* Magnetometer */
+		magno_input.common_property.report_id = report_id;
+		magno_input.common_property.sensor_state =
+			HID_USAGE_SENSOR_STATE_READY_ENUM;
+		magno_input.common_property.event_type =
+			HID_USAGE_SENSOR_EVENT_DATA_UPDATED_ENUM;
+		magno_input.in_magno_x = (int)sensor_virt_addr[0] /
+						AMD_SFH_FIRMWARE_MULTIPLIER;
+		magno_input.in_magno_y = (int)sensor_virt_addr[1] /
+						AMD_SFH_FIRMWARE_MULTIPLIER;
+		magno_input.in_magno_z = (int)sensor_virt_addr[2] /
+						AMD_SFH_FIRMWARE_MULTIPLIER;
+		magno_input.in_magno_accuracy = (u16)sensor_virt_addr[3] /
+						AMD_SFH_FIRMWARE_MULTIPLIER;
+		memcpy(input_report, &magno_input, sizeof(magno_input));
+		report_size = sizeof(magno_input);
+		break;
+
+	case AMBIENT_LIGHT_IDX: /* Als */
+		als_input.common_property.report_id = report_id;
+		als_input.common_property.sensor_state =
+					HID_USAGE_SENSOR_STATE_READY_ENUM;
+		als_input.common_property.event_type =
+				HID_USAGE_SENSOR_EVENT_DATA_UPDATED_ENUM;
+		als_input.illuminance_value =  (int)sensor_virt_addr[0] /
+						AMD_SFH_FIRMWARE_MULTIPLIER;
+		report_size = sizeof(als_input);
+		memcpy(input_report, &als_input, sizeof(als_input));
+		break;
+	}
+	return report_size;
+}
diff --git a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_descriptor.h b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_descriptor.h
new file mode 100644
index 0000000..9f0b042
--- /dev/null
+++ b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_descriptor.h
@@ -0,0 +1,125 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * HID report and descriptor stuructures and routines
+ *
+ * Author: Nehal Bakulchandra Shah <Nehal-bakulchandra.shah@amd.com>
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
+	u8	 report_id;
+	u8	 connection_type;
+	u8	 report_state;
+	u8	 power_state;
+	u8	 sensor_state;
+	u32  report_interval;
+} __packed;
+
+struct common_input_porperty {
+	/* common properties */
+	u8	 report_id;
+	u8	 sensor_state;
+	u8	 event_type;
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
+	u16  accel_change_sesnitivity;
+	s16  accel_sensitivity_max;
+	s16  accel_sensitivity_min;
+} __packed;
+
+struct accel3_input_report {
+	struct	common_input_porperty common_property;
+	/* values specific to this sensor */
+	int   in_accel_x_value;
+	int   in_accel_y_value;
+	int   in_accel_z_value;
+	/* include if required to support the "shake" event */
+	u8   in_accel_shake_detection;
+} __packed;
+
+struct gyro_feature_report {
+	struct common_feature_property common_property;
+	/* properties specific to this sensor */
+	u16  gyro_change_sesnitivity;
+	s16  gyro_sensitivity_max;
+	s16  gyro_sensitivity_min;
+} __packed;
+
+struct gyro_input_report {
+	struct	common_input_porperty common_property;
+	/* values specific to this sensor */
+	int   in_angel_x_value;
+	int   in_angel_y_value;
+	int   in_angel_z_value;
+} __packed;
+
+struct magno_feature_report {
+	struct common_feature_property common_property;
+	/*properties specific to this sensor */
+	u16	magno_headingchange_sensitivity;
+	s16	heading_min;
+	s16	heading_max;
+	u16	flux_change_sensitivity;
+	s16	flux_min;
+	s16	flux_max;
+} __packed;
+
+struct magno_input_report {
+	struct	common_input_porperty common_property;
+	int	in_magno_x;
+	int	in_magno_y;
+	int	in_magno_z;
+	int	in_magno_accuracy;
+} __packed;
+
+struct als_feature_report {
+	struct common_feature_property common_property;
+	/* properties specific to this sensor */
+	u16  als_change_sesnitivity;
+	s16  als_sensitivity_max;
+	s16  als_sensitivity_min;
+} __packed;
+
+struct als_input_report {
+	struct  common_input_porperty common_property;
+	/* values specific to this sensor */
+	int illuminance_value;
+} __packed;
+
+int get_report_descriptor(int sensor_idx, u8 rep_desc[]);
+u32 get_descriptor_size(int sensor_idx, int descriptor_name);
+//u32 get_report_descriptor_size(int sensor_idx);
+//u32 get_feature_report_size(int sensor_idx);
+//u32 get_input_report_size(int sensor_idx);
+u8 get_feature_report(int sensor_idx, int report_id, u8 *feature_report);
+u8 get_input_report(int sensor_idx, int report_id, u8 *input_report,
+		    u32 *sensor_virt_addr);
+
+#endif
diff --git a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_descriptor.h b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_descriptor.h
new file mode 100644
index 0000000..b686ed7
--- /dev/null
+++ b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_descriptor.h
@@ -0,0 +1,642 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * HID  descriptor stuructures
+ *
+ * Author: Nehal Bakulchandra Shah <Nehal-bakulchandra.shah@amd.com>
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
+const unsigned char gyro3_report_descriptor[] = {
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
+const unsigned char comp3_report_descriptor[] = {
+0x05, 0x20,		/* Usage page */
+0x09, 0x83,		/* Motion type Orientation compass 3D */
+0xA1, 0x00,		/* HID Collection (Physical) */
+
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
+const unsigned char als_report_descriptor[] = {
+0x05, 0x20,	/* HID usage page sensor */
+0x09, 0x41,	/* HID usage sensor type Ambientlight  */
+0xA1, 0x00,	/* HID Collection (Physical) */
+
+//feature reports(xmit/receive)
+0x05, 0x20,	/* HID usage page sensor */
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
2.7.4

