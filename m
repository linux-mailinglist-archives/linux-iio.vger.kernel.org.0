Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1765454CBDA
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jun 2022 16:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343591AbiFOOyO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Jun 2022 10:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343697AbiFOOyJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Jun 2022 10:54:09 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A00129838;
        Wed, 15 Jun 2022 07:54:08 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id d14so16501293eda.12;
        Wed, 15 Jun 2022 07:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7dCSgUmnblCdx5KQELAz1p60pr2nFvcndhXbnKYQfrI=;
        b=CpxBdKLejyP3SnPKbJb623o4+1vbgmSMihmP6uzcHVcy4QCT3mv7YS+djKsClDngeL
         +BD/UMIAGRQ2fUgvzJKWp4q4oLSxnylrTGdCptUCQM9ycD55oMrGY7Sk+b44AcowlaAQ
         E7NE9jZArz7ZaHErwbQnFT6qWsI5JOJsluTj4NkjnjcSn+8ff/rfDbfxisI3TM1A5ZT0
         L2wCKfRR0wHIGmM761kYBYU55FmGKBe4qLIL0b3XYEa+xz1CLh/tZzYmDmTmMZ+I8WtU
         gyu+qZg/FrUolDyPLNabcylgXW5otcswasZUxMyHbkRU50ToWwVB+xwc82kBxl6G21Sd
         st6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7dCSgUmnblCdx5KQELAz1p60pr2nFvcndhXbnKYQfrI=;
        b=cZUzTCHBlpp9cin5YznmxxkfXGrcwBFRjO/X+vMh+eUeZQ+QZmY9nrBF4pSBHA+KtJ
         piSSj0t3u9gq5+V28kH8jhmbftjNWTqcjcgswy3cgG03CMA+XZSCz00wenJyNP4rHlNq
         OFna3yBMYaYNELGB1gsBxhMZ5uFI5bj6nl8lCNml7z2oJygiRl4FmdG3MMNEcFp0n9l9
         mblMofmti4LuBLkjLXXOQq0j52m33Pfj5DJUzPOUL1gyEEjB2s7ou+3TQH+Op4OgvwMB
         d0q8ejx36R3I9TEZ+yW6wr+a/zezVVuqyM+4qKO9k4dwGLAcn8mfKlRMzFQPQalB3pJq
         RI/A==
X-Gm-Message-State: AJIora/6uUS12/M+SZWI3QYOIADa3YXCelVxF0ls63boZvkkHkROqTe+
        yVSSYXP4ZlScSWzUbO3GZQg=
X-Google-Smtp-Source: AGRyM1tm4YLQpvz8BzlfDA4mQvjen6CbDidW7CXzUKkWIzYScM2l53ZbIYqQqwUVAXsIh9cSXO/yhg==
X-Received: by 2002:a05:6402:358a:b0:431:20d5:f4ad with SMTP id y10-20020a056402358a00b0043120d5f4admr88450edc.375.1655304846821;
        Wed, 15 Jun 2022 07:54:06 -0700 (PDT)
Received: from localhost.localdomain (p5dcfe5fe.dip0.t-ipconnect.de. [93.207.229.254])
        by smtp.gmail.com with ESMTPSA id y2-20020a1709063a8200b00706287ba061sm6341665ejd.180.2022.06.15.07.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 07:54:06 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sre@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, andy.shevchenko@gmail.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v3 4/6] iio: adc: mp2629: restrict input voltage mask for mp2629
Date:   Wed, 15 Jun 2022 16:53:55 +0200
Message-Id: <20220615145357.2370044-5-sravanhome@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220615145357.2370044-1-sravanhome@gmail.com>
References: <20220615145357.2370044-1-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index e7fbfe92e884..28d048eefce3 100644
--- a/drivers/iio/adc/mp2629_adc.c
+++ b/drivers/iio/adc/mp2629_adc.c
@@ -64,6 +64,7 @@ static int mp2629_read_raw(struct iio_dev *indio_dev,
 			int *val, int *val2, long mask)
 {
 	struct mp2629_adc *info = iio_priv(indio_dev);
+	struct mp2629_data *ddata = dev_get_drvdata(info->dev);
 	unsigned int rval;
 	int ret;
 
@@ -73,8 +74,10 @@ static int mp2629_read_raw(struct iio_dev *indio_dev,
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
2.25.1

