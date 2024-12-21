Return-Path: <linux-iio+bounces-13739-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DD59FA184
	for <lists+linux-iio@lfdr.de>; Sat, 21 Dec 2024 17:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80292167062
	for <lists+linux-iio@lfdr.de>; Sat, 21 Dec 2024 16:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF99154BEE;
	Sat, 21 Dec 2024 15:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjGJeKgK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD7C145B14;
	Sat, 21 Dec 2024 15:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734796786; cv=none; b=cG85HjTOn74f87Bo5KTptzFz2MhlAX7CJ+vZJtbRNKJNCBWuvtneXPOPPgd6sii3tlU9wVrDlZ+TN6MbwuhY3sJZz5X+1f7M0QKzEd5D8cNTStIpys/8O6wfJZDBThc0qiEhf/wzLTNF4gRoLrXzGtwUt01EXEzzzA9BBVHogtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734796786; c=relaxed/simple;
	bh=iEgmvuGLQTSUqCOCgNngzEbOj0dsPTlvHkJ2XdHjeV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sMvBrqTK4l1QLcpoFWpYxfZ11KyR4f54+empBgveN7TjcYSocaRi3HFCQv4/jbjG/MuXc59H7Uxswu4fezsbIQ+2Sk6zmh/YyEdaD12gwF5sfhsV5mIg8rX5OtxlVkCNvQ/SpYG5SLCKObbTxDx2qea/hJXJt66/vZgc4TknKnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GjGJeKgK; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-385e06af753so1626676f8f.2;
        Sat, 21 Dec 2024 07:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734796783; x=1735401583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XRd5DeXAx/b8ExqxMMYFYTnBE3FSJKz7qX5uJSCKKC8=;
        b=GjGJeKgKjWBqyjE8XOlUsnkndEuO9+sGDPYCLNtdIoJ+RDp2Hm67Q815FA7AXyPzZU
         FxD1MLM6Titdtj/AekAcyX48aDKLh28Zlcj1wOhHD1WX+vgOAqiPcgaW5lHKZcElkL7z
         90Rzr5MNeZg3ogQsu7WalhGgzkgx7xZS78i5KItgdbBW4MaXQL42kNS80tpH3mOPebhr
         TUPpEnjKbkSKCqrjtrgQs21et/FAYcMdWGFUwuXEbHMogluMsJCQhdSauWb8td11aGhy
         rLzZHoyGkLyW+xq2HLTfsiLBFQa31gwOaomjzMfZT8v+O3zF/KwJmbMgErhRI9ck5AaA
         nHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734796783; x=1735401583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XRd5DeXAx/b8ExqxMMYFYTnBE3FSJKz7qX5uJSCKKC8=;
        b=nvzXM+VKin/fRrzSGucml1T3VtQjZisM+rCp+sexD55/LRqdwFJ2rkqMmiTZpo+upO
         HjgjfjNSxlDOEpSsDm0m0lHVf9W0KA9+tkhpk3Y4QSc3hKZjmhJWvhkxewW2eZayjDui
         NAJDxRdnALVUpkBuZT73tW7o4U9meWGGXS9CiQ9jfQTxAtNN2T1hnvN3cmM00sJuMDHY
         /dLHe4ppjtT0ChQ28ixS9yCZt3VeCH5b/ZykxfYtIcHl3qywwcr4dWY0+E9PVdHuxwNj
         /Ppuo80yCzjUNdkaCe5SH60yhssVPnjBVuq7fv3XXbq0K/GcXCW02vCaHDCuwvy8pXDY
         NxAg==
X-Forwarded-Encrypted: i=1; AJvYcCVVXHVcbOGTafKKZJ6K3rnr7pbVRL0/GuH3Xbe+U0U1YS1kB9ibwdx8kZmFTG8X/3NlY534eoR6BD8/7TEj@vger.kernel.org, AJvYcCW2+GpAZbQR0fjGPY4CnorpIAaumLyrE7MChI8mnPe9eDuf78An+Y3FV3lFoyO2Y6HRsCWO2ZreNVyK@vger.kernel.org, AJvYcCWd8Ovdo1iriCFu0fna79FxO3zwIx7nmpZvhGGctpk42yQDLldRpWrOeN179kM3292ekg1f49/vTEwu@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx8aA6gQxjIEQdkc8FM1rxlh+UIa3TnPsHEkBcRvMLCHygVUde
	/+xnep8YLUhYA0EM/xvh/yzafGlLn03ac3yi9xAe2hfj4NQRhrE4Re1TErib
X-Gm-Gg: ASbGnctk4ZOOFj3CVg+GOdafQKmtnN4JI7lB0oMsIJPJRww4/9wN4+jsvbeuXTJQh1B
	oDzCqNiRYtOvcdGrIoDZLoGY2HKc9PMyZAmJo4iPjZiQRbSoFEmc/b6lUxxPsfbn6D3vp5Nl0u2
	qzsSrjp4J2UZygVbcDpzVuZppbpSqVIuMhh3W1cRokizFMwIg+nKG2EdigdVeXYOJDDpXXF3H0p
	gXpkXpMJVfud3TQhtyBP1EXfgz6r2zB9EbeuGs6S5KudwnlcUfUYSVY
X-Google-Smtp-Source: AGHT+IEOuWPBLVfLhI5ImFw5KizL9xVqN8T+Hs1xLSKfaLTOJOqXSNSHXiv9xdEVGVRhBKAO+OATkw==
X-Received: by 2002:a5d:6c61:0:b0:386:3357:2d9d with SMTP id ffacd0b85a97d-38a223f5c18mr6255818f8f.36.1734796782887;
        Sat, 21 Dec 2024 07:59:42 -0800 (PST)
Received: from spiri.. ([2a02:2f0e:604:8900:a4e6:d95:2e66:864e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8b874asm6751081f8f.109.2024.12.21.07.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Dec 2024 07:59:41 -0800 (PST)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v1 1/3] iio: adc: ad_sigma_delta: Add CS assert function
Date: Sat, 21 Dec 2024 17:56:00 +0200
Message-ID: <20241221155926.81954-2-alisa.roman@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241221155926.81954-1-alisa.roman@analog.com>
References: <20241221155926.81954-1-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some sigma-delta ADCs, such as AD7191 and AD7780, have no registers and
start conversion when CS is asserted. Add helper function to support
this use case by allowing devices to assert CS without performing
register operations.

This function can be used by drivers through their set_mode callback.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 drivers/iio/adc/ad_sigma_delta.c       | 24 ++++++++++++++++++++++++
 include/linux/iio/adc/ad_sigma_delta.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 0f355dac7813..c0f33d4baddf 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -48,6 +48,30 @@ void ad_sd_set_comm(struct ad_sigma_delta *sigma_delta, uint8_t comm)
 }
 EXPORT_SYMBOL_NS_GPL(ad_sd_set_comm, "IIO_AD_SIGMA_DELTA");
 
+/**
+ * ad_sd_assert_cs() - Assert chip select line
+ *
+ * @sigma_delta: The sigma delta device
+ *
+ * Returns 0 on success, an error code otherwise.
+ **/
+int ad_sd_assert_cs(struct ad_sigma_delta *sigma_delta)
+{
+	struct spi_transfer t = {
+		.len = 0,
+		.cs_change = sigma_delta->keep_cs_asserted,
+	};
+	struct spi_message m;
+
+	spi_message_init(&m);
+	spi_message_add_tail(&t, &m);
+
+	if (sigma_delta->bus_locked)
+		return spi_sync_locked(sigma_delta->spi, &m);
+	return spi_sync(sigma_delta->spi, &m);
+}
+EXPORT_SYMBOL_NS_GPL(ad_sd_assert_cs, IIO_AD_SIGMA_DELTA);
+
 /**
  * ad_sd_write_reg() - Write a register
  *
diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index 417073c52380..99ab56d04793 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -178,6 +178,7 @@ static inline int ad_sigma_delta_postprocess_sample(struct ad_sigma_delta *sd,
 }
 
 void ad_sd_set_comm(struct ad_sigma_delta *sigma_delta, uint8_t comm);
+int ad_sd_assert_cs(struct ad_sigma_delta *sigma_delta);
 int ad_sd_write_reg(struct ad_sigma_delta *sigma_delta, unsigned int reg,
 	unsigned int size, unsigned int val);
 int ad_sd_read_reg(struct ad_sigma_delta *sigma_delta, unsigned int reg,
-- 
2.43.0


