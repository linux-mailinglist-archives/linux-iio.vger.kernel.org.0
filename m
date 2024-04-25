Return-Path: <linux-iio+bounces-4514-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 170918B2213
	for <lists+linux-iio@lfdr.de>; Thu, 25 Apr 2024 14:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 489731C21502
	for <lists+linux-iio@lfdr.de>; Thu, 25 Apr 2024 12:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00971494C9;
	Thu, 25 Apr 2024 12:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GgNDXJOp"
X-Original-To: linux-iio@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0231494CB
	for <linux-iio@vger.kernel.org>; Thu, 25 Apr 2024 12:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714049893; cv=none; b=HklIBCD9sxMfpu1rk6DaL7QlFnjoDlnBJe3Y/trz0g8My4fay/gf5sWZmgkbQIJ65GOaW/H21C6QVPm0dntsXZYFyV0xII77g7KfnKJivN4AFjv15LEqBSLl+5WBo3RHW4QaZc+UFPK4X1x5JT3XIT94IAhij7wHckZ/1d01ztE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714049893; c=relaxed/simple;
	bh=xifCPLeSsTllBTlHjx9mLqoYlmQwvHNPWoJv5+zt088=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c4dKWeepPrk1UTz+wriGDNMtkhh/hDM1QCsavU4KBL9kwn+zswvgw3Ah7u+dUSfzTUGiURThnIdRFdrvV6DilhBlJYLH6MbUgHWqPQuqJUETInYtizhnpyXiLYywJUxbSguJgheGeJCv+gGzacqMAyvs3JLdVRoURtJRRvKvrBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GgNDXJOp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714049891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Io486Uu61TYMcQB80WqMDcmi/oy3OORWqJwK1emhiTQ=;
	b=GgNDXJOpMw1KUeXq935eRAJ5LTLbcKKZmuNw6/M+1ATSsIvUcYindbDuCA8dHuXbeyhVAb
	gXi0WiBcYMHW113COtJdt06v7X9r0XjsToXOiWFOONi1N1ywFY9dmZGXv7oAV6skUCp4+1
	Jlq/0b/vR040vK9aAXJIMe/aXPnhWdg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-B4qetLXGPxe5euNQpmZi_A-1; Thu,
 25 Apr 2024 08:58:05 -0400
X-MC-Unique: B4qetLXGPxe5euNQpmZi_A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 09A6938143A5;
	Thu, 25 Apr 2024 12:58:05 +0000 (UTC)
Received: from x1.nl (unknown [10.39.192.78])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A864B112131D;
	Thu, 25 Apr 2024 12:58:03 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Sean Rhodes <sean@starlabs.systems>,
	linux-iio@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>
Subject: [PATCH v3 4/4] iio: accel: mxc4005: Read orientation matrix from ACPI ROTM method
Date: Thu, 25 Apr 2024 14:57:54 +0200
Message-ID: <20240425125754.76010-5-hdegoede@redhat.com>
In-Reply-To: <20240425125754.76010-1-hdegoede@redhat.com>
References: <20240425125754.76010-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Some devices use the semi-standard ACPI "ROTM" method to store
the accelerometers orientation matrix.

Add support for this using the new iio_read_acpi_mount_matrix() helper, if
the helper fails to read the matrix fall back to iio_read_mount_matrix()
which will try to get it from device-properties (devicetree) and if
that fails it will fill the matrix with the identity matrix.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=218578
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/accel/mxc4005.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
index 9f38d3a08299..72f29e2af6df 100644
--- a/drivers/iio/accel/mxc4005.c
+++ b/drivers/iio/accel/mxc4005.c
@@ -65,6 +65,7 @@ struct mxc4005_data {
 	struct mutex mutex;
 	struct regmap *regmap;
 	struct iio_trigger *dready_trig;
+	struct iio_mount_matrix orientation;
 	/* Ensure timestamp is naturally aligned */
 	struct {
 		__be16 chans[3];
@@ -272,6 +273,20 @@ static int mxc4005_write_raw(struct iio_dev *indio_dev,
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
@@ -298,6 +313,7 @@ static const unsigned long mxc4005_scan_masks[] = {
 		.shift = 4,					\
 		.endianness = IIO_BE,				\
 	},							\
+	.ext_info = mxc4005_ext_info,				\
 }
 
 static const struct iio_chan_spec mxc4005_channels[] = {
@@ -440,6 +456,12 @@ static int mxc4005_probe(struct i2c_client *client)
 
 	mutex_init(&data->mutex);
 
+	if (!iio_read_acpi_mount_matrix(&client->dev, &data->orientation, "ROTM")) {
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


