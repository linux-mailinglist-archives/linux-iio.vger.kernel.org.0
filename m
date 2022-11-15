Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB736294F1
	for <lists+linux-iio@lfdr.de>; Tue, 15 Nov 2022 10:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237940AbiKOJz2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Nov 2022 04:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbiKOJz0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Nov 2022 04:55:26 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E814055AA
        for <linux-iio@vger.kernel.org>; Tue, 15 Nov 2022 01:55:25 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id a29so23598376lfj.9
        for <linux-iio@vger.kernel.org>; Tue, 15 Nov 2022 01:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFlivsWSV6gGZ5OdvJQQ5Tn1kiYEgUjLp6Dm1aK7LCc=;
        b=eB62TXKbmv90jFuho+MH8RtJRleXtoV19wJ7lGofTJHZeRStYtOauYc9z0Yeset8ya
         Y6D0LaESdNpj4/uAX0bCSzGjpzNCbsoq9SE+agzNE33PM4yRUwBJgLsA6FjL6u38WcGm
         gW/l9cNOxVi9KzPWqCMhvurVobFyld3FNuY0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JFlivsWSV6gGZ5OdvJQQ5Tn1kiYEgUjLp6Dm1aK7LCc=;
        b=WDZ1bizhRp9B0D5WiOIbXF98OeQytG/2mr+Al/JldtVjMqIf4AxBhMHkgI+UolyhnU
         KdDuxm5iR3l/DGKza99j7w6EFT7trvA9toma2b4KATJP3q7w7dC4/OHZFxlr21RIyqvc
         wlsBFuOoTeU2Djlw1FAdvFbjPu0LwZrz9zfRbkrZsTPh5GSddlWe3I1jUZYbj8maMxyY
         pCXAYyDlXAeeBIskp6fIVWGLcChZVCcdQsaw6W7DtZPoRPojsnTY51NgY7F231i5yc/G
         X2EQQTjkGZuDGdrnHO8uYMuCBjGFBrmi9Vf1NQx/l5e+f+AfWWivBcJyRIVq/s7vOjAw
         0WUg==
X-Gm-Message-State: ANoB5pkeeDAzIfYe5tcJ5n7wcAppOQgKDGXrUGrJTtCuNZ5lrfLmpDlT
        G8fpUi0UEwgdJd739TSgdl/gBQ==
X-Google-Smtp-Source: AA0mqf5Y95D8tO/xmcrREUli7jPVrLMM/oPDXhwa8i/q0SQclJU1quPMKFYiHLjliXfnoxZtB3jWJw==
X-Received: by 2002:ac2:44d9:0:b0:4a6:fa2a:275b with SMTP id d25-20020ac244d9000000b004a6fa2a275bmr5384240lfm.87.1668506124311;
        Tue, 15 Nov 2022 01:55:24 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id q3-20020a19f203000000b00493014c3d7csm2148598lfh.309.2022.11.15.01.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 01:55:23 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] iio: addac: ad74413r: add support for reset-gpio
Date:   Tue, 15 Nov 2022 10:55:17 +0100
Message-Id: <20221115095517.1008632-4-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221115095517.1008632-1-linux@rasmusvillemoes.dk>
References: <20221111143921.742194-1-linux@rasmusvillemoes.dk>
 <20221115095517.1008632-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

We have a board where the reset pin of the ad74412 is connected to a
gpio, but also pulled low (i.e., asserted) by default. Hence to get
the chip out of reset, the driver needs to know about that gpio and
deassert the reset signal before attempting to communicate with the
chip.

When a reset-gpio is given in device tree, use that instead of the
software reset. According to the data sheet, the two methods are
functionally equivalent.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/iio/addac/ad74413r.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
index a157f2247a50..313c279173f2 100644
--- a/drivers/iio/addac/ad74413r.c
+++ b/drivers/iio/addac/ad74413r.c
@@ -71,6 +71,7 @@ struct ad74413r_state {
 	struct regmap			*regmap;
 	struct device			*dev;
 	struct iio_trigger		*trig;
+	struct gpio_desc		*reset_gpio;
 
 	size_t			adc_active_channels;
 	struct spi_message	adc_samples_msg;
@@ -393,6 +394,13 @@ static int ad74413r_reset(struct ad74413r_state *st)
 {
 	int ret;
 
+	if (st->reset_gpio) {
+		gpiod_set_value_cansleep(st->reset_gpio, 1);
+		fsleep(50);
+		gpiod_set_value_cansleep(st->reset_gpio, 0);
+		return 0;
+	}
+
 	ret = regmap_write(st->regmap, AD74413R_REG_CMD_KEY,
 			   AD74413R_CMD_KEY_RESET1);
 	if (ret)
@@ -1322,6 +1330,10 @@ static int ad74413r_probe(struct spi_device *spi)
 	if (IS_ERR(st->regmap))
 		return PTR_ERR(st->regmap);
 
+	st->reset_gpio = devm_gpiod_get_optional(st->dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(st->reset_gpio))
+		return PTR_ERR(st->reset_gpio);
+
 	st->refin_reg = devm_regulator_get(st->dev, "refin");
 	if (IS_ERR(st->refin_reg))
 		return dev_err_probe(st->dev, PTR_ERR(st->refin_reg),
-- 
2.37.2

