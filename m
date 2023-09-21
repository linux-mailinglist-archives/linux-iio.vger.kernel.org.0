Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA7E7A9F42
	for <lists+linux-iio@lfdr.de>; Thu, 21 Sep 2023 22:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjIUUUT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Sep 2023 16:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbjIUUTn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Sep 2023 16:19:43 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A5F4065A
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 10:24:21 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31dd10c2b8bso1223636f8f.3
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 10:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695317060; x=1695921860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5XZRvh5FJ3F9RXkqi8NbBrwtIOGm1RUjmAFGYn0SWM=;
        b=RF/VbRCCSuidjQPkl1zidhwGpSVeN+RbHW0GSBtD6f1uH7lpYVVHXIC0mT39nCHNSH
         B80z6vu1RbBkbQtZ1pupQsymocDPdK3D7eZdbfF+BHpiZu2mUnHQn2aSbXcG/f0dQUZw
         78cWtuQiyUFfbDcYKHotdVGipvKXvwAoD8/ZqyFajoqmDvbUZsvUy1+WmblYDQQWJ1Q7
         q5a4D/zESzfh8sMOIy1BjSbbF2qgBNKFIOcMYgXxgML29mnlBiA5XsNWXTmj88aJmVIS
         EWgj3zfhOp8NXYvy7hWg3pcAYecxtVcTLx74S8r+yAc4rNiaAICe/PSPaBUcSI/KReF4
         zoYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317060; x=1695921860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y5XZRvh5FJ3F9RXkqi8NbBrwtIOGm1RUjmAFGYn0SWM=;
        b=S03bwRbu2l+LzsCK1nqEz4cfRFH2wlJNFCnfFIK+/DJNfteLcud+olNi47OjuSHu1i
         2aCcNNd+MYjVB1gdzRJFzI0Wqnpjg2eu8pp1ZWlwCdYTHtnUdjfpGwZ0JRvuDOKw+tI4
         YEhPK7FFsJ5C3zqgtxy5RG7LtmS5eqkqHVs1tMEabdkcbuK42x28LQBacBcKQhJMAfV2
         o8laHtNix+XCFRoEGiyzF0OCuw4I31rKXPnHs3jiEMDjVmjxN7bf6CJyexAK9a81ORUO
         egKvDrMn9oZ0qgVRhb6UmjFvx5sEhmmS1G/3H1EmSORVyFliIqQh6Ks+LD68LTh1qLZy
         VoEQ==
X-Gm-Message-State: AOJu0YwETOehvApAHGjJP3mjiq4mEhchPdmdRj+Y6h/iRfUtQi/gSQ4C
        NKmBiYkCpJAbbG68mSzRyqntxAqMoFI/NT3pJeszEGXs
X-Google-Smtp-Source: AGHT+IGCZngJGw2TLbVAmHBkA5Ct02TLdu6cufs/nlp002BSIPnQTHy4JPAWFAoql4McGwV/17mztQ==
X-Received: by 2002:a05:600c:2117:b0:3fe:e7b2:c97f with SMTP id u23-20020a05600c211700b003fee7b2c97fmr5472970wml.36.1695306168409;
        Thu, 21 Sep 2023 07:22:48 -0700 (PDT)
Received: from localhost.localdomain (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id n11-20020a5d4c4b000000b0031fbbe347ebsm1901426wrt.22.2023.09.21.07.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:22:48 -0700 (PDT)
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
Subject: [v2 18/19] staging: iio: resolver: ad2s1210: add phase_lock_range attributes
Date:   Thu, 21 Sep 2023 09:19:46 -0500
Message-Id: <20230921141947.57784-21-dlechner@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921141947.57784-1-dlechner@baylibre.com>
References: <20230921141947.57784-1-dlechner@baylibre.com>
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

This adds new phase_lock_range and phase_lock_range_available attributes
to the ad2s1210 resolver driver. These attributes allow the user to set
the phase lock range bit in the control register to modify the behavior
of the resolver to digital converter.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/staging/iio/resolver/ad2s1210.c | 58 +++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 71f0913b7e2e..f5b8b290e860 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -259,6 +259,60 @@ static ssize_t excitation_frequency_store(struct device *dev,
 	return ret;
 }
 
+static ssize_t phase_lock_range_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
+	int ret;
+
+	mutex_lock(&st->lock);
+	ret = regmap_test_bits(st->regmap, AD2S1210_REG_CONTROL,
+			       AD2S1210_PHASE_LOCK_RANGE_44);
+	if (ret < 0)
+		goto error_ret;
+
+	ret = sprintf(buf, "%d\n", ret ? 44 : 360);
+
+error_ret:
+	mutex_unlock(&st->lock);
+	return ret;
+}
+
+static ssize_t phase_lock_range_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t len)
+{
+	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
+	u16 udata;
+	int ret;
+
+	ret = kstrtou16(buf, 10, &udata);
+	if (ret < 0 || (udata != 44 && udata != 360))
+		return -EINVAL;
+
+	mutex_lock(&st->lock);
+
+	ret = regmap_update_bits(st->regmap, AD2S1210_REG_CONTROL,
+				 AD2S1210_PHASE_LOCK_RANGE_44,
+				 udata == 44 ? AD2S1210_PHASE_LOCK_RANGE_44 : 0);
+	if (ret < 0)
+		goto error_ret;
+
+	ret = len;
+
+error_ret:
+	mutex_unlock(&st->lock);
+	return ret;
+}
+
+static ssize_t phase_lock_range_available_show(struct device *dev,
+					       struct device_attribute *attr,
+					       char *buf)
+{
+	return sprintf(buf, "44 360\n");
+}
+
 /* read the fault register since last sample */
 static ssize_t ad2s1210_show_fault(struct device *dev,
 				   struct device_attribute *attr, char *buf)
@@ -506,6 +560,8 @@ static int ad2s1210_write_raw(struct iio_dev *indio_dev,
 }
 
 static IIO_DEVICE_ATTR_RW(excitation_frequency, 0);
+static IIO_DEVICE_ATTR_RW(phase_lock_range, 0);
+static IIO_DEVICE_ATTR_RO(phase_lock_range_available, 0);
 static IIO_DEVICE_ATTR(fault, 0644,
 		       ad2s1210_show_fault, ad2s1210_clear_fault, 0);
 
@@ -552,6 +608,8 @@ static const struct iio_chan_spec ad2s1210_channels[] = {
 
 static struct attribute *ad2s1210_attributes[] = {
 	&iio_dev_attr_excitation_frequency.dev_attr.attr,
+	&iio_dev_attr_phase_lock_range.dev_attr.attr,
+	&iio_dev_attr_phase_lock_range_available.dev_attr.attr,
 	&iio_dev_attr_fault.dev_attr.attr,
 	&iio_dev_attr_los_thrd.dev_attr.attr,
 	&iio_dev_attr_dos_ovr_thrd.dev_attr.attr,
-- 
2.34.1

