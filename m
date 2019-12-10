Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD78A118C06
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2019 16:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfLJPIY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Dec 2019 10:08:24 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:35650 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727272AbfLJPIY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Dec 2019 10:08:24 -0500
Received: by mail-vs1-f66.google.com with SMTP id x123so13276424vsc.2;
        Tue, 10 Dec 2019 07:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=M0KdOe/3glRoJt3BcCpaVTKFGDYHuqzU8vlGhcuT6tg=;
        b=EMeZ7E9iqUoVn8WURRWpi4w+1DzrzT30sZYlxmo9vnRssx2vHWoNaYMav50IQ3Zxt1
         jT8E2RH90GVRFyD8sbWLrkzHaZeDiom53Sew6NhGII3taXQTWH72SukacWNtfH5ZXvq7
         Hrhrr1jhoZ+PTJIk+2qKInROJ17VU50+BaCC9KunDNopnzD3NJ6x1AkenFxHfSJxATnJ
         68a0NSdcVrcenfa8GPC53nv726sXLosygyHAPQ/pKyZtONnBPeHgFInEy4LPwv4K35VZ
         XsJ2KhS6kfuPzM7ocYM5++Ln/sylOdSZUCkn81u6Xu95bWWfmEBOqHNkzk6Y7IIdsyA3
         FlaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M0KdOe/3glRoJt3BcCpaVTKFGDYHuqzU8vlGhcuT6tg=;
        b=oQuWC3m7O/sD8pHmeD4qf5FuEfytJD+QaJJQ45Ni6Eaz7e8rgWjeLgh5OrmV+SVQh5
         Nk4iNYBHh3BtBJDf8oPqW/MHwqbNgSTOBXg0grlewgxzpXf8/PkG3XR9L3wCuFVB1UJL
         9m7uW2K5pNkSgrAMq2mGfRGj1espGXf/BVVFI/kgxP5KT7G7hYvb4oRGBNXASEeWoiJH
         2fWgY/r6aS66+aQ0k8wHXwvTrPhaaQOUfwmoSvsj0DFtJU5G//HosXOU+ceR/RoJUGFx
         F1WdTti91fueoSyaVhpIDc7xE/HHESLsdzZf2mbNi/Mpr9dKjCgA994YUFMCyp4Mz3uA
         hQTA==
X-Gm-Message-State: APjAAAXnqVVqYncxeFdR0LP5iXXDZZQJWEtY4slyM7juQe61dkimipJW
        qPU0SJXlhKmiOsTCbjjqJiw=
X-Google-Smtp-Source: APXvYqwi10wpRuTontMcHv2cc2KsTG+TFMOebyYfMwYe0CpMzHOf07j9Gv+0dgn3BoF+ybyNYVbOvw==
X-Received: by 2002:a67:e3da:: with SMTP id k26mr25062655vsm.172.1575990502766;
        Tue, 10 Dec 2019 07:08:22 -0800 (PST)
Received: from brcpsddjunho-l.padtec.com.br (apolo.padtec.com.br. [200.228.158.130])
        by smtp.gmail.com with ESMTPSA id k45sm1986139uae.9.2019.12.10.07.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 07:08:22 -0800 (PST)
From:   Daniel Junho <djunho@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Subject: [PATCH v2 2/4] iio: adc: ad7923: Fix checkpatch warning
Date:   Tue, 10 Dec 2019 12:08:09 -0300
Message-Id: <20191210150811.3429-3-djunho@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191210150811.3429-1-djunho@gmail.com>
References: <20191210150811.3429-1-djunho@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fix checkpatch warning:
WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
+static int ad7923_scan_direct(struct ad7923_state *st, unsigned ch)

Signed-off-by: Daniel Junho <djunho@gmail.com>
---
 drivers/iio/adc/ad7923.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
index 969c06b7d2b7..e535cec9fc02 100644
--- a/drivers/iio/adc/ad7923.c
+++ b/drivers/iio/adc/ad7923.c
@@ -184,7 +184,7 @@ static irqreturn_t ad7923_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
-static int ad7923_scan_direct(struct ad7923_state *st, unsigned ch)
+static int ad7923_scan_direct(struct ad7923_state *st, unsigned int ch)
 {
 	int ret, cmd;
 
-- 
2.24.0

