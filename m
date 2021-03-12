Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E448338F82
	for <lists+linux-iio@lfdr.de>; Fri, 12 Mar 2021 15:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhCLOKv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Mar 2021 09:10:51 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2691 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbhCLOKb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Mar 2021 09:10:31 -0500
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DxncW0KNfz67vqd;
        Fri, 12 Mar 2021 22:04:27 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 12 Mar 2021 15:10:29 +0100
Received: from localhost (10.47.81.238) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 12 Mar
 2021 14:10:28 +0000
Date:   Fri, 12 Mar 2021 14:09:15 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
CC:     Jonathan Cameron <jic23@kernel.org>, <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        <linux-iio@vger.kernel.org>,
        Robin van der Gracht <robin@protonic.nl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "David Jander" <david@protonic.nl>, <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v1 2/2] iio: adc: add ADC driver for the TI TSC2046
 controller
Message-ID: <20210312140915.000039ad@Huawei.com>
In-Reply-To: <20210309114046.mxcicdiyraa2jqnk@pengutronix.de>
References: <20210305133813.27967-1-o.rempel@pengutronix.de>
        <20210305133813.27967-3-o.rempel@pengutronix.de>
        <20210305190239.000075fe@Huawei.com>
        <20210306132852.s2vzotnadanoo2na@pengutronix.de>
        <20210306145959.4c51e8ae@archlinux>
        <20210309114046.mxcicdiyraa2jqnk@pengutronix.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.81.238]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 9 Mar 2021 12:40:46 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Hi Jonathan,
> 
> On Sat, Mar 06, 2021 at 02:59:59PM +0000, Jonathan Cameron wrote:
> > On Sat, 6 Mar 2021 14:28:52 +0100
> > Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> >   
> > > On Fri, Mar 05, 2021 at 07:02:39PM +0000, Jonathan Cameron wrote:  
> > > > On Fri, 5 Mar 2021 14:38:13 +0100
> > > > Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> > > >     
> > > > > Basically the TI TSC2046 touchscreen controller is 8 channel ADC optimized for
> > > > > the touchscreen use case. By implementing it as IIO ADC device, we can
> > > > > make use of resistive-adc-touch and iio-hwmon drivers.
> > > > > 
> > > > > So far, this driver was tested with custom version of resistive-adc-touch driver,
> > > > > since it need to be extended to make use of Z1 and Z2 channels. The X/Y
> > > > > are working without additional changes.
> > > > > 
> > > > > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>    
> > > > 
> > > > Hi Oleksij,
> > > > 
> > > > To consider this as a possible long term route instead of just making this
> > > > a touchscreen driver, we'll want to see those mods to the resistive-adc-touch.
> > > > Of course that doesn't stop review of this in the meantime.    
> > > 
> > > ok.
> > > 
> > > I had following issues with the existing resistive-adc-touch driver:
> > > - the buffer layout is not configurable over DT or i didn't understood
> > >   how to properly configure it
> > > - the "pressure" channel provide pre processed data driver or
> > >   controller, this information cannot be extracted directly from the
> > >   touchscreen plates.
> > > 
> > > I did following changes to make it work for my use case:
> > > 
> > > --- a/drivers/input/touchscreen/resistive-adc-touch.c
> > > +++ b/drivers/input/touchscreen/resistive-adc-touch.c
> > > @@ -44,15 +44,34 @@ static int grts_cb(const void *data, void *private)
> > >  {
> > >  	const u16 *touch_info = data;
> > >  	struct grts_state *st = private;
> > > -	unsigned int x, y, press = 0x0;
> > > +	unsigned int x, y, press = 0x0, z1, z2;
> > > +	unsigned int Rt;
> > >  
> > >  	/* channel data coming in buffer in the order below */
> > > -	x = touch_info[0];
> > > -	y = touch_info[1];
> > > +	// TODO: make sure we get buffers in proper order  
> > 
> > Ah.  So to figure this out we'll need to read some more info about the
> > channels.  The phandle order for the touchscreen binding
> > should probably be specified (if it's not already) and that should let
> > us establish the ordering of channels.   
> 
> Ack. So this should be done in the touchscreen driver and can be done
> later?

Sure. I don't recall if we have handy look up functions to make this easy
but we can add some as needed for the touchscreen side of things.

> 
> > > +	x = touch_info[3];
> > > +	z2 = touch_info[2];
> > > +	z1 = touch_info[1];
> > > +	y = touch_info[0];
> > > +
> > > +	if (z1) {
> > > +		Rt = z2;  
> > 
> > So for this we are going to need to define it in a generic fashion - probably
> > via a mode + coefficients in DT?  
> 
> I assume, mode will be needed any way, coefficients can stay as is and
> if we get some different use case add an overwrite binding to the
> devicetree.

Ok, we can use these as default values.

> 
> > > +		Rt -= z1;
> > > +		Rt *= 800;
> > > +		//Rt *= ts->x_plate_ohms;
> > > +		Rt = DIV_ROUND_CLOSEST(Rt, 16);
> > > +		Rt *= x;
> > > +		Rt /= z1;
> > > +		Rt = DIV_ROUND_CLOSEST(Rt, 256);
> > > +	} else
> > > +		Rt = 0x400;
> > > +
> > >  	if (st->pressure)
> > > -		press = touch_info[2];
> > > +		press = Rt;
> > >  
> > > -	if ((!x && !y) || (st->pressure && (press < st->pressure_min))) {
> > > +	//printk("%s:%i: x: %x, y %x, z1: %x, z2: %x, press: %x\n", __func__, __LINE__, x, y, z1, z2, press);
> > > +	//if ((!x && !y) || (st->pressure && (press < st->pressure_min))) {
> > > +	if ((!x && !y) || (st->pressure && (press > 0x350))) {
> > >  		/* report end of touch */
> > >  		input_report_key(st->input, BTN_TOUCH, 0);
> > >  		input_sync(st->input);
> > > @@ -116,7 +135,7 @@ static int grts_probe(struct platform_device *pdev)
> > >  	}
> > >  
> > >  	chan = &st->iio_chans[0];
> > > -	st->pressure = false;
> > > +	st->pressure = true;
> > >  	while (chan && chan->indio_dev) {
> > >  
> > > 
> > >   
> > > > There are quite a few things in here that feel pretty specific to the touchscreen
> > > > usecase. That makes me wonder if this is a sensible approach or not.    
> > > 
> > > I'm sure it is the right way to go. Here is why:
> > > 
> > > A typical resistive touchscreen can be described as 2 resistors (plates)
> > > shorted to each other on pressure:
> > > 
> > >           o Y+
> > >           |
> > >           #
> > > 	  #
> > >           # /---- shorted on pressure
> > >           |/
> > > o---###---+---###--o
> > > X-        |        X+
> > >           #
> > >           #
> > >           #
> > >           |
> > >           o Y-
> > > 
> > > 
> > > To find the location of shorted circuit (finger position) we need to
> > > measure voltage on different points of the circuit:
> > > - to get X-position, apply voltage on X+/X- and measure voltage on Y+
> > > - to get Y-position, apply voltage on Y+/Y- and measure voltage on X+
> > > 
> > > Measuring the "pressure" is a bit more tricky:
> > > - apply voltage on X-/Y+ and measure on X+ and Y-, so we will get Z1 and
> > >   Z2
> > > - will need to know real plate resistance to do following calculation:
> > >   Rtouch = Rx-plate * (X-position / 4096) * (Z2/Z1 - 1)
> > > 
> > > There is is still more points which share all resistive touchscreens:
> > > - they have parasitic capacitance, so it take some time between
> > >   switching to voltage on and usable measurements
> > > - they act as antenna, so we measure different kind of electrical noise
> > > - we have low-frequency mechanical waves on the plates which can trigger
> > >   some bounce artifacts
> > > - the results will change depending on the temperature and the supply
> > >   voltage. So we need to monitor both of them to adjust our results.
> > > 
> > > To handle this issues we need to skip some samples until voltage is
> > > settled, we need to apply some simple digital low-pass filter to
> > > reduce the noise and add some corrections if we are able to measure
> > > system temperature and voltage.
> > > 
> > > All of described measurements are more or less touchscreen and not
> > > touch controller specific. IMO, resistive-adc-touch provide proper
> > > abstraction separation and should be a long therm - way to go :)
> > > 
> > > Now is the question, what is TSC2046? Please see the block diagram on
> > > page 10:
> > > https://www.ti.com/lit/ds/symlink/tsc2046.pdf
> > > 
> > > If I oversimplify this diagram, this controller is an ADC with 3 pin
> > > muxes:
> > > - ADC input mux
> > > - termistor mux chained after ADC mux
> > > - voltage output mux
> > > 
> > > all touchscreen specific code within this driver can be moved to the
> > > resistive-adc-touch, but need some optimization or discussion on how
> > > this should be done properly.   
> > 
> > ok.  There is definitely an argument in favour of generic code.  Whether
> > the method of IIO provider and touch screen driver consumer makes sense
> > is a little less clear but it's certainly a reasonable option.
> >   
> > > > > ---
> > > > > +/*
> > > > > + * Default settling time. This time depends on the:
> > > > > + * - PCB design
> > > > > + * - touch plates size, temperature, etc
> > > > > + * - initial power state of the ADC
> > > > > + *
> > > > > + * Since most values higher than 100us seems to be good, it make sense to
> > > > > + * have some default value. These values were measuring get by testing on a
> > > > > + * PLYM2M board at 2MHz SPI CLK rate.
> > > > > + *
> > > > > + * Sometimes there are extra signal filter capacitors on the touchscreen
> > > > > + * signals, which make it 10 or 100 times worse.    
> > > > 
> > > > Sounds like something that makes sense to expose in dt?    
> > > 
> > > yes. we need to discuss what is the proper place. Is it possible to
> > > grub enough buffers in CPU effective way withing one SPI transfer and
> > > then hand over it to the resistive-adc-touch driver?
> > > 
> > > I placed it within ADC driver for optimization. IMO, proper place should
> > > be resistive-adc-touch driver.  
> > 
> > It isn't that unusual to have a generic ADC that needs some settling time
> > before a good result is obtained, so it might be fine to keep an element of
> > that in the ADC driver, perhaps even defining a standard interface to do
> > it.   It is a somewhat similar requirement to oversampling, just that you
> > drop the first N samples rather than averaging them.  
> 
> ok, sounds good. 
> 
> 
> > > > > +	 */
> > > > > +	if (ret < 0 && ret != -EBUSY) {
> > > > > +		dev_err_ratelimited(dev, "%s: Filed to push scan buffer %pe\n",    
> > > > failed    
> > > > > +				    __func__, ERR_PTR(ret));
> > > > > +
> > > > > +		return ret;
> > > > > +	}
> > > > > +
> > > > > +	return valid ? 0 : -EAGAIN;    
> > > > 
> > > > If not valid, why are we pushing it to the buffer?    
> > > 
> > > The touchscreen driver will classify this buffer as finger-up event.
> > > and the ADC driver need to know it to stop sampling.  
> > 
> > That is a fairly specific thing to do.  Does the existing 
> > touch screen driver do that, or it that a proposed change?  
> 
> existing driver is already doing it, the proposed change change only
> change the way how this information is extracted. The ADC driver needs
> only provide enough samples, so that touchscreen driver can detect it.
> 
Ok. I'm fine with that in the touchscreen side of things.


