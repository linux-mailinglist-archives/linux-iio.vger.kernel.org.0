Return-Path: <linux-iio+bounces-18326-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A867A943A6
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 15:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D65B617A353
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 13:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E761DF25D;
	Sat, 19 Apr 2025 13:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dc1uxoNo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDB31DE3DB;
	Sat, 19 Apr 2025 13:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745071007; cv=none; b=S4SolaRVmgkP5vpq1IXkZxZ5lheS55tTzrTWi4yI6QjF1AhI4wSyQw+cq1AmFYBGoSr32GdLNtdTvUSih5vIRRKO24P2q1w25TT7ei+w9il0DwXyAfd9KNMT1c3s/+ExI9URRMkAEkEtjXtqdwLfYwqjRAVxT2SG/Th4NTV4TRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745071007; c=relaxed/simple;
	bh=IeGkgU0YBXtfAvHiWobFFEYEFFchmZKYlSuvetJAaME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rH5MMLyeS5VlEU1TFVsQMQ/72tEZrNL5LxJacNGmyuppX6E0p7NRwuKdBvNpjSIYChwm9/LDDcvb4E+uM0YztutixtOBjtYtW3Uykpf10CqWiJeXivKVV2Se8eC1lTZfxPyf5YvsmnD0+M0jiWnp77i4hpURyL3tRUrwtmHlIf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dc1uxoNo; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c55500cf80so206252085a.1;
        Sat, 19 Apr 2025 06:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745071004; x=1745675804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWMbB3RCjLtzIka1EeVCBu0jLU/YK5i3+0Q0+aZfr+E=;
        b=dc1uxoNo1VkYUuLz2XEtTs/kKzGjAhLw8zazTaU/W00Qd9Xo6wUJvNEonRwGJTCnMq
         Wiyk4kSaHXFR88dE3BQZ1/AD/9rIcYaB3//Lxizf+LBXtRvhHm5eE7Hd6IY/pDHWp+Tu
         kmuIS4exmgeE7/aSbmVaKLLoyHUn/xcXg3nJy+IK6PoObMXYajeXRUtKxAH0V2N3Djti
         QFM7v3rOKbiU58tiTc+G007nH2MbdS4deML/lMIGyZWsEs84+e6W2yjFHonP9gqXWVmq
         U0TMQ/bmXmUCaST8zTC00cMXS9UFItFXIxT4DbrOK9Ttb7HJ36xMzXahC7KJRo63C1kW
         4uBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745071004; x=1745675804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AWMbB3RCjLtzIka1EeVCBu0jLU/YK5i3+0Q0+aZfr+E=;
        b=sPpZG7sCs5u7/0S3LySTKmVxQmX+GF0E2eh3CCqA/DJIJQLgkLIvZmsIjVNP0VX97i
         RjdtxWZnlJe6msBONuYqBpXFUrVDlNlT20kVmQCvkHSoAOzMWYFhxmW7JXYbabeNXCCq
         WYWpgDbJoxMfmYne2N7031L+Z2o5Ehtiinj/ZWlETepLZvnHN0EKjXp/c22DjbKduNyi
         od6LcmVUO38eVJAetWwsxFP37SaGebdeA0hewnslymqJIO4MfPaJR9JkGtpIoskMrMIc
         BXCyHoeLkJONNYzI4q/2gnNLcxk/2Qaejxn5RPQGRdYhbLspsWJz8mjg8cnpBGPexSB3
         1AWw==
X-Forwarded-Encrypted: i=1; AJvYcCVKHWaUe7zAueGhyqEYKbrNDO2I60OYVzK7RDHeVCklVmt6z5713BvcxKw0nGirSQr+v7iN+zVc4OZgWLza@vger.kernel.org, AJvYcCWg/ZRbBs5efQ6t/5iCNexZo9FpFgZv7sxna8iM+hMIONy/yOkxzySJ7QCgvTQGJ4oVW03h8xbuQe4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGLxgfMJwnfbnN2MzgL9ugcPPTdh2UECVTDx/kauG/CR5jXiMW
	C56u3OXkzI10QWxf5OYgA8B15bIed44zBEcctV4ojh7YCv6IoNlM
X-Gm-Gg: ASbGnctFH4kEKXhWSRdm/pceyrOU7pT7Y3rNqSHv2oyOxLn4bZO8+YZKeKaAnAEhxLk
	VqVXQ0HshNpKYYeW+60h2vQFfQO+2NnjoFE1FQokk1Z4eh35c3sUv7ekgzAnbyZBzn0h5Dp8KVg
	A9Mpf+H3F4hQ1lnmrCPbsuZAMHmHOFsQR0J4w33pPRiQHRv3WgA/0ZKC5n7T6I/p8SKf9dQZaCW
	OAE4ay31BUVp+ejiWNLYyyl7wb/VJRf5CqnffAyo2wXZ97zS06KfPUaAmGbQrznA/5LDqWpqobU
	gitA21rJJM/BHrSpXaDCzC6rHTViGBB6mimee5h0LSCdkQdzT7XcFaE=
X-Google-Smtp-Source: AGHT+IFE5Q10ytdMM8/SuSSTefTUYIbTBwb4vK2u7waQDWVfRENh+ujjhU4ceANhgI0oVyC+lc+k9g==
X-Received: by 2002:a05:620a:319d:b0:7c5:4c49:76a5 with SMTP id af79cd13be357-7c927f59296mr765340185a.12.1745071004357;
        Sat, 19 Apr 2025 06:56:44 -0700 (PDT)
Received: from theriatric.mshome.net ([73.123.232.110])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925ac4749sm214350185a.59.2025.04.19.06.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 06:56:44 -0700 (PDT)
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
To: gregkh@linuxfoundation.org,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Michael.Hennerich@analog.com,
	sonic.zhang@analog.com,
	vapier@gentoo.org
Cc: gshahrouzi@gmail.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH 4/5] staging: iio: adc: ad7816: Use chip_info for device capabilities
Date: Sat, 19 Apr 2025 09:56:37 -0400
Message-ID: <20250419135638.810070-5-gshahrouzi@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250419135638.810070-1-gshahrouzi@gmail.com>
References: <20250419135638.810070-1-gshahrouzi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move device-specific capability information, like the presence of a
BUSY pin, into the ad7816_chip_info structure.

Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
---
 drivers/staging/iio/adc/ad7816.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 39310ade770d0..ab7520a8a3da9 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -44,21 +44,25 @@
 struct ad7816_chip_info {
 	const char *name;
 	u8 max_channels;
+	bool has_busy_pin;
 };
 
 static const struct ad7816_chip_info ad7816_info_ad7816 = {
 	.name = "ad7816",
 	.max_channels = 0,
+	.has_busy_pin = true,
 };
 
 static const struct ad7816_chip_info ad7817_info_ad7817 = {
 	.name = "ad7817",
 	.max_channels = 3,
+	.has_busy_pin = true,
 };
 
 static const struct ad7816_chip_info ad7818_info_ad7818 = {
 	.name = "ad7818",
 	.max_channels = 1,
+	.has_busy_pin = false,
 };
 
 struct ad7816_state {
@@ -98,7 +102,7 @@ static int ad7816_spi_read(struct ad7816_state *chip, u16 *data)
 		gpiod_set_value(chip->convert_pin, 1);
 	}
 
-	if (chip->chip_info == &ad7816_info_ad7816 || chip->chip_info == &ad7817_info_ad7817) {
+	if (chip->chip_info->has_busy_pin) {
 		while (gpiod_get_value(chip->busy_pin))
 			cpu_relax();
 	}
-- 
2.43.0


