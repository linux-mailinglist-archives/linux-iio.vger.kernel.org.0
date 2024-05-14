Return-Path: <linux-iio+bounces-5027-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E03928C4CC9
	for <lists+linux-iio@lfdr.de>; Tue, 14 May 2024 09:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 964E828266D
	for <lists+linux-iio@lfdr.de>; Tue, 14 May 2024 07:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B422031D;
	Tue, 14 May 2024 07:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PiKJY3Ru"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9423D1DFFB;
	Tue, 14 May 2024 07:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715671398; cv=none; b=QIhVRTQe/H3B5iLfG/+3CNsRehEm7oIvQouQ5+SlDCySVD5W/lw09x3vVk3lc7Ar5htNWzuJa3lyqrG+oarw8SYkzD1H4PPkjS08QdyAK8wAKDHPL/DM4BgiFgdoa2xuIIGXeFYpAHF2zbaMj7R3W4hKoJ7pa2NE/fZGhYQ2BGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715671398; c=relaxed/simple;
	bh=3bcxwx7sfw8ExkjnXW8neKCzL9NjAQifAMy4d7Pc3gk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iKNPCNJ2H+soQBXOOvfWFwQEwaf8XDiYclAZVSAXUiAY/bbh/bFYmeaaEimafZ6tlGGHlxq70oVhjqk4kln2jj6t74MJMKnTg+b6hVKT+HBv+deOK8KaMZpEURK8hfgfEL+etCVrU27uh9T7VDSVKE0PNAwslT22wVhvuc8D5Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PiKJY3Ru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2942BC4AF0A;
	Tue, 14 May 2024 07:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715671398;
	bh=3bcxwx7sfw8ExkjnXW8neKCzL9NjAQifAMy4d7Pc3gk=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=PiKJY3RuSk3b0iWQI/TNHXIQFjUlbnxgF6FBbF3qpI/wELvzgkGfSBnnjYRJZ+K40
	 h5bF4gm8i0B9Qt80ENKUPBWi3VG9ziNDLnS4pLD3nFrITuHJBF8Urix0VRGfKERx95
	 6mCkWbmHTy9TcYEf3GBbD4chd1A9PFgcwirjoVSAhjheqn2plsoEQgAk8ZjMEMkbIU
	 7smlWBW7xc/nhrYHWh+AIbj2bpM3ar757AWmbOQiJM1QtQvXA4albG5KBIFDttiogZ
	 ftHy5NAEecJwFO2Rx/oREOAOTJgP9RfZwQSQ7bvuU6U6I+cBZqUbi1Ynf8q8jJrEdI
	 +JzTau80xDTmw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18043C25B75;
	Tue, 14 May 2024 07:23:18 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Subject: [PATCH v2 0/9] Add support for AD411x
Date: Tue, 14 May 2024 10:22:45 +0300
Message-Id: <20240514-ad4111-v2-0-29be6a55efb5@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEURQ2YC/zXMyw7CIBCF4VdpZi2Ggam3le9huqB02pIoNGCIp
 uHdxRqX/8nJt0Li6DjBpVkhcnbJBV9D7Rqws/ETCzfUBiUVSY1KmIEQURyZe03ck2lHqOcl8uh
 eG3Tras8uPUN8b27G7/ojSOKfyCik0HTAkzlb20p1Nd7cw7S34QFdKeUD8nmS+J0AAAA=
To: Ceclan Dumitru <dumitru.ceclan@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715671396; l=6250;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=3bcxwx7sfw8ExkjnXW8neKCzL9NjAQifAMy4d7Pc3gk=;
 b=3pQ94uO81s0//8XuVGtezlkkET09/clzgXKTYhvLUbvh05IcCoou4f+U2Sl+bz7fqsGj5xA9l
 zw22lFP1GvDAtMw32ZUVIQ1VZQnO41qoMi5FXoaLp+mCJrC1n46C0FL
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

This series depends on patch:
(iio: adc: ad7173: Use device_for_each_child_node_scoped() to simplify error paths.)
https://lore.kernel.org/all/20240330190849.1321065-6-jic23@kernel.org

Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
---
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
Dumitru Ceclan (9):
      dt-bindings: adc: ad7173: add support for ad411x
      iio: adc: ad7173: fix buffers enablement for ad7176-2
      iio: adc: ad7173: refactor channel configuration parsing
      iio: adc: ad7173: refactor ain and vref selection
      iio: adc: ad7173: add support for special inputs
      iio: adc: ad7173: Add ad7173_device_info names
      iio: adc: ad7173: Remove index from temp channel
      iio: adc: ad7173: Add support for AD411x devices
      iio: adc: ad7173: Reduce device info struct size

 .../devicetree/bindings/iio/adc/adi,ad7173.yaml    | 118 +++++-
 drivers/iio/adc/ad7173.c                           | 438 ++++++++++++++++++---
 2 files changed, 497 insertions(+), 59 deletions(-)
---
base-commit: 5ab61121a34759eb2418977f0b3589b7edc57776
change-id: 20240312-ad4111-7eeb34eb4a5f

Best regards,
-- 
Dumitru Ceclan <dumitru.ceclan@analog.com>



