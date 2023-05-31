Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747407184E2
	for <lists+linux-iio@lfdr.de>; Wed, 31 May 2023 16:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236112AbjEaO0a (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 31 May 2023 10:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236419AbjEaO0Z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 31 May 2023 10:26:25 -0400
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F5E19B
        for <linux-iio@vger.kernel.org>; Wed, 31 May 2023 07:26:07 -0700 (PDT)
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
        by mx0b-00549402.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VD5Ck0030918;
        Wed, 31 May 2023 14:25:43 GMT
Received: from jpn01-os0-obe.outbound.protection.outlook.com (mail-os0jpn01lp2107.outbound.protection.outlook.com [104.47.23.107])
        by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3quanmk3c3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 14:25:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/qxaadomoSd7Sr74wka98QqWCQP/cmROABwmRuoSCiLAwyp3VsCc0+OLDAww5kZD7xbVBlZItrxFm6VZvQlGJHpoAcJFFuLPBBFd713y5ybBX0kOkBc6Y1dA3lx5O0acTlkofZ3AsmCxFKpjD8qiBjj42dOrL/eQvSLcpVJ0dpxL9sW2F7Aq/cGA+kNZBXNJIQveWy/6PYuqdoEA/BrD9cwtLsTCLevbeT/qIuUDs9GAwMvvC9Xql4jqH92Q1e+tWG7n/Vv1s1E0QtGufaSCLYumTRTU0f8X6Et3xeSLMziGzo0/mdV4jg6lKq/tgKpWfuyxrpbgP1CjU4qRClb3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VnINkVu+AoYSxCAuQs0JG4WNYUPsYpW5nicujF1wB94=;
 b=aJVATVSMK4NlpeFI6Xn3hO0zc76T0It6tAQcKFBtWaMrG5I5VZCwJJYDyQuVnPXNobERo/0eLx/KRLaYzFkxipcmb4N1UI1b3lATNGGxGaVWDoMm9vb9Ue13KBwCxiQDZPEJ69DEWVi15en1LFvXzWKAr0WSX0j94rdtGqH+qiZIlyWcuG/0riU97wLngfksvzBq+zQd4cnT9cCeBNn11V2TWj+eZi96duGE8ZtPy9g2NsZz2UJTWCrEC3PTuEr6iPFGt1X5TV5tfaYd1gclFZAA7K5g04LiKTgdIQpEMO1TCTmgmDFdi3AwENHqJMCkWOTnYMtoDucBj6nH1rUJQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VnINkVu+AoYSxCAuQs0JG4WNYUPsYpW5nicujF1wB94=;
 b=E15Ilg48ta65Dcz3IH4EH62ueqNiQYUNjNemnMIiDPjfIgpRR5X8A946kHiA01F8QE3GLU0ZUVE6z/6olbHEvawZI6ttNScgi9bzhyb/PCAQRO+0VKQLZEM9ZWHogYSjWpD38oXO4OjO0y9uWceYONI2DsUQlwupmEMapCQrLYvfRjT58T0ZWu4Ol60HImpmYMUoLWJ9Not0U9D+sbC5qL6xGL6vIrqRSTdGNvWa2+ZE4MZMNbawjXr8RxmMCOxk5IPY7MKFFWaAWkAMpOCMJkVEDTQGwFAFKnfsxXLwlwmNfTD8JJN3DV7+/cwMFX9mKxfgj0Ny4tikfTXn4W3Afw==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TY3P286MB2785.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:250::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Wed, 31 May
 2023 14:25:41 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::60df:b013:2731:f9c1]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::60df:b013:2731:f9c1%7]) with mapi id 15.20.6455.020; Wed, 31 May 2023
 14:25:39 +0000
From:   inv.git-commit@tdk.com
To:     jic23@kernel.org, linux-iio@vger.kernel.org
Cc:     lars@metafoo.de,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH 0/4] Factorize timestamp module
Date:   Wed, 31 May 2023 14:25:09 +0000
Message-Id: <20230531142513.48507-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO0P265CA0007.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::18) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TY3P286MB2785:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f5de25c-f449-4c79-2a34-08db61e2e823
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +lLruSqQ4V+Lo/eU71adj9d9+9xRCb+DeeZShVgiBVsMj8NAVnq5s4tRjBCxdFsp4/mIz7MioFId4CxGuLrranRGyTDTa1rS5/emhJBrV3g74c55LvHelTWeUZJO5MBe6RqLcuRAEKDiJ5xJOneAlmEiQTbOd4BgI82M4OPjdcVhgnTB5Y+x/ankmwI5PWa+ggumN3udwtLePuRUkhYf1ePLdiPyZd3RKBFACf8YDXNXn6d2WBhnvKuCG72tfGlJgmsXJRKmIzaR3J5NJ1WBpbUqzbg5uPw7jZw1piFz9V9LLdP/Y4q3IGpFsspC09XDyiTESHh18m57Z847Et5EbuDzPrh2x1QdJ+NNHXL7SMAmvf04hV9f26ZK1Hj0gxFzC5AxDuegRRw1ILzM3tTSnIYDUEXogy2/Ps/Kzo4RQ2JwvMLHxfq3o+6DAm5El1HxNAL3QTG7LZwm5yl9kLYPiEw+fTfdkbmuHdIpAQbr6rB48IftxYCtJ4BgInTcXf+NBWikLtUNAt6fqzEgp9t42H/cu/QqFh8ySyTlUKgBETKxklmodecstpvLcSTSqUSCjHeDadKs6C4Ya/xiRW1mvjd1IBHvY162AU7ER9U3NZDrh/qsUiLPRHjNHqXlA24J
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(451199021)(86362001)(36756003)(2906002)(186003)(5660300002)(6506007)(1076003)(26005)(9686003)(6512007)(6666004)(52116002)(6486002)(2616005)(478600001)(83380400001)(38350700002)(4326008)(66946007)(66476007)(66556008)(38100700002)(41300700001)(316002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?npVp9BO9pSyBSbdKZ4moy/NHsCDZPKky+RHUIKb7Rz0+/pEQoMcsli1rojbQ?=
 =?us-ascii?Q?BM/UP5cMSAyom0PPVW48AikBt1lQcG5CauchfKJssZJc2HZthXfXDpaZe1M0?=
 =?us-ascii?Q?kpFXiuIiiG/aYFKJLPE7L9OweusKOpXgZnn1r6LzHLi3RaecB55EsV02dNXt?=
 =?us-ascii?Q?EnUJG80vRrvSK4WgMTj3OcIaiQM3Ztt/xW2LYBH/9Gtkodp1b54+G8S5OPcs?=
 =?us-ascii?Q?gO8qam9T4dTXcBNeejZVmyJG/DKVmZ3jrmY5clzdQe98hBhRkxvfHz71UcdF?=
 =?us-ascii?Q?JWfXI+ERL5+9yAj+QLZ4Z0+WMovLWefPZrkTg8khkj0b3DB8QRhjtRP8K1Xt?=
 =?us-ascii?Q?M6LTSnhZWxe/WzrE7JQ7QESIg14QkBT30VdEzUQTvrdWsJgbX8A6aJdmnFDH?=
 =?us-ascii?Q?gVD7rmQgCDEgRDICN7kNfwz88bei21nZ3cwHuJZzYfo+2l+nQ5bAX9R80fAF?=
 =?us-ascii?Q?3Iour4j4shUEvsNMRht6vGAV8MuoFc/Ne+EYBVGQIWPhh7bJT1+oIb1EqxSd?=
 =?us-ascii?Q?z4GjCc4jhNRfIpmoFkQ+dTl4E01eFiovGC1hAGBsBF2Dp5N3dZuUiaNx/YFm?=
 =?us-ascii?Q?KS2qS4h/ekLftgz0xeWhkjSDR0IQfgh/XCm0RLDdYuG+VpiV7qiYs6hp5dWN?=
 =?us-ascii?Q?fthz5onQQY4xd9T1gvZTEzCdZPiGjmK2GS7pLMRv3rXNsbhkbUddHpSiTfnx?=
 =?us-ascii?Q?QqtEqQa3UxUZj/v53Ueoo0UoiZXToWodzuDjnu22NXklRduKligyA1IQzZvx?=
 =?us-ascii?Q?LHDf2aJ49M/xfhHuDf0MxLEC5vxvFxWQ8i1nqzFR3N1L4rowCFEORBycHhVo?=
 =?us-ascii?Q?xITI3yY/eRGxAHP/ALlYXgiUEIHQNuar5xHVZqS+My1yTL7FNCpLU1j1RxQH?=
 =?us-ascii?Q?i2q+jToc4bXU+PvNaOusDCqqboe4zgYUHvPs34zGKwg93l1QgZtq6Uww1TjN?=
 =?us-ascii?Q?e09f0Z8fds4oNa2xcbNu9Pr7VyCAghE+KfRzIQ6wFt70XOKgdwluQ2DBfcl2?=
 =?us-ascii?Q?Xf43C4age4EmNrFO3et8ikZD11rS7WrI+vzy0BXplvx6YXVhCXv/BUvHHE3j?=
 =?us-ascii?Q?/SE+FHkyBDYIm6r7Yd8DZQ6q6S1HzMdSsFfIrz8T7SB3pW2U9z2msMByW4YA?=
 =?us-ascii?Q?D0OLjEqM/Y9EI/X9PpLi9gSTKbfbXex5OtANsFKM1nmsjU/oFw3SAtVMM6DG?=
 =?us-ascii?Q?k9OljSqO6wgXgLl1VsgE4qoDeLSMOyDG/Ux+xIHRJGSMJ7Aj8M2Qrmc87UFu?=
 =?us-ascii?Q?n/+yzj7pnTqN3ixNvFDtLpELj1XH/9ebkGGev9Eb2pRh3cRuh724UoyJ3tkP?=
 =?us-ascii?Q?uV8ZOG25HtwP6Y6LZBm/sQowIpUPvC0nFPNBrXdHDCeq7CAG7uynbpX5M4JA?=
 =?us-ascii?Q?2jFmZHmKh3Nsl6TOl2s2DQf1UI/Bbr7gHkoAJK1BVHXydaJ/ivdj/BMpAh0i?=
 =?us-ascii?Q?52GyKwleLlttT4C8khiBcMm2/+wq9ZYtIPzuQloUTDu2y5nZVaxo68XhdMxH?=
 =?us-ascii?Q?/AoYFrS1hHwmPuVwQrvUT/EvhtHTC5EtTCN6jwyTBpIb+VIgIPfUBbUlu5Dd?=
 =?us-ascii?Q?yHH4/17O6s3a31ZtQq85LOYi2CRkMhuXInHm9d39?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f5de25c-f449-4c79-2a34-08db61e2e823
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 14:25:39.2151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mLnKFxye7ZWtBI2XKkSk8txUXMD5xDZ9/D8jozH3Le4M0gLGw1ksdx8uRZEnidwh7KcifZ4YwlVtoXdU+u8bzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2785
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_08,2023-05-31_03,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

Jean-Baptiste Maneyrol (4):
  iio: imu: inv_icm42600: make timestamp module chip independent
  iio: move inv_icm42600 timestamp module in common
  iio: make invensense timestamp module generic
  iio: imu: inv_mpu6050: use the common inv_sensors timestamp module

 drivers/iio/common/Kconfig                    |   1 +
 drivers/iio/common/Makefile                   |   1 +
 drivers/iio/common/inv_sensors/Kconfig        |   7 ++
 drivers/iio/common/inv_sensors/Makefile       |   6 +
 .../inv_sensors/inv_sensors_timestamp.c}      | 105 +++++++++---------
 drivers/iio/imu/inv_icm42600/Kconfig          |   1 +
 drivers/iio/imu/inv_icm42600/Makefile         |   1 -
 .../iio/imu/inv_icm42600/inv_icm42600_accel.c |  32 ++++--
 .../imu/inv_icm42600/inv_icm42600_buffer.c    |  30 ++---
 .../iio/imu/inv_icm42600/inv_icm42600_core.c  |  13 ++-
 .../iio/imu/inv_icm42600/inv_icm42600_gyro.c  |  32 ++++--
 .../imu/inv_icm42600/inv_icm42600_timestamp.h |  85 --------------
 drivers/iio/imu/inv_mpu6050/Kconfig           |   1 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    |  26 ++++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |   9 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    |  83 ++------------
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |   3 +-
 .../linux/iio/common/inv_sensors_timestamp.h  |  89 +++++++++++++++
 18 files changed, 255 insertions(+), 270 deletions(-)
 create mode 100644 drivers/iio/common/inv_sensors/Kconfig
 create mode 100644 drivers/iio/common/inv_sensors/Makefile
 rename drivers/iio/{imu/inv_icm42600/inv_icm42600_timestamp.c => common/inv_sensors/inv_sensors_timestamp.c} (55%)
 delete mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.h
 create mode 100644 include/linux/iio/common/inv_sensors_timestamp.h

-- 
2.34.1

