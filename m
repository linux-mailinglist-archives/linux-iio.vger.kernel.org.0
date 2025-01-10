Return-Path: <linux-iio+bounces-14092-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC2EA08DE8
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 11:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCCF816914D
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 10:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E89920CCCA;
	Fri, 10 Jan 2025 10:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ALApDXEh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E8320C471
	for <linux-iio@vger.kernel.org>; Fri, 10 Jan 2025 10:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736504757; cv=none; b=IEHoMkGjAZwM0+NLYicCDPqti55x1+jaSfH2DWD/QjcPuYzMsfnR/5HICXd5iSjSGOj+cdEzA/Nn4tTIsP8jjBfiBJRaIm4rZwWHSk7GDhdiO8+tM60jv/v6LsBVrhvKJ2UNYNno9Uy3KBv6/tfFYfaHLRhsf6jAjLujUiGQub8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736504757; c=relaxed/simple;
	bh=IuHaI/semL+Hv8JNr40Pmjd0RO8u7Ce4lu8w8B537I0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GZXkdmAcWXT+33Dz3+gNoEFKBAO370o1bN/ZE44eoD8OnEWHYIMKKEI6vi3ZVQmjgnG7iMSZdtYfklp1DxOq0YUZ+haBf64Kj8Whgr4yUJTFZJjJBuXMM9A4BuITv0mKCX5H3KZsVMfaDh+vBhIufjGNr3jOv9dQyKUW23zsXI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ALApDXEh; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4361815b96cso13693745e9.1
        for <linux-iio@vger.kernel.org>; Fri, 10 Jan 2025 02:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736504753; x=1737109553; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=szKwztPhzV6CVF/0X9HGbGEX7Uh9TD9UOgptum5XTx8=;
        b=ALApDXEh3OlM4oxg+GozuS2phdcQ0sXXmBzbwaPlqscwWTwjvmn55PmUU0daQ0Lfut
         +Hp88trRBbiUWN5bqwhQKGh4kLX2kDS7/ERJrzWVMqCqDmvpZm25lMwYYktOciIxqkVn
         Mkw8jsLGyfPn1wzMfzkzKdjuwDnxfnZBwMBttVzJL8Ql1MCfNI3szOR/jsQgYUm2666g
         QcNVX+agtfLl2OKKNXXZb30VslQiw2b0B4iroCL5FF+CCJ18WWajNeSFG557dVcM/xbf
         VZ5klflBOYlgfElCbzhkMbZH2s7i5nuiXe0kko4OTxkVQzRtj4HGj8jfHCkC0R+EH1Gy
         wOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736504753; x=1737109553;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=szKwztPhzV6CVF/0X9HGbGEX7Uh9TD9UOgptum5XTx8=;
        b=ZDEdLo2jFw3LHxtBQI84Z9VFazhQeysC6VO8wAPdHKQEPySRNatr16EJPxjjcWx3bu
         ygRciPmrZRbBcQ1TIld4Nc1CUV78TlLuFU2YoqDSmRvJy8+AZ7uUBhJ1ctZKe6A3mnAY
         HyHbWNmqfZys2PH3t67PMGuw9FWNEbj3qthm/E4ZTBeptQZ/2YiN8heyNNUbomJeglmd
         M4t9QYvf+Ca4Ac5Nd3CP+uH/EenZ167ZYmIVPz+Euz+s4b4mokfgO5QAKZCkVF5BFc1D
         59n1bKhEoewlhu19m0b1oIlbHm5hgWCwwyCCOajS1RkUWLc6uhyCsNcaUJQNhgpTuvtz
         tyEg==
X-Forwarded-Encrypted: i=1; AJvYcCX7NcCTbAESgOF+OkV6ut8EDwy1IT2e3d012fQj/rm16EiuU1oxbByy5AH7/CktRXL2Rm8dZrdJFXE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk8xMTvSI71VwKlIJJrFldKrjlkZHtUt3yh2LDegGb80wJY4pU
	PqRuV85uBobs6KaNQ57KTpAJ4I67Nv/D+y9/tYoYvi6k9fUX9jkuyXGynwcr7Ka6rK2X7itHNH5
	t
X-Gm-Gg: ASbGncvkaZvkNWiB3z9QBRrhfTKNE98WlskJ3tZ2mF6PXZr1O9pXIziFIutN1Y2o9ih
	p5WqW9zwtprvFIJt5pTT72P8Em2YQ1REo/fRGDwgDT+9UXjO/3pbdeZyyhf6Iv0hxwlRDvNbGZ9
	fK13gkx+Mj//DRkKIbhN5jOGfJvPwvSUOUfDezruAiCANcNZVKEU6RizoDuhxgCt5mPWnnYLZfs
	Yk8NAYJFqyH9NJ2Bgl74X45nOX2h/9AzOd6fLIa09uE+RF8CX3KQTwYK+U=
X-Google-Smtp-Source: AGHT+IGNS4AxOhKeAKUJUDRT1G2Jf4e2tT1rbepjOnwCwFe20rGAGSm7JFfzQTBHtaUnVgT5XIJj1g==
X-Received: by 2002:a05:6000:2ce:b0:385:ee59:44f1 with SMTP id ffacd0b85a97d-38a872dec2amr8572781f8f.20.1736504753515;
        Fri, 10 Jan 2025 02:25:53 -0800 (PST)
Received: from [127.0.1.1] ([87.13.70.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d085sm4246430f8f.13.2025.01.10.02.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 02:25:52 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Fri, 10 Jan 2025 11:24:17 +0100
Subject: [PATCH v3 5/9] iio: dac: ad3552r-hs: fix message on wrong chip id
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-5-ab42aef0d840@baylibre.com>
References: <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-0-ab42aef0d840@baylibre.com>
In-Reply-To: <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-0-ab42aef0d840@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Nuno Sa <nuno.sa@analog.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Set a better info message on wrong chip id, fixing the
expected value as read from the info struct.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/ad3552r-hs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
index 8974df625670..27949f207d42 100644
--- a/drivers/iio/dac/ad3552r-hs.c
+++ b/drivers/iio/dac/ad3552r-hs.c
@@ -326,8 +326,9 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
 
 	id |= val << 8;
 	if (id != st->model_data->chip_id)
-		dev_info(st->dev, "Chip ID error. Expected 0x%x, Read 0x%x\n",
-			 AD3552R_ID, id);
+		dev_info(st->dev,
+			 "Chip ID mismatch, detected 0x%x but expected 0x%x\n",
+			 id, st->model_data->chip_id);
 
 	/* Clear reset error flag, see ad3552r manual, rev B table 38. */
 	ret = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_ERR_STATUS,

-- 
2.47.0


