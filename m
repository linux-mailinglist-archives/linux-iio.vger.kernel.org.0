Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D325C6D64E2
	for <lists+linux-iio@lfdr.de>; Tue,  4 Apr 2023 16:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235594AbjDDOMQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Apr 2023 10:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235683AbjDDOMM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Apr 2023 10:12:12 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3529744AA
        for <linux-iio@vger.kernel.org>; Tue,  4 Apr 2023 07:12:09 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-54606036bb3so450306297b3.6
        for <linux-iio@vger.kernel.org>; Tue, 04 Apr 2023 07:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680617528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VXpkbjdlcHxE2UhGi8BVKz9oJwAUhYdEPgQCrFBUbtg=;
        b=ANaY3Sh6n86OcFsrMqgmdJnGPyQOIhZ6nlCWS5mYv5y2mHg71tnjhg8PZuIkR0nI6M
         unZ/wv8g57w6kK/GrQ1psdcxM1TOy1+Klw3LULHA4WnqMhiPtaWpDA/Io7YlTg2M49nD
         USSjeIFHQ2y8LagYrRuFGdDFh7j4n8ScbrPKYCzpoqYgKSBHhOeH1MkLxlv6mwSbxAh1
         uM8+RycfcpMn80GWoODlWTd5XP+bzBoiWI2/wIaS/Jn15KelljV+kCmX1qrA0Fn6/aba
         OobIFVzVJ8yUydCZ6THMmCtCWYgvzJ37kiUhfdYBWEadHrxLK/PgSE2CsdOPHG3t70AL
         d2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680617528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VXpkbjdlcHxE2UhGi8BVKz9oJwAUhYdEPgQCrFBUbtg=;
        b=CrQ8R1DYUIHCGjPWxzbKp20viVDEnU77QKQAkVuww+I80KIZcrjX2jJlCy8KbcSZsP
         d9qu7vbgIGuofSKmKwN7sfmsmVlmJmN4byThB0ghDZalyxeJ6uT0CBwzv5Pl1xERmVU/
         1mc5vb30QwKBr95lS8akzwLSMA3KM25Vns9Wq6sYYJ/hcSUIDJGhNtkeEpaJ8B6S0M9e
         OvuwjTznkcFBdjNizGCx8Xxff/MXZ/DyKwdOl0fOljWepc0c/bl6lXHWcaF6CUPftKUd
         nrh9e7Z6x9jGt/OEv0XUL+KV1o8RaRGITes3aUwU/6ftfKwz9IAKBqBy+Ck5+oclrjs9
         hKEg==
X-Gm-Message-State: AAQBX9eg6WukRRtNfjkCZTzJHdMHjNOJGLPVMkaayvCKC4wTk4P/7cf2
        Wr5cIJR8Jz6T+e5Dh8PavJsf0A==
X-Google-Smtp-Source: AKy350a+0t85IB/hhnmx7wWa+SKejsDXF74jW0q5rSx6aa+TL3DzYudacwZc2l2yk+6y1oddZZc7Yw==
X-Received: by 2002:a81:1383:0:b0:541:61b1:4a59 with SMTP id 125-20020a811383000000b0054161b14a59mr19446751ywt.3.1680617528187;
        Tue, 04 Apr 2023 07:12:08 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id d195-20020a811dcc000000b00545a08184d8sm3202750ywd.104.2023.04.04.07.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 07:12:07 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v4 3/5] iio: addac: stx104: Improve indentation in stx104_write_raw()
Date:   Tue,  4 Apr 2023 10:12:00 -0400
Message-Id: <ac00afab032039350d23cfc9752f8e9225537fd0.1680564468.git.william.gray@linaro.org>
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

By bailing out early if chan->output is false for the IIO_CHAN_INFO_RAW,
indentation can be decreased by a tab and code readability improved.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/iio/addac/stx104.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/addac/stx104.c b/drivers/iio/addac/stx104.c
index 8730b79e921c..9cc467469dde 100644
--- a/drivers/iio/addac/stx104.c
+++ b/drivers/iio/addac/stx104.c
@@ -180,20 +180,20 @@ static int stx104_write_raw(struct iio_dev *indio_dev,
 
 		return 0;
 	case IIO_CHAN_INFO_RAW:
-		if (chan->output) {
-			/* DAC can only accept up to a 16-bit value */
-			if ((unsigned int)val > 65535)
-				return -EINVAL;
+		if (!chan->output)
+			return -EINVAL;
 
-			mutex_lock(&priv->lock);
+		/* DAC can only accept up to a 16-bit value */
+		if ((unsigned int)val > 65535)
+			return -EINVAL;
 
-			priv->chan_out_states[chan->channel] = val;
-			iowrite16(val, &priv->reg->dac[chan->channel]);
+		mutex_lock(&priv->lock);
 
-			mutex_unlock(&priv->lock);
-			return 0;
-		}
-		return -EINVAL;
+		priv->chan_out_states[chan->channel] = val;
+		iowrite16(val, &priv->reg->dac[chan->channel]);
+
+		mutex_unlock(&priv->lock);
+		return 0;
 	}
 
 	return -EINVAL;
-- 
2.39.2

