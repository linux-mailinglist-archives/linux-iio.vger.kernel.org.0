Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A44D37AAB7
	for <lists+linux-iio@lfdr.de>; Tue, 11 May 2021 17:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbhEKPbk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 May 2021 11:31:40 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:25455 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbhEKPbh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 May 2021 11:31:37 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.7]) by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee8609aa306443-09d98; Tue, 11 May 2021 23:30:14 +0800 (CST)
X-RM-TRANSID: 2ee8609aa306443-09d98
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.22.251.112])
        by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee4609aa30251e-f151c;
        Tue, 11 May 2021 23:30:14 +0800 (CST)
X-RM-TRANSID: 2ee4609aa30251e-f151c
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     Michael.Hennerich@analog.com, lars@metafoo.de, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH] iio: adc: ad7768-1: Fix the right interrupt interface calls
Date:   Tue, 11 May 2021 23:31:08 +0800
Message-Id: <20210511153108.14816-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In the function ad7768_probe(), the devm_request_irq() should
call ad7768_interrupt, not &ad7768_interrupt, so fix this mistake.

Fixes: a5f8c7da3dbe ("iio: adc: Add AD7768-1 ADC basic support")
Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/iio/adc/ad7768-1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 0e93b0766..9c9ab56d6 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -605,7 +605,7 @@ static int ad7768_probe(struct spi_device *spi)
 	init_completion(&st->completion);
 
 	ret = devm_request_irq(&spi->dev, spi->irq,
-			       &ad7768_interrupt,
+			       ad7768_interrupt,
 			       IRQF_TRIGGER_RISING | IRQF_ONESHOT,
 			       indio_dev->name, indio_dev);
 	if (ret)
-- 
2.20.1.windows.1



