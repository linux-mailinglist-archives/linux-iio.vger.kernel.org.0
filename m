Return-Path: <linux-iio+bounces-23912-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFAFB51026
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 09:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9114A7B372F
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 07:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EA130E0F9;
	Wed, 10 Sep 2025 07:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="IRY2XOy0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A377E30DED5;
	Wed, 10 Sep 2025 07:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491090; cv=none; b=hr/7H07r/gh1KOoWDw78g8LJW5cOb0tR55K/Kcfj1s7autXXEbgXBt7TpAg0Ou2AfkXpZcdBjszOT2wotkTZsFoEaMb121ieuo0ZARmMNZYhUSRBwce5aQtqYfebeFeQYGaf6eNyZinNcDgR8QeTD/HEDHnL2RrqD8vtzNTbzI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491090; c=relaxed/simple;
	bh=eoUFQREILI5LGw6mWOAR37W5Ml7CFlgc4I7tP00kxt8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=btcXzO3q77ph+X4vZ14UGo8Qnqk/oGWjoSk+78a0HtwiSnq3NCLYen0OHRV92URwQLSVfrx+AyGiwEOQKiETuXZUvrP0xkq4o04LngHaWVdcHk1nY8qkWW+Xui6SH81rQglwTUM8Qf6lYS0qBsEFdv8VMCN/acUd1FycSdYrQU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=IRY2XOy0; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3503:4a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 954D5173BE2;
	Wed, 10 Sep 2025 10:57:59 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1757491080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K48oocFyp/T/tDsvdqqFTFaeMiZ+hriXChNAYfcdHQA=;
	b=IRY2XOy0Grv1qMnd4ZusmmDpEJstUf60PssK+qi2Hv1Y/r6ePCbrhHd7z8lflxEqLfVa+9
	KDiB8yR0cKnqNjGIyu0KLMn+ZbeVe4u42bDHzX8UCi/CGZa9RfQCkeB6hnJZ3gCdcGqYkB
	FXZoc5pB+E9pjVLG4K5Qka8s6Mh4S/nmqQCMindJvqjb7zGgV/NkNzH+MVx/Xcg9vlyDav
	rNpKtARlnCRSjBs81nb0a0xJyY7NV38o8nOzvnZ2HyUxOb3WbcZ3GW97cdCK27JP/Gepk1
	fsn1UVyvQ7KN4LqJAZQueA/jOgCkXbYlucrDObxE++265AVzokomlS3/tstjgg==
From: Petre Rodan <petre.rodan@subdimension.ro>
Subject: [PATCH v2 00/14] iio: accel: bma220 improvements
Date: Wed, 10 Sep 2025 10:57:05 +0300
Message-Id: <20250910-bma220_improvements-v2-0-e23f4f2b9745@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFIvwWgC/02OQQ6CMBBFr0JmbUmnAk1dcQ9jTJFBZtGWTJGYE
 O5udeXyveS//B0yCVOGS7WD0MaZUyxgThU8Zh+fpHgsDEabVjtt1RC8MfrOYZG0UaC4ZkVn7Bq
 01lKHUJaL0MTvX/V6KzxJCmqdhfx/C9E1tjE1YuucQrXQKlRLGn3s82sYucS/d4qC4/gAnD6el
 KoAAAA=
X-Change-ID: 20250907-bma220_improvements-e31641777e61
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Petre Rodan <petre.rodan@subdimension.ro>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1932;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=eoUFQREILI5LGw6mWOAR37W5Ml7CFlgc4I7tP00kxt8=;
 b=owEBbQKS/ZANAwAIAc8mmZmETn8wAcsmYgBowS+GKxt4xflVgR9CsMG9EwiiFrzzmbJLUgx3N
 3qfgnbprW6JAjMEAAEIAB0WIQTYCn/BdhUZNew+X6nPJpmZhE5/MAUCaMEvhgAKCRDPJpmZhE5/
 MGBaEACOleXWnApsaPJw1dq3+Qj7EkTTPMfwSunrLVAc9KH52G4yA5rn+zArZLxoCQAjUZJOrci
 3EjwR4uEWgktSphCybZpZ0+Fp/Zkpr/WdvTUq3Fo3EPk/zC3nJZE1yP7/mnkNxwCfk8s16yt3kW
 rZ5+cVJvdFcNQ2d7aqAOo8xNtJCw897pOL8TyQ+pvtgKf+7xuhgunWrlfWhcR4kmtuG0mxRVnVq
 WOroec7DXxGsg4+1vf7DVQ/Vo47zc44Cj/PzFJq4a7Gk6G5g6DF7LpQt9PDxDUmwrpO31Ozdw2j
 e6JQd1hoWaJkQ8KywVcPQ99lXmhmqXQUuYtqhAtNDvd5g6PAA7ZypKqsoRZpH9MNKtTBWqpnuaU
 JjZ42t1NfyqVysJ7QdBhtVjaOlVbGplUTaiH7w0biPViCH9Ixp+aW0pGaf47Ls3VGisWmse99PP
 SWQP3LCXJRj+jUO9CfgHfrxczi5asN3MlNP7Ee0ns95cYmoLV6rdmNyC8JvapflNymjGqe4K4yG
 6kegKu5CCFYPxnWS+ddAZHBRvardqwme6XSy+WdgmyGsOunvBIfAhWmDutK0WeqQiOS5tA0HI7G
 WvDRXrad0+ZXf8IEWh7KhF3iOfj5t62rvHDwVUgNUv1QR5P8nJmI6TKoL5mPI8qkunH0l3TsS5s
 1kFZDzqnJOoXHhg==
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Series of patches that switch the driver to the regmap API and add
i2c connectivity.

Tested in I2C and SPI modes with two different sensors.

Event-related code was skipped since the patch series was getting too
large.

Contains fixes based on feedback from Krzysztof, David and Jonathan.

First time pushing with b4, crossing fingers.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
Petre Rodan (14):
      dt-bindings: iio: accel: bosch,bma220 cleanup typo
      dt-bindings: iio: accel: bosch,bma220 setup SPI clock mode
      dt-bindings: iio: accel: bosch,bma220 change irq type
      iio: accel: bma220: split original driver
      iio: accel: bma220: add open firmware table
      iio: accel: bma220: add get regulator check
      iio: accel: bma220: reset registers during init stage
      iio: accel: bma220: migrate to regmap API
      iio: accel: bma220: add i2c module
      iio: accel: bma220: add i2c watchdog feature
      iio: accel: bma220: add interrupt trigger
      iio: accel: bma220: add LPF cut-off frequency mapping
      iio: accel: bma220: add debugfs reg access
      iio: accel: bma220: add maintainer

 .../bindings/iio/accel/bosch,bma220.yaml           |   9 +-
 MAINTAINERS                                        |   7 +
 drivers/iio/accel/Kconfig                          |  18 +-
 drivers/iio/accel/Makefile                         |   4 +-
 drivers/iio/accel/bma220.h                         |  20 +
 drivers/iio/accel/bma220_core.c                    | 617 +++++++++++++++++++++
 drivers/iio/accel/bma220_i2c.c                     |  61 ++
 drivers/iio/accel/bma220_spi.c                     | 318 +----------
 8 files changed, 757 insertions(+), 297 deletions(-)
---
base-commit: 19dc57d72d2b9365ef185286886c432f980cff55
change-id: 20250907-bma220_improvements-e31641777e61

Best regards,
-- 
Petre Rodan <petre.rodan@subdimension.ro>


