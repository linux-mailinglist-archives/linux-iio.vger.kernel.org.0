Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35807A5C21
	for <lists+linux-iio@lfdr.de>; Tue, 19 Sep 2023 10:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjISILw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Sep 2023 04:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjISILt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Sep 2023 04:11:49 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53CA12C;
        Tue, 19 Sep 2023 01:11:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cm8RK2xGTyMrF+raG6lUo5GvkVl5uRea4zGdoZcPtMxnYFaqx/ArdtuwMG0wK8ddXOVyBLP5fpVJ5SNAl9sktlF4+xeFQOBfIWs+aqMWItGAtLSzZR/FxFNuU/tSFCjUBy9f4ZSXYKwAmgYuuXQW6M3PMbsD3P5XZvLKnGKkycOzw/A+Dfh2gdAxqeuDO6rXhz+ai6k4m6qE751Fz2dSHjdmAOwhDwiKHxxTBg1fZbmUKAnViR4NwH3A/nv3q2msWnjCf8DkL8IPPGXMkYqFJfDmbFXO+djGkaCydBqvHi/EdEGiWEKSj3CK62rZrKxLmpxStKCdKkzf4Ke2yknryQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYFbC19+qb+hmfTtsZu+eKfqubRxtg4a/ctf2q6CvkQ=;
 b=WURDObCa0nlQ5kMqyY92x3ENBJuhBj7kPvToEE189bz9gsnmPRGvzRVnct3hXJoBY8YyaUcwJB/9w8maU9lLABueBYBh8F1DhnXYyIlLxJhfhbhjHdPosqSJYj+AtlAQ8A63w6Y5KsSDTi8eSvRBrkb2PMAOes8Xun5+M8L4ytQTdwossSq//q4AcOgq1tFO70MbTw3H4S0lpnObJvTzXJAOjv6PpH/8EeB6EB06UNFbEbBVSh654wMRSADUI7FphgQlV+/tUWx9qhzAucjFGEmZwo/qWrzrenjguURU2aaQlDmG7huLG5n5SbP7TUXyDp/QWA3W3BGJ3Zm4pfmAXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYFbC19+qb+hmfTtsZu+eKfqubRxtg4a/ctf2q6CvkQ=;
 b=0XSxtJzyceGLFiIbugwQhWb8FO0yXUlxjIfiSymP4QTNoUHzM/HF5spAFObGGyaHNeD4zMddxu+z+KatsW9oWDI9YAjKGL6zodkFodc17A5ZxbbuMJKKjlazLet1neIPwqyu2UWU2eWe6wvfcXt54fuV1ClBnKqQK5z6Ei4eTzc=
Received: from MW4PR03CA0038.namprd03.prod.outlook.com (2603:10b6:303:8e::13)
 by BL3PR12MB6593.namprd12.prod.outlook.com (2603:10b6:208:38c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Tue, 19 Sep
 2023 08:11:35 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:303:8e:cafe::58) by MW4PR03CA0038.outlook.office365.com
 (2603:10b6:303:8e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Tue, 19 Sep 2023 08:11:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Tue, 19 Sep 2023 08:11:34 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 03:11:31 -0500
From:   Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To:     <jikos@kernel.org>, <benjamin.tissoires@redhat.com>,
        <jic23@kernel.org>, <lars@metafoo.de>,
        <srinivas.pandruvada@linux.intel.com>,
        <linux-input@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v2 5/9] HID: amd_sfh: Add support for SFH1.1 light color temperature
Date:   Tue, 19 Sep 2023 13:40:50 +0530
Message-ID: <20230919081054.2050714-6-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|BL3PR12MB6593:EE_
X-MS-Office365-Filtering-Correlation-Id: 846f533c-273f-4f8f-5cbd-08dbb8e80a81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VYf8i37kOK7br0+PrLtDyo1+A+dHU92DG9gH7/92LNLW1ubNW0YiGSxzEoFBVLLOZQBA6B7qNtodQkL2wkXiDsapcXcFGM+gVN+gSxOgOezNfmL/oQ0NNBj6pbc5V97YwjKzYtYqZCPl/BGYhFc9v0MmQF5OF0WtkdGD2T4oURJe/Qs8tXlGXI5P+OFTdq8u4pE8VTfAuMxf7mE3ckRRNAhkdUAsUtGMYOr0hLK5VdHZ+x6n6u4JdJLG+WuqRhOuBqdYw3gQqARiZ1/oI44SyIPN+FQrHsBSCU5kY7jiMJyuSn24KLf1GXJKlx+tvWW+Bpi516vIiNveAzXiQx0lUB0RzT4IO7IYsFT5bZP5zPleHblFPEYLkkGZrHMxwf/oolmNO6hnffcW8S3Vj5fd7Hv4bcQgk6sLKwlgmOWXgSKreHNwZQJzERSrtTJBBsHMm9Schu5aSNgZukCRYGxvrKx89YOY5961n3x71nMsNLwDMpd6eC/cmFWr0JG+QbmE1FgGUmptX9ekduroAT24J545YLrNNpW99VJ7VXKzkBOg6AVGEiw6h6p2UoW+RVhX5ajj32DKp/K5TPeSRQL8XHtaduwLLOT9EX0JO/xClyOTkZ/dj8ZdpvqE8QZ00c69+XY5dj9PRN3qaGfScoLdBo/cCJK6nUzc3OD/1yXx+eJWYPJKwFubvC5i+sksLPngu7XP/zzJGribmXZGYnKnPtptHrsITTSpL7W/BkMOG8j9bvUMm23b3RXGrwa+S9qK4wlKjNUTEx2IOPKpBBgFPg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(82310400011)(1800799009)(186009)(451199024)(46966006)(36840700001)(40470700004)(110136005)(336012)(7696005)(6666004)(47076005)(478600001)(2616005)(16526019)(70586007)(356005)(2906002)(426003)(1076003)(70206006)(316002)(8676002)(4326008)(8936002)(86362001)(5660300002)(41300700001)(36756003)(82740400003)(81166007)(36860700001)(26005)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 08:11:34.9824
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 846f533c-273f-4f8f-5cbd-08dbb8e80a81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6593
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
As a result, add support of light color temperature for SFH1.1.

Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c      |  6 ++++++
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h | 13 +++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c
index 06bdcf072d10..f100aaafa167 100644
--- a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c
+++ b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c
@@ -188,6 +188,7 @@ static u8 get_input_rep(u8 current_index, int sensor_idx, int report_id,
 	struct sfh_mag_data mag_data;
 	struct sfh_als_data als_data;
 	struct hpd_status hpdstatus;
+	struct sfh_base_info binfo;
 	void __iomem *sensoraddr;
 	u8 report_size = 0;
 
@@ -235,6 +236,11 @@ static u8 get_input_rep(u8 current_index, int sensor_idx, int report_id,
 		memcpy_fromio(&als_data, sensoraddr, sizeof(struct sfh_als_data));
 		get_common_inputs(&als_input.common_property, report_id);
 		als_input.illuminance_value = float_to_int(als_data.lux);
+
+		memcpy_fromio(&binfo, mp2->vsbase, sizeof(struct sfh_base_info));
+		if (binfo.sbase.s_prop[ALS_IDX].sf.feat & 0x2)
+			als_input.light_color_temp = als_data.light_color_temp;
+
 		report_size = sizeof(als_input);
 		memcpy(input_report, &als_input, sizeof(als_input));
 		break;
diff --git a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h
index 9d31d5b510eb..6f6f5db150c3 100644
--- a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h
+++ b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h
@@ -88,6 +88,16 @@ struct sfh_sensor_list {
 	};
 };
 
+struct sfh_sensor_prop {
+	union {
+		u32 sprop;
+		struct {
+			u32 elist	: 16;
+			u32 feat	: 16;
+		} sf;
+	};
+};
+
 struct sfh_base_info {
 	union {
 		u32 sfh_base[24];
@@ -95,6 +105,8 @@ struct sfh_base_info {
 			struct sfh_platform_info plat_info;
 			struct sfh_firmware_info  fw_info;
 			struct sfh_sensor_list s_list;
+			u32 rsvd;
+			struct sfh_sensor_prop s_prop[16];
 		} sbase;
 	};
 };
@@ -134,6 +146,7 @@ struct sfh_mag_data {
 struct sfh_als_data {
 	struct sfh_common_data commondata;
 	u32 lux;
+	u32 light_color_temp;
 };
 
 struct hpd_status {
-- 
2.25.1

