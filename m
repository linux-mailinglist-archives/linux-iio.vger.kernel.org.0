Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE376D9ABB
	for <lists+linux-iio@lfdr.de>; Thu,  6 Apr 2023 16:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237148AbjDFOmb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Apr 2023 10:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239025AbjDFOmJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 Apr 2023 10:42:09 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6F3BB94
        for <linux-iio@vger.kernel.org>; Thu,  6 Apr 2023 07:40:36 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id f7-20020a4ab647000000b0054101f316c7so2775114ooo.13
        for <linux-iio@vger.kernel.org>; Thu, 06 Apr 2023 07:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680792035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T77DZLgcuvZGhTCXvpAiez5W7bAjrquGewZGCvMql+g=;
        b=YwIEBxMVzAo6ze8vKzbjcXJdJTuZ047xC9x1gnqtINolu0BWghermplLZ32osLEoEt
         obEby0llRPohdk4+U+BhveUYpj6WFZ7xQ0RbMgUaI4y7+uohndddh+vPJJ9O3poK7Rpl
         aiHiswTYiKGbv15cmieOo9kdxW6DnlCd9ojK9lH9xXM7avTPqnv6wK2j7zYY0xHevp/T
         x7E6e57R1qQoE14eL+yNcKNJcgqgxFwyz3aCnPqkKbU0yXKekPNtfzYyUjmP4uBTLoDi
         Nx6rLgiUzM7WF/oNmZcQXzxHXMWC8SvlpkvYD/fb7EZxXxuoP/PV6XFUWx4wK+caCln8
         zlKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680792035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T77DZLgcuvZGhTCXvpAiez5W7bAjrquGewZGCvMql+g=;
        b=El2fMrTg/y3F2CDVb8Gd3c/t3UX9N37zfF0D/QYe/S48WoMNCdJBgFQZOzaqiiQiVR
         FWpAn4Sh/x4EZCewwvigw13Ie1IbdBOlek56HNedBN8fvSeo7hNS0zU7maYjeyrQFLRe
         x2p94+0O8opqGuS62XBP63n1RLQzvR5j8lefGMrcv3VdIalU7J+uhDEVIvxJuNvGn8nT
         F9ESH3P7ps9jrsZGLOpBFrwFiXQ3879It5n6gI/30/uuevqPM4YQRjpLgo/lH3uB0Gx9
         puW86OQtajBw/5kP+lyzGwJG1cN1jPxwYp6d9ERDl9DgnD5izRE3pqBzEYYTGV2vSNy5
         EBeA==
X-Gm-Message-State: AAQBX9cehB4FVqwEXbseyKrlyxc6JQeKaBlqu5tNIevO7d5ZTpwrMQft
        8UfHJQKUPSXKdAE+/hL5/UugvQ==
X-Google-Smtp-Source: AKy350akILD0OhGKfUUaCFpXEw+5BRBBcj8pfP0bB7fbj9sbK9VTS5qG5SCeZpVqb602yozzLWg/0w==
X-Received: by 2002:a4a:3383:0:b0:525:4058:2fcd with SMTP id q125-20020a4a3383000000b0052540582fcdmr882877ooq.1.1680792035728;
        Thu, 06 Apr 2023 07:40:35 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id q7-20020acaf207000000b0037d7f4eb7e8sm726209oih.31.2023.04.06.07.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 07:40:35 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v5 3/6] iio: addac: stx104: Use define rather than hardcoded limit for write val
Date:   Thu,  6 Apr 2023 10:40:12 -0400
Message-Id: <4c9f4f1b4a270d133be70c82a091351b531b5e3e.1680790580.git.william.gray@linaro.org>
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

The DAC register is 16 bits wide, so the value passed by write_raw()
should be checked against that limit. Rather than hardcoding the 16-bit
maximum value limit, use a define to improve readability and make the
intention of the code clearer. The explicit cast is also avoided by
instead explicitly checking for negative values.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/iio/addac/stx104.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/addac/stx104.c b/drivers/iio/addac/stx104.c
index 8730b79e921c..0ed5f71b18cb 100644
--- a/drivers/iio/addac/stx104.c
+++ b/drivers/iio/addac/stx104.c
@@ -13,6 +13,7 @@
 #include <linux/ioport.h>
 #include <linux/isa.h>
 #include <linux/kernel.h>
+#include <linux/limits.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/mutex.h>
@@ -181,8 +182,7 @@ static int stx104_write_raw(struct iio_dev *indio_dev,
 		return 0;
 	case IIO_CHAN_INFO_RAW:
 		if (chan->output) {
-			/* DAC can only accept up to a 16-bit value */
-			if ((unsigned int)val > 65535)
+			if (val < 0 || val > U16_MAX)
 				return -EINVAL;
 
 			mutex_lock(&priv->lock);
-- 
2.39.2

