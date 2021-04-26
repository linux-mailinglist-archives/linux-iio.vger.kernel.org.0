Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C5A36B858
	for <lists+linux-iio@lfdr.de>; Mon, 26 Apr 2021 19:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237635AbhDZRv3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Apr 2021 13:51:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:48558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237557AbhDZRv2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 26 Apr 2021 13:51:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ECFC8613B3;
        Mon, 26 Apr 2021 17:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619459446;
        bh=VQZdDSqZD5zazOZGU1N3BZNK6DyJUwxVWaZG3Ualtl0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bqrHewHzvJn1Yo+P4uGnw8i7zvj16NSLdc1+uh+0+AyB+oZ3p2zu5qscC5T//XcwL
         QW8+BcFXHVPPHvZYjnm+TE3rLvbPzwU901j/Q/w6W2P1CD7eZB3ORVq+UYV2PJE580
         hb2sgP6EYVUgm9EH3LmiHRrnQPBRIOxSPN5U/yNX09fJJTzLbOzU3y8c+OTldzb53w
         S+rLRXtBL7QI52qgsxhFXGcWFBtkM5YKnJc1ji3OCYGU1DT/RCNrad5hoyOjLUx4Dp
         zhbMaDn+2JPq/6Ai0Bk8T/5GLUCLa2KyqVEWlG4vUObt9CuMsLXawuV3Bz8+MiIQZU
         x8svInghengKw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 9/9] iio: core: move @clock_id from struct iio_dev to struct iio_dev_opaque
Date:   Mon, 26 Apr 2021 18:49:11 +0100
Message-Id: <20210426174911.397061-10-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210426174911.397061-1-jic23@kernel.org>
References: <20210426174911.397061-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

There is already an acessor function used to access it, making this
move straight forward.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/industrialio-core.c | 14 +++++++++++++-
 include/linux/iio/iio-opaque.h  |  2 ++
 include/linux/iio/iio.h         | 12 +-----------
 3 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 4a4c02fea152..efb4cf91c9e4 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -271,13 +271,25 @@ int iio_device_set_clock(struct iio_dev *indio_dev, clockid_t clock_id)
 		mutex_unlock(&indio_dev->mlock);
 		return -EBUSY;
 	}
-	indio_dev->clock_id = clock_id;
+	iio_dev_opaque->clock_id = clock_id;
 	mutex_unlock(&indio_dev->mlock);
 
 	return 0;
 }
 EXPORT_SYMBOL(iio_device_set_clock);
 
+/**
+ * iio_device_get_clock() - Retrieve current timestamping clock for the device
+ * @indio_dev: IIO device structure containing the device
+ */
+clockid_t iio_device_get_clock(const struct iio_dev *indio_dev)
+{
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
+
+	return iio_dev_opaque->clock_id;
+}
+EXPORT_SYMBOL(iio_device_get_clock);
+
 /**
  * iio_get_time_ns() - utility function to get a time stamp for events etc
  * @indio_dev: device
diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
index d7c3036861ac..c9504e9da571 100644
--- a/include/linux/iio/iio-opaque.h
+++ b/include/linux/iio/iio-opaque.h
@@ -24,6 +24,7 @@
  * @legacy_scan_el_group:	attribute group for legacy scan elements attribute group
  * @legacy_buffer_group:	attribute group for legacy buffer attributes group
  * @scan_index_timestamp:	cache of the index to the timestamp
+ * @clock_id:			timestamping clock posix identifier
  * @chrdev:			associated character device
  * @flags:			file ops related flags including busy flag.
  * @debugfs_dentry:		device specific debugfs dentry
@@ -51,6 +52,7 @@ struct iio_dev_opaque {
 	struct attribute_group		legacy_buffer_group;
 
 	unsigned int			scan_index_timestamp;
+	clockid_t			clock_id;
 	struct cdev			chrdev;
 	unsigned long			flags;
 
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index ed0537015eee..5606a3f4c4cb 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -509,7 +509,6 @@ struct iio_buffer_setup_ops {
  * @name:		[DRIVER] name of the device.
  * @label:              [DRIVER] unique name to identify which device this is
  * @info:		[DRIVER] callbacks and constant info from driver
- * @clock_id:		[INTERN] timestamping clock posix identifier
  * @setup_ops:		[DRIVER] callbacks to call before and after buffer
  *			enable/disable
  * @priv:		[DRIVER] reference to driver's private information
@@ -538,7 +537,6 @@ struct iio_dev {
 	const char			*name;
 	const char			*label;
 	const struct iio_info		*info;
-	clockid_t			clock_id;
 	const struct iio_buffer_setup_ops	*setup_ops;
 
 	void				*priv;
@@ -589,15 +587,7 @@ static inline void iio_device_put(struct iio_dev *indio_dev)
 		put_device(&indio_dev->dev);
 }
 
-/**
- * iio_device_get_clock() - Retrieve current timestamping clock for the device
- * @indio_dev: IIO device structure containing the device
- */
-static inline clockid_t iio_device_get_clock(const struct iio_dev *indio_dev)
-{
-	return indio_dev->clock_id;
-}
-
+clockid_t iio_device_get_clock(const struct iio_dev *indio_dev);
 int iio_device_set_clock(struct iio_dev *indio_dev, clockid_t clock_id);
 
 /**
-- 
2.31.1

