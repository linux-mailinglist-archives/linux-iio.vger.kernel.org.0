Return-Path: <linux-iio+bounces-12494-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F4A9D6134
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 16:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 741B3280FCA
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 15:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5FE1DE2BD;
	Fri, 22 Nov 2024 15:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2qelVv6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17597083D;
	Fri, 22 Nov 2024 15:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732288554; cv=none; b=hmzirCxxZkh5mzUreDDgsdNTNzEmAM3uFPZLwsOGeWuve5cWYH3LMnr8XiQqBaZKQZfcUwiriwSSmbyeLH7fSJLWcuEZskBRPAwoxvP4wa+K5nPZSTMloRFXm6p/gNemulN+xFJP63LVkS73R7b2oJa02O46IdS+vNsbGVvBbBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732288554; c=relaxed/simple;
	bh=TGa7Of0k80PmwcFhPdThmmvF7lbiviqdPAM1Y997XAU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UuTbnE8wha20IcK4LaoUC/u3UxSQrR0GxLSAkwcckQSniQ3gqf8DGJPRaAr0dRcT918d7ZgZQ+ObXmzJ4WniMZUloTLwdkKMXZ0k+aCYN4pzwBaGb6m0TPJSQNJaMQ5Gu9SbllS1mGDaHaVPa1M9s3soV1ul7oxwkcJCnn9G7mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2qelVv6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 918CDC4CECE;
	Fri, 22 Nov 2024 15:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732288553;
	bh=TGa7Of0k80PmwcFhPdThmmvF7lbiviqdPAM1Y997XAU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=e2qelVv6R+Is4QJWMDe9vhMZUulwl+2euEMrW/Jewr9QT6K/uBcqhio8GRIIAp33q
	 4zaCQCs1kgdVTWBWT4j1cvDUBzXC39bmhs8rpXavbIOXxlKAW79WTDZB6tWgMTlwPn
	 rgFztAk8DSNUpr+kGgVez14dGxYXV22JcBRLxBJOfgRkyWovO7olII8musSOzEtSeE
	 LnWsisvs08UQw0I16GX5Tfxxl2J/vLTq38nt5wloh/c47Jb+7tNzvhLRfgm1YGS5wI
	 0MwO79lHhhYsnQXNhMs5zmqxbRwArEQzPzZ9TAcc7WmZY5ezK+fl6PrsqPQuyBqbir
	 YMrAZ9dODZXrA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F5BE6916F;
	Fri, 22 Nov 2024 15:15:53 +0000 (UTC)
From: Tobias Sperling via B4 Relay <devnull+tobias.sperling.softing.com@kernel.org>
Subject: [PATCH 0/2] Support for TI ADS7128 and ADS7138 ADCs
Date: Fri, 22 Nov 2024 16:15:35 +0100
Message-Id: <20241122-adc_ml-v1-0-0769f2e1bbc1@softing.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABegQGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQyMj3cSU5PjcHN0Uw+RUC7NUC9Mko2QloOKCotS0zAqwQdGxtbUA/2k
 grlgAAAA=
X-Change-ID: 20241122-adc_ml-d1ce86e85b2c
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Tobias Sperling <tobias.sperling@softing.com>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732288552; l=1621;
 i=tobias.sperling@softing.com; s=20241122; h=from:subject:message-id;
 bh=TGa7Of0k80PmwcFhPdThmmvF7lbiviqdPAM1Y997XAU=;
 b=vaDfFwv9U9SBeSnnomZ3qhMudcfqPeU9OqSxBVHX7QlW7lY2WZg4ZysWJbp7pCrEg6fMqSDw+
 2mrkok1/BQ3BDUHotcBbPSsWhWJR5ESTKny1J0lm55NuuFp/BXdFRrE
X-Developer-Key: i=tobias.sperling@softing.com; a=ed25519;
 pk=v7hgaMHsrA9ul4UXkBVUuwusS9PF3uHW/CC+gABI65E=
X-Endpoint-Received: by B4 Relay for tobias.sperling@softing.com/20241122
 with auth_id=281
X-Original-From: Tobias Sperling <tobias.sperling@softing.com>
Reply-To: tobias.sperling@softing.com

This patch series adds support for Texas Instruments ADS7128 and
ADS7138, which are 12-bit, 8 channel analog-to-digital converters (ADCs)
with build-in digital window comparator (DWC), using the I2C interface.

The driver exposes the interfaces to read the raw values, as well as the
minimum and maximum value for each channel. In addition several settings
can be configured, like the DWC, sampling frequency or an averaging
filter/oversampling. Interrupts triggered by the DWC, if configured, are
then exposed as IIO events.

ADS7128 differs in the addition of further hardware features, like a
root-mean-square (RMS) and a zero-crossing-detect (ZCD) module, which
are not yet supported by the driver.

Regarding the I2C interface the chips using opcodes to define the way
how the registeres are accessed, like single or multiple register(s)
read/write or setting/clearing only bits. 

Changes in v1:
- dt-bindings: Extended description

Signed-off-by: Tobias Sperling <tobias.sperling@softing.com>
---
Tobias Sperling (2):
      dt-bindings: iio: adc: Introduce ADS7138
      iio: adc: Add driver for ADS7128 / ADS7138

 .../devicetree/bindings/iio/adc/ti,ads7138.yaml    |  64 ++
 drivers/iio/adc/Kconfig                            |  10 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/ti-ads7138.c                       | 796 +++++++++++++++++++++
 4 files changed, 871 insertions(+)
---
base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
change-id: 20241122-adc_ml-d1ce86e85b2c

Best regards,
-- 
Tobias Sperling <tobias.sperling@softing.com>



