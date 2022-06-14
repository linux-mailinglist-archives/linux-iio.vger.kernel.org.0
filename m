Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C7254B46F
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jun 2022 17:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356594AbiFNPRm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Jun 2022 11:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356586AbiFNPRi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Jun 2022 11:17:38 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0456962E3;
        Tue, 14 Jun 2022 08:17:32 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id kq6so17807433ejb.11;
        Tue, 14 Jun 2022 08:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K/Bb9QNZS4KUSJsXgLquKvLX7xOgHLYAfEYnI8Rwogk=;
        b=AFaVWlyXJ1FNEKXOiuwson3lZ8cfTXUQPrOam43nTKnwNtl29wG4yC9I4BKLiU093+
         9nxcGWeZtPWw+VjHOE5zz/AfgFaQ95erSHURx3EH4kMGV+OX/Zhg52HUbNsK+F4O8qxa
         YiDLHKSnFJEXXc9VXvMgeeKdvwBehE3gndoklvrfOPyKE0MQrYc6yNPCq0Ehrt4Wkx7b
         NCXlLUvfwAv7+sXqBkBjus+6CueRX8yvK3zPnUXVgN5vtg5Wie1QnJnIwvkdTD1/riEB
         34YPiKG/o1SYJkqi1jTiN3ZgzYjT2WTrokAX0zYXstowIcQBS0CDQQ1lwio8zIyvS2XE
         yb1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K/Bb9QNZS4KUSJsXgLquKvLX7xOgHLYAfEYnI8Rwogk=;
        b=yYDJcKua1ahk3rxn1BOMbIz8BDYZSU/VvMQw3bqbivZc4ruLs+JxBEoGW3AN5w700t
         qGsVd0b89LwaUMzTsrdgmXi6pzW0D4+cl4f9jzsbWewArvZOFLr+QgmosI5LVsaQEbUu
         Nlx20N/oZIQB31WR0a+tiZgKWmXzaHpxvPNVMm3PiBu50DhkcXErqdkqJo8Xi3iVZlCm
         zn8spaSZkBHtznVV8ZQSip21GeHqbqfMd8cAQZaPA33ptt1qrXDentJhLdpDGBUyI6rz
         +kcmX0rXT/YeI/AI0h+Urq1OwH8jcF3VKRMd/MVuGaB+Nkds/I90t2cqPWOlcqXtKWjb
         EIlA==
X-Gm-Message-State: AOAM533dA9SNLWROvFpWo1h7z6Erb0mowO1JRdDzHErzfMs5/l3ZLTOU
        kS08/zLUFCIr1vxKJNme36s=
X-Google-Smtp-Source: AGRyM1tJm5/bvEJsCvork/9f2aT3katbgBIymlUUTiawbib1+mgc64mVno1uo/2ndBNZTkoAukTW+Q==
X-Received: by 2002:a17:906:c209:b0:6fe:a3d5:c5a4 with SMTP id d9-20020a170906c20900b006fea3d5c5a4mr4672061ejz.759.1655219850365;
        Tue, 14 Jun 2022 08:17:30 -0700 (PDT)
Received: from localhost.localdomain (p5b3f7f9c.dip0.t-ipconnect.de. [91.63.127.156])
        by smtp.gmail.com with ESMTPSA id f1-20020a50d541000000b0042dd7e13391sm7198180edj.45.2022.06.14.08.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 08:17:26 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sre@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, andy.shevchenko@gmail.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH 1/6] iio: adc: mp2629: fix wrong comparison of channel
Date:   Tue, 14 Jun 2022 17:17:17 +0200
Message-Id: <20220614151722.2194936-1-sravanhome@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Input voltage channel enum is compared against iio address instead
of channel.

Fixes: 7abd9fb64682 ("iio: adc: mp2629: Add support for mp2629 ADC driver")
Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 drivers/iio/adc/mp2629_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mp2629_adc.c b/drivers/iio/adc/mp2629_adc.c
index aca084f1e78a..e7fbfe92e884 100644
--- a/drivers/iio/adc/mp2629_adc.c
+++ b/drivers/iio/adc/mp2629_adc.c
@@ -73,7 +73,7 @@ static int mp2629_read_raw(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 
-		if (chan->address == MP2629_INPUT_VOLT)
+		if (chan->channel == MP2629_INPUT_VOLT)
 			rval &= GENMASK(6, 0);
 		*val = rval;
 		return IIO_VAL_INT;
-- 
2.25.1

