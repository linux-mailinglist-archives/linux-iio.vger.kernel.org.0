Return-Path: <linux-iio+bounces-17918-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 592D2A84847
	for <lists+linux-iio@lfdr.de>; Thu, 10 Apr 2025 17:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F6DD1B639EA
	for <lists+linux-iio@lfdr.de>; Thu, 10 Apr 2025 15:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A611EBFEB;
	Thu, 10 Apr 2025 15:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJe693PR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397F71EB5F0;
	Thu, 10 Apr 2025 15:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744299635; cv=none; b=nMQMRhreXvNnrp9SJvb03Y6Oua5b+S/IxNh+/rd2+TynYjodqP+QBgbRoqHDSECgMEf6nMd3YSj9Ltbr3PA4ltDx0sx6suEBpF4A0eLieWGOagy9P4KpFnm2eU6ZREXUFz+7PxvjCLvT2P7J4FmHNipSw9fHkjw7e3txJqVlFzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744299635; c=relaxed/simple;
	bh=WWPgjrypLq+FtwiDGFQDw69WqwGWqMZd39vBNg9H2Ek=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pemJ9dEzb3jWaC1xmaBXDxKTdJLNEapq+oOP8/GvL+PSYcv83hf6PPzu+CRg42XRSIKq8DPRqpDS3wzygxgyi8EGEjHJru3nC2yoTPT7BrZ+xHM3iifFCtv+wNPGh3v64ux15zEM6cGUS+4g7+2QkZT2La5391Qd+jYSjPM3Adg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJe693PR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95CDEC4CEDD;
	Thu, 10 Apr 2025 15:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744299634;
	bh=WWPgjrypLq+FtwiDGFQDw69WqwGWqMZd39vBNg9H2Ek=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=qJe693PRS+hQ6mlDmBvuZUfvssTMkQwUs0dlIPhRoGai+Is66UbQhQMRcrTWFuTMW
	 voSg8/H9A6tN/W2wtWMhDEwA6niGtF1fSzzFdMtsQBrlgFe+PPD0vCX6+64b7QwNEA
	 MJA2mF49cyLLl0UffUnGpm097TBDKGVyfGCAphTZSzVX5PlUVW4ltDUDLTYV963dQU
	 V5OTlmsf+/xjXVR5c6kAPvsbOxDMaD+POpP6yUNNFYwTm/HaAfwAPDE206OyvHAHY0
	 hrNVV/d+CXFR+hUD6v38NozEEVySA7TkkIQ0UTNqShiHrPr5SV1KKvDmrvfsJZul8P
	 r6aakh8SbxC3w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6EBC3601E;
	Thu, 10 Apr 2025 15:40:34 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Subject: [PATCH v4 0/2] iio: imu: inv_icm42600: switch to use generic name
 irq get
Date: Thu, 10 Apr 2025 17:39:39 +0200
Message-Id: <20250410-iio-imu-inv-icm42600-rework-interrupt-using-names-v4-0-19e4e2f8f7eb@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADvm92cC/53OsW7CMBDG8VdBnnvIOdt16NT3qDo49gEnFBvZi
 dsK5d1rYADWjN8Nv/9dRKHMVMTH5iIyVS6cYhv6bSP80cUDAYe2BUo0UqEB5gQ8zsCxAvtR47u
 UkOkn5VO7TZTzfJ5gLhwPEN1IBQa1s56CxV4Z0dxzpj3/3ppf320fuUwp/91eqN31eq9pqVfUa
 gcSLFIwnZTBdfpzCqetT6O4tio++3aNj833aHvn96a3A7766tnfrfFV84MbeuOksx6Hh78syz/
 8+/aesAEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744299633; l=1934;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=WWPgjrypLq+FtwiDGFQDw69WqwGWqMZd39vBNg9H2Ek=;
 b=3e/zhaM3q8MUpKaDXmv/uRr+PITc98IwwQe13/LQSk4jVoPOcTJJ33hLF96luG1fIYPRXL3Pq
 A3cD4uIaS4LAJM0LAjxh2fSqIfnVUO2DcKzF7rZj9nUexhL/fKD66HO
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

The purpose of this series is to switch to fwnode_irq_get_by_name()
in the core module instead of using irq from the bus parsing.

Add in dt binding interrupt naming and up to 2 interrupts support.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
Changes in v4:
- Change dt-binding commit message to be more explicit about interrupt
  support.
- Simplify fwnode usage, NULL checking is already done automatically.
- Link to v3: https://lore.kernel.org/r/20250409-iio-imu-inv-icm42600-rework-interrupt-using-names-v3-0-dab85a0a7c2b@tdk.com

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

 .../devicetree/bindings/iio/imu/invensense,icm42600.yaml   | 13 ++++++++++++-
 drivers/iio/imu/inv_icm42600/inv_icm42600.h                |  2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c           | 14 ++++++++++++--
 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c            |  2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c            |  2 +-
 5 files changed, 27 insertions(+), 6 deletions(-)
---
base-commit: 1c2409fe38d5c19015d69851d15ba543d1911932
change-id: 20250325-iio-imu-inv-icm42600-rework-interrupt-using-names-b397ced72835

Best regards,
-- 
Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>



