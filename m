Return-Path: <linux-iio+bounces-14539-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B710DA19B1D
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jan 2025 23:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB2A116123E
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jan 2025 22:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182541CC881;
	Wed, 22 Jan 2025 22:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XoTx1s3z"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3B31CAA6C;
	Wed, 22 Jan 2025 22:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737586781; cv=none; b=PAw05s3sMqi4lqbhEzPXt/KD1OazTZ1AvaC7HCKULushrHLLMQO4rAc4OfsBWwbZodB9XdHuk1PIl43s+eSZnrxT1SacY7KR/PUIuNI5sOwdL/4BYFIpO2VptPco9kPn8scckV6eVA0roiQWhX4bXSk9mvQQfJAvtlMYuc1p8W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737586781; c=relaxed/simple;
	bh=8uqoflCjXKKdp0P7r0EJGrV8SwpmYb2NJr/xhdDj5Kk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rAiKAnks9pab3MbWM691oJd1rb+aW2/7r6xXOrxkfQXO7TKI9HKNUR+GP9Mesf3GBR8gVPQAj1bOPIarQuQAYLG+bKYYzlbaMiT2tMYDm8MEbXyEfDxReBniBP936AmA6AEG/Zvss0bGzvShMv3iVqMcoeIQHaR7JOWUbudzt7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XoTx1s3z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3BF36C4CEE1;
	Wed, 22 Jan 2025 22:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737586781;
	bh=8uqoflCjXKKdp0P7r0EJGrV8SwpmYb2NJr/xhdDj5Kk=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=XoTx1s3z3Hm0j4s2VY9FBHJbZGbo1Q/bqwUZAEKzJMVa4qmt7SlT6c2xFjTgQHKun
	 Cf8CzBPpmWKv7R7yJ8Ic9yV4yr4Y60v9+k9PuoDnCsGIIbRoEG4A4nptmk7lT+d75F
	 sQTKV6ZXfDqruepqWWqOnGVx1SgFv7oREkEfdX1DgB0CQcqBd6dv6GAjrAFB2vN6hK
	 pS2FWManUbB7j714mybky8Zds7m8Zxzv3O9FEK7XXUzxaXjwKYmQhFlGRZSvAtpwn2
	 RAI3VRw6A1BFc8uR8Puaji887qzNIJSdApO0ECa6mmVX9O2eaM0a3orkNp+huVJGZg
	 45KGqSRGm6w0A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE4DC02181;
	Wed, 22 Jan 2025 22:59:41 +0000 (UTC)
From: Mikael Gonella-Bolduc via B4 Relay <devnull+mgonellabolduc.dimonoff.com@kernel.org>
Subject: [PATCH v5 0/2] Add support for Avago/Broadcom APDS9160
Date: Wed, 22 Jan 2025 17:59:32 -0500
Message-Id: <20250122-apds9160-driver-v5-0-5393be10279a@dimonoff.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFR4kWcC/3XPQQ7CIBAF0KsY1mKAAqWuvIdxUWBGWVgaMERje
 nepidFoXf5J5s2fO8mQAmSyXd1JghJyiEMNar0i7tQPR6DB10wEE5Jz3tF+9LnjmlGfQoFEjXa
 owGgPjSJ1a0yA4foU94eaTyFfYro9DxQ+T/9bhVNGsWdMt8pK6OXOh3McIuLGxTOZuSLehGD6l
 xCVsCCcbQWgwSWi+SD4AtFUwokOtdMts94uEPJFKMaXWsj5EWN8h04qb75bTNP0ALdAtyx6AQA
 A
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737586780; l=3221;
 i=mgonellabolduc@dimonoff.com; s=20241119; h=from:subject:message-id;
 bh=8uqoflCjXKKdp0P7r0EJGrV8SwpmYb2NJr/xhdDj5Kk=;
 b=MDxKkeA1OxLo9R2bUnaYI08tUHwpl0NSVt5Pu/YIQeVoLw2+bhFfDq8KjuRUTHfCscjVB9JiG
 KAlg7RqbO2hA29E+IISf0VHTr6sXR5Ti5aS1wcwREVjS0fRW5H2OrQ0
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
Changes in v5:
- dt-bindings: Use new picoamp unit suffix instead of index for
  cancellation current property
- driver: Use new picoamp unit to calculate cancellation level coarse
  and fine
- driver: Add a warning if requested cancellation level is not supported
- driver: Minor additional changes
- Link to v4: https://lore.kernel.org/r/20250106-apds9160-driver-v4-0-f88d9fc45d84@dimonoff.com

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

 .../bindings/iio/light/brcm,apds9160.yaml          |   78 +
 MAINTAINERS                                        |    7 +
 drivers/iio/light/Kconfig                          |   11 +
 drivers/iio/light/Makefile                         |    1 +
 drivers/iio/light/apds9160.c                       | 1597 ++++++++++++++++++++
 5 files changed, 1694 insertions(+)
---
base-commit: 5de07b8a24cf44cdb78adeab790704bf577c2c1d
change-id: 20241119-apds9160-driver-86cf5e86de35

Best regards,
-- 
Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>



