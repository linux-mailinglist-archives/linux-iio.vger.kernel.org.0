Return-Path: <linux-iio+bounces-17881-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F439A82A00
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 17:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D240D4E704F
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 15:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4A01DFFD;
	Wed,  9 Apr 2025 15:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQP5NabU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4204B18A6A5;
	Wed,  9 Apr 2025 15:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744211688; cv=none; b=uwsMTQRwszc4Ys5gFFgHCXKlTa0GO47Uh80UXszEM1v6vEINAJs1gRWLHIneyiDNddXSlJkcmZvEPoqRSx+ateQfdEYBfVfeWNibkwhuEcqRG4d5XRZiyGHixOlQHlAywkv2H1CcMMWxZCFIuEUC2mvQBjaysRzpUES5gYmU/pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744211688; c=relaxed/simple;
	bh=FMJInia6WIVcnROgoVppgptni1eK+Ht+NAQikTBAa/c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lcPwp5B7E9glsjMsDu4g7M0RPjKpU7n3lo2eZnrPCHlehF0hPlhb1ud0ZLTfU/AyGpKyvBLTMC6muteo94OsfTVw0kDvFZupo4jbvoCXi/KFf8sa0Bue/PL0/ymup9LbMGM8xipd+3UWyYpVyLV4HQBX7CVwVcVKr5u+QBG8FDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQP5NabU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ADD5FC4CEE7;
	Wed,  9 Apr 2025 15:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744211687;
	bh=FMJInia6WIVcnROgoVppgptni1eK+Ht+NAQikTBAa/c=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=OQP5NabUMTRSO3YQppTMB4J4vt8362BH1yG/JL90eHxUKiwkCt8il4/OcenoktP7J
	 ssjmKkJ8ysB5Iw2h47fsP8AttlYaug+Mc4bzOcnUyL63EjZd/6W1ZUGqjYydGqnoV1
	 +m20bgY/P4y4+okfXejKvmhFrT/ny0R68yNlhFM0jYTrjJuqFYsigY7t+rkQb4hHHn
	 MEPT0CLLvyDPN5uddAFfnoo0gU/ZjibMctySwlxj2+YndDkK0ZvoghvXG3wqhPpge6
	 dO/qceqbkRqJUwfnmXAEX4HXwGSamW376sVUQSbi885b/qC1qZDBYI504cKFpzNl3e
	 XfiWLqpPEcshw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCC1C36002;
	Wed,  9 Apr 2025 15:14:47 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Subject: [PATCH v3 0/2] iio: imu: inv_icm42600: switch to use generic name
 irq get
Date: Wed, 09 Apr 2025 17:14:30 +0200
Message-Id: <20250409-iio-imu-inv-icm42600-rework-interrupt-using-names-v3-0-dab85a0a7c2b@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANaO9mcC/52OQQ6CMBBFr2K6dkwZqEVX3sO4gHbUiaE1LVSN4
 e4WXOia5fuL9/5bRApMUexXbxEocWTvMpTrlTDXxl0I2GYWKFHJEhUwe+BuAHYJ2HQVbqWEQA8
 fbnnrKYTh3sMQ2V3ANR1FaMudNmQ11qUS2XsPdObn3DyeMl859j685gupmNZvrZLVgloqQIJGs
 qqQ0jZFdejtbWN8J6ZWwn+/XuLH7Deo68acVa1b/PnHcfwAelVUL1ABAAA=
X-Change-ID: 20250325-iio-imu-inv-icm42600-rework-interrupt-using-names-b397ced72835
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744211686; l=1598;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=FMJInia6WIVcnROgoVppgptni1eK+Ht+NAQikTBAa/c=;
 b=G6CHdRYNzEfB/2L44UMhQFCEPqJdFTn0dDFgOjyByEvQUTft/AFsbhAU4qX1Sm2kjYx9HYvxw
 M79fQlQwI4ZBWrBTBNy6eIjdM2fz0vgMAWg7eY9by0seHQJz4IYpUTP
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
Changes in v3:
- Update dt-binding to report support of the 2 interrupts and delete
  remark about driver feature support.
- Link to v2: https://lore.kernel.org/r/20250407-iio-imu-inv-icm42600-rework-interrupt-using-names-v2-0-c278acf587b2@tdk.com

Changes in v2:
- Add INT2 in interrupt-names enum and fix enum
- Add fallback to first interrupt if naming is not here to ensure
  backward compatibility
- Link to v1: https://lore.kernel.org/r/20250404-iio-imu-inv-icm42600-rework-interrupt-using-names-v1-0-72ed5100da14@tdk.com

---
Jean-Baptiste Maneyrol (2):
      dt-bindings: iio: imu: icm42600: add interrupt naming support
      iio: imu: inv_icm42600: switch to use generic name irq get

 .../bindings/iio/imu/invensense,icm42600.yaml           | 13 ++++++++++++-
 drivers/iio/imu/inv_icm42600/inv_icm42600.h             |  2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c        | 17 +++++++++++++++--
 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c         |  2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c         |  2 +-
 5 files changed, 30 insertions(+), 6 deletions(-)
---
base-commit: 1c2409fe38d5c19015d69851d15ba543d1911932
change-id: 20250325-iio-imu-inv-icm42600-rework-interrupt-using-names-b397ced72835

Best regards,
-- 
Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>



