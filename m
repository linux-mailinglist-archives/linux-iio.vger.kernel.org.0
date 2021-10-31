Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17AA8440ED3
	for <lists+linux-iio@lfdr.de>; Sun, 31 Oct 2021 15:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhJaOY3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 Oct 2021 10:24:29 -0400
Received: from www381.your-server.de ([78.46.137.84]:57602 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhJaOY1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 31 Oct 2021 10:24:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=D6dUBrz9B7jarc4xBRjnUJZlGyYXPMil1WMjX+A2LUc=; b=QatdTpgh4ggKEkEBjZ28jpS8G0
        hC9EndygaWzSBEXEDwoapcrGxpACOeMMYGFLEp+iH1lVyi8cTrpJWnpDbnGl0LFzB0DC/G/R44IHL
        Ff/Hb3yqap6yYHM+vq5V2L7kk7Fbsd02W2kYu4c6+IZSuUaxnWG619UNAiOCSjmNnnsk3fJd2evql
        +ZtnhUqnF6fpYlmtRIahBtnCL9X29DA1zaCKDWi+07qeoA4JXe1GLRbpR5jnukMKotgYPIkoqzNeu
        cDjuiytfwamZYekGH/ExqFAm+IPuu1g6SNwdfOKlMNsJTPgH8pxE/p4P2Gjvvo2KwwmtrYplZL9rS
        aWIfIIBg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mhBic-00069V-Lm; Sun, 31 Oct 2021 15:21:54 +0100
Received: from [82.135.83.112] (helo=lars-desktop.fritz.box)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mhBic-000F2T-En; Sun, 31 Oct 2021 15:21:54 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno Sa <Nuno.Sa@analog.com>,
        Matt Ranostay <mranostay@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 9/9] iio: lmp91000: Remove no-op trigger ops
Date:   Sun, 31 Oct 2021 15:21:30 +0100
Message-Id: <20211031142130.20791-9-lars@metafoo.de>
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
 drivers/iio/potentiostat/lmp91000.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
index ed30bdaa10ec..fe514f0b5506 100644
--- a/drivers/iio/potentiostat/lmp91000.c
+++ b/drivers/iio/potentiostat/lmp91000.c
@@ -271,9 +271,6 @@ static int lmp91000_buffer_cb(const void *val, void *private)
 	return 0;
 }
 
-static const struct iio_trigger_ops lmp91000_trigger_ops = {
-};
-
 static int lmp91000_buffer_postenable(struct iio_dev *indio_dev)
 {
 	struct lmp91000_data *data = iio_priv(indio_dev);
@@ -330,7 +327,6 @@ static int lmp91000_probe(struct i2c_client *client,
 		return -ENOMEM;
 	}
 
-	data->trig->ops = &lmp91000_trigger_ops;
 	init_completion(&data->completion);
 
 	ret = lmp91000_read_config(data);
-- 
2.20.1

