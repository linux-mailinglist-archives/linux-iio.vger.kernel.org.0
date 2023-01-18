Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38056715E7
	for <lists+linux-iio@lfdr.de>; Wed, 18 Jan 2023 09:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjARIN3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Jan 2023 03:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjARIMh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Jan 2023 03:12:37 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2050.outbound.protection.outlook.com [40.107.8.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C804FADE
        for <linux-iio@vger.kernel.org>; Tue, 17 Jan 2023 23:42:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5E0ozthu0D0AIo64YZp+szEVZXqytH07mlWIRmIhozTRtulElzS+Xv8aUToMUQL/jL/xe40wreWIEq762GkQtqV6USzpTPI75DmYddqADrjlD9ql9Qz2KUIYCcZLDNB2QSVnFoevHgjjIdcIy27R2B3muQ449FN/Q9jDSFEFioTl/q+BbF3wJli51UGaKkb+C2CYF98FjnSx4rqrUTTxarO2X+lWZ3NqLyPb4qp71G9/VqJ7AlvAcTWKIAgwKxoozlDpdN4wCD0ouSo7X21tctxGF30gl/yUrD68wglOCspcEIU+kNr3s9ZWTmTnyANFvh73b0ZizH1D0wsn9Wn5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OvpeXbuCzi1oPptG/ArvS0+HyY8Y1AY5JNrCQeTVfjU=;
 b=TvcWiminh2LhgigKILvw3iW2Rm9PJda3tsUceiBrE5quQO7/uXjS1NS/6zUbOVm3HYMtk+BQpZ4R5u/1akVVir/26TZ9SK9JdV7KGrgLE8AqrVDMVVw/SS2izaxtMyxjclfKN/OYwKndihV1qyRVk0gZFir/kyczBKTCwfSzIANj4bm+qaKzUJ/lGF9V+LPztGaTBAo5tyNtbBv4rkUlwNFe//sxtu5NuLel5fZ91JCL0XTjLtbUh2XkA+GEC6ufl0fV6XOBU1/ULdaqIFoWRGUjiW3ew7jx+mUd+H4twJnDqohSHKdUiZt4QGCHMRts/bl2YQbf2U6x1BLb2awnOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OvpeXbuCzi1oPptG/ArvS0+HyY8Y1AY5JNrCQeTVfjU=;
 b=YkZPc+6Hi+pPg8ykl0zSNJoDNCVTOQVsEDjwZSXT31/bQxHH6O2Qo9HmxqG/GmP2XDJmg1IdPC+2liOSSRGOyWTAc+R2GK2893eVLeIgc1WsjGfgrd2VY/PF/ALwxOQJBc+9ztbt2Kvtg0OqDm+DQ5/45fDkUeolBKnyi43FOcc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by VI1PR04MB7152.eurprd04.prod.outlook.com (2603:10a6:800:12b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Wed, 18 Jan
 2023 07:42:02 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749%6]) with mapi id 15.20.6002.024; Wed, 18 Jan 2023
 07:42:02 +0000
From:   carlos.song@nxp.com
To:     jic23@kernel.org, lars@metafoo.de
Cc:     rjones@gateworks.com, Jonathan.Cameron@huawei.com,
        haibo.chen@nxp.com, carlos.song@nxp.com, linux-imx@nxp.com,
        linux-iio@vger.kernel.org
Subject: [PATCH v5 1/4] iio: imu: fxos8700: fix incorrect ODR mode readback
Date:   Wed, 18 Jan 2023 15:42:24 +0800
Message-Id: <20230118074227.1665098-2-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230118074227.1665098-1-carlos.song@nxp.com>
References: <20230118074227.1665098-1-carlos.song@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0106.apcprd02.prod.outlook.com
 (2603:1096:4:92::22) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5005:EE_|VI1PR04MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: 434ff97b-d278-4244-bacf-08daf9277cdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mT25ow6LH6cn4xDfv9mjJtBQnebSGyqHLkdOFGV3cpR54lGaOYYu9sutr6MelCmjzSCXsAToeW1Zcmwd8OsaeJpI5NA7ssqUnXseVo3ZmaEl1++uqUeiBuR4qcm5jFxC75saxXicDQrPUzpw9YYnpS8/4+L/8VSV81tx+AHubYkRrESasS7LEhCvxz2I4BVVQxDhP81udXAgH9TkZhIFujFavOkKpgT6CDM7prHIkS0ay2QQZsvbRBHa/lTPtcC6dGI7oPROWJeU353HSJehcQIrz4QtW1tYzOOB04zwcDqecyiXnljSiuUVgAbFPn4bu7/F0/SA7NZP17IgLO8h7axmHEWAZQ94wlMz8XEQRw5JwXiUP/JLzTIgqkj8A91zHDf+aoVCgoxHe41WeEGvoYbKP8P0jKCenfYxBMtxSGlFik0JaUXGwmKGGZkSt6e7HbmcOEvyhPLn1usMrtWLzYJ1yEBrhAds1xMGPj9ZzkFFmi9AjIfuD4RIAduuQkQszElxCqt19fBRMM12eM76rMaPr4nO49YUi7gSlr/KXDQH5unUXhwaImmw16n01H+dJuoZ3yRyNpg7UL8Ep5KckNKIn0FcvIRZRO+Mk4I48KZq6TEg5njj9P8EOJYcou2z+e4x3LM0rKaNN+XP1Aubl/zKcvpMT4uRscRmASILEpxNhxfbeGkOOx9TnX2a/bVE6NbyJEGDTfUncTtBAUSkUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(396003)(346002)(366004)(451199015)(38350700002)(38100700002)(8936002)(5660300002)(2906002)(66556008)(66476007)(66946007)(8676002)(4326008)(41300700001)(2616005)(1076003)(186003)(83380400001)(9686003)(6512007)(26005)(316002)(52116002)(6666004)(36756003)(478600001)(6486002)(6506007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pGrsCjSEEfcD9xpxPPnryba5pNAlUVR4WFD9+nxng4vvARDFt42JP2h3GBUW?=
 =?us-ascii?Q?DW3b+zr1VtQ1K3wEQXM2SStr92qWCk1IR0WQp76f5HJ6skXiJ4F7/+CsqSZY?=
 =?us-ascii?Q?em4G6Wu/W1muzzcvnyLoMpa38JD1YmtqJeJaSK4D9a1++0/iCZOws1pl9pZg?=
 =?us-ascii?Q?Vqur3ZY+9oiKSQoYbx8EAkfd5dWf9Lj15y26QbLAfstdZz3WJD9w3/UZop5G?=
 =?us-ascii?Q?gSQ7dwETYL4XewqUn/sK83/Bk22xk2VMKu9dawmadyMjXRm46M1PJ5+sCS19?=
 =?us-ascii?Q?yQs+XjN5uv9Koq8ClZtpUt04CP3A1EgsJUJgkaYuARhSGVZoMg4T0p3tySBq?=
 =?us-ascii?Q?EHMiEXoF+CFiENWkRSFYZ8SJJJQwKwcpYsSm8KkI2L5rWQDh9aDuQICnHiup?=
 =?us-ascii?Q?lH+K4DPgqfFDHfJQgu88Ax3Ir6fbJCzIqd4TSUthcC/oTGupkIvAqvCFZmXz?=
 =?us-ascii?Q?ygSNYGbTUhPvEd77EcNNQRxZaUR+omKi3GszdoeFsz4nqS1nMmGMPi17p+qt?=
 =?us-ascii?Q?fYa9r7HoPek4gQFNYl87jowB5SyoYmT8gbu9Rs8bxGTVUiF2Nsjry6EymzE6?=
 =?us-ascii?Q?7o9rZvWWzdlh5PWRkJexjEfazLM3rzPMNDlOYwAkhK9pA55V5EI/csj764T2?=
 =?us-ascii?Q?tJQnSyfmCp52xEd1iSB94wILSMBNK9dqWQYXHfUr+qc6POu1bzBh3LX5QL/s?=
 =?us-ascii?Q?qHODGXZ9MJ7Jh8BVqNmlibhYn4vIOnmLpDuqralibitx8ar6IO76myr8rKMz?=
 =?us-ascii?Q?9Ra2og3aa5Qlbc/vlMVDYqWcEQ+vFl0eo/EgyDEOGUjibIawS3GW2isJE60J?=
 =?us-ascii?Q?FSQlo0Xmxj/FK08kG9hP2+CWs4piC0gpdgoROuyC+9ooMAI1rblTzPrARMsi?=
 =?us-ascii?Q?BzjHjLIPxHTcMid/uYtzb5RfGhDNEA/STnWvZfVtrnA2AdOHu87g6M7dX7LT?=
 =?us-ascii?Q?YeMesFZ3LeIlEE8W3a0+tH6TQbNOL26cP06ofjNcyt79fBWEqqauffBSkO5X?=
 =?us-ascii?Q?fL4F1Cgu45Po2uKgvEiss9/zj7oiHM5Yu8lCXz2xh4E2NaherkB5Z6sybJl9?=
 =?us-ascii?Q?e5caCyuoYWni05kPLzIIPUjoQGftdIHY5beCJO+KWl5/XLkgMuN8/uAPI0lD?=
 =?us-ascii?Q?ASZXIoN2EK+pzQ/DD9pyDekAXWDRRw23TO0w80bwcHANhiXJJY2Z6sSdEaIi?=
 =?us-ascii?Q?4f2GPFcNtQXAeOgPSKogUbOH6ySOGix95pjv7RqlCGA7zm9PCg9DVdSpfy2E?=
 =?us-ascii?Q?uPn+7cYWF6oeYoT2xMa4Id2jdNLBFbH5oXiTAsypm8kLmaE361BRF829wSMj?=
 =?us-ascii?Q?2+39g9CDesD7gXVI1W8behfXrAg9AkfixxiqYHAz8DBe93Wn18j/sIBdId+m?=
 =?us-ascii?Q?YaVyQcvih1mrzHlUoI1nNdVg67gnc+CJC/V0IKWc0CCov3o8jGJQHnrw5Wjr?=
 =?us-ascii?Q?xqE1idwWsxNQzQwYEx/ldvy6rXA8wGeEOb8UkUnzWnCMi8YzvhNy5cgolXYA?=
 =?us-ascii?Q?99UvfT7SYd3p1E8dPUhw6PJxaKuGIrMFHGyeZFP622OfpacBGaMWiCzwIMM/?=
 =?us-ascii?Q?qOeV65tO7TQth0cv7nirzKVkyaDwxd6sqKJ56jTG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 434ff97b-d278-4244-bacf-08daf9277cdd
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 07:42:02.3105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h3KktHPmb33nTTk7uB+zOjqcQ7aDVdKof2eKTf1VkvoMEAHQcQfayTCsNJCZq6D+GL+Nfb0WdmN4opJY6k2Tjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7152
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

The absence of a correct offset leads an incorrect ODR mode
readback after use a hexadecimal number to mark the value from
FXOS8700_CTRL_REG1.

Get ODR mode by field mask and FIELD_GET clearly and conveniently.
And attach other additional fix for keeping the original code logic
and a good readability.

Fixes: 84e5ddd5c46e ("iio: imu: Add support for the FXOS8700 IMU")
Signed-off-by: Carlos Song <carlos.song@nxp.com>
---
Changes for V5:
- Correctly use regmap_write and FIELD_PREP to modify ODR value and
  activate device in FXOS8700_CTRL_REG1.
Changes for V4:
- Use ODR_MSK in the first place that merged the first two patches
  in V3 into this patch.
- Rework commit log
Changes for V3:
- Remove FXOS8700_CTRL_ODR_GENMSK and set FXOS8700_CTRL_ODR_MSK a
  field mask
- Legal use of filed mask and FIELD_PREP() to select ODR mode
- Rework commit log
---
 drivers/iio/imu/fxos8700_core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/imu/fxos8700_core.c b/drivers/iio/imu/fxos8700_core.c
index 773f62203bf0..419039d3fe86 100644
--- a/drivers/iio/imu/fxos8700_core.c
+++ b/drivers/iio/imu/fxos8700_core.c
@@ -10,6 +10,7 @@
 #include <linux/regmap.h>
 #include <linux/acpi.h>
 #include <linux/bitops.h>
+#include <linux/bitfield.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -144,9 +145,9 @@
 #define FXOS8700_NVM_DATA_BNK0      0xa7
 
 /* Bit definitions for FXOS8700_CTRL_REG1 */
-#define FXOS8700_CTRL_ODR_MSK       0x38
 #define FXOS8700_CTRL_ODR_MAX       0x00
 #define FXOS8700_CTRL_ODR_MIN       GENMASK(4, 3)
+#define FXOS8700_CTRL_ODR_MSK       GENMASK(5, 3)
 
 /* Bit definitions for FXOS8700_M_CTRL_REG1 */
 #define FXOS8700_HMS_MASK           GENMASK(1, 0)
@@ -508,10 +509,9 @@ static int fxos8700_set_odr(struct fxos8700_data *data, enum fxos8700_sensor t,
 	if (i >= odr_num)
 		return -EINVAL;
 
-	return regmap_update_bits(data->regmap,
-				  FXOS8700_CTRL_REG1,
-				  FXOS8700_CTRL_ODR_MSK + FXOS8700_ACTIVE,
-				  fxos8700_odr[i].bits << 3 | active_mode);
+	val &= ~FXOS8700_CTRL_ODR_MSK;
+	val |= FIELD_PREP(FXOS8700_CTRL_ODR_MSK, fxos8700_odr[i].bits) | FXOS8700_ACTIVE;
+	return regmap_write(data->regmap, FXOS8700_CTRL_REG1, val);
 }
 
 static int fxos8700_get_odr(struct fxos8700_data *data, enum fxos8700_sensor t,
@@ -524,7 +524,7 @@ static int fxos8700_get_odr(struct fxos8700_data *data, enum fxos8700_sensor t,
 	if (ret)
 		return ret;
 
-	val &= FXOS8700_CTRL_ODR_MSK;
+	val = FIELD_GET(FXOS8700_CTRL_ODR_MSK, val);
 
 	for (i = 0; i < odr_num; i++)
 		if (val == fxos8700_odr[i].bits)
-- 
2.34.1

