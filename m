Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53DAD1B2076
	for <lists+linux-iio@lfdr.de>; Tue, 21 Apr 2020 09:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbgDUHzp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Apr 2020 03:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728261AbgDUHzm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Apr 2020 03:55:42 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B861CC061A0F;
        Tue, 21 Apr 2020 00:55:41 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f13so15290138wrm.13;
        Tue, 21 Apr 2020 00:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o8ZYjk3I5HUzOWotVnd0+m+B88M3hyy1mHjXl9WA6sE=;
        b=u5uuKYhZQUAbXG08+ryOgldwFlo7l9hFtEjLupf2p5XUXKMH0ikRBZ/rrDQodbS8fz
         DbrcrcJl9avb97wqaZQLDIDPeQ28J9xMHnwHhk5ah94lvRF0r9zJDao4bZwzi1C/1a6S
         YNJ6VezgY62/8uxeQ3sLN8f/w+IkMm3L8mA++ZtuuH9s0JiNSsZXMVtsriNICRPorm2d
         LEKLj1AMkjgoq5qOuR63nyjObaiy7l05Rq7kh8ip+72D7ByF90gPg/6BKcumjFXat4sr
         kJ7sQw4U0pdnKzeCILMD4F1D2jpcMggLQwwzrMWw/eHbhVByWvI0/zj38TCZa4Jpk56Q
         rVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o8ZYjk3I5HUzOWotVnd0+m+B88M3hyy1mHjXl9WA6sE=;
        b=OEUAjHof19B9RfuCikKD8Eg9oJpx73hsj4MKhg0PBQW2DyysJjyYsC4ZPFO/4idZ4K
         jn23x5aAQjfNzn8fOzC8T6cLoCfz6yZiN4qtmqtMCBF7dQZgOQQ7vL+TMASh9P2BMRM1
         017WG8lCcnLDH38VrobxJOg4h2eFV2JY/mhU+9rAWrICUrq3EV0gKQfBqtmjnvWC7qRp
         pzPpbsakpw2qpcUp7FZ3phtIvLWRScHpVgtWoaYnGtBVskGE1plCFZ1oUSiowHsBZq6g
         4mM1ymiaKXSRn18cy8/Moqdlo2RChDKEk6MzJL8iylRM6KHmjwB+clUGbm1hslEf6UOc
         tnIg==
X-Gm-Message-State: AGi0PuZyPF0r1JsHwhgzYnLxiG0lMBPKhqB8KVvltiIj5RJ+yb4+k5ON
        kdmbeFFm5CXLxKRAAR61dZo=
X-Google-Smtp-Source: APiQypIrTJf2QqENfxr7sS9N0AXX9fL7GjMLPMCa7fPYANOUtS9UnWouBFn/vLZgMcUR7KXa7jy0+w==
X-Received: by 2002:adf:ee88:: with SMTP id b8mr21941119wro.93.1587455740528;
        Tue, 21 Apr 2020 00:55:40 -0700 (PDT)
Received: from meru.fronius.com ([2a01:cb18:832e:5f00:f9a2:4:b043:a3fb])
        by smtp.gmail.com with ESMTPSA id c190sm2514510wme.10.2020.04.21.00.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 00:55:39 -0700 (PDT)
From:   Mathieu Othacehe <m.othacehe@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: [PATCH v4 1/4] iio: vcnl4000: Factorize data reading and writing.
Date:   Tue, 21 Apr 2020 09:55:29 +0200
Message-Id: <20200421075532.19192-2-m.othacehe@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200421075532.19192-1-m.othacehe@gmail.com>
References: <20200421075532.19192-1-m.othacehe@gmail.com>
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

