Return-Path: <linux-iio+bounces-13938-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FC3A032A8
	for <lists+linux-iio@lfdr.de>; Mon,  6 Jan 2025 23:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17FA8164986
	for <lists+linux-iio@lfdr.de>; Mon,  6 Jan 2025 22:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C541E0DED;
	Mon,  6 Jan 2025 22:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDK0zxfi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96691DF99C;
	Mon,  6 Jan 2025 22:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736202207; cv=none; b=DrgSVmTihZyBgN0cSQPSKHD9OfvHWDS0DX4Trrth7A3N6Aja65Hywd79KHxlZg+qEVmA9uKTHMA+OLOqRTy8jvYXY8fd2gSLxOYqYxVKs6lvtEVq1K08GJc7nBz7s533uULfbQcY6/xYxpuU+4dhOTykAZeFz1+ybxoDoB77w1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736202207; c=relaxed/simple;
	bh=EjF1YdbqpBPh4sTCXyvUJoXES+N65/VkVyh/WyOKlAU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gN+1x43yjosqO//dQN6Y/UQ87YCKdpp/2mS1UQTH4xNL+/V0imxIFdDcaJNCfe/SrQWp2u7sVREn26TmZtKTZflZ9peFI8E+9xfH91aHH1laR5odxmMEBnDZnO7/xLO71Zlmkmti305nDRyZ1fUgh78vy10z1DfP3WTzh/LCSJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDK0zxfi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2908EC4CEDD;
	Mon,  6 Jan 2025 22:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736202207;
	bh=EjF1YdbqpBPh4sTCXyvUJoXES+N65/VkVyh/WyOKlAU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=WDK0zxfibQNqposUpofYKNMUr6THqGQzFguvcF3JIiqTlvPnk8CLLWbu8cn3XHG/b
	 G5cbc1p2HKj4gkeIgpNYvquCwEHlGXnP/gWchgvLYluiP8aO6dTsPhZAVJ1v22yFaD
	 ZyGuEUwuLwcK+RDTKWswd0bGcR5kzldEj8SXDD3mvenfCqtMrz5pkdEaCj9NvLupxL
	 X6Fqhkl5QnvtL86+O8l1pmk3+9xkG1mVA25xip2wbmWxO3y/10zpYDXWyO2y78jqD/
	 Fe0E5YLYwDYIYoMLvyKV8Ab10iGMestVsCXRcJoTX2iD/V0b1NHriDYwewqTe3BQEi
	 p+4eDpzgEFAxQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E80E77198;
	Mon,  6 Jan 2025 22:23:27 +0000 (UTC)
From: Mikael Gonella-Bolduc via B4 Relay <devnull+mgonellabolduc.dimonoff.com@kernel.org>
Subject: [PATCH v4 0/2] Add support for Avago/Broadcom APDS9160
Date: Mon, 06 Jan 2025 17:23:00 -0500
Message-Id: <20250106-apds9160-driver-v4-0-f88d9fc45d84@dimonoff.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMRXfGcC/3XNQQ7CIBCF4as0rMUApbR15T2MiwIzlkVLA4Zom
 t5d2o1G6/J/yXwzkwjBQSSnYiYBkovOjznkoSCm78YbUGdzE8GE5Jy3tJtsbLli1AaXINBGGay
 gURbKiuSrKQC6xyZerrl7F+8+PLcHia/rfytxyih2jKm60hI6ebZu8KNHPBo/kJVL4k0Ipn4Jk
 QkNwuhaADa4R5QfBN8hykwY0aIyqmba6i9iWZYXLawuwzcBAAA=
X-Change-ID: 20241119-apds9160-driver-86cf5e86de35
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: Mikael Gonella-Bolduc <m.gonella.bolduc@gmail.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Matti Vaittinen <mazziesaccount@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736202206; l=2816;
 i=mgonellabolduc@dimonoff.com; s=20241119; h=from:subject:message-id;
 bh=EjF1YdbqpBPh4sTCXyvUJoXES+N65/VkVyh/WyOKlAU=;
 b=rhCRyhxP9R3tc9V/gi0aiwV282xjQ9OJwJLz2cHufK0FKqqFUgY5ktAOarD0PLvyxf7PrEqtn
 DsccZt0pflhAWKV4ghbjfcH781Xp7vsxe5m4d1aBMS/vivzLzCWJyEh
X-Developer-Key: i=mgonellabolduc@dimonoff.com; a=ed25519;
 pk=p4tvPfGPfXRyChsgHc6s7HwB6YBl2JqqcP3BXtoDitE=
X-Endpoint-Received: by B4 Relay for mgonellabolduc@dimonoff.com/20241119
 with auth_id=279
X-Original-From: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
Reply-To: mgonellabolduc@dimonoff.com

APDS9160 is an ALS and proximity sensor.
https://www.broadcom.com/products/optical-sensors/integrated-ambient-light-and-proximity-sensors/apds-9160-003

Signed-off-by: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
---
Changes in v4:
- dt-bindings: Add additional analog cancellation properties
- driver: Using analog cancellation properties from device tree
- driver: Changed proximity channel type calibscale to calibbias
- driver: Fixed some comments format
- Link to v3: https://lore.kernel.org/r/20241216-apds9160-driver-v3-0-c29f6c670bdb@dimonoff.com

Changes in v3:
- Updated maintainers file email and vendor
- Corrected documentation file reference
- dt-bindings: Changed commit message
- driver: Added event and channel table when irq is not used
- driver: Using int time instead of sampling freq for proximity channel
- driver: Using scale instead of hardwaregain for proximity channel
- driver: Dropped unused static variables
- driver: Fixed switch fall-through
- driver: Dropped explicit void pointer cast
- driver: Dropped some less relevant comments
- driver: Various code style related fix
- Link to v2: https://lore.kernel.org/r/20241206-apds9160-driver-v2-0-be2cb72ef8f4@dimonoff.com

Changes in v2:
- Rebased on linux-iio 20fd1383
- dt-bindings: Dropped the old Avago name and use the brcm vendor prefix
- dt-bindings: Updated example node name with a generic name
- dt-bindings: Updated example indentation to 4 spaces
- dt-bindings: Fixed element ordering
- KConfig: Dropped unsure sentences
- KConfig: Dropped unused Kfifo buffer selection
- driver: Use a more recent iio light driver as template
- driver: Remove buffer declaration
- driver: Use avail functions instead of custom iio attributes
- driver: Use scale instead of hardware gain
- driver: Removed unused members and unreachable statements
- driver: Removed unnecessary info and debug prints
- driver: Fix some coding style and line wrapping issues
- driver: Reordering of functions
- Link to v1: https://lore.kernel.org/r/20241119-apds9160-driver-v1-0-fa00675b4ea4@dimonoff.com

---
Mikael Gonella-Bolduc (2):
      dt-bindings: iio: light: Add APDS9160 binding
      iio: light: Add APDS9160 ALS & Proximity sensor driver

 .../bindings/iio/light/brcm,apds9160.yaml          |   86 ++
 MAINTAINERS                                        |    7 +
 drivers/iio/light/Kconfig                          |   11 +
 drivers/iio/light/Makefile                         |    1 +
 drivers/iio/light/apds9160.c                       | 1586 ++++++++++++++++++++
 5 files changed, 1691 insertions(+)
---
base-commit: 5de07b8a24cf44cdb78adeab790704bf577c2c1d
change-id: 20241119-apds9160-driver-86cf5e86de35

Best regards,
-- 
Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>



