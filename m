Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088EE7A98C3
	for <lists+linux-iio@lfdr.de>; Thu, 21 Sep 2023 19:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjIURwf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Sep 2023 13:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjIURwY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Sep 2023 13:52:24 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B248101AE
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 10:30:04 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-52fe27898e9so1398869a12.0
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 10:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695317397; x=1695922197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDg1sZsypbtmVZl9501Jvjfjp7cqgNO2wWu9eDz+bAo=;
        b=l/qGSxD7COvPQGWx5sqvgPWpKgAare2hW7ZQNGGMchEz2FewsGOMMzKyNTCqSq7NVr
         QPVWn9umasrRZujqBasThk40BQjcOK0h16erZK6Lp6JXnIOIf4qYoIz5CMH4PgTmd5Sd
         WmoSQDS9wNC2Sq6+0cdHTeo59cMbJaduDHgzOr5TFRlN0ALZDlp6XhFgRLfu9w2hYeS3
         9nE6XqYRkplA5fz3aX+c3qJmpQWbUx1iR7hrHjSkOS+zeXzlcACjdfODBBHODBEDBqPB
         jFZ0DiVop1/1szGXatBnOgnI26JER9cNfrjU8BaQwaL7cJI8RUTC/jTGqY61E+xK+Hby
         vqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317397; x=1695922197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NDg1sZsypbtmVZl9501Jvjfjp7cqgNO2wWu9eDz+bAo=;
        b=vLVzLHIGY81oGdU17NkogEVThAmeRNHMAUci94z0wY+FOOPmJorgmW4x9yf13/VdjG
         OqTNf1qmwCSPmCjCVLW7V4sTypEcNo+oV2OzuG7xl86nvDTv1+I4YP7fIAOxn5ItlUse
         jdJe46UcAisYxlag7q/o85eiH60lNMgqVBc04xpW1mh3okFUt+7aAxnrJncIJl5xJmtt
         DBPfxnSrr+nI4HPabGml78MP1q5GteoFivpvVqzOH49De1PskX4JChNCq7t3KeP+4wCm
         Dc0F9+sNp8/EJuOyAGSJkbaoUQxFoqR150MH+/kQHnryOsFdJa3GgsTlLDc6IMGqeubn
         ydoQ==
X-Gm-Message-State: AOJu0YxUz2vqG9669DFURC6tBfHlH4p6Lyfp999qHEvxLrM+QKW30f5U
        tJnlxVDrg7ZHZs9XtX3q5tswLU3Yqp0Moh5piaVs20T4
X-Google-Smtp-Source: AGHT+IHTDD4zYuu6lV9x3Jl/iVplDBdwIifaK9LFet9fL2i2jXEx9floEa+zeO5CPOjwgUdMkMbH9g==
X-Received: by 2002:a05:600c:2245:b0:402:906:1e87 with SMTP id a5-20020a05600c224500b0040209061e87mr5026780wmm.31.1695307461363;
        Thu, 21 Sep 2023 07:44:21 -0700 (PDT)
Received: from localhost.localdomain (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id s17-20020a1cf211000000b003fe2a40d287sm2125515wmc.1.2023.09.21.07.44.20
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
Subject: [PATCH v2 10/19] staging: iio: resolver: ad2s1210: add debugfs reg access
Date:   Thu, 21 Sep 2023 09:43:51 -0500
Message-Id: <20230921144400.62380-11-dlechner@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921144400.62380-1-dlechner@baylibre.com>
References: <20230921144400.62380-1-dlechner@baylibre.com>
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

