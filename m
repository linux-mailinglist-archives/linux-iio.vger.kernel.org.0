Return-Path: <linux-iio+bounces-8453-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B593950B63
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2024 19:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D4061C21D7F
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2024 17:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DE51A257C;
	Tue, 13 Aug 2024 17:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qXayL9XZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A6E1A255A
	for <linux-iio@vger.kernel.org>; Tue, 13 Aug 2024 17:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723570010; cv=none; b=Us3UuGujR/pHrmJkmH3Vw1fxhr/B6G3EOPQWQyFcGIqGsT2k1jRem4bf8iGF+HCx//MIXc0G4KB8a9n5CoWgmqrCWbfa9ugPX3c0/2nUmb+ay03Ssud07tDrqx+wNmWWGCzMvXx4NOSkbCnKd64FwyedvGSmENAv8uBYpY0WOxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723570010; c=relaxed/simple;
	bh=ZzTceNq/VahFThxcoefiMSTMiJCAPq1LHWua5OwiDXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bX9uZK6ZxX3vhgDpV923arwGKloMov2O32BE0nt2Vsa2mBOs4FZZhw85KK5tnkxgcNOeflnjy5wsuE4vvrJXUbwYReulks+fU5+mrBpAzBn0TtAIT/puwhsniqCA95VkwFTQB00H7+51wSAS9dPgVqGt5nrdKQ05QhoMsmMT/i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qXayL9XZ; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2642cfb2f6aso4184571fac.2
        for <linux-iio@vger.kernel.org>; Tue, 13 Aug 2024 10:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723570008; x=1724174808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xG6x5j0C9GwdQm5O0YJQ35HAaRtvKzSD7igQqCAZy5g=;
        b=qXayL9XZsDlKOg5GtGZIGosNDrqOdGVcBnMl7PE9F8LwdX7N5KbyRV8hqgeqW5/Nxq
         2et2S1cL24TuftNYhMarGAZ8PqtEdvFSRiBN46K4oAGT4c+v69lNDNapHcYFugZlwljR
         Iuh9xPpVyvUSczOidxAAvWeALUj0UVOwgIoOG8xXuVJWhPWg7FbSxVY+yxNd4F3GYAGf
         qiSk1jnDSwcdcrBrJxQWF2ii1J22hHAG1IM2p/+d5iDCLwPIoVcBlt8t7OURqSU6DAQw
         /PODmFv9xpTAY2xPp7cGXYho03qyvQF87QmtgF3RR0+JGkzY5ydvMOl0qmUQZbIzunLm
         h2/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723570008; x=1724174808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xG6x5j0C9GwdQm5O0YJQ35HAaRtvKzSD7igQqCAZy5g=;
        b=cJut/GwiCKKkvqP1HWUCDvk7JL46wyks6juw3Rv5YghL4x3XtdwOUdHz+LA+wglAy1
         lAxBvc6Wtd4A0JFulTfBuyYBpjxAbZMJ48ybPGjgHVjMX5mqdp+2hhho4oVUmrnaW3gG
         52uU0WNaOufEr/CMYvDdqpRT5NH1MgnuxUDT7c7PjVP60Q/xvwMpPdXrAr83Xm9YHejn
         mq1jTyg8JxV/DB+rKIaYT//XyyBZ+PYoKrSlCZ0/SZUb2HMyWQ6pkUBYPp1pnvUeOmeY
         tlQJhSpvrS9vM8b99dieNzJnoyjPXvo+ZtOo4L6X4ppPsQDGj68ZSsdESFvg2sB7/wGI
         nKOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJ4osgjxtcTUsuM+24m0Z6NidbBdAnLE+SeRKt866asQ3HaYrmR3ok6EwdarKRgPNESJiEVh+RA/WJ2HlgT/OV6S4J8z9x+hhz
X-Gm-Message-State: AOJu0Yw2oByFBTkQTrfzNvnzEH2Hhxjago44qNsmz+P97sJvKg9pbJlL
	rgF7uFWZynmVV8IbxmV9Nlli8Mb+hsBfBpDsYvfxoHm3pookgqW/K1EHw96bMSg=
X-Google-Smtp-Source: AGHT+IE7cQzWLO3jWd3KSSFLMOSIEVFhEv2EfjOn346VEcwYYVn943aDI4d7Fs3uIL/ohjzsEiDG9w==
X-Received: by 2002:a05:6870:972b:b0:25e:24d5:4d54 with SMTP id 586e51a60fabf-26fe5bb98afmr324787fac.35.1723570007899;
        Tue, 13 Aug 2024 10:26:47 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-26c7203f908sm2462915fac.11.2024.08.13.10.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 10:26:47 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 0/2] iio: adc: ad4695: implement triggered buffer
Date: Tue, 13 Aug 2024 12:26:39 -0500
Message-ID: <20240813-iio-adc-ad4695-buffered-read-v2-0-9bb19fc1924b@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.0
Content-Transfer-Encoding: 8bit

This is a fairly simple series that adds support for triggered buffers
to the ad4695 driver.

Not directly related to this patch, but as a side discussion about
future possibilities with this chip while we are here...

The advanced sequencer on this chip can repeat the same channel multiple
times which, when combined with the autocycle feature, can be used to
create different effective sampling rates for individual channels.

For example if we set up the sequence [IN1, IN2, IN1, IN3] and the time
between each individual sample in the sequence is the same, then IN1 has
an effective sampling rate of 2x the other channels.

Have there ever been discussions before about implementing something
like this in the IIO subsystem? I didn't see anything that looked like
this already implemented in the kernel.

---
Changes in v2:
v2 changes:
* Don't error when only temperature channel is enabled, just add extra
  xfer instead.
* Drop use of reg/mask/val local variables.
* Use struct initializer for xfer in ad4695_exit_conversion_mode().
* Simplify return at end ad4695_buffer_preenable().
* Use t_ACQ instead of t_CNVL to ensure proper acquisition time.
* The temperature channel changes weren't quite trivial, so I didn't
  pick up Nuno's Reviewed-by.
* Link to v1: https://lore.kernel.org/r/20240807-iio-adc-ad4695-buffered-read-v1-0-bdafc39b2283@baylibre.com

---
David Lechner (2):
      iio: adc: ad4695: implement triggered buffer
      doc: iio: ad4695: document buffered read

 Documentation/iio/ad4695.rst |   9 +-
 drivers/iio/adc/ad4695.c     | 250 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 255 insertions(+), 4 deletions(-)
---
base-commit: d505a9dc8de83df2a8ce8c9e780f7b29887f34af
change-id: 20240807-iio-adc-ad4695-buffered-read-f49eb511e300

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


