Return-Path: <linux-iio+bounces-19063-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 403C0AA88B8
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 19:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02670189124A
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 17:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213C421D00A;
	Sun,  4 May 2025 17:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQQWf8gT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C987C376;
	Sun,  4 May 2025 17:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746380556; cv=none; b=YScjQ6JTkvth3OINiJkyrx53H32tUH5piR4FCn+DWril5+LaLrh7vR1Qjk2s8ZrSrFKxxO53x+cfj5aBFu53o3+u1CIRMAlLlWGIa4sFU4zhbCt1Kwtc69wJQjhRm1r1ObaKnYWaBK+ALkSPqX4tBMDqshYD9hD6Oq42/54gD5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746380556; c=relaxed/simple;
	bh=WkYL6FGlVclDrlXDvCs0OiEahCDRSD1HxxaguC0IEU0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QdrHwnx8V+gmb8dnSf5D2DUYIM9HIVwCnMDN3yJAuyjZlrekJozEjCOriSbT8QEN5G+N7qnmvxwnhCm0qlKmiPGDW4T2haZEIu7630tXVLXkVhZirsFPsz/IZ+pesssv5uyogCOY4AJq83wECLN4eZLYrYlW2jfAL/5moe1MYpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQQWf8gT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E20C4CEE7;
	Sun,  4 May 2025 17:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746380556;
	bh=WkYL6FGlVclDrlXDvCs0OiEahCDRSD1HxxaguC0IEU0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CQQWf8gTmjfB7/3upXI1NZYr1j08YJ7xMdEmqBA2n5oM1is0gOMDUzKk3DmTj7vrJ
	 GqONafVvQc53pVQnmIiGn25CK0ZRSIp+B8CPDepZMlJzsY65sJIAQPp6+hYEIFWHg4
	 MOzMi9ClKiCYGsm7OfvZJROsG9bVzrCCpBZaAwyO7EXCOUp76DGBcsZM7OJGCQsKuW
	 jIz8z8k9erCYOxGERolkMMoa3f070LdOyqxj77dqv7lvMTju/sjN/sZAQZV64FVCJ+
	 9nmuaIU1tNYv37TpDqo7FAqY1DgZCwDQz6+/prjSJ1iv+idW4cMQ/LEwxYMQnO1t/O
	 ihmpKbwvo7z5Q==
Date: Sun, 4 May 2025 18:42:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <lars@metafoo.de>,
 <Michael.Hennerich@analog.com>, <dlechner@baylibre.com>,
 <nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v2 7/7] iio: adc: ad4170: Add support for weigh scale
 and RTD sensors
Message-ID: <20250504184227.177d1764@jic23-huawei>
In-Reply-To: <3687a9e0a479aef9736ad557b341ed2e7d4f5756.1745841276.git.marcelo.schmitt@analog.com>
References: <cover.1745841276.git.marcelo.schmitt@analog.com>
	<3687a9e0a479aef9736ad557b341ed2e7d4f5756.1745841276.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Apr 2025 09:29:40 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> The AD4170 design has features to aid interfacing with weigh scale and RTD
> sensors that are expected to be setup with external circuitry for proper
> sensor operation. A key characteristic of those sensors is that the circuit
> they are in must be excited with a pair of signals. The external circuit
> can be excited either by voltage supply or by AD4170 excitation signals.
> The sensor can then be read through a different pair of lines that are
> connected to AD4170 ADC.
> 
> Configure AD4170 to handle external circuit sensors.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Hi Marcelo

A few comments inline.

Jonathan

> ---
> changes since v1:
> - Improved to support more than one external sensor connected.
> 
>  drivers/iio/adc/ad4170.c | 375 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 372 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad4170.c b/drivers/iio/adc/ad4170.c
> index 335b4194c7eb..9e4a9b524dd4 100644
> --- a/drivers/iio/adc/ad4170.c
> +++ b/drivers/iio/adc/ad4170.c
> @@ -62,6 +62,8 @@
>  #define AD4170_FILTER_FS_REG(x)				(0xC7 + 14 * (x))
>  #define AD4170_OFFSET_REG(x)				(0xCA + 14 * (x))
>  #define AD4170_GAIN_REG(x)				(0xCD + 14 * (x))
> +#define AD4170_V_BIAS_REG				0x135
> +#define AD4170_CURRENT_SRC_REG(x)			(0x139 + 2 * (x))
>  #define AD4170_GPIO_MODE_REG				0x191
>  #define AD4170_GPIO_OUTPUT_REG				0x193
>  #define AD4170_GPIO_INPUT_REG				0x195
> @@ -110,6 +112,10 @@
>  /* AD4170_FILTER_REG */
>  #define AD4170_FILTER_FILTER_TYPE_MSK			GENMASK(3, 0)
>  
> +/* AD4170_CURRENT_SRC_REG */
> +#define AD4170_CURRENT_SRC_I_OUT_PIN_MSK		GENMASK(12, 8)
> +#define AD4170_CURRENT_SRC_I_OUT_VAL_MSK		GENMASK(2, 0)
> +
>  /* AD4170 register constants */
>  
>  /* AD4170_CLOCK_CTRL_REG constants */
> @@ -171,6 +177,21 @@
>  #define AD4170_FILTER_FILTER_TYPE_SINC5			0x4
>  #define AD4170_FILTER_FILTER_TYPE_SINC3			0x6
>  
> +/* AD4170_CURRENT_SRC_REG constants */

These seem a bit repetitive. Can we use some macros?

#define AD4170_CURRENT_SRC_I_OUT_PIN_AIN(x) (x)
#define AD4170_CURRENT_SRC_I_OUT_PIN_GPIO(x) (x + 17)

> +#define AD4170_CURRENT_SRC_I_OUT_PIN_AIN0		0
> +#define AD4170_CURRENT_SRC_I_OUT_PIN_AIN1		1
> +#define AD4170_CURRENT_SRC_I_OUT_PIN_AIN2		2
> +#define AD4170_CURRENT_SRC_I_OUT_PIN_AIN3		3
> +#define AD4170_CURRENT_SRC_I_OUT_PIN_AIN4		4
> +#define AD4170_CURRENT_SRC_I_OUT_PIN_AIN5		5
> +#define AD4170_CURRENT_SRC_I_OUT_PIN_AIN6		6
> +#define AD4170_CURRENT_SRC_I_OUT_PIN_AIN7		7
> +#define AD4170_CURRENT_SRC_I_OUT_PIN_AIN8		8
> +#define AD4170_CURRENT_SRC_I_OUT_PIN_GPIO0		17
> +#define AD4170_CURRENT_SRC_I_OUT_PIN_GPIO1		18
> +#define AD4170_CURRENT_SRC_I_OUT_PIN_GPIO2		19
> +#define AD4170_CURRENT_SRC_I_OUT_PIN_GPIO3		20
> +
>  /* Device properties and auxiliary constants */
>  
>  #define AD4170_NUM_ANALOG_PINS				9
> @@ -204,6 +225,15 @@
>  #define AD4170_PIN_UNASIGNED				0x00
>  #define AD4170_PIN_ANALOG_IN				0x01
>  #define AD4170_PIN_CURRENT_OUT				0x02
> +#define AD4170_PIN_VBIAS				0x04
> +
> +/* GPIO pin functions  */
> +#define AD4170_GPIO_UNASIGNED				0x00
> +#define AD4170_GPIO_AC_EXCITATION			0x02
> +#define AD4170_GPIO_OUTPUT				0x04
> +
> +/* Current source */
> +#define AD4170_CURRENT_SRC_DISABLED			0xFF
>  
>  static const unsigned int ad4170_reg_size[] = {
>  	[AD4170_CONFIG_A_REG] = 1,
> @@ -244,6 +274,8 @@ static const unsigned int ad4170_reg_size[] = {
>  	[AD4170_OFFSET_REG(5) ... AD4170_GAIN_REG(5)] = 3,
>  	[AD4170_OFFSET_REG(6) ... AD4170_GAIN_REG(6)] = 3,
>  	[AD4170_OFFSET_REG(7) ... AD4170_GAIN_REG(7)] = 3,
> +	[AD4170_V_BIAS_REG] = 2,
> +	[AD4170_CURRENT_SRC_REG(0) ... AD4170_CURRENT_SRC_REG(3)] = 2,
>  	[AD4170_GPIO_MODE_REG] = 2,
>  	[AD4170_GPIO_OUTPUT_REG] = 2,
>  	[AD4170_GPIO_INPUT_REG] = 2,
> @@ -305,6 +337,33 @@ static const unsigned int ad4170_sinc5_filt_fs_tbl[] = {
>  	1, 2, 4, 8, 12, 16, 20, 40, 48, 80, 100, 256,
>  };
>  
> +static const unsigned int ad4170_iout_pin_tbl[] = {
> +	AD4170_CURRENT_SRC_I_OUT_PIN_AIN0,
> +	AD4170_CURRENT_SRC_I_OUT_PIN_AIN1,
> +	AD4170_CURRENT_SRC_I_OUT_PIN_AIN2,
> +	AD4170_CURRENT_SRC_I_OUT_PIN_AIN3,
> +	AD4170_CURRENT_SRC_I_OUT_PIN_AIN4,
> +	AD4170_CURRENT_SRC_I_OUT_PIN_AIN5,
> +	AD4170_CURRENT_SRC_I_OUT_PIN_AIN6,
> +	AD4170_CURRENT_SRC_I_OUT_PIN_AIN7,
> +	AD4170_CURRENT_SRC_I_OUT_PIN_AIN8,
> +	AD4170_CURRENT_SRC_I_OUT_PIN_GPIO0,
> +	AD4170_CURRENT_SRC_I_OUT_PIN_GPIO1,
> +	AD4170_CURRENT_SRC_I_OUT_PIN_GPIO2,
> +	AD4170_CURRENT_SRC_I_OUT_PIN_GPIO3,
> +};
> +
> +static const unsigned int ad4170_iout_current_ua_tbl[] = {
> +	0, 10, 50, 100, 250, 500, 1000, 1500

I think Andy got this, but trailing comma.

> +};
> +
> +enum ad4170_sensor_type {
> +	AD4170_WEIGH_SCALE_SENSOR = 0,
> +	AD4170_RTD_SENSOR = 1,
> +	AD4170_THERMOCOUPLE_SENSOR = 2,
> +	AD4170_ADC_SENSOR = 3,
> +};
> +
>  struct ad4170_chip_info {
>  	const char *name;
>  };
> @@ -378,6 +437,8 @@ struct ad4170_state {
>  	struct clk *ext_clk;
>  	struct clk_hw int_clk_hw;
>  	int pins_fn[AD4170_NUM_ANALOG_PINS];
> +	int gpio_fn[AD4170_NUM_GPIO_PINS];
> +	unsigned int cur_src_pins[AD4170_NUM_CURRENT_SRC];
>  	struct gpio_chip gpiochip;
>  	u32 int_pin_sel;
>  	int sps_tbl[ARRAY_SIZE(ad4170_filt_names)][AD4170_MAX_FS_TBL_SIZE][2];
> @@ -925,6 +986,19 @@ static int ad4170_get_ain_voltage_uv(struct ad4170_state *st, int ain_n,
>  	struct device *dev = &st->spi->dev;
>  
>  	*ain_voltage = 0;
> +	/*
> +	 * The voltage bias (vbias) sets the common-mode voltage of the channel
> +	 * to (AVDD + AVSS)/2. If provided, AVSS supply provides the magnitude
> +	 * (absolute value) of the negative voltage supplied to the AVSS pin.
> +	 * So, we do AVDD - AVSS to compute the DC voltage generated by the bias
> +	 * voltage generator.
> +	 */
> +	if (st->pins_fn[ain_n] & AD4170_PIN_VBIAS) {
> +		*ain_voltage = (st->vrefs_uv[AD4170_AVDD_SUP]
> +				- st->vrefs_uv[AD4170_AVSS_SUP]) / 2;
> +		return 0;
> +	}
> +
>  	if (ain_n <= AD4170_CHAN_MAP_TEMP_SENSOR)
>  		return 0;
>  
> @@ -1742,6 +1816,266 @@ static int ad4170_gpio_init(struct iio_dev *indio_dev)
>  	return devm_gpiochip_add_data(&st->spi->dev, &st->gpiochip, indio_dev);
>  }
>  
> +static int _ad4170_find_table_index(const unsigned int *tbl, size_t len,
> +				    unsigned int val)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < len; i++)
> +		if (tbl[i] == val)
> +			return i;
I wonder if this is worth while vs the opencoded version

	for (i = 0; i < ARRAY_SIZE(ad4170_iout_pin_tbl); i++)
		if (ad4170_iout_pin_tbl[i] == val)
			break;

	if (i == ARRAY_SIZE(ad4170_iout_pin_tbl))
		return -EINVAL;

There is a bit more repetition and opportunity for missmatches
between which table etc, but it is pretty compact and you
only have two usecases of the function via the macro.

> +
> +	return -EINVAL;
> +}
> +
> +#define ad4170_find_table_index(table, val) \
> +	_ad4170_find_table_index(table, ARRAY_SIZE(table), val)
> +
> +static int ad4170_validate_excitation_pins(struct ad4170_state *st,
> +					   u32 *exc_pins, int num_exc_pins)
> +{
> +	struct device *dev = &st->spi->dev;
> +	int ret, i;
> +
> +	for (i = 0; i < num_exc_pins; i++) {
> +		unsigned int pin = exc_pins[i];
> +
> +		ret = ad4170_find_table_index(ad4170_iout_pin_tbl, pin);
> +		if (ret < 0)
> +			return dev_err_probe(dev, ret,
> +					     "Invalid excitation pin: %u\n",
> +					     pin);
> +
> +		if (pin <= AD4170_MAX_ANALOG_PINS) {
> +			if (st->pins_fn[pin] != AD4170_PIN_UNASIGNED)
> +				return dev_err_probe(dev, -EINVAL,
> +						     "Pin %u already used with fn %u\n",
> +						     pin, st->pins_fn[pin]);
> +
> +			st->pins_fn[pin] |= AD4170_PIN_CURRENT_OUT;
> +		} else {
> +			unsigned int gpio = pin - AD4170_CURRENT_SRC_I_OUT_PIN_GPIO0;
> +
> +			if (st->gpio_fn[gpio] != AD4170_GPIO_UNASIGNED)
> +				return dev_err_probe(dev, -EINVAL,
> +						     "GPIO %u already used with fn %u\n",
> +						     gpio, st->gpio_fn[gpio]);
> +
> +			st->gpio_fn[gpio] |= AD4170_GPIO_AC_EXCITATION;
> +		}
> +	}
> +	return 0;
> +}
> +

> +
> +static int ad4170_setup_bridge(struct ad4170_state *st,
> +			       struct fwnode_handle *child,
> +			       struct ad4170_setup *setup, u32 *exc_pins,
> +			       int num_exc_pins, int exc_cur, bool ac_excited)
> +{
> +	int ret;
> +
> +	/*
> +	 * If a specific current is provided through
> +	 * adi,excitation-current-microamp, set excitation pins provided through
> +	 * adi,excitation-pins to AC excite the bridge circuit. Else, use
> +	 * predefined ACX1, ACX1 negated, ACX2, ACX2 negated signals to AC
> +	 * excite the bridge. Those signals are output on GPIO2, GPIO0, GPIO3,
> +	 * and GPIO1, respectively. If only two pins are specified for AC
> +	 * excitation, use ACX1 and ACX2.
> +	 *
> +	 * Also, to avoid any short-circuit condition when more than one channel
> +	 * is enabled, set GPIO2 and GPIO0 high, and set GPIO1 and GPIO3 low to
> +	 * DC excite the bridge whenever a channel without AC excitation is
> +	 * selected. That is needed because GPIO pins are controlled by the next
> +	 * highest priority GPIO function when a channel doesn't enable AC
> +	 * excitation. See datasheet Figure 113 Weigh Scale (AC Excitation) for
> +	 * an example circuit diagram.
> +	 */
> +	if (exc_cur == 0 && ac_excited) {
> +		if (num_exc_pins == 2) {
> +			setup->misc |= FIELD_PREP(AD4170_MISC_CHOP_ADC_MSK, 0x3);
> +			ret = regmap_set_bits(st->regmap,
> +					      AD4170_GPIO_MODE_REG,
> +					      BIT(7) | BIT(5));
These are fields in a register with meaning that isn't obvious here.
Should have defines to give them a 'meaning'.
I'll guess this is setting two separate 1 bit values in 2 bit fields?
Those need defines that take the index of the gpio.


> +			if (ret)
> +				return ret;
> +
> +			ret = regmap_set_bits(st->regmap,
> +					      AD4170_GPIO_OUTPUT_REG,
> +					      BIT(3) | BIT(2));

This is a bit more obvious as those are the two pins we are using
but maybe a comment.

> +			if (ret)
> +				return ret;
> +
> +			st->gpio_fn[3] |= AD4170_GPIO_OUTPUT;
> +			st->gpio_fn[2] |= AD4170_GPIO_OUTPUT;
> +		} else {
> +			setup->misc |= FIELD_PREP(AD4170_MISC_CHOP_ADC_MSK, 0x2);
> +			ret = regmap_set_bits(st->regmap,
> +					      AD4170_GPIO_MODE_REG,
> +					      BIT(7) | BIT(5) | BIT(3) | BIT(1));
As above. Looks like a bunch of 2 bit fields with value 1?
> +			if (ret)
> +				return ret;
> +
> +			ret = regmap_set_bits(st->regmap,
> +					      AD4170_GPIO_OUTPUT_REG,
> +					      BIT(3) | BIT(2) | BIT(1) | BIT(0));
> +			if (ret)
> +				return ret;
> +
> +			st->gpio_fn[3] |= AD4170_GPIO_OUTPUT;
> +			st->gpio_fn[2] |= AD4170_GPIO_OUTPUT;
> +			st->gpio_fn[1] |= AD4170_GPIO_OUTPUT;
> +			st->gpio_fn[0] |= AD4170_GPIO_OUTPUT;
> +		}
> +
> +		return 0;
> +	}
> +
> +	return ad4170_setup_current_src(st, child, setup, exc_pins,
> +					num_exc_pins, exc_cur, ac_excited);
> +}


