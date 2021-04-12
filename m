Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D44C635C419
	for <lists+linux-iio@lfdr.de>; Mon, 12 Apr 2021 12:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237440AbhDLKgE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Apr 2021 06:36:04 -0400
Received: from fgw21-7.mail.saunalahti.fi ([62.142.5.82]:36200 "EHLO
        fgw21-7.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237219AbhDLKgD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Apr 2021 06:36:03 -0400
X-Greylist: delayed 963 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Apr 2021 06:36:02 EDT
Received: from localhost (88-115-248-186.elisa-laajakaista.fi [88.115.248.186])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id 97175cf6-9b78-11eb-9eb8-005056bdd08f;
        Mon, 12 Apr 2021 13:19:40 +0300 (EEST)
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Cristian Pop <cristian.pop@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v1 1/1] iio: adc: ad7768-1: Keep fwnode reference count balanced
Date:   Mon, 12 Apr 2021 13:19:04 +0300
Message-Id: <20210412101904.2054406-1-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The commit 75ed0be7200d ("iio: adc: ad7768-1: Add channel labels.")
missed the point that loop counter should be put after use. Otherwise
the reference count of it will become unbalanced.

Fixes: 75ed0be7200d ("iio: adc: ad7768-1: Add channel labels.")
Cc: Cristian Pop <cristian.pop@analog.com>
Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/adc/ad7768-1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index c945f1349623..c488bd4bfeba 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -565,6 +565,7 @@ static int ad7768_set_channel_label(struct iio_dev *indio_dev,
 
 		st->labels[crt_ch] = label;
 	}
+	fwnode_handle_put(fwnode);
 
 	return 0;
 }
-- 
2.31.1

