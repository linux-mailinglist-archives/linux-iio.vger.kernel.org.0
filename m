Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D6A7A153A
	for <lists+linux-iio@lfdr.de>; Fri, 15 Sep 2023 07:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbjIOFRi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Sep 2023 01:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjIOFRh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Sep 2023 01:17:37 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B7E269D;
        Thu, 14 Sep 2023 22:17:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1QsAiAlrkaovUNywC6tLiNTOHRaXHhreKvzpUTd/C+ZuCvloYUOexK36qyWqeA5QXE+0AYuPVnosBf2uwfXHjqvk+m66S4R+JDQoyaSc7Gq5e19SGlVqvE3ONGZqoGwKnbZtmKYj8UnemoRN5LRRcPdPXLkJ2afo8+XB60KMcPyc9+ThJ+ptKdXFr4vzUZWXow9mmKs0YmkT9z3096JUhyzBsqASouEJHMchFYAlI+g0JzfC7BzxebPSCdzkfs7zayPuS+N0ab8sdDM9uAdEJxqnFJtZiJBrIJdI35RJSiXN8Yg99g4SqS1fDf9b+9+7F86OkPY5lD+6Elv9jXM9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uI8srs+sArZr/wdaT3Nd3bkInbeP1Of3mNjFpuUW1PY=;
 b=JLGkwPVgLr5PHpKv5xxtqUmwKiTygGX7F0Z76VizSwTTDy8F+mI8R8u9gzTutmtXfvo0iKFlAQ3S3JF5F0BAWldiM/NA/Kodz7YRkOX6B5q0Q7VSNamFDWqumxHh5UmXTVtBiyaQdegUjosSoPm3YtH+55WEeqnXiGcg5ZSdmmdorixdLaIquYI8ShjFX9OveToQDZNYXdtp9vTEkW10+7hmg+AgJ+ZOQmTsSDFAs1H+TbHghfGHXlVpqAMNeQ4SwkqtD/QCB65lKUmvYg+ZCmvBZM4C5Y8AJB2sEfpZIXAb6X3z3lGcfcSjdOt8ELvLDZDyMH9rop1x2F9CxgX84w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uI8srs+sArZr/wdaT3Nd3bkInbeP1Of3mNjFpuUW1PY=;
 b=mS5Y9zI9PfNhBoWZOVY+Ngr5rZpgzxtfpqlL5WKHVUY/DBHB7JbWeNADmiXbbBCHWtx3dyA8P3Va1jXciGWa8oTvD3aOk5sl5LaXD6GKRgRkzRc2wuyZdKF+yNVqF5z60yM0gK1HK59mzlzsViHcg0Y1tRA3URkvddY4LLxwC5Y=
Received: from SN4PR0501CA0117.namprd05.prod.outlook.com
 (2603:10b6:803:42::34) by PH0PR12MB5483.namprd12.prod.outlook.com
 (2603:10b6:510:ee::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Fri, 15 Sep
 2023 05:17:29 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:803:42:cafe::13) by SN4PR0501CA0117.outlook.office365.com
 (2603:10b6:803:42::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 05:17:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 15 Sep 2023 05:17:29 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Sep
 2023 00:17:26 -0500
From:   Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To:     <jikos@kernel.org>, <benjamin.tissoires@redhat.com>,
        <jic23@kernel.org>, <lars@metafoo.de>,
        <srinivas.pandruvada@linux.intel.com>,
        <linux-input@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH 0/8] Multiple light sensor support 
Date:   Fri, 15 Sep 2023 10:46:55 +0530
Message-ID: <20230915051703.1689578-1-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|PH0PR12MB5483:EE_
X-MS-Office365-Filtering-Correlation-Id: d358f8bb-364a-47b4-db22-08dbb5ab0ea9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +8WJ324CPDKtyHklYydst7UaUO1wPZHn3sCebf49GFv2tpZJi7NhuJ6fflDkwxjVlhuKrz+B8zUAPe/EAtZ/SH3twqIVPnE5iuBnCsJgv727czHPs2q5pd/f5wx/4bI8UYt4nH4LvoSp4DcTa5ykHsikBie1PlYx3UsiNpZz1F2jD0/XTVmfCfpFMVnMQJbx9xsyS0qGDt/2QpHI8mMIkJMwfbdlrNgy9xMuIVY8ETxR/dBdMtrSUhZi+rZ7ug7KhjruYJgpm+ZmQ8bqSr+RHBP9PHM+aZ3G1dQvLMA1Df37aAFPMRIcER7Y60t3qJERCpMmfww1TBIIrNQ8Vt07GBCmRC6H8BKtn0m5XRnDVgMZL/Rbin2llqM2oC1w3ICmvoS8JWlxre/baAoMA9PglywqYRoF7MAnkHLAmp/4W9V2FLIQkgU1M5qfpC6SjzDcmkhHDT9M0wRIiS/clyAgona7u1cuH6bZVXT0LWnGOYdH6E9TQm2UyAWXDmdndbWg1UNPNdZLRjT/JnvbN9GrbpxGPblR21a0FC1Ww0jX9XmvwcwrSn72qhlsPP8QHNkKylCHoA8z64AVE39LrFdaMO6GGStTNGp9pS0MjdY6mThy/xTB8TSvF9/BjtI95XXEXeH9ob0ExVFVC4cXEBTLvk+hyCvlH+Ofkxz6FemAzKmLW0fTByJnaQrzBGH0pEBcoL3AUNV6bmE9yM43ixJnG8vEAArNriiUhSZpBUZGO+1TQZ5X0szyeyd2/J7l0KAchCttXRyEMfNk1GFVOjYLQg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199024)(186009)(1800799009)(82310400011)(40470700004)(36840700001)(46966006)(336012)(4743002)(426003)(2616005)(1076003)(8936002)(4326008)(8676002)(16526019)(26005)(5660300002)(82740400003)(6666004)(7696005)(83380400001)(47076005)(41300700001)(36860700001)(40480700001)(356005)(81166007)(86362001)(2906002)(316002)(110136005)(70586007)(70206006)(36756003)(478600001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 05:17:29.2479
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d358f8bb-364a-47b4-db22-08dbb5ab0ea9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5483
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This series adds support for light color temperature and chromaticity.

Basavaraj Natikar (8):
  iio: hid-sensor-als: Use channel index to support more hub attributes
  iio: hid-sensor-als: Add light color temperature support
  HID: amd_sfh: Add support for light color temperature
  HID: amd_sfh: Add support for SFH1.1 light color temperature
  iio: Add channel for chromaticity
  iio: hid-sensor-als: Add light chromaticity support
  HID: amd_sfh: Add light chromaticity support
  HID: amd_sfh: Add light chromaticity for SFH1.1

 Documentation/ABI/testing/sysfs-bus-iio       |   8 ++
 .../hid_descriptor/amd_sfh_hid_desc.c         |   7 +
 .../hid_descriptor/amd_sfh_hid_desc.h         |   3 +
 .../hid_descriptor/amd_sfh_hid_report_desc.h  |  21 +++
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c |   9 ++
 .../amd-sfh-hid/sfh1_1/amd_sfh_interface.h    |  15 +++
 drivers/iio/industrialio-core.c               |   1 +
 drivers/iio/light/hid-sensor-als.c            | 124 +++++++++++++++---
 include/linux/hid-sensor-ids.h                |   4 +
 include/uapi/linux/iio/types.h                |   1 +
 tools/iio/iio_event_monitor.c                 |   2 +
 11 files changed, 180 insertions(+), 15 deletions(-)

-- 
2.25.1

