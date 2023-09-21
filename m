Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664047A9E41
	for <lists+linux-iio@lfdr.de>; Thu, 21 Sep 2023 21:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjIUT7b (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Sep 2023 15:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjIUT7I (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Sep 2023 15:59:08 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDA8AD0D
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 10:22:48 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50317080342so2191688e87.2
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 10:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695316966; x=1695921766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gabiCx8aQ+iMVEJft2DL0LHbd3RWq71VIbUUi+w3JfM=;
        b=aVJ/pYX1o7/cDrARBoYLU7zi7SblPXI94RwGldpCWNnBIUvkL/H4H00NuprUhBp965
         zbZtJ9GqYZxoqBCzBD61dzjb9LU/nYXj8Co6nMdRAye/UoizziqwoZD+gvgyVgNUImcA
         AYG8o0RqVO36ts9CtvXj+nxKvMfAXrvACOe1W5xtCr8T7ODVw1V6VmAbocurL7WBn5R7
         putHNFHkd9bhSEC2foLsx5UsCL61NwXZ2DMTnmWXH6+X2khZc/e6FiccqrjGfkOGCROx
         z3cuwBXZaEeUsVlgdSHmoHBZjHcakbhpNZd0skXC2UgLQO0LLU9rvlkvswypoYZx90k8
         Y3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316966; x=1695921766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gabiCx8aQ+iMVEJft2DL0LHbd3RWq71VIbUUi+w3JfM=;
        b=SUL6Cflal4Y/z8dbBm9ZfZVVwhULA+ijg5waXD6paqB3HnDG63dCYkFLoJxfFZOPJg
         /E1y5cYIaveavcQvpyOHein2Gf1Q+UA2DSdQrMKEv7fHbYa5K6FJJOB6WjvtZQ4JWcsJ
         pKYqi4Pg5nZ0oUH9E+llFJkwgpSg022C9+6zSATylg2SVGz2ULObsgAf2FbIbYMEQq+w
         uhJECLgYd8WfaBHLJH3ZCX9L3oNG/YkR9Ox1BGLF7YiaNuvUlEYTYaL5NEG9rDFFG2CL
         5q2Yt+G3HcYHA1QPIwoo6ZnCFXX9lyXOPZw1LVsWOgEFh7V+6pBO1/kp31Rfl3TRhe84
         M6Ag==
X-Gm-Message-State: AOJu0Ywtx6LaOJhW23cJHvE6p5QJ94/G9QpWgQ0UwSrc6yU9sjqmoHe8
        x+iUPQzE1Xrqq4JiSIGVrg0dieVEdWIawFyRvACjW7oq
X-Google-Smtp-Source: AGHT+IE4sDvMSw/UkfMczfXLxgbpckMACuzljnUTY5SM6KE9BEVvGBveVsOv+3vfUogJ5wktpvrmbA==
X-Received: by 2002:a5d:6e54:0:b0:31a:e8e6:8a96 with SMTP id j20-20020a5d6e54000000b0031ae8e68a96mr5153996wrz.67.1695306157156;
        Thu, 21 Sep 2023 07:22:37 -0700 (PDT)
Received: from localhost.localdomain (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id n11-20020a5d4c4b000000b0031fbbe347ebsm1901426wrt.22.2023.09.21.07.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:22:36 -0700 (PDT)
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
Subject: [v2 06/19] staging: iio: resolver: ad2s1210: always use 16-bit value for raw read
Date:   Thu, 21 Sep 2023 09:19:34 -0500
Message-Id: <20230921141947.57784-9-dlechner@baylibre.com>
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

