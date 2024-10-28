Return-Path: <linux-iio+bounces-11475-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B91199B3383
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 15:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FD9A1F228C5
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 14:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726A01DDC13;
	Mon, 28 Oct 2024 14:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="AVB+177H"
X-Original-To: linux-iio@vger.kernel.org
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840AD18C93D;
	Mon, 28 Oct 2024 14:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730125813; cv=none; b=c88n4z7uowoZFLhukMrkXn6FeR5E+fVoRqs2VxD1vgRdPhRtnpOl7Nkc36trVWZ+9U/aBOZIePKaLcRfkMfDxIECrWhrRigXr7/iJAPXD6GMTssdBXv+eTLa5qVYPH/Gy2Yrd/+oEbUaOEB64iU9CUl/vA4YUOBz7E4iXalQEB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730125813; c=relaxed/simple;
	bh=sdstsogHfVVzt/qF2FVu3AhaNVUWpR2HAeKX/JoSshs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZMCAIdVsNmapcun4lDdaEaGo0e122KrCaqVLN0yfB7kkgvIN1KLz8bnX1JLZp6vBooS7uF/lIdh+prXNSnnfPgn3Lz8hsECK5+iZ55tlpFHK+fH5NhruL6Pkq4eEVaslQxW6YHf8EOV/jNutmrMiF1jqvCZXd7iGt7vQ/k9IL+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=AVB+177H; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id 0ADD64C564;
	Mon, 28 Oct 2024 14:21:41 +0000 (UTC)
From: Aren Moynihan <aren@peacevolution.org>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: Aren Moynihan <aren@peacevolution.org>,
	Kaustabh Chakraborty <kauschluss@disroot.org>,
	=?UTF-8?q?Barnab=C3=A1s=20Cz=C3=A9m=C3=A1n?= <trabarni@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ondrej Jirman <megi@xff.cz>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	Dragan Simic <dsimic@manjaro.org>,
	phone-devel@vger.kernel.org
Subject: [PATCH v3 0/6] iio: light: stk3310: support powering off during suspend
Date: Mon, 28 Oct 2024 10:19:54 -0400
Message-ID: <20241028142000.1058149-1-aren@peacevolution.org>
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
	s=dkim; t=1730125303;
	h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding;
	bh=O8RsRfQ0OglbTcLNh0bfBx27J2SnHEfQFA6wmv/Gu7k=;
	b=AVB+177HK9Qd1iMLpM+4bhuIlh+W5zJ0k9Xni0T4R1EpdgmfO27T9W+uRd7xZWcMQn1Umk
	eBOM/iW098j9le51t7XRoFHmU0h8egOB+38mmvB8050DsIcJnp/DyEcpwyx4p2IhRx7Q0X
	F2Ni2tmH1dq7ve0XTTiY5Up5GMew57U=

In the Pine64 PinePhone, the stk3310 chip is powered by a regulator that is
disabled at system boot and can be shut off during suspend. To ensure that
the chip properly initializes, both after boot and suspend, we need to
manage this regulator.

Additionally if the chip is shut off in suspend, we need to make sure that
it gets reinitialized with the same parameters after resume.

Major changes in v3:
 - Use bulk regulators instead of two individual ones
 - Replace stk3310_remove with devm callbacks
 - Hopefully I haven't missed anything, it's been a while since I worked on this
   patch, and I didn't take good enough notes

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
 drivers/iio/light/stk3310.c                   | 156 +++++++++++++-----
 3 files changed, 118 insertions(+), 44 deletions(-)

-- 
2.47.0


