Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4BB1B45E7
	for <lists+linux-iio@lfdr.de>; Wed, 22 Apr 2020 15:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgDVNJK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Apr 2020 09:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgDVNJI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Apr 2020 09:09:08 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79502C03C1A9;
        Wed, 22 Apr 2020 06:09:08 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id u127so2296494wmg.1;
        Wed, 22 Apr 2020 06:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o8ZYjk3I5HUzOWotVnd0+m+B88M3hyy1mHjXl9WA6sE=;
        b=hK+ks0m1mz5ue1YKIErT7o3rOfCS1EuBrtA5xlzhOf3ZWXKvueUPSUzTL8yDEgNZ68
         JEwczI7+bw+PAS0Jx06/zbLwURBK5gxwQAHdtvUar+aQR4Gfdjh1nselM8ZzczQafAMP
         Erp5ITRMLwNV7fdJxcQnBcYHHWI8gaowt98d34RouN5a20ujzv4+pnSv5II6JShCB/B+
         u5eeS5JKGWD/bMCKGBd7HyaGtWRLM9d0UN74BiaVughzXZx2ysySWWsr8e6+JPElrrda
         +0ecFlnuf0r4r/2cLijdEs36prNwd5Pyw4etsgYR3/T/1NEAc4/UXGgFhr80oki5qLvs
         4o9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o8ZYjk3I5HUzOWotVnd0+m+B88M3hyy1mHjXl9WA6sE=;
        b=H2CCIeQcaDAtBFolKa/Aw1dIoi3zIbIKLc5hsLJekNpScZTeIb57o4wloP1/s7TuT9
         ZRFv87anyl72vA1G4KISJsw97YbJpLMSbXubrp2zWDjwjLFCqDqcgyPljO6ZNI60EgZn
         l7AAyVKV02zQd/Ged10sbxOd7yk2JQadeIxGyGslMqjAoqLkgzua1xiKjoXfgM2y7VrR
         FeNCvSH5iMyd11gkYNZZw8QKg0yXyN1bveea4RRRrbw+N6wk1vgcCLLI5on03RPBQTXx
         i3ZLhBMA4WtSG/LRVhOvwFGJg+dJPYmYLqGKbf7M+y/v0xWk81x2pcdkC5M6JDsJ5Cr8
         0lJQ==
X-Gm-Message-State: AGi0Pua8iTjSO61rzfGStdU3aC1TYThWBGoHhyf2z6igONRAD7WOKvel
        6b/EI8GNaFOZbtnqXFwYx4U=
X-Google-Smtp-Source: APiQypLU8MGH0X0UdQ0rgRUyTEa3dUIF6jOnxmfpxOM7YDxUeHveBspOUUyr6TyVfxz+c1dnApX+VQ==
X-Received: by 2002:a7b:c147:: with SMTP id z7mr11227951wmi.52.1587560947204;
        Wed, 22 Apr 2020 06:09:07 -0700 (PDT)
Received: from meru.fronius.com ([2a01:cb18:832e:5f00:8872:7e71:5cf6:8a5b])
        by smtp.gmail.com with ESMTPSA id o3sm2064820wru.68.2020.04.22.06.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 06:09:06 -0700 (PDT)
From:   Mathieu Othacehe <m.othacehe@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: [PATCH v5 1/4] iio: vcnl4000: Factorize data reading and writing.
Date:   Wed, 22 Apr 2020 15:08:53 +0200
Message-Id: <20200422130856.1722-2-m.othacehe@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200422130856.1722-1-m.othacehe@gmail.com>
References: <20200422130856.1722-1-m.othacehe@gmail.com>
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
 drivers/iio/light/vcnl4000.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 58e97462e803..695a81e95d8d 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -215,11 +215,34 @@ static int vcnl4200_init(struct vcnl4000_data *data)
 	return 0;
 };
 
+static int vcnl4000_read_data(struct vcnl4000_data *data, u8 data_reg, int *val)
+{
+	s32 ret;
+
+	ret = i2c_smbus_read_word_data(data->client, data_reg);
+	if (ret < 0)
+		return ret;
+
+	*val = be16_to_cpu(ret);
+	return 0;
+}
+
+static int vcnl4000_write_data(struct vcnl4000_data *data, u8 data_reg, int val)
+{
+	__be16 be_val;
+
+	if (val > U16_MAX)
+		return -ERANGE;
+
+	be_val = cpu_to_be16(val);
+	return i2c_smbus_write_word_data(data->client, data_reg, be_val);
+}
+
+
 static int vcnl4000_measure(struct vcnl4000_data *data, u8 req_mask,
 				u8 rdy_mask, u8 data_reg, int *val)
 {
 	int tries = 20;
-	__be16 buf;
 	int ret;
 
 	mutex_lock(&data->vcnl4000_lock);
@@ -246,13 +269,11 @@ static int vcnl4000_measure(struct vcnl4000_data *data, u8 req_mask,
 		goto fail;
 	}
 
-	ret = i2c_smbus_read_i2c_block_data(data->client,
-		data_reg, sizeof(buf), (u8 *) &buf);
+	ret = vcnl4000_read_data(data, data_reg, val);
 	if (ret < 0)
 		goto fail;
 
 	mutex_unlock(&data->vcnl4000_lock);
-	*val = be16_to_cpu(buf);
 
 	return 0;
 
-- 
2.26.0

