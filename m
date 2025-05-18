Return-Path: <linux-iio+bounces-19642-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C23EAABB12F
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 20:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33B007A6823
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 18:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B08D21D594;
	Sun, 18 May 2025 18:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWIx8Bxh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BF939FD9
	for <linux-iio@vger.kernel.org>; Sun, 18 May 2025 18:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747591779; cv=none; b=lhH2u3bmw0S4wuEkLEW0mDC0+uQFuhgOBiGgWPGR/gHmoC4O1WY8xr8y8YzNGsBGaVnvKQEOoUhtni+bBR8TvJ8Iw5dhnK5tnnAvVS6xao1Pf6x2IEuXhYKbsjJ3FtvEnQan9AX00HsjBFOHchkIYmsShsghs8GU2Y5TIoF3I74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747591779; c=relaxed/simple;
	bh=bu8lSJMhC9tD9vyBN/shmrYt4t7UqPnuuUcbQ5AdKPA=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nqefR1DY3l4yQh88qykhO4QcGRf2Z431xE1kU24ZPFuTUoQYZi1520K1SdEriNYxGh7UkCDo2l87J59UqtPlBFgYvR1LNo1mDIfAGHOYXqLqrUjl0wY0GS5vyxhDQSCWa0wuYCmQb8XZWLpweTYXXHKmKAye176CwrAvpmKaH7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWIx8Bxh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0B6C4CEE7;
	Sun, 18 May 2025 18:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747591778;
	bh=bu8lSJMhC9tD9vyBN/shmrYt4t7UqPnuuUcbQ5AdKPA=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=PWIx8BxhpkZij5yK/lN662mfwjOnOLaStpoXyGTYuvpRy17sSt1ozgs6CSVmT/2WF
	 VP+Kl8AsbyjwDm0ffoW3ojfheMRO7CyzToo5zKMhQyLuZiHxtYujN7F+eQZdVMHiWa
	 DFZYsQGZRwqX7px8IvGMS7NbGRhyfoDtzfzfxePhP10B2/DaKCi0C1cLCJ3Ayw4enk
	 Bj2YpysDGcF25N5CGD7mDJvX4JzwaiAfltXrx/ZKlSupXgDDlzejAfBK6KzLIN0XIk
	 431S7iil9iAtVD60xOcvIgxVzLWsZuWmzGQ04BgUdzzAxT+E+wLJdc+uvvrKJScQna
	 sK+gN/NWkOB/w==
Date: Sun, 18 May 2025 19:09:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: New device support, features and cleanup for 6.16
Message-ID: <20250518190933.4dab9eea@jic23-huawei>
In-Reply-To: <20250517202341.095163d6@jic23-huawei>
References: <20250517202341.095163d6@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 17 May 2025 20:23:41 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089a=
c8:
>=20
>   Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)
>=20
> are available in the Git repository at:
>=20
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-=
for-6.16a
>=20
> for you to fetch changes up to 1b8833364795fb4562b867623f62b401b72238e2:
>=20
>   dt-bindings: iio: adc: Add ROHM BD79100G (2025-05-17 20:18:30 +0100)
>=20
Hi Greg,

I didn't call it out in here because I'd forgotten about it when writing th=
is
pull request up whilst travelling.  There is a trivial conflict with the
fixes pull request I just sent that modifies an adjacent line in the=20
ad7606 driver.

https://lore.kernel.org/all/20250502-iio-adc-ad7606-fix-raw-read-for-18-bit=
-chips-v1-1-06caa92d8f11@baylibre.com/
called that out under the ---

I haven't resolved it locally because I meant to send that fix
a while back and as mentioned I forgot about it.  Hope you don't mind
doing the resolution during the merge.

Stephen's resolution was:
https://lore.kernel.org/linux-next/20250506155728.65605bae@canb.auug.org.au/

Thanks,

Jonathan


> ----------------------------------------------------------------
> IIO: New device support, features and cleanup for 6.16
>=20
> Note - last minute rebase was to drop a typo patch that I'd accidentally
> picked up (in the microblaze arch Kconfig)
>=20
> Added 3 named IIO reviewers to MAINTAINERS. This is a reflection of those
> who have been doing much of this work for some time. Lars-Peter is
> removed from the entry having moved on to other topics.  Thanks
> Nuno, David and Andy for stepping up and Lars-Peter for all your
> hard work in the past!
>=20
> Includes the usual mix of new device support, features and general
> cleanup.
>=20
> This time we also have some tree wide changes.
>=20
> - Rip out the iio_device_claim_direct_scoped() as it proved hard to work
>   with.  This series includes quite a few related cleanups such as use
>   of guard or factoring code out to allow direct returns.
> - Switch from iio_device_claim/release_direct_mode() to new
>   iio_device_claim/release_direct() which is structured so that sparse
>   can warn on failed releases. There were a few false positives but
>   those were mostly in code that benefited from being cleaned up as part
>   of this process.
> - Introduce iio_push_to_buffers_with_ts() to replace the _timestamp()
>   version over time. This version takes the size of the supplied buffer
>   which the core checks is at least as big as expected by calculation
>   from channel descriptions of those channels enabled. Use this in
>   an initial set of drivers.
> - Add macros for IIO_DECLARE_BUFFER_WITH_TS() and
>   IIO_DECLARE_DMA_BUFFER_WITH_TS() to avoid lots of fiddly code to ensure
>   correctly aligned buffers for timestamps being added onto the end of
>   channel data.
>=20
> New device support
> ------------------
>=20
> adi,ad3530r
> - New driver for AD3530, AD3530R, AD3531 and AD3531R DACs with
>   programmable gain controls. R variants have internal references.
> adi,ad7476
> - Add support (dt compatible only) for the Rohm BU79100G ADC which is
>   fully compatible with the ti,ads7866.
> adi,ad7606
> - Support ad7606c-16 and ad7606c-18 devices. Includes switch to dynamic
>   channel information allocation.
> adi,ad7380
> - Add support for the AD7389-4
> dfrobot,sen0322
> - New driver for this oxygen sensor.
> mediatek,mt2701-auxadc
> - Add binding for MT6893 which is fully compatible with already supported
>   MT8173.
> meson-saradc
> - Support the GXLX SoCs.  Mostly this is a workaround for some unrelated
>   clock control bits found in the ADC register map.
> nuvoton,nct7201
> - New driver for NCT7201 and NCT7202 I2C ADCs.
> rohm,bd79124
> - New driver for this 12-bit, 8-channel SAR ADC.
> - Switch to new set_rv etc gpio callbacks that were added in 6.15.
> rohm,bd79703
> - Add support for BD79700, BD79701 and BD79702 DACs that have subsets of
>   functionality of the already supported bd79703.  Included making this
>   driver suitable for support device variants.
> st,stm32-lptimer
> - Add support for stm32pm25 to this trigger.
>=20
> Features
> --------
>=20
> Beyond IIO
> - Property iterator for named children.
> core
> - Enable writes for 64 bit integers used for standard IIO ABI elements.
>   Previously these could be read only.
> - Helper library that should avoid code duplication for simpler ADC
>   bindings that have a child node per channel.
> - Enforce that IIO_DMA_MINALIGN is always at least 8 (almost always true
>   and simplifies code on all significant architectures)
> core/backend
> - Add support to control source of data - useful when the HDL includes
>   things like generated ramps for testing purposes. Enable this for
>   adi-axi-dac
> adi,ad3552-hs
> - Add debugfs related callbacks to allow debug access to register content=
s.
> adi,ad4000
> - Support SPI offload with appropriate FPGA firmware along with improving
>   documentation.
> adi,ad7293
> - Add support for external reference voltage.
> adi,ad7606
> - Support SPI offload.
> adi,ad7768-1
> - Support reset GPIO.
> adi,admv8818
> - Support filter frequencies beyond 2^32.
> adi,adxl345
> - Add single and double tap events.
> hid-sensor-prox
> - Support 16-bit report sizes as seen on some Intel platforms.
> invensense,icm42600
> - Enable use of named interrupts to avoid problems with some wiring choic=
es.
>   Get the interrupt by name, but fallback to previous assumption on the f=
irst
>   being INT1 if no names are supplied.
> microchip,mcp3911
> - Add reset gpio support.
> rohm,bh7150
> - Add reset gpio support.
> st,stm32
> - Add support to control oversampling.
> ti,adc128s052
> - Add support for ROHM BD79104 which is early compatible with the TI
>   parts already supported by this driver. Includes some general driver
>   cleanup and a separate dt binding.
> - Simplify reference voltage handling by assuming it is fixed after enabl=
ing
>   the supply.
> winsen,mhz19b
> - New driver for this C02 sensor.
>=20
> Cleanup and minor fixes
> -----------------------
>=20
> dt-bindings
> - Correct indentation and style for DTS examples.
> - Use unevalutateProperties for SPI devices instead of additionalProperti=
es
>   to allow generic SPI properties from spi-peripheral-props.yaml
> ABI Docs
> - Add missing docs for sampling_frequency when it applies only to events.
> Treewide
> - Various minor tweaks, comment fixes and similar.
> - Sort TI ADCs in Kconfig that had gotten out of order.
> - Switch various drives that provide GPIO chip functionality to the new
>   callbacks with return values.
> - Standardize on { } formatting for all array sentinels.
> - Make use of aligned_s64 in a few places to replace either wrong types
>   or manually defined equivalents.
> - Drop places where spi bits_per_word is set to 8 because that is the
>   default anyway.
>=20
> adi,ad_sigma_delta library
> - Avoid a potential use of uninitialized data if reg_size has a value
>   that is not supported (no drivers hit this but it is reasonable hardeni=
ng)
> adi,ad4030
> - Add error checking for scan types and no longer store it in state.
> - Rework code to reduce duplication.
> - Move setting the mode from buffer preenable() to update_scan_mode(),
>   better matching expected semantics of the two different callbacks.
> - Improve data marshalling comments.
> adi,ad4695
> - Use u16 for buffer elements as oversampling is not yet supported except
>   with SPI offload (which doesn't use this path).
> adi,ad5592r
> - Clean up destruction of mutexes.
> - Use lock guards to simplify code (later patch fixes a missed unlock)
> adi,ad5933
> - Correct some incorrect settling times.
> adi,ad7091
> - Deduplicate handling of writable vs volatile registers as they are the
>   inverse of each other for this device.
> adi,ad7124
> - Fix 3db Filter frequency.
> - Remove ability to directly write the filter frequency (which was broken)
> - Register naming improvements.
> adi,ad7606
> - Add a missing return value check.
> - Fill in max sampling rates for all chips.
> - Use devm_mutex_init()
> - Fix up some kernel-doc formatting issues.
> - Remove some camel case that snuck in.
> - Drop setting address field in channels as easily established from other
>   fields.
> - Drop unnecessary parameter to ad76060_scale_setup_cb_t.
> adi,ad7768-1
> - Convert to regmap.
> - Factor out buffer allocation.
> - Tidy up headers.
> adi,ad7944
> - Stop setting bits_per_word in SPI xfers with no data.
> adi,ad9832
> - Add of_device_id table rather than just relying on fallbacks.
> - Use FIELD_PREP() to set values of fields.
> adi,admv1013
> - Cleanup a pointless ternary.
> adi,admv8818
> - Fix up LPF Band 5 frequency which was slightly wrong.
> - Fix an integer overflow.
> - Fix range calculation
> adi,adt7316
> - Replace irqd_get_trigger_type(irq_get_irq_data()) with simpler
>   irq_get_trigger_type()
> adi,adxl345
> - Use regmap cache instead of various state variables that were there to
>   reduce bus accesses.
> - Make regmap return value checking consistent across all call sites.
> adi,axi-dac
> - Add a check on number of channels (0 to 15 valid)
> allwinner,sun20i
> - Use new adc-helpers to replace local parsing code for channel nodes.
> bosch,bmp290
> - Move to local variables for sensor data marshalling removing the need
>   for a messy definition that has to work for all supported parts.
>   Follow up fix adds a missing initialization.
> dynaimage,al3010 and dynaimage,al3320a
> - Various minor cleanup to bring these drivers inline with reviewed feedb=
ack
>   given on a new driver.
> - Fix an error path in which power down is not called when it should be.
> - Switch to regmap.
> google,cros_ec
> - Fix up a flexible array in middle of structure warning.
> - Flush fifo when changing the timeout to avoid potential long wait
>   for samples.
> hid-sensor-rotation
> - Remove an __aligned(16) marking that doesn't seem to be justified.
> kionix,kxcjk-1013
> - Deduplicate code for setting up interrupts.
> microchip,mcp3911
> - Fix handling of conversion results register which differs across suppor=
ted
>   devices.
> idt,zopt2201
> - Avoid duplicating register lists as all volatile registers are the
>   inverse of writeable registers on this device.
> renesas,rzg2l
> - Use new adc-helpers to replace local parsing code for channel nodes.
> ti,ads1298
> - Fix a missing Kconfig dependency.
>=20
> ----------------------------------------------------------------
> Ahelenia Ziemia=C5=84ska (1):
>       iio: ssp_sensors: optimalize -> optimize
>=20
> Andy Shevchenko (1):
>       iio: amplifiers: hmc425a: Remove not fully correct comment
>=20
> Angelo Dureghello (10):
>       iio: dac: ad3552r-hs: add debugfs reg access
>       dt-bindings: iio: adc: adi,ad7606: add SPI offload properties
>       doc: iio: ad7606: describe offload support
>       iio: adc: ad7606: add SPI offload support
>       iio: dac: adi-axi-dac: add cntrl chan check
>       docs: iio: add documentation for ad3552r driver
>       iio: backend: add support for data source get
>       iio: dac: adi-axi-dac: add data source get
>       iio: dac: ad3552r-hs: add support for internal ramp
>       docs: iio: ad3552r: fix malformed table
>=20
> AngeloGioacchino Del Regno (1):
>       dt-bindings: iio: adc: Add compatible for Dimensity 1200 MT6893
>=20
> Antoniu Miclaus (3):
>       dt-bindings: iio: dac: ad7293: add vrefin support
>       iio: dac: ad7293: add adc reference configuration
>       MAINTAINERS: add maintainers for ad4851 driver
>=20
> Arthur Pilone (1):
>       iio: adc: ad7091r-base: Remove duplicate code on volatile reg check
>=20
> Arthur-Prince (1):
>       iio: adc: ti-ads1298: Kconfig: add kfifo dependency to fix module b=
uild
>=20
> Bartosz Golaszewski (7):
>       iio: dac: ad5592r: destroy mutexes in detach paths
>       iio: dac: ad5592r: use lock guards
>       iio: dac: ad5592r: use new GPIO line value setter callbacks
>       iio: adc: ti-ads7950: use new GPIO line value setter callbacks
>       iio: adc: ad4130: use new GPIO line value setter callbacks
>       iio: addac: ad74413r: use new GPIO line value setter callbacks
>       iio: addac: ad74115: use new GPIO line value setter callbacks
>=20
> Beatriz Viana Costa (1):
>       iio: light: zopt2201: Remove code duplication in scale write functi=
ons
>=20
> Brian Pellegrino (1):
>       iio: filter: admv8818: Support frequencies >=3D 2^32
>=20
> Chelsy Ratnawat (2):
>       HID: sensor-hub: Fix typo and improve documentation for sensor_hub_=
remove_callback()
>       HID: sensor-hub: Fix typo and improve documentation
>=20
> Colin Ian King (1):
>       iio: admv1013: replace redundant ternary operator with just len
>=20
> Dan Carpenter (2):
>       iio: dac: ad5592r: Delete stray unlock in ad5592r_write_raw()
>       iio: chemical: mhz19b: Fix error code in probe()
>=20
> David Heidelberg (13):
>       iio: light: al3010: Use unsigned int for the indexing
>       iio: light: al3320a: Use unsigned int for the indexing
>       iio: light: al3010: Remove DRV_NAME definition
>       iio: light: al3320a: Remove DRV_NAME definition
>       iio: light: al3010: Abstract device reference in the probe function
>       iio: light: al3320a: Abstract device reference in the probe function
>       iio: light: al3010: Split set_pwr function into set_pwr_on and _off
>       iio: light: al3320a: Split set_pwr function into set_pwr_on and _off
>       iio: light: al3010: Improve al3010_init error handling with dev_err=
_probe()
>       iio: light: al3000a: Fix an error handling path in al3000a_probe()
>       iio: light: al3320a: Fix an error handling path in al3320a_probe()
>       iio: light: al3010: Implement regmap support
>       iio: light: al3320a: Implement regmap support
>=20
> David Lechner (51):
>       iio: adc: ad4030: check scan_type for error
>       iio: adc: ad4030: remove some duplicate code
>       iio: adc: ad4030: move setting mode to update_scan_mode
>       iio: adc: ad4030: don't store scan_type in state
>       iio: adc: ad4030: explain rearranging raw sample data
>       iio: adc: ad7606_spi: check error in ad7606B_sw_mode_config()
>       iio: adc: ad7606: add missing max sample rates
>       iio: adc: ad7606: use devm_mutex_init()
>       iio: adc: ad7606: fix kernel-doc comments
>       iio: adc: ad7606: use kernel identifier name style
>       iio: adc: ad7606: don't use address field
>       iio: adc: ad7606: drop ch param from ad7606_scale_setup_cb_t
>       iio: adc: ad7606: dynamically allocate channel info
>       iio: adc: ad7606_par: add ad7606c chips
>       iio: adc: ad7944: drop bits_per_word hack
>       dt-bindings: iio: adc: ad7380: add AD7389-4
>       iio: adc: ad7380: rename internal_ref_only
>       iio: adc: ad7380: move internal reference voltage to chip_info
>       iio: adc: ad7380: add ad7389-4
>       Documentation: iio: ad7380: add AD7389-4
>       iio: normalize array sentinel style
>       iio: adc: mt6360-adc: use aligned_s64 for timestamp
>       iio: addac: ad74413r: use aligned_s64 for timestamp
>       iio: adc: hx711: use struct with aligned_s64 timestamp
>       iio: orientation: hid-sensor-rotation: remove unnecessary alignment
>       iio: pressure: bmp280: drop sensor_data array
>       iio: adc: ad7606_spi: add offload scan mask check
>       iio: adc: ad7606: explicit timestamp alignment
>       iio: adc: ad4695: use u16 for buffer elements
>       iio: adc: ad4030: remove bits_per_word =3D 8
>       iio: adc: ti-tsc2046: remove bits_per_word =3D 8
>       iio: chemical: bme680_spi: remove bits_per_word =3D 8
>       iio: dac: ad5761: remove bits_per_word =3D 8
>       iio: dac: ad5766: remove bits_per_word =3D 8
>       iio: dac: ad5791: remove bits_per_word =3D 8
>       iio: dac: ltc2688: remove bits_per_word =3D 8
>       iio: gyro: adxrs450: remove bits_per_word =3D 8
>       iio: imu: adis: remove bits_per_word =3D 8
>       iio: magnetometer: hmc5843_spi: remove bits_per_word =3D 8
>       iio: magnetometer: rm3100-spi: remove bits_per_word =3D 8
>       iio: pressure: bmp280-spi: remove bits_per_word =3D 8
>       iio: pressure: ms5611_spi: remove bits_per_word =3D 8
>       iio: pressure: zpa2326_spi: remove bits_per_word =3D 8
>       iio: make IIO_DMA_MINALIGN minimum of 8 bytes
>       iio: introduce IIO_DECLARE_BUFFER_WITH_TS macros
>       iio: adc: ad4695: use IIO_DECLARE_DMA_BUFFER_WITH_TS
>       iio: adc: ad4695: rename AD4695_MAX_VIN_CHANNELS
>       iio: adc: ad7380: use IIO_DECLARE_DMA_BUFFER_WITH_TS
>       iio: accel: sca3300: use IIO_DECLARE_BUFFER_WITH_TS
>       iio: adc: at91-sama5d2: use IIO_DECLARE_BUFFER_WITH_TS
>       iio: bmp280: zero-init buffer
>=20
> Eason Yang (2):
>       dt-bindings: iio: adc: add NCT7201 ADCs
>       iio: adc: add support for Nuvoton NCT7201
>=20
> Feng Wei (1):
>       staging: iio: adt7316: replace irqd_get_trigger_type with irq_get_t=
rigger_type
>=20
> Gabriel Shahrouzi (2):
>       iio: frequency: ad9832: Remove unused parameter from data documenta=
tion
>       staging: iio: ad5933: Correct settling cycles encoding per datasheet
>=20
> Gustavo A. R. Silva (2):
>       iio: proximity: cros_ec_mkbp_proximity: Avoid -Wflex-array-member-n=
ot-at-end warning
>       iio: cros_ec: Avoid -Wflex-array-member-not-at-end warning
>=20
> Gustavo Vaz (1):
>       iio: accel: kxcjk-1013: Deduplicate setup interrupt functions
>=20
> Gwendal Grignou (1):
>       iio: cros_ec_sensors: Flush when changing the FIFO timeout
>=20
> Gyeyoung Baek (4):
>       dt-bindings: Add Winsen to the vendor prefixes
>       dt-bindings: Add device tree support for Winsen MHZ19B CO2 sensor
>       iio: chemical: Add support for Winsen MHZ19B CO2 sensor
>       MAINTAINERS: Add WINSEN MHZ19B
>=20
> Jean-Baptiste Maneyrol (2):
>       dt-bindings: iio: imu: icm42600: add interrupt naming support
>       iio: imu: inv_icm42600: switch to use generic name irq get
>=20
> Jonathan Cameron (79):
>       iio: adc: vf610: Move claim of direct mode to caller of vf610_read_=
sample and use guard(mutex)
>       iio: adc: vf610: Switch to sparse friendly iio_device_claim/release=
_direct()
>       iio: adc: ti-ads1100: Use guard(mutex) to allow direct returns
>       iio: adc: ti-ads1100: Switch to sparse friendly iio_device_claim/re=
lease_direct()
>       iio: adc: ti-ads1015: Use guard(mutex) and factor out code for INFO=
_RAW
>       iio: adc: ti-ads1015: Switch to sparse friendly iio_device_claim/re=
lease_direct()
>       iio: adc: mxs-lradc: Switch to sparse friendly iio_device_claim/rel=
ease_direct()
>       iio: adc: rcar: Switch to sparse friendly iio_device_claim/release_=
direct()
>       iio: light: apds9306: Switch to sparse friendly iio_device_claim/re=
lease_direct()
>       iio: light: gp2ap020a00f: Switch to sparse friendly iio_device_clai=
m/release_direct()
>       iio: light: isl29125: Switch to sparse friendly iio_device_claim/re=
lease_direct()
>       iio: light: as73211: Use guard() and move mode switch into inner wr=
ite_raw fucntion
>       iio: light: as73211: Switch to sparse friendly iio_device_claim/rel=
ease_direct()
>       iio: light: ltr501: Factor out IIO_INFO_RAW leg of read_raw() callb=
ack.
>       iio: light: ltr501: Factor out core of write_raw() where direct mod=
e claim is held.
>       iio: light: ltr501: Switch to sparse friendly iio_device_claim/rele=
ase_direct()
>       iio: light: opt4060: Switch to sparse friendly iio_device_claim/rel=
ease_direct()
>       iio: light: rohm-bu27034: Switch to sparse friendly iio_device_clai=
m/release_direct()
>       iio: light: rpr0521: Factor out handling of IIO_INFO_RAW and use gu=
ard()
>       iio: light: rpr0521: Switch to sparse friendly iio_device_claim/rel=
ease_direct()
>       iio: light: si1145: Switch to sparse friendly iio_device_claim/rele=
ase_direct()
>       iio: light: st_uvis25: Switch to sparse friendly iio_device_claim/r=
elease_direct()
>       iio: light: tcs3414: Switch to sparse friendly iio_device_claim/rel=
ease_direct()
>       iio: light: tcs3472: Switch to sparse friendly iio_device_claim/rel=
ease_direct()
>       iio: light: vcnl4000: Switch to sparse friendly iio_device_claim/re=
lease_direct()
>       iio: light: vcnl4035: Switch to sparse friendly iio_device_claim/re=
lease_direct()
>       iio: addac: ad74115: Switch to sparse friendly iio_device_claim/rel=
ease_direct()
>       iio: chemical: ccs811: Factor out handling of read of IIO_INFO_RAW =
to simplify error paths.
>       iio: chemical: ccs811: Switch to sparse friendly iio_device_claim/r=
elease_direct()
>       iio: chemical: atlas-sensor: Switch to sparse friendly iio_device_c=
laim/release_direct()
>       iio: chemical: scd4x: Switch to sparse friendly iio_device_claim/re=
lease_direct()
>       iio: common: scmi: Switch to sparse friendly iio_device_claim/relea=
se_direct()
>       iio: common: st_sensors: Switch to sparse friendly iio_device_claim=
/release_direct()
>       iio: gyro: adxrs290: Switch to sparse friendly iio_device_claim/rel=
ease_direct()
>       iio: health: max30102: Switch to sparse friendly iio_device_claim/r=
elease_direct()
>       iio: humidity: hdc100x: Use guard(mutex) to simplify code flow
>       iio: humidity: hdc100x: Switch to sparse friendly iio_device_claim/=
release_direct()
>       iio: humidity: hdc2010: Switch to sparse friendly iio_device_claim/=
release_direct()
>       iio: humidity: hts211: Factor out everything under direct mode clai=
m into helper functions.
>       iio: humidity: hts211: Switch to sparse friendly iio_device_claim/r=
elease_direct()
>       iio: imu: inv_icm42600: Switch to sparse friendly iio_device_claim/=
release_direct()
>       iio: imu: inv_mpu6050: Switch to sparse friendly iio_device_claim/r=
elease_direct()
>       iio: imu: smi240: Switch to sparse friendly iio_device_claim/releas=
e_direct()
>       iio: imu: st_lsm6dsx: Factor out parts of st_lsm6dsx_shub_write_raw=
() to allow direct returns
>       iio: imu: st_lsm6dsx: Switch to sparse friendly claim/release_direc=
t()
>       iio: imu: st_lsm6dsx: Switch to sparse friendly iio_device_claim/re=
lease_direct()
>       iio: magnetometer: mag3110: Factor out core of read/write_raw() and=
 use guard() to simplify code flow.
>       iio: magnetometer: mag3110: Switch to sparse friendly iio_device_cl=
aim/release_direct()
>       iio: magnetometer: rm3100: Switch to sparse friendly iio_device_cla=
im/release_direct()
>       iio: pressure: dlhl60d: Switch to sparse friendly iio_device_claim/=
release_direct()
>       iio: pressure: icp10100: Switch to sparse friendly iio_device_claim=
/release_direct()
>       iio: pressure: mpl3115: factor out core of IIO_INFO_RAW read to sim=
plify code flow
>       iio: pressure: mpl3115: Switch to sparse friendly iio_device_claim/=
release_direct()
>       iio: pressure: ms5611: Switch to sparse friendly iio_device_claim/r=
elease_direct()
>       iio: pressure: rohm-bm1390: Switch to sparse friendly iio_device_cl=
aim/release_direct()
>       iio: pressure: zpa2326: Switch to sparse friendly iio_device_claim/=
release_direct()
>       iio: proximity: hx9023s: Switch to sparse friendly iio_device_claim=
/release_direct()
>       iio: proximity: pulsed-light: Switch to sparse friendly iio_device_=
claim/release_direct()
>       iio: proximity: sx9500: Switch to sparse friendly iio_device_claim/=
release_direct()
>       iio: temp: maxim_thermocouple: Switch to sparse friendly iio_device=
_claim/release_direct()
>       iio: temp: maxim_thermocouple: Drop unused mutex.h include.
>       staging: iio: ad5933: Switch to sparse friendly iio_device_claim/re=
lease_direct()
>       iio: Adjust internals of handling of direct mode claiming to suit n=
ew API.
>       MAINTAINERS: IIO: Update reviewers for the subsystem
>       iio: introduced iio_push_to_buffers_with_ts() that takes a data_tot=
al_len argument.
>       iio: dummy: Use a fixed structure to build up scan to push to buffe=
rs.
>       iio: dummy: Switch to iio_push_to_buffers_with_ts() and provide siz=
e of storage
>       iio: adc: ti-ads131e08: Use new iio_push_to_buffers_with_ts() to pr=
ovide length sanity check.
>       iio: adc: Use iio_push_to_buffers_with_ts() to provide length for r=
untime checks.
>       iio: accel: Use iio_push_to_buffers_with_ts() to provide length for=
 runtime checks.
>       iio: accel: hid: Use iio_push_to_buffers_with_ts() to provide lengt=
h for runtime checks.
>       iio: chemical: Use iio_push_to_buffers_with_ts() to provide length =
for runtime checks.
>       iio: temperature: Use iio_push_to_buffers_with_ts() to provide leng=
th for runtime checks.
>       iio: resolver: Use iio_push_to_buffers_with_ts() to provide length =
for runtime checks.
>       iio: proximity: irsd200: Use a struct for scan and iio_push_to_buff=
ers_with_ts()
>       iio: proximity: Use iio_push_to_buffers_with_ts() to provide length=
 for runtime checks.
>       iio: pressure: zpa2326: Use aligned_s64 for the timestamp
>       iio: pressure: Use iio_push_to_buffers_with_ts() to provide length =
for runtime checks.
>       iio: magnetometer: Use iio_push_to_buffers_with_ts() to provide len=
gth for runtime checks.
>=20
> Jonathan Santos (2):
>       iio: adc: ad7768-1: convert driver to use regmap
>       iio: adc: ad7768-1: reorganize driver headers
>=20
> Jorge Marques (1):
>       Documentation: ABI: add events sampling frequency in sysfs-bus-iio
>=20
> Kim Seer Paller (3):
>       iio: ABI: add new DAC powerdown mode
>       dt-bindings: iio: dac: Add adi,ad3530r.yaml
>       iio: dac: ad3530r: Add driver for AD3530R and AD3531R
>=20
> Krzysztof Kozlowski (2):
>       dt-bindings: iio: Correct indentation and style in DTS example
>       dt-bindings: iio: Use unevaluatedProperties for SPI devices
>=20
> Lothar Rubusch (7):
>       iio: accel: adxl345: use regmap cache for INT mapping
>       iio: accel: adxl345: move INT enable to regmap cache
>       iio: accel: adxl345: cleanup regmap return values
>       iio: accel: adxl345: introduce adxl345_push_event function
>       iio: accel: adxl345: add single tap feature
>       iio: accel: adxl345: add double tap feature
>       iio: accel: adxl345: set the tap suppress bit permanently
>=20
> Marcelo Schmitt (5):
>       iio: adc: ad4000: Add support for SPI offload
>       Documentation: iio: ad4000: Add new supported parts
>       Documentation: iio: ad4000: Add IIO Device characteristics section
>       Documentation: iio: ad4000: Describe offload support
>       iio: adc: ad4000: Avoid potential double data word read
>=20
> Marcus Folkesson (3):
>       iio: adc: mcp3911: fix device dependent mappings for conversion res=
ult registers
>       dt-bindings: iio: adc: mcp3911: add reset-gpios
>       iio: adc: mcp3911: add reset management
>=20
> Marius Cristea (1):
>       iio: adc: PAC1934: fix typo in documentation link
>=20
> Martin Blumenstingl (2):
>       dt-bindings: iio: adc: amlogic,meson-saradc: Add GXLX SoC compatible
>       iio: adc: meson: add support for the GXLX SoC
>=20
> Matti Vaittinen (23):
>       dt-bindings: ROHM BD79124 ADC/GPO
>       property: Add functions to iterate named child
>       iio: adc: add helpers for parsing ADC nodes
>       iio: adc: rzg2l_adc: Use adc-helpers
>       iio: adc: sun20i-gpadc: Use adc-helpers
>       iio: adc: Support ROHM BD79124 ADC
>       MAINTAINERS: Add IIO ADC helpers
>       MAINTAINERS: Add ROHM BD79124 ADC/GPO
>       dt-bindings: Add ROHM BD7970x variants
>       iio: dac: bd79703 Store device address to 'address'
>       iio: dac: bd79703: Add chip data
>       iio: dac: bd79703: Support BD79700 and BD79701
>       iio: dac: bd79703: Support ROHM BD79702
>       iio: bd79124: Use set_rv and set_multiple_rv
>       dt-bindings: ROHM BD79104 ADC
>       iio: adc: ti-adc128s052: Simplify using be16_to_cpu()
>       iio: adc: ti-adc128s052: Be consistent with arrays
>       iio: adc: ti-adc128s052: Use devm_mutex_init()
>       iio: adc: ti-adc128s052: Simplify using guard(mutex)
>       iio: adc: ti-adc128s052: Support ROHM BD79104
>       MAINTAINERS: A driver for TI/ROHM ADCs
>       iio: ti-adc128s052: Drop variable vref
>       dt-bindings: iio: adc: Add ROHM BD79100G
>=20
> Olivier Moysan (2):
>       iio: trigger: stm32-lptimer: add support for stm32mp25
>       iio: adc: stm32: add oversampling support
>=20
> Purva Yeshi (1):
>       iio: adc: ad_sigma_delta: Fix use of uninitialized status_pos
>=20
> Sam Winchenbach (5):
>       dt-bindings: iio: filter: Add lpf/hpf freq margins
>       iio: filter: admv8818: fix band 4, state 15
>       iio: filter: admv8818: fix integer overflow
>       iio: filter: admv8818: fix range calculation
>       iio: core: Add support for writing 64 bit attrs
>=20
> Sergio Perez (2):
>       dt-bindings: iio: light: bh1750: Add reset-gpios property
>       iio: light: bh1750: Add hardware reset support via GPIO
>=20
> Sergiu Cuciurean (2):
>       iio: adc: ad7768-1: Add reset gpio
>       iio: adc: ad7768-1: Move buffer allocation to a separate function
>=20
> Siddharth Menon (2):
>       iio: frequency: ad9832: devicetree probing support
>       iio: frequency: ad9832: Use FIELD_PREP macro to set bit fields
>=20
> Tobias Sperling (1):
>       iio: adc: sort TI drivers alphanumerical
>=20
> T=C3=B3th J=C3=A1nos (2):
>       dt-bindings: trivial-devices: Document SEN0322
>       iio: chemical: Add driver for SEN0322
>=20
> Uwe Kleine-K=C3=B6nig (3):
>       iio: adc: ad7124: Fix 3dB filter frequency reading
>       iio: adc: ad7124: Remove ability to write filter_low_pass_3db_frequ=
ency
>       iio: adc: ad7124: Make register naming consistent
>=20
> Zhang Lixu (1):
>       iio: hid-sensor-prox: Add support for 16-bit report size
>=20
>  Documentation/ABI/testing/sysfs-bus-iio            |    3 +
>  .../devicetree/bindings/iio/adc/adi,ad7380.yaml    |   11 +
>  .../devicetree/bindings/iio/adc/adi,ad7476.yaml    |   63 +-
>  .../devicetree/bindings/iio/adc/adi,ad7606.yaml    |    8 +
>  .../bindings/iio/adc/amlogic,meson-saradc.yaml     |    1 +
>  .../bindings/iio/adc/mediatek,mt2701-auxadc.yaml   |    1 +
>  .../bindings/iio/adc/microchip,mcp3911.yaml        |    5 +
>  .../bindings/iio/adc/nuvoton,nct7201.yaml          |   70 ++
>  .../devicetree/bindings/iio/adc/rohm,bd79104.yaml  |   69 ++
>  .../devicetree/bindings/iio/adc/rohm,bd79124.yaml  |  114 ++
>  .../devicetree/bindings/iio/adc/st,stm32-adc.yaml  |  102 +-
>  .../bindings/iio/chemical/winsen,mhz19b.yaml       |   33 +
>  .../devicetree/bindings/iio/dac/adi,ad3530r.yaml   |  100 ++
>  .../devicetree/bindings/iio/dac/adi,ad3552r.yaml   |    2 +-
>  .../devicetree/bindings/iio/dac/adi,ad7293.yaml    |    2 +
>  .../devicetree/bindings/iio/dac/adi,ltc2664.yaml   |    2 +-
>  .../devicetree/bindings/iio/dac/adi,ltc2672.yaml   |    2 +-
>  .../bindings/iio/dac/microchip,mcp4821.yaml        |    2 +-
>  .../devicetree/bindings/iio/dac/rohm,bd79703.yaml  |   35 +-
>  .../bindings/iio/filter/adi,admv8818.yaml          |   20 +
>  .../devicetree/bindings/iio/imu/adi,adis16550.yaml |    2 +-
>  .../bindings/iio/imu/invensense,icm42600.yaml      |   13 +-
>  .../devicetree/bindings/iio/light/bh1750.yaml      |    6 +
>  .../bindings/iio/pressure/honeywell,hsc030pa.yaml  |    2 +-
>  .../iio/pressure/honeywell,mprls0025pa.yaml        |    2 +-
>  .../devicetree/bindings/trivial-devices.yaml       |    2 +
>  .../devicetree/bindings/vendor-prefixes.yaml       |    2 +
>  Documentation/iio/ad3552r.rst                      |   72 ++
>  Documentation/iio/ad4000.rst                       |   91 +-
>  Documentation/iio/ad7380.rst                       |    7 +
>  Documentation/iio/ad7606.rst                       |   45 +
>  Documentation/iio/index.rst                        |    1 +
>  MAINTAINERS                                        |   60 +-
>  drivers/base/property.c                            |   27 +
>  drivers/iio/accel/adxl345.h                        |    4 +
>  drivers/iio/accel/adxl345_core.c                   |  600 +++++++++-
>  drivers/iio/accel/adxl345_i2c.c                    |    2 +
>  drivers/iio/accel/adxl345_spi.c                    |    2 +
>  drivers/iio/accel/adxl355_core.c                   |    4 +-
>  drivers/iio/accel/adxl367_i2c.c                    |    2 +-
>  drivers/iio/accel/adxl367_spi.c                    |    4 +-
>  drivers/iio/accel/adxl372_i2c.c                    |    2 +-
>  drivers/iio/accel/adxl372_spi.c                    |    2 +-
>  drivers/iio/accel/bma180.c                         |    2 +-
>  drivers/iio/accel/bma220_spi.c                     |    8 +-
>  drivers/iio/accel/bma400_core.c                    |    5 +-
>  drivers/iio/accel/bmc150-accel-i2c.c               |    6 +-
>  drivers/iio/accel/bmc150-accel-spi.c               |    4 +-
>  drivers/iio/accel/bmi088-accel-i2c.c               |    4 +-
>  drivers/iio/accel/bmi088-accel-spi.c               |    4 +-
>  drivers/iio/accel/da280.c                          |    4 +-
>  drivers/iio/accel/da311.c                          |    2 +-
>  drivers/iio/accel/dmard10.c                        |    2 +-
>  drivers/iio/accel/fxls8962af-core.c                |    4 +-
>  drivers/iio/accel/fxls8962af-i2c.c                 |    4 +-
>  drivers/iio/accel/fxls8962af-spi.c                 |    4 +-
>  drivers/iio/accel/hid-sensor-accel-3d.c            |    4 +-
>  drivers/iio/accel/kxcjk-1013.c                     |   91 +-
>  drivers/iio/accel/kxsd9-i2c.c                      |    2 +-
>  drivers/iio/accel/kxsd9-spi.c                      |    2 +-
>  drivers/iio/accel/kxsd9.c                          |    7 +-
>  drivers/iio/accel/mma7455_core.c                   |    5 +-
>  drivers/iio/accel/mma7660.c                        |    4 +-
>  drivers/iio/accel/mma8452.c                        |    5 +-
>  drivers/iio/accel/mma9551.c                        |    4 +-
>  drivers/iio/accel/mma9553.c                        |    6 +-
>  drivers/iio/accel/msa311.c                         |    4 +-
>  drivers/iio/accel/mxc4005.c                        |    8 +-
>  drivers/iio/accel/sca3000.c                        |    2 +-
>  drivers/iio/accel/sca3300.c                        |   23 +-
>  drivers/iio/accel/st_accel_i2c.c                   |    6 +-
>  drivers/iio/accel/st_accel_spi.c                   |    4 +-
>  drivers/iio/accel/stk8312.c                        |    6 +-
>  drivers/iio/accel/stk8ba50.c                       |    8 +-
>  drivers/iio/adc/Kconfig                            |  155 ++-
>  drivers/iio/adc/Makefile                           |    4 +
>  drivers/iio/adc/ad4000.c                           |  387 ++++++-
>  drivers/iio/adc/ad4030.c                           |   68 +-
>  drivers/iio/adc/ad4130.c                           |   10 +-
>  drivers/iio/adc/ad4695.c                           |   19 +-
>  drivers/iio/adc/ad7091r-base.c                     |    9 +-
>  drivers/iio/adc/ad7124.c                           |  210 ++--
>  drivers/iio/adc/ad7266.c                           |    7 +-
>  drivers/iio/adc/ad7280a.c                          |    2 +-
>  drivers/iio/adc/ad7298.c                           |    4 +-
>  drivers/iio/adc/ad7380.c                           |   57 +-
>  drivers/iio/adc/ad7476.c                           |    4 +-
>  drivers/iio/adc/ad7606.c                           |  355 +++---
>  drivers/iio/adc/ad7606.h                           |  196 ++--
>  drivers/iio/adc/ad7606_par.c                       |   37 +-
>  drivers/iio/adc/ad7606_spi.c                       |  294 +++--
>  drivers/iio/adc/ad7768-1.c                         |  247 +++--
>  drivers/iio/adc/ad7779.c                           |    3 +-
>  drivers/iio/adc/ad7791.c                           |    2 +-
>  drivers/iio/adc/ad7923.c                           |    4 +-
>  drivers/iio/adc/ad7944.c                           |   11 -
>  drivers/iio/adc/ad799x.c                           |    2 +-
>  drivers/iio/adc/ad_sigma_delta.c                   |    4 +
>  drivers/iio/adc/adi-axi-adc.c                      |    2 +-
>  drivers/iio/adc/at91-sama5d2_adc.c                 |   13 +-
>  drivers/iio/adc/axp20x_adc.c                       |    8 +-
>  drivers/iio/adc/axp288_adc.c                       |    4 +-
>  drivers/iio/adc/cpcap-adc.c                        |    2 +-
>  drivers/iio/adc/da9150-gpadc.c                     |    2 +-
>  drivers/iio/adc/dln2-adc.c                         |    4 +-
>  drivers/iio/adc/envelope-detector.c                |    4 +-
>  drivers/iio/adc/fsl-imx25-gcq.c                    |    2 +-
>  drivers/iio/adc/hi8435.c                           |    2 +-
>  drivers/iio/adc/hx711.c                            |   11 +-
>  drivers/iio/adc/imx7d_adc.c                        |    2 +-
>  drivers/iio/adc/imx8qxp-adc.c                      |    2 +-
>  drivers/iio/adc/imx93_adc.c                        |    2 +-
>  drivers/iio/adc/ina2xx-adc.c                       |    2 +-
>  drivers/iio/adc/industrialio-adc.c                 |   82 ++
>  drivers/iio/adc/intel_mrfld_adc.c                  |    4 +-
>  drivers/iio/adc/lpc18xx_adc.c                      |    2 +-
>  drivers/iio/adc/ltc2471.c                          |    2 +-
>  drivers/iio/adc/max1118.c                          |    4 +-
>  drivers/iio/adc/max11410.c                         |    4 +-
>  drivers/iio/adc/max1363.c                          |    8 +-
>  drivers/iio/adc/max77541-adc.c                     |    2 +-
>  drivers/iio/adc/mcp3911.c                          |   62 +-
>  drivers/iio/adc/meson_saradc.c                     |   36 +-
>  drivers/iio/adc/mt6359-auxadc.c                    |    2 +-
>  drivers/iio/adc/mt6360-adc.c                       |    4 +-
>  drivers/iio/adc/mt6370-adc.c                       |    2 +-
>  drivers/iio/adc/mxs-lradc-adc.c                    |   17 +-
>  drivers/iio/adc/nct7201.c                          |  501 +++++++++
>  drivers/iio/adc/npcm_adc.c                         |    2 +-
>  drivers/iio/adc/pac1921.c                          |    7 +-
>  drivers/iio/adc/pac1934.c                          |    2 +-
>  drivers/iio/adc/palmas_gpadc.c                     |    2 +-
>  drivers/iio/adc/rcar-gyroadc.c                     |   11 +-
>  drivers/iio/adc/rn5t618-adc.c                      |    2 +-
>  drivers/iio/adc/rockchip_saradc.c                  |    3 +-
>  drivers/iio/adc/rohm-bd79124.c                     | 1146 ++++++++++++++=
++++++
>  drivers/iio/adc/rtq6056.c                          |    3 +-
>  drivers/iio/adc/rzg2l_adc.c                        |   41 +-
>  drivers/iio/adc/spear_adc.c                        |    2 +-
>  drivers/iio/adc/stm32-adc-core.h                   |   17 +
>  drivers/iio/adc/stm32-adc.c                        |  158 ++-
>  drivers/iio/adc/stm32-dfsdm-adc.c                  |    8 +-
>  drivers/iio/adc/sun20i-gpadc-iio.c                 |   41 +-
>  drivers/iio/adc/sun4i-gpadc-iio.c                  |    6 +-
>  drivers/iio/adc/ti-adc081c.c                       |    4 +-
>  drivers/iio/adc/ti-adc0832.c                       |    4 +-
>  drivers/iio/adc/ti-adc084s021.c                    |    4 +-
>  drivers/iio/adc/ti-adc12138.c                      |    4 +-
>  drivers/iio/adc/ti-adc128s052.c                    |   98 +-
>  drivers/iio/adc/ti-ads1015.c                       |  172 ++-
>  drivers/iio/adc/ti-ads1100.c                       |   44 +-
>  drivers/iio/adc/ti-ads1119.c                       |    4 +-
>  drivers/iio/adc/ti-ads124s08.c                     |    4 +-
>  drivers/iio/adc/ti-ads131e08.c                     |    4 +-
>  drivers/iio/adc/ti-ads7950.c                       |   17 +-
>  drivers/iio/adc/ti-ads8688.c                       |    4 +-
>  drivers/iio/adc/ti-lmp92064.c                      |    6 +-
>  drivers/iio/adc/ti-tlc4541.c                       |    4 +-
>  drivers/iio/adc/ti-tsc2046.c                       |    6 +-
>  drivers/iio/adc/twl6030-gpadc.c                    |    2 +-
>  drivers/iio/adc/vf610_adc.c                        |   46 +-
>  drivers/iio/adc/xilinx-xadc-core.c                 |    2 +-
>  drivers/iio/addac/ad74115.c                        |   25 +-
>  drivers/iio/addac/ad74413r.c                       |   37 +-
>  drivers/iio/afe/iio-rescale.c                      |    2 +-
>  drivers/iio/amplifiers/ad8366.c                    |    2 +-
>  drivers/iio/amplifiers/ada4250.c                   |    4 +-
>  drivers/iio/amplifiers/hmc425a.c                   |    5 +-
>  drivers/iio/cdc/ad7150.c                           |    4 +-
>  drivers/iio/cdc/ad7746.c                           |    4 +-
>  drivers/iio/chemical/Kconfig                       |   20 +
>  drivers/iio/chemical/Makefile                      |    2 +
>  drivers/iio/chemical/ags02ma.c                     |    4 +-
>  drivers/iio/chemical/atlas-ezo-sensor.c            |    4 +-
>  drivers/iio/chemical/atlas-sensor.c                |   14 +-
>  drivers/iio/chemical/bme680_core.c                 |    4 +-
>  drivers/iio/chemical/bme680_i2c.c                  |    4 +-
>  drivers/iio/chemical/bme680_spi.c                  |   12 +-
>  drivers/iio/chemical/ccs811.c                      |   83 +-
>  drivers/iio/chemical/ens160_core.c                 |    4 +-
>  drivers/iio/chemical/mhz19b.c                      |  316 ++++++
>  drivers/iio/chemical/pms7003.c                     |    4 +-
>  drivers/iio/chemical/scd30_core.c                  |    3 +-
>  drivers/iio/chemical/scd4x.c                       |   10 +-
>  drivers/iio/chemical/sen0322.c                     |  161 +++
>  drivers/iio/chemical/sps30.c                       |    4 +-
>  drivers/iio/chemical/sunrise_co2.c                 |    4 +-
>  .../iio/common/cros_ec_sensors/cros_ec_lid_angle.c |    2 +-
>  .../iio/common/cros_ec_sensors/cros_ec_sensors.c   |    2 +-
>  .../common/cros_ec_sensors/cros_ec_sensors_core.c  |   78 +-
>  drivers/iio/common/scmi_sensors/scmi_iio.c         |   11 +-
>  drivers/iio/common/ssp_sensors/ssp_dev.c           |    2 +-
>  drivers/iio/common/ssp_sensors/ssp_spi.c           |    2 +-
>  drivers/iio/common/st_sensors/st_sensors_core.c    |    7 +-
>  drivers/iio/dac/Kconfig                            |   11 +
>  drivers/iio/dac/Makefile                           |    1 +
>  drivers/iio/dac/ad3530r.c                          |  517 +++++++++
>  drivers/iio/dac/ad3552r-common.c                   |    4 +
>  drivers/iio/dac/ad3552r-hs.c                       |  182 +++-
>  drivers/iio/dac/ad3552r.h                          |    1 +
>  drivers/iio/dac/ad5064.c                           |    8 +-
>  drivers/iio/dac/ad5360.c                           |    2 +-
>  drivers/iio/dac/ad5380.c                           |    2 +-
>  drivers/iio/dac/ad5446.c                           |    6 +-
>  drivers/iio/dac/ad5449.c                           |    2 +-
>  drivers/iio/dac/ad5504.c                           |    4 +-
>  drivers/iio/dac/ad5592r-base.c                     |  156 ++-
>  drivers/iio/dac/ad5592r.c                          |    6 +-
>  drivers/iio/dac/ad5593r.c                          |    6 +-
>  drivers/iio/dac/ad5624r_spi.c                      |    4 +-
>  drivers/iio/dac/ad5686-spi.c                       |    2 +-
>  drivers/iio/dac/ad5686.c                           |    2 +-
>  drivers/iio/dac/ad5696-i2c.c                       |    4 +-
>  drivers/iio/dac/ad5755.c                           |    4 +-
>  drivers/iio/dac/ad5758.c                           |    2 +-
>  drivers/iio/dac/ad5761.c                           |    4 +-
>  drivers/iio/dac/ad5766.c                           |    8 +-
>  drivers/iio/dac/ad5770r.c                          |    4 +-
>  drivers/iio/dac/ad5791.c                           |    4 +-
>  drivers/iio/dac/ad7293.c                           |   17 +-
>  drivers/iio/dac/ad7303.c                           |    6 +-
>  drivers/iio/dac/ad8801.c                           |    2 +-
>  drivers/iio/dac/ad9739a.c                          |    4 +-
>  drivers/iio/dac/adi-axi-dac.c                      |   58 +-
>  drivers/iio/dac/dpot-dac.c                         |    2 +-
>  drivers/iio/dac/ds4424.c                           |    2 +-
>  drivers/iio/dac/lpc18xx_dac.c                      |    2 +-
>  drivers/iio/dac/ltc1660.c                          |    4 +-
>  drivers/iio/dac/ltc2632.c                          |    6 +-
>  drivers/iio/dac/ltc2688.c                          |   14 +-
>  drivers/iio/dac/max5522.c                          |    4 +-
>  drivers/iio/dac/max5821.c                          |    2 +-
>  drivers/iio/dac/mcp4725.c                          |    4 +-
>  drivers/iio/dac/mcp4728.c                          |    6 +-
>  drivers/iio/dac/mcp4821.c                          |    4 +-
>  drivers/iio/dac/mcp4922.c                          |    2 +-
>  drivers/iio/dac/rohm-bd79703.c                     |  116 +-
>  drivers/iio/dac/stm32-dac-core.c                   |    2 +-
>  drivers/iio/dac/stm32-dac.c                        |    4 +-
>  drivers/iio/dac/ti-dac082s085.c                    |    2 +-
>  drivers/iio/dac/ti-dac5571.c                       |    6 +-
>  drivers/iio/dac/ti-dac7311.c                       |    2 +-
>  drivers/iio/dac/ti-dac7612.c                       |    4 +-
>  drivers/iio/dac/vf610_dac.c                        |    4 +-
>  drivers/iio/dummy/iio_simple_dummy_buffer.c        |   27 +-
>  drivers/iio/filter/admv8818.c                      |  230 +++-
>  drivers/iio/frequency/ad9523.c                     |    2 +-
>  drivers/iio/frequency/adf4350.c                    |    6 +-
>  drivers/iio/frequency/adf4371.c                    |    6 +-
>  drivers/iio/frequency/adf4377.c                    |    4 +-
>  drivers/iio/frequency/admv1013.c                   |    8 +-
>  drivers/iio/frequency/admv1014.c                   |    4 +-
>  drivers/iio/frequency/adrf6780.c                   |    4 +-
>  drivers/iio/gyro/adis16080.c                       |    2 +-
>  drivers/iio/gyro/adis16260.c                       |    2 +-
>  drivers/iio/gyro/adxrs290.c                        |   14 +-
>  drivers/iio/gyro/adxrs450.c                        |    7 +-
>  drivers/iio/gyro/bmg160_i2c.c                      |    4 +-
>  drivers/iio/gyro/bmg160_spi.c                      |    2 +-
>  drivers/iio/gyro/hid-sensor-gyro-3d.c              |    2 +-
>  drivers/iio/gyro/mpu3050-core.c                    |    2 +-
>  drivers/iio/gyro/mpu3050-i2c.c                     |    4 +-
>  drivers/iio/gyro/st_gyro_i2c.c                     |    4 +-
>  drivers/iio/gyro/st_gyro_spi.c                     |    4 +-
>  drivers/iio/health/afe4403.c                       |    4 +-
>  drivers/iio/health/afe4404.c                       |    4 +-
>  drivers/iio/health/max30100.c                      |    2 +-
>  drivers/iio/health/max30102.c                      |    6 +-
>  drivers/iio/humidity/am2315.c                      |    2 +-
>  drivers/iio/humidity/hdc100x.c                     |   68 +-
>  drivers/iio/humidity/hdc2010.c                     |   14 +-
>  drivers/iio/humidity/hid-sensor-humidity.c         |    2 +-
>  drivers/iio/humidity/hts221_core.c                 |   91 +-
>  drivers/iio/humidity/hts221_i2c.c                  |    6 +-
>  drivers/iio/humidity/hts221_spi.c                  |    4 +-
>  drivers/iio/humidity/htu21.c                       |    4 +-
>  drivers/iio/imu/adis.c                             |    9 -
>  drivers/iio/imu/adis16400.c                        |    2 +-
>  drivers/iio/imu/adis16460.c                        |    4 +-
>  drivers/iio/imu/adis16475.c                        |    2 +-
>  drivers/iio/imu/adis16480.c                        |    2 +-
>  drivers/iio/imu/adis_buffer.c                      |    3 -
>  drivers/iio/imu/bmi160/bmi160_i2c.c                |    6 +-
>  drivers/iio/imu/bmi160/bmi160_spi.c                |    6 +-
>  drivers/iio/imu/inv_icm42600/inv_icm42600.h        |    2 +-
>  drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  |   23 +-
>  drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   |   14 +-
>  drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c   |   23 +-
>  drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c    |    5 +-
>  drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c    |    5 +-
>  drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c   |    7 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c         |    2 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |   14 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c          |    4 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c          |    4 +-
>  drivers/iio/imu/kmx61.c                            |    2 +-
>  drivers/iio/imu/smi240.c                           |    7 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |   16 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c        |    6 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c        |    2 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c       |   73 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c        |    4 +-
>  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c        |    6 +-
>  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c        |    4 +-
>  drivers/iio/industrialio-backend.c                 |   28 +
>  drivers/iio/industrialio-core.c                    |   41 +-
>  drivers/iio/light/acpi-als.c                       |    2 +-
>  drivers/iio/light/adux1020.c                       |    2 +-
>  drivers/iio/light/al3000a.c                        |   11 +-
>  drivers/iio/light/al3010.c                         |  105 +-
>  drivers/iio/light/al3320a.c                        |  116 +-
>  drivers/iio/light/apds9306.c                       |    7 +-
>  drivers/iio/light/apds9960.c                       |    2 +-
>  drivers/iio/light/as73211.c                        |   42 +-
>  drivers/iio/light/bh1750.c                         |   24 +
>  drivers/iio/light/bh1780.c                         |    2 +-
>  drivers/iio/light/cm3232.c                         |    4 +-
>  drivers/iio/light/cm3323.c                         |    4 +-
>  drivers/iio/light/cm3605.c                         |    2 +-
>  drivers/iio/light/cros_ec_light_prox.c             |    2 +-
>  drivers/iio/light/gp2ap002.c                       |    2 +-
>  drivers/iio/light/gp2ap020a00f.c                   |    7 +-
>  drivers/iio/light/hid-sensor-als.c                 |    2 +-
>  drivers/iio/light/hid-sensor-prox.c                |    5 +-
>  drivers/iio/light/isl29018.c                       |    4 +-
>  drivers/iio/light/isl29028.c                       |    4 +-
>  drivers/iio/light/isl29125.c                       |    7 +-
>  drivers/iio/light/jsa1212.c                        |    2 +-
>  drivers/iio/light/ltr390.c                         |    4 +-
>  drivers/iio/light/ltr501.c                         |  170 +--
>  drivers/iio/light/ltrf216a.c                       |    4 +-
>  drivers/iio/light/opt4001.c                        |    2 +-
>  drivers/iio/light/opt4060.c                        |    5 +-
>  drivers/iio/light/pa12203001.c                     |    4 +-
>  drivers/iio/light/rohm-bu27034.c                   |   14 +-
>  drivers/iio/light/rpr0521.c                        |   63 +-
>  drivers/iio/light/si1145.c                         |   25 +-
>  drivers/iio/light/st_uvis25_core.c                 |    7 +-
>  drivers/iio/light/st_uvis25_i2c.c                  |    4 +-
>  drivers/iio/light/st_uvis25_spi.c                  |    4 +-
>  drivers/iio/light/stk3310.c                        |    8 +-
>  drivers/iio/light/tcs3414.c                        |    9 +-
>  drivers/iio/light/tcs3472.c                        |    9 +-
>  drivers/iio/light/tsl2563.c                        |    4 +-
>  drivers/iio/light/tsl2583.c                        |    4 +-
>  drivers/iio/light/tsl2591.c                        |    2 +-
>  drivers/iio/light/tsl2772.c                        |    4 +-
>  drivers/iio/light/us5182d.c                        |    6 +-
>  drivers/iio/light/vcnl4000.c                       |   82 +-
>  drivers/iio/light/vcnl4035.c                       |   42 +-
>  drivers/iio/light/veml6040.c                       |    4 +-
>  drivers/iio/light/veml6075.c                       |    2 +-
>  drivers/iio/light/vl6180.c                         |    2 +-
>  drivers/iio/light/zopt2201.c                       |   42 +-
>  drivers/iio/magnetometer/af8133j.c                 |    3 +-
>  drivers/iio/magnetometer/ak8974.c                  |   10 +-
>  drivers/iio/magnetometer/ak8975.c                  |    8 +-
>  drivers/iio/magnetometer/als31300.c                |    7 +-
>  drivers/iio/magnetometer/bmc150_magn.c             |    4 +-
>  drivers/iio/magnetometer/bmc150_magn_i2c.c         |    2 +-
>  drivers/iio/magnetometer/bmc150_magn_spi.c         |    2 +-
>  drivers/iio/magnetometer/hid-sensor-magn-3d.c      |    2 +-
>  drivers/iio/magnetometer/hmc5843.h                 |    2 +-
>  drivers/iio/magnetometer/hmc5843_core.c            |    4 +-
>  drivers/iio/magnetometer/hmc5843_i2c.c             |    2 +-
>  drivers/iio/magnetometer/hmc5843_spi.c             |    1 -
>  drivers/iio/magnetometer/mag3110.c                 |  165 ++-
>  drivers/iio/magnetometer/mmc35240.c                |    4 +-
>  drivers/iio/magnetometer/rm3100-core.c             |   11 +-
>  drivers/iio/magnetometer/rm3100-spi.c              |    1 -
>  drivers/iio/magnetometer/st_magn_i2c.c             |    4 +-
>  drivers/iio/magnetometer/st_magn_spi.c             |    4 +-
>  drivers/iio/magnetometer/tmag5273.c                |    4 +-
>  drivers/iio/magnetometer/yamaha-yas530.c           |    8 +-
>  drivers/iio/multiplexer/iio-mux.c                  |    2 +-
>  drivers/iio/orientation/hid-sensor-incl-3d.c       |    2 +-
>  drivers/iio/orientation/hid-sensor-rotation.c      |    4 +-
>  .../iio/position/hid-sensor-custom-intel-hinge.c   |    2 +-
>  drivers/iio/potentiometer/ad5272.c                 |    4 +-
>  drivers/iio/potentiometer/ds1803.c                 |    4 +-
>  drivers/iio/potentiometer/max5432.c                |    2 +-
>  drivers/iio/potentiometer/max5487.c                |    2 +-
>  drivers/iio/potentiometer/mcp4018.c                |    4 +-
>  drivers/iio/potentiometer/mcp41010.c               |    4 +-
>  drivers/iio/potentiometer/mcp4131.c                |    4 +-
>  drivers/iio/potentiometer/mcp4531.c                |    4 +-
>  drivers/iio/potentiometer/tpl0102.c                |    2 +-
>  drivers/iio/potentiostat/lmp91000.c                |    4 +-
>  drivers/iio/pressure/abp060mg.c                    |    2 +-
>  drivers/iio/pressure/bmp280-core.c                 |  110 +-
>  drivers/iio/pressure/bmp280-i2c.c                  |    4 +-
>  drivers/iio/pressure/bmp280-spi.c                  |   10 +-
>  drivers/iio/pressure/bmp280.h                      |    8 -
>  drivers/iio/pressure/cros_ec_baro.c                |    2 +-
>  drivers/iio/pressure/dlhl60d.c                     |   11 +-
>  drivers/iio/pressure/dps310.c                      |    4 +-
>  drivers/iio/pressure/hid-sensor-press.c            |    7 +-
>  drivers/iio/pressure/hp03.c                        |    2 +-
>  drivers/iio/pressure/hp206c.c                      |    4 +-
>  drivers/iio/pressure/hsc030pa.c                    |    4 +-
>  drivers/iio/pressure/hsc030pa_i2c.c                |    4 +-
>  drivers/iio/pressure/hsc030pa_spi.c                |    4 +-
>  drivers/iio/pressure/icp10100.c                    |   15 +-
>  drivers/iio/pressure/mpl115_spi.c                  |    2 +-
>  drivers/iio/pressure/mpl3115.c                     |  101 +-
>  drivers/iio/pressure/mprls0025pa_i2c.c             |    4 +-
>  drivers/iio/pressure/mprls0025pa_spi.c             |    4 +-
>  drivers/iio/pressure/ms5611_core.c                 |    8 +-
>  drivers/iio/pressure/ms5611_spi.c                  |    1 -
>  drivers/iio/pressure/ms5637.c                      |    4 +-
>  drivers/iio/pressure/rohm-bm1390.c                 |   14 +-
>  drivers/iio/pressure/st_pressure_i2c.c             |    6 +-
>  drivers/iio/pressure/st_pressure_spi.c             |    4 +-
>  drivers/iio/pressure/zpa2326.c                     |   21 +-
>  drivers/iio/pressure/zpa2326_spi.c                 |    3 +-
>  drivers/iio/proximity/as3935.c                     |    8 +-
>  drivers/iio/proximity/cros_ec_mkbp_proximity.c     |   17 +-
>  drivers/iio/proximity/hx9023s.c                    |   15 +-
>  drivers/iio/proximity/irsd200.c                    |   14 +-
>  drivers/iio/proximity/isl29501.c                   |    4 +-
>  drivers/iio/proximity/mb1232.c                     |    6 +-
>  drivers/iio/proximity/ping.c                       |    2 +-
>  drivers/iio/proximity/pulsedlight-lidar-lite-v2.c  |    9 +-
>  drivers/iio/proximity/srf04.c                      |    2 +-
>  drivers/iio/proximity/srf08.c                      |    6 +-
>  drivers/iio/proximity/sx9310.c                     |    6 +-
>  drivers/iio/proximity/sx9324.c                     |    2 +-
>  drivers/iio/proximity/sx9500.c                     |   11 +-
>  drivers/iio/proximity/sx_common.c                  |    4 +-
>  drivers/iio/proximity/vcnl3020.c                   |    2 +-
>  drivers/iio/proximity/vl53l0x-i2c.c                |    4 +-
>  drivers/iio/resolver/ad2s1200.c                    |    2 +-
>  drivers/iio/resolver/ad2s1210.c                    |    5 +-
>  drivers/iio/resolver/ad2s90.c                      |    4 +-
>  drivers/iio/temperature/hid-sensor-temperature.c   |    7 +-
>  drivers/iio/temperature/ltc2983.c                  |    4 +-
>  drivers/iio/temperature/maxim_thermocouple.c       |   37 +-
>  drivers/iio/temperature/mcp9600.c                  |    4 +-
>  drivers/iio/temperature/tmp006.c                   |    4 +-
>  drivers/iio/temperature/tmp007.c                   |    2 +-
>  drivers/iio/temperature/tsys01.c                   |    4 +-
>  drivers/iio/temperature/tsys02d.c                  |    2 +-
>  drivers/iio/test/iio-test-format.c                 |    2 +-
>  drivers/iio/test/iio-test-gts.c                    |    2 +-
>  drivers/iio/test/iio-test-rescale.c                |    2 +-
>  drivers/iio/trigger/stm32-lptimer-trigger.c        |   77 +-
>  drivers/iio/trigger/stm32-timer-trigger.c          |    4 +-
>  drivers/staging/iio/accel/adis16203.c              |    2 +-
>  drivers/staging/iio/adc/ad7816.c                   |    2 +-
>  drivers/staging/iio/addac/adt7316-i2c.c            |    2 +-
>  drivers/staging/iio/addac/adt7316.c                |    2 +-
>  drivers/staging/iio/frequency/ad9832.c             |  102 +-
>  drivers/staging/iio/frequency/ad9832.h             |    1 -
>  drivers/staging/iio/frequency/ad9834.c             |    4 +-
>  drivers/staging/iio/impedance-analyzer/ad5933.c    |   44 +-
>  include/dt-bindings/iio/adc/adi,ad7606.h           |    9 +
>  include/linux/hid-sensor-hub.h                     |   19 +-
>  include/linux/iio/adc-helpers.h                    |   27 +
>  include/linux/iio/backend.h                        |    5 +
>  include/linux/iio/buffer.h                         |   12 +
>  include/linux/iio/iio.h                            |   51 +-
>  include/linux/iio/timer/stm32-lptim-trigger.h      |    9 +
>  include/linux/property.h                           |   20 +
>  tools/iio/iio_generic_buffer.c                     |    2 +-
>  464 files changed, 8481 insertions(+), 3189 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,nct=
7201.yaml
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/rohm,bd7910=
4.yaml
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/rohm,bd7912=
4.yaml
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/winsen=
,mhz19b.yaml
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad3530r=
.yaml
>  create mode 100644 Documentation/iio/ad3552r.rst
>  create mode 100644 drivers/iio/adc/industrialio-adc.c
>  create mode 100644 drivers/iio/adc/nct7201.c
>  create mode 100644 drivers/iio/adc/rohm-bd79124.c
>  create mode 100644 drivers/iio/chemical/mhz19b.c
>  create mode 100644 drivers/iio/chemical/sen0322.c
>  create mode 100644 drivers/iio/dac/ad3530r.c
>  create mode 100644 include/dt-bindings/iio/adc/adi,ad7606.h
>  create mode 100644 include/linux/iio/adc-helpers.h


