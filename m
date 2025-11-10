Return-Path: <linux-iio+bounces-26141-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F80C47ACD
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 16:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 782DB188A60A
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 15:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFF72749C5;
	Mon, 10 Nov 2025 15:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gt4mBKa3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68853213E6A;
	Mon, 10 Nov 2025 15:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789530; cv=none; b=F+f8x81nYfMVs1tbJNA57a/pvQUdGpCw9vcucLokcQQLo+IwSn916vTfNLEHYTZjXKEEYWE4nK6EKcNQGMhy4W1z0UQsZifzjx+uLM3HwdpOh1EDjSy4tGc1HqjYr3TliiC8XKTK8LVqyRPD2QbuZwjBy5TKMnowiWm2ChlerlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789530; c=relaxed/simple;
	bh=9poQJZ13bmkoyTIkEY6uFwCthMZYSqe1hiLBYCBG2RQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kVj5xDr7Dm0JfNtX4ceY2xXZYDvMPtorM9pfbGrKJWw57FGeXzzOQKi25fLMZAmhY6/kmmNJ5w9Ec29fdPjA+zY2/0EYBgULUBlLVCwZmSlWkkXB0hQnf10IoXLhrFuJkGa7pNehKwL9xMQds7Ra0Ix1Ty1eN1o8ZlWqYTnFqRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gt4mBKa3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4415C4CEF5;
	Mon, 10 Nov 2025 15:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762789529;
	bh=9poQJZ13bmkoyTIkEY6uFwCthMZYSqe1hiLBYCBG2RQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Gt4mBKa3osgTeMnDHqJYpvfWylJ+d6RPxfjGBZDjmgyLMzF6K7RAGpYraRX5/x7/h
	 E7fgWJ2wvDDDBEwnLk30jep9zoUuDf82QGglMfdKWRjJkAvtIs6zOr3XpmSY05PBYb
	 O6X/I94kpUnc6EU36Ahwdr3s5Rv7sCuFPnYkLEJ2hfk53se19jOd2+1xhOebCtc6Kg
	 5RGUu38V3CchA6NGLwuE2g1VgF3sz5XV8407V7Ll8OyZoTEDAeHSGSQq+GuijUwgqC
	 jE1L444PB8py3xvt87avWbDuXwXVSiWbMLr8SiaF0wN5Brh9cNEqVzxlydY87Ml979
	 VUuVJMp3EPWcg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AAECCFA1A;
	Mon, 10 Nov 2025 15:45:29 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Subject: [PATCH 0/3] ADF41513/ADF41510 PLL frequency synthesizers
Date: Mon, 10 Nov 2025 15:44:43 +0000
Message-Id: <20251110-adf41513-iio-driver-v1-0-2df8be0fdc6e@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGsIEmkC/x3MPQqAMAxA4atIZgONP1i8ijgEm2qWVlIQQby7x
 fEb3nugiKkUmJsHTC4tmlMFtQ1sB6ddUEM1dK4bicghhzjQSD2qZgymlxgyb+x5it55gVqeJlH
 v/7qs7/sBBLFJPWUAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762789528; l=2258;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=9poQJZ13bmkoyTIkEY6uFwCthMZYSqe1hiLBYCBG2RQ=;
 b=ph+VaieH/2Z1pTAj3636B8hO3V/PMBRLThavszgki4+Kc7lATv3vHdTtOy5DCLCeHLVYoUdj5
 1s4e+RFUqZ1BT0haeDUEgzR6apGngS/46uTGDhIOb5nODT6XVMdV5mY
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
operates from 1 GHz to 10 GHz. Both devices feature exceptional phase noise
performance and flexible frequency synthesis capabilities.

Key features supported by this driver:
- Integer-N and fractional-N operation modes
- Ultra-low phase noise (-235 dBc/Hz integer-N, -231 dBc/Hz fractional-N)
- High maximum PFD frequency (250 MHz integer-N, 125 MHz fractional-N)
- 25-bit fixed modulus or 49-bit variable modulus fractional modes
- Programmable charge pump currents with 16x range
- Digital lock detect functionality
- Phase resync capability for consistent output phase
- Clock framework integration for system clock generation

The series includes:
1. Core driver implementation with full register programming support
2. Device tree bindings documentation
3. IIO subsystem documentation with usage examples

The driver integrates with both the IIO subsystem (for direct hardware control)
and the Linux clock framework (for use as a system clock source), providing
flexibility for different use cases.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
Rodrigo Alencar (3):
      iio: frequency: adf41513: driver implementation
      dt-bindings: iio: frequency: add adf41513
      docs: iio: add documentation for adf41513 driver

 .../bindings/iio/frequency/adi,adf41513.yaml       |  268 ++++
 Documentation/iio/adf41513.rst                     |  377 +++++
 Documentation/iio/index.rst                        |    1 +
 MAINTAINERS                                        |    9 +
 drivers/iio/frequency/Kconfig                      |   11 +
 drivers/iio/frequency/Makefile                     |    1 +
 drivers/iio/frequency/adf41513.c                   | 1435 ++++++++++++++++++++
 7 files changed, 2102 insertions(+)
---
base-commit: d16d1c2553248f9b859b86c94344d8b81f0297cd
change-id: 20251110-adf41513-iio-driver-aaca8a7f808e

Best regards,
-- 
Rodrigo Alencar <rodrigo.alencar@analog.com>



