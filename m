Return-Path: <linux-iio+bounces-3811-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B89C88C0EB
	for <lists+linux-iio@lfdr.de>; Tue, 26 Mar 2024 12:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F8991C3C466
	for <lists+linux-iio@lfdr.de>; Tue, 26 Mar 2024 11:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FE06CDD4;
	Tue, 26 Mar 2024 11:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WrsNn+c6"
X-Original-To: linux-iio@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38058537F8
	for <linux-iio@vger.kernel.org>; Tue, 26 Mar 2024 11:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711453038; cv=none; b=nFkSB48INGGUNxPjKh8b5UgoM50xzRwsNw88axnTs1Z1LKi95s40LVbUXuRrdPQBWguOML30tBj2KeokFWThEncQVoQjtUuMd5qMI25dG0wFBNZrRcS64tPoTq31SBsbG9KzsaqEsBj8D89QuJselXmF2auT5H2MhJ8gsWcJbUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711453038; c=relaxed/simple;
	bh=qAG3pFi2xwLm+9mpy2D1yzFHf212C2EDRivXki81yEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ui4z6Od8LSZXvdXTQMXueKyrzPcV4twEG//by0zQGhWxi9YWMqIxNxlPcoyzBnvuqboQqWu1/+0UV3t0yNSDningRLIRJr1aUcdOm3GXW2rSt+H0s/3llw1TXlmz9s0VpAR5XZme+2trBWkfGI6XhbDusw3aWIbrbZcs0C+2jpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WrsNn+c6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711453036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gSpwIUbnCP1IY4B7pL7ljIJPfPALgc4i2JbtQVshhvU=;
	b=WrsNn+c6NsPvWHrmky75+z3k0WjpJnAbmBdowfjxXT82bvw0AhAZDuH31BSVLQzooSiiMs
	F6WR1IlyoxcwVdlRTx2uX+5SDOpYwsoVbN2ZCUhlr67gHAsp0HTPXnO/RR+WDzSC95YF04
	CUo/ELmUloS3Ji/xZJu2oQnyWeuJ6J0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-5nw8_JyVPpOsUmiDihaq7w-1; Tue, 26 Mar 2024 07:37:12 -0400
X-MC-Unique: 5nw8_JyVPpOsUmiDihaq7w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7386A85A58B;
	Tue, 26 Mar 2024 11:37:12 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.193.26])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9676A492BC8;
	Tue, 26 Mar 2024 11:37:11 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Christian Oder <me@myself5.de>,
	Nikita Mikhailevich <ermyril@gmail.com>,
	linux-iio@vger.kernel.org
Subject: [RFC 1/2] iio: accel: mxc4005: Interrupt handling fixes
Date: Tue, 26 Mar 2024 12:36:59 +0100
Message-ID: <20240326113700.56725-2-hdegoede@redhat.com>
In-Reply-To: <20240326113700.56725-1-hdegoede@redhat.com>
References: <20240326113700.56725-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

There are 2 issues with interrupt handling in the mxc4005 driver:

1. mxc4005_set_trigger_state() writes MXC4005_REG_INT_MASK1_BIT_DRDYE
(0x01) to INT_MASK1 to enable the interrupt, but to disable the interrupt
it writes ~MXC4005_REG_INT_MASK1_BIT_DRDYE which is 0xfe, so it enables
all other interrupt sources in the INT_SRC1 register. On the MXC4005 this
is not an issue because only bit 0 of the register is used. On the MXC6655
OTOH this is a problem since bit7 is used as TC (Temperature Compensation)
disable bit and writing 1 to this disables Temperature Compensation which
should only be done when running self-tests on the chip.

Write 0 instead of ~MXC4005_REG_INT_MASK1_BIT_DRDYE to disable
the interrupts to fix this.

2. The datasheets for the MXC4005 / MXC6655 do not state what the reset
value for the INT_MASK0 and INT_MASK1 registers is and since these are
write only we also cannot learn this from the hw. Presumably the reset
value for both is all 0, which means all interrupts disabled.

Explicitly set both registers to 0 from mxc4005_chip_init() to ensure
both masks are actually set to 0.

Fixes: 79846e33aac1 ("iio: accel: mxc4005: add support for mxc6655")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/accel/mxc4005.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
index 61839be501c2..111f4bcf24ad 100644
--- a/drivers/iio/accel/mxc4005.c
+++ b/drivers/iio/accel/mxc4005.c
@@ -27,9 +27,13 @@
 #define MXC4005_REG_ZOUT_UPPER		0x07
 #define MXC4005_REG_ZOUT_LOWER		0x08
 
+#define MXC4005_REG_INT_MASK0		0x0A
+
 #define MXC4005_REG_INT_MASK1		0x0B
 #define MXC4005_REG_INT_MASK1_BIT_DRDYE	0x01
 
+#define MXC4005_REG_INT_CLR0		0x00
+
 #define MXC4005_REG_INT_CLR1		0x01
 #define MXC4005_REG_INT_CLR1_BIT_DRDYC	0x01
 
@@ -113,7 +117,9 @@ static bool mxc4005_is_readable_reg(struct device *dev, unsigned int reg)
 static bool mxc4005_is_writeable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
+	case MXC4005_REG_INT_CLR0:
 	case MXC4005_REG_INT_CLR1:
+	case MXC4005_REG_INT_MASK0:
 	case MXC4005_REG_INT_MASK1:
 	case MXC4005_REG_CONTROL:
 		return true;
@@ -330,17 +336,13 @@ static int mxc4005_set_trigger_state(struct iio_trigger *trig,
 {
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
 	struct mxc4005_data *data = iio_priv(indio_dev);
+	unsigned int val;
 	int ret;
 
 	mutex_lock(&data->mutex);
-	if (state) {
-		ret = regmap_write(data->regmap, MXC4005_REG_INT_MASK1,
-				   MXC4005_REG_INT_MASK1_BIT_DRDYE);
-	} else {
-		ret = regmap_write(data->regmap, MXC4005_REG_INT_MASK1,
-				   ~MXC4005_REG_INT_MASK1_BIT_DRDYE);
-	}
 
+	val = state ? MXC4005_REG_INT_MASK1_BIT_DRDYE : 0;
+	ret = regmap_write(data->regmap, MXC4005_REG_INT_MASK1, val);
 	if (ret < 0) {
 		mutex_unlock(&data->mutex);
 		dev_err(data->dev, "failed to update reg_int_mask1");
@@ -382,6 +384,14 @@ static int mxc4005_chip_init(struct mxc4005_data *data)
 
 	dev_dbg(data->dev, "MXC4005 chip id %02x\n", reg);
 
+	ret = regmap_write(data->regmap, MXC4005_REG_INT_MASK0, 0);
+	if (ret < 0)
+		return dev_err_probe(data->dev, ret, "writing INT_MASK0\n");
+
+	ret = regmap_write(data->regmap, MXC4005_REG_INT_MASK1, 0);
+	if (ret < 0)
+		return dev_err_probe(data->dev, ret, "writing INT_MASK1\n");
+
 	return 0;
 }
 
-- 
2.44.0


