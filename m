Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6676404CA
	for <lists+linux-iio@lfdr.de>; Fri,  2 Dec 2022 11:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbiLBKfn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 2 Dec 2022 05:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbiLBKfh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Dec 2022 05:35:37 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on20623.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1b::623])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C48C4CDE
        for <linux-iio@vger.kernel.org>; Fri,  2 Dec 2022 02:35:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BtDd6q2tnZ+NmlNKeISPB+2x8NG+JAZ4ziJ1+PRPqKNl+k7zK87K0siFxbzgOdNGEgpXMNEhfviqPyWNKM/uzWlAjtN2jo0SkOySctDP7vJN0u092U3vSe+VLcHDHwXhET3mZy4aidhPIR0D5TDYU/gw/Ub95jQSzZ14srT/TbI9a3SVmMVSDXLLETfTgtwLMFuihUsZ9QDG3dLGLEolN5ZORwnvd2OsnlgmxAfgxyorz6bpmXMA2YCjswxWGWpSDTbL72NfDu0Lm3kaqbKE2T6K1Tn35rmEmrEHNSCDLqOEoTPJeMpgOsOwyRwQAnw/JGGKlKZ5WSTX2yHvLMqr0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uG3NB5fM20bpaE+wfDR5jgLu+rcXCfh5LG7gGxCFjHI=;
 b=KBoA0qvM/F5LJbnKXqKY/xcE6u0EM7GrkD2PH+XP5SY7t7uK9m9EyqyLxowTjcCMD0hZ2p9iSXnbYd61KBAIKl2F/gkX9vAKJ7GSw5c2HRUx1HqLCpEFxRc6etgGuHBa6nxwtqWLA1f6HgiF1BfhmgtttpmNz18iyTRzOvRNaQXW6eYB1pOVcpMEKqMFVnlFG38Kg7czgnPN3AE7Sj9/0zCZ6hLL6oKGXA+9sAJ996w8Zj99rZ68zStxbBNbxPNTPkE+tY+lsK46mgJrqhV+hY/+CPti/ErDBEPfDr3iQhYncT9zP1oeklnTqRVqYAV1ydJ/LdwLhM5hy5Bav7wxEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uG3NB5fM20bpaE+wfDR5jgLu+rcXCfh5LG7gGxCFjHI=;
 b=cPtQULHSJlLsu7wESEglyRr7aHLXV11SCGwRVsHI6LuyirKeIrZphTpnGABBqkP0siXP7Tkq62s7+PQIGZP7VI3jhtcowdaqZIm75OZYNqQzJrx6Wyl7gff5/VPI6Wf2X5E7foeYY34cbRZttd2ipCFIPjbRJvOeNaHlChtYHaM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by PA4PR04MB7727.eurprd04.prod.outlook.com (2603:10a6:102:e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Fri, 2 Dec
 2022 10:35:33 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749%3]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 10:35:33 +0000
From:   Carlos Song <carlos.song@nxp.com>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     rjones@gateworks.com, Jonathan.Cameron@huawei.com,
        haibo.chen@nxp.com, carlos.song@nxp.com, linux-imx@nxp.com,
        linux-iio@vger.kernel.org
Subject: [PATCH 3/4] iio: imu: fxos8700: fix ODR offset error
Date:   Fri,  2 Dec 2022 18:35:37 +0800
Message-Id: <20221202103538.2218925-4-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221202103538.2218925-1-carlos.song@nxp.com>
References: <20221202103538.2218925-1-carlos.song@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::22) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5005:EE_|PA4PR04MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fac87ef-3ed4-4451-f3a2-08dad450f106
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qli76QqK8/1XyCzBCk1QsLx+JL3szUm5bzLKAo6C1woiYHVfOIUndAa3Tv4MvgLawna2yuvrsKV5kczTdiA3eftFgNds8NVM/ytZNHTlrcgRVIyPVcYDV1a9bvL8Ft/OZrzHBCos2ptbhuzn/e9EEMYXL9m4BEddOXyY6jfG2GUamXXYAVUmG9RIQXWlvNsfCSClcnBrPGDDP2C7oE+8hf0x8HkVW9IBfOI2oojYE3osUwkcqc3503r4DI5OtTwTAk5odFLGqI1VDX6D1AelKlqKlYeAP8lueknfS9c5mFqYkL8KvG5DtSK+haqeRmUHred+yGFVpoiZFDdmnFDteiJU0lFUVSODt9a4JN+i1lluTb06Kq+Ijf86cP844BUtyfphhm69ccNKq9yiDpbfmfbTvmLbw+dnQxSIoslsXxtsdLkKUqLEdRAn0s3iC+YBEqsURSYirVVugWE3kn6ptNlJ2qdPoFnGY+LDY5CrtrUR6B1FRWLRJsJnFeqSzECLYYMpGsQYOSkSX+7KLrunDDfeb7o97wfp42lLkHereY0Jb0rF1OQoQVD3X8EiAYpiqwrfRo8PLBQXEdIpWmHHSMhTfqUb1jIKxd6TMqK5WEc10eZWxQbvy+n1whO/Nz4G/2js/kl09LRCf1ZOxV76h5/JFXOOYR4Q8wZzhJ4yceS2cifLq5Sby8Kc10ql4WHaRXoqwPqIcSQ8+6L9DDerLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199015)(52116002)(6506007)(6486002)(186003)(6512007)(26005)(316002)(478600001)(8676002)(66476007)(4326008)(66946007)(66556008)(2616005)(41300700001)(1076003)(8936002)(5660300002)(44832011)(83380400001)(2906002)(36756003)(86362001)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vX8rM9fiEvFdLXKrx2ERWxfJF5JrpaENVnYTPo6hNBCSQP1LrrvDVSS49qzN?=
 =?us-ascii?Q?BFbkF9NCa5662tvIL72uDiAEWYuFr4rCyZ/p8vT/JAy/uwT8KWWDusAwt6Bu?=
 =?us-ascii?Q?o+42lJ5zlxerAToJtlZY28/hGlik/DrDm2mgjq/97+aaRMIIKfmEbq1XT0YS?=
 =?us-ascii?Q?AMJ706Ab8ek+7gvoU38Ey1Lka30W8LAzuQ+c8BiEjPTQ9KlBVu5mIAegOgC9?=
 =?us-ascii?Q?yaNGn7zpdO3PLp9DZ7qIZEWDUI6UpI0aAU833+Zp9HkZoASZDDxsu6DTQ1Nv?=
 =?us-ascii?Q?/ALiXC+H8pZi2NLO/qdsdi5SGYMZR4O9VoW7Jndhn6gHIRpkTuPFg7iIOKcT?=
 =?us-ascii?Q?qamqO2JyrFpnfSUI1iFFCUVo+ji52WFhSrGHAFCt6o3oWVddHDKTfKs44KJR?=
 =?us-ascii?Q?e5yIlF2CxiNZBazIDgqTrt0vH4aagzAeBkPBlwDB57E/6q+YVznSmACW0s6w?=
 =?us-ascii?Q?IVhU43XwVHEnddAlV2gvhNEUKJ5ZuxesKxncGwY0/H1ErBebHsddBzsPTabY?=
 =?us-ascii?Q?1yXfhkEBdCx7+c8E6cMRIp014t8hwXjPffek77OrfB4Jv/U9POWd83pih6Fc?=
 =?us-ascii?Q?KW4Qh18Qyhi3XQc7senZHrxp8kKZHei5ZnMmwP/HJd+P/b2U7GQU8f4Ujb4h?=
 =?us-ascii?Q?xBOCj9besJkwotUooTNKSKGO7KBrqeTqVC5i7zUro1/6sWkeWBks83i/wF0H?=
 =?us-ascii?Q?QX2yMQg8jkqVRb+/YCbdmzYIfxaewIj2kCMdp65vtlg9tqM5Nc5y3HqMaRQ6?=
 =?us-ascii?Q?Scy8DuARe8KygB0XPk8onvReWsYRN4h0KP6emvGsYJbcaIBGp/9/KmwrJnCO?=
 =?us-ascii?Q?CfKTXq4u/tvbubkWjnpYARCriL+WXd8qlh7J3CvB5AXrDr8fiVbeaIN7hQp3?=
 =?us-ascii?Q?X2+6lTdXd6hBJ1X7dO+ueoN679M8EjmPzHWutVLNMkHdVOvvxuG4gpMo4qPG?=
 =?us-ascii?Q?SiwzQ2MgMasbbG1egjiblc5XSXFAZWd/wcsfUNXpB+li7m2gQyerFKNCpce8?=
 =?us-ascii?Q?+nJxoivEtt8ujTmbRLXDYIbx3WcKPGM3xXwE8CkoWgFxIQ6J29fQQbAkQmRW?=
 =?us-ascii?Q?unYxQaTI5GYA3CQQbowt0dE0wj25GN6TcpsXWfl+8tvWK4YQzfZC8FqzURWu?=
 =?us-ascii?Q?XNCDpxF23qVQjEpSTc1oTpZzDIc+rh5mWBVYsQKj1n6qV2cb996tChM2t/2c?=
 =?us-ascii?Q?VvhVTZdPisValDgHIpVbCcZLi84oEIwTi1f1KK1cE3UhEdBokVZH49uK7er8?=
 =?us-ascii?Q?N9GQ9RhLSynjdzNs550GadimliGz2i9jJT+W7HBGB4SKbj6tVXFE9UdCPI8a?=
 =?us-ascii?Q?h7Seu8MvdksYOLwe2RrMkXq6if/oH4CDkrARSFDbN4ndSHwcQBpFmjMmUg5+?=
 =?us-ascii?Q?jXckRTXqSymrm57CUGFSbQ2iDH7XMpPznerFYhkXe9QvgwbZmlSVfBrejDc/?=
 =?us-ascii?Q?o40NPY6OQ0sxXbM+gfd7WfQvkx074aU9/zaI6VNiVL2dvLVzRZmA0y9OJZgN?=
 =?us-ascii?Q?WelWvGQtMJL1u/y2dTjIxDTec7qEATArMYC+XU9ya54g2anCoqH/d9lAWCXA?=
 =?us-ascii?Q?sYwryNKb44RhfuU4FAePq3dySs06BauZ9GltRMyI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fac87ef-3ed4-4451-f3a2-08dad450f106
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 10:35:33.5239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: myF/KtwmQUgVn1uR5G3tucQgwDLjRqHHohAibsP8Uy/CDWxAZM+BUC96qwW7d0GBhUWbwrFAm8Pg6BR9GiRnQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7727
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,T_SPF_PERMERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Correct offset of ODR configure is needed when configure the register
and read ODR data from the register.

Give the correct offset to value when configuring ODR bit and
reading ODR data from CTRL_REG1 register.

Fixes: 84e5ddd5c46e ("iio: imu: Add support for the FXOS8700 IMU")
Fixes: 058f2a09e645 ("iio: imu: fxos8700: fix CTRL_REG1 register configuration error")
Signed-off-by: Carlos Song <carlos.song@nxp.com>
Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/iio/imu/fxos8700_core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/fxos8700_core.c b/drivers/iio/imu/fxos8700_core.c
index 60c08519d8af..27e3bd61d054 100644
--- a/drivers/iio/imu/fxos8700_core.c
+++ b/drivers/iio/imu/fxos8700_core.c
@@ -147,6 +147,7 @@
 #define FXOS8700_CTRL_ODR_MSK       0x38
 #define FXOS8700_CTRL_ODR_MAX       0x00
 #define FXOS8700_CTRL_ODR_MIN       GENMASK(4, 3)
+#define FXOS8700_CTRL_ODR_OFFSET    3
 
 /* Bit definitions for FXOS8700_M_CTRL_REG1 */
 #define FXOS8700_HMS_MASK           GENMASK(1, 0)
@@ -498,8 +499,7 @@ static int fxos8700_get_odr(struct fxos8700_data *data, enum fxos8700_sensor t,
 	if (ret)
 		return ret;
 
-	val &= FXOS8700_CTRL_ODR_MSK;
-
+	val = (val & FXOS8700_CTRL_ODR_MSK) >> FXOS8700_CTRL_ODR_OFFSET;
 	for (i = 0; i < odr_num; i++)
 		if (val == fxos8700_odr[i].bits)
 			break;
@@ -636,7 +636,8 @@ static int fxos8700_chip_init(struct fxos8700_data *data, bool use_spi)
 
 	/* Max ODR (800Hz individual or 400Hz hybrid), active mode */
 	return regmap_write(data->regmap, FXOS8700_CTRL_REG1,
-			   FXOS8700_CTRL_ODR_MAX | FXOS8700_ACTIVE);
+			   FXOS8700_CTRL_ODR_MAX << FXOS8700_CTRL_ODR_OFFSET |
+			   FXOS8700_ACTIVE);
 }
 
 static void fxos8700_chip_uninit(void *data)
-- 
2.34.1

