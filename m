Return-Path: <linux-iio+bounces-22525-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D07E9B1FBCE
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 20:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1CB91892971
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 18:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81A11FBEB6;
	Sun, 10 Aug 2025 18:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stromeko.de header.i=@stromeko.de header.b="NbWwCQUY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp4.goneo.de (smtp4.goneo.de [85.220.129.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60901EDA0F
	for <linux-iio@vger.kernel.org>; Sun, 10 Aug 2025 18:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.129.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754852362; cv=none; b=mW6uL/CrErOoqqzLnM57tH15BShHR5PLpdFOufVyUUEwxJoxGW0KxFLpQHQoIvtkGOZ9/iDhfdOrrKFLCFq1kH7ic1lNBOW1+WTQGZUMVsooRHvPDxczqqH6T5ki0uF+7YltlS2a1RWFZeTZMo2VcEbKyyUf5k1BDboDIBvrPSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754852362; c=relaxed/simple;
	bh=htY5xxUVitN5O79vmVM3/YBMn1BazPoesANcFfCWqpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SN3k7gphAfUEogg/XOmyN0e0272Uxu+5GLXe9mDiSKIyqR6ybZuRbAd2qztpeF5QFGYDZ0byDQbbbbBdCDdJv9BbzC9nxn7RW/TyrzHqiq/DmzMib2saJO5ZGYvY5uVZG8qU7JtzbnLI9dK/xN0+NSlPs8b7jWB2o/VO5eyp2qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Stromeko.DE; spf=pass smtp.mailfrom=Stromeko.DE; dkim=pass (2048-bit key) header.d=stromeko.de header.i=@stromeko.de header.b=NbWwCQUY; arc=none smtp.client-ip=85.220.129.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Stromeko.DE
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Stromeko.DE
Received: from hub2.goneo.de (hub2.goneo.de [85.220.129.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp4.goneo.de (Postfix) with ESMTPS id A06CB2405BD;
	Sun, 10 Aug 2025 20:59:10 +0200 (CEST)
Received: from hub2.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPS id 0ED3A24026C;
	Sun, 10 Aug 2025 20:59:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stromeko.de; s=DKIM001;
	t=1754852349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2tPu6b7lP1v/xpgemD71tmomH0AKFGFY1WxKRKokjkc=;
	b=NbWwCQUYUbsDe1+n1Mjp5DJDjhTwQfD10Zr58wcovV5jbyhx6TTgooYJZxXyzIRPcpdOyo
	DWd3uNGRSiB55Adpg3whsvVInVkP9te7yS7E0fYjuITfHJB3PnBL35UklyjNpvKB/618yi
	u6Hp9Hz1quJjArW7TpOhhw8YJ3zfQbtQMNB4Go3NO1t3JI8yc/QaaBIaiBfNQdRxefiWzj
	Aao2pW+LbgtE2WMvIWTZit2L9AGFdtq74GchaN4xiCa9RTioiD9nlSIpJ+Di/RQc/ps5zm
	I2WBqljlpPJumgWnx1vJqNcio3bk7NPoAyiratEDMct7E0ahfEOy9VGhZpKokQ==
Received: from Gerda.fritz.box (p54a0c448.dip0.t-ipconnect.de [84.160.196.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPSA id B4473240195;
	Sun, 10 Aug 2025 20:59:08 +0200 (CEST)
From: Achim Gratz <Achim.Gratz@Stromeko.DE>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Achim Gratz <Achim.Gratz@Stromeko.DE>
Subject: [RFC PATCH v2 0/9] Fixes and enhancements for the bmp280 driver
Date: Sun, 10 Aug 2025 20:58:37 +0200
Message-ID: <20250810185846.114355-1-Achim.Gratz@Stromeko.DE>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20241017233022.238250-1-vassilisamir@gmail.com>
References: <20241017233022.238250-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: cd7416
X-Rspamd-UID: 679d61

Revision History:
=================

v1:
	- initial proposal, incorrectly prefixed "bmp280" instead of "RFC PATCH"
	- patch series presented in the order it was created

v1 -> v2:
	- prefix as "RFC PATCH"
	- drop channel switching
	- rewrite to present patches in smaller units and in logical steps

With v6.13 a change was made to the bmp280 drivers to use MODE_FORCED
instead of MODE_NORMAL.  This broke userspace functionality: reading
from sysfs interfaces no longer worked and an error was thrown
"Measurement cycle didn't complete".  This series fixes the underlying
bugs affecting the measurement time calculation and implements
additional functionality not available for the BMx280 devices
previously to allow the use of the sysfs interface in MODE_NORMAL
again and control the corresponding parameters.  The implementation
follows the already existing facilities for the BMx[35]80 devices even
though the actual functionality of the BMx280 devices is slightly
different.

Achim Gratz (9):
  iio: pressure: bmp280: correct meas_time_us calculation
  iio: pressure: bmp280: implement adaptive wait for BMx280 devices
  iio: pressure: bmp280: implement adaptive wait for BMP380 devices
  iio: pressure: bmp280: refactoring
  iio: pressure: bmp280: remove code duplication
  iio: pressure: bmp280: enable filter settings for BMx280
  iio: pressure: bmp280: implement sampling_frequency for BMx280
  iio: pressure: bmp280: implement sampling_frequency calculation for
    BMx280
  iio: pressure: bmp280: test longer autosuspend (WIP)

 drivers/iio/pressure/bmp280-core.c | 350 +++++++++++++++++++++++------
 drivers/iio/pressure/bmp280.h      |  22 ++
 2 files changed, 300 insertions(+), 72 deletions(-)

---

Comments:

Thanks for allo the comments on my v1 patch series.  I have not seen
any reaction to my on-list replies however, so it appears y'all are
expecting to Cc: everyone involved?

I've just seen new responses from James, but these are not taken into
account for v2 obviously.

The dropped channel switching code may be revisited / resurrected at a
later time.  However it can not fully achieve what I want anyway for
how I use the sensor and the later implemented controls for several
sensor parameters get the desired performance back.

The remaining sticky point is the control of the autosuspend delay.
If the sensor is suspended between measurements, then even when it is
operating in MODE_NORMAL, an additional latency of 12…15ms is incured
when the interval between measurements is long enough to trigger
autosuspend.  I have set the hardcoded value to 2s as a test (see the
last patch in the series) and this additional latency vanishes,
interestingly also the tailing to long measurement times I have
observed otherwise is also much reduced.  However so far I've not come
up with an idea of how to control the autosuspend delay from
userspace, to wit:

 /sys/bus/iio/devices/iio:device0/power/async: disabled
 /sys/bus/iio/devices/iio:device0/power/autosuspend_delay_ms:
 '/sys/bus/iio/devices/iio:device0/power/autosuspend_delay_ms': Input/output error
 /sys/bus/iio/devices/iio:device0/power/control: auto
 /sys/bus/iio/devices/iio:device0/power/runtime_active_kids: 0
 /sys/bus/iio/devices/iio:device0/power/runtime_active_time: 0
 /sys/bus/iio/devices/iio:device0/power/runtime_enabled: disabled
 /sys/bus/iio/devices/iio:device0/power/runtime_status: unsupported
 /sys/bus/iio/devices/iio:device0/power/runtime_suspended_time: 0
 /sys/bus/iio/devices/iio:device0/power/runtime_usage: 0
 -rw-r--r-- 1 root root 4096 Aug 10 18:41 async
 -rw-r--r-- 1 root root 4096 Aug 10 18:41 autosuspend_delay_ms
 -rw-r--r-- 1 root root 4096 Aug 10 18:41 control
 -r--r--r-- 1 root root 4096 Aug 10 18:41 runtime_active_kids
 -r--r--r-- 1 root root 4096 Aug 10 18:41 runtime_active_time
 -r--r--r-- 1 root root 4096 Aug 10 18:41 runtime_enabled
 -r--r--r-- 1 root root 4096 Aug 10 18:41 runtime_status
 -r--r--r-- 1 root root 4096 Aug 10 18:41 runtime_suspended_time
 -r--r--r-- 1 root root 4096 Aug 10 18:41 runtime_usage

…which according to the kernel documentation is due to a lack of
unspecified support from the driver.  Now, it appears I should be able
to switch off autosuspend altogether by changing control from "auto"
to "on", but that doesn't seem to take effect; also I'd rather
configure a sensible value in accordance to my measurement settings.
The other handful of IIO drivers I've looked at that set this
parameter don't do things differently, so I don't know if there's
anything that can be done about it.

-- 
2.50.1

