Return-Path: <linux-iio+bounces-27189-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41385CCFE4C
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 13:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9E0C309EC5F
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 12:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E27346A02;
	Fri, 19 Dec 2025 12:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uNFwTiL7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDAE346782;
	Fri, 19 Dec 2025 12:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766147693; cv=none; b=GDidRT01GI8yY85N+yz+LIKbBRMFwVPnQ2o3lYj3ZeW/NpHa60cc0kFgkVOSVRNrp6yPYXM516Opnx6s95YTJb4vBiWus6UUeYZjYJNeqqTLOLJRTeeP9zDKH5M3Q6bHouc7/oSEvyqEJikChml88W+cZ8JZxuutlMz4V4DdZj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766147693; c=relaxed/simple;
	bh=sqgwzniAZ/2pfeFn6PJ1VjhBOf9YLXIh2LImEpKrknA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Rtx/YtMJqLNtjnNlj8HXv5NFbFzQXHnXaJrSLFbjF+fi9VSkkKcWzSLWZMoGrJ8NpAKzAYteHUNeQd1c2lmyLGA03Xeyjzz2SUkspt6G3oba3INyKWMmQ7JTdG/oFbgCCDkRnIk4SgBlQrgruV27HPc+Gmyt7QS8bY+rK0HNWEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uNFwTiL7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9D0CAC113D0;
	Fri, 19 Dec 2025 12:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766147693;
	bh=sqgwzniAZ/2pfeFn6PJ1VjhBOf9YLXIh2LImEpKrknA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=uNFwTiL7eMvrjl1ubJbi156XS7QOSb8sVKaT5E7e8p+T0VFVG37rW22iDSwBz1umd
	 nTMJzmS9WqiPcKilkl2XGc1pJFcOG/ynmYzYXmUUIzmfZuYQLAeOw4YBksQeiAOKzm
	 jTK1d2RnEyYpuymTEkrP5JhEvWynOr3GpIBDTStJ1eUGrhHW5kSQqJkdHs2/X2jZip
	 jIYWf3IHGeFgEBdMftrHBbvXWHuSifp+wge9ujwPXtg7ox2Q0KFtnltIHy/ggt1m52
	 x+FV551AoKnceZYRpG4H5ZvMR9PWZAuRfk3id2ZXgYf2nDpHvq6tHbXvhKucV1zXjX
	 YL/4U0DoEMXhw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93558D767EE;
	Fri, 19 Dec 2025 12:34:53 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Subject: [PATCH v2 0/6] ADF41513/ADF41510 PLL frequency synthesizers
Date: Fri, 19 Dec 2025 12:34:47 +0000
Message-Id: <20251219-adf41513-iio-driver-v2-0-be29a83d5793@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGdGRWkC/32NQQrCMBBFryKzdiQTrQZX3kO6GJNJO6CNJBKU0
 rsbewCX78F/f4YiWaXAeTNDlqpF09TAbjfgR54GQQ2NwRrbEZFBDvFAHe1RNWHIWiUjs2fHp+i
 ME2jLZ5ao77V67RuPWl4pf9aTSj/7v1cJDdoQ3U1MDP4oF574noadTw/ol2X5AuoIJUW3AAAA
X-Change-ID: 20251110-adf41513-iio-driver-aaca8a7f808e
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766147692; l=2398;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=sqgwzniAZ/2pfeFn6PJ1VjhBOf9YLXIh2LImEpKrknA=;
 b=IAq3uS794270XTaJ3MbTU1aVJDUYE9VZcZ+kW7zTedhpTfyHkH+tvzEs7TpHjgYowR83CNI2J
 dJZmPd1gDaaDW7Lxj8ixQ1DTEYbppndZyHPNlAZmu4/IUeHov7S0ihJ
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

This patch series adds support for the Analog Devices ADF41513 and ADF41510
ultralow noise PLL frequency synthesizers. These devices are designed for
implementing local oscillators (LOs) in high-frequency applications.
The ADF41513 covers frequencies from 1 GHz to 26.5 GHz, while the ADF41510
operates from 1 GHz to 10 GHz.

Key features supported by this driver:
- Integer-N and fractional-N operation modes
- High maximum PFD frequency (250 MHz integer-N, 125 MHz fractional-N)
- 25-bit fixed modulus or 49-bit variable modulus fractional modes
- Digital lock detect functionality
- Phase resync capability for consistent output phase
- Load Enable vs Reference signal syncronization

The series includes:
1. PLL driver implementation
2. Device tree bindings documentation
3. IIO ABI documentation

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
Changes in v2:
- separate driver implementation from extra features and improve commit messages
- use macros from units.h
- explanation of custom parse function: adf41513_parse_uhz
- reorganize driver data structures
- drop clock framework support for now
- reorganize documentation
- Link to v1: https://lore.kernel.org/r/20251110-adf41513-iio-driver-v1-0-2df8be0fdc6e@analog.com

---
Rodrigo Alencar (6):
      dt-bindings: iio: frequency: add adf41513
      iio: frequency: adf41513: driver implementation
      iio: frequency: adf41513: handle LE synchronization feature
      iio: frequency: adf41513: features on frequency change
      docs: iio: add documentation for adf41513 driver
      Documentation: ABI: testing: add support for ADF41513

 .../ABI/testing/sysfs-bus-iio-frequency-adf41513   |   27 +
 .../bindings/iio/frequency/adi,adf41513.yaml       |  246 ++++
 Documentation/iio/adf41513.rst                     |  255 ++++
 Documentation/iio/index.rst                        |    1 +
 MAINTAINERS                                        |   10 +
 drivers/iio/frequency/Kconfig                      |   10 +
 drivers/iio/frequency/Makefile                     |    1 +
 drivers/iio/frequency/adf41513.c                   | 1378 ++++++++++++++++++++
 8 files changed, 1928 insertions(+)
---
base-commit: a7b10f0963c651a6406d958a5f64b9c5594f84da
change-id: 20251110-adf41513-iio-driver-aaca8a7f808e

Best regards,
-- 
Rodrigo Alencar <rodrigo.alencar@analog.com>



