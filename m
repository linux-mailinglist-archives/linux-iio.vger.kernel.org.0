Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7288F7A5C11
	for <lists+linux-iio@lfdr.de>; Tue, 19 Sep 2023 10:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbjISILe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Sep 2023 04:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjISILc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Sep 2023 04:11:32 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9AE187;
        Tue, 19 Sep 2023 01:11:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QW1uwLFy0Hso8Dk8KSsfVj+TM5TSjQJUSXo54GGuXHjVFiaj6aJrgtzBrKL5JO2RvMNyA42EK5KRm6pXXj7ecZYb1rmXMQBjjajL74URjzRRp7DCEW4uGTg2S1G93OkWU7JJvdfDMA7RpJtErQg/UufZNIJaw2r9GtMUOVgOOYXvbcJn+X6nyiYnWN6EwvypOrYHP4ZV71nJLAurVov1XarHdVkOc+rgcyFnDXX1QdU55MRSHnkTnCA9C0A0Y6MA7Zmw1dF/kzbZl0wlZlnIwfuKWYDRo7ksqNRD6LbSxN3Txg820kEoW778TNLrF0xCFHhJxRnrYTBwDysSHHhUxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VLHIxE9bbV01nNF7xIOrzehU0872mlcXV20+xr021KI=;
 b=YKFZCxH5QkK0gaODPsYv828m3nEhO+3TrBXim9Of2HLur/9b+/TgoF9G0aA3orjya/YdPxbLki7dLDJMF3E9oINsW/SdJaN+UNpYxVJKKwuEMh6X7b5EY1SVvaCHNXXumWYlnyZtmXinTHygamU30IClRWlZc5nfYJCbmw9TFz06ovJ8VonuEjIryFnNt3s56l9Q8xjXdlHXv7mb9Az60HlogqwANCyRHWfY15nAYFchEPDGW3Oj3DG2pR7gvPhZHK9YjxMqxLRC9coPd95+fZGQQyMkxRRQVzzLsNPhb7J7W8vYspCTTvdpF2ZoecZZfWEewDqYM/m71xomgIlR7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLHIxE9bbV01nNF7xIOrzehU0872mlcXV20+xr021KI=;
 b=W2hnm3AnehdF3PjlmEAuKQz1Cppf8Npq+1bJaxwZLxHZj/bJrNxR9IIe4jZi+rLWtHDn+/wibDqrnmGvLWsbj8OcbNBmei6bVFOUCyLOpzBG9+fHefPXm8x9t/KIJ86BPDb615PzzRY0jhfTWadATTBQfMfBZ/D0pMeFJxlYmoI=
Received: from MW4PR03CA0040.namprd03.prod.outlook.com (2603:10b6:303:8e::15)
 by PH7PR12MB5654.namprd12.prod.outlook.com (2603:10b6:510:137::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Tue, 19 Sep
 2023 08:11:21 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:303:8e:cafe::e5) by MW4PR03CA0040.outlook.office365.com
 (2603:10b6:303:8e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Tue, 19 Sep 2023 08:11:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Tue, 19 Sep 2023 08:11:21 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 03:11:18 -0500
From:   Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To:     <jikos@kernel.org>, <benjamin.tissoires@redhat.com>,
        <jic23@kernel.org>, <lars@metafoo.de>,
        <srinivas.pandruvada@linux.intel.com>,
        <linux-input@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v2 0/9] Support light color temperature and chromaticity
Date:   Tue, 19 Sep 2023 13:40:45 +0530
Message-ID: <20230919081054.2050714-1-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|PH7PR12MB5654:EE_
X-MS-Office365-Filtering-Correlation-Id: bf42fe48-c88f-4aec-6dd1-08dbb8e80237
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AT/UB3OT0cDKTGnpZkJHZL74u/KsiLr+FU3P7EkVhA/s3J4rP6GGy9kHea6sPvRWUXLXoblxQAEgICj0wTcQU8M4Fe3umNcPONmzLPeBLy6ZeR8K4FaMZphl9owTlEy3uLiYECQPOQmcLGzbel30liJlJ9Pq3sbRk+/dgDv5MqQywe+Zf+yqPPAtkaG4RISTgX3cocNkYZSGGVqNQ0vfUM31PqxrdmzkO16Lio3NmlYIusqq4f3lx0g8TG++iUNVHkidtlhtF3R8aKpmlw3wvclIGdbFx9khFww+1A8RcMjAtDdcYwFS2j4otUf53aroRGmwahq+J8uv0WOpBO2AF1RfllaNYOTJMqF+QXHEcNveFP59XjCHrbKcYv1iTjjab3dZxAUzzX+8/k4cPQpy5OMWbrbaNbpTxoNCrNVxlK2xUPbm2qjheCK+I7lhAgjg7XZbPIyKwFjbmBDEnPS8sOr9d6QMLZ4JN264rnFkKVAvb6DJgScefSa7ZSi9JOCy830n+/4ZxoJQ+0ECUw4/eYJcB7rOaaIdI/DgFz9O9vwXfjSJEpl7StLhJwbuQhhEjHnMrqXRNlh5NzwXNyGTA52KZxalYZSUS68BnWsKzcU+neWlWEPKX1daFo8sIBT8+8EE7KSYGLKFPCllou5iODyAmNSCmHZoiExo2TquYuUrzuEAjf26IWxyB8WslMM/WZ2GG/djtnE+kzbmf1l1IX9xnJJzhBqfr8HZKxdHxcBVlJnhsHyJcen95y5IILq74avHA8tI0JFBJhLdyhnEFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199024)(1800799009)(82310400011)(186009)(40470700004)(46966006)(36840700001)(40480700001)(7696005)(86362001)(316002)(41300700001)(70586007)(70206006)(110136005)(6666004)(5660300002)(478600001)(2616005)(8936002)(8676002)(356005)(81166007)(26005)(82740400003)(16526019)(2906002)(36756003)(36860700001)(336012)(426003)(47076005)(4326008)(40460700003)(1076003)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 08:11:21.0761
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf42fe48-c88f-4aec-6dd1-08dbb8e80237
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5654
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This series adds support for light color temperature and chromaticity.

v1->v2:
*Rename the series.
*Rename als_illum to als channel as it supports other channels.
*Update patch description to include same reading for the two existing
 channels to use channel index to support more hub attributes.
*Keep line length under 80chars in hid-sensor-als.
*Add new channel type IIO_COLORTEMP.
*Update patch description and its subject to add channel type for 
 chromaticity. 

Basavaraj Natikar (9):
  iio: hid-sensor-als: Use channel index to support more hub attributes
  iio: Add channel type light color temperature
  iio: hid-sensor-als: Add light color temperature support
  HID: amd_sfh: Add support for light color temperature
  HID: amd_sfh: Add support for SFH1.1 light color temperature
  iio: Add channel type for chromaticity
  iio: hid-sensor-als: Add light chromaticity support
  HID: amd_sfh: Add light chromaticity support
  HID: amd_sfh: Add light chromaticity for SFH1.1

 Documentation/ABI/testing/sysfs-bus-iio       |  15 ++
 .../hid_descriptor/amd_sfh_hid_desc.c         |   7 +
 .../hid_descriptor/amd_sfh_hid_desc.h         |   3 +
 .../hid_descriptor/amd_sfh_hid_report_desc.h  |  21 +++
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c |   9 ++
 .../amd-sfh-hid/sfh1_1/amd_sfh_interface.h    |  15 ++
 drivers/iio/industrialio-core.c               |   2 +
 drivers/iio/light/hid-sensor-als.c            | 130 +++++++++++++++---
 include/linux/hid-sensor-ids.h                |   4 +
 include/uapi/linux/iio/types.h                |   2 +
 tools/iio/iio_event_monitor.c                 |   3 +
 11 files changed, 195 insertions(+), 16 deletions(-)

-- 
2.25.1

