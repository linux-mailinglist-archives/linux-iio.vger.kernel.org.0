Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7E224126F
	for <lists+linux-iio@lfdr.de>; Mon, 10 Aug 2020 23:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgHJVcC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Aug 2020 17:32:02 -0400
Received: from mail-eopbgr690050.outbound.protection.outlook.com ([40.107.69.50]:7030
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726928AbgHJVcB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 10 Aug 2020 17:32:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LuNQ/+9fFadOmrrO9yjoFnrrktIZc0MdfqEPCXYwjr8MeSoNSamh/3ur4f2JtNWmV9aWhUC8J+HGobC04YT1/h3F9HPMejdJCYAmKkheX3MpspOHi3Lfd6RNLv/SAqMzoeWfC6gfQQrlC8DAevsvZJ1T2SiiBNZcFPTQT5EcskahsWRdhN+G6nNaqOKnCqbOcbabaCu/A5/VbHXNOxPpEGhYiBwAM5Sxb9p0gf0cOuhNRjdx2aRaEm7hfHrKWe6CTNDsQU2Rp4I8VRT8FKtcQQIlxQGFlDvIXuQ2vt195135m1LNtaVQwtWXUDeEScHMGs3PugIn7v8j2I/Ngd1nLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BeV4XL9YAUzQEEVHUoKWFdLpymJFyrSG6V7La4xZqpc=;
 b=Xn75AWdrzHEulOsWElFXNMgXd4vBjpnp5rttoPWsXgKIDHuFAgxcmpNJni62P3aJa5vQLnKu5zwt/1gaBq/2cwKqWp466usydJTK7pBzUa4am2qCiJW5OmlKw0E+Y2ndp+Ivjp2xsf3IgwsjslHw4Pw+i1ln6GbqBtQeWcVAWbpisnBxKPagNLI4rrA0HaImFkaV6OlcssPDfU0iuxMM2dzYnKl79KA8+MdoujVaz63q0KF/eh6n+ld0w6QmhdxKcGpvb9JZNCetVmEO8BiQrCAYVN7eifleroKk61Vz/XMhKTz/14vFtJl8Bk8OdD/fcQpA9bazAe0molKyyB+5kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BeV4XL9YAUzQEEVHUoKWFdLpymJFyrSG6V7La4xZqpc=;
 b=h+jgcGFmBr8uD8NM7q3tB13E+oCBU9hS7JAITgZfZdCpgxBAMeNYQl22N5tKHutfz7I5G4yevwVhZJLUnmce4XBrdxlQrOQtppXmTtuCXqZI0XKGTDieVPa2ChmPFZtVFwrzf81au3viN0nS07r/uGTqJF+Ff2xuShP84cGfSi8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2726.namprd12.prod.outlook.com (2603:10b6:a03:66::17)
 by BY5PR12MB3715.namprd12.prod.outlook.com (2603:10b6:a03:1a5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18; Mon, 10 Aug
 2020 21:31:54 +0000
Received: from BYAPR12MB2726.namprd12.prod.outlook.com
 ([fe80::8503:3713:6ed0:af09]) by BYAPR12MB2726.namprd12.prod.outlook.com
 ([fe80::8503:3713:6ed0:af09%6]) with mapi id 15.20.3261.024; Mon, 10 Aug 2020
 21:31:54 +0000
From:   Sandeep Singh <Sandeep.Singh@amd.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        srinivas.pandruvada@linux.intel.com, jic23@kernel.org,
        linux-iio@vger.kernel.org, hdegoede@redhat.com,
        Nehal-bakulchandra.Shah@amd.com, andy.shevchenko@gmail.com,
        mail@richard-neumann.de, m.felsch@pengutronix.de,
        rdunlap@infradead.org
Cc:     Shyam-sundar.S-k@amd.com, Sandeep Singh <sandeep.singh@amd.com>
Subject: [PATCH v7 4/4] SFH: Create HID report to Enable support of AMD sensor fusion Hub (SFH)
Date:   Mon, 10 Aug 2020 21:30:55 +0000
Message-Id: <20200810213055.103962-5-Sandeep.Singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200810213055.103962-1-Sandeep.Singh@amd.com>
References: <20200810213055.103962-1-Sandeep.Singh@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR0101CA0025.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::11) To BYAPR12MB2726.namprd12.prod.outlook.com
 (2603:10b6:a03:66::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jatayu.amd.com (165.204.156.251) by MA1PR0101CA0025.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:22::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18 via Frontend Transport; Mon, 10 Aug 2020 21:31:50 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0776f54b-c500-4263-6ad0-08d83d74cd24
X-MS-TrafficTypeDiagnostic: BY5PR12MB3715:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB37152FEAE48535EF263C807FE0440@BY5PR12MB3715.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3u1Y7UvL/K92St0PohPx+lJMu84nR16WBzasXut9MojERPJ6EVk87sAQXzPlB7040mzuR+WN11DtMTGNE09XNF4I6Kkhj5jA4RRyxUSJVsQvLbPHR2+cjko3cAxkBrHuAsYBOyvPq+kfU0EcFtz8G6Nro/54R4SlfY+4MWCtr5AiUOCskpN+sVECaCmLaLwsOsEGc1wUDDMUMxdLHlU3BCPHD9T8O0LUvs8adky1wkoZ4NNDfQJUsg2yBP0K/Qb3IMhc1mF4k1qZM/PWWhn8wVRlNAbWzaeh0bsnOsl3onjOWPEq4+JWZtaCR0OThJODeHP9qKuTUMic+JIcmvGqBiUHJWaCsvD2GKFSIqhpCP10xgFxHeo7mgYGqo23Rogi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(366004)(39860400002)(396003)(376002)(2906002)(6486002)(26005)(30864003)(186003)(7696005)(52116002)(16526019)(5660300002)(66556008)(66476007)(4326008)(66946007)(1076003)(478600001)(8936002)(36756003)(83380400001)(2616005)(956004)(86362001)(8676002)(316002)(7416002)(921003)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: KDHlfGu0K7gJnBSvbIqhOHw1IDSJwWLobhN78J0mFM3BIUh3NGyaNw3VrRw2ZwMT9S5mVGKa0WR/vNPAW1HZbWXOJEyIyJztPP6ZMkRuT7w3o+JcPFdb6QXzUIMFV8uocKyTzEif4jltwTRn4ZjUxd4OvIkjfHquchS9CZ5qeTjdZIC4WX+VMpYqmQJe5iDITkMeWZpjKycl4LboXo324QZRfYfscnC1EIh7rvoit8D0JeX/Ldu7gkE2pq2knNxTr9nl8EYQeWoJFltuWftCId5B5y/8bfxhZU1k8/1PRCt6k0tDenfzFgyMUIgdBZXVUnlDV6B8Uz5Fk306T2yiUEWwAYnhxzSJFncV3IhMLUyaT2c8pe4sKe85lHZLufycd6cSYRKPEYh9H0WCYfS8mF4CdHpUm7dhtuABKVFPCD34FM7O0gBrckJnmh630Y77EJdQzlTKwxykbkM41V8a+hLkmoT+E95LuqU+ErObzBWmgHF2pSYNaHB2gyto3RkkpbSUAMizsjhGYKIEnGq8Ur1GqG6eDbnxIyQ4wezd+PE6GJl1voG8knujtZ2xcO6tkdO+0F5S14dBKYHvWYRFeVsaKTwAn3ewfv9I080rzqL3/vG/bV0WViP7VDkiNPRQD1j2/WGY+UCvPDsNxv7AaQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0776f54b-c500-4263-6ad0-08d83d74cd24
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2020 21:31:54.5029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KamZ9Ygk0zuK2YQvyAtss3Nr+Mfayp3vp5rGpDaOya0KjzKUF10CVL7FgjSqcmAk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3715
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Sandeep Singh <sandeep.singh@amd.com>

This part of module will define the data into HID reports. Get data from
PCIe layer and populate that data into reports. HID core communication
between devices and HID core is mostly done via HID reports.

Signed-off-by: Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
Signed-off-by: Sandeep Singh <sandeep.singh@amd.com>
---
 .../hid_descriptor/amd_sfh_hid_descriptor.c   | 226 ++++++
 .../hid_descriptor/amd_sfh_hid_descriptor.h   | 121 ++++
 .../amd_sfh_hid_report_descriptor.h           | 645 ++++++++++++++++++
 3 files changed, 992 insertions(+)
 create mode 100644 drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_descriptor.c
 create mode 100644 drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_descriptor.h
 create mode 100644 drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_descriptor.h

diff --git a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_descriptor.c b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_descriptor.c
new file mode 100644
index 000000000000..dc87c0547874
--- /dev/null
+++ b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_descriptor.c
@@ -0,0 +1,226 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  AMD SFH Report Descriptor generator logic
+ *  Copyright 2020 Advanced Micro Devices, Inc.
+ *  Authors: Nehal Bakulchandra Shah <Nehal-Bakulchandra.Shah@amd.com>
+ *	     Sandeep Singh <sandeep.singh@amd.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include "amd_sfh_hid_descriptor.h"
+#include "amd_sfh_hid_report_descriptor.h"
+#include "amd_mp2_pcie.h"
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
+
+	case als_idx: /* Als */
+		get_common_inputs(&als_input.common_property, report_id);
+		als_input.illuminance_value =  (int)sensor_virt_addr[0] / AMD_SFH_FW_MULTIPLIER;
+		report_size = sizeof(als_input);
+		memcpy(input_report, &als_input, sizeof(als_input));
+		break;
+
+	default:
+		break;
+	}
+	return report_size;
+}
diff --git a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_descriptor.h b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_descriptor.h
new file mode 100644
index 000000000000..823cecbca046
--- /dev/null
+++ b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_descriptor.h
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
+	u8	 report_id;
+	u8	 connection_type;
+	u8	 report_state;
+	u8	 power_state;
+	u8	 sensor_state;
+	u32  report_interval;
+} __packed;
+
+struct common_input_property {
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
+	struct	common_input_property common_property;
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
+	struct	common_input_property common_property;
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
+	struct	common_input_property common_property;
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
+	struct  common_input_property common_property;
+	/* values specific to this sensor */
+	int illuminance_value;
+} __packed;
+
+int get_report_descriptor(int sensor_idx, u8 rep_desc[]);
+u32 get_descr_sz(int sensor_idx, int descriptor_name);
+u8 get_feature_report(int sensor_idx, int report_id, u8 *feature_report);
+u8 get_input_report(int sensor_idx, int report_id, u8 *input_report, u32 *sensor_virt_addr);
+#endif
diff --git a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_descriptor.h b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_descriptor.h
new file mode 100644
index 000000000000..44271d39b322
--- /dev/null
+++ b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_descriptor.h
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

