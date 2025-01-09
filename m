Return-Path: <linux-iio+bounces-14056-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9939A0785B
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jan 2025 15:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DAEE3A751E
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jan 2025 14:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E780C219A73;
	Thu,  9 Jan 2025 14:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Yh9lZIxP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDA821A421
	for <linux-iio@vger.kernel.org>; Thu,  9 Jan 2025 14:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736431225; cv=none; b=oyIhFmkNcKBi3Fq7QWs81rH2NGS8wyXnCdrflRji04bwWHXsW6AiC3QgFHsPzb/VFuIMV7p9Lmg9GO92U2D5sJEdqTGmftJBFJbsgyelvW+FStMD5qR+bCdd7beh09VUwKNwNMKUfFXGYHUrh+SIaS4DoYIJm4mH5xarVPmPqzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736431225; c=relaxed/simple;
	bh=X1m6tbUa1Mc5sarTnrJ7hnh8GE8VxnFKCTkxOUyIJBQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YguLI8dvo3XnWf6QajrCnc3FfgGPA3hawepAZS+GAfsNd00S6ncqt/nJxf9k7rZam65wrhHMr525XsvGLSxwWgddt0C4ZSLg9Ck+P5MnksNWA6TIaOZJ+zKAmYrtvo1XTXgNpoJQqM6AFp1Ss67OK0JvXYKflByHaVmrf1LvJVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Yh9lZIxP; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4361fe642ddso10802005e9.2
        for <linux-iio@vger.kernel.org>; Thu, 09 Jan 2025 06:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736431221; x=1737036021; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uZmL1r51ARVi+loLbf9/u6cYJvyUGz7CFl3uP4jNh0o=;
        b=Yh9lZIxPl4czwtrQKZ5j5+BNFc8dxLkxABEFL1s56PiP/2VrUl+3GsB5Vo6OjzRt0q
         fZgtFmNCKtcCNkZBHhDQp/6Uj4csM1gFlL3Tbq1IsDFg/oDLXqQmIqv5S4vpIJ96IYDX
         uyfyorH9cfRaNOiItBMxr1u1L/xyG4ZTlIcs9lzxdn6PqdTtnAT9f8RhJXjnEfgynHvX
         H1PBPSacxiiQ/X/27yefacFUzYd+SXGqXc0wodFDsg7OHinH1NcYC50HTg0AhPbSXykg
         jh+RZE9lfU6JZSu+5cpOI8sRCEaUYqbTh7FRsEwHdmr6hmPl+GGuGzv6u5Mit0UTTG8a
         1JbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736431221; x=1737036021;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uZmL1r51ARVi+loLbf9/u6cYJvyUGz7CFl3uP4jNh0o=;
        b=Xoi7bI14F+qKM9EIhQAFH9E+zeC4ia5Og24XBepLPuo5vojhtcxx41Z2iBn0BiyZdZ
         i/Q+Cu72VwRwWmzNBYNH5kxSYk3mtkqHDMbICRavQ+nhtKphmLZy8Z4aPPhS3zqUF2/G
         zg5mEACt9aeRltoMvGpkkQTDJCed1E5iBSeeVVRme+wdTo5Nnmw04euv8dstCnvdGXiH
         Y3bNhJOwPNibTaSZBOwgk16UIyuHpsN5QNrwDKovs40c5xOAV7KS3WnghujLcaVDm6bv
         qxXxiJZ1l0eqry96Fvm2DUVvmDLWIUIX+C0vL+uv6YEBb2+4tpjRXVEarfd6roUs5Orc
         yO1Q==
X-Gm-Message-State: AOJu0YwiYyXNvGTaOiHNz9p+MG7zNAczH6uc18TGnhxHd1fTwiuSb7UN
	5Ta2onu65qnP9k0XxfTR+bP4eLQpg3tuoGbGvrj2k/cZ8w00JuGeR05JpR4TxVI=
X-Gm-Gg: ASbGncu7Hiib6qjhLJQe3EYBUNIY0CpI8/8Q43/d3lVlw1Qn8PFZ1/tTOYWdwnAoKNO
	22Mk1vUZH/AjGNvIIfIwI6tMhTefB7snv854UcsUcmrek2DS6Wn4fdTrc35EGBwzDaNELMsM3Vc
	C+85ENcYCtCg/2c1QKQ566wzu9hFu0Sg+t6k60km5HaQB3/3GaTujT+a/sjPmCuYAhaSXwlCtsK
	tA9l79+/uKRF2wcK8zobeItRabROwE6fIoLdCiwCfx/NgDyKSUgu0n0VQ==
X-Google-Smtp-Source: AGHT+IG76ILeA+kdO19DBe62Tc0aQCakSFcMhm+J2rDyERwRVOmqJRHe6J7O4dFx2XZOlLNrnC40/w==
X-Received: by 2002:adf:b1db:0:b0:38a:2658:bbc7 with SMTP id ffacd0b85a97d-38a8730cef4mr4090504f8f.29.1736431221239;
        Thu, 09 Jan 2025 06:00:21 -0800 (PST)
Received: from [127.0.0.1] ([82.66.159.240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e38325esm1901507f8f.27.2025.01.09.06.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 06:00:20 -0800 (PST)
From: Guillaume Ranquet <granquet@baylibre.com>
Subject: [PATCH RFC v2 0/2] iio: adc: ad7173: add ad4111 openwire detection
 support
Date: Thu, 09 Jan 2025 14:55:16 +0100
Message-Id: <20250109-ad4111_openwire-v2-0-0372c2dde0ce@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAETVf2cC/3WPwWrDMAyGXyXoPI/YzDQNYxQKfYBdRymyLa+CJ
 WltL0spefc67nboYSfxS+j7pCtECkwR2uoKgUaOPPQ5qKcK7BH7TxLscgZVqxcppRbolnoYTtT
 /cCBBWjsy2Kj1ykPeOgXyPBXiB7zvtrC/NwOdvzM9/U46ihELva1eH+HTweIXm4Ap3yJGKaTQv
 lG180bbpt4YvCxjerZD97YoDUYSOXSc2qqnKYk/YJEfOaYhXMqLoyz2f78pNmfWK7SN8Uo/2mA
 /z/MNKdvwSDMBAAA=
X-Change-ID: 20241115-ad4111_openwire-e55deba8297f
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Guillaume Ranquet <granquet@baylibre.com>
X-Mailer: b4 0.15-dev

Hi.

This patch adds the openwire detection support for the ad4111 chip.

The openwire detection is done in software and relies on comparing the
results of two conversions on different channels.

Following the discussion in the RFC V1, I'm taking the easy route of
adding a new event type  called IIO_EV_TYPE_OPENWIRE to signal the
condition to the userland.

I have chosen this option rather than the generic TRACE_EVENT() solution
exposed by Jonathan because this change is more contained and only
impacts the iio subsystem.

The TRACE_EVENT() option, although more generic, will require a lot of
discussion between involved parties and is probably easier to tackle in
person than through the mailing list?

The openwire detection on ad4111 is triggered automatically when a
single conversion is requested.
Due to the way openwire detection works on ad4111, implementing openwire
detection for continuous conversion mode is more complicated.

Thx,
Guillaume.

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
---
Changes in v2:
- Introduce IIO_EV_TYPE_OPENWIRE instead of misusing the IIO_EV_THRESH
  event.
- Link to v1: https://lore.kernel.org/r/20241115-ad4111_openwire-v1-1-db97ac8bf250@baylibre.com

---
Guillaume Ranquet (2):
      iio: introduce the OPENWIRE event type
      iio: adc: ad7173: add openwire detection support for single conversions

 drivers/iio/adc/ad7173.c         | 164 +++++++++++++++++++++++++++++++++++++++
 drivers/iio/industrialio-event.c |   1 +
 include/uapi/linux/iio/types.h   |   1 +
 tools/iio/iio_event_monitor.c    |   2 +
 4 files changed, 168 insertions(+)
---
base-commit: c849f534b9ea4688304f80f4571af75931dda7c1
change-id: 20241115-ad4111_openwire-e55deba8297f
prerequisite-message-id: <20241115-ad411x_calibration-v1-1-5f820dfb5c80@baylibre.com>
prerequisite-patch-id: 26241903b8fee8c4243e73d11fb2872cd9f52a15

Best regards,
-- 
Guillaume Ranquet <granquet@baylibre.com>


