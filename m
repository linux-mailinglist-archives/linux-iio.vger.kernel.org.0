Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC81433110
	for <lists+linux-iio@lfdr.de>; Tue, 19 Oct 2021 10:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbhJSIcN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Oct 2021 04:32:13 -0400
Received: from www381.your-server.de ([78.46.137.84]:46386 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbhJSIcL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Oct 2021 04:32:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=z+iWw2NTZJqEK3Zb1ZnADuT55TU3zQMAJMxtSY4DXUY=; b=gld4NrNf/TyT8LRkYPZq1Z7Nr0
        QmFVLgFmDdm7d1R2iltHQNCH2Ds2/PmAdBcSt/8/pKT2I9lLP5PqtC0oRmRhG/IZrV83voObpdL6A
        JlWt5dKYNEXQBHlm9avbGrK/a+LBeqlYkC3U4Dk21Z8LRqyz/Y6l5zxFXxP2B1dm3MBZIMIJFbROS
        dQA664ZTlbvywzPE5AFc5di1jqrFMBp5i1qIxS62zgR+B11vXdZlRsFEZI0Mkg5kvVj/Mr8CpFfu9
        fYetQI8eS/hUi77sG9vUf6CAp2jaCPq/P0h/5PKQ65zhzE49W9xIwvJTtu+9hcupj5MNhlITwDrEv
        qjiZ8goA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mckVR-0008lT-OV; Tue, 19 Oct 2021 10:29:57 +0200
Received: from [82.135.83.71] (helo=lars-desktop.fritz.box)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mckVR-0000Lx-K3; Tue, 19 Oct 2021 10:29:57 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Eugen Hristev <eugen.hristev@microchip.com>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] iio: at91-sama5d2: Use dev_to_iio_dev() in sysfs callbacks
Date:   Tue, 19 Oct 2021 10:29:29 +0200
Message-Id: <20211019082929.30503-2-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211019082929.30503-1-lars@metafoo.de>
References: <20211019082929.30503-1-lars@metafoo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26326/Mon Oct 18 10:19:08 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Using `dev_get_drvdata()` in IIO sysfs callbacks to get a pointer to the
IIO device is a relic from the very early days of IIO. The IIO core as well
as most other drivers have switched over to using `dev_to_iio_dev()`
instead.

This driver is one of the last few drivers remaining that uses the outdated
idiom, update it. This will allow to eventually update the IIO core to no
longer set the drvdata for the IIO device and free it up for driver usage.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 3841e7b6c81d..a2c406276329 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -1825,7 +1825,7 @@ static void at91_adc_hw_init(struct iio_dev *indio_dev)
 static ssize_t at91_adc_get_fifo_state(struct device *dev,
 				       struct device_attribute *attr, char *buf)
 {
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct at91_adc_state *st = iio_priv(indio_dev);
 
 	return scnprintf(buf, PAGE_SIZE, "%d\n", !!st->dma_st.dma_chan);
@@ -1834,7 +1834,7 @@ static ssize_t at91_adc_get_fifo_state(struct device *dev,
 static ssize_t at91_adc_get_watermark(struct device *dev,
 				      struct device_attribute *attr, char *buf)
 {
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct at91_adc_state *st = iio_priv(indio_dev);
 
 	return scnprintf(buf, PAGE_SIZE, "%d\n", st->dma_st.watermark);
-- 
2.20.1

