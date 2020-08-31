Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB852579DF
	for <lists+linux-iio@lfdr.de>; Mon, 31 Aug 2020 15:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgHaNAA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 Aug 2020 09:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbgHaM74 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 31 Aug 2020 08:59:56 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C57C061573
        for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2020 05:59:55 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id c10so5336304edk.6
        for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2020 05:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pl1+yfv1y+NwjXUNFwiqFKnssjS9HTfrfVCZG150aus=;
        b=laphm0kk0lm6t4DkAy7Bd12R/Ta7KHzV06F75B+Ej6wR9cRJQF209fwuyPwn0P+oQH
         Uv0j4u8nqJd3DTpf9lCsM9tzgN1pCnVgt3pqvKvO9fY4cXt3Kq/35fHT1zamoBNkiEVl
         nYkuVDwGHpHV31FwgesSW/MTDCM1vZXtMsIIoPuvS711Zef0xJHCgA1HbsoMieiagJM3
         eZi4mFWKF3NGums43LZXhoT5yDTPd8t0NQ8d3Ge4UoTSM4Ax3vVaqfRfYUxUAXKixzbh
         B5DuXppQ3S6pvsVD2mR7wgQbOKb2WTAkk8ltE0dzMdYhQ6en4/BS1a5NkelQNnAO2Cm1
         VhQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pl1+yfv1y+NwjXUNFwiqFKnssjS9HTfrfVCZG150aus=;
        b=uDCWRur2yi+1eEsaVLQgfMTC0HC9+exfg/mBUX/gFIjl6HBe1YhApTwgmSRCXWxHR4
         KNY4uA/z5G3qNmQ/j0DcrLh5p9nx9HKYRkUwI97w2Cp1tvREkeh0FS17KOwPXaG2GsKj
         oC4KQrMLCeVUC3IYlenVbIezFZ+96/l4VNM0bCxa2KpuCMrssiBgk76dhszVk4N4jSl5
         +uKDm4G8xhTEWeMYHWaYKNPp9JQHnODJ/+cVKAhRTGHkvSkX7pTerpssMiC9Do+lGzmD
         N/xtFHnC33drH6HqjEdo01rBPC/SUD2V4+ay1IHM61P1UhP2cb5mojsLm3VIPZXur01F
         KuUQ==
X-Gm-Message-State: AOAM533WBmvLh8BtLHFBooa4ASYhwpyRjmf18755oUdCSs41il626+mv
        14pcX/czNGLdtbfFchZcz+GknZwYipfV6w==
X-Google-Smtp-Source: ABdhPJx4cORlOAVThvkXcZ4uCEcy1Lmav0L8bedp/WV7O0NYvtiyoNEw4apsDuER1IOyXd9XCc2LUg==
X-Received: by 2002:a05:6402:d07:: with SMTP id eb7mr1215207edb.160.1598878793594;
        Mon, 31 Aug 2020 05:59:53 -0700 (PDT)
Received: from localhost.localdomain (host085115198017.static.fidoka.tech. [85.115.198.17])
        by smtp.gmail.com with ESMTPSA id w20sm8172878ejc.77.2020.08.31.05.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 05:59:52 -0700 (PDT)
From:   Angelo Compagnucci <angelo.compagnucci@gmail.com>
X-Google-Original-From: Angelo Compagnucci <angelo@amarulasolutions.com>
To:     linux-iio@vger.kernel.org
Cc:     Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        Angelo Compagnucci <angelo@amarulasolutions.com>
Subject: [PATCH v3] iio: adc: mcp3422: fix locking scope
Date:   Mon, 31 Aug 2020 14:59:47 +0200
Message-Id: <20200831125947.74824-1-angelo@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Angelo Compagnucci <angelo.compagnucci@gmail.com>

Locking should be held for the entire reading sequence involving setting
the channel, waiting for the channel switch and reading from the
channel.
If not, reading from a channel can result mixing with the reading from
another channel.

Fixes: 07914c84ba30 ("iio: adc: Add driver for Microchip MCP3422/3/4 high resolution ADC")
Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>
Signed-off-by: Angelo Compagnucci <angelo@amarulasolutions.com>
---
 drivers/iio/adc/mcp3422.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
index d86c0b5d80a3..f96f0cecbcde 100644
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
@@ -145,12 +143,18 @@ static int mcp3422_read_channel(struct mcp3422 *adc,
 		config &= ~MCP3422_PGA_MASK;
 		config |= MCP3422_PGA_VALUE(adc->pga[req_channel]);
 		ret = mcp3422_update_config(adc, config);
-		if (ret < 0)
+		if (ret < 0) {
+			mutex_unlock(&adc->lock);
 			return ret;
+		}
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

