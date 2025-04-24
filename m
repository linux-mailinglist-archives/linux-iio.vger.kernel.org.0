Return-Path: <linux-iio+bounces-18608-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57487A9BAD3
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 00:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 539771BA6279
	for <lists+linux-iio@lfdr.de>; Thu, 24 Apr 2025 22:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDF728DF0D;
	Thu, 24 Apr 2025 22:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIhp8xLl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDAA22686B;
	Thu, 24 Apr 2025 22:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745534087; cv=none; b=gCD9oZR84C0iMV3rs0MBcBykCrrpu3HtGE3VRo/OfB3dKirpc5WyP0pQZ/YBW79Ibx3TG3ox5lzcUeIl1gex/0BSUz3dJCGwqV97C8o3YgeH0ukkK9yhMbliqQX16Kx59ue2SjyBU4QroxDF4hxqLUwublHKPVg87OhwqJhAhzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745534087; c=relaxed/simple;
	bh=sqeoJp+2jRFNDH3TzY9O6mzMr5Isww/bZnpTdl7s7Uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bCyS9V6BkoqhAiXQ7AZFvrbfS5D+DRhLbBkfcxtpAk5/mnuunwWdPZTVAUfoC3XwtcFvMMEaVSpNqWXdIKoY1k3s168StQF1jUu/gKgtIgT9s/cf/emxnFtPjDy7eVaINTjzF34yHh6NUfyj0otviVNpQrFU6VxMRU/AcaCJQYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aIhp8xLl; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c5e39d1e0eso169079285a.1;
        Thu, 24 Apr 2025 15:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745534085; x=1746138885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6HQQxzT0Bc9xltCaxxJ7uLhPmo14NYdtMTMXhuJ1RU=;
        b=aIhp8xLlZBMdfa6b9283ZxFlcT3e1Ok84ymZZVeI+koBJI0O2YOIvWV72qGzwybbrs
         ovKNWpseuAFWDVzeEdYw5ajtyPj63qJMSDz+Oq6EIhEtGzkJbLloIfjzzg/fEaXlTEHh
         0SqAqlDOQOoDtyVT3ZEf8I1FACUlHgVbwOcfwaPgShMvEIhsfKeLSdIdlxh0tDkpFQ1a
         +qWhZf66Kcl6vvOPrGLivGop+T84hMLI9PJECdSMLukeI59u2mNdPJ4C3WmiPAMnEGlz
         /12vaGTVKP9/U9JMitGmMmOQD2Ws2pHbxHsZ/lRH40H0l3ZBcCu3RXfKJyNpmYmp02Rq
         F6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745534085; x=1746138885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M6HQQxzT0Bc9xltCaxxJ7uLhPmo14NYdtMTMXhuJ1RU=;
        b=e3ibccBDcnz8EKr/vL8UwdMi6psoCo1lA+6oggGyQQIph2rfpXVBsO5+9xeMyDM27o
         Q8yw5vSP+MRoEe0Q0Lmi151hcHl+drSXer4CAFx3gsy/yy9p1XHbITd78ZtnCgimTPVe
         a1QVIvfi6Tkx9w/CLZf8CNEWnpTUVyrOy5UOuR9vnuA7H3h28CG+/1wCAZG6qtkX3h3j
         UESSQr7Ilr/EgcRCj7ssE9VjnS9dEqzD7SrGpo23Ixhd07QhGFrJMs96Hun1w+9il0Yh
         EsipCUNVpcNy6mFYkIxoxIo9J5m3agI97Oy+JKAE1vHc8mE1EgNDbsK4j1WiTZWCwR50
         ejcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAkSptXBhO2HWDaYaqrjW63iyCaHHBaw0gYEekWACN5NZdBzooYtvWG1RMgxxFp3fGv9ZgZP+vivJYrNsw@vger.kernel.org, AJvYcCWU3HvnnMYSQ1G/tFLv02+2PDV3OvZEQHb1ELSiBoGCdJAsT+wm/ldLX3Qe0Sku/wCX/KsuXKnjVy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpFnjwg92YXkcpSAi08CApvC57MQdRZHLjaHgRJyYsSS90tYDm
	MAlsNjRk1Ev8l6VYvcdoalc1qxKlzoHvAGjQ1oQeOydjlkzWc1HR
X-Gm-Gg: ASbGncvwAppvConOM21Urqnl0FAFhgwq+PWAJdHgmvDxjcNGvtfWPDLcCGEmaIlkBPA
	pH6CvPL51VAefG+PSx951DLaXyAwSlSuzWDQr5Bg9ESHv4+gC77/gTl99AQd6QsWW32VGMlUOl+
	Ameq4NdgcQIEViduaDd9LTwphwrkQs60HMFQ70zJhXRUYirzS/rwIQ60i0h+LCqk+Gmvu6JzkK7
	+2zhj2/l99ME4hoKgl0114RZMWvZBC0TKAfAmTW6RiLFbCcrIuISswQbNcRzry93Ebz92R32L7D
	bS3Er0T+FaMKeon536HSYq9nJdh5elkUY5QLSRDHffIfqdHMbGa0sv/aaIX9kPYmlXIT4dihXWN
	lj6NVZfew/2lXNMERspTg6udhnev7dg==
X-Google-Smtp-Source: AGHT+IEHNcRZ8mQ6zC3MsB97BOz3q06O+YLI0Gv2TZzEcTOdD+Jy+MSlgXuIuIVaSjsiDwOHMnKE7g==
X-Received: by 2002:a05:620a:191d:b0:7c5:6375:1450 with SMTP id af79cd13be357-7c9606de128mr40651985a.18.1745534084963;
        Thu, 24 Apr 2025 15:34:44 -0700 (PDT)
Received: from theriatric.mshome.net (c-73-123-232-110.hsd1.ma.comcast.net. [73.123.232.110])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958ea36eesm142986885a.111.2025.04.24.15.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 15:34:44 -0700 (PDT)
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
To: andy@kernel.org,
	dlechner@baylibre.com,
	gregkh@linuxfoundation.org,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Michael.Hennerich@analog.com,
	nuno.sa@analog.com
Cc: gshahrouzi@gmail.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v4 2/2] staging: iio: frequency: ad9832: Refactor powerdown control
Date: Thu, 24 Apr 2025 18:32:09 -0400
Message-ID: <20250424223210.91317-3-gshahrouzi@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424223210.91317-1-gshahrouzi@gmail.com>
References: <20250424223210.91317-1-gshahrouzi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace custom implementation with out_altvoltage_powerdown ABI. The
attribute's logic is inverted (1 now enables powerdown) to match the
standard.

Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
---
V3 -> v4:
	- Use guard(mutex) for simplified locking.
	- Use an extended attribute.
v2 -> v3:
v1 -> v2:
	Refactor powerdown functionality.
---
 drivers/staging/iio/frequency/ad9832.c | 69 +++++++++++++++++++-------
 1 file changed, 51 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 2e555084ff98a..b8b52302abf36 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -174,6 +174,32 @@ static int ad9832_write_phase(struct ad9832_state *st,
 	return spi_sync(st->spi, &st->phase_msg);
 }
 
+static ssize_t ad9832_write_powerdown(struct iio_dev *indio_dev, uintptr_t private,
+				      const struct iio_chan_spec *chan,
+				      const char *buf, size_t len)
+{
+	struct ad9832_state *st = iio_priv(indio_dev);
+	int ret;
+	bool val;
+
+	ret = kstrtobool(buf, &val);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&st->lock);
+	if (val)
+		st->ctrl_src |= AD9832_SLEEP;
+	else
+		st->ctrl_src &= ~(AD9832_RESET | AD9832_SLEEP |
+				 AD9832_CLR);
+
+	st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_SLEEPRESCLR) |
+					  st->ctrl_src);
+	ret = spi_sync(st->spi, &st->msg);
+
+	return ret ? ret : len;
+}
+
 static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
 			    const char *buf, size_t len)
 {
@@ -185,9 +211,9 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
 
 	ret = kstrtoul(buf, 10, &val);
 	if (ret)
-		goto error_ret;
+		return ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	switch ((u32)this_attr->address) {
 	case AD9832_FREQ0HM:
 	case AD9832_FREQ1HM:
@@ -232,22 +258,9 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
 						  st->ctrl_fp);
 		ret = spi_sync(st->spi, &st->msg);
 		break;
-	case AD9832_OUTPUT_EN:
-		if (val)
-			st->ctrl_src &= ~(AD9832_RESET | AD9832_SLEEP | AD9832_CLR);
-		else
-			st->ctrl_src |= FIELD_PREP(AD9832_SLEEP, 1);
-
-		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_SLEEPRESCLR) |
-						  st->ctrl_src);
-		ret = spi_sync(st->spi, &st->msg);
-		break;
 	default:
 		ret = -ENODEV;
 	}
-	mutex_unlock(&st->lock);
-
-error_ret:
 	return ret ? ret : len;
 }
 
@@ -270,8 +283,6 @@ static IIO_CONST_ATTR_PHASE_SCALE(0, "0.0015339808"); /* 2PI/2^12 rad*/
 
 static IIO_DEV_ATTR_PINCONTROL_EN(0, 0200, NULL,
 				ad9832_write, AD9832_PINCTRL_EN);
-static IIO_DEV_ATTR_OUT_ENABLE(0, 0200, NULL,
-				ad9832_write, AD9832_OUTPUT_EN);
 
 static struct attribute *ad9832_attributes[] = {
 	&iio_dev_attr_out_altvoltage0_frequency0.dev_attr.attr,
@@ -285,7 +296,6 @@ static struct attribute *ad9832_attributes[] = {
 	&iio_dev_attr_out_altvoltage0_pincontrol_en.dev_attr.attr,
 	&iio_dev_attr_out_altvoltage0_frequencysymbol.dev_attr.attr,
 	&iio_dev_attr_out_altvoltage0_phasesymbol.dev_attr.attr,
-	&iio_dev_attr_out_altvoltage0_out_enable.dev_attr.attr,
 	NULL,
 };
 
@@ -293,6 +303,27 @@ static const struct attribute_group ad9832_attribute_group = {
 	.attrs = ad9832_attributes,
 };
 
+static const struct iio_chan_spec_ext_info ad9832_ext_info[] = {
+	{
+		.name = "powerdown",
+		.shared = IIO_SEPARATE,
+		.write = ad9832_write_powerdown,
+	},
+	{ },
+};
+
+#define AD9832_CHANNEL(chan) {					\
+	.type = IIO_ALTVOLTAGE,					\
+	.indexed = 1,						\
+	.output = 1,						\
+	.channel = (chan),					\
+	.ext_info = ad9832_ext_info,				\
+}
+
+static const struct iio_chan_spec ad9832_channels[] = {
+	AD9832_CHANNEL(0),
+};
+
 static const struct iio_info ad9832_info = {
 	.attrs = &ad9832_attribute_group,
 };
@@ -333,6 +364,8 @@ static int ad9832_probe(struct spi_device *spi)
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->info = &ad9832_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = ad9832_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ad9832_channels);
 
 	/* Setup default messages */
 
-- 
2.43.0


