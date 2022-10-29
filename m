Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7F86121C5
	for <lists+linux-iio@lfdr.de>; Sat, 29 Oct 2022 11:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiJ2JaJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Oct 2022 05:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJ2JaI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 Oct 2022 05:30:08 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329D957BE2;
        Sat, 29 Oct 2022 02:30:06 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id y16so9389003wrt.12;
        Sat, 29 Oct 2022 02:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xkjjo7UhHr68UQkDQLmeDc/rzOhg5k2ugSo/6Bh7PsU=;
        b=quUqf6BNp5UZzyhdM5eQZ4d0L+clKrLdmEM2GHHs+ljP/NUkaE9aqMDWfyYj8AMMBX
         u13V0EmOiGjmeWy0+rDgbYXLdNq98g4BwtPgn7Eg2EuRUCuu1KAxCuqFuO+//vyKZXcR
         0MPFAn12KAoSgw1bmBAzVGLWeBnlwFe65RNuimv1PfBQYwxcF7vGAAtN/fnPqO2WYyDg
         F8IPZRvDsg25EnzLKxlLapcBQhjUtDBPci3w0GKVUsXQTXM4UmNXDTDwU2REFDLwWQmQ
         cNuk6IQVyZMpPg/tKYHLhHtQv0F+D2Xye54b8jhapzXIXcReZofOAIjaTI6shEji4hm/
         1ORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xkjjo7UhHr68UQkDQLmeDc/rzOhg5k2ugSo/6Bh7PsU=;
        b=dhlNCX4GKYPS9O4+H9awhP4yRzIGSV7vw4saMh/jzI7NCrAg1cjVWcMQmyQke+uiRK
         P63v4+o+U7bEjvKL6AmiP1VxA3ywREcVPX+zKQm8lB0L9X+Rr4gQaoQ3tFiRNrlnc3R5
         xNBBPKESy18SeTZElYIYDf/6YhP+t7K6GPoM1OaL7glwrK/aLpeHN3o2OJN0T+A8Obli
         xLuJh4IMSHGOF8BS+6dK731BsqI5aKljk/339szeUaiMqrMPUionMlfAwNI/xwEAMciF
         ZxQwlZ0efWhw4gtIL0nZKZj+FlCfUB12t9J+ycYAkbQyI5SlP2UuEzP/nY41X6ZpqGav
         7PBw==
X-Gm-Message-State: ACrzQf19KK4as4Djj2JJJrMaik//ewZZzlLOAYX/7Hg2QtjcbvfZmj4M
        A/qUtwE9FG/s14P8tV2FKGa6nQH32wqfmw==
X-Google-Smtp-Source: AMsMyM5e6xOzMTR5x/GZs6j7ZXh31p17gFPI/5vbXO9YBLPcQuN3jfxvhA2NJA90nCfVseQTkkhM2w==
X-Received: by 2002:a05:6000:1a85:b0:230:f67b:da03 with SMTP id f5-20020a0560001a8500b00230f67bda03mr2011312wry.296.1667035804661;
        Sat, 29 Oct 2022 02:30:04 -0700 (PDT)
Received: from discovery.. (p5b3f76b5.dip0.t-ipconnect.de. [91.63.118.181])
        by smtp.gmail.com with ESMTPSA id f7-20020adff987000000b0022e6178bd84sm1068187wrr.8.2022.10.29.02.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 02:30:04 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sre@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, andy.shevchenko@gmail.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v5 1/8] iio: adc: mp2629: fix wrong comparison of channel
Date:   Sat, 29 Oct 2022 11:29:53 +0200
Message-Id: <20221029093000.45451-2-sravanhome@gmail.com>
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

Input voltage channel enum is compared against iio address instead
of the channel.

Fixes: 7abd9fb64682 ("iio: adc: mp2629: Add support for mp2629 ADC driver")
Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/adc/mp2629_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mp2629_adc.c b/drivers/iio/adc/mp2629_adc.c
index 30a31f185d08..f7af9af1665d 100644
--- a/drivers/iio/adc/mp2629_adc.c
+++ b/drivers/iio/adc/mp2629_adc.c
@@ -74,7 +74,7 @@ static int mp2629_read_raw(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 
-		if (chan->address == MP2629_INPUT_VOLT)
+		if (chan->channel == MP2629_INPUT_VOLT)
 			rval &= GENMASK(6, 0);
 		*val = rval;
 		return IIO_VAL_INT;
-- 
2.32.0

