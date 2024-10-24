Return-Path: <linux-iio+bounces-11060-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF589ADEF3
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 10:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18A171C21F9C
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 08:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BAB1C07C6;
	Thu, 24 Oct 2024 08:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JkfL4EYl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F16D1C07DF
	for <linux-iio@vger.kernel.org>; Thu, 24 Oct 2024 08:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729757851; cv=none; b=pd68/pHcDKOc0nXZbssmsvrlT2NljHtESM8QWruYQjEPLp7IOUr+aR+vq9wogg0BGZI27QJSBQ7jIO8SMOsoIcdapUoy31o3GQEJwtbr1SpPOfdNBkJpU488dYkaA6x/hmpOmZ1mnyqLpOWY9b+IWS8fTDhrhR46HE2kzFWT36k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729757851; c=relaxed/simple;
	bh=ur2xrohuXdp+XK2W9kNkEGxeD+PeEi9hqLfcXSWTqkM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jfAYUmTgelT/cTpbhyc6QR4/cFqo7y09jpO6EUDUlKYvLir25TlEJany67p6KxOrlcfiwgKQcMUCU9+WF0hHCHlQ/9OunQIPVcgKwagTZlhT8nS5UQGfxjyqGCa8S2kHlFlkGM2WCLqgmw/PREfD4DZpGSyN+j8+tgPz8lRm81k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JkfL4EYl; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43163667f0eso6411405e9.0
        for <linux-iio@vger.kernel.org>; Thu, 24 Oct 2024 01:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729757847; x=1730362647; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jrgH1600uHhvBk1qPJnNVTmvv8RgMwdXL0zxz051j4c=;
        b=JkfL4EYlRRrUGUmLnXv/rW261P7hoNXLMIEzWUhHOapRCtDyGEsdTehDSksU2CL0fY
         B/gkBtl7JzAtgUwEN2NDxr9iBiUgeotJwuLgZkvaWDqdEbkl8F3kpwR/qxU6EXo0tk+v
         lOjWsywZ9eCHclADFT9LyQGORTYjPZEfflLZUIR/B3el3FvVw6eBWd5L21tBB/bZ+N0c
         EtgXGjZj+Vv+tyaXJg1SXnZ73Wag3HY+ZeUDJme8TJMfv/Vh5iKZpWtxVbWPoRg4Jo9E
         y38ainG89s8yHsMpEl6i8DwvWI5LcOPIZWYpDj+jpSwx5T/wi6fxscnnmQfHQ/9xxCxn
         3NZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729757847; x=1730362647;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jrgH1600uHhvBk1qPJnNVTmvv8RgMwdXL0zxz051j4c=;
        b=Yzo3ozOlMaYRKFBpq4kZ7EHikfxlAjx9fhNQ2CJXgYP98h62KOFgW5Vs1ttlzZJcsQ
         VjLTjBDRnsPbyAxggSDYk/KJBEW/neuiXt8yl5hiwR1VCk5m7bLw4fdAtpjNiIHFfNPz
         aIUs856p45rQ4BXR1zXOl/UrdYMkz6wS9/W3okw6YW7PD10VJ63hjFKal180l9JZmcwr
         FlkWFznjPucQ5VR/vEUWdo0HEPCgk6zypTtarsI3vTA60PueOMXswwyJ5ycNhJCpd10c
         lSdPCmgt6lh/UUY4+c0wcbAgu8Fsa0A2FHJBN7pDcASm8SMbNtPs+nmLVscElwc3SxGx
         tHXA==
X-Gm-Message-State: AOJu0Yxe1Qrtiz2g+6MFo8/ufvebTXljmga53ja07HPp0CnOWXOHgIx2
	ov6M388chZEPrq8JpgfPe/oHdmaPEPtmJh3L2uM3/tzfTR1ASNoLOBzRm3rcIxA=
X-Google-Smtp-Source: AGHT+IEzhsRwOJgh3fbdbOlKC8iU7HLBw8UwXvWJmchuXs8faxJKCHdJuHR/Twx0nsTKecCdTDVCeQ==
X-Received: by 2002:adf:f8d2:0:b0:37d:4ebe:1646 with SMTP id ffacd0b85a97d-37efcf8e433mr3207284f8f.48.1729757846760;
        Thu, 24 Oct 2024 01:17:26 -0700 (PDT)
Received: from [192.168.1.64] (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net. [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b93d53sm10828922f8f.70.2024.10.24.01.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 01:17:26 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 24 Oct 2024 10:16:59 +0200
Subject: [PATCH v3 4/4] docs: iio: ad7380: add adaq4370-4 and adaq4380-4
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241024-ad7380-add-adaq4380-4-support-v3-4-6a29bd0f79da@baylibre.com>
References: <20241024-ad7380-add-adaq4380-4-support-v3-0-6a29bd0f79da@baylibre.com>
In-Reply-To: <20241024-ad7380-add-adaq4380-4-support-v3-0-6a29bd0f79da@baylibre.com>
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


