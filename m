Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42F564C2A2
	for <lists+linux-iio@lfdr.de>; Wed, 14 Dec 2022 04:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237292AbiLNDPP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Dec 2022 22:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237301AbiLNDOy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Dec 2022 22:14:54 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2048.outbound.protection.outlook.com [40.107.6.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B56A27CCC
        for <linux-iio@vger.kernel.org>; Tue, 13 Dec 2022 19:14:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XXmA+romryiYA5hAmeNj/Nl4UWrm6EmUHAJhIcwATZ3eSVufmIFJfJdIb/Hzi2WkbEQo4Nuo27t1YZb0fq20l3K6w/I1PBzXkvMNCvy2IGWpfJA+5BcjvPZhendus1ff1Jbr6r74bYLWoMPqVr1ZYzoeVus9fG2BysalB20Tz729SVQ5Qd1Xc3j9cY462/DX0tFL3Ue6QzlYoHxoBtAwvfIbq31ScOilRcae6xL7oVhWsP3m0bQUJUldC5j5nTo80s9KrHA2ZNmzqBV0b92D1y1cUbdKkfOKqhdgYj7C/OWBdDcVRm/ZZ1ZT/4i1kReN+1HQezXLe04CF1fbMW4tOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9+t9eIVF4HhHRCYdy+8DWJPzM17OPpvrEq9+bpMmW0=;
 b=Kd9uOsh3SHGq+X/HAkqNdIXaz8YJ6GnIJH5+7l1gh3tnDu5M2rHQ1CEjeYGsxJMM2In5OwSOml8tH6m9fCXnL2r16f0nuph6phxCMS7F8I0yrVpXkQ6990ogVlqaaEfvL7HLlldBqq0A7KiC+e4cZ+xoukv0+cmLoMqC5FsyO4S0HF1n0DXcU4DtwlHxa3Ufgn7A4HLye42HwD+JBoQk+iygfcyJe7UXg9EqL/w+GIBUmF9MZS25sWuAPSVp934ROTX5SY24IEl/QSM0j1u6np7pPU/qJ9T7bWzN+zHvg4lkU7BJoeSReLdBS1eNYdgzjpNOlwtbHVNZYCIgN4b5Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9+t9eIVF4HhHRCYdy+8DWJPzM17OPpvrEq9+bpMmW0=;
 b=SroQHFZnIbzJcmriWFKTTgaBfryYohH76g0yVFf9nY6MN+c9QwvWdN90a4GX5s6L7zMnVDJ9kQ/+iWPzaJuTv6B8CQ5LEMKWtClATCdSzZoFSDlQMiJoLXdbni97gASZBI7uT/1f+Lqcvbyck78A8c9wsair30MCPPUIpmX+2V4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AM8PR04MB7761.eurprd04.prod.outlook.com (2603:10a6:20b:248::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Wed, 14 Dec
 2022 03:14:46 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749%3]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 03:14:46 +0000
From:   carlos.song@nxp.com
To:     jic23@kernel.org, lars@metafoo.de
Cc:     rjones@gateworks.com, Jonathan.Cameron@huawei.com,
        haibo.chen@nxp.com, carlos.song@nxp.com, linux-imx@nxp.com,
        linux-iio@vger.kernel.org
Subject: [PATCH v3 4/5] iio: imu: fxos8700: remove definition FXOS8700_CTRL_ODR_MIN
Date:   Wed, 14 Dec 2022 11:15:02 +0800
Message-Id: <20221214031503.3104251-5-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221214031503.3104251-1-carlos.song@nxp.com>
References: <20221214031503.3104251-1-carlos.song@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5005:EE_|AM8PR04MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d92347b-9af6-4e77-efe1-08dadd815a46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pb7g2rlBEKfSmgBfQCyLsIxzycGOGMHiVNvRNqUGQ7g5k/KTnkRoCxwh4wF+PXm+HlEtCB6GkVRCOvYrPVL/gSqpWwtzWm8HR1tw1oM7z6SGZMoqcQjOsdUjBxb+ocOzXgvapCqqe/qPSrvZt7Bipcb29cJvo5AMcQBXTUHAXfP1kVTn6HaZsV1nF3ttoIdoRFqMqVujIym7db+7fWkOgRzIL7upCrXnTv7dBWuw2SU3JMm2i4XO3NQqaB580A5IdEPa/0kEQ1GyF76j54cbgXmXCab9CpTBKe4cpVMZy+MPSNuw+66UCxiy6yLBJbL/WfaIycZCF+xgjcplGWvDE86zN7SEkdRpFRN8yYjxAbVjOeAVJGIIbZq+6dYpCRTHUJuw6cDU/rFR74J2pjxTPFLOf2lnjTIJrU9qtCFk8s6iF53lY+QWZ0l5Z6HOwQE347YyUxEP3UNsGuEHl76mWz1IY0Gc4+EPTdUoSHf1x5Ocb2+Xh4DUC5XW7BUVKie0MPYXC0tPqM+yzzjZuwC+J/szrxHdZsEl/Yqv7blD5PMeNIEXy9tr1qsNv7IrCpnlkivHAhlHLhi78vcnh4GcSisZaE/2O6i+uQ6BnpRNHgm27r+fEd/UicGWAO2QThPGu7DzgMirhm0CiDWFCuPgiYf+KzQ2O/PGGQR4vItOG0StoTkEW4sN5n8WTtLvqBPGtJ0rZCp5t6Rg0xRe4TFiLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(346002)(366004)(136003)(451199015)(66556008)(4326008)(36756003)(66946007)(41300700001)(66476007)(8676002)(316002)(5660300002)(38350700002)(38100700002)(6666004)(478600001)(6486002)(6506007)(186003)(1076003)(86362001)(2616005)(26005)(9686003)(52116002)(6512007)(8936002)(2906002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ipCffGGdDce1QBeV6PN34GwEhJEVvLUVNRy2pz2p20PLplyH71xW/5MD1cD1?=
 =?us-ascii?Q?fWRc7ScFY2W0epAGv1TRxQVV3oZJfcEMtk/oylJCuJxBmy+yCwF0T5nYiDet?=
 =?us-ascii?Q?T/p11vjKBlGcB1UUOVcAz9Wi8GMK3ihdQlcH/JT/BXv1xUqX0tHUEPXfUFTp?=
 =?us-ascii?Q?QzH6gG8kvuBQPnXehH+BBk+nEwTzCZFh5BcXjFTronHDvrQ1FHxzlHRPU7HZ?=
 =?us-ascii?Q?XEjiqUlOVBekNGRpI+6OsvCmCANrHoLKWq2AymKp2gLXblZp70Twk2dc47XR?=
 =?us-ascii?Q?J1xji3zeuAuc7BmCyKKOmksH6G/4y9OHWle++X5q4JtGoHmxe5jfd7fa6iiW?=
 =?us-ascii?Q?TgDwypT7TAzOO4wl3Ni5evUNP0bzmuZq1Lg+Gth5VnHAg1vjy8tYRox5oacg?=
 =?us-ascii?Q?OBd4BK5DpGssnqDE3NILL7EwqxGa6dNNPdr8dW7VX89rjLQ26m6zYZEV0pqG?=
 =?us-ascii?Q?NZdsmO2v1YUyjwt40aWRtoMEInfOp9ykgnbQjkKoyfCktMUMsYa5u9Jsg2lX?=
 =?us-ascii?Q?8M4I5/uyZKbk49Ve+jaXckEvqsGBrCCnfo2HGTOMcxd6q+HMO5uS4bQzuyha?=
 =?us-ascii?Q?/lbapkqbMTDd8p+89Nm18MusO31TcQ9VZthMosI/vSQqj0ytW3TFJ3Tv76HP?=
 =?us-ascii?Q?kJ/pAq0iv7oDYBlSwLHowDusxEVltXsiv7hUxVRi8EaQHYeFeGBYNqMnbecF?=
 =?us-ascii?Q?eWDMRXjjSZF6S5AhWrPl/ZgAmN7J5geVWvyHqQSY8w0cy389Zyc1wKbfrOG2?=
 =?us-ascii?Q?B8yIeVRejlh3eKFqUp1ddcPzZjdWEdfT8XregARaG/bSzvkH3p/+K0hjCssj?=
 =?us-ascii?Q?0CCRjXhbQUdAwcq8VA2ZGpS+iJcCEqzHTROorxcbEVPO5+aO0uLs0ehDWOvz?=
 =?us-ascii?Q?QgtSayumb31gl5Q0Dk9JWTEj88+iclQZpGfy+BYA5vdStAPn21LzOh3KRJ7/?=
 =?us-ascii?Q?GdXdHdxtPi0EZU5LcR3VFzyDxVog2xU66TtSwKy2JPNFNbyfY91M8qbHRI0m?=
 =?us-ascii?Q?BQyBF1AYEe0oC95Uo0lYWNxJZ1SIBd+99KyVFZBGfylTbXZ6TwelVv/aFfJU?=
 =?us-ascii?Q?ZA+I4pqqUpRc1N69old6Mm4XYuIeu3ZR55f4OTaYqlcs8YAJy/FB4fVQPDqk?=
 =?us-ascii?Q?mz1bzx92qN4omQ3uA7G9RB965dAzh2egZJ/NRqBl6SmpQd7pChSdagMh6dxi?=
 =?us-ascii?Q?Vp9usZ0fpz8ek314ah4wDGjcR1RuKcUNZCmA/14WwpasK1xYKJwfHmbQykYf?=
 =?us-ascii?Q?tnGGgUn9M8kpGdKG3Q05e1UEgRKGeqJlaS9nATUyXcAJS7J8kHVb4BOnT2J2?=
 =?us-ascii?Q?VxRXGH8fEQYvj98v6ImEmSFS04ye9j6myZSC/bqs1Wl2KFdMIIad/fVlNS3V?=
 =?us-ascii?Q?JYAwr7Typdvawgt/SovY27cqNI6NRcZCwtSJIcZ2sGRPej7rhnDJMSRbV672?=
 =?us-ascii?Q?cLtIJY91BngKsDZpuRWn8NXmuANhx0lUlrVwyDmqGklQx05XBDTuuKNyRQhn?=
 =?us-ascii?Q?GSkNBHshqb6++D2qxoEa1ey0fL0aiIPt/jRr7YKNRkrTr0ZaFOZN/aZvuNvW?=
 =?us-ascii?Q?FC4ad7We6VNaI+GEcenbJZa5xRn9gQioqZY6Ub8S?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d92347b-9af6-4e77-efe1-08dadd815a46
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 03:14:46.4433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q66a9ZR5YbF9T3DlhAHyWhOPG3T/JVObXWYqkOyK9w8wzdYnqkL1qGnYQ2msz+R6P1+z1iY5houTxg378O1ZJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7761
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

FXOS8700_CTRL_ODR_MIN is not used but value is probably wrong.

Remove it for a good readability.

Fixes: 84e5ddd5c46e ("iio: imu: Add support for the FXOS8700 IMU")
Signed-off-by: Carlos Song <carlos.song@nxp.com>

Changes for V3:
- Proposed a separate clean fix

diff --git a/drivers/iio/imu/fxos8700_core.c b/drivers/iio/imu/fxos8700_core.c
index de4ced979226..7b370bd643a1 100644
--- a/drivers/iio/imu/fxos8700_core.c
+++ b/drivers/iio/imu/fxos8700_core.c
@@ -146,7 +146,6 @@
 
 /* Bit definitions for FXOS8700_CTRL_REG1 */
 #define FXOS8700_CTRL_ODR_MAX       0x00
-#define FXOS8700_CTRL_ODR_MIN       GENMASK(4, 3)
 #define FXOS8700_CTRL_ODR_MSK       GENMASK(5, 3)
 
 /* Bit definitions for FXOS8700_M_CTRL_REG1 */
-- 
2.34.1

