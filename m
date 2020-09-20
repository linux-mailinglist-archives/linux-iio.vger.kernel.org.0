Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7031027148A
	for <lists+linux-iio@lfdr.de>; Sun, 20 Sep 2020 15:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgITN14 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 20 Sep 2020 09:27:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:43524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbgITN1z (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 20 Sep 2020 09:27:55 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3621421789;
        Sun, 20 Sep 2020 13:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600608475;
        bh=jGML1WVRi4uqHDK500iKohEQq88l8IW+DXO39tBo4gA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kB4vQQYuhKrblLcWQyY/4OXZOtBRT++fbZVryslWVVIXkt20Ni9vXyFYK23NUmCpF
         Fb2Mcn/JcJIILldeKkt6LPmfN2jQhQn776xD97p88L9axCqNBmS+beRnEsJL7MgGX3
         5q8C2KOmwuoaQM1yrZ9YbnIWgMwNh1Oyxz2MjdOM=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Christian Eggers <ceggers@arri.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 1/2] iio: Fix: Do not poll the driver again if try_reenable() callback returns non 0.
Date:   Sun, 20 Sep 2020 14:25:47 +0100
Message-Id: <20200920132548.196452-2-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200920132548.196452-1-jic23@kernel.org>
References: <20200920132548.196452-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The original reason for this behaviour is long gone and no current
drivers are making use of this function correctly. Note however, that
you would be very unlucky to actually hit the problem as it would
require a bus comms failure in the callback.

This dates back a long way.  The original board on which I did a lot
of early IIO development only supported edge interrupts, but some of the
sensors were level interrupt based.  As such, the lis3l02dq driver did
a dance with checking a GPIO to identify if it should retrigger.
That was an unsustainable hack so we later just stopped supporting interrupts
for that particular combination.

There are a number of drivers where a fault on a bus read in the
try_reenable() callback will result in them returning non 0 and
incorrectly then causing iio_trigger_poll() to be called.

Anyhow, this handling is unused and causing issues so let us rip it out.
Link: https://lore.kernel.org/linux-iio/20200813075358.13310-1-lars@metafoo.de/

After this the try_reenable() naming makes no sense, so as a follow up
patch I'll rename it to simply reenable().  I haven't done that here
as it will add noise to the fix for backporting.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Christian Eggers <ceggers@arri.de>
---
 drivers/iio/industrialio-trigger.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 583bb51f65a7..f902be90980b 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -204,9 +204,7 @@ void iio_trigger_notify_done(struct iio_trigger *trig)
 {
 	if (atomic_dec_and_test(&trig->use_count) && trig->ops &&
 	    trig->ops->try_reenable)
-		if (trig->ops->try_reenable(trig))
-			/* Missed an interrupt so launch new poll now */
-			iio_trigger_poll(trig);
+		trig->ops->try_reenable(trig);
 }
 EXPORT_SYMBOL(iio_trigger_notify_done);
 
-- 
2.28.0

