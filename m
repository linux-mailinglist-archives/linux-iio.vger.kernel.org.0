Return-Path: <linux-iio+bounces-5356-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BFB8D0903
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 19:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D59DD1F23024
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 17:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D60C15F311;
	Mon, 27 May 2024 17:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IP8Ckic+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6A6155CA5;
	Mon, 27 May 2024 17:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716829361; cv=none; b=N/YqihAAI4mrAP7sJYB7Wps5Yb8KO0fT7Dg4Zt1b1dqh9FpwY6ysTxlVa+fpDiO+Th5xUIhnXPtMZQjReioHs/1CzjuAhw0xmNTOeLpwVKq2V9Qdgc/M9x4es5TIV/63r6cT0CBs6D2kE9ENkjtcdxwLVq7enE5sAj2WyvSIMRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716829361; c=relaxed/simple;
	bh=cFDJY22wO2eKM07eqM2RIO2uLxMahT3mxSrHFfp82LA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ANCiVN28UTAlAi8Qb0uEULcNz0rPLop81KLkHJObgVq6K73wPBzJx/oILYGT8ZA1ayJPU9niK0aq2isa84BnoN2HXF6YuUqKnft/60kRbhDiGgtk/9WRqov96+FkNEJqAHuZg/GvUySGBn7U42Qg/OEsKCsfKoxHderyluoAZQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IP8Ckic+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0B7AC4AF09;
	Mon, 27 May 2024 17:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716829360;
	bh=cFDJY22wO2eKM07eqM2RIO2uLxMahT3mxSrHFfp82LA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=IP8Ckic+7YA2uTlZOCNtKgndmR1XcwTQWnldlY3FQM7mFuitA6qWmeQfcI3BOC6/c
	 ZvvFxiUhV74AJNTbCisQaHSmfHXzlX2s22sL3SIEOBi7qt5AdSA3+2EEuYoIW55Aag
	 aLk2/yVqcHdSL9YbgaGxuBL6EJZWOL+TPeDCI/DV8/kPyFdCHp3YC2eojezEUP2jZF
	 xIIqshyE/jV1RkABpggNYbvgWfacPcgrZTLc6eOhfmNnCtceHoRoYWK/C+AYBVkmmE
	 4kpD5tm7XpxgKL3SypOuRvPTvJk0l3pBApn+UmYqK5m2lVUboll0xhTF/sdxrB65DC
	 TpouHoDYVJG4A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877D3C25B74;
	Mon, 27 May 2024 17:02:40 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Subject: [PATCH v3 0/6] Add support for AD411x
Date: Mon, 27 May 2024 20:02:33 +0300
Message-Id: <20240527-ad4111-v3-0-7e9eddbbd3eb@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKm8VGYC/1WMywrCMBBFf6XM2kgmj2pd+R/iIkmnbUAbSSQop
 f9uWlFxeS73nAkSRU8JDtUEkbJPPowF5KYCN5ixJ+bbwiC4UFyiYKZViMh2RFYqssroDsr5Fqn
 zjzV0OhcefLqH+Fy7GZf1nVAcP4mMjDOpatybxjnNxdGM5hL6rQtXWBpZ/DyN6uuJ4onGUm20p
 s7qP2+e5xdnJVNX1QAAAA==
To: Ceclan Dumitru <dumitru.ceclan@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716829358; l=7573;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=cFDJY22wO2eKM07eqM2RIO2uLxMahT3mxSrHFfp82LA=;
 b=h49EarEVR3ljABeelwUC6br+05WdfNkNnylFHvevnfW+VdNj1PINJAIhy5deZtgDnjlSf0Sx5
 xLPJOhOupfoA2sJ3ssbu3D6ugR+NVmUpweYVMQZFuHqEmiy/jqAkeBf
X-Developer-Key: i=dumitru.ceclan@analog.com; a=ed25519;
 pk=HdqMlVyrcazwoiai7oN6ghU+Bj1pusGUFRl30jhS7Bo=
X-Endpoint-Received: by B4 Relay for dumitru.ceclan@analog.com/20240313
 with auth_id=140
X-Original-From: Dumitru Ceclan <dumitru.ceclan@analog.com>
Reply-To: dumitru.ceclan@analog.com

This patch series adds support for the Analog Devices AD4111, AD4112,
 AD4114, AD4115, AD4116 within the existing AD7173 driver.

  The AD411X family encompasses a series of low power, low noise, 24-bit,
sigma-delta analog-to-digital converters that offer a versatile range of
specifications. They integrate an analog front end suitable for processing
fully differential/single-ended and bipolar voltage inputs.

Particularities of the models:
- All ADCs have inputs with a precision voltage divider with a division
ratio of 10.
- AD4116 has 5 low level inputs without a voltage divider.
- AD4111 and AD4112 support current inputs (0 mA to 20 mA) using a 50ohm
shunt resistor.

Discussions from this patch series have concluded with:
-Datasheets mention single-ended and pseudo differential capabilities by
 the means of connecting the negative input of a differential pair (IN-)
 to a constant voltage supply and letting the positive input fluctuate.
 This is not a special operating mode, it is a capability of the
 differential channels to also measure such signals.

-Single-ended and pseudo differential do not need any specific
 configuration and cannot be differentiated from differential usage by
 the driver side =>
	offer adi,channel-type attribute to flag the usage of the channel

-VINCOM is described as a dedicated pin for single-ended channels but as
 seen in AD4116, it is a normal input connected to the cross-point
 multiplexer (VIN10, VINCOM (single-ended or differential pair)).
 This does not mean full functionality in any configuration:
 AD4111:"If any two voltage inputs are paired in a configuration other
 than what is described in this data sheet, the accuracy of the device
 cannot be guaranteed".

-ADCIN15 input pin from AD4116 is specified as the dedicated pin for
 pseudo-differential but from the datasheet it results that this pin is
 also able to measure single-ended and fully differential channels
 ("ADCIN11, ADCIN15. (pseudo differential or differential pair)";
  "An example is to connect the ADCIN15 pin externally to the AVSS
   pin in a single-ended configuration")

 As such, detecting the type of usage of a channel is not possible and
will be the responsability of the user to specify.
 If the user has connected a non 0V (in regards to AVSS) supply to
the negative input pin of a channel in a pseudo differential
configuration, the offset of the measurement from AVSS will not be known
from the driver and will need to be measured by other means.

Datasheets:
https://www.analog.com/media/en/technical-documentation/data-sheets/AD4111.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/AD4112.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/AD4114.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/AD4115.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/AD4116.pdf

This series depends on patches:
(iio: adc: ad7173: Use device_for_each_child_node_scoped() to simplify error paths.)
https://lore.kernel.org/all/20240330190849.1321065-6-jic23@kernel.org
(dt-bindings: iio: adc: Add single-channel property)
https://lore.kernel.org/linux-iio/20240514120222.56488-5-alisa.roman@analog.com/

And patch series:
(AD7173 fixes)
https://lore.kernel.org/all/20240521-ad7173-fixes-v1-0-8161cc7f3ad1@analog.com/

Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
---
Changes in v3:

iio: adc: ad7173: fix buffers enablement for ad7176-2
iio: adc: ad7173: Add ad7173_device_info names
iio: adc: ad7173: Remove index from temp channel
- Remove patches, send in separate series

dt-bindings: adc: ad7173: add support for ad411x
- fix VINCOM typo
- switch current channel definition to use single-channel
- remove pseudo-differential from adi,channel-type, specify that
  single-ended will be used for that case as well
- remove diff-channels from required, already defined in adc.yaml
- update constraints to not permit single-channel for models without
  current inputs

iio: adc: ad7173: refactor channel configuration parsing
- remove blank line from commit message

iio: adc: ad7173: refactor ain and vref selection
- remove blank space from commit message

iio: adc: ad7173: add support for special inputs
<no changes>

iio: adc: ad7173: Add support for AD411x devices
- remove pseudo diff channel type
- change current channels dt parsing to single-channel
- change module description from wild-card to "and similar"

iio: adc: ad7173: Reduce device info struct size
<no changes>

- Link to v2: https://lore.kernel.org/r/20240514-ad4111-v2-0-29be6a55efb5@analog.com

Changes in v2:

dt-bindings: adc: ad7173: add support for ad411x
- Add constraint for missing avdd2-supply on ad411x
- Change support for current channels to selecting the actual
   diff-channels input values and activating the
   adi,current-channel property
- Add constraint for adi,current-channel
- Add adi,channel-type to be able to differentiante in the driver
   between single-ended, pseudo-differential and differential channels.
- Update diff-channels description to decribe inputs beside the AINs

iio: adc: ad7173: fix buffers enablement for ad7176-2
- Specify ".has_input_buf = false" for AD7176-2
- Drop fixes tag, specify that configuration bits are read only

iio: adc: ad7173: refactor channel configuration parsing
- Add Link and Suggested-by in commit message

iio: adc: ad7173: refactor ain and vref selection
- Improve commit message to express commit purpose
- Refactor line wrappings due to reduced indent
- Change AINs check to a loop

iio: adc: ad7173: add support for special inputs
- Create patch

iio: adc: ad7173: Add ad7173_device_info names
- Create patch

iio: adc: ad7173: Remove index from temp channel
- Justify in commit message userspace breakage
- Remove index from the correct channel template

iio: adc: ad7173: Add support for AD411x devices
- Add missing validation for VCOM and inputs with voltage divider
- Add missing validation for AD4116 low level inputs
- Add missing ad7173_device_info names
- Add support for setting differential flag depending on the channel type
- Change current channel validation to use actual pin values
- Combine multiple chipID reg values in a single define
		(AD7173_AD4111_AD4112_AD4114_ID)
- Rename num_inputs and num_inputs_with_divider to include voltage
- Add comment to specify that num_voltage_inputs_with_divider does not
   include the VCOM pin.
- Change break to direct returns where possible in switch cases
- Add fix for ad411x gpio's

iio: adc: ad7173: Reduce device info struct size
- Create patch

- Link to v1: https://lore.kernel.org/r/20240401-ad4111-v1-0-34618a9cc502@analog.com

---
Dumitru Ceclan (6):
      dt-bindings: adc: ad7173: add support for ad411x
      iio: adc: ad7173: refactor channel configuration parsing
      iio: adc: ad7173: refactor ain and vref selection
      iio: adc: ad7173: add support for special inputs
      iio: adc: ad7173: Add support for AD411x devices
      iio: adc: ad7173: Reduce device info struct size

 .../devicetree/bindings/iio/adc/adi,ad7173.yaml    | 122 +++++-
 drivers/iio/adc/ad7173.c                           | 437 ++++++++++++++++++---
 2 files changed, 498 insertions(+), 61 deletions(-)
---
base-commit: af5b6543889edceed5eff3b74e3cfeece6c56c5e
change-id: 20240312-ad4111-7eeb34eb4a5f

Best regards,
-- 
Dumitru Ceclan <dumitru.ceclan@analog.com>



