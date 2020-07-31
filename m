Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25EF6234979
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jul 2020 18:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733225AbgGaQtJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 31 Jul 2020 12:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733161AbgGaQtH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Jul 2020 12:49:07 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345CEC06138D
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2020 09:49:06 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id l1so32262457ioh.5
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2020 09:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XHCUU2RRnfaW/xOy0tUCXIP889dh0URjbsp/iA2xySI=;
        b=UttcU3N3nttvXlJ8qC5xBWXsvsAh+sqFPzkIM8khtexWu++q35V94rnwGyOB6FqUHG
         j9Lf5QLydvMp2UmbUpFunMQKamV/WyYDR/Jz1b8x++OcDmZf6VwOUbwJa/FyYFaUNq3B
         VeEKOEjEzFrX7+XJJJsqxSonhDjt08GNWPIIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XHCUU2RRnfaW/xOy0tUCXIP889dh0URjbsp/iA2xySI=;
        b=RvUkoPSVkX/exdge7js12kAFFE/glWZRAyt1FmwqbBnBB2oxVQP/Q3TJkHYXPUeNxi
         zBhUfUKlItlRhcrlaNAW9X+l8DCab392EUFcdUbY5ilPT6A39aMtlCCzA/rdpVXW+lOi
         LsAEqqstRrJe0rdrQ9M4SloX9iB3C9J/A2n6foaJhrsaID93/zYmZJOMWUQJjI9trIBg
         B67CFnloTjhmBIuI4CecF2fy1VFs5iot2D+yPbksgz9XPbbFdvUFlTgiRLErPWEk210U
         mooYdY8g/mL2MWhK8ECTO+AK9qIZUwIcxShdcVA8dVK7XABxjCTti6PTXH+cNLezklLG
         xSCg==
X-Gm-Message-State: AOAM532/fcOjtni2FPbRtUIE14O8kmvIAI9GpdLoQxKBPjaoJSyqRyy4
        XJtiXo7XH8RvuM+Mfr23EdCf0A==
X-Google-Smtp-Source: ABdhPJzIMn/W3JE/0PZaHnMNnre5jGWm2flk0DVLrUPQfgEdwiQciGPBXUWRGcZXYBqJdEes/zE9pQ==
X-Received: by 2002:a02:7092:: with SMTP id f140mr6145335jac.8.1596214145596;
        Fri, 31 Jul 2020 09:49:05 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id e84sm5122083ill.60.2020.07.31.09.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 09:49:05 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org
Subject: [PATCH v3 08/15] iio: sx9310: Use regmap_read_poll_timeout() for compensation
Date:   Fri, 31 Jul 2020 10:48:45 -0600
Message-Id: <20200731104555.v3.8.Ia205f0b0363bf663db7704026b5b7036b9748c56@changeid>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200731164853.3020946-1-campello@chromium.org>
References: <20200731164853.3020946-1-campello@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Simplify compensation stage by using regmap_read_poll_timeout().

Signed-off-by: Daniel Campello <campello@chromium.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---

Changes in v3: None
Changes in v2:
 - Fixed dev_err() message

 drivers/iio/proximity/sx9310.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 8f80a4c20ac05e..9f6292cc86146d 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -802,7 +802,7 @@ static const struct sx9310_reg_default sx9310_default_regs[] = {
 static int sx9310_init_compensation(struct iio_dev *indio_dev)
 {
 	struct sx9310_data *data = iio_priv(indio_dev);
-	int i, ret;
+	int ret;
 	unsigned int val;
 	unsigned int ctrl0;
 
@@ -816,22 +816,17 @@ static int sx9310_init_compensation(struct iio_dev *indio_dev)
 	if (ret < 0)
 		return ret;
 
-	for (i = 100; i >= 0; i--) {
-		msleep(20);
-		ret = regmap_read(data->regmap, SX9310_REG_STAT1, &val);
-		if (ret < 0)
-			goto out;
-		if (!(val & SX9310_COMPSTAT_MASK))
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

