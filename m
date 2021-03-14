Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C06F133A773
	for <lists+linux-iio@lfdr.de>; Sun, 14 Mar 2021 19:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbhCNSSS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Mar 2021 14:18:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:45198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233332AbhCNSRx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Mar 2021 14:17:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B29E64EE7;
        Sun, 14 Mar 2021 18:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615745872;
        bh=3gNza+00fZBZtTOKVwvC+yOPSmdSdZM9NLOppzvWbmE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R9F+kzpEBS9PnLU7GF47YG6HN8P0Vqox/yAatmrL2mQXb5yuIPGTXjS5IS94TvINK
         AVQitRfa7kJ4E7EVcwOc7HgjaSHDwH5eGsi68ZR/dOZGN8k2KC8shHmI1YBBk4SUgn
         y3kwN7DWSzdZkOHKoIZRGQtwQIIZ+y5bHmaDWub+3FmWf8K1O3Xy1YGxpfcHbAotkx
         Vx68xCUgyJKRsrnc7zYvxkyO+rEFftbxwCT5Sm+E6q74GBn91F3xvyI12teZQnhDMa
         JBnRp+GzHa4ZwoYYAOf36igzC7j+a/gK2K4n1wmFoMnkDo8uk+AOSLBlkMQDNQvExq
         oaLSPyAnXXNxw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <aardelean@deviqon.com>, Robh+dt@kernel.org,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 15/24] staging:iio:cdc:ad7150: Tidy up local variable positioning.
Date:   Sun, 14 Mar 2021 18:15:02 +0000
Message-Id: <20210314181511.531414-16-jic23@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210314181511.531414-1-jic23@kernel.org>
References: <20210314181511.531414-1-jic23@kernel.org>
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
Reviewed-by: Barry Song <song.bao.hua@hisilicon.com>
Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Link: https://lore.kernel.org/r/20210207154623.433442-16-jic23@kernel.org
---
 drivers/staging/iio/cdc/ad7150.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index 8131fbb56d37..1bfa71d7ca1d 100644
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
-	u8 thresh_type, cfg, fixed;
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
+		u8 thresh_type, cfg, fixed;
 
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
2.30.2

