Return-Path: <linux-iio+bounces-27538-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6137ED04769
	for <lists+linux-iio@lfdr.de>; Thu, 08 Jan 2026 17:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E737732E8B00
	for <lists+linux-iio@lfdr.de>; Thu,  8 Jan 2026 15:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6484A33FA;
	Thu,  8 Jan 2026 12:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yf7Ccz9z"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44ED480325;
	Thu,  8 Jan 2026 12:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767874516; cv=none; b=QyXFhSTtbq4vP2tjzxntBEeIyv3A0Ql6OGD5IBSQgNMsKydYIa5r4E/eamqLnTInEpcgIys1PcTECPUHOvFzUyeE5A7ctWlWigRC4HTjqoZEW4aKPk3RYCw0oBiV8TZfYslQOetYUKx20ZwMOgSweIrlZ9pQkDXzIeMhOQGXjy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767874516; c=relaxed/simple;
	bh=oBDZinY9Nh5D84J1Ns4d7Wu4t/l25XNvaZ8UJ6362WI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=L9AI0hDH+pw3cgOEiHvY0zf+ry9IyoekXnsAbBUaNV6nvQwg/pOLvZrZgo4LjBHcYh1hEI2KzvJKlEgHFTxGgibKNKIc5ymW0uURbfW1fe9rqOibbkfrxRDdMstnMXk3nTw3AKW3GjBh2iYnQBjoPUEx2BIA7ll/IZqo6jPIyPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yf7Ccz9z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1C7AEC116C6;
	Thu,  8 Jan 2026 12:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767874515;
	bh=oBDZinY9Nh5D84J1Ns4d7Wu4t/l25XNvaZ8UJ6362WI=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Yf7Ccz9zhSKaJnsXZOc6qcXEwG1mOb+vBWFcfQOGl9DrepkBwqufe1TH1Hd9z3tcn
	 TlcYPqyi7Lrdj6etZq0G4dC7nv84gjee3Np0XAJEdaCy6qjkzF71VssYCaQQ8VQvs8
	 EaU+C7hgdSgb29gpR9E8NYLWLccWZBaqFBdVO73wrYs/STTxT0arHktD/opZJurXO2
	 AtowHdgccloFDSomAczkY0T6PnyaBCH6F5Zw3dIL6hSZpI/3MmD6xD+49m6k/35Njm
	 V/iPOk08g+jQNos7h4SCitWsYlkxikqr666FuKih94sDMarUhYPTWazC8ZUY1twTyp
	 tA+c8/ngkv6pw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117E1D185EB;
	Thu,  8 Jan 2026 12:15:15 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Subject: [PATCH v3 0/6] ADF41513/ADF41510 PLL frequency synthesizers
Date: Thu, 08 Jan 2026 12:14:49 +0000
Message-Id: <20260108-adf41513-iio-driver-v3-0-23d1371aef48@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALmfX2kC/33NQQrCMBCF4atI1kYyibWpK+8hLqbNpB3QRhIJS
 undTbsRQVz+D+abSSSKTEkcN5OIlDlxGEuY7UZ0A449SXalhVa6AgAl0fk9VGAkc5AucqYoETu
 0WHurLIlyeY/k+bmq50vpgdMjxNf6JMOy/vcySCW187Yl5V13oBOOeA39rgs3sYBZfxANzW9EF
 6Ql3aA1rqob84XM8/wGS2mnQ/wAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767874513; l=2780;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=oBDZinY9Nh5D84J1Ns4d7Wu4t/l25XNvaZ8UJ6362WI=;
 b=Qd5KgcRRfQJFn4BzMgxYGSE4nES+ykF2gna/smPyX12Jj5WkQUVtNM8YXlBzFEXzfY9QpuV0y
 /77qAjE0E94CEoFN8lJBYjbTmTYBhkxEZFm1pQXbI3MTlqHGoCdSi4X
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
Changes in v3:
- Use FIELD_MODIFY macro in driver implementation
- Drop refin_frequency iio attribute
- Drop muxout-select property from dt-bindings (and rename logic-level property)
- Use -mhz suffix in power-up frequency property
- Address documentation issues
- Link to v2: https://lore.kernel.org/r/20251219-adf41513-iio-driver-v2-0-be29a83d5793@analog.com

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
      Documentation: ABI: testing: add common ABI file for iio/frequency

 Documentation/ABI/testing/sysfs-bus-iio-frequency  |   11 +
 .../bindings/iio/frequency/adi,adf41513.yaml       |  234 ++++
 Documentation/iio/adf41513.rst                     |  199 +++
 Documentation/iio/index.rst                        |    1 +
 MAINTAINERS                                        |   10 +
 drivers/iio/frequency/Kconfig                      |   10 +
 drivers/iio/frequency/Makefile                     |    1 +
 drivers/iio/frequency/adf41513.c                   | 1295 ++++++++++++++++++++
 8 files changed, 1761 insertions(+)
---
base-commit: fb2f4eb29a258145b0336601f00509cab6e93e7c
change-id: 20251110-adf41513-iio-driver-aaca8a7f808e

Best regards,
-- 
Rodrigo Alencar <rodrigo.alencar@analog.com>



