Return-Path: <linux-iio+bounces-13995-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92056A04B37
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 21:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0722418880DB
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 20:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351C21E0084;
	Tue,  7 Jan 2025 20:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vw6fdb1c"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497C8A95C;
	Tue,  7 Jan 2025 20:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736283033; cv=none; b=kGbWB4a/kNsz+f6G8cyfsiEbPxGsdr28x40GIGegzh8UOgMxrL4or/ukzJCI2jgavEE1+iIHaZw3ewgF51NC0or+VHZwhdy49mTo0JW3PyWNUqGRY9MH2BbrEV8kcgl5Pg6PjyamhfvZ/Ms6vL9peKLlF3KL6Efp0or2gd5lXQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736283033; c=relaxed/simple;
	bh=cEDXrzDAGwn89i07P0yWZjAXaeNwVKps0fgpA+pnbg4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TqjSkUxhOUQ6vjicIoHrzSXvi8vCoavaViykFTYIkiahSLUNmPhpSRbVsCc71oW/uI/l0DAxPMhwd6nj/VTIBx6GvitKn4bAiVzR07RA/M0uHZAM/yyVBPMZEa4SFN3dLzIrwgaQmSwZL3gpSD5+uY8uZsDNQl64MCubER+9x2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vw6fdb1c; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4361b6f9faeso1114325e9.1;
        Tue, 07 Jan 2025 12:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736283029; x=1736887829; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bRQ37yVdnn78l8TV/lFd8BR/arBGK2xhRXFfyCcpT6Y=;
        b=Vw6fdb1cSFhW9lVAJHvHhJuPhb232gFDjbwcqe/c+KzjtNCX2ANvDOpabFVS078igq
         A075I2XUOpIChPQQ91/eq7XJVqzl8dlRUQtEvjyvJt2k6wouFTXUZPkCNmDgV9Jgc/sl
         gAPtF3PuJNpCVM0Ly8M9J8pjpoitNTnepeX+LHlLxxFNuOQf5/Shq4L7YkKY9zcccDop
         urkNjinhczfzFl/WDtsekHjcL5BtHlus/dkiQqonTmX6cWdDBcbQRwMYTTqNIvcCRea4
         44BBOQfO0u8ehWnDq4YvYtZ9A+Hv1foksZlN5K1HdgKWR/qjS4uSpHwzV6dZ+Xba3y4h
         hVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736283029; x=1736887829;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bRQ37yVdnn78l8TV/lFd8BR/arBGK2xhRXFfyCcpT6Y=;
        b=cUls1lo0hoifXPnXVfNae6ivLkr9OYw4PIFoaMz7JbfP7bUQRYeaXwvhk7DdSreUGk
         TbOwRFr6kMnUkyfjO6xe6rPvJ6r9gpnCni5GOI5+67pBMuncwxG/uvs55R+bTbDNTDoS
         VNmMAvhHmxGVgVE+jMwXI6MGy7sniSiHOfJoP1UsyEcNa4DiwhhJ0buvthfqeyqVlccb
         eIiGe25C3PBB2GsVMPdu3Tna9jw8bXrCdGUybAmaM686aDoRWOhk3SqXUDWdScuDXpyo
         yCbTjRdbfPBS/MZAmBsBicpQzgeouX0dNpFvksTKrqv2YEEodRe2Qy+slhrYtUkqKDY0
         IpOg==
X-Forwarded-Encrypted: i=1; AJvYcCVisifale77P+roWVcQ9vUtEs5eRGhsox+XCADGkFz115xVB41xipoD8yPTfEg8GsWAHtCRYusGnHNwtMg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Ay0Dyb9Wj22T/D5iDN+E2XargG8doqG9chPeH2oIm8GH6gPM
	OYfnETmSd6mspbVGYVLirSCZl0LtdojcURNStYMZQ6ijZxHi4iOT
X-Gm-Gg: ASbGnctk0lAfQKI0RX/t0Yl8CgNXDdeKM2YPYDFn2Hmt5Q8ykJefq+85mzRmcpU6FeN
	636d6d3G/ggM566ZBXMJRpeBb9KEO/CTJP7XUZ4eS+9iCrdvv40HiR7LdIJ3noyXMFkzkOSkMG9
	xX48reB7VvaNzjdzii3LyREkaKpM8W/xxqO20CWKQ+29TKwap/cxT3OPAeXNeHaEiiSAVZh7ddD
	VVq3KIaZRKnyICT5xqSxC/yW0lEKBw5i0uYZU9NAnwKBBWYnKEulosxyWddFBBJtNC2rssaveRH
	DLRLb5LdEcllCd8CahZULpIENscRq1zummYGWvYQkbYRV3QPotVeEATE1arZnmbxcsRqU6farp7
	ZK8Y=
X-Google-Smtp-Source: AGHT+IGp4cmv6sCBQQPg/Zrz7RZ09VVhlEsurmant8u4hlwnTmzl4oNuuUJMbtzwDaF71BZAK0wOFw==
X-Received: by 2002:a05:600c:1d0d:b0:434:fe3c:c662 with SMTP id 5b1f17b1804b1-436e1e301e4mr4215165e9.12.1736283029240;
        Tue, 07 Jan 2025 12:50:29 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-d595-98be-71e7-371c.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:d595:98be:71e7:371c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a67c77a90sm13164132f8f.54.2025.01.07.12.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 12:50:28 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 0/2] iio: light: fix scale in veml6030
Date: Tue, 07 Jan 2025 21:50:20 +0100
Message-Id: <20250107-veml6030-scale-v1-0-1281e3ad012c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIyTfWcC/x3MSwqAIBRG4a3IHSf4CI22Eg2ifutCWShEEO49a
 fgNznkpIzEy9eKlhJszn7FCN4LmbYorJC/VZJRptbFa3jh2p6ySeZ52yE63JtjOw8NRja6EwM8
 /HMZSPoat/YhgAAAA
X-Change-ID: 20241231-veml6030-scale-8142f387e7e6
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rishi Gupta <gupt21@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736283026; l=2268;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=cEDXrzDAGwn89i07P0yWZjAXaeNwVKps0fgpA+pnbg4=;
 b=UO2IgIrXptGE3VTCWi3tVhFzHWPSw8UVA3tiKrf966retrM/RjRFVKsOcARegOo7rtyIK6MEq
 Pab79Hz+KigC+O6nBbKK43KDdD6/2fi13UoZAllQMvXFi5xaJsJkDPe
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series follows a similar approach as recently used for the veml3235
by using iio-gts to manage the scale as stated in the ABI. In its
current form, the driver exposes the hardware gain instead of the
multiplier for the raw value to obtain a value in lux.

Although this driver and the veml3235 have many similarities, there are
two main differences in this series compared to the one used to fix the
other driver:

- The veml6030 has fractional gains, which are not supported by the
  iio-gts helpers. My first attempt was adding support for them, but
  that made the whole iio-gts implementation more complex, cumbersome,
  and the risk of affecting existing clients was not negligible.
  Instead, a x8 factor has been used for the hardware gain to present
  the minimum value (x0.125) as x1, keeping linearity. The scales
  iio-gts generates are therefore right without any extra conversion,
  and they match the values provided in the different datasheets.

- This driver included a processed value for the ambient light, maybe
  because the scale did not follow the ABI and the conversion was not
  direct. To avoid breaking userspace, the functionality has been kept,
  but of course using the fixed scales. That requires using intermediate
  u64 values u64 divisions via div_u64() and do_div() to avoid overflows.

To ease the usage of the iio-gts selectors, a previous patch to support
regfields and caching has been included.

This issue has been present since the original implementation, and it
affects all devices it supports.

This series has been tested with a veml7700 (same gains as veml6030) and
a veml6035 with positive results.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (2):
      iio: light: veml6030: extend regmap to support regfields and caching
      iio: light: veml6030: fix scale to conform to ABI

 drivers/iio/light/Kconfig    |   1 +
 drivers/iio/light/veml6030.c | 594 ++++++++++++++++++++-----------------------
 2 files changed, 282 insertions(+), 313 deletions(-)
---
base-commit: 577a66e2e634f712384c57a98f504c44ea4b47da
change-id: 20241231-veml6030-scale-8142f387e7e6

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


