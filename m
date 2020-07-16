Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 315E4222495
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jul 2020 16:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbgGPOAC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Jul 2020 10:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729197AbgGPOAB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jul 2020 10:00:01 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A718DC08C5C0
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2020 07:00:00 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z13so7180970wrw.5
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2020 07:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yhAlYdV5Ne68CM+OfBERNX54x9vjQJ2ipPF8jNzEsTE=;
        b=YFHjdhb3nz8ipEzJ5Z806+yAFjm+JnCtifCj6oH7xDw7KtUOJ803J24ZjjOOOhC5SY
         If9NQFbI1uNzn53+X4WA3nqiVRBvRaKaoXJM9NtJWkvQn6GgpyaJHFkcYmUdivz4Tnak
         9LrnSDlGMHCPbNeUqzcR7y1eiZCJI+3+i3g5AesZsCYEfEPIAHZ9Sv80NNIflvXhbZFF
         trvIALQsI4z7xNXWhb5jZsiTVhHjN8z6ugz7+X67NnBZ9XEH0+HKETaP+WHDLLkgd96L
         fUqTlXxcQ0wjCzXjsdNA8mYUHYEPIJRbgB6GQfu3GsNkpy1pZcuZXu/pEzf7o+2i5du9
         xBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yhAlYdV5Ne68CM+OfBERNX54x9vjQJ2ipPF8jNzEsTE=;
        b=sfzdVnVPexnyaaFll/VhgywCFrLNffLZ+y2Cb1F0Q/B8vNCPU+C3V2bjFrl9fxRoqG
         zpgqcf10l4GMdoBejvspsYuabVjbiqadtP1ayWJJ4cDm6OupYN0s3u5XWdO7+Oa33jeQ
         m7ES8QmitgaEF2wVN5kshdwM2MKsJdr8WTQX8E8gsOuhOuJdANVXiYoEirnbc9EmS8w/
         A5RYJ8lxmBt9vlzLsXVHT3CeOJXHd+G4LV/VM+ILtFZWR89yGfx4J7AF9/MkI5cZVUtB
         0iQBWxIHbTqmhT5iqdohQeVG+i8EVTtzGNKfBiWUJKlWZo11HN3qWj3DlNzynLe0dLlu
         vAaQ==
X-Gm-Message-State: AOAM5316N/WoyzjIRQCOG40YVKXuLV134OfvNfZGsuxrSiQgBbLiE04B
        V4DIKTSiiqscQJKPKdUVc05emg==
X-Google-Smtp-Source: ABdhPJwCAMel7xrEfrRY7L+G7+cweQnfelaWTowsT3p/jtlurNSyRj2+Bif0CrPV/qz9AQShAUeY8Q==
X-Received: by 2002:a5d:6412:: with SMTP id z18mr5144810wru.310.1594907999384;
        Thu, 16 Jul 2020 06:59:59 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id x18sm9351001wrq.13.2020.07.16.06.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 06:59:58 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH 22/30] iio: dac: ad5755: Fix kerneldoc attribute formatting for 'lock'
Date:   Thu, 16 Jul 2020 14:59:20 +0100
Message-Id: <20200716135928.1456727-23-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716135928.1456727-1-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Kerneldoc expects attributes/parameters to be in '@*.: ' format.

Fixes the following W=1 kernel build warning(s):

 drivers/iio/dac/ad5755.c:105: warning: Function parameter or member 'lock' not described in 'ad5755_state'

Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/dac/ad5755.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
index 7723bd313fc6e..bee4ed0ce91a8 100644
--- a/drivers/iio/dac/ad5755.c
+++ b/drivers/iio/dac/ad5755.c
@@ -82,7 +82,7 @@ struct ad5755_chip_info {
  * @pwr_down:	bitmask which contains  hether a channel is powered down or not
  * @ctrl:	software shadow of the channel ctrl registers
  * @channels:	iio channel spec for the device
- * @lock	lock to protect the data buffer during SPI ops
+ * @lock:	lock to protect the data buffer during SPI ops
  * @data:	spi transfer buffers
  */
 struct ad5755_state {
-- 
2.25.1

