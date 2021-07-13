Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786823C6DCB
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jul 2021 11:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235314AbhGMJ4g (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Jul 2021 05:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234857AbhGMJ4g (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Jul 2021 05:56:36 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABC3C0613DD;
        Tue, 13 Jul 2021 02:53:45 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id g4-20020a17090ace84b029017554809f35so992577pju.5;
        Tue, 13 Jul 2021 02:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lwJZ+FRHmPdVwm0/Cne9BWGWHB7Nx2ph+8GMBriVPGo=;
        b=FgqZxAVKxvO+GCExH/zFMu9YuTw8GDamGJ/5dup4vhtKhwmmzjeYgMHLJsacEIqAC7
         yHJ7wXfseuCn0kxxJZRhz0kcpxVXpX21zWkUCKCKoIJCYxiW8d3P1aYJ2ULsd6HwOTGy
         /y+l0oce8pwfMDr8QT46b8Fb6E28WbNOauPQAeB0dkLqXpCrpcFqxQnHqiqUFYKh+f/G
         gVMwkS27jhQBD8ROukvn8RUEYmlh1TEJWgelVGy3ELBgQN883/H72pMhAyrs968bKNMj
         K/EOKAoBaagMqRMMOSVFkEfG2XbEXdfi3RXVLqv781vdlN8p3rLvdKHsAHU24IkplFCn
         HFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lwJZ+FRHmPdVwm0/Cne9BWGWHB7Nx2ph+8GMBriVPGo=;
        b=ZSzOyuVcVKNvF/fd0DhmTXmURfSz4C85R6NPHFUiKQOtXAiHN1xvoxcbB3SdaZtrpQ
         8VpUfCi0QfK45Q8I4sAxtB+QkQciFEjBT4EZM1G1QxUPefA8aaRdnTe+PZCARjTY3Vl5
         54l+MvCZm6C7rgUdfHMp19+LxVNuu1s/BmxY9rqc8d1WsIS8Ym3sAFMuJpkKwIiYR2cg
         5QZ5sd0MWw+ZYgQCFKoXOm7o66tGtlr7yJkw1tQwlT6cimiuqErNpMwK62tHreBw9cUw
         bnh4JD+JZNXg/STWGhXIHOgC6z7/XKMR9eWRhHgWWgIu9OlAi+BaYVgtvQm7FNN3D4qg
         aU/g==
X-Gm-Message-State: AOAM533vDSKrr34l+2WiSMXwb9Ij13kAw0fOjSPLNf5ZMFofoa/zJoPk
        duzftUyu37BM1Pu9ODJS8VyijaejdtF5/A==
X-Google-Smtp-Source: ABdhPJyZJg0h7/PGYh3gQwJmWPbdH2EnidAws8IJ5RP3cPzf0/4r23v8F6aWYAnS6YeHPh6wmMpmFA==
X-Received: by 2002:a17:902:b193:b029:11a:a179:453a with SMTP id s19-20020a170902b193b029011aa179453amr2841400plr.69.1626170025528;
        Tue, 13 Jul 2021 02:53:45 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id f6sm18153854pfj.28.2021.07.13.02.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 02:53:45 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        jarkko.nikula@linux.intel.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v13 01/17] counter: 104-quad-8: Return error when invalid mode during ceiling_write
Date:   Tue, 13 Jul 2021 18:53:05 +0900
Message-Id: <5a9678944e953d23e0ee2a53d3c61e700cb1cd89.1626165765.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1626165764.git.vilhelm.gray@gmail.com>
References: <cover.1626165764.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The 104-QUAD-8 only has two count modes where a ceiling value makes
sense: Range Limit and Modulo-N. Outside of these two modes, setting a
ceiling value is an invalid operation -- so let's report it as such by
returning -EINVAL.

Fixes: fc069262261c ("counter: 104-quad-8: Add lock guards - generic interface")
Acked-by: Syed Nayyar Waris <syednwaris@gmail.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/104-quad-8.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 09a9a77cce06..81f9642777fb 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -715,12 +715,13 @@ static ssize_t quad8_count_ceiling_write(struct counter_device *counter,
 	case 1:
 	case 3:
 		quad8_preset_register_set(priv, count->id, ceiling);
-		break;
+		mutex_unlock(&priv->lock);
+		return len;
 	}
 
 	mutex_unlock(&priv->lock);
 
-	return len;
+	return -EINVAL;
 }
 
 static ssize_t quad8_count_preset_enable_read(struct counter_device *counter,
-- 
2.32.0

