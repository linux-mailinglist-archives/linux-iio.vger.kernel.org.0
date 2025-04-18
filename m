Return-Path: <linux-iio+bounces-18273-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B69F0A93AA4
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 18:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC43E176581
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 16:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A14226170;
	Fri, 18 Apr 2025 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NXEGQMmz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5389321B9E7
	for <linux-iio@vger.kernel.org>; Fri, 18 Apr 2025 16:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744993066; cv=none; b=Y4TyoN9zbaRtgcvPr93KZBfwsanKC5MO2ViAn5IA0rOmTL9FoTuAU3g7U840jlo4fvIdjE0UA7wPEgosJxORitjtvyf48y6p9yVcSY5ftBE8XdH5YyXKiR3+YiTQXe8ivAxTIDyotP11O/6sr2uxwxg23h9pYfajQdCPX3EVYiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744993066; c=relaxed/simple;
	bh=Ji2Bufzsf6DgjWf4BBNQD3G1VXMnmCGj6mWGvQqpC6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XsPppRailMhU4TKXv5RR0bMeFfjn3SJKuRKNmHqQW4Yvq73K8TKW5kVI9eaAu7B8x91MJ41xtY3yrXro4N1PFmPRzmaWyAQvZIN1TnsckhA3vOsBuqwpXdIK0RJJn3jRkmCEqkmHxksoGm3Jhxr3ljRVShSP2x2M6xfUAO8i6o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NXEGQMmz; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3ff0df81fdbso823364b6e.3
        for <linux-iio@vger.kernel.org>; Fri, 18 Apr 2025 09:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744993062; x=1745597862; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hab2lxvE/fC3IFWY2w9omfjURJU1Di1Tb8agi9lm2zI=;
        b=NXEGQMmz2CPMXMbgPK/CTPkr3iW1Q4qwgnYuFDdUYUflcuvc7xbX7GezDIUaffmsdS
         P5YsFCMR1mqDaQv0D0c6BfNNcEf4y1wT7pU1sh7bFAj43J/1q5WgHYJjJJYktlbSyGiC
         A4aNHWhhgbd51/LBp8c0JBDplJqk+1zvTtU8FrMvuG8QhWL9e4TGONLDXMxEw1GIZ6rO
         /BwMdhsEjDHmsJ/gw2BXZ6FDD2NdYXpsljTP8dbR6478TRhQNdZ58Ufzq3kGizs1plXB
         J6rpRY5SqJxjAcD1CliL6cLJDhnifXSnwyF6O8qK/TsWyP/mpxqakAgVOidsX71qNFIk
         DPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744993062; x=1745597862;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hab2lxvE/fC3IFWY2w9omfjURJU1Di1Tb8agi9lm2zI=;
        b=ZGPvKLTnreG+kN11eIaENLamqGji6fiWEXgq5kkmXIfO9uVUoJgR8uZV2w24xGxylu
         bDGWW5IKAsPcmPYpZvRnNSpjb0PC7ZQL13bjGj1EJ1olNebyG2ZK8dEhlx9e6nX84ZeD
         fz/+hrX0ptRMyj6/9jxpkwLyJgGibna++1n+4lJKrRyUi7BV2nEJclOEDDg98rBY8fJl
         dToKUiurroBVZcejkUtTWsMmGqaC5uRlDwAVvpY8z9P1tgxnLuBMLt+bYSONNuZ1zXnR
         mA3bv9qRhB6UrIu+Jw6DSIqbBcoQdQCBsZDhEKKshpj2LfRRnzX8gRYVN1G39vX2HdxA
         3aqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtDqoh0v3KMOK1pOEf7JUNkhBy8h5AILlKKdRg8RqOvlmeDz9cNWZVw+fsKQwglZA4KXdI2H7uq+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YygrahOp50wv/c7JWBru/kWCP3B088e2JtvQZjgaoKDZ4J7iKEg
	C1XGl9YhHfiefyknyS9SbRgpllXj16awIXswHlOsH+anX8zmc4GejlDLNSfGmgw=
X-Gm-Gg: ASbGncvVBT9MOToMdh6vaahfihSN6I5YK2/19bv4gXQaZaJLE5M7WFqRpGJbvUMdxCI
	HbR0BTyyIOK1ZKVPRfFdpJszodZslplMuJsYbshfaspmtrcP3dqfaEo24/RW8TsC1f0+fteH3ja
	jr6FeEp+QxB5axYLXQ0abA0LAODiMBHe1auGimTbs1uxu3YGLiZ9Rt9yifBtsmZy7CYznbew6AQ
	0btgHXj+X9TpuH3DnBAGQyr+hkVbWOZl3cq+v73S4YBAePLTa60JmUOBbB7oSnw27LJnwl2YmHg
	8BgWeQEIfJlNU/85E9/ib8OLjjrhtRJ4bVhFEqrM7S61MYA=
X-Google-Smtp-Source: AGHT+IG/MpUgMyPK4jKl1uNgegRoH+YvszC0/QY69eyP1nF1ELt8AiR2HwXu0ntYkRWrAaw6L7fBrQ==
X-Received: by 2002:a05:6808:4e15:b0:400:be08:f6e5 with SMTP id 5614622812f47-401c092e403mr1579080b6e.7.1744993062308;
        Fri, 18 Apr 2025 09:17:42 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:dcdf:46e0:18e5:c279])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-401beeffe05sm384929b6e.30.2025.04.18.09.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 09:17:41 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 18 Apr 2025 11:17:13 -0500
Subject: [PATCH v2 1/2] iio: imu: adis16550: align buffers for timestamp
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250418-iio-more-timestamp-alignment-v2-1-d6a5d2b1c9fe@baylibre.com>
References: <20250418-iio-more-timestamp-alignment-v2-0-d6a5d2b1c9fe@baylibre.com>
In-Reply-To: <20250418-iio-more-timestamp-alignment-v2-0-d6a5d2b1c9fe@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Ramona Gradinariu <ramona.gradinariu@analog.com>, 
 Robert Budai <robert.budai@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andreas Klinger <ak@it-klinger.de>, 
 Petre Rodan <petre.rodan@subdimension.ro>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=980; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=Ji2Bufzsf6DgjWf4BBNQD3G1VXMnmCGj6mWGvQqpC6c=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoAnsUn+ARff5RlLSjf5RfdY2gi8ublq+tbyrEL
 5nV5JOlTEWJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaAJ7FAAKCRDCzCAB/wGP
 wH92B/42FlsLkWxKApYyrIMJuVdxLFtZ78J6pzL4P+rXHmqEOSiL9eAYiplsxPTvqSvJNT1/BFu
 YZEuSLECihsYpNtqmKCabfw6N2Cp0iXcrngukUWLjkNClBfpAzaUgareHgyOxBM5WUBShJ/l1y3
 rd8xYed07q1bKQfjfIi2AUSs7mu4NOk29cIlxkIMmWw3r4zScL1M8kT42JMbCITU2bAUkWSZUgM
 Z2+WPCof6mLnRhWhZ1N0bvYFT6jzEleKG+xf+QotSM62569wAZUNryQZBqcrryfajIL1nmQ13Kc
 f8w/wiRlFiW4ywldzntwreV69I90wDr2rJ7SO0tJV6++PEwz
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Align the buffers used with iio_push_to_buffers_with_timestamp() to
ensure the s64 timestamp is aligned to 8 bytes.

Fixes: bac4368fab62 ("iio: imu: adis16550: add adis16550 support")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/imu/adis16550.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/adis16550.c b/drivers/iio/imu/adis16550.c
index b14ea8937c7f5a2123e4097dc5b8260492044d1b..28f0dbd0226cbea67bc6c87d892f7812f21e9304 100644
--- a/drivers/iio/imu/adis16550.c
+++ b/drivers/iio/imu/adis16550.c
@@ -836,7 +836,7 @@ static irqreturn_t adis16550_trigger_handler(int irq, void *p)
 	u16 dummy;
 	bool valid;
 	struct iio_poll_func *pf = p;
-	__be32 data[ADIS16550_MAX_SCAN_DATA];
+	__be32 data[ADIS16550_MAX_SCAN_DATA] __aligned(8);
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16550 *st = iio_priv(indio_dev);
 	struct adis *adis = iio_device_get_drvdata(indio_dev);

-- 
2.43.0


