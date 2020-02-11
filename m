Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 167681595D5
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2020 18:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgBKRBg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 Feb 2020 12:01:36 -0500
Received: from hosting.pavoucek.net ([46.28.107.168]:41966 "EHLO
        hosting.pavoucek.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728228AbgBKRBg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Feb 2020 12:01:36 -0500
Received: from tomas.local.tbs-biometrics.cz (176-74-132-138.netdatacomm.cz [176.74.132.138])
        (Authenticated sender: tomas@novotny.cz)
        by hosting.pavoucek.net (Postfix) with ESMTPSA id 10743101BD9;
        Tue, 11 Feb 2020 18:01:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 hosting.pavoucek.net 10743101BD9
Date:   Tue, 11 Feb 2020 18:01:33 +0100
From:   Tomas Novotny <tomas@novotny.cz>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Angus Ainslie <angus@akkea.ca>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guido =?UTF-8?B?R8O8bnRoZXI=?= <agx@sigxcpu.org>
Subject: Re: [PATCH 5/5] iio: light: vcnl4000: add control of multi pulse
Message-ID: <20200211180133.4fa4164b@tomas.local.tbs-biometrics.cz>
In-Reply-To: <20200208151710.4a9cbc13@archlinux>
References: <20200205101655.11728-1-tomas@novotny.cz>
        <20200205101655.11728-6-tomas@novotny.cz>
        <20200208151710.4a9cbc13@archlinux>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On Sat, 8 Feb 2020 15:17:10 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Wed,  5 Feb 2020 11:16:55 +0100
> Tomas Novotny <tomas@novotny.cz> wrote:
> 
> > Multi pulse settings allow to emit more pulses during one measurement
> > (up to 8 on vcnl4040 and vcnl4200). The raw reading is approximately
> > multiplied by the multi pulse settings. More information is available in
> > the added documentation.
> > 
> > Multi pulse is specific only for proximity sensor. Only the vcnl4040 and
> > vcnl4200 hardware supports this settings.  
> 
> A few comments but this one is more or less good.
> 
> Thanks,
> 
> Jonathan
> 
> > 
> > Signed-off-by: Tomas Novotny <tomas@novotny.cz>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-iio-vcnl4000 | 21 +++++++++
> >  drivers/iio/light/vcnl4000.c                     | 60 ++++++++++++++++++++++++
> >  2 files changed, 81 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-vcnl4000 b/Documentation/ABI/testing/sysfs-bus-iio-vcnl4000
> > index 4860f409dbf0..923a78dc9869 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio-vcnl4000
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio-vcnl4000
> > @@ -16,3 +16,24 @@ KernelVersion:	5.7
> >  Contact:	linux-iio@vger.kernel.org
> >  Description:
> >  		The on/off available duty ratios.
> > +
> > +What:		/sys/bus/iio/devices/iio:deviceX/in_proximity_multi_pulse  
> 
> This is less ambiguous than duty_cycle, but perhaps something 
> in_proximity_led_pulse_count is more specific?

ok.

> > +Date:		February 2020
> > +KernelVersion:	5.7
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Instead of one single pulse per every measurement, more pulses
> > +		may be programmed. This leads to a longer led current on-time
> > +		for each proximity measurement, which also results in a higher
> > +		detection range. The raw reading is approximately multiplied by
> > +		the multi pulse settings. The duty ration is not changed. The  

oh, typo.

> Hmm. Normal meaning of duty ratio would be changed by this...  It's uneven but
> multiple pulses == more on time hence lower duty ratio.
>
> > +		settings cannot be changed when the proximity channel is
> > +		enabled.  Valid values are in the respective '_available'
> > +		attribute.
> > +
> > +What:		/sys/bus/iio/devices/iio:deviceX/in_proximity_multi_pulse_available
> > +Date:		February 2020
> > +KernelVersion:	5.7
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		List of multi pulse values.
> > diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> > index a8c2ce1056a6..cc75e5e7e634 100644
> > --- a/drivers/iio/light/vcnl4000.c
> > +++ b/drivers/iio/light/vcnl4000.c
> > @@ -46,6 +46,7 @@
> >  
> >  #define VCNL4200_AL_CONF	0x00 /* Ambient light configuration */
> >  #define VCNL4200_PS_CONF1	0x03 /* Proximity configuration */
> > +#define VCNL4200_PS_CONF3	0x04 /* Proximity conf., white channel, LED I */
> >  #define VCNL4200_PS_DATA	0x08 /* Proximity data */
> >  #define VCNL4200_AL_DATA	0x09 /* Ambient light data */
> >  #define VCNL4200_DEV_ID		0x0e /* Device ID, slave address and version */
> > @@ -65,6 +66,8 @@
> >  #define VCNL4200_PS_DUTY_MASK	GENMASK(7, 6) /* Proximity duty ratio */
> >  #define VCNL4200_PS_DUTY_SHIFT	6
> >  #define VCNL4200_PS_SD		BIT(0) /* Proximity shutdown */
> > +#define VCNL4200_PS_MPS_MASK	GENMASK(6, 5)
> > +#define VCNL4200_PS_MPS_SHIFT	5  
> 
> You could probably use the FIELD_PREP  macros etc to avoid having both mask and
> shift defines.

As Marco suggested, I will use reg_field.

Thanks a lot for the whole review.

Tomas

> >  enum vcnl4000_device_ids {
> >  	VCNL4000,
> > @@ -223,11 +226,24 @@ static const char * const vcnl4200_ps_duty_ratio_items[] = {
> >  	"1/1280"
> >  };
> >  
> > +/* Values are directly mapped to register values. */
> > +static const char * const vcnl4200_ps_multi_pulse_items[] = {
> > +	"1",
> > +	"2",
> > +	"4",
> > +	"8"
> > +};
> > +
> >  static int vcnl4200_get_ps_duty_ratio(struct iio_dev *indio_dev,
> >  				      const struct iio_chan_spec *chan);
> >  static int vcnl4200_set_ps_duty_ratio(struct iio_dev *indio_dev,
> >  				      const struct iio_chan_spec *chan,
> >  				      unsigned int mode);
> > +static int vcnl4200_get_ps_multi_pulse(struct iio_dev *indio_dev,
> > +				       const struct iio_chan_spec *chan);
> > +static int vcnl4200_set_ps_multi_pulse(struct iio_dev *indio_dev,
> > +				       const struct iio_chan_spec *chan,
> > +				       unsigned int mode);
> >  
> >  static const struct iio_enum vcnl4040_ps_duty_ratio_enum = {
> >  	.items = vcnl4040_ps_duty_ratio_items,
> > @@ -243,15 +259,26 @@ static const struct iio_enum vcnl4200_ps_duty_ratio_enum = {
> >  	.set = vcnl4200_set_ps_duty_ratio,
> >  };
> >  
> > +static const struct iio_enum vcnl4200_ps_multi_pulse_enum = {
> > +	.items = vcnl4200_ps_multi_pulse_items,
> > +	.num_items = ARRAY_SIZE(vcnl4200_ps_multi_pulse_items),
> > +	.get = vcnl4200_get_ps_multi_pulse,
> > +	.set = vcnl4200_set_ps_multi_pulse,
> > +};
> > +
> >  static const struct iio_chan_spec_ext_info vcnl4040_ps_ext_info[] = {
> >  	IIO_ENUM("duty_ratio", IIO_SEPARATE, &vcnl4040_ps_duty_ratio_enum),
> >  	IIO_ENUM_AVAILABLE("duty_ratio", &vcnl4040_ps_duty_ratio_enum),
> > +	IIO_ENUM("multi_pulse", IIO_SEPARATE, &vcnl4200_ps_multi_pulse_enum),
> > +	IIO_ENUM_AVAILABLE("multi_pulse", &vcnl4200_ps_multi_pulse_enum),
> >  	{ },
> >  };
> >  
> >  static const struct iio_chan_spec_ext_info vcnl4200_ps_ext_info[] = {
> >  	IIO_ENUM("duty_ratio", IIO_SEPARATE, &vcnl4200_ps_duty_ratio_enum),
> >  	IIO_ENUM_AVAILABLE("duty_ratio", &vcnl4200_ps_duty_ratio_enum),
> > +	IIO_ENUM("multi_pulse", IIO_SEPARATE, &vcnl4200_ps_multi_pulse_enum),
> > +	IIO_ENUM_AVAILABLE("multi_pulse", &vcnl4200_ps_multi_pulse_enum),
> >  	{ },
> >  };
> >  
> > @@ -638,6 +665,39 @@ static int vcnl4200_set_ps_duty_ratio(struct iio_dev *indio_dev,
> >  	return vcnl4200_set_samp_rate(data, IIO_PROXIMITY);
> >  };
> >  
> > +static int vcnl4200_get_ps_multi_pulse(struct iio_dev *indio_dev,
> > +				       const struct iio_chan_spec *chan)
> > +{
> > +	int ret;
> > +	unsigned int val;
> > +	struct vcnl4000_data *data = iio_priv(indio_dev);
> > +
> > +	ret = regmap_read(data->regmap, VCNL4200_PS_CONF3, &val);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	val &= VCNL4200_PS_MPS_MASK;
> > +	val >>= VCNL4200_PS_MPS_SHIFT;
> > +
> > +	return val;
> > +};
> > +
> > +static int vcnl4200_set_ps_multi_pulse(struct iio_dev *indio_dev,
> > +				       const struct iio_chan_spec *chan,
> > +				       unsigned int mode)
> > +{
> > +	int ret;
> > +	struct vcnl4000_data *data = iio_priv(indio_dev);
> > +
> > +	ret = vcnl4200_check_enabled(data, IIO_PROXIMITY);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return regmap_update_bits(data->regmap, VCNL4200_PS_CONF3,
> > +				  VCNL4200_PS_MPS_MASK,
> > +				  mode << VCNL4200_PS_MPS_SHIFT);
> > +};
> > +
> >  static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
> >  	[VCNL4000] = {
> >  		.prod = "VCNL4000",  
> 
