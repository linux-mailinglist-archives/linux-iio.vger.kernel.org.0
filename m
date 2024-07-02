Return-Path: <linux-iio+bounces-7149-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8751A92430D
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 18:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9FD31C221FA
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 16:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BC81BD01D;
	Tue,  2 Jul 2024 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYrDe9UN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711FD1BB6AF;
	Tue,  2 Jul 2024 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719936159; cv=none; b=JbkiK1NdeVaDJpMK/5SPWuHiyMm0sAZy7JquaMFb+Gz+TFsFNMY2SBnnDxt1W1vfIXNexdlxWFVm9l0mpRGjYnaq0e/kWfUxp/1owAASQ2ftlScODXohNNyXoIzlismWfkiwO5o9NOXNLyQlebv3XLIEHzFgTkVd8+V9JRt7yIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719936159; c=relaxed/simple;
	bh=dYNF6iO2wfFDcJE7eHk31m6ISxbwFVT9boKTTNa+uX8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KzBv+k5U2X6R+6pZmZ2+ozKTGCBUpxmevOmq4NrPkrshpidMXNcfVGGf31N/47gXVHXLR76lldf9eIdDkxPiyqJqoKa7DY2d7qQyKwBI//SURR0G1gTUlgOMPkAegLIH8V2xhSkEuXapd9OG6gVpWKE43/XSUZn5jsiCoYC0yek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYrDe9UN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00F4BC116B1;
	Tue,  2 Jul 2024 16:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719936159;
	bh=dYNF6iO2wfFDcJE7eHk31m6ISxbwFVT9boKTTNa+uX8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=DYrDe9UN8GXF4R7V+2IiyMjOK2AIDleqAEjzHHEe192U90WmoqDZlbGeMbJPy+RG+
	 3ixghLFszYs+U6DA9vctptEj6mS84LRcl4D+ZD3Cc97zJlYdfFfupAlucndYXksChp
	 v85x1061KfhxBrUIGaXGHCO6pvi6q6GkYAZ0KOActlodmmFgOemCw5wIxuAv4L1W0D
	 AdMb4TcWuxIHnigYeK97/Acsvp81caZajOQKnFNqlU5pT3vp1EmfUcpv/iZaMMdAxW
	 H1lnTJ2TAkvDTgWZ4zojESnxjxLpzrqOr442tfwTpkDWG3cmFXjECPfa+lydwXJKzG
	 z98uYjngXIqRg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD40C3064D;
	Tue,  2 Jul 2024 16:02:38 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH 00/20] iio: make masklength __private (round 1)
Date: Tue, 02 Jul 2024 18:02:32 +0200
Message-Id: <20240702-dev-iio-masklength-private-v1-0-98193bf536a6@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJgkhGYC/x3MSw5AMBAA0KvIrE1SRX2uIhbFYIKSVhpJ4+4ay
 7d5ARxZJgdtEsCSZ8enicjSBMZVm4WQp2iQQhZCZRVO5JH5xEO7bSez3Ctelr2+CYXMx0E2pa5
 qBTG4LM38/HnXv+8H5PZxCGwAAAA=
To: linux-iio@vger.kernel.org, chrome-platform@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Cosmin Tanislav <cosmin.tanislav@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 Dmitry Rokosov <ddrokosov@sberdevices.ru>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719936156; l=3395;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=dYNF6iO2wfFDcJE7eHk31m6ISxbwFVT9boKTTNa+uX8=;
 b=dYayS/sYzYBMk3LDN5MD+QUI9w92ZbUDruyAqtEdvLcUf2ukXZglMWK/T9YrXjvcpEoybuZez
 o4HfrGK/hPaBZK9VUZnwEcX3u3uaHqvVLIvaotmLg8apkuK8x2WJA0s
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

Hi Jonathan,

Here it goes the first round of what we discussed in [1] about
annotating .masklength as __private. Patches should be fairly simple so
hopefully I did not messed up much...

Note that in core, there's one place where we're still directly writing
into .masklength (when it's effectively set). The plan is then to
directly use ACCESS_PRIVATE() in there in the same patch where we mark
.masklength as __private.

Note this was only compile tested for arm with allyesconfig.

[1]: https://lore.kernel.org/linux-iio/20240612-dev-iio-scan-private-v1-0-7c75c8e3d30b@analog.com/

---
Nuno Sa (20):
      iio: core: add accessors  'masklength'
      iio: core: make use of iio_get_masklength()
      iio: buffer: make use of iio_get_masklength()
      iio: accel: adxl367: make use of iio_get_masklength()
      iio: accel: adx1372: make use of iio_get_masklength()
      iio: accel: bma180: make use of iio_for_each_active_channel()
      iio: accel: bmc150-accel-core: make use of iio_for_each_active_channel()
      iio: accel: cros_ec_accel_legacy: make use of iio_get_masklength()
      iio: accel: fxls8962af-core: make use of iio_for_each_active_channel()
      iio: accel: msa311: make use of iio_for_each_active_channel()
      iio: accel: sca3300: make use of iio_for_each_active_channel()
      iio: accel: stk8312: make use of iio_for_each_active_channel()
      iio: accel: stk8ba50: make use of iio_for_each_active_channel()
      iio: adc: ad7266: make use of iio_get_masklength()
      iio: adc: ad7298: make use of iio_get_masklength()
      iio: adc: ad799x: make use of iio_get_masklength()
      iio: adc: ad_sigma_delta: use new '.masklength' accessors
      iio: adc: at91_adc: make use of iio_for_each_active_channel()
      iio: imu: adis16475: make use of iio_for_each_active_channel()
      iio: imu: adis16480: make use of iio_for_each_active_channel()

 drivers/iio/accel/adxl367.c                   |  2 +-
 drivers/iio/accel/adxl372.c                   |  2 +-
 drivers/iio/accel/bma180.c                    |  3 +-
 drivers/iio/accel/bmc150-accel-core.c         |  3 +-
 drivers/iio/accel/cros_ec_accel_legacy.c      |  2 +-
 drivers/iio/accel/fxls8962af-core.c           |  3 +-
 drivers/iio/accel/msa311.c                    |  3 +-
 drivers/iio/accel/sca3300.c                   |  3 +-
 drivers/iio/accel/stk8312.c                   |  3 +-
 drivers/iio/accel/stk8ba50.c                  |  3 +-
 drivers/iio/adc/ad7266.c                      |  3 +-
 drivers/iio/adc/ad7298.c                      |  3 +-
 drivers/iio/adc/ad799x.c                      |  3 +-
 drivers/iio/adc/ad_sigma_delta.c              |  6 ++--
 drivers/iio/adc/at91_adc.c                    |  4 +--
 drivers/iio/buffer/industrialio-buffer-cb.c   |  2 +-
 drivers/iio/buffer/industrialio-hw-consumer.c |  4 +--
 drivers/iio/imu/adis16475.c                   |  3 +-
 drivers/iio/imu/adis16480.c                   |  2 +-
 drivers/iio/industrialio-buffer.c             | 50 ++++++++++++---------------
 drivers/iio/industrialio-core.c               |  2 +-
 include/linux/iio/iio.h                       | 18 ++++++++++
 22 files changed, 67 insertions(+), 60 deletions(-)
---
base-commit: 21ab030b8f8b4704c299435e167824ec90c8bab5
change-id: 20240617-dev-iio-masklength-private-023cb295a786
--

Thanks!
- Nuno Sá



