Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B749177BF6
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2019 23:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388075AbfG0VLb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Jul 2019 17:11:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:56316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387841AbfG0VLb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 27 Jul 2019 17:11:31 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64C00208C0;
        Sat, 27 Jul 2019 21:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564261889;
        bh=hIf85MnZinz0v+l3++MYf/ZAkLBsny8T9xu3lVEh050=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B973b+vjaR1UKvnETpUaX0zFJRQOS/sCarLzNdt+ZCfWbwdX4SpEgathaRUGdYFw9
         4uuHgGXxEhhO0zHFQYgfnK0PM8zjCYvhDikYYziBZuL9762isgFt4Tu7Sy+AOvcE8u
         RyLawzoZ+XwtD63wCEYPR4Qghw6DqGWSkK2Myak0=
Date:   Sat, 27 Jul 2019 22:11:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Sean Nyekjaer <sean@geanix.com>, linux-iio@vger.kernel.org,
        lorenzo.bianconi83@gmail.com, martin@geanix.com,
        denis.ciocca@st.com, mario.tesi@st.com, armando.visconti@st.com
Subject: Re: [PATCH v2 3/6] iio: imu: st_lsm6dsx: add motion events
Message-ID: <20190727221124.1184a056@archlinux>
In-Reply-To: <20190716082927.GB13440@localhost.localdomain>
References: <20190715081514.81129-1-sean@geanix.com>
        <20190715081514.81129-3-sean@geanix.com>
        <20190716082927.GB13440@localhost.localdomain>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 16 Jul 2019 10:29:27 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> > Add event channels that controls the creation of motion events.
> > 
> > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> > ---
> > 
> > Changes since v1:
> >  * added handling of LSM6
> >  * added CHANNEL info with events for ACC
> >  * removed st_lsm6dsx_set_event_threshold function
> >  * added check of event type to event channels
> > 
> > Issues:
> >  * This currently breaks buffered reads, as the interrupt stays high.
> >    This happens when MD1_CFG INT1_WU (wakeup event routes to INT1) is
> >    enabled.
> >    The datasheet doesn't seem to decribe whats happening and I can't
> >    find a status register to read somehing useful.
> >    Maybe it's impossible to share the buffered reads interrupt with
> >    the wakeup interrupt?  
> 
> Could you explain this issue a bit more? adding st folks...

This isn't totally unheard of for other hardware. If it turns out to be
a hardware restriction then the software approach is to return -EBUSY
if anyone tries to enable an event whilst in buffered mode, and -EBUSY
if anyone tries to enable buffered mode with an event enabled.

It's rather ugly though definitely good to see if there is a proper
solution!

Thanks,

Jonathan

> 
> > 
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  30 ++++
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 164 +++++++++++++++++--
> >  2 files changed, 182 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > index 738bed4a9752..fef08b7cf2a0 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > @@ -12,6 +12,7 @@
> >  #define ST_LSM6DSX_H
> >  
> >  #include <linux/device.h>
> > +#include <linux/iio/iio.h>
> >  
> >  #define ST_LSM6DS3_DEV_NAME	"lsm6ds3"
> >  #define ST_LSM6DS3H_DEV_NAME	"lsm6ds3h"
> > @@ -50,6 +51,26 @@ enum st_lsm6dsx_hw_id {
> >  					 * ST_LSM6DSX_TAGGED_SAMPLE_SIZE)
> >  #define ST_LSM6DSX_SHIFT_VAL(val, mask)	(((val) << __ffs(mask)) & (mask))
> >  
> > +#define ST_LSM6DSX_CHANNEL_ACC(chan_type, addr, mod, scan_idx)		\
> > +{									\
> > +	.type = chan_type,						\
> > +	.address = addr,						\
> > +	.modified = 1,							\
> > +	.channel2 = mod,						\
> > +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
> > +			      BIT(IIO_CHAN_INFO_SCALE),			\
> > +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> > +	.scan_index = scan_idx,						\
> > +	.scan_type = {							\
> > +		.sign = 's',						\
> > +		.realbits = 16,						\
> > +		.storagebits = 16,					\
> > +		.endianness = IIO_LE,					\
> > +	},								\
> > +	.event_spec = &st_lsm6dsx_event,				\
> > +	.num_event_specs = 1,						\
> > +}  
> 
> I would prefer to extend existing macros
> 
> > +
> >  #define ST_LSM6DSX_CHANNEL(chan_type, addr, mod, scan_idx)		\
> >  {									\
> >  	.type = chan_type,						\
> > @@ -297,6 +318,8 @@ struct st_lsm6dsx_hw {
> >  	u8 enable_mask;
> >  	u8 ts_sip;
> >  	u8 sip;
> > +	u8 event_threshold;
> > +	bool enable_event;
> >  	int drdy_pin;
> >  
> >  	u8 *buff;
> > @@ -306,6 +329,13 @@ struct st_lsm6dsx_hw {
> >  	const struct st_lsm6dsx_settings *settings;
> >  };
> >  
> > +static const struct iio_event_spec st_lsm6dsx_event = {
> > +	.type = IIO_EV_TYPE_THRESH,
> > +	.dir = IIO_EV_DIR_EITHER,
> > +	.mask_separate = BIT(IIO_EV_INFO_VALUE) |
> > +			 BIT(IIO_EV_INFO_ENABLE)
> > +};
> > +
> >  static const unsigned long st_lsm6dsx_available_scan_masks[] = {0x7, 0x0};
> >  extern const struct dev_pm_ops st_lsm6dsx_pm_ops;
> >  
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > index 2c11addf568b..6decb0846f1a 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > @@ -76,6 +76,16 @@
> >  #define ST_LSM6DSX_REG_GYRO_OUT_Y_L_ADDR	0x24
> >  #define ST_LSM6DSX_REG_GYRO_OUT_Z_L_ADDR	0x26
> >  
> > +#define ST_LSM6DSX_REG_TAP_CFG_ADDR		0x58
> > +#define ST_LSM6DSX_REG_TAP_CFG_INT_EN_MASK	BIT(7)  
> 
> I am pretty sure this is not true at least for lsm6ds3/lsm6ds3h
> 
> > +
> > +#define ST_LSM6DSX_REG_WAKE_UP_ADDR		0x5B
> > +#define ST_LSM6DSX_REG_WAKE_UP_THRES_MASK	GENMASK(5, 0)
> > +
> > +#define ST_LSM6DSX_REG_MD1_CFG_ADDR		0x5E
> > +#define ST_LSM6DSX_REG_MD2_CFG_ADDR		0x5F
> > +#define ST_LSM6DSX_REG_MD_CFG_INT_WU_MASK	BIT(5)
> > +
> >  static const struct st_lsm6dsx_odr_table_entry st_lsm6dsx_odr_table[] = {
> >  	[ST_LSM6DSX_ID_ACC] = {
> >  		.reg = {
> > @@ -470,12 +480,12 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
> >  };
> >  
> >  static const struct iio_chan_spec st_lsm6dsx_acc_channels[] = {
> > -	ST_LSM6DSX_CHANNEL(IIO_ACCEL, ST_LSM6DSX_REG_ACC_OUT_X_L_ADDR,
> > -			   IIO_MOD_X, 0),
> > -	ST_LSM6DSX_CHANNEL(IIO_ACCEL, ST_LSM6DSX_REG_ACC_OUT_Y_L_ADDR,
> > -			   IIO_MOD_Y, 1),
> > -	ST_LSM6DSX_CHANNEL(IIO_ACCEL, ST_LSM6DSX_REG_ACC_OUT_Z_L_ADDR,
> > -			   IIO_MOD_Z, 2),
> > +	ST_LSM6DSX_CHANNEL_ACC(IIO_ACCEL, ST_LSM6DSX_REG_ACC_OUT_X_L_ADDR,
> > +			       IIO_MOD_X, 0),
> > +	ST_LSM6DSX_CHANNEL_ACC(IIO_ACCEL, ST_LSM6DSX_REG_ACC_OUT_Y_L_ADDR,
> > +			       IIO_MOD_Y, 1),
> > +	ST_LSM6DSX_CHANNEL_ACC(IIO_ACCEL, ST_LSM6DSX_REG_ACC_OUT_Z_L_ADDR,
> > +			       IIO_MOD_Z, 2),
> >  	IIO_CHAN_SOFT_TIMESTAMP(3),
> >  };
> >  
> > @@ -679,18 +689,21 @@ static int st_lsm6dsx_read_oneshot(struct st_lsm6dsx_sensor *sensor,
> >  	int err, delay;
> >  	__le16 data;
> >  
> > -	err = st_lsm6dsx_sensor_set_enable(sensor, true);
> > -	if (err < 0)
> > -		return err;
> > +	if (!hw->enable_event) {
> > +		err = st_lsm6dsx_sensor_set_enable(sensor, true);
> > +		if (err < 0)
> > +			return err;
> >  
> > -	delay = 1000000 / sensor->odr;
> > -	usleep_range(delay, 2 * delay);
> > +		delay = 1000000 / sensor->odr;
> > +		usleep_range(delay, 2 * delay);
> > +	}
> >  
> >  	err = st_lsm6dsx_read_locked(hw, addr, &data, sizeof(data));
> >  	if (err < 0)
> >  		return err;
> >  
> > -	st_lsm6dsx_sensor_set_enable(sensor, false);
> > +	if (!hw->enable_event)
> > +		st_lsm6dsx_sensor_set_enable(sensor, false);
> >  
> >  	*val = (s16)le16_to_cpu(data);
> >  
> > @@ -763,6 +776,94 @@ static int st_lsm6dsx_write_raw(struct iio_dev *iio_dev,
> >  	return err;
> >  }
> >  
> > +static int st_lsm6dsx_read_event(struct iio_dev *iio_dev,
> > +				   const struct iio_chan_spec *chan,
> > +				   enum iio_event_type type,
> > +				   enum iio_event_direction dir,
> > +				   enum iio_event_info info,
> > +				   int *val, int *val2)
> > +{
> > +	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
> > +	struct st_lsm6dsx_hw *hw = sensor->hw;
> > +
> > +	if (type != IIO_EV_TYPE_THRESH)
> > +		return -EINVAL;
> > +
> > +	*val2 = 0;
> > +	*val = hw->event_threshold;
> > +
> > +	return IIO_VAL_INT;
> > +}
> > +
> > +static int st_lsm6dsx_write_event(struct iio_dev *iio_dev,
> > +				    const struct iio_chan_spec *chan,
> > +				    enum iio_event_type type,
> > +				    enum iio_event_direction dir,
> > +				    enum iio_event_info info,
> > +				    int val, int val2)
> > +{
> > +	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
> > +	struct st_lsm6dsx_hw *hw = sensor->hw;
> > +	int err;
> > +
> > +	if (type != IIO_EV_TYPE_THRESH)
> > +		return -EINVAL;
> > +
> > +	if (!hw->enable_event)
> > +		return -EBUSY;  
> 
> I guess it is ok to configure the threshold first, no?
> 
> > +
> > +	if (val < 0 || val > 31)
> > +		return -EINVAL;
> > +
> > +	err = regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_WAKE_UP_ADDR,
> > +				 ST_LSM6DSX_REG_WAKE_UP_THRES_MASK,
> > +				 val);
> > +	if (err)
> > +		return -EINVAL;
> > +
> > +	hw->event_threshold = val;
> > +
> > +	return 0;
> > +}
> > +
> > +static int st_lsm6dsx_read_event_config(struct iio_dev *iio_dev,
> > +					  const struct iio_chan_spec *chan,
> > +					  enum iio_event_type type,
> > +					  enum iio_event_direction dir)
> > +{
> > +	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
> > +	struct st_lsm6dsx_hw *hw = sensor->hw;
> > +
> > +	if (type != IIO_EV_TYPE_THRESH)
> > +		return -EINVAL;
> > +
> > +	return hw->enable_event;
> > +}
> > +
> > +static int st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
> > +					   const struct iio_chan_spec *chan,
> > +					   enum iio_event_type type,
> > +					   enum iio_event_direction dir,
> > +					   int state)
> > +{
> > +	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
> > +	struct st_lsm6dsx_hw *hw = sensor->hw;
> > +
> > +	if (type != IIO_EV_TYPE_THRESH)
> > +		return -EINVAL;
> > +
> > +	if (state && hw->enable_event)
> > +		return 0;
> > +
> > +	hw->enable_event = state;
> > +	if (state)
> > +		st_lsm6dsx_sensor_set_enable(sensor, true);
> > +	else
> > +		st_lsm6dsx_sensor_set_enable(sensor, false);  
> 
> st_lsm6dsx_sensor_set_enable can fails. Why not do
> 
> 	err = st_lsm6dsx_sensor_set_enable(sensor, state);
> 	if (err < 0)
> 		return err;
> 
> 	hw->enable_event = state;;
> 	return 0;
> 
> > +
> > +	return 0;
> > +}
> > +
> >  int st_lsm6dsx_set_watermark(struct iio_dev *iio_dev, unsigned int val)
> >  {
> >  	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
> > @@ -839,6 +940,10 @@ static const struct iio_info st_lsm6dsx_acc_info = {
> >  	.attrs = &st_lsm6dsx_acc_attribute_group,
> >  	.read_raw = st_lsm6dsx_read_raw,
> >  	.write_raw = st_lsm6dsx_write_raw,
> > +	.read_event_value = st_lsm6dsx_read_event,
> > +	.write_event_value = st_lsm6dsx_write_event,
> > +	.read_event_config = st_lsm6dsx_read_event_config,
> > +	.write_event_config = st_lsm6dsx_write_event_config,
> >  	.hwfifo_set_watermark = st_lsm6dsx_set_watermark,
> >  };
> >  
> > @@ -1076,6 +1181,38 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
> >  	return iio_dev;
> >  }
> >  
> > +int st_lsm6dsx_event_setup(int id, struct st_lsm6dsx_hw *hw)
> > +{
> > +	int err;
> > +	unsigned int md_reg;
> > +
> > +	if (id == ST_ISM330DLC_ID) {
> > +		/* Enable basic interrupts for ISM330 */
> > +		err = regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_TAP_CFG_ADDR,
> > +					 ST_LSM6DSX_REG_TAP_CFG_INT_EN_MASK,
> > +					 ST_LSM6DSX_REG_TAP_CFG_INT_EN_MASK);  
> 
> please put device differences in st_lsm6dsx_sensor_settings[]
> 
> > +		if (err < 0)
> > +			return err;
> > +	}
> > +
> > +	switch (hw->drdy_pin) {  
> 
> drdy_pin it is only used here right? If so we do not need it just enable this
> configuration by default. I would prefer to maintain the code simple
> 
> > +	case 1:
> > +		md_reg = ST_LSM6DSX_REG_MD1_CFG_ADDR;
> > +		break;
> > +	case 2:
> > +		md_reg = ST_LSM6DSX_REG_MD2_CFG_ADDR;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +	/* Enable wakeup interrupt */
> > +	err = regmap_update_bits(hw->regmap, md_reg,
> > +				 ST_LSM6DSX_REG_MD_CFG_INT_WU_MASK,
> > +				 ST_LSM6DSX_REG_MD_CFG_INT_WU_MASK);
> > +
> > +	return err;
> > +}
> > +
> >  static irqreturn_t st_lsm6dsx_handler_irq(int irq, void *private)
> >  {
> >  	struct st_lsm6dsx_hw *hw = private;
> > @@ -1207,6 +1344,9 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
> >  		err = st_lsm6dsx_fifo_setup(hw);
> >  		if (err < 0)
> >  			return err;  
> 
> newline here please
> 
> > +		err = st_lsm6dsx_event_setup(hw_id, hw);
> > +		if (err < 0)
> > +			return err;
> >  	}
> >  
> >  	for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
> > -- 
> > 2.22.0
> >   

