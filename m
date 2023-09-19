Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FDA7A5C15
	for <lists+linux-iio@lfdr.de>; Tue, 19 Sep 2023 10:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjISILk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Sep 2023 04:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjISILg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Sep 2023 04:11:36 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A4B13A;
        Tue, 19 Sep 2023 01:11:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rdp2EcccVG8kPWDW6wbvNTdJ385Y+Wp8nNlQb8fYkvCLWCIrfBrnsGt+Ljnc6qvOxMLfwM1ZAMCpYSX/4fioXw2yuEYGRnEJhcbpkFNww5o3Xw0YY+3c/Kpf7dwg2+K+qppx3w8BTn7/hripFQBsu3cthvjCmAHHwB2gUwfJOCJ5vM9FAZZ5UYzfJLYAJ1/22kXEaEUCK4DkbiJl3FzzztRXgqXrXnmK4e6HNwpWx/0at+FJmH9SmEekKM8yyurRczFuJXvtAie+Fv30NTBtBYdl0iyZu9+hr78k93PD+TWtQTjbsJhkUnZ1gopRKR8KVWKgCkf3IEXOFGA9OZCK1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AUzvzZBNARuUcuP2tJ4cRDjF1KyeW11DfvzuR6pJ5VY=;
 b=nYv3UUyDxETaZea6NfVqdn4cRVSKO7VgcwGLZGIxzXZfdvBxS4zS6yavMoAqckLd8ouakWerKFY/1HaTsdAuumhHd1RDhux1ZKB4QsN/q4BHeGa7MgX6rJDOFGRlZ9xXTGVCZLQWBMa0DNifpWVF+cIYTPLeRuoewppagrDhrM2rslblIiTIWSI+X41LihS3uqIGBfiAsTQXXCpvnNMyY9oOwBzziQdx8TJmn3AMqr5pgxaHzoIGcVjZFgwb2Zxq9KchKxSuWlWK2f2FWTIkCFp5Ck2tOmcbnakhqxv+dl9B9zI+OFIbOYpZYLDaQNIqBdCgizZp0ha87QFdqPbd0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUzvzZBNARuUcuP2tJ4cRDjF1KyeW11DfvzuR6pJ5VY=;
 b=sdbW6VlsQUhinkEJIjG/c6JG/wLhNBrNQEGF2cz1dFs1JDm9VpOAsK49IQcsICP7L5ALxr2croRlU5fGaoVoRPPYdZ7E5vWQEWmdcnyAXUyXDdMlMjnl/DUv//ZMZ2mRjBViw//QYKaiOnDiGRfZgxoqcC8ODBmjkixj21xon+g=
Received: from MW4PR04CA0167.namprd04.prod.outlook.com (2603:10b6:303:85::22)
 by DM4PR12MB5357.namprd12.prod.outlook.com (2603:10b6:5:39b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Tue, 19 Sep
 2023 08:11:26 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:303:85:cafe::16) by MW4PR04CA0167.outlook.office365.com
 (2603:10b6:303:85::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28 via Frontend
 Transport; Tue, 19 Sep 2023 08:11:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Tue, 19 Sep 2023 08:11:26 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 03:11:23 -0500
From:   Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To:     <jikos@kernel.org>, <benjamin.tissoires@redhat.com>,
        <jic23@kernel.org>, <lars@metafoo.de>,
        <srinivas.pandruvada@linux.intel.com>,
        <linux-input@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v2 2/9] iio: Add channel type light color temperature
Date:   Tue, 19 Sep 2023 13:40:47 +0530
Message-ID: <20230919081054.2050714-3-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|DM4PR12MB5357:EE_
X-MS-Office365-Filtering-Correlation-Id: b73f5a74-3203-44c2-945a-08dbb8e8056c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2DxIvdJxRUJu4FpIZv/8h/k1KX3WGYHkQInszNRvgQTlszkdWqPISrpCS/ExVEwPT/vM3SCqILCBmhWlna2QuGSvWTkxg48IVe/DFUCQEyuJrelT1/0CUz10pzceZc3e2vCNnH4b7YxwsZckWQ3c2U9DegjXlGYgmyG7mC3/cTnltCDyAMSWaQq3RYA3GlwzOhXRKJLnhEsxA5wJMuIvJNm5eWUUJYY3/g6w3XGtdru/8o7HptGestktCdZnW8rRE25PmYAldse2/dsCQsLX7v1HrgJfqaQRTtax+NsUUA1xpuc6cdF2LydluJe7LxuMLaUj+IVsCK/qwUE2LcIu7iomj/DVncJu+EK7mfJ+TTogfwlP6eiLPthioepbxsEjNZXqlbAq9a+O/0/W7cxC2zCDuxzTeMm3WXQ7RyP5NR6zIAqBKZcp6BxRjsmilieUurPyAEhaxx3o+Et/49waZ4OwYXCuivYgxHp1G2jvyXjRTKW0pZWmViZlNeahMVzvJfbm67E/RZAM1DdV1ybBebCHl3NwJSb1t3cBAZ09+kWGWA1oTaepzZU0v4n7e0VU1eGQKCDHk2zEEv4CfJqAI9xepJIyuObh3n5sqDak4i34kVIqF55R6ZqS6CBBQ1j8IkQuyBlLKlIVBC1PCRqZBhJAgMlTy3KDnXEHR4DcImWCW/0li6p5k5GF9UGKFMYiJ5JaQ21v6Rlz/exQmTpRbrCRNgMC4/zo1KlbFTtV6xO3c6CiiwpyAWeZ/B/q3hwpt9EWBhMbcSpdDoLgCbsgmw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(82310400011)(451199024)(186009)(1800799009)(46966006)(36840700001)(40470700004)(40480700001)(81166007)(82740400003)(36756003)(356005)(86362001)(40460700003)(478600001)(70206006)(70586007)(2906002)(6666004)(4326008)(8676002)(8936002)(7696005)(426003)(2616005)(5660300002)(336012)(1076003)(36860700001)(41300700001)(316002)(110136005)(47076005)(16526019)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 08:11:26.4576
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b73f5a74-3203-44c2-945a-08dbb8e8056c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5357
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In most cases, ambient color sensors also support light color
temperature, which is measured in kelvin. Thus, add channel type light
color temperature.

Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 7 +++++++
 drivers/iio/industrialio-core.c         | 1 +
 include/uapi/linux/iio/types.h          | 1 +
 tools/iio/iio_event_monitor.c           | 2 ++
 4 files changed, 11 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index a2854dc9a839..4cf7ed9ca57b 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2179,3 +2179,10 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		Number of conditions that must occur, during a running
 		period, before an event is generated.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_colortemp_raw
+KernelVersion:	6.7
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Represents light color temperature, which measures light color
+		temperature in Kelvin.
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index d752e9c0499b..cba942cadf97 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -90,6 +90,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_POSITIONRELATIVE]  = "positionrelative",
 	[IIO_PHASE] = "phase",
 	[IIO_MASSCONCENTRATION] = "massconcentration",
+	[IIO_COLORTEMP] = "colortemp",
 };
 
 static const char * const iio_modifier_names[] = {
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index c79f2f046a0b..08c20e540c13 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -47,6 +47,7 @@ enum iio_chan_type {
 	IIO_POSITIONRELATIVE,
 	IIO_PHASE,
 	IIO_MASSCONCENTRATION,
+	IIO_COLORTEMP,
 };
 
 enum iio_modifier {
diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index 0a5c2bb60030..a63741e43ddf 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -59,6 +59,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_POSITIONRELATIVE] = "positionrelative",
 	[IIO_PHASE] = "phase",
 	[IIO_MASSCONCENTRATION] = "massconcentration",
+	[IIO_COLORTEMP] = "colortemp",
 };
 
 static const char * const iio_ev_type_text[] = {
@@ -173,6 +174,7 @@ static bool event_is_known(struct iio_event_data *event)
 	case IIO_POSITIONRELATIVE:
 	case IIO_PHASE:
 	case IIO_MASSCONCENTRATION:
+	case IIO_COLORTEMP:
 		break;
 	default:
 		return false;
-- 
2.25.1

