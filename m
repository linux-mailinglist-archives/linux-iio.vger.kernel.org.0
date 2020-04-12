Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 527CB1A5ED9
	for <lists+linux-iio@lfdr.de>; Sun, 12 Apr 2020 15:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgDLN5F (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Apr 2020 09:57:05 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42182 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgDLN5F (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Apr 2020 09:57:05 -0400
Received: by mail-pg1-f194.google.com with SMTP id g6so3337889pgs.9;
        Sun, 12 Apr 2020 06:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=88xbndOYpGPe/NGmyaJojaQNXhzRAvoZsI5qqKDeBKc=;
        b=Cz9w5UUrnKe3vHpSv451HrsP+jELlu2KJ/F9ZdaTxYjNFIbLL60xBXWzS9pJNu+q+q
         lt31gX+qh0g1CrqTZrgSp55NNy8CdMq/nPtykmffOMhrDy8XrQLqE59ovGvPg4J8JGml
         mACtcCkJAMRanQLr6NR0vhVb3XZeRfbq69VjdPyUTldcbGRw637Hp83U0dxKzEfOB0bM
         NVmn9PUAB7xJFOOyDwcWwVFP/ohBLiuBjKf7C0GHekrkgUFXEarMHAF2KTG2uHlMJ4vC
         6kBMmic6+mT+IvRReQnlD+hmkjOQHMcnErvBzetcBNKJ49tAkvGy0/Hzn/1wHYdTV85o
         eCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=88xbndOYpGPe/NGmyaJojaQNXhzRAvoZsI5qqKDeBKc=;
        b=r3wPTk77ELz4f/w/Ps9Bq7020jzuW9RYD8F76mqkhTQ2S4mDhvk6ztbUUzamz6ILP0
         AAeAidvYBGQGE035c94F3BJaHeuMb8WNwHA7m639jvp+xnbYR3cX98xq59rHNlJqh971
         Q2HJ+6Y/da19OKdszpRlGA/h6nWdLPNyQ7HMv3H0DSv9WRx23vB9Qg4C8+KdodTZfSZY
         RSxYOdVjca1+Gsz6nckKJksFhZqbbHYBOIBQI8TQfkzfWlpQpXrBnwEudna6duIb+ODT
         /pVWhZb5/M+LoCgOUprt7hvQPNddf+8O7RH5/uLjmuACQYF59ESyA0jnl0ziBr14aOub
         Y4xw==
X-Gm-Message-State: AGi0PubrSIjEIhZKg8gtroxCFxUHr/OwaHH8++ShFOWOVUq7hpUhJkvh
        TNM1bV8g0fpjt1FkSMO3CUM=
X-Google-Smtp-Source: APiQypKVgCfL7VmfA1bSCl2vQ5+BYxlM/jmWtJJk14l2KcB4YSAQrQ4wq4TxZtKLs407YAEvSYMHiw==
X-Received: by 2002:a62:8343:: with SMTP id h64mr14488459pfe.166.1586699824643;
        Sun, 12 Apr 2020 06:57:04 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:992:22ab:f465:67ce:fbea:c439])
        by smtp.gmail.com with ESMTPSA id 139sm6139060pfv.0.2020.04.12.06.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2020 06:57:03 -0700 (PDT)
From:   Aishwarya R <aishwaryarj100@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Richard Fontana <rfontana@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Aishwarya R <aishwaryarj100@gmail.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: at91-adc: Use devm_platform_ioremap_resource
Date:   Sun, 12 Apr 2020 19:26:42 +0530
Message-Id: <20200412135644.4027-1-aishwaryarj100@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200409151125.32677-1-aishwaryarj100@gmail.com>
References: <20200409151125.32677-1-aishwaryarj100@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Aishwarya Ramakrishnan <aishwaryarj100@gmail.com>

Use the helper function that wraps the calls to
platform_get_resource() and devm_ioremap_resource()
together. It reduces boilerplate and suggested by coccinelle.

Signed-off-by: Aishwarya Ramakrishnan <aishwaryarj100@gmail.com>
---
 drivers/iio/adc/at91_adc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index abe99856c823..0368b6dc6d60 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -1152,7 +1152,6 @@ static int at91_adc_probe(struct platform_device *pdev)
 	int ret;
 	struct iio_dev *idev;
 	struct at91_adc_state *st;
-	struct resource *res;
 	u32 reg;
 
 	idev = devm_iio_device_alloc(&pdev->dev, sizeof(struct at91_adc_state));
@@ -1182,9 +1181,7 @@ static int at91_adc_probe(struct platform_device *pdev)
 	if (st->irq < 0)
 		return -ENODEV;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-
-	st->reg_base = devm_ioremap_resource(&pdev->dev, res);
+	st->reg_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(st->reg_base))
 		return PTR_ERR(st->reg_base);
 
-- 
2.17.1

