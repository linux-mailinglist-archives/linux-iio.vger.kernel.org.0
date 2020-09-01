Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEFCE258B9E
	for <lists+linux-iio@lfdr.de>; Tue,  1 Sep 2020 11:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgIAJcj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Sep 2020 05:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgIAJcj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Sep 2020 05:32:39 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4320C061244
        for <linux-iio@vger.kernel.org>; Tue,  1 Sep 2020 02:32:38 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k15so703257wrn.10
        for <linux-iio@vger.kernel.org>; Tue, 01 Sep 2020 02:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fjzYRnlLP3NDVTbtqa0TtTnoLtPLqGtsTI87vfoQgbs=;
        b=j2lLNXeksADJzDW1uQToY7XNNjkjJHIjOwsHpqtYKk1XFui1n0zMUyMa6FnWftcbLM
         3bxPyqpGRR9WicJOTRAQDGvcCWUIeEuN8iHWGM71H43C6TuRkq0ZYsRisvLA3Wc9M+EQ
         TlBTBchswtzlx90ufM6CilXvZwsFu86eyPRzb8j/KkoOLb+6Ms/6Gahng1l3XvkX5CRx
         jYk0gDbcSb+Mw5N0SSHXU8UJUUmMu84j+2+dS846pcsFMGo0Ztftr4WcgyuX3+Rt3YZz
         DGCTQVnigSSuHpQBlioWyxeh5c2fdeXXOpjZ6syWpIwapaaJXq6vW/4ZUuymeoEkMpkR
         F4TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fjzYRnlLP3NDVTbtqa0TtTnoLtPLqGtsTI87vfoQgbs=;
        b=qzProhYH88jZeeFKO8VuEBoaAy/CT0DpmE0AK1rQJ1SuXzxh2QP2GCj4rUxwX5u7Yg
         KqxUMAc7RkBYAUr4IAYF19KfX0nHn4CTZ6UGvyw1eZU/6S3A0kHR2zHkjLtvYLpubcqk
         hSutD+SGQvmPWML1R1/MT7nrgTLJ11Y+AeFyk7YK3mNRZwGrCrqHTLXh5sw6ClNCEohr
         4qQql4zZ50LQ5COLZngZSiuqdXCNN0SHMGFtMyDbDgNUZgBwjQFNXUWdvHFC/+1epBBn
         Wdqh5TE/4ON19Ovdc2RcO7PCsCiCiM3Jt9QYZDPjcXflV0t1LV9irCkR4/ZS7oPqHwjK
         Ng6Q==
X-Gm-Message-State: AOAM532E+0JcuMZRANPrAKafl/zD9g2RfyaHPrafx8p/ERsGFNqI4c0y
        flg/z5U0krIAFQ5bovW2+bzNESpvjp7ZLA==
X-Google-Smtp-Source: ABdhPJzoCTXvNp+ALiDiKBuhYdzYaIK2KCY/RhEAXp7FO+Py9oOJdjRyTZoWrd+eA4MPjjnxN9YmJw==
X-Received: by 2002:adf:dd0e:: with SMTP id a14mr884670wrm.151.1598952756726;
        Tue, 01 Sep 2020 02:32:36 -0700 (PDT)
Received: from localhost.localdomain (host085115198017.static.fidoka.tech. [85.115.198.17])
        by smtp.gmail.com with ESMTPSA id k8sm1085496wma.16.2020.09.01.02.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 02:32:36 -0700 (PDT)
From:   Angelo Compagnucci <angelo.compagnucci@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, jic23@kernel.org,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>
Subject: [PATCH] iio: adc: mcp3422: fix locking on error path
Date:   Tue,  1 Sep 2020 11:32:18 +0200
Message-Id: <20200901093218.1500845-1-angelo.compagnucci@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Reading from the chip should be unlocked on error path else the lock
could never being released.

Fixes: 07914c84ba30 ("iio: adc: Add driver for Microchip MCP3422/3/4 high resolution ADC")
Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>
---
 drivers/iio/adc/mcp3422.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
index 219adac2384b..da353dcb1e9d 100644
--- a/drivers/iio/adc/mcp3422.c
+++ b/drivers/iio/adc/mcp3422.c
@@ -143,8 +143,10 @@ static int mcp3422_read_channel(struct mcp3422 *adc,
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
 
-- 
2.25.1

