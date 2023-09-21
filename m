Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090E87A9DC0
	for <lists+linux-iio@lfdr.de>; Thu, 21 Sep 2023 21:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjIUTrC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Sep 2023 15:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbjIUTq4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Sep 2023 15:46:56 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701A5561C7
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 10:52:19 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-400a087b0bfso13032425e9.2
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 10:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695318737; x=1695923537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9WVKxDU/WCTxqQ52/M5ua8wasfSRRcZpI1eeblkSC8=;
        b=VzQLyXUsjMOeKvBPyj07uWQGtUKOu9NSyLaaQtjtf7Uel6fd8vx5Hvr04+uf0VkirS
         ti/xhmEODcTODxKQVjz9aGGcsn+vzrheoA1t++M3PA+MtQ6wMdoiCkiYJQi0IjAmouz/
         X/VzlrUXq5GIxI8joQug85/V14k2bcHV3WbJ7N8NP7j4/xMa5GwK+AhAwN9AGJ+KexRE
         NOhFrG/ZJHauk5z9eXu3FJMDyoJCltdHDLMdkbvRKOON3KTeNV/It1VgpSqv5tn9yYuz
         x3fxh6ApFvaee0cWp2x76o1EhgukpPhF4YurYILrx1rtivzmhLM6m+9vyHJBvDmpqgUN
         2bGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695318737; x=1695923537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9WVKxDU/WCTxqQ52/M5ua8wasfSRRcZpI1eeblkSC8=;
        b=QceK4RHbADnpUGSE7/gi/eRWPmysBSUk8zke4Cl+K+HGloFnZfUPBlAxYrtsAgy3DO
         7/ZIS1zcCGnQKW8BvnikOZJIbzSdUePDQrqFJTvWYgvLMWyp5B7H0RGbk1sj5Vf63Ysr
         Io5xFjQ6ysZGxfW2OMQ2M0911+UhcaUbnKVMkX4Rs2uyIi0Rm6Gbb3TsxCgGOZd6nBNf
         NIVAErcPscWqOxnHsnFF7Fm+W1e7ffTfVMUN+dIdyliWPQZ6qi/ZH36dih6LHgwGkCEc
         Pse0pO7hAA9RoOxq8Ja0lmXWg9oUbaBJ76EmiU8p7T/5HD7TMlMc+4wp4cgbzcpLUr9i
         aIsQ==
X-Gm-Message-State: AOJu0YwGzh7OwixBbJSfdDW3gJZmFfPv006Fat5Uo7mIvYNo+wzFYoeX
        YBd8C4fweAgAWa0om9WRMHvFI8dXWeyvutX20Tzs/3Wv
X-Google-Smtp-Source: AGHT+IE9ZEE6qW3Uh7F/2SHDgzRpOaJowWC7a1ZsGgdxWu4OvSFD38FqiRfJikCDKaiQeM4iFx0WXA==
X-Received: by 2002:a5d:500d:0:b0:317:58e4:e941 with SMTP id e13-20020a5d500d000000b0031758e4e941mr5405435wrt.33.1695307462223;
        Thu, 21 Sep 2023 07:44:22 -0700 (PDT)
Received: from localhost.localdomain (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id s17-20020a1cf211000000b003fe2a40d287sm2125515wmc.1.2023.09.21.07.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:44:21 -0700 (PDT)
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
Subject: [PATCH v2 11/19] staging: iio: resolver: ad2s1210: remove config attribute
Date:   Thu, 21 Sep 2023 09:43:52 -0500
Message-Id: <20230921144400.62380-12-dlechner@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921144400.62380-1-dlechner@baylibre.com>
References: <20230921144400.62380-1-dlechner@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This removes the config register sysfs attribute.

Writing to the config register directly can be dangerous and userspace
should not need to have to know the register layout. This register
can still be accessed though debugfs if needed.

We can add new attributes to set specific flags in the config register
in the future if needed (e.g. `enable_hysterisis` and
`phase_lock_range`).

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/staging/iio/resolver/ad2s1210.c | 47 -------------------------
 1 file changed, 47 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index b99928394e3f..223cc4702188 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -269,50 +269,6 @@ static ssize_t ad2s1210_store_fexcit(struct device *dev,
 	return ret < 0 ? ret : len;
 }
 
-static ssize_t ad2s1210_show_control(struct device *dev,
-				     struct device_attribute *attr,
-				     char *buf)
-{
-	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
-	unsigned int value;
-	int ret;
-
-	mutex_lock(&st->lock);
-	ret = regmap_read(st->regmap, AD2S1210_REG_CONTROL, &value);
-	mutex_unlock(&st->lock);
-	return ret < 0 ? ret : sprintf(buf, "0x%x\n", value);
-}
-
-static ssize_t ad2s1210_store_control(struct device *dev,
-				      struct device_attribute *attr,
-				      const char *buf, size_t len)
-{
-	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
-	unsigned char udata;
-	unsigned char data;
-	int ret;
-
-	ret = kstrtou8(buf, 16, &udata);
-	if (ret)
-		return -EINVAL;
-
-	mutex_lock(&st->lock);
-	data = udata & ~AD2S1210_ADDRESS_DATA;
-	ret = regmap_write(st->regmap, AD2S1210_REG_CONTROL, data);
-	if (ret < 0)
-		goto error_ret;
-
-	st->resolution =
-		ad2s1210_resolution_value[data & AD2S1210_SET_RES];
-	ad2s1210_set_resolution_pin(st);
-	ret = len;
-	st->hysteresis = !!(data & AD2S1210_ENABLE_HYSTERESIS);
-
-error_ret:
-	mutex_unlock(&st->lock);
-	return ret;
-}
-
 static ssize_t ad2s1210_show_resolution(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
@@ -519,8 +475,6 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
 
 static IIO_DEVICE_ATTR(fexcit, 0644,
 		       ad2s1210_show_fexcit,	ad2s1210_store_fexcit, 0);
-static IIO_DEVICE_ATTR(control, 0644,
-		       ad2s1210_show_control, ad2s1210_store_control, 0);
 static IIO_DEVICE_ATTR(bits, 0644,
 		       ad2s1210_show_resolution, ad2s1210_store_resolution, 0);
 static IIO_DEVICE_ATTR(fault, 0644,
@@ -566,7 +520,6 @@ static const struct iio_chan_spec ad2s1210_channels[] = {
 
 static struct attribute *ad2s1210_attributes[] = {
 	&iio_dev_attr_fexcit.dev_attr.attr,
-	&iio_dev_attr_control.dev_attr.attr,
 	&iio_dev_attr_bits.dev_attr.attr,
 	&iio_dev_attr_fault.dev_attr.attr,
 	&iio_dev_attr_los_thrd.dev_attr.attr,
-- 
2.34.1

