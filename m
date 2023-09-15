Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F22D7A1546
	for <lists+linux-iio@lfdr.de>; Fri, 15 Sep 2023 07:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjIOFSB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Sep 2023 01:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbjIOFSA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Sep 2023 01:18:00 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F202737;
        Thu, 14 Sep 2023 22:17:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGKVudfhd7vX93BI8PNO78eNEZm1PmA4OJ+r2g9omQ7r7R90OCYNKkf3mtcSXVQbLuH12f5/HrPlfQj+Bs0/y9RR6PDZ3ckj9bHeWrLLrMZiLdcpFBDEh1pORSORTJ1Ov1iW+NBEoAC+MokD3E8i25HTbw0xFfS3rAwzbwjPIyyWapmCI2KwkwZAEebE4Tl2BuBmNBhp6O5mGAf+ouUrehHEbvl9URyjvS8m82DXa4/ien1AU4Yu6MUf2KhgxP8zOQ3v5rQqlZsv8bzhq+qyQA0VGhrjB6QsAyrlqVYe1f/qwM4kKm6prgcR+WGDneBpW4ySOwLOsJFqFkBxx1przg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nXhPlcnMX5GWYU3NNqKS2RRG50qP19klF6F04ecWysU=;
 b=IAk/IjsfnCwBI3e0g/QtYHa8jEBoWTf8wEDiucjtNc1vPmctB19tWiRY+iJbwX0K4qYFbYWtxl1VCd1rHZMIgWUaEeJdvBqTGJ9FgKFhgwlkrY2MzguAkRCq3Ijg3v/9TINFsyJTsn7GnMldmdbuNK3S/zhFRvJ6pDoDtMjTe86ZGOC7Wg0Zq6PuofwZEi+Evk+H7OiKdcnaAeAi1D0q8KhwVRF0MfE85GGb/Mfb13nQGd3ZUxdGYJBkZXCJCRuqg5/1qaSMjJ2M07V0ieNAbLTPDcrJUk/wpgurYYUlXoAxGmi79etNfO0Vx2Y6a6aF4brmJbsqT1R4iFS+Vg9dkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXhPlcnMX5GWYU3NNqKS2RRG50qP19klF6F04ecWysU=;
 b=BOYU1wHtt0hqjtoV8WklCyGMaRH/Nsd9oLZpfhIcpZE+baqMuLLq5nsFPdALGYKXHMKRPSc/09D89bUnAu1oeidzjcwPt0tNsSFd3LKShDpyqJ2hwi4BFhn6sHNsbWEuLr69Qw9LB+n0D8rWLll4YPWMb8wlWCQtLYDqd+2Hkko=
Received: from SA9PR13CA0120.namprd13.prod.outlook.com (2603:10b6:806:24::35)
 by SA1PR12MB6703.namprd12.prod.outlook.com (2603:10b6:806:253::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Fri, 15 Sep
 2023 05:17:44 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:24:cafe::ba) by SA9PR13CA0120.outlook.office365.com
 (2603:10b6:806:24::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 05:17:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 15 Sep 2023 05:17:44 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Sep
 2023 00:17:41 -0500
From:   Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To:     <jikos@kernel.org>, <benjamin.tissoires@redhat.com>,
        <jic23@kernel.org>, <lars@metafoo.de>,
        <srinivas.pandruvada@linux.intel.com>,
        <linux-input@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH 5/8] iio: Add channel for chromaticity
Date:   Fri, 15 Sep 2023 10:47:00 +0530
Message-ID: <20230915051703.1689578-6-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|SA1PR12MB6703:EE_
X-MS-Office365-Filtering-Correlation-Id: 3987c0a3-b6a0-4062-d5fa-08dbb5ab17af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oouxGMILpwTkEEEyk2higrrAQYw3SGj6IlDSRV5YZR+VLzncw4W2i6jEw+K7AF1HzPZ5LywdJZnPPytq0yZckUrREo95iCvBma8/nbJJeZwWE2o4CrKmWKFMehXRHBxQkIfY2H4cnahSOtVDhexEPd2fdYge3qnQhwMvxcoryTkJRWDOEiBCcxl7vpYnCoEnRQ1kEpCBpyEe6dk1MVOaGSdIqRCsbupRmG+287WKTvzGzNVnhq4N8QA+SX08jm3BaglEvkO0FhzPhlRWf3nYeluQs5Bo2dBTu1NY5TX+OgZNdtWIO2wV1qZLgLg/HLPq8v6NGe2Xg0k11KGeEqCi9N4DguogULqIIGqRi8YVNZwFoXAu8BY5e0IP4rUShfXHBSLX1ioy5PAa6IorM4Cd4wygXBg/hXyVpf2z4zNHgPZjGx5g7wtTeGcssoXO6vPOE8s4ua8wV+7nvD9gasO6Hoar+JII3tuBhFBYDe5o227TC4tDSmmCnYUAJ+5G2Bh1hcMhT5nJCOTea6JE6jBHoeQHLgiz3WkxVjPTVGp4hQ6z14Eu1yNJRYjskQB/gpty422f5D8i5ALb/DweIRZCsyTPSjaxG4lhCyPZfMG/51Vpmr+/syOz6Tkm3BdnI37MQtl+oq6ZlX3MurYndsIaev2ISr/JNtEvQNzMOFEK6IZ3iIgXuoHKe4F1Jyf5/9bqgrto+nqXLUa3vFy2ANgHbm6L/WbCLbi7IpIv/+XNFBmkAv4JhTzftn+ndrbJ3dvB9jF/P5Y21gemlRL8bqUweg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199024)(1800799009)(82310400011)(186009)(36840700001)(40470700004)(46966006)(40480700001)(8936002)(41300700001)(36860700001)(81166007)(316002)(70206006)(2906002)(110136005)(70586007)(478600001)(6666004)(86362001)(8676002)(5660300002)(7696005)(2616005)(426003)(47076005)(356005)(82740400003)(1076003)(336012)(40460700003)(4326008)(16526019)(36756003)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 05:17:44.4023
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3987c0a3-b6a0-4062-d5fa-08dbb5ab17af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6703
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
diagram. Thus, add channel for chromaticity.

Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 8 ++++++++
 drivers/iio/industrialio-core.c         | 1 +
 include/uapi/linux/iio/types.h          | 1 +
 tools/iio/iio_event_monitor.c           | 2 ++
 4 files changed, 12 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index a2854dc9a839..6a810771f5e4 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2179,3 +2179,11 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		Number of conditions that must occur, during a running
 		period, before an event is generated.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_chromaticity_x_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_chromaticity_y_raw
+KernelVersion:	6.6
+Contact:	linux-iio@vger.kernel.org
+Description:
+		The x and y light color coordinate on the CIE 1931 chromaticity
+		diagram.
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index d752e9c0499b..c1df66cdfdf6 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -90,6 +90,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_POSITIONRELATIVE]  = "positionrelative",
 	[IIO_PHASE] = "phase",
 	[IIO_MASSCONCENTRATION] = "massconcentration",
+	[IIO_CHROMATICITY] = "chromaticity",
 };
 
 static const char * const iio_modifier_names[] = {
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index c79f2f046a0b..8952d48cfc64 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -47,6 +47,7 @@ enum iio_chan_type {
 	IIO_POSITIONRELATIVE,
 	IIO_PHASE,
 	IIO_MASSCONCENTRATION,
+	IIO_CHROMATICITY,
 };
 
 enum iio_modifier {
diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index 0a5c2bb60030..115ba1fbf3ac 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -59,6 +59,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_POSITIONRELATIVE] = "positionrelative",
 	[IIO_PHASE] = "phase",
 	[IIO_MASSCONCENTRATION] = "massconcentration",
+	[IIO_CHROMATICITY] = "chromaticity",
 };
 
 static const char * const iio_ev_type_text[] = {
@@ -173,6 +174,7 @@ static bool event_is_known(struct iio_event_data *event)
 	case IIO_POSITIONRELATIVE:
 	case IIO_PHASE:
 	case IIO_MASSCONCENTRATION:
+	case IIO_CHROMATICITY:
 		break;
 	default:
 		return false;
-- 
2.25.1

