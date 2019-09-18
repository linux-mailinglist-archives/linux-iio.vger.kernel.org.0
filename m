Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3294B5E5B
	for <lists+linux-iio@lfdr.de>; Wed, 18 Sep 2019 09:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbfIRHxi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Sep 2019 03:53:38 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38733 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfIRHxi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Sep 2019 03:53:38 -0400
Received: by mail-pf1-f194.google.com with SMTP id h195so3829572pfe.5;
        Wed, 18 Sep 2019 00:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jztD0q/pSM8JUi6mwAcEWzxcgZfTnzpK2xWBV2x6KlU=;
        b=Um9D2iCr8IeMcdqzFKJCNkI4+H9iquS7B6UFk6cgl4jXkAirxwIuJ95qkKTrUhPsfT
         gTJcQMEthS4bzi0GfhSAd52gBR5BnadIzveTBTJe5gXEKvFl/zkrZBG1JQAG3wwASiDa
         INEDf4012fWYH/QZwcG3VHMmcNQaX2TVdkk3ncLyDT9fs5uPELiztes5FG8XMNlvN0fi
         YM0fnrpbCFQ0TSpfLVRR3SyTJKZH5qDBhLa0bfCyr2euLMqndD+EYffJSPfQ3LI5rTg4
         VbrNEubms5qPtsWb331YMEQTqHr4o0GWM0hcAlBaJwAVOpVN8q53IHXZBOA7Z1F9Hfxs
         DeqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jztD0q/pSM8JUi6mwAcEWzxcgZfTnzpK2xWBV2x6KlU=;
        b=ZtCzrhVHnFd2IKs7QWEhx/R7k5ImqY47+rM6Wu6GqCtpr1ZwF3y/scYX/eXsHrSZqk
         dUDBtcQLdF+SMhTMRcKo88Jk2b1nUc0t+qxyeNGS5kR32d2lrvBFYO0jOaa0iB7ghfXc
         +SLHLAz0RPn6cbfkNjPItToMmLbAf+F+c7kAXnMnDZCRztwSniia3pisKwQYqj45Hvzu
         e+GD4a00fsPL9xSTg9ue5Oo8OzJO4hQ79OAR2R+z2AfMax42ZxuYVK3ta0YNKB6bN2IY
         RNkI/AYCdN3Fk88mb808zxG7vk//yBIa5JyR1vZGTUC5iDlRZ6A8O3NpdhHcyOM1akyP
         i6+Q==
X-Gm-Message-State: APjAAAWzcpCmjxs8xueY054i5Q4BWCxRKfUpYRZpY5wXQ6ZTbKvGEwZ9
        29N4HrJ8r5AAqJZoK6bZ3ks=
X-Google-Smtp-Source: APXvYqxxqPoVDdtGr5+T574vmF9JYrxp2FWnYti4I+/c5S8B3oWrqRqPteeAZ6AyHkDVfV3S2ouo0A==
X-Received: by 2002:a63:2004:: with SMTP id g4mr2593156pgg.97.1568793217016;
        Wed, 18 Sep 2019 00:53:37 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c147:d9df:f819:e399:825f:f2dc])
        by smtp.gmail.com with ESMTPSA id h8sm5580715pfo.64.2019.09.18.00.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 00:53:36 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@jic23.retrosnub.co.uk
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v2 5/7] counter: ftm-quaddec: Update count_read and count_write callbacks
Date:   Wed, 18 Sep 2019 16:52:46 +0900
Message-Id: <6925fdda26c57ce29d373f8cb01a572cd7b92c0f.1568792697.git.vilhelm.gray@gmail.com>
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

Cc: Patrick Havelange <patrick.havelange@essensium.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/ftm-quaddec.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quaddec.c
index 4046aa9f9234..c2b3fdfd8b77 100644
--- a/drivers/counter/ftm-quaddec.c
+++ b/drivers/counter/ftm-quaddec.c
@@ -178,31 +178,25 @@ static const enum counter_count_function ftm_quaddec_count_functions[] = {
 
 static int ftm_quaddec_count_read(struct counter_device *counter,
 				  struct counter_count *count,
-				  struct counter_count_read_value *val)
+				  unsigned long *val)
 {
 	struct ftm_quaddec *const ftm = counter->priv;
 	uint32_t cntval;
 
 	ftm_read(ftm, FTM_CNT, &cntval);
 
-	counter_count_read_value_set(val, COUNTER_COUNT_POSITION, &cntval);
+	*val = cntval;
 
 	return 0;
 }
 
 static int ftm_quaddec_count_write(struct counter_device *counter,
 				   struct counter_count *count,
-				   struct counter_count_write_value *val)
+				   const unsigned long val)
 {
 	struct ftm_quaddec *const ftm = counter->priv;
-	u32 cnt;
-	int err;
 
-	err = counter_count_write_value_get(&cnt, COUNTER_COUNT_POSITION, val);
-	if (err)
-		return err;
-
-	if (cnt != 0) {
+	if (val != 0) {
 		dev_warn(&ftm->pdev->dev, "Can only accept '0' as new counter value\n");
 		return -EINVAL;
 	}
-- 
2.23.0

