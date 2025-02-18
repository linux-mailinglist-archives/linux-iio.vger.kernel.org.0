Return-Path: <linux-iio+bounces-15754-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13410A3AC72
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 00:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13E5118903A7
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 23:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B651DE2B2;
	Tue, 18 Feb 2025 23:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JFQ/ASxS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7454C1DD0EF
	for <linux-iio@vger.kernel.org>; Tue, 18 Feb 2025 23:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739920677; cv=none; b=D2gqYxtioD8CCn27x5woBzyP8+OkjVLOj8SZz0rCrYRjncANsKlx4ph2/mpozL0ZCEat/wGIHTApS1cj7A2bsCrEKajV62xnAuvMBBeTDJHxvYOUvQTIW/Od0ZonuDsQUu1GFPgtgNpw0bHxKlx/O4gPo7TGX+YbBAzLpsV6Xzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739920677; c=relaxed/simple;
	bh=Fc/KruNh8T4raL3lKWRskCYx+88ToxfZwIciprkAUJ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A73dmT9nYKh2o1cOksmYsO8S6jtooCwLGt55s1tvUFjBeteoaKez5yT4i26PZpjAoM+rUtnJdDV8idyUU+ppN4wemt8dy2eLZqyZ5XYIUhtrMwPuuy1yffJG/uLk0+DoUfKX9N7Reolg2nyefmvtJJNxImkV9wwWDlVAmYerUXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JFQ/ASxS; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-72721c2ec6aso1505858a34.2
        for <linux-iio@vger.kernel.org>; Tue, 18 Feb 2025 15:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739920674; x=1740525474; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MdXXbz+KViDcJGlSldaRjqAtEQyfETaLwe7gw52hDjk=;
        b=JFQ/ASxSJSaOxKw9oLjiE9J34OqDlWUILHBtCVof9kDq8sAfdtvuj03phg+YLKzlI3
         JRqQtoLQ0KxrI45wYFHHgN2b8esex6kDuD4qmeYqUhGGuS/TvTP//w5IqJGDtxHR+YZA
         FGii0c0mCP3wdPbPf4o26E3a3MRhi2tJW3vkaQah0E/1mISOH0z2OQWR0UFfK+EnkEEV
         mxr/1Ja9F2A2HdDBOULoU0YMb9G9kN9rucVzTqU7zHW7gaAM4BLu4NgsGSVbEqDXujWg
         4W9cANZyDAZXoI8WDt/nY/OMoQ8eM7+73CQbtoPPnybvH5t/awToH9OZZOXVu2QWqiMU
         vQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739920674; x=1740525474;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MdXXbz+KViDcJGlSldaRjqAtEQyfETaLwe7gw52hDjk=;
        b=Gkj6Q2rx57RqT0Gh0ZR0BPaVqt4GrjYuYKiAKO7jjdYC48WhS4FGOi6q5zM5DUBNnX
         4SYbKU6iKUL+KQmNH6QPOU7KUeKI4pWHUZXXUq1CBm3QlXjucnS/EAU0vaEGhOj74rwz
         blh6XRj9H+rk3UmsMOxIMjsiXpDTkwrG9AC1b8NgqqxvM21ie9igH+7nDkdyKF4wtjl1
         g1/1/4tuvM/I1b6iUgeHC7frfNA0UgR/hiJlKnwB1r46TTGoMORaZNmOWqIPkpep8aQ2
         TkCDKvNDtS42u0ymk6UX6hP30pW8IJXJCURycmZb7q+F3U6dpT8Rq9D2kbrFoHaMrwmJ
         08dg==
X-Forwarded-Encrypted: i=1; AJvYcCUW6qbX9YgaFBeqvusozoyHCDk3W6UorP+eGx5+dtz4xuH44LbwgRkz7tW6C/fbp+jB2QNDIBi7IQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRg0VVAybPRLaB9ub5n7Mktuk+ctUwutpzJM9n12B6+mmxwqfG
	KgZkSj7vj5A7yrJqDCiJRGT1DQ/5FGcvWr77RisrMUwzU7uQYficf+ZaWNbODMZOFD6BKCmO/rE
	G
X-Gm-Gg: ASbGncueokmPtN0sX+V/O5xHwE2zqnUhTvxkDnvrEDgYkQrHcEnoO+KB12zN1tOt/ZL
	jSaEtZbUqJiwhmLMfn7q2/t/MG7QB1Pi+Yp2yaQ2N/8dhdgJL4UceN1igh26/1blhFSqyHFggXx
	O4eu0uJ5z7PstPTatFkairyPHtP5PLiN8WMG7fZMxsd6oAEiXYYEuV8GkLNQ2Eskg72CUnSuHcE
	5cDSvcXGb1eOaIpSNpr9tUpJbTtZ2yvXZXdz3bIGkjvxfcC07RSMOJYICv6EQy6fdXNqBIZlcSN
	CAHDLrqhs+C+JYYKy442oBXS0l2jxqi9JIZ+AAlNYcUnLXo=
X-Google-Smtp-Source: AGHT+IF7oRKpCGN6j69ZLc8G2JNQTQddNop9Dt1GJFV3FyCUOggPoz7eaolskYMdgMWyLlpjj5sgwg==
X-Received: by 2002:a05:6830:6684:b0:727:3303:7ea8 with SMTP id 46e09a7af769-72733038088mr2860011a34.25.1739920674577;
        Tue, 18 Feb 2025 15:17:54 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7271f7c5ba8sm1803129a34.32.2025.02.18.15.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 15:17:53 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 18 Feb 2025 17:17:46 -0600
Subject: [PATCH 2/2] iio: adc: ad4695: simplify getting oversampling_ratio
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-iio-adc-ad4695-fix-out-of-bounds-array-access-v1-2-57fef8c7a3fd@baylibre.com>
References: <20250218-iio-adc-ad4695-fix-out-of-bounds-array-access-v1-0-57fef8c7a3fd@baylibre.com>
In-Reply-To: <20250218-iio-adc-ad4695-fix-out-of-bounds-array-access-v1-0-57fef8c7a3fd@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 Trevor Gamblin <tgamblin@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

We already have a local variable that holds a pointer to
st->channels_cfg[chan->scan_index]. Use that to simplify the code.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad4695.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
index 8721cbd2af34c53f0cea32e307b9ef2da46b0cfb..b38d2b3ccbfca10dfe5b05c3a96ba00f8838b89c 100644
--- a/drivers/iio/adc/ad4695.c
+++ b/drivers/iio/adc/ad4695.c
@@ -1164,7 +1164,7 @@ static int ad4695_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		switch (chan->type) {
 		case IIO_VOLTAGE:
-			*val = st->channels_cfg[chan->scan_index].oversampling_ratio;
+			*val = cfg->oversampling_ratio;
 			return IIO_VAL_INT;
 		default:
 			return -EINVAL;

-- 
2.43.0


