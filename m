Return-Path: <linux-iio+bounces-16094-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B36A463AE
	for <lists+linux-iio@lfdr.de>; Wed, 26 Feb 2025 15:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17C8F189FB99
	for <lists+linux-iio@lfdr.de>; Wed, 26 Feb 2025 14:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3D1218AB4;
	Wed, 26 Feb 2025 14:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jtp8KYmC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941C2221736
	for <linux-iio@vger.kernel.org>; Wed, 26 Feb 2025 14:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740581426; cv=none; b=hXFvD7Hc3QWM0p/qCC4PmghmIIU650v9knZbR6fWBJWvXT7iqLphRb1CRn5aC+tHVc9+h2oH2jqKIAGzj9t4VbDcloVvCbDc3gmMHjO4FrJDKNGpbYYEKIfWhES/zK7+D1SdQoKF8k/HFUYzrtMItuQ1RavGkZN9AoDHqa8MXLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740581426; c=relaxed/simple;
	bh=EQukQFpoy1bCTquTWJ0f97VwpieDtmlOfkC2xmR08G0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GREvNOh+ebZ8mMHksS4JAz1PmmVJ5gdXx1sTGHA3kxW68NF2nYVCVzw+LDoueu9D2ZZjXeUQ5RtBhwj7V3cilrQ9FlWdPGs+wAfyu4g62OuRqbblEufBRleEOdq/DmmnF848NOkI2VrrnqvgUJeUx+GiWD3D2uPSxOCbHF+eGU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jtp8KYmC; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38f488f3161so3847189f8f.3
        for <linux-iio@vger.kernel.org>; Wed, 26 Feb 2025 06:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740581422; x=1741186222; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V0cS3BjCebiH0oU2houUoLjoPQfGa9B9aygJMIYRWyk=;
        b=jtp8KYmCWn3mlTrZGmz3vgEnsu4A5ytnbT6sGZ+i0gGbtbH9P5b/eNBe07als1yGcb
         CGTEl/PqKl4qEN6ogsM2oUdrZSkQItlaCe5U2XcFLTgxelNzTxLP9h6JJ+brKoLK1YX7
         CFbS4xoeXaedKKNcovarRIfmaRhPmYcMk0pLI2VqUZFgYn9pYSeybkPgg5Xp7LBgCZod
         3rEAImEMtmj4KA4NaNzgrR0cPiDwRvwZh+6Dzep8WHn9yvQeVPdCj8w5TH27QZ2yQ8Vc
         XwWlDsLLXXBZUW8/XKCZDAhMnNqunlSIQ+HU9Up6MGJB7FODq9q2spQDjpEBDx8mRHu8
         rUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740581422; x=1741186222;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V0cS3BjCebiH0oU2houUoLjoPQfGa9B9aygJMIYRWyk=;
        b=iLaLoNX+1nETbbbRJuHb1w9qyxkzG0WIaoYjaI1sdID4c2ayeUeLRqxlBbm6avYxjU
         kFIQX7U2xSEiyWT5042LaJFlmSHAIgsV4YrqdAno24B2fDv+E7Ctiu+l65uIA3y1T+k1
         TQ1GYNiYpPTpQYUkOhcCSrAp0Ai6fn9oxpry/v204sQihz/UUg3d3IYe84EbEskF8prL
         gCjJx6bUDSqnGD1UBwuUmS6bb+iPOG0n/NjGsS76pxcSeHYBzA8a2u+M8P5HrDUFaQQT
         csq03muRTpDDoHEUestoFTwH6D/hKP/gboXjNFBsHScXY75hquG/cy8/b9p2Sn+/JLpl
         4DWg==
X-Gm-Message-State: AOJu0YyMpjEwMDSKaUIp0FNupp7M570zqkAmc8TOICHdHgRmGpsyBRi+
	xRHSskVIbhqugxjfI1EdJy2eIXiAqiZmngxlFjFbuR+1Z2axnuxK8qtfYhYbTxI=
X-Gm-Gg: ASbGnctTQEnPG9GJZvuVs+MsOJyOWwUuSsEpHd+noTa6FW1M/QbRFHfGMg1GZARzIXx
	S2TaMT8e1hRGzlgwOegHn6FIGAaDiqVN87BPvsbf+zzXRU9FKQQ5BJXmewlFMWBko7CZyMm+/z4
	Cg9VbHe1QBdjsQFcC5XeM6PeDzWP82pP7bktrbo9hmLyKDD5Nht5t6EksVhhl1CIADFeLwnrcrE
	MIhCA+FpztReqTwGNeygN/gkvAEc1GXI1A+QpCH+belBVpe0m9cDWuv45vED4siX1RKoI+7lkvS
	uPhYefH7Ra4JTzolbatvaaJAPy74b5dwNPXpWyAx38k2Nd4ueaxfyZ9mKinAtI/jq/XcJNJ6TaD
	Em1jw4PXeHib+4v1rHSqWx2Y=
X-Google-Smtp-Source: AGHT+IEJjM76VpVo0v7/LMiu5gepvuHca6Q+JK6FVucSfxbZMKesqh+xseFSt6OsHtbewKkv0+M5Vg==
X-Received: by 2002:a5d:4bc7:0:b0:38f:338e:3cf0 with SMTP id ffacd0b85a97d-38f707aa445mr11160894f8f.32.1740581421934;
        Wed, 26 Feb 2025 06:50:21 -0800 (PST)
Received: from jstephan-bl.local (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net. [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba549d6asm23747965e9.36.2025.02.26.06.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 06:50:21 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH 0/3] ad7380: add adaq4381-4 support
Date: Wed, 26 Feb 2025 15:50:02 +0100
Message-Id: <20250226-ad7380-add-adaq4381-4-support-v1-0-f350ab872d37@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABoqv2cC/x2MQQqDMBAAvyJ77kKyWhP6leIhJqvuRdOkFUH8u
 0sPwzCXOaFyEa7wak4ovEuVbdWwjwbiEtaZUZI2kKGnIeoxJNd6o0pK+HStt9hh/eW8lS96S26
 KLoxj7EEfufAkx///Hq7rBlprY3dvAAAA
X-Change-ID: 20250226-ad7380-add-adaq4381-4-support-8127fc7abbc6
To: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.2

ADAQ4381-4 is the 14 bits version of the ADAQ4380-4. It is compatible
with the ad7380 driver, so add its support and documentation, in driver,
doc, and bindings.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Julien Stephan (3):
      iio: adc: ad7380: add adaq4381-4 support
      dt-bindings: iio: adc: ad7380: add adaq4381-4 compatible parts
      docs: iio: ad7380: add adaq4381-4

 .../devicetree/bindings/iio/adc/adi,ad7380.yaml         |  4 ++++
 Documentation/iio/ad7380.rst                            |  5 +++--
 drivers/iio/adc/ad7380.c                                | 17 +++++++++++++++++
 3 files changed, 24 insertions(+), 2 deletions(-)
---
base-commit: faeaa1ec6c63b6676679f321601471772f2a0c9b
change-id: 20250226-ad7380-add-adaq4381-4-support-8127fc7abbc6

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>


