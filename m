Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29325B5E61
	for <lists+linux-iio@lfdr.de>; Wed, 18 Sep 2019 09:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbfIRHxr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Sep 2019 03:53:47 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43061 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfIRHxq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Sep 2019 03:53:46 -0400
Received: by mail-pf1-f194.google.com with SMTP id a2so3815256pfo.10;
        Wed, 18 Sep 2019 00:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wv4la6Y6FsJg+2v49trmGgdAwNGUcPB7OMZV54Bj2EQ=;
        b=gBsEGCLIoG9yZOLSPABp5DkqpxUM9VPF+gft6+M58mitntGiBP2B8ZmrdxOFtVQXbn
         Ri3QHHyEmNUfyQSyX52qq4D7m9tZmGEhy7E12ATGIl8xUL2fdr6MQC7B7UgLocy3qRN2
         zKvq2O6kUZNUZUjYg9ZTnJLo1cAZ3DagU2gA6jbq1mM9d7b8TS+CBxCYv73a21JsSweL
         YgDq8thCF1g0TVAs5oSjbcIWdTfUOK6BABgoT/pslldal2AWK0yke8OqcUmbkyBbntit
         /xJdKQ99zJ/XgOU8AdprPj5kAjHHpD7e2Vrr4WeHEetM6hB5L+So+ClfGNokdxjz5+Vw
         UwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wv4la6Y6FsJg+2v49trmGgdAwNGUcPB7OMZV54Bj2EQ=;
        b=KIiza3Ym0/Iek06nYuTC0Q+Bf8u1iGmn36aGRe9W/I1gIFUEfGsbleqvuPZIWT00W8
         br3rJrR/2H39KU5IhPVo1sEoS98RJTcYpjA9f3EeDxdoY/ek4TKpCxnLhjJsYyDgs9mq
         5UyMw1Z1JmGOsDBuuR6fTmhHEfUGP82+FFbQdSPJn+qMFX61MTp+H4BNXc2gytT9HWEQ
         1Y0sX4b1szCVT7f6AAfDkTzFbdF7HZDF0g22BzyCJecpkgXSzjoiwdIDU4sLVryoCmXx
         Um8Vc8hzUKg4zSwCI+dEH0xaHnhaohNcEAfu+DjaKEj+HDeeVgcQTJokCj/uSyGiMEdn
         CEXQ==
X-Gm-Message-State: APjAAAWawIb3dwoRrSj8hB0RHg4M+Rzf5isi7d/OB00dbZSdpyxZH8uN
        TrkX7mwGsR40gJC5g820QCQ=
X-Google-Smtp-Source: APXvYqyk7VLAQdjAwuVNeoLOS2lLrS99HPfR5mFLVgsHVxJ42p5JUMRjPPcgX6gO5Y/xqCH3Tv6Kyg==
X-Received: by 2002:a17:90a:b108:: with SMTP id z8mr2370791pjq.64.1568793226157;
        Wed, 18 Sep 2019 00:53:46 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c147:d9df:f819:e399:825f:f2dc])
        by smtp.gmail.com with ESMTPSA id h8sm5580715pfo.64.2019.09.18.00.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 00:53:45 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@jic23.retrosnub.co.uk
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v2 7/7] counter: stm32-timer-cnt: Update count_read and count_write callbacks
Date:   Wed, 18 Sep 2019 16:52:48 +0900
Message-Id: <327fe01b7ce4feb0fc3d854393691664a6a36b40.1568792697.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568792697.git.vilhelm.gray@gmail.com>
References: <cover.1568792697.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The count_read and count_write callbacks pass unsigned long now.

Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/stm32-timer-cnt.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index 644ba18a72ad..839083543323 100644
--- a/drivers/counter/stm32-timer-cnt.c
+++ b/drivers/counter/stm32-timer-cnt.c
@@ -48,34 +48,27 @@ static enum counter_count_function stm32_count_functions[] = {
 };
 
 static int stm32_count_read(struct counter_device *counter,
-			    struct counter_count *count,
-			    struct counter_count_read_value *val)
+			    struct counter_count *count, unsigned long *val)
 {
 	struct stm32_timer_cnt *const priv = counter->priv;
 	u32 cnt;
 
 	regmap_read(priv->regmap, TIM_CNT, &cnt);
-	counter_count_read_value_set(val, COUNTER_COUNT_POSITION, &cnt);
+	*val = cnt;
 
 	return 0;
 }
 
 static int stm32_count_write(struct counter_device *counter,
 			     struct counter_count *count,
-			     struct counter_count_write_value *val)
+			     const unsigned long val)
 {
 	struct stm32_timer_cnt *const priv = counter->priv;
-	u32 cnt;
-	int err;
-
-	err = counter_count_write_value_get(&cnt, COUNTER_COUNT_POSITION, val);
-	if (err)
-		return err;
 
-	if (cnt > priv->ceiling)
+	if (val > priv->ceiling)
 		return -EINVAL;
 
-	return regmap_write(priv->regmap, TIM_CNT, cnt);
+	return regmap_write(priv->regmap, TIM_CNT, val);
 }
 
 static int stm32_count_function_get(struct counter_device *counter,
-- 
2.23.0

