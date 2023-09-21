Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423427AA0BB
	for <lists+linux-iio@lfdr.de>; Thu, 21 Sep 2023 22:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbjIUUri (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Sep 2023 16:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbjIUUrL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Sep 2023 16:47:11 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D796A8F49C
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 10:45:36 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso1231198f8f.0
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 10:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695318335; x=1695923135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9YCZ78k5Zg5KKitr5PpHsZw/Rz0qYyLXQR2L135bIs=;
        b=eUUsSlFjHvKAE7f0sTeaSSViS1IXPGeAmrhBAPuakrxWdftwbvtRnIvoS0DxqIuMoK
         /8U5xVmMlkJ8EQDGJbQClMCx/X4eNL99g0RuBsPgJ+/5u7ctiddoGw/9oSXpf10EFFd9
         ZW7nKQuYU/dRFk0JkaRNEROzGH4bkCK4rSXRJfy3trJj4OaEqUsz1McH8Ka5rIGPqIhJ
         8slxjqVsvC3CyssyEAYCKZzAOocZhReInXWM2biD6rofNbDl5XfCRr7D6Ab0YEzmGa9V
         qiV/CjLR4IZQS2gXSKc/NNP5ZrhZ7cN4Kj3g2rmuKvVo8a083E8n2xMqqKATA3dylNSE
         Vfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695318335; x=1695923135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x9YCZ78k5Zg5KKitr5PpHsZw/Rz0qYyLXQR2L135bIs=;
        b=JNM9j4J1GD61fFgQ+uT00r3OwEJxOX8+07umU4kwA3ki0+FcrHY5CiniOWKEefpYbi
         hlEdU2Iiawah5aZXA4x718T8bgi0269ZOpMje9O/n8G6kd9HmLZ7pgZPhGjqeeLjFaSf
         +Zc7uzYETV9a9hf3Zq1lJDYZiUKAdwDbBBdFXTVZBI1c6GRuLYxXoWvoeHEA2qgqYF1a
         +PN0ChLOOiTVdcpWiqNIL05PU76NmWe5aBzH/ymcMkGZP7F9XF2Jn4ItpTR8njBx5s7b
         xOjSvb3QGEomcduYRh8D2/t5jS114XDsr0J6AfHYmsCUlRWtXGMavcXFWn4kyRnmS0od
         N3Vw==
X-Gm-Message-State: AOJu0YzNe4wJ0PYOOXAhiugOjFxwZiP7PKlnyGB35Q1fC0pS90ob9y6y
        sueXyImucz85m4gWOVyQrpw/98OQ+k9sy4MD0SFB3bun
X-Google-Smtp-Source: AGHT+IEpFrDSoMcGwkX92bs0KANrkQRic6vkb2g8vJmtLIHbFG/3F3REKUYxWKXB+6gaHaSm9uvZwA==
X-Received: by 2002:a05:600c:ce:b0:401:d2cb:e6f2 with SMTP id u14-20020a05600c00ce00b00401d2cbe6f2mr5107214wmm.32.1695307456325;
        Thu, 21 Sep 2023 07:44:16 -0700 (PDT)
Received: from localhost.localdomain (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id s17-20020a1cf211000000b003fe2a40d287sm2125515wmc.1.2023.09.21.07.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:44:16 -0700 (PDT)
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
Subject: [PATCH v2 04/19] staging: iio: resolver: ad2s1210: fix not restoring sample gpio in channel read
Date:   Thu, 21 Sep 2023 09:43:45 -0500
Message-Id: <20230921144400.62380-5-dlechner@baylibre.com>
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

