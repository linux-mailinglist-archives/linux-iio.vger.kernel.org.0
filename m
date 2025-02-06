Return-Path: <linux-iio+bounces-15077-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20918A2ACD8
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 16:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45E81188688C
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 15:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023D1231CA2;
	Thu,  6 Feb 2025 15:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OaMa6WbE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4754228CB7;
	Thu,  6 Feb 2025 15:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738856555; cv=none; b=OY9cw4j6NvCUjSVN3T5gDqxNluKSSYKqQwe92ynenCYfmzGrTSdNZ0TzFCDvd6TwWx6lv5pGE4cKCYf+gNHfKsdR28vVTPurwjRYtm1wN2yBuDnev+Fibj6efNU2WPUcP/wbs8EhGRYqLcoBhfn/wOVK4ZkitnbS7bIqqk3sbLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738856555; c=relaxed/simple;
	bh=1fOQzDV6HZJ2nN25yLU7hZ1P3TPmArQ54K7qLHm0wt0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=D0NgjkXTSJjOQIBBx6dsGlMI0T0zDo/nb7aw8/J9iM33fGhXGG+mkadCoMEbsprXs8XOm0mVW4RibyFUP+UF7v6z+Qd8Sfv0a+ljMxGLlgdONgnD9RT+6eMNsd1NMM5yQc5wifZxVaWhey7wwQsEBmzAK5O7CU4MliFtyOfh6Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OaMa6WbE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12586C4CEDD;
	Thu,  6 Feb 2025 15:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738856555;
	bh=1fOQzDV6HZJ2nN25yLU7hZ1P3TPmArQ54K7qLHm0wt0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=OaMa6WbEdZSXs9whDxmywhoKlZ0JJeQ5stHvw2RxNRbhiNh9vjojCjCsARSMNFIza
	 p5C8SvU936Jv9FD04FQ4dk17aNdZ38eAgyqNQ+LACMV+Yqg4VHHhHbwKsohJCJWEFI
	 MlvBNgUOOCOrQsShzx+hI2MFA3sbtfTvLVUzckZar22ir2oqEzOBgjFLC0F64ZUjDS
	 sb4pXD4owcpNuPi1h9oH/Dy9sXz3WJ9XYMEYPtHlPlpvFvboR9V5sesAHumALvtHS2
	 WWrHOxrdDFBR/bb+Tu9K4pt6ZKi4Yc2W0bv88r8CoV8QBMJFGjRoQ9mDxgxDVdgRzT
	 97lW4BNgpLIRQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BCDC02194;
	Thu,  6 Feb 2025 15:42:34 +0000 (UTC)
From: Tobias Sperling via B4 Relay <devnull+tobias.sperling.softing.com@kernel.org>
Subject: [PATCH v3 0/2] Support for TI ADS7128 and ADS7138 ADCs
Date: Thu, 06 Feb 2025 16:41:47 +0100
Message-Id: <20250206-adc_ml-v3-0-1d0bd3483aa2@softing.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADvYpGcC/2WM0QqCMBSGXyXOdYvt2KZ21XtEhM6jHkgXm4xCf
 PemUBBdfj//980QyDMFOO1m8BQ5sBsTZPsd2L4aOxLcJAaUeFQKUVSNvQ130ShLhaFC12ghnR+
 eWn5uocs1cc9hcv61daNa179EVEIKmZuyRVJ1bdU5uHbisTtYN8AaifgRtUSZfUVMYlHpMjdG2
 qzUv+KyLG+d9ek51wAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738856545; l=2986;
 i=tobias.sperling@softing.com; s=20241122; h=from:subject:message-id;
 bh=1fOQzDV6HZJ2nN25yLU7hZ1P3TPmArQ54K7qLHm0wt0=;
 b=EDhZjivm2O9mwyFHeORx+WauW1U4nzeS00mqk6I26KR0A+OjgJ+GiRdQyBsQO8xhOha5mygZE
 sXkn1loYnQtA73o2cnWWJCiCFgFHqyWz0OKd+GDYQrgOFyj6jlu8g4P
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
Changes in v3:
- Make interrupt optional.
- Replace SET_RUNTIME_PM_OPS() with RUNTIME_PM_OPS() to prevent warning.
- Rework read_avail for sampling frequency to show each frequency only
  once.
- Use IIO_CHAN_INFO_PEAK and IIO_CHAN_INFO_TROUGH instead of ext_info.
- Link to v2: https://lore.kernel.org/r/20250203-adc_ml-v2-0-8a597660c395@softing.com

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

Changes in v1 (to patch series without b4):
- dt-bindings: Extended description

Signed-off-by: Tobias Sperling <tobias.sperling@softing.com>

---
Tobias Sperling (2):
      dt-bindings: iio: adc: Introduce ADS7138
      iio: adc: Add driver for ADS7128 / ADS7138

 .../devicetree/bindings/iio/adc/ti,ads7138.yaml    |  62 ++
 drivers/iio/adc/Kconfig                            |  10 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/ti-ads7138.c                       | 746 +++++++++++++++++++++
 4 files changed, 819 insertions(+)
---
base-commit: 05dbaf8dd8bf537d4b4eb3115ab42a5fb40ff1f5
change-id: 20241122-adc_ml-d1ce86e85b2c

Best regards,
-- 
Tobias Sperling <tobias.sperling@softing.com>



