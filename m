Return-Path: <linux-iio+bounces-12967-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA769E0BE5
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 20:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A739282302
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 19:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512D81DE3BC;
	Mon,  2 Dec 2024 19:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y96HLoHJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1191DACA7;
	Mon,  2 Dec 2024 19:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733167134; cv=none; b=cGghy1LHGYRT49KhweK8Y7JLXmNtTvAuaCAd/3ro26QG9uTOA/9mEYFPMMXmhIIML7Td0BOe17G04ZXCbUAUU7XWvwOuH8QHSs80vPCF0WB6nsJxaDbjQnjJ3mLUxWjc1mY2p9FkHJ7IpR1sxC5Zrlm86ka/cFqFFNoerK4WY1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733167134; c=relaxed/simple;
	bh=UNYTQCQ4U0f5t75v+3oqKVreEsYoOkeElwGyOVTcyLY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JJPEZ8vSAmQnJIVnWTLSUI9NqVmO0GanjksIqLO4jKDGK1I5ZOUmA2KOFUnoHJPGrfaguL6hABmMupgu33SaDkTurvaCNwlJy02KFdbzmvHdTrMU9YKEGexWiqWYvxaODvJ6AQy95Yi+A8PfsK50VHloT+9RGxuQNQVt5Z1CpEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y96HLoHJ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-434ab938e37so30263485e9.0;
        Mon, 02 Dec 2024 11:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733167131; x=1733771931; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b1M8QkqJkisY/ETmPRqXk3HD34EoSuZs2F99KPXzllo=;
        b=Y96HLoHJkByYQyttJOP9ETJI6xOcm7D2aXkonklGeJ1XjFP/tGKYel6TF+oisD5S/4
         pq1WLhK+3wqU2aFsCsD8vmNpVYg+c5DFR5YTeVwg4M20NH+KnoHlxnsFRZ/HxBR28Jhb
         LzXcfDLyETjVmelqj6osXiIRtcGMfA3S/eQ/wivRs/ZQxZlukYkSMTT/bw8YebQBZr+p
         G8stg/JHjCrzvR6l7OS3dosYvgAItP3atnEbmwQ6+O5tju7nwMj4zcYtlx3x9rc/l4ts
         I2NWI7R7PtU1PhPAuaLkqdly9bRE5cV7aC/mMgcGDfWlRpBuFe6Yr1Xlk9cy/h1VGgAs
         b1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733167131; x=1733771931;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b1M8QkqJkisY/ETmPRqXk3HD34EoSuZs2F99KPXzllo=;
        b=ISvyAEEKNILhKh4DMlnmP2jEG4bGUXwVktlyD+H+ZDvM6d6ntCYBxFDxzExoLR4c/M
         SmmtY4njtgeZhIxQqemHUtzuaoLLWzUTVQ70+P9wAkJSNlZx0WVP8gdZHvBRt00XLbPn
         j6aOAGp6APicv9u6u3pHtmwi/CEUfgKN6ChU+oJSqK/OImf4nTzXXz4FbJYwAHhNQFXy
         B1Its5EYbnDpyrX6ms1lonWaurTZmiAsturZD06Iwo2ACsSWqgt2wa6Sv3UIgabt0IS0
         hPYVGnSYHiVRtW2lTVkqEcW6IC2r6Utwo0cKcTipwUfI+6RkyHsJCjQdMkW3fkEY9Qpj
         /60Q==
X-Forwarded-Encrypted: i=1; AJvYcCUSSnL6gy2+aqeszf3xIur8FAvSCNHI1dMIe4CDnmBfxWPMhnhYc0ucvjdueWMjSW2biQocdrLk7i0AIdR+@vger.kernel.org, AJvYcCXAd7lGs5A816Pemt4vQpTBqq86fLiqNsN1vdi0kZbiqo1/eOWOMibKbyhPbSJpqmPCDSoOAHoJ9JU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw33pT6saPEsrvpRlOZFVscZDWJNqgERAs76ycrvUhbjB8sKl2
	us3tRK7PlWvZJp1JXRFNCUvRYg9KZP89WoJfu46ZfqGrR2MtHFTr
X-Gm-Gg: ASbGnctEgiIgXTNf5Cq8SGdFMzoZjLql6HmMSwflXOZMOF1wYkpNumBDYChdSzk3qnR
	C7lnVyQLoIHHa7qY2PfhWrRBQ4dtvxYt14Kgn2U6stNJPKOi38DZYDJ/a27uVwKo4Fffc78kXtU
	cre/NahZprIXsLWDuqJ2/KQX3lJVaJxJzPWpKEe2mmwdRuk4YqK+D5mTCEp/Jrs/idf5IryCguZ
	FbYgu1Z0DmuVBCvRaHl9ocPLVvpVBhG83sicab9rFP+ZJMnnej+xRiQxKnZnaL1SQoaUzBeJAsv
	K9172Nt229Emav5dditzYdmVpFhpo0It3PlJlp6uxPxfzZ1fahmkdkIUFt211W39CpQIw1m3
X-Google-Smtp-Source: AGHT+IFT1C64b0Tm1Azea/Zf2eWohd4XOQWB+8j1jNvlxpO77F81dukY7Vw9Q+YU53eXBD1Zo5U5KA==
X-Received: by 2002:a05:6000:4712:b0:385:f271:a22c with SMTP id ffacd0b85a97d-385f271a44cmr5002241f8f.59.1733167130494;
        Mon, 02 Dec 2024 11:18:50 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-d553-b993-925a-609c.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:d553:b993:925a:609c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd36b80sm13198423f8f.29.2024.12.02.11.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 11:18:50 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 02 Dec 2024 20:18:44 +0100
Subject: [PATCH] iio: adc: ti-ads1119: fix sample size in scan struct for
 triggered buffer
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-ti-ads1119_s16_chan-v1-1-fafe3136dc90@gmail.com>
X-B4-Tracking: v=1; b=H4sIABMITmcC/x2MSwqAMAwFryJZGzD1A3oVkVJt1GxUGhFBenerm
 4GBee8B5SCs0GUPBL5EZd+SUJ7BtLptYRSfHExhKkrAU9B5JaLWKjX2i9A4Jt/MNdNYQloegWe
 5/9d+iPEFYunm1mUAAAA=
To: Francesco Dolcini <francesco@dolcini.it>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733167129; l=1359;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=UNYTQCQ4U0f5t75v+3oqKVreEsYoOkeElwGyOVTcyLY=;
 b=VpZJFmK3vOM2cCjPBIBU4i3shRgvvAyHUK3ZhesaFeokMS1oaiA+x1goyqgQ3EnBYNv7UMI+Q
 EzCX1DcnvDDDa2lMs8+5bm4N8BO+BxtfoILcC4FUsmUOMxxspCbnlfH
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This device returns signed, 16-bit samples as stated in its datasheet
(see 8.5.2 Data Format). That is in line with the scan_type definition
for the IIO_VOLTAGE channel, but 'unsigned int' is being used to read
and push the data to userspace.

Given that the size of that type depends on the architecture (at least
2 bytes to store values up to 65535, but its actual size is often 4
bytes), use the 's16' type to provide the same structure in all cases.

Fixes: a9306887eba4 ("iio: adc: ti-ads1119: Add driver")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/adc/ti-ads1119.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads1119.c b/drivers/iio/adc/ti-ads1119.c
index 533610ac214e..6637cb6a6dda 100644
--- a/drivers/iio/adc/ti-ads1119.c
+++ b/drivers/iio/adc/ti-ads1119.c
@@ -500,7 +500,7 @@ static irqreturn_t ads1119_trigger_handler(int irq, void *private)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ads1119_state *st = iio_priv(indio_dev);
 	struct {
-		unsigned int sample;
+		s16 sample;
 		s64 timestamp __aligned(8);
 	} scan;
 	unsigned int index;

---
base-commit: a0d6ec6575fce400e976af1dd9223823251775e9
change-id: 20241202-ti-ads1119_s16_chan-2ae1d6f5e1b3

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


