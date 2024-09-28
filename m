Return-Path: <linux-iio+bounces-9841-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33240989052
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 18:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF4E628232B
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 16:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20A123749;
	Sat, 28 Sep 2024 16:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTtriEQq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E02728DBC;
	Sat, 28 Sep 2024 16:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727540319; cv=none; b=Hy6I63G+OvFeYSmhdBcWo4WdH/83k1DazSgup/9Mh4RYaawqAm5o/+7HFSULm1IOgpbYQiCwA2rbvLMwPwKPc33fujqx/YsxaOX8i6RzZh9E91EsBeXTKe2I1eV3VImVdn30Ej+PqqbxutvvBUphMz5c763SWB5cAwR2+wDGjJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727540319; c=relaxed/simple;
	bh=Q7/UVw8Tz9lv7QX1qDHQwhSamKjsaRN9XrZJeMbQQQA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pegkHD84iR0LqQse2xtOeY0BJaondRBK5+eYwRpsQRFcl+bih9XTmX3NyRMu+b4xCy4yKL73Qu5IrNgJLdCLdyMU468D33feCXd2y6kiM1SiVZ3PgXegKr7b/m5/d02QQbkc3d27fU74AjqdrmAdn7yK4N721CVjE3kMslIqLI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTtriEQq; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71c5e1ad01cso974298b3a.0;
        Sat, 28 Sep 2024 09:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727540317; x=1728145117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FRCq+GBEzVT7HTG4M+sJRuaSxTn2JAuesip1QVe4vBM=;
        b=BTtriEQqRuWCtUsz6TRtJG38pHTe0JT/SKAMbAJSMUMOnNul24JDai76PnBDiSg786
         OUQ/7sVZdnN/h6tzRnk7RfgdLKJN3WHJYOcde17aHVpNwQXGhVHYoLpOq/GYu0B+cf+H
         pj24sg3W9LmkycmLSq0Vee7qR5ZOHWxP8M3lwO8ssaTbTPNLEs7e9Qne4QqlSt7tYX4K
         rUbmVBnFVhfqLl7dTp0lzgfJrb4Js1+nxcmMjjqh396d2kYik8R6qw89HyGAtIVuybD3
         aaNnTMzqk4FQKLLYDvkvS7/fjMTbSJUfFaXZvw45DpcxaTO57y/ZhrCsYbBZHgOfsMev
         Cuww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727540317; x=1728145117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FRCq+GBEzVT7HTG4M+sJRuaSxTn2JAuesip1QVe4vBM=;
        b=gTkGvpbWc/n8lBJSsgmyX4cTIUkvJpz7L0MYqIcjjZBS9RIL3QmspG6Jg8WEdYmeP5
         1FZK8n+jvffWiHteLEuHUanf5L8wB0ro+F2AO1bnfvRqyPW/22040Iyw4oVEUMj49Y2t
         h/2W9L4cQ19CSjgtj6N39zQBIcQfYFSvu5w8p5ilpInD0h5QyDzKaYnbOu1T9wPhuKY1
         fL/U3mRi+2kOI+DJKfIRvpp+UFBQHUmdfB4eRNp+YMe5FuYFfZ/FacGpz8k22dd8qMSn
         DudsmMbdtOp7EanvAgLB0ZRHzDlfTWLmoh9YrwEitnmOhC/sSekP0WeJJogvJxC/Fheb
         qXjg==
X-Forwarded-Encrypted: i=1; AJvYcCXZBD4mWO4/+j+3QhkQkp8Ni9it7ZCrP9tjG2Jwkj94QR/5EPlJUKly5oJnR+BpkYXrocW93GmwA/bQqjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHa3x8ETKm1RO7yrHRcc8WJ5dTqPR1edZJCUpwFxL0dSXPwwE1
	/WSRYHtIa2Sk3w7KTn2afpH4yz0ro5zi4rcb/N4wHeFt53A4bdWQC431dSntWlM=
X-Google-Smtp-Source: AGHT+IHkIAq5Q5nFt4MMvUMPueyxVV/OWcdSVemRG/01aTNBBDemdgMg6YdrhlOw4e4blbCN4XaN6w==
X-Received: by 2002:a05:6a00:4b53:b0:718:dbc7:2d2f with SMTP id d2e1a72fcca58-71b192af06dmr16926505b3a.5.1727540316837;
        Sat, 28 Sep 2024 09:18:36 -0700 (PDT)
Received: from abhash-IdeaPad-L340-15IRH-Gaming.. ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71b2653717esm3280851b3a.204.2024.09.28.09.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 09:18:36 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Michael.Hennerich@analog.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH] iio: dac: ad5770r: Convert to get_unaligned_le16
Date: Sat, 28 Sep 2024 21:48:05 +0530
Message-ID: <20240928161805.165543-1-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the manual shifting to use `get_unaligned_le16` api.

Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
---
 drivers/iio/dac/ad5770r.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5770r.c b/drivers/iio/dac/ad5770r.c
index c360ebf52..12c98f3e6 100644
--- a/drivers/iio/dac/ad5770r.c
+++ b/drivers/iio/dac/ad5770r.c
@@ -17,6 +17,7 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
+#include <asm/unaligned.h>
 
 #define ADI_SPI_IF_CONFIG_A		0x00
 #define ADI_SPI_IF_CONFIG_B		0x01
@@ -325,7 +326,7 @@ static int ad5770r_read_raw(struct iio_dev *indio_dev,
 		if (ret)
 			return 0;
 
-		buf16 = st->transf_buf[0] + (st->transf_buf[1] << 8);
+		buf16 = get_unaligned_le16(st->transf_buf);
 		*val = buf16 >> 2;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-- 
2.43.0


