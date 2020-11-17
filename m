Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3E352B5D09
	for <lists+linux-iio@lfdr.de>; Tue, 17 Nov 2020 11:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgKQKib (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Nov 2020 05:38:31 -0500
Received: from www381.your-server.de ([78.46.137.84]:50892 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbgKQKib (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Nov 2020 05:38:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=o01jxV4yO2dqpFkMwgXqdLSGGKEhMfhsu2EsZzRkYew=; b=M804rOM3NmfWqmPJ5WAKAXDQ3P
        hCo1r3TsTSJeD/X7RzROe8aXhSbNHdVCuK7nbQu2dOf5WG14OLUVKTuAg30SKAffr5XXK6gbJKgur
        MjGbKzKMCbn6fV/oHYx261CHYOB/rE8Zweb8DQ/ECXdnHLAm0NNUqdzM2usyanmBm+Qx23UVH/a2s
        DGOUdVHkEcSeAbZ2S5/SxkYsgQWKbq9DCpaoSKyol9yOGLH9OPkmx3LI9EFW/hLomLWgfDJieLKeL
        YiKY23rL44t41YwsU0Vi+YjzvVvaSY5PgFr3oNQrP/Y/ujAE+A/K3sy8JG+cH0uP8TamjpPApa/X6
        76kX5nPA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1keyNZ-00050e-1l; Tue, 17 Nov 2020 11:38:29 +0100
Received: from [62.216.202.98] (helo=lars-desktop.fritz.box)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1keyNY-0008jM-SB; Tue, 17 Nov 2020 11:38:28 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Christian Eggers <ceggers@arri.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 2/2] iio: sysfs-trigger: Mark irq_work to expire in hardirq context
Date:   Tue, 17 Nov 2020 11:37:51 +0100
Message-Id: <20201117103751.16131-2-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201117103751.16131-1-lars@metafoo.de>
References: <20201117103751.16131-1-lars@metafoo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/25990/Mon Nov 16 14:19:13 2020)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Mark the IIO sysfs-trigger irq_work with IRQ_WORK_HARD_IRQ to ensure that
it is always executed in hard interrupt context, even with PREEMPT_RT=y.

The IIO sysfs-trigger irq_work needs to run in hard interrupt context since
it will end up calling generic_handle_irq() which has the requirement to
run in hard interrupt context.

Note that the IRQ_WORK_HARD_IRQ flag, while it exists, does not seem to do
anything in the mainline kernel yet. It does have an effect in the RT
patchset though and presumably this is sooner or later going to be added to
mainline as well.

Reported-by: Christian Eggers <ceggers@arri.de>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
No changes since v1.
---
 drivers/iio/trigger/iio-trig-sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/trigger/iio-trig-sysfs.c b/drivers/iio/trigger/iio-trig-sysfs.c
index e09e58072872..10a3fd29362b 100644
--- a/drivers/iio/trigger/iio-trig-sysfs.c
+++ b/drivers/iio/trigger/iio-trig-sysfs.c
@@ -161,6 +161,7 @@ static int iio_sysfs_trigger_probe(int id)
 	iio_trigger_set_drvdata(t->trig, t);
 
 	init_irq_work(&t->work, iio_sysfs_trigger_work);
+	atomic_set(&t->work.flags, IRQ_WORK_HARD_IRQ);
 
 	ret = iio_trigger_register(t->trig);
 	if (ret)
-- 
2.20.1

