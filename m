Return-Path: <linux-iio+bounces-17792-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1573A7EEBF
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 22:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C245F425015
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 20:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F0B2222D0;
	Mon,  7 Apr 2025 19:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tgzhskYL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1561221F0A;
	Mon,  7 Apr 2025 19:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744055846; cv=none; b=keTxbciyh6VvZhK73DWPValqWA9565tTuZH1nvP9CoxmvjQWFciRu3/e7RjdBUSDZMmYnggfUfj/VpsXugZMJx4VLowM3+waU2OoEQXGYGDvOiBFwVocuTxQ1B0t7OkXoKXsKycwJqLNfgCO2R7YzVtML61E9bo+2zav4tH4vqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744055846; c=relaxed/simple;
	bh=rIJwEoz8xFlQQVlAO/VsBXMyVwVYpieUYx8Cva0KGTE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sv5/pMRUQtZ++vzCIcMK302r06hJSsvV8FmuF3r8l9WVTgW4223F0LreDnbTLyYIhniQek0KWkSihgh7HwH8F19wvGhv3GpBGYED0EA8w30E8NmJnr1h8tUiI8W/L6PYqR3puKxl9ts/OruHJdNxVkHLCaJd2qOp4PPisR9vFFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tgzhskYL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46C75C4CEDD;
	Mon,  7 Apr 2025 19:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744055846;
	bh=rIJwEoz8xFlQQVlAO/VsBXMyVwVYpieUYx8Cva0KGTE=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=tgzhskYL/PMGu21tr58ueykP3Q9fyZrBrWKSjpXZzf9QPTcv4daFvZbDkTnQnJwHe
	 bBCw/cKcTpEXxuwHd6AkZi4va7FU3cm63s/iRaJ/+zqWekoQLnOntua7eVAfYN/f2P
	 apvimfZjkeZHsd1rwC5UIYWCQ/Yp7tmL/43BQj7SrrdFTwd9ZIF2UeY3KCtjnmSkW1
	 ++GxQOGpopt9U+iwBSXQ+syM3KLi16PMFi/yGxk4l7Z2OrdHXgxI1GJkFC402dsSw4
	 4M4PSbL+fycvNhfMc+MSP0WDV8OQFBl3iEVRgA2tR3a0nGkXHRPOeaOJwX14+wKu7m
	 ZlcZRxMmZQs7g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBEFC36010;
	Mon,  7 Apr 2025 19:57:26 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Subject: [PATCH v2 0/2] iio: imu: inv_icm42600: switch to use generic name
 irq get
Date: Mon, 07 Apr 2025 21:57:15 +0200
Message-Id: <20250407-iio-imu-inv-icm42600-rework-interrupt-using-names-v2-0-c278acf587b2@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABsu9GcC/52OQQ7CIBBFr2JYOwYoWHXlPUwXFcZ20gANtKhpe
 nex3sDle4v//sISRsLELruFRcyUKPgCcr9jpm99h0C2MJNcal5JDUQByM1APgMZp+SRc4j4DHE
 obsIY53GCOZHvwLcOE9yrc23Q1vJUaVZ2x4gPem3NW1O4pzSF+N4uZPG1v5ri6o9aFsChlmi14
 Ny2Ql0nOxxMcKxZ1/UD/A4HzfAAAAA=
X-Change-ID: 20250325-iio-imu-inv-icm42600-rework-interrupt-using-names-b397ced72835
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744055845; l=1344;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=rIJwEoz8xFlQQVlAO/VsBXMyVwVYpieUYx8Cva0KGTE=;
 b=MVjajOAMvhvW8ch5RkVeX8GmZZbQOrXdcvzHU+tA5GN7UEQXJqDv5QbJVYoJGlajjxAzi4KWT
 pUHelmpxrRwDc34RBXCdat+LH/CkpVmEvi08CPObIilHZCG+niO56pR
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

The purpose of this series is to switch to fwnode_irq_get_by_name()
in the core module instead of using irq from the bus parsing.
Add interrupt naming and support only INT1.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
Changes in v2:
- Add INT2 in interrupt-names enum and fix enum
- Add fallback to first interrupt if naming is not here to ensure
  backward compatibility
- Link to v1: https://lore.kernel.org/r/20250404-iio-imu-inv-icm42600-rework-interrupt-using-names-v1-0-72ed5100da14@tdk.com

---
Jean-Baptiste Maneyrol (2):
      dt-bindings: iio: imu: icm42600: add interrupt naming support
      iio: imu: inv_icm42600: switch to use generic name irq get

 .../bindings/iio/imu/invensense,icm42600.yaml           | 13 +++++++++++++
 drivers/iio/imu/inv_icm42600/inv_icm42600.h             |  2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c        | 17 +++++++++++++++--
 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c         |  2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c         |  2 +-
 5 files changed, 31 insertions(+), 5 deletions(-)
---
base-commit: e3ee177e2a3e21ef4502f68336023154049d2acd
change-id: 20250325-iio-imu-inv-icm42600-rework-interrupt-using-names-b397ced72835

Best regards,
-- 
Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>



