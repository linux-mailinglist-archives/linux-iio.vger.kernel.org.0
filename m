Return-Path: <linux-iio+bounces-18366-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1671AA9466A
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 03:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED6D93B56E5
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 01:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389AD199FA2;
	Sun, 20 Apr 2025 01:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDmmVT8J"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D184148838;
	Sun, 20 Apr 2025 01:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745113758; cv=none; b=H8VgSpgzUSQylwl05OzOVk4Dnn0yM7eEXcohkrS3cunHe6d4v0xlMZTeXElUMdxYzD0gykTKublL6Wk2dzYfkDg1FgGnAOpn9fqP+VH0oaQ0KFpdkyWpnbT5UP+V0a5s5rEdrl56h4O0A9dJXmFPTzdULpOiTTJx1wuZYC35bJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745113758; c=relaxed/simple;
	bh=IeGkgU0YBXtfAvHiWobFFEYEFFchmZKYlSuvetJAaME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QGcbMRqoX732ecLx6DL2v9eL2Y2Y3ORUZZsGpyI1xLommpZu+CwXoE06L5Z7A5bnK1dgR35Rp7DCfMam0jzwYj6bjIDvjRHEyUHWSMOPzN1R65dNasdHsBdoXHxTIyrFqY6stacg4K30kpzPgLgd/yQvqujH0hOiyjuC9Cel82A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDmmVT8J; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6f0ad744811so19435676d6.1;
        Sat, 19 Apr 2025 18:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745113755; x=1745718555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWMbB3RCjLtzIka1EeVCBu0jLU/YK5i3+0Q0+aZfr+E=;
        b=IDmmVT8J97niHusDSiMgIDsZBRNIDsRkxi0+/iQX0T3VyjpI9O+kjA+qf5FYsPDpAQ
         MUzryj8vVLHNkwz0uH78tH4ZnP2wTEERSTuHxbDbWj7qBq1W6w/5jHwY655QfDUYKMag
         rg85of/htsocguZAQT+S827jAIDOXXveOo7Z+OEyHu+1AdUNH+nYh3UDAJiLyhn/1nQq
         Fcjqj+9PIiULVGwNQoKJYsZlXdnaedN8bsVp7PyWqrkMFVe1dO8qLc4zWOOp6690sTtN
         UtIyCV7Sg2mIrnCKjXcVKq3c8J+pXlpVI5xbJkz7kbGmKidBMeVPO1qh0C0knjbc2VGg
         ZyQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745113755; x=1745718555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AWMbB3RCjLtzIka1EeVCBu0jLU/YK5i3+0Q0+aZfr+E=;
        b=sfHF3SZi3m22+zuSg5qZZtHr0A43OlaUeKAfm9MBskaXfOP7ngBkzpKFrF5rvMijtK
         dr2efU0I/8+nxdxOWu02mulUQFBbXQHt/wa4izKDVDHLQvwJUy6tLtU+0geoYuHOuCVC
         E61IFmS+UqQIt1LnNJKHIz114XyenNmwFkCw8o33c3ci/Zf/5rUqhVbJCzaLnshUdAPq
         UtzdWezzBz9mtHOSHqWHtoT+E6phnu8Q3jFxlQD5Ja9zhiliMoPopYYfkb4eqtEDODdo
         FpcFZaXMWAGvtDNoEJYL3hcWyrMgYW1/4h4145wmVzFnX4T3ZQ2sH2kK754qBHtSg1Gn
         11sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMrfXT5WYUeByjvkkO80xu3tzJNZvxXBWGHitvt7AgB4liGUBcqjjIbyNkslAXKnEVgdEs7wKVmsY=@vger.kernel.org, AJvYcCX8056cdmNMCOHm9cwPSUhomw/+eMHvocNTOb8wce7jZGrJzABeJBWkUAmzzQVfVvYzwAnAkDSLV1hsOrcr@vger.kernel.org
X-Gm-Message-State: AOJu0YwAFqOCNWn2nrVLGLtL5iWNffRKIV9OnemgSiCc3jmZ77e6Msmx
	ulKCiygPZfuhOS7s+xsaWrBdXxeFnmugjb0L4WDEprl66W/cJe1rvV6ClI2I1D4=
X-Gm-Gg: ASbGncuM3SSX9GPdTA2lFUk37+m78OH+d1xPIJR00ZxombxxrCOf27ynmSbBrzo0BZ6
	1wYXMeNBagOgZi0rebLdBVvehBQmDznBuijMg08DZgIp9eudHizbmclYmw8u0+aGWEzocshd0RX
	Z5kdwMtfhRga0CHvcFAvXoYVnqkCZxnUgsPnLiXCtLER4ya6vZ3UMkt49RRdoSJ2yfVqlGhkC+I
	euzMNOtMYDyx5lXsb7X3yWOZb8tbafvdrwOs1HotNjESSwHZpYXD/fJBRtWWKKOYRKdjbmuZOp3
	NVBNq0N+3ZbLj7Cs5A1YyGrsJJK6q1GeCNFpRh5xohDWAlt8P3Cv6y13hHumrjQ5Ani8CFM8Dr3
	aO6RwGRUQ0QzrNQyRPhZLzkddZvPcaw==
X-Google-Smtp-Source: AGHT+IHlRgFSQA5uuSHMeGhsfwbPFm63bB0A1m3Zb5IbIU0lFNk5InMgcrcqFUNR30HKIJT0f2f5IA==
X-Received: by 2002:a05:6214:f6a:b0:6e8:f88f:b96b with SMTP id 6a1803df08f44-6f2c450aab7mr123047676d6.9.1745113755276;
        Sat, 19 Apr 2025 18:49:15 -0700 (PDT)
Received: from theriatric.mshome.net (c-73-123-232-110.hsd1.ma.comcast.net. [73.123.232.110])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2af1283sm27583846d6.23.2025.04.19.18.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 18:49:15 -0700 (PDT)
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
Subject: [PATCH v5 4/5] staging: iio: adc: ad7816: Use chip_info for device capabilities
Date: Sat, 19 Apr 2025 21:49:09 -0400
Message-ID: <20250420014910.849934-5-gshahrouzi@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250420014910.849934-1-gshahrouzi@gmail.com>
References: <20250420014910.849934-1-gshahrouzi@gmail.com>
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


