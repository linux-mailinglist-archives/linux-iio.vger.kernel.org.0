Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14D8588FDD
	for <lists+linux-iio@lfdr.de>; Sun, 11 Aug 2019 07:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbfHKFpj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Aug 2019 01:45:39 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41376 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfHKFpj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 11 Aug 2019 01:45:39 -0400
Received: by mail-pf1-f195.google.com with SMTP id 196so990451pfz.8;
        Sat, 10 Aug 2019 22:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lIW5+zLtFfN9H7oBc2McuaeCn1zqDU+D1SMoM8Zey4s=;
        b=RWql46uYmokkkg/8vQ74G1zM2fP/uLPL7KSRAotKTdAGrQ1t9WNqX8yNI6wSUmQ5Lr
         wzL3a/b1BFYaddgZ+hndBTQqZFa9fZuIyENu2V/UjL6TZNPaOczsLsmDMsFVwBM8Pzma
         Eh84eZkHt6VAlB+qpIFX/TF4gXGuVvSg18wREwhJRt5ghWOkCZmRrDQSYBLh2XOny7bU
         2JcNVphJEY3eCe2yK/hU0fS2Bg4y/7rJjNDtmZ4cpc3VxZwEFqfRKDiTEMR/G5p42819
         arhKGC3zWZTrF4ISQ9ejk1eejVa0VKxmvn7zT0610TUY46+uWItPCE+bA7A52IuUXoPE
         2Byw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lIW5+zLtFfN9H7oBc2McuaeCn1zqDU+D1SMoM8Zey4s=;
        b=mNqtLKz5OAXYD/xa8C+l4h0Ax6rVvqkvKv63XsapNOHHHNqHZBSnXDEWy3+iu8I1e0
         cnPRJ8NOs2FiWYd6sRRs+vVoADxnYGEYSxwloF4+p/pFE9tzKJF0jP9k+XiCskWZ4YdN
         oyrp1i+Q22Py0HjJEPsAvsJfh4GOwJWrndist/MAzBNsqkTIG30snkGo3t5dbrgC05Rx
         Wqbu2EPFmEiWhD6EA0JFb0EBaLpNVShH5sj5mBORfPpvzdMHbVluGUm8JUhZLXxCKhdC
         JpT4rqEK345HTNvI+oWdWc3WfJMm9QeTfrm7Dk4hQROv5ZzXytGw+YKK7OC1Ga3FMmYA
         l61g==
X-Gm-Message-State: APjAAAXfCp0aR8aQyh1uQ3KThUPMd4741k63W9m+vDUMVUxnm2kaoz4Q
        9GQdOMpaXp0WbutdRq4TczpfEfhC
X-Google-Smtp-Source: APXvYqy62qY5Nw5KPG90iDC6SPsMV21AfqOfhGrsszpcpJ24ghf59M6LIY5d9vlfLV8/dWPNV36u5w==
X-Received: by 2002:a65:4b89:: with SMTP id t9mr24429738pgq.55.1565502338139;
        Sat, 10 Aug 2019 22:45:38 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id i17sm7275065pfo.28.2019.08.10.22.45.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 10 Aug 2019 22:45:37 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Chris Healy <cphealy@gmail.com>
Subject: [PATCH] iio: hi8435: Use gpiod_set_value_cansleep()
Date:   Sat, 10 Aug 2019 22:45:11 -0700
Message-Id: <20190811054511.6430-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use gpiod_set_value_cansleep() instead of gpiod_set_value() to support
the case when reset pin is connected to a GPIO expander. See ZII VF610
SCU4 AIB for one such example.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
---
 drivers/iio/adc/hi8435.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/hi8435.c b/drivers/iio/adc/hi8435.c
index 35951c47004e..c15f0e154e4d 100644
--- a/drivers/iio/adc/hi8435.c
+++ b/drivers/iio/adc/hi8435.c
@@ -477,7 +477,7 @@ static int hi8435_probe(struct spi_device *spi)
 		hi8435_writeb(priv, HI8435_CTRL_REG, 0);
 	} else {
 		udelay(5);
-		gpiod_set_value(reset_gpio, 1);
+		gpiod_set_value_cansleep(reset_gpio, 1);
 	}
 
 	spi_set_drvdata(spi, idev);
-- 
2.21.0

