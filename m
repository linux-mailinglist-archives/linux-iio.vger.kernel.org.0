Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C97D7363498
	for <lists+linux-iio@lfdr.de>; Sun, 18 Apr 2021 12:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhDRKXX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Apr 2021 06:23:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229544AbhDRKXW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Apr 2021 06:23:22 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E19A161245;
        Sun, 18 Apr 2021 10:22:53 +0000 (UTC)
Date:   Sun, 18 Apr 2021 11:23:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno Sa <nuno.sa@analog.com>
Cc:     <linux-iio@vger.kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3] iio: adis16480: support burst read function
Message-ID: <20210418112324.5b49356d@jic23-huawei>
In-Reply-To: <20210418105307.67fad41e@jic23-huawei>
References: <20210413092815.28626-1-nuno.sa@analog.com>
        <20210418105307.67fad41e@jic23-huawei>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 18 Apr 2021 10:53:07 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 13 Apr 2021 11:28:14 +0200
> Nuno Sa <nuno.sa@analog.com> wrote:
> 
> > Some supported devices support burst read function. This provides a method
> > for reading a batch of data (status, temperature, gyroscopes,
> > accelerometers, time stamp/data counter, and CRC code), which does not
> > require a stall time between each 16-bit segment and only requires one
> > command on the DIN line to initiate. Devices supporting this mode
> > are:
> > 
> >  * adis16495-1
> >  * adis16495-2
> >  * adis16495-3
> >  * adis16497-1
> >  * adis16497-2
> >  * adis16497-3
> > 
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>  
> 
> Applied and I've added the tag Lars gave for v2.
> If you intentionally drop someones tag, please call out why alongside
> your change log.  Here the tweaks were fairly minor so I don't think
> there was any need to drop it.
> 
> Appiled to the togreg branch of iio.git and pushed out as testing for
> the autobuilders to poke at it and see if we missed anything.
> 
> Thanks,
> 
> Jonathan
Backed out as I think this has the same narrow race you spotted in the
other series.

Jonathan

> 
> 
> > ---
> > Changes in v2:
> >  * Return right away if offset == 4 (no valid transition found from
> > brurst_id to sys_flags).
> > 
> > Changes in v3:
> >  * Move crc32.h header;
> >  * Return proper 'irqreturn_t' types in all error paths;
> >  * Move 'adis->current_page = 0' to right after setting it;
> >  * Restore spi max transfer in case 'spi_sync()' fails;
> >  * Use 80 line chars for 'devm_adis_setup_buffer_and_trigger()'.
> > 
> >  drivers/iio/imu/adis16480.c | 164 +++++++++++++++++++++++++++++++++---
> >  1 file changed, 151 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
> > index f81b86690b76..f7026c804f3a 100644
> > --- a/drivers/iio/imu/adis16480.c
> > +++ b/drivers/iio/imu/adis16480.c
> > @@ -19,11 +19,15 @@
> >  #include <linux/sysfs.h>
> >  #include <linux/module.h>
> >  #include <linux/lcm.h>
> > +#include <linux/swab.h>
> > +#include <linux/crc32.h>
> >  
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/sysfs.h>
> >  #include <linux/iio/buffer.h>
> >  #include <linux/iio/imu/adis.h>
> > +#include <linux/iio/triggered_buffer.h>
> > +#include <linux/iio/trigger_consumer.h>
> >  
> >  #include <linux/debugfs.h>
> >  
> > @@ -103,6 +107,12 @@
> >   * Available only for ADIS1649x devices
> >   */
> >  #define ADIS16495_REG_SYNC_SCALE		ADIS16480_REG(0x03, 0x10)
> > +#define ADIS16495_REG_BURST_CMD			ADIS16480_REG(0x00, 0x7C)
> > +#define ADIS16495_BURST_ID			0xA5A5
> > +/* total number of segments in burst */
> > +#define ADIS16495_BURST_MAX_DATA		20
> > +/* spi max speed in burst mode */
> > +#define ADIS16495_BURST_MAX_SPEED              6000000
> >  
> >  #define ADIS16480_REG_SERIAL_NUM		ADIS16480_REG(0x04, 0x20)
> >  
> > @@ -163,6 +173,8 @@ struct adis16480 {
> >  	struct clk *ext_clk;
> >  	enum adis16480_clock_mode clk_mode;
> >  	unsigned int clk_freq;
> > +	/* Alignment needed for the timestamp */
> > +	__be16 data[ADIS16495_BURST_MAX_DATA] __aligned(8);
> >  };
> >  
> >  static const char * const adis16480_int_pin_names[4] = {
> > @@ -863,7 +875,7 @@ static const char * const adis16480_status_error_msgs[] = {
> >  
> >  static int adis16480_enable_irq(struct adis *adis, bool enable);
> >  
> > -#define ADIS16480_DATA(_prod_id, _timeouts)				\
> > +#define ADIS16480_DATA(_prod_id, _timeouts, _burst_len)			\
> >  {									\
> >  	.diag_stat_reg = ADIS16480_REG_DIAG_STS,			\
> >  	.glob_cmd_reg = ADIS16480_REG_GLOB_CMD,				\
> > @@ -887,6 +899,8 @@ static int adis16480_enable_irq(struct adis *adis, bool enable);
> >  		BIT(ADIS16480_DIAG_STAT_BARO_FAIL),			\
> >  	.enable_irq = adis16480_enable_irq,				\
> >  	.timeouts = (_timeouts),					\
> > +	.burst_reg_cmd = ADIS16495_REG_BURST_CMD,			\
> > +	.burst_len = (_burst_len),					\
> >  }
> >  
> >  static const struct adis_timeout adis16485_timeouts = {
> > @@ -931,7 +945,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
> >  		.int_clk = 2460000,
> >  		.max_dec_rate = 2048,
> >  		.filter_freqs = adis16480_def_filter_freqs,
> > -		.adis_data = ADIS16480_DATA(16375, &adis16485_timeouts),
> > +		.adis_data = ADIS16480_DATA(16375, &adis16485_timeouts, 0),
> >  	},
> >  	[ADIS16480] = {
> >  		.channels = adis16480_channels,
> > @@ -944,7 +958,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
> >  		.int_clk = 2460000,
> >  		.max_dec_rate = 2048,
> >  		.filter_freqs = adis16480_def_filter_freqs,
> > -		.adis_data = ADIS16480_DATA(16480, &adis16480_timeouts),
> > +		.adis_data = ADIS16480_DATA(16480, &adis16480_timeouts, 0),
> >  	},
> >  	[ADIS16485] = {
> >  		.channels = adis16485_channels,
> > @@ -957,7 +971,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
> >  		.int_clk = 2460000,
> >  		.max_dec_rate = 2048,
> >  		.filter_freqs = adis16480_def_filter_freqs,
> > -		.adis_data = ADIS16480_DATA(16485, &adis16485_timeouts),
> > +		.adis_data = ADIS16480_DATA(16485, &adis16485_timeouts, 0),
> >  	},
> >  	[ADIS16488] = {
> >  		.channels = adis16480_channels,
> > @@ -970,7 +984,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
> >  		.int_clk = 2460000,
> >  		.max_dec_rate = 2048,
> >  		.filter_freqs = adis16480_def_filter_freqs,
> > -		.adis_data = ADIS16480_DATA(16488, &adis16485_timeouts),
> > +		.adis_data = ADIS16480_DATA(16488, &adis16485_timeouts, 0),
> >  	},
> >  	[ADIS16490] = {
> >  		.channels = adis16485_channels,
> > @@ -984,7 +998,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
> >  		.max_dec_rate = 4250,
> >  		.filter_freqs = adis16495_def_filter_freqs,
> >  		.has_pps_clk_mode = true,
> > -		.adis_data = ADIS16480_DATA(16490, &adis16495_timeouts),
> > +		.adis_data = ADIS16480_DATA(16490, &adis16495_timeouts, 0),
> >  	},
> >  	[ADIS16495_1] = {
> >  		.channels = adis16485_channels,
> > @@ -998,7 +1012,9 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
> >  		.max_dec_rate = 4250,
> >  		.filter_freqs = adis16495_def_filter_freqs,
> >  		.has_pps_clk_mode = true,
> > -		.adis_data = ADIS16480_DATA(16495, &adis16495_1_timeouts),
> > +		/* 20 elements of 16bits */
> > +		.adis_data = ADIS16480_DATA(16495, &adis16495_1_timeouts,
> > +					    ADIS16495_BURST_MAX_DATA * 2),
> >  	},
> >  	[ADIS16495_2] = {
> >  		.channels = adis16485_channels,
> > @@ -1012,7 +1028,9 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
> >  		.max_dec_rate = 4250,
> >  		.filter_freqs = adis16495_def_filter_freqs,
> >  		.has_pps_clk_mode = true,
> > -		.adis_data = ADIS16480_DATA(16495, &adis16495_1_timeouts),
> > +		/* 20 elements of 16bits */
> > +		.adis_data = ADIS16480_DATA(16495, &adis16495_1_timeouts,
> > +					    ADIS16495_BURST_MAX_DATA * 2),
> >  	},
> >  	[ADIS16495_3] = {
> >  		.channels = adis16485_channels,
> > @@ -1026,7 +1044,9 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
> >  		.max_dec_rate = 4250,
> >  		.filter_freqs = adis16495_def_filter_freqs,
> >  		.has_pps_clk_mode = true,
> > -		.adis_data = ADIS16480_DATA(16495, &adis16495_1_timeouts),
> > +		/* 20 elements of 16bits */
> > +		.adis_data = ADIS16480_DATA(16495, &adis16495_1_timeouts,
> > +					    ADIS16495_BURST_MAX_DATA * 2),
> >  	},
> >  	[ADIS16497_1] = {
> >  		.channels = adis16485_channels,
> > @@ -1040,7 +1060,9 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
> >  		.max_dec_rate = 4250,
> >  		.filter_freqs = adis16495_def_filter_freqs,
> >  		.has_pps_clk_mode = true,
> > -		.adis_data = ADIS16480_DATA(16497, &adis16495_1_timeouts),
> > +		/* 20 elements of 16bits */
> > +		.adis_data = ADIS16480_DATA(16497, &adis16495_1_timeouts,
> > +					    ADIS16495_BURST_MAX_DATA * 2),
> >  	},
> >  	[ADIS16497_2] = {
> >  		.channels = adis16485_channels,
> > @@ -1054,7 +1076,9 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
> >  		.max_dec_rate = 4250,
> >  		.filter_freqs = adis16495_def_filter_freqs,
> >  		.has_pps_clk_mode = true,
> > -		.adis_data = ADIS16480_DATA(16497, &adis16495_1_timeouts),
> > +		/* 20 elements of 16bits */
> > +		.adis_data = ADIS16480_DATA(16497, &adis16495_1_timeouts,
> > +					    ADIS16495_BURST_MAX_DATA * 2),
> >  	},
> >  	[ADIS16497_3] = {
> >  		.channels = adis16485_channels,
> > @@ -1068,10 +1092,123 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
> >  		.max_dec_rate = 4250,
> >  		.filter_freqs = adis16495_def_filter_freqs,
> >  		.has_pps_clk_mode = true,
> > -		.adis_data = ADIS16480_DATA(16497, &adis16495_1_timeouts),
> > +		/* 20 elements of 16bits */
> > +		.adis_data = ADIS16480_DATA(16497, &adis16495_1_timeouts,
> > +					    ADIS16495_BURST_MAX_DATA * 2),
> >  	},
> >  };
> >  
> > +static bool adis16480_validate_crc(const u16 *buf, const u8 n_elem, const u32 crc)
> > +{
> > +	u32 crc_calc;
> > +	u16 crc_buf[15];
> > +	int j;
> > +
> > +	for (j = 0; j < n_elem; j++)
> > +		crc_buf[j] = swab16(buf[j]);
> > +
> > +	crc_calc = crc32(~0, crc_buf, n_elem * 2);
> > +	crc_calc ^= ~0;
> > +
> > +	return (crc == crc_calc);
> > +}
> > +
> > +static irqreturn_t adis16480_trigger_handler(int irq, void *p)
> > +{
> > +	struct iio_poll_func *pf = p;
> > +	struct iio_dev *indio_dev = pf->indio_dev;
> > +	struct adis16480 *st = iio_priv(indio_dev);
> > +	struct adis *adis = &st->adis;
> > +	int ret, bit, offset, i = 0;
> > +	__be16 *buffer;
> > +	u32 crc;
> > +	bool valid;
> > +	const u32 cached_spi_speed_hz = adis->spi->max_speed_hz;
> > +
> > +	adis_dev_lock(adis);
> > +	if (adis->current_page != 0) {
> > +		adis->tx[0] = ADIS_WRITE_REG(ADIS_REG_PAGE_ID);
> > +		adis->tx[1] = 0;
> > +		ret = spi_write(adis->spi, adis->tx, 2);
> > +		if (ret) {
> > +			dev_err(&adis->spi->dev, "Failed to change device page: %d\n", ret);
> > +			adis_dev_unlock(adis);
> > +			goto irq_done;
> > +		}
> > +
> > +		adis->current_page = 0;
> > +	}
> > +
> > +	adis->spi->max_speed_hz = ADIS16495_BURST_MAX_SPEED;
> > +
> > +	ret = spi_sync(adis->spi, &adis->msg);
> > +	if (ret) {
> > +		dev_err(&adis->spi->dev, "Failed to read data: %d\n", ret);
> > +		adis->spi->max_speed_hz = cached_spi_speed_hz;
> > +		adis_dev_unlock(adis);
> > +		goto irq_done;
> > +	}
> > +
> > +	adis->spi->max_speed_hz = cached_spi_speed_hz;
> > +	adis_dev_unlock(adis);
> > +
> > +	/*
> > +	 * After making the burst request, the response can have one or two
> > +	 * 16-bit responses containing the BURST_ID depending on the sclk. If
> > +	 * clk > 3.6MHz, then we will have two BURST_ID in a row. If clk < 3MHZ,
> > +	 * we have only one. To manage that variation, we use the transition from the
> > +	 * BURST_ID to the SYS_E_FLAG register, which will not be equal to 0xA5A5. If
> > +	 * we not find this variation in the first 4 segments, then the data should
> > +	 * not be valid.
> > +	 */
> > +	buffer = adis->buffer;
> > +	for (offset = 0; offset < 4; offset++) {
> > +		u16 curr = be16_to_cpu(buffer[offset]);
> > +		u16 next = be16_to_cpu(buffer[offset + 1]);
> > +
> > +		if (curr == ADIS16495_BURST_ID && next != ADIS16495_BURST_ID) {
> > +			offset++;
> > +			break;
> > +		}
> > +	}
> > +
> > +	if (offset == 4) {
> > +		dev_err(&adis->spi->dev, "Invalid burst data\n");
> > +		goto irq_done;
> > +	}
> > +
> > +	crc = be16_to_cpu(buffer[offset + 16]) << 16 | be16_to_cpu(buffer[offset + 15]);
> > +	valid = adis16480_validate_crc((u16 *)&buffer[offset], 15, crc);
> > +	if (!valid) {
> > +		dev_err(&adis->spi->dev, "Invalid crc\n");
> > +		goto irq_done;
> > +	}
> > +
> > +	for_each_set_bit(bit, indio_dev->active_scan_mask, indio_dev->masklength) {
> > +		/*
> > +		 * When burst mode is used, temperature is the first data
> > +		 * channel in the sequence, but the temperature scan index
> > +		 * is 10.
> > +		 */
> > +		switch (bit) {
> > +		case ADIS16480_SCAN_TEMP:
> > +			st->data[i++] = buffer[offset + 1];
> > +			break;
> > +		case ADIS16480_SCAN_GYRO_X ... ADIS16480_SCAN_ACCEL_Z:
> > +			/* The lower register data is sequenced first */
> > +			st->data[i++] = buffer[2 * bit + offset + 3];
> > +			st->data[i++] = buffer[2 * bit + offset + 2];
> > +			break;
> > +		}
> > +	}
> > +
> > +	iio_push_to_buffers_with_timestamp(indio_dev, st->data, pf->timestamp);
> > +irq_done:
> > +	iio_trigger_notify_done(indio_dev->trig);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> >  static const struct iio_info adis16480_info = {
> >  	.read_raw = &adis16480_read_raw,
> >  	.write_raw = &adis16480_write_raw,
> > @@ -1341,7 +1478,8 @@ static int adis16480_probe(struct spi_device *spi)
> >  		st->clk_freq = st->chip_info->int_clk;
> >  	}
> >  
> > -	ret = devm_adis_setup_buffer_and_trigger(&st->adis, indio_dev, NULL);
> > +	ret = devm_adis_setup_buffer_and_trigger(&st->adis, indio_dev,
> > +						 adis16480_trigger_handler);
> >  	if (ret)
> >  		return ret;
> >    
> 

