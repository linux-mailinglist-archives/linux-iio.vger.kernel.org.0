Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 042651C2AEB
	for <lists+linux-iio@lfdr.de>; Sun,  3 May 2020 11:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgECJcX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 May 2020 05:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726445AbgECJcW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 3 May 2020 05:32:22 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B66EC061A0C;
        Sun,  3 May 2020 02:32:22 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k1so17250650wrx.4;
        Sun, 03 May 2020 02:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1K9HR6HwCf2nmSwUHn99KqNtbjn4Ac+2ymZ0fApUQkA=;
        b=aDzrCnl9cM0RFHjgLgy7hzS/vXj0mVa93H1A6hwYw6mGdnv+o6KWbqhE98L1gSA/Wm
         aeqeFhx070MpCze4t73nFhL9Skuc28zAq/9Za/pWTeggYHokEy7H6pZ18nsgs2C0ajN2
         79w58jdcpq9pH8tgSD74Rs2/1F00dNCvC6hXDKFtHss07qVvnfUi3m/rnj5RQAQtbIPy
         uSXWPx2r1Pv2FDZa5rAA6qnqvqm4fz7MrtfdM+QL4N0xKzsnsRQhbpLiO6UqscMY5b/4
         55JXA1BR+rEcD5FU/kBS61DlN1VEm+IDThKRIBCV3pDr38C1gX256L8YT02/kX9Mc/JS
         97Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1K9HR6HwCf2nmSwUHn99KqNtbjn4Ac+2ymZ0fApUQkA=;
        b=H6PKOOW7+vi9z/2Kc6uPy/nKgv9ze0HmAo84+2sm1par3DrNFsLNNWRkH2G/NiwblU
         qTqSJBafe3O9f1TFKyvzab4ewwLoGu0GDOSsUZTqUOQh2jSvFhCKHdWskEvyzKSObRzp
         tXrvo6wQN2gh52NVTBpK3OKaSC4Lt3Z4+1OsFQ7QlvfOiRoEmJXdfPyuie+RDlroKPXN
         6vw+UwLwQOe3RyxmeNjLZuLZshGvCo0m4M7dSIoW28C5KgkhkJm9wFeqh45IqkSvoEVq
         SVnTlmcRTfQUy8oSwfw6WPYjgLQNt4ml4D6eY9z7L/W7oX5XGdjgZivXpcqhK+UQXGC5
         i7ww==
X-Gm-Message-State: AGi0PubXvo2psabTgdMEDLYKJCSjQpt64N4CQ6/VhyMCgmiit/snEqqk
        r6acuIYVHfH52lAK6flkCHw=
X-Google-Smtp-Source: APiQypIfyLJDZgGDr+HA9z/9rXC+SekElfLYRJr49aOJixfzPQUmimy9yyFbT96vtyyoiSU7nSTUsQ==
X-Received: by 2002:a5d:5273:: with SMTP id l19mr13196617wrc.42.1588498340795;
        Sun, 03 May 2020 02:32:20 -0700 (PDT)
Received: from meru.home ([2a01:cb18:832e:5f00:1cf0:acc0:9003:83d6])
        by smtp.gmail.com with ESMTPSA id e17sm10086963wrr.32.2020.05.03.02.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 02:32:20 -0700 (PDT)
From:   Mathieu Othacehe <m.othacehe@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: [PATCH v7 1/5] iio: vcnl4000: Fix i2c swapped word reading.
Date:   Sun,  3 May 2020 11:29:55 +0200
Message-Id: <20200503092959.8806-2-m.othacehe@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200503092959.8806-1-m.othacehe@gmail.com>
References: <20200503092959.8806-1-m.othacehe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The bytes returned by the i2c reading need to be swapped
unconditionally. Otherwise, on be16 platforms, an incorrect value will be
returned.

Fixes: 62a1efb9f868 ("iio: add vcnl4000 combined ALS and proximity sensor")
Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>
---
 drivers/iio/light/vcnl4000.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 58e97462e803..e5f86bd00fb0 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -219,7 +219,6 @@ static int vcnl4000_measure(struct vcnl4000_data *data, u8 req_mask,
 				u8 rdy_mask, u8 data_reg, int *val)
 {
 	int tries = 20;
-	__be16 buf;
 	int ret;
 
 	mutex_lock(&data->vcnl4000_lock);
@@ -246,13 +245,12 @@ static int vcnl4000_measure(struct vcnl4000_data *data, u8 req_mask,
 		goto fail;
 	}
 
-	ret = i2c_smbus_read_i2c_block_data(data->client,
-		data_reg, sizeof(buf), (u8 *) &buf);
+	ret = i2c_smbus_read_word_swapped(data->client, data_reg);
 	if (ret < 0)
 		goto fail;
 
 	mutex_unlock(&data->vcnl4000_lock);
-	*val = be16_to_cpu(buf);
+	*val = ret;
 
 	return 0;
 
-- 
2.26.0

