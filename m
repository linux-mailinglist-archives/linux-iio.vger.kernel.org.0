Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA2A133A764
	for <lists+linux-iio@lfdr.de>; Sun, 14 Mar 2021 19:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhCNSRl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Mar 2021 14:17:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:44930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233103AbhCNSRa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Mar 2021 14:17:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6BADF64E77;
        Sun, 14 Mar 2021 18:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615745849;
        bh=s5yXVp6LX5eRVmMkKAXkegOWvppVQyqScTFtdObQhAg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VE9EFSeqbwgiZFRV0++gTVj9mLlwIa2WNdbM2sv3maJqBL3/Y7zLBMTfimrI6fHUk
         00XrIGsdZYiPGfZBToxi8Q5z18Do2IavDd7PCyYHVn1qyQFeFoli4rCtPuEtYycD0v
         mrtfPZW+RbFRv1LQjacBPzjuhDGpapdJgz7fcmCuaqI645q3Eryu7J4JAvEclDG9uM
         jJfgvlXo6E2QSxl7pJuakguWXenK70FL8T0dj3M/P6R2Ie3xTXnHPYKz37fNGNUYQf
         rDOwvz+OpW7xi8fss/AhaPNL0U6fVcGm17macZCHElGSdRFw7nABW1zDzZpMTPrBSq
         jBasPt98P4ZMQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <aardelean@deviqon.com>, Robh+dt@kernel.org,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 03/24] staging:iio:cdc:ad7150: Refactor event parameter update
Date:   Sun, 14 Mar 2021 18:14:50 +0000
Message-Id: <20210314181511.531414-4-jic23@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210314181511.531414-1-jic23@kernel.org>
References: <20210314181511.531414-1-jic23@kernel.org>
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
Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Link: https://lore.kernel.org/r/20210207154623.433442-4-jic23@kernel.org
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
2.30.2

