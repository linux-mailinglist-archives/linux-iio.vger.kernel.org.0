Return-Path: <linux-iio+bounces-19214-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC1FAACF34
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 23:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E66774C17E9
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 21:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9501D218AC1;
	Tue,  6 May 2025 21:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BOysUuBm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4240215F6C
	for <linux-iio@vger.kernel.org>; Tue,  6 May 2025 21:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746565527; cv=none; b=sGhnV+EWUJnwL4p8rk+0GctOP/fNFHBo89HN6dVL6v/Xj0FbB8ESyjr6bKNwgEZ4YB4COZ6Jgc8mhgAQyH4Xlad9AOnb3Ek88LM2lB6j1on7GSERdfmwgCTSzqgD3UDO1GYo01BN+hv3cIkvHiu6Ks6+N8CNg1XQVUGv8BKTNCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746565527; c=relaxed/simple;
	bh=8DecWNX9a+g7ci97Vv7IU6U85+eTrGoiJDNqhMLAwD0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OJktCbUipfatUIhvIXoJ/ggVtfFvu0p45NI6KkmIPGWmES0CxCf60ZOqm83OjPD7N/XgMUsWwzHtgYq/TsOtGsgYGRT7s+AHrhv3qePAjzy6RtMtfrx7ZLZhwFZNbFiuUK586lZWBT/pfM9PiCmDVJpG4NUO+vTcUTv+VDQNor0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BOysUuBm; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so52424095e9.3
        for <linux-iio@vger.kernel.org>; Tue, 06 May 2025 14:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746565523; x=1747170323; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gQIoahuutc2qqjFxwM4CJBJC7cg2fQ/5cUj9Q0XSXuA=;
        b=BOysUuBmSoAEMOyH+RVIb0Pvh11HJ3xEGkP88oGtGf5uAixPvY86fTJwZ9xn6RC04t
         cWlTLWozS0d5l7ykVZQfjblN/GRR4NDqktJ1Bks3V9oM6AT0cvJ7iAr0pH/P131LOY/c
         4YCy530NQPyL/W0qEBMoOannqil6mfPbLbex7W2cKcrp6svIHQaPKM/6RBTKkOPI7n+O
         70CB/DIlM8pVPAqy93tsXfslt9EXAhOMBCmGHBtsvtylybpPOGK/Nh8qPuemBiBiBlFr
         PQiy7I6Vnk4dZlAbin7tY875sGnKLjkyv2VDXidxbJgMcYABkrFhLEnHmEKFw+LG+eNl
         ybbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746565523; x=1747170323;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gQIoahuutc2qqjFxwM4CJBJC7cg2fQ/5cUj9Q0XSXuA=;
        b=cGlEMaYxz8x8wpnzlKqOP3c5Ky6He2tKn5q2ROkG8pyv7ky4xyVFeUra+u5gNzlW/g
         SdwVxSYBtsl1hYCKVkUp/MVI4uFs+vOpfhStIS/eA1N+ycuZ2T23tG4KIdSl43zsQPIV
         qGhluSOxgua0g91PVQzlzhPt4jMV+LzXAN70tYEKsWL1KS2GHlTJKHXeyCDpAltu+H7f
         sDa8ke03uEg51PsDmht17l1h3J70T9kGDLsMlumsh7KYs87CV/bzKxH0xsKcKH04XUx6
         uZI3pjRdhMLG05bYdaNYL3N/Y/xlg3dHFKIrOloDFP7mPm0qbGHZca3RUDA+uQHDwd09
         iz6Q==
X-Gm-Message-State: AOJu0YyiWyUhO3pnrO77XPyzXc0Z2Lnicv4/X35pcBiqA5vDoLfVPnNP
	F8OfOOIZT5Bh/8a0BlexAKy7slUAyR9ksvswH+tZEIQDkZ+VD75ku0caR7tThKo=
X-Gm-Gg: ASbGncuvQw5D9hNOjM0M4uNxFynIzUDQQmZchvgZGVvMSo0TtdL3PG9G7ldPabe2Ybi
	m/6Rk1SS3C4hEhiyk2jQZgf2mvaCTG3w6jYTf+Zj5Z5bRCGauOYMoKwQMDymL8BIs6x82JX3faC
	KIxljLohWv+wcLiwZFrF4MhFUwXy5RLcnj2qf8EcqkBzCdmW4vBTmHPg707sbnCWlFBZ7iPa1uZ
	lpO7z9i42uoq7fPhaIu0Hnq8bq0fS7xXP2EQlIhveZDxda8Pysp7y+zL8NKbOGWNKuINP0985vF
	ThQtK6DW7OpeO0twMW9RoSgPwM1vgvPpxJk74vPQC0xhTU/O9cf++LK4tQiztQ1ltVt8BRo4QDD
	xV8YLviSkXsbkmrGFt9sUrqc=
X-Google-Smtp-Source: AGHT+IE0lNn0nT2i13dUfcqq/tEEHU4n3DZAgcrz6Oy4DZvTBDhpwmaW+VV7h81wiw+2Az3EYbCpFg==
X-Received: by 2002:a05:600c:37c6:b0:43d:1b74:e89a with SMTP id 5b1f17b1804b1-441d44c3933mr3684925e9.9.1746565523006;
        Tue, 06 May 2025 14:05:23 -0700 (PDT)
Received: from [192.168.0.2] (host-87-8-31-78.retail.telecomitalia.it. [87.8.31.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441d4351abdsm6794475e9.23.2025.05.06.14.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 14:05:22 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Tue, 06 May 2025 23:03:48 +0200
Subject: [PATCH v3 2/5] iio: core: add ADC delay calibration definition
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250506-wip-bl-ad7606-calibration-v3-2-6eb7b6e72307@baylibre.com>
References: <20250506-wip-bl-ad7606-calibration-v3-0-6eb7b6e72307@baylibre.com>
In-Reply-To: <20250506-wip-bl-ad7606-calibration-v3-0-6eb7b6e72307@baylibre.com>
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
 bh=4Hb5fAw6wk9UOyjGvMGWLBgqM5yKlaYwdF7azoNoMts=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYsiQqnQ3KT7w9NWpH9PZpfu5Yz+6RB9VY8lekhEqm5rIV
 2dnkfqso5SFQYyLQVZMkaUuMcIk9HaolPICxtkwc1iZQIYwcHEKwEQ4rjP8032+bJ5MgIzJlhtz
 Zp1nV65mXhgq9kPi2YrPPWfvpPHaFDP8leabnfws1/gip23dg6dTBSVm11Uts/PXP+EiukNj08I
 YZgA=
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

From: Angelo Dureghello <adureghello@baylibre.com>

ADCs as ad7606 implement a phase calibration as a delay.
Add such definition, needed for ad7606.

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


