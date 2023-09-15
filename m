Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383477A1543
	for <lists+linux-iio@lfdr.de>; Fri, 15 Sep 2023 07:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjIOFRz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Sep 2023 01:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbjIOFRy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Sep 2023 01:17:54 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2084.outbound.protection.outlook.com [40.107.95.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3392722;
        Thu, 14 Sep 2023 22:17:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTXokV8HZ/rD092YGH6P2zNWgYPOjs+Ri8RfHgPA0CJOv98m7NOR/Gukl/UEpqvpwcU9BBN07dWxnizDxaEMszZKKb9J+0oRazXV71kjNf8MIz2YF9UqvIAFoDiSbBhhto0qEBD22ptPqQPWaron85eeJuL94bd/BsJD2R/5cPwHPW4EW2ZMh/OJj+pvjtD20HsAc6a7zlgPi/HQ8bPZdEyKwEma88bUupK9eQMMLBoZwhb4h82E7pA6FzBl/qFzXZvh7djY1ZrxKkANr6EdKh0lvGGMo/e/GpE0539icPe1GCYfRwT5xp++bpX92P634gbiOXORMMxpCBJaAmqTXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYFbC19+qb+hmfTtsZu+eKfqubRxtg4a/ctf2q6CvkQ=;
 b=EYhURd78wvYcUvyWJY1Fngnf8DB8NZj+LHFAuC0/0jCApG4v9EoEimwOzAPu5e2lgY4+zj+N3FYXwl8Ls0aj2Qv3O3BL996myvtaek5OZngi/GbfFTSzfEuKRS6mOM0kV7ajGqAo43ZPtuygTlOmsJq20vPax6zWVHlEcmqMqJ/fJlGhVq0363XBgvMRCfBPeSmrJjmoISl7YEk/yKx3yL3IpXNMRsmNlhANPHissv+Fi/2Xh793ldQ2H10bhrNWwxD6Qo3o1r5WGKuOiiKVtVQNlzlYPaFB9+LL/plxsT2cd9Td3zi3hTd6ck3hBxxYcQfT2vM5zHAjy0gBLFyPSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYFbC19+qb+hmfTtsZu+eKfqubRxtg4a/ctf2q6CvkQ=;
 b=sGhQlg49KlPArnypQvyBjhrEaq/ViZIdgnIGsXItr0X92ZeQAXIvLK89ZYTXtSR/aXZZjYjWWN8y+0P/bzw4I9piD5DOstqcCS7POCMa2zV8o3H0eClITNe3EKgizDoggQVpyRWy+uHArrMXDcO/8I5NtjG0OwCwhjofEl2HoPs=
Received: from SA9PR13CA0106.namprd13.prod.outlook.com (2603:10b6:806:24::21)
 by SJ2PR12MB8953.namprd12.prod.outlook.com (2603:10b6:a03:544::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Fri, 15 Sep
 2023 05:17:43 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:24:cafe::6) by SA9PR13CA0106.outlook.office365.com
 (2603:10b6:806:24::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Fri, 15 Sep 2023 05:17:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 15 Sep 2023 05:17:42 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Sep
 2023 00:17:38 -0500
From:   Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To:     <jikos@kernel.org>, <benjamin.tissoires@redhat.com>,
        <jic23@kernel.org>, <lars@metafoo.de>,
        <srinivas.pandruvada@linux.intel.com>,
        <linux-input@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH 4/8] HID: amd_sfh: Add support for SFH1.1 light color temperature
Date:   Fri, 15 Sep 2023 10:46:59 +0530
Message-ID: <20230915051703.1689578-5-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|SJ2PR12MB8953:EE_
X-MS-Office365-Filtering-Correlation-Id: 32b50f8a-85ed-4ace-6a53-08dbb5ab16c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9R7oj/SGb+s2ZSqqKJ3r0TPFx5c5POHQ+ZkqOD4zg8i51gXNzZIE9GT9Z4LHfFyYNRxf9EX+yKhquldma69YMFZ4OaIWi9sxBqzl3zI3yMg/K+yuLa++YnjIFQGtDMH0WOe4/3wr2NxqJY8wNyXjEw6SjbjMaHlmHh6fbkYT34dz/DobjsmlfLkAgDDJMYL7Vzb5vqrDvP3ZpmLAGlzmWT1+hw6wu8G1hJmzrToDeylJutSl+6613hnwwQXHr/F005xCUY3UtPFEvvbfyW2abNSeHme9kHZUyKQz6GIGhy2hx8tku1aMJ41JSYDGgFCfWi61G6XHizmc5SNURvWKxa+SHuIWgoRMfAj5oqSrLvLc2VW8XxTRtbHeHs8FZejxEK+luYfWPukk6nNcXYknEV3t72d4aN1fmvH2lfSrP2/GmdwdRF/1+2z+wxckDYww5mxY0LkBH1ei0vXGQ79FU8mMzkXcNnLKGqZYSnAxTRND/Rb0YJiOLrPD2NtSVntmt6wRHi3ndtOTBYr9Civ9DHUj1CE9JekDJFabd5jDAgDEdjq9GyoBet/L8xDzVOJJeUr1xf2Rtsq3xIhK7m0h7zN1jdkBNweo3rIo5T0jRhunFiWOv2T9HrAlBkosnV/ypSOnC9wUIQ2sIDBwYu5oaauuxAxMohZvOvT4CFeiqPBOIxSQ93++q9/hWIey3hioUoa398hVxnGIIv07O9NmB5GYj7obAPF9d7HjTJvYXXj5WMdgIV44dSGhe+7E2hdSQnapnSQXwvZzPeRLV4p+Lw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199024)(1800799009)(186009)(82310400011)(40470700004)(46966006)(36840700001)(8936002)(316002)(41300700001)(26005)(16526019)(40480700001)(336012)(1076003)(70586007)(110136005)(426003)(70206006)(8676002)(2906002)(478600001)(4326008)(5660300002)(6666004)(40460700003)(7696005)(36756003)(2616005)(36860700001)(47076005)(86362001)(82740400003)(81166007)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 05:17:42.8241
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b50f8a-85ed-4ace-6a53-08dbb5ab16c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8953
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

