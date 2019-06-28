Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 387715A561
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2019 21:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfF1TuJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 Jun 2019 15:50:09 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39772 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfF1TuJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 28 Jun 2019 15:50:09 -0400
Received: by mail-qk1-f194.google.com with SMTP id i125so5898879qkd.6
        for <linux-iio@vger.kernel.org>; Fri, 28 Jun 2019 12:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jZRO3VzZkmVCxDN0Eltf5dWSrbxlKFxXjJd0EkGNJt8=;
        b=n/pLk2Blz54TcW6mfCs+FT0vklOVTcqyX4q8d20Z5/ABNjFoWsNfTzqHH9v8r6HAOd
         hi3GeNg2iC0l4UAzKGKW9zJpOprL+2Xl4ffvrV38Ga1vJAEjEUY2oEQcUJnIQJ/uEMFx
         0UjTXgBGOdiay5zb8VP1umXEMoArjkcwYJSRaKLea3uwry1q/1wF0poXZlzbNZnb1Qjq
         NPiYjRL4T+WybrjBX8IJRQZghCWPlXD8EvA5y3mZi6wEC5kt2OdrGqWi9FcYL+fgfZwq
         kKCzds0GscXsXABZu45uYi+N/pEHmU8Irve6DJWBcSkktZjY0uxXW1kJougZOvyo/UhX
         SDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jZRO3VzZkmVCxDN0Eltf5dWSrbxlKFxXjJd0EkGNJt8=;
        b=WtXzs6pE4CVELEwir/OubaLRMhkvwTO774+YKnl3JU+0NDLXWYo/vnuTwcXtltfkpa
         B9eg0mUzNbyZFTtKBukBXvnrp5Sy/9ue5BaZ571N0ldy1kG5TzzRK6bxPFczEsz9kDvF
         aAXvSqOi1mmQ/lE1mWiM9vD9gM7Ups2XoPPaGeXn532KH1vPSaRPI4ZcViqL9zrGFDEf
         JeFN3eR3ciZu9SaKhV5kq8C0oCdhaumnh/KM3E6da3ub2XMC0xLEOIDqsWz4UBf26W2r
         vu3jBPDHDS/GXGp/sb9y+KsW4decSdtuPVxwUGJQzSB66b7PzXPi663Hozb/Zp55vVCV
         2J2A==
X-Gm-Message-State: APjAAAUao3sUKL7mAKb+6SyY3wO43HmKWMq+x9Rgp5FMu7JZkg2Kxm8b
        EDNpnkyUB+1jfP710/Kk12hb1g==
X-Google-Smtp-Source: APXvYqwoB+1hTX6NcQcoYm7J38heVzgt5n/r06M3b9POecQl9mwE7FfNXzKKP8Nnuns04rRl+HTCwQ==
X-Received: by 2002:a37:4e17:: with SMTP id c23mr10251959qkb.34.1561751407986;
        Fri, 28 Jun 2019 12:50:07 -0700 (PDT)
Received: from greta.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id c55sm1535141qtk.53.2019.06.28.12.50.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 12:50:07 -0700 (PDT)
From:   =?UTF-8?q?B=C3=A1rbara=20Fernandes?= <barbara.fernandes@usp.br>
To:     lars@metafoo.de, Michael.Hennerich@analog.com,
        stefan.popa@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        =?UTF-8?q?B=C3=A1rbara=20Fernandes?= <barbara.fernandes@usp.br>,
        Wilson Sales <spoonm@spoonm.org>
Subject: [PATCH v2] staging: iio: ad7192: create of_device_id array
Date:   Fri, 28 Jun 2019 16:49:22 -0300
Message-Id: <20190628194922.13277-1-barbara.fernandes@usp.br>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Create list of compatible device ids to be matched with those stated in
the device tree.

Signed-off-by: Bárbara Fernandes <barbara.fernandes@usp.br>
Signed-off-by: Wilson Sales <spoonm@spoonm.org>
Co-developed by: Wilson Sales <spoonm@spoonm.org>
---
 drivers/staging/iio/adc/ad7192.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 3d74da9d37e7..70118db98d94 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -810,11 +810,23 @@ static const struct spi_device_id ad7192_id[] = {
 	{"ad7195", ID_AD7195},
 	{}
 };
+
 MODULE_DEVICE_TABLE(spi, ad7192_id);
 
+static const struct of_device_id ad7192_of_match[] = {
+	{ .compatible = "adi,ad7190" },
+	{ .compatible = "adi,ad7192" },
+	{ .compatible = "adi,ad7193" },
+	{ .compatible = "adi,ad7195" },
+	{}
+};
+
+MODULE_DEVICE_TABLE(of, ad7192_of_match);
+
 static struct spi_driver ad7192_driver = {
 	.driver = {
 		.name	= "ad7192",
+		.of_match_table = ad7192_of_match,
 	},
 	.probe		= ad7192_probe,
 	.remove		= ad7192_remove,
-- 
2.17.1

