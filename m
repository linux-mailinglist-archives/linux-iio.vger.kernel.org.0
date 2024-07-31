Return-Path: <linux-iio+bounces-8083-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC6A942772
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 09:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99849284042
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 07:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2F71A71FC;
	Wed, 31 Jul 2024 07:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jpb8Wchr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF781A4F32
	for <linux-iio@vger.kernel.org>; Wed, 31 Jul 2024 07:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722409556; cv=none; b=E5gkq7AAh8LhUvEJpPwpNkAnxX0MPzY1vx8N4470lajp6Z/jdLqVLeN4WasJCbjRprKlZkgI5v1Hh43lFAYBuu1417sjAy0oouFLWBKQAH9sq8rRwI4jggU3M43NF/Rqk4LD7yYjOVcrLNqa83WTqX4j0dUNnNcUNVPYhXo3SyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722409556; c=relaxed/simple;
	bh=QnD2BToR4Nwm3fzJOwnxm/3JHf/41UbLqSYaKrl5UA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HanvoAcQF9fEp6+YF/dJnaANO/kNdYwWPqU3kYADEN73xiwagdhxrdiv9nuoMOhEWw7iVBDOSv33Z24VQKtoB628Hvn/LBUGHGII8MIt1IK7DjFYlVH8jMEvnb7x29wokHv+PeSXeoSyiW8RLOEkvtZ4/IRRxB04f2BZWpuqjpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jpb8Wchr; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4281faefea9so22366595e9.2
        for <linux-iio@vger.kernel.org>; Wed, 31 Jul 2024 00:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722409552; x=1723014352; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ma/nRsNL/NmomeGPp3xpJ7bK2CtwegdhnZZFnIG8n9I=;
        b=jpb8Wchr15EQ9GEzyz3Ht6SvL6G8C6Qsfwf4yHaxU/LNpln4X6VGpvHpfp8dKoB5AG
         5A7HLnSDJR6kPrsXij7ITnMDj6mNvfZr0yLf3XHkrp3chogdAX37bgB9XPkWemPLyNfA
         t4UB9wTAnRgbZZQebpvScmoA2PJHh+GlPVkfOMe+MlNzNYKh6ELMj7Y/E7XADcz+I+41
         +iKhwTRbnijsAE+/W286gwP+dXE6Mdjl+yPEiojFRHyX/0eRC7xlu9buGNh07bNElipi
         Sh6W7zGokVInJbT6X6zu71jh8QAG8yyJSyHeK96oyHRp4VmoP5RLksghyZECUs5xLXm/
         klcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722409552; x=1723014352;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ma/nRsNL/NmomeGPp3xpJ7bK2CtwegdhnZZFnIG8n9I=;
        b=bH/I7iffBQgZvS1JCFX3SCDHgkc0hJx/xTxhBSTgzNw6nt/IhNwB/cMDJig0GdWzqS
         h4FlUyVmZxuixN0GkKkdCvZPvFxnNvFucLy0HDBeaIJhEWaitZLWIu0zAM6992rTIf5U
         FjoXT1wbwNEgHg8iF+2CdOBIP+VHWyVVoHPJEUlBdvrSGX17SaOVnIs3ZU6qNudJRF1y
         ATkt+V2L321tvd8j7bOrCwJZZ+hfUNVSMbGKt/oeftJx5UKxBPsQzoLFOMl4Er4B7R+1
         t1a7wqgzZJ8u5SgPcRCruB85f9aB1uGk1942/d/ieelShot91CWapmIsNbqcFQvZs/zK
         cYTg==
X-Forwarded-Encrypted: i=1; AJvYcCXjSNfAX0hZidFNurcDZKSff5bvMtZVFkYHselxpZId59EHqqXGpq5tUqB9VHTCBreOAa2CrNit8YE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIyS6hL1s1mCYNCwFmDeLpPpQqBscpI5mrCTFhDdJ8JkIG9TCq
	KkeiT+9yE0Jxkd7GzmMnrdq+4Qdo+T5WGB0BpnuG6Lm+YBjK+X1PD041yX9Vls8=
X-Google-Smtp-Source: AGHT+IFTtyFkmP5aNXcUZvN5CS82N1Zzoo59tEP+gFc3i3IpNJlN+gyZnV2sH7d17TEGTLQWL6ZGJA==
X-Received: by 2002:a05:600c:35d5:b0:426:61af:e1d6 with SMTP id 5b1f17b1804b1-42811e131aamr86638515e9.29.1722409551968;
        Wed, 31 Jul 2024 00:05:51 -0700 (PDT)
Received: from [192.168.1.61] (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net. [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b8a2593sm9953215e9.4.2024.07.31.00.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 00:05:51 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 31 Jul 2024 09:05:44 +0200
Subject: [PATCH v2 3/7] iio: adc: ad7380: add missing trailing commas
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-ad7380-add-single-ended-chips-v2-3-cd63bf05744c@baylibre.com>
References: <20240731-ad7380-add-single-ended-chips-v2-0-cd63bf05744c@baylibre.com>
In-Reply-To: <20240731-ad7380-add-single-ended-chips-v2-0-cd63bf05744c@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.13.0

Add missing trailing commas in iio_scan_type structures

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/iio/adc/ad7380.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index 7568cd0a2b32..72fece383f72 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -97,13 +97,13 @@ static const struct iio_scan_type ad7380_scan_type_14[] = {
 		.sign = 's',
 		.realbits = 14,
 		.storagebits = 16,
-		.endianness = IIO_CPU
+		.endianness = IIO_CPU,
 	},
 	[AD7380_SCAN_TYPE_RESOLUTION_BOOST] = {
 		.sign = 's',
 		.realbits = 16,
 		.storagebits = 16,
-		.endianness = IIO_CPU
+		.endianness = IIO_CPU,
 	},
 };
 
@@ -113,13 +113,13 @@ static const struct iio_scan_type ad7380_scan_type_16[] = {
 		.sign = 's',
 		.realbits = 16,
 		.storagebits = 16,
-		.endianness = IIO_CPU
+		.endianness = IIO_CPU,
 	},
 	[AD7380_SCAN_TYPE_RESOLUTION_BOOST] = {
 		.sign = 's',
 		.realbits = 18,
 		.storagebits = 32,
-		.endianness = IIO_CPU
+		.endianness = IIO_CPU,
 	},
 };
 

-- 
2.45.1


