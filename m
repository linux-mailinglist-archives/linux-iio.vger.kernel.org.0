Return-Path: <linux-iio+bounces-13166-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED40F9E7649
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 17:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8037165285
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 16:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF3220628E;
	Fri,  6 Dec 2024 16:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="TFmBClOH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA2A819;
	Fri,  6 Dec 2024 16:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733503269; cv=none; b=Tkf53IiP5ue/n3IO7ZADW1ctf9M9syZsUJCAxG1uWS+usGnkVAEwcztxAerM5eV3KKAZGiRmPsQbp+BmBmaMklBwulaeJRp7hBkIrRIvVX+k/wQIJiBMk1ZGceoOWsVlR+8fYhNYKmM5UqzdT8Vu//z3gYGq1BR+gsPx4GLMZPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733503269; c=relaxed/simple;
	bh=7ANu5EScUwuJ6PQjUEeCzCCZry0hPu73TNNgvcoO70Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cxalo6z/R575WhhkW+5i8hyyse/B38cR5jwMbMOGVL7yd/QpM0LeXVaLqaEEGtCRcvJ18cC7hx8oUGIFDGKKjQj63TLRKBzvKCNozoJZ8VqqHgaTLIaKY6DKWDIOGWNlP+gwnQJLywvvaLG+VqitFqzz1idLCXwHYMnonXnEPz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=TFmBClOH; arc=none smtp.client-ip=80.12.242.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id JbMqtRjeSgyqpJbMqthh1y; Fri, 06 Dec 2024 17:39:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1733503190;
	bh=j8NFJHpTnotxjR23il/PFTjZwL7eJr/DxZvCjCEpviw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=TFmBClOHnKrl2gNLgLkmaW6lQl+KGzrIc46tK1ss2HkGyLTiwFvqzgioS7ZR2eROP
	 awZaRWMpAMnDWrltN3qsw31k93H2PLh0+IIkd3hOP8i6VCuRaeTygE5f1dq2d0zsqr
	 FRy7ltBzCuTgHA/HgBby7GAWG8W3/sFhXpx0IwWBK2/Op4l3ZQtoAfGk7ftlqeW7CM
	 NLugchr9Jo1AradlZ0QLkKB4T6hXD+vDaflqqdwiZyJ2zs+aumuKHgPGle5cCZanV9
	 fd1yj4C0vqdXZRRiPLeKN2hZBjVM/H+cnrNNocW5uod0ngkRf2AXGKBMhJ6QWoXDaU
	 s+EyAUdqhqzpA==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 06 Dec 2024 17:39:50 +0100
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org
Subject: [PATCH v2] iio: adc: ad9467: Fix the "don't allow reading vref if not available" case
Date: Fri,  6 Dec 2024 17:39:28 +0100
Message-ID: <cc65da19e0578823d29e11996f86042e84d5715c.1733503146.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit in Fixes adds a special case when only one possible scale is
available.
If several scales are available, it sets the .read_avail field of the
struct iio_info to ad9467_read_avail().

However, this field already holds this function pointer, so the code is a
no-op.

Use another struct iio_info instead to actually reflect the intent
described in the commit message. This way, the structure to use is selected
at runtime and they can be kept as const.

This is safer because modifying static structs that are shared between all
instances like this, based on the properties of a single instance, is
asking for trouble down the road.

Fixes: b92f94f74826 ("iio: adc: ad9467: don't allow reading vref if not available")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is compile tested only and is completely speculative.

Changes in v2:
  - use another struct iio_info to keep the structure const

v1: https://lore.kernel.org/linux-kernel/556f87c8931d7d7cdf56ebc79f974f8bef045b0d.1733431628.git.christophe.jaillet@wanadoo.fr/
---
 drivers/iio/adc/ad9467.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index d358958ab310..f30119b42ba0 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -895,7 +895,7 @@ static int ad9467_update_scan_mode(struct iio_dev *indio_dev,
 	return 0;
 }
 
-static struct iio_info ad9467_info = {
+static const struct iio_info ad9467_info = {
 	.read_raw = ad9467_read_raw,
 	.write_raw = ad9467_write_raw,
 	.update_scan_mode = ad9467_update_scan_mode,
@@ -903,6 +903,14 @@ static struct iio_info ad9467_info = {
 	.read_avail = ad9467_read_avail,
 };
 
+/* Same as above, but without .read_avail */
+static const struct iio_info ad9467_info_no_read_avail = {
+	.read_raw = ad9467_read_raw,
+	.write_raw = ad9467_write_raw,
+	.update_scan_mode = ad9467_update_scan_mode,
+	.debugfs_reg_access = ad9467_reg_access,
+};
+
 static int ad9467_scale_fill(struct ad9467_state *st)
 {
 	const struct ad9467_chip_info *info = st->info;
@@ -1214,11 +1222,12 @@ static int ad9467_probe(struct spi_device *spi)
 	}
 
 	if (st->info->num_scales > 1)
-		ad9467_info.read_avail = ad9467_read_avail;
+		indio_dev->info = &ad9467_info;
+	else
+		indio_dev->info = &ad9467_info_no_read_avail;
 	indio_dev->name = st->info->name;
 	indio_dev->channels = st->info->channels;
 	indio_dev->num_channels = st->info->num_channels;
-	indio_dev->info = &ad9467_info;
 
 	ret = ad9467_iio_backend_get(st);
 	if (ret)
-- 
2.47.1


