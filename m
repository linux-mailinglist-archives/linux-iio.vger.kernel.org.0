Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46DDB230D44
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jul 2020 17:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730691AbgG1PNh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jul 2020 11:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730776AbgG1PNZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2020 11:13:25 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B042FC0619D4
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 08:13:25 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id q75so12953658iod.1
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 08:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dBdydSoMKXmEdaffi7O9O0wgF/TEt9JKgR6178mXM9M=;
        b=ZDN3H2FXLdJTJyyOyKwo1UsyPtVLwiflwAGYLEHP/VTYvYZwDPVoAND8SEDKbuMOBe
         /+ROVE9tP8bVAdijZ/I0/wUIi9zI2+N0ZbjYuY60iGCnPjy9A1P2eEJpF3yPtjtnP+dX
         nktogQjb/VN6LlP4kfLf64RXYmfmo4J5gjieo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dBdydSoMKXmEdaffi7O9O0wgF/TEt9JKgR6178mXM9M=;
        b=Bl5kQwfmDu/g5Qfn2mzdh7ss4b3EOEr3CLDU+gaUG/BqT1fvNuVHrzHCHStFAylBl4
         Kom0fKWh6761IOITYxGlQ+xvJq5Vs7wHESQ/BQAqf35HzB6KVXLskRFsIJWn8LmbvcBh
         qvi9Bivmt3v9hWfxhSK9469aFp3uDnMKoOalCjZw9C2Bd+sJRIqYZn0ubfg/PwC6Qy0k
         IHshINsugONjtsCtfoXx7ZI93RfRrb3jB7yrS0HcvNLGZU8V8j2849ST9b0zhs4Bbv1s
         Y/u8rgEz1GxP0VUhLjFV7uI60foVOIxgyCfYxPJrLDo6V3G/ZPWnweV2ThgVe4Z1tfcD
         5pXw==
X-Gm-Message-State: AOAM533kpl3nKtWKBtCSUlU6Zx2ERgOy++rqY9Qfuvq5JY0hKo3zrXLV
        Nh0jU3I3DkDbhYqhN+3DiBtS4A==
X-Google-Smtp-Source: ABdhPJxheG4noLBhnCh3S2+F/84pEFZ4uw6a7eN1qHSiQ8i19vDcXpxohLRyRyn6LT+vAZgHpbzNBg==
X-Received: by 2002:a02:6d07:: with SMTP id m7mr2381002jac.140.1595949205135;
        Tue, 28 Jul 2020 08:13:25 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id q70sm6399781ili.49.2020.07.28.08.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 08:13:24 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Daniel Campello <campello@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [PATCH 13/15] iio: sx9310: Add newlines to printks
Date:   Tue, 28 Jul 2020 09:12:56 -0600
Message-Id: <20200728091057.13.I14600506d0f725bf800c8da4ef89fdb3c3fb45cd@changeid>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
In-Reply-To: <20200728151258.1222876-1-campello@chromium.org>
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid>
 <20200728151258.1222876-1-campello@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Stephen Boyd <swboyd@chromium.org>

Printks in the kernel have newlines at the end. Add them to the few
printks in this driver.

Reviewed-by: Daniel Campello <campello@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Fixes: 72ad02b15d63 ("iio: Add SEMTECH SX9310/9311 sensor driver")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Daniel Campello <campello@chromium.org>
---

 drivers/iio/proximity/sx9310.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 3f981d28ee4056..4553ee83a016a3 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -809,7 +809,7 @@ static int sx9310_init_compensation(struct iio_dev *indio_dev)
 	if (ret) {
 		if (ret == -ETIMEDOUT)
 			dev_err(&data->client->dev,
-				"0x02 << 3l compensation timed out: 0x%02x",
+				"0x02 << 3l compensation timed out: 0x%02x\n",
 				val);
 		return ret;
 	}
@@ -855,7 +855,7 @@ static int sx9310_set_indio_dev_name(struct device *dev,
 
 	ddata = (uintptr_t)device_get_match_data(dev);
 	if (ddata != whoami) {
-		dev_err(dev, "WHOAMI does not match device data: %u", whoami);
+		dev_err(dev, "WHOAMI does not match device data: %u\n", whoami);
 		return -ENODEV;
 	}
 
@@ -867,7 +867,7 @@ static int sx9310_set_indio_dev_name(struct device *dev,
 		indio_dev->name = "sx9311";
 		break;
 	default:
-		dev_err(dev, "unexpected WHOAMI response: %u", whoami);
+		dev_err(dev, "unexpected WHOAMI response: %u\n", whoami);
 		return -ENODEV;
 	}
 
@@ -896,7 +896,7 @@ static int sx9310_probe(struct i2c_client *client)
 
 	ret = regmap_read(data->regmap, SX9310_REG_WHOAMI, &data->whoami);
 	if (ret) {
-		dev_err(dev, "error in reading WHOAMI register: %d", ret);
+		dev_err(dev, "error in reading WHOAMI register: %d\n", ret);
 		return ret;
 	}
 
-- 
2.28.0.rc0.142.g3c755180ce-goog

