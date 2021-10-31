Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1D1F440D73
	for <lists+linux-iio@lfdr.de>; Sun, 31 Oct 2021 08:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbhJaHgP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 Oct 2021 03:36:15 -0400
Received: from www381.your-server.de ([78.46.137.84]:57618 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhJaHgP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 31 Oct 2021 03:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=/Kz4Nl7/ygoukCVewyCImg7B3E+WFW6kJ/c7aDREi+g=; b=jQu20gNNFRaRUoJ9IZmw+osQSA
        /FWlyT+QBZdd8jXoGi3W0eZixvbJfoTAsp6Mnoq53Me3ds4RF37+eE3JXbsc3MSslomD5ptC6T848
        HwKQu8Rac8C7BS7LqSp/B8jvmzAqUyAWW4OwsBQ1HcOqDO8Se/K6ZxWQqHDXy2oLf0hr5Ze81VP6M
        WVxNXyt9iPh/fS9y3TdAPTdJUXL38sWLg4gtjPnIHfJ1Gwpds29crwIoUEVdWzfJ4sKDSKPochBuO
        paXlrOt5qTssik6O29BxV2y/ahA7yMlGbZVdv2R1enP/nUxUiR1t82yD14Ee60PImtQDyas7Y0f2h
        UCwklFoQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mh5Lb-000FTb-3w; Sun, 31 Oct 2021 08:33:43 +0100
Received: from [82.135.83.71] (helo=lars-desktop.fritz.box)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mh5La-00059C-VK; Sun, 31 Oct 2021 08:33:42 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] iio: viio_trigger_alloc(): Correctly free trigger on error
Date:   Sun, 31 Oct 2021 08:32:31 +0100
Message-Id: <20211031073231.13780-2-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211031073231.13780-1-lars@metafoo.de>
References: <20211031073231.13780-1-lars@metafoo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26338/Sat Oct 30 10:21:41 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Once device_initialize() has been called on a struct device the device must
be freed by decreasing the reference count rather than directly freeing the
underlying memory.

This is so that any additional state and resources associated with the
device get properly freed.

In this particular case there are no additional resources associated with
the device and no additional reference count. So there is no resource leak
or use-after-free by freeing the struct device directly

But in order to follow best practices and avoid accidental future breakage
use put_device() instead of kfree() to free the device when an error
occurs.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/industrialio-trigger.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 93990ff1dfe3..d566e8d4a14b 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -480,7 +480,7 @@ static void iio_trig_release(struct device *device)
 	struct iio_trigger *trig = to_iio_trigger(device);
 	int i;
 
-	if (trig->subirq_base) {
+	if (trig->subirq_base > 0) {
 		for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++) {
 			irq_modify_status(trig->subirq_base + i,
 					  IRQ_NOAUTOEN,
@@ -541,11 +541,11 @@ struct iio_trigger *viio_trigger_alloc(struct device *parent,
 					    CONFIG_IIO_CONSUMERS_PER_TRIGGER,
 					    0);
 	if (trig->subirq_base < 0)
-		goto free_trig;
+		goto err_put_trig;
 
 	trig->name = kvasprintf(GFP_KERNEL, fmt, vargs);
 	if (trig->name == NULL)
-		goto free_descs;
+		goto err_put_trig;
 
 	trig->subirq_chip.name = trig->name;
 	trig->subirq_chip.irq_mask = &iio_trig_subirqmask;
@@ -559,10 +559,8 @@ struct iio_trigger *viio_trigger_alloc(struct device *parent,
 
 	return trig;
 
-free_descs:
-	irq_free_descs(trig->subirq_base, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
-free_trig:
-	kfree(trig);
+err_put_trig:
+	put_device(&trig->dev);
 	return NULL;
 }
 
-- 
2.20.1

