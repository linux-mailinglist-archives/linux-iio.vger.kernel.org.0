Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E642660AE3C
	for <lists+linux-iio@lfdr.de>; Mon, 24 Oct 2022 16:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbiJXOxF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Oct 2022 10:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbiJXOwf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Oct 2022 10:52:35 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB299B85F;
        Mon, 24 Oct 2022 06:30:34 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id z97so31227603ede.8;
        Mon, 24 Oct 2022 06:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTwWNDn2qdNJbRVw9L9jOeKIRCjIta4CaBA+HcX1eOI=;
        b=V17lr0h3FpW9kjI2vkyNoAG1BIIuwTrC1r3tH3a3LeHFAHee+isiudTIbWz79ZqNoI
         odLWavTFfLHYvyGRDGWd8ZbU4Xqxoujfk5TbzR8DZ+iC1s9zLik0AETTqbK62Pb3FKLQ
         RShfOIXH1rabvPyR9XT6mPJaWRQ9U585B6idhb/q1Byi9DmU4+a2y+Pp0qIPsrb2e7xc
         HiSutZmWDLk9satKX+6DifC31ADBejDiABipsWuCq52awmCeW/xwCsd4hAv98FILj2So
         DWcNOx0wRUiYMSKz9gq27gvgQHVpVhbG1J7ZQ7BmYJsvPnLqIjE9gMGZoSG2Vmy+gUGh
         fdhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gTwWNDn2qdNJbRVw9L9jOeKIRCjIta4CaBA+HcX1eOI=;
        b=rPrxWbVrc7MCd+heYMg6vLZ7jh0sjd00CqW68RaCnbiyWMjoQMo5ASkF0gleBvO7xi
         KFhPW1FaKK0V9yO+ZsWo0p/9lD8EPcU/KkdZRrFSrzEmQTEtA19R7SR4TnVxcHFOf7ke
         hxRDVPTdI+EZPBrP1gcERAjKzncCFJ/8vFVzDUqzhfB0GV/jvdZRCJ1yWHmSHfcVbgob
         i5OinmUcOELACBwHEz1+NN4HrNYaDOhMuG827Xcchzj1U5u8wo8I9ttT0cO/hlbRy5rB
         P02Uh/Gql3HK4wt6si6K+0NQ9Q4mc2he5pxCzy+B9MnNqxuWr3dhJc8QebsNm31tkh85
         Tk+Q==
X-Gm-Message-State: ACrzQf3FlnwWYU9nHZYPh0efEF49mwtaTbwkE1aq0j0ROGK2hK0wyGC0
        eHYzlkPXEeuZuS2Q/VgTxGHBGuWY4yc=
X-Google-Smtp-Source: AMsMyM4wuoEeSV6p6sCOVKCcYuUj083c9dZQhKjdqPnK6b7c+25sRkz071I2gCQiO64qQxU+P/ztIQ==
X-Received: by 2002:a05:6402:2687:b0:45d:3a94:348f with SMTP id w7-20020a056402268700b0045d3a94348fmr30638576edd.48.1666618084665;
        Mon, 24 Oct 2022 06:28:04 -0700 (PDT)
Received: from discovery.. (p5dcfeede.dip0.t-ipconnect.de. [93.207.238.222])
        by smtp.gmail.com with ESMTPSA id l20-20020a056402231400b00457c5637578sm18243818eda.63.2022.10.24.06.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 06:28:04 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sre@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, andy.shevchenko@gmail.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v4 3/8] iio: adc: mp2629: restrict input voltage mask for mp2629
Date:   Mon, 24 Oct 2022 15:27:52 +0200
Message-Id: <20221024132757.3345400-4-sravanhome@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20221024132757.3345400-1-sravanhome@gmail.com>
References: <20221024132757.3345400-1-sravanhome@gmail.com>
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
index f7af9af1665d..0f297072b8aa 100644
--- a/drivers/iio/adc/mp2629_adc.c
+++ b/drivers/iio/adc/mp2629_adc.c
@@ -65,6 +65,7 @@ static int mp2629_read_raw(struct iio_dev *indio_dev,
 			int *val, int *val2, long mask)
 {
 	struct mp2629_adc *info = iio_priv(indio_dev);
+	struct mp2629_data *ddata = dev_get_drvdata(info->dev);
 	unsigned int rval;
 	int ret;
 
@@ -74,8 +75,10 @@ static int mp2629_read_raw(struct iio_dev *indio_dev,
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

