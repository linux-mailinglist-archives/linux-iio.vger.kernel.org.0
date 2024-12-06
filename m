Return-Path: <linux-iio+bounces-13161-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBF19E752A
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 17:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A28EF28A2B8
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 16:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CF720DD64;
	Fri,  6 Dec 2024 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJ2x5g+I"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2958120CCF7;
	Fri,  6 Dec 2024 16:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733501409; cv=none; b=vAscenazOkgdSQJ/H1t+4CYa6RacYfaNov6psGJCOLxWULZLuJMOTxLmQMHuoPpv/g56/jG8zGOltPQ5er0Vs4m6DSGLoHXRY3oD0fHcSAVxj6mvfffYW8OZKAR3QKGXdgRdPTZiZUeWYBkK40z8qwtb4mHKHI2YuZSz7Mc7SmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733501409; c=relaxed/simple;
	bh=ZdXL/CQ2TrjNMSokVHxllGZV1S32vZjn0gN4B66uxck=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cpDhLH4B5DRak1uz70+a5BMA70jx+i7pDfLl7vyUUDkiO20nzrPX60pXxjB15MLGIEca+1qVlXnexd0CAu2U1m7gJjFlvIpsbo6qOQDSYOgrr22qkDcK70Qdkc0Maih3rAOOty7SL/iCNOt6Txo8BQeThQJwaNec/fubRK4gbX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJ2x5g+I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9DEA3C4CED1;
	Fri,  6 Dec 2024 16:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733501408;
	bh=ZdXL/CQ2TrjNMSokVHxllGZV1S32vZjn0gN4B66uxck=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=aJ2x5g+IG1DtpROmC4bv7aHFGyfDyWImX8q/3V1KeY7dTNmcQKhISJShWtzf6QAoH
	 NMmfsd2LEELgAZErTHKLsJbG8shKTVr3N6oARUl5EcFKyL/2eYQsTUdDawnvFpAhHf
	 rpDbGxw15Xl5wajl4ttN8IeDDiauESV7yDuOrqpNe8AyYrSXXMjpywrlCE5OiFwRjM
	 4E/xCFVLRZA2fwgqwuUJ+L1e6C+v0940pUufzTdM12w7VW9fTNMbBcCqhHuq4KGEnD
	 YsaLhr7UWrbsoqOg3aJxRgEZ6JBGzl9h5C3TI1M9+LAyJZGT7C2v2sL9k9Ium0IcHO
	 YIwaRQEFIE8bQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FF4E77173;
	Fri,  6 Dec 2024 16:10:08 +0000 (UTC)
From: Mikael Gonella-Bolduc via B4 Relay <devnull+mgonellabolduc.dimonoff.com@kernel.org>
Subject: [PATCH v2 0/2] Add support for Avago/Broadcom APDS9160
Date: Fri, 06 Dec 2024 11:09:55 -0500
Message-Id: <20241206-apds9160-driver-v2-0-be2cb72ef8f4@dimonoff.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANMhU2cC/3WNwQ7CIBAFf6XZsxhAwLYn/8P0gLDYPbQ0YIim4
 d/F3j3OJG/eDhkTYYax2yFhoUxxbSBPHbjZrk9k5BuD5FIJIQZmN58HYTjziQom1hsXNPbG40V
 DW20JA72P4n1qPFN+xfQ5Dor42f+tIhhnwXJurvqh0KqbpyWuMYSziwtMtdYv0NGsPbEAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733501407; l=1809;
 i=mgonellabolduc@dimonoff.com; s=20241119; h=from:subject:message-id;
 bh=ZdXL/CQ2TrjNMSokVHxllGZV1S32vZjn0gN4B66uxck=;
 b=LYaNcKYSA/mz/IKt8GbypsXX7TjSie6ppUscAoJrTJ1eBPqc15dhk/wWRbKSaAZZHupMyqk5D
 0OA7zAVhmmxB+lDWhinb0vR42ydFe+a61FRGClaWo47xhwDFhCFByWd
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
 drivers/iio/light/apds9160.c                       | 1548 ++++++++++++++++++++
 5 files changed, 1618 insertions(+)
---
base-commit: 5de07b8a24cf44cdb78adeab790704bf577c2c1d
change-id: 20241119-apds9160-driver-86cf5e86de35

Best regards,
-- 
Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>



