Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D3F7B389F
	for <lists+linux-iio@lfdr.de>; Fri, 29 Sep 2023 19:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbjI2RZx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 Sep 2023 13:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbjI2RZw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 Sep 2023 13:25:52 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F54ECC0
        for <linux-iio@vger.kernel.org>; Fri, 29 Sep 2023 10:25:50 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-57bb6b1f764so5820938eaf.2
        for <linux-iio@vger.kernel.org>; Fri, 29 Sep 2023 10:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696008349; x=1696613149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdyEj3wikWRAcNOtcWjzMUp/VXe76XnGqEiNgzZP6WM=;
        b=15XdpdXmk98e/fncfJ5R9qnkVj+AXNYi55cpGje5PD480tQ4ZEE7X6dJKT64YOanru
         Y6dww5ewy900Rlyq07qB0ubeXEyjVLANBV8BwVpQJhJ0T9aT3wXsrVLZ5IuvBiHeoAC+
         IWWp4BXfCBb/PSGN3jAc+34+fvjbQNSg3WtPlBMsIbrLqeYJKoySI20Uz9LH+laceNxc
         v69qPR0Feqa823+HV3KHtAF7+80lLTrkmNDlj6Q6H6+/C+tQewlt4UeehnSSlS3tbU+c
         hZF2jHMEsVulycIRsZvY1sWEkFFYr7RUqSzqMH7LqY2dCTD/n9NRne2FDpIJp8Ygd37a
         Y4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696008349; x=1696613149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sdyEj3wikWRAcNOtcWjzMUp/VXe76XnGqEiNgzZP6WM=;
        b=D6EG6mdXO5eh/IXO1tT3SBXC5Jis+xovTbF0d7kEp1z5NIZ9nTEmgeYWu5tvdpLhK8
         ky0uznbFxciZiynQuZPxB/t4EyUZsQ8qnX0ABIn43WpLLOhfmc2N5BiZeMkUmB8yGASg
         taeBT+3BKdm6PV0d4EBGSOucZrXetaskmWG6UfvTDAqujnuAOOKmJNK+2bjPuDFFTmqi
         pKLEc/OpCNSSQ5fB93aA1DaCdjHQn0ETNnPbYgqHuq45rS0FEcTEewtQqngQ3ziPpOEL
         JIKOldTHIgQit+tyFlzlk5rsqp4iFtMd7ElZocvVrvAas72Wmxp7a4QPn+VKhMEzYtBn
         ZQ2Q==
X-Gm-Message-State: AOJu0YztbXHLLXq5yugWWo/XtevRqhgAOjU1dz6jq98hu8L8NngNq1ir
        VGygOm0A70PXS5apOAIzGO4oCfHc6ec8mMcPZrErdA==
X-Google-Smtp-Source: AGHT+IEdsrADh4nu4YW1a/z3YRqrcmH2BqYxTLsP/81uaD4TcborXfHuhbM/eSAh86i/ThqzYbreAw==
X-Received: by 2002:a4a:9c4d:0:b0:571:1fad:ebdb with SMTP id c13-20020a4a9c4d000000b005711fadebdbmr4938892ook.3.1696008349364;
        Fri, 29 Sep 2023 10:25:49 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id f128-20020a4a5886000000b0057bb326cad4sm2272915oob.33.2023.09.29.10.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 10:25:48 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     David Lechner <david@lechnology.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: [PATCH v3 03/27] staging: iio: resolver: ad2s1210: remove call to spi_setup()
Date:   Fri, 29 Sep 2023 12:23:08 -0500
Message-ID: <20230929-ad2s1210-mainline-v3-3-fa4364281745@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
References: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: David Lechner <david@lechnology.com>

From: David Lechner <dlechner@baylibre.com>

This removes the call to spi_setup() in the ad2s1210 driver.

Setting MODE_3 was incorrect. It should be MODE_1 but we can let the
device tree select this and avoid the need to call spi_setup().

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v3 changes:
* This is a new patch split out from "staging: iio: resolver: ad2s1210:
 fix probe"

 drivers/staging/iio/resolver/ad2s1210.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 3f08b59f4e19..8fde08887f7f 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -683,8 +683,6 @@ static int ad2s1210_probe(struct spi_device *spi)
 		return ret;
 
 	st->fclkin = spi->max_speed_hz;
-	spi->mode = SPI_MODE_3;
-	spi_setup(spi);
 	ad2s1210_initial(st);
 
 	return 0;

-- 
2.42.0

