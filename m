Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD341C5958
	for <lists+linux-iio@lfdr.de>; Tue,  5 May 2020 16:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbgEEOYu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 May 2020 10:24:50 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:40945 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729315AbgEEOYp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 May 2020 10:24:45 -0400
Received: from localhost.localdomain ([149.172.19.189]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MY5wD-1jdHa241VN-00YOBN; Tue, 05 May 2020 16:24:12 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH] iio: adc: ad7476: fix clang -Wpointer-bool-conversion warning
Date:   Tue,  5 May 2020 16:23:58 +0200
Message-Id: <20200505142408.1113763-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:vBk959c9QorF7QsCYU41aH9goxp0ICkrLgIuIDeOigWieoPf80S
 ROZMpyWePeM9q+THfBXanGEvcMubL4WRB0dY5oSyb2hadPzuAt/HHY7qPK2o9UI1vO8F7X1
 xmxjCheC8aoKCybULo0fC9vvxeo9/KZaM9rlVaAruelm+Ics8NSygUbL0S7wSY4Xa4AMNNT
 JBVof8OBtVXU+lwRCwzAg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:eRPxKtH3rQU=:O5EVI4xC2GZ/gUmRfA8SEw
 WLMV/tRzDP8/jZ6j93yp6zKZkNqaZi6ho0ZD0mmcnWTHb8unGGHG8p17UjfC/QAqxuL+OepH+
 pNpsruObntEUuGQRs6KSvo6ALNTlFYsbMqrGlkCg2iVU905tHTatj0KyMUk8En0aPLdsr8xQh
 lBiy2yQ1dsRatPxPSpRg0aOBQaLodxFN90PH7+NRnsQq0jKhwIMfElbK3UTWC/8CE67Q0BDN0
 7Jk4DTlcFuLPq+1/PevJMHNqCUfEFiEeo0mCMzzQju4QxZtuRD0PtHmGs96mp3w8KdFap+TzK
 dH+PLMKxwmAF1SD2CcN8ZJxkiEJnWJ8ysQ8mhQcstzm6usepW6GhYLgh+JGvTx0fASzoGGMIu
 jrdERlp623EKOL8Zc8tt0wEkfMjef84zrN9OskqN84Fx8+O4sUNZ/7dXuZmW/unOKhZm5opXu
 Fo1JIgmr1XOJeQrDZWof3OPiD4JT6zK+K5vWY9n+o0l+ZkWm4LRwsvdUTh/+MZ/mybkQcoz8I
 YAUfjbr331qFqmlQt2+gTT3ewvYzdf3qXGtRN45rDcah7kZyAu+sCp8quakIQZp7NAc8eb+vR
 8bUQSGMnLpUX2kuUov+7dYYZtjVSFPXwKDqMyiCnPtSFkMhWi807hkXer7YgHXk4CO4Tlkztl
 cdihF7m2ELTFKb1QsMKcporA0fPiTqiEh7UnEBBST7iCEgCPtse8w0ibaZABCa8MrD7lWkSNa
 QRyeIc5krxE2JiAqQVO8ZJlryNOauUaEI3FVNWJ3Pxxv4PwcYoiIidVaqXbnSAF4OlUsHC0wP
 +1bS0ize47c3VMZNnhnurkFpWS9RcICVxk4/n7TrsbcC2IlAZ0=
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Checking the pointer value of st->chip_info->convst_channel is pointless
since this this an array inside of a struct: even if st->chip_info is NULL,
the pointer is non-zero. Clang warns about this:

drivers/iio/adc/ad7476.c:312:40: warning: address of array 'st->chip_info->convst_channel' will always evaluate to 'true' [-Wpointer-bool-conversion]
        if (st->convst_gpio && st->chip_info->convst_channel)
                            ~~ ~~~~~~~~~~~~~~~^~~~~~~~~~~~~~

I could not come up with a sane way to check whether the entry
is valid, so just remove the check and keep the behavior as it
is today but without the warning.

Fixes: 3a6af93dd66e ("iio: adc: ad7476: Add IIO_CHAN_INFO_RAW for AD7091R")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iio/adc/ad7476.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index e9984a38fc4c..4e816d714ad2 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -309,7 +309,7 @@ static int ad7476_probe(struct spi_device *spi)
 	indio_dev->num_channels = 2;
 	indio_dev->info = &ad7476_info;
 
-	if (st->convst_gpio && st->chip_info->convst_channel)
+	if (st->convst_gpio)
 		indio_dev->channels = st->chip_info->convst_channel;
 	/* Setup default message */
 
-- 
2.26.0

