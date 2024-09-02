Return-Path: <linux-iio+bounces-9035-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13031968F8E
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 00:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C333C283F13
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 22:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA9C187FFA;
	Mon,  2 Sep 2024 22:28:55 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15F0187FE3
	for <linux-iio@vger.kernel.org>; Mon,  2 Sep 2024 22:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725316135; cv=none; b=aZUsvTdjOP+xE21HenLGR3RpkJidenoj+PjHGD8wfVrASeC0e7UjfN7Qv60gYxRlwQAkPvrzz8lS84o1GJRn31xYrFxN8TLW3FIF0pzARGcW3vN74+bCAan7yjk0CU+bu+gMi/NCcmLt9POvg4suF0GO8HKHL5rNot/ehzvigp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725316135; c=relaxed/simple;
	bh=T/CgH+qXQHoXnPD9XO3eOWuwN2VpZYAO5w82WXns/1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gAOnCJh1ZjLjN8B8kymjIlu5GtFR4z5/xVWbP03SrdKiZ9lt/+C+vFp1U4nZOY7tG9rq0EdbGgiajo4Xm2EZm+2X5HdViRRF37NvTdZooX9cg3FPScpP4QskJtjYkWPDprbJw0l9+vjcduQcNKMchb3BhHKL/pcxY9Xc4866+3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id aee633f9-697a-11ef-abae-005056bdd08f;
	Tue, 03 Sep 2024 01:28:31 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v1 04/22] iio: adc: ad7887: Get platform data via dev_get_platdata()
Date: Tue,  3 Sep 2024 01:16:49 +0300
Message-ID: <20240902222824.1145571-5-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902222824.1145571-1-andy.shevchenko@gmail.com>
References: <20240902222824.1145571-1-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Access to platform data via dev_get_platdata() getter to make code cleaner.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/adc/ad7887.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
index 6265ce7df703..b301da9b88b1 100644
--- a/drivers/iio/adc/ad7887.c
+++ b/drivers/iio/adc/ad7887.c
@@ -234,7 +234,7 @@ static void ad7887_reg_disable(void *data)
 
 static int ad7887_probe(struct spi_device *spi)
 {
-	struct ad7887_platform_data *pdata = spi->dev.platform_data;
+	const struct ad7887_platform_data *pdata = dev_get_platdata(&spi->dev);
 	struct ad7887_state *st;
 	struct iio_dev *indio_dev;
 	uint8_t mode;
-- 
2.46.0


