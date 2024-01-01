Return-Path: <linux-iio+bounces-1367-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0C68213D5
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jan 2024 14:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 945EA281C3C
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jan 2024 13:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B28623DB;
	Mon,  1 Jan 2024 13:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/Ps2hdz"
X-Original-To: linux-iio@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFE83C32
	for <linux-iio@vger.kernel.org>; Mon,  1 Jan 2024 13:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704115958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=P3WH5Y20SUQlcjrcbkj8nmIyl5JG1Z6m8oiI5cjlfK8=;
	b=U/Ps2hdzZrTTylEKmj04KW9R8+egbeNpBPFhbU3Sbw57zengdZHMCv51H0QPXfJ2HImnHY
	BN6HJnw9d0KF7i4i2UsEo5tEU5Dx8D1hnSIExCz/8wdUB4XnyQ3+DVB7yFCf1roAu3HTdS
	EfsKtvOatRVDyfr4MSx0qi7yj6F3ZFk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-fGMjfHvCM0qK0jmjCLNaOw-1; Mon, 01 Jan 2024 08:32:36 -0500
X-MC-Unique: fGMjfHvCM0qK0jmjCLNaOw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 92990879840;
	Mon,  1 Jan 2024 13:32:36 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.60])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 73F8951D5;
	Mon,  1 Jan 2024 13:32:35 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: accel: da280: Simplify id-matching
Date: Mon,  1 Jan 2024 14:32:34 +0100
Message-ID: <20240101133234.10310-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

da280_match_acpi_device() is a DIY version of acpi_device_get_match_data(),
so it can be dropped.

And things can be simplified further by using i2c_get_match_data() which
will also check i2c_client_id style ids.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/accel/da280.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/iio/accel/da280.c b/drivers/iio/accel/da280.c
index 572bfe9694b0..e4cd4b3a28ab 100644
--- a/drivers/iio/accel/da280.c
+++ b/drivers/iio/accel/da280.c
@@ -89,17 +89,6 @@ static const struct iio_info da280_info = {
 	.read_raw	= da280_read_raw,
 };
 
-static enum da280_chipset da280_match_acpi_device(struct device *dev)
-{
-	const struct acpi_device_id *id;
-
-	id = acpi_match_device(dev->driver->acpi_match_table, dev);
-	if (!id)
-		return -EINVAL;
-
-	return (enum da280_chipset) id->driver_data;
-}
-
 static void da280_disable(void *client)
 {
 	da280_enable(client, false);
@@ -107,7 +96,6 @@ static void da280_disable(void *client)
 
 static int da280_probe(struct i2c_client *client)
 {
-	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	int ret;
 	struct iio_dev *indio_dev;
 	struct da280_data *data;
@@ -128,11 +116,7 @@ static int da280_probe(struct i2c_client *client)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = da280_channels;
 
-	if (ACPI_HANDLE(&client->dev)) {
-		chip = da280_match_acpi_device(&client->dev);
-	} else {
-		chip = id->driver_data;
-	}
+	chip = (uintptr_t)i2c_get_match_data(client);
 
 	if (chip == da217) {
 		indio_dev->name = "da217";
-- 
2.43.0


