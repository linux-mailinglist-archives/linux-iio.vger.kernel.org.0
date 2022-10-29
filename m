Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEB36121D5
	for <lists+linux-iio@lfdr.de>; Sat, 29 Oct 2022 11:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiJ2JaP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Oct 2022 05:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiJ2JaM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 Oct 2022 05:30:12 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB6B5B065;
        Sat, 29 Oct 2022 02:30:11 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id k8so9451790wrh.1;
        Sat, 29 Oct 2022 02:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9aX0cSt9m4+Cq/f1RJLWS1kmL6VQUel6+uX1gQMvMUk=;
        b=dmr+VZFxGybIUj2z2AntKwOIXFPJF+0kLb37xpb2ClxzIf4VbSzZd3yCrCD95ZHuhu
         LXhPOifD/LsBtJ3gWWVulxskurW4AljDMjSWxHICi2JVl651461JrsabhkHJu0uodJmY
         f8OggObxxrAh5zLGWTbaNfex1M0QHk1bDVJK/Kjg+Ehz2c5x4qPNhC1eUMpSIAnAEyz5
         VHReQ7W24HxNblIkhGVlds4rylc/zU/kB0XqyHt0s/35Ov4FK1VXMzM4TUQ7du6lR0oW
         cQfG/vvZJesqYYWlbRGZZIFqVsWn3/6nQ3epLH+9gTjcW8frNF21Oi2tjEtaSswL2UkI
         ebkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9aX0cSt9m4+Cq/f1RJLWS1kmL6VQUel6+uX1gQMvMUk=;
        b=aKMUHxTdLpNuQURmnEUV5ug/5ze44qKtzUX0S6wceiUVTGZaZ4oCe7I7kDKJSfWSou
         51hZVzzzo/xSCuoMBaCaNWwtfhCBpHTjCHr6PbYFWs71bueltZJGr9jAKFrQq6sfeFx3
         ix9q9CfJdy6FiSsF5WeF2V/DtI+IcUaChjb9v0aRyhR1OAnylo/96lvi9TzRdDwD1h3H
         pinasmCTOw+Irj2CMWQTMX2SgQYItH2XvdpCnF4rhCxUZ2c/90qUrziTIMPmT1YhaDAs
         tIkbL6Cqh7E4wbPj/Nnjxo37UddMMsiDCLklmpmL585e7cWFVI+JpmYo7CR33yy6531B
         XWQA==
X-Gm-Message-State: ACrzQf35Pvl0AAkmBDapZn25aw49jYbVqgCxuVbReiiU61jw8GONEwBp
        iS8Yg45MDqrW0F9ZUkY6xQg=
X-Google-Smtp-Source: AMsMyM6B1H6rKpGvxcPczA+Ys/6D3oEasxUh7PBv4MEZ0Mo40/Bvl5vbvzL680lqsl4uP/I3q68Q2w==
X-Received: by 2002:a5d:47ce:0:b0:236:76de:726c with SMTP id o14-20020a5d47ce000000b0023676de726cmr1978167wrc.510.1667035809542;
        Sat, 29 Oct 2022 02:30:09 -0700 (PDT)
Received: from discovery.. (p5b3f76b5.dip0.t-ipconnect.de. [91.63.118.181])
        by smtp.gmail.com with ESMTPSA id f7-20020adff987000000b0022e6178bd84sm1068187wrr.8.2022.10.29.02.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 02:30:09 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sre@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, andy.shevchenko@gmail.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v5 6/8] iio: adc: mp2629: restrict input voltage mask for mp2629
Date:   Sat, 29 Oct 2022 11:29:58 +0200
Message-Id: <20221029093000.45451-7-sravanhome@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20221029093000.45451-1-sravanhome@gmail.com>
References: <20221029093000.45451-1-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for mp2733 which is updated version of mp2629
with a higher range of input voltage.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/adc/mp2629_adc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mp2629_adc.c b/drivers/iio/adc/mp2629_adc.c
index 88e947f300cf..18290e176e1e 100644
--- a/drivers/iio/adc/mp2629_adc.c
+++ b/drivers/iio/adc/mp2629_adc.c
@@ -66,6 +66,7 @@ static int mp2629_read_raw(struct iio_dev *indio_dev,
 			int *val, int *val2, long mask)
 {
 	struct mp2629_adc *info = iio_priv(indio_dev);
+	struct mp2629_data *ddata = dev_get_drvdata(info->dev);
 	unsigned int rval;
 	int ret;
 
@@ -75,8 +76,10 @@ static int mp2629_read_raw(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 
-		if (chan->channel == MP2629_INPUT_VOLT)
+		if (chan->channel == MP2629_INPUT_VOLT &&
+		    ddata->chip_id == CHIP_ID_MP2629)
 			rval &= GENMASK(6, 0);
+
 		*val = rval;
 		return IIO_VAL_INT;
 
-- 
2.32.0

