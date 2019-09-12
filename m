Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1262B115E
	for <lists+linux-iio@lfdr.de>; Thu, 12 Sep 2019 16:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732784AbfILOnh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Sep 2019 10:43:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45377 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732708AbfILOnh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Sep 2019 10:43:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id l16so28681073wrv.12
        for <linux-iio@vger.kernel.org>; Thu, 12 Sep 2019 07:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8qKtktIW48wn6megrwv4Wyp2PCeXeuD2/owEpjgyYCs=;
        b=hyBMDEUalzb8J7W+9zqEhhCOXYLK8Ca9zLJaXcVgDvPjcCcaDImGPHjKEZcetx5XEA
         cbhSmkA/jzDD+mtq29QoK2h3fkcQ9MAk514EalyZHlmkmob5eM60y7sGhSlphQU039dI
         0mnl642tMdwXIESRav0LyB1Qhefb1ypcgbzX98ulRBGnDzCC5u6JofrSntn1zLys/nDj
         CBuuAgPn4VhIikC7jSjNu7ux9jSUoz6JE709DyxmuuHZM8G7PpRFtW9YClUzUdQcNXsH
         b6ZlG2vn7SSo9vGXuwtbovAx/cpIuHoCqPTMw/Form4mkL79dv/mVM3JHGH+Ox3Y2Dbq
         JKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8qKtktIW48wn6megrwv4Wyp2PCeXeuD2/owEpjgyYCs=;
        b=Kd8YE/hA8jp8+L0tmuaQTTYylJCZVvlkAaEcmjVMf2qfTFIarpnp3vT2d4JBDXz8cK
         gaQ60dt4BQD6fwcwkePyAmZoe0mT4eebxYhRbdbryo653cGl9kR8IsWhK5ALvnmsgfqC
         xVkwHkuqmPLAHQ/Z++TCwltApYOsEvbjSt+MdGJkRTrRNEX2UwrJ9wsKk9R92PmSsoiF
         yzYGW5Yuq50QdpoBOJhELJhRYmWkgVnUR7CLQ/U6712feeuImtZLD4TS9bnrvnr1AcqH
         817LIxLO8Nyk1L9CvliB9rFqj2aTCYku0SX9/lKzc5YFeCVvoX0fLE5QilJ0PYZa3pC4
         DmiQ==
X-Gm-Message-State: APjAAAUgIGOstI2OjJy5ycBNhqbvLLzhhtDXQ0YnjUtkJTyDto9YgZDA
        z7VI3bM7ivo2Q97YeM3xoP0=
X-Google-Smtp-Source: APXvYqzr1Taq5m0PJ7mYDj3qzajsGPCjCukotrGI+P6LNTTNJh4175oTngnzbfQiHAFb32MEY6TrhQ==
X-Received: by 2002:adf:cd8e:: with SMTP id q14mr13274195wrj.187.1568299415797;
        Thu, 12 Sep 2019 07:43:35 -0700 (PDT)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id q19sm35175256wra.89.2019.09.12.07.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 07:43:35 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org,
        Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH 2/4] iio: ad7949: fix incorrect SPI xfer len
Date:   Thu, 12 Sep 2019 16:43:08 +0200
Message-Id: <20190912144310.7458-3-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190912144310.7458-1-andrea.merello@gmail.com>
References: <20190912144310.7458-1-andrea.merello@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This driver supports 14-bits and 16-bits devices. All of them have a 14-bit
configuration registers. All SPI trasfers, for reading AD conversion
results and for writing the configuration register, fit in two bytes.

The driver always uses 4-bytes xfers which seems at least pointless (maybe
even harmful). This patch trims the SPI xfer len and the buffer size to
two bytes.

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
---
 drivers/iio/adc/ad7949.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
index 518044c31a73..5c2b3446fa4a 100644
--- a/drivers/iio/adc/ad7949.c
+++ b/drivers/iio/adc/ad7949.c
@@ -54,7 +54,7 @@ struct ad7949_adc_chip {
 	u8 resolution;
 	u16 cfg;
 	unsigned int current_channel;
-	u32 buffer ____cacheline_aligned;
+	u16 buffer ____cacheline_aligned;
 };
 
 static int ad7949_spi_write_cfg(struct ad7949_adc_chip *ad7949_adc, u16 val,
@@ -67,7 +67,7 @@ static int ad7949_spi_write_cfg(struct ad7949_adc_chip *ad7949_adc, u16 val,
 	struct spi_transfer tx[] = {
 		{
 			.tx_buf = &ad7949_adc->buffer,
-			.len = 4,
+			.len = 2,
 			.bits_per_word = bits_per_word,
 		},
 	};
@@ -95,7 +95,7 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
 	struct spi_transfer tx[] = {
 		{
 			.rx_buf = &ad7949_adc->buffer,
-			.len = 4,
+			.len = 2,
 			.bits_per_word = bits_per_word,
 		},
 	};
-- 
2.17.1

