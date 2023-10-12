Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47297C7248
	for <lists+linux-iio@lfdr.de>; Thu, 12 Oct 2023 18:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379476AbjJLQSo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Oct 2023 12:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235758AbjJLQSl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Oct 2023 12:18:41 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AABDC
        for <linux-iio@vger.kernel.org>; Thu, 12 Oct 2023 09:18:39 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1e9c9d181d6so233728fac.0
        for <linux-iio@vger.kernel.org>; Thu, 12 Oct 2023 09:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1697127518; x=1697732318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3NXXzp/tCwIOo0tlTvlUJI63ZzTPU3E19sORPsGfkkY=;
        b=T/vvgmdXuKLvNcJuBW9qvN7dVqxnT96NdbG8ZB+fVZCgeo1llGm5ph8Yuv8C3CEmNS
         Cvv17NYleVxz2nDuJy+T6CwpJjVe8R64QgYIxLhP48zjsY5udA8Ev0FO/Pq1pT9/Quqs
         Oh6quQqLHZvexuWWLFBkAB5bK2m8EA+Xzw3yf1182snU2sSOJhufQh1GrQVac0iEsJ+o
         p46+4Y+fs7lZz4m5CBtRGKqVO5MbOHc2AO9tPWek6OkhMwnGFTC9e40z0vtqzZ3hS2Dm
         aqKlz1SdFmhjf6W1Fvy5U/Vr0wCQM6xKUVJs+nmrt6BgI6Jxg7GwLnaAgLDJCMgw94Zf
         ysEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697127518; x=1697732318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3NXXzp/tCwIOo0tlTvlUJI63ZzTPU3E19sORPsGfkkY=;
        b=F4NKEcLOluPwOHYqhKgudjlqSzdZ1vLpZc7KDpdOAGqcJTl22ldUltVQvmSO/CY8Ue
         HmS4FoeOVqwJXBKoXOu86dEM8ama809GnETe+I6nJpODwlBmDkZsFjeoN0dcVED3Q0Yp
         2+ULs/RSsQ/nm8YqTgZ7hZ9Mq09kJ53d8ZXzjlxQ0klLEFVsKhXGYYZitQPucil6317j
         yB5BoMu8P0YVkBgzE5Rr/WE2wnL57BiK+NK5j1CiRfi5JEax3pJU5IFlhP31pvipDcTM
         Y/FVQZFbXyzqSlCAfsn/QJjcCoSq/Oyak2jGIbuiUsglw76IYdKUdnq3fhL8Yxwu4Ts1
         E2XA==
X-Gm-Message-State: AOJu0Yxufet0M1+Vuax04gWaoCBRhMYAPll8a84BR35Clf4q+AP6JDws
        daXMM3K8kVbFSKZN1VE3pgV4crXhD+LPl+Cg4lJPbw==
X-Google-Smtp-Source: AGHT+IFH7kAjVghpq9S9SSJMUJIGrd94WuyWSQANISTNm1stmttQZdEQ58ccK13hWWB2JwgtitrnPw==
X-Received: by 2002:a05:6870:d795:b0:1b0:649f:e68a with SMTP id bd21-20020a056870d79500b001b0649fe68amr27704676oab.25.1697127518608;
        Thu, 12 Oct 2023 09:18:38 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id ob16-20020a056871761000b001dd63f65870sm414529oac.28.2023.10.12.09.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 09:18:38 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org
Cc:     David Lechner <dlechner@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iio: resolver: ad2s1210: remove of_match_ptr()
Date:   Thu, 12 Oct 2023 11:18:13 -0500
Message-ID: <20231012-ad2s1210-mainline-v1-2-b2ee31c0e9dd@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231012-ad2s1210-mainline-v1-0-b2ee31c0e9dd@baylibre.com>
References: <20231012-ad2s1210-mainline-v1-0-b2ee31c0e9dd@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

To be consistent with the rest of iio, remove of_match_ptr(). It does
not do anything useful here.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/resolver/ad2s1210.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/resolver/ad2s1210.c b/drivers/iio/resolver/ad2s1210.c
index 00562bc542bb..1bd1b950e7cc 100644
--- a/drivers/iio/resolver/ad2s1210.c
+++ b/drivers/iio/resolver/ad2s1210.c
@@ -54,7 +54,6 @@
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
-#include <linux/of.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
@@ -1508,7 +1507,7 @@ MODULE_DEVICE_TABLE(spi, ad2s1210_id);
 static struct spi_driver ad2s1210_driver = {
 	.driver = {
 		.name = "ad2s1210",
-		.of_match_table = of_match_ptr(ad2s1210_of_match),
+		.of_match_table = ad2s1210_of_match,
 	},
 	.probe = ad2s1210_probe,
 	.id_table = ad2s1210_id,

-- 
2.42.0

