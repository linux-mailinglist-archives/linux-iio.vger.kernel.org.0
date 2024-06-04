Return-Path: <linux-iio+bounces-5729-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CC58FAD05
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 10:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41914283701
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 08:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CEA1420C8;
	Tue,  4 Jun 2024 08:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Utx2TM9Z"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B5478283;
	Tue,  4 Jun 2024 08:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717488156; cv=none; b=udKzwlVHLyVGA/WJDi0v7m+uYS3VUQ4YqHbbcZgAFF4F2Q3JXPGl+oF6WGpBET0MOZJ7D8HrxTuhCQeRApwKcHUgqV+WAI6Wwbr2IPRoSS6CMtndUWa0rMbkuIubY+pZ0ip4V+d8cV47dDfDLBEoIEso3KSAJX9i+muYvtQVx8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717488156; c=relaxed/simple;
	bh=uHvOv9aK9XOoj9fYBdiwGn2AO8p3JyKaBsQ+U6DRHZU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ISF9vnjh21UX3dhp2uoXvATR+hK8W98wvXMRuejuKszM4GmjGOQPGvBEk6k2yXvfDekecILDiL6psWzeKzmoOHNWZfwLNwgpKRKe/QCLrx0WKTDR5L+pBYBs/uMBVa2wynKomihLt9LVXdLhqCeULFOKxjMAHjK7JGug52urzfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Utx2TM9Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68C41C2BBFC;
	Tue,  4 Jun 2024 08:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717488156;
	bh=uHvOv9aK9XOoj9fYBdiwGn2AO8p3JyKaBsQ+U6DRHZU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Utx2TM9Z4QUgwaYuHdYo4i0oAeVLfaVT+eS4hSXjrX6jb9eZ45FQKQiuY/hN/qmJl
	 hDMfVdUFmFvxjtJUIntDVNa80V9JDpn+GE3bc4qlGaJgbld1U/1zFRfYFdXNkS21T+
	 XTdsGVr5WBYhN3+KnyH9Rkz1Vdv51pbVaRT19LoJeu0kF9H+gSkV1Usf9XenKAz9Pf
	 k/UWipFy3qUEwbfYQSix9c00Zr0yqgr/ELY9yznNuXS9sUlEliUGHhEttPUcUT57Qa
	 azICEJJjVPORuLRwPcHeEBDq4glgBxqvn1/5hyYzzVMPKNhKYgVRyg/fTzObs+/3vm
	 YuHzz5NlHpJkg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2CAC27C52;
	Tue,  4 Jun 2024 08:02:36 +0000 (UTC)
From: Arthur Becker via B4 Relay <devnull+arthur.becker.sentec.com@kernel.org>
Subject: [PATCH v4 0/2] Add driver for Vishay VEML6040
Date: Tue, 04 Jun 2024 10:01:47 +0200
Message-Id: <20240604-veml6040-v4-0-5a4d59597874@sentec.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOvJXmYC/23MQQrCMBCF4auUWRsZM9MUXXkP6cKmExuwqSQlK
 CV3N3bt8n88vg2SRC8JLs0GUbJPfgk1+NCAne7hIcqPtUGjZmx1p7LMT4OMCunEzmLLRB3U+yu
 K8++duvW1J5/WJX52OdNv/YNkUqiMo2FwI+uzwWuSsIo92mWGvpTyBaIWJLKhAAAA
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, Arthur Becker <arthur.becker@sentec.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717488152; l=1495;
 i=arthur.becker@sentec.com; s=20240521; h=from:subject:message-id;
 bh=uHvOv9aK9XOoj9fYBdiwGn2AO8p3JyKaBsQ+U6DRHZU=;
 b=e/8TVxIokVEEUaj0I6HWTrOfYy+gzUjubml8W4SUO62Y3Zmho2fHunG2eTyV1OO1tqQ60TjCB
 ddSwCdykvITAltsCXDcGDuN6e8By9eL+H9IFEnw7tXh62kv8pnca5vM
X-Developer-Key: i=arthur.becker@sentec.com; a=ed25519;
 pk=1GLsDBF6GZKt9oNFsvdnAB6sHyKKrSISlwM3AyWbx/k=
X-Endpoint-Received: by B4 Relay for arthur.becker@sentec.com/20240521 with
 auth_id=163
X-Original-From: Arthur Becker <arthur.becker@sentec.com>
Reply-To: arthur.becker@sentec.com

The driver allows to turn the module on/off, set the integration time
(in MS) for the sensors, and read the raw measurements of the Red,
Green, Blue and White sensors.

Thank you Jonathan, Krzysztof, Conor and Rob for your comments on the
driver, dt-bindings and my workflow!

To: Jonathan Cameron <jic23@kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Arthur Becker <arthur.becker@sentec.com>

Changes in v4:
- Minor adjustments to the driver
- Merged dt-bindings with veml6075
- Link to v3: https://lore.kernel.org/r/20240527-veml6040-v3-0-6f3bbfd42960@sentec.com

---
Arthur Becker (2):
      iio: light: driver for Vishay VEML6040
      dt-bindings: iio: light: add VEML6040 RGBW-LS bindings

 .../bindings/iio/light/vishay,veml6075.yaml        |   9 +-
 drivers/iio/light/Kconfig                          |  11 +
 drivers/iio/light/Makefile                         |   1 +
 drivers/iio/light/veml6040.c                       | 281 +++++++++++++++++++++
 4 files changed, 300 insertions(+), 2 deletions(-)
---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20240527-veml6040-0314fc054337

Best regards,
-- 
Arthur Becker <arthur.becker@sentec.com>



