Return-Path: <linux-iio+bounces-17567-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 435CBA79B55
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 07:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF1A217176A
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 05:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435B019D06A;
	Thu,  3 Apr 2025 05:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOvHZLBD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C3819ABC3;
	Thu,  3 Apr 2025 05:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743658456; cv=none; b=rVJ9ux7GbbYH0VPZYBfetJgPzrQmazYpkF7mPnbHyr7BaMZbVmRfdWoftAFdEDPptJdrI3nEOKUu+ATxxOXH5MMVFgS3aIhaed27S+16dbbGfQ4kfdtQ07vvDAQGU1ye7MTBYJ+oUsPcKck+DFoZBKUDpEbmNA17IOCzTDNKGTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743658456; c=relaxed/simple;
	bh=SLDjyT9aGb0O4Bab8ecLoIGz+BzPtNif4CXgFY7Jicw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S3NRd+SZwIMpkzHy22YPmm+tZWwh/69YfA+ksQXIpVLFlJ24Pr/92EeYX2hWyizyqeYix5E51nBYtPyY96fbDIB/LcMNGkrGfJrQEGlGP4lOxthL7/mnB5IynEil/faTxgvyvDfYgIbicqcNiEOzvJqxOTlhjsfd//j/IJUFw9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOvHZLBD; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-30572effb26so464796a91.0;
        Wed, 02 Apr 2025 22:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743658453; x=1744263253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s764Dh99lIIFXVqQ+swT5a6swcPUiutKEjwZ1bJ/GgY=;
        b=AOvHZLBDtDb7ls/GTlAJ+L8wN3GnYlOvwZk1rP83tc58Dee7o2GGKJ0VHwtQ60fIj7
         ZAKFjOjCUEfvob1S0WBFHIWmASiFCRST7FqJeldJY1MYAzwbLllSN7pOTCc3thJ3h5Ci
         NE0ZdKAP4wHI2Rrhy3wX2+a4Qb6IriRbl9sYhpFyuI/htt8mvNqeRQLC47CPFIL30H5T
         /Kl6fsUHYZ9ZNlttpiy5d24iLI9sXb17gd5y2BuclPY32VQ/pXkQJJIYnFTgwt+piQUc
         nW4Pqbdou818DOadT9mIRMTikGjQPo85s7maf9JlPy7uD/bTSuqzSd/ZnuUCQQeMKlc5
         aW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743658453; x=1744263253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s764Dh99lIIFXVqQ+swT5a6swcPUiutKEjwZ1bJ/GgY=;
        b=twut/xDDwHhFtjAueuVU1TFihSLnEumOR3+i+G7PZvuWbnKPs1Ld3Kq5q5ux+gwUWT
         JrOfVJt9TWyp5UHcjgHSaWG+hkAckzBzac/I5hiYYQkJ43P6NjMtwHHmPlm8T3fAzenw
         W0BVPLWoJFUdc7Pimb0zlmYjWlVdBTk10HhI0XXNQTgHyEjPmPOjKQjjGhhLEyhYMFPf
         ZYgoE8aQ1Wf+guzfUgDdr1J2jjpSR31aYr6V7nnHDlrLYkU7nosbY11LaHnqKJgIvSjj
         3rDb+dRRzZOsrettvXgAknSiK+0mB/2PjrqO0JWjXtZZC3aYCq4CL8Cyu2RIGusI5ct4
         OFnA==
X-Forwarded-Encrypted: i=1; AJvYcCVt1XKrTztiUAV9uob0+ZpOtcACaTyEC4ijzu/YWId/pwbjoz302xxqMqhEHKVdOufBgfWraSwvF3PL@vger.kernel.org, AJvYcCXkXyN99UwXycXyugIGw6wNXUOJ9EZhdSIk8u61AJjqr+ewVK3/LbFKF99lRWzocAHm7MeXoud80qUC@vger.kernel.org
X-Gm-Message-State: AOJu0Yz41oig7065qJXjpLdXslgekvCgUuO5OHzKz+UYSZqpDfnD3Qco
	tHOCMyNSVmZAcaanFTARo/avRVRmspwF/ZJ5VBaHHvutAHgrNvCshduFKiRF
X-Gm-Gg: ASbGncvrVZZdB2R/WIa0QHwo2qXrsLyKzgSWr8f59hrooYM+YUlbAshU/dYVu4PLjq4
	Rtwa9y+0wGmb5tpA0y10ZUxTF8dsVa/B0ZQ+FGS1jkFTfMuzrAzgpbvXJJqUvEk0zLRTuPFxbi4
	updOTR+EyQiCbVilvawzmWwILriCjvQyghD2wUKLLC8UvtrtRLcwViz7EveKcZtTWllzmxdg9dB
	zOoTY2dorxCdrDjdao2Bd7t/nfvfqbBbFmFuExmAMIVrVv56WOwNShCGphuJa6BbpPqx44zugtv
	aTohXH/CPABkW30reMBMLfp+Y5nQAdnS1KExShB847gmMOatxA==
X-Google-Smtp-Source: AGHT+IF7EXW900gLktJ3bRVu/wjaYD7GLL2U/i7+wRxSla+zpsHS9v4u17rKAG4z1q8xCR3pIJlu0g==
X-Received: by 2002:a17:90b:2801:b0:2fe:9e6c:add9 with SMTP id 98e67ed59e1d1-3057daf7dddmr1803902a91.18.1743658453479;
        Wed, 02 Apr 2025 22:34:13 -0700 (PDT)
Received: from gye-ThinkPad-T590.. ([61.108.38.194])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22978776601sm5537575ad.237.2025.04.02.22.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 22:34:13 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
To: jic23@kernel.org
Cc: Gyeyoung Baek <gye976@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	lars@metafoo.de,
	gustavograzs@gmail.com,
	javier.carrasco.cruz@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Subject: [PATCH v1 0/5] add support for winsen MHZ19B CO2 sensor
Date: Thu,  3 Apr 2025 14:32:20 +0900
Message-Id: <20250403053225.298308-1-gye976@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds support for winsen MHZ19B CO2 sensor.

Datasheet:
https://www.winsen-sensor.com/d/files/infrared-gas-sensor/mh-z19b-co2-ver1_0.pdf

v1:
 - Add ABI doc.
 - Add complete struct to receive UART transmission successfully.
 - Add undersigned as a maintainer for the WINSEN MHZ19B.
 - Modify to comply with the IIO subsystem ABI as much as possible.
 - Revise the coding style overall.

Gyeyoung Baek (5):
  dt-bindings: add winsen to the vendor prefixes
  dt-bindings: add device tree support for winsen MHZ19B CO2 sensor
  ABI: iio: add new ABI doc for mhz19b
  iio: chemical: add support for winsen MHZ19B CO2 sensor
  MAINTAINERS: Add WINSEN MHZ19B

 .../ABI/testing/sysfs-bus-iio-chemical-mhz19b |   7 +
 .../bindings/iio/chemical/winsen,mhz19b.yaml  |  33 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   7 +
 drivers/iio/chemical/Kconfig                  |  10 +
 drivers/iio/chemical/Makefile                 |   1 +
 drivers/iio/chemical/mhz19b.c                 | 386 ++++++++++++++++++
 7 files changed, 446 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-chemical-mhz19b
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/winsen,mhz19b.yaml
 create mode 100644 drivers/iio/chemical/mhz19b.c

--
2.34.1


