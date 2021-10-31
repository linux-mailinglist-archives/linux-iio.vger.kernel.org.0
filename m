Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296EB440ECF
	for <lists+linux-iio@lfdr.de>; Sun, 31 Oct 2021 15:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhJaOY2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 Oct 2021 10:24:28 -0400
Received: from www381.your-server.de ([78.46.137.84]:57598 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhJaOY1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 31 Oct 2021 10:24:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=O3ER5VFArpWcEvdVfpuabWk6VNIUxNY+gVGSVjs6QN0=; b=R2ytcOm38G4xSI0Qw/Ku/m12Nf
        Nw5Nh6OL3vuUenvYWK7zRw64Qxz2WdH89UMHGxHvEdS8aEhIq7UIX1fL/Y+mSFAZ+04KiWIZ7gnHL
        1Cb98V94/YkgdCqNIMg0G19EAzTKqNitLVtRUVLFDqbC2reDmd2OLYfWG9w5ldj3xnaPBecHaw0x7
        AD9TKFow2RMNUP0AteiZxG8kIzwnPZF0t7KlAqt5iLHwUrYHC5Fi7DxfPsYgIuHuWsq7Q2evIRndz
        cZ5zOguHAhcKyN4r42CC+TFolisB3YJtWKFQEZAesRnKt5FAHHo60lY4Nw0O+Im1I0WnJ2Eb98fIv
        MskbWzRg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mhBic-00069O-J5; Sun, 31 Oct 2021 15:21:54 +0100
Received: from [82.135.83.112] (helo=lars-desktop.fritz.box)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mhBic-000F2T-CH; Sun, 31 Oct 2021 15:21:54 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno Sa <Nuno.Sa@analog.com>,
        Matt Ranostay <mranostay@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 8/9] iio: gp2ap020a00f: Remove no-op trigger ops
Date:   Sun, 31 Oct 2021 15:21:29 +0100
Message-Id: <20211031142130.20791-8-lars@metafoo.de>
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
 drivers/iio/light/gp2ap020a00f.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index d1d9f2d319e4..b820041159f7 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -1467,9 +1467,6 @@ static const struct iio_buffer_setup_ops gp2ap020a00f_buffer_setup_ops = {
 	.predisable = &gp2ap020a00f_buffer_predisable,
 };
 
-static const struct iio_trigger_ops gp2ap020a00f_trigger_ops = {
-};
-
 static int gp2ap020a00f_probe(struct i2c_client *client,
 				const struct i2c_device_id *id)
 {
@@ -1550,8 +1547,6 @@ static int gp2ap020a00f_probe(struct i2c_client *client,
 		goto error_uninit_buffer;
 	}
 
-	data->trig->ops = &gp2ap020a00f_trigger_ops;
-
 	init_irq_work(&data->work, gp2ap020a00f_iio_trigger_work);
 
 	err = iio_trigger_register(data->trig);
-- 
2.20.1

