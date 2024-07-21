Return-Path: <linux-iio+bounces-7766-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D4E93844B
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jul 2024 12:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A49C6B20E91
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jul 2024 10:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D0E156C63;
	Sun, 21 Jul 2024 10:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Nr+QFmvn"
X-Original-To: linux-iio@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1C515667B;
	Sun, 21 Jul 2024 10:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721556965; cv=none; b=nZ0zvURfBk6tAZ0DXkdQrUrfCqw2utaUFAvVt/EH7graffhv/wCVN2NKpzhhXX9tztqaoLtnLnRcvsfLIfBf5fCRzckALxaUWz+FZ8dGVS5JnTxTN6mOydcG5kF2XDSvNqK6u2oM1734YaQV2o1lUDfpTSlsDA3c6BGrLM4kFFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721556965; c=relaxed/simple;
	bh=nlwMgdDh72Yy3m0/MxrsPqPbdxmP17LFKy0FuK0GHY8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VS74VOibt0wB5yrvw2qQm8yr1ktyoV2w7e/CT7KfVPqS6PGnlPjmpmPnGbTxGYtQkkRfmzaWLRiivrlYDE6eGURI9/S3Myj27ZzlHhR59d445ENsriN386H/YQxqVzBP0MWVayi359jHpuGMykKDiJb1+Vv19h/0v9BoYu4Vb4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Nr+QFmvn; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from localhost (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 53FF041A6C;
	Sun, 21 Jul 2024 12:15:54 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
	by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1mgW2OmlWPGU; Sun, 21 Jul 2024 12:15:53 +0200 (CEST)
From: Kaustabh Chakraborty <kauschluss@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1721556953; bh=nlwMgdDh72Yy3m0/MxrsPqPbdxmP17LFKy0FuK0GHY8=;
	h=From:Subject:Date:To:Cc;
	b=Nr+QFmvnI65K1NfdN6Bj4WEBdkhVPnTFJhKA2dFwIcd4eg4LDogKCcyJ3jyvYYYsj
	 YKhmYcTjglit245dIV5CRh/3CZSgcIH+TwHDgvADqEd0nHJxWV4Pe4LMjAwue85vK8
	 sN1nWLzMUiMFWSSLu00caghNWMDDfELcZn+3TpvjqdX7nPgdEZ3bZxtdygg2IS/pFC
	 Tb4Ok1hGdHrLrLdwRqdTFc/YIRCt9T2O5RMnw7BR6btcyHkn3IcqJe+tGPQAeMRdSz
	 B2hGzIaSU2S2zgh1yn22AFOBb+TYPgjI0+jFKluxd4JgM0RKK4MLFbQHGKpA7EEzEp
	 lInPWF9WO2Mpg==
Subject: [PATCH v3 0/3] iio: light: stk3310: stk3013 support
Date: Sun, 21 Jul 2024 15:44:28 +0530
Message-Id: <20240721-stk3310-v3-0-98fcb6f551a1@disroot.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAITfnGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHUUlJIzE
 vPSU3UzU4B8JSMDIxMDc0MT3eKSbGNjQwNdM1OLNLM0Y5NEc0sLJaDqgqLUtMwKsEnRsbW1AA0
 mNypZAAAA
To: Jonathan Cameron <jic23@kernel.org>, Conor Dooley <conor@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 Kaustabh Chakraborty <kauschluss@disroot.org>

STK3013 is a part manufactured by Sensortek which is marketed as a [1]
"Proximity Sensor". This part is available in several consumer mobile
devices, including, but not limited to, Samsung Galaxy J7 Prime and
Samsung Galaxy A2 Core.

The existing ambient light sensor seemed suitable for this chip, and on
enabling the driver, it was discovered that these "Proximity Sensors" had
ambient light sensing capabilities as well.

The downstream kernel driver shipped with this phone by Samsung [2] exposes
a sysfs interface for proximity sensing, but leaves out the light sensing
features, hence there's no such functionality in userspace.

The following patch series aims to add support for STK3013 as an
ambient light/proximity sensor.

[1] https://www.sensortek.com.tw/index.php/en/products/optical-sensor/
[2] https://github.com/samsungexynos7870/android_kernel_samsung_exynos7870/blob/master/drivers/sensors/stk3013.c

Changes in v3:
- added a cover letter to the patch series
- added stk3310 as a fallback compatible

v2: https://lore.kernel.org/linux-iio/20240712152417.97726-1-kauschluss@disroot.org/
Changes in v2:
- added a commit to relax unknown chipid warning
- missed "v2" in patches

v1: https://lore.kernel.org/linux-iio/20240625165122.231182-1-kauschluss@disroot.org/

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
Kaustabh Chakraborty (3):
      iio: light: stk3310: relax chipid check warning
      iio: light: stk3310: add support for stk3013
      dt-bindings: iio: light: stk33xx: add compatible for stk3013

 Documentation/devicetree/bindings/iio/light/stk33xx.yaml | 13 +++++++++----
 drivers/iio/light/stk3310.c                              |  7 ++++++-
 2 files changed, 15 insertions(+), 5 deletions(-)
---
base-commit: 62c97045b8f720c2eac807a5f38e26c9ed512371
change-id: 20240714-stk3310-658f6f34a798

Best regards,
-- 
Kaustabh Chakraborty <kauschluss@disroot.org>


