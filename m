Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC363CC38E
	for <lists+linux-iio@lfdr.de>; Sat, 17 Jul 2021 15:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbhGQN07 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 17 Jul 2021 09:26:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:55680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229746AbhGQN07 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 17 Jul 2021 09:26:59 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54F60613D0;
        Sat, 17 Jul 2021 13:24:00 +0000 (UTC)
Date:   Sat, 17 Jul 2021 14:26:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v6 1/2] iio: frequency: adrf6780: add support for
 ADRF6780
Message-ID: <20210717142623.45f96a22@jic23-huawei>
In-Reply-To: <20210716114210.141560-1-antoniu.miclaus@analog.com>
References: <20210716114210.141560-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 16 Jul 2021 14:42:09 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> The ADRF6780 is a silicon germanium (SiGe) design, wideband,
> microwave upconverter optimized for point to point microwave
> radio designs operating in the 5.9 GHz to 23.6 GHz frequency
> range.
> 
> Datasheet:
> https://www.analog.com/media/en/technical-documentation/data-sheets/ADRF6780.pdf
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Hi Antoniu

As it looks like we'll have a v7, a few trivial comments from me.

...

> +
> +static int adrf6780_init(struct adrf6780_dev *dev)
> +{
> +	int ret;
> +	unsigned int chip_id, enable_reg, enable_reg_msk;
> +	struct spi_device *spi = dev->spi;
> +
> +	/* Perform a software reset */
> +	ret = adrf6780_reset(dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = adrf6780_spi_read(dev, ADRF6780_REG_CONTROL, &chip_id);
> +	if (ret)
> +		return ret;
> +
> +	chip_id = FIELD_GET(ADRF6780_CHIP_ID_MSK, chip_id);
> +	if (chip_id != ADRF6780_CHIP_ID) {
> +		dev_err(&spi->dev, "ADRF6780 Invalid Chip ID.\n");
> +		return -EINVAL;
> +	}
> +
> +	enable_reg_msk = ADRF6780_VGA_BUFFER_EN_MSK |
> +			ADRF6780_DETECTOR_EN_MSK |
> +			ADRF6780_LO_BUFFER_EN_MSK |
> +			ADRF6780_IF_MODE_EN_MSK |
> +			ADRF6780_IQ_MODE_EN_MSK |
> +			ADRF6780_LO_X2_EN_MSK |
> +			ADRF6780_LO_PPF_EN_MSK |
> +			ADRF6780_LO_EN_MSK |
> +			ADRF6780_UC_BIAS_EN_MSK;
> +
> +	enable_reg = FIELD_PREP(ADRF6780_VGA_BUFFER_EN_MSK, dev->vga_buff_en) |
> +			FIELD_PREP(ADRF6780_DETECTOR_EN_MSK, 1) |
> +			FIELD_PREP(ADRF6780_LO_BUFFER_EN_MSK, dev->lo_buff_en) |
> +			FIELD_PREP(ADRF6780_IF_MODE_EN_MSK, dev->if_mode_en) |
> +			FIELD_PREP(ADRF6780_IQ_MODE_EN_MSK, dev->iq_mode_en) |
> +			FIELD_PREP(ADRF6780_LO_X2_EN_MSK, dev->lo_x2_en) |
> +			FIELD_PREP(ADRF6780_LO_PPF_EN_MSK, dev->lo_ppf_en) |
> +			FIELD_PREP(ADRF6780_LO_EN_MSK, dev->lo_en) |
> +			FIELD_PREP(ADRF6780_UC_BIAS_EN_MSK, dev->uc_bias_en);

Here we are probably turning on a bunch of stuff which will result in power usage.
Would it be sensible to turn it off again in remove path?  (devm managed should be fine).


> +
> +	ret = adrf6780_spi_update_bits(dev, ADRF6780_REG_ENABLE, enable_reg_msk, enable_reg);
> +	if (ret)
> +		return ret;
> +
> +	ret = adrf6780_spi_update_bits(dev, ADRF6780_REG_LO_PATH,
> +						ADRF6780_LO_SIDEBAND_MSK,
> +						FIELD_PREP(ADRF6780_LO_SIDEBAND_MSK, dev->lo_sideband));
> +	if (ret)
> +		return ret;
> +
> +	return adrf6780_spi_update_bits(dev, ADRF6780_REG_ADC_CONTROL,
> +						ADRF6780_VDET_OUTPUT_SELECT_MSK,
> +						FIELD_PREP(ADRF6780_VDET_OUTPUT_SELECT_MSK, dev->vdet_out_en));
> +}
> +

> +static void adrf6780_dt_parse(struct adrf6780_dev *dev)

Trivial nitpick, but given this is all device property based (great)
the dt naming is now misleading.  Perhaps _properties_parse() ?

> +{
> +	struct spi_device *spi = dev->spi;
> +
> +	dev->vga_buff_en = device_property_read_bool(&spi->dev, "adi,vga-buff-en");
> +	dev->lo_buff_en = device_property_read_bool(&spi->dev, "adi,lo-buff-en");
> +	dev->if_mode_en = device_property_read_bool(&spi->dev, "adi,if-mode-en");
> +	dev->iq_mode_en = device_property_read_bool(&spi->dev, "adi,iq-mode-en");
> +	dev->lo_x2_en = device_property_read_bool(&spi->dev, "adi,lo-x2-en");
> +	dev->lo_ppf_en = device_property_read_bool(&spi->dev, "adi,lo-ppf-en");
> +	dev->lo_en = device_property_read_bool(&spi->dev, "adi,lo-en");
> +	dev->uc_bias_en = device_property_read_bool(&spi->dev, "adi,uc-bias-en");
> +	dev->lo_sideband = device_property_read_bool(&spi->dev, "adi,lo-sideband");
> +	dev->vdet_out_en = device_property_read_bool(&spi->dev, "adi,vdet-out-en");
> +}

