Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 346E5438ADB
	for <lists+linux-iio@lfdr.de>; Sun, 24 Oct 2021 19:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbhJXRPh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 Oct 2021 13:15:37 -0400
Received: from www381.your-server.de ([78.46.137.84]:54146 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbhJXRPg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 24 Oct 2021 13:15:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=WveDC516dlSgTwW/gTzbmeRKMFSyidxrCwfrreoF/1Y=; b=VUH0NsW1c9AdC2nbKj9kkuASpV
        DlFYqZhpx6PKgcFYKs9RKfIeANczM+gIqT0RK2Xi8jCaX9YylsONxfQJZKxwvpP6bX92TaMonecJI
        l62xmLHVmvhXbO9iknnpbzxsUy+OXTf+yyLnIjIimUTg5Zi+MFGHthlnxK6VMEUVa628sX31Yhi7v
        uHXOmnsEgRdrs05+N+dQx7ple23tDXLUOwIW57YhnQCkU8aA0eJV5eGl9vXoHDA256Wrlyx8wNCJt
        04TZxecp4U2eDGmdRgYJNDjfeQ77UCt//xP/bY8W9lGVdelgWHQOQTBgRcCYmXM9xQJmgvyu+fsUh
        JqmdUKeA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1meh3Z-000BgT-3u; Sun, 24 Oct 2021 19:13:13 +0200
Received: from [82.135.83.71] (helo=lars-desktop.fritz.box)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1meh3Y-000VNB-Uz; Sun, 24 Oct 2021 19:13:12 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Tiberiu Breana <tiberiu.a.breana@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/3] iio: stk3310: Don't return error code in interrupt handler
Date:   Sun, 24 Oct 2021 19:12:51 +0200
Message-Id: <20211024171251.22896-3-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211024171251.22896-1-lars@metafoo.de>
References: <20211024171251.22896-1-lars@metafoo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26332/Sun Oct 24 10:18:48 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Interrupt handlers must return one of the irqreturn_t values. Returning a
error code is not supported.

The stk3310 event interrupt handler returns an error code when reading the
flags register fails.

Fix the implementation to always return an irqreturn_t value.

Fixes: 3dd477acbdd1 ("iio: light: Add threshold interrupt support for STK3310")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/light/stk3310.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index 07e91846307c..fc63856ed54d 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -546,9 +546,8 @@ static irqreturn_t stk3310_irq_event_handler(int irq, void *private)
 	mutex_lock(&data->lock);
 	ret = regmap_field_read(data->reg_flag_nf, &dir);
 	if (ret < 0) {
-		dev_err(&data->client->dev, "register read failed\n");
-		mutex_unlock(&data->lock);
-		return ret;
+		dev_err(&data->client->dev, "register read failed: %d\n", ret);
+		goto out;
 	}
 	event = IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 1,
 				     IIO_EV_TYPE_THRESH,
@@ -560,6 +559,7 @@ static irqreturn_t stk3310_irq_event_handler(int irq, void *private)
 	ret = regmap_field_write(data->reg_flag_psint, 0);
 	if (ret < 0)
 		dev_err(&data->client->dev, "failed to reset interrupts\n");
+out:
 	mutex_unlock(&data->lock);
 
 	return IRQ_HANDLED;
-- 
2.20.1

