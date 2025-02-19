Return-Path: <linux-iio+bounces-15817-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CBEA3CDEF
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 00:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06E1317109E
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 23:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C5825EFA9;
	Wed, 19 Feb 2025 23:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdS/uO5C"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE38214805;
	Wed, 19 Feb 2025 23:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740009304; cv=none; b=lgpPle1O2oVRqsNXID3coR0pz9+yWZBYgFziBlyCXYWH8JgYtRiH6VfAdXeSXzGogZNt/WY7mFA10GvOHZiHaHBBKF6vKmWS1u01esVcHsvIYP2UOLswc6yPTpnYCO3xXOXsSHq7O5QB6rNLrB3eBsbRV/Ig33nwwSUBZe79s14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740009304; c=relaxed/simple;
	bh=AWAZmY3z0sKAgz24RMKBInEL8e32XRPSJtZW9PcJXno=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qQXwcVhDx4VP8MSsVmMPz7d8Xn90ke0yxhYC14WboaQQFqs8LIbCcfwYO27UjdtyMJxi1Wt3tKqysfqm80pqe4IyFpU1GinWDBnaMPzPxzFssRsoncZKyxgZyf3TaolLP6KkQNws6lkq/GZFdxZCSfhWD7SH6Ctctnrp9BNgMAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdS/uO5C; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7272c68780aso177129a34.3;
        Wed, 19 Feb 2025 15:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740009302; x=1740614102; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MrkgSEwu6wPUdd7PuNAiCByQXD4XUeJZryknw69cH0M=;
        b=bdS/uO5CF1M70fYVbi7nOV9nf75ATAqFjrVrYjLvzb88Jv3810runQ4YD1z3iztM5K
         5VTYjKEXohNbSYruifmqMeteDdlsNDbzzExsFP/ERMyq6lfPyeXNfXS8lvavSkl5hx4U
         F76T1ImAltCcXjIUj1Cs+eE+4OC0R7CYWiGsZ36xuvD4kyRMTNa5vQV8O0zpmtvLR6Yj
         XQ6xReRSvJ7XupzRah5qIN5m9/57z+y1a86g9Ul+9Jb2Khf8kVZnq38M3v+y46JoeNDg
         abHD3MK7hieyk8OkofapIiG3wYr8NATo5WXYnZyjDmoyV7p9vyROuaaC5BpAeKYFrqXx
         DzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740009302; x=1740614102;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MrkgSEwu6wPUdd7PuNAiCByQXD4XUeJZryknw69cH0M=;
        b=nPyt5eOtO1DqAcvNIHBQ757KGnBTu4tEA5jCjv7GvgzEzFo2tbkjCqnupZnrj7KpRV
         Wj5HEStnTvKQdAOdbGdyIEOOiSb2lbZbjdDYoSR5AD7N5cJXk4IX+xJHEHm+QwRfEs45
         FUxnGe29M30moynWn2xFxzM2LWemkF6DbzN7UczsmE+PEPj7DlbqBQlrya1JbWaxcTcV
         eJ3NOxTSpJOvmjb4xyd9FCll3JwKx+Tv409f8era8Ua8/S2GOqEb1S2Z9ZkRJzfkFRs7
         18/xNTWmTSeEOxqOmkGaCtspJi/dOeEcpJw2n4itYlfn6RBoBZJAmFAHi5e3+ZXUYe6w
         Q35g==
X-Forwarded-Encrypted: i=1; AJvYcCXexGI8rVhA2O0idx+Fy+WUMj8+aLeDsUknod2mHsCL8fHG2rsMGABCLkUTRZbxFF2dqlJPxctZcjfTkSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YztUJZdMbvg0kN6U2eFTYSvw0VzXqUhprJCfMqIrUDCOcR5DQQZ
	EdvwO478wWPD+LiEZbqJ64DhnG+pP0h0JnbXNOFDHEPkhx1nW6M5
X-Gm-Gg: ASbGncuinRh0QSzKwkzeuzCcP81kuLRZJBuVG7xRKDATkmntMkVKnpDEab9TLeR9WAg
	Z8YwEy+xIqX5qrrBWLoJQiulecDHxdnIBzaGGbAHwhyJU1RNinHmSwAF7DlpjbmAKsDk71EVb18
	VAE3dtkn4gyjYSSoA4qXhmknUAcEZCDiAMZogKhg1qFAXixRSpHdzMtCJ/8rzVwT4PuTSuHR/GC
	mYq+RD7KRZUvIp4t0KO6ulFa2gc3EYgGb46zdjrfCApBpGALOM3awKCqVBpiANZXF1Z268l/Ahc
	XrI4eFFc
X-Google-Smtp-Source: AGHT+IElP2c/FtiEbSW8bXEi4hxsFYYfadDyEA6FTwQGvmQrnWpkAMJzUy3FjfOMwiV7eG/OAYHrlg==
X-Received: by 2002:a05:6830:398d:b0:727:3664:ca23 with SMTP id 46e09a7af769-727436df772mr213262a34.0.1740009301953;
        Wed, 19 Feb 2025 15:55:01 -0800 (PST)
Received: from [192.168.0.107] ([2804:14d:90a8:854f::10dc])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7273a14070esm658173a34.49.2025.02.19.15.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 15:55:01 -0800 (PST)
From: Gustavo Silva <gustavograzs@gmail.com>
Subject: [PATCH 0/3] BMI270 data ready interrupt support
Date: Wed, 19 Feb 2025 20:54:44 -0300
Message-Id: <20250219-bmi270-irq-v1-0-145d02bbca3b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAERvtmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDI0NL3aTcTCNzA93MokJdy0SjpGQTw7TE1FRjJaCGgqLUtMwKsGHRsbW
 1AG4nmGtcAAAA
X-Change-ID: 20250219-bmi270-irq-9a2bc41faee3
To: Alex Lanzano <lanzano.alex@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gustavo Silva <gustavograzs@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740009298; l=863;
 i=gustavograzs@gmail.com; s=20250111; h=from:subject:message-id;
 bh=AWAZmY3z0sKAgz24RMKBInEL8e32XRPSJtZW9PcJXno=;
 b=Kki1qmUXoHHfnfc7UyVKkuBqAO8K2rRA11GXEJ6LJ3WXL5H23v1bo6682d18vqcb4vdJ2mF1e
 Zcws0jbj+M3BRqfC2jEYmlltlMJA4S5yVsL1iq4HXb/NeDdUxZ0kSzL
X-Developer-Key: i=gustavograzs@gmail.com; a=ed25519;
 pk=g2TFXpo1jMCOCN+rzVoM9NDFNfSMOgVyY0rlyvk4RTM=

This series adds support for data ready interrupt to the BMI270 driver
using one of the available interrupt pins.

Additionally, this series includes some cleanups to simplify and improve
consistency across the driver.

Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
---
Gustavo Silva (3):
      iio: imu: bmi270: move private struct declaration to source file
      iio: imu: bmi270: rename variable bmi270_device to data
      iio: imu: bmi270: add support for data ready interrupt trigger

 drivers/iio/imu/bmi270/bmi270.h      |  17 +-
 drivers/iio/imu/bmi270/bmi270_core.c | 326 ++++++++++++++++++++++++++++++-----
 2 files changed, 281 insertions(+), 62 deletions(-)
---
base-commit: 4c571885898c5c98934d086f2ab11b5e27e4f41f
change-id: 20250219-bmi270-irq-9a2bc41faee3

Best regards,
-- 
Gustavo Silva <gustavograzs@gmail.com>


