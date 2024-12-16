Return-Path: <linux-iio+bounces-13562-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0289F3DD3
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 23:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B77D1889F16
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 22:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69B41D90DD;
	Mon, 16 Dec 2024 22:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRF0C3fH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76327143723;
	Mon, 16 Dec 2024 22:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734389752; cv=none; b=eRf5uR+D2tvkQkZFWkY7gXpcqcBDkY0eVps0ydndY6VS79xf9aK0xQ5p8YEYKXejQFu6C9m9ptsHN/kgs61CZefvFyUdZhFyWApgt+VzNspCoa59BXtQ9CCmQ38rK2uimSZAS4qpGyT1VxuL5EssDdKpezpCWceejWNOV2aVsSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734389752; c=relaxed/simple;
	bh=HWkTxX+IpDGQNG52ogknWjClj9up9Mh0BRCF+szV+n0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=teqxbliCUsdL6zn3qEvrHcDjyiPBO0Rez8MhN8Jn6Ro9otsFT1n5/574elvI8TMDJzVSGcSVJJXYOxuIAQeE8g0gkFNcj4PFStBz2ToevymPD+RU1AM7ltyXzGqCOdCBLUkg//RwBi2s6xooAlL0NGRFP4wb2KbYxvXvftZM+4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRF0C3fH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19CECC4CED0;
	Mon, 16 Dec 2024 22:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734389752;
	bh=HWkTxX+IpDGQNG52ogknWjClj9up9Mh0BRCF+szV+n0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=mRF0C3fHlp/SR4oj0P+4VoJhIR4Mv79dx5EobhVgttY40OO+nZQu9FLRKe5n/XjaQ
	 wIgQQvF0oEJplgB5McW4Vx5w0hFHhvjClUMMHv0jvF9vaRzqQyNht4qTZmC+8vFrXE
	 lBGZBqe3zfpM7lN4fIOB8AuweQTQVIqGIr05+WuqpsRIDWY1qDnEe+doKQFuqLUvIR
	 LMZFQFiq8dH0dI1IQKcLdRKCb3WBkTwlaM3HpkqAfmB73Azs1LCqGYhV/sjyP6q4L7
	 AceratXQxEXQwJQUveVjuZJ/BRD/uR0ktdgy3Ox4hPXFHm4G+EM437oNyRc0KhR5nf
	 +woo7/erKjDDg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBC3E7717F;
	Mon, 16 Dec 2024 22:55:52 +0000 (UTC)
From: Mikael Gonella-Bolduc via B4 Relay <devnull+mgonellabolduc.dimonoff.com@kernel.org>
Subject: [PATCH v3 0/2] Add support for Avago/Broadcom APDS9160
Date: Mon, 16 Dec 2024 17:55:39 -0500
Message-Id: <20241216-apds9160-driver-v3-0-c29f6c670bdb@dimonoff.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOuvYGcC/3XNTQ7CIBCG4as0rMUAbenPynsYFxRm7CxaGjBE0
 /Tu0m5MNC7fL5lnVhYhEETWFysLkCiSn3OUp4LZ0cx34ORyMyVUJaXsuFlc7KQW3AVKEHirLdb
 QagdlzfLVEgDpeYjXW+6R4sOH1/EgyX39byXJBUcjhG7qoQJTXRxNfvaIZ+sntnNJfQgl9C+hM
 jGAskOjAFv8JrZtewM+W14D9AAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734389751; l=2469;
 i=mgonellabolduc@dimonoff.com; s=20241119; h=from:subject:message-id;
 bh=HWkTxX+IpDGQNG52ogknWjClj9up9Mh0BRCF+szV+n0=;
 b=+42sxzvfPl1eT5ll3dVLEOTAVpMhKjB+BIa9Hp1ShMspCQwr4MNjOmWpFBA4PV2ff65lJSQ69
 li7jgfiYkhpAC6v6GDBLE+PgM85AeWASs1UeJObVqfu2R9IVyGtrDiV
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

 .../bindings/iio/light/brcm,apds9160.yaml          |   51 +
 MAINTAINERS                                        |    7 +
 drivers/iio/light/Kconfig                          |   11 +
 drivers/iio/light/Makefile                         |    1 +
 drivers/iio/light/apds9160.c                       | 1581 ++++++++++++++++++++
 5 files changed, 1651 insertions(+)
---
base-commit: 5de07b8a24cf44cdb78adeab790704bf577c2c1d
change-id: 20241119-apds9160-driver-86cf5e86de35

Best regards,
-- 
Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>



