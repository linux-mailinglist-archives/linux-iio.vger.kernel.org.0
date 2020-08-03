Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF7423B119
	for <lists+linux-iio@lfdr.de>; Tue,  4 Aug 2020 01:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbgHCXmh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Aug 2020 19:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728926AbgHCXmI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Aug 2020 19:42:08 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCBDC06179F
        for <linux-iio@vger.kernel.org>; Mon,  3 Aug 2020 16:42:08 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id j9so29251805ilc.11
        for <linux-iio@vger.kernel.org>; Mon, 03 Aug 2020 16:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=crpNFCNIy/zAlJwvXKSpz1wtCMZ2tFyOhrPvEeMN7o0=;
        b=QmyMqDJsmdR/d0fB+0WUIJaOqulAEaOjBgp/lrDRlz0p7lrJKCUcFnBnfOb7Y91dZe
         DQ1MAREQuOy2r1RgZ9eL+3ojvnp+93gwrGyErlxHOQTNoZwqzWQ9AVUApFjaZvY7Bg9P
         7/NwBNBRrsNVh415wLN5DX6vEvx+fx9cQvTeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=crpNFCNIy/zAlJwvXKSpz1wtCMZ2tFyOhrPvEeMN7o0=;
        b=W0QNdCr32I83MY8ugR9oHAKIXaSdHO/FheC2YlWlngm/gNvvO0ljN4DDCmIG+ZElL7
         L8HBrHf6EUI4sVg5AAxnDv58VVOZQTrL3YK4skhBVDSYf7t+AAgr6Mt+BiH4eNpHy1np
         Zcs/o5EfTrksI5Sc5D7cQwbAtq+SIvc64CmWeA60BgBFYRvOXBO8UeY3jMBuHMGl0QrF
         XQQ/hSd86Z5jAyOIItpVJ7ITI/0T6RTfZnmbBM5BqsTuKVwR52ZGWG7M+EvBast4wsUY
         8IuoschgKg8lKGiddJGMCkitnB1UMgHchgiUGukl0wH31mtdgaHL4W0rNhPtUfXNJ7ay
         od7Q==
X-Gm-Message-State: AOAM530urzVHXCVbv2nrnfoisElJImq/RWbz2MVNv+OKqZfOIXjBzVDG
        tGBHCcGeR6ViPZK/6g+RM17LxQ==
X-Google-Smtp-Source: ABdhPJxKJ6juB/6v9Cq2ZsqNdu0gCRw9v/ib+Mzpv7eRLhX8f32mNaCUvbn+3mKElRKyr3AgBqOsYw==
X-Received: by 2002:a05:6e02:1203:: with SMTP id a3mr1935467ilq.85.1596498127516;
        Mon, 03 Aug 2020 16:42:07 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id g2sm5468435ioe.4.2020.08.03.16.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 16:42:07 -0700 (PDT)
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
Subject: [PATCH v4 08/15] iio: sx9310: Use regmap_read_poll_timeout() for compensation
Date:   Mon,  3 Aug 2020 17:41:47 -0600
Message-Id: <20200803131544.v4.8.Ia205f0b0363bf663db7704026b5b7036b9748c56@changeid>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200803234154.320400-1-campello@chromium.org>
References: <20200803234154.320400-1-campello@chromium.org>
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

Changes in v4: None
Changes in v3: None
Changes in v2:
 - Fixed dev_err() message

 drivers/iio/proximity/sx9310.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 45569a0657060c..9636a3beabeb36 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -798,7 +798,7 @@ static const struct sx9310_reg_default sx9310_default_regs[] = {
 static int sx9310_init_compensation(struct iio_dev *indio_dev)
 {
 	struct sx9310_data *data = iio_priv(indio_dev);
-	int i, ret;
+	int ret;
 	unsigned int val;
 	unsigned int ctrl0;
 
@@ -812,22 +812,17 @@ static int sx9310_init_compensation(struct iio_dev *indio_dev)
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

