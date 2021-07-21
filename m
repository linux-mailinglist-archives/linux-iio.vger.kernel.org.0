Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B5B3D0DD3
	for <lists+linux-iio@lfdr.de>; Wed, 21 Jul 2021 13:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238457AbhGUKxe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Jul 2021 06:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240073AbhGUKNW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Jul 2021 06:13:22 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F4DC061788;
        Wed, 21 Jul 2021 03:53:37 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id d12so1650588wre.13;
        Wed, 21 Jul 2021 03:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fTnZJfUUX7U9Vo16rWquZ2im3Sa9CLdFbpSdYfT291U=;
        b=hsec7tKhSjlTXQq2YtOIE88y8F6CcAj/5rk33LgavBNIiFyb1MvHw/KmFUwqWgPsTQ
         V3Wdsod2aqJBQYI0DvgqzJlcrsHEsDO/vgK1VtjAQ9cNpsnI+2fwbfSghd+WdFJakDdU
         NRy0r+O3FMad9T/oFJaUS+roFRDi3MF7QhD3+L6LRCHZl9/5gOWXaLFHhNfykULu/bkX
         EsFVOv3ACM5w1NhlUbZlLbk4F34MISeNlxdsztVekfTT455NfazXGUsXMk+g0ZmthRH/
         cT2eo03ZYCJsOrU9HgRmq39ZLLe2o8rxuFbWN20mO9bUGTmfMaVfwP623Vg0E+cc+4QW
         XR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fTnZJfUUX7U9Vo16rWquZ2im3Sa9CLdFbpSdYfT291U=;
        b=L+/DZovY3DeIo1iU8nq2La350T1uAcl8tSyiJ4BiSVfjUViErn9nyfJbhujLXd0iW5
         BB6AG04dAHL8zi2OHGaZR3PaAtDSm8/oPnvgmDa1JA4i1O0k4Xu0/krm861+nXaqDACX
         xyUpIdtlufmkdRnwWOKxoyM1aEQVWwt1KcbkAcl+y7joJFO1FwXfyj9DZgm6lepUM8QZ
         6D570ml7IBT+fVeeXwGNw3f6Gyu3pYDKDcGidf5CBoCQ4EokAxZNdUBi5G3ZhJpDhuO6
         vOsMv8VrNlzMFJioadO6H1RExJwXQ8Zu699URLc3On6UV90jMU/OdmtVK73N0q0C8Lcg
         ZXcw==
X-Gm-Message-State: AOAM530dnFtZeRfQHEkMBWiA9Gf6IHkfkBPr39thAms2Cz3Z86ISmPlr
        RABQg08DfDy9H8CoDCgFhkWuBS3UGbGgaj8N
X-Google-Smtp-Source: ABdhPJyJbKuav1J0Ru6SFz5i5LiXEgKSvYCwniaHXYGhRw7HKlVq2gRB5NVAp+x49PN+RzabIMXLhg==
X-Received: by 2002:a5d:6804:: with SMTP id w4mr41411375wru.417.1626864816413;
        Wed, 21 Jul 2021 03:53:36 -0700 (PDT)
Received: from monk.home (astrasbourg-157-1-7-84.w90-40.abo.wanadoo.fr. [90.40.218.84])
        by smtp.gmail.com with ESMTPSA id o14sm26933641wrj.66.2021.07.21.03.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 03:53:36 -0700 (PDT)
From:   citral23 <cbranchereau@gmail.com>
To:     paul@crapouillou.net
Cc:     jic23@kernel.org, lars@metafoo.de, linux-mips@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, linux@roeck-us.net,
        contact@artur-rojek.eu, citral23 <cbranchereau@gmail.com>
Subject: [PATCH 5/6] iio/adc: ingenic: modify 
Date:   Wed, 21 Jul 2021 12:53:16 +0200
Message-Id: <20210721105317.36742-6-cbranchereau@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210721105317.36742-1-cbranchereau@gmail.com>
References: <20210721105317.36742-1-cbranchereau@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The current code does not allow to set MD to 0 to sample AUX0, fix it for the JZ4760(B).

Signed-off-by: citral23 <cbranchereau@gmail.com>
---
 drivers/iio/adc/ingenic-adc.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-adc.c
index 618150475421..1edaae439a32 100644
--- a/drivers/iio/adc/ingenic-adc.c
+++ b/drivers/iio/adc/ingenic-adc.c
@@ -632,7 +632,7 @@ static int ingenic_adc_read_chan_info_raw(struct iio_dev *iio_dev,
 					  struct iio_chan_spec const *chan,
 					  int *val)
 {
-	int bit, ret, engine = (chan->channel == INGENIC_ADC_BATTERY);
+	int cmd, ret, engine = (chan->channel == INGENIC_ADC_BATTERY);
 	struct ingenic_adc *adc = iio_priv(iio_dev);
 
 	ret = clk_enable(adc->clk);
@@ -642,11 +642,22 @@ static int ingenic_adc_read_chan_info_raw(struct iio_dev *iio_dev,
 		return ret;
 	}
 
-	/* We cannot sample AUX/AUX2 in parallel. */
+	/* We cannot sample the aux channels in parallel. */
 	mutex_lock(&adc->aux_lock);
 	if (adc->soc_data->has_aux_md && engine == 0) {
-		bit = BIT(chan->channel == INGENIC_ADC_AUX2);
-		ingenic_adc_set_config(adc, JZ_ADC_REG_CFG_AUX_MD, bit);
+		switch (chan->channel) {
+		case INGENIC_ADC_AUX0:
+			cmd = 0;
+			break;
+		case INGENIC_ADC_AUX:
+			cmd = 1;
+			break;
+		case INGENIC_ADC_AUX2:
+			cmd = 2;
+			break;
+		}
+             
+		ingenic_adc_set_config(adc, JZ_ADC_REG_CFG_AUX_MD, cmd);
 	}
 
 	ret = ingenic_adc_capture(adc, engine);
@@ -654,6 +665,7 @@ static int ingenic_adc_read_chan_info_raw(struct iio_dev *iio_dev,
 		goto out;
 
 	switch (chan->channel) {
+	case INGENIC_ADC_AUX0:
 	case INGENIC_ADC_AUX:
 	case INGENIC_ADC_AUX2:
 		*val = readw(adc->base + JZ_ADC_REG_ADSDAT);
-- 
2.30.2

