Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409DF1B83FC
	for <lists+linux-iio@lfdr.de>; Sat, 25 Apr 2020 09:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgDYHBF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Apr 2020 03:01:05 -0400
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:40618 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbgDYHBF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Apr 2020 03:01:05 -0400
Received: from localhost.localdomain ([92.148.159.11])
        by mwinf5d16 with ME
        id Wv11220030F2omL03v11wU; Sat, 25 Apr 2020 09:01:03 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 25 Apr 2020 09:01:03 +0200
X-ME-IP: 92.148.159.11
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     lars@metafoo.de, Michael.Hennerich@analog.com,
        stefan.popa@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] iio: dac: ad5592r: Fix a typo in the name of a function
Date:   Sat, 25 Apr 2020 09:00:56 +0200
Message-Id: <20200425070056.31664-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This module is related to AD5592R, not AD5593R, so be consistent in naming.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/iio/dac/ad5592r.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ad5592r.c b/drivers/iio/dac/ad5592r.c
index 34ba059a77da..49308ad13c4b 100644
--- a/drivers/iio/dac/ad5592r.c
+++ b/drivers/iio/dac/ad5592r.c
@@ -98,7 +98,7 @@ static int ad5592r_reg_read(struct ad5592r_state *st, u8 reg, u16 *value)
 	return 0;
 }
 
-static int ad5593r_gpio_read(struct ad5592r_state *st, u8 *value)
+static int ad5592r_gpio_read(struct ad5592r_state *st, u8 *value)
 {
 	int ret;
 
@@ -121,7 +121,7 @@ static const struct ad5592r_rw_ops ad5592r_rw_ops = {
 	.read_adc = ad5592r_read_adc,
 	.reg_write = ad5592r_reg_write,
 	.reg_read = ad5592r_reg_read,
-	.gpio_read = ad5593r_gpio_read,
+	.gpio_read = ad5592r_gpio_read,
 };
 
 static int ad5592r_spi_probe(struct spi_device *spi)
-- 
2.20.1

