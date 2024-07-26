Return-Path: <linux-iio+bounces-7948-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B93793D8BE
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 20:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C6C81C23107
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 18:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE876BFB5;
	Fri, 26 Jul 2024 18:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="G8/AcUJL"
X-Original-To: linux-iio@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A01405E6;
	Fri, 26 Jul 2024 18:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722020033; cv=none; b=Ah76DduNDcedYXWzYk+Bc9kysyDj1D4yltnf5iCsHt+UOQpMR3gisThQ+l78EJ9xMhkKO/K6wq974ywWRfDNyhMRMmnpNXCpcF/rtsRUwgcSiNWBhKU32QeZNIHdqtSBNpqbsWtP/ZiOsbd1RVh67YhFYuF7vq4d3AOmDnREbWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722020033; c=relaxed/simple;
	bh=BIQOzAf6aS8fozZtMAZL8oGwu4drSsIx4IlU+4FGw10=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YsA4hND6FIRR6gnr4QXOTeyCa16Igy3Op1W3HjBPk8jwolSprdc9uWeQ2ZmanFg1Rk8QTW9wqg2Pfz/Q52VG/aqYjtyxcXVibGM5mdbd7BN/GbA+dBcCG+Rq4pEPFMxhkNSVRQnsbT+PISoChFaowy1XOMelRKjJIhKI/hsWvMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=G8/AcUJL; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from localhost (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 87A5D4117A;
	Fri, 26 Jul 2024 20:53:48 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
	by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y3fWCkFzlsTF; Fri, 26 Jul 2024 20:53:47 +0200 (CEST)
From: Kaustabh Chakraborty <kauschluss@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1722020027; bh=BIQOzAf6aS8fozZtMAZL8oGwu4drSsIx4IlU+4FGw10=;
	h=From:Subject:Date:To:Cc;
	b=G8/AcUJLWfo8TPFngyzfgPPRs0hi2PcOXu4cRB0Rd1sKhot5LiLmDpBy2uFR7Q4fb
	 6fHDi/ESQu01OLttEEPC4MzXwfraC5Tujp++GAILDuKFqAL5AN5wrGZ4fjTCXm5ACC
	 KCNT1Qx3AuRHbgwdCFaP2K1sLRwnLEVx3U0AAbhrf/BAQJLreykifRLwvTYeQ99F3L
	 613GCtyZPgTRzkTXVuX85vt5MV7SzyiMinSDpUpWySswId4f3qR0/YIKMCdURV5M8f
	 WfMqd0ZzDIGdyr0oobBDQnuodEoOQ43PchBz/PMva1N/b1nd976g3/JDDLprxo6brO
	 3uMuDqBfdyPBQ==
Subject: [PATCH v4 0/3] iio: light: stk3310: stk3013 support
Date: Sat, 27 Jul 2024 00:23:30 +0530
Message-Id: <20240727-stk3310-v4-0-02497b1407ba@disroot.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKrwo2YC/z3MSwrCMBSF4a2UOzaSd1NH7kM6iG3SXoRGkhCUk
 r0bizj8D4dvh+QiugSXbofoCiYMWwt56mBa7bY4gnNr4JRL2jNJUn4IwSjRynjthbT9YKC9n9F
 5fB3SbWy9Ysohvg+4iO/6Mzj7G0UQSgbjp7v2SjHLrjOmGEI+h7jAWGv9AJa4zKCgAAAA
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

Changes in v4:
- fixed incorrect indentation in doc
- Link to v3: https://lore.kernel.org/r/20240721-stk3310-v3-0-98fcb6f551a1@disroot.org

Changes in v3:
- added a cover letter to the patch series
- added stk3310 as a fallback compatible
- Link to v2: https://lore.kernel.org/r/20240712152417.97726-1-kauschluss@disroot.org

Changes in v2:
- added a commit to relax unknown chipid warning
- missed "v2" in patches
- Link to v1: https://lore.kernel.org/r/20240625165122.231182-1-kauschluss@disroot.org

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


