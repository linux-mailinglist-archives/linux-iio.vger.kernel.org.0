Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A63B2E2360
	for <lists+linux-iio@lfdr.de>; Thu, 24 Dec 2020 02:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbgLXBRv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Dec 2020 20:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728421AbgLXBRv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Dec 2020 20:17:51 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27D0C061794
        for <linux-iio@vger.kernel.org>; Wed, 23 Dec 2020 17:17:10 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id m25so1479139lfc.11
        for <linux-iio@vger.kernel.org>; Wed, 23 Dec 2020 17:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DoSTIz4OclpRqy9M1PRlqRFubsvDvdVI7jF3w2c+ZJ0=;
        b=DnoA/VmpMSORz9wPt0sZljZAfcFC4sY2f7B3Cobx4lxW219Y93SQ8lko3rSoDhY/NH
         9iYjd3GucYAGdGub8suQf5LC1oj23rXcAVmwFOVhhD39vY9YpUlYk19oo172WVXhhc7b
         dxLTOSS9FI5FFbm/2pN8bpjsq2lfgL2Xc0qEmfcuNa/T8QKdZVPAiRuuU7XPXfa2RB3g
         igT855yqtbOIbIS4oL0UPA2E051MrJQUqLhW8Hro5x5cIqC3YLgs4b1RwnyfkPiQBsom
         PrV7izB1GaTYTy7F94i5TD8+8pppyK0Tw/ESyf7ai38kvRG4jrWoZ1tww/ccP32DqJN4
         /53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DoSTIz4OclpRqy9M1PRlqRFubsvDvdVI7jF3w2c+ZJ0=;
        b=V9WCguCzI78fFY+4Y/pPgLP6JQecQMkFmVgJkjAiB62GyMI4EQSOiolHkww1V/zDvf
         hQf6OEn+4BDNpgAlY9Eyu7/GtyxykhdfU4OHnCsPzIfRDhc2M38w6ZeWyGle4ahshgts
         eJP4ytbvmo+g/yU7vksvTEZSpnS0CqnW0UqluPq131h/Zm1m5Gt+1j2trnZm21gF0e4+
         rbWMUZVEv2MPmLUex3rMRydZFs2EEosAKTMWiQQ9akf8jxVEmyym5NOCNuQuOIWyAJ83
         HUlOCIg4VhKU6LoC4i9G+X8W54vLX6Zkk3AfIU3MvLA36XXnokCaesfeFVE/ew881IZV
         UiFw==
X-Gm-Message-State: AOAM5338Z8OnbQ5/Sr1wIpgLo8eEj6vT4KbUIV55iZcH5qbWI3pi3ASi
        YJosCRxRFiMv8njdHGpE9xYBmw==
X-Google-Smtp-Source: ABdhPJwnquAubxr6XTG0nIBFCkaG03nKktNWn5cV49rLlHje5rrVUK/9UCklSnoZUWgxFQCyBcePPg==
X-Received: by 2002:a2e:b5b5:: with SMTP id f21mr6559612ljn.239.1608772629268;
        Wed, 23 Dec 2020 17:17:09 -0800 (PST)
Received: from localhost.localdomain (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id q26sm3426159lfd.87.2020.12.23.17.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 17:17:08 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH] iio: adc: ab8500-gpadc: Fix off by 10 to 3
Date:   Thu, 24 Dec 2020 02:17:00 +0100
Message-Id: <20201224011700.1059659-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fix an off by three orders of magnitude error in the AB8500
GPADC driver. Luckily it showed up quite quickly when trying
to make use of it. The processed reads were returning
microvolts, microamperes and microcelsius instead of millivolts,
milliamperes and millicelsius as advertised.

Cc: stable@vger.kernel.org
Fixes: 07063bbfa98e ("iio: adc: New driver for the AB8500 GPADC")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/adc/ab8500-gpadc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ab8500-gpadc.c b/drivers/iio/adc/ab8500-gpadc.c
index 6f9a3e2d5533..7b5212ba5501 100644
--- a/drivers/iio/adc/ab8500-gpadc.c
+++ b/drivers/iio/adc/ab8500-gpadc.c
@@ -918,7 +918,7 @@ static int ab8500_gpadc_read_raw(struct iio_dev *indio_dev,
 			return processed;
 
 		/* Return millivolt or milliamps or millicentigrades */
-		*val = processed * 1000;
+		*val = processed;
 		return IIO_VAL_INT;
 	}
 
-- 
2.29.2

