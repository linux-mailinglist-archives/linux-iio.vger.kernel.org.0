Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651966D9AB8
	for <lists+linux-iio@lfdr.de>; Thu,  6 Apr 2023 16:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238544AbjDFOm1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Apr 2023 10:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238150AbjDFOmG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 Apr 2023 10:42:06 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67133B768
        for <linux-iio@vger.kernel.org>; Thu,  6 Apr 2023 07:40:34 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id r16so29137122oij.5
        for <linux-iio@vger.kernel.org>; Thu, 06 Apr 2023 07:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680792033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwrW8zLdNa13eS+GI7R48Yjhq4tM8k3jsY8GnpkuSw0=;
        b=ET29C6Lpq8H1bupcLWpddJ6+WJMTZH14dq8GvOLwp89jjim1Y3wOQbN1KqFe/QpqPy
         be/SeTJYazGAwS7ghu4jp7LrOVKD2d4AaCEbEbnVH9aC9Id6cSyePAk+O3pWcwkdtGP8
         hX9A1/oeThB47yf06fReeoYujLwL7my+G/S3t/vAOcU1Pko10MoIJGQib395m8yK5eVv
         JwxDASIU3jjLNyC3fRyxpePBnqpQkss9KO3phn1JTpZXqrFxg6p5h6hc2Nb8FaBvel6A
         gDTkiNq38ls117KNKCBhztRm5K9vpZQg/Cb/tVj08vooFX9lr00x3FhUWE8llk50q2zc
         wqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680792033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QwrW8zLdNa13eS+GI7R48Yjhq4tM8k3jsY8GnpkuSw0=;
        b=xVW1DaCxOsjTjg01COKLh1PAaPw6ZvusgQAnf2TWHtFirz06Lg3Ztxan7wzQZL06UH
         /yry34GcO5hi2f5zAie4KB5viVuIO4/XPnVVeqkwSrF6knQmZwWAaaYIFp5vEHLtpV/i
         HS1KzXAQqLx/4lTO0VmTf4NdY19X1tzIgVW8H5kJMb+K7Qg8hcjxQ/yO3Xo/p1Xio3hD
         SdU4j9QWk/I6OynkQBg6OieZyVZCBrqmKMieUmkd+0qzONFBZWDjmizvZ49r1Qbm+GBB
         c6Wm4XPkt8qr4qvtrE++yxOhG9fiD8bvX0Kuy+KQQ9WtWyZv7ntc9o/JFJz+2LYNvBeV
         05qQ==
X-Gm-Message-State: AAQBX9fzhP5jhQ+gpSdzKLreBidrfNcClXU4tXQbpr3ej6VARrXsRrCI
        Rwbn1ZssnuJY93D6RVgDNq9+eQ==
X-Google-Smtp-Source: AKy350bCG0vtWtwYel0t3Kxrv4Y3pHI0ty1lJDbA7pUA7EgHrAAKXj9ot3YBX1+UPSmWRV0LbsvSuA==
X-Received: by 2002:a05:6808:614:b0:387:715e:56b8 with SMTP id y20-20020a056808061400b00387715e56b8mr4773349oih.56.1680792033707;
        Thu, 06 Apr 2023 07:40:33 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id q7-20020acaf207000000b0037d7f4eb7e8sm726209oih.31.2023.04.06.07.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 07:40:33 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v5 1/6] iio: addac: stx104: Fix race condition for stx104_write_raw()
Date:   Thu,  6 Apr 2023 10:40:10 -0400
Message-Id: <c95c9a77fcef36b2a052282146950f23bbc1ebdc.1680790580.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1680790580.git.william.gray@linaro.org>
References: <cover.1680790580.git.william.gray@linaro.org>
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
Changes in v5: none

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

