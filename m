Return-Path: <linux-iio+bounces-13947-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5AAA03A1E
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 09:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A29CA1654A9
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 08:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539C11DFE23;
	Tue,  7 Jan 2025 08:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Y6vAod/9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960C91DFD99
	for <linux-iio@vger.kernel.org>; Tue,  7 Jan 2025 08:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736239713; cv=none; b=QQiPFMYhklmHQzSEiBH9m+4ufAKC7JxdbEtXbt52VYwD14ZHKJ74tp66Y/ivhwIrRo0t+CubPHlYKlONKURfRPPNrMxYJdPEqaZ7dhc8Frni3VIrI5Z5e6lvJyah1yB6P+2JURv+Ymh09usc6qZMpXHUlco/+BV35iQ0CXIKDmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736239713; c=relaxed/simple;
	bh=JScDeqYbIVgdtvzMG6HJz7Q+oqkApB4u2j+TWaPzgQw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AuvQA49RGhqJhR8NhwfhE5M9r9yk5cxMwFyD5BSp/747JqRDcK2/rl0sRNVLepVBdP6xzZiyWY/zIkNafbyx6xoDWFNkFR0tc7UDdKnIookXapSyd4lcNSLvja3f1eOHl8T5rZE2IduwxG+umKr8UK/VowJ+wImwVDqXSda5rlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Y6vAod/9; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-38637614567so6919190f8f.3
        for <linux-iio@vger.kernel.org>; Tue, 07 Jan 2025 00:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736239706; x=1736844506; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9ItiK4KQmv9BFEgfm1xUxikYdoeP+k/ONB82cnNZD4I=;
        b=Y6vAod/9DK8x6lgzZVd8nwPX+mzhIvKx0HF5wLpGwu/HjSc6huWwVGq55nFsE/2L2k
         bDk27FU1n7Ar7wAd3wsWwwc/ilRbBkD3YDxCGgbJMt5mlIZlFs2MyoctkfV0+VXsORQP
         QdAldbRfmbzwk4H+WUyI+gL1Dyfk5zEjmcamHMM8IhDxVeEWccXefrY6NVYBf6uh1SFf
         jQMITWvJEh5DvdkZZxLq6fVfcujM00g9RijNUZBBq2gLZJQyP4PSjqsd7NiZ4AY+lXFH
         46AA3ef7IIquz00wmq0YHNCIIuCd+HFJ0IrwddljQnIq/IW7upx7IglOnQnIgdJoFt0W
         bvuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736239706; x=1736844506;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ItiK4KQmv9BFEgfm1xUxikYdoeP+k/ONB82cnNZD4I=;
        b=s3+eLp7lnR/RzimmpO2g56UCm/Oaj0D+h/M+NEkyAr90mC3oOYcpySQidKcwnId67h
         YgNjjzA4YI+eFhtVWv2vVQ26d4nBHw9aDrDkutVjD+OWaxCE2T3VTgd8oCx7VFLrZb01
         7c3fi7dVlPGju4Ls7VEpF/6LOM+TG/O6fri0Zotbv3Btp/BNfGmSem7WcQ2QzhyMo4Xd
         35s0C7on1OJmP0CLCfp3+wY6eILAKu9w4KQo0utbrLaucouNiHd8cIOl7/FlHYsMGecc
         l277I9ZatUAi/9VGc4mjMQYCTVrcBVKJ346kqu/uxOMj3XlPx9SJkGKP/lXga4hTy6Gs
         +TmA==
X-Gm-Message-State: AOJu0YwsFVKjNyAicCcB4CRv8VxsuLF72Ig2D/SQSBuRo5ZUGcTKlj1E
	fVFbb1PAAPr2Njdc+blbyKpIC/1mBFG9qL+PFSwImI8q3XJU6jDSGPG2ZL1GfYg=
X-Gm-Gg: ASbGncsIqnCErrmHqyBnJQXNUVlCDP9Tj4l03oYnuj6qNck1EriwIib/VH2xRp0LN0l
	pOyY8Hm2iK5PqP+uXKlmzFMsH6xQMpmCjknL2o7Ia+vVCYCBP6wc371K7KsOrE+uDaMDf9W+8Nk
	5RikCUgYGBu9TQm4CzRB4TyQ72Fn6FFwkAOOGn+GvuF3F6xkwcE65QEDCZt1wN7hQ3NeG04XLuw
	lFlOnABXaRipdIEQV+gJqXMU5GdDpoMO85yjAcLORIeZcSvjUNjLxZPRzsbrSOksAhC+V75CYKa
	1iPWjNY/1ro6RRBQjuxkhpx9dlRBvbxmfatZSQPckfnXlVpe/Q==
X-Google-Smtp-Source: AGHT+IEbBLYRYCCKspoyVREKqnRmx9SNp7XWgbWQMLHo9S6x46APPiifoVfwToumEY7p9eUH6PnFnQ==
X-Received: by 2002:a5d:47af:0:b0:385:fb66:faee with SMTP id ffacd0b85a97d-38a221fa4b5mr43671082f8f.18.1736239705779;
        Tue, 07 Jan 2025 00:48:25 -0800 (PST)
Received: from [192.168.1.62] (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net. [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c828817sm50722280f8f.1.2025.01.07.00.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 00:48:25 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH v3 0/5] iio: adc: ad7380: add alert support
Date: Tue, 07 Jan 2025 09:48:24 +0100
Message-Id: <20250107-ad7380-add-alert-support-v3-0-bce10afd656b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFjqfGcC/42NTQ6CMBhEr2K6tqYt1RZX3sO46M+HNEGKLTQSw
 t0tuCBxYVxN3iTzZkIRgoOIzrsJBUguOt9mKPY7ZGrV3gE7mxkxwjglrMTKikKSHBarBkKP49B
 1Pie3xNqTASWNRXneBajca1Vfbx8O8BzyQ7+VtYu9D+N6n+jS/vGUKKbYkuJYckK1kPKi1dg4H
 eBg/AMt3sQ2F2P8h4thgoWRpWa6EkYXX655nt8tI0KqJAEAAA==
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

This is the first non RFC version of the series (RFC available at [1] and [2]).

Given the fact that the main use case is to hardwire the interrupt line
and according to discussions in V2 about interrupts, I think the best is
to not generate events, at least while we don't have a reasonable way to
correctly and efficiently handle interrupts.

Events attributes are still populated to allow user to set a threshold
and enable alert detection, so alert pin can be hardwired.

Userspace event can still be added later if needed.

[1]: https://lore.kernel.org/r/20241029-ad7380-add-aleyyrt-support-v1-1-d0359401b788@baylibre.com
[2]: https://lore.kernel.org/r/20241224-ad7380-add-alert-support-v2-0-7c89b2bf7cb3@baylibre.com

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Changes in v3:
- split regmap cache commit in two
- remove interrupt handling completely, updating commit messages,
  driver, and doc
- fix minor comments from v2 review
- improve commit message for iio_device_claim_direct_scoped removal
- Link to v2: https://lore.kernel.org/r/20241224-ad7380-add-alert-support-v2-0-7c89b2bf7cb3@baylibre.com

Changes in v2:
- fix read/write high/low thresholds
- add reset_timeout mechanism for buffered reads
- implement regcache
- add cleanup patch to remove iio_device_claim_direct_scoped calls
- add alert section in the Documentation page
- Link to v1: https://lore.kernel.org/r/20241029-ad7380-add-aleyyrt-support-v1-1-d0359401b788@baylibre.com

---
Julien Stephan (5):
      iio: adc: ad7380: do not use iio_device_claim_direct_scoped anymore
      iio: adc: ad7380: enable regmap cache
      iio: adc: ad7380: do not store osr in private data structure
      iio: adc: ad7380: add alert support
      docs: iio: ad7380: add alert support

 Documentation/iio/ad7380.rst |  32 +++-
 drivers/iio/adc/ad7380.c     | 394 +++++++++++++++++++++++++++++++++++++------
 2 files changed, 369 insertions(+), 57 deletions(-)
---
base-commit: 5ab39233382c621d3271cc274d1534e1b687f4d3
change-id: 20241029-ad7380-add-alert-support-4d0dd6cea8cd

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>


