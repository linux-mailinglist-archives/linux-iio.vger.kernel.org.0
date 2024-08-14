Return-Path: <linux-iio+bounces-8464-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC229519F0
	for <lists+linux-iio@lfdr.de>; Wed, 14 Aug 2024 13:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E3CD1C21385
	for <lists+linux-iio@lfdr.de>; Wed, 14 Aug 2024 11:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B679C1B0104;
	Wed, 14 Aug 2024 11:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgVeIxWV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BB21AED4F;
	Wed, 14 Aug 2024 11:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723635151; cv=none; b=ttDJwYoyg/pot/mqy3W80TcnkK6H+yxYvZAVJ3nQhc24ADCOU8yLhVD5bv5y4h4ZGdFLk0EnD8Suiq+owJEofff1MgO6FRVXJ6T27Tk7pffwaROyppsazTsCwx2KCfNgQxtRzL9pI2SvbjwfD7nQ0CrOS1GPBRADj8RhJkUMXHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723635151; c=relaxed/simple;
	bh=RgvFY5hMdtkZMQD226LXln+PQFCch/QPC/FIkEkOe8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oriT5/NeMjfP91+yuF/24kJ4G2cqaIUkMEJ6xofBpTxLc90cs6FAgWFwoOQsgCFOp8ByYCUt3dhmYd7gngxi8UgnUDma0cyxhcx2c4/T+vH8rp0l/yhVoqjJcEvKiRnPqnzO3EY7ZLWKYW7WMCJ/HByQRhoX4pM+Dx0WPE4Go7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OgVeIxWV; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-710d0995e21so4296017b3a.1;
        Wed, 14 Aug 2024 04:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723635149; x=1724239949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIV9l5apoDFp6zNENoVkKZFaD01MLNp+jT9vLQjnNaY=;
        b=OgVeIxWVJEuUaDaWdfLWXyngD9uHYXVPlddG2iADBEj3FFWFLoyimoeuEg1uH+w4LA
         vW3Ul23auDs7lL68Ty45TNoZPkr/VkjdLwn4/bATn+DufeMChTwNCFqlCJ8L6ZMIalEX
         7NUtfYhZmswXGYqbjDtw5q0ezd7spw0iWGN9JZnSIFJlOqvQm6HSWJYBKbNXd9RlLdP6
         VyesyMDvZ6F6icOFKxyvbPPOTu7mtIpKLQ9pClND9JlbHhkmDPXsCNxIWdwM0pOpoHsG
         Niilw7X0aFEo/IJSIOKB9Hk07MBz4nW34mdEljlHQmS2+TugIJUVGsx1dTZ5Damp6PvL
         kyFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723635149; x=1724239949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JIV9l5apoDFp6zNENoVkKZFaD01MLNp+jT9vLQjnNaY=;
        b=CQwujmJbpe38OaZK6AddQ0PMnf47hzIw/V3Q+BmoEvJ7f8WmOb/d4OuywXixeHPl0O
         orLfg0MTwzY30EJFd8zljKy4zMecmdV2Sn4ZlAKBPtyNsNcH1O0/tDzr1ssb+z+Kb4fx
         8hv131QyqbPJh6GX+wTXruQAeomvW1pwA8Fqqhz5+mkFqHAcLYpjILKZBe0UjSLN4lHi
         CVeo/OXK3dkHvkXqbjEir9R6pvZxk3CpSoRUQ/zmbRJZNsbpAugbZKm1042SHiMa66iX
         0SgLB5uui4Z3Rx1XVBgx9atuGjdBsWXkoWv/t0FZhLpC5OOF1Snc0IXGuTtxZt3rz8dl
         0zUw==
X-Forwarded-Encrypted: i=1; AJvYcCUazlaHUOs5dPCGrnu63bsY9bPTmwWS2W3ThxUjZOTCI5JDg0p59+YJuLLg8UmjrjNa2WUUeWsrLzWy4CVYSiZkX+HwrvfQpENYY9ox
X-Gm-Message-State: AOJu0YxYmA5uy948AzC7YVT4GJWJVEe9Hj9WYev09g1MzCnNo8gcA6Se
	CS+Ui2rr/JoDAF+FcaMCcux8w/qWw1xrHTKyb8fQoU8ZXYrFXXFAoEw0oPF24SV7Fg==
X-Google-Smtp-Source: AGHT+IEonW+2JpeanG0Jbx5PF/d7PDJmtRCo9/Ikxm0JQt/n24uuSWQgRCfX/M3UeXjLpuho0JPmWw==
X-Received: by 2002:a05:6a20:d049:b0:1c0:ef1c:b80 with SMTP id adf61e73a8af0-1c8eaf68715mr3032986637.52.1723635148679;
        Wed, 14 Aug 2024 04:32:28 -0700 (PDT)
Received: from abhash-IdeaPad-L340-15IRH-Gaming.. ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2d3ac7e80e5sm1467434a91.17.2024.08.14.04.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 04:32:27 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: anshulusr@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v7 2/2] iio: light: ltr390: Calculate 'counts_per_uvi' dynamically
Date: Wed, 14 Aug 2024 17:01:34 +0530
Message-ID: <20240814113135.14575-3-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240814113135.14575-1-abhashkumarjha123@gmail.com>
References: <20240814113135.14575-1-abhashkumarjha123@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

counts_per_uvi depends on the current value of gain and resolution.
Hence, we cannot use the hardcoded value 96.
The `counts_per_uvi` function gives the count based on the current gain
and resolution (integration time).

Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
---
 drivers/iio/light/ltr390.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
index 16e06f2ab..7e58b50f3 100644
--- a/drivers/iio/light/ltr390.c
+++ b/drivers/iio/light/ltr390.c
@@ -46,6 +46,8 @@
 #define LTR390_UVS_MODE	      BIT(3)
 #define LTR390_SENSOR_ENABLE  BIT(1)
 
+#define LTR390_FRACTIONAL_PRECISION 100
+
 /*
  * At 20-bit resolution (integration time: 400ms) and 18x gain, 2300 counts of
  * the sensor are equal to 1 UV Index [Datasheet Page#8].
@@ -125,6 +127,14 @@ static int ltr390_set_mode(struct ltr390_data *data, enum ltr390_mode mode)
 	return 0;
 }
 
+static int ltr390_counts_per_uvi(struct ltr390_data *data)
+{
+	const int orig_gain = 18;
+	const int orig_int_time = 400;
+
+	return DIV_ROUND_CLOSEST(23 * data->gain * data->int_time_us, 10 * orig_gain * orig_int_time);
+}
+
 static int ltr390_read_raw(struct iio_dev *iio_device,
 			   struct iio_chan_spec const *chan, int *val,
 			   int *val2, long mask)
@@ -164,8 +174,8 @@ static int ltr390_read_raw(struct iio_dev *iio_device,
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_UVINDEX:
-			*val = LTR390_WINDOW_FACTOR;
-			*val2 = LTR390_COUNTS_PER_UVI;
+			*val = LTR390_WINDOW_FACTOR * LTR390_FRACTIONAL_PRECISION;
+			*val2 = ltr390_counts_per_uvi(data);
 			return IIO_VAL_FRACTIONAL;
 
 		case IIO_LIGHT:
-- 
2.43.0


