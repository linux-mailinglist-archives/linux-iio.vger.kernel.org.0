Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB1166BEE0
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jan 2023 14:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjAPNLU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Jan 2023 08:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbjAPNLD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Jan 2023 08:11:03 -0500
Received: from frolo.macqel.be (smtp2.macqel.be [109.135.2.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 39CE223C5A
        for <linux-iio@vger.kernel.org>; Mon, 16 Jan 2023 05:08:46 -0800 (PST)
Received: by frolo.macqel.be (Postfix, from userid 1000)
        id 64538DF00AC; Mon, 16 Jan 2023 14:07:45 +0100 (CET)
From:   Philippe De Muyter <Philippe.DeMuyter@macq.eu>
To:     lorenzo@kernel.org, linux-iio@vger.kernel.org
Cc:     Philippe De Muyter <phdm@macqel.be>
Subject: [PATCH v2 1/2] iio: imu: st_lsm6dsx: fix naming of 'struct iio_info' in st_lsm6dsx_shub.c.
Date:   Mon, 16 Jan 2023 14:07:13 +0100
Message-Id: <1673874434-30750-2-git-send-email-Philippe.DeMuyter@macq.eu>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1673874434-30750-1-git-send-email-Philippe.DeMuyter@macq.eu>
References: <1673874434-30750-1-git-send-email-Philippe.DeMuyter@macq.eu>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Philippe De Muyter <phdm@macqel.be>

We need the name 'st_lsm6dsx_ext_info' for the actual 'iio_chan_spec_ext_info'.
Rename the 'st_lsm6dsx_ext_info' in st_lsm6dsx_shub.c to 'st_lsm6dsx_shub_info'.
For consistency, replace also 'ext' by 'shub' in 'st_lsm6dsx_ext_attributes'
and 'st_lsm6dsx_ext_attribute_group'.

Signed-off-by: Philippe De Muyter <phdm@macqel.be>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
index f2b64b4956a3..c1b444520d2a 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
@@ -704,18 +704,18 @@ static ssize_t st_lsm6dsx_shub_scale_avail(struct device *dev,
 static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(st_lsm6dsx_shub_sampling_freq_avail);
 static IIO_DEVICE_ATTR(in_scale_available, 0444,
 		       st_lsm6dsx_shub_scale_avail, NULL, 0);
-static struct attribute *st_lsm6dsx_ext_attributes[] = {
+static struct attribute *st_lsm6dsx_shub_attributes[] = {
 	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
 	&iio_dev_attr_in_scale_available.dev_attr.attr,
 	NULL,
 };
 
-static const struct attribute_group st_lsm6dsx_ext_attribute_group = {
-	.attrs = st_lsm6dsx_ext_attributes,
+static const struct attribute_group st_lsm6dsx_shub_attribute_group = {
+	.attrs = st_lsm6dsx_shub_attributes,
 };
 
-static const struct iio_info st_lsm6dsx_ext_info = {
-	.attrs = &st_lsm6dsx_ext_attribute_group,
+static const struct iio_info st_lsm6dsx_shub_info = {
+	.attrs = &st_lsm6dsx_shub_attribute_group,
 	.read_raw = st_lsm6dsx_shub_read_raw,
 	.write_raw = st_lsm6dsx_shub_write_raw,
 	.hwfifo_set_watermark = st_lsm6dsx_set_watermark,
@@ -737,7 +737,7 @@ st_lsm6dsx_shub_alloc_iiodev(struct st_lsm6dsx_hw *hw,
 		return NULL;
 
 	iio_dev->modes = INDIO_DIRECT_MODE;
-	iio_dev->info = &st_lsm6dsx_ext_info;
+	iio_dev->info = &st_lsm6dsx_shub_info;
 
 	sensor = iio_priv(iio_dev);
 	sensor->id = id;
-- 
2.31.1

