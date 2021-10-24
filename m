Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 777F84387E6
	for <lists+linux-iio@lfdr.de>; Sun, 24 Oct 2021 11:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbhJXJ3v (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 Oct 2021 05:29:51 -0400
Received: from www381.your-server.de ([78.46.137.84]:60932 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbhJXJ3u (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 24 Oct 2021 05:29:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=fD5y+86hpSacwZ5irExf2GQC0HqyX7O6dkahfaGcJmc=; b=OryVkA4Z6vBC2jkV7SeeXo206u
        2aC/bTcXMIOABcZ6drePznNXEGyZPY0Z9oRrrwdX46o8vNeDADKyo9v6tYIcHnAO5Y1+EzGPnKMdT
        Cmf6vaiHYBCgK0sjyCkFN6rrl26yf/XOShqpBo8b797SF5/ZrBELfJD/3gKyFICx8oXLVz9xswm+h
        5NyP533qKmpykXG1A2myI0PWwafOMpqLYmrJ4m6R/T5y2hn3XZb81rZweHEjxAN5bQ+hTvlCwGPjU
        X7KUsLZSfO9RP6//EqJ4N3eWghAsCwGIb3ztOJAxmsIyDEwIfaJhPx+k2sa7DBDZXnxnJ3KEHdu/G
        kApikO/Q==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1meZmr-000Bch-6n; Sun, 24 Oct 2021 11:27:29 +0200
Received: from [82.135.83.71] (helo=lars-desktop.fritz.box)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1meZmr-0003Um-0d; Sun, 24 Oct 2021 11:27:29 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Martin Fuzzey <mfuzzey@parkeon.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] iio: trigger: Fix reference counting
Date:   Sun, 24 Oct 2021 11:27:00 +0200
Message-Id: <20211024092700.6844-2-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211024092700.6844-1-lars@metafoo.de>
References: <20211024092700.6844-1-lars@metafoo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26332/Sun Oct 24 10:18:48 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In viio_trigger_alloc() device_initialize() is used to set the initial
reference count of the trigger to 1. Then another get_device() is called on
trigger. This sets the reference count to 2 before the trigger is returned.

iio_trigger_free(), which is the matching API to viio_trigger_alloc(),
calls put_device() which decreases the reference count by 1. But the second
reference count acquired in viio_trigger_alloc() is never dropped.

As a result the iio_trigger_release() function is never called and the
memory associated with the trigger is never freed.

Since there is no reason for the trigger to start its lifetime with two
reference counts just remove the extra get_device() in
viio_trigger_alloc().

Fixes: 5f9c035cae18 ("staging:iio:triggers. Add a reference get to the core for triggers.")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
I'm a bit unsure about the fixes tag. I've looked at the IIO tree at the
point when this was introduced and I believe it was incorrect even back
then.

But we also had a few drivers that directly assigned the indio_dev->trig
without getting an extra reference. So these two bugs, one in the core, one
in the drivers sort of even out. Except that iio_trigger_get() also gets a
reference to the drivers module and iio_trigger_put() releases it again. So
with the missing iio_trigger_get() there is still the problem that, even
though the device references balance out, there is a module reference count
imbalance.
---
 drivers/iio/industrialio-trigger.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index b23caa2f2aa1..93990ff1dfe3 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -556,7 +556,6 @@ struct iio_trigger *viio_trigger_alloc(struct device *parent,
 		irq_modify_status(trig->subirq_base + i,
 				  IRQ_NOREQUEST | IRQ_NOAUTOEN, IRQ_NOPROBE);
 	}
-	get_device(&trig->dev);
 
 	return trig;
 
-- 
2.20.1

