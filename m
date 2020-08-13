Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5F224358E
	for <lists+linux-iio@lfdr.de>; Thu, 13 Aug 2020 09:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgHMHyu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 Aug 2020 03:54:50 -0400
Received: from www381.your-server.de ([78.46.137.84]:48652 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbgHMHys (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 Aug 2020 03:54:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=kseFHIrYtMArcuIr7UZEvMpSII4I4pmSCP9jh0NPbik=; b=RMN+LCs2IMNMtea1KU8f8Sw72L
        3W4rBtyJN2bxjenoIUeYKKV45ZdbPN7EbqlGJ8omGjN0uwTUV5LduEaoyqAGrfzK4jd+BnOFG3rHt
        OknKNQpCSlsBvoTahFAQzwH0Iq9IcIUlrMkG++a1vRYaTKQ55m8Y+cb9jBSOH1SSHlLdA5tyIj+Xs
        o8M8WkJ3RBYJm9Fk17sSEyOTQNbgaLqf4AZnbG0vCc7xpLMJ2IHwacJGxyRCVEpuqNMjnvO3/qVQT
        hlQ0RQ3taMZX4u8AJbBINHTyrgYzX6ea2U7cxDIuzMKt/D0VUsGEGGemZdh5PYhX9aAPKQLdMCQgq
        41IZZJEQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1k684U-00069o-V9; Thu, 13 Aug 2020 09:54:46 +0200
Received: from [2001:a61:2517:6d01:9e5c:8eff:fe01:8578] (helo=lars-desktop.fritz.box)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1k684U-000C5M-Qc; Thu, 13 Aug 2020 09:54:46 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Christian Eggers <ceggers@arri.de>, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] iio: sysfs-trigger: Mark irq_work to expire in hardirq context
Date:   Thu, 13 Aug 2020 09:53:58 +0200
Message-Id: <20200813075358.13310-2-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200813075358.13310-1-lars@metafoo.de>
References: <20200813075358.13310-1-lars@metafoo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/25900/Mon Aug 10 14:44:29 2020)
Sender: linux-iio-owner@vger.kernel.org
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

