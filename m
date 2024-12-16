Return-Path: <linux-iio+bounces-13553-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A83B9F3AF2
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 21:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33EE7168F42
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 20:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441951D5154;
	Mon, 16 Dec 2024 20:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UnMC+KMd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE6A1D4352
	for <linux-iio@vger.kernel.org>; Mon, 16 Dec 2024 20:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734381473; cv=none; b=kYEU4dj7iMlXjKaDEGJUGkbigDpU2Ja6J2zXLGmmb921wnZcS0Rwf2aeYCo9x1Jk08I4c7wWbQy3q72Vf+4PiAFiB13UYFWZOy5nTndg990FpuUNGbhlh+N8LBOzlLdbS1fVg/yZ19xLiOBzk3rMFcOu3tEw/p0xOf+y6P6xj2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734381473; c=relaxed/simple;
	bh=EHy5byuG6WbwH/WIoV7ON1vbDnc/Cuw0X71BpLN71pk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OI69l+f68V7+n3bm/Tbg2YqtGQ/P8vV/wHqHY0f021YEUvUNVpWO04cqLixmBtIyYTOR24h7ykAtklafYtEJrN38U/ZTWg60D1USbiic2dcSQG4ja9XtVjkq9flJGrTCccG4wc0cjKtuzwp3FNY3tVUByRSGDf3uPa4bwvxmbU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UnMC+KMd; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4361e89b6daso31740775e9.3
        for <linux-iio@vger.kernel.org>; Mon, 16 Dec 2024 12:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734381470; x=1734986270; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/uTGbHwpheP7ZTAGPT3M61/wOimoSAI/DIQJehz+WSk=;
        b=UnMC+KMdsaOANflEqx+9YBwxWI6Q6M4V6CwRaPkbZZrJIDjEYuUVl8YZcgSSByG41p
         hNNkDFdWoyedjiLVtJk+4bQw53xLm8zH8OiezEqxdpogKw9X5PURHkRz2kkhVCn1PKjK
         NJ21VDjP4p7ECTjto3PWRLe0zY4Hdpv3W+Eo3If12+3ARArQ8N6MVrrnvPxn6o7daRQb
         A4xStepoMfteVSokDz7V+j2I/tDzRgUHE4jhbd80+Hx86ADagfO/kLXSNILW3l5Al7UD
         vLPrI9vMMhb1IHBP/J1IzFBx1nVVt/pnjGsgmPEtp3HMC/VWz7Kg9W9Yxz7dgx8crLjo
         yU/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734381470; x=1734986270;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/uTGbHwpheP7ZTAGPT3M61/wOimoSAI/DIQJehz+WSk=;
        b=Sl5FuHProTe8Ptysm9hLIqOSbwl3zRZ1/TMWZFXW63K0NrjLWzNpGsVE66B/45Lakb
         MTBiH8wsR9YqZmsqUS6PVz5mu1HwimapGLAmOg5DWqoln6hsjCJzgcmJuWf/PcqfCuUl
         8c8hyGXBfcuCQo9+YVdMmDivOmysgmj0T4TeATxYX0DARpE1FY/k7HGnphoc+DEC0by8
         QmqAs1W435lWYfPvLmTHEZui6Rx9IvX5eBGpmENw66xPudlGnht2XlnfJ1VLSK6dFqhe
         UgWkggcLc0KkxdtLRuitErd7RPqOLEpO2k619jK62ytXBFAeeu6mFAAn54FLXzl/NJBo
         iohA==
X-Forwarded-Encrypted: i=1; AJvYcCUbRUEWNCgo5ZSis9FlAA6jweGjClat1S4bvMm/15voKYzuXAHZts0o3Nl3Ig0JR2PpIazaoh6tP00=@vger.kernel.org
X-Gm-Message-State: AOJu0YySBhvO9cUl+b55ethAp8vWQqzu3DmkLhZtdwZ0ftKFJIZyOM79
	7hXoSF/EYR4FtOmPqrF96V3HN7XtRPf83NXW10nYFv6y32QsqaW9z+oV0oIjqDg=
X-Gm-Gg: ASbGncs2qTNAmjlRzNBPzitzuj9qJDPn423BtFYIxHevyZRfGTqabwISq+GAaSKh1GH
	3jdjJdDamSBC0E4w0voSh6uremwd159fcRIaZ8Fy+c8mBTe93rh9sxT6SkB+qJzq+epqF1swOaX
	x7XtaF3+vHxSlHuoN+/cH+hsgNHS9iIqFkVEvR4LlvCSADVYspmHzOxx2EU/1uydDeJmQNPyx6V
	J04rtwJFS8VF9ZJwllWF/FSi584bZAwa8aXva/dllDh3HN1GFZwOtXDjJ22uhv+u75fMRuETI9Z
	NuFNmlNNJ6rOavnk3LgDDSen0wfMNSaDYQ==
X-Google-Smtp-Source: AGHT+IFNCWVvRQ7+f8hFiG7JbS7X72/g8umDwwWJ5AyRvkEjalQbahlAC2N4g/Q6vqIgCI1W5i1cmw==
X-Received: by 2002:a05:600c:214a:b0:434:f7e3:bfbd with SMTP id 5b1f17b1804b1-4362aa947admr126088855e9.23.1734381469651;
        Mon, 16 Dec 2024 12:37:49 -0800 (PST)
Received: from [127.0.1.1] (host-79-17-239-245.retail.telecomitalia.it. [79.17.239.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4363602b468sm95514245e9.11.2024.12.16.12.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 12:37:49 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Mon, 16 Dec 2024 21:36:22 +0100
Subject: [PATCH 2/8] iio: dac: ad3552r-hs: clear reset status flag
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-2-856ff71fc930@baylibre.com>
References: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-0-856ff71fc930@baylibre.com>
In-Reply-To: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-0-856ff71fc930@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Mihail Chindris <mihail.chindris@analog.com>, Nuno Sa <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Clear reset status flag, to keep error status register
clean after reset (ad3552r manual, rev B table 38).

Fixes: 0b4d9fe58be8 ("iio: dac: ad3552r: add high-speed platform driver")
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


