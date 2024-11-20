Return-Path: <linux-iio+bounces-12431-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8352B9D437E
	for <lists+linux-iio@lfdr.de>; Wed, 20 Nov 2024 22:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42CD81F2262A
	for <lists+linux-iio@lfdr.de>; Wed, 20 Nov 2024 21:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8681C4A37;
	Wed, 20 Nov 2024 21:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wuriinmc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957471865E5
	for <linux-iio@vger.kernel.org>; Wed, 20 Nov 2024 21:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732138445; cv=none; b=MEGJ3+WDtjGwkY950hbRo4pyD/DC7zbDDZVbITQ8PTpoaSBXzVoszSv5hDRDkFhDOX7aeqMyyiqaoRYeCeFH+RmL9JAWcuxE98Vj3EfL9cqifGovQdCkH1MW6XmZolDsLZKgSIlVCT72psrNrvFPmJENO8BeJIYWuG67ouhD3Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732138445; c=relaxed/simple;
	bh=Xl1ucGBXN8Ab5O0eTwCrzfVk4oVpsNxeeYYkgyTO4wY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iPCZNEKj0TM2urLpUgFvY4P1wl59giTZ4bnqMaqNB/S+vqRg/qEVzKZjKTiUPtk+JNueAjNDXU/mw9u6VUvp7E31VstYvwS1eN06m2fqA96coplbu3nHJd6Z6IMy++sl83k0itslkcFpBeCoZ+mHjx7+ofnW2gjF8pym4ipys1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=wuriinmc; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-29666708da7so214594fac.0
        for <linux-iio@vger.kernel.org>; Wed, 20 Nov 2024 13:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732138441; x=1732743241; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VHXzVn+FU8SfAawuWvQ4fvCX8mEpHyw2bPUQ2RW2fhk=;
        b=wuriinmcL4FcZNRtcRO4HMfannXHXBdtNfM5sk1A+yEvqL32hwpQnxg1uXsUGfhDK0
         4/fJoz8RyM1gW3KslFzlhpaDmlwuhM+zLh/mTDVnOLfDHZg7+g9gewVtnkjAusqBDWS+
         zBzuGCqwygjBYUIQ2oDt8o0SFyBNnODAqkl93dwJaGDvhvsnogYuzl85oo7L7S704B0K
         Jq0LJhZxAd07TvyW638WuAlieOzB4T0nydumlCTJglV2mVV9vN44RkqyYG9gG95kEvuj
         JNXsfm3XYwJgE01hvfnOdjx4iXIaLTRLhjAGkM3eak887xIdpZdhmNYj4SZDTRIXQsLQ
         UVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732138441; x=1732743241;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VHXzVn+FU8SfAawuWvQ4fvCX8mEpHyw2bPUQ2RW2fhk=;
        b=JWQrUIjlFrsw942ZDYRybc28atAGS6rDfu3470TOOS4MBgq8ZgDkR8l1B9cbPRCM+O
         xEljvQyT1l6MM3Bp7NopXHh26IXWNUnTp4eFwD2U45jDtDktPb+jGU7y+5+pJ6US0bZe
         RDFSeGnLdL0YC7LYNN4CXlhGJ16fZEiq7dc4LKPNVX1pzhTAbZtUqniQusWld8+IyHFg
         rJRyerQamnrYx3lYhOOCOgBu8XezgEoYEB3wxu7+5DWlJFK5CjGf3o18TqUviOYWMBnH
         yh6OuhAHOWftTFZXtfZKs1vGdQED/EytRU04Tk7+Vp/XGJBVcprsCuiFGUVgi2KzMq+i
         EWIw==
X-Forwarded-Encrypted: i=1; AJvYcCXT20tDBvFSNGfD3+G4LHMkg9Po1adbWkIEhh5loaFgJCs5jvT9ovuPsVRlcrDGJp+1rGKvy4R9zww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9kOd5lD5+h3Zm5++jnl2JkX/1eN7v0rYgFHni9C27OhIGTeOy
	AxfVklrjMJYQf4GsWoQxPA3w31S8YAw8wUGpgAYRiyWAdCHYjsw08D8kcfpLlgU=
X-Google-Smtp-Source: AGHT+IGmeO3UOuBcBMbAlPJkDaHTLSKEPkagM4+DYmypgIFQ2jzYAjNyXEq+HRTkEog+qDgqDQQpMw==
X-Received: by 2002:a05:6870:aa88:b0:277:caf7:3631 with SMTP id 586e51a60fabf-296d9b157bfmr5121861fac.5.1732138441704;
        Wed, 20 Nov 2024 13:34:01 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29651852c27sm4487365fac.2.2024.11.20.13.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 13:34:00 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 20 Nov 2024 15:33:24 -0600
Subject: [PATCH 01/11] iio: dac: ad5624r: fix struct name in doc comment
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-iio-regulator-cleanup-round-6-v1-1-d5a5360f7ec3@baylibre.com>
References: <20241120-iio-regulator-cleanup-round-6-v1-0-d5a5360f7ec3@baylibre.com>
In-Reply-To: <20241120-iio-regulator-cleanup-round-6-v1-0-d5a5360f7ec3@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Fix a copy/paste mistake in the struct ad5624r_state doc comment.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/dac/ad5624r.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5624r.h b/drivers/iio/dac/ad5624r.h
index 14a439b06eb6..8c2ab6ae855b 100644
--- a/drivers/iio/dac/ad5624r.h
+++ b/drivers/iio/dac/ad5624r.h
@@ -41,7 +41,7 @@ struct ad5624r_chip_info {
 };
 
 /**
- * struct ad5446_state - driver instance specific data
+ * struct ad5624r_state - driver instance specific data
  * @indio_dev:		the industrial I/O device
  * @us:			spi_device
  * @chip_info:		chip model specific constants, available modes etc

-- 
2.43.0


