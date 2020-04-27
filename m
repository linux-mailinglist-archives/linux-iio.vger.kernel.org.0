Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF93F1BA07F
	for <lists+linux-iio@lfdr.de>; Mon, 27 Apr 2020 11:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgD0J4O (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Apr 2020 05:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726963AbgD0J4M (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Apr 2020 05:56:12 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75836C0610D6;
        Mon, 27 Apr 2020 02:56:11 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id v8so15542610wma.0;
        Mon, 27 Apr 2020 02:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j/mmHt22K1/kkx3UEk6NpFmo2AhOraXdCBC9rYucPjU=;
        b=AANPMA6LxlpwWtWQyR4uvVjOkr8aUNcCKIy6PsctAHFwGloLajHRC8Avq4Iy2hiAu3
         JstDKTg0DZZYO1/UdnyR0OlIq7OdSvlo/C4LtwMiYmFH1pHcJPOSpwRm50tC/2EjD3+1
         vYTMkIWrX5YZJpiM88woKo6fDznBqafOCexDD8v7BR2wccP7TiuLtoOUDPgjviJ6FH9d
         Zq78J/z2sW01BtWbMdaSHR5EHReEV5LZwK1HfzmzGoe7rHgthuxSS6ngL9UrTyw8UHPu
         ylo1zfyHu/jPPglTpjS0tXQ3yCP1dSYEDkjV9Qru6+bZgNUqhGGLzrB3HhjD6QjCI4oB
         uWDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j/mmHt22K1/kkx3UEk6NpFmo2AhOraXdCBC9rYucPjU=;
        b=HkYYzCrssuBAURTkSmJgfOx5TEnU/K11xYAPfLy7GbfZWMdObZWnCI8bzXFv+caJb+
         c0deADVcADMDrD7KWlhrURT6NN+9JMjk8+s9B3mwB0Xy9MZ83EPcwwYKVwLEuBNgYgIn
         GKQXBwQtNYMgxqA1snZ7btgRQeUujbDT/UL3YxWA0mn/LtfCvXPDRpOKhxOfQlQstFr6
         1BPuToq7/yVoji9/ujGDIAi1WHKjcGZ2C6PmPQdLndNhmHIPLLBGyG7CW7uDX2n7u0Fc
         xS+S0doUKfg4klmPr5bLfeasIBH/f/vceXI1DO5IMpgooRAUrYxxaQvfJGnzQNyOuiBe
         WYPQ==
X-Gm-Message-State: AGi0PuaIhN4fwyFLu83VCf01iy5kBE8v8HsNr5gaTlkpGR3Kdkv2WyZe
        0PYRLkxct0EVLLonLzDKmXc=
X-Google-Smtp-Source: APiQypJTSOUzkahAN9OB7zdXtuaZk+o5/d2WMSbC1wIdks/3DwWZgjF81xw3r0A2CrN7TvaPe5q0ug==
X-Received: by 2002:a7b:c0d5:: with SMTP id s21mr25257317wmh.107.1587981370041;
        Mon, 27 Apr 2020 02:56:10 -0700 (PDT)
Received: from meru.fronius.com ([2a01:cb18:832e:5f00:7069:9b5d:ebe2:85b8])
        by smtp.gmail.com with ESMTPSA id y10sm14487606wma.5.2020.04.27.02.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 02:56:09 -0700 (PDT)
From:   Mathieu Othacehe <m.othacehe@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: [PATCH v6 2/5] iio: vcnl4000: Factorize data reading and writing.
Date:   Mon, 27 Apr 2020 11:55:56 +0200
Message-Id: <20200427095559.16131-3-m.othacehe@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200427095559.16131-1-m.othacehe@gmail.com>
References: <20200427095559.16131-1-m.othacehe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Factorize data reading in vcnl4000_measure into a vcnl4000_read_data
function. Also add a vcnl4000_write_data function.

Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>
---
 drivers/iio/light/vcnl4000.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index e5f86bd00fb0..b976e29f2fda 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -215,6 +215,27 @@ static int vcnl4200_init(struct vcnl4000_data *data)
 	return 0;
 };
 
+static int vcnl4000_read_data(struct vcnl4000_data *data, u8 data_reg, int *val)
+{
+	s32 ret;
+
+	ret = i2c_smbus_read_word_swapped(data->client, data_reg);
+	if (ret < 0)
+		return ret;
+
+	*val = ret;
+	return 0;
+}
+
+static int vcnl4000_write_data(struct vcnl4000_data *data, u8 data_reg, int val)
+{
+	if (val > U16_MAX)
+		return -ERANGE;
+
+	return i2c_smbus_write_word_swapped(data->client, data_reg, val);
+}
+
+
 static int vcnl4000_measure(struct vcnl4000_data *data, u8 req_mask,
 				u8 rdy_mask, u8 data_reg, int *val)
 {
@@ -245,12 +266,11 @@ static int vcnl4000_measure(struct vcnl4000_data *data, u8 req_mask,
 		goto fail;
 	}
 
-	ret = i2c_smbus_read_word_swapped(data->client, data_reg);
+	ret = vcnl4000_read_data(data, data_reg, val);
 	if (ret < 0)
 		goto fail;
 
 	mutex_unlock(&data->vcnl4000_lock);
-	*val = ret;
 
 	return 0;
 
-- 
2.26.0

