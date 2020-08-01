Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7530C2352A7
	for <lists+linux-iio@lfdr.de>; Sat,  1 Aug 2020 15:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgHANzT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Aug 2020 09:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbgHANzS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Aug 2020 09:55:18 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2D7C06174A
        for <linux-iio@vger.kernel.org>; Sat,  1 Aug 2020 06:55:18 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a5so20341985wrm.6
        for <linux-iio@vger.kernel.org>; Sat, 01 Aug 2020 06:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xksakG98Jh6UZslbGLGPyvID9dXYb3/p9C0EfVE2aII=;
        b=NfyezWKwiPkaLT1WPMriq3Qfm/bsAxVvle+3tNYwwfDNuUz+jhR98VnEKfKd89BnqX
         T0SbOnTJFW79B0lME0GpuIruRdhJFY8gKIf9Y/cabuEM4nOoi/9Jfx3GYqBoPamocmQG
         rj2RWdh2y7kFrywEMjvhVj4rVAlvpwLdx8JqjluRF33ZNgTs7t9zfCRH6fJT5iCdLmhS
         3A8lcHAFzW7VZdME+5sM2HdNExkZ0RRsStsmwVjcethrsDYvsZ/xKQ3fizBdYffKefeF
         2LzJV8NZ4LuZpXinOUk3UPdlCYFvGO1mqYhUwEQITxZA+I4ZKpJKkS0wSA3giz0ZMxcj
         8X+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xksakG98Jh6UZslbGLGPyvID9dXYb3/p9C0EfVE2aII=;
        b=nkJRzekv0ermM2mE83gkBFA37+6Djp0ITtkstaGUrvIwcfiX39peBv+/7KaZdmRtyh
         sHb5dSRS0dNWbLpmlNnCaQykjn2CJz8tp/1xa+Vh1Ou3OBMoI4LVM2v+MmCvWoxKPfAd
         bqb1B0MmoPaUdp7mwsXj9NDr/oTBfTZlU9NqP6HEXH3B68853lSDVtutT5GvH+InnRV3
         3Kw88hgFMvaz8LZDsWroOgqgwfh5jaA11BhI7nS6olzBa50HoNNPwlr2wUuIXxDUlOOo
         eevJ0xvCWVFfrLQzChq7bW8qanS3KBReZ0nqn+Fdm4Yyj09irNqNPMNaNEC0mLyd12ZE
         B1NA==
X-Gm-Message-State: AOAM531rjFUPlMILdIF9JXCV4OyCG/Fi/1fOzvUVRCfSneJABGT8xIqc
        o+631Z9EdxSdLVlvcHEmcMOhwHutvSc=
X-Google-Smtp-Source: ABdhPJwKpT65ITbXAbpk3TIvKooYqQtJUnaZukd5wEE8QUR9B4t+bKPhYfPUM/NO9aBhmNyBPTxYKQ==
X-Received: by 2002:adf:dd4f:: with SMTP id u15mr7652068wrm.275.1596290115254;
        Sat, 01 Aug 2020 06:55:15 -0700 (PDT)
Received: from localhost.localdomain (host185127036212.static.fidoka.tech. [185.127.36.212])
        by smtp.gmail.com with ESMTPSA id g25sm14901913wmh.35.2020.08.01.06.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2020 06:55:14 -0700 (PDT)
From:   Angelo Compagnucci <angelo.compagnucci@gmail.com>
X-Google-Original-From: Angelo Compagnucci <angelo@amarulasolutions.com>
To:     linux-iio@vger.kernel.org
Cc:     Angelo Compagnucci <angelo@amarulasolutions.com>,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>
Subject: [PATCH] iio: adc: mcp3422: fix locking scope
Date:   Sat,  1 Aug 2020 15:55:11 +0200
Message-Id: <20200801135511.342869-1-angelo@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Locking should be held for the entire reading sequence involving setting
the channel, waiting for the channel switch and reading from the
channel.
If not, reading from a channel can result mixing with the reading from
another channel.

Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>
---
 drivers/iio/adc/mcp3422.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
index d86c0b5d80a3..02a60fb164cd 100644
--- a/drivers/iio/adc/mcp3422.c
+++ b/drivers/iio/adc/mcp3422.c
@@ -96,16 +96,12 @@ static int mcp3422_update_config(struct mcp3422 *adc, u8 newconfig)
 {
 	int ret;
 
-	mutex_lock(&adc->lock);
-
 	ret = i2c_master_send(adc->i2c, &newconfig, 1);
 	if (ret > 0) {
 		adc->config = newconfig;
 		ret = 0;
 	}
 
-	mutex_unlock(&adc->lock);
-
 	return ret;
 }
 
@@ -138,6 +134,8 @@ static int mcp3422_read_channel(struct mcp3422 *adc,
 	u8 config;
 	u8 req_channel = channel->channel;
 
+	mutex_lock(&adc->lock);
+
 	if (req_channel != MCP3422_CHANNEL(adc->config)) {
 		config = adc->config;
 		config &= ~MCP3422_CHANNEL_MASK;
@@ -150,7 +148,11 @@ static int mcp3422_read_channel(struct mcp3422 *adc,
 		msleep(mcp3422_read_times[MCP3422_SAMPLE_RATE(adc->config)]);
 	}
 
-	return mcp3422_read(adc, value, &config);
+	ret = mcp3422_read(adc, value, &config);
+
+	mutex_unlock(&adc->lock);
+
+	return ret;
 }
 
 static int mcp3422_read_raw(struct iio_dev *iio,
-- 
2.25.1

