Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BE66B6BAE
	for <lists+linux-iio@lfdr.de>; Sun, 12 Mar 2023 22:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjCLVJn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Mar 2023 17:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjCLVJm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Mar 2023 17:09:42 -0400
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922A623649
        for <linux-iio@vger.kernel.org>; Sun, 12 Mar 2023 14:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
        s=default2002; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=04GA5pIu/hBYNK1Hk1wD+nRNsL2iEY6YXTo9hY22+i0=; b=TY3+kamFrISLYls/pwZjE7wUUw
        dE7bMoMADTVh+fuKzpzK+W4V7vVd2H4mIJJk5Xd2uCJKetBa3GXAP/o4qk/1RqomlfNIXX7yWCkHm
        QxAq5QOt91E9d9URX2E5xkwCGIc6xY7DY8pufKl5aeT/pe0zVZl35dB7hS9J4EnSIgJQbyoYwIDBT
        p/2jm7h7SKHkeAMVEi9VwxRn3RvvZHNakiYcUDq/pNr6uEIFFzLG7XZH7BIhpS4qs68DtUOrVh+32
        iSttiygs0SYuSTv8tljKdwWTI0rNBzX2V7FLc+g2801GPkV+2PPTGqAaswwLGsTK+U8gvTtKAf4oT
        33PJt/SQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <lars@metafoo.de>)
        id 1pbSwl-000Jqf-C2; Sun, 12 Mar 2023 22:09:39 +0100
Received: from [2604:5500:c0e5:eb00:da5e:d3ff:feff:933b] (helo=lars-desktop.lan)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1pbSwk-000Q5l-TD; Sun, 12 Mar 2023 22:09:39 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     David Lechner <david@lechnology.com>,
        Justin Chen <justinpopo6@gmail.com>, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio: adc: ti-ads7950: Set `can_sleep` flag for GPIO chip
Date:   Sun, 12 Mar 2023 14:09:33 -0700
Message-Id: <20230312210933.2275376-1-lars@metafoo.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.8/26839/Sun Mar 12 09:22:48 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ads7950 uses a mutex as well as SPI transfers in its GPIO callbacks.
This means these callbacks can sleep and the `can_sleep` flag should be
set.

Having the flag set will make sure that warnings are generated when calling
any of the callbacks from a potentially non-sleeping context.

Fixes: c97dce792dc8 ("iio: adc: ti-ads7950: add GPIO support")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
Sorry if you received this twice. Forgot to cc the mailinglist on the first
try.
---
 drivers/iio/adc/ti-ads7950.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
index 2cc9a9bd9db6..263fc3a1b87e 100644
--- a/drivers/iio/adc/ti-ads7950.c
+++ b/drivers/iio/adc/ti-ads7950.c
@@ -634,6 +634,7 @@ static int ti_ads7950_probe(struct spi_device *spi)
 	st->chip.label = dev_name(&st->spi->dev);
 	st->chip.parent = &st->spi->dev;
 	st->chip.owner = THIS_MODULE;
+	st->chip.can_sleep = true;
 	st->chip.base = -1;
 	st->chip.ngpio = TI_ADS7950_NUM_GPIOS;
 	st->chip.get_direction = ti_ads7950_get_direction;
-- 
2.30.2

