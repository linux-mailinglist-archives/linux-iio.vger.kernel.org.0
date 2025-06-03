Return-Path: <linux-iio+bounces-20195-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE66ACCB86
	for <lists+linux-iio@lfdr.de>; Tue,  3 Jun 2025 18:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 082D33A5571
	for <lists+linux-iio@lfdr.de>; Tue,  3 Jun 2025 16:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614971C5D57;
	Tue,  3 Jun 2025 16:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VeCW3X7H"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F302F2D;
	Tue,  3 Jun 2025 16:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748969846; cv=none; b=jVSIWGrYgpvClk9XdvTMByrXsDwDmKgJlSpDcVPGSJtcRdR4zrg7RmCfF15HExH9fQrkzKP/T1LE9+SL1bOMzu+ttOX97CQSUhBoUzuLAxS1LQUoT8s1h/sHP/Cx4iRwASxs8xuFHwH85DWK+2aKgGCn+Ls6Ly+FOz9h1VyXw2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748969846; c=relaxed/simple;
	bh=3B62uAs3zA/VMQDhZ2TwDLvyVdR7XXYniei/Wzuok3U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VmsJM9CYejfxobmPEcS0njwL5aYQHMMkzMo8OTKuvJ0I7kacEQPYJU4lWZ1VqStwz1Vv/TAxVWU3batPufq4FuhoHIxdcECz3MeTtWb3UNloooAVxa/lASw54Zt0kzH9jYlOcKG0N0ePFtKudO5pBt2DNPLHbcyXpt75bVtDEcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VeCW3X7H; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3105ef2a08dso48562191fa.0;
        Tue, 03 Jun 2025 09:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748969842; x=1749574642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6nFIdBf+QqGFWI3Gq9dIQExVAMzr8xh6lrtRWiH5QxQ=;
        b=VeCW3X7HkOQyTNw9se5KiSeV8FDibCJ2AoDkb7SUYGEMz4YvwpKPaf/+X63nIciUwz
         l2dMhaRHrb4IaKWkciHU3EoWKwn5R/mKOotP/ZrIE3zDURj8P6lZ1Jb7zvBZUL0bE0nq
         SdZmbOCUsqdUQ+dtm4NWlmIIbcNm7wdiI0MWhg6sxmkx/3OQkwUZH7oONYyfY3dau5ks
         jKEFYvPFB2SVcqEsmzzOywpUg/X8qbr3s0I80DuiSYastpAvuM3cGt9xeRVZDlCwbf18
         K3PyLR+UrSQ7ekGf/SHw8+3zurcRnECo/el9K7fHZp3/6ujO//0LEQ3FiDXfNup02t+7
         KZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748969842; x=1749574642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6nFIdBf+QqGFWI3Gq9dIQExVAMzr8xh6lrtRWiH5QxQ=;
        b=fPlxHx4rKP31YBd2J8WOAfnv6uKWnpNQ3xqf/G3sz5BmxzpeIAV1CBSlSd3E/bGih0
         qJe7UYdgbvBFtOepEyy6CtaKkvLFGSS1UQ/s2I1CcabxaeRlkI5pnnB40GQcJJS4Dy5m
         kYFSwZEZEFvvkNiNm6H72r6dUoJfMTwzwj3x5nq8NsEICyp9FxY9XMU85UHncrv8fIo8
         p51KB63f6Eo3j5AKaEvy8FP6VDz0CNnL1HlJGt7FGWN/RYvdB5ZBkYPiCdHpaB0Qu79T
         Vz5rWhVIKAS5tFTjf8nHDaPv7uSMNjyph/02b8jgD53IZZHAjivohSPYMP6IyvVJs5/D
         CjyA==
X-Forwarded-Encrypted: i=1; AJvYcCWB82Xrtr2mGqP9PRQnE7qw/1rUu5OB0kTygTZuOQVsrS921iLxmU6d99n4YtrzQvP7rvCBr0L1BPA=@vger.kernel.org, AJvYcCWWkd7pZs20HA93+jMSHBbQBkW7DxKjk/YMMdoRJ0y1kV1dctdyudZNgmIKfnUu+c4hB2o29JhhteQ+aiHr@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+j2J/a/AUNwBggC/27wSIJZu2unKCgUK5yCoh39OqAze+Rn93
	ODXXyhhu+qClhU3akc0nQlyXca3T08kuXi829MFnt6Vd37WqUGw8hcXg
X-Gm-Gg: ASbGncv4dGVSTfsDSI3TP76EOyrdD1QES8oaX+EyZ9Lofr6Tj1qrROCzjPnJ529k1GY
	XYEm/EMJ4xegR8lD7LD1VlcikbVgTM/w0M4yd4OB5JfD8jXHS/yLT/mNbPCK6bcJcyYtKcr7BsM
	9vzqhf+4of84n+JCFnMAd7ZCLQwK548vL1g5ZLbm7ocUL9zB/cS28K5chA+GHdr7EfozOyIBKZf
	mxY42U6XSyUMlGbIlMp8C1t1SR6fffT45NcpT/Pt68ieadXOfNjfOGUxdAmLj44CyshbQqCe/6P
	qS9L/KPC5PpB3LJzTTXOB0tGa8mU5VaqdunI6ovaMkoltVWk2Q==
X-Google-Smtp-Source: AGHT+IEyqD/pdPvg4Ux/WCiRHUdofsot85Z6azihhxb4zI10DgVZmdgESbsCOQ/eBcSi+RW/ECGNbQ==
X-Received: by 2002:a05:651c:1549:b0:32a:6eea:5c35 with SMTP id 38308e7fff4ca-32a9e9b88bdmr35442981fa.15.1748969842040;
        Tue, 03 Jun 2025 09:57:22 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 38308e7fff4ca-32a85b1a810sm18724151fa.8.2025.06.03.09.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 09:57:21 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] iio: adc: ti-ads131e08: Fix spelling mistake "tweek" -> "tweak"
Date: Tue,  3 Jun 2025 17:57:06 +0100
Message-ID: <20250603165706.126031-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in variable tweek_offset and in comment
blocks. Fix these.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/iio/adc/ti-ads131e08.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ti-ads131e08.c b/drivers/iio/adc/ti-ads131e08.c
index 085f0d6fb39e..b18f30d3fdbe 100644
--- a/drivers/iio/adc/ti-ads131e08.c
+++ b/drivers/iio/adc/ti-ads131e08.c
@@ -625,7 +625,7 @@ static irqreturn_t ads131e08_trigger_handler(int irq, void *private)
 	 * 16 bits of data into the buffer.
 	 */
 	unsigned int num_bytes = ADS131E08_NUM_DATA_BYTES(st->data_rate);
-	u8 tweek_offset = num_bytes == 2 ? 1 : 0;
+	u8 tweak_offset = num_bytes == 2 ? 1 : 0;
 
 	if (iio_trigger_using_own(indio_dev))
 		ret = ads131e08_read_data(st, st->readback_len);
@@ -640,25 +640,25 @@ static irqreturn_t ads131e08_trigger_handler(int irq, void *private)
 		dest = st->tmp_buf.data + i * ADS131E08_NUM_STORAGE_BYTES;
 
 		/*
-		 * Tweek offset is 0:
+		 * Tweak offset is 0:
 		 * +---+---+---+---+
 		 * |D0 |D1 |D2 | X | (3 data bytes)
 		 * +---+---+---+---+
 		 *  a+0 a+1 a+2 a+3
 		 *
-		 * Tweek offset is 1:
+		 * Tweak offset is 1:
 		 * +---+---+---+---+
 		 * |P0 |D0 |D1 | X | (one padding byte and 2 data bytes)
 		 * +---+---+---+---+
 		 *  a+0 a+1 a+2 a+3
 		 */
-		memcpy(dest + tweek_offset, src, num_bytes);
+		memcpy(dest + tweak_offset, src, num_bytes);
 
 		/*
 		 * Data conversion from 16 bits of data to 24 bits of data
 		 * is done by sign extension (properly filling padding byte).
 		 */
-		if (tweek_offset)
+		if (tweak_offset)
 			*dest = *src & BIT(7) ? 0xff : 0x00;
 
 		i++;
-- 
2.49.0


