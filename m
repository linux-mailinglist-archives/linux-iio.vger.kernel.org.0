Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE30B18C203
	for <lists+linux-iio@lfdr.de>; Thu, 19 Mar 2020 22:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgCSVCw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Mar 2020 17:02:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:56328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbgCSVCw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 19 Mar 2020 17:02:52 -0400
Received: from lore-desk-wlan.redhat.com (unknown [151.48.128.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A184C2072D;
        Thu, 19 Mar 2020 21:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584651771;
        bh=J8Kg42/pOa/mjdkrRPabhgiCYuXFh3oizoWG/TZel10=;
        h=From:To:Cc:Subject:Date:From;
        b=C9vUKsh6YF/E6qqlEOsyLrCfpksvnprTXiUzENyAqxSPJIokrMOzMkUdNSvhjjNgc
         D7kqrEJH7J7Oysh+MC834bo7lK+fp28JMDQS9HFQJUuFGdCNKAK/tWCHly9jbOBFfZ
         vB7k4CHNGEf6NM2hOTrzkkuSPow3yLVqkjN+IAuc=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com,
        jimmyassarsson@gmail.com
Subject: [PATCH] iio: imu: st_lsm6dsx: configure full scale on slave device if supported
Date:   Thu, 19 Mar 2020 22:02:45 +0100
Message-Id: <cb3059b1ef8a5f0ebbd68a11db9931d6a2e4f44d.1584651650.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Introduce st_lsm6dsx_shub_set_full_scale routine in order to configure
the i2c slave device sensitivity

Tested-by: Jimmy Assarsson <jimmyassarsson@gmail.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 33 ++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
index 64ef07a30726..fec1dbd5f00d 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
@@ -518,6 +518,36 @@ st_lsm6dsx_shub_read_raw(struct iio_dev *iio_dev,
 	return ret;
 }
 
+static int
+st_lsm6dsx_shub_set_full_scale(struct st_lsm6dsx_sensor *sensor,
+			       u32 gain)
+{
+	const struct st_lsm6dsx_fs_table_entry *fs_table;
+	int i, err;
+
+	fs_table = &sensor->ext_info.settings->fs_table;
+	if (!fs_table->reg.addr)
+		return -ENOTSUPP;
+
+	for (i = 0; i < fs_table->fs_len; i++) {
+		if (fs_table->fs_avl[i].gain == gain)
+			break;
+	}
+
+	if (i == fs_table->fs_len)
+		return -EINVAL;
+
+	err = st_lsm6dsx_shub_write_with_mask(sensor, fs_table->reg.addr,
+					      fs_table->reg.mask,
+					      fs_table->fs_avl[i].val);
+	if (err < 0)
+		return err;
+
+	sensor->gain = gain;
+
+	return 0;
+}
+
 static int
 st_lsm6dsx_shub_write_raw(struct iio_dev *iio_dev,
 			  struct iio_chan_spec const *chan,
@@ -552,6 +582,9 @@ st_lsm6dsx_shub_write_raw(struct iio_dev *iio_dev,
 		}
 		break;
 	}
+	case IIO_CHAN_INFO_SCALE:
+		err = st_lsm6dsx_shub_set_full_scale(sensor, val2);
+		break;
 	default:
 		err = -EINVAL;
 		break;
-- 
2.25.1

