Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699377A9F5E
	for <lists+linux-iio@lfdr.de>; Thu, 21 Sep 2023 22:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjIUUVe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Sep 2023 16:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbjIUUU4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Sep 2023 16:20:56 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C473B43CA2
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 10:31:40 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50308217223so2092872e87.3
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 10:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695317496; x=1695922296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nYFN9YS9lGoY3Drq+6yfHeUu5PUEzCkva/9j6XN0ZE4=;
        b=la2QrKF/QOTLv9Xl6vpk/AtMY/ONZdAaZu+qx6RtmnnPSI+Sgly6VuQeLB/YdyXxda
         gcXI58IuoSFm6OQhfUEQ82P0v1r8XmhPWtQhahFsemM6hGYmfBNxqaC+2RNhCwXgPknA
         iUHCCZvYdfRaDlH2/e2KLtpAqgkn4+Ty648QGK1K4XXUwZA8MBSPJJQdWKBR0S/sGQnG
         vCr8VuytnRpSuGUyEq2HGFUmGlv3Jwtc2ZUy+RmEKht32REI2ldxn8nmyVJClepoxElm
         C2MLRYKiWJC7Q/v7MogMsKimn+I44RoVo8x6ahQD9tg7maoFzFAxm3FLOXPKxNayHv5a
         wlig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317496; x=1695922296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nYFN9YS9lGoY3Drq+6yfHeUu5PUEzCkva/9j6XN0ZE4=;
        b=aqlNsoXa+TEGFkXN+1iwE9TKTlea4whseM2jgfb0vHIwi++/WSlRsPhY6smq+wP6rc
         D3FpCzUnCN04A/ls+K1xAYWVC5L3tgiYqpOOH9BZJ2qD7Ks25PNqEQrv6yY63CSfC9Tg
         Wbo1FXxHXAzvmWwgfmwR750ZxGDhzmzEOZirXh4zIPSnOLEPLEdv6r/4qvOqI7HNz7T9
         eOfbPMC6MgFRXKOMrygQDPBeViGj+XW2yyKsIyZ3ok5rzFms3ghc0tZQttHbBU50pBag
         HUu30t/CD7Axsi5rDhMvjmiRlSNgHq3bn7cqvUtD9D85/Xp9/2pgY/LQGSfvv3slXImW
         LhNg==
X-Gm-Message-State: AOJu0YwnLlOFJ/v6EvpbQqs2KjGf7Z7na6JI44CpDAy2h5pHjbslA2O9
        GuKf/ejoq2Z24uWK62lhnJ3E3d9+UZTbAqTLqALpamU5
X-Google-Smtp-Source: AGHT+IFu1F25pmyaAgzXYF1qsHUDXBwQ437AiaWnWjMjwmw80fpRWTPc2ECeCGljKdTfsMbdgIq1Yg==
X-Received: by 2002:a1c:ed08:0:b0:405:1bbd:aa9c with SMTP id l8-20020a1ced08000000b004051bbdaa9cmr5515593wmh.34.1695306166581;
        Thu, 21 Sep 2023 07:22:46 -0700 (PDT)
Received: from localhost.localdomain (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id n11-20020a5d4c4b000000b0031fbbe347ebsm1901426wrt.22.2023.09.21.07.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:22:46 -0700 (PDT)
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
Subject: [v2 16/19] staging: iio: resolver: ad2s1210: rename fexcit attribute
Date:   Thu, 21 Sep 2023 09:19:44 -0500
Message-Id: <20230921141947.57784-19-dlechner@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921141947.57784-1-dlechner@baylibre.com>
References: <20230921141947.57784-1-dlechner@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This renames the fexcit attribute to excitation_frequency to be more
human-readable. Since we are already making many breaking changes to
the staging driver, this is a good time to do this.

Also make use of IIO_DEVICE_ATTR_RW while we are touching this.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/staging/iio/resolver/ad2s1210.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 27294eff99ef..14bec2b20939 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -217,9 +217,9 @@ static int ad2s1210_set_resolution_gpios(struct ad2s1210_state *st,
 				     bitmap);
 }
 
-static ssize_t ad2s1210_show_fexcit(struct device *dev,
-				    struct device_attribute *attr,
-				    char *buf)
+static ssize_t excitation_frequency_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
 {
 	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
 	unsigned int value;
@@ -240,9 +240,9 @@ static ssize_t ad2s1210_show_fexcit(struct device *dev,
 	return ret;
 }
 
-static ssize_t ad2s1210_store_fexcit(struct device *dev,
-				     struct device_attribute *attr,
-				     const char *buf, size_t len)
+static ssize_t excitation_frequency_store(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf, size_t len)
 {
 	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
 	u16 fexcit;
@@ -555,8 +555,7 @@ static int ad2s1210_write_raw(struct iio_dev *indio_dev,
 	return ret;
 }
 
-static IIO_DEVICE_ATTR(fexcit, 0644,
-		       ad2s1210_show_fexcit,	ad2s1210_store_fexcit, 0);
+static IIO_DEVICE_ATTR_RW(excitation_frequency, 0);
 static IIO_DEVICE_ATTR(bits, 0644,
 		       ad2s1210_show_resolution, ad2s1210_store_resolution, 0);
 static IIO_DEVICE_ATTR(fault, 0644,
@@ -604,7 +603,7 @@ static const struct iio_chan_spec ad2s1210_channels[] = {
 };
 
 static struct attribute *ad2s1210_attributes[] = {
-	&iio_dev_attr_fexcit.dev_attr.attr,
+	&iio_dev_attr_excitation_frequency.dev_attr.attr,
 	&iio_dev_attr_bits.dev_attr.attr,
 	&iio_dev_attr_fault.dev_attr.attr,
 	&iio_dev_attr_los_thrd.dev_attr.attr,
-- 
2.34.1

