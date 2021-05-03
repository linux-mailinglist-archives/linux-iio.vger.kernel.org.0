Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80132371397
	for <lists+linux-iio@lfdr.de>; Mon,  3 May 2021 12:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbhECK1f convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 3 May 2021 06:27:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:52890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233340AbhECK1b (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 3 May 2021 06:27:31 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE8E8610C9;
        Mon,  3 May 2021 10:25:09 +0000 (UTC)
Date:   Mon, 3 May 2021 11:26:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     =?UTF-8?B?SsOzenNlZiBIb3J2w6F0aA==?= <info@ministro.hu>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Gene Chen <gene_chen@richtek.com>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc: driver for texas instruments ads7142
Message-ID: <20210503112600.35c4016e@jic23-huawei>
In-Reply-To: <20210502204846.GA32610@dev>
References: <bffbc2b24a869dc42307adf8e3fc71f08fcff6dd.1619892171.git.info@ministro.hu>
        <20210502181423.1712130b@jic23-huawei>
        <20210502204846.GA32610@dev>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 2 May 2021 20:48:47 +0000
József Horváth <info@ministro.hu> wrote:

> On Sun, May 02, 2021 at 06:14:23PM +0100, Jonathan Cameron wrote:
> > On Sat, 1 May 2021 18:24:28 +0000
> > Jozsef Horvath <info@ministro.hu> wrote:
> >   
> > > This is an iio driver for
> > >  Texas Instruments ADS7142 dual-channel, programmable sensor monitor.
> > > 
> > > Operation modes supportedby the driver:
> > >   When the 'ti,monitoring-mode' property is not present
> > >     in the devicetree node definition, the driver initiates a single
> > >     conversion in the device for each read request
> > >     (/sys/bus/iio/devices/iio:deviceX/in_voltageY_raw).
> > >     This is a one-shot conversion, and it is called
> > >     "Manual Mode" in the datasheet.
> > > 
> > >   When the 'ti,monitoring-mode' property is present
> > >     in the devicetree node definition, the driver configures
> > >     the device's digital window comparator and sets the device's
> > >     data buffer operation mode to pre alert data mode.
> > >     The driver reads the conversion result when the BUSY/RDY interrupt
> > >     fires, and keeps the value until the next BUSY/RDY interrupt
> > >     or the first read request
> > >     (/sys/bus/iio/devices/iio:deviceX/in_voltageY_raw).  
> > 
> > Hi Jozsef.
> > 
> > Interesting device - somewhat like an impact sensor, but on a general
> > purpose ADC.  
> 
> Yes, but now I'm using as an ADC in my project.
> In my point of view this is a general purpose ADC with monitoring features.
> 
> > 
> > Hmm. This sounds rather unintuitive and also very much like a policy
> > decision rather than anything to do with the hardware.  Hence it
> > should almost certainly be in control of userspace and no via
> > dt parameters.
> >   
> 
> I think that, this operation modes are not generic enough to bring it to sysfs.

That just means you need to figure out how to do it, not make it a
boot time, or board flash time based control.

> 
> > The interrupt driven nature of the device implies that a polled interface
> > such as sysfs is not appropriate to support this mode.
> > 
> > Based on the description you have given here and a quick look
> > at the flow charts in the datasheet I would suggest.
> > 1) Enable sysfs reads as manual mode only.
> > 2) Implement the buffered part of an IIO driver.  This is what we use
> >    for data where autonomous clocking is going on.  
> 
> I'll check the buffered api.
> 
> > 3) Add triggers to represent the different autonomous modes.  In some
> >    sense all the modes present can be considered be a series of
> >    'capture now' signals that are being generated by the hardware in
> >    response to some event'.
> > 
> > So you'd have a pre_alert_tigger, post_alert_trigger
> > Stop_burst and start_burst are more interesting to handle because you
> > will need something to actually start/stop them.  These could be done
> > via a sysfs attribute for the trigger, or more complex schemes exist
> > such as triggering them off another trigger... one or two of the SoC
> > ADCs do that sort of thing.
> > 
> >    
> > >     The digital window comparator and hysteresis parameters
> > >     can be controlled by:
> > >       - the devicetree definition of channel node
> > >       - iio sysfs interfaces
> > >     This is event driven conversion, and is called
> > >     "Autonomous Mode with Pre Alert Data" in the datasheet.
> > >     This mode can be used to wake up the system with the ALERT pin,
> > >     in case when the monitored voltage level is out of the configured range.  
> > 
> > Whilst it's fine to only enable the modes you want, we should think about how
> > to ensure other modes can be supported.
> >   
> 
> As I described above, I would keep the operation modes in dt, and
>  'ti,monitoring-mode' can be an enum.

Sorry but no.  Unless you can make a 'very' strong argument of the
fact that this a characteristic of the hardware setup (wiring etc) then
it needs to be userspace controlled.

> 
> > > 
> > > Datasheet: https://www.ti.com/lit/ds/symlink/ads7142.pdf
> > > 
> > > Signed-off-by: Jozsef Horvath <info@ministro.hu>
> > > ---  

...

> 
> > 
> >   
> > > +
> > > +	return ret >= 0 ? 0 : ret;  
> > 
> > if ret == 0 then something went wrong and we should report that.  
> 
> You are right
> 
> > > +				channel->data.value = value;
> > > +				*channel_collected |= 1 << channel_address;
> > > +			}
> > > +		}
> > > +	} while (--data_buffer_status);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static int ti_ads7142_do_work(struct iio_dev *indio_dev)  
> > 
> > As mentioned below, these function needs a more informative name.  
> 
> I'll change it to ..._do_monitoring_work, and create something like
>  start_pre_alert_monitoring, start_post_alert_monitoring, etc

Maybe, but I'd expect 'work' to imply it was the function called on
each cycle of monitoring.  This is more monitoring_setup()


...

>  
> > > +static int ti_ads7142_read_event_config(struct iio_dev *indio_dev,
> > > +					const struct iio_chan_spec *chan,
> > > +					enum iio_event_type type,
> > > +					enum iio_event_direction dir)
> > > +{
> > > +	struct ti_ads7142_priv *priv = iio_priv(indio_dev);
> > > +	struct ti_ads7142_channel *channel;
> > > +	int ret;
> > > +
> > > +	if (!priv->config.monitoring_mode)
> > > +		return -EINVAL;
> > > +
> > > +	if (type != IIO_EV_TYPE_THRESH)
> > > +		return -EINVAL;
> > > +
> > > +	ret = ti_ads7142_address2channel(indio_dev, chan->address,
> > > +					 &channel);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	if (dir == IIO_EV_DIR_RISING)
> > > +		ret = channel->config.alert_high ? 1 : 0;  
> > 
> > Not fine using ret = channel->config.alert_high; directly?
> >   
> 
> alert_high is bool, ret is int.
>  I know, the 'true' value is 1, and its autmatically casted,
>  but who knows the future...I would keep this, if possible.

Ok.  Assuming the c spec will change to make this invalid is a bit implausible,
but it's not too bad I guess.

> 
...

> 
> >   
> > > +					   &ads_channel->config.high_threshold);
> > > +		ads_channel->config.alert_high = !ret;
> > > +		ret = of_property_read_u32(channel_node, "ti,threshold-falling",
> > > +					   &ads_channel->config.low_threshold);
> > > +		ads_channel->config.alert_low = !ret;
> > > +		ret = of_property_read_u32(channel_node, "ti,hysteresis",
> > > +					   &ads_channel->config.hysteresis);
> > > +		channel_index++;
> > > +	}
> > > +
> > > +	return 0;
> > > +err:
> > > +	of_node_put(channel_node);
> > > +	return ret;
> > > +}
> > > +
> > > +static int ti_ads7142_parse_config_of(struct device *dev,
> > > +				      struct iio_dev *indio_dev)
> > > +{
> > > +	struct ti_ads7142_priv *priv = iio_priv(indio_dev);
> > > +
> > > +	priv->config.osc_sel = of_property_read_bool(dev->of_node,
> > > +						     "ti,osc-sel");  
> > 
> > Please use generic device property access functions where possible.
> > That basically gives us support on non OF based platforms for free.  
> 
> Could you please explain this, I dont understand.

See include/linux/property.h

That provides firmware type agnostic property accessors - so they will work
whether the property is provided via ACPI or via DT (or a number of other
options though those are less common).

ACPI DSDT tables can use a special device type PRP0001 which basically is a
wrapper for device tree properties.  So the properties are all the same
(including compatible) but you need to use the generic accessors to be able to
read them. 


> 
> >   
> > > +	of_property_read_u32(dev->of_node, "ti,n-clk", &priv->config.n_clk);
> > > +	priv->config.monitoring_mode = of_property_read_bool(dev->of_node,
> > > +							     "ti,monitoring-mode");
> > > +
> > > +	return ti_ads7142_parse_channel_config_of(dev, indio_dev);
> > > +}
>
...
> Thank you for the review and suggestions.

You are welcome.

Thanks,

Jonathan

> 
> Best regards
> Jozsef

> 
> >   
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +module_i2c_driver(ti_ads7142_driver);
> > > +
> > > +MODULE_LICENSE("GPL");
> > > +MODULE_AUTHOR("Jozsef Horvath <info@ministro.hu>");
> > > +MODULE_DESCRIPTION("Texas Instruments TI_ADS7142 ADC driver");  
> > 
> >   
> 

