Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBBE370810
	for <lists+linux-iio@lfdr.de>; Sat,  1 May 2021 19:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbhEAREF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 May 2021 13:04:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:47560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231342AbhEAREC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 May 2021 13:04:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 62A5E6157F;
        Sat,  1 May 2021 17:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619888592;
        bh=Os8CvOp/eMVW6m2sKI8BCf+BQB2Cozl1YzqRhCEBQiA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kKbM3z6RaAe3jzim5gsbnufEJu/++wn+991/Kz5Tu9a+ELaOZZ/ALBHaPNtMe0SkD
         x92oRAF2Xm3zksw0EBIgJmHftWQrlnE3oJXGBgA6BC3XFVjHhMTTsItTKXW6C77lRy
         gZrRSBGJ3+Z22bUvxXz78rJSNdEh72Pf6zHcpfAhyO17qTZF9M/0WgfV5TBpttQqlx
         8vOJNqtP6lXoc2uvwwcPKT3H+QT9UK9cpTX1j39VUbRe+KJtLc0uHd/iJcirB5jAG9
         Nu0USHcbOSuJRpc4wJUHiLqEGzOB2P0r4kw+WO+vDth1RwIXcSm9io57PP+93Kc/Qo
         0IsX9IH1vaYaA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH 13/19] iio: prox: pulsed-light: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
Date:   Sat,  1 May 2021 18:01:15 +0100
Message-Id: <20210501170121.512209-14-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210501170121.512209-1-jic23@kernel.org>
References: <20210501170121.512209-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

To make code more readable, use a structure to express the channel
layout and ensure the timestamp is 8 byte aligned.

Found during an audit of all calls of uses of
iio_push_to_buffers_with_timestamp()

Fixes: cb119d535083 ("iio: proximity: add support for PulsedLight LIDAR")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
index c685f10b5ae4..822a68ae5e03 100644
--- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
+++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
@@ -44,7 +44,11 @@ struct lidar_data {
 	int (*xfer)(struct lidar_data *data, u8 reg, u8 *val, int len);
 	int i2c_enabled;
 
-	u16 buffer[8]; /* 2 byte distance + 8 byte timestamp */
+	/* Ensure timestamp is naturally aligned */
+	struct {
+		u16 chan;
+		s64 timestamp __aligned(8);
+	} scan;
 };
 
 static const struct iio_chan_spec lidar_channels[] = {
@@ -229,9 +233,9 @@ static irqreturn_t lidar_trigger_handler(int irq, void *private)
 	struct lidar_data *data = iio_priv(indio_dev);
 	int ret;
 
-	ret = lidar_get_measurement(data, data->buffer);
+	ret = lidar_get_measurement(data, &data->scan.chan);
 	if (!ret) {
-		iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
+		iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
 						   iio_get_time_ns(indio_dev));
 	} else if (ret != -EINVAL) {
 		dev_err(&data->client->dev, "cannot read LIDAR measurement");
-- 
2.31.1

