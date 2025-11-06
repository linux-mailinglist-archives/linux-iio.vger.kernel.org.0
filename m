Return-Path: <linux-iio+bounces-25962-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BCAC3BA86
	for <lists+linux-iio@lfdr.de>; Thu, 06 Nov 2025 15:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74ADA3A469C
	for <lists+linux-iio@lfdr.de>; Thu,  6 Nov 2025 14:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093D63396FA;
	Thu,  6 Nov 2025 14:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="sMGmBwoU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B322932AAAB
	for <linux-iio@vger.kernel.org>; Thu,  6 Nov 2025 14:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762438317; cv=none; b=fPnzLpjZbOJ0sWZ0qZZ5v6MOXZ36lnrRgxujTNTclWaYug469jNxyQxC6mg/DdQJke7IpqtqfUSCymYAznrHs+N7+sK6geFx9vsJZMzpwkZ4pjWtlqkNejomAoVI5WCUklNG2Qk0woUYRdxXbrE+Pk9J7S5ZKBXR6+GU1P0uy50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762438317; c=relaxed/simple;
	bh=MtBfKXgnwks9wDoLkPAlCFx579dhGTTT+GguYPMTtqg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fR2hGYir3SGyykOF0wYnaP0x6EqkGnByjxPzM5y98Ww9PJo/HMvKvc5FYMMMnJug1wsjumpRYwlQlo6mK/v69sg8TFRBqB+NRCZkx8Z8cTHhMMQBL6utiQpy8P0y718TWAA5nPdMcWRYWhgmDxrj2TJ5HzsXKGGF8e8YZQHqoaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=sMGmBwoU; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 075D14E41569;
	Thu,  6 Nov 2025 14:11:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CAAD16068C;
	Thu,  6 Nov 2025 14:11:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 89E7711851157;
	Thu,  6 Nov 2025 15:11:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762438313; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=ONwYkiE0Y5F1gcqwWehUvyhT8A8hUCs6f4qMGMhcP0I=;
	b=sMGmBwoUAi1Ldut8XcUpiGstU/Vzn5/L+NZrc4uWTDBgg4psw4aNV3mZPPuOa78s7b16Gh
	JdXv9QZHQAPG0Nf3lXb3CATfAJ6G7NlH9NOBHTsBPETil0GSWuc5xrfzLnKC3Pt2cUrbX9
	/+iajo6TxXdURmOtuCz6y5zoFhYahvqx4rEARzSfFtrobAbShqwCC0KzriZSm8MZ5F/0MN
	hkBtfZrjGXYY2rKcGhSBn9HlA4OWGC6oMyRDGBoWnDK4kqkIjF/405lhiOfOssKi/w3Hrp
	jciT/jOhVvys9En31okKHg7QyY3xgpZ9QylJpHvjNbFe6ewhKzZqoRw29OAKSQ==
From: Romain Gantois <romain.gantois@bootlin.com>
Subject: [PATCH v3 0/5] Add support for the LTM8054 voltage regulator
Date: Thu, 06 Nov 2025 15:11:45 +0100
Message-Id: <20251106-ltm8054-driver-v3-0-fd1feae0f65a@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKKsDGkC/2XMyQ6CMBSF4VchXVvTW1oGV76HcdEJuQlQ05JGQ
 3h3C24clv9JzreQ6AK6SE7FQoJLGNFPOcpDQUyvppujaHMTzrhkNW/oMI8Nk4LagMkFCmA6JWo
 BrJIkn+7BdfjYwcs1d49x9uG5+wm29U21UP1SCSijnRWubsCWpW7P2vt5wOlo/Eg2LPEPgMs/g
 GdA6wqUYKCYNd/Auq4vZ4VnC+8AAAA=
X-Change-ID: 20250728-ltm8054-driver-11cfa4741065
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-iio@vger.kernel.org, Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Hello everyone,

This is version three of my series which adds initial support of the Linear
Technology LTM8054 voltage regulator. The driver supports a fixed voltage
and a tunable output current limit using a DAC-controlled pin.

I'd say that the most unusual part of this series is the usage of the IIO
consumer API in a regulator driver. I think this makes sense here, since
the regulator driver has to access a DAC to read/set the output current
limit.

Since the regulator driver writes microvolts and the IIO consumer API takes
millivolts, the reads and writes to the CTL DAC have to be scaled by a
factor of 1000. Scaled reads are already supported in IIO, but scaled
writes are not, which is why I've implemented them in patch 2/4.

Moreover, the IIO read/write operations are done in quite a roundabout way
in the driver's regulator callbacks. This is due to a unsafe locking
interaction: the regulator callbacks are called under regulator lock, which
means they have an active ww_mutex reservation ID. Or, some IIO drivers
will perform regulator operations when read/written to, thus taking a new
ww_mutex reservation ID.  Taking two consecutive reservation IDs for the
same ww_mutex context without freeing the first ID is forbidden (and
lockdep will complain about this). The most straightforward solution I've
found is to move the actual IIO read/write operations to a different
thread, and to wait for them to complete with a timeout from the main
callback thread.

Please let me know what you think.

Thanks,

Romain

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
Changes in v3:
- Made IIO operations to an asynchronous context to avoid locking issue.
- Made CTL DAC control optional.
- Make various style adjustments to the LTM8054 driver.
- Link to v2: https://lore.kernel.org/r/20250925-ltm8054-driver-v2-0-bb61a401a0dc@bootlin.com

Changes in v2:
- Refactored iio_convert_processed_to_raw() to match what was done in Hans'
  series.
- Added unit tests for IIO division.
- Fixed coding style issues and removed unnecessary casts.
- Link to v1: https://lore.kernel.org/r/20250916-ltm8054-driver-v1-0-fd4e781d33b9@bootlin.com

---
Romain Gantois (5):
      regulator: dt-bindings: Add Linear Technology LTM8054 regulator
      iio: add processed write API
      iio: test: Add kunit tests for iio_divide_by_value()
      regulator: Support the LTM8054 voltage regulator
      regulator: ltm8054: Support output current limit control

 .../devicetree/bindings/regulator/adi,ltm8054.yaml |  71 ++++
 MAINTAINERS                                        |   6 +
 drivers/iio/inkern.c                               | 129 +++++++
 drivers/iio/test/Kconfig                           |  12 +
 drivers/iio/test/Makefile                          |   1 +
 drivers/iio/test/iio-test-divide.c                 | 215 ++++++++++++
 drivers/regulator/Kconfig                          |   9 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/ltm8054-regulator.c              | 386 +++++++++++++++++++++
 include/linux/iio/consumer.h                       |  37 ++
 10 files changed, 867 insertions(+)
---
base-commit: 959f5c38d89070dc078ec2097161f871397ea3f1
change-id: 20250728-ltm8054-driver-11cfa4741065

Best regards,
-- 
Romain Gantois <romain.gantois@bootlin.com>


