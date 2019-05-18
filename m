Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 980D8224EB
	for <lists+linux-iio@lfdr.de>; Sat, 18 May 2019 22:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbfERUsa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 May 2019 16:48:30 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42768 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbfERUsa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 May 2019 16:48:30 -0400
Received: by mail-qt1-f196.google.com with SMTP id j53so11992888qta.9;
        Sat, 18 May 2019 13:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=WciszLrf+StkjFt3IBn6hpgp/9AF96pJ0rNKW3jR/+M=;
        b=HLb5TpL2OZK9F+Sws7GtcM0fcYy2Fpa0ZMJdNhCMtOLZMVEY+ElJpjmIm0P8JJRbD2
         Prrlb0Mh4QB6LBxWpjojlXoIr2Bo7FvtQpL1unzh7VBbRxCMs0NjXu25uVay1W2blkQ1
         xJ51654h0C+9hGDdq1Exe/Oy0rtqGvn2DvKV8U8QuPksMetMWUY+cYb8Ybxf0eNqnmKC
         AW1G+Csw9mchDYubTetAqRvAwyxXC0kEQ1tNjHyClhCLecElOVZ3Ao6Bm9p1MZ1+JXMU
         0CK/vflRyF3sKzM/DJc2QTy1JfdwxVqLU8I8VcZ17pekXd6QTC3fNAKQxthAFKZb5JHW
         ARYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=WciszLrf+StkjFt3IBn6hpgp/9AF96pJ0rNKW3jR/+M=;
        b=QnBA3fNUYijIR8CNzsDljh4rPz+/kN/ktNyE25ynPQoeaFUVQ9xr3SLVnIXxeMCu2c
         jho4uNZZoc6Jc/60VaYp88pER9nddvzCtxd3pU1hE3m+YsaCM+C5HlA/TjMfArszVpcy
         MWLoPs7U/+wlEfnGXmnn3yIxL+numlhO4s2ZhfRk5Y8RuXWA0MttTaVrl4SP/COUzAVE
         jsRNfW+CdZGK2EEYiDb+utsNPt2O3pz1HjNAR0zsv+mnBwu7/ZqImC8HGfku5c3GN2Hm
         BjydfFsrXR+xbrDVTB2PPxgAUFFy5thseDjGc4EMhRUNkgB+qXm/S8grIQYASxeQHu3d
         g/6g==
X-Gm-Message-State: APjAAAXWX5Po8pypjzH70sl8+bIyeuaHjbyisB6rBZnNivL83YvSYS+y
        6kOb3T6LAsPKcoY2V4Qa/jGT7jILXE0=
X-Google-Smtp-Source: APXvYqy2gfnMW7/yiWdNTqPE4nLkdak6PNML06Ce9ea32BPPhxLwoi2G0Zob0InNNm7XJjBrCJh9jw==
X-Received: by 2002:a0c:9523:: with SMTP id l32mr54285129qvl.75.1558212509186;
        Sat, 18 May 2019 13:48:29 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d15sm5528204qko.77.2019.05.18.13.48.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 May 2019 13:48:28 -0700 (PDT)
Date:   Sat, 18 May 2019 17:48:25 -0300
From:   =?utf-8?B?Sm/Do28=?= Seckler <joaoseckler@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: iio: ad9832: Add device tree support
Message-ID: <20190518204825.4kh5qkqo2e5q2se6@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add a of_device_id struct variable and subsequent call to
MODULE_DEVICE_TABLE macro to support device tree.

Signed-off-by: João Seckler <joaoseckler@gmail.com>
Signed-off-by: Anderson Reis <andersonreisrosa@gmail.com>
Co-developed-by: Anderson Reis  <andersonreisrosa@gmail.com>
Signed-off-by: Andre Tadeu de Carvalho <andre.tadeu.de.carvalho@gmail.com>
Co-developed-by: Andre Tadeu de Carvalho <andre.tadeu.de.carvalho@gmail.com>
---
 drivers/staging/iio/frequency/ad9832.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 74308a2e72db..51e97c74c6b2 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -451,6 +451,13 @@ static int ad9832_remove(struct spi_device *spi)
 	return 0;
 }
 
+static const struct of_device_id ad9832_of_match[] = {
+	{ .compatible = "adi,ad9832", },
+	{ .compatible = "adi,ad9835", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, ad9832_of_match);
+
 static const struct spi_device_id ad9832_id[] = {
 	{"ad9832", 0},
 	{"ad9835", 0},
-- 
2.11.0

