Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 914F21B7628
	for <lists+linux-iio@lfdr.de>; Fri, 24 Apr 2020 15:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgDXNE1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Apr 2020 09:04:27 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50751 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgDXNE1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Apr 2020 09:04:27 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jRy0C-0007Vi-69; Fri, 24 Apr 2020 13:04:20 +0000
From:   Colin King <colin.king@canonical.com>
To:     Dragos Bogdan <dragos.bogdan@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] iio: adc: ad7476: remove redundant null check on an array
Date:   Fri, 24 Apr 2020 14:04:19 +0100
Message-Id: <20200424130419.22940-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The null check on st->chip_info->convst_channel is redundant because
convst_channel is a 2 element array of struct iio_chan_spec objects
and this can never be null. Fix this by removing the null check.

Addresses-Coverity: ("Array compared against 0")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
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
2.25.1

