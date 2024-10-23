Return-Path: <linux-iio+bounces-10973-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2265E9AC40D
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 11:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90E83B26BD2
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 09:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BD81A08C4;
	Wed, 23 Oct 2024 09:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KmlhUT+J"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A9019B3F6
	for <linux-iio@vger.kernel.org>; Wed, 23 Oct 2024 09:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729675190; cv=none; b=ZmqEh1zF+K7YUTBr5644O9M1viDvYN1OhII0Yxd6Usjy6rD77g4zdbgbw3T2GDpmw/yfPyC/o1VN2HOc+5aVL/H30o0LcvSVBbYxCRTFu+/YfyVY+Nyd7vhQmpDkYSCn6ZC/MBpqpqu6zOc9o0YP1S3gCoFhiZvUcFmAVrX+V6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729675190; c=relaxed/simple;
	bh=ur2xrohuXdp+XK2W9kNkEGxeD+PeEi9hqLfcXSWTqkM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PKsWZBpK87IV7viXZ5RuXTWteDHDdCROHgPrf3TiPfOawDLa3Qc5lfYAhKRVCSqqivXNK5/TFjxhzUAEqoyJLpf/394bdfNnSpYUuofuFvOUd/vAe/ealJTctqV7iMzLlx35RLt6VSqFtOimnJzt8jOhD4X3SQhgJBEjnKYkLG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KmlhUT+J; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d4fd00574so452247f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 23 Oct 2024 02:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729675186; x=1730279986; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jrgH1600uHhvBk1qPJnNVTmvv8RgMwdXL0zxz051j4c=;
        b=KmlhUT+JjIRVhP2l2zNPEE/84mI9pAV6iVZWqbqJ6m2dzxhf6tYzDLtN9zVLucsvwO
         6P4MP4GEINB2bBDEDD4ddY2Tr7FAuEpv2bL6rJZN3c2jfB1sFiRZx5KtPm2GTQHPcQI7
         VDh1bWnPsdN5oYODf7zvbJ3Af3UkPeDDTCevNupm4e34j4q9iaIpjdLkoiENUbHRowo4
         B2ZgfgYZP2aEAlBo3PjltnPIsm/6ZHp0Ty4mOtWn7Ik0++m8Nv/LOf0lp5LrV4+SF70T
         imhhxEo8UAcramYveXDXxTUw7ViFviN8VSNVLFo7/I/Ls84aleU0l35dfOGvdjDYaXJE
         3FXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729675186; x=1730279986;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jrgH1600uHhvBk1qPJnNVTmvv8RgMwdXL0zxz051j4c=;
        b=Fh6NE4q4sA4CKb/Aqw8d1s74veNAxJYlUTVJ+oWGVai9X4vqCSclroOnNtJ8TSgbOu
         9nBh2nauZicV21/FBNH0SXfdpQAF/dugzFvjB+UnG7j4UGZBQj9YCfGVdXDxyNFHqx9x
         XhqNfVnnR+5QDciwoqSKeiNqRpDOz+OkMDQJ2Y/8jE8o1vFkkskjUV99JGu4VRz/VzEe
         Qz1N3OJ+vj+q1hV/7vx41hh6SbJ0cGp567VwDwnjd8KsbYs8t0TEKGEPaYDOQ6s589ow
         xqtull+811M39ggl7RQAOiokLzu3qB6E5frwMG/BWuy1SszC6KCmzNuxUMF7KQUNmi0R
         HH+w==
X-Gm-Message-State: AOJu0YxhaEEpLT/VEb4lQ/zJ6fHYna3oBRsBoNt1deTUb6tZR+dp8fL4
	VdeyA8M593M9LxwSgTzovk8ETVc/bsWDZqpnXcoSJY4HpBnoNQQ5JYaKVuJidaw=
X-Google-Smtp-Source: AGHT+IG7i9cBORVipXN1XrnApLPL139RzqZXid7n7NRI2h7TniBq6yDje6T+sE35UDZsVYVp9lNWOQ==
X-Received: by 2002:adf:fe03:0:b0:37d:3f81:153f with SMTP id ffacd0b85a97d-37efc5f0b29mr1109962f8f.17.1729675186417;
        Wed, 23 Oct 2024 02:19:46 -0700 (PDT)
Received: from [192.168.1.62] (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net. [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b94363sm8515796f8f.73.2024.10.23.02.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 02:19:45 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 23 Oct 2024 11:19:36 +0200
Subject: [PATCH v2 4/4] docs: iio: ad7380: add adaq4370-4 and adaq4380-4
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-ad7380-add-adaq4380-4-support-v2-4-d55faea3bedf@baylibre.com>
References: <20241023-ad7380-add-adaq4380-4-support-v2-0-d55faea3bedf@baylibre.com>
In-Reply-To: <20241023-ad7380-add-adaq4380-4-support-v2-0-d55faea3bedf@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.2

Adding documentation for adaq4370-4 and adaq4380-4 supported devices. In
particular, document the reference voltage mechanism and the gain
parameter that are specific to adaq devices.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 Documentation/iio/ad7380.rst | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/iio/ad7380.rst b/Documentation/iio/ad7380.rst
index 6f70b49b9ef27c1ac32acaefecd1146e5c8bd6cc..ae408ff2fa9c97427a9fef57020fb54203d2d33e 100644
--- a/Documentation/iio/ad7380.rst
+++ b/Documentation/iio/ad7380.rst
@@ -27,6 +27,8 @@ The following chips are supported by this driver:
 * `AD7386-4 <https://www.analog.com/en/products/ad7386-4.html>`_
 * `AD7387-4 <https://www.analog.com/en/products/ad7387-4.html>`_
 * `AD7388-4 <https://www.analog.com/en/products/ad7388-4.html>`_
+* `ADAQ4370-4 <https://www.analog.com/en/products/adaq4370-4.html>`_
+* `ADAQ4380-4 <https://www.analog.com/en/products/adaq4380-4.html>`_
 
 
 Supported features
@@ -47,6 +49,12 @@ ad7380-4
 ad7380-4 supports only an external reference voltage (2.5V to 3.3V). It must be
 declared in the device tree as ``refin-supply``.
 
+adaq devices
+~~~~~~~~~~~~
+
+adaq4370-4 and adaq4380-4 don't have an external reference, but use a 3V
+internal reference derived from one of its supplies (``refin-supply``)
+
 All other devices from ad738x family
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -121,6 +129,16 @@ Example for AD7386/7/8 (2 channels parts):
 
 When enabling sequencer mode, the effective sampling rate is divided by two.
 
+
+Gain (adaq devices only)
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+adaq devices have a pin selectable gain in front of each adc. The appropriate
+gain is selectable from device tree using the ``adi,gain-milli`` property.
+Refer to the typical connection diagrams section of the datasheet for pin
+wiring.
+
+
 Unimplemented features
 ----------------------
 

-- 
2.47.0


