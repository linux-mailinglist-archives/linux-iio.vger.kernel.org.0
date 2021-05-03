Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCBC9372080
	for <lists+linux-iio@lfdr.de>; Mon,  3 May 2021 21:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbhECTeo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 May 2021 15:34:44 -0400
Received: from bmail1.ministro.hu ([5.249.150.236]:42762 "EHLO
        bmail1.ministro.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhECTen (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 May 2021 15:34:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTP id 6EEBF123F7A;
        Mon,  3 May 2021 21:33:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1620070427;
        bh=zJ3TTZ5d5dm5GAXhkfMZnzMd4yvhHXI8f3VJrda5gLY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L8TCGUfaNrDQ3qGfar96xwm/EISqpHC9aU170sve0b+VinDWAuQvbFqS0yErSRB1n
         pw7jyrOyYAbFALkyoZ2zB238SK0uTqjNmPucQ3uAKwnVGw1LYR08d8xrZ5mAHz33sK
         ZyE1GtWISQV9ywrPUsAT8cbUR6wjmUp+BQHWeXdF6lDHKVkfeVpGdN9Uc2xv8JAnav
         qMwLGRSgttreh7HKIMmDiJSOkQse/mSXPs+cjDVQjzuOd5LMVXAsLGYhKYvyGaZgvE
         DLDRZSbA1ANMOQHR6gBCZJrRZN+FTHk+MNBYBgmJx02nRdINAbvrJm0ygaKoKxWCzP
         dFungFB0d5OPw==
X-Virus-Scanned: Debian amavisd-new at ministro.hu
Received: from bmail1.ministro.hu ([127.0.0.1])
        by localhost (bmail1.ministro.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id B9PGb0-2Lmg4; Mon,  3 May 2021 21:33:14 +0200 (CEST)
Received: from dev (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTPSA id 0279C123F6B;
        Mon,  3 May 2021 21:33:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1620070394;
        bh=zJ3TTZ5d5dm5GAXhkfMZnzMd4yvhHXI8f3VJrda5gLY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tIyuYlPxRZU91v6Vu5pKKW6IpUIOr91jVkQkx8HnVuHf8d+rTwPMVWrYCWz0cLPhG
         Jei19SQFy1dUWqr1zTins95Li74J5yusgXiGx/PR9FnVCZJ8oCfRzQkbc//lDAkMq7
         AT2/C1VHJrl7aLYSgXfVngHb8YCrSGIdnKS0y5sffeM94wUNB1KV7LtuxS+QjO4rg0
         439FFeNpEWBSpKK1wwmWqdLMnH1r+oYbi+5p6aTf42RkqXx48LkTcIYegif+cdZD3j
         3cGuEJVzGTjgis/yNBCJbJ2NueVRNdlFrWvCXgvMs4LUQYDFtXMDKAySdWSTrBXhbE
         YHQ4CYNJBbrhg==
Date:   Mon, 3 May 2021 19:33:10 +0000
From:   =?iso-8859-1?Q?J=F3zsef_Horv=E1th?= <info@ministro.hu>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Gene Chen <gene_chen@richtek.com>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc: driver for texas instruments ads7142
Message-ID: <20210503193310.GA1714@dev>
References: <bffbc2b24a869dc42307adf8e3fc71f08fcff6dd.1619892171.git.info@ministro.hu>
 <20210502181423.1712130b@jic23-huawei>
 <20210502204846.GA32610@dev>
 <20210503112600.35c4016e@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210503112600.35c4016e@jic23-huawei>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, May 03, 2021 at 11:26:00AM +0100, Jonathan Cameron wrote:
> On Sun, 2 May 2021 20:48:47 +0000
> József Horváth <info@ministro.hu> wrote:
> 
> > On Sun, May 02, 2021 at 06:14:23PM +0100, Jonathan Cameron wrote:
> > > On Sat, 1 May 2021 18:24:28 +0000
> > > Jozsef Horvath <info@ministro.hu> wrote:
> > >   
> > > > This is an iio driver for
> > > >  Texas Instruments ADS7142 dual-channel, programmable sensor monitor.
> > > > 
> > > > Operation modes supportedby the driver:
> > > >   When the 'ti,monitoring-mode' property is not present
> > > >     in the devicetree node definition, the driver initiates a single
> > > >     conversion in the device for each read request
> > > >     (/sys/bus/iio/devices/iio:deviceX/in_voltageY_raw).
> > > >     This is a one-shot conversion, and it is called
> > > >     "Manual Mode" in the datasheet.
> > > > 
> > > >   When the 'ti,monitoring-mode' property is present
> > > >     in the devicetree node definition, the driver configures
> > > >     the device's digital window comparator and sets the device's
> > > >     data buffer operation mode to pre alert data mode.
> > > >     The driver reads the conversion result when the BUSY/RDY interrupt
> > > >     fires, and keeps the value until the next BUSY/RDY interrupt
> > > >     or the first read request
> > > >     (/sys/bus/iio/devices/iio:deviceX/in_voltageY_raw).  
> > > 
> > > Hi Jozsef.
> > > 
> > > Interesting device - somewhat like an impact sensor, but on a general
> > > purpose ADC.  
> > 
> > Yes, but now I'm using as an ADC in my project.
> > In my point of view this is a general purpose ADC with monitoring features.
> > 
> > > 
> > > Hmm. This sounds rather unintuitive and also very much like a policy
> > > decision rather than anything to do with the hardware.  Hence it
> > > should almost certainly be in control of userspace and no via
> > > dt parameters.
> > >   
> > 
> > I think that, this operation modes are not generic enough to bring it to sysfs.
> 
> That just means you need to figure out how to do it, not make it a
> boot time, or board flash time based control.

I will try to bring it into sysfs.

> 
> > 
> > > The interrupt driven nature of the device implies that a polled interface
> > > such as sysfs is not appropriate to support this mode.
> > > 
> > > Based on the description you have given here and a quick look
> > > at the flow charts in the datasheet I would suggest.
> > > 1) Enable sysfs reads as manual mode only.
> > > 2) Implement the buffered part of an IIO driver.  This is what we use
> > >    for data where autonomous clocking is going on.  
> > 
> > I'll check the buffered api.
> > 
> > > 3) Add triggers to represent the different autonomous modes.  In some
> > >    sense all the modes present can be considered be a series of
> > >    'capture now' signals that are being generated by the hardware in
> > >    response to some event'.
> > > 
> > > So you'd have a pre_alert_tigger, post_alert_trigger
> > > Stop_burst and start_burst are more interesting to handle because you
> > > will need something to actually start/stop them.  These could be done
> > > via a sysfs attribute for the trigger, or more complex schemes exist
> > > such as triggering them off another trigger... one or two of the SoC
> > > ADCs do that sort of thing.
> > > 
> > >    
> > > >     The digital window comparator and hysteresis parameters
> > > >     can be controlled by:
> > > >       - the devicetree definition of channel node
> > > >       - iio sysfs interfaces
> > > >     This is event driven conversion, and is called
> > > >     "Autonomous Mode with Pre Alert Data" in the datasheet.
> > > >     This mode can be used to wake up the system with the ALERT pin,
> > > >     in case when the monitored voltage level is out of the configured range.  
> > > 
> > > Whilst it's fine to only enable the modes you want, we should think about how
> > > to ensure other modes can be supported.
> > >   
> > 
> > As I described above, I would keep the operation modes in dt, and
> >  'ti,monitoring-mode' can be an enum.
> 
> Sorry but no.  Unless you can make a 'very' strong argument of the
> fact that this a characteristic of the hardware setup (wiring etc) then
> it needs to be userspace controlled.
> 

Ok, I'll come back a possible solution soon.

> > 
> > > > 
> > > > Datasheet: https://www.ti.com/lit/ds/symlink/ads7142.pdf
> > > > 
> > > > Signed-off-by: Jozsef Horvath <info@ministro.hu>
> > > > ---  
> 
> ...
> 
> > 
> > > 
> > >   
> > > > +
> > > > +	return ret >= 0 ? 0 : ret;  
> > > 
> > > if ret == 0 then something went wrong and we should report that.  
> > 
> > You are right
> > 
> > > > +				channel->data.value = value;
> > > > +				*channel_collected |= 1 << channel_address;
> > > > +			}
> > > > +		}
> > > > +	} while (--data_buffer_status);
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +static int ti_ads7142_do_work(struct iio_dev *indio_dev)  
> > > 
> > > As mentioned below, these function needs a more informative name.  
> > 
> > I'll change it to ..._do_monitoring_work, and create something like
> >  start_pre_alert_monitoring, start_post_alert_monitoring, etc
> 
> Maybe, but I'd expect 'work' to imply it was the function called on
> each cycle of monitoring.  This is more monitoring_setup()
> 

'..._setup' is ok for me.

> 
> ...
> 
> >  
> > > > +static int ti_ads7142_read_event_config(struct iio_dev *indio_dev,
> > > > +					const struct iio_chan_spec *chan,
> > > > +					enum iio_event_type type,
> > > > +					enum iio_event_direction dir)
> > > > +{
> > > > +	struct ti_ads7142_priv *priv = iio_priv(indio_dev);
> > > > +	struct ti_ads7142_channel *channel;
> > > > +	int ret;
> > > > +
> > > > +	if (!priv->config.monitoring_mode)
> > > > +		return -EINVAL;
> > > > +
> > > > +	if (type != IIO_EV_TYPE_THRESH)
> > > > +		return -EINVAL;
> > > > +
> > > > +	ret = ti_ads7142_address2channel(indio_dev, chan->address,
> > > > +					 &channel);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	if (dir == IIO_EV_DIR_RISING)
> > > > +		ret = channel->config.alert_high ? 1 : 0;  
> > > 
> > > Not fine using ret = channel->config.alert_high; directly?
> > >   
> > 
> > alert_high is bool, ret is int.
> >  I know, the 'true' value is 1, and its autmatically casted,
> >  but who knows the future...I would keep this, if possible.
> 
> Ok.  Assuming the c spec will change to make this invalid is a bit implausible,
> but it's not too bad I guess.
> 
> > 
> ...
> 
> > 
> > >   
> > > > +					   &ads_channel->config.high_threshold);
> > > > +		ads_channel->config.alert_high = !ret;
> > > > +		ret = of_property_read_u32(channel_node, "ti,threshold-falling",
> > > > +					   &ads_channel->config.low_threshold);
> > > > +		ads_channel->config.alert_low = !ret;
> > > > +		ret = of_property_read_u32(channel_node, "ti,hysteresis",
> > > > +					   &ads_channel->config.hysteresis);
> > > > +		channel_index++;
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +err:
> > > > +	of_node_put(channel_node);
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +static int ti_ads7142_parse_config_of(struct device *dev,
> > > > +				      struct iio_dev *indio_dev)
> > > > +{
> > > > +	struct ti_ads7142_priv *priv = iio_priv(indio_dev);
> > > > +
> > > > +	priv->config.osc_sel = of_property_read_bool(dev->of_node,
> > > > +						     "ti,osc-sel");  
> > > 
> > > Please use generic device property access functions where possible.
> > > That basically gives us support on non OF based platforms for free.  
> > 
> > Could you please explain this, I dont understand.
> 
> See include/linux/property.h
> 
> That provides firmware type agnostic property accessors - so they will work
> whether the property is provided via ACPI or via DT (or a number of other
> options though those are less common).
> 
> ACPI DSDT tables can use a special device type PRP0001 which basically is a
> wrapper for device tree properties.  So the properties are all the same
> (including compatible) but you need to use the generic accessors to be able to
> read them. 
> 

I'ts clear now, include/linux/property.h was a good starting point. Thank you.

> 
> > 
> > >   
> > > > +	of_property_read_u32(dev->of_node, "ti,n-clk", &priv->config.n_clk);
> > > > +	priv->config.monitoring_mode = of_property_read_bool(dev->of_node,
> > > > +							     "ti,monitoring-mode");
> > > > +
> > > > +	return ti_ads7142_parse_channel_config_of(dev, indio_dev);
> > > > +}
> >
> ...
> > Thank you for the review and suggestions.
> 
> You are welcome.
> 
> Thanks,
> 
> Jonathan
> 
> > 
> > Best regards
> > Jozsef
> 
> > 
> > >   
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +module_i2c_driver(ti_ads7142_driver);
> > > > +
> > > > +MODULE_LICENSE("GPL");
> > > > +MODULE_AUTHOR("Jozsef Horvath <info@ministro.hu>");
> > > > +MODULE_DESCRIPTION("Texas Instruments TI_ADS7142 ADC driver");  
> > > 
> > >   
> > 
> 

Best regards
Jozsef
