Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B89E115D804
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2020 14:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbgBNNLT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Feb 2020 08:11:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:45784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728895AbgBNNLT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 14 Feb 2020 08:11:19 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59065222C2;
        Fri, 14 Feb 2020 13:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581685878;
        bh=FHsHZRJpZHbKmcpb1fTmxc1K9yq4sJ5NuR3hevlbaW4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ygQq8IAtKw3LAcHJLq59h8acwMxo2J7sJ7lCjry/BupYVvC81YvKaJqkyGWVEmVcI
         cH+QrE8Qy4Lwe3Huh9NrQDGHzNQ+n33qEbzwMhCVCgYzWRwM6r2ZoLGIOsgswONpde
         dDwpCmU2gyhlMdOQX7rhjOYdwxme/j5SlBDnbkmk=
Date:   Fri, 14 Feb 2020 13:11:13 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Olivier MOYSAN <olivier.moysan@st.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 4/4] iio: adc: stm32-dfsdm: add scale and offset support
Message-ID: <20200214131113.70aa36b8@archlinux>
In-Reply-To: <8400827e-5f3d-ad3f-99c8-986934b1a7b8@st.com>
References: <20200204101008.11411-1-olivier.moysan@st.com>
        <20200204101008.11411-5-olivier.moysan@st.com>
        <20200208161847.76c7d6e8@archlinux>
        <8400827e-5f3d-ad3f-99c8-986934b1a7b8@st.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 11 Feb 2020 15:19:01 +0000
Olivier MOYSAN <olivier.moysan@st.com> wrote:

> Hi Jonathan,
>=20
> On 2/8/20 5:18 PM, Jonathan Cameron wrote:
> > On Tue, 4 Feb 2020 11:10:08 +0100
> > Olivier Moysan <olivier.moysan@st.com> wrote:
> > =20
> >> Add scale and offset attributes support to STM32 DFSDM.
> >>
> >> Signed-off-by: Olivier Moysan <olivier.moysan@st.com> =20
> > Hmm. I can't remember this history of this but we've kind of
> > ended up backwards wrt to other consumer drivers.
> >
> > In some sense this is similar to the analog gyroscopes.  In those
> > the consumer driver is the gyroscope which is consuming the raw
> > readings from an ADC connected to the channel.  This results
> > in us getting readings reported by the gyroscope driver.
> >
> > Here we have a sigma delta convertor consuming the pulse train
> > from a sigma delta device.  So the channels are reported by
> > the sigma delta receiver, whereas i think the nearest equivalent
> > to the analog voltage outputing gyroscopes would have been if
> > we had reported the channel values at the sigma delta converter. =20
> The DFSDM driver is currently used as a consumer of the sd modulator.
> The scale and offset values of the channels are already computed by
> the DFSDM driver, and provided by this driver to the IIO ABI.
> However, the DFSDM has no voltage reference, so it has to retrieve
> it from sd-modulator channels, for the scale factor computation.
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 scale=C2=A0=
 offset
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ^=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IIO =
ABI
> +-------------------------------------------------------------+
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +---------------+=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-------------+
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |sd driver=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
|DFSDM driver |
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +---------------+=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-------------+
> +-------------------------------------------------------------+
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HW
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +---------------+=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-------------+
> +------->+ sd-modulator=C2=A0 +--------->+ DFSDM +-------->
> analog=C2=A0=C2=A0 +------+--------+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 +-------------+ output
> input=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | vref
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 +
>=20
>=20
> Is it the topology your are expecting ?

It's not the one we'd expect if we are aligning with similar cases
elsewhere in IIO.  For example, if we attach an analog accelerometer
to an ADC, we report the accel channels on the accelerometer not the
ADC.  The equivalent would be to see the DFSDM as providing a
conversion service to the SD device which is actually executing
the measurement and has the input channels.


=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 scale=C2=A0 offset  raw
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ^      ^
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0  |  =C2=A0=C2=A0              =
            IIO ABI
 +-------------------------------------------------------------+
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +---------------+=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-------------+
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |sd driver=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
|DFSDM driver |
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +---------------+=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-------------+
 +-------------------------------------------------------------+
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HW
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +---------------+=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-------------+
 +------->+ sd-modulator=C2=A0 +--------->+ DFSDM +-------->
 analog=C2=A0=C2=A0 +------+--------+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 +-------------+ output
 input=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | vref
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 +
>=20

> If not, I probably missedsomething. Could you please clarify this point ?
>=20
> Regards
> Olivier
> > This wasn't really an issue when the only values available were
> > raw, but if we are adding scale and offset, they are things that
> > belong to the ad1201 for example, not the upstream stm32-dfsdm unit.
> >
> > Thinking of it another way, we don't report an SPI ADC output in
> > the driver for the SPI master.
> >
> > Could we flip it around without breaking anything?
> >
> > Jonathan
> > =20
> >> ---
> >>   drivers/iio/adc/stm32-dfsdm-adc.c | 105 ++++++++++++++++++++++++++++=
+-
> >>   1 file changed, 102 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32=
-dfsdm-adc.c
> >> index 07b9dfdf8e76..b85fd3e90496 100644
> >> --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> >> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> >> @@ -10,6 +10,7 @@
> >>   #include <linux/dma-mapping.h>
> >>   #include <linux/iio/adc/stm32-dfsdm-adc.h>
> >>   #include <linux/iio/buffer.h>
> >> +#include <linux/iio/consumer.h>
> >>   #include <linux/iio/hw-consumer.h>
> >>   #include <linux/iio/sysfs.h>
> >>   #include <linux/iio/timer/stm32-lptim-trigger.h>
> >> @@ -67,6 +68,13 @@ struct stm32_dfsdm_dev_data {
> >>   	const struct regmap_config *regmap_cfg;
> >>   };
> >>  =20
> >> +struct stm32_dfsdm_sd_chan_info {
> >> +	int scale_val;
> >> +	int scale_val2;
> >> +	int offset;
> >> +	unsigned int differential;
> >> +};
> >> +
> >>   struct stm32_dfsdm_adc {
> >>   	struct stm32_dfsdm *dfsdm;
> >>   	const struct stm32_dfsdm_dev_data *dev_data;
> >> @@ -79,6 +87,7 @@ struct stm32_dfsdm_adc {
> >>   	struct iio_hw_consumer *hwc;
> >>   	struct completion completion;
> >>   	u32 *buffer;
> >> +	struct stm32_dfsdm_sd_chan_info *sd_chan;
> >>  =20
> >>   	/* Audio specific */
> >>   	unsigned int spi_freq;  /* SPI bus clock frequency */
> >> @@ -1271,7 +1280,10 @@ static int stm32_dfsdm_read_raw(struct iio_dev =
*indio_dev,
> >>   				int *val2, long mask)
> >>   {
> >>   	struct stm32_dfsdm_adc *adc =3D iio_priv(indio_dev);
> >> -	int ret;
> >> +	struct stm32_dfsdm_filter *fl =3D &adc->dfsdm->fl_list[adc->fl_id];
> >> +	struct stm32_dfsdm_filter_osr *flo =3D &fl->flo[fl->fast];
> >> +	u32 max =3D flo->max << (flo->lshift - chan->scan_type.shift);
> >> +	int ret, idx =3D chan->scan_index;
> >>  =20
> >>   	switch (mask) {
> >>   	case IIO_CHAN_INFO_RAW:
> >> @@ -1307,6 +1319,41 @@ static int stm32_dfsdm_read_raw(struct iio_dev =
*indio_dev,
> >>   		*val =3D adc->sample_freq;
> >>  =20
> >>   		return IIO_VAL_INT;
> >> +
> >> +	case IIO_CHAN_INFO_SCALE:
> >> +		/*
> >> +		 * Scale is expressed in mV.
> >> +		 * When fast mode is disabled, actual resolution may be lower
> >> +		 * than 2^n, where n=3Drealbits-1.
> >> +		 * This leads to underestimating input voltage. To
> >> +		 * compensate this deviation, the voltage reference can be
> >> +		 * corrected with a factor =3D realbits resolution / actual max
> >> +		 */
> >> +		*val =3D div_u64((u64)adc->sd_chan[idx].scale_val *
> >> +			       (u64)BIT(DFSDM_DATA_RES - 1), max);
> >> +		*val2 =3D chan->scan_type.realbits;
> >> +		if (adc->sd_chan[idx].differential)
> >> +			*val *=3D 2;
> >> +
> >> +		return IIO_VAL_FRACTIONAL_LOG2;
> >> +
> >> +	case IIO_CHAN_INFO_OFFSET:
> >> +		/*
> >> +		 * DFSDM output data are in the range [-2^n,2^n-1],
> >> +		 * with n=3Drealbits-1.
> >> +		 * - Differential modulator:
> >> +		 * Offset correspond to SD modulator offset.
> >> +		 * - Single ended modulator:
> >> +		 * Input is in [0V,Vref] range, where 0V corresponds to -2^n.
> >> +		 * Add 2^n to offset. (i.e. middle of input range)
> >> +		 * offset =3D offset(sd) * vref / res(sd) * max / vref.
> >> +		 */
> >> +		*val =3D div_u64((u64)max * adc->sd_chan[idx].offset,
> >> +			       BIT(adc->sd_chan[idx].scale_val2 - 1));
> >> +		if (!adc->sd_chan[idx].differential)
> >> +			*val +=3D max;
> >> +
> >> +		return IIO_VAL_INT;
> >>   	}
> >>  =20
> >>   	return -EINVAL;
> >> @@ -1430,7 +1477,9 @@ static int stm32_dfsdm_adc_chan_init_one(struct =
iio_dev *indio_dev,
> >>   	 * IIO_CHAN_INFO_RAW: used to compute regular conversion
> >>   	 * IIO_CHAN_INFO_OVERSAMPLING_RATIO: used to set oversampling
> >>   	 */
> >> -	ch->info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW);
> >> +	ch->info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> >> +				 BIT(IIO_CHAN_INFO_SCALE) |
> >> +				 BIT(IIO_CHAN_INFO_OFFSET);
> >>   	ch->info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_OVERSAMPLING_RATI=
O) |
> >>   					BIT(IIO_CHAN_INFO_SAMP_FREQ);
> >>  =20
> >> @@ -1481,8 +1530,10 @@ static int stm32_dfsdm_adc_init(struct iio_dev =
*indio_dev)
> >>   {
> >>   	struct iio_chan_spec *ch;
> >>   	struct stm32_dfsdm_adc *adc =3D iio_priv(indio_dev);
> >> +	struct iio_channel *channels, *chan;
> >> +	struct stm32_dfsdm_sd_chan_info *sd_chan;
> >>   	int num_ch;
> >> -	int ret, chan_idx;
> >> +	int ret, chan_idx, val2;
> >>  =20
> >>   	adc->oversamp =3D DFSDM_DEFAULT_OVERSAMPLING;
> >>   	ret =3D stm32_dfsdm_compute_all_osrs(indio_dev, adc->oversamp);
> >> @@ -1506,6 +1557,22 @@ static int stm32_dfsdm_adc_init(struct iio_dev =
*indio_dev)
> >>   	if (!ch)
> >>   		return -ENOMEM;
> >>  =20
> >> +	/* Get SD modulator channels */
> >> +	channels =3D iio_channel_get_all(&indio_dev->dev);
> >> +	if (IS_ERR(channels)) {
> >> +		dev_err(&indio_dev->dev, "Failed to get channel %ld\n",
> >> +			PTR_ERR(channels));
> >> +		return PTR_ERR(channels);
> >> +	}
> >> +	chan =3D &channels[0];
> >> +
> >> +	adc->sd_chan =3D devm_kzalloc(&indio_dev->dev,
> >> +				    sizeof(*adc->sd_chan) * num_ch, GFP_KERNEL);
> >> +	if (!adc->sd_chan)
> >> +		return -ENOMEM;
> >> +
> >> +	sd_chan =3D adc->sd_chan;
> >> +
> >>   	for (chan_idx =3D 0; chan_idx < num_ch; chan_idx++) {
> >>   		ch[chan_idx].scan_index =3D chan_idx;
> >>   		ret =3D stm32_dfsdm_adc_chan_init_one(indio_dev, &ch[chan_idx]);
> >> @@ -1513,6 +1580,38 @@ static int stm32_dfsdm_adc_init(struct iio_dev =
*indio_dev)
> >>   			dev_err(&indio_dev->dev, "Channels init failed\n");
> >>   			return ret;
> >>   		}
> >> +
> >> +		if (!chan->indio_dev)
> >> +			return -EINVAL;
> >> +
> >> +		ret =3D iio_read_channel_scale(chan, &sd_chan->scale_val,
> >> +					     &sd_chan->scale_val2);
> >> +		if (ret < 0) {
> >> +			dev_err(&indio_dev->dev,
> >> +				"Failed to get channel %d scale\n", chan_idx);
> >> +			return ret;
> >> +		}
> >> +
> >> +		if (iio_channel_has_info(chan->channel, IIO_CHAN_INFO_OFFSET)) {
> >> +			ret =3D iio_read_channel_offset(chan, &sd_chan->offset,
> >> +						      &val2);
> >> +			if (ret < 0) {
> >> +				dev_err(&indio_dev->dev,
> >> +					"Failed to get channel %d offset\n",
> >> +					chan_idx);
> >> +				return ret;
> >> +			}
> >> +		}
> >> +
> >> +		sd_chan->differential =3D chan->channel->differential;
> >> +
> >> +		dev_dbg(&indio_dev->dev, "Channel %d %s scale ref=3D%d offset=3D%d",
> >> +			chan_idx, chan->channel->differential ?
> >> +			"differential" : "single-ended",
> >> +			sd_chan->scale_val, sd_chan->offset);
> >> +
> >> +		chan++;
> >> +		sd_chan++;
> >>   	}
> >>  =20
> >>   	indio_dev->num_channels =3D num_ch; =20

