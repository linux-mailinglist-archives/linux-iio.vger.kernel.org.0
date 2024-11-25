Return-Path: <linux-iio+bounces-12655-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B749D8DC4
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 22:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6F0B16A28D
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 21:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED171CB32A;
	Mon, 25 Nov 2024 21:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WK4c0M4T"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5BB1B87DE;
	Mon, 25 Nov 2024 21:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732569385; cv=none; b=lvAfGMmCLmQkeOhjbWAyFMli9nliXm4aJmIkpc5xST49EnqtScW/AxkXezDNQaEaySWLbtnGDTA0R4xuK0UA2pSc/eaejiU/cfGPh+AivwbaqTZgt9XziR/ittRyeXSsB8yZ9HzMWZXE8YPTkPketj+a+R8iHQtg4LaVnDZSONc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732569385; c=relaxed/simple;
	bh=4X4x3q7FZNx502nxm7s26D+sOlmBbszT1dfj9EmuXt4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oOl98hPpniLORWltT+FeH3Jmj5yFqX4TG+ns92jOCGDp2668ibBnNfzqaQ1QaA7XmNCGo6ZrI/aM/ogKlD0fiKVNMDpfhZYMx8nlW2/Nkn37q6V9mPqEPzKNZXdoCTZN+HFG0aMaxS2nZVHWDOZjHNwgiMOvhdki5XqOHja8JTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WK4c0M4T; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-382411ea5eeso2787184f8f.0;
        Mon, 25 Nov 2024 13:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732569382; x=1733174182; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G6J94mRhaR0bTMOB+SdMX1VKM7f3jssSX2qY9c9Hjqo=;
        b=WK4c0M4TXg7XMMhfhkCn4w1UM3u0LDkn40fJI5mfAz9WfL36Ch5PYCMigFDamWil66
         LPjOZERyR9hJ+U+2RluSHSzgbk79JT94DkRjnf2z44nHq1WjjCXKe/I9erO/1JJtxX72
         PY/i8ZNFXxPHZnPyKEex3rAlWG5wqYd6CV9fDtACo99tZsrOim3PrYG6IRoTy9/rDOzz
         uBsBudiPG+X/BFIUHddQLoGQuZ12jMVzJHKs8xSOWCQUMVA1wHiQLOVEt8V6f1PUcJv9
         z1zdLFl2Cxetni9uLa+GyUVBYi1xUjhpS0uiJlvnonIgrZjI1xVXa+VCCtLzj9iq72f8
         pZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732569382; x=1733174182;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G6J94mRhaR0bTMOB+SdMX1VKM7f3jssSX2qY9c9Hjqo=;
        b=hziW82ddJyN43YMyN9dW2kJP+qVlABqCjPcNset9rYLdXNmPQSmwMIY0+SL8jcxeVm
         gXZoN0hqJGuYvguuFODUQoyuz4eyUk+pYxIky4rN5eYTxFaiN5nglDC6ebMug4pS7apT
         eSi2wvHkr1SS9lu0IIet4tK0vL5mQfGMG+Pp3OI4KKV2hA4Mb3nVxB8C8tMf3pOQ3n8P
         jjgbrdffcnr7HSrhhS6TfqaI5t2BN+U8CNLR3t2E/hjYtm3qfv0Jg698Q4uO7yTGSN2g
         VNp6lBuwWZE9vFtIazq9of17OhF7oHDQiYZA7a+fARGPJQOLc6CoFYAf4cQ5inAJFohH
         B+gw==
X-Forwarded-Encrypted: i=1; AJvYcCVN9Cu4QC0asq3AFeq/4sTFmTs/VR5nSsI4W+naoOdjcchMfDMhGzhBHF5YXuimrA27b+suXSUw@vger.kernel.org, AJvYcCVe3kMCtnBK64ghwBfgJLW8BCk6Yziu/4ZfXEgAOncL4U77W7qu7TSW9U+OqTiSTZ8Y7bjFPXf+8fk=@vger.kernel.org, AJvYcCVrgdV2QULCsKL+ow6eOfJmi+a81SuFTAtRCbQyyyFIxb8rES6OlszQQby7hN4tpio6q7GeM51jTmB1HZVP@vger.kernel.org
X-Gm-Message-State: AOJu0Yysn8RtGDOc/HqFuwO4rYDa0gzpPnnNRwgsRgn3GCIgfpkAnpne
	OIQUQ2K7gZ6Y2d4jpazp6RA9wm0KWprWaxChN3gY7o29+VemcTCj710NAA==
X-Gm-Gg: ASbGncuZobqplGNjNsK1fapt1qpumf4TK6ThtXT/0TG7SwIef82fbJF1vdYh2/Cuz1B
	PG4TCvTZv0x5LIzoh9X+gNVtGzdyP3/jDtnp9Mc91EH9/N7ladlD+cWqhSfNmIw4srGm5iuuOLb
	o7VL6MMmsT9HeKUNE3gMgEpt6ffMtZXPgEeIk6LW2/Vgrk1s8zeneKpO5+XGmeIJgN7fELt+ivg
	Myvu+EdRKXTSV1dq3XlHF3+Z3Gopttrse5GsCUYgH8xnwwO/PSlOetq7SN32PHyyRk7Z52jjEmT
	pIuiUm0fpbZdCeo6QEfKxpMr873x3wY3os99sglLrEX9ZDc8HHmOlnMjlb3ilqHh8sWh6Jst
X-Google-Smtp-Source: AGHT+IFT12uVSCCAWkgAl4GS+z0y2451loFILgsF2SZnv69V28ljASoB9jrjNKXLWcU5duZH34tNpg==
X-Received: by 2002:a05:6000:1ac8:b0:37d:3b31:7a9d with SMTP id ffacd0b85a97d-385bfb14bbemr820879f8f.23.1732569382214;
        Mon, 25 Nov 2024 13:16:22 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-eff8-ad65-1bf6-3f21.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:eff8:ad65:1bf6:3f21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4349ca82957sm75236295e9.33.2024.11.25.13.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 13:16:21 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 25 Nov 2024 22:16:10 +0100
Subject: [PATCH 02/11] iio: adc: ti-ads1119: fix information leak in
 triggered buffer
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-iio_memset_scan_holes-v1-2-0cb6e98d895c@gmail.com>
References: <20241125-iio_memset_scan_holes-v1-0-0cb6e98d895c@gmail.com>
In-Reply-To: <20241125-iio_memset_scan_holes-v1-0-0cb6e98d895c@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Antoni Pokusinski <apokusinski01@gmail.com>, 
 Francesco Dolcini <francesco@dolcini.it>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
 Gregor Boirie <gregor.boirie@parrot.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732569377; l=1040;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=4X4x3q7FZNx502nxm7s26D+sOlmBbszT1dfj9EmuXt4=;
 b=9hTH3B6nj8K6TTD8NVnbqQez5IriunG2L4qgRAHhIb2EfgxwqqYU1ZL+oN89IAQv3P/gz/JcR
 PXhNbMxrbXiAWOpAOfF+HkdKPZnrgfUfe1OedAIeCpL5bh44PZv8PYG
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The 'scan' local struct is used to push data to user space from a
triggered buffer, but it has a hole between the sample (unsigned int)
and the timestamp. This hole is never initialized.

Initialize the struct to zero before using it to avoid pushing
uninitialized information to userspace.

Cc: stable@vger.kernel.org
Fixes: a9306887eba4 ("iio: adc: ti-ads1119: Add driver")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/adc/ti-ads1119.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/ti-ads1119.c b/drivers/iio/adc/ti-ads1119.c
index e9d9d4d46d38..2615a275acb3 100644
--- a/drivers/iio/adc/ti-ads1119.c
+++ b/drivers/iio/adc/ti-ads1119.c
@@ -506,6 +506,8 @@ static irqreturn_t ads1119_trigger_handler(int irq, void *private)
 	unsigned int index;
 	int ret;
 
+	memset(&scan, 0, sizeof(scan));
+
 	if (!iio_trigger_using_own(indio_dev)) {
 		index = find_first_bit(indio_dev->active_scan_mask,
 				       iio_get_masklength(indio_dev));

-- 
2.43.0


