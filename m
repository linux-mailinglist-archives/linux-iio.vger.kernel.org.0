Return-Path: <linux-iio+bounces-23517-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B24BB3D227
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 12:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DC6C17AB58
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 10:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7BA256C6C;
	Sun, 31 Aug 2025 10:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="XgxVDxrJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B39212566;
	Sun, 31 Aug 2025 10:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756636423; cv=none; b=fXwE9DKQCFRRARTTIzL2Nu15PfgTVr18M8XD9ERK6QGrjfiPpa/z/vbBaGqn42+4QlTb8Ziqj64gP47puL4mmo9Xm7nWxTS0iJ068s0O5JYbZTJZUqcNITc6rsREEV0/mF1+GG8CdBIZCN4HOh7XH36r0m7+EIlpKe0au0EeoLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756636423; c=relaxed/simple;
	bh=ope+mfKis5PHmRi4hHU32TZUCGyXa9GWHFlOjUlR70o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mFHn00jMM7aJIBKDe/Y6+B8vorKsfkQoN4KVnSQ90u6eevM+Lgh5udJ4ufFHP4KZekDijLyPxOo7Dv0DE5HX66wd7QWIJjHcWyctgc4kufF6DZSvHDUDZx0/Gpd5u43mjBXW72D1SDcFo3jx4Ra1MnQYvjJNzYjB8besihlYyD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=XgxVDxrJ; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
DKIM-Signature: a=rsa-sha256; bh=xPcQftlnTMJXqDvzSyQmVAo4telOxyGxWkU01QZoEeA=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:Message-Id:Message-Id:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1756636408; v=1; x=1757068408;
 b=XgxVDxrJF8Gczy0R51NJGwjF9A+6o6FWJxuhSQQmIXwhvPbf7eN1p3SXsPLGkXnOFVBnuIaC
 kAL1mB7zpMk8N8huusb30pWsloiwNTPYycpgIVsjdeBG9sx7bvfMXzJDXlCMfLnOlpaOTb530ri
 3t0accMxVpDjOSFX/qV76/U3uLbt5GbcPuCA9PQ+tPo04bnJsjlZMfPnQyWs3BGX82AxwO2yPhw
 D9yiQ9qEb5wL951XsoZetfLa7BMJX7qjnFTOs4YwlKob1ALCLrfgpXl7SuSlh9PVlK+AGp60BLs
 pelySZjXz93fnEAcpc4AyX0ekgRx+ojVbIqXnRhjDQrQA==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id 5a3db84b; Sun, 31 Aug 2025 12:33:28 +0200
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Subject: [PATCH v2 0/3] Marvell 88PM886 PMIC GPADC driver
Date: Sun, 31 Aug 2025 12:33:03 +0200
Message-Id: <20250831-88pm886-gpadc-v2-0-759c1e14d95f@dujemihanovic.xyz>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAN8ktGgC/13OTQrCMBCG4auUWRtJBhqjK+8hXYRk2o7QH5IaW
 kvubiy4cfl+MA+zQ6TAFOFW7RAoceRpLIGnClxvx44E+9KAEmtp8CKMmQdjtOhm650witBZ5Wt
 0BOVmDtTyeniPpnTPcZnCdvBJfdefdP2TkhJStFqiRtS6JXv3rycNXJ6YErvzur2hyTl/ANJce
 /iyAAAA
X-Change-ID: 20250827-88pm886-gpadc-81e2ca1d52ce
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Karel Balej <balejk@matfyz.cz>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: David Wronek <david@mainlining.org>, phone-devel@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1272;
 i=duje@dujemihanovic.xyz; s=20240706; h=from:subject:message-id;
 bh=ope+mfKis5PHmRi4hHU32TZUCGyXa9GWHFlOjUlR70o=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBlbVL5L2J3fzC+3u36G5e1QI4/I55eZlURZzTZ0S4d/s
 j+m8WdBRykLgxgXg6yYIkvuf8drvJ9Ftm7PXmYAM4eVCWQIAxenAEzkYAbDP4uXCbpFDIxbw27f
 Wnk4/m/p2WfZLXP61/Ra9QqLTO98VMXwzyZou1vRBVn7mGnsVocS9t9z3BWZ+OhK54Js5VNucq1
 3uAA=
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

This series adds a driver for the GPADC found on the Marvell 88PM886
PMIC. The GPADC monitors various system voltages and is a prerequisite
for battery monitoring on boards using the PMIC.

Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
Changes in v2:
- Refactor driver according to comments
- Add binding patch
- Link to v1: https://lore.kernel.org/r/20250829-88pm886-gpadc-v1-0-f60262266fea@dujemihanovic.xyz

---
Duje Mihanović (3):
      dt-bindings: mfd: 88pm886: Add #io-channel-cells
      iio: adc: Add driver for Marvell 88PM886 PMIC ADC
      mfd: 88pm886: Add GPADC cell

 .../bindings/mfd/marvell,88pm886-a1.yaml           |   4 +
 MAINTAINERS                                        |   5 +
 drivers/iio/adc/88pm886-gpadc.c                    | 383 +++++++++++++++++++++
 drivers/iio/adc/Kconfig                            |  13 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/mfd/88pm886.c                              |   1 +
 include/linux/mfd/88pm886.h                        |  54 +++
 7 files changed, 461 insertions(+)
---
base-commit: 1b237f190eb3d36f52dffe07a40b5eb210280e00
change-id: 20250827-88pm886-gpadc-81e2ca1d52ce

Best regards,
-- 
Duje Mihanović <duje@dujemihanovic.xyz>


