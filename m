Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1A57A154D
	for <lists+linux-iio@lfdr.de>; Fri, 15 Sep 2023 07:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbjIOFSL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Sep 2023 01:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbjIOFSK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Sep 2023 01:18:10 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5D4271C;
        Thu, 14 Sep 2023 22:17:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFPcTO3V/Vm2ApexZ7Lx+UrSlOQt5ODC0OjmdkrBt8qhhhKPQkmAf37vCQvgtorSGygcfnh3Vs4SPB08HGi2HTwSqui3rA4bDjNJyLrs/rUU8gH48pnNc51Rvb9i1RsiBwHnpEh5+eRk+Zq+BTYvnBJLRvRaG/xkUYnvUoWc3bvokO+pXKrBZK8bRdiEZ+4DExH3Hpelwv2Ki01Oaq2sDFI9zkE6vxtLJEtW4HIhIax8lU/FVQSn06op2DJu++0/gSzRlc1NLLJ/zn2zHgBrHNJ9TsqlI/Gu5YBu1yxCT6n5/dQ4CsYbUz49qkOFPxRDRUMDEpfBSQA4pVhoprpkbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BRttNnP96aTPXTUOo6HAVcO1CoeD7W1mXfqZ/tJJmZU=;
 b=FNkd7LUGS+9gwQhFn2EgH9IP3I5/l0z8BBXps9/s4GvE6OhI4mXj6tD+vEuUYNile+hPBR7fkggwwHgeod+jUXakg8mNFzW/8tsqTjCLDMbNDtJZyTKJO9iVEV02F9jZXHcCnqSGHntXDA0MlFw0ygbha7mcFpt+6bLf/Kt8+nUxuH5Gkfa/0Ah+OMxIH+cNqfVl/dJpT5dKMtqfUIPhmQqydHXiPOAO2Pv2UX/jg8YIiQ581ySykG2D0q4bAx+67/7ASsr/d8f8MjonvRkNP5ssGmc+LH/VcVJsCneQC8Mgn3b5SZmh2FPygio/iFCh/FnK0kH7CtP4ArgmLvyhoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BRttNnP96aTPXTUOo6HAVcO1CoeD7W1mXfqZ/tJJmZU=;
 b=GXsmtr0n5bNMROC+VZGm89ewL2bmLWhjMyKTaS4/BCe3NLaAVy49XIsIZhCLxKM+3PyM2T6PgtmuSknMDsW4Ol7bha7Zeo8bwOVSCwKGHdk8p+f5Wxq8jT+CDGwfmVYqh1qKjhsHLpC6ZoJbe7em7W7PYpxYoEZ60oFSO0TR8I8=
Received: from PA7P264CA0410.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:39b::22)
 by CY5PR12MB6408.namprd12.prod.outlook.com (2603:10b6:930:3b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 05:17:54 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10a6:102:39b:cafe::e2) by PA7P264CA0410.outlook.office365.com
 (2603:10a6:102:39b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 05:17:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 15 Sep 2023 05:17:52 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Sep
 2023 00:17:49 -0500
From:   Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To:     <jikos@kernel.org>, <benjamin.tissoires@redhat.com>,
        <jic23@kernel.org>, <lars@metafoo.de>,
        <srinivas.pandruvada@linux.intel.com>,
        <linux-input@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH 8/8] HID: amd_sfh: Add light chromaticity for SFH1.1
Date:   Fri, 15 Sep 2023 10:47:03 +0530
Message-ID: <20230915051703.1689578-9-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|CY5PR12MB6408:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fb23a10-41b7-4d63-c9e2-08dbb5ab1c98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ifVROvhFmyMC5XlzWQg7IAZpyPmHXnme/gxftLfX/NB1wsnOVWWeLZe0tBgaGbQ/HQyYBtvCAX8dbFF1klTKYt5FjycgPMuQno9SylZOrdlyQnfueTuAUUcGSIX6xM7ctpLlzV7RI3Y3YAxd0+/KWPv/fQeeqI6bGFaIikWgj0gaXAHgcf+EGIf+XIljMdBjt5JL5egcXFXSZIrf/+u4COOyDWCOXDuhLDcNRUNzx+meFsVNXhJ1sZWRBrYbmieA1FeAdzUNN4TMuZ1bYIR1EiJVIYHkMABNz8WNT0FMIgpOR0TmJRXwwY80Bidq/0g0TWrEGGe5RFf3bV3nqeUQuKcj65bobTNsrSnqKB4cL7al8AKGXoMRMELCB70QKyo2etJP0Mfe7kt962a+gsnAnnEol9eVwmDpYxszKgFuN3swPQDh2SVj7NcfYxGvIRBbr6FHkMeBDApw69oMpUXAAFZvAPC7d3s/gWw/pNmzbmr2QuqUX0ZRkK5k5qrHgA0covRuKfftkct3FTVJMWMGtFoMAhgfMPyHSPdY3cLeBIh9oS+DYjPFaMhyMWvVAsAPyax3frfOwioIhO3H+r96d+5sbIkjm7b6fJKjTIKoa0bnbRUUuYrvm7MoQjtzZS4++97Sfy153Lf/vwP3hVY49cPmEZVmERxYntgfwOYeWLrV5WZTXtLOLhs8Vaa8LmfANcLKv/x3Rdmls7XJprb4RMR+cLT9H3Hs4uSQDDmEaMk59C9X3+ZRWSw7r+L3SRhwhf93nMm9lCUkOSh66YPw0w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(82310400011)(451199024)(186009)(1800799009)(46966006)(40470700004)(36840700001)(36860700001)(478600001)(40480700001)(40460700003)(47076005)(4326008)(8676002)(8936002)(81166007)(356005)(316002)(110136005)(70206006)(70586007)(36756003)(41300700001)(5660300002)(82740400003)(16526019)(1076003)(426003)(336012)(86362001)(26005)(2906002)(2616005)(7696005)(6666004)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 05:17:52.6242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fb23a10-41b7-4d63-c9e2-08dbb5ab1c98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6408
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
diagram. Thus, add light chromaticity x and y for SFH1.1.

Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c      | 5 ++++-
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c
index f100aaafa167..8a037de08e92 100644
--- a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c
+++ b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c
@@ -238,8 +238,11 @@ static u8 get_input_rep(u8 current_index, int sensor_idx, int report_id,
 		als_input.illuminance_value = float_to_int(als_data.lux);
 
 		memcpy_fromio(&binfo, mp2->vsbase, sizeof(struct sfh_base_info));
-		if (binfo.sbase.s_prop[ALS_IDX].sf.feat & 0x2)
+		if (binfo.sbase.s_prop[ALS_IDX].sf.feat & 0x2) {
 			als_input.light_color_temp = als_data.light_color_temp;
+			als_input.chromaticity_x_value = float_to_int(als_data.chromaticity_x);
+			als_input.chromaticity_y_value = float_to_int(als_data.chromaticity_y);
+		}
 
 		report_size = sizeof(als_input);
 		memcpy(input_report, &als_input, sizeof(als_input));
diff --git a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h
index 6f6f5db150c3..656c3e95ef8c 100644
--- a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h
+++ b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h
@@ -147,6 +147,8 @@ struct sfh_als_data {
 	struct sfh_common_data commondata;
 	u32 lux;
 	u32 light_color_temp;
+	u32 chromaticity_x;
+	u32 chromaticity_y;
 };
 
 struct hpd_status {
-- 
2.25.1

