Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5391231258D
	for <lists+linux-iio@lfdr.de>; Sun,  7 Feb 2021 16:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhBGPu1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Feb 2021 10:50:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:34028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229650AbhBGPuZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Feb 2021 10:50:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8DBD364E5D;
        Sun,  7 Feb 2021 15:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612712945;
        bh=9bCbymbbviS1pIvSoNX1oyz7bcGvrgD7rv/3Bka0rOU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qoKY5QemVUtwtqQAKENhFQBQWzddhuTB+8/xcBPynDdIqAfsxlrK5i0lTbv5o5DyV
         /Hj+G6fZJc1p2oRD2MwwmadJEhLn7k4dndVX/fspvnVoynZW/+xIc+LhbA5/M3Y+k5
         6gHk8lOSNFEa/14PgiFtjSggNim3LZSWeT3L+OTi4/9O/eo3LqQnzQcXIvOC+kp+xM
         cSDsmBeD9m+BIXHoL3m6RRH+7d81IEg6gy80o70zDyz6yXvL+8GZ7pNTwG085NaXum
         okQleel8G1QkOa2ViPJbQvt/3b38UtLyjty15LmS0cANVxxKM0Bt1mTXyAvdzba5F2
         eR/BJf/9lmyow==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        song.bao.hua@hisilicon.com, robh+dt@kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 15/24] staging:iio:cdc:ad7150: Tidy up local variable positioning.
Date:   Sun,  7 Feb 2021 15:46:14 +0000
Message-Id: <20210207154623.433442-16-jic23@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210207154623.433442-1-jic23@kernel.org>
References: <20210207154623.433442-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Where there is no other basis on which to order declarations
let us prefer reverse xmas tree.  Also reduce scope where
sensible.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/cdc/ad7150.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index 9e88e774752f..d530b467d1b2 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -108,9 +108,9 @@ static int ad7150_read_raw(struct iio_dev *indio_dev,
 			   int *val2,
 			   long mask)
 {
-	int ret;
 	struct ad7150_chip_info *chip = iio_priv(indio_dev);
 	int channel = chan->channel;
+	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -143,10 +143,10 @@ static int ad7150_read_event_config(struct iio_dev *indio_dev,
 				    enum iio_event_type type,
 				    enum iio_event_direction dir)
 {
-	int ret;
+	struct ad7150_chip_info *chip = iio_priv(indio_dev);
 	u8 threshtype;
 	bool thrfixed;
-	struct ad7150_chip_info *chip = iio_priv(indio_dev);
+	int ret;
 
 	ret = i2c_smbus_read_byte_data(chip->client, AD7150_CFG_REG);
 	if (ret < 0)
@@ -227,10 +227,8 @@ static int ad7150_write_event_config(struct iio_dev *indio_dev,
 				     enum iio_event_type type,
 				     enum iio_event_direction dir, int state)
 {
-	u8 thresh_type, cfg, adaptive;
-	int ret;
 	struct ad7150_chip_info *chip = iio_priv(indio_dev);
-	int rising = (dir == IIO_EV_DIR_RISING);
+	int ret;
 
 	/*
 	 * There is only a single shared control and no on chip
@@ -251,6 +249,8 @@ static int ad7150_write_event_config(struct iio_dev *indio_dev,
 
 	mutex_lock(&chip->state_lock);
 	if ((type != chip->type) || (dir != chip->dir)) {
+		int rising = (dir == IIO_EV_DIR_RISING);
+		u8 thresh_type, cfg, adaptive;
 
 		/*
 		 * Need to temporarily disable both interrupts if
@@ -533,9 +533,9 @@ static const struct iio_info ad7150_info_no_irq = {
 static int ad7150_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
-	int ret;
 	struct ad7150_chip_info *chip;
 	struct iio_dev *indio_dev;
+	int ret;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
 	if (!indio_dev)
-- 
2.30.0

