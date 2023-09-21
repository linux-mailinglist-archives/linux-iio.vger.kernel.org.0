Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDAD7A9F2D
	for <lists+linux-iio@lfdr.de>; Thu, 21 Sep 2023 22:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjIUUTE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Sep 2023 16:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbjIUUS0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Sep 2023 16:18:26 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBE75AAB3
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 10:29:20 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99bf3f59905so150640666b.3
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 10:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695317350; x=1695922150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gabiCx8aQ+iMVEJft2DL0LHbd3RWq71VIbUUi+w3JfM=;
        b=F1TliWLaUbu8KINHlkXT8KssGRcrjc5tsPHvDoOxWazAcgJyhutZjJu8G9I+wK+xkh
         J5oK0ezlTGa4jEeHmzQw+ipxcs9LcyGE2YbdahhvuL+OmuJ5ZnO38oZ9FGqwW/fe3MMy
         s4TBT8UutRlqVHjwBzERvj1YKhTW92p/ySbhSJjLUjkBh2EvKgmT4fIoC91gXzxHNyre
         oAkn1HP9QejCxWTqAFyivxKQTi021DRO+jUMhb8FWWOU14LE35idO+ZbBUxiiAGBt5aW
         Fxo/QnU2C9Te91bqNoKcseonsXi5aTaFtMe2eLyM8JZF9hJNefNYmq1Q9Z8QqnjpWGpi
         Qq0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317350; x=1695922150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gabiCx8aQ+iMVEJft2DL0LHbd3RWq71VIbUUi+w3JfM=;
        b=s0xB1/lzfTG9DeK49Y+E8dUhdna5TsAgFNT5RaOMJ5ikRf6MPCbbRVGaztvGZNyNDg
         hdgl697qutfiBDqkwhV5TbnEOH4rtTGbq2eNoXNkV1iLvQdW0gYPehiCE/UOb19YfVuv
         13d0Znrf8PNFrRX4zZi1GnqWMtv92E8Oxkv33BHuPniBvLfb7BYHIt1glUMO0D3jO4J9
         SAKjnivWds0E0wfVNrQZeXCZrPCq5aXr1B1R6/htza7dP1F2fJW25rBuidiUydDgV5Ff
         B4wW+4BNZsj6PDQBTXGahQEghIJOpOX+Vmfgv+3oas6+YDH0UIGj1GAg3GD8I2NbVk/c
         eHdw==
X-Gm-Message-State: AOJu0Ywh1uTK3XTN3NWtRCOf3jD6Czr/CGmEiPsmDwJlNthQf3XAdNZ4
        Ir60e7m48yIhCLclbzH8VZbQ0g9mNID43Jd2nhiZ0s/o
X-Google-Smtp-Source: AGHT+IGMZl/TatrnYES3LNioCY2DwT26zyGRXXVW2ZtQaBOVUD3PWf2yg31geciAz9PBdjwldIVOpA==
X-Received: by 2002:a05:600c:ad4:b0:3f9:b430:199b with SMTP id c20-20020a05600c0ad400b003f9b430199bmr5382331wmr.15.1695307457930;
        Thu, 21 Sep 2023 07:44:17 -0700 (PDT)
Received: from localhost.localdomain (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id s17-20020a1cf211000000b003fe2a40d287sm2125515wmc.1.2023.09.21.07.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:44:17 -0700 (PDT)
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
Subject: [PATCH v2 06/19] staging: iio: resolver: ad2s1210: always use 16-bit value for raw read
Date:   Thu, 21 Sep 2023 09:43:47 -0500
Message-Id: <20230921144400.62380-7-dlechner@baylibre.com>
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

This removes the special handling for resolutions lower than 16 bits.
This will allow us to use a fixed scale independent of the resolution.

Also, for the record, according to the datasheet, the logic for the
special handling based on hysteresis that was removed was incorrect.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/staging/iio/resolver/ad2s1210.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 9c7f76114360..985b8fecd65a 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -465,10 +465,7 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
 			     long m)
 {
 	struct ad2s1210_state *st = iio_priv(indio_dev);
-	u16 negative;
 	int ret = 0;
-	u16 pos;
-	s16 vel;
 
 	mutex_lock(&st->lock);
 	gpiod_set_value(st->gpios[AD2S1210_SAMPLE], 0);
@@ -494,20 +491,11 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
 
 	switch (chan->type) {
 	case IIO_ANGL:
-		pos = be16_to_cpup((__be16 *)st->rx);
-		if (st->hysteresis)
-			pos >>= 16 - st->resolution;
-		*val = pos;
+		*val = be16_to_cpup((__be16 *)st->rx);
 		ret = IIO_VAL_INT;
 		break;
 	case IIO_ANGL_VEL:
-		vel = be16_to_cpup((__be16 *)st->rx);
-		vel >>= 16 - st->resolution;
-		if (vel & 0x8000) {
-			negative = (0xffff >> st->resolution) << st->resolution;
-			vel |= negative;
-		}
-		*val = vel;
+		*val = (s16)be16_to_cpup((__be16 *)st->rx);
 		ret = IIO_VAL_INT;
 		break;
 	default:
-- 
2.34.1

