Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D597A97B2
	for <lists+linux-iio@lfdr.de>; Thu, 21 Sep 2023 19:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjIUR1J (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Sep 2023 13:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjIUR0s (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Sep 2023 13:26:48 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D55CF0
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 10:01:14 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-32172f8a5dbso1144851f8f.3
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 10:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695315621; x=1695920421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFHoFBATjyYAR3S3Kihiw7DM+oB505Wu13vuO5lq7BQ=;
        b=1LQEIWrWPgYVvFOfMJ/DdBamYItOVN+hx687qgsPSYuQ67lTbBPCtyIOqZt2261h/y
         eNCWL8c21gGATxZ4Q6NTAr7sjhzCC4E36M+ytA0z1fg+xX8bQZkmrhtCWthBFjGVC8L5
         f5hE6dzFWVVtg1Xb+/jdSCGgPkG2EX+tc6o2aMEwGHl+67ygqpWQcL2kU6GBgW7mrKm5
         AV7NQkeriEcFCI/hg+N1JPCtXoFzxEl+//v6x92RL21L/KOk1cgokfEDSWXKaZsSeFS5
         kyt2uN2JOP6a7+EwW+ECooNKVfL1ZYCPAhRkXFyJHMLepZzm+Dnkae7Zigc6WqOtdit9
         UWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695315621; x=1695920421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FFHoFBATjyYAR3S3Kihiw7DM+oB505Wu13vuO5lq7BQ=;
        b=KPg19uYEBdceUjF44tIKrYu6fQs7VATzhACTQNKhu+I4lCdAjVpyYdAD3+zKJ5xu2L
         SbrYq2hEOppQSwTDWkyTdpyX6vSgkQ+UxuEVVgKURPaSCPphuwLsgvHxh6iLHvc0bXUv
         pWOE+IK4hdKiOVLP0JV8QHY9H77wlvqfvMHuCov30vPaV9oiMISgL1tQP3YQNySHI33s
         CV1hgflUg3W3Zt/Dyvy+8846ZQPtx1qYe2RFBYNrsAk4wZA341oZoVgZwI+hQCOl540k
         WE0kIlOGL2wklZajPM1vz+e4W8n89bplv9K+JkRyok/QPp29urEh2D9ITkCisFp4Y75Y
         2XHA==
X-Gm-Message-State: AOJu0Yxkhm55Uspj1g74T8uZPWGupvqqB4dJRFiY//Q3JaHNW6jzxJdk
        //eLQ5xSRFXq6bKshejQr/7owT50Rp7mNjsvBtAhUpzu
X-Google-Smtp-Source: AGHT+IEuEQ+yHcKXMmNkfUgwvUgJV0TYHVRrMSBE2WgINBdiZLHbPgjRXkTk6HjPHk2lj+d6o1Or/w==
X-Received: by 2002:adf:fb47:0:b0:316:fc63:dfed with SMTP id c7-20020adffb47000000b00316fc63dfedmr3915975wrs.39.1695306165716;
        Thu, 21 Sep 2023 07:22:45 -0700 (PDT)
Received: from localhost.localdomain (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id n11-20020a5d4c4b000000b0031fbbe347ebsm1901426wrt.22.2023.09.21.07.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:22:45 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        David Lechner <dlechner@baylibre.com>
Subject: [v2 15/19] staging: iio: resolver: ad2s1210: read excitation frequency from control register
Date:   Thu, 21 Sep 2023 09:19:43 -0500
Message-Id: <20230921141947.57784-18-dlechner@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921141947.57784-1-dlechner@baylibre.com>
References: <20230921141947.57784-1-dlechner@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This modifies the ad2s1210_show_fexcit() function to read the excitation
frequency from the control register. This way we don't have to keep
track of the value and don't risk returning a stale value.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/staging/iio/resolver/ad2s1210.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index f1ffee34ebbc..27294eff99ef 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -78,7 +78,6 @@ struct ad2s1210_state {
 	struct regmap *regmap;
 	/** The external oscillator frequency in Hz. */
 	unsigned long fclkin;
-	unsigned int fexcit;
 	u8 resolution;
 	u8 rx[2] __aligned(IIO_DMA_MINALIGN);
 	u8 tx[2];
@@ -202,8 +201,6 @@ static int ad2s1210_set_excitation_frequency(struct ad2s1210_state *st,
 	if (ret < 0)
 		return ret;
 
-	st->fexcit = fexcit;
-
 	/* software reset reinitializes the excitation frequency output */
 	return regmap_write(st->regmap, AD2S1210_REG_SOFT_RESET, 0);
 }
@@ -225,8 +222,22 @@ static ssize_t ad2s1210_show_fexcit(struct device *dev,
 				    char *buf)
 {
 	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
+	unsigned int value;
+	u16 fexcit;
+	int ret;
 
-	return sprintf(buf, "%u\n", st->fexcit);
+	mutex_lock(&st->lock);
+	ret = regmap_read(st->regmap, AD2S1210_REG_EXCIT_FREQ, &value);
+	if (ret < 0)
+		goto error_ret;
+
+	fexcit = value * st->fclkin / (1 << 15);
+
+	ret = sprintf(buf, "%u\n", fexcit);
+
+error_ret:
+	mutex_unlock(&st->lock);
+	return ret;
 }
 
 static ssize_t ad2s1210_store_fexcit(struct device *dev,
-- 
2.34.1

