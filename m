Return-Path: <linux-iio+bounces-12136-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7809C4243
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 17:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BBC7282B8A
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 16:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43A51A0B13;
	Mon, 11 Nov 2024 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Bg/UBwFh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A10C19E7F3
	for <linux-iio@vger.kernel.org>; Mon, 11 Nov 2024 15:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731340788; cv=none; b=GY6ipxCgTUJjMd+qYfcZDmBi2m5GW7/LXRBSj6u6U4I+EImSvv1N7xGZ8PQCZC4r9BKSvmWq7l8flbH3s5SRqntqqripl4Z7AvOIHLH1zc1/qmNnTDZT/FHEtZdhv9A7XJ2zSL+QCh0vDg91wSpc7/V8/0N+D+GC+SpO3/hTvPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731340788; c=relaxed/simple;
	bh=ybmm1a8R24BhiHQwe8H9ZffGuu8x5YyWkcizJljXbj8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HUeBvgho2DlM8hgsHDYFgsfIlh+cix74vRTPEA8i1NCD0bHioIpSi7ipfzex4p9jeCkM3qR5U0gShKQ6JsoqrkDrVmU99FCdNy9CrAuBgEo6Ium11B1RAyp0RnQwfLQGv7t5TR0TzzFbBNWgyrdsMxgDousGlXjJ5HGm4XwdNNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Bg/UBwFh; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-83ab694ebe5so183479739f.0
        for <linux-iio@vger.kernel.org>; Mon, 11 Nov 2024 07:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731340786; x=1731945586; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4z/hm6lPFwMecvVOX0An3KkhvxsEEmh2g07oQ0/eJcE=;
        b=Bg/UBwFhbVqMuvx8G5xOpSEdNFl6IVN2tqrquuA43FSc9Msec1TsEunAGH56V3qG3C
         3FUeY+R4LzALy1xq8A/Yiv2sJBa16j0izXshSQ/m7oVHg1077KBYCVwdzGcGWCGPvLnp
         e+v7x/tRYjUhf1z5wT0X8sDKOfgsiKPYKH3QejDxWDo2u19D3TrdsTGJkIWFqQ0yQFYq
         nOq7ZDZqkf4MRV7any0z8DGfIHwSO8skbdtWO8GWdgU8qMxgs4ndggmo7R3z4PYkGKPz
         zs2ezc8j4AW2+VpxH7z4FVpmZLJ0z1bT5b5Zq9MybXejg7pFIiOg5JBTzluBcpBGbYPG
         KogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731340786; x=1731945586;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4z/hm6lPFwMecvVOX0An3KkhvxsEEmh2g07oQ0/eJcE=;
        b=xFaTv7QWHKvtVQr51rGP7YjANm6qBz2kAS4Kg8rgpqajscpJbXKBBqUO37sMSFSJhc
         DCPERjJnefsPo/1JUfsDN42a/B8xYT2HnfFSCPC+eBOlCDF5Di58I03ud+xP9Lb6cgwx
         Top/OJHXznxAvfWbotqPaGliv8AGlOeQd35tbQ6aRED6k+Q/3L/VZcH2TIFyAEiGu1uC
         XOhIsyOAB33PI2Pb5XmIcFfiyYQo93T6aKQJpEfbUdcrQlojo8scMSQo7FEaB+2ac+P+
         cFtoVyBzPNXMAg2czaKP5Jb2AyT8Ie7Sxp3U+P02hSM/iZw2hR/fi442/SFGepvXUKgK
         k7Mg==
X-Forwarded-Encrypted: i=1; AJvYcCVi0TUay6bZ6i3ZqAy1+WYbJbsyZGoY0rqbFSak5yQCI9T0qYPl4FtJxI4kRso1p5xib1OFgJCo988=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycsfylm+QoolwU2a0cGHgNrutKi051SBise1QNu1Cm7PxGZMGE
	c8+XQ+KEryeP+3DyepI7lTd8Zk2p9hGLPjXCiSo6wU9KjrC73w4ETCDTP5NPDYQ=
X-Google-Smtp-Source: AGHT+IEHnj+MWyk1ZmKPzxL9cAQzdLRvcMpPU088PJBjUDzedvuV9E7InGRr6iUlI3S0dqTIqSA4ew==
X-Received: by 2002:a05:6602:2cc5:b0:835:4278:f130 with SMTP id ca18e2360f4ac-83e0336f6e2mr1395046239f.13.1731340785863;
        Mon, 11 Nov 2024 07:59:45 -0800 (PST)
Received: from [127.0.1.1] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de787d62c6sm1410986173.81.2024.11.11.07.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 07:59:45 -0800 (PST)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Mon, 11 Nov 2024 10:59:43 -0500
Subject: [PATCH 2/3] iio: adc: ad4695: make ad4695_exit_conversion_mode()
 more robust
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-tgamblin-ad4695_improvements-v1-2-698af4512635@baylibre.com>
References: <20241111-tgamblin-ad4695_improvements-v1-0-698af4512635@baylibre.com>
In-Reply-To: <20241111-tgamblin-ad4695_improvements-v1-0-698af4512635@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Trevor Gamblin <tgamblin@baylibre.com>
X-Mailer: b4 0.14.1

Ensure that conversion mode is successfully exited when the command is
issued by adding an extra transfer beforehand, matching the minimum CNV
high and low times from the AD4695 datasheet. The AD4695 has a quirk
where the exit command only works during a conversion, so guarantee this
happens by triggering a conversion in ad4695_exit_conversion_mode().
Then make this even more robust by ensuring that the exit command is run
at AD4695_REG_ACCESS_SCLK_HZ rather than the bus maximum.

Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 drivers/iio/adc/ad4695.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
index 82e930b21c69..f36c1a1db886 100644
--- a/drivers/iio/adc/ad4695.c
+++ b/drivers/iio/adc/ad4695.c
@@ -92,6 +92,8 @@
 #define AD4695_T_REFBUF_MS		100
 #define AD4695_T_REGCONFIG_NS		20
 #define AD4695_T_SCK_CNV_DELAY_NS	80
+#define AD4695_T_CNVL_NS		80
+#define AD4695_T_CNVH_NS		10
 #define AD4695_REG_ACCESS_SCLK_HZ	(10 * MEGA)
 
 /* Max number of voltage input channels. */
@@ -364,11 +366,31 @@ static int ad4695_enter_advanced_sequencer_mode(struct ad4695_state *st, u32 n)
  */
 static int ad4695_exit_conversion_mode(struct ad4695_state *st)
 {
-	struct spi_transfer xfer = {
-		.tx_buf = &st->cnv_cmd2,
-		.len = 1,
-		.delay.value = AD4695_T_REGCONFIG_NS,
-		.delay.unit = SPI_DELAY_UNIT_NSECS,
+	/*
+	 * An extra transfer is needed to trigger a conversion here so
+	 * that we can be 100% sure the command will be processed by the
+	 * ADC, rather than relying on it to be in the correct state
+	 * when this function is called (this chip has a quirk where the
+	 * command only works when reading a conversion, and if the
+	 * previous conversion was already read then it won't work). The
+	 * actual conversion command is then run at the slower
+	 * AD4695_REG_ACCESS_SCLK_HZ speed to guarantee this works.
+	 */
+	struct spi_transfer xfers[] = {
+		{
+			.delay.value = AD4695_T_CNVL_NS,
+			.delay.unit = SPI_DELAY_UNIT_NSECS,
+			.cs_change = 1,
+			.cs_change_delay.value = AD4695_T_CNVH_NS,
+			.cs_change_delay.unit = SPI_DELAY_UNIT_NSECS,
+		},
+		{
+			.speed_hz = AD4695_REG_ACCESS_SCLK_HZ,
+			.tx_buf = &st->cnv_cmd2,
+			.len = 1,
+			.delay.value = AD4695_T_REGCONFIG_NS,
+			.delay.unit = SPI_DELAY_UNIT_NSECS,
+		},
 	};
 
 	/*
@@ -377,7 +399,7 @@ static int ad4695_exit_conversion_mode(struct ad4695_state *st)
 	 */
 	st->cnv_cmd2 = AD4695_CMD_EXIT_CNV_MODE << 3;
 
-	return spi_sync_transfer(st->spi, &xfer, 1);
+	return spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
 }
 
 static int ad4695_set_ref_voltage(struct ad4695_state *st, int vref_mv)

-- 
2.39.5


