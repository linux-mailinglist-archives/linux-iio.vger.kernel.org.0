Return-Path: <linux-iio+bounces-13770-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CA29FBB4A
	for <lists+linux-iio@lfdr.de>; Tue, 24 Dec 2024 10:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E69E37A2662
	for <lists+linux-iio@lfdr.de>; Tue, 24 Dec 2024 09:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEEC1AE01C;
	Tue, 24 Dec 2024 09:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hwXdpX9a"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F63EC0
	for <linux-iio@vger.kernel.org>; Tue, 24 Dec 2024 09:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735032881; cv=none; b=cLxn6DULslhOiM8QsLlQCiqY1gNkRkBzHg/6Vyjg4VP48W0HEWa3np+zI0umcPc2eRawaud5HVVFIFx6zfMI2h6vhRSspqrffv6znmvxKm8g4GEBtu3KuIe0K3s41l3G8qoaGg9qtj0D79+OH/vmgGUEsh1yq38SHXH1holYw4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735032881; c=relaxed/simple;
	bh=gTP11STaOambNCrfwCro80qN7oJiUElgow1HkycNbHk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Tux9ZYInuP444Z4CQhlWiom7O/5Wr69B0qKc5GdhUhYp/OdwDHg20uhOQgXEKhLQ/boBKLnCoI5AX2Q5DkbAVCfRdTnvQFWloxAq3P5rQq3YvrQKqT60k5d+RJsqBcG55Yy5OZhq8R+upsjZSenk9DP+qF9PalH5cAE2c3Vh704=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hwXdpX9a; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-436249df846so34020835e9.3
        for <linux-iio@vger.kernel.org>; Tue, 24 Dec 2024 01:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1735032876; x=1735637676; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N0Ght693j/xuIl81ogZ/rFRsFKJQFysaPVf5fimjLkw=;
        b=hwXdpX9aJZ5IbBsSfNkslk7hwGc27j9Y1L0Lmy6P6PjD1bfBy7bo5+NFgNQUxnJCSo
         aixo/jYbuPmFTJ9ptZH5ajKlJOv1SIQp6MWSh8/++ya+neqBRkQtvsMeALJzIR7wX74u
         zVUrHKsQVedsEAcxJ3mIoSaRpQLfj+MhnENHH2GYejVVsGgqqFSB7Q9Tor9r+X1mf5D5
         g9Cpy45tjl2nRsRbN2IiR6y/t7DGxZ/AeSKHF2O0tmyVG9bweJkr9CidWtZow6T+bY7B
         4VquAESpFwiWTgw06lDDoJuhLbca7IYRadf8O46mSE0x40wo2rY+CAeShR8DC6sVm8WX
         jO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735032876; x=1735637676;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N0Ght693j/xuIl81ogZ/rFRsFKJQFysaPVf5fimjLkw=;
        b=q8Kf1s8YviDZzee/a2Y4ESyLl/5H/4wdDxzS+S33JFbjTAycPa1j9RzAXugmXFhhfM
         QeNeil+3iGxxd5zs3VT+HShScYJgpbaGD15jO94ba8PbV/zG/sdq/RC9P+Jm1FEvZtdK
         JrzHCc8I1YP3dHTuZlSqrndZPG6Pql+MQIY0SN4OwsN3WSTHPuCG+YEIfyF1OElwOA2W
         I4Y17TppfOIDFFB4MjIZOR6JmxFHsKcfQ5or0X4Cq5y9cp2wo6Tfjtt2DFfMbwoJOVWc
         J5z9K+I2QmavzWJM1xDcoauWGI8/Mi+o7woRN9xJC/oP+3TkopqUlXIeEGoi36twJkXW
         ch9g==
X-Gm-Message-State: AOJu0YzIAYvXbuizTZdxlgHLt8AL6xO4KcVYXAw35WEiBpfVNRs5iLlm
	QGYzRzQoYiWPVgfy6DVBx2k0yWudYNbxVbA90TZfNkUdpt1TQrBba2IV55OU1Aw=
X-Gm-Gg: ASbGncvlQH4rWHOqkd+smHuf23GslQV/RHCiDSCkSii46FRUtrnr/ZAefA0aH690UzO
	QFMbK9kKFghRIMyEqn6/6Zsc2lnQCrxGdAV/kByFxvvoomdAYzTE43oO+CGaNx5zOdyB7+Ptp30
	JqIxLokGUh3ohgLo9DGQx/1cwf90B3JdGgAcRhOtf79WHrybuN4HWgm+xcaW2uECqSiqUFxaFEJ
	XHsSsIzl19gVBZeNesmywyZG0TAb8QIGiyhwswnDO+8B1UnxuEBXBYK0M/6CbNGhilFORlc1eLK
	Qjw3LrqBUCxAI0bd1FXjn6B6hud70iEv7whck9m2K8Q3ghz5tQ==
X-Google-Smtp-Source: AGHT+IEsgDxRPzkbXXtlK3VaH4Q+DJ6FgkizyiG5Fyr+eZyjLexw0tZrYi1npUGFdYkBQ5L2oJLvNA==
X-Received: by 2002:a05:6000:188d:b0:385:ebea:969d with SMTP id ffacd0b85a97d-38a221fb1a9mr13669120f8f.22.1735032876048;
        Tue, 24 Dec 2024 01:34:36 -0800 (PST)
Received: from [192.168.1.62] (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net. [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43661219a7csm160932535e9.24.2024.12.24.01.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2024 01:34:35 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH RFC v2 0/4] iio: adc: ad7380: add alert support
Date: Tue, 24 Dec 2024 10:34:29 +0100
Message-Id: <20241224-ad7380-add-alert-support-v2-0-7c89b2bf7cb3@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACWAamcC/4VOSw6CMBC9Cpm1NW1BKa5MTDyAW8OidEZpghRbI
 BLC3a1wAFcv7zdvZgjkLQU4JTN4Gm2wro1E7hIwtW6fxCxGDpLLTHBZMI15qngEZLoh37MwdJ2
 LmCFHPBrSyiDEeufpYT/r6TvcrhcoN9HTe4gz/eb8xNqG3vlp/WEUa/7/3CiYYMjTQ5FxUeVKn
 Ss9NbbytDfuBeWyLF88AGCr3QAAAA==
X-Change-ID: 20241029-ad7380-add-alert-support-4d0dd6cea8cd
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.2

Hello,

The ad738x family includes a built-in alert mechanism for early
detection of out-of-bounds conversion results. This series introduces
this functionality to the ad7380 family.

As a reminder, an RFC was sent [1] with several open questions.

Here is a summary of the changes made:

- I now have a better understanding of the alert high/low registers, and
  it is much simpler than I initially thought: users can use the same
scale as the raw value; we just need to extract the 12 MSBs.
- IRQs are now disabled by default and only enabled before read_raw and
  buffered_read operations.
- I implemented the reset timeout mechanism, as suggested in the RFC, to
  avoid generating too many events during buffered reads (this has no
effect on read_raw).
- Reading registers via debugfs no longer triggers events.
- The reset_timeout attribute is added only if an IRQ is present in the
  device tree. However, the high/low thresholds and enable attributes
  are always available. This allows configuration of the thresholds and
  alert enablement even when no interrupts are defined in the device tree.
  For example, a user can enable alerts and hardwire the interrupt line,
  without relying on user events.

- I added an alert section to the documentation.

- Two preliminary commits have been added to this series:
  - A cleanup patch to remove iio_device_claim_direct_scoped calls.
  - A patch to implement regcache.

[1]: https://lore.kernel.org/r/20241029-ad7380-add-aleyyrt-support-v1-1-d0359401b788@baylibre.com

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Changes in v2:
- fix read/write high/low thresholds
- add reset_timeout mechanism for buffered reads
- implement regcache
- add cleanup patch to remove iio_device_claim_direct_scoped calls
- add alert section in the Documentation page
- Link to v1: https://lore.kernel.org/r/20241029-ad7380-add-aleyyrt-support-v1-1-d0359401b788@baylibre.com

---
Julien Stephan (4):
      iio: adc: ad7380: do not use iio_device_claim_direct_scoped anymore
      iio: adc: ad7380: enable regmap cache
      iio: adc: ad7380: add alert support
      docs: iio: ad7380: add alert support

 Documentation/iio/ad7380.rst |  56 ++++-
 drivers/iio/adc/ad7380.c     | 531 +++++++++++++++++++++++++++++++++++++++----
 2 files changed, 537 insertions(+), 50 deletions(-)
---
base-commit: 5ab39233382c621d3271cc274d1534e1b687f4d3
change-id: 20241029-ad7380-add-alert-support-4d0dd6cea8cd

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>


