Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 064FAC0F09
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2019 02:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725306AbfI1AqC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Sep 2019 20:46:02 -0400
Received: from mx1.ucr.edu ([138.23.248.2]:5308 "EHLO mx1.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfI1AqC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 27 Sep 2019 20:46:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1569631560; x=1601167560;
  h=from:to:cc:subject:date:message-id;
  bh=Gyih0+ys/dsZuk6p5tTk9jxHvhG3+TejPRIPLUcLycQ=;
  b=U3WR9miMgxy0SN498fX2SV2sPBpIxXXcn5G3Qo7GWB9BDuIODCJTRET5
   pEuO6VqSrxGkvDVmOvTNKNQDnwkhLgiIuiCNslbVUhQh1RCrU9DgOV7d3
   NoX503xNy+jL8pBmDP3ka31G9Xb33QPyXRZjN/U26YnJdKC3wjmvKNp7p
   Z4pD/RkUykOWlVTtTktRpNUInWwKLgfr7RdqTd3VUf40bm7Tz0FVvzTjG
   C45LkwlPOc9Ihw3vNECxIJnH3aKyMwNrVx43BIfLILoeeNXxZa9HLzIdN
   O5WLeYFdrZlLQNloTGmS0Mr6+1J4thWnDZU4vsvgx5VYl3k325jNgkmrK
   g==;
IronPort-SDR: emy5Rhb5eypLm5fEJ5Cd0HZJ+wTpYrrGlwMygFV3ODtuNK3HmIBZl/ssGkJCJF/f446uppNGHv
 9ve5Uo5PdNHIBUQW94i4t52/vx5VlWXMpzb6C1IlflHt/9jokaxZ3YYp+1ZYA6y/zH0v1bXFWW
 dD38I9Ga5svL8FjMV1bNbPa3PvQ3hkHAk4OkujRGrvNr8D1tRDx49bONvMFbgEVY8IZcWueepo
 2x6l5yigG07sV5sL5PAZgfvyhMTYvqpYaZCcmCQ5MPdG+sclOZp1r2uW7lPNu+2tPmMo9dOpxa
 zew=
IronPort-PHdr: =?us-ascii?q?9a23=3A4ejvYBSyvf7QiHPGNb/GY9TAgdpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa69bBGN2/xhgRfzUJnB7Loc0qyK6vumAjNLusvJmUtBWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MRu7oR/fu8QUjodvJKY8wQ?=
 =?us-ascii?q?bVr3VVfOhb2XlmLk+JkRbm4cew8p9j8yBOtP8k6sVNT6b0cbkmQLJBFDgpPH?=
 =?us-ascii?q?w768PttRnYUAuA/WAcXXkMkhpJGAfK8hf3VYrsvyTgt+p93C6aPdDqTb0xRD?=
 =?us-ascii?q?+v4btnRAPuhSwaLDMy7n3ZhdJsg6JauBKhpgJww4jIYIGOKfFyerrRcc4GSW?=
 =?us-ascii?q?ZdW8pcUSlBAoKnb4sUDuoBO+lYpJTjqVUXsBC+CwisC/3ryjBVm3T62aM33/?=
 =?us-ascii?q?gkHQzAwQcuHc8BsG7Modv1KqkcTO67wqrPwzjYc/9axS3w5JTSfxw9vf2BW6?=
 =?us-ascii?q?97f8rLyUkoEgPIllefqY3kPjOVy+QNtHWQ4u1gVOOui24osQBxriSzysoikY?=
 =?us-ascii?q?TJm54aykre+Spn3Yk1OMS1RUhmatCnCJtdrz+WO5dyT884QGxluDw2xqMbtZ?=
 =?us-ascii?q?O0ZiQG1ogrywLHZ/CacoWF5gjvWPifLDp4nn5pZrOyiwyw/EWvzOD3S9O630?=
 =?us-ascii?q?xQriVfl9nBrnUN1xvO5ceZUvZ95UKh2SqX1wDU9+FEPVg4larFJJ4lxb49jp?=
 =?us-ascii?q?8Tvl7CHi/ygUn2lKuWelg99uim9ejrfqnqqoWTN49zjQH+PaAuldKlDeskNQ?=
 =?us-ascii?q?gOWnCX+eW61LL94U30WKtGguEyn6XDs53XJd4XqrCkDwJayIov9QqzAyu+3N?=
 =?us-ascii?q?Qdh3YHLVZFeBydj4juPlHDOPD5DPa/g1u2kTdn2+zKM7P6D5XQMnfDiq3tcq?=
 =?us-ascii?q?hg5E5B0AYz18xQ54pICrEdJ/L+QkvxtN3eDh8kPA242ufnCNR61o4FR2KPDb?=
 =?us-ascii?q?GWMLnIvV+L+O0vOe+Ma5ERuDrnLPgl/fHu3jcXg1gYKJioz5sKbzjsD+ZmKk?=
 =?us-ascii?q?TBOSHEn9wbV2oGo1xtH6TRlFSeXGsLND6JVKUm62R+V9qr?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FFCgDRrI5dgMjWVdFmHgEGEoFcC4N?=
 =?us-ascii?q?eTBCNHoVzUAMGiyaBCYV6iDGBewEIAQEBDAEBLQIBAYRAgzojNAkOAgMJAQE?=
 =?us-ascii?q?FAQEBAQEFBAEBAhABAQkNCQgnhUKCOimDNQsWFVKBFQEFATUiOYJHAYF2FKE?=
 =?us-ascii?q?xgQM8jCUziHEBCQ2BSAkBCIEihzWEWYEQgQeBEYNQh2OCRASBLwEBAYs/gjG?=
 =?us-ascii?q?HK5ZJAQYCghAUgXiTByeEOYk9iz8BLYoonGoCCgcGDyOBL4IRTSWBbAqBRFA?=
 =?us-ascii?q?QFIFaFxWOLSEzgQiOPQE?=
X-IPAS-Result: =?us-ascii?q?A2FFCgDRrI5dgMjWVdFmHgEGEoFcC4NeTBCNHoVzUAMGi?=
 =?us-ascii?q?yaBCYV6iDGBewEIAQEBDAEBLQIBAYRAgzojNAkOAgMJAQEFAQEBAQEFBAEBA?=
 =?us-ascii?q?hABAQkNCQgnhUKCOimDNQsWFVKBFQEFATUiOYJHAYF2FKExgQM8jCUziHEBC?=
 =?us-ascii?q?Q2BSAkBCIEihzWEWYEQgQeBEYNQh2OCRASBLwEBAYs/gjGHK5ZJAQYCghAUg?=
 =?us-ascii?q?XiTByeEOYk9iz8BLYoonGoCCgcGDyOBL4IRTSWBbAqBRFAQFIFaFxWOLSEzg?=
 =?us-ascii?q?QiOPQE?=
X-IronPort-AV: E=Sophos;i="5.64,557,1559545200"; 
   d="scan'208";a="10653444"
Received: from mail-pl1-f200.google.com ([209.85.214.200])
  by smtp1.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Sep 2019 17:45:59 -0700
Received: by mail-pl1-f200.google.com with SMTP id j9so2605331plk.21
        for <linux-iio@vger.kernel.org>; Fri, 27 Sep 2019 17:46:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WVXKJFPAYYP31lJ6IlM5/o8x5LjKeBVij0jUlLnOB1Y=;
        b=UN+dwJrIYp1oqQJMGDu7ebGBOp08lxNjyVZUt9MbCEwYyRKxhEki1iVbq37DYehYBY
         QHA1veONoPJ1Gbg3pz1Tbc+JydQ/1Rv3NOzs4vaK5H0CnpO2NBZVprnYUfM2zaO3bBmO
         co0vsolU4Ul7m0ZsTiY7h+vuUj6rrUfqY7aOjtBhaj5BmKB49qwg6YtTFkPkRsmhkiA0
         KqNYd4oxIMN3F4EWKhi2LCFrmBHa58Cao41ohTWSuUvx2BBVe5T+IjnOyulWj84/NFdV
         uX1ELX6de3lQOypciPSNO4Zka3c/LjVtrA6je2g+hvRAYp75m5HsOcEz8/8e1s12fz6m
         dzSg==
X-Gm-Message-State: APjAAAWCR1075pn1h5c3Ql3ls8ml9i6e8yRyn2do8Pzh7/NNcokDqYtm
        Hds9nBRh7v6jUpwmxK2wSUR2iE0HsVsmtUe8h4m56rF64vwb0i3hHjvx4KSXK2HQDyV9ZLutuZj
        kkZvCVkzhL0AH0gU03L/gsw==
X-Received: by 2002:a17:90a:3301:: with SMTP id m1mr13556469pjb.27.1569631560294;
        Fri, 27 Sep 2019 17:46:00 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx/7cnNYMLx9aWgtGrOZYcIU8PemYtXquLbvog1tYQtmk61OBe75ni/14YXREFeG7CW3SRlDg==
X-Received: by 2002:a17:90a:3301:: with SMTP id m1mr13556446pjb.27.1569631560014;
        Fri, 27 Sep 2019 17:46:00 -0700 (PDT)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id r2sm4136689pfq.60.2019.09.27.17.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 17:45:59 -0700 (PDT)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicholas Mc Guire <hofrat@osadl.org>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: meson-saradc: Variables could be uninitalized if regmap_read() fails
Date:   Fri, 27 Sep 2019 17:46:41 -0700
Message-Id: <20190928004642.28932-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Several functions in this file are trying to use regmap_read() to
initialize the specific variable, however, if regmap_read() fails,
the variable could be uninitialized but used directly, which is
potentially unsafe. The return value of regmap_read() should be
checked and handled.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/iio/adc/meson_saradc.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 7b28d045d271..c032a64108b4 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -323,6 +323,7 @@ static int meson_sar_adc_wait_busy_clear(struct iio_dev *indio_dev)
 {
 	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
 	int regval, timeout = 10000;
+	int ret;
 
 	/*
 	 * NOTE: we need a small delay before reading the status, otherwise
@@ -331,7 +332,9 @@ static int meson_sar_adc_wait_busy_clear(struct iio_dev *indio_dev)
 	 */
 	do {
 		udelay(1);
-		regmap_read(priv->regmap, MESON_SAR_ADC_REG0, &regval);
+		ret = regmap_read(priv->regmap, MESON_SAR_ADC_REG0, &regval);
+		if (ret)
+			return ret;
 	} while (FIELD_GET(MESON_SAR_ADC_REG0_BUSY_MASK, regval) && timeout--);
 
 	if (timeout < 0)
@@ -358,7 +361,11 @@ static int meson_sar_adc_read_raw_sample(struct iio_dev *indio_dev,
 		return -EINVAL;
 	}
 
-	regmap_read(priv->regmap, MESON_SAR_ADC_FIFO_RD, &regval);
+	int ret = regmap_read(priv->regmap, MESON_SAR_ADC_FIFO_RD, &regval);
+
+	if (ret)
+		return ret;
+
 	fifo_chan = FIELD_GET(MESON_SAR_ADC_FIFO_RD_CHAN_ID_MASK, regval);
 	if (fifo_chan != chan->address) {
 		dev_err(&indio_dev->dev,
@@ -491,6 +498,7 @@ static int meson_sar_adc_lock(struct iio_dev *indio_dev)
 {
 	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
 	int val, timeout = 10000;
+	int ret;
 
 	mutex_lock(&indio_dev->mlock);
 
@@ -506,7 +514,10 @@ static int meson_sar_adc_lock(struct iio_dev *indio_dev)
 		 */
 		do {
 			udelay(1);
-			regmap_read(priv->regmap, MESON_SAR_ADC_DELAY, &val);
+			ret = regmap_read(priv->regmap,
+					MESON_SAR_ADC_DELAY, &val);
+			if (ret)
+				return ret;
 		} while (val & MESON_SAR_ADC_DELAY_BL30_BUSY && timeout--);
 
 		if (timeout < 0) {
@@ -784,7 +795,10 @@ static int meson_sar_adc_init(struct iio_dev *indio_dev)
 		 * BL30 to make sure BL30 gets the values it expects when
 		 * reading the temperature sensor.
 		 */
-		regmap_read(priv->regmap, MESON_SAR_ADC_REG3, &regval);
+		ret = regmap_read(priv->regmap, MESON_SAR_ADC_REG3, &regval);
+		if (ret)
+			return ret;
+
 		if (regval & MESON_SAR_ADC_REG3_BL30_INITIALIZED)
 			return 0;
 	}
@@ -1014,7 +1028,11 @@ static irqreturn_t meson_sar_adc_irq(int irq, void *data)
 	unsigned int cnt, threshold;
 	u32 regval;
 
-	regmap_read(priv->regmap, MESON_SAR_ADC_REG0, &regval);
+	int ret = regmap_read(priv->regmap, MESON_SAR_ADC_REG0, &regval);
+
+	if (ret)
+		return ret;
+
 	cnt = FIELD_GET(MESON_SAR_ADC_REG0_FIFO_COUNT_MASK, regval);
 	threshold = FIELD_GET(MESON_SAR_ADC_REG0_FIFO_CNT_IRQ_MASK, regval);
 
-- 
2.17.1

