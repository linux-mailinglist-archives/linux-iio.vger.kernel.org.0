Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B86A019F84F
	for <lists+linux-iio@lfdr.de>; Mon,  6 Apr 2020 16:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbgDFOyI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Apr 2020 10:54:08 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33737 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728808AbgDFOyF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Apr 2020 10:54:05 -0400
Received: by mail-wr1-f67.google.com with SMTP id a25so17880292wrd.0;
        Mon, 06 Apr 2020 07:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1vU7BXQ3fVHMU/xSRZ2H0ygHz+MqpASoQp7308bMzBM=;
        b=mCg+e/wCwocjRzgkfcW0+e2g/lLd9IC3tQgUQlUk7MZ5uZykMUwRbCw4GFdj+Uuz//
         rQWIkS1U0zLXSS0+I4a/gjbTI5ZPT3D46apbzHGejjGuTiE3y4w1EACmw3ujpZWaaR67
         Zv0tQw1o1ducGZQFYxZKq2Uh34rnwBl4u31FVytDgoe2kcduZSLK/qGXSIyvjqS6gDut
         syqFltoboWGK5PoGTDyYARMhW4r0ZCtio/2FGkRBb4pneg3kjIMiz5BhLCMJ1hF8Ems9
         MgpZdb3B3K5Eh4R8aHtSXtKUmFW8ED43TGFxkHluZkML8tfoZ1l/HOoIGuyp/Ed6wHzb
         q1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1vU7BXQ3fVHMU/xSRZ2H0ygHz+MqpASoQp7308bMzBM=;
        b=GtF7RUqwXBHXqHdRd28KseMgjTKo3CDMxR1aYHAk9YhTk6nJBkAwP1V2econhOau0B
         UMvHeNyUddltHEJwU6Y4QJSLuzi7sHEme4naoxGS2a4TGdg5dKZ92mj0zFPjeKfP1tzO
         if5xfrh0QzUxcBXNG2iAAkanRSNTXp2vdf0AHpbo2V64IyFNrWOAh83oU6bNUqZKUAcy
         l0diGpK8s/W4CbKHaRhF6eUFHx2UYPKNQ9RltpK4BNqqQR4CRW34/BSBQs6BcBay3ovY
         9ZVLUf/DhWmA1yfJJIr+pEIMCHQVH/SSGC4Jbezd8HlWAt4RZaZbYLVKMj6cFt8jE2wY
         vR2A==
X-Gm-Message-State: AGi0PuaHTly8vhj6L6lVGx5yq/6zhTCs7QfM3pKL/dKkCHRZ9LE690HR
        +eRvR1qh9Qorwk9JFTpypUXCBkFgsI99Nw==
X-Google-Smtp-Source: APiQypLl9RqSy6iQHAlEXTn7+kzlPvQwWdJhWhozBcZv+UxtfTaTEH8GjO7QLKko6QJd/2OnyXKTNw==
X-Received: by 2002:a05:6000:12c5:: with SMTP id l5mr23040146wrx.134.1586184843862;
        Mon, 06 Apr 2020 07:54:03 -0700 (PDT)
Received: from meru.fronius.com ([2a01:cb18:832e:5f00:586b:b940:d2f2:e882])
        by smtp.gmail.com with ESMTPSA id d7sm26382914wrr.77.2020.04.06.07.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 07:54:03 -0700 (PDT)
From:   Mathieu Othacehe <m.othacehe@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: [PATCH v2 1/4] iio: vcnl4000: Factorize data reading and writing.
Date:   Mon,  6 Apr 2020 16:53:53 +0200
Message-Id: <20200406145356.25883-2-m.othacehe@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200406145356.25883-1-m.othacehe@gmail.com>
References: <20200406145356.25883-1-m.othacehe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Factorize data reading in vcnl4000_measure into a vcnl4000_read_block_data
function. Use it to provide a vcnl4000_read_data function that is able to
read sensor data under lock. Also add a vcnl4000_write_data function.

Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>
---
 drivers/iio/light/vcnl4000.c | 54 +++++++++++++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index e5b00a6611ac..c95b89740dfa 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -189,11 +189,59 @@ static int vcnl4200_init(struct vcnl4000_data *data)
 	return 0;
 };
 
+static int vcnl4000_read_block_data(struct vcnl4000_data *data, u8 data_reg,
+				    int *val)
+{
+	__be16 buf;
+	int ret;
+
+	ret = i2c_smbus_read_i2c_block_data(data->client,
+		data_reg, sizeof(buf), (u8 *) &buf);
+	if (ret < 0)
+		goto end;
+
+	*val = be16_to_cpu(buf);
+end:
+	return ret;
+}
+
+static int vcnl4000_read_data(struct vcnl4000_data *data, u8 data_reg,
+			      int *val)
+{
+	int ret;
+
+	mutex_lock(&data->vcnl4000_lock);
+	ret = vcnl4000_read_block_data(data, data_reg, val);
+	mutex_unlock(&data->vcnl4000_lock);
+
+	return ret;
+}
+
+static int vcnl4000_write_data(struct vcnl4000_data *data, u8 data_reg,
+			       u16 val)
+{
+	int ret;
+
+	if (val > U16_MAX)
+		return -ERANGE;
+
+	mutex_lock(&data->vcnl4000_lock);
+
+	ret = i2c_smbus_write_byte_data(data->client, data_reg, val >> 8);
+	if (ret < 0)
+		goto end;
+
+	ret = i2c_smbus_write_byte_data(data->client, data_reg + 1, val);
+end:
+	mutex_unlock(&data->vcnl4000_lock);
+
+	return ret;
+}
+
 static int vcnl4000_measure(struct vcnl4000_data *data, u8 req_mask,
 				u8 rdy_mask, u8 data_reg, int *val)
 {
 	int tries = 20;
-	__be16 buf;
 	int ret;
 
 	mutex_lock(&data->vcnl4000_lock);
@@ -220,13 +268,11 @@ static int vcnl4000_measure(struct vcnl4000_data *data, u8 req_mask,
 		goto fail;
 	}
 
-	ret = i2c_smbus_read_i2c_block_data(data->client,
-		data_reg, sizeof(buf), (u8 *) &buf);
+	ret = vcnl4000_read_block_data(data, data_reg, val);
 	if (ret < 0)
 		goto fail;
 
 	mutex_unlock(&data->vcnl4000_lock);
-	*val = be16_to_cpu(buf);
 
 	return 0;
 
-- 
2.26.0

