Return-Path: <linux-iio+bounces-24542-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF65BA7579
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 19:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A5E116ABAF
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 17:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673A4239E76;
	Sun, 28 Sep 2025 17:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stromeko.de header.i=@stromeko.de header.b="OImYJ04S"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp4.goneo.de (smtp4.goneo.de [85.220.129.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2575D2222A9
	for <linux-iio@vger.kernel.org>; Sun, 28 Sep 2025 17:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.129.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759080940; cv=none; b=Zf/l7eCrCnmRcjIBj2585UPUShVHNQJ6GE0zDG5rq9R1O/flKkxd1+IMbljQZ74T6BQVWmoUiFFIwOgbEqxMcgR8LFfN5MbYo9DfFYwFjRm1X719LcTxHpSbOy7EEwhs/jBvs9ui0lP/tPPglzt7LOAZe6PYR22B+aeo8kOWb0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759080940; c=relaxed/simple;
	bh=a/WYmFGkC122+N0OjRYiGtYsXsYOHP4w5vKB2tgVQv4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z/6JxizYtLkOwogwiMz3xGdWeuToTxScnqr11kmGXLgqIBd/e9UKwksqiNPlhu7cU2IplwPLUV9vd5058PSNE3SDdwHiZL7VrfizTN85ThVluF5H8eslpJ9pTf27dirW0Y1NwPtinOTW3w12qX+RB4Ss6PG124ZqVTPY1KDGaLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Stromeko.DE; spf=pass smtp.mailfrom=Stromeko.DE; dkim=pass (2048-bit key) header.d=stromeko.de header.i=@stromeko.de header.b=OImYJ04S; arc=none smtp.client-ip=85.220.129.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Stromeko.DE
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Stromeko.DE
Received: from hub1.goneo.de (hub1.goneo.de [85.220.129.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp4.goneo.de (Postfix) with ESMTPS id 622EA240707;
	Sun, 28 Sep 2025 19:27:20 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPS id C3AFC240165;
	Sun, 28 Sep 2025 19:27:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stromeko.de; s=DKIM001;
	t=1759080438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rpx0PDdi2DKCjXoPe9Zhi6rxoVyuARp8l5VPb/ZES30=;
	b=OImYJ04SSNKj1xY9+oxm5lFGHZEkTAEtRksXxnwvDMa50RCES08EDF9uv8ADOhlvwsApfr
	KnndQtequRdvmZvcy7dfoIwKzO+XZ/0hhA7ENmuh82nXg/cQT/RhDP3k++EYaqlTefxYoT
	0upXnGj1fwRltPZOnKhnlqSRPB/QGFAoIRSwmxIhCPrA1yJTG/7n3FfWlz71j9j5TV75ms
	RU3Ho7k6hfQFMo+J1wHpDLMysF0fbrMyl4E15Cu2iJ0vhvWt8kxgyeWDBLbbTCNPKLVkaE
	IlQV76iA+7iw+i71Nuy3K1mtKoIpgqRLi9h9GfJS0rBSvq0s9rV14qCzr+FegA==
Received: from Gerda.fritz.box (p5b2f36f7.dip0.t-ipconnect.de [91.47.54.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPSA id 7851B2400FE;
	Sun, 28 Sep 2025 19:27:18 +0200 (CEST)
From: Achim Gratz <Achim.Gratz@Stromeko.DE>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Achim Gratz <Achim.Gratz@Stromeko.DE>
Subject: [RFC PATCH v3 0/9] Fixes and enhancements for the bmp280 driver
Date: Sun, 28 Sep 2025 19:26:27 +0200
Message-ID: <20250928172637.37138-1-Achim.Gratz@Stromeko.DE>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: 009ef4
X-Rspamd-UID: 00556f

Revision History:
=================

v1:
	- initial proposal, incorrectly prefixed "bmp280" instead of "RFC PATCH"
	- patch series presented in the order it was created

v1 -> v2:
	- prefix as "RFC PATCH"
	- drop channel switching
	- rewrite to present patches in smaller units and in logical steps

v2 -> v3:
	- incorporate comments/suggestions on v2
	- clean up

With v6.13 a change was made to the bmp280 drivers to use MODE_FORCED
instead of MODE_NORMAL.  This broke userspace functionality: reading
from sysfs interfaces no longer worked and an error was thrown
"Measurement cycle didn't complete".  This series fixes the underlying
bugs affecting the measurement time calculation (patches 0001 through
005) and implements additional functionality (patches 0006 through
009) not available for the BMx280 devices previously to allow the use
of the sysfs interface in MODE_NORMAL again and control the
corresponding parameters.  The implementation follows the already
existing facilities for the BMx[35]80 devices even though the actual
functionality of the BMx280 hardware is slightly different.

Achim Gratz (9):
  iio: pressure: bmp280: correct meas_time_us calculation
  iio: pressure: bmp280: implement adaptive wait for BMx280 devices
  iio: pressure: bmp280: implement adaptive wait for BMP380 devices
  iio: pressure: bmp280: rename wait_conv() to conv(), factor out
    measurement time calculation
  iio: pressure: bmp280: remove code duplication
  iio: pressure: bmp280: enable filter settings for BMx280
  iio: pressure: bmp280: implement sampling_frequency for BMx280
  iio: pressure: bmp280: implement sampling_frequency calculation for
    BMx280
  iio: pressure: bmp280: test longer autosuspend (WIP)

 drivers/iio/pressure/bmp280-core.c | 504 +++++++++++++++++++++--------
 drivers/iio/pressure/bmp280.h      |  26 +-
 2 files changed, 387 insertions(+), 143 deletions(-)

-- 

Comments:

Thanks for all suggestions and comments on my v1 and v2 patch series.

I've not had time to work on the suggested further changes to the
implementation, to recap that would entail implementing the
*_available attributes and completely reworking the handling of the
ODR and filter settings to better conform to the API:

	1. A list of available values for each setting should be
          associated via the *_available attribute (since these are a
          fixed number for each parameter due to the register
          mapping);

	2. Available output data rate settings would be variable
          depending on the OSR (at the moment the setting is fixed,
          but the reading is variable);

	3. Filter settings would be done by 3dB corner (either real or
          normalized frequency) instead of the divisor (bitshift)
          applied to produce the decay value of the underlying
          recursive IIR.

Anything from 2. on would break userspace (again), but make the
implementation more conformant with the API.  I think there needs to
be more discission of how to re-structure the code to support this:
the current static tables would become really large, however setting
dynamic calculations up so that the small number of valid register
values can get extracted would be rather complex and error-prone.  So
it is likely there should be some combination of both approaches used.


The remaining sticky point is the control of the autosuspend delay
(patch 0099).  If the sensor is suspended between measurements, then
even when it is operating in MODE_NORMAL, an additional latency of
12…15ms is incured when the interval between measurements is long
enough to trigger autosuspend.  I have set the hardcoded value to 2s
as a test (see the last patch in the series) and this additional
latency vanishes, interestingly also the tailing to long measurement
times I have observed otherwise is also much reduced.  However so far
I've not come up with an idea of how to control the autosuspend delay
from userspace, to wit:

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
anything that can be done about it from within the driver
implementation.


