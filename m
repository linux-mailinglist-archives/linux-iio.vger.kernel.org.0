Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5144C2862
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2019 23:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfI3VPC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Sep 2019 17:15:02 -0400
Received: from mx2.ucr.edu ([138.23.62.3]:35745 "EHLO mx2.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727767AbfI3VPB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Sep 2019 17:15:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1569878101; x=1601414101;
  h=from:to:cc:subject:date:message-id;
  bh=HYGA3/ETQRN0dliOSfTAE61tbuv040Q6WyOvR7/0sbI=;
  b=f8+ne9ATxgS4r5uBlGbuJfX6LlOObPJ/yupVJVVioN2vTLWloLoOwZUe
   D548U6GjdlTYRsJ0XzxHz3OhN0LPw4ozM/6CQGZVyPjVhE6YgkSveWkRQ
   EuTvkjTfWo8c/vptJfYsn/uaSH6ycmiDB+gfbnLAdQWlD30/DVlzv08Nj
   RoQ3meKJYc5+oLQmlH7r8t6luudHPJRHmA8KnU2YqnzHvggaq/RbfGkiZ
   gMHnvu84d1OidMKrPjD7bomiMg6vRJ9mDAvTK24eNsJmYFVdxLThBbQu/
   ahmOEJGH8saV9SmGXl5jwSOewPllh+uLlH1QqNAz1W2hDCMIbI96ZWxoE
   g==;
IronPort-SDR: oB6xZTQGvti6aIbCzE04ay03k5eH0dRhWLQ7YicRH3AdrPm1+kcmncifVwcC/HegM+Zdjci9dL
 0QOpGrdFD7989DaC10WhzyxBOUp2nj5D9de1LNRpGnfPQhLZS9LHBRzcmJPp/ojmdxvs90UV65
 KZf9JwglFpwlZUQHsRLcO067x7pV09sVd/TmfxDfc8a3b2x2Z8a3Dcn6CvbCopoc70h4euvvy3
 n1usQ4y26hZP2OFLTS7GLOwBER89iDj164ySCFcuu2VJAhrUGkCU5ru/6bDWaQvlkp5QX2HNx6
 0gw=
IronPort-PHdr: =?us-ascii?q?9a23=3A78UNtxP83BzUGmR0mBcl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0LfTzrarrMEGX3/hxlliBBdydt6sfzbaM+Pm8BiQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagb75+Nhq7oRveusULjoZvKLs6xw?=
 =?us-ascii?q?fUrHdPZ+lY335jK0iJnxb76Mew/Zpj/DpVtvk86cNOUrj0crohQ7BAAzsoL2?=
 =?us-ascii?q?465MvwtRneVgSP/WcTUn8XkhVTHQfI6gzxU4rrvSv7sup93zSaPdHzQLspVz?=
 =?us-ascii?q?mu87tnRRn1gyocKTU37H/YhdBxjKJDoRKuuRp/w5LPYIqIMPZyZ77Rcc8GSW?=
 =?us-ascii?q?ZEWMtRUi1BApinb4sOCeoBMvtToZfkqVAToxu+BBejBOfyxTRVgnP707E23+?=
 =?us-ascii?q?EnHArb3gIvAsgOvWzUotvrKakcX+O7wq7TwDnfc/9bwyvx5ZLUfhw9p/yHQL?=
 =?us-ascii?q?J+cdDWyUkqDw7KjFSQqI3lPzOI0eQGrm+W7uphVOKvkWEnqh19riShy8o3l4?=
 =?us-ascii?q?nGmpgVxkra+ipk3YY4PNu1Q1N4b968CJZcqT2WOo9sTs4hQ2xkojg2xqAJtJ?=
 =?us-ascii?q?KhYSQHzJYqywbCZ/GGd4WE+AzvWeiRLDtimn5oeaizihS9/EWm1+byTNO70E?=
 =?us-ascii?q?xQoSpAitTMs3cN2AHN5cWfUft9+1uh2S6I1wDO9uFIOUA0mrTfK54m2rMwk4?=
 =?us-ascii?q?AcsUXHHiPvgEX2iLKaelwq+uS17+nqYK/qppCbN49zhQH+NrohltajDuQ/Nw?=
 =?us-ascii?q?gCR2mb+eKi273/5UD1XqlGg/ksnqTasJ3WP9oXqrO2DgNPz4ou7xSyAy+j0N?=
 =?us-ascii?q?sCnHkHKFxFeAiAj4jsI1zPIPH5DfeljFStjDtn2/7LM6b8AprRNHjPiqnucq?=
 =?us-ascii?q?tg60JE0go80chf545ICrEGOP/zXk7xtNrFDh42KgC0wufnCNJm24MAVmKAHL?=
 =?us-ascii?q?WZPLnRsVCW/OIvJfeDZIsPtDb6Mfgl6K2mo2U+nAosfLupwJxfPGGqHv1nex?=
 =?us-ascii?q?3CSWfnmJEMHXpc7Vl2d/DjlFDXCW0bXH21Ra9po25jBQ=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FBBgDiZ5Jdh8XWVdFmhXxMEI0ehkU?=
 =?us-ascii?q?BAQaLJoEJhXqKLAEIAQEBDAEBLQIBAYRAg0YjOBMCAwkBAQUBAQEBAQUEAQE?=
 =?us-ascii?q?CEAEBAQgNCQgphUCCOimDNQsWFVKBFQEFATUiOYJHAYF2FKJEgQM8jCUziGA?=
 =?us-ascii?q?BCQ2BSAkBCIEihzWEWYEQgQeEYYdlgkQEgTcBAQGLPgGCMYcrlkkBBgKCEBS?=
 =?us-ascii?q?BeJMHJ4I3ggKJPTmLBgGKVZxrAgoHBg8jgUaBe00lgWwKgURQEBSBWw4JjkM?=
 =?us-ascii?q?hM4EIkBoB?=
X-IPAS-Result: =?us-ascii?q?A2FBBgDiZ5Jdh8XWVdFmhXxMEI0ehkUBAQaLJoEJhXqKL?=
 =?us-ascii?q?AEIAQEBDAEBLQIBAYRAg0YjOBMCAwkBAQUBAQEBAQUEAQECEAEBAQgNCQgph?=
 =?us-ascii?q?UCCOimDNQsWFVKBFQEFATUiOYJHAYF2FKJEgQM8jCUziGABCQ2BSAkBCIEih?=
 =?us-ascii?q?zWEWYEQgQeEYYdlgkQEgTcBAQGLPgGCMYcrlkkBBgKCEBSBeJMHJ4I3ggKJP?=
 =?us-ascii?q?TmLBgGKVZxrAgoHBg8jgUaBe00lgWwKgURQEBSBWw4JjkMhM4EIkBoB?=
X-IronPort-AV: E=Sophos;i="5.64,568,1559545200"; 
   d="scan'208";a="11706546"
Received: from mail-pl1-f197.google.com ([209.85.214.197])
  by smtp2.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Sep 2019 13:44:12 -0700
Received: by mail-pl1-f197.google.com with SMTP id g7so5911174plo.5
        for <linux-iio@vger.kernel.org>; Mon, 30 Sep 2019 13:44:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dapQGiPs5+yxjLDl9zMNq1LcsFOAJWQdGyLQ0/gwWhQ=;
        b=XMdcaIIxBaXQuzf/exRlY4bVV1GIvYWoUKZ+JNWAeQjhKxO0FHd5RvBCc0X9S85b4P
         2BAtn8fad+AciKsb4YuiWYRcAfZDHDvxr9AjSW7N1GIB3iDpc+Jw7OcBiM6cQQzAIKbJ
         YqzrZPKrECRfTjk2meRl2m7ThBsqhJ1QaWO7rp0Rtgg/F3XvzkG5sYgo9qvKA7HeCHfi
         lwHsum//xYI9vLs1/B3fk2XHoNAAiGvcOP0zbhh3s7uUBPavuWrvDvU9cB5W5BQAs7gh
         45e5xViUi4eMhNDsMY63rujh3ZoEVNTqOSVS0WKMQsg9XiefCrpAoJOx9wueamFZgJB6
         WPOw==
X-Gm-Message-State: APjAAAW7AlFJuDtIO8rDzveykumELtCXREBUymJb+4mAXTLSCQnePUOK
        JvCvsb/c/LM7L4IF3UKRtGE4+mhYiH0FVVl2mXuiqFy/xuBuSonfew0qG78he2eAzRLe+dDzDpY
        EEyuak1ysKOzKYsZcaXS2XA==
X-Received: by 2002:a63:e001:: with SMTP id e1mr11470031pgh.358.1569876251833;
        Mon, 30 Sep 2019 13:44:11 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx9zg1sf8FzV4vsDfqgG05ZRQlpuE7Jqlj1s/A+Zus03/W2Go073rlg0ow44d+y6lPcxf9YEw==
X-Received: by 2002:a63:e001:: with SMTP id e1mr11469999pgh.358.1569876251280;
        Mon, 30 Sep 2019 13:44:11 -0700 (PDT)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id s97sm409068pjc.4.2019.09.30.13.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 13:44:10 -0700 (PDT)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: trigger: stm32-timer: fix the usage of uninitialized variables
Date:   Mon, 30 Sep 2019 13:44:49 -0700
Message-Id: <20190930204451.28614-1-yzhai003@ucr.edu>
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
checked and handled. This patch fixes most of the uninitialized
variables, but those in function stm32_tt_read_frequency() are
hard to handle and need extra effot.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/iio/trigger/stm32-timer-trigger.c | 98 ++++++++++++++++++++---
 1 file changed, 85 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
index a5dfe65cd9b9..f8ea7bcbb739 100644
--- a/drivers/iio/trigger/stm32-timer-trigger.c
+++ b/drivers/iio/trigger/stm32-timer-trigger.c
@@ -107,6 +107,7 @@ static int stm32_timer_start(struct stm32_timer_trigger *priv,
 	unsigned long long prd, div;
 	int prescaler = 0;
 	u32 ccer, cr1;
+	int ret;
 
 	/* Period and prescaler values depends of clock rate */
 	div = (unsigned long long)clk_get_rate(priv->clk);
@@ -132,11 +133,21 @@ static int stm32_timer_start(struct stm32_timer_trigger *priv,
 	}
 
 	/* Check if nobody else use the timer */
-	regmap_read(priv->regmap, TIM_CCER, &ccer);
+	ret = regmap_read(priv->regmap, TIM_CCER, &ccer);
+	if (ret) {
+		dev_err(priv->dev, "fail to read TIM_CCER.\n");
+		return ret;
+	}
+
 	if (ccer & TIM_CCER_CCXE)
 		return -EBUSY;
 
-	regmap_read(priv->regmap, TIM_CR1, &cr1);
+	ret = regmap_read(priv->regmap, TIM_CR1, &cr1);
+	if (ret) {
+		dev_err(priv->dev, "fail to read TIM_CR1.\n");
+		return ret;
+	}
+
 	if (!(cr1 & TIM_CR1_CEN))
 		clk_enable(priv->clk);
 
@@ -164,12 +175,23 @@ static int stm32_timer_start(struct stm32_timer_trigger *priv,
 static void stm32_timer_stop(struct stm32_timer_trigger *priv)
 {
 	u32 ccer, cr1;
+	int ret;
+
+	ret = regmap_read(priv->regmap, TIM_CCER, &ccer);
+	if (ret) {
+		dev_err(priv->dev, "Fail to read TIM_CCER.\n");
+		return;
+	}
 
-	regmap_read(priv->regmap, TIM_CCER, &ccer);
 	if (ccer & TIM_CCER_CCXE)
 		return;
 
-	regmap_read(priv->regmap, TIM_CR1, &cr1);
+	ret = regmap_read(priv->regmap, TIM_CR1, &cr1);
+	if (ret) {
+		dev_err(priv->dev, "Fail to read TIM_CR1.\n");
+		return;
+	}
+
 	if (cr1 & TIM_CR1_CEN)
 		clk_disable(priv->clk);
 
@@ -403,20 +425,36 @@ static int stm32_counter_read_raw(struct iio_dev *indio_dev,
 {
 	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
 	u32 dat;
+	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		regmap_read(priv->regmap, TIM_CNT, &dat);
+		ret = regmap_read(priv->regmap, TIM_CNT, &dat);
+		if (ret) {
+			dev_err(priv->dev, "fail to read TIM_CNT.\n");
+			return ret;
+		}
+
 		*val = dat;
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_ENABLE:
-		regmap_read(priv->regmap, TIM_CR1, &dat);
+		ret = regmap_read(priv->regmap, TIM_CR1, &dat);
+		if (ret) {
+			dev_err(priv->dev, "fail to read TIM_CR1.\n");
+			return ret;
+		}
+
 		*val = (dat & TIM_CR1_CEN) ? 1 : 0;
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_SCALE:
-		regmap_read(priv->regmap, TIM_SMCR, &dat);
+		ret = regmap_read(priv->regmap, TIM_SMCR, &dat);
+		if (ret) {
+			dev_err(priv->dev, "fail to read TIM_SMCR.\n");
+			return ret;
+		}
+
 		dat &= TIM_SMCR_SMS;
 
 		*val = 1;
@@ -438,6 +476,7 @@ static int stm32_counter_write_raw(struct iio_dev *indio_dev,
 {
 	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
 	u32 dat;
+	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -449,13 +488,23 @@ static int stm32_counter_write_raw(struct iio_dev *indio_dev,
 
 	case IIO_CHAN_INFO_ENABLE:
 		if (val) {
-			regmap_read(priv->regmap, TIM_CR1, &dat);
+			ret = regmap_read(priv->regmap, TIM_CR1, &dat);
+			if (ret) {
+				dev_err(priv->dev, "fail to read TIM_CR1.\n");
+				return ret;
+			}
+
 			if (!(dat & TIM_CR1_CEN))
 				clk_enable(priv->clk);
 			regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN,
 					   TIM_CR1_CEN);
 		} else {
-			regmap_read(priv->regmap, TIM_CR1, &dat);
+			ret = regmap_read(priv->regmap, TIM_CR1, &dat);
+			if (ret) {
+				dev_err(priv->dev, "fail to read TIM_CR1.\n");
+				return ret;
+			}
+
 			regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN,
 					   0);
 			if (dat & TIM_CR1_CEN)
@@ -517,8 +566,13 @@ static int stm32_get_trigger_mode(struct iio_dev *indio_dev,
 {
 	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
 	u32 smcr;
+	int ret;
 
-	regmap_read(priv->regmap, TIM_SMCR, &smcr);
+	ret = regmap_read(priv->regmap, TIM_SMCR, &smcr);
+	if (ret) {
+		dev_err(priv->dev, "fail to read TIM_SMCR.\n");
+		return ret;
+	}
 
 	return (smcr & TIM_SMCR_SMS) == TIM_SMCR_SMS ? 0 : -EINVAL;
 }
@@ -557,6 +611,7 @@ static int stm32_set_enable_mode(struct iio_dev *indio_dev,
 	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
 	int sms = stm32_enable_mode2sms(mode);
 	u32 val;
+	int ret;
 
 	if (sms < 0)
 		return sms;
@@ -565,7 +620,12 @@ static int stm32_set_enable_mode(struct iio_dev *indio_dev,
 	 * enable counter clock, so it can use it. Keeps it in sync with CEN.
 	 */
 	if (sms == 6) {
-		regmap_read(priv->regmap, TIM_CR1, &val);
+		ret = regmap_read(priv->regmap, TIM_CR1, &val);
+		if (ret) {
+			dev_err(priv->dev, "fail to read TIM_CR1.\n");
+			return ret;
+		}
+
 		if (!(val & TIM_CR1_CEN))
 			clk_enable(priv->clk);
 	}
@@ -594,8 +654,14 @@ static int stm32_get_enable_mode(struct iio_dev *indio_dev,
 {
 	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
 	u32 smcr;
+	int ret;
+
+	ret = regmap_read(priv->regmap, TIM_SMCR, &smcr);
+	if (ret) {
+		dev_err(priv->dev, "fail to read TIM_SMCR.\n");
+		return ret;
+	}
 
-	regmap_read(priv->regmap, TIM_SMCR, &smcr);
 	smcr &= TIM_SMCR_SMS;
 
 	return stm32_sms2enable_mode(smcr);
@@ -706,13 +772,19 @@ EXPORT_SYMBOL(is_stm32_timer_trigger);
 static void stm32_timer_detect_trgo2(struct stm32_timer_trigger *priv)
 {
 	u32 val;
+	int ret;
 
 	/*
 	 * Master mode selection 2 bits can only be written and read back when
 	 * timer supports it.
 	 */
 	regmap_update_bits(priv->regmap, TIM_CR2, TIM_CR2_MMS2, TIM_CR2_MMS2);
-	regmap_read(priv->regmap, TIM_CR2, &val);
+	ret = regmap_read(priv->regmap, TIM_CR2, &val);
+	if (ret) {
+		dev_err(priv->dev, "fail to read TIM_CR2.\n");
+		return;
+	}
+
 	regmap_update_bits(priv->regmap, TIM_CR2, TIM_CR2_MMS2, 0);
 	priv->has_trgo2 = !!val;
 }
-- 
2.17.1

