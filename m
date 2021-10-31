Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E884440ECC
	for <lists+linux-iio@lfdr.de>; Sun, 31 Oct 2021 15:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbhJaOY1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 Oct 2021 10:24:27 -0400
Received: from www381.your-server.de ([78.46.137.84]:57576 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhJaOY1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 31 Oct 2021 10:24:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=jEbFWCaWEC+YBqa72rxZv+PXZkojri7OpZa48Mxv3Jw=; b=bVIaO7jskjfELxpTBn6IYwUa9I
        6eMkp/0vuNRNiU1/ruhHP53fa3yp851q/2J/54y8k8TkJiVf1cgStpBNdjqT0Zd8QnN26ADY1m2SS
        7M7wVT8xHRJ4uvOIaiZR+obavzGhw47OcCTnmdIU7AEBmRMsoONx6iMipZVx33VTkhaWv0K49s/V1
        NKOzYWRu9DDi2au5nOpbSUVvaoEhFbFu4Q74bnzlkqJdV8s3BSvmcuQcXiRqImbU0Kl4qSFYJ50Q4
        cOHtfY7F6WWwuT+xIipWjKMgWKgwn2bisWHKz/VKGzeII3JYc3LJjjlbU23Ajo+1Xn5mP96sVhb+E
        Z0onp1Wg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mhBic-00069L-G5; Sun, 31 Oct 2021 15:21:54 +0100
Received: from [82.135.83.112] (helo=lars-desktop.fritz.box)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mhBic-000F2T-9f; Sun, 31 Oct 2021 15:21:54 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno Sa <Nuno.Sa@analog.com>,
        Matt Ranostay <mranostay@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 7/9] iio: atlas-sensor: Remove no-op trigger ops
Date:   Sun, 31 Oct 2021 15:21:28 +0100
Message-Id: <20211031142130.20791-7-lars@metafoo.de>
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

The IIO core handles a trigger ops with all NULL callbacks the same as if
the trigger ops itself was NULL.

Remove the empty trigger ops from the interrupt trigger driver to slightly
reduce the boilerplate code. Object size of the driver module is also
slightly reduced.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/chemical/atlas-sensor.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
index 9cb99585b6ff..04b44a327614 100644
--- a/drivers/iio/chemical/atlas-sensor.c
+++ b/drivers/iio/chemical/atlas-sensor.c
@@ -434,9 +434,6 @@ static int atlas_buffer_predisable(struct iio_dev *indio_dev)
 	return 0;
 }
 
-static const struct iio_trigger_ops atlas_interrupt_trigger_ops = {
-};
-
 static const struct iio_buffer_setup_ops atlas_buffer_setup_ops = {
 	.postenable = atlas_buffer_postenable,
 	.predisable = atlas_buffer_predisable,
@@ -645,7 +642,6 @@ static int atlas_probe(struct i2c_client *client,
 	data->client = client;
 	data->trig = trig;
 	data->chip = chip;
-	trig->ops = &atlas_interrupt_trigger_ops;
 	iio_trigger_set_drvdata(trig, indio_dev);
 
 	i2c_set_clientdata(client, indio_dev);
-- 
2.20.1

