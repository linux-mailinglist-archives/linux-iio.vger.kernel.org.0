Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA966CD138
	for <lists+linux-iio@lfdr.de>; Wed, 29 Mar 2023 06:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjC2Efm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Mar 2023 00:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjC2Efk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Mar 2023 00:35:40 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33982705;
        Tue, 28 Mar 2023 21:35:38 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id e18so14287873wra.9;
        Tue, 28 Mar 2023 21:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680064537;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aO3iffgYttit+KiwJOjw8k7a3mJdpVLTgTWfTOHkxBc=;
        b=OSQIyj5UMb+VqBOWmCUC4uqftFYo1FvjIVo/t8efei/yAJbjsWtvx75HuGP8Y6c2N6
         lT6RSQL0gYpgFWNF+Jt3DSACrWm+H2A0YuS+xyY7rltgE3xWLUo7kjXbHyrFnugZ+fgg
         yYy2KZ+ydlEX9y2JkgYqcQ55BbtqkxNWvAhYkYwHw2heFNXRRKn9wCYpGxujdi6ACr6r
         sNkvQrcQMJhnyKupUHGu5qlnKdnsK5i/ZaOgWBFwi+ZvsPSwb32kwmXBRTkY5GZbL5LU
         OmNvYzy/cHC/gYjev/hpBZZfOgmLp/NB9Mj2udP6NA0y/NL2hpGjFl9RDjvYp7nzrMWr
         xZjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680064537;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aO3iffgYttit+KiwJOjw8k7a3mJdpVLTgTWfTOHkxBc=;
        b=cWMpKbbJN49/UesEcqgotTebRUGmAPwcusFQQnUHNYoYhXPzGVWcnCGdGPPFUDjcT4
         7uLfI5+jrWaitlxPYlEjjZ545Wa1tM3fHv4n3MFaw9PfHXJvIurbAphNl4jPVoEAdA8I
         p8iMkK4wFN6xu4x5rlOlVvs4rCsC4nQj2VLInDbr4SGJw1CZwPgpf16RC+hx3reEbzHc
         guTFlJCVT11/lcpCvq7uzlUHHXAn1Q1tmlCV9FPeQUy/ah04nNgAyz97feXMlC7d5NaK
         SOqsih+c4uhgA/FgG3+4ZwmyvlMnHc/ssh+JnO/hd9JT5XQK/vpzCT6bhRSdwyWHdma6
         Jd7g==
X-Gm-Message-State: AAQBX9cEBmOGHwVhePl8UMW9y1PBTNcEvkizBiftJZTagD+92yu0M72G
        y5XKk/il7azUK7XxJjV+UsQ=
X-Google-Smtp-Source: AKy350YlW5rNRwSVW5XehFVdz8qPl2Zx0q16OVLZlfYmLNqT30jqo+K3VAkc6JJ3Ks773XQXjx6g4A==
X-Received: by 2002:a5d:424a:0:b0:2d2:39d3:ce7c with SMTP id s10-20020a5d424a000000b002d239d3ce7cmr13870821wrr.70.1680064537161;
        Tue, 28 Mar 2023 21:35:37 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id z6-20020a056000110600b002c557f82e27sm28961465wrw.99.2023.03.28.21.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 21:35:36 -0700 (PDT)
Date:   Wed, 29 Mar 2023 07:35:32 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Eugen Hristev <eugen.hristev@collabora.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] iio: adc: at91-sama5d2_adc: fix an error code in
 at91_adc_allocate_trigger()
Message-ID: <5d728f9d-31d1-410d-a0b3-df6a63a2c8ba@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The at91_adc_allocate_trigger() function is supposed to return error
pointers.  Returning a NULL will cause an Oops.

Fixes: 5e1a1da0f8c9 ("iio: adc: at91-sama5d2_adc: add hw trigger and buffer support")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index b5d0c9ee284c..2a9fdc5b7edf 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -1409,7 +1409,7 @@ static struct iio_trigger *at91_adc_allocate_trigger(struct iio_dev *indio,
 	trig = devm_iio_trigger_alloc(&indio->dev, "%s-dev%d-%s", indio->name,
 				iio_device_id(indio), trigger_name);
 	if (!trig)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	trig->dev.parent = indio->dev.parent;
 	iio_trigger_set_drvdata(trig, indio);
-- 
2.39.1

