Return-Path: <linux-iio+bounces-9896-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 127F498974E
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 22:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFE791F216E5
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 20:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6ED811F7;
	Sun, 29 Sep 2024 20:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgLgWhsF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E6745C18;
	Sun, 29 Sep 2024 20:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727642333; cv=none; b=FbXQOGw9UnzDCUl9CcJxSxZqCKqhpN1cfM+57ZH+uZN0h65Sbf8jMmuxJKIXoOF4dPXyqHxDXZAuk2nOWrmzyruSxQpHNY7hF6Df/ClIhKcWW3tBIaLR63lY3WVnxg92lEdfVQ4ur4vbeRAQ1A7LOzXWn2mxcdJCIWV6cuRrn/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727642333; c=relaxed/simple;
	bh=ZT03Gl7EcIyCpIsNcxfxqkKztgiam/EU+vMyxpmHsGc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jNcTIMZmje4YzxSIqYQXvVQ+Nbu9FjQ9qUe1D8avIkpRYCAWuR3MPY1qLHTbwKMu6y46u8sPJUJSzl+64ve7HKnFZmgd2kQPWZSz4I1/ClZz1QfPnikurSAKhZrbMHa4EiriJSUhp13OILQ3FYPQM35ghqo5GH6nz1kG0+LQX3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JgLgWhsF; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8d446adf6eso636918066b.2;
        Sun, 29 Sep 2024 13:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727642330; x=1728247130; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=putZppQgXwDvNv+RZA6pcl4OAhvfYEne4ISwcXTtxBk=;
        b=JgLgWhsFbYIMY+/tU4ogJyn/F/peU/ay+aKmWzhaNr2YIcPaFPLFxivPxdyJMemsH/
         13MJFDLEI3ZFxDM+ByD4kv5eV5qx07CBSWU34Ywm7j0bMxMEXwLKGoEg2U/xCnX1n14A
         8/OEMqlVbp5yTkgjBnBoB+9YS76pgvfjIEVPtUzVqCKpdbqMjUVS8rhfmJR+dj+d55Mj
         CuMkVWFaXFsD1ch5RSj9qmPTcOh+V6ge3f9/jEmQVe6elRcFOVE5ZhuYwu56+5SHAPoc
         mqVl9ixzO7DnqQmbB+iGKdIrqkBaDp+GzeltONwaCw4N/qtIe7SlTc3Od30KC30hwTWB
         ynJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727642330; x=1728247130;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=putZppQgXwDvNv+RZA6pcl4OAhvfYEne4ISwcXTtxBk=;
        b=nXj/ssx2symy7A0k4d6rEJZmFoZlbOM/wK+VahupfNRdxmIvmOKCWbFRvtCtto3V49
         gCXmB5KsCG/Q1fovRckms/0XqqkAVALysoSUGoikSfmO+PSVeDMDcLDeXBp+CpXciFIs
         7T5KWM0SdxxO3uU4J/Zy5Y1SVxjokAtKKRw2MH10PbLKI1JaVFnxvvc/VeCJGVbVBjzd
         6c84DRktWnWcXl4jJp/B+HI33zxgDIAcl12o5iFAd6G+W27fZY6qwUrQCK5QLs4XzDsS
         7HX+lbt9o0s63PgeGhOx7KBPq5McoVYGG0eiBeZePIOrMcleBkct3PzvpImm54BlALAH
         b/eA==
X-Forwarded-Encrypted: i=1; AJvYcCVT7wGeCMxwaLOKKHX3yR47T8tHukHbZuR5oad7ueVydIMqzgNp/j7chahFZnbwq+66YY5jeKJpj/i4@vger.kernel.org, AJvYcCWxHTqB2Byg29+iSjtoepy29UaN9XIG6E1+MNdKWwwdDPDN2Uo9DMSP+WVUNzIKEh6Xqs9MCeFjrfepj6Tf@vger.kernel.org
X-Gm-Message-State: AOJu0YykdWYUMtfNWq5nYbs6VkxZEH+deHWFLpmYPYr1ylfnXW8hPcFX
	cPpPCB+wuLQAre1AYsBMSXUsQqcpaGgx7T6LC1F558gToJar4nRw
X-Google-Smtp-Source: AGHT+IGyPWoz26+OpR6JitvAyLC+0JNsOOQdP9wZCb794YJDQTFsvLc4R9Nac+2AU2xHAPLf1L0XPA==
X-Received: by 2002:a17:907:74b:b0:a86:7e7f:69ab with SMTP id a640c23a62f3a-a93c49087f3mr1048028366b.15.1727642329957;
        Sun, 29 Sep 2024 13:38:49 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-e2c0-9a60-64a8-717a.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:e2c0:9a60:64a8:717a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8824051c2sm3487985a12.19.2024.09.29.13.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 13:38:48 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 0/7] iio: light: veml6070: update code to current IIO best
 practices
Date: Sun, 29 Sep 2024 22:38:45 +0200
Message-Id: <20240929-veml6070-cleanup-v1-0-a9350341a646@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANW6+WYC/x3MQQqAIBBA0avErBNGicKuEi2yxhowEyUJwrsnL
 d/i/xcSRaYEY/NCpMyJL18h2wbWY/E7Cd6qQaHqUCstMp2uxwHF6mjxdxADmh61MdKihZqFSJa
 ffznNpXx6t0WDYgAAAA==
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727642327; l=1300;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=ZT03Gl7EcIyCpIsNcxfxqkKztgiam/EU+vMyxpmHsGc=;
 b=kkyqhMHF9gCWUWY6bTo9x/poJxSaUvSKr8CkgIXIZbVR/W2jApDPzhW4IY6jgpppGZn9xdJym
 z2NmSqW4ygVDXxIsgvp/Tr2Ir10z/2O8g8ZFhZIAp2NVIGvq7kax0Nq
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series updates the driver in preparation to add new features. The
cleanup consists of:

1. Device-managed registering for:
- iio device
- action (unregister i2c device)
- regulator

2. Code update to use a guard for the mutex handling and
   dev_err_probe in the probe function.

3. Devicetree support (document the device bindings and register the
compatible in the driver).

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (7):
      iio: light: veml6070: add action for i2c_unregister_device
      iio: light: veml6070: use guard to handle mutex
      iio: light: veml6070: use device managed iio_device_register
      iio: light: veml6070: add support for a regulator
      dt-bindings: iio: light: vishay,veml6075: add vishay,veml6070
      iio: light: veml6070: add devicetree support
      iio: light: veml6070: use dev_err_probe in probe function

 .../bindings/iio/light/vishay,veml6075.yaml        |  3 +-
 drivers/iio/light/veml6070.c                       | 63 +++++++++++-----------
 2 files changed, 35 insertions(+), 31 deletions(-)
---
base-commit: 4057951fb272efda718dca665f6607c348d5785b
change-id: 20240929-veml6070-cleanup-70b609bb1f0f

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


