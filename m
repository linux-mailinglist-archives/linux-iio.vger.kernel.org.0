Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 408CF441CC5
	for <lists+linux-iio@lfdr.de>; Mon,  1 Nov 2021 15:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbhKAOnx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 Nov 2021 10:43:53 -0400
Received: from www381.your-server.de ([78.46.137.84]:34708 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbhKAOnw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 Nov 2021 10:43:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=ETG+4vdMHRn8TZ85+qnqDk1BL/LkrYfAtdt8NQJdkc4=; b=DATcXcZS9m6DbPCyiMq01WMW1E
        SOQ31x8x+m4KEhSk0i9YBGWC0oh3Opm3mFasCfkgetlNEJCcktbJpv6Jq5bb2AECRA61I8s8GZA6n
        LidZ8sBrGMIIlGI30BiPdg2fXOt2qH3O+5mudO2xOavTwqCKJxQWwqcMniO7GNdKyv2BT3JoZ8llq
        i5XBvkOsusmt7cO4sqolwvNoiaWmcwqJqlRwMm388XQtpEXInFvY8CO5AdG4oP1f7YSmxci+dk5Lx
        66nw/Z503lcRCxuIc2UNh+hwDAwgzl8dZjF/nnydyMNa7G/hsjnToTFcKoJb8fNxUpSAeYpLKVFYx
        y5RaqWxw==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mhYUu-0009ir-N9; Mon, 01 Nov 2021 15:41:16 +0100
Received: from [82.135.83.112] (helo=lars-desktop.fritz.box)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mhYUu-000WpK-Ho; Mon, 01 Nov 2021 15:41:16 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno Sa <Nuno.Sa@analog.com>,
        Manuel Stahl <manuel.stahl@iis.fraunhofer.de>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] iio: ad7768-1: Call iio_trigger_notify_done() on error
Date:   Mon,  1 Nov 2021 15:40:55 +0100
Message-Id: <20211101144055.13858-2-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211101144055.13858-1-lars@metafoo.de>
References: <20211101144055.13858-1-lars@metafoo.de>
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

The ad7768-1 driver neglects to call iio_trigger_notify_done() when there
is an error reading the converter data. Fix this by making sure that
iio_trigger_notify_done() is included in the error exit path.

Fixes: a5f8c7da3dbe ("iio: adc: Add AD7768-1 ADC basic support")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/ad7768-1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 2c5c8a3672b2..aa42ba759fa1 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -480,8 +480,8 @@ static irqreturn_t ad7768_trigger_handler(int irq, void *p)
 	iio_push_to_buffers_with_timestamp(indio_dev, &st->data.scan,
 					   iio_get_time_ns(indio_dev));
 
-	iio_trigger_notify_done(indio_dev->trig);
 err_unlock:
+	iio_trigger_notify_done(indio_dev->trig);
 	mutex_unlock(&st->lock);
 
 	return IRQ_HANDLED;
-- 
2.20.1

