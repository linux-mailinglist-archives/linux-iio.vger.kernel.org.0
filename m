Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493116FCA21
	for <lists+linux-iio@lfdr.de>; Tue,  9 May 2023 17:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235013AbjEIPWz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 May 2023 11:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjEIPWy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 May 2023 11:22:54 -0400
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0A41729;
        Tue,  9 May 2023 08:22:52 -0700 (PDT)
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
        by mx0b-00549402.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3498PKA8026870;
        Tue, 9 May 2023 15:22:33 GMT
Received: from jpn01-os0-obe.outbound.protection.outlook.com (mail-os0jpn01lp2105.outbound.protection.outlook.com [104.47.23.105])
        by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3qf7b50twt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 May 2023 15:22:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QOyX7xsHYisQSnXHn1UANA9F+CQH53m9pFCoKG+i8g10WyTlIAEfmjenZULTrDyrKK+VVraG3h37+lGxZ4CmUcDno7kdKmGGgVDszfIjNhJj/Vrs6nHKVci4iXkzqly53J1n/o0e3SSOL0eNuU9rztEusbxY+2YiT43SD+PvdCDJshmboGyyPVepItQ3CBqZRtL9Q1ovYClNBCh1E7pQV/8ZcFthkZ6qS3tQNfzM9AhjxYGQxvxk63v0ueUqp9IgnTabK2+bocR+welmupedu2goVGtveK5hhLg7+gsZOmy9Wi7swX5+iuVq55VJ7+I/uYJPV3w1YhXmJkZgKIg2uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXp5S2wZgucPYCmiag9V6adJiju9l6YsM9QGxpjOc3g=;
 b=k4U0DV39q48QWqJyKNgZKkLB31qjUaTpJgjmYIzOeI1RPUklrl2aZymACOhHQqf0hq+3qMTaEd5uHE2zPUAcR8ZRkX8CfCE1VZfDxcUUVV61wGMl+CJYQtgCObC4IzZHkD2YJimc4eHSXItubjvEtGQvOUZ8GMqBdkQCIdOc+jZUaWHGR7GJu1Uq/Mcpjn14EQ676B8yfXtgPeCsoDPyWEaGxqFk4LyBfndUd10ED3MxBi4CsHog6wys2sbtMFZUNd5y5hx8MWzRfwhuPfFfPl6GKmPTyC1skTdfJBqmocUv6/vQOTxChKwDjkYHR1EEeyIld4AswZWZL2uR9thBjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXp5S2wZgucPYCmiag9V6adJiju9l6YsM9QGxpjOc3g=;
 b=DxE914+SugcQwaKIDOgzG/FFCku2YXYmGKbgbYW/EOcfNfi20wLq/9RNd4me49QUzHMPI/gENQsBVJEyIKQDu8mgKLRi5U00+X90hhxxrGjPyt6ZRSCp+9Q1rZtaFWSczfx7jBMTm/NwiYG/NiYoi5mc7JTROjwCgLiMze0ROCDdoRgb+4xWDU/CISBvLERfnBLBH/MQ0YuXKqsLNY4IHFCsE8Uowy90qxCeJtgHvGGrQCKUMy09fUzCGWnKUUsg/rzBf8iRjhzHt277zVNydFDXKmVUklW6+AaDVYelpLCup2B8/C0QDFAcPs+KBiQeKaaRIx1aVLdTepY/NTsufQ==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TYYP286MB1882.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:110::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 15:22:29 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::72e9:c955:a34c:9647]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::72e9:c955:a34c:9647%4]) with mapi id 15.20.6387.018; Tue, 9 May 2023
 15:22:27 +0000
From:   inv.git-commit@tdk.com
To:     jic23@kernel.org, linux-iio@vger.kernel.org
Cc:     lars@metafoo.de,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        stable@vger.kernel.org
Subject: [PATCH v2] iio: imu: inv_icm42600: fix timestamp reset
Date:   Tue,  9 May 2023 15:22:02 +0000
Message-Id: <20230509152202.245444-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0397.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::6) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TYYP286MB1882:EE_
X-MS-Office365-Filtering-Correlation-Id: fc08e2dc-cf2b-4e75-2149-08db50a131ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /M7hCcMhAKYBo2XJWcG3icz7eNwGSNMTJfu9wC0KtPIH4onJUQ7wbFsjbjn/AhVG7gvLiNdf2A2nv1CVHqk/GycAG4R4vlxTiDF+Rc+E+Q2Vo6ZhDPwGmdsfz3ytBFj9VCaIll0MF3b6wWJsc3XYQXGwv9Z0LiBkzEkLt1X8wmsnfKgKdX9IKKb+erNJnOlHeETsKyE25qM6/r6o0GLrXCReOQjSB5RpGDit7Vfg/+IKu3FzsAisfbYnPnwdpnlLPDYAiRX85z7Uf/DK/LBw0P+OCVF3XrlagGJPj1/shdDa/lFBsjOXS8TDvSnK2CUMb/eSdKk0c05QRLnHaqAEv6Ep7hism65i8EYFg9lP6+uvv63Iu/mHpF5HRSlVdonE2IkqFpI8mo1MGXFBkcooHa1wZ+e0rT3AA8f94SRxTxQsiV5nWWA/UlrkY11MOYPVijJP9gqiftH/SIS1ROqb2qs4GZaEWs4OC2PmzpSpJnf585+CLG7z4mqFZ4Dwo+wPUrAi0d79Lf0pB+WEUJcBXlpkVciIsJj82iS3xtwdQXve43D5W8Ne2fA6FJbQhOlGh8v9aE+XYetuNFdy9uayb22hnfpXfB3bEkgEhJaQo8TrHcTR/S3fa//6ZPodtRGn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(366004)(39860400002)(376002)(451199021)(26005)(186003)(2906002)(38350700002)(6512007)(6506007)(1076003)(9686003)(36756003)(38100700002)(83380400001)(2616005)(316002)(6486002)(6666004)(66476007)(4326008)(41300700001)(66946007)(66556008)(52116002)(86362001)(478600001)(8676002)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l9QcoI2ovvyD5kqNPv8SOSohNmnd67v9mrCIFcPyw4MYM1PAC+QplhEynLXn?=
 =?us-ascii?Q?6aIEY0MDgXJ+1QtVd/OvcEgmxc5ZsTuxEGHGJN1gWP/vdmzNo0o7PZDcx5Wc?=
 =?us-ascii?Q?eR7raLLuIU8PeDiOB6ZV/tB9KwI4bIEqhrDrkPGYbp5FpTd19aEuscw8qOw0?=
 =?us-ascii?Q?if8lOw6VfO1GSGzeiD/LM/LMbsHkt2dKjj/elcHe13qoHFYoqfbVODBjWmgx?=
 =?us-ascii?Q?ZIvdhUmQfRvbUSft6pdMPdl4uf7AgzPTsw/pdpCGTqwyxtm0ZUuPxFmacsAt?=
 =?us-ascii?Q?HjzKG0oMj8h+/gAabJHXtrHpmHCcfHIly5fnPUAjLpm+tQ6st9E8JsL07WxY?=
 =?us-ascii?Q?/22OFFvB3f7gCPqZItsQ2DQS0baAXLlJSoTIeSAvf74GwyLaVLvxZcZL6To2?=
 =?us-ascii?Q?NDG30xv2g1uP6dpDxn8+fxLuzQg1hNkDrzuriK+5nbTqatZEJS+LCk2Yct2w?=
 =?us-ascii?Q?JI3tS2QRW6679HjSljtvo0THGhmAuUqdSH8MTEZFoE6PBgr999+foa6y9qVW?=
 =?us-ascii?Q?j40UDBUzVkv7kGv9w+CJX4eZmhRPBaEfBujgrhKelp/WzmLxm+TMxGTRp3VX?=
 =?us-ascii?Q?pZ4QBHa+b4IhgqEx6gh++2S7vqMlq/s72vyDYsMCJpMBg5t6LcmB+PlaJ3jz?=
 =?us-ascii?Q?s/RheiElxumzTt+ABMWj+3ozWcBpWrnPObnfg6KxI3qnLYj0qX3v9IzVFUUF?=
 =?us-ascii?Q?XgqJvlinppp1B2qeD132qPT5IWmdZrQkefhBcJKrCO0a1d5RpsZITNcYvwvT?=
 =?us-ascii?Q?v826Jht7ZFHAgR8FBwDYnr1HE3+ux0+13VD+FY6xK+pmSixyDqGSL9oC7ygl?=
 =?us-ascii?Q?7kxJVV82ji7Ry9ErS/Kgn6Xxt3QFFXZ5cwVXmQ0/nne+Fine4QsoAmA/aXDq?=
 =?us-ascii?Q?PTpAoM/Ea0MrjTeAyvX024JuzjJp8Zpwwyt9qHRYk48qeX/Vw3kPZ22zzq+v?=
 =?us-ascii?Q?JHDUfBpj2Qs4cSlUgcQLXBrUIL45O7OgxaizpmDyTvTIBIeyjBAZLVic4R2X?=
 =?us-ascii?Q?eUmP2GucuAFoeir0gexC+JD4LMR2gsrdrNKIUSSxVKLmWTCIObsJghZdxZ5S?=
 =?us-ascii?Q?ocHAiOepSWzUsx5gXW4EZ1FP7UA1YQGeehJECrIaocBbzoHGx2swO2p3ZSkM?=
 =?us-ascii?Q?n6y2V5RFpFbnpPoDZZWFqBP9w40dJ5ljrRLUFcdfeCd6QSCgXxYbM7HpUDz4?=
 =?us-ascii?Q?OsDmUSRSQn2Dmw1VnjTjxH08FPfjLw7QKDh7a9ibzPXr/kwwg6bMbr289nvZ?=
 =?us-ascii?Q?qBjJkaErrf+4uVnxugMxqtT6kW+zIIS+T9svELOtRwLREcbnkhjoLqZmgGMy?=
 =?us-ascii?Q?PNjgaSwCLeRFEkJhU8jxd+QkUao/JVryCw+5hBeFQRr0SaCO2pYlA7npA9a/?=
 =?us-ascii?Q?gG/cBb6MfKRI3RNAMIYHk9d/qlnHJ7WnQ8Os/rfX7tlianSCZf/2etEEFzPF?=
 =?us-ascii?Q?eieoPPiUd5jVS9VCSMnGlb2gQJ2uFpj5jTqVNslorA/GQQJsUN4hjDSLMuPf?=
 =?us-ascii?Q?Wf5FsPpKek0S35Gqm2QLhzmOQDXtGBxDaDGxyU7r/SJKLPkANM7IUqUKiFWX?=
 =?us-ascii?Q?jJJtz56SSKkHCuI63INgaRA3EprkYfn2nwyi1rmG?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc08e2dc-cf2b-4e75-2149-08db50a131ba
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 15:22:26.5290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b+dDsvYcY+B6dgdNMAbL7e4JZryee/dKAhgluAdVvpvmE4DN4cO5vVvN5HKdNfcp5tYKW09UQrBBqz4ZprFRew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB1882
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_08,2023-05-05_01,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Timestamp reset is not done in the correct place. It must be done
before enabling buffer. The reason is that interrupt timestamping
is always happening when the chip is on, even if the
corresponding sensor is off. When the sensor restarts, timestamp
is wrong if you don't do a reset first.

Fixes: ec74ae9fd37c ("iio: imu: inv_icm42600: add accurate timestamping")
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Cc: <stable@vger.kernel.org>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index 99576b2c171f..32d7f8364230 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -275,9 +275,14 @@ static int inv_icm42600_buffer_preenable(struct iio_dev *indio_dev)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
 	struct device *dev = regmap_get_device(st->map);
+	struct inv_icm42600_timestamp *ts = iio_priv(indio_dev);
 
 	pm_runtime_get_sync(dev);
 
+	mutex_lock(&st->lock);
+	inv_icm42600_timestamp_reset(ts);
+	mutex_unlock(&st->lock);
+
 	return 0;
 }
 
@@ -375,7 +380,6 @@ static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
 	struct device *dev = regmap_get_device(st->map);
 	unsigned int sensor;
 	unsigned int *watermark;
-	struct inv_icm42600_timestamp *ts;
 	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
 	unsigned int sleep_temp = 0;
 	unsigned int sleep_sensor = 0;
@@ -385,11 +389,9 @@ static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
 	if (indio_dev == st->indio_gyro) {
 		sensor = INV_ICM42600_SENSOR_GYRO;
 		watermark = &st->fifo.watermark.gyro;
-		ts = iio_priv(st->indio_gyro);
 	} else if (indio_dev == st->indio_accel) {
 		sensor = INV_ICM42600_SENSOR_ACCEL;
 		watermark = &st->fifo.watermark.accel;
-		ts = iio_priv(st->indio_accel);
 	} else {
 		return -EINVAL;
 	}
@@ -417,8 +419,6 @@ static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
 	if (!st->fifo.on)
 		ret = inv_icm42600_set_temp_conf(st, false, &sleep_temp);
 
-	inv_icm42600_timestamp_reset(ts);
-
 out_unlock:
 	mutex_unlock(&st->lock);
 
-- 
2.34.1

