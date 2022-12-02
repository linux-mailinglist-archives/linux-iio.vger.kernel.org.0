Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5D16404CC
	for <lists+linux-iio@lfdr.de>; Fri,  2 Dec 2022 11:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbiLBKfl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 2 Dec 2022 05:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbiLBKf1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Dec 2022 05:35:27 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2059.outbound.protection.outlook.com [40.107.22.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90159CD794
        for <linux-iio@vger.kernel.org>; Fri,  2 Dec 2022 02:35:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEBaqhs+dlWvPeITOXpTUqwU3fdyYvPIbfpCOCDEc+1EBNums4z2lFMgD+CXTtIP9D4JbvYc7OtAj8W/h5xF0TJGe43PNnI78zWiRQnaE3suj/RMQZq0ngcEsZYfC639L6O6XFTmLX17eY46tVygxUmTh+KyO6jM2e/IsL3lft/+oc6wG/tWncxK2AxACYWi6T1fpVq0R3U8tloopmTnzL+BWsSxd1GSe58Wul3W8ISw9fKZrZFTUfK76xFRQNL8cMGLzPUGBJVUxnMKNDZfpxhlDmT5+9qoy2xhIuyz9Bae5boByi+nmh05J3xYDUCD2RD3h13r88kIteBx65GTPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxLLyGgiMbKa8pah5bha/own4HoPm4/ft+rdSHohEIk=;
 b=jfX+lOSm7auk9c+ufdGhaf5Z4NDaCyHE6lbrQO0xWP773IuZO8SrBBaqhvZodO8zlgz5GcEqWJDnGxXHbOksx1fu4VCMln0reYvFLrvNu4+64bO/fHzMmBoAGiJtdI4E+O3S7lC3tTk24G3J2h5doEnJOekHvTtb3fKYy54S58IdAANJH9ghpKG0QKQPRXZHmfegiuUWRIpfquYW9bimXKLNUvy/bR22Wznh5rpETdWPYPTGjD2Z2VRTn7nBDwQ5GFJS9psQkq7Mk6IYk4Ye2pNzm8V9euEt8AazwRgLkiaKcy7oc5yRFJF/P4qNhGRHKf5c/e74FQ6tcwGZR/m0vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxLLyGgiMbKa8pah5bha/own4HoPm4/ft+rdSHohEIk=;
 b=qLUjtRkW3sd1LNwjgoY6QVNwOYpBelXd0DenuLfZtjPA3rW6RTwPWTtxuUFHQYebQ5htYIa9h929O8OEtGGPHVdSKZ1yiGDepsHmruJvUpea7dodkQKWEPqlwA0bz7bl0hkDKFov64px5J7h4UFVAXxN/EI66ICLRssTu/bzp8c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by PA4PR04MB7727.eurprd04.prod.outlook.com (2603:10a6:102:e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Fri, 2 Dec
 2022 10:35:24 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749%3]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 10:35:24 +0000
From:   Carlos Song <carlos.song@nxp.com>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     rjones@gateworks.com, Jonathan.Cameron@huawei.com,
        haibo.chen@nxp.com, carlos.song@nxp.com, linux-imx@nxp.com,
        linux-iio@vger.kernel.org
Subject: [PATCH 0/4] iio: imu: fxos8700: fix few bug in reading raw data and configuring register
Date:   Fri,  2 Dec 2022 18:35:34 +0800
Message-Id: <20221202103538.2218925-1-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::22) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5005:EE_|PA4PR04MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: fa7e12b8-5877-43e2-25cd-08dad450eb8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X1h1vYmX9+z1T5oJiddp1jQLb+fbj4+XYNasS2SGoUFdvKbOvpQ+Vj5BlzNibykizX50bnvGtalpxbnAEqTqQYndvlgnUn+Vl5jvNS+8BJrAJLFuqtFXzTLupRDHNQTty1+OPzGXFCtXmipfSPuAjC+ZJb4Kn7kY4oRHjs86DRj2CP5bk3de0s8xKpT8p4yU104ta3ud37ikzxLDbHpeYSET8L6KwzO/EPvzwSRHrg6l1z1FsDK6w12+OfujZphtINE78Ca//gbP8InKvAL9cxipJxypSbqa54N7JGOJwmi4Vul9jvJbZ2n0eGrfNfjXMD4aHB50EOtJwDNglA25T96E2E4+4o6yuR8UFA2ZPbw+ZJZnm1l8Z6mrGSALUW67InMVZc+0RTXn8k/11lI8nPxH0cAaWPlL3akEsI8Jl2XQ3BDJrPSJjzCzNKFaFSkXu5sQVkJe0mj/Hvalz47rKg9FwGWykL021buBKm3wMILVTeHazQyeJEHod5L05sKMQwOl4m5QCXSWZCWEKS285jztXN5yOwkLWzMd25tbdyu/xVpJoD1w8O69ZQdko+KcwbohvpwK6I6aJRFZWnDu81VvT8VAUbRyIGbiYoZqfiaYfTIXFsov41r5xkY6Q9mSsDnxJFPfb3zvAa1Cjg+i4GCW7JPF4xR2UFxcDTAwiBl+CUTIhshGHivQdtLSmnG2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199015)(6666004)(52116002)(6506007)(6486002)(186003)(6512007)(26005)(316002)(478600001)(8676002)(66476007)(4326008)(66946007)(66556008)(2616005)(41300700001)(1076003)(8936002)(4744005)(5660300002)(44832011)(83380400001)(2906002)(36756003)(86362001)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zDAVqT5dh6ccSq91hrjyMYXOZOjqFa2x/9cmemwR1PTrADMaUO/ny8GNOkb5?=
 =?us-ascii?Q?dAAk1P6SInfJcbKxPqGtZxPWzstP9PtuajY+MSPe4/c+SoktZnkP6xsINzEy?=
 =?us-ascii?Q?bLSEr1HgB7pazw9ONiJht3v8KnI7jKo07StyoIIL95T9hUgLDxoEybety8Dr?=
 =?us-ascii?Q?ONjc6RViXhmgjPaiar/UVg4K3ZUfKxRv/Dhcvq/opK58DgIqXXmzvg7B+gyy?=
 =?us-ascii?Q?1y3Z/9sw9WAfPCHErZCK7RuJ9obR2gYZWPv892kDTs38IasC1wu8OrivlOPg?=
 =?us-ascii?Q?pYL7hg23nte8R/5Q6HBLII5Z8qA1rWDcWytd5QT/KeiqVNI/Z6FoixpFfYhh?=
 =?us-ascii?Q?NyQH9CcvtM2fRxkL2KtVFYHfXB7asvWysfymtVfYkv+lfRXrt1EXWK+vb5f6?=
 =?us-ascii?Q?DZ6BuSq4QJmUJnIWcG9qqVH0ewKvPdf4/d49nf3gBeajT/hpX4v67ahDtLhn?=
 =?us-ascii?Q?wkDWhKenp+uITTJEo0CYNFjIJ5cwI4dyIPUfaSOmcz6/bRlO4yM7kncJy0tL?=
 =?us-ascii?Q?Aay2jiuXitYh84KGSgWYJKFXyGNtA46WVpZ/Maan/9pii5UQ5sGbmGzkdIev?=
 =?us-ascii?Q?Z9VkaiSsCU2kwGrc5UD3LgpESKQXCS9RSHFSXUwyhGLPiVzFAsC0tuCHNrAu?=
 =?us-ascii?Q?cVZSLJyu2Eq9S08XJNfZTH/oQGcRPNpJ4edASoi2QqAOfrExiEltWYZMAKFq?=
 =?us-ascii?Q?zWX3w6TKzPSq1tEGwOF3GFJS/5v10qKOY+uwW0rB+YzmRjS+KugyJoCo9Lhv?=
 =?us-ascii?Q?fHkWvU6bChExXXLJYBpQTgX3VNcCKikgMpk6yfyjqexPBSr2ZMDEFhiwIXsJ?=
 =?us-ascii?Q?de69S5AcGGdqF5GKN0meMEYvRRlYqCiQnSJkd/NQdlTzScjmJ6TalBeyYvL2?=
 =?us-ascii?Q?em91GxIkFnlfsusWOFDAL25X51Topd8drIE1I8xxYirLQ1Iarp1XZ0fEHkFp?=
 =?us-ascii?Q?X4tIqAphZsEtWkQQMEfyp4chB7vYtXn8zp/pBtjeWkUqRknhLh5kNZFHCC0I?=
 =?us-ascii?Q?4QMyx6BRuEKa1v4ZA4dezsp/2RlFWq4AlsjRETAbWYKmzn502cv88VWunX63?=
 =?us-ascii?Q?NtLeCbFpGNzuJ16FY/Gxcp6x2PF1HSwxvoLb2N2D+Nrb/Rx0MHv4I02KQDws?=
 =?us-ascii?Q?pFWNb9tHotKAhhhr9CJvEGk8pjv43nWKJpMdVhcyKTozbp3YJxMxP+5IysHr?=
 =?us-ascii?Q?9GpLopCOUsdXPBC69A94kiRwennplbr/aLhWFE6JKoWdU2OboJOkfrHAlV3W?=
 =?us-ascii?Q?nvLJkFepQVu23lQcbHUQM91Dak9BhdGAOYyTo+Y/9yuVagmZx4HEWvrDAi3Z?=
 =?us-ascii?Q?/rqS4Vzp4KkbmtmjWyOwXxt0vqB3nRmKPfiFPy2V48TKWMC8yLeML4cllpUj?=
 =?us-ascii?Q?OWqdSlK6M0fPoQ1BLWAYLW5+CeZsAMbvrnR3gkLDK1wByVtCMiIVtEiT1b3M?=
 =?us-ascii?Q?YCwXP6XlstgR3quEzw6YYjEcWZ74erJulWQBhIEebI8+iUNvh/n7+CGlRJBG?=
 =?us-ascii?Q?rQucAVBPjebB3ut1JlMZ7Q/+qhg1Km0yVOgI+B7/bpHcCuwLv7dqTw8ZI1G8?=
 =?us-ascii?Q?fUgmJLZ6MzzpyfsG6uWQm7l5KC7CqafK7sW87vKi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa7e12b8-5877-43e2-25cd-08dad450eb8d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 10:35:24.4151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zJUArdisMuWiQeNoIM2B9jn9RKKJtYtnYjf6SW7KIjic4PwAMwCkVnKV5na6aLOLBLiOxjWFREhgdj480riJGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7727
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Because of illegal use of raw data register and configuration error
of raw data base address, fix data acquisition function error. When the
device is in active mode, any change of the other fields within CTRL_REG1
will lead an invalid configuration. Set the device in standby mode before
configuring CTRL_REG1 register in chip initialization phase and setting
scale phase. Give the correct offset to value when configuring odr bit and
reading ODR data from CTRL_REG1 register. Set magnetometer scale and
available magnetometer a legal scale and rectify iio channel type to get
a correct magnetometer scale.

Carlos Song (4):
  iio: imu: fxos8700: fix get data function error
  iio: imu: fxos8700: fix CTRL_REG1 register configuration error
  iio: imu: fxos8700: fix ODR offset error
  iio: imu: fxos8700: fix magnetometer scale getting error

 drivers/iio/imu/fxos8700_core.c | 88 +++++++++++++++++++++++----------
 1 file changed, 63 insertions(+), 25 deletions(-)

-- 
2.34.1

