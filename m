Return-Path: <linux-iio+bounces-4426-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 297BC8ACA2A
	for <lists+linux-iio@lfdr.de>; Mon, 22 Apr 2024 12:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AC5F1C21061
	for <lists+linux-iio@lfdr.de>; Mon, 22 Apr 2024 10:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C1E13CFB7;
	Mon, 22 Apr 2024 10:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h05iLSW+"
X-Original-To: linux-iio@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CA413D521
	for <linux-iio@vger.kernel.org>; Mon, 22 Apr 2024 10:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713780153; cv=none; b=pOMAXH53ipExJcS6hB6IOoX7z6x2JqTYAm1wfnyPdTMv+90yyEkzuiMt9giEeNmmaTxzWUf62cGoq7fiUgP0VPxL/w2y53xNePBw+nzcp8QNDgCVq5Avamh0J/owe754UEOT6tt5lc9dO5gh2iUPMmc3JMxOp+++CMMLbrzY1vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713780153; c=relaxed/simple;
	bh=wZ3QxhBJiaOMw/VyXlSBTx2mSSnLkPa1eNl03oRZ8f0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V3rvCmMc1sfGNbj8qvnPSY2wWq+X8ZO2OyfQBsAW4JMdKPPlnnvFDbZZeZZUhI52DsWKCYX8iAC3onc1mkd2pA5EI2Icpy1GoCOeBHHkEfSLQKSk9A8tLN3PBWX//3LZgk3iGWwaFn5MOXVSEgiCbemzFKiNkpMjEtSF15VmaSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h05iLSW+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713780150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/kWFFgyICdCuvnm6V12HK3Hu8XORVXgNv8ShxjjESyI=;
	b=h05iLSW+daiHzkpr6cVZZlfEYjynddAgJLTvCKDGwXpPTtJCKvFhfczaUZ9EZFLAfH1eAu
	oWGmeZuicmwdl/aY881faHLYPPSWR5VevTLKMP4h+SO1OKjqWOZOgHE1ZjqAfhEcN/OJSQ
	obWcfwpmRuzxkn2wJFlRsl1oIGDovUo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-vegu3ixBNdaEY3q59NzfYQ-1; Mon, 22 Apr 2024 06:02:27 -0400
X-MC-Unique: vegu3ixBNdaEY3q59NzfYQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 34497104B507;
	Mon, 22 Apr 2024 10:02:27 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.192.177])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4C49D44047;
	Mon, 22 Apr 2024 10:02:26 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Sean Rhodes <sean@starlabs.systems>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH v2 4/4] iio: accel: mxc4005: Read orientation matrix from ACPI ROTM method
Date: Mon, 22 Apr 2024 12:02:18 +0200
Message-ID: <20240422100218.7693-5-hdegoede@redhat.com>
In-Reply-To: <20240422100218.7693-1-hdegoede@redhat.com>
References: <20240422100218.7693-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

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


