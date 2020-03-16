Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0AB918717F
	for <lists+linux-iio@lfdr.de>; Mon, 16 Mar 2020 18:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732079AbgCPRrZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Mar 2020 13:47:25 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:54170 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731843AbgCPRrY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 16 Mar 2020 13:47:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 7F511FB03;
        Mon, 16 Mar 2020 18:47:22 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GMMW-5x6GCXX; Mon, 16 Mar 2020 18:47:21 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id D498B40D82; Mon, 16 Mar 2020 18:47:20 +0100 (CET)
Date:   Mon, 16 Mar 2020 18:47:20 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Tomas Novotny <tomas@novotny.cz>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: vcnl4000: Export near level property for
 proximity sensor
Message-ID: <20200316174720.GA188762@bogon.m.sigxcpu.org>
References: <cover.1581947007.git.agx@sigxcpu.org>
 <4a8075acde807225a2d9aeb4164fff881013bbe2.1581947007.git.agx@sigxcpu.org>
 <20200221120519.43b72007@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200221120519.43b72007@archlinux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,
On Fri, Feb 21, 2020 at 12:05:19PM +0000, Jonathan Cameron wrote:
> On Mon, 17 Feb 2020 14:44:47 +0100
> Guido Günther <agx@sigxcpu.org> wrote:
> 
> > When an object can be considered close to the sensor is hardware
> > dependent. Allowing to configure the property via device tree
> > allows to configure this device specific value.
> > 
> > This is useful for e.g. iio-sensor-proxy to indicate to userspace
> > if an object is close to the sensor.
> > 
> > Signed-off-by: Guido Günther <agx@sigxcpu.org>
> 
> I'd like this to sit for a while on the mailing list and hopefully get
> some input from others.
> 
> However, it needs documentation and I think this should be in the
> generic docs, or at least proximity specific ones.
> 
> Documentation/ABI/testing/sysfs-bus-iio-proximity would be the obvious
> place.

Makes sense, i left that out to gather initial feedback but added the
docs and converted the bindings to yaml for v2.
Cheers,
 -- Guido

> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/iio/light/vcnl4000.c | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> > 
> > diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> > index 38fcd9a26046..7111118e0fda 100644
> > --- a/drivers/iio/light/vcnl4000.c
> > +++ b/drivers/iio/light/vcnl4000.c
> > @@ -83,6 +83,7 @@ struct vcnl4000_data {
> >  	struct mutex vcnl4000_lock;
> >  	struct vcnl4200_channel vcnl4200_al;
> >  	struct vcnl4200_channel vcnl4200_ps;
> > +	uint32_t near_level;
> >  };
> >  
> >  struct vcnl4000_chip_spec {
> > @@ -342,6 +343,26 @@ static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
> >  	},
> >  };
> >  
> > +
> > +static ssize_t vcnl4000_read_near_level(struct iio_dev *indio_dev,
> > +					uintptr_t priv,
> > +					const struct iio_chan_spec *chan,
> > +					char *buf)
> > +{
> > +	struct vcnl4000_data *data = iio_priv(indio_dev);
> > +
> > +	return sprintf(buf, "%u\n", data->near_level);
> > +}
> > +
> > +static const struct iio_chan_spec_ext_info vcnl4000_ext_info[] = {
> > +	{
> > +		.name = "near_level",
> > +		.shared = IIO_SEPARATE,
> > +		.read = vcnl4000_read_near_level,
> > +	},
> > +	{ /* sentinel */ }
> > +};
> > +
> >  static const struct iio_chan_spec vcnl4000_channels[] = {
> >  	{
> >  		.type = IIO_LIGHT,
> > @@ -350,6 +371,7 @@ static const struct iio_chan_spec vcnl4000_channels[] = {
> >  	}, {
> >  		.type = IIO_PROXIMITY,
> >  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> > +		.ext_info = vcnl4000_ext_info,
> >  	}
> >  };
> >  
> > @@ -439,6 +461,10 @@ static int vcnl4000_probe(struct i2c_client *client,
> >  	dev_dbg(&client->dev, "%s Ambient light/proximity sensor, Rev: %02x\n",
> >  		data->chip_spec->prod, data->rev);
> >  
> > +	if (device_property_read_u32(&client->dev, "near-level",
> > +				     &data->near_level) < 0)
> > +		data->near_level = 0;
> > +
> >  	indio_dev->dev.parent = &client->dev;
> >  	indio_dev->info = &vcnl4000_info;
> >  	indio_dev->channels = vcnl4000_channels;
> 
