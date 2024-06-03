Return-Path: <linux-iio+bounces-5689-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D7D8D8724
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 18:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2910C1C2174A
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 16:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71F91369A5;
	Mon,  3 Jun 2024 16:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BnJSVz5i"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBEE19F;
	Mon,  3 Jun 2024 16:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717431794; cv=none; b=A1Ozg98k1Dc+4iJL7QJV7DOOyehcE6kk/H8jafk+Nl2kx+0ZXROW6v16s8ups46dN1s7cwrb19qkobz85SLATxksIfnPLAujchacEnjCw/G7TGb1Ncry9pA8lbLV9gF6YL7EPd9SfoK7YrEdukHzfjsY4Qyqtzo7txWK6RxsLq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717431794; c=relaxed/simple;
	bh=pnQ8bQV8mHAFSbmSnU7+atoImMrUL8Y0W7r0fD3jSvU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eBMfw/Re9kPOsxTdD/WaBcTng4QbT6H/lRlCuG+nt14fjFf2kaJ7QIVFl79ecpEwWs2iWC674EoLnisuJockFsDd3CWI0Px343jx7JWCBg5gXiHvGeP8FqzOtIqCkBZ0Xco+RpgBDD+DjL3+d/gvc8HZ834QuNDe3G9NflvSo9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BnJSVz5i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC0E6C4AF09;
	Mon,  3 Jun 2024 16:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717431793;
	bh=pnQ8bQV8mHAFSbmSnU7+atoImMrUL8Y0W7r0fD3jSvU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=BnJSVz5irI0kFbpZ5QfyFr1LVvyCPlCkfWgJCdFh5gHNBK8OA93QnaxzmYx2Fk+D6
	 uklCCW+Xh8kwxU741LUW95GkPX+kpX3UDjhOydgaO+LKJlXqTEC0WN35c+MkyOu5zm
	 QsYZSlgO7UHygJDRzPqsN5v5t5latFIJBTVEuH5FCU7OA4dLUjs58yn8ePptgDnXFt
	 WY+6PPNm2f58EBFibwXHvAX+purzgqn35FBILQ+0urM8EeCasaFiQKJqz+/TFpWkpk
	 +0XH2fG5CWoZLzvvaCIQZJUHq1jNqyprQaEvczgt9z1YKzMkoCAhwDPE4xteCAgLYM
	 2flG5JbeLu0kQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7243C25B75;
	Mon,  3 Jun 2024 16:23:13 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Subject: [PATCH v5 0/9] Add support for AD411x
Date: Mon, 03 Jun 2024 19:22:58 +0300
Message-Id: <20240603-ad4111-v5-0-9a9c54d9ac78@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOLtXWYC/2XOTQrCMBCG4atI1kYyyaSxrryHuMjPtAa0kVaKU
 np3U8VacfkNeV4ysI7aSB3brQbWUh+7mJo89HrF/Mk2NfEY8mZSSBQKJLcBAYAbIqeQHFpdsfz
 42lIV76/Q4Zj3KXa31D5e3R6m6zuBAj6JHrjgCgvY2tJ7LeTeNvac6o1PFzY1evl1GnB2MjtZO
 iqs1lQ5/efUwkkzO5WdoZJCcC4ocn8OF059/4nZFVgIowR4oc2PG8fxCcpBcHxFAQAA
To: Ceclan Dumitru <dumitru.ceclan@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717431792; l=11344;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=pnQ8bQV8mHAFSbmSnU7+atoImMrUL8Y0W7r0fD3jSvU=;
 b=CV/2Az6ToqKFUXmunbIaFGNHHc2RNHX75ZV/ULoAZYSNWc4hcBhxJ0gOaKI4K3889mUvRoCdw
 tqVwWSitRvlBlm35cku9rlK9WWCkpD64q9dbhPg96lgHUukDK5stHyU
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
will be the responsibility of the user to specify.
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
Changes in v5:
dt-bindings: iio: adc: Add common-mode-channel property
- create patch

dt-bindings: adc: ad7173: add support for ad411x
- remove "adi" from common-mode-channel property

iio: adc: ad_sigma_delta: add disable_one callback
- create patch

iio: adc: ad7173: refactor channel configuration parsing
<no changes>

iio: adc: ad7173: refactor ain and vref selection
- change function header to send ain[0] and ain[1] as two arguments
- drop loop
- drop reviewed-by tag

iio: adc: ad7173: add support for special inputs
- unroll the loop in the ain validation function
- drop reviewed-by tag

iio: adc: ad7173: refactor device info structs
<no changes>

iio: adc: ad7173: document sampling frequency behaviour
- create patch

iio: adc: ad7173: Add support for AD411x devices
- rename VINCOM define from wildcard to specific models
- sampling frequency comment: "to" -> "for"
- don't set ain[1] for a second time in channel_parse, set
  chan->channel2 value directly if the channel is a current channel
- revert white space change in channel config parse
- unroll the loop in the ain validation function
- use new common-mode-channel property name
- remove sampling frequency comment as included in a previous patch

- Link to v4: https://lore.kernel.org/r/20240531-ad4111-v4-0-64607301c057@analog.com

Changes in v4:
dt-bindings: adc: ad7173: add support for ad411x
- remove "adi,channel-type"
- add "adi,common-mode-input" and "adi,current-channel" to use
  single-channel with both single-ended/pseudo-differential and current
  channels
- add restrictions to patternProperties channel to restrict presence of
  both diff-channels and single-channel
   and
  both "adi,current-channel" and "adi,common-mode-input"
- update diff-channels description
- update commit message to current state of the binding
- add a second example to exemplify single-ended and current channels

iio: adc: ad7173: refactor channel configuration parsing
- picked up reviewed-by tag

iio: adc: ad7173: refactor ain and vref selection
- Moved reference error message from validate_reference() to
  ad7173_get_ref_voltage_milli()
- Changed from dev_err_probe to dev_err as function can be reached from
  non probe paths
- added AD7173_NO_AINS_PER_CHANNEL to remove ambiguity when using the
  size of the ain array

iio: adc: ad7173: add support for special inputs
- picked up reviewed-by tag

iio: adc: ad7173: refactor device info structs
- create patch

iio: adc: ad7173: Add support for AD411x devices
- separate chip id defines for ad411<1,2,4>
- fix device_info typos: voltage, VINCOM
- rename num_voltage_inputs and num_voltage_inputs_with_divider to *_voltage_in*
- subtract ch->cfg.bipolar directly
- change to const ain argument in *_validate_current_ain()
- change parsing to new dt structure for current and single-ended channels
- drop adi,channel-type
- refactor device info structs as the previous patch

iio: adc: ad7173: Reduce device info struct size
- remove patch as suggested by David Lechner as it would increase binary
  size more than the savings done in RAM

- Link to v3: https://lore.kernel.org/r/20240527-ad4111-v3-0-7e9eddbbd3eb@analog.com

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
- add comment to document HW behavior when multiple channels are enabled
  in buffered reading mode

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
Dumitru Ceclan (9):
      dt-bindings: iio: adc: Add common-mode-channel property
      dt-bindings: adc: ad7173: add support for ad411x
      iio: adc: ad_sigma_delta: add disable_one callback
      iio: adc: ad7173: refactor channel configuration parsing
      iio: adc: ad7173: refactor ain and vref selection
      iio: adc: ad7173: add support for special inputs
      iio: adc: ad7173: refactor device info structs
      iio: adc: ad7173: document sampling frequency behaviour
      iio: adc: ad7173: Add support for AD411x devices

 Documentation/devicetree/bindings/iio/adc/adc.yaml |  11 +
 .../devicetree/bindings/iio/adc/adi,ad7173.yaml    | 191 +++++-
 drivers/iio/adc/ad7124.c                           |  14 +-
 drivers/iio/adc/ad7173.c                           | 694 +++++++++++++++------
 drivers/iio/adc/ad_sigma_delta.c                   |   6 +
 include/linux/iio/adc/ad_sigma_delta.h             |  14 +
 6 files changed, 736 insertions(+), 194 deletions(-)
---
base-commit: 02b664413a44903ef349bb70a3f1842cbcee9616
change-id: 20240312-ad4111-7eeb34eb4a5f

Best regards,
-- 
Dumitru Ceclan <dumitru.ceclan@analog.com>



