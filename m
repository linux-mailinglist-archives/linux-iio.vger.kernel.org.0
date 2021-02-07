Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47680312582
	for <lists+linux-iio@lfdr.de>; Sun,  7 Feb 2021 16:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbhBGPta (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Feb 2021 10:49:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:33728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229581AbhBGPt2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Feb 2021 10:49:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DEDBD64E4E;
        Sun,  7 Feb 2021 15:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612712927;
        bh=1egU6Yk0gIai2VfmnJdXpTGAUkrWXeZ9155v8/lJxBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qXw4u1z2Nfc528LYjAwGzY4PqbF4JZ4+LmJfBESO2KKK1PhtTP/2strcDyqYHtbKn
         TOMtO6/hjM9zaXffQ+JTW82rIsa/gDbJT04V02vMGbLK+mnGGe0cHTGXmFRv0DP4Ew
         R0ocziM0n2GSxtSCavPSb6bUaFLBWH0+Wfo+WlzgT+lsBfd8XQwBSd57H5n2AELnzz
         oX+RtGTtT5GiFOOe90vP76CjOD1ERHc1kXetO/dKm8HnwnzdpM6MinTdwZThpPqpIb
         wyPEiVKhqq+x9RfF0sg0RAX6ocgzTbHzRR31Avz9OprPIOCa5CRUxfxvwcsP+6brsL
         D5BK6/RstDA+A==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        song.bao.hua@hisilicon.com, robh+dt@kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 03/24] staging:iio:cdc:ad7150: Refactor event parameter update
Date:   Sun,  7 Feb 2021 15:46:02 +0000
Message-Id: <20210207154623.433442-4-jic23@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210207154623.433442-1-jic23@kernel.org>
References: <20210207154623.433442-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Original code was ordered in a fairly unituitive fashion with
the non adaptive threshold handling returning from the switch
statement, whilst the adapative path did the actual writes outside
the switch.   Make it more readable by bringing everything within
the switch statement cases and reducing scope of local variables
as appropriate.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/cdc/ad7150.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index 4dac4aaec0cf..d6a7bfd94f1c 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -163,9 +163,6 @@ static int ad7150_write_event_params(struct iio_dev *indio_dev,
 				     enum iio_event_type type,
 				     enum iio_event_direction dir)
 {
-	int ret;
-	u16 value;
-	u8 sens, timeout;
 	struct ad7150_chip_info *chip = iio_priv(indio_dev);
 	int rising = (dir == IIO_EV_DIR_RISING);
 	u64 event_code;
@@ -177,26 +174,31 @@ static int ad7150_write_event_params(struct iio_dev *indio_dev,
 
 	switch (type) {
 		/* Note completely different from the adaptive versions */
-	case IIO_EV_TYPE_THRESH:
-		value = chip->threshold[rising][chan];
+	case IIO_EV_TYPE_THRESH: {
+		u16 value = chip->threshold[rising][chan];
 		return i2c_smbus_write_word_swapped(chip->client,
 						    ad7150_addresses[chan][3],
 						    value);
-	case IIO_EV_TYPE_THRESH_ADAPTIVE:
+	}
+	case IIO_EV_TYPE_THRESH_ADAPTIVE: {
+		int ret;
+		u8 sens, timeout;
+
 		sens = chip->thresh_sensitivity[rising][chan];
+		ret = i2c_smbus_write_byte_data(chip->client,
+						ad7150_addresses[chan][4],
+						sens);
+		if (ret)
+			return ret;
+
 		timeout = chip->thresh_timeout[rising][chan];
-		break;
+		return i2c_smbus_write_byte_data(chip->client,
+						 ad7150_addresses[chan][5],
+						 timeout);
+	}
 	default:
 		return -EINVAL;
 	}
-	ret = i2c_smbus_write_byte_data(chip->client,
-					ad7150_addresses[chan][4],
-					sens);
-	if (ret)
-		return ret;
-	return i2c_smbus_write_byte_data(chip->client,
-					ad7150_addresses[chan][5],
-					timeout);
 }
 
 static int ad7150_write_event_config(struct iio_dev *indio_dev,
-- 
2.30.0

