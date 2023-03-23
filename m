Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62B76C6C3F
	for <lists+linux-iio@lfdr.de>; Thu, 23 Mar 2023 16:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbjCWP0T (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 Mar 2023 11:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbjCWP0S (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Mar 2023 11:26:18 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4CC1DB88;
        Thu, 23 Mar 2023 08:26:17 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id l12so20942315wrm.10;
        Thu, 23 Mar 2023 08:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679585176;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F2AEpvtu2XG88P/VDWdqhpfYyJ4UOcOn6tPJNQTorBk=;
        b=StMMyxjdB8B52QWahYfHHTXOaM9qHCRWRUcDu9g6vBIHgPDNQtBQ02gT5PnFRuC7X0
         TPim4MQFiFC5Q4VAM1N0PiBgA5Nq5by2VmSY9Lri59gC/9oxdUYkouJh7gEAAjrcA3jP
         BZTY+NP7aE9LU9XH1o95Ghr/8nprUz+E+SiaBOLCymAaKp5cncyx098vLJomRa44xAAl
         HlF8tz6LMpw8LMh3W2MMPrO0J2ymcAhrDpgTNGooAjF4/QxkO+MGNgCblOq+5Fp6q+I+
         IjK5FaIEKG0Wsm/lJ8Hp1/FnLqw6TSi2W00VUUxBeZC1sj4q9qfEqNwzPShHZXEcZuF1
         /Ldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679585176;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F2AEpvtu2XG88P/VDWdqhpfYyJ4UOcOn6tPJNQTorBk=;
        b=3iSa2M7lNlGLzr0DGmTXfkFRQg9fNXxnDR/vVHcJ4i/kLfgcperoVHClLbvweV7I/0
         1WUynFIUeEtdmDG0PHa4pifNd2YbjZ7gRGV391eauHT3WNJcJm+h0q3clQyL06VaLcYI
         6WRaRUGK1qp2E3fs9d3Zqr9pYhluBx7VehpazjD3u9MxZEf+nOK3swvRJho7FPpY0FXl
         1h3+Mt2VjKwWTDWN01fDyYLacCahoRKtGep7M/7guHVpipy28oTKZojutvKO7/EBNn6H
         AlRAdC9IDJJb1E52x9+VV6820Q+lBkVCeUX5oIc5xRkPsT7tYsOCVm4qlogOSlAoKs2v
         SvJA==
X-Gm-Message-State: AAQBX9dmqhl6Lh1E/XVlOiY3fpqYHfcnvcsPCHPbc7T2eqqbNfC9y6+u
        RkjfLv2qN7+MiXkC8WJB28A=
X-Google-Smtp-Source: AKy350aMt6oN6Jcj9qISEhLPHPa+5FVszw+vesojoxzv4NX5+dK1wsm84LY0J/skqkAe8UQzx5ytEA==
X-Received: by 2002:adf:f1c1:0:b0:2da:1ac3:adfc with SMTP id z1-20020adff1c1000000b002da1ac3adfcmr3191787wro.60.1679585176142;
        Thu, 23 Mar 2023 08:26:16 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id w2-20020a5d6802000000b002cfe687fc7asm16291460wru.67.2023.03.23.08.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 08:24:44 -0700 (PDT)
Date:   Thu, 23 Mar 2023 18:23:56 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] iio: adc: ti-ads1100: fix error code in probe()
Message-ID: <36fa2aeb-f392-4793-8b38-ae15514033c8@kili.mountain>
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

This code has a copy and paste bug so it accidentally returns
"PTR_ERR(data->reg_vdd)" which is a valid pointer cast to int. It
should return "ret" instead.

Fixes: 541880542f2b ("iio: adc: Add TI ADS1100 and ADS1000")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 drivers/iio/adc/ti-ads1100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads1100.c b/drivers/iio/adc/ti-ads1100.c
index 6a478efb108b..6b5aebb82455 100644
--- a/drivers/iio/adc/ti-ads1100.c
+++ b/drivers/iio/adc/ti-ads1100.c
@@ -344,7 +344,7 @@ static int ads1100_probe(struct i2c_client *client)
 
 	ret = regulator_enable(data->reg_vdd);
 	if (ret < 0)
-		return dev_err_probe(dev, PTR_ERR(data->reg_vdd),
+		return dev_err_probe(dev, ret,
 				     "Failed to enable vdd regulator\n");
 
 	ret = devm_add_action_or_reset(dev, ads1100_reg_disable, data->reg_vdd);
-- 
2.39.1

