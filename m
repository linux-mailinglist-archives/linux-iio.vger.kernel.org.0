Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708EB6469A0
	for <lists+linux-iio@lfdr.de>; Thu,  8 Dec 2022 08:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiLHHTN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 8 Dec 2022 02:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiLHHTM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Dec 2022 02:19:12 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2075.outbound.protection.outlook.com [40.107.22.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00919442E8
        for <linux-iio@vger.kernel.org>; Wed,  7 Dec 2022 23:19:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=blgsnEQR82nhBbhauw+hHImp7YjkXvqQzSxcM9fxtybymsZlXSxHW2f+dZlJJqlFzEye/JE5Zow5nbWO52J0DxFA3SSw16TulE4IxiqlNkTHP2jfl6iA8pSxldQrsHzXWWiZ429nvUAK5haMbd5jNzW7dDt4Do5veaIJ9GDHwG5euP0PM9anQ8/ILfUdMRheq12LcuSUZ5fHSHmWpdvnXOr8Tha7li53zT3fnMo4Yyz6ayjggTTDKtBLLKV8xSPy1WPbcB/+vF3uvXRpzXdhipIdEhd1jP105p71+UFxtMWP1/yWE+OoEIuLM4GFua1LqXd8EH5wPn5EPkJRi0s/Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QeuU2kwCYmZtX/gsyU+CxZ4ylB4DVCx5o2A5GUTeRwk=;
 b=LHPIRgbNCVTfDaEe03hDC5CRWnKKfnRgYsoAi9d6lwZ0ISw7nTjoil4ye0A/rx6i03WoEmz1GVK8kPN1PKvLVEgpdOoKD2JL9UmkEHljAlXI8N/DoeQMZfkvozhRJ602HajIw7tWF99f70Mf9HZuFKMT586ecJFWxAiaJeYCw8f62SdPT3fvlmRvks5u9LWyF1sdt8EtDW2Ch88iXh6dJNnZYhWa0vjPwwuRQOs89dVbxdR+TtqYExe/UC4NbK7U1N+aMXPRGlq+nysXNADLPuibJn/5dWWxXoGxcmVJWY2qTdMPC00IJMwCV8vCtvg3neQSNPYoxnGLS4/dP0VkxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QeuU2kwCYmZtX/gsyU+CxZ4ylB4DVCx5o2A5GUTeRwk=;
 b=SlvChyIlkQ2Kgr/UEVpIPfSZqO6ApQydQ8jmmvjAD3TNj2AOHRIzpSGgsSSfwj2aNvCV08ZW8ao73WzikciInLpr6NXZ7dbWCkyMgubxEv/YhidlvnQ1AJF2uh0G2trDvWOfenOO7GS7k8ALnEz3osPKXnb4gfTW6siFz8Ge0G4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by DB9PR04MB9701.eurprd04.prod.outlook.com (2603:10a6:10:300::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Thu, 8 Dec
 2022 07:19:09 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749%3]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 07:19:09 +0000
From:   carlos.song@nxp.com
To:     jic23@kernel.org, lars@metafoo.de
Cc:     rjones@gateworks.com, Jonathan.Cameron@huawei.com,
        haibo.chen@nxp.com, carlos.song@nxp.com, linux-imx@nxp.com,
        linux-iio@vger.kernel.org
Subject: [PATCH v2 7/7] iio: imu: fxos8700: fix MAGN sensor scale and unit
Date:   Thu,  8 Dec 2022 15:19:11 +0800
Message-Id: <20221208071911.2405922-8-carlos.song@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3fee9034-7e35-4404-66b9-08dad8ec7fce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DZmg+zJYSbZpG35V/3wGsR2HFLcPz2U/oWE6RQQQgU5BJFvQdHD+koDuktHooi8ChqimveyrowFIPuW5UgPa1k6HmKNlWHp/0Z5RBE+O+hfzHDntr3qSPuqUiHs81PU80AEo1HHzRMYvskpv+sKOxTmelHb2EybrE69+Gh9QZ1D1E8W9nCGqk5edauVzA9vN6mcw4H2diD0IUPPkcNxrCYGXK4gss2lwY9D+oWZXXZHf1HK6tuUFYoJp4yRfhFvIJak08lyKMJUjRqiv6xJ2aVDqGUrlyt4F+5JNVE2p2vxYJ0Y+C5qkLOWzPWno0G26TZxid5cGcS9HI4D2D3Z4KqOrxn/EhpbUAxgIz/h1shchxrG8MGw99fCgv+PyQY1nRCHIJpNiQ3zx1xbWBmtUxhvI9Uk3KxradArSx8jgyF851v6lysLno2EsbriEg4EUqO4kD4XJC1Sok5PBsdgBYoeb663D6VxDyUA5/8VWhmP+mgSbTR/M9XwWZ3yJPj00TmmXunwC/gTHpfYSudqI0+MtavEYY5xyU67w7TyizlCI9eU/Yqy6/SrGBngw44gNQ+rbDc3g8eHojbkp8xMZM+u6xLrKGSPNgYEmXFJgwpp+Lo1vgJMxlGS3WZs3hGb0GCycn89XYJkOIs0AUFZEGJMRDzlnDq8uvJvsdhW0g3TTvuO1wCFMzTA80KILCuJj8NTEIOukkZE0xvIjYmb3Vg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199015)(36756003)(6506007)(9686003)(316002)(26005)(83380400001)(2906002)(186003)(6486002)(6512007)(1076003)(6666004)(52116002)(86362001)(66476007)(8676002)(38100700002)(4326008)(66946007)(38350700002)(66556008)(478600001)(2616005)(41300700001)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fl5GY00cZdnrTFAbGWqACAGry/zVuuPrSy1rHkir/O5xIwtZ4CdglPusW20E?=
 =?us-ascii?Q?oKmULzFFTYJg4rfJ/wBIP+AMWFZcZ4EmAb1Z8ckFbeDW6KePDgW+PECzgyMP?=
 =?us-ascii?Q?fL+VaB6NArhT3sRnJOmHbFrsyhcv+Y85Xb1iQAKyK1PReOZQZh/Ew8u4gxB2?=
 =?us-ascii?Q?aFoJy5GUeGHjYpBoPPJXiA4whRFaEm+LxyM/6YgjZKg2kxmMwerx3WdOTgkh?=
 =?us-ascii?Q?I0f0+oIOHJydAlrf4EcUoxmk+4EGH6MU+mOSUUP1ARGjY/21vaujai7KVVp9?=
 =?us-ascii?Q?Hlz6q0GIlY3fhR1dS5DtAaDnIYGuoV1wzV28gblFEDjbyAldAZStoHs8rwlp?=
 =?us-ascii?Q?4Zgt+mtNMbY1wHOacdl5GX2DCIECW+6w6+tABvOLYAkcElXG37qifCxL/N6w?=
 =?us-ascii?Q?fP7fRJby5S8h4/pLhrAJ7Ez5CyUGPSMRXGRyU3ThIIzB3goHWNfFRwxFmqUY?=
 =?us-ascii?Q?tHGEOh3cL9wZA617iun5PmkH7SUXzDFsJiMVZBPKPTEUy7lLhGSl6j0b0BVW?=
 =?us-ascii?Q?I56LeSERWNxfnIjFA1Fgy0xHJtiItr3vOh59vijyrDGVg11zuc3ybDGQnam6?=
 =?us-ascii?Q?1SQjBwcr2HAza8XYElbzBZOvrjBL/trYFgRFIya5n+jvCRv1vCxvUao0AEeO?=
 =?us-ascii?Q?/8drHraCeu3941qOleoaWubr46ftonMufPYyG3MzyDibUrRhSHgg74qjedZT?=
 =?us-ascii?Q?yDUpew65pm3FisfC8Zs5DOL21bbzat4ZMJQmqEB7FMEwV7Iunz8m6q7kZy3T?=
 =?us-ascii?Q?uZlipfV1yNwiEDCafejBgBPpuMxsvoiEXLWHVWO2+iFKyqYMwytSgi/ApPiI?=
 =?us-ascii?Q?qWLOaYzI9kl4LwZScHQg6NZgivc/PC7s/nM9403AR24bNmu1MyysvrzRWVj6?=
 =?us-ascii?Q?JQBPW/Pgvqo5i1tYYF6+vLdRt4d7LPVAyXGqno7qF9zrHY8U3ERRvFM8l26I?=
 =?us-ascii?Q?837uOhU3NIkDqr19w2h0UVZvGNWDwr7tzj4+yloD2JUhRg8RZkKVZUvv3uc2?=
 =?us-ascii?Q?fArvIN9BMcovlXchm5TzEoE2nP7v3qKQryHMm4m1Ije+Z4sv0PmHkNlj02+5?=
 =?us-ascii?Q?rp47FHj2wRETuAAyWCcvtzWU6iwlYoQs/co3Q6ds4jD2hN0hBt7J+poTe+iy?=
 =?us-ascii?Q?XY6e34bVoHbbc83OLMs7jEkO3jaG/qlhFXeZweVrVBfYZMSPl7hMYHfOU81I?=
 =?us-ascii?Q?b2hE1kh7ge9WKfgx9scEk4dWo53/A69v1ChdikBftRSZ46lD1xA1s8MV7gG5?=
 =?us-ascii?Q?WDd/PsWaw/rm1R4R24TmbCrFb7t9sHM9W8vJEmA0P4L583dTIzZOgMVVRrwH?=
 =?us-ascii?Q?VByu3dTCfLqwOJKmlssRFCytN0KRgMF8x//YQvpJq2K/zQdWIPS4Mm4BwMt1?=
 =?us-ascii?Q?cBAqepkRRcoE+hE+h3WwvSBTQisUTthwJKOFMKov37wP1IULxC+eRMfjgh40?=
 =?us-ascii?Q?0xZJOr94jbvvq+NMa7Q/oBLPpeloVF3OSy9RKMYEXxGZ4ITyiucc1M2Q5ju6?=
 =?us-ascii?Q?8llDH25yPLwLX1BQumzM46XaXMQ8JvEEjqOHTYO+3pXx+DOwAH5A+LWvI2x6?=
 =?us-ascii?Q?Hbpe+KTpSYH4sIa9eCqLjF9dCfmSYmBjaQYcamUE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fee9034-7e35-4404-66b9-08dad8ec7fce
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 07:19:09.6179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 77e3S/HHLXYHZHijAbB3xBRhPWxAXhVLmU+mV+yJTIEqXtp1mPWEUcWls1g79gIN47sV8s0yQoNi24xIRC8oPw==
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

+/-1200uT is a MAGN sensor full measurement range. Magnetometer scale
is the magnetic sensitivity parameter. It is referenced as 0.1uT
according to datasheet and magnetometer channel unit is Gauss in
sysfs-bus-iio documentation. Gauss and uTesla unit conversion
relationship as follows: 0.1uT = 0.001g.

Set magnetometer scale and available magnetometer scale as fixed 0.001g.

Fixes: 84e5ddd5c46e ("iio: imu: Add support for the FXOS8700 IMU")
Signed-off-by: Carlos Song <carlos.song@nxp.com>
---
Changes for V2:
- Modify the magnetometer sensitivity unit to be consistent with the
  documentation as 0.001g
- Rework commit log

diff --git a/drivers/iio/imu/fxos8700_core.c b/drivers/iio/imu/fxos8700_core.c
index b4baef82f6d5..1780ed99d2f9 100644
--- a/drivers/iio/imu/fxos8700_core.c
+++ b/drivers/iio/imu/fxos8700_core.c
@@ -352,7 +352,7 @@ static int fxos8700_set_scale(struct fxos8700_data *data,
 	struct device *dev = regmap_get_device(data->regmap);
 
 	if (t == FXOS8700_MAGN) {
-		dev_err(dev, "Magnetometer scale is locked at 1200uT\n");
+		dev_err(dev, "Magnetometer scale is locked at 0.001g\n");
 		return -EINVAL;
 	}
 
@@ -397,7 +397,7 @@ static int fxos8700_get_scale(struct fxos8700_data *data,
 	static const int scale_num = ARRAY_SIZE(fxos8700_accel_scale);
 
 	if (t == FXOS8700_MAGN) {
-		*uscale = 1200; /* Magnetometer is locked at 1200uT */
+		*uscale = 1000; /* Magnetometer is locked at 0.001g */
 		return 0;
 	}
 
@@ -591,7 +591,7 @@ static IIO_CONST_ATTR(in_accel_sampling_frequency_available,
 static IIO_CONST_ATTR(in_magn_sampling_frequency_available,
 		      "1.5625 6.25 12.5 50 100 200 400 800");
 static IIO_CONST_ATTR(in_accel_scale_available, "0.000244 0.000488 0.000976");
-static IIO_CONST_ATTR(in_magn_scale_available, "0.000001200");
+static IIO_CONST_ATTR(in_magn_scale_available, "0.001000");
 
 static struct attribute *fxos8700_attrs[] = {
 	&iio_const_attr_in_accel_sampling_frequency_available.dev_attr.attr,
-- 
2.34.1

