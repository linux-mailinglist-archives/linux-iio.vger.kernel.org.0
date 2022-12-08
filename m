Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A905864699A
	for <lists+linux-iio@lfdr.de>; Thu,  8 Dec 2022 08:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiLHHSy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 8 Dec 2022 02:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiLHHSy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Dec 2022 02:18:54 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2057.outbound.protection.outlook.com [40.107.14.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A05242981
        for <linux-iio@vger.kernel.org>; Wed,  7 Dec 2022 23:18:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTNDTRAXeSbBE4nm29HL6+itUt1Ar+9uvv0Gnj1GqdvpX309UikhRnLppDi18RBEIpHBt8jHUYrGeGF1/5sRYEmMkwtNEyl6PY1B6HpqOHSDmOEh6gZYpM/rO2ARMjfabrJo/93uVlfl53JcNX0oM7NPoPxYqx01tMaYTQA+bPV3l+fEEEs6MsL1XHnT9FvXuwm9eN7bo5ZlMMwicOqJdFS/R1dBHIEK5vmGKPpN/AopBzT743Os7mctsE36Trwg37pBBXO4Dv+MWEe1Xe6KGf2Sf9iXfYz4LaAoflB7FGgbfpWWg0eXBzAcbaK81Ell1m4GaHTsa4neWmAQDJEkog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XDdley4IlanKxj3qvEr4kqBic0jLOzQbO9sfUCRnVxw=;
 b=kqLMYHsIsqw0IaL3xcr/6WkyvtHjuniB2K9IogJml+StFMSHzacxs32MAkicTetdeVwsAu3eaYrl6tvSKw1gjhHTRIt2b7VKoIHt3XR85QMLJztvwetWKsb+efap8mOlhbrJ6ar/4jZGtdnJEmMwJaUks0tQf3erE1JP+VxKwZjYF3LX28vMUb6lbjk5vg+ACJ+J/5eYGvQH9thxAn7e+v2xn6H5DvAyfKtPyqSXfbC/VhiuKDWNKV09p08zG9uYJ5MI69z0EowRmKPTvoO3lr6m0EE30BOpHKNnBr1imk89LZCPx3QQzbuzkAzi4ndfSh+f7z4sE5Pwgi8hBM/fBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDdley4IlanKxj3qvEr4kqBic0jLOzQbO9sfUCRnVxw=;
 b=M2oHKD034+0WfmdKqwihFih7zNggszsWvoQYng4fz453PaYyvJlhJtKNttwed3RIYpdTkg/vEJilol+yWt0G+/sKr2EUAtF6c1vjK8BXIEJQnbk9ZXkfBe/efg6+VPk8z+ZSLUQtaa6ysHKNGfrbVGiJdLWcwQYX1/EJcmxikcY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by DB9PR04MB9701.eurprd04.prod.outlook.com (2603:10a6:10:300::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Thu, 8 Dec
 2022 07:18:52 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749%3]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 07:18:52 +0000
From:   carlos.song@nxp.com
To:     jic23@kernel.org, lars@metafoo.de
Cc:     rjones@gateworks.com, Jonathan.Cameron@huawei.com,
        haibo.chen@nxp.com, carlos.song@nxp.com, linux-imx@nxp.com,
        linux-iio@vger.kernel.org
Subject: [PATCH v2 1/7] iio: imu: fxos8700: fix map lable of channel type to MAGN sensor
Date:   Thu,  8 Dec 2022 15:19:05 +0800
Message-Id: <20221208071911.2405922-2-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221208071911.2405922-1-carlos.song@nxp.com>
References: <20221208071911.2405922-1-carlos.song@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0019.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::10) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5005:EE_|DB9PR04MB9701:EE_
X-MS-Office365-Filtering-Correlation-Id: bd508c77-75ac-4fdb-0265-08dad8ec7533
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LhRHOlUxO+1U9f7zEoIU9DGPhbAlcoO6eHet1HAwwHQ4xsyZ5LvbGknFa/slDh0fSvek4N0YEheKI4Fo1oCRJOK2VfPIgfKWBAPXSPDIiTRaA6ZPY19LIcqKjEEFNIbXskXDsGy7SAXPatCDSpWfsLNbglNhuzu8uwtwbAaGEu6Fc/iskmkz6a+T5KM2CMLbPqtjlndoEJA+pKbijKsp5xeNs1ezRlEp0s98D9DQ7ps5iHkT3c7qeNrwzImZs2FxbjQRKSjNmloeQeChyV1qclHDRlgMc/DSxLoOaa/4R3WHr+QnUbUD5z9vzAnemCsLDCaNVsvVDcBpe30Woc43JH07abNnjF+aGk0j02YIzuS8XHM+uDEmOX8tYHXqsvOLbJjywOLUI6RIpNMU6ShDszdkORYBjDiGM9YHWncDVkNdnD3oZrFfPouLxodX/babCDU5uLoYnJeQTsqHVSd//7Vtl37C+hScavWTTDNTs1OcWyDRvhBD972ZSrGZuZsPWPY9R6FyUVzirZFJo6d1us7VgMpWCjLpOqqo+DPZJOajkJmjARbD67XYI5gpNBt6yGkPO0eMwW9fshdegOeVcm98FVilzT2gIdRL4iwSga5fKy+z3vKhRKdZcQ6wort/1oNkBxvARF36M0jxI6oxcud1G219LwCvwmULTFeiM+JSNw/q7UnUufYptYvPhzIgNXYuCCCUR5ZMgRjj5AhowA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199015)(36756003)(6506007)(9686003)(316002)(26005)(2906002)(186003)(6486002)(6512007)(1076003)(6666004)(52116002)(86362001)(66476007)(8676002)(38100700002)(4326008)(66946007)(38350700002)(66556008)(478600001)(2616005)(41300700001)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mO4z6ijZiCljY12VzElUBtaUHQ4EUmq+n5h1zvPsa/+z2NW1sNtj2MQjg8ZW?=
 =?us-ascii?Q?97QfLTbdwECQHfWdkRj/Wzhm3bBPRnt8tr5ANxYAdlO2aFU5sALnbjop/DCA?=
 =?us-ascii?Q?Ec423KPBJrvp51cuKSkKlu1megMOr71uedv7WbKa3YWrBKBtXP+Nk11RN5BK?=
 =?us-ascii?Q?IK4hS2Zmz23M6d+exz/TJZKQnegXz7gGeWFV0YNkSaBOEev9ISoH1XodYYrq?=
 =?us-ascii?Q?8HzAWMrUIpaOAKdIR/IR7swPyCLpzSyJABtvSnoHTEtyaz2GWzQPXi1kwMYS?=
 =?us-ascii?Q?ouY7trQVPM2ExMoqCYfohmb821AOxq7cXT2C9dTMKV/FOJ2A4sGD5v25A2MT?=
 =?us-ascii?Q?h+YUKa1uPGDQ6C9/IMgbD+g8rfCXkXmwTWVeXFTRsEFIdpHzXp8iNlQ2CW/a?=
 =?us-ascii?Q?2pG0Ghl4ukxdEEsVXaFI2+7+wyRUJyQAN5vQtmwZSeE8oEneNAbMngRmah3D?=
 =?us-ascii?Q?GvDrgwHvVtaQJsRvS5AX9Rj3FvOwmQwhD0Xh3isCVa10LodJnEDpLi/nZh2P?=
 =?us-ascii?Q?94o02MTzEKBblpzg73y0zrMqJugELgQvK07eXbRk/mbT35OqnQqTUqSt/vkO?=
 =?us-ascii?Q?4inMPYT0LaIfG97coMzPeP2M/+1dTzrFOxJwtRjYFMMr5q7hBXaymoJZvLyS?=
 =?us-ascii?Q?CPE+cNChuNy8d7E9flhmBtU3aaLUyGfDi6gyD6d1UtByLO67zhMYbubk+7md?=
 =?us-ascii?Q?R2BQyDITnDz763B7uBim9poS4nrcSBdentlODBwEnwb4UhGTIkYo6HT1ff6C?=
 =?us-ascii?Q?9BXtEAiKYuT8v8kaf5eZLp3H9dfgta+LZWu6KWMu/KGYks6oggXzIkGz+9xq?=
 =?us-ascii?Q?F7AazmIPZG2y5Gzk9cvIloMJBPycR3Mo6elESzMhJGXfvLhNKtk2vlBPDOIM?=
 =?us-ascii?Q?T7wW4Z9bDKcWADqVLqfUmAcAY4oPcdM2XAm/FT21/LtXoRoqY5bXNTgdHwgY?=
 =?us-ascii?Q?T2QkiwPoCuVIbxLo0f3S1ezEULOfMqKnCFBe1hrEwCLivB0DVcWmlTqAQJzR?=
 =?us-ascii?Q?k/0v6RzK2yZiSELM10sUwX0eqLuDByn/4SDF8eQzdHPnQuaK8DL5RuWcNq5P?=
 =?us-ascii?Q?yN1gr+1wcqCUXWbucHvRhivINNglPxD0UkWMgGmeQUaZbjADSeLFT9OGy1xf?=
 =?us-ascii?Q?JLfVdLsAczhKrFprTOQeGuhxL5B/sN+4wB/2IOLMJ/6/vhcT784KqSIdcKPJ?=
 =?us-ascii?Q?cSV7tKUe5UcGCO95QSgAxSnhVGfZtl2oTq8/2SLMvGzNtyoBkepPOyAdZ7KT?=
 =?us-ascii?Q?BSi1V9UVOg7Hl+A+desMg6ebRVmg1GLzrJt9NTw5eF0cc90vcLCWctQZSg+t?=
 =?us-ascii?Q?cGeAw3BWCdG3MlUD0NtVkfqt/dZk/oaLjY+cgpWS64oGcCvMbr6eDUXtftlc?=
 =?us-ascii?Q?1vhI7yLbboSS4dYQB5QyT+rQ31NwjDjvmJWnSAz8XI8x4GrHTRFDeAm7Mbkd?=
 =?us-ascii?Q?DpspUY3M4bh1DwdoOQwCc2iuJBLViB2lTwPylM0iARZVQN2wgL7khz7YT3Oo?=
 =?us-ascii?Q?IzHDnXvXecX8G8Yjh5KdfL1u2vOtqWJFTzlxQxF/SxQxzzq9lPkepSBD5s1S?=
 =?us-ascii?Q?tbKkmBty2gOWMiRUtoJJPPwJ6zb5yPJzgXbwtIe/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd508c77-75ac-4fdb-0265-08dad8ec7533
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 07:18:51.9629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pQ/Ki+VQVS5cw9vp45VqF4YpCPZEeAGbo6fugUHm9Cx/GoKrj4E6iWocARsrBvSxLKbb/TwLmzaB7IaP2J0NNA==
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

FXOS8700 is an IMU sensor with ACCEL sensor and MAGN sensor.
Sensor type is indexed by corresponding channel type in a switch.
IIO_ANGL_VEL channel type mapped to MAGN sensor has caused confusion.

Fix the mapping lable of "IIO_MAGN" channel type instead of
"IIO_ANGL_VEL" channel type to MAGN sensor.

Fixes: 84e5ddd5c46e ("iio: imu: Add support for the FXOS8700 IMU")
Signed-off-by: Carlos Song <carlos.song@nxp.com>
---
Changes for V2:
- Modify the magnetometer sensitivity unit to be consistent with the
  documentation as 0.001g
- Rework commit log

diff --git a/drivers/iio/imu/fxos8700_core.c b/drivers/iio/imu/fxos8700_core.c
index 423cfe526f2a..235b02b2f4e5 100644
--- a/drivers/iio/imu/fxos8700_core.c
+++ b/drivers/iio/imu/fxos8700_core.c
@@ -320,7 +320,7 @@ static enum fxos8700_sensor fxos8700_to_sensor(enum iio_chan_type iio_type)
 	switch (iio_type) {
 	case IIO_ACCEL:
 		return FXOS8700_ACCEL;
-	case IIO_ANGL_VEL:
+	case IIO_MAGN:
 		return FXOS8700_MAGN;
 	default:
 		return -EINVAL;
-- 
2.34.1

