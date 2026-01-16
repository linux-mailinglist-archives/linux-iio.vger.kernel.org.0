Return-Path: <linux-iio+bounces-27855-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1344BD32A88
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 15:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B02D307752B
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 14:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320DD393415;
	Fri, 16 Jan 2026 14:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ukahvETz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50D7392C3A;
	Fri, 16 Jan 2026 14:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768573958; cv=none; b=NaVlQEapoZBg12eKSmDoOgeYjLOuk06OgLgKHTS+9Xhh9IeB6QqGcMyP8F0/rXllaaeoMoZF4FDJSAFDeUZgkBQUbxw1VmQg++hqoSg3GEjupgv8ZjOdAf826JGmBxxbgcdeigQkIVhG4wfejePjItFEw4ZqAdgjCvXbm/DMr/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768573958; c=relaxed/simple;
	bh=W1PCOuxQA9A2tP9QuthJCHiDAoHE0mj5IZ5fHnrMt8Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mBcwufdu/C5S7volD6LoeH3tusM4lG8opfNKoRfQJI8SyVXWVmqh1y4xZoRibMdaXNbO/LlUu1FgR1D1BWWvX13igePPvRYpE7zd2gakdTJJ85WJXyfwpYgWTTAxnJlU1uMuOmUfzfmQoZ85vz/YRNxplY7XFv0V3+dBRCM11II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ukahvETz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77B2CC116C6;
	Fri, 16 Jan 2026 14:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768573958;
	bh=W1PCOuxQA9A2tP9QuthJCHiDAoHE0mj5IZ5fHnrMt8Q=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ukahvETznrJOUVlhjWKJAsZEv/yhPm8BtzsV19AmG7zCS0I2Rx1MHxU+DCPHO+Xax
	 OIWGRhy578Nnmgp786Qqnc7ivoY9NRkVl4buc1gEoqavrwBCwbBVIE6sScpRfhrYpr
	 5u0Lw/735hnAxoxr6yPlA6sO19QiYBqjpMn/dAPpcyOyO11NmEkK/3PLDzwp2Ph2Tv
	 TvZ0MFG+kKYuEWopyNJ4MFNLAYf3sun+KHNRbcg2xhLgxjJjQ3Nh5H8WQ1Vo9fRlFF
	 lB0BiM4weZmyJ+hamjUTl9OzvvvW+OCyEzd9bvipN+5LlfGXVopJOZEifBdPC/Eyot
	 GmfSQJoHmhtZg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A21C79FBF;
	Fri, 16 Jan 2026 14:32:38 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Subject: [PATCH v4 0/7] ADF41513/ADF41510 PLL frequency synthesizers
Date: Fri, 16 Jan 2026 14:32:19 +0000
Message-Id: <20260116-adf41513-iio-driver-v4-0-dbb7d6782217@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPNLamkC/33OzQrCMAzA8VcZPVtp2n10nnwP8RDX1AV0lU6KI
 nt3u4GIKB7/gfyShxgpMo1iUzxEpMQjhyFHuSpE1+NwJMkut9BKVwCgJDpfQgVGMgfpIieKErF
 Di423ypLIm5dInm+Lutvn7nm8hnhfjiSYp/+9BFJJ7bw9kPKuq2mLA57Ccd2Fs5jBpN+IhvY3o
 jNyIN2iNa5qWvOFmBdSK1D2N2LmT4wD0wCSL+0HMk3TE4fQ9YVBAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768573956; l=3158;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=W1PCOuxQA9A2tP9QuthJCHiDAoHE0mj5IZ5fHnrMt8Q=;
 b=GNLIGcVH6An//1BSFYh5sTuZY1j5u0Zfqs06uG4U5di+kCt+9JDzCuJ+6HBCWRrD4P74za+G6
 5qLKlritDkfCwDcx28Xa2I+K4sc6q68ryAaB71Xk0jXQpsDxhqPhHcJ
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
Changes in v4:
- Proper usage of units.h macros
- Simplifications to DT property parsing
- Adjustments to return value handling
- Drop of simple DT property node example
- Link to v3: https://lore.kernel.org/r/20260108-adf41513-iio-driver-v3-0-23d1371aef48@analog.com

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
Rodrigo Alencar (7):
      dt-bindings: iio: frequency: add adf41513
      units: Add HZ_PER_GHZ definition
      iio: frequency: adf41513: driver implementation
      iio: frequency: adf41513: handle LE synchronization feature
      iio: frequency: adf41513: features on frequency change
      docs: iio: add documentation for adf41513 driver
      Documentation: ABI: testing: add common ABI file for iio/frequency

 Documentation/ABI/testing/sysfs-bus-iio-frequency  |   11 +
 .../bindings/iio/frequency/adi,adf41513.yaml       |  212 ++++
 Documentation/iio/adf41513.rst                     |  199 +++
 Documentation/iio/index.rst                        |    1 +
 MAINTAINERS                                        |   10 +
 drivers/iio/frequency/Kconfig                      |   10 +
 drivers/iio/frequency/Makefile                     |    1 +
 drivers/iio/frequency/adf41513.c                   | 1295 ++++++++++++++++++++
 include/linux/units.h                              |    1 +
 9 files changed, 1740 insertions(+)
---
base-commit: b82f3047dae4aba38cb26c55c28444db4d77f521
change-id: 20251110-adf41513-iio-driver-aaca8a7f808e

Best regards,
-- 
Rodrigo Alencar <rodrigo.alencar@analog.com>



