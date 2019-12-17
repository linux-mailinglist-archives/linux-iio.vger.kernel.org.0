Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 789C4122997
	for <lists+linux-iio@lfdr.de>; Tue, 17 Dec 2019 12:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfLQLMP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Dec 2019 06:12:15 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:33989 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbfLQLMP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Dec 2019 06:12:15 -0500
Received: by mail-pj1-f68.google.com with SMTP id j11so4441362pjs.1;
        Tue, 17 Dec 2019 03:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=gLPsXf1M5gmXwUcxazQUZ7xNr2aBinYX1xs0OI9I9S4=;
        b=VYdWIVofnGsdB2NADPwAXAnESwKkMoKkOvTYlbwhnrqAJEcFL484nJqdgUZXzlF7te
         MZLtp+rCqg5BmIznBO6kuqppjFnxsaNCiq6ByVD8ntKa/s0O/mVr7d+BtUiOIngH1TV8
         BWCBjeSsGSJV0uQDGPN/ogQdHzM2IWRVTGTDY/DqALc6IKlSNu1MXV9MuuQxBGq2yu10
         +M1nc1/hi+NtZ3UzK7mPuyvf2p57XeneskIcsNiXuQPvty0WcDBaD6wTXTukN3kj9gr3
         RO6VZeQvhjzePAQLTuXrVaGfMScoRSuYzocPqEsvfbGZHvxB4fkJ/H2gXsy9T/1FGplH
         1Yhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gLPsXf1M5gmXwUcxazQUZ7xNr2aBinYX1xs0OI9I9S4=;
        b=cyhComrKtKIQptgj5feznE2H3y1BSYMsrtUPap1Pg02vbifBkvWVV1F90fwEK4+J+2
         6ZOmVBRA8jCkHCznxA2h6rRBAGpKCCd0nrwwKMghqmrxmczxTe6eFpOLQZ7GxiOfYA3Z
         SEt7RoS2X8qHNFJZcZJcN+o6RYjbPmAaTaLRGslfcLBGaeYNovsL2Eepii2RgAZ6H1mf
         UnFKWLAk4N2Tb/IEKlS04bNmjGkdllTdyh2h41SHVfhbc7sZtFk8pLmyjDd/Qud53/sK
         3m1Ka8eaDiSzkyXprCHYNTLi2/1ouP/ysMxeRk/L24QP/O94poALqt8CUP/+hHfDR2y+
         Clog==
X-Gm-Message-State: APjAAAVhRiP8X2rtrg2Ax6Rm7oLWkdGqbHtl6rAD/lJberc6w/xPZtyC
        W8byRqatumXuvpY9gix0cnw=
X-Google-Smtp-Source: APXvYqxxtDdg7H7hS9kzLrmzUSDsgQEaNfS2QkpewoXAmH/+9UFHymPBTndK7/foHeWlYvdLwA3ltg==
X-Received: by 2002:a17:90a:9dc3:: with SMTP id x3mr5276099pjv.45.1576581134621;
        Tue, 17 Dec 2019 03:12:14 -0800 (PST)
Received: from brcpsddjunho-l.padtec.com.br (apolo.padtec.com.br. [200.228.158.130])
        by smtp.gmail.com with ESMTPSA id 81sm25855190pfx.73.2019.12.17.03.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 03:12:14 -0800 (PST)
From:   Daniel Junho <djunho@gmail.com>
To:     "Jonathan Cameron" <jic23@kernel.org>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "lkcamp@lists.libreplanetbr.org" <lkcamp@lists.libreplanetbr.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: [PATCH v3 3/4] iio: adc: ad7923: Add of_device_id table
Date:   Tue, 17 Dec 2019 08:11:57 -0300
Message-Id: <20191217111158.30888-4-djunho@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191217111158.30888-1-djunho@gmail.com>
References: <20191217111158.30888-1-djunho@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Accomplish device tree compatibility to driver AD7923
by adding of_device_id table and making a subsequent call to
MODULE_DEVICE_TABLE.

Signed-off-by: Daniel Junho <djunho@gmail.com>
---
 drivers/iio/adc/ad7923.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
index e535cec9fc02..6d56fa0b9e30 100644
--- a/drivers/iio/adc/ad7923.c
+++ b/drivers/iio/adc/ad7923.c
@@ -348,9 +348,19 @@ static const struct spi_device_id ad7923_id[] = {
 };
 MODULE_DEVICE_TABLE(spi, ad7923_id);
 
+static const struct of_device_id ad7923_of_match[] = {
+	{ .compatible = "adi,ad7904", },
+	{ .compatible = "adi,ad7914", },
+	{ .compatible = "adi,ad7923", },
+	{ .compatible = "adi,ad7924", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ad7923_of_match);
+
 static struct spi_driver ad7923_driver = {
 	.driver = {
 		.name	= "ad7923",
+		.of_match_table = ad7923_of_match,
 	},
 	.probe		= ad7923_probe,
 	.remove		= ad7923_remove,
-- 
2.24.1

