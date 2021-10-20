Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B449434766
	for <lists+linux-iio@lfdr.de>; Wed, 20 Oct 2021 10:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbhJTI4X (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 Oct 2021 04:56:23 -0400
Received: from www381.your-server.de ([78.46.137.84]:56834 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhJTI4X (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 Oct 2021 04:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=brKZzvrn6yKcx8iuVOfO5r3VnKOlvnoS0ccbmHsX7tU=; b=jqWLEjw5yUGTxV5fr4iWlTRm58
        kKs7hdCLFhxTzgDAyWXRy4C1/GuFWLJPWJQWuXVDvT8lBBjG2DfabzzqWCB6vMqTtWLDpBusWJvVC
        lzJR3C514VIOJPczVISebqyRTKkBDCdrfBkxSxGLbXdTWSVbQ4tLedtcvTGtpENHkk+WoVgO4iiI2
        iGCTmLuDnqRNCjT+0FGbgsnwWEhHIw9RG5R3UfBrXsNLSMIk6pCwZZH4rqkncFR0YtIHe1DDu9e2L
        SqSTHpWsYKVsyOvTX1P32yPdh24a+lyO6woQxYx/dI/86utlAr+rYM+GS/41KEcZUxcVftDHnriyb
        SosbEvpQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1md7MN-000AcQ-Dd; Wed, 20 Oct 2021 10:54:07 +0200
Received: from [82.135.83.71] (helo=lars-desktop.fritz.box)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1md7MN-000QJl-7M; Wed, 20 Oct 2021 10:54:07 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Denis Ciocca <denis.ciocca@st.com>, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio: st-sensors: Use dev_to_iio_dev() in sysfs callbacks
Date:   Wed, 20 Oct 2021 10:53:49 +0200
Message-Id: <20211020085349.16178-1-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26327/Tue Oct 19 13:35:20 2021)
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
 drivers/iio/common/st_sensors/st_sensors_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index 1de395bda03e..eb452d0c423c 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -638,7 +638,7 @@ ssize_t st_sensors_sysfs_sampling_frequency_avail(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	int i, len = 0;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
 
 	mutex_lock(&indio_dev->mlock);
@@ -660,7 +660,7 @@ ssize_t st_sensors_sysfs_scale_avail(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	int i, len = 0, q, r;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
 
 	mutex_lock(&indio_dev->mlock);
-- 
2.20.1

