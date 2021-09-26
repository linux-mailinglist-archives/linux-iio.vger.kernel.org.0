Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32BC3418A27
	for <lists+linux-iio@lfdr.de>; Sun, 26 Sep 2021 18:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbhIZQav (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Sep 2021 12:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbhIZQau (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Sep 2021 12:30:50 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191E9C061570
        for <linux-iio@vger.kernel.org>; Sun, 26 Sep 2021 09:29:14 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id v10so53989307edj.10
        for <linux-iio@vger.kernel.org>; Sun, 26 Sep 2021 09:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7jucDxAZgXFO2xiPpoYJkT8xmT+xrk7gRKE4e9TEQU4=;
        b=jotAFICWXy4a5lhFBAfBjvv0/xOsSC3yFTelep4P8kVqsSiYZ34vpXylx7uc+MY+Kp
         oYeQgPOnJ9INL6J7YXyWbxTVSvMZo2SIBvPrqwW8Nn8Ux46Igqbk47Kj+vqgQYlU55aB
         CpBgq99QsmmkkcXuv2G/zMMNwZBTETpadnM7v6QWgOBVzXrz3WJW1fXkYk52nX+T7X1f
         xkciLhI9uhUrWMip5PlsSbDB0SbPU2ix2Nc+SrALDkFmeXLydJEuhHq7v4vFLaJBjXpD
         Tih4GZAq6FavS/Gnb0v23eICQtu4RxfhtF5pYuPACsKYmC+AP3BkyCGIh0z1SRqvdvcf
         JGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7jucDxAZgXFO2xiPpoYJkT8xmT+xrk7gRKE4e9TEQU4=;
        b=PDD3vrXWs6K943JseldGpAwxGcTKYDy8glmFXRhztRQLvlRX7e7rTNCgVACgms3iYM
         gWQlWrBlPSLM//4XXdl/A5FK119SJiRiFpG85hlvNpVNgifJ0gMk9r62TBeIIKQrZNc4
         ZEHB9nD1rhNnX5e2plao19d6GQ6LVbcZC2NoLJov6R4nWL6xdEliOnUlz80J71HeKxkn
         pH2vbvyESlmzSvLtf0nWssJHCJtuUucZ3TwIst+sItf8t1g5hGRzw92VGpJlkk7B9uFI
         JeucoWdjuCzZWHfwv9HBRccBnFIFRnmmlOtkE5VHxRbEKmGmhaxxkgnq+JRy6yJY52xf
         zBrQ==
X-Gm-Message-State: AOAM533X9b6edafdWS6uM1vWFbcSjKfCoqT6bInC30MnVQV8RljeWVGx
        m8egY7B0uAaazDHz5/9yyL8V5w==
X-Google-Smtp-Source: ABdhPJwO+nWxZexfB5hgTBwJua7YyCdMBD3I/VDSQIOwjq+G9zhLU5af0yoKCSnhihWCWHTef4US8A==
X-Received: by 2002:a17:906:3054:: with SMTP id d20mr22181545ejd.294.1632673752679;
        Sun, 26 Sep 2021 09:29:12 -0700 (PDT)
Received: from neptune.. ([188.27.128.17])
        by smtp.gmail.com with ESMTPSA id d15sm7468956ejo.4.2021.09.26.09.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 09:29:12 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, andreas@kemnade.info,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH] iio: adc: rn5t618-adc: use devm_iio_map_array_register() function
Date:   Sun, 26 Sep 2021 19:28:59 +0300
Message-Id: <20210926162859.3567685-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This driver already hooks a similar unwind callback via
devm_add_action_or_reset().

They pretty much do the same thing, so this change converts it to the
devm_iio_map_array_register().

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/adc/rn5t618-adc.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/iio/adc/rn5t618-adc.c b/drivers/iio/adc/rn5t618-adc.c
index c56fccb2c8e1..7d891b4ea461 100644
--- a/drivers/iio/adc/rn5t618-adc.c
+++ b/drivers/iio/adc/rn5t618-adc.c
@@ -197,13 +197,6 @@ static struct iio_map rn5t618_maps[] = {
 	{ /* sentinel */ }
 };
 
-static void unregister_map(void *data)
-{
-	struct iio_dev *iio_dev = (struct iio_dev *) data;
-
-	iio_map_array_unregister(iio_dev);
-}
-
 static int rn5t618_adc_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -254,11 +247,7 @@ static int rn5t618_adc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = iio_map_array_register(iio_dev, rn5t618_maps);
-	if (ret < 0)
-		return ret;
-
-	ret = devm_add_action_or_reset(adc->dev, unregister_map, iio_dev);
+	ret = devm_iio_map_array_register(adc->dev, iio_dev, rn5t618_maps);
 	if (ret < 0)
 		return ret;
 
-- 
2.31.1

