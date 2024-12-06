Return-Path: <linux-iio+bounces-13175-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF639E776E
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 18:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C74F1888DE7
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 17:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE87D203D4F;
	Fri,  6 Dec 2024 17:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Q99iGA1v"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC731FFC7F
	for <linux-iio@vger.kernel.org>; Fri,  6 Dec 2024 17:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733506166; cv=none; b=gHNl+6BKOPL2JHB8c1IbUWxCytIxBhDUHxbs2KPKbUOBYpH+CQM6dGnIjDlTCdXGO9QRw16uV+JGYHqG1qogGANMvU0iznX/stdmQsn1an9fnVwOVt0voJEsIlMrZperc9fLjrkVgam0ZQeCDokNvOWIg9iVKLPq953UyGfWCCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733506166; c=relaxed/simple;
	bh=aMPtlxpdGZaOBJnY/Yq9rwlEXxqb3NKFZyJY/BjDPEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qd3Fts+uXPj736NrhD+5omXSFpeQLM+1pdUxaDZsCb0s3ZbwxTDi8hliSm5H+ELcuzzKhuRkb6fn81KTaMpaQUOpJ1nSqKXErJRCRleWfPxNzIhC7DDh58g6LNQjxpeydTtN62o8RE5GG+BTL3TKx7a4KPX/jBBAZ5ifAi3PhM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Q99iGA1v; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3862f32a33eso314562f8f.3
        for <linux-iio@vger.kernel.org>; Fri, 06 Dec 2024 09:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733506163; x=1734110963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8IRU8zBEy7jxR+7VmvODzKHC26p59IQBEfwnsCShAF8=;
        b=Q99iGA1v+aFH+4AwbvpYCn9+6VRPYXeWX+/lNDX/q1oKr8R21mhaWUG/8sGvbsrDsJ
         7qTYsjH/xwU98OP59wK8yXMfF1ftbA6BzlmVJhCj5Za2X4xIKiS9wqV02sdswQkAE3dt
         VIE4bZrA+UNm2Tgr7YIk0DcniNhXXB0eMl+7EJb/UVJo+OjQYKbkRATuJbnYRtoMZ1rQ
         WF2scIeYqecY51ZdmfmsMH4JTDzuVM++SJS7/+gV1GvBS0GmiB1eRFiZsh4ZR/CT+HZE
         ynlUsSeos69Rc0ckAwssyBMXTD9H8LrGrW09hsYyP4w6aISgcBrgzkpsxsDykisNjm4f
         rDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733506163; x=1734110963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8IRU8zBEy7jxR+7VmvODzKHC26p59IQBEfwnsCShAF8=;
        b=ggHo8fRNxekY27UbPAw+6WL9s8Hpw4CBjta0Z6xD1sGJ6+oXGrdPDctOJG7YMZE0NR
         nEcrSO5rwEdFjKzMP1Z5CgoAcduieP5qxS+pFmYe0lveXXLy+d+6+SdsueRyOwBqhKyt
         fP4IgQW/f9FXDev75tdX5baWBA8kn4rysbgtB8NSxOWc2A8gb8ju2nLhfpJ4tttXAnS9
         2sqWhoctXss+Gb/HSxuTbJPzPG9SbdslkEG37H2nEx+h6l67q1yja9EJYPt216m6Kx74
         AqFgZ9kCPLQABgXQxpp2HA8kQIxAEIPlsIPJoPXyucZCec4Fpgkgij/1gvLxMA/tYA6r
         QsmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAYYn5CmvW+u6TZXk5Vh3WZ9GvrE1MKqRfUwvkznhLAW8O5TTCvk9z1vP11ug7rCAjBcZfrpEODqM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm01E8XFsfvoNoSR3TWYquLiCx8OFr1uSovVedouqx7Oqpo9s6
	UpyooNIA+dsy4Vr5g02Duw8dIdQM3yW0ZfzM9Bdjldr2GXOBkzFyJobbrOULIDk=
X-Gm-Gg: ASbGncv+dY3G1UfJHCiBt0ziiTSxG2ONq97Ckj62WfirYuz7T51EhzYS5VDy6KI35Sl
	euIJbcwvqRA5d0SLAngVkD0Rb967UwY8JvWAZBmVfWk3do9JxB0QcfI3kuhbUNBqrQcER0UCHZO
	vGyn0KKL5unjtU570CYwiQQ/cHEIk8LDjvDd+QG++LX3xRB8ywBSO8bV0tUWOytgL/+k+r7vt8L
	K2HUQnMlpiUqLJ4QjlrmWO6hBWxxEj8w0cp1/m/DRb/PmhWdAUuU/GyZz5Q9mTn90OiTPTgMJ01
	uGer
X-Google-Smtp-Source: AGHT+IHDl/ScyQQ+9XiC5cCufYVRE3jr6pK52v7nsqovPUyNKxgKhKvmh/BbTDgrN1Szg6jeZXNdTQ==
X-Received: by 2002:a5d:6d0b:0:b0:385:f984:2cca with SMTP id ffacd0b85a97d-3862b368b38mr3469749f8f.25.1733506162886;
        Fri, 06 Dec 2024 09:29:22 -0800 (PST)
Received: from localhost (p5dc6838f.dip0.t-ipconnect.de. [93.198.131.143])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861fd46cbdsm4988194f8f.56.2024.12.06.09.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 09:29:22 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alexandru Ardelean <aardelean@baylibre.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Renato Lui Geh <renatogeh@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Trevor Gamblin <tgamblin@baylibre.com>
Subject: [PATCH v6 07/10] iio: adc: ad_sigma_delta: Store information about reset sequence length
Date: Fri,  6 Dec 2024 18:28:39 +0100
Message-ID:  <9750db62fce638bf140ff48172c23bff7f785e5b.1733504533.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733504533.git.u.kleine-koenig@baylibre.com>
References: <cover.1733504533.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6421; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=aMPtlxpdGZaOBJnY/Yq9rwlEXxqb3NKFZyJY/BjDPEs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnUzRVCSgIn2/HrW3qhDdfxEQQ3yybpn3sRgHPo 8oCZ7yneSSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ1M0VQAKCRCPgPtYfRL+ TtznB/sHEYNcsSInj9cqjWXtbpKcYFSSy5I0DmwSkbbrB7KZtshxvO1Ss2Fq2Ekpi08MGI8fN7W TsiWXDGxQFCZlE4ngtgtscy7QwbGCGf9yDVjZ6B7LCjPt0RDxDpZuYGeKt6b5stg+618szjhC+W izHdtYXaivYgPQQIizFTKgcbSAzk1f8MqSJa3feEtiUKrvkJbz92cKPDuqx4KQS4oytMttPli0+ eh+wTA3YaRnBIBk7/8YDxZOmNQSI3Da6vMaJVa6bRUNqRNaKPUdu8JioJu8NaWk3qw50BDbYUDb TV/Nv4IrN9Ldazeok1ekHzRof9hR1RlpjY3IDSZs7KRDKkEj
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The various chips can be reset using a sequence of SPI transfers with
MOSI = 1. The length of such a sequence varies from chip to chip. Store
that length in struct ad_sigma_delta_info and replace the respective
parameter to ad_sd_reset() with it.

Note the ad7192 used to pass 48 as length but the documentation
specifies 40 as the required length. Assuming the latter is right.
(Using a too long sequence doesn't hurt apart from using a longer spi
transfer than necessary, so this is no relevant fix.)

The motivation for storing this information is that this is useful to
clear a pending R̅D̅Y̅ signal in the next change.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad7124.c               | 3 ++-
 drivers/iio/adc/ad7173.c               | 1 +
 drivers/iio/adc/ad7192.c               | 4 +++-
 drivers/iio/adc/ad7791.c               | 1 +
 drivers/iio/adc/ad7793.c               | 3 ++-
 drivers/iio/adc/ad_sigma_delta.c       | 5 ++---
 include/linux/iio/adc/ad_sigma_delta.h | 5 +++--
 7 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 1f3342373f1c..b17c3dbeaeba 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -571,6 +571,7 @@ static const struct ad_sigma_delta_info ad7124_sigma_delta_info = {
 	.data_reg = AD7124_DATA,
 	.num_slots = 8,
 	.irq_flags = IRQF_TRIGGER_FALLING,
+	.num_resetclks = 64,
 };
 
 static int ad7124_read_raw(struct iio_dev *indio_dev,
@@ -756,7 +757,7 @@ static int ad7124_soft_reset(struct ad7124_state *st)
 	unsigned int readval, timeout;
 	int ret;
 
-	ret = ad_sd_reset(&st->sd, 64);
+	ret = ad_sd_reset(&st->sd);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index a0fca16c3be0..ca46bb20288d 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -764,6 +764,7 @@ static struct ad_sigma_delta_info ad7173_sigma_delta_info = {
 	.read_mask = BIT(6),
 	.status_ch_mask = GENMASK(3, 0),
 	.data_reg = AD7173_REG_DATA,
+	.num_resetclks = 64,
 };
 
 static int ad7173_setup(struct iio_dev *indio_dev)
diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 955e9eff0099..f744441bd13f 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -361,6 +361,7 @@ static const struct ad_sigma_delta_info ad7192_sigma_delta_info = {
 	.status_ch_mask = GENMASK(3, 0),
 	.num_slots = 4,
 	.irq_flags = IRQF_TRIGGER_FALLING,
+	.num_resetclks = 40,
 };
 
 static const struct ad_sigma_delta_info ad7194_sigma_delta_info = {
@@ -373,6 +374,7 @@ static const struct ad_sigma_delta_info ad7194_sigma_delta_info = {
 	.read_mask = BIT(6),
 	.status_ch_mask = GENMASK(3, 0),
 	.irq_flags = IRQF_TRIGGER_FALLING,
+	.num_resetclks = 40,
 };
 
 static const struct ad_sd_calib_data ad7192_calib_arr[8] = {
@@ -565,7 +567,7 @@ static int ad7192_setup(struct iio_dev *indio_dev, struct device *dev)
 	int i, ret, id;
 
 	/* reset the serial interface */
-	ret = ad_sd_reset(&st->sd, 48);
+	ret = ad_sd_reset(&st->sd);
 	if (ret < 0)
 		return ret;
 	usleep_range(500, 1000); /* Wait for at least 500us */
diff --git a/drivers/iio/adc/ad7791.c b/drivers/iio/adc/ad7791.c
index 5d2ad3dd6caa..897e628de611 100644
--- a/drivers/iio/adc/ad7791.c
+++ b/drivers/iio/adc/ad7791.c
@@ -254,6 +254,7 @@ static const struct ad_sigma_delta_info ad7791_sigma_delta_info = {
 	.addr_shift = 4,
 	.read_mask = BIT(3),
 	.irq_flags = IRQF_TRIGGER_FALLING,
+	.num_resetclks = 32,
 };
 
 static int ad7791_read_raw(struct iio_dev *indio_dev,
diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
index b86e89370e0d..5f15fd7aab74 100644
--- a/drivers/iio/adc/ad7793.c
+++ b/drivers/iio/adc/ad7793.c
@@ -206,6 +206,7 @@ static const struct ad_sigma_delta_info ad7793_sigma_delta_info = {
 	.addr_shift = 3,
 	.read_mask = BIT(6),
 	.irq_flags = IRQF_TRIGGER_FALLING,
+	.num_resetclks = 32,
 };
 
 static const struct ad_sd_calib_data ad7793_calib_arr[6] = {
@@ -265,7 +266,7 @@ static int ad7793_setup(struct iio_dev *indio_dev,
 		return ret;
 
 	/* reset the serial interface */
-	ret = ad_sd_reset(&st->sd, 32);
+	ret = ad_sd_reset(&st->sd);
 	if (ret < 0)
 		goto out;
 	usleep_range(500, 2000); /* Wait for at least 500us */
diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index a4c31baa9c9e..101cf30f4458 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -178,13 +178,12 @@ EXPORT_SYMBOL_NS_GPL(ad_sd_read_reg, IIO_AD_SIGMA_DELTA);
  * ad_sd_reset() - Reset the serial interface
  *
  * @sigma_delta: The sigma delta device
- * @reset_length: Number of SCLKs with DIN = 1
  *
  * Returns 0 on success, an error code otherwise.
  **/
-int ad_sd_reset(struct ad_sigma_delta *sigma_delta,
-	unsigned int reset_length)
+int ad_sd_reset(struct ad_sigma_delta *sigma_delta)
 {
+	unsigned int reset_length = sigma_delta->info->num_resetclks;
 	uint8_t *buf;
 	unsigned int size;
 	int ret;
diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index f86eca6126b4..eef87d04eb6b 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -54,6 +54,7 @@ struct iio_dev;
  * @irq_flags: flags for the interrupt used by the triggered buffer
  * @num_slots: Number of sequencer slots
  * @irq_line: IRQ for reading conversions. If 0, spi->irq will be used
+ * @num_resetclks: Number of SPI clk cycles with MOSI=1 to reset the chip.
  */
 struct ad_sigma_delta_info {
 	int (*set_channel)(struct ad_sigma_delta *, unsigned int channel);
@@ -70,6 +71,7 @@ struct ad_sigma_delta_info {
 	unsigned long irq_flags;
 	unsigned int num_slots;
 	int irq_line;
+	unsigned int num_resetclks;
 };
 
 /**
@@ -181,8 +183,7 @@ int ad_sd_write_reg(struct ad_sigma_delta *sigma_delta, unsigned int reg,
 int ad_sd_read_reg(struct ad_sigma_delta *sigma_delta, unsigned int reg,
 	unsigned int size, unsigned int *val);
 
-int ad_sd_reset(struct ad_sigma_delta *sigma_delta,
-	unsigned int reset_length);
+int ad_sd_reset(struct ad_sigma_delta *sigma_delta);
 
 int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
 	const struct iio_chan_spec *chan, int *val);
-- 
2.45.2


