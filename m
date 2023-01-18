Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2766715E6
	for <lists+linux-iio@lfdr.de>; Wed, 18 Jan 2023 09:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjARIN2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Jan 2023 03:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjARIMj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Jan 2023 03:12:39 -0500
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2085.outbound.protection.outlook.com [40.107.103.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4074FCC4
        for <linux-iio@vger.kernel.org>; Tue, 17 Jan 2023 23:42:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jIDKFenD4LP+N6kQ5LIl7irZT4UcDuaYgvW9ZwNg3sb7vOAyuXx/1OFe1fg5uzHHgP4ASPyWOlMmLWn4BWSJwGAO/WtAJSzlAJqD3pHtvgCBmh7+GDYkRPOM5pc8cmjh1pdZYN/XwnBjZRu2kkey9gM0aAZ+r+/CwrgWuKOXoUzl2htiNb0YT6winxNkiuXJb33wgo1kwkipcKyIhX9IAFS33HQCqaCgx74zjbgyqnO+Ip5h8U2s/yPn2efv/T1Dev2hsbnkXRGjj4YeEGthby0g07YG2F8pkU8v5SRK6sSmGdrm0UNFv/fOP/7b0qTS+6sN/AH/oyuBAqHf4VF7eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukfj3zuCEA1UWfEg+NMYGkI8vTtvjZRkDC/s+FCyEpk=;
 b=AS1J/eH3PtDAk502HT9e0wxedfntKBu+Y2OuUnAP8RWZlkwJJVrucF2VSySSPI54Iti9NJDvv/6tWP13vikIXH9d7f/C0GS0TnTJwqRVEzHDjlovieiXoR3edVswNbBF/7EDkRxS/d3Hhk/yyo+Sp5EH1CnQNzdvRR9cwlL0ImQL7v/FJTHh1se/qRWjEklWcvxLyu1OZ8s7L/Sk7QzcOJr6+Em6J8XR4f61PXeOEXFdeL0d0kqm6H0vJf495Np94YxddY/8NEQAwJNHS0FMufuytvKyf+f5SdO+MUTq3/m1wYysDsYWaCK2zo5MyQwBw8m931T5ThxnaB7kyl8q4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukfj3zuCEA1UWfEg+NMYGkI8vTtvjZRkDC/s+FCyEpk=;
 b=hb1GE6rN11Kz8nDhzGe5d/S3wEjNcqskwMmctkQ+NeEOwbeF5C3pl7A1yHdCWMaG99x73MmUOF59pGC3owxlxQ7vgXl/zBnG3/czcCYBFUzoriDHpek8WQ6qERIvJJdgLTqyPal2ydY0qi6a1Ibnqs9Caj7y+5FSC20AqQoXlsw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AM8PR04MB7410.eurprd04.prod.outlook.com (2603:10a6:20b:1d5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Wed, 18 Jan
 2023 07:42:10 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749%6]) with mapi id 15.20.6002.024; Wed, 18 Jan 2023
 07:42:10 +0000
From:   carlos.song@nxp.com
To:     jic23@kernel.org, lars@metafoo.de
Cc:     rjones@gateworks.com, Jonathan.Cameron@huawei.com,
        haibo.chen@nxp.com, carlos.song@nxp.com, linux-imx@nxp.com,
        linux-iio@vger.kernel.org
Subject: [PATCH v5 4/4] iio: imu: fxos8700: fix MAGN sensor scale and unit
Date:   Wed, 18 Jan 2023 15:42:27 +0800
Message-Id: <20230118074227.1665098-5-carlos.song@nxp.com>
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
X-MS-TrafficTypeDiagnostic: VI1PR04MB5005:EE_|AM8PR04MB7410:EE_
X-MS-Office365-Filtering-Correlation-Id: 70788d6b-61ad-4c33-f001-08daf92781fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sjiVrvWzmD4361umhKZypv/Yj0scATuzKiB6toFLLfvyUyQ1SEd/eNt1mxpJgw7gaqxwSTc9PBd8jsWsP7ahiRw6ai2BmaSpsvXJ+/jAWakNxp8V9hvdtTyx2joaYNdYjivHqXRzjQlLfx6o9yjRfeNmboroSg0MlfQp1XzshK690032rCKd2IS2ujRBavL3FVPfBmII86wVwxFdP8G4Uck3Q+7yKlEgos6Maw16FxM6uTsKsiD129O9QEuOfSfWiTHVzuYyLYgXBlm5KEP3I0XjxcQdyzrZ2baRV7/AV9wW3jWFYuh19+SQ7h6yMyxy/xddegZLx9rU7hvT8Vx9UpxnQkRnZ5ce3vpEUvxSY+Mj8XfBTNcqSAhqdu1w7205V9/u/5c2oINxMxFBwedCQ1TWZ+KFZrfFac6ITUQr8YAPe+5VE6ZotjiBkP8x0X9X97yE4IUiPemRlBcXgkM1IQaHKRFGuQ86bwBzywXsJJ70NovxvU/fkQhPwNP+vuTAuY8xuB7l88pB/XqLqSuSbgYIEwSMHBzg++y5d0xgZaL1Sfve1dH/OW+xvRhdeUTwtUkGRCxOj3qr9vT1Q7+zTdcD/fUd7OThXYxG3bWyP5XYFk5vYxNwNq7LhoCYJ0URoOunPxGdrF7WwrihA6CWgpSGtllCNQjU0AOIRKTEVicUjcDdn3DPOC4PoBnNIdgp39w9zL46msa5Qw6S7nzYlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(451199015)(83380400001)(8936002)(5660300002)(41300700001)(4326008)(8676002)(66556008)(66476007)(66946007)(86362001)(2906002)(36756003)(38100700002)(6486002)(2616005)(52116002)(38350700002)(6666004)(6506007)(478600001)(9686003)(186003)(6512007)(26005)(316002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CaW68louk6+Ti+zbEDziKH3x3DiZYvMFbim1YETuaOnKDoFLA4WsYlkafvqk?=
 =?us-ascii?Q?QvH1fsG4iqmemBKx5Duy9kS4VivUm4SxadeBO/QZqVRODDWDPji/Zp8+0PcK?=
 =?us-ascii?Q?3JyUMBijW46JfDYTSjaAQVnaMFW6A9k/ntILxabDytdeCHRKgcFGktafBZIj?=
 =?us-ascii?Q?NNKvyoQalcxWxgaJDQ7YHAD68p+37BIhhKXj0EesDGgtHB08IleUI+gV1j/r?=
 =?us-ascii?Q?Y87vWBqoMUgpKK1VF4ozeRkqAszcEAVIfrwelP6x+ccCfl3q+maeTW+G9Ae+?=
 =?us-ascii?Q?eupTBTu2XXW5sgqMDRktqDZoDtFBrZpov+j/noeEjRqgwFqNwrx6pM5uzdgT?=
 =?us-ascii?Q?m9jTEUU12ZnenKo1FF9BMYgnjjoYmgwEcDZCx1TLKcDzDevXqizXg4DS/z3Q?=
 =?us-ascii?Q?2CCA80b3939vgFysjMxi6RqMeE9PJh2g32+b0oU+hyd4WJ1JFmDqH8nUuf68?=
 =?us-ascii?Q?CiQvnw6egdQOIMimOGV3XjkL59bTxn4reBbCGTup/IqpxaPD9BWXvzCyUb6U?=
 =?us-ascii?Q?63VPzv9qY/6WxnxH/CPpSc2V/tNM3XGgxjyL0+tOgzx/wBjBiSa6PrFeXuRP?=
 =?us-ascii?Q?rTUoQR0X2vZLlOyvmPPmlnYscp1slqVq0DtSEXqWA04g3hbn9L8BzGW4oAHI?=
 =?us-ascii?Q?dxlOXQ2JoN3+WqWiNJq+AwV2a71tcf60r/VTgPet6ZXXdi/jbH1V/2nuMXIW?=
 =?us-ascii?Q?5GQvasWG/2Ox0312DFlLMLYPbsc07uBYEUkfzXBZ68y82S1ryGrrAkudUkBM?=
 =?us-ascii?Q?URN7jCkUGKJTLgCCpXb/mUu6N4UqkQR891Tcrd2BPqLs80CevcOQxOcHXbkc?=
 =?us-ascii?Q?xebJvmI6JzaDd1LphWHubz8/wxFIgcdP80Tok/lV2M7fV9CYXlWIol2QsOt9?=
 =?us-ascii?Q?RSexrL5kyrd1zKjVfDhZnAySBSgJp9WfvB7eZUZh5eFRI+ZMp+HIAelUDnSF?=
 =?us-ascii?Q?fmQASU/TE4OS7lmCKSZAQ65gyH5zLSm8oEeCVN7Hi2N60VJCh4/dv2JrUC7Y?=
 =?us-ascii?Q?Ml9A4TJL6SpeTBcOiphY4Fc+IW/2qx1iujWx/hyo2Bfp3JzeyGUfiUve7Aw+?=
 =?us-ascii?Q?4gZraqaEtP9Z/8S+vJhQseabgaSi8eIij3fYU/2ApZpyDvWsUDGu+Am1XvOW?=
 =?us-ascii?Q?6b9l1MZkb6GeL1jEg5PvKgra3kgJ1YUgjRcHMk4EwGR9c1fR1IauN33n6PH6?=
 =?us-ascii?Q?awM2FfwO/4ct6IJ5AiLhil3yRb/wRQmDKZX+779skWhjKfJXDmgBO+yKFRrf?=
 =?us-ascii?Q?ckAt6XDf9mDCdQv1Nzg3xseW4LvhfvyXIs54O/r2P8REp9N6Z8XE+R0xGycy?=
 =?us-ascii?Q?U6/N7ztxFtChQlosXCiYm3Gn8hRBaIK2wtm/KDfI7wyAf5upL0aWm6XpHjv2?=
 =?us-ascii?Q?uxP1lXV4YCfTSiofXe8i6tzNMciM8Zm76C+tFxJyrzYtzZQfvPY9R7Rz0cUd?=
 =?us-ascii?Q?Ng46ofhsnwCRFGSee3edvH6i2nsrFijYX1hWBqtKfyTuwokLZc0Y7xXQIKc6?=
 =?us-ascii?Q?5X6EAyZRzQ2V8DvqT8JqC35HxG3XpYdFvNZV6irL72U+GOyFgbiLXd9/zHaz?=
 =?us-ascii?Q?Keg4TsaJFNsxXnHI6CWY9QAcswoyG2rGwkZLuHd1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70788d6b-61ad-4c33-f001-08daf92781fc
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 07:42:10.8255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: enz8hHNDohhHQP0dk9yZVg64VsPuxc4M/JPLzBOhXU1QPHa5P7F+4pQDIDq+rKTjloCxtw46eAJ8P62uYM7l4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7410
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

+/-1200uT is a MAGN sensor full measurement range. Magnetometer scale
is the magnetic sensitivity parameter. It is referenced as 0.1uT
according to datasheet and magnetometer channel unit is Gauss in
sysfs-bus-iio documentation. Gauss and uTesla unit conversion
relationship as follows: 0.1uT = 0.001Gs.

Set magnetometer scale and available magnetometer scale as fixed 0.001Gs.

Fixes: 84e5ddd5c46e ("iio: imu: Add support for the FXOS8700 IMU")
Signed-off-by: Carlos Song <carlos.song@nxp.com>
---
Changes for V5:
- None
Changes for V4:
- None
Changes for V3:
- Modify the magnetometer sensitivity unit "g" to standard unit "Gs"
- Check and confirm uscale value is correct. The readback of
  MAGN scale is 0.001 Gs
- Rework commit log
Changes for V2:
- Modify the magnetometer sensitivity unit to be consistent with the
  documentation as 0.001g
- Rework commit log
---
 drivers/iio/imu/fxos8700_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/fxos8700_core.c b/drivers/iio/imu/fxos8700_core.c
index 44e4befcf3f0..939f6069ef4c 100644
--- a/drivers/iio/imu/fxos8700_core.c
+++ b/drivers/iio/imu/fxos8700_core.c
@@ -351,7 +351,7 @@ static int fxos8700_set_scale(struct fxos8700_data *data,
 	struct device *dev = regmap_get_device(data->regmap);
 
 	if (t == FXOS8700_MAGN) {
-		dev_err(dev, "Magnetometer scale is locked at 1200uT\n");
+		dev_err(dev, "Magnetometer scale is locked at 0.001Gs\n");
 		return -EINVAL;
 	}
 
@@ -396,7 +396,7 @@ static int fxos8700_get_scale(struct fxos8700_data *data,
 	static const int scale_num = ARRAY_SIZE(fxos8700_accel_scale);
 
 	if (t == FXOS8700_MAGN) {
-		*uscale = 1200; /* Magnetometer is locked at 1200uT */
+		*uscale = 1000; /* Magnetometer is locked at 0.001Gs */
 		return 0;
 	}
 
@@ -588,7 +588,7 @@ static IIO_CONST_ATTR(in_accel_sampling_frequency_available,
 static IIO_CONST_ATTR(in_magn_sampling_frequency_available,
 		      "1.5625 6.25 12.5 50 100 200 400 800");
 static IIO_CONST_ATTR(in_accel_scale_available, "0.000244 0.000488 0.000976");
-static IIO_CONST_ATTR(in_magn_scale_available, "0.000001200");
+static IIO_CONST_ATTR(in_magn_scale_available, "0.001000");
 
 static struct attribute *fxos8700_attrs[] = {
 	&iio_const_attr_in_accel_sampling_frequency_available.dev_attr.attr,
-- 
2.34.1

