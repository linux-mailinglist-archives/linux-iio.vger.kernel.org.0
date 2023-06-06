Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BD37248E3
	for <lists+linux-iio@lfdr.de>; Tue,  6 Jun 2023 18:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237495AbjFFQWo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Jun 2023 12:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbjFFQWn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Jun 2023 12:22:43 -0400
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F5910C2
        for <linux-iio@vger.kernel.org>; Tue,  6 Jun 2023 09:22:41 -0700 (PDT)
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
        by mx0b-00549402.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3568m9s5005040;
        Tue, 6 Jun 2023 16:22:20 GMT
Received: from jpn01-os0-obe.outbound.protection.outlook.com (mail-os0jpn01lp2111.outbound.protection.outlook.com [104.47.23.111])
        by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3qyxvgj55s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jun 2023 16:22:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KNidBLWKOD3Z0tGdijz5QoVtTpJirogEhv87YFAWmq5ID+VKu+SCzLqBbgMnLUjfvG1oJbT8dZCYC/CoewpWUrju3AL+K6GXnbKXGpVTdVyZBtw380IKr31z84UdDKZ421alSX6H3GIejKmAX2T749WTdH0CyBjs1RZqynYirlI9uDOfzREClHfW/g1gQYemMDiQojl6nuKjY7k6Q+vzUddjtcj8qg+Y75Z/lM6+mwwX0j99uT8ICPKStSXOAJbbym2ZQ0WwVZfEQ8oJq3nzIafqiR+wIPSE+MTujLY01Jp6f49CBwZa1EHLCOuHjldkMmPSmdPQg3IokPW4ZWQWrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=avUz9hhH1hP9ofWwNwKMBdocHU5FFUu5eRfREEeh2ME=;
 b=cdo5QoOmdzLdAo4pkkPpjsdYNzBmNyAx85zHF4gNJUq3fXkoVFJMw4jUpxOK1YpX0wFJYKPKULE5bPXQvw0YcIFjOfRU7dt+pc8p4aI9PFeLRJgnxJkDiRDqLkELVplcDOSBAD5zEHeZK5MDDPFq5PTcV4BWxa2/TblCa1H9k1rtr/CLIZ7LUt5O0omUsplQbQURSOGwm4+ojTAUDyf92hGZ9Pfci0VYtuKgyEw7CmMN97k2KLGaggn8TTUel1Jzugt38sBNA1Jol0Wc5Z//fgSuAat+TgcGceoPZZbU4851A11vugbeopJDsQo5HSJBcMd7KOCMAqd1E0rgT+eYXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avUz9hhH1hP9ofWwNwKMBdocHU5FFUu5eRfREEeh2ME=;
 b=qjICUd/eyB8Rs+rE9F9QSV5/g6g8VCSDQ2XDZdVc1BxRXiy2sEecWU5et8pG4ryrvcpDUktMYPWFbjwUNsCrx6T46uw5k3Geij61piCG6zM0V4Uh39Qcyrkz65DfOl67sRJqn3F0NccidAnnYdERuiBq+RHfZopoJKezHHvfsT0mh3ghjkx4rCJFnZvJ7PsGjLa89mi/HIDv1A3SF4ORgAJuqA12R2+VRauhanjtKg2AwYjCq2pBQyolZ17ypzX3X6BPtc76vZhZwQ8DlvQl06yBq6QRowDyo6N1/mvZqLsAK/zHRfV//aEjNI39jqh4/uc01GIRGtrfQJ6Gqkr0sA==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TYCP286MB2179.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:15d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Tue, 6 Jun
 2023 16:22:15 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::60df:b013:2731:f9c1]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::60df:b013:2731:f9c1%7]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 16:22:08 +0000
From:   inv.git-commit@tdk.com
To:     jic23@kernel.org, linux-iio@vger.kernel.org
Cc:     lars@metafoo.de,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH v2 0/4] Factorize timestamp module
Date:   Tue,  6 Jun 2023 16:21:43 +0000
Message-Id: <20230606162147.79667-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0212.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::32) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TYCP286MB2179:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a1972aa-ccb0-40e0-cba9-08db66aa2ba8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WMtkdtZb8YtSWioDtadVFXY1W9XtZsQptu4h5/e1AZ9p5PxlfiliPA/56nubGp5W6aV/+UYeuEWJwFbn2Hr23Z8mPU/c6YFkGZingQAd+Wu2pVSsXoHNDuzFQyGk2s2sLS6YrnHvNAXcOBDEeH5yJeL6Flr9vevaJAAieJRX45gQY0A8sREB3X/lwOIgbFgi3n6tuCfGgbT50OGucVJMZbE3eRZnXnm8oB1sPMRd/EWCS/iYYK+YbhihBAGJUxMJt6+XV1XnK63AMqTXNKT+8+Po2mrz60G0WNQQFL0UwYPxnwTKkfnftZEwA74+h2c+C2Tqqm8qaWeth4j5KWHmDJutj5acv1yk+EApdQNV1R9ExPTi0wk6zTo4cVdzYEt2cB70RUteQidla2ea8mCPVzEMtjSn6RVHy12ohSwfs6e+9AviqPabe3PZCN23qLVSOmKpqbR/JaZdTu9VJgmZfuqLBmbTQRre+wum1wHDoIVxpbs9R9T1HAoWnXX4ctzlR4LmJFaxHUM05ho95P/HmskSRg1ViAK/Dw4MiW++op1Cygs5fPizozYrOyfrBHTylsz0AtfqpQpXlxwX0LX9Aqy/XfKovk6Z31Kgw2fDChYipdyV7xrbRwjbucoVdfbf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(451199021)(36756003)(478600001)(5660300002)(6666004)(8936002)(8676002)(316002)(4326008)(66476007)(66556008)(66946007)(41300700001)(38350700002)(38100700002)(2906002)(1076003)(26005)(6506007)(6512007)(9686003)(86362001)(186003)(2616005)(83380400001)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vbxy2v3bTPrU2AmN+VdBwwI7n1HPQomVzRnJf6f0J8C88+/EoC0cX9ZXOy3T?=
 =?us-ascii?Q?gL/XvYDrJutJaogx0PElpFZiIeMEF65+5vRrlTKkzHu0YAbX80STeD4snznW?=
 =?us-ascii?Q?319LWh08Wa6lMAq61DtJ1J97LaVvozjQ3xd2sOJNtkGsIw8BMXLfRJuhIA75?=
 =?us-ascii?Q?/8Sm+Tgmwg8YbAH+2FR/Cue7J+hOQkWZNx5UIoJ8hkjX4NI48i6D01mEakAO?=
 =?us-ascii?Q?6HMvSS6EBEiriWlS1q/5kRClI1J1LeVKi6xQbOlxYs1KqVfNfxcw57RySAMu?=
 =?us-ascii?Q?KQXVQ/CeqESBj9dImvlVVI81BpzzqYZwo9YhrqIpSW+D0yyb3PV4RUHJBjcx?=
 =?us-ascii?Q?2xZEgJgbzcCXR2jRDlq7U0R2zbuwJmKNGsAc50OtDrGdiS4jIO09Xa4Ob6v6?=
 =?us-ascii?Q?mKvhxPGSIxJBIspOVp6jQUR4x9M8vW+kGt8zpzIxpMaZN6nJgU/gh/ohCm/P?=
 =?us-ascii?Q?hSXo9srZojgJGfKxAvoV6cvzoRL+6JwD/YIaBuPbbJq5TAxlPPkxoLppDny5?=
 =?us-ascii?Q?ue5B2qRrz1sfPC54cGOo7sd48vqz6AyEB9e+wRQGx75X2JFdx4Iat62HuxKb?=
 =?us-ascii?Q?k+o8A1wYtFxcURySmyIRrg4qCUD0Idt92sqcQK4mOrsmyK+NO0vZKr4UpSfi?=
 =?us-ascii?Q?9UKCM8Tz3G4miEiU7FBbU14NZHFFGvniFoIfJmOoNH1e7ixwpvWhQBhmamLn?=
 =?us-ascii?Q?syDxgYRgX+7jKhex7vn3INnuCEagAC+3p+aIfj2Uq7a/zdncAVb4tbGN38EF?=
 =?us-ascii?Q?Ad/MVVd9VjgY1waMJ1RStOhb2yiMqL/7UlGVR1dmCyaVq8ofTTH2nLJnLx+l?=
 =?us-ascii?Q?0pUnOdFD7dDQg859te5CcESaU3rsCIsCRG9l/K5BPltmomzpusF2wZiR6zyP?=
 =?us-ascii?Q?dIW2IAOINJ+SSsQ5GJwsWzJD0vSisOnvosb5InhArzZFR0a/jKx+agz18CIu?=
 =?us-ascii?Q?nHkZDT02xlZKtlEPCUNX3LwcFo8rqotdHmbWYLHAcJLPszOYtIO+KHSAZHVC?=
 =?us-ascii?Q?Rx0pWw4vH1vKyeimJl0AdFJjghWGo2CAkYEi6VtDLmiPGHpHOH3vQmsKP/pL?=
 =?us-ascii?Q?79TqsjuIvaoS+eyzSEP4JJwl4H+gM/rfngCYAJ8VdfTOlFd5boMyc0YVWYBT?=
 =?us-ascii?Q?QORkURLsb0GtYLAeDUrAfHtNXosj5kM+tN9d89Ph17+Ssly5/Xg8n0+pKnbt?=
 =?us-ascii?Q?OCy+O+G98uyBrGCuOodoU4s5n8G3yMpfbvY8aleF0Ri5KG5Xloh2XEZ4LUC0?=
 =?us-ascii?Q?KBeD5GKmUw5r0csukLj1XuWCuEuqG8b821ggQ5eKVLaBWAOnNiNsv2MBkHad?=
 =?us-ascii?Q?ggCgLae/vPjtjztcSwRFXn0el9AA90ccNeQqjdQDiujE4cuSOrsBHaxh8ysb?=
 =?us-ascii?Q?NC4HWQuj4QwXr8oERVKVB0K3Zeo+BhepPmcO3DCxUMLHLkMCre/CPJDcHVS5?=
 =?us-ascii?Q?mGYi/rcPzu31vKXcr9keAdFAJINsM5gpNKxLCNHTZtfAszKJQgxvASfWdgAn?=
 =?us-ascii?Q?LtwqjC/xYbbifvnTEfDc/sNXH3/Hf/vkVxK/3VwKzWYQJMGjVJOpDagW48E3?=
 =?us-ascii?Q?NH4HptE/WpIse52k8GwSy3yCr4G8ECojU1G502i8?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a1972aa-ccb0-40e0-cba9-08db66aa2ba8
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 16:22:07.6854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bAjksc8xWazS7emnxD+hSJGwHka0G1qlJvMq8EQNcm9Mw3T+Q/Vg2FJ6volvhs7p7QtGq3VaXft4HYx6jWfOOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2179
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_12,2023-06-06_02,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

The purpose if this series is to make timestamping from
inv_icm42600 driver an independent module and use it for both
inv_icm42600 and inv_mpu6050 drivers.

Create a new inv_sensors_timestamp common module based on
inv_icm42600 driver and use it in the 2 drivers.

WARNING: this patch requires following commit in fixes-togreg
bbaae0c79ebd ("iio: imu: inv_icm42600: fix timestamp reset")

Changelog
- v2: do some headers cleanup and add some justifications in
      the patches descriptions.

Jean-Baptiste Maneyrol (4):
  iio: imu: inv_icm42600: make timestamp module chip independent
  iio: move inv_icm42600 timestamp module in common
  iio: make invensense timestamp module generic
  iio: imu: inv_mpu6050: use the common inv_sensors timestamp module

 drivers/iio/common/Kconfig                    |   1 +
 drivers/iio/common/Makefile                   |   1 +
 drivers/iio/common/inv_sensors/Kconfig        |   7 ++
 drivers/iio/common/inv_sensors/Makefile       |   6 ++
 .../inv_sensors/inv_sensors_timestamp.c}      | 100 +++++++++---------
 drivers/iio/imu/inv_icm42600/Kconfig          |   1 +
 drivers/iio/imu/inv_icm42600/Makefile         |   1 -
 .../iio/imu/inv_icm42600/inv_icm42600_accel.c |  35 +++---
 .../imu/inv_icm42600/inv_icm42600_buffer.c    |  33 +++---
 .../iio/imu/inv_icm42600/inv_icm42600_core.c  |  14 ++-
 .../iio/imu/inv_icm42600/inv_icm42600_gyro.c  |  35 +++---
 .../imu/inv_icm42600/inv_icm42600_timestamp.h |  85 ---------------
 drivers/iio/imu/inv_mpu6050/Kconfig           |   1 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    |  30 ++++--
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  18 ++--
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    |  83 ++-------------
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |   6 +-
 .../linux/iio/common/inv_sensors_timestamp.h  |  95 +++++++++++++++++
 18 files changed, 278 insertions(+), 274 deletions(-)
 create mode 100644 drivers/iio/common/inv_sensors/Kconfig
 create mode 100644 drivers/iio/common/inv_sensors/Makefile
 rename drivers/iio/{imu/inv_icm42600/inv_icm42600_timestamp.c => common/inv_sensors/inv_sensors_timestamp.c} (56%)
 delete mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.h
 create mode 100644 include/linux/iio/common/inv_sensors_timestamp.h

-- 
2.34.1

