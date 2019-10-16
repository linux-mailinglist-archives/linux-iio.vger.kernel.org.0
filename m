Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E841DD93BC
	for <lists+linux-iio@lfdr.de>; Wed, 16 Oct 2019 16:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392386AbfJPOZz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Oct 2019 10:25:55 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34721 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731887AbfJPOZz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Oct 2019 10:25:55 -0400
Received: by mail-pg1-f194.google.com with SMTP id k20so7052187pgi.1;
        Wed, 16 Oct 2019 07:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ujGILVS8EOVsDFzbe0iajn+DjkCITaKLgBibceQs4Qk=;
        b=a6bOoh9WX6DTprd6X00EX+6JfgBs7ui/aqTCQjRQtKjuicevk+q6uytkW0NbwJxVil
         cSBlwFT21oiOer9Khli6iBMoxHsCgyGRBpGjpJk+lxnhnrKW/ZqNrJhL9TEF3OvzcsFR
         4MQ15Eo/+o+PGv428dqqGP0V5khaisyqzTNF0ePtA5zZcOq4h2o+ArfnRMwqnyVgJgZ9
         GQKSOxEck+QcA6uHMJtr4lU8JpWTf3MEMjBXLCsmoDLa2SxUtFNM1kvXrDsValCbcDC9
         siH/D7L3PtTo1yqpzChH0dcb4/Ewf2aS6tyPau+NaSijx8sqvyai1t05WTVlsIi1VrC1
         nRMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ujGILVS8EOVsDFzbe0iajn+DjkCITaKLgBibceQs4Qk=;
        b=q/vQbfY5EijazxjCafMWsD3B4qV/ZYQ8NTZMmZj22ETE2i9lxHPPdOWl7LffGrMQ3k
         4dE9xrENftN6KLowvU4kwb1G3M1vkgdHnCvyqwAgf16HYkbwYWsM9nQOBqgQ9ELOzjNW
         zBE2jX2enHibj35eHBX6ijZ8487PiVyEE1Ig3kg2d/PKs5kmYvsB4T0ZafN1Jd/82k6M
         m5sr5H4ipCIEq42afoUDlp4UhbZ9x0xAulrO/JByEhcu9YZr9lmusm3c/0ar93WFtBvB
         vn1rlRAnqV5N/lftJVbcTOanyIvwE4mYa82WKw9w303j4KrO6bJdys4cKx7jUgdRbd6K
         sktg==
X-Gm-Message-State: APjAAAVc/FZ+8cc5kXiav+ylpUlF5wN2V9kYiMJelPi9XsCaDig4wRHp
        vuqcmN6Wo9JZXesvC6ya+44=
X-Google-Smtp-Source: APXvYqxIYy2Qv9i2kyVFd/IvVJK02XNDYI0j0LNVdMEsCydz62Z+SlEJeTndXygi/WhaU4LEtTD7PA==
X-Received: by 2002:a63:3f86:: with SMTP id m128mr910929pga.404.1571235954263;
        Wed, 16 Oct 2019 07:25:54 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id i1sm30371683pfg.2.2019.10.16.07.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 07:25:53 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] staging: iio: ad9834: add a check for devm_clk_get
Date:   Wed, 16 Oct 2019 22:25:40 +0800
Message-Id: <20191016142540.26450-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

ad9834_probe misses a check for devm_clk_get and may cause problems.
Add a check like what ad9832 does to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/staging/iio/frequency/ad9834.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index 038d6732c3fd..23026978a5a5 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -417,6 +417,10 @@ static int ad9834_probe(struct spi_device *spi)
 	st = iio_priv(indio_dev);
 	mutex_init(&st->lock);
 	st->mclk = devm_clk_get(&spi->dev, NULL);
+	if (IS_ERR(st->mclk)) {
+		ret = PTR_ERR(st->mclk);
+		goto error_disable_reg;
+	}
 
 	ret = clk_prepare_enable(st->mclk);
 	if (ret) {
-- 
2.20.1

