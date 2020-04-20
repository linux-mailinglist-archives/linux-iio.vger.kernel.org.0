Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 139451B04AB
	for <lists+linux-iio@lfdr.de>; Mon, 20 Apr 2020 10:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgDTInI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Apr 2020 04:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgDTInG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Apr 2020 04:43:06 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC23AC061A0C;
        Mon, 20 Apr 2020 01:43:05 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u127so9257251wmg.1;
        Mon, 20 Apr 2020 01:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cstlwMnv04bCAHAUWWMKPZPu8D6vNJH5eQWWNxXZ+kY=;
        b=YRFFtVzR23Te8fPlBGabzsOHXKO3hc9hmTck76fLXWQx0d4ShUfg9cUIdIb9tP1ymq
         wr+zp+WuuQfio4iFM+FMvYIJpu2mrA+wTYQjRYXICUG9+qSXIvBGGzqPjyX1rK5yWece
         1jkd5BPZ4NICEN1a/u1ZaZ8W+RbtYdDLbg9GGiZqP1B78GdsUZ1zSohWp0IE8+iV+l1d
         nHg4O6rExDHLfNQ4FIlWL5b/8QsC+wJf7GDZK5pWHnesrT7jNoOFfiVCXPoocCg2BZeW
         aCVpuOxbq/xkd09MAFNm1vwZ6O55H2qPtIwEf1dBaKTx1G1NBAOStXD32X/sqXC5o4Mr
         hFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cstlwMnv04bCAHAUWWMKPZPu8D6vNJH5eQWWNxXZ+kY=;
        b=DzL7GRR9grw/csohjIPYHqILe7OIY2fzZqGKspBLScmZyRTxdygm9Fo4nnBX9swIJp
         6mtOSbVg8r5BCw3n8BrIV5gG7eR7Z83ANERI4U/X/RCFAXeowzhvseMcDsA85L5Sw5qr
         FdE6JIF/grPhwquw6gzO8Cwi4JwNb7CucPwi05dVctOszoSGwqRxSMq0ft4EU9UKx2Vc
         cO7UfOIZYpgJdeKrgqlg/7bH8UprW5PqrBazwrfPC7b3aN3gwPfwa/Ntcbfe7Lg9LTDE
         +P4f1W6fYUnYtez+cl/MBYWjMEgjftlUKM5XTF1ZjzUvbzcjfSiM5/pEhuGD6fIpSNfe
         ZQPw==
X-Gm-Message-State: AGi0PuYpMZ2t4AaMzTdn2pKZBcp/kjorndrJtrvbv2s+rK+7zwwoX2b3
        B+PAdDAtGmUTqh6D7azNA7M=
X-Google-Smtp-Source: APiQypJDecjrn9dj/VhY70rgPUjJk2qIZoKqw01otESw2M+3XlcgKgTMavdjBuvf0v7hJhA3f2+2FQ==
X-Received: by 2002:a1c:9e52:: with SMTP id h79mr10552838wme.84.1587372184615;
        Mon, 20 Apr 2020 01:43:04 -0700 (PDT)
Received: from meru.fronius.com ([2a01:cb18:832e:5f00:c546:5ea:178b:4074])
        by smtp.gmail.com with ESMTPSA id g74sm403183wme.44.2020.04.20.01.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 01:43:04 -0700 (PDT)
From:   Mathieu Othacehe <m.othacehe@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: [PATCH v3 1/4] iio: vcnl4000: Factorize data reading and writing.
Date:   Mon, 20 Apr 2020 10:42:07 +0200
Message-Id: <20200420084210.14245-2-m.othacehe@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200420084210.14245-1-m.othacehe@gmail.com>
References: <20200420084210.14245-1-m.othacehe@gmail.com>
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
index 58e97462e803..4e87d2cf1100 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -215,11 +215,59 @@ static int vcnl4200_init(struct vcnl4000_data *data)
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
@@ -246,13 +294,11 @@ static int vcnl4000_measure(struct vcnl4000_data *data, u8 req_mask,
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

