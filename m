Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9032523B156
	for <lists+linux-iio@lfdr.de>; Tue,  4 Aug 2020 01:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbgHCX6Z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Aug 2020 19:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729173AbgHCX6X (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Aug 2020 19:58:23 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD92BC0617A1
        for <linux-iio@vger.kernel.org>; Mon,  3 Aug 2020 16:58:22 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id l17so22459879ilq.13
        for <linux-iio@vger.kernel.org>; Mon, 03 Aug 2020 16:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bp6OwO92DPNru+lJBtL8+lflqmBd40LGlvDc78rVJ9c=;
        b=MHUNxH6sVnlzX16mnBO0Libr5RgVsQYv7/UqRC0xTEUbYCbo3sOqowucBA3nb+m5MX
         m8FwZqCpFUl/T08XoQJUnhJNTzHCdLOmUkdAV6Pnv+6WaOYjgLjlNOPBAK2MVIOrIRhP
         eQ1iYXdyJitiQUzJSNADJUzaWFUIrKDbJSCOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bp6OwO92DPNru+lJBtL8+lflqmBd40LGlvDc78rVJ9c=;
        b=mGbdq1zKpFWt5h0KiDU/d2mwr46AL9ZVbCR4cl4yfx8XitWDZPi/YxxuYQwcScbR2U
         mntyoCyz9Rs145fT/pKIIOqh5ys0Xj2T7hVK+zVIeySOk6J56q/klqSqITNPawWcxpjS
         Dux0s2PzqSb+n3zKbfqR/rN1mcqPX9ItTUcqB0ZJEoiae3ejpTei9d8/LuLFmN0QW2Hg
         ipZLsw3bbPNCMj9bK017eFScbLqogckrvzV3HaZvW0FHC5E3qgnVrS0oJrKCXxJI0HnK
         cm53+Adds0Z47ahRbraalGbYZmPEOMDDqjF5tZ8/u24FNP6/y4KhAvO+PGEO3fYJs4Q2
         wKhw==
X-Gm-Message-State: AOAM533PzTnQEOcwzVaCxpE27TMaMS3JVSyh5YysZna8tvL6tehvSAt2
        eW7xbCkGQwh+bI2uX4xnt4LErQ==
X-Google-Smtp-Source: ABdhPJxHGJNGeHI0qdX4nnx8eSv09ZJiDnvrlC0tQ13wHy6OexeBXFmXFY6nkq0UlgH4JqadZFUj6w==
X-Received: by 2002:a92:3006:: with SMTP id x6mr2079172ile.260.1596499102078;
        Mon, 03 Aug 2020 16:58:22 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id x185sm11075992iof.41.2020.08.03.16.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 16:58:21 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [PATCH v5 03/15] iio: sx9310: Fix irq handling
Date:   Mon,  3 Aug 2020 17:58:03 -0600
Message-Id: <20200803175559.v5.3.Idbfcd2e92d2fd89b6ed2e83211bd3e6c06852c33@changeid>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200803235815.778997-1-campello@chromium.org>
References: <20200803235815.778997-1-campello@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fixes enable/disable irq handling at various points. The driver needs to
only enable/disable irqs if there is an actual irq handler installed.

Signed-off-by: Daniel Campello <campello@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---

Changes in v5: None
Changes in v4:
 - Reverted condition check logic on enable/disable_irq methods.

Changes in v3:
 - Moved irq presence check down to lower methods

Changes in v2:
 - Reordered error handling on sx9310_resume()

 drivers/iio/proximity/sx9310.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index d7c77fc661ba86..dafee85018aa6d 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -323,11 +323,15 @@ static int sx9310_put_event_channel(struct sx9310_data *data, int channel)
 
 static int sx9310_enable_irq(struct sx9310_data *data, unsigned int irq)
 {
+	if (!data->client->irq)
+		return 0;
 	return regmap_update_bits(data->regmap, SX9310_REG_IRQ_MSK, irq, irq);
 }
 
 static int sx9310_disable_irq(struct sx9310_data *data, unsigned int irq)
 {
+	if (!data->client->irq)
+		return 0;
 	return regmap_update_bits(data->regmap, SX9310_REG_IRQ_MSK, irq, 0);
 }
 
@@ -381,7 +385,7 @@ static int sx9310_read_proximity(struct sx9310_data *data,
 
 	mutex_unlock(&data->mutex);
 
-	if (data->client->irq > 0) {
+	if (data->client->irq) {
 		ret = wait_for_completion_interruptible(&data->completion);
 		reinit_completion(&data->completion);
 	} else {
@@ -1010,10 +1014,11 @@ static int __maybe_unused sx9310_resume(struct device *dev)
 
 out:
 	mutex_unlock(&data->mutex);
+	if (ret)
+		return ret;
 
 	enable_irq(data->client->irq);
-
-	return ret;
+	return 0;
 }
 
 static const struct dev_pm_ops sx9310_pm_ops = {
-- 
2.28.0.163.g6104cc2f0b6-goog

