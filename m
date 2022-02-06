Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD994AB11C
	for <lists+linux-iio@lfdr.de>; Sun,  6 Feb 2022 18:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239101AbiBFR7i (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Feb 2022 12:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiBFR7h (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Feb 2022 12:59:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC16C06173B
        for <linux-iio@vger.kernel.org>; Sun,  6 Feb 2022 09:59:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2726611F3
        for <linux-iio@vger.kernel.org>; Sun,  6 Feb 2022 17:59:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89FBEC340E9;
        Sun,  6 Feb 2022 17:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644170375;
        bh=lI7h0XipUgznEkGKixO9M2KcxAqjpgq0F5kCwYtWt+o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lbkK0psPUR1DUKWVLBZvZFolWyOdQuZ2Bipmh2kkMSSYBywsUTg3uVntsrmj85V9k
         z7peDynofjgixlzUfgbCmuCUTzQeypCQi6n5Y69oN+Yo1DulRznxr7g2+lyc+VjeuI
         /rYn37mhnmt+3EDGKwVQ8GGjzJrGkeCTrO7IRw6NkbvQBO0FcdObCwUBYnaX70uVBf
         USzUjNtXrkE6oQ1da1vLcrm3suo9Lgs3iruyNbaMTipPGwbh4omG9z1pFJsOD6vYgx
         6EyNMG6/ZnQbHJ+fnlXXKAEpl5UIXWxrrIjGpR4lSsewlu04Azkf80srF3hmrD0ld+
         NOs9gcrsCaMpw==
Date:   Sun, 6 Feb 2022 18:06:07 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     linux-iio@vger.kernel.org, Nuno Sa <Nuno.Sa@analog.com>,
        lars@metafoo.de, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH v2 14/17] staging:iio:adc:ad7280a: Use device properties
 to replace platform data.
Message-ID: <20220206180607.65af4b76@jic23-huawei>
In-Reply-To: <20220130202459.00a1be01@jic23-huawei>
References: <20211205202710.2847005-1-jic23@kernel.org>
        <20211205202710.2847005-15-jic23@kernel.org>
        <Yb5NcvGuaauOHBXe@marsc.168.1.7>
        <20220130202459.00a1be01@jic23-huawei>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 30 Jan 2022 20:24:59 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sat, 18 Dec 2021 18:06:58 -0300
> Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:
> 
> > Removing AUX channels from alert detection is a bit tricky.
> > According to a note from datasheet page 27:
> > To remove AUX5 or AUX5 and AUX3 from the alert detection, conversions on
> > three auxiliary ADC input channels only must be selected in the control register.  
> 
> Hmm. Always hide the important stuff in foot notes. I missed that entirely it seems
> though honestly I can only vaguely remember how this works at all.
> 
> > 
> > We can check the AUX alert configuration and write to control register HB at
> > probe but it would not last for long since every other device read sets D15:D14
> > to 0x00 again. Can't think of any reasonable way to ensure only AUX1,3,5 without
> > keeping ctrl_hb again. However, AUX selection should not bother if we drop AUX
> > alert removal support for now.  
> 
> Agreed. This is a pain.  Dropping the support is probably a better plan than
> getting stuck figuring this out.  I'll give it a bit more thought when I get
> back to this driver properly.

I'm going to add an extra patch to drop this support - mostly to give us
a clear description of why it is dropped.

I just checked the original code and that never supported the mode
to read 1,3 and 5 either so we aren't making anything worse by just
dropping the pretence of it being supported.

I also just realised I haven't been cc'ing Michael on the series and
definitely should have been! Sorry about that Michael.  I'm guessing 
you can't recall this subtle detail from many years ago though!

> 
> > 
> > Few other bits and thoughts inline.
> > 
> > On 12/05, Jonathan Cameron wrote:  
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > 
> > > Convert all the device specific info that was previously in platform data
> > > over to generic firmware query interfaces.
> > > 
> > > dt-bindings to follow shortly.
> > > 
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > ---
> > >  drivers/staging/iio/adc/ad7280a.c | 100 +++++++++++++++++++++++++-----
> > >  drivers/staging/iio/adc/ad7280a.h |  31 ---------
> > >  2 files changed, 86 insertions(+), 45 deletions(-)
> > > 
> > > diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> > > index acaae1b33986..0806238debe3 100644
> > > --- a/drivers/staging/iio/adc/ad7280a.c
> > > +++ b/drivers/staging/iio/adc/ad7280a.c
> > > @@ -23,8 +23,6 @@
> > >  #include <linux/iio/events.h>
> > >  #include <linux/iio/iio.h>
> > >  
> > > -#include "ad7280a.h"
> > > -
> > >  /* Registers */
> > >  
> > >  #define AD7280A_CELL_VOLTAGE_1_REG		0x0  /* D11 to D0, Read only */
> > > @@ -81,6 +79,11 @@
> > >  #define AD7280A_AUX_ADC_UNDERVOLTAGE_REG	0x12 /* D7 to D0, Read/write */
> > >  
> > >  #define AD7280A_ALERT_REG			0x13 /* D7 to D0, Read/write */
> > > +#define   AD7280A_ALERT_REMOVE_MSK			GENMASK(3, 0)
> > > +#define     AD7280A_ALERT_REMOVE_AUX5			BIT(0)
> > > +#define     AD7280A_ALERT_REMOVE_AUX4_AUX5		BIT(1)    
> > typo, according to datasheet this bit disables AUX5 and AUX3 so it would be
> > #define     AD7280A_ALERT_REMOVE_AUX3_AUX5		BIT(1)  
> 
> Ah.  I'd missed that which rather makes a mess of using the 'last' channel
> in the dt binding.  Will need a rethink.  Sometimes if feels like the
> hardware folks design this stuff just to make it hard to put a nice
> simple software description in place!
> 
> >   
> > > +#define     AD7280A_ALERT_REMOVE_VIN5			BIT(2)
> > > +#define     AD7280A_ALERT_REMOVE_VIN4_VIN5		BIT(3)
> > >  #define   AD7280A_ALERT_GEN_STATIC_HIGH			BIT(6)
> > >  #define   AD7280A_ALERT_RELAY_SIG_CHAIN_DOWN		(BIT(7) | BIT(6))
> > >  
> > > @@ -163,6 +166,8 @@ static unsigned int ad7280a_devaddr(unsigned int addr)
> > >  struct ad7280_state {
> > >  	struct spi_device		*spi;
> > >  	struct iio_chan_spec		*channels;
> > > +	unsigned int			chain_last_alert_ignore;
> > > +	bool				thermistor_term_en;
> > >  	int				slave_num;
> > >  	int				scan_cnt;
> > >  	int				readback_delay_us;
> > > @@ -932,14 +937,8 @@ static const struct iio_info ad7280_info_no_irq = {
> > >  	.write_event_value = &ad7280a_write_thresh,
> > >  };
> > >  
> > > -static const struct ad7280_platform_data ad7793_default_pdata = {
> > > -	.acquisition_time = AD7280A_ACQ_TIME_400ns,
> > > -	.thermistor_term_en = true,
> > > -};
> > > -
> > >  static int ad7280_probe(struct spi_device *spi)
> > >  {
> > > -	const struct ad7280_platform_data *pdata = dev_get_platdata(&spi->dev);
> > >  	struct device *dev = &spi->dev;
> > >  	struct ad7280_state *st;
> > >  	int ret;
> > > @@ -954,17 +953,90 @@ static int ad7280_probe(struct spi_device *spi)
> > >  	st->spi = spi;
> > >  	mutex_init(&st->lock);
> > >  
> > > -	if (!pdata)
> > > -		pdata = &ad7793_default_pdata;
> > > +	st->thermistor_term_en =
> > > +		device_property_read_bool(dev, "adi,thermistor-termination");
> > > +
> > > +	if (device_property_present(dev, "adi,acquistion-time-ns")) {    
> > typo, adi,acquistion-time-ns -> adi,acquisition-time-ns
> >   
> > > +		u32 val;
> > > +
> > > +		ret = device_property_read_u32(dev, "adi,acquisition-time-ns", &val);
> > > +		if (ret)
> > > +			return ret;
> > > +
> > > +		switch (val) {
> > > +		case 400:
> > > +			st->acquisition_time = AD7280A_CTRL_LB_ACQ_TIME_400ns;
> > > +			break;
> > > +		case 800:
> > > +			st->acquisition_time = AD7280A_CTRL_LB_ACQ_TIME_800ns;
> > > +			break;
> > > +		case 1200:
> > > +			st->acquisition_time = AD7280A_CTRL_LB_ACQ_TIME_1200ns;
> > > +			break;
> > > +		case 1600:
> > > +			st->acquisition_time = AD7280A_CTRL_LB_ACQ_TIME_1600ns;
> > > +			break;
> > > +		default:
> > > +			dev_err(dev, "Firmware provided acquisition time is invalid\n");
> > > +			return -EINVAL;
> > > +		}
> > > +	} else {
> > > +		st->acquisition_time = AD7280A_CTRL_LB_ACQ_TIME_400ns;
> > > +	}
> > > +
> > > +	/* Alert masks are intended for when particular inputs are not wired up */
> > > +	if (device_property_present(dev, "adi,voltage-alert-last-chan")) {
> > > +		u8 val;
> > >  
> > > +		ret = device_property_read_u8(dev, "adi,voltage-alert-last-chan", &val);    
> > I added some extra configuration to the ad7280a qemu emulation stuff to test
> > cases where we would have voltage and temperature channels removed from alert
> > generation. On my setup, these device_property_read_u8 reads gave me zeros all
> > the time while the u32 reads gave me the expected values.
> > Not sure if this is something with qemu or even some misconfiguration from my side.
> > Would be good if someone else could check it out.  
> 
> I'll check it out.  Thanks for the heads up that it might be an issue.
> Digging in the implementation it looks like it might need a specific format
> for the device property.
> https://elixir.bootlin.com/linux/latest/source/include/linux/of.h#L439
> 
> ``property = /bits/ 8 <0x50 0x60 0x70>;`
> 
> So it might be that. Given we don't care better to just use
> 32 bit reads.
I've changed them all to 32 bit reads.

Thanks,

Jonathan
