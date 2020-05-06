Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7231C6677
	for <lists+linux-iio@lfdr.de>; Wed,  6 May 2020 05:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgEFDwS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 May 2020 23:52:18 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:21793 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgEFDwS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 May 2020 23:52:18 -0400
Received: from localhost.localdomain ([93.23.13.221])
        by mwinf5d40 with ME
        id bFsD2200H4m9Yy503FsDqi; Wed, 06 May 2020 05:52:16 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 06 May 2020 05:52:16 +0200
X-ME-IP: 93.23.13.221
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, info@metux.net, gregkh@linuxfoundation.org,
        dan.carpenter@oracle.com, tglx@linutronix.de
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] iio: sca3000: Remove an erroneous 'get_device()'
Date:   Wed,  6 May 2020 05:52:06 +0200
Message-Id: <20200506035206.192173-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This looks really unusual to have a 'get_device()' hidden in a 'dev_err()'
call.
Remove it.

While at it add a missing \n at the end of the message.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is purely speculative.
I've looked a bit arround and see no point for this get_device() but other
eyes are welcomed :)
---
 drivers/iio/accel/sca3000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index 66d768d971e1..6e429072e44a 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -980,7 +980,7 @@ static int sca3000_read_data(struct sca3000_state *st,
 	st->tx[0] = SCA3000_READ_REG(reg_address_high);
 	ret = spi_sync_transfer(st->us, xfer, ARRAY_SIZE(xfer));
 	if (ret) {
-		dev_err(get_device(&st->us->dev), "problem reading register");
+		dev_err(&st->us->dev, "problem reading register\n");
 		return ret;
 	}
 
-- 
2.25.1

