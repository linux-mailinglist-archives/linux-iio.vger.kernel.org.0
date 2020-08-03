Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB8323B171
	for <lists+linux-iio@lfdr.de>; Tue,  4 Aug 2020 01:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbgHCX7E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Aug 2020 19:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbgHCX62 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Aug 2020 19:58:28 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0347EC06179E
        for <linux-iio@vger.kernel.org>; Mon,  3 Aug 2020 16:58:28 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id a5so25140560ioa.13
        for <linux-iio@vger.kernel.org>; Mon, 03 Aug 2020 16:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yik+aMIToEohV7wg7qvgTDzaja0eSR46JIGUiWz8tJI=;
        b=E7jVBRmsXsePU/j4COJ/CgUnuw/aUYFsKgjExjc4hD2pfJstPSKiaVgJ7X1URgMJyF
         xK1XM2aQC8CxxvBwJcRrRPT6jli+Sf6k1SsBeSxkpNHRGUwwhA6clyfLxNLzuT2VqCAF
         A3HnMdocMmQLStbcTkVzL9CgOMh1aXKK0cOPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yik+aMIToEohV7wg7qvgTDzaja0eSR46JIGUiWz8tJI=;
        b=AcRhhKiMdlV3IJvzR74ki+Rg0EN27ZZ7GaId7j4t/cXcw89ayYYXd1uuPnCzdrzMA5
         mkVxJcvlDKPlclV3pOq17NDIkJfd4y/vQqvXmfQhwsvDfpMI3CUCXSiAA096hQ7bPTZJ
         +FQdRPcgkyRmgyDJH4Imna0uSPoLTrXHDlI2Zr/avA74J7zU8h6WFsR/IfQAAsN7U3yZ
         MpIWxFlYXUbsu3aPnBNJSDahehrPlnIiXe7kbJnnpePv7z3YkbwIbtgKzlDD3nF8ffiS
         8CfPaYwEfaf14CGktwhd7vdcs6N5UmISoxr4wPix8GFipENEN01ignAfk0VlyZyf7kL1
         T2vQ==
X-Gm-Message-State: AOAM531wYOGY/dA/s4jaEoAsynerY+ZlyWbKe7aOxQoIsWuob0TNRQQp
        L6THdrin5F3xuFzQ5Bo6vJ7z4w==
X-Google-Smtp-Source: ABdhPJx95HrouxJZl3V49xPt809qEmM/nrFASnWcwbUgmIIAxqSgr8eUcYm1t5PfpcCDeoLZv3grCw==
X-Received: by 2002:a5e:dd4c:: with SMTP id u12mr2259195iop.93.1596499107453;
        Mon, 03 Aug 2020 16:58:27 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id x185sm11075992iof.41.2020.08.03.16.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 16:58:27 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [PATCH v5 08/15] iio: sx9310: Use regmap_read_poll_timeout() for compensation
Date:   Mon,  3 Aug 2020 17:58:08 -0600
Message-Id: <20200803175559.v5.8.Ia205f0b0363bf663db7704026b5b7036b9748c56@changeid>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200803235815.778997-1-campello@chromium.org>
References: <20200803235815.778997-1-campello@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Simplify compensation stage by using regmap_read_poll_timeout().

Signed-off-by: Daniel Campello <campello@chromium.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2:
 - Fixed dev_err() message

 drivers/iio/proximity/sx9310.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index f78500b8a5841e..cd7de40a55c2f6 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -799,7 +799,7 @@ static const struct sx9310_reg_default sx9310_default_regs[] = {
 static int sx9310_init_compensation(struct iio_dev *indio_dev)
 {
 	struct sx9310_data *data = iio_priv(indio_dev);
-	int i, ret;
+	int ret;
 	unsigned int val;
 	unsigned int ctrl0;
 
@@ -813,22 +813,17 @@ static int sx9310_init_compensation(struct iio_dev *indio_dev)
 	if (ret < 0)
 		return ret;
 
-	for (i = 100; i >= 0; i--) {
-		msleep(20);
-		ret = regmap_read(data->regmap, SX9310_REG_STAT1, &val);
-		if (ret < 0)
-			goto out;
-		if (!(val & SX9310_REG_STAT1_COMPSTAT_MASK))
-			break;
-	}
-
-	if (i < 0) {
-		dev_err(&data->client->dev,
-			"initial compensation timed out: 0x%02x", val);
-		ret = -ETIMEDOUT;
+	ret = regmap_read_poll_timeout(data->regmap, SX9310_REG_STAT1, val,
+				       !(val & SX9310_REG_STAT1_COMPSTAT_MASK),
+				       20000, 2000000);
+	if (ret) {
+		if (ret == -ETIMEDOUT)
+			dev_err(&data->client->dev,
+				"initial compensation timed out: 0x%02x\n",
+				val);
+		return ret;
 	}
 
-out:
 	regmap_write(data->regmap, SX9310_REG_PROX_CTRL0, ctrl0);
 	return ret;
 }
-- 
2.28.0.163.g6104cc2f0b6-goog

