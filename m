Return-Path: <linux-iio+bounces-10931-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 104089AA309
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 15:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75E4DB22FCE
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 13:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90F91A08B8;
	Tue, 22 Oct 2024 13:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CanjXkgf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B321919F424
	for <linux-iio@vger.kernel.org>; Tue, 22 Oct 2024 13:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729603369; cv=none; b=VnakIbdOQE1rL22ha3iejJ5Mnxf300ubc7vorL4M7hZ0M+Rj9EFw9ZxsC5CgFmcgOtX98h0w4zMJANoDuqvXtT1SwRmxDFdjUgCNxo/d5RuZLyXaROxkUb18sYK779nPB5La8cYkaotpVe6yePKGLCLYU8+rSD5lhXY73dREhhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729603369; c=relaxed/simple;
	bh=93yqkWUeqoTZrMS3Qv/LyjXxpxza8AT1Xx3sBk7mQ6w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h5sUdScM/3AilS3n9csxA1Q3y5hwI135ra0VyRjdrM8sJkXdA6W/Fog3QDbJFmmTOxIewOIeJdC+1H8C2QpFlVpS2FK2BeWEY3CKoTRRwYdH779TE8njF+RKE+9G9RlPwiXsR13uEKy1O31UGisCDkjAFvqvRIrsNs1u5c/hKAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CanjXkgf; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb443746b8so59042581fa.0
        for <linux-iio@vger.kernel.org>; Tue, 22 Oct 2024 06:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729603366; x=1730208166; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LmBCGGu8V19sKPuLEdWIgSMphHuygDUH58C0a6iUhuU=;
        b=CanjXkgf7YNyEvsiWHVtMNTHkXqyakl7A06+bT1X+zYy2JFdwN/lrsxb3ppfNK/ttp
         YXJpOfH/QaCWhO6ghwRX+xy2Fx5aYOl74tUCmrCgbEPS+sKjZj+TNhps2glqZaxJbtxA
         BFSKg1/XTrWN/CuePXX4OuI3yJhxwgK8UWDvfCm09C5PYIeGn2Z0A5yvEqYx5Tx1Oib4
         a3RFpEjjfsRgU3Nfrh+5KFwxhjiplzYcvArhOU3HFfmEreX5sJO6Qf0RfPxYEcYgJRUf
         Vz1wEC8xeW15dxcrjm4KyLRNIfKorjxezdsSsO5Lnkp7ZwU/Hz1fqBkOBkBerbIoX92W
         s+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729603366; x=1730208166;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LmBCGGu8V19sKPuLEdWIgSMphHuygDUH58C0a6iUhuU=;
        b=JLO4fzSFez75KgUZezNuNEGk78eE4teXbp6evyUD8G4ZmKI5LEa7fRPg1iwp3F6Yin
         f7EVFFDSSvsKe9VKth5H9Ci3B96iBFvlJlOXHmQbusDZfnBLr6PRT08KfvQ5WX0Kp3Ep
         Vp9YltreFuU/ujKASMqsPiYf2D0dLN6pmNDJd7Gq0I2JwLVgN+5Z8YKPEn49ZhvR8Ic1
         o1yxbGLiLOmuf1yfaKX1WUTBezNuJuzh4sURpAtNEV8hQqHzzHJTx3hVRZNy4u2DinG1
         yU2Aa7/ekMrLml1r0A3PCRmX6+1l0FFXaa1nSwV9Y7vJ6W/sAegzp875gUJRdf9DyFcK
         jhuw==
X-Gm-Message-State: AOJu0YxCyGsv+29o8KyIBtofZP77VqmEfaK8KgeoTzUh/7BX2qPLtuV0
	Wg3hp9rgVU3A6hTttLW+xW8KKSn1dJnYPws3uaR9QAtxMTNpVmoa2xHo5/lwjhU=
X-Google-Smtp-Source: AGHT+IFYoWGYAGAyysYJxsmXb35dqHXmkJ5cp0TemXNdKUtqwdnENvnGULLlRAUTFNIbNka7IFJWrA==
X-Received: by 2002:a05:651c:2109:b0:2fa:e658:27a1 with SMTP id 38308e7fff4ca-2fb82e92b5bmr85705451fa.5.1729603365699;
        Tue, 22 Oct 2024 06:22:45 -0700 (PDT)
Received: from [192.168.1.64] (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net. [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c737c4sm3109496a12.96.2024.10.22.06.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 06:22:45 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 22 Oct 2024 15:22:40 +0200
Subject: [PATCH v3 5/5] docs: iio: ad7380: fix supply for ad7380-4
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241022-ad7380-fix-supplies-v3-5-f0cefe1b7fa6@baylibre.com>
References: <20241022-ad7380-fix-supplies-v3-0-f0cefe1b7fa6@baylibre.com>
In-Reply-To: <20241022-ad7380-fix-supplies-v3-0-f0cefe1b7fa6@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-doc@vger.kernel.org, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.2

ad7380-4 is the only device from ad738x family that doesn't have an
internal reference. Moreover it's external reference is called REFIN in
the datasheet while all other use REFIO as an optional external
reference. Update documentation to highlight this.

Fixes: 3e82dfc82f38 ("docs: iio: new docs for ad7380 driver")
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 Documentation/iio/ad7380.rst | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/iio/ad7380.rst b/Documentation/iio/ad7380.rst
index 9c784c1e652e9afc116fd206a6cdb70fa6e2adf0..6f70b49b9ef27c1ac32acaefecd1146e5c8bd6cc 100644
--- a/Documentation/iio/ad7380.rst
+++ b/Documentation/iio/ad7380.rst
@@ -41,13 +41,22 @@ supports only 1 SDO line.
 Reference voltage
 -----------------
 
-2 possible reference voltage sources are supported:
+ad7380-4
+~~~~~~~~
+
+ad7380-4 supports only an external reference voltage (2.5V to 3.3V). It must be
+declared in the device tree as ``refin-supply``.
+
+All other devices from ad738x family
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+All other devices from ad738x support 2 possible reference voltage sources:
 
 - Internal reference (2.5V)
 - External reference (2.5V to 3.3V)
 
 The source is determined by the device tree. If ``refio-supply`` is present,
-then the external reference is used, else the internal reference is used.
+then it is used as external reference, else the internal reference is used.
 
 Oversampling and resolution boost
 ---------------------------------

-- 
2.47.0


