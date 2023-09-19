Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA977A5C28
	for <lists+linux-iio@lfdr.de>; Tue, 19 Sep 2023 10:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjISIMC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Sep 2023 04:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjISILu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Sep 2023 04:11:50 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B2618F;
        Tue, 19 Sep 2023 01:11:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WYMHIfhoWiloJJAKTkcYRWsQVb/sBlDcsL7LmuQLbghsVP++s1XgTAUS6AuUEn38E02kiHfCkRC/yZLHop798w4XFX76mRkMqY+98Rj1Qfcez0INCJkSbtn9JdQzZJZlIKLRyPKA2+Q9IbfoaM397tPDgqOTKfdzj40zws64oDBhKmzlasMNvPUoyBzU3tWxMuOYuzm2IgVMMEl/sUKe5IpE2PAMJnM5W9X9jkxnZCpGR+I5BUhwebVu/4Ug7o5NFu2bnbjWSzRdzvUMT3oHRwoahEyv89ZXCmQZbbtofdHL/V0O4rQIWFkdys5PxNblAfFR/3PaM4PMSnXPHZZq6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4GOZDiGaiqGffm/LE0+eDNy1BcfpXqw4uJ4Bmy0+nrk=;
 b=ZslMRHZN6ePydYYZ6UJ8hEjjufd4PTTG+1i47dnjf57kuRaVXZ99ryRmsMsGOxDZDjSkFArHSEhkS6AdHy3T6VH8+/Hf0W5kOdrp3k5vtTPjxCo6neGY8l3B2rQ/egFVu2QrrJCc/ff80Ts7v/tApRNBsbPFLV8sdfujfjNvQ/hm3WbNRIXq1F4YeZZ2WK9YEs0j2lighH5n3cnF64A8iW/Qd7+oBFrT+e/6F35lFkl7OwcI8hYENl5WWdLLcQIxGoyY6kHvFC+gHjHLjfsPPUJcBV8AYIGxLLthUz5rfs5QuwhTcI+0CS4PIcryit5br3EHyMG3M3fnpRrm0G8pow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GOZDiGaiqGffm/LE0+eDNy1BcfpXqw4uJ4Bmy0+nrk=;
 b=xdCkvd/UBp7rQYBVGT5vzx2kdU+XVqzHXjzo2WxOM+yRxRtuS1yBDJ9oXuwD0tn5Y3eMX6ro0xvoDlI3+7SuDypYU+8h6z3cg970OTdhIqyZNixfi/YY/ZKPSDA/k9UNba4/sa+83dLc2rZG6/8mR9SVlM/yejqnEKivuOD97Hg=
Received: from MW4PR04CA0070.namprd04.prod.outlook.com (2603:10b6:303:6b::15)
 by CH3PR12MB7739.namprd12.prod.outlook.com (2603:10b6:610:151::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Tue, 19 Sep
 2023 08:11:38 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:303:6b:cafe::4e) by MW4PR04CA0070.outlook.office365.com
 (2603:10b6:303:6b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28 via Frontend
 Transport; Tue, 19 Sep 2023 08:11:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Tue, 19 Sep 2023 08:11:37 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 03:11:34 -0500
From:   Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To:     <jikos@kernel.org>, <benjamin.tissoires@redhat.com>,
        <jic23@kernel.org>, <lars@metafoo.de>,
        <srinivas.pandruvada@linux.intel.com>,
        <linux-input@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v2 6/9] iio: Add channel type for chromaticity
Date:   Tue, 19 Sep 2023 13:40:51 +0530
Message-ID: <20230919081054.2050714-7-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|CH3PR12MB7739:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b7513b5-f92f-41b4-04a8-08dbb8e80c31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M42mGJh+vpWmW9vSuXmtjbyoilj9oB25bmRlQADNgyPi8Ptl8Y+31p/JjbCTsFTtEiJqqJSJ7Of4Y7IuPv6SWsbwo4itXn9RlIAwu7xpWDZkjJyBcbpY82iFHLHoftd+vRzxzSIeITCKsugGOOQKURE0AZXSG0mYcBks4Ad/2SsH29vkuGuboRyGvmyodiD+mSHqiz+vjh7xMs3nv4df+SEotyCUkXoFJPd3gK0TQPapmLEdZRfF7beWF0HqwTczPJJOCnuCsCPClIpvsgIMkYkCOrek0Df88UVjzUSaZeiwIFzxqJlWtGKEG7gVCRrf5l2aX/MA8E+hp5tM/Hw1QjoucH93IMlZbwK1J8w3WK98+ibYAl0uKzVRkkBlGA46V8qGoJgc9DaAu7xZCuNy5Uh3W3pS2Yu1i3aebtSnJF67prMGu7UUoX0pyapNr9PblUYObbB0Vtki4vya8PpUK6LDzoo3h5//JzpJkEaDBJ7G2zktp1uXABUXdFKVQKW2yMy/wpdJs0+OHWVmhSS6kTDeQNG1yG51KKyucIgcUoHgruFCHFZEd3pE0HR9b77WYJT281d4gtVC/iw8NLuxvIdvTyxBl/Cdr+iBkWnOENdDmm9dSzkN0cYNRgT4UlXZnJolqwuefy8FLaGzPdhkVlH2qqkqE8ZpqCM2X8uZzo4aZtq5rzB4cvaUzeM4Y3ikQ0BldEl8YFYFV32GGXMOfCggz/Ft2rUXaUT9NWOwLzJwJaffiLWINNJkojk0qDGRG+VTLTni5iST2O+EK2VKvA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(136003)(39860400002)(346002)(1800799009)(451199024)(186009)(82310400011)(36840700001)(40470700004)(46966006)(8676002)(8936002)(4326008)(2906002)(41300700001)(5660300002)(70206006)(70586007)(316002)(110136005)(40460700003)(478600001)(6666004)(7696005)(36756003)(16526019)(1076003)(426003)(2616005)(26005)(47076005)(336012)(40480700001)(36860700001)(81166007)(356005)(82740400003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 08:11:37.7800
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b7513b5-f92f-41b4-04a8-08dbb8e80c31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7739
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
diagram. Thus, add channel type for chromaticity.

Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 8 ++++++++
 drivers/iio/industrialio-core.c         | 1 +
 include/uapi/linux/iio/types.h          | 1 +
 tools/iio/iio_event_monitor.c           | 1 +
 4 files changed, 11 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 4cf7ed9ca57b..0c9389ad3709 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2186,3 +2186,11 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		Represents light color temperature, which measures light color
 		temperature in Kelvin.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_chromaticity_x_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_chromaticity_y_raw
+KernelVersion:	6.7
+Contact:	linux-iio@vger.kernel.org
+Description:
+		The x and y light color coordinate on the CIE 1931 chromaticity
+		diagram.
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index cba942cadf97..6dc4d2b296bb 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -91,6 +91,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_PHASE] = "phase",
 	[IIO_MASSCONCENTRATION] = "massconcentration",
 	[IIO_COLORTEMP] = "colortemp",
+	[IIO_CHROMATICITY] = "chromaticity",
 };
 
 static const char * const iio_modifier_names[] = {
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 08c20e540c13..4832c611c027 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -48,6 +48,7 @@ enum iio_chan_type {
 	IIO_PHASE,
 	IIO_MASSCONCENTRATION,
 	IIO_COLORTEMP,
+	IIO_CHROMATICITY,
 };
 
 enum iio_modifier {
diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index a63741e43ddf..5edacc358c5d 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -175,6 +175,7 @@ static bool event_is_known(struct iio_event_data *event)
 	case IIO_PHASE:
 	case IIO_MASSCONCENTRATION:
 	case IIO_COLORTEMP:
+	case IIO_CHROMATICITY:
 		break;
 	default:
 		return false;
-- 
2.25.1

