Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFBAE6F5698
	for <lists+linux-iio@lfdr.de>; Wed,  3 May 2023 12:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjECKux (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 May 2023 06:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjECKuw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 May 2023 06:50:52 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F26612F
        for <linux-iio@vger.kernel.org>; Wed,  3 May 2023 03:50:49 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f139de8cefso2046089e87.0
        for <linux-iio@vger.kernel.org>; Wed, 03 May 2023 03:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1683111047; x=1685703047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zgj+aUgoJdUUawwjQ6SgSQXM3EvgvrnXKII1glX28tA=;
        b=XnS7NVz8zttO1mmcapsD4f8wA0e8bEV1z3wez08PCINAL3k7C7YTNcSfTyrILcy74r
         Di5jMQfCzg01pGf5tURveH4iEtrBZYukqXzl6fky++6GLhQyYDIPJKX+FXaGzZqQKvCD
         BHFrHpukkujhe/jjDm+9SjwFj0B4ralYu78Ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683111047; x=1685703047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zgj+aUgoJdUUawwjQ6SgSQXM3EvgvrnXKII1glX28tA=;
        b=jLFDYT9tcxCWoPQpd7x0WkJ0aRNI1j/tV3dP8S9NeZEoeYBANwyVwrOHgP1Bx7pk8J
         +dijr27xvyykUQzxnngfrEL8LbYP/b4WqpUGKj3JJPd/rwU+JKsWCG1W63Hl3W1HdDji
         GtDgb8w8c1AI7Iz9xjI6FWAGWV7ZPlxPLnGHx1/F9NVuGQYZqGMur5x5OzY+V7h1TuLA
         KoZLqSGbOB78aS7hDhsjtdizYehDqiELrHOCsZ0kVxHyXMHP2jrhW38gaR+EW5f5LJ4W
         LQ5wKKs5HV9a7xp/qt+XL5DBYuLm8rTWhv/W/i64fLvfKpY5/TFahR2mt6sPUcKXcsCk
         P0KA==
X-Gm-Message-State: AC+VfDyxbTyOigL7slsbkGQ9vseMrNlJJQh11VjCQwvqPgVfoHPRiUPi
        Ja03Uh74nAyr6dQ3uXt4lu67cg==
X-Google-Smtp-Source: ACHHUZ7KGBBKidxkonefCJDBhObv1u5vOSFiRrhYpWG4uzfVOm+Br56TJUXrQbSRcCCtDVdvY7iG+w==
X-Received: by 2002:ac2:529a:0:b0:4ef:ebbb:2cf5 with SMTP id q26-20020ac2529a000000b004efebbb2cf5mr467562lfm.17.1683111047318;
        Wed, 03 May 2023 03:50:47 -0700 (PDT)
Received: from prevas-ravi.k200.local ([87.54.42.112])
        by smtp.gmail.com with ESMTPSA id j1-20020a19f501000000b004eff0bcb276sm4702776lfb.7.2023.05.03.03.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 03:50:46 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: addac: ad74413: don't set DIN_SINK for functions other than digital input
Date:   Wed,  3 May 2023 12:50:41 +0200
Message-Id: <20230503105042.453755-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Apparently, despite the name Digital Input Configuration Register, the
settings in the DIN_CONFIGx registers also affect other channel
functions. In particular, setting a non-zero value in the DIN_SINK
field breaks the resistance measurement function.

Now, one can of course argue that specifying a drive-strength-microamp
property along with a adi,ch-func which is not one of the digital
input functions is a bug in the device tree. However, we have a rather
complicated setup with instances of ad74412r on external hardware
modules, and have set a default drive-strength-microamp in our DT
fragments describing those, merely modifying the adi,ch-func settings
to reflect however the modules have been wired up. And restricting
this setting to just being done for digital input doesn't make the
driver any more complex.

Fixes: 504eb485589d1 (iio: ad74413r: wire up support for drive-strength-microamp property)
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/iio/addac/ad74413r.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
index e3366cf5eb31..6b0e8218f150 100644
--- a/drivers/iio/addac/ad74413r.c
+++ b/drivers/iio/addac/ad74413r.c
@@ -1317,13 +1317,14 @@ static int ad74413r_setup_gpios(struct ad74413r_state *st)
 		}
 
 		if (config->func == CH_FUNC_DIGITAL_INPUT_LOGIC ||
-		    config->func == CH_FUNC_DIGITAL_INPUT_LOOP_POWER)
+		    config->func == CH_FUNC_DIGITAL_INPUT_LOOP_POWER) {
 			st->comp_gpio_offsets[comp_gpio_i++] = i;
 
-		strength = config->drive_strength;
-		ret = ad74413r_set_comp_drive_strength(st, i, strength);
-		if (ret)
-			return ret;
+			strength = config->drive_strength;
+			ret = ad74413r_set_comp_drive_strength(st, i, strength);
+			if (ret)
+				return ret;
+		}
 
 		ret = ad74413r_set_gpo_config(st, i, gpo_config);
 		if (ret)
-- 
2.37.2

