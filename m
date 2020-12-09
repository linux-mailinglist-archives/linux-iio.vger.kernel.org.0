Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D9E2D4F11
	for <lists+linux-iio@lfdr.de>; Thu, 10 Dec 2020 00:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgLIXv3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Dec 2020 18:51:29 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:40925 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732125AbgLIXtz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Dec 2020 18:49:55 -0500
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 6B15C240003;
        Wed,  9 Dec 2020 23:49:06 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 3/6] iio:pressure:ms5637: limit available sample frequencies
Date:   Thu, 10 Dec 2020 00:48:54 +0100
Message-Id: <20201209234857.1521453-4-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201209234857.1521453-1-alexandre.belloni@bootlin.com>
References: <20201209234857.1521453-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Avoid exposing all the sampling frequencies for chip that only support a
subset.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/iio/pressure/ms5637.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/pressure/ms5637.c b/drivers/iio/pressure/ms5637.c
index 351bfdb24fb4..2943b88734b3 100644
--- a/drivers/iio/pressure/ms5637.c
+++ b/drivers/iio/pressure/ms5637.c
@@ -36,8 +36,19 @@ struct ms_tp_data {
 };
 
 static const int ms5637_samp_freq[6] = { 960, 480, 240, 120, 60, 30 };
-/* String copy of the above const for readability purpose */
-static const char ms5637_show_samp_freq[] = "960 480 240 120 60 30";
+
+static ssize_t ms5637_show_samp_freq(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct ms_tp_dev *dev_data = iio_priv(indio_dev);
+	int i, len = 0;
+
+	for (i = 0; i <= dev_data->hw->max_res_index; i++)
+		len += scnprintf(buf + len, PAGE_SIZE - len, "%u ", ms5637_samp_freq[i]);
+	buf[len - 1] = '\n';
+
+	return len;
+}
 
 static int ms5637_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *channel, int *val,
@@ -114,10 +125,10 @@ static const struct iio_chan_spec ms5637_channels[] = {
 	}
 };
 
-static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(ms5637_show_samp_freq);
+static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(ms5637_show_samp_freq);
 
 static struct attribute *ms5637_attributes[] = {
-	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
+	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
 	NULL,
 };
 
-- 
2.28.0

