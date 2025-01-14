Return-Path: <linux-iio+bounces-14354-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E530A10ADE
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 16:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59CEC3A90AC
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 15:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17489194A74;
	Tue, 14 Jan 2025 15:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Rww4GutW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BFC15746B
	for <linux-iio@vger.kernel.org>; Tue, 14 Jan 2025 15:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736868710; cv=none; b=T1FZUWhsWeddyBKtHl6jBc7JT6L+dvAucFCMnU8ONYU60RKQ4r3Y1eXjJsqzOeUwEno4FyhA4jZ4keCsN6Gi3EJFl2SrCU6DcUFZcscwK1T3u75IEyBWzzZAucYDltjfrBMNs1RPc7ZcGeeR7rIP8yPKrI2MnxtRYIWdpotDto0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736868710; c=relaxed/simple;
	bh=WwKlVxTv7Oeh09OXx+DvjZEFIeEypUPrgYxitxNiF28=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JxQ43snqW+DlfV1MvyTUCjny5H8br/1DNJvAMQR6vWrp019jmuVwzU9+jGcu53r4JGjEwCJ5YforNY6FsI1pVheU1Szpx9gMuBrbBckcCJ11ZG5dkVfDT5Ti7T+zrEPwxkoxnx85kscH5wPteqxvF0eiha4tmQo5khkOMx/vFTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Rww4GutW; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-385f06d0c8eso2952333f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 14 Jan 2025 07:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736868707; x=1737473507; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RmYlx/En2aqqfgAz0OoSAfJ3wizK8wbnQXwhJAWjCCw=;
        b=Rww4GutWC7vy+903fwKqVbdjh7ptEPyodeJR5ErcStemSSqLhX1SPTCJ9FrsFAXgZ2
         HnKPqTawsKKkS9U8f+bZalPWMEIKAvvcjoKx3DCW3ev3UjQZ6IQYWQ3zewrLJ9htH89U
         9Kdp/tt73zZn/hHuk3jkghWjMz+ygMu1bUR+93m1cGxnZES6GF/L5gKFCV6SCR2XSK1d
         ua93ucYSPIWCFbLl/E4Eh5M9f0lGe9o1i51+V2N/Zszcxcq+110hnNyXbfTtcH+jyg7G
         b+n9j7auq9rX858JGzkeYR4ezqHSxQtTLLahC8Q8/U2GdJa2u4OxGODu2iipikWArtUl
         8cFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736868707; x=1737473507;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RmYlx/En2aqqfgAz0OoSAfJ3wizK8wbnQXwhJAWjCCw=;
        b=mjYn1U6/5FBGF8EiMeLsti2KxztH9V4gxSpJ7JSDsbQvlb9eRe5p8LeVTkicLEqC/w
         T0J+a7GenoFUSfMtX9S3vWwPkFob2HZAs9QiV5upaVr3mXO79q9zsnyD6WICEiSNpKUq
         DnHmN6E0KX3ytyWnHXCyaypsYQ+uKmEDChEvCH7W0Wjs1USIp884CBEhPC+aiyFrm12s
         4aPQHaUmMFO5ehz0ccbMCzjuDfe1b6Be/xEtMj3RPihLw0mh0F753EpZ3R1AWqTCAXS4
         WMI+lSlH7RgjOmniC2YgRQSQawPHH7xG2xaTz2I18M1ZQEyPXjMxQLhwTkwNj5JqE9k6
         GsyA==
X-Forwarded-Encrypted: i=1; AJvYcCUSQIUt5aqZjsFEyoPdL8n9auaLVKdC+wew2QuF0TBJwnhnDqacYkhfj3Ht+XZ+16qSBjLCL2xIcwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfMDy6y1mT+iRDkVg+G+5oaKbPqAkaWSq/yNziZbsFZJKDLhki
	JD60Eo6BQ7WDpl1Kap+FNkUM+427nwKDNxTooNSye25IgGLaoaZP+2vF/AoJ9Gg=
X-Gm-Gg: ASbGncs4Vr/TpoAhmqMf3867Rdzuktfr0XVMsPp3alTYM9eLxmDfqxRQxQxUKlon9L2
	gTL+Wlr9c+YkgQTDI4ApaZVKlx0t1ERQYhsa58z5DcyRNWwGikT8C2aUnd6rE670jTMpVODESZ2
	6ITe0pI9T1fQL8dQOJxU04LpDTo3kz+oFugbmouAfXJTsim03cNWRyx9pQZTeiq7HUz+Po0cXwl
	yzF6yH9I6GAN8qjRcO0Oz/NtRkxG+05PWF/dpDEscLrLp1lWmk/L5f0wyc=
X-Google-Smtp-Source: AGHT+IGTfu68TjbqpJhz91FbPuANOfke+PQV/4PPq6Ra3BMMNeQguSEVyw6KgI7jOnEtN3nP89YzHg==
X-Received: by 2002:a5d:6d0e:0:b0:38a:a117:3da1 with SMTP id ffacd0b85a97d-38aa1173f70mr10969153f8f.5.1736868705806;
        Tue, 14 Jan 2025 07:31:45 -0800 (PST)
Received: from [127.0.1.1] ([87.13.70.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b8116sm15049907f8f.79.2025.01.14.07.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 07:31:45 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Tue, 14 Jan 2025 16:30:11 +0100
Subject: [PATCH v4 2/9] iio: dac: ad3552r-hs: clear reset status flag
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250114-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v4-2-979402e33545@baylibre.com>
References: <20250114-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v4-0-979402e33545@baylibre.com>
In-Reply-To: <20250114-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v4-0-979402e33545@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Nuno Sa <nuno.sa@analog.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Clear reset status flag, to keep error status register
clean after reset (ad3552r manual, rev B table 38).

Reset error flag was left to 1, so debugging registers, the
"Error Status Register" was dirty (0x01). It is important
to clear this bit, so if there is any reset event over normal
working mode, it is possible to detect it.

Fixes: 0b4d9fe58be8 ("iio: dac: ad3552r: add high-speed platform driver")
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/ad3552r-hs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
index 216c634f3eaf..8974df625670 100644
--- a/drivers/iio/dac/ad3552r-hs.c
+++ b/drivers/iio/dac/ad3552r-hs.c
@@ -329,6 +329,12 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
 		dev_info(st->dev, "Chip ID error. Expected 0x%x, Read 0x%x\n",
 			 AD3552R_ID, id);
 
+	/* Clear reset error flag, see ad3552r manual, rev B table 38. */
+	ret = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_ERR_STATUS,
+				      AD3552R_MASK_RESET_STATUS, 1);
+	if (ret)
+		return ret;
+
 	ret = st->data->bus_reg_write(st->back,
 				      AD3552R_REG_ADDR_SH_REFERENCE_CONFIG,
 				      0, 1);

-- 
2.47.0


