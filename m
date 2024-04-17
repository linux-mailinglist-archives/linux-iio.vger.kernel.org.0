Return-Path: <linux-iio+bounces-4308-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D84088A8955
	for <lists+linux-iio@lfdr.de>; Wed, 17 Apr 2024 18:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F6692823AE
	for <lists+linux-iio@lfdr.de>; Wed, 17 Apr 2024 16:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1255217106D;
	Wed, 17 Apr 2024 16:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZhKFfV9Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5470F16FF5A
	for <linux-iio@vger.kernel.org>; Wed, 17 Apr 2024 16:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713372399; cv=none; b=KqvFsII2seX8ZBDHvAm0qcarYmpzhj3IMVOUqLd5H1wB5TeXq0Os+qlrU5nA8msRdeTa86IKqOEnhcU8o4Oa7fPq3AdaS/J2ScJkBsJ5w30JXZWG2kMo4bL5VT6LC3pLntaiUbqZg0/ex+/3DiFzi6eSXUrvm+hVY2t1VVIhjAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713372399; c=relaxed/simple;
	bh=wZ3QxhBJiaOMw/VyXlSBTx2mSSnLkPa1eNl03oRZ8f0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aFUu9TnNAWZFJuhpW4vKCXabuwiOn/qTq5Ejpo5yugnRrJMBz1cNIISXMYiC8GwF70e4TlJ7HnT8nSv8S3IJSS03+zbpxQwIuUyjCfs1Y9GncW+PyxjQDlg5O7kx/5Q8C0H2/Wjrr7vPYXhtmbAdxn8HjCFsPCfRfzvpYy4fgaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZhKFfV9Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713372397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/kWFFgyICdCuvnm6V12HK3Hu8XORVXgNv8ShxjjESyI=;
	b=ZhKFfV9QTGSyMMuqOIasC+6BuYUGI3MmnQUbChLlU04rEYEBifGiGfDflyZeifYp3eDYn+
	jXoiy+D6+ok9S5eRYKl4Qiw+jrH0ylwCjCsca2Kofyn/Zlqkm6qcKppKUS/DrqZygx2Hoa
	qAQTAwVsWwaxIOvRtE92dSzmVzZqYFo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-XODW_6XMPNqUmD23ZU9WDQ-1; Wed, 17 Apr 2024 12:46:35 -0400
X-MC-Unique: XODW_6XMPNqUmD23ZU9WDQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6C65E18065AE;
	Wed, 17 Apr 2024 16:46:31 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.26])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A5A022166B34;
	Wed, 17 Apr 2024 16:46:30 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Sean Rhodes <sean@starlabs.systems>,
	linux-iio@vger.kernel.org
Subject: [PATCH 4/4] iio: accel: mxc4005: Read orientation matrix from ACPI ROTM method
Date: Wed, 17 Apr 2024 18:46:16 +0200
Message-ID: <20240417164616.74651-5-hdegoede@redhat.com>
In-Reply-To: <20240417164616.74651-1-hdegoede@redhat.com>
References: <20240417164616.74651-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Some devices use the semi-standard ACPI "ROTM" method to store
the accelerometers orientation matrix.

Add support for this using the new acpi_read_mount_matrix() helper, if
the helper fails to read the matrix fall back to iio_read_mount_matrix()
which will try to get it from device-properties (devicetree) and if
that fails it will fill the matrix with the identity matrix.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=218578
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/accel/mxc4005.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
index 9f38d3a08299..c54c98a4d902 100644
--- a/drivers/iio/accel/mxc4005.c
+++ b/drivers/iio/accel/mxc4005.c
@@ -17,6 +17,8 @@
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
 
+#include "acpi-helpers.h"
+
 #define MXC4005_DRV_NAME		"mxc4005"
 #define MXC4005_IRQ_NAME		"mxc4005_event"
 #define MXC4005_REGMAP_NAME		"mxc4005_regmap"
@@ -65,6 +67,7 @@ struct mxc4005_data {
 	struct mutex mutex;
 	struct regmap *regmap;
 	struct iio_trigger *dready_trig;
+	struct iio_mount_matrix orientation;
 	/* Ensure timestamp is naturally aligned */
 	struct {
 		__be16 chans[3];
@@ -272,6 +275,20 @@ static int mxc4005_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static const struct iio_mount_matrix *
+mxc4005_get_mount_matrix(const struct iio_dev *indio_dev,
+			   const struct iio_chan_spec *chan)
+{
+	struct mxc4005_data *data = iio_priv(indio_dev);
+
+	return &data->orientation;
+}
+
+static const struct iio_chan_spec_ext_info mxc4005_ext_info[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_TYPE, mxc4005_get_mount_matrix),
+	{ }
+};
+
 static const struct iio_info mxc4005_info = {
 	.read_raw	= mxc4005_read_raw,
 	.write_raw	= mxc4005_write_raw,
@@ -298,6 +315,7 @@ static const unsigned long mxc4005_scan_masks[] = {
 		.shift = 4,					\
 		.endianness = IIO_BE,				\
 	},							\
+	.ext_info = mxc4005_ext_info,				\
 }
 
 static const struct iio_chan_spec mxc4005_channels[] = {
@@ -440,6 +458,12 @@ static int mxc4005_probe(struct i2c_client *client)
 
 	mutex_init(&data->mutex);
 
+	if (!acpi_read_mount_matrix(&client->dev, &data->orientation, "ROTM")) {
+		ret = iio_read_mount_matrix(&client->dev, &data->orientation);
+		if (ret)
+			return ret;
+	}
+
 	indio_dev->channels = mxc4005_channels;
 	indio_dev->num_channels = ARRAY_SIZE(mxc4005_channels);
 	indio_dev->available_scan_masks = mxc4005_scan_masks;
-- 
2.44.0


