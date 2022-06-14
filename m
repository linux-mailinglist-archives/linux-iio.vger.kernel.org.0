Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C45654B465
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jun 2022 17:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356443AbiFNPRo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Jun 2022 11:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356556AbiFNPRl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Jun 2022 11:17:41 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9868F614B;
        Tue, 14 Jun 2022 08:17:40 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id v1so17769568ejg.13;
        Tue, 14 Jun 2022 08:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6jDc8NYKw9j0qO0CfGbHbtkna/x8yWVycKpFAr90cjc=;
        b=DZkOtGjEpO1sJbNy9nSKfTkiIbp+P4QmGZ81uEl5vOYZ5lyOkbez4qLuDZUlalBylI
         6jXgiSugt/73hRCOI+k6NKXAE7qVfj1I20ZQ3xHt2KTsufSCJ160PGNV9w856nwtzZYJ
         YYtb0xDTAS5L/bPmdeNHo7/mHpBvkU0nWVSwFkJVLFgcyYZANvH4QguhyKv4CTPTg2r8
         IHe3JwnlC2SWjdVA1LMtPltPEkC4iMPqm8h6QhUfhTN4hyMHd6CQcuUUGfs65tvMQ/bU
         /6R0lE5JL3yyx3tKPqvi/7qYxhsiI9ObzKeHi/n5CvpfVYTOq8wmuep5dZO+SHKTiApD
         33rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6jDc8NYKw9j0qO0CfGbHbtkna/x8yWVycKpFAr90cjc=;
        b=vIo4leAUHMxSOc9puO/56Yd3MiLXj+DgV3PnLxcXPfLZhkMEJxVxjksE31Hfb8S9z/
         Ebl1uslY/dCcljNQRis9tHQWBaPWaVnUbtf8fLQ+PZAMZJWevwDvVw4WyWjkrlosYVpW
         bdlqCbgJhgxFEV0qPEAQSOUVt5cwiu23DoRicm6M72S26jQKuYBidI9BKIvOSZj28tTc
         UgpkDMyf9CvX0tqhQdKlyh4ZlAJoLvOVljczBQsubxgTjzm5cspMfTwFlsS9szTxD25G
         7l12LEsSu9Nb7rackgZT+MikXSSYXigSOP6+DCOrTXPHCHTMV7sPzH1d8pu6HPdt1JTx
         b/mg==
X-Gm-Message-State: AOAM5307p/L+rZzklZn4tF95V00abY4f4bbmgYShBJ1vfAf5o5/7N5q8
        qRYnS2BebnqySXsGNGbGzrk=
X-Google-Smtp-Source: ABdhPJxycYdV5oj3QkuWaDhyeE3cJZaHW0V0ek65XDvKBULDtJWpvFGpHN0YGp01wvdr2UEk+BBcQg==
X-Received: by 2002:a17:907:2c43:b0:715:85cb:21a with SMTP id hf3-20020a1709072c4300b0071585cb021amr4523321ejc.541.1655219859188;
        Tue, 14 Jun 2022 08:17:39 -0700 (PDT)
Received: from localhost.localdomain (p5b3f7f9c.dip0.t-ipconnect.de. [91.63.127.156])
        by smtp.gmail.com with ESMTPSA id f1-20020a50d541000000b0042dd7e13391sm7198180edj.45.2022.06.14.08.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 08:17:37 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sre@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, andy.shevchenko@gmail.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH 4/6] iio: adc: mp2629: restrict input voltage mask for mp2629
Date:   Tue, 14 Jun 2022 17:17:20 +0200
Message-Id: <20220614151722.2194936-4-sravanhome@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220614151722.2194936-1-sravanhome@gmail.com>
References: <20220614151722.2194936-1-sravanhome@gmail.com>
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

add support for mp2733 which is updated version of mp2629
with higher range of input voltage.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
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

