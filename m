Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0E57A9B35
	for <lists+linux-iio@lfdr.de>; Thu, 21 Sep 2023 20:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjIUSzu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Sep 2023 14:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjIUSzd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Sep 2023 14:55:33 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07931FF3
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 10:01:11 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b9338e4695so20089981fa.2
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 10:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695315617; x=1695920417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9YCZ78k5Zg5KKitr5PpHsZw/Rz0qYyLXQR2L135bIs=;
        b=GXljzaDh0Cwjt9tLDOds1R0q+YtAVWorCrhoDQRUuzDnF0g4VHhq3PGabDTDErfVp9
         n8dx8XTTj0safODkkFM4m048dmFmgH9g+yhKPTiYQqcL+RNslFoSmGsK08QVoaPKiIa8
         8gsE46olgX9lWI1t1oxBqtp5H++ZvTFgY2BqSVtMo9/pBf3CMq+KgSipNJIxmeTwotAU
         Mlp/TP1iLANJa6wpdtRYjyHzqR1cQhd5rQVaoeYb4VS4B/XRyOh041kGmsZMp5Uxqs8K
         dC+YcckBsm6XNlRvw3B30E9XO+2GjTy9p90NUMTr+Iz8FaxT7myV6hQ6/cpcur728WCh
         LpQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695315617; x=1695920417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x9YCZ78k5Zg5KKitr5PpHsZw/Rz0qYyLXQR2L135bIs=;
        b=Expsw4W0sYD3WGtc+Kfqf1YZgU+7f68FGo0d0BgHzmyH8Whzuw6/Kb4R0eInYnQYjy
         kyNT1GiyLyOM4gJ0b1WxCKwQNeM37x0nAauMgNNfjqem27UrCowH1g3dk5SZCKdOuIik
         6065JQ1NZ1oymE8PvmtpQxwCE1kmnQLk1LMSnwDgpE3B4EFg/IoTN9vTCpl3B/TAfz8H
         b+YbVTfnWmgE2ixcmDNLsHaFnhGS4+R/yIzdtsNu7buFtTAEwMCwslhPcf2VuiQcLAz2
         pcUBGNQXvjkQOeGMO+HdxtDT7RsvNcblPqFnEfxBMF1aIJTmGDJvp+By3piWcJH7xtXG
         XNDw==
X-Gm-Message-State: AOJu0YwqiBeW8ENhpFuHU8ieX7M2bduS1ZaIg973k3py1FyvwLB4OFib
        krlevqqJxR0fJWLo9iaPE4zToBOk8lWVHwFCiiCo1zPh
X-Google-Smtp-Source: AGHT+IFLOeeKjkZXzmrmyjj61SlCO4QtLumxRWkUp/uZ0wPGaqOzHFNXTE+bvD2TXSjNSCu16d/fHw==
X-Received: by 2002:adf:fe8e:0:b0:319:f9d6:a769 with SMTP id l14-20020adffe8e000000b00319f9d6a769mr5207822wrr.45.1695306155398;
        Thu, 21 Sep 2023 07:22:35 -0700 (PDT)
Received: from localhost.localdomain (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id n11-20020a5d4c4b000000b0031fbbe347ebsm1901426wrt.22.2023.09.21.07.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:22:35 -0700 (PDT)
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
Subject: [v2 04/19] staging: iio: resolver: ad2s1210: fix not restoring sample gpio in channel read
Date:   Thu, 21 Sep 2023 09:19:32 -0500
Message-Id: <20230921141947.57784-7-dlechner@baylibre.com>
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

In theory, this code path should not be reachable because of the
previous switch statement. But just in case we should make sure we
are restoring the SAMPLE gpio to its original state before returning
in addition to releasing the mutex lock.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/staging/iio/resolver/ad2s1210.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 84743e31261a..0bdd5a30d45d 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -510,8 +510,8 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
 		ret = IIO_VAL_INT;
 		break;
 	default:
-		mutex_unlock(&st->lock);
-		return -EINVAL;
+		ret = -EINVAL;
+		break;
 	}
 
 error_ret:
-- 
2.34.1

