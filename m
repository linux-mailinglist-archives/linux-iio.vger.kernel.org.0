Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC915441CC6
	for <lists+linux-iio@lfdr.de>; Mon,  1 Nov 2021 15:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbhKAOnx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 Nov 2021 10:43:53 -0400
Received: from www381.your-server.de ([78.46.137.84]:34712 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbhKAOnw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 Nov 2021 10:43:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=ALFLYeBZ2oUI6MC6Ckantl6xoFsQyuUavx3fLKN7D14=; b=kIkg0k09BRh9NEmhgNinOve+vN
        ZdUmB4mqu1Ewi+KeDR4iwu6CCYeMCRREPY93tCy3eU+UnOXnMy08sGE3rkUti9+x40zRQwVZ2TELq
        yf5n/uMcWP0aUYRINVYiSo940QtXj9/8kqaEqHC9fUZo5xJQmnjjwOW7RZ/SVfplwY9zbrNLZHA00
        oOOBKtjXScY89dtcfM0bEJRAp1n1/cTHXAQsMUC3GQYeGSttW6Hr6Ak7n7Ei01uPu+AymZecmLdqa
        SInIFx+JmhcV2IGHnr1zKBdf7GT2LpXgDF3ZT0x9WjQunQNBgDdhOk/f8vvEfYSjQHxz+CQk8fGGW
        sYZGBgrw==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mhYUu-0009ip-Lv; Mon, 01 Nov 2021 15:41:16 +0100
Received: from [82.135.83.112] (helo=lars-desktop.fritz.box)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mhYUu-000WpK-Fb; Mon, 01 Nov 2021 15:41:16 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno Sa <Nuno.Sa@analog.com>,
        Manuel Stahl <manuel.stahl@iis.fraunhofer.de>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] iio: itg3200: Call iio_trigger_notify_done() on error
Date:   Mon,  1 Nov 2021 15:40:54 +0100
Message-Id: <20211101144055.13858-1-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26340/Mon Nov  1 09:21:46 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

IIO trigger handlers must call iio_trigger_notify_done() when done. This
must be done even when an error occurred. Otherwise the trigger will be
seen as busy indefinitely and the trigger handler will never be called
again.

The itg3200 driver neglects to call iio_trigger_notify_done() when there is
an error reading the gyro data. Fix this by making sure that
iio_trigger_notify_done() is included in the error exit path.

Fixes: 9dbf091da080 ("iio: gyro: Add itg3200")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/gyro/itg3200_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/gyro/itg3200_buffer.c b/drivers/iio/gyro/itg3200_buffer.c
index 04dd6a7969ea..4cfa0d439560 100644
--- a/drivers/iio/gyro/itg3200_buffer.c
+++ b/drivers/iio/gyro/itg3200_buffer.c
@@ -61,9 +61,9 @@ static irqreturn_t itg3200_trigger_handler(int irq, void *p)
 
 	iio_push_to_buffers_with_timestamp(indio_dev, &scan, pf->timestamp);
 
+error_ret:
 	iio_trigger_notify_done(indio_dev->trig);
 
-error_ret:
 	return IRQ_HANDLED;
 }
 
-- 
2.20.1

