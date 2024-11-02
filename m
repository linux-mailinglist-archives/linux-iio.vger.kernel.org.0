Return-Path: <linux-iio+bounces-11854-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FA69BA235
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 20:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C77E282337
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 19:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2CD1AB51B;
	Sat,  2 Nov 2024 19:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="Tzc7jf7/"
X-Original-To: linux-iio@vger.kernel.org
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE2A1A4E9E;
	Sat,  2 Nov 2024 19:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730577277; cv=none; b=sP9+3Y/qoJdOAgO9wNYOsMei/UuYftr1JH9TO4YOXzcJds044OmuoQwgsssdUVW/XoOCk59RjYDkdnI/B3FbjabZX1mbJohFbsVX6GgGHI3AV3xdykFBh0DBMv7/d1sPRdlx35Dj0WPBR2EQTKdtdjYOqyH0Qjo6iDecoWnjOPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730577277; c=relaxed/simple;
	bh=EvtA0L6i7PVpTUXFS8v/MeTEdxw2Y5yqzQ012t++dO8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gR0/DSCPK6PeZp7gi1VjVfMsBN95Z4Us6POlr1LvGJNHvMfPbjZCzBehxUTHvM2dkKtydGWVaXh119idcSHYoXvlRV+LsHYkoxPLyo2KNjeYUXwIIOn9/4fH/YEreiByDIcJNQbJRX3JaGJEyFuGQk0CG3TJC8ykIFb8tVux/no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=Tzc7jf7/; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id AC5EF4C845;
	Sat,  2 Nov 2024 19:54:26 +0000 (UTC)
From: Aren Moynihan <aren@peacevolution.org>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: Aren Moynihan <aren@peacevolution.org>,
	Kaustabh Chakraborty <kauschluss@disroot.org>,
	=?UTF-8?q?Barnab=C3=A1s=20Cz=C3=A9m=C3=A1n?= <trabarni@gmail.com>,
	Ondrej Jirman <megi@xff.cz>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	Dragan Simic <dsimic@manjaro.org>,
	phone-devel@vger.kernel.org
Subject: [PATCH v4 0/6] iio: light: stk3310: support powering off during suspend
Date: Sat,  2 Nov 2024 15:50:33 -0400
Message-ID: <20241102195037.3013934-3-aren@peacevolution.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
X-Spam-Level: ****
X-Spamd-Bar: ++++
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1730577268;
	h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding;
	bh=G68ZaVveeAPDy61zCvgR6ZvWngMfCpzqwzzHizbuydU=;
	b=Tzc7jf7/YcxSmOknbQHGUntcT+2BmHXa6PKRE5Wi0BLJKcBuya7pa2msevfer6Ii9LupZQ
	8ZRP4N3ShUjjF1/anXp3sGNM7Vs/RAFgIZLYNz/cj46M2bbucjlHbDYwslM0zJVkscVh+X
	7C3j+jd96ZG7dEYMS3rRQqPYmiSs+oI=

In the Pine64 PinePhone, the stk3310 chip is powered by a regulator that is
disabled at system boot and can be shut off during suspend. To ensure that
the chip properly initializes, both after boot and suspend, we need to
manage this regulator.

Additionally if the chip is shut off in suspend, we need to make sure that
it gets reinitialized with the same parameters after resume.

Major changes in v4:
 - replace mutex_init with devm_mutex_init
 - code style cleanup

Major changes in v3:
 - Use bulk regulators instead of two individual ones
 - Replace stk3310_remove with devm callbacks

Major changes in v2:
 - Add handling of the IR LED. I was hesitant to include this as it is the
   same as pull-up regulator for the i2c bus on the hardware I have, so I
   can't test it well. I think leaving it out is more likely to cause
   issues than including it.
 - Convert stk3310 to use dev_err_probe for errors.
 - Always enable / disable regulators and rely on dummy devices if they're
   not specified.
 - more listed in individual patches

Aren Moynihan (5):
  dt-bindings: iio: light: stk33xx: add vdd and leda regulators
  iio: light: stk3310: handle all remove logic with devm callbacks
  iio: light: stk3310: Implement vdd and leda supplies
  iio: light: stk3310: use dev_err_probe where possible
  iio: light: stk3310: log error if reading the chip id fails

Ondrej Jirman (1):
  arm64: dts: allwinner: pinephone: Add power supplies to stk3311

 .../bindings/iio/light/stk33xx.yaml           |   4 +
 .../dts/allwinner/sun50i-a64-pinephone.dtsi   |   2 +
 drivers/iio/light/stk3310.c                   | 162 ++++++++++++------
 3 files changed, 120 insertions(+), 48 deletions(-)

-- 
2.47.0


