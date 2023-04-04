Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003A56D64DD
	for <lists+linux-iio@lfdr.de>; Tue,  4 Apr 2023 16:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234223AbjDDOML (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Apr 2023 10:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235518AbjDDOMK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Apr 2023 10:12:10 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200AB3ABD
        for <linux-iio@vger.kernel.org>; Tue,  4 Apr 2023 07:12:07 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5456249756bso615808267b3.5
        for <linux-iio@vger.kernel.org>; Tue, 04 Apr 2023 07:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680617526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9McelT+zWG2/DIkleGNvPOrsfCv2UT04HfKm+eOKcDU=;
        b=CO/hizh+011yKzU6HontJBqPWmzmJxc1gbnTM6f3+Yqc79ccNokRyR/7GJzC2qp/IW
         77YiGpZEMp3k9OrXetCCxDZoZM9wCYzr5l2+OOuQKIPn3/PIpbNDDbJJoUmKz4vqSVMG
         C/BwkKvTishZZEqCFwmaLuryFw9oeiUKl0eDqDjW8gYpgo6jCbWZGSK87ApwJGsEUVIi
         QElE4bpmOf6nemwJs9CtXKHBU7onJpehB2z6ymuR+7JiP9NvqlofUCaxS96hnR5zRrTd
         9mpV+6qAUyJ6Pesiy3lflzabTLEtHraF8pY2juNoHUKhTfqruKLHZWtSI8LUOaeuX6vI
         J4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680617526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9McelT+zWG2/DIkleGNvPOrsfCv2UT04HfKm+eOKcDU=;
        b=VnL4BTFMMFNz+Z4fCcloM+e48+sQNxq4e8cHWTmgmCq7PK0XJ15bNzSEVQ36i4Efcn
         buB9rN/k+tj+sfoQ26FTn+gBl3n0/myeb/lYZ6fcfgO1J2jjmy3Ii1Dps22SbtEj7JWs
         eicfsdOequEFYSdN1+idvByvAzJ2h8iapuRmexee/myQDFuWti5YD92B7N97jFVcwxoa
         ZtZAkRv0gBsz8JLAvRkraTLRGZ5oyd29yjFQGYf67ZwzTQtLysNIK6Ae0gXUk1h/KEkU
         GHHVv1owviAxCeyLhV1E3G+jvkzMO7S78J/zzRm5lVYTKk7Xs9EFkzIo0xhT6rOjciBO
         hIAw==
X-Gm-Message-State: AAQBX9eFd0Xf7eMXuKjP3O3Oe2bZYL5QGXk6zhZyKzszuM6kuFZPnTC5
        o5QaNHBWnepA+XdTXN5kieRiPg==
X-Google-Smtp-Source: AKy350a5g/bqjE02/w4LwDBmkieF0djaQVVPmgD8EpD5vIGAfgM7RY+uJOBm98yJAhCtWCOHIKb+pg==
X-Received: by 2002:a81:4808:0:b0:541:a49e:6f26 with SMTP id v8-20020a814808000000b00541a49e6f26mr2459164ywa.10.1680617526309;
        Tue, 04 Apr 2023 07:12:06 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id d195-20020a811dcc000000b00545a08184d8sm3202750ywd.104.2023.04.04.07.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 07:12:05 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v4 1/5] iio: addac: stx104: Fix race condition for stx104_write_raw()
Date:   Tue,  4 Apr 2023 10:11:58 -0400
Message-Id: <c95c9a77fcef36b2a052282146950f23bbc1ebdc.1680564468.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1680564468.git.william.gray@linaro.org>
References: <cover.1680564468.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The priv->chan_out_states array and actual DAC value can become
mismatched if stx104_write_raw() is called concurrently. Prevent such a
race condition by utilizing a mutex.

Fixes: 97a445dad37a ("iio: Add IIO support for the DAC on the Apex Embedded Systems STX104")
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/iio/addac/stx104.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/addac/stx104.c b/drivers/iio/addac/stx104.c
index e45b70aa5bb7..4239aafe42fc 100644
--- a/drivers/iio/addac/stx104.c
+++ b/drivers/iio/addac/stx104.c
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/mutex.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
 
@@ -69,10 +70,12 @@ struct stx104_reg {
 
 /**
  * struct stx104_iio - IIO device private data structure
+ * @lock: synchronization lock to prevent I/O race conditions
  * @chan_out_states:	channels' output states
  * @reg:		I/O address offset for the device registers
  */
 struct stx104_iio {
+	struct mutex lock;
 	unsigned int chan_out_states[STX104_NUM_OUT_CHAN];
 	struct stx104_reg __iomem *reg;
 };
@@ -178,9 +181,12 @@ static int stx104_write_raw(struct iio_dev *indio_dev,
 			if ((unsigned int)val > 65535)
 				return -EINVAL;
 
+			mutex_lock(&priv->lock);
+
 			priv->chan_out_states[chan->channel] = val;
 			iowrite16(val, &priv->reg->dac[chan->channel]);
 
+			mutex_unlock(&priv->lock);
 			return 0;
 		}
 		return -EINVAL;
@@ -351,6 +357,8 @@ static int stx104_probe(struct device *dev, unsigned int id)
 
 	indio_dev->name = dev_name(dev);
 
+	mutex_init(&priv->lock);
+
 	/* configure device for software trigger operation */
 	iowrite8(0, &priv->reg->acr);
 
-- 
2.39.2

