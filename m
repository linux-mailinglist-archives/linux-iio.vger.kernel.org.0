Return-Path: <linux-iio+bounces-14934-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EB0A25FEE
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 17:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36D76166F9D
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 16:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73F220AF77;
	Mon,  3 Feb 2025 16:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Izkd5CRs"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAC620ADEA;
	Mon,  3 Feb 2025 16:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738600070; cv=none; b=oV5tIB/vMmS5UXXHmkdfl5b3ja5yHCZRS9CIGVGa1LfbL30gQ8LDPf7NAgNbQ1um30hApcWbFGqYq++c1aRjo6zQH3Z0pRKZl4EBWWw2Lgzq4gKOE4FK7ZGXZwu/bYM+SZwvWcTfOmpVWPUGeIJf36+S2q5mNHR6EC1lhZIpZFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738600070; c=relaxed/simple;
	bh=rgHM/p0hUnCDBMBm3G2zStxhJ9RTxF5vG/Ix46XgKSM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=n9Vcwjw9VvhVpd87HXHoS0A/E3jdpKCH1pNnSK6YxrCNi/pf1uEtiUbWGZKUa3UaMOff5LlFeKwpQHgBPGQ0sN2b7cw3S3YZF6wwnwIvOw/P5RPQIwCC/ZBeVCn1xk0udq+TWIsmYfldZWl5+ZOvQURq7JV8H2YX3s1YMu9G3Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Izkd5CRs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B71FC4CED2;
	Mon,  3 Feb 2025 16:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738600070;
	bh=rgHM/p0hUnCDBMBm3G2zStxhJ9RTxF5vG/Ix46XgKSM=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Izkd5CRs7Lrs1CiY3YvFGGp875cfk1oyaBvJCQ7qvD1EqII66Yy+D1WQTwNgnAtkr
	 pyyyj3qNwwwZ/kA2/09hUnTMYe+uFuxNdBC84w9b3o1Sr9UVra1nOP/53QNV75tfx9
	 E8kvSYK16A0gCCHEro2MsmWqsszjGzjgugEF4rqW1fsGGxykJr6EI2n7zulk6T3i6Z
	 uXoQXAdbsLlWEa+doQr16OaZ+eSKD8F5zoyt2y5XfJqQmcju1oVG7+rl7J+mInBep6
	 9+M3+/AgNrTEp6ZadAr5AzXvCzOhYExdNRNFhqtFHIVaI7ZXT9ex3B83R/IDPujhPg
	 dAqyfM9QvX0Ww==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D71C02192;
	Mon,  3 Feb 2025 16:27:50 +0000 (UTC)
From: Tobias Sperling via B4 Relay <devnull+tobias.sperling.softing.com@kernel.org>
Subject: [PATCH v2 0/2] Support for TI ADS7128 and ADS7138 ADCs
Date: Mon, 03 Feb 2025 17:27:33 +0100
Message-Id: <20250203-adc_ml-v2-0-8a597660c395@softing.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHbuoGcC/2XMQQrCMBCF4auUWRvJDFqrK+8hRdpk0g7YpiQlK
 CV3N3br8n88vg0iB+EIt2qDwEmi+LkEHSowYzcPrMSWBtJ0QiRSnTXP6aUsGm5qbs49GSjnJbC
 T9w492tKjxNWHz+4m/K1/REKllb7UV0eMfW/wHr1bZR6Oxk/Q5py/toQNIZ4AAAA=
X-Change-ID: 20241122-adc_ml-d1ce86e85b2c
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Tobias Sperling <tobias.sperling@softing.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738600069; l=2626;
 i=tobias.sperling@softing.com; s=20241122; h=from:subject:message-id;
 bh=rgHM/p0hUnCDBMBm3G2zStxhJ9RTxF5vG/Ix46XgKSM=;
 b=tNHR2Rfgc+XYhNaJ/oNv0PzrzHHSj8QdbBiKI6u8GC/UpVXMCcZoEAD2Ca67k3z5QFauPQ4Bx
 ahyGgtWmEuqCwy3b5vMq2/669INPikt4p5U9QnkedJtoBF9QI7jSxi9
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

---
Changes in v1 (to patch series without b4):
- dt-bindings: Extended description

Changes in v2:
- Improved commit messages.
- dt-bindings: drop info about what driver supports, make 'avdd-supply'
  optional.
- General rework of driver regarding indentation and code style.
- General code improvements to make code shorter and improve
  readability, like remove 'goto's, order of declarations, ...
- Use kernel macros and functions, like FIELD_*, guard(), ...
- Rework i2c functions to return 0 in case of success and use
  i2c_master_send() if possible.
- Use struct for chip data instead of enum.
- Add comment to what the lock is used for and make sure it's used in
  these cases.
- Use read_avail of iio_info and extend to return also the available
  values for OSR.
- Rework to only accept values of the availability list.
- Use devm_* if possible and therefore drop 'remove' callback.
- Rebase to kernel 6.13 and adjust to API changes.
- Link to v1:
  https://lore.kernel.org/r/20241122-adc_ml-v1-0-0769f2e1bbc1@softing.com

Signed-off-by: Tobias Sperling <tobias.sperling@softing.com>

---
Tobias Sperling (2):
      dt-bindings: iio: adc: Introduce ADS7138
      iio: adc: Add driver for ADS7128 / ADS7138

 .../devicetree/bindings/iio/adc/ti,ads7138.yaml    |  62 ++
 drivers/iio/adc/Kconfig                            |  10 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/ti-ads7138.c                       | 755 +++++++++++++++++++++
 4 files changed, 828 insertions(+)
---
base-commit: 05dbaf8dd8bf537d4b4eb3115ab42a5fb40ff1f5
change-id: 20241122-adc_ml-d1ce86e85b2c

Best regards,
-- 
Tobias Sperling <tobias.sperling@softing.com>



