Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCD01440ECE
	for <lists+linux-iio@lfdr.de>; Sun, 31 Oct 2021 15:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhJaOY1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 Oct 2021 10:24:27 -0400
Received: from www381.your-server.de ([78.46.137.84]:57554 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhJaOY1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 31 Oct 2021 10:24:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=jHDaVu7kVe/tjTs8thO0lQ1kYyoEAs+FwmNQSWYYpVc=; b=DlysyyqYC+6cmjtxE/+e0ctUa4
        ZaUqscuRiwwArMfjmq/Bm7DmJW5Ijw86oz6wvjB8HgqDMWnPVJeJt8UWIpblkRDag8KkriOCiW2Hc
        WsXP1lmXSoIC6uu4EnJE0Ec5djmzWFPME7g00aXm8eJUrhJxlDtkD3azbfRMNqnco0ZrCdy+lTRfR
        xW6HnZTfsTQbHIg/VCMAv2y3axQ2VxwO5cnJ/kLbqSnddQgjwQ3Kpky7pyr9RjpFqVncMOoYBrPD1
        ITMsB6Wpkr4a3xaYFfSa47NMp4xZjOnTsvML+1TAZAjh/TMcuxvAzBYXFJBVUnMALtglcoM93s1wK
        Kr3pwqiQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mhBic-000694-2V; Sun, 31 Oct 2021 15:21:54 +0100
Received: from [82.135.83.112] (helo=lars-desktop.fritz.box)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mhBib-000F2T-Sk; Sun, 31 Oct 2021 15:21:53 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno Sa <Nuno.Sa@analog.com>,
        Matt Ranostay <mranostay@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/9] iio: sysfs-trigger: Remove no-op trigger ops
Date:   Sun, 31 Oct 2021 15:21:23 +0100
Message-Id: <20211031142130.20791-2-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211031142130.20791-1-lars@metafoo.de>
References: <20211031142130.20791-1-lars@metafoo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26339/Sun Oct 31 09:18:16 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The IIO core handles a trigger ops with all NULL callbacks the
same as if the trigger ops itself was NULL.

Remove the empty trigger ops from the interrupt trigger driver to slightly
reduce the boilerplate code. Object size of the driver module is also
slightly reduced.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/trigger/iio-trig-sysfs.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iio/trigger/iio-trig-sysfs.c b/drivers/iio/trigger/iio-trig-sysfs.c
index e9adfff45b39..2a4b75897910 100644
--- a/drivers/iio/trigger/iio-trig-sysfs.c
+++ b/drivers/iio/trigger/iio-trig-sysfs.c
@@ -124,9 +124,6 @@ static const struct attribute_group *iio_sysfs_trigger_attr_groups[] = {
 	NULL
 };
 
-static const struct iio_trigger_ops iio_sysfs_trigger_ops = {
-};
-
 static int iio_sysfs_trigger_probe(int id)
 {
 	struct iio_sysfs_trig *t;
@@ -156,7 +153,6 @@ static int iio_sysfs_trigger_probe(int id)
 	}
 
 	t->trig->dev.groups = iio_sysfs_trigger_attr_groups;
-	t->trig->ops = &iio_sysfs_trigger_ops;
 	iio_trigger_set_drvdata(t->trig, t);
 
 	t->work = IRQ_WORK_INIT_HARD(iio_sysfs_trigger_work);
-- 
2.20.1

