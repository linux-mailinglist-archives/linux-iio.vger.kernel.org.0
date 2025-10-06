Return-Path: <linux-iio+bounces-24786-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 438BCBBECB0
	for <lists+linux-iio@lfdr.de>; Mon, 06 Oct 2025 19:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F9213AEBF2
	for <lists+linux-iio@lfdr.de>; Mon,  6 Oct 2025 17:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8A9243946;
	Mon,  6 Oct 2025 17:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="kmMrA3zb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE8A23E358
	for <linux-iio@vger.kernel.org>; Mon,  6 Oct 2025 17:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759771288; cv=none; b=ezP+kEgSbs9ITYG/GhG16/C0OLidi1SMZJxhRtnXXxwFg/S9GIHdyWu2TtNobh+LeX8wWiEnRIY9QHVcdnQcmQPyX8su9XVpigr234SVo6Srr45o2Ma377HcTnJyR3tLSjgmeHiCZlNYffiE7v/HNJsB0CJZyfewgvWnwBISnaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759771288; c=relaxed/simple;
	bh=sQ0dTUDpQcsZ/weNz6kb6D3WpxLTyfqadGY595z2QaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S9sPtnj3/sUzW1Acr4FTNzUrNzROsSWfI4GLNSp1NWii0py6/46/7jwmpSW9zMy5jhmWVNCCiQNIWL+5H4S3FKHFLn58+6y+7l05wGGF7yKwqFTTtAxhLd5/qf6DS9XljELjbUtDq48kVD9kS05T8XqExgxTLyRP1xXPMAdPisM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=kmMrA3zb; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=E4/V55hzcxf9TE
	tfnexhB26CakGBJUNMUASQiHt/6f4=; b=kmMrA3zbF6+J4+ngcxzKIRXBXxqw/Z
	tgVXN8/YGkoUareNfcDhQ82Xl9HYtd2M7r+wpXdY0R3eLw7kdOSz7rKFMKOJ7S93
	K3Nzj5SuFFu5a+f0oaC4GMKD1zAWB4jg2FV+T/waqgEcr6nJy0k5ySQPEQ5iyQ7F
	s05WsnfvkiS8ACCRIkuXEvkTEBBudzDKUlYvCI9qsPPFC4qSgZ9HleU/FmhBThnc
	7B3ff30HLYdzmuV0o82KJqzCzwE3j59CQh1bQVM8mH4UgPOzP5dNNwMjJUYveKtr
	AbkPrjd2DB3NFGF08Cs3EZKIlSYzDrQyqPveA9B6kUGa4wP8aHmsgnqw==
Received: (qmail 1872438 invoked from network); 6 Oct 2025 19:21:20 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 6 Oct 2025 19:21:20 +0200
X-UD-Smtp-Session: l3s3148p1@B7YRroBAPsUujnsE
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org,
	Rob Herring <robh@kernel.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andy Shevchenko <andy@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	devicetree@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Subject: [RFC PATCH 0/2] another 'interrupts-extended' replacement needed?
Date: Mon,  6 Oct 2025 19:21:16 +0200
Message-ID: <20251006172119.2888-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Rob,

I want to fix the following 'dtbs_check' issue:

arch/arm/boot/dts/renesas/sh73a0-kzm9g.dtb: accelerometer@1d (adi,adxl345): interrupts-extended: [[18, 2, 4], [18, 3, 4]] is too long
	from schema $id: http://devicetree.org/schemas/iio/accel/adi,adxl345.yaml#

However, this series uncovers another place where 'interrupts-extended'
is not recognized as an alternative to 'interrupts'. Namely, when this
is part of a 'dependencies:' like in this binding:

arch/arm/boot/dts/renesas/sh73a0-kzm9g.dtb: accelerometer@1d (adi,adxl345): 'interrupts' is a dependency of 'interrupt-names'
	from schema $id: http://devicetree.org/schemas/iio/accel/adi,adxl345.yaml#

Now, I wonder if this also needs to be fixed in dtschema? Or do we need
another way to express the dependency?

Thanks for any pointers,

   Wolfram


Wolfram Sang (2):
  dt-bindings: iio: accel: adxl345: document second interrupt
  ARM: dts: renesas: kzm9g: name interrupts for accelerometer

 .../bindings/iio/accel/adi,adxl345.yaml          | 16 +++++++++++-----
 arch/arm/boot/dts/renesas/sh73a0-kzm9g.dts       |  1 +
 2 files changed, 12 insertions(+), 5 deletions(-)

-- 
2.47.2


