Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953407A9BE6
	for <lists+linux-iio@lfdr.de>; Thu, 21 Sep 2023 21:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjIUTFL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Sep 2023 15:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjIUTEM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Sep 2023 15:04:12 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7596D84F26
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 10:53:54 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-530ea522f5eso1407927a12.3
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 10:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695318820; x=1695923620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFHoFBATjyYAR3S3Kihiw7DM+oB505Wu13vuO5lq7BQ=;
        b=OggB7gl6/72NL3i52bBilcJ1EIGb43pTabE8avDOG+gePNmkYyx46/F3jZ+I7Ol1DN
         N6KyAzkMOdPC60A6CsNDorkp1UdwN3AXoCuDHT8bqgxIp4pSfl06YINltAxe4dkPIVY7
         59Wv+4AHp5x0ioVJBXLCl50Jw33MeVCuqH/mH3fA/wTPYlDnnMnqivOsrO7qvDXqpJ3u
         BDuKRot0Y+q1k0MC0r6Ivw+kxnYJ6o5Y1nMU86JR/zRsc95Fp1yoO5dvoEWgjUghmLKI
         lAHVpqxEumv5MBSuJTdebPXTj21d+WJim+IWRRuE+di9En1gRpb7+p0JJJ+AXoOPGg13
         a+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695318820; x=1695923620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FFHoFBATjyYAR3S3Kihiw7DM+oB505Wu13vuO5lq7BQ=;
        b=j3COztwPIUFC57m622Y7UkXi07gLSNM39zz/TvLydNdH+nxT9zK3ydIABZA6oFXExK
         YIMBtxvS0Zkd52Ss5YO9f4ZC4fFMpsPj4rjc9v/NCXeHd2VvfdOsIIepFDvKFzyQvJQU
         zhwQQ0fXEnLBKuGN1GemW16SCnprqQcSKDCkowTmTsMtEuV2i5P4Uga4w8XJnk/DsBOL
         vKPI6zRGKZFNZYn+RiaTKRFuo6bbBXXfk21ZEb1B37Vx+MDo3sZtYnJjV8enLv1egX/0
         vMXlQM5vGE8VS2CLsa1YZGB1BVdj11zL04OwdmhOfU5MaFNKAGQkEM0DQ0SwRpAAM1I+
         DAsw==
X-Gm-Message-State: AOJu0YxU/O4komZ4E+n3l7P5PurouN/CscuNNG2WmCP1vIkPpXtAAOHb
        n0j5McQWXovbhfbijHjztDpjOljophwFqFbujxGb5zX2
X-Google-Smtp-Source: AGHT+IFyRSQ9sVI6svVzHUR3normBxbHxw1ADHwq9tPPMiHuaAAm+CM2HzCwtdqMZnvyJVaEdPWyUw==
X-Received: by 2002:a7b:ce15:0:b0:401:daf2:273b with SMTP id m21-20020a7bce15000000b00401daf2273bmr5282558wmc.12.1695307465779;
        Thu, 21 Sep 2023 07:44:25 -0700 (PDT)
Received: from localhost.localdomain (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id s17-20020a1cf211000000b003fe2a40d287sm2125515wmc.1.2023.09.21.07.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:44:25 -0700 (PDT)
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
Subject: [PATCH v2 15/19] staging: iio: resolver: ad2s1210: read excitation frequency from control register
Date:   Thu, 21 Sep 2023 09:43:56 -0500
Message-Id: <20230921144400.62380-16-dlechner@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921144400.62380-1-dlechner@baylibre.com>
References: <20230921144400.62380-1-dlechner@baylibre.com>
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

