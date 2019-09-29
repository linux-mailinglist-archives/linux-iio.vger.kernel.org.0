Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A27BBC1658
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2019 18:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbfI2QsL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Sep 2019 12:48:11 -0400
Received: from mx3.ucr.edu ([138.23.248.64]:35224 "EHLO mx3.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbfI2QsL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Sep 2019 12:48:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1569775691; x=1601311691;
  h=from:to:cc:subject:date:message-id;
  bh=UNKIGMa4Eg+l+IVQcMpLQFIdcsa8oCD4s9qyVCpjIUE=;
  b=KMl6eBygGNPUmTdGJGcsZ0AFQA+Bz7Dr06c8vFQLg0WEJ1FXlDsVwH+J
   1nr2KNVkL9jj3xprvGIRfZNNxlsp4N0vYFGKOtIQDV3JhG/IpsVfFLXeI
   xkKEGkSXOSayWtubuxYRiXr4L8d+7UUHpFP5A9/kMkUfY09V097rGr1Xr
   pws/4Wqt1fgK2p6wEtju2tbY6DqMDZqYEQr0wp4Sk13kRnqCK8Niw67uR
   I3LHGxrprPDlIdHLW6bEwC9sZr2DtzrlDauPQPqCBqQCXa0dQITLk7QbC
   z0SRMHdih8dV+V4D78yV/sx/S2Shn/jCA6XbratSQv9RQ/9zjwNsfjrUo
   g==;
IronPort-SDR: 23ZA8QOvmEZt6J7xrjUKRZZQFS6Lt7l0cTkPoA0ZGcTSHQBU45joVAN2txqfPf6YK1iotXN4vN
 QF6Mo0i6yyOM8pzmZyE+t3DbaGXjSk6lUfVrts6GIvFya0+AEfuADjQiuZV1ky2V7d3l14Epgl
 7x9QA5hr4nWi51Joe/rvUhs3bcBcl2uZbAGRYW7o18jsixnav3NS9iUIgC6Y1azi0Agx2O8Qkw
 v2MeJ3l3/QVDuo+cCXkXtwhOBX51ykkBkbc+D44zOOOhdj7UX8lGYQe45IDjKx9x/bW9isXnMT
 qmU=
IronPort-PHdr: =?us-ascii?q?9a23=3Aohyx6BWAjYGOdFLrv424ns7cMXfV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYYxyPt8tkgFKBZ4jH8fUM07OQ7/m7HzBYqs/Z7jgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrowjdrMYbjZdtJqos1h?=
 =?us-ascii?q?fEo2ZDdvhLy29vOV+dhQv36N2q/J5k/SRQuvYh+NBFXK7nYak2TqFWASo/PW?=
 =?us-ascii?q?wt68LlqRfMTQ2U5nsBSWoWiQZHAxLE7B7hQJj8tDbxu/dn1ymbOc32Sq00WS?=
 =?us-ascii?q?in4qx2RhLklDsLOjgk+2zMlMd+kLxUrw6gpxxnwo7bfoeVNOZlfqjAed8WXH?=
 =?us-ascii?q?dNUtpNWyBEBI68aooPD/EaPeZZqYn9qEYFowWnCwKxCuPvyyFHhnvr0qYn1+?=
 =?us-ascii?q?gsHx3K0AkmEtkTsnrbsc/1Ob8SX+6r0afGwzbNYfRN1Dvh9ITFaAwtrOuQUb?=
 =?us-ascii?q?5sd8fa1EkhFxnCjlWVsYHqPTKV1+UNs2iG6OprSOWiim4mqgFxuDevx9sghp?=
 =?us-ascii?q?XHi48O11DL6T95zJwrKtKlVU52eNipG4ZTuSGCL4Z6XN8uTmVytCs5yrAKo4?=
 =?us-ascii?q?C3cDUWxJg92hLSb/iKf5CV7h/iUOudOyl0iXxldb6lmRq/8FKsx+/zW8SyzV?=
 =?us-ascii?q?1EtDBKksPWuXAIzxHT78+HReZj8Uq5wjaP0hzT6vlDIUApiarXM54hzaA0lp?=
 =?us-ascii?q?oUqUnDGzX5mETyjKOPbkUk9PWk5/3pYrn7opKRM5V4ig75MqQplcy/Bfo3Ph?=
 =?us-ascii?q?ISUGic/OSwzLzj/UvnT7VWlvA6jLXVvZTAKckYpqO1GRFZ3ps/5xqlEjur1N?=
 =?us-ascii?q?AVkWECLF1feRKHi4bpO0vJIPD9Ffq+g1WtkDdxyPDHIrHtHpvAI2PekLj9Z7?=
 =?us-ascii?q?Zx8VBTxxcuzdxH/ZJbFqkBIO7vWk/2rNHYCh45Mwqpw+foEdl914IeWWWUD6?=
 =?us-ascii?q?+HP6Pdr0WI6vgsI+aSfo8VvijyK/w/6/7pl385lgxVU7Ou2M4maWK4A/Mud1?=
 =?us-ascii?q?SLYXPt2o9aOXoBpEwzQPG82w7KaiJae3vnB/F03To8Eo/zSNibSw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EZBQD+3pBdgMfSVdFmHgEGEoFcC4N?=
 =?us-ascii?q?eTBCNHoVyUQEBBosmgQmFeogxgXsBCAEBAQwBAS0CAQGEQIM6IzQJDgIDCQE?=
 =?us-ascii?q?BBQEBAQEBBQQBAQIQAQEJDQkIJ4VCgjopgzULFhVSgRUBBQE1IjmCRwGBdhS?=
 =?us-ascii?q?fO4EDPIwlM4hqAQkNgUgJAQiBIoc1hFmBEIEHgRGDUIdjgkQEgS8BAQGLP4I?=
 =?us-ascii?q?xhyuWSQEGAoIQFIF4kwcnhDmJPYs/AS2KKJxrAgoHBg8jgS+CEU0lgWwKgUR?=
 =?us-ascii?q?QEBSBWhcVji0hM4EIkA8B?=
X-IPAS-Result: =?us-ascii?q?A2EZBQD+3pBdgMfSVdFmHgEGEoFcC4NeTBCNHoVyUQEBB?=
 =?us-ascii?q?osmgQmFeogxgXsBCAEBAQwBAS0CAQGEQIM6IzQJDgIDCQEBBQEBAQEBBQQBA?=
 =?us-ascii?q?QIQAQEJDQkIJ4VCgjopgzULFhVSgRUBBQE1IjmCRwGBdhSfO4EDPIwlM4hqA?=
 =?us-ascii?q?QkNgUgJAQiBIoc1hFmBEIEHgRGDUIdjgkQEgS8BAQGLP4IxhyuWSQEGAoIQF?=
 =?us-ascii?q?IF4kwcnhDmJPYs/AS2KKJxrAgoHBg8jgS+CEU0lgWwKgURQEBSBWhcVji0hM?=
 =?us-ascii?q?4EIkA8B?=
X-IronPort-AV: E=Sophos;i="5.64,563,1559545200"; 
   d="scan'208";a="83746920"
Received: from mail-pf1-f199.google.com ([209.85.210.199])
  by smtp3.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Sep 2019 09:48:08 -0700
Received: by mail-pf1-f199.google.com with SMTP id z13so6002438pfr.15
        for <linux-iio@vger.kernel.org>; Sun, 29 Sep 2019 09:48:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=utdaQ4jWHTttFql8WKqbnsQdQq9GY1vzrMBpLN2a9NQ=;
        b=CjYMbRjqCs5vwr4KcJJ+27p38mYxRzMHwb3BX3JrSUO2T9qa7W8EMfjZGfx0J5aYV0
         lrJsXlC9HTc4h1TqQfQocgoWooj/eF3w9koeJxdCDeyaaQgg3dxz1Z9aEwkvYU3/1ZXf
         iiQbVrmuONrHppCIwHf0UOrUFnvfFIKFB4kEu5tEYJAwBJFymRrwd8yCFkDKuaI8kVZ4
         oWJhYiE1hzPmrCe7L8h2egJ3dyYFLLG+dXU1uiwKWIAnQ/VKh5KGDHV6P9BmKW7BF2g1
         HnoCaygVwebzb8H7+2ycVwpeHt5j/7DVJNT2mRfyBJIsqucnAOCH3yog1ORMBdYlnhAL
         FqgA==
X-Gm-Message-State: APjAAAVP6e+/+pmCJVYP2IpWVeo36fOxQtEJYFLWFN4z5JtRtKD2Hv1u
        D4FIXb8a9yHAPi5aEUBPnfJFBHKjV0B2JBwM6BMjWbX432a6inmXIBk/Axl7ObVZKEh4QbU4G+I
        y4tsPi1RbcADJRR3M3lJbIA==
X-Received: by 2002:a17:90a:3090:: with SMTP id h16mr22224054pjb.46.1569775687369;
        Sun, 29 Sep 2019 09:48:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxJjjuQpguiCEE+oT8FZ21bOrlaI5ek77fAN6CJVVTks05KOo47tYsfxvPiCR9IDOpmjYNCew==
X-Received: by 2002:a17:90a:3090:: with SMTP id h16mr22224024pjb.46.1569775687030;
        Sun, 29 Sep 2019 09:48:07 -0700 (PDT)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id ep10sm26814605pjb.2.2019.09.29.09.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 09:48:05 -0700 (PDT)
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicholas Mc Guire <hofrat@osadl.org>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: meson-saradc: Variables could be uninitalized if regmap_read() fails
Date:   Sun, 29 Sep 2019 09:48:43 -0700
Message-Id: <20190929164848.13930-1-yzhai003@ucr.edu>
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
 drivers/iio/adc/meson_saradc.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 7b28d045d271..4b6c2983ef39 100644
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
@@ -346,6 +349,7 @@ static int meson_sar_adc_read_raw_sample(struct iio_dev *indio_dev,
 {
 	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
 	int regval, fifo_chan, fifo_val, count;
+	int ret;
 
 	if(!wait_for_completion_timeout(&priv->done,
 				msecs_to_jiffies(MESON_SAR_ADC_TIMEOUT)))
@@ -358,7 +362,10 @@ static int meson_sar_adc_read_raw_sample(struct iio_dev *indio_dev,
 		return -EINVAL;
 	}
 
-	regmap_read(priv->regmap, MESON_SAR_ADC_FIFO_RD, &regval);
+	ret = regmap_read(priv->regmap, MESON_SAR_ADC_FIFO_RD, &regval);
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
+						MESON_SAR_ADC_DELAY, &val);
+			if (ret)
+				return ret;
 		} while (val & MESON_SAR_ADC_DELAY_BL30_BUSY && timeout--);
 
 		if (timeout < 0) {
@@ -771,7 +782,7 @@ static int meson_sar_adc_init(struct iio_dev *indio_dev)
 {
 	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
 	int regval, i, ret;
-
+	int ret;
 	/*
 	 * make sure we start at CH7 input since the other muxes are only used
 	 * for internal calibration.
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
@@ -1013,8 +1027,12 @@ static irqreturn_t meson_sar_adc_irq(int irq, void *data)
 	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
 	unsigned int cnt, threshold;
 	u32 regval;
+	int ret;
+
+	ret = regmap_read(priv->regmap, MESON_SAR_ADC_REG0, &regval);
+	if (ret)
+		return ret;
 
-	regmap_read(priv->regmap, MESON_SAR_ADC_REG0, &regval);
 	cnt = FIELD_GET(MESON_SAR_ADC_REG0_FIFO_COUNT_MASK, regval);
 	threshold = FIELD_GET(MESON_SAR_ADC_REG0_FIFO_CNT_IRQ_MASK, regval);
 
-- 
2.17.1

