Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC323A0934
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 03:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235782AbhFIBfP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Jun 2021 21:35:15 -0400
Received: from mail-pl1-f175.google.com ([209.85.214.175]:46973 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235689AbhFIBfN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Jun 2021 21:35:13 -0400
Received: by mail-pl1-f175.google.com with SMTP id e1so11670169pld.13;
        Tue, 08 Jun 2021 18:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M+ymk8l7sDsxacyxiiHwx/yDAi9ouIx2opOlllHKJGo=;
        b=rETqv+/5v6VexoVTKEiL4+p0jOdC7Wugt1hqCAt26ZVIK7eVr04itPS5S98u10CUXF
         wCkbpBcx9jkH79pTdTSzBVjyOJEfQ5NLFbGORbm8Y7AaQsp1Q7bXGgU3cMyrGT+eCDYL
         imKFwJoBJNIx5fhuK8Z2yq8c+s51ZpZ5Kw59BjOOrlrGdwlb4TiDX2smFWRAyDgStNtA
         47prT7DrHcjDa+gAa/4ZAnEiaTx0jI6CvN6ahwbOL1YxljGe7y2WHNA+zOy23wfaRbGr
         8GxN9l65KStBtx/mxg8fAw27c3TPkr+JHUJVAafW72CxDvSoNxBtxoM+rAzoCKdbbAST
         sIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M+ymk8l7sDsxacyxiiHwx/yDAi9ouIx2opOlllHKJGo=;
        b=Z5Ccdz/NO9uMeiKq/SWaDv1QDbQqOzWVwSQLX+G5EylglhDjbwY0MMje8VhtjGlw6Q
         6qdk227lccvh/9SSS90UxHnZ1qBApYauTCKVeqygl8/IwHNgaRhETmvnY3B4Ljtb8VzG
         /jQktUNDZoF/vCLGQryJlOoBwPDo7a1gbaBveEn58jtZLsYWRnHQMGGqF16H7h/PTak6
         jRDYLfMPLQW5MaBF8a6FjeTLMsqHY9rIXbHr94ut3wrFrWx/4PJp1T0Fzzt/f5/gxZJ1
         keVS1bvRWcPULqMMNSXntcpVQGxC/v3hUSy8Y59MrH/5x5LSh1Ex4McqU2rc+VpBIAIN
         0FdQ==
X-Gm-Message-State: AOAM533ucywt9m98kLwGZIjU7IvD/gxUpMa/sS0eR2FB6qY5oKqMabVF
        mDEKsiQUyRtxYZYP9Z1S5dQ=
X-Google-Smtp-Source: ABdhPJzksTcPTip/Mhf4JXMjYM+qZ6M24lezTlxsHVdN8I2e98HWcnQmfJCDEEdD2+XO7nVchRUGpQ==
X-Received: by 2002:a17:90a:a098:: with SMTP id r24mr7872954pjp.120.1623202324568;
        Tue, 08 Jun 2021 18:32:04 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id v14sm12659815pgl.86.2021.06.08.18.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 18:32:04 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        jarkko.nikula@linux.intel.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v11 03/33] counter: 104-quad-8: Remove pointless comment
Date:   Wed,  9 Jun 2021 10:31:06 +0900
Message-Id: <77e9f3daa091d0ad0ee56b8973705dd03db85dd4.1623201081.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623201081.git.vilhelm.gray@gmail.com>
References: <cover.1623201081.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

It is obvious that devm_counter_register() is used to register a Counter
device, so a comment stating such is pointless here.

Acked-by: Syed Nayyar Waris <syednwaris@gmail.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/104-quad-8.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 9691f8612be8..4bb9abffae48 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -1082,7 +1082,6 @@ static int quad8_probe(struct device *dev, unsigned int id)
 	/* Enable all counters */
 	outb(QUAD8_CHAN_OP_ENABLE_COUNTERS, base[id] + QUAD8_REG_CHAN_OP);
 
-	/* Register Counter device */
 	return devm_counter_register(dev, &priv->counter);
 }
 
-- 
2.32.0

