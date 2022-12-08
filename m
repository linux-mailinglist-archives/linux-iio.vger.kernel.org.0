Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53754646999
	for <lists+linux-iio@lfdr.de>; Thu,  8 Dec 2022 08:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiLHHSy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 8 Dec 2022 02:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiLHHSx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Dec 2022 02:18:53 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2057.outbound.protection.outlook.com [40.107.14.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7AC42997
        for <linux-iio@vger.kernel.org>; Wed,  7 Dec 2022 23:18:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+RC2jNpAPQQyDsoSnyoTt5FRxZwl2fhW77RAjJhes0kWbhpiLB3CEduUAXl9z92QDmO/FsCL1+NDgmzeKu+6RGmGW4rd6+8NTFbNr9MisTVRiHuWlXZbRVH2N4eHHNsJ5KhRugiDDZS2HkqnoSKHhol5IQye81nr6kH4a/xKOyAlKFIlfJ7y/6BC+7zT6heiqrMqBCRx9hbF/Q4+QHAzCfpxVzjA/TI3t7QdmjEOylfyzSfgzVMyYX6VRfO6X7VwT28QpD/U1gWs6rrSAEJtzllTK1bp1gDbZMhVXvA1DvsrlSkNaTUJ2lpw+O6WXrV6x03Z1ACR/eK83Ob4myTdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2P1IoSMCK9QvPwyzBqVOMfgS7LOBYYSmms/xOrjkZM=;
 b=EfertISudOSqaZGlhPikFCmBrNgMCHgkfykmYVhF/3CuIYDMhIN5yflES0mY3mckBJBJQWn14el5ILglLKlenhC5UKEk/oMVpIvU7ydl/NsTMkdpItvGicTZUsX8jLPj8mhFGfeWNpnjmL3nFX/8k2JkAh00XbVljK9mo3Gf1C/ivCRDmm5FoxwLa5M4GOGCE5WNsJPuecaxtHnQUSHfaXvBd3KHjHF3IZpKobtWuLLT+Lp2nVLJ3pjcGWAu7gzlL0HbeRkrgYGbqz52CYiCnQNjtsMwDaIwTf8pr1Nkxif7Dyqi1Djb05cZ/XgVsr9wWKp+axe/L/kVNKdA0dqdzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2P1IoSMCK9QvPwyzBqVOMfgS7LOBYYSmms/xOrjkZM=;
 b=cwPJ9ek0JTLVMyIqlUOblFpzXoXCenrzM5yoN102sV/Hztx+KrZ/SmVPddQA177cCUOC7upNJhdbxSCvljgaAR8WAs3N3OVLpxNOVn5hPO4LawxCuMTJ0P0UxSDsHPAuonfxhD1NrzDcgwEhZ2zMjCMs/YrUYogBpYRSx9X4Cn0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by DB9PR04MB9701.eurprd04.prod.outlook.com (2603:10a6:10:300::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Thu, 8 Dec
 2022 07:18:49 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749%3]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 07:18:49 +0000
From:   carlos.song@nxp.com
To:     jic23@kernel.org, lars@metafoo.de
Cc:     rjones@gateworks.com, Jonathan.Cameron@huawei.com,
        haibo.chen@nxp.com, carlos.song@nxp.com, linux-imx@nxp.com,
        linux-iio@vger.kernel.org
Subject: [PATCH v2 0/7] iio: imu: fxos8700: fix few bugs in data readback and mode set
Date:   Thu,  8 Dec 2022 15:19:04 +0800
Message-Id: <20221208071911.2405922-1-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0019.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::10) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5005:EE_|DB9PR04MB9701:EE_
X-MS-Office365-Filtering-Correlation-Id: 7273963b-450c-46a4-1e61-08dad8ec7381
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cB6/1UhZFdUSYSuGyqqKxQZ3oGpnya+2Yf2MINfc1pThxomnvhswgk8+bjfGDMXLY1MkyZDq15cuxbv3GtVi+se0HxyvLsC64U2tegOsbg4UP04xa9Hwv+GLJQ9TwVi2z0HV2zNLZQf2DLFoK35Su+U/kT5Usop7NJ0IXAbHXsdTh9Jf3JLa4WmZf1kU5TyQYx/AJpweMpon2B8xxbP1of2nsOd1kVL1LixQ2VTmRYm7gIzGEqQgeSpuTRczZJ/u1zmafOnToHtfBrt1HJsiD7a4G0v+GgKe3WN4LOZTXjwc9JNHJjxKSV+Y1hib88MJSDR//8+AgUDH5K1lvyf32xaMgDnczzJmQVFjFieq0ei1PCViYcUDT1PvcNJbHas81vB+pcwzW/yOEV/xWo+FNKgv1+yV7f5NA/JnoYuWEwEN6tFdffayJMOyNSud+ofN6zOU9hpFKzRuNilSP8sRP2LpO+cXWqDgX1c6xT75JKQPfsJZgzibaR0kS6LmhpcjxUCzRqe0wusHtg2PbTo4m84I7SRuEIoZDYFvsM15CW2P20z365tFu8REDSRJfrEWzk745r01kG76ekn80yvkl5ZSFuCaTcTG6A9W8pQsnzFsktT/YDGMePLGzx57EIyFpDSS2jLnhC2XPUYUcjAtkIQfVp+je3vyp17C8NHYc/5/mDDKyChUmoxFSzJOKar7kFBcjzJHjvox6qF1QtMkUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199015)(36756003)(6506007)(9686003)(316002)(26005)(83380400001)(2906002)(186003)(6486002)(6512007)(1076003)(6666004)(52116002)(86362001)(66476007)(8676002)(38100700002)(4326008)(66946007)(38350700002)(66556008)(478600001)(2616005)(41300700001)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HuNWkJ8avqiTO5jDHh7xNkUgbxzALWCgM7W9MZsjvreZOVWsF7hYRcFzPqZG?=
 =?us-ascii?Q?P/tOfakhaWbL5lt6dGsKf8u2w6WcONCC5Ust0ZB32G3J9REMmqmyqvPQeKEc?=
 =?us-ascii?Q?UA/4s/84J2SPwAYa9O3vCEx+seYsceYCAj/7snykH0JM3LsqpIbxPNMPq2am?=
 =?us-ascii?Q?HNuKiYjdF/R0WtFZDdB6qj4V92QKDam2jIbxklwrBjC+E8g4VslTjjuGu2cn?=
 =?us-ascii?Q?klwKKkirvNYIpHC+X99frwCXd02NS1pk6YxEJtbBKJC3Roq7TU21gTpahpUQ?=
 =?us-ascii?Q?pdZm4wAyezBlk3tkgCPfY+FFcNBCVKkkCL26hk3HnY7EHdBT6x5MaPH/L5yD?=
 =?us-ascii?Q?GELblTnr6HoVfN4rozgcFsdqVfy76t1L9DN5+mEDf663As15vekRUYH/D1ql?=
 =?us-ascii?Q?MNBVKy+laJAsiBtEaB8nPdbjIDy1LkOgnn94fWa9qolH/N5p/oafRPFfD+vy?=
 =?us-ascii?Q?gBWYr51GnXzv7jhycx0KGLnWnjr74qkwZ/Rx2oIyRrGUl2rsQ7zYo2QygT41?=
 =?us-ascii?Q?ibiw/s5oXOLOIdDnhNL1t/pokdWhJTlEpuGDGIQg1H/nRzDYseFvFmNJ+Gfn?=
 =?us-ascii?Q?gG9+dtEH76bY4G2dptKH6Wvvs6Sutshe3wb7/t3AKt/ghUbjzSaFBoihd7rn?=
 =?us-ascii?Q?T5nFFOBd2pepSjERxKg99CQ1AWAi/jZpHD8aWk/7KJag2ExS/koj1MvYHNSL?=
 =?us-ascii?Q?QHH4smwJ9NWlCjwZ7ePfspqisUxpu25GlKql19kefRRyjco3DCmX3Urq7usT?=
 =?us-ascii?Q?0rX5MNPIyU+BduDu11lqB14ku+dRP7W1MIXyIhi2udkdr7rzswKYTMUFJ9Fw?=
 =?us-ascii?Q?KCXsKtBL5F/OkoHBeWbYAxH7uyB9qppEBOUwJYgUNcEtioiI8aDuDUMuF3nQ?=
 =?us-ascii?Q?lviwxm4FI+qRrOxnAWrivSF9vP1uJdvjsh6JWxTEkfcMprpQXm8jfSbElGi5?=
 =?us-ascii?Q?draHiNrjKDfVrlw0ja3GxDb1QHmJqW/LMMoBskaqYkH97ZFuHOeE4CitvAe9?=
 =?us-ascii?Q?bz7/ssvjhVLKSLSgj95kPCsyTHoWeRKDOLs7lhzGTv8Dwt+MCTN8ckzH9+1s?=
 =?us-ascii?Q?QIN/x2Cwf/kM+2EK+wQkw3sAX3BQRd+11G+TaCOzS6OuPVt4qbdZtEqcpEUS?=
 =?us-ascii?Q?LZpZ1MtfdU/OuUUmer2+idroGlMdE4yzwq7PJ4026jfE2duXrpc5k/HJyYuE?=
 =?us-ascii?Q?CNNERrsMCuayatmfOpSPxZjidV59piC+8dNpticUka5cMiwkOD9OBQ8OWCS5?=
 =?us-ascii?Q?Zn9/yu5uau6HArtGykWKEb7HOtvI1otTFM/lX0gbdjLRf1CdCgCjj0LPWcyc?=
 =?us-ascii?Q?P90kLw/elMQhITkdRrSd1ZO+dCu3m6DnO6MltqgfAmJ9J7fpRvUvHWRwBkkV?=
 =?us-ascii?Q?YWtuIQLK8Q6ioFqFlN1E6EmL1VwVx9nHTTQ1IwkzN+pFa7kAE7hMI4ZWcHWY?=
 =?us-ascii?Q?et2qmqxlHq3mZGHAuO+ZndGfPsgslapz1TVryHQzqjD0abIQ3FWGf91xYave?=
 =?us-ascii?Q?1UB7qOtEKVxhxNiIF5Wro8+nltGsVNQ7yvMyLBYha2djOQwoRwMgQzCMcab8?=
 =?us-ascii?Q?CYGfZw5M+gGJTQGiFiKDanJ/6wchleuJ8t/ZmBlv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7273963b-450c-46a4-1e61-08dad8ec7381
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 07:18:48.9788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HVRpHuiGM0RzcGIyfZBhEcg2RDzgLDHP1XJuxXO6TvSP/D3KvLrGcAzPI2fp7U9hiU3+bDGaQ1v9RYhB1RoUbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9701
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Carlos Song <carlos.song@nxp.com>

I'm grateful to receive and accept suggestions for these patches from
Jonathan. I am so sorry for sending patches with much confusion before.
In PATCH v2, I have reworked our patches to give a minimal fix and split
the large patches into more smaller patches, especially rewritten the
commit logs and comments. I hope these can explain more clearly the patch
of the role of FXOS8700 driver.

We have found some bugs exist in fxos8700 IMU sensor as follows,
some patches were proposed correspondingly:
- Confused IIO_ANGL_VEL channel type mapped to MAGN sensor
  PATCH: iio: imu: fxos8700: fix map lable of channel type to MAGN sensor
- Incorrect ACCEL and MAGN channels readback
  PATCH:
  iio: imu: fxos8700: fix swapped ACCEL and MAGN channels readback
  iio: imu: fxos8700: fix incompete ACCEL and MAGN channels readback
  iio: imu: fxos8700: fix IMU data bits returned to user space
- Fail to select an ACCEL measuremen range(2g/4g/8g)
  PATCH: iio: imu: fxos8700: fix ACCEL measurement range selection
- Fail to get and config ODR mode
  PATCH: iio: imu: fxos8700: fix ODR register readback and initialization
- Incorrect MAGN scale readback
  PATCH: iio: imu: fxos8700: fix MAGN sensor scale and unit
---
Changes for V2:
- Divide [PATCHv1 1/4] into three patches to fix ACCEL and MAGN
  channels readback. We rework our patches to fix the bug in a
  more concise way. In this way, we give a minimal and base fix
  compared with PATCHv1 and remain the logic of the original code
  as much as possible.
- For [PATCHv1 2/4], we rework commit log and comments to explain why
  it is necessary to set device in standby mode when select an ACCEL
  measure range(2g/4g/8g).
- For [PATCHv1 3/4], according to the suggestion of Jonathan, with
  unified use of regmap_write(), FIELD_GET()/FIELD_PREP() when read
  and write correct ODR register bits. This will greatly improve the
  readability of the code.
- Divide [PATCHv1 4/4] into two patches: one patch separately fixes
  confused IIO_ANGL_VEL channel type mapped to MAGN sensor, the other
  one fixes MAGN sensor scale and unit.

Carlos Song (7):
  iio: imu: fxos8700: fix map lable of channel type to MAGN sensor
  iio: imu: fxos8700: fix swapped ACCEL and MAGN channels readback
  iio: imu: fxos8700: fix incompete ACCEL and MAGN channels readback
  iio: imu: fxos8700: fix IMU data bits returned to user space
  iio: imu: fxos8700: fix ACCEL measurement range selection
  iio: imu: fxos8700: fix ODR register readback and initialization
  iio: imu: fxos8700: fix MAGN sensor scale and unit

 drivers/iio/imu/fxos8700_core.c | 113 ++++++++++++++++++++++++++------
 1 file changed, 92 insertions(+), 21 deletions(-)

-- 
2.34.1

