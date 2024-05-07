Return-Path: <linux-iio+bounces-4863-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E07688BEC2A
	for <lists+linux-iio@lfdr.de>; Tue,  7 May 2024 21:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 102481C2112F
	for <lists+linux-iio@lfdr.de>; Tue,  7 May 2024 19:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE2F16DEA8;
	Tue,  7 May 2024 19:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cW/75z/7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06A1184D
	for <linux-iio@vger.kernel.org>; Tue,  7 May 2024 19:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715108541; cv=none; b=GVAcwzomeEAKTdD+wHfxeK8y8SCEU8auaCbQKLrn6Gsa0OsOefX3iwbTOKPecEpl2kjPnolbqNFZnBscDl43/QuTqtIl5jwmGs/7zvrrL2x2aZ9rjp6Wr/IktgybM3FKlnY4uaj6U2puRvs1Cb9ueQjanIEWJ2LbtYmfGkWjDhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715108541; c=relaxed/simple;
	bh=THOnbvcy8YtMoRQ3jbGfEEGlc2KdcZb94TmIKkRQWlk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H9yUBFSOIpWaNIiVMAsRLM0zepBdGQIlhPtuGbDMbtx/Nt/9vY7KCSNb36Osxfe1y/mRaQIfcB9CIZijJjzEe1McqLcTPwG5VALiYHong2iJY8Uzk7aGS6aJz+GqnjF2QknXIZ6W9+OZzhsYYb2/PkZslTxwftyzkfHe9fR794M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cW/75z/7; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c96871b854so1723715b6e.0
        for <linux-iio@vger.kernel.org>; Tue, 07 May 2024 12:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715108537; x=1715713337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6gNuCvbrlks6X/afJauRk0LUFr+8aSzPKDUwnh98XeQ=;
        b=cW/75z/7izkgDldBQRavpTGhMiUF9WIBAgrCPaJd5GDsT1aRtjk49w9STW1gesjzWv
         NK+uhJDtKVrXiNS6+6lIgzEkyuIkzVluCCwhi9gWQQnis2TbjnvrNdsRoh/WTu1lnCvo
         DFAemoCAstWItrVQRawnc1pv4bYpSCicbXMhb8hvEaSMqxzCyj0WR00Fo2LqUulBgSAm
         sWDyzHwLagRvwQ2AWQhktN7Uadf7cVLAVFTqFMpZs8h/zw033cg8wXRlVgv7o9M8ODT6
         A+fhqJFCNU/4W+EHq/u+1eB/NERLT2gjZ0KVS8AaeELKnBxGve9T3y2RW+Ekm1nGYILM
         2JgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715108537; x=1715713337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6gNuCvbrlks6X/afJauRk0LUFr+8aSzPKDUwnh98XeQ=;
        b=AJW7zSxw6S73zfN/eYHOLjJB6UWUlLmaedZ0kDqL6PoiaNahxuBa4xzH0QA3jRqqjQ
         LDp47pQUwIO6OsbXlDs0kpl5oHMI4mApz7QrZ1Rj/mN6ZyytP6BxfYUeb1Njtei6gvSy
         wgDN9Pi/Ic7AeIrkWE7UFzmIhqEltgON+is5Y2dHbKe2I3rBSi5+9mIYSxHTehSoudFc
         oRDgBS7nmTSjZV/XIUA9eR1KRKguabwcySf16Ve8edOSU4I9pbdLg1U8eF5zgt6TJt6l
         6MHLvccvKs9SJfQwpTYK2HUNDQ2jtJMtciE1a4UbF/psz9Kdd6O2Gx8LRWIZvWY85Uf4
         0Ffw==
X-Forwarded-Encrypted: i=1; AJvYcCW7+CFtg5VLYNAf8IX9BuZANJf18FWU3PYu6AXohJz0NULQi3cV5ibNSwVwVsPl/QsJvVNT0APb5RklAyUoHfxgHfzLrQ/Rnc7X
X-Gm-Message-State: AOJu0YzzFWnT+t2/yTFzpa7rPAI5WhgYMEsg/dLQv8ad2tX592KF8Bf+
	RgcVljW5Vi993ux3Mu7w06vQmrcNEaEgVPCjizGfqgPWdwXMi2s+YH4DPnLuPbI3ksqNqO/GojE
	qIPo=
X-Google-Smtp-Source: AGHT+IF8zSwqsJ7DovqJ5O4gj7spAXfPuBoq2zMMEpGPBPiIIQ4Dk9li+asev671rVSmc8q6OL279Q==
X-Received: by 2002:a05:6808:304:b0:3c9:6e9f:fe23 with SMTP id 5614622812f47-3c9852c051cmr508992b6e.17.1715108537035;
        Tue, 07 May 2024 12:02:17 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id j14-20020a54480e000000b003c96bbe0e79sm909652oij.13.2024.05.07.12.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 12:02:16 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Julien Stephan <jstephan@baylibre.com>,
	Esteban Blanc <eblanc@baylibre.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC 0/4] iio: add support for multiple scan types
Date: Tue,  7 May 2024 14:02:04 -0500
Message-ID: <20240507-iio-add-support-for-multiple-scan-types-v1-0-95ac33ee51e9@baylibre.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

Following up from this thread [1]...

Unless I've overlooked something important, I think adding support for
multiple scan types per channels should be rather trivial, at least in
the kernel. Userspace tools will need to learn to re-read buffer _type
attributes though. For example, it looks like libiio caches these values.
I had to restart iiod to get a proper capture with the iio-oscilloscope
after changing the scan type at runtime.

Here is a bit of background for those not following along:

Up to now, the IIO subsystem has only supported a single scan type per
channel. This scan type determines the binary format of the data in the
buffer when doing buffered reads.

For simple devices, there is only one scan type and all is well. But
for more complex devices, there may be multiple scan types. For example,
ADCs with a resolution boost feature that adds more bits to the raw
sample data. Traditionally, for slow devices, we've just always used the
highest resolution mode, but for high performance ADCs, this may not be
always practical. Manipulating data after every read can hurt performance
and in the case of hardware buffers, it may not be possible to change the
format of the data in the buffer at all. There are also ADCs where
enabling the higher resolution can only be done if oversampling is also
enabled which may not be desireable.

To allow for more flexibility, we would like to add support for multiple
scan types per channel.

To avoid having to touch every driver, we implemented this in a way that
preserves the existing scan_type field. See the "iio: add support for
multiple scan types per channel" the details. The first couple of patches
are just preparation for this.

The last patch shows how to use this new feature in the ad7380 driver
which is still under review at [2].

[1]: https://lore.kernel.org/linux-iio/CAMknhBHOXaff__QyU-wFSNNENvs23vDX5n_ddH-Dw3s6-sQ9sg@mail.gmail.com/
[2]: https://lore.kernel.org/linux-iio/20240501-adding-new-ad738x-driver-v6-0-3c0741154728@baylibre.com/T/#t

---
David Lechner (4):
      iio: introduce struct iio_scan_type
      iio: buffer: use struct iio_scan_type to simplify code
      iio: add support for multiple scan types per channel
      iio: adc: ad7380: add support for multiple scan type

 drivers/iio/adc/ad7380.c          | 185 ++++++++++++++++++--------------------
 drivers/iio/industrialio-buffer.c |  77 +++++++++++-----
 include/linux/iio/iio.h           |  74 +++++++++++----
 3 files changed, 194 insertions(+), 142 deletions(-)
---
base-commit: 32cf3c865729172e67dced11c0b73e658444888a
change-id: 20240507-iio-add-support-for-multiple-scan-types-f4dbcf4c2cb8


