Return-Path: <linux-iio+bounces-20187-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD63ACC947
	for <lists+linux-iio@lfdr.de>; Tue,  3 Jun 2025 16:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED3A8188E8BD
	for <lists+linux-iio@lfdr.de>; Tue,  3 Jun 2025 14:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67AA23BCFF;
	Tue,  3 Jun 2025 14:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ysbRskEN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B94623A562
	for <linux-iio@vger.kernel.org>; Tue,  3 Jun 2025 14:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748961479; cv=none; b=j9+JyZNc67qLseTGLequnXGLHnMPBVHMSUyqEuecWuOV5labjC/PpaVAWB/nuoyHDJCw3N69osEBh5MmKNt1PhCK1qDCFaMmJQn3e6lisRsHZcHkkJzbZxyzSeRfwSJS7O7L1liyWYFE4zU0YD4l+kc/eUY/TIv6NNcWuepms7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748961479; c=relaxed/simple;
	bh=cBfFaDkjp8cn9ZsqfhZtThmlU0g1ewE4x6fWUwfuIqQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PL3WhuX4pMvhgitaUun07oSsUAdIMC0B/PFXPrO/iEAO4q/gZ/TJbSC/aeizbCPZ+W2LDJ3A/Z0R+KEQLReyPkKBhoB5LpAwLoC2cqmvQFUtxGt7ysWJ0jld6PQSHFqx/8L3zbWJkGf9CpIVNZivhgnjiRf7Pjwaf+CbL2yARWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ysbRskEN; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-450cb2ddd46so36816035e9.2
        for <linux-iio@vger.kernel.org>; Tue, 03 Jun 2025 07:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748961476; x=1749566276; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wv6YLDN8CkaWn53LtM3+C3UNFVc2t/n3NaXm0d2EaQs=;
        b=ysbRskEN0A3PLHKDFHGbg9/fMXzvuRjhl9QCN3EUImjtEfAFJr1sRFGQ/20u+lueKl
         JN9ngEOn3QEB+n99c53jVRw+4YX4KJcVs6Ugh3btewQEeRROxcGovVPgGFS5c/6tQ+Ir
         uQqhJYl7pZyoH6/Vureu/DssC+j9KIDKUHXwJqlzwwxTN7Ezqo+AMl4BgDKvKRzijbyV
         iCGgVwBMvK45zV3oVD7vLjXG69v0E/5Qa4bBjpY1I+NT2/apjdhgBQLuUyxnwx0uztkL
         wu+JKREiEPZwKFU3lzli1jMCbSVy0MwaYWlqTfqOXymJn3J5cQU2hDGWYR8W8lZ8PTUU
         9cug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748961476; x=1749566276;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wv6YLDN8CkaWn53LtM3+C3UNFVc2t/n3NaXm0d2EaQs=;
        b=Grtga85tiZEefJN8PQZ0DRIodoKqrFARWhv9eEycBH3rxbYZsRiDc1vh07y8zZIjOR
         WIRfGK/jSbyKkXtoGg82ew5iV6bAnMGGAJ5lbZnWHzHcGU+5rAbmSAidK+lRrr7iNEFl
         WWlu7FDTSFLlQh+Eo83x/Y7sNFT1Jnf7bNrcXx16N9WlcsARLk8hzqW7HzNOCFD0xwA8
         qNb5k4n2EihBVaOi8HFt8NLyMeCtD+ikk543pJQ7AN41IXqsjPx4D8rGDOgqoA4CMS4t
         nS34mSlyZRCn+G/3tfFxwL0IJys4IyRn1HX8BUH208eFUbR+92Io8NM6g9iKi2hfsYav
         iM0A==
X-Gm-Message-State: AOJu0Yw3C/FEssDa5jat6ADMmAkEpOaPhgf0kSdFKysOVkvhoLmBp1IL
	pcI1WQ6PXrZkOT77Ya4dgh/4TEwL/aMhcXj1FoyFerfPleK7Lh4LUHBT5nUzr1qcqKg=
X-Gm-Gg: ASbGnct1nv6Nqr8MPDCjgtp57PZ6hn1xjkGHqFZ9n/UvMi0SI8g4kI7m4kmhKnqtCdO
	ZzD/eW/tjc+co7SfdnjIpvq3g/Okyo1KuLmFmMoKhLDoUIAtdnjmhUngsr4/TJyl5VKEy3kJItl
	PtpdF92n8k135VE1yolnHJp+jFtmLkVdAsgHJ48SXHY03gMQ2YiUHUYJOXkLagAuI7uJ6BiYOXr
	NwRQikQIeATIWnPb53ilzr15Cj4/6UIhCcYRGQiIhX2Zoxe7znNCYN518IjdDJWlrkIegxLOJHe
	Pw/g+yraWs2M6kJwOgp8rA+fRGT+Mg2wWhRI60WgiUQx7sAh8Ab3Uy4h9bhzG4fJrNzX6E8Wpji
	X/H1teDCdGF5UBO/tIjI6BaMwMSgZBEGe6Lw=
X-Google-Smtp-Source: AGHT+IGi92HX1UJvJNv4jB4VsIqlJhcaBZEOiBDzHJTO+g5R+fS7gSPid4Q+SBUhQBpnpASye2ehmw==
X-Received: by 2002:a05:600c:4f53:b0:451:edc8:7806 with SMTP id 5b1f17b1804b1-451edc879e2mr2630175e9.32.1748961475600;
        Tue, 03 Jun 2025 07:37:55 -0700 (PDT)
Received: from [192.168.0.2] (host-80-116-51-117.pool80116.interbusiness.it. [80.116.51.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7f1afebsm164430945e9.0.2025.06.03.07.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 07:37:55 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Tue, 03 Jun 2025 16:36:24 +0200
Subject: [PATCH v8 2/6] iio: core: add ADC delay calibration definition
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250603-wip-bl-ad7606-calibration-v8-2-2371e7108f32@baylibre.com>
References: <20250603-wip-bl-ad7606-calibration-v8-0-2371e7108f32@baylibre.com>
In-Reply-To: <20250603-wip-bl-ad7606-calibration-v8-0-2371e7108f32@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 devicetree@vger.kernel.org, Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1303;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=1bBjL7VlkgNBkqwPeVPqoUWRyRoNRlMdTRY5+MPjmRY=;
 b=kA0DAAoWD8251fe2tzsByyZiAGg/CHijdsTzMjwT3UGd2xYkTjaRg19yhgnb2aeqUjuFnGlAz
 Yh1BAAWCgAdFiEEfmFYNFXbVRojoAGbD8251fe2tzsFAmg/CHgACgkQD8251fe2tzsLDQEAwcDp
 dw/ODgoZISYIDlUeA3UR3m5FJKXZBPXv3T2cjTgA/0Aah4WIIse+TYCpnRXKtC3T4k5/MjryXo5
 zSSfPaDMN
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

From: Angelo Dureghello <adureghello@baylibre.com>

ADCs as ad7606 implement a phase calibration as a delay. Add such
definition, needed for ad7606.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/industrialio-core.c | 1 +
 include/linux/iio/types.h       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 178e99b111debc59a247fcc3a6037e429db3bebf..f13c3aa470d774bfe655d6a9fb00c263789db637 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -188,6 +188,7 @@ static const char * const iio_chan_info_postfix[] = {
 	[IIO_CHAN_INFO_CALIBAMBIENT] = "calibambient",
 	[IIO_CHAN_INFO_ZEROPOINT] = "zeropoint",
 	[IIO_CHAN_INFO_TROUGH] = "trough_raw",
+	[IIO_CHAN_INFO_CONVDELAY] = "convdelay",
 };
 /**
  * iio_device_id() - query the unique ID for the device
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index d89982c98368cf72c0fc30fa66ab001e48af4e8b..ad2761efcc8315e1f9907d2a7159447fb463333e 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -69,6 +69,7 @@ enum iio_chan_info_enum {
 	IIO_CHAN_INFO_CALIBAMBIENT,
 	IIO_CHAN_INFO_ZEROPOINT,
 	IIO_CHAN_INFO_TROUGH,
+	IIO_CHAN_INFO_CONVDELAY,
 };
 
 #endif /* _IIO_TYPES_H_ */

-- 
2.49.0


