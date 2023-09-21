Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6240C7A9F6A
	for <lists+linux-iio@lfdr.de>; Thu, 21 Sep 2023 22:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbjIUUV5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Sep 2023 16:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjIUUVe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Sep 2023 16:21:34 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE462487F
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 10:11:33 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-503056c8195so2009378e87.1
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 10:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695316292; x=1695921092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDg1sZsypbtmVZl9501Jvjfjp7cqgNO2wWu9eDz+bAo=;
        b=JZUaSyEDg5pbWYztWULRutAyVXeMfMa7eAV0w/GWtoX5Vkcdl+u8SfZSbydxjLrpPX
         8Vxaw0AVLZ9LQ24VJUSKk7lchUHShgltP2Sq6oHenfQn3s70QKVXYFi/HHPUyCQKQsjG
         UzURbL5B6fAr8OLuwBhFYVdsnp8Vc2YesqEn2gsfPQJDYkN5AjlIUkK5/vaRhrud6DPy
         B4tUhPvHZuuHCaQCWOsDiZZ6Zq+B+GlAGdbYjyBYY9dkAcC+9SzP8ST/Gx4qpz5wX+3b
         OJ4Dvn9+7UXa0VxPojfRoFhV+7G8LhEOenjL2ItjUmv/IhcQ3aC1ueVJUt1ANiIykvI4
         oTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316292; x=1695921092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NDg1sZsypbtmVZl9501Jvjfjp7cqgNO2wWu9eDz+bAo=;
        b=fUpDpBBPSCB6xcgXPz1vbrzNkrxDu4S1S8eJZJ5uWt1WRjUjFaCnO1t+cS0WTHo4NE
         Kf4x5R+PAlJuELpeKGxM0HbHX8zMYTobiSBmtQ3CIZX8LxLOKwTSvLEsvNbuSOycKb/b
         PuXH/PLDiNekDy6IdjpJAeLHW7ldAeS6f6JBw4lxJOazb2K4X6VGkuL8ZEQhR4e8Iylc
         KX99pO4yt4k9L22up0+oc+zo3w3MUhCll7QGIbgopDKvzkbyItrxcKov92mBD18gx1D5
         bAZRvDvG84iAzykb0+bhvzRS+lFhU+ORZJUhoK2fGDjv6KKlOFay6aHZL4f2yU6wxPEg
         1nuQ==
X-Gm-Message-State: AOJu0YyBhnvfuw5N4cJOOerU6+wVEWjcJ4ikKlejLXaAOBvJn3VpN2/V
        DwI26Q5yBfsQ+GpYnn6/35YOG4tuSiVDmx2Krhmvkggz
X-Google-Smtp-Source: AGHT+IGgYCYV4RIyluC952QS15xlxGsYiHuw3JJvkpeLNvHhq4UFPDC/C6dReCQO1m30NxXKsPt5kw==
X-Received: by 2002:a5d:4c85:0:b0:31f:a259:733 with SMTP id z5-20020a5d4c85000000b0031fa2590733mr5275304wrs.20.1695306161138;
        Thu, 21 Sep 2023 07:22:41 -0700 (PDT)
Received: from localhost.localdomain (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id n11-20020a5d4c4b000000b0031fbbe347ebsm1901426wrt.22.2023.09.21.07.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:22:40 -0700 (PDT)
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
Subject: [v2 10/19] staging: iio: resolver: ad2s1210: add debugfs reg access
Date:   Thu, 21 Sep 2023 09:19:38 -0500
Message-Id: <20230921141947.57784-13-dlechner@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921141947.57784-1-dlechner@baylibre.com>
References: <20230921141947.57784-1-dlechner@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This add an implementation of debugfs_reg_access for the AD2S1210
driver.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/staging/iio/resolver/ad2s1210.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 3c81ee61b897..b99928394e3f 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -606,9 +606,29 @@ static int ad2s1210_initial(struct ad2s1210_state *st)
 	return ret;
 }
 
+static int ad2s1210_debugfs_reg_access(struct iio_dev *indio_dev,
+				       unsigned int reg, unsigned int writeval,
+				       unsigned int *readval)
+{
+	struct ad2s1210_state *st = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&st->lock);
+
+	if (readval)
+		ret = regmap_read(st->regmap, reg, readval);
+	else
+		ret = regmap_write(st->regmap, reg, writeval);
+
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
 static const struct iio_info ad2s1210_info = {
 	.read_raw = ad2s1210_read_raw,
 	.attrs = &ad2s1210_attribute_group,
+	.debugfs_reg_access = &ad2s1210_debugfs_reg_access,
 };
 
 static int ad2s1210_setup_clocks(struct ad2s1210_state *st)
-- 
2.34.1

