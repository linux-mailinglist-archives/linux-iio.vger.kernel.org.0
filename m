Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D04B276269
	for <lists+linux-iio@lfdr.de>; Wed, 23 Sep 2020 22:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgIWUrf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Sep 2020 16:47:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:38508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbgIWUrf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 23 Sep 2020 16:47:35 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0C24214F1;
        Wed, 23 Sep 2020 20:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600894052;
        bh=+9479RGK6KbyT0ynhzB90EhoAUP4OJLsjtp6N2fddaE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Jyj9N1sbn70UVk9lhlJ3+e6zXzRC0a8OQQRzPDOkFXukgibPy9GQFeMB499+Ap1hT
         c+ny0eEnBtqk86r5ZEBDymbzIcd8BMlSxngmm7NPi3q3rKS6A1MGld0fRUiKnpXXsX
         rO70vgwL7CgunxnsD6I5JZljMXv/ivJ1EQ7GWkrU=
Date:   Wed, 23 Sep 2020 21:47:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: xilinx-xadc: Add basic support for Ultrascale
 System Monitor
Message-ID: <20200923214728.6e0c07b0@archlinux>
In-Reply-To: <20200922134624.13191-2-lars@metafoo.de>
References: <20200922134624.13191-1-lars@metafoo.de>
        <20200922134624.13191-2-lars@metafoo.de>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 22 Sep 2020 15:46:24 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> The xilinx-xadc IIO driver currently has support for the XADC in the Xilinx
> 7 series FPGAs. The system-monitor is the equivalent to the XADC in the
> Xilinx UltraScale and UltraScale+ FPGAs.
> 
> The IP designers did a good job at maintaining backwards compatibility and
> only minor changes are required to add basic support for the system-monitor
> core.
> 
> The non backwards compatible changes are:
>   * Register map offset was moved from 0x200 to 0x400
>   * Only one ADC compared to two in the XADC
>   * 10 bit ADC instead of 12 bit ADC
>   * Two of the channels monitor different supplies
> 
> Add the necessary logic to accommodate these changes to support the
> system-monitor in the XADC driver.
> 
> Note that this patch does not include support for some new features found
> in the system-monitor like additional alarms, user supply monitoring and
> secondary system-monitor access. This might be added at a later time.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Very nice.  Will let this sit on the mailing list a bit longer
but looks good to me.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/Kconfig              |  11 +-
>  drivers/iio/adc/xilinx-xadc-core.c   | 202 ++++++++++++++++++++-------
>  drivers/iio/adc/xilinx-xadc-events.c |   9 +-
>  drivers/iio/adc/xilinx-xadc.h        |   6 +
>  4 files changed, 172 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index e7a9c1834d39..c31fb6b8f8e3 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1215,8 +1215,15 @@ config XILINX_XADC
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
>  	help
> -	  Say yes here to have support for the Xilinx XADC. The driver does support
> -	  both the ZYNQ interface to the XADC as well as the AXI-XADC interface.
> +	  Say yes here to have support for the Xilinx 7 Series XADC or
> +	  UltraScale/UltraScale+ System Management Wizard.
> +
> +	  For the 7 Series the driver does support both the ZYNQ interface
> +	  to the XADC as well as the AXI-XADC interface.
> +
> +	  The driver also support the Xilinx System Management Wizard IP core
> +	  that can be used to access the System Monitor ADC on the Xilinx
> +	  UltraScale and UltraScale+ FPGAs.
>  
>  	  The driver can also be build as a module. If so, the module will be called
>  	  xilinx-xadc.
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index d0b7ef296afb..294ca3455587 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -92,7 +92,12 @@ static const unsigned int XADC_ZYNQ_UNMASK_TIMEOUT = 500;
>  #define XADC_AXI_REG_GIER		0x5c
>  #define XADC_AXI_REG_IPISR		0x60
>  #define XADC_AXI_REG_IPIER		0x68
> -#define XADC_AXI_ADC_REG_OFFSET		0x200
> +
> +/* 7 Series */
> +#define XADC_7S_AXI_ADC_REG_OFFSET	0x200
> +
> +/* UltraScale */
> +#define XADC_US_AXI_ADC_REG_OFFSET	0x400
>  
>  #define XADC_AXI_RESET_MAGIC		0xa
>  #define XADC_AXI_GIER_ENABLE		BIT(31)
> @@ -447,6 +452,12 @@ static const struct xadc_ops xadc_zynq_ops = {
>  	.get_dclk_rate = xadc_zynq_get_dclk_rate,
>  	.interrupt_handler = xadc_zynq_interrupt_handler,
>  	.update_alarm = xadc_zynq_update_alarm,
> +	.type = XADC_TYPE_S7,
> +};
> +
> +static const unsigned int xadc_axi_reg_offsets[] = {
> +	[XADC_TYPE_S7] = XADC_7S_AXI_ADC_REG_OFFSET,
> +	[XADC_TYPE_US] = XADC_US_AXI_ADC_REG_OFFSET,
>  };
>  
>  static int xadc_axi_read_adc_reg(struct xadc *xadc, unsigned int reg,
> @@ -454,7 +465,8 @@ static int xadc_axi_read_adc_reg(struct xadc *xadc, unsigned int reg,
>  {
>  	uint32_t val32;
>  
> -	xadc_read_reg(xadc, XADC_AXI_ADC_REG_OFFSET + reg * 4, &val32);
> +	xadc_read_reg(xadc, xadc_axi_reg_offsets[xadc->ops->type] + reg * 4,
> +		&val32);
>  	*val = val32 & 0xffff;
>  
>  	return 0;
> @@ -463,7 +475,8 @@ static int xadc_axi_read_adc_reg(struct xadc *xadc, unsigned int reg,
>  static int xadc_axi_write_adc_reg(struct xadc *xadc, unsigned int reg,
>  	uint16_t val)
>  {
> -	xadc_write_reg(xadc, XADC_AXI_ADC_REG_OFFSET + reg * 4, val);
> +	xadc_write_reg(xadc, xadc_axi_reg_offsets[xadc->ops->type] + reg * 4,
> +		val);
>  
>  	return 0;
>  }
> @@ -541,7 +554,7 @@ static unsigned long xadc_axi_get_dclk(struct xadc *xadc)
>  	return clk_get_rate(xadc->clk);
>  }
>  
> -static const struct xadc_ops xadc_axi_ops = {
> +static const struct xadc_ops xadc_7s_axi_ops = {
>  	.read = xadc_axi_read_adc_reg,
>  	.write = xadc_axi_write_adc_reg,
>  	.setup = xadc_axi_setup,
> @@ -549,6 +562,18 @@ static const struct xadc_ops xadc_axi_ops = {
>  	.update_alarm = xadc_axi_update_alarm,
>  	.interrupt_handler = xadc_axi_interrupt_handler,
>  	.flags = XADC_FLAGS_BUFFERED,
> +	.type = XADC_TYPE_S7,
> +};
> +
> +static const struct xadc_ops xadc_us_axi_ops = {
> +	.read = xadc_axi_read_adc_reg,
> +	.write = xadc_axi_write_adc_reg,
> +	.setup = xadc_axi_setup,
> +	.get_dclk_rate = xadc_axi_get_dclk,
> +	.update_alarm = xadc_axi_update_alarm,
> +	.interrupt_handler = xadc_axi_interrupt_handler,
> +	.flags = XADC_FLAGS_BUFFERED,
> +	.type = XADC_TYPE_US,
>  };
>  
>  static int _xadc_update_adc_reg(struct xadc *xadc, unsigned int reg,
> @@ -732,6 +757,15 @@ static int xadc_power_adc_b(struct xadc *xadc, unsigned int seq_mode)
>  {
>  	uint16_t val;
>  
> +	/*
> +	 * As per datasheet the power-down bits are don't care in the
> +	 * UltraScale, but as per reality setting the power-down bit for the
> +	 * non-existing ADC-B powers down the main ADC, so just return and don't
> +	 * do anything.
> +	 */
> +	if (xadc->ops->type == XADC_TYPE_US)
> +		return 0;
> +
>  	/* Powerdown the ADC-B when it is not needed. */
>  	switch (seq_mode) {
>  	case XADC_CONF1_SEQ_SIMULTANEOUS:
> @@ -751,6 +785,10 @@ static int xadc_get_seq_mode(struct xadc *xadc, unsigned long scan_mode)
>  {
>  	unsigned int aux_scan_mode = scan_mode >> 16;
>  
> +	/* UltraScale has only one ADC and supports only continuous mode */
> +	if (xadc->ops->type == XADC_TYPE_US)
> +		return XADC_CONF1_SEQ_CONTINUOUS;
> +
>  	if (xadc->external_mux_mode == XADC_EXTERNAL_MUX_DUAL)
>  		return XADC_CONF1_SEQ_SIMULTANEOUS;
>  
> @@ -863,6 +901,7 @@ static int xadc_read_raw(struct iio_dev *indio_dev,
>  	struct iio_chan_spec const *chan, int *val, int *val2, long info)
>  {
>  	struct xadc *xadc = iio_priv(indio_dev);
> +	unsigned int bits = chan->scan_type.realbits;
>  	uint16_t val16;
>  	int ret;
>  
> @@ -874,17 +913,17 @@ static int xadc_read_raw(struct iio_dev *indio_dev,
>  		if (ret < 0)
>  			return ret;
>  
> -		val16 >>= 4;
> +		val16 >>= chan->scan_type.shift;
>  		if (chan->scan_type.sign == 'u')
>  			*val = val16;
>  		else
> -			*val = sign_extend32(val16, 11);
> +			*val = sign_extend32(val16, bits - 1);
>  
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
>  		switch (chan->type) {
>  		case IIO_VOLTAGE:
> -			/* V = (val * 3.0) / 4096 */
> +			/* V = (val * 3.0) / 2**bits */
>  			switch (chan->address) {
>  			case XADC_REG_VCCINT:
>  			case XADC_REG_VCCAUX:
> @@ -900,19 +939,19 @@ static int xadc_read_raw(struct iio_dev *indio_dev,
>  				*val = 1000;
>  				break;
>  			}
> -			*val2 = 12;
> +			*val2 = chan->scan_type.realbits;
>  			return IIO_VAL_FRACTIONAL_LOG2;
>  		case IIO_TEMP:
> -			/* Temp in C = (val * 503.975) / 4096 - 273.15 */
> +			/* Temp in C = (val * 503.975) / 2**bits - 273.15 */
>  			*val = 503975;
> -			*val2 = 12;
> +			*val2 = bits;
>  			return IIO_VAL_FRACTIONAL_LOG2;
>  		default:
>  			return -EINVAL;
>  		}
>  	case IIO_CHAN_INFO_OFFSET:
>  		/* Only the temperature channel has an offset */
> -		*val = -((273150 << 12) / 503975);
> +		*val = -((273150 << bits) / 503975);
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		ret = xadc_read_samplerate(xadc);
> @@ -1001,7 +1040,7 @@ static const struct iio_event_spec xadc_voltage_events[] = {
>  	},
>  };
>  
> -#define XADC_CHAN_TEMP(_chan, _scan_index, _addr) { \
> +#define XADC_CHAN_TEMP(_chan, _scan_index, _addr, _bits) { \
>  	.type = IIO_TEMP, \
>  	.indexed = 1, \
>  	.channel = (_chan), \
> @@ -1015,14 +1054,14 @@ static const struct iio_event_spec xadc_voltage_events[] = {
>  	.scan_index = (_scan_index), \
>  	.scan_type = { \
>  		.sign = 'u', \
> -		.realbits = 12, \
> +		.realbits = (_bits), \
>  		.storagebits = 16, \
> -		.shift = 4, \
> +		.shift = 16 - (_bits), \
>  		.endianness = IIO_CPU, \
>  	}, \
>  }
>  
> -#define XADC_CHAN_VOLTAGE(_chan, _scan_index, _addr, _ext, _alarm) { \
> +#define XADC_CHAN_VOLTAGE(_chan, _scan_index, _addr, _bits, _ext, _alarm) { \
>  	.type = IIO_VOLTAGE, \
>  	.indexed = 1, \
>  	.channel = (_chan), \
> @@ -1035,41 +1074,82 @@ static const struct iio_event_spec xadc_voltage_events[] = {
>  	.scan_index = (_scan_index), \
>  	.scan_type = { \
>  		.sign = ((_addr) == XADC_REG_VREFN) ? 's' : 'u', \
> -		.realbits = 12, \
> +		.realbits = (_bits), \
>  		.storagebits = 16, \
> -		.shift = 4, \
> +		.shift = 16 - (_bits), \
>  		.endianness = IIO_CPU, \
>  	}, \
>  	.extend_name = _ext, \
>  }
>  
> -static const struct iio_chan_spec xadc_channels[] = {
> -	XADC_CHAN_TEMP(0, 8, XADC_REG_TEMP),
> -	XADC_CHAN_VOLTAGE(0, 9, XADC_REG_VCCINT, "vccint", true),
> -	XADC_CHAN_VOLTAGE(1, 10, XADC_REG_VCCAUX, "vccaux", true),
> -	XADC_CHAN_VOLTAGE(2, 14, XADC_REG_VCCBRAM, "vccbram", true),
> -	XADC_CHAN_VOLTAGE(3, 5, XADC_REG_VCCPINT, "vccpint", true),
> -	XADC_CHAN_VOLTAGE(4, 6, XADC_REG_VCCPAUX, "vccpaux", true),
> -	XADC_CHAN_VOLTAGE(5, 7, XADC_REG_VCCO_DDR, "vccoddr", true),
> -	XADC_CHAN_VOLTAGE(6, 12, XADC_REG_VREFP, "vrefp", false),
> -	XADC_CHAN_VOLTAGE(7, 13, XADC_REG_VREFN, "vrefn", false),
> -	XADC_CHAN_VOLTAGE(8, 11, XADC_REG_VPVN, NULL, false),
> -	XADC_CHAN_VOLTAGE(9, 16, XADC_REG_VAUX(0), NULL, false),
> -	XADC_CHAN_VOLTAGE(10, 17, XADC_REG_VAUX(1), NULL, false),
> -	XADC_CHAN_VOLTAGE(11, 18, XADC_REG_VAUX(2), NULL, false),
> -	XADC_CHAN_VOLTAGE(12, 19, XADC_REG_VAUX(3), NULL, false),
> -	XADC_CHAN_VOLTAGE(13, 20, XADC_REG_VAUX(4), NULL, false),
> -	XADC_CHAN_VOLTAGE(14, 21, XADC_REG_VAUX(5), NULL, false),
> -	XADC_CHAN_VOLTAGE(15, 22, XADC_REG_VAUX(6), NULL, false),
> -	XADC_CHAN_VOLTAGE(16, 23, XADC_REG_VAUX(7), NULL, false),
> -	XADC_CHAN_VOLTAGE(17, 24, XADC_REG_VAUX(8), NULL, false),
> -	XADC_CHAN_VOLTAGE(18, 25, XADC_REG_VAUX(9), NULL, false),
> -	XADC_CHAN_VOLTAGE(19, 26, XADC_REG_VAUX(10), NULL, false),
> -	XADC_CHAN_VOLTAGE(20, 27, XADC_REG_VAUX(11), NULL, false),
> -	XADC_CHAN_VOLTAGE(21, 28, XADC_REG_VAUX(12), NULL, false),
> -	XADC_CHAN_VOLTAGE(22, 29, XADC_REG_VAUX(13), NULL, false),
> -	XADC_CHAN_VOLTAGE(23, 30, XADC_REG_VAUX(14), NULL, false),
> -	XADC_CHAN_VOLTAGE(24, 31, XADC_REG_VAUX(15), NULL, false),
> +/* 7 Series */
> +#define XADC_7S_CHAN_TEMP(_chan, _scan_index, _addr) \
> +	XADC_CHAN_TEMP(_chan, _scan_index, _addr, 12)
> +#define XADC_7S_CHAN_VOLTAGE(_chan, _scan_index, _addr, _ext, _alarm) \
> +	XADC_CHAN_VOLTAGE(_chan, _scan_index, _addr, 12, _ext, _alarm)
> +
> +static const struct iio_chan_spec xadc_7s_channels[] = {
> +	XADC_7S_CHAN_TEMP(0, 8, XADC_REG_TEMP),
> +	XADC_7S_CHAN_VOLTAGE(0, 9, XADC_REG_VCCINT, "vccint", true),
> +	XADC_7S_CHAN_VOLTAGE(1, 10, XADC_REG_VCCAUX, "vccaux", true),
> +	XADC_7S_CHAN_VOLTAGE(2, 14, XADC_REG_VCCBRAM, "vccbram", true),
> +	XADC_7S_CHAN_VOLTAGE(3, 5, XADC_REG_VCCPINT, "vccpint", true),
> +	XADC_7S_CHAN_VOLTAGE(4, 6, XADC_REG_VCCPAUX, "vccpaux", true),
> +	XADC_7S_CHAN_VOLTAGE(5, 7, XADC_REG_VCCO_DDR, "vccoddr", true),
> +	XADC_7S_CHAN_VOLTAGE(6, 12, XADC_REG_VREFP, "vrefp", false),
> +	XADC_7S_CHAN_VOLTAGE(7, 13, XADC_REG_VREFN, "vrefn", false),
> +	XADC_7S_CHAN_VOLTAGE(8, 11, XADC_REG_VPVN, NULL, false),
> +	XADC_7S_CHAN_VOLTAGE(9, 16, XADC_REG_VAUX(0), NULL, false),
> +	XADC_7S_CHAN_VOLTAGE(10, 17, XADC_REG_VAUX(1), NULL, false),
> +	XADC_7S_CHAN_VOLTAGE(11, 18, XADC_REG_VAUX(2), NULL, false),
> +	XADC_7S_CHAN_VOLTAGE(12, 19, XADC_REG_VAUX(3), NULL, false),
> +	XADC_7S_CHAN_VOLTAGE(13, 20, XADC_REG_VAUX(4), NULL, false),
> +	XADC_7S_CHAN_VOLTAGE(14, 21, XADC_REG_VAUX(5), NULL, false),
> +	XADC_7S_CHAN_VOLTAGE(15, 22, XADC_REG_VAUX(6), NULL, false),
> +	XADC_7S_CHAN_VOLTAGE(16, 23, XADC_REG_VAUX(7), NULL, false),
> +	XADC_7S_CHAN_VOLTAGE(17, 24, XADC_REG_VAUX(8), NULL, false),
> +	XADC_7S_CHAN_VOLTAGE(18, 25, XADC_REG_VAUX(9), NULL, false),
> +	XADC_7S_CHAN_VOLTAGE(19, 26, XADC_REG_VAUX(10), NULL, false),
> +	XADC_7S_CHAN_VOLTAGE(20, 27, XADC_REG_VAUX(11), NULL, false),
> +	XADC_7S_CHAN_VOLTAGE(21, 28, XADC_REG_VAUX(12), NULL, false),
> +	XADC_7S_CHAN_VOLTAGE(22, 29, XADC_REG_VAUX(13), NULL, false),
> +	XADC_7S_CHAN_VOLTAGE(23, 30, XADC_REG_VAUX(14), NULL, false),
> +	XADC_7S_CHAN_VOLTAGE(24, 31, XADC_REG_VAUX(15), NULL, false),
> +};
> +
> +/* UltraScale */
> +#define XADC_US_CHAN_TEMP(_chan, _scan_index, _addr) \
> +	XADC_CHAN_TEMP(_chan, _scan_index, _addr, 10)
> +#define XADC_US_CHAN_VOLTAGE(_chan, _scan_index, _addr, _ext, _alarm) \
> +	XADC_CHAN_VOLTAGE(_chan, _scan_index, _addr, 10, _ext, _alarm)
> +
> +static const struct iio_chan_spec xadc_us_channels[] = {
> +	XADC_US_CHAN_TEMP(0, 8, XADC_REG_TEMP),
> +	XADC_US_CHAN_VOLTAGE(0, 9, XADC_REG_VCCINT, "vccint", true),
> +	XADC_US_CHAN_VOLTAGE(1, 10, XADC_REG_VCCAUX, "vccaux", true),
> +	XADC_US_CHAN_VOLTAGE(2, 14, XADC_REG_VCCBRAM, "vccbram", true),
> +	XADC_US_CHAN_VOLTAGE(3, 5, XADC_REG_VCCPINT, "vccpsintlp", true),
> +	XADC_US_CHAN_VOLTAGE(4, 6, XADC_REG_VCCPAUX, "vccpsintfp", true),
> +	XADC_US_CHAN_VOLTAGE(5, 7, XADC_REG_VCCO_DDR, "vccpsaux", true),
> +	XADC_US_CHAN_VOLTAGE(6, 12, XADC_REG_VREFP, "vrefp", false),
> +	XADC_US_CHAN_VOLTAGE(7, 13, XADC_REG_VREFN, "vrefn", false),
> +	XADC_US_CHAN_VOLTAGE(8, 11, XADC_REG_VPVN, NULL, false),
> +	XADC_US_CHAN_VOLTAGE(9, 16, XADC_REG_VAUX(0), NULL, false),
> +	XADC_US_CHAN_VOLTAGE(10, 17, XADC_REG_VAUX(1), NULL, false),
> +	XADC_US_CHAN_VOLTAGE(11, 18, XADC_REG_VAUX(2), NULL, false),
> +	XADC_US_CHAN_VOLTAGE(12, 19, XADC_REG_VAUX(3), NULL, false),
> +	XADC_US_CHAN_VOLTAGE(13, 20, XADC_REG_VAUX(4), NULL, false),
> +	XADC_US_CHAN_VOLTAGE(14, 21, XADC_REG_VAUX(5), NULL, false),
> +	XADC_US_CHAN_VOLTAGE(15, 22, XADC_REG_VAUX(6), NULL, false),
> +	XADC_US_CHAN_VOLTAGE(16, 23, XADC_REG_VAUX(7), NULL, false),
> +	XADC_US_CHAN_VOLTAGE(17, 24, XADC_REG_VAUX(8), NULL, false),
> +	XADC_US_CHAN_VOLTAGE(18, 25, XADC_REG_VAUX(9), NULL, false),
> +	XADC_US_CHAN_VOLTAGE(19, 26, XADC_REG_VAUX(10), NULL, false),
> +	XADC_US_CHAN_VOLTAGE(20, 27, XADC_REG_VAUX(11), NULL, false),
> +	XADC_US_CHAN_VOLTAGE(21, 28, XADC_REG_VAUX(12), NULL, false),
> +	XADC_US_CHAN_VOLTAGE(22, 29, XADC_REG_VAUX(13), NULL, false),
> +	XADC_US_CHAN_VOLTAGE(23, 30, XADC_REG_VAUX(14), NULL, false),
> +	XADC_US_CHAN_VOLTAGE(24, 31, XADC_REG_VAUX(15), NULL, false),
>  };
>  
>  static const struct iio_info xadc_info = {
> @@ -1083,8 +1163,16 @@ static const struct iio_info xadc_info = {
>  };
>  
>  static const struct of_device_id xadc_of_match_table[] = {
> -	{ .compatible = "xlnx,zynq-xadc-1.00.a", (void *)&xadc_zynq_ops },
> -	{ .compatible = "xlnx,axi-xadc-1.00.a", (void *)&xadc_axi_ops },
> +	{
> +		.compatible = "xlnx,zynq-xadc-1.00.a",
> +		.data = &xadc_zynq_ops
> +	}, {
> +		.compatible = "xlnx,axi-xadc-1.00.a",
> +		.data = &xadc_7s_axi_ops
> +	}, {
> +		.compatible = "xlnx,system-management-wiz-1.3",
> +		.data = &xadc_us_axi_ops
> +	},
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, xadc_of_match_table);
> @@ -1093,8 +1181,10 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
>  	unsigned int *conf)
>  {
>  	struct xadc *xadc = iio_priv(indio_dev);
> +	const struct iio_chan_spec *channel_templates;
>  	struct iio_chan_spec *channels, *chan;
>  	struct device_node *chan_node, *child;
> +	unsigned int max_channels;
>  	unsigned int num_channels;
>  	const char *external_mux;
>  	u32 ext_mux_chan;
> @@ -1136,7 +1226,16 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
>  		*conf |= XADC_CONF0_MUX | XADC_CONF0_CHAN(ext_mux_chan);
>  	}
>  
> -	channels = kmemdup(xadc_channels, sizeof(xadc_channels), GFP_KERNEL);
> +	if (xadc->ops->type == XADC_TYPE_S7) {
> +		channel_templates = xadc_7s_channels;
> +		max_channels = ARRAY_SIZE(xadc_7s_channels);
> +	} else {
> +		channel_templates = xadc_us_channels;
> +		max_channels = ARRAY_SIZE(xadc_us_channels);
> +	}
> +	channels = kmemdup(channel_templates,
> +		sizeof(channels[0]) * max_channels, GFP_KERNEL);
> +
>  	if (!channels)
>  		return -ENOMEM;
>  
> @@ -1146,7 +1245,7 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
>  	chan_node = of_get_child_by_name(np, "xlnx,channels");
>  	if (chan_node) {
>  		for_each_child_of_node(chan_node, child) {
> -			if (num_channels >= ARRAY_SIZE(xadc_channels)) {
> +			if (num_channels >= max_channels) {
>  				of_node_put(child);
>  				break;
>  			}
> @@ -1181,6 +1280,11 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
>  	return 0;
>  }
>  
> +static const char * const xadc_type_names[] = {
> +	[XADC_TYPE_S7] = "xadc",
> +	[XADC_TYPE_US] = "xilinx-system-monitor",
> +};
> +
>  static int xadc_probe(struct platform_device *pdev)
>  {
>  	const struct of_device_id *id;
> @@ -1219,7 +1323,7 @@ static int xadc_probe(struct platform_device *pdev)
>  	if (IS_ERR(xadc->base))
>  		return PTR_ERR(xadc->base);
>  
> -	indio_dev->name = "xadc";
> +	indio_dev->name = xadc_type_names[xadc->ops->type];
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->info = &xadc_info;
>  
> diff --git a/drivers/iio/adc/xilinx-xadc-events.c b/drivers/iio/adc/xilinx-xadc-events.c
> index 2357f585720a..1bd375fb10e0 100644
> --- a/drivers/iio/adc/xilinx-xadc-events.c
> +++ b/drivers/iio/adc/xilinx-xadc-events.c
> @@ -155,9 +155,6 @@ int xadc_write_event_config(struct iio_dev *indio_dev,
>  	return ret;
>  }
>  
> -/* Register value is msb aligned, the lower 4 bits are ignored */
> -#define XADC_THRESHOLD_VALUE_SHIFT 4
> -
>  int xadc_read_event_value(struct iio_dev *indio_dev,
>  	const struct iio_chan_spec *chan, enum iio_event_type type,
>  	enum iio_event_direction dir, enum iio_event_info info,
> @@ -177,7 +174,8 @@ int xadc_read_event_value(struct iio_dev *indio_dev,
>  		return -EINVAL;
>  	}
>  
> -	*val >>= XADC_THRESHOLD_VALUE_SHIFT;
> +	/* MSB aligned */
> +	*val >>= 16 - chan->scan_type.realbits;
>  
>  	return IIO_VAL_INT;
>  }
> @@ -191,7 +189,8 @@ int xadc_write_event_value(struct iio_dev *indio_dev,
>  	struct xadc *xadc = iio_priv(indio_dev);
>  	int ret = 0;
>  
> -	val <<= XADC_THRESHOLD_VALUE_SHIFT;
> +	/* MSB aligned */
> +	val <<= 16 - chan->scan_type.realbits;
>  
>  	if (val < 0 || val > 0xffff)
>  		return -EINVAL;
> diff --git a/drivers/iio/adc/xilinx-xadc.h b/drivers/iio/adc/xilinx-xadc.h
> index 25abed9c0285..8b80195725e9 100644
> --- a/drivers/iio/adc/xilinx-xadc.h
> +++ b/drivers/iio/adc/xilinx-xadc.h
> @@ -70,6 +70,11 @@ struct xadc {
>  	int irq;
>  };
>  
> +enum xadc_type {
> +	XADC_TYPE_S7, /* Series 7 */
> +	XADC_TYPE_US, /* UltraScale and UltraScale+ */
> +};
> +
>  struct xadc_ops {
>  	int (*read)(struct xadc *xadc, unsigned int reg, uint16_t *val);
>  	int (*write)(struct xadc *xadc, unsigned int reg, uint16_t val);
> @@ -80,6 +85,7 @@ struct xadc_ops {
>  	irqreturn_t (*interrupt_handler)(int irq, void *devid);
>  
>  	unsigned int flags;
> +	enum xadc_type type;
>  };
>  
>  static inline int _xadc_read_adc_reg(struct xadc *xadc, unsigned int reg,

