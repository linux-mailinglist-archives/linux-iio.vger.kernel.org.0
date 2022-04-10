Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A054FAF50
	for <lists+linux-iio@lfdr.de>; Sun, 10 Apr 2022 19:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbiDJRhl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 Apr 2022 13:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiDJRhj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 10 Apr 2022 13:37:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3A628E12;
        Sun, 10 Apr 2022 10:35:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 297DE61141;
        Sun, 10 Apr 2022 17:35:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7DEDC385A1;
        Sun, 10 Apr 2022 17:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649612127;
        bh=Rg333jaCmUAY2Cl9e+LiJP2hnhlhivhPlhCbYLFKB2s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hkvw53vp8CkRnFj1jnL/3EUeFL4i142GL21W4MGmi/4km9Jp7oFV9jfD1g9boCldO
         YQsAbn02p5IVd9/WFUFybmTkN38EdqbSdOUo9tnkNJmVXciSGVsgZN6R70zOG7dE/g
         JuTHEnukkFiVUaYnfzMoo+tX4b1tAR0w1qi5igcxVhwrw9EW7qBNq1hL/BeLLoaJRb
         p8HIKdCqYXBv/c7Mu2o/wF08k93XIra0Pk/mvdrxxjAleqiYKRLGiZ5XhYF+COmu5l
         QnOBSNr8rvncqNmznR0bjtnpfQoBmQF+eazd8niCQnzTLb4L2hq4MvtULk9sS1cckf
         uZuVqOQZPcYVQ==
Date:   Sun, 10 Apr 2022 18:43:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Chris Morgan <macromorgan@hotmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chris Morgan <macroalpha82@gmail.com>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] input: adc-joystick: Stop using scan_index for reading
 data
Message-ID: <20220410184318.53c0de04@jic23-huawei>
In-Reply-To: <c7ace6661c11183586420b431adb6bab@artur-rojek.eu>
References: <20220408212857.9583-1-macroalpha82@gmail.com>
        <YlDqTKuo5rbkIL8V@google.com>
        <2941de6570a6f808d6ea6e71d137ef87@artur-rojek.eu>
        <SN6PR06MB5342727A065E9FA2223B6A45A5EB9@SN6PR06MB5342.namprd06.prod.outlook.com>
        <c7ace6661c11183586420b431adb6bab@artur-rojek.eu>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
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

On Sun, 10 Apr 2022 16:58:48 +0200
Artur Rojek <contact@artur-rojek.eu> wrote:

> On 2022-04-10 03:39, Chris Morgan wrote:
> > On Sat, Apr 09, 2022 at 12:08:57PM +0200, Artur Rojek wrote:  
> >> Hi Chris & Dmitry,
> >> 
> >> On 2022-04-09 04:07, Dmitry Torokhov wrote:  
> >> > Hi Chris,
> >> >
> >> > On Fri, Apr 08, 2022 at 04:28:57PM -0500, Chris Morgan wrote:  
> >> > > From: Chris Morgan <macromorgan@hotmail.com>
> >> > >
> >> > > For my Odroid Go Advance I noticed that the adc-joystick driver was
> >> > > only reporting the y channel and on the x axis. After debugging, I
> >> > > found that the driver was trying to read values from channels 0 and
> >> > > 1 even though my device is using channels 1 and 2. By changing the
> >> > > code
> >> > > to use the axis index instead of the scan index when unpacking the
> >> > > data
> >> > > from the buffer, the joystick begins working as expected.  
> >> >
> >> > This sounds like some sort of misconfiguration, as your change
> >> > effectively removes the ability of using just some ADC channels for
> >> > joystick functionality...  
> >> 
> >> I agree, this sounds like either a case of misconfiguration, or an 
> >> issue in
> >> the ADC driver that this device is using.
> >> The axis index corresponds to the iio channel associated with the 
> >> joystick,
> >> but NOT to the order at which data is sampled by ADC.
> >> That's why each channel has a `scan_index` field. It sounds like in 
> >> Chris'
> >> case the channels have wrong scan indices.
> >> I'd start by verifying that in the ADC driver that is being used.
> >> 
> >> In any case, this patch is wrong and removes functionality that 
> >> existing
> >> devices depend on.  
> > 
> > I appreciate the feedback. If this driver is working as expected then
> > that means the issue I am experiencing is further up the stack. Based
> > on troubleshooting by getting the raw data that the rockchip-saradc
> > driver was putting into the triggered buffer and seeing what the
> > adc-joystick saw coming out of the triggered buffer I wonder if the
> > issue is with the rockchip-saradc driver? I noticed that the buffer
> > pushed by the driver's trigger handler would only (appear to) send the
> > channels that I was requesting data for. So basically the data buffer
> > would have the correct values in [0] and [1], but the adc-joystick
> > driver by using the idx would fetch values from [1] for x (which has
> > the y axis data) and [2] for y (which would have arbitrary data in
> > it, usually something around 65406 or so).
> > 
> > Do you think I should start looking at the rockchip-saradc driver then?
> > Should the saradc be putting stuff in the buffer for every channel with
> > empty data for channels that aren't to be reported?
> > 
> > Thank you.  
> 
> Chris,
> 
> I analyzed the IIO core code some more and I think you are correct in 
> your assessment.
> The data buffer that `adc-joystick` receives will be the length of all 
> the *active* channels combined.
> That would mean scan index specifies the order of the channels by which 
> they appear in the buffer, NOT their offsets in it.
> 
> That said, we can't rely on channel order from `joy->chans = 
> devm_iio_channel_get_all(dev);`,
> as channels might have out-of-order scan indices and thus this sequence 
> can't be used to iterate the buffer.
> I think the best approach would be to add an IIO helper to find a 
> channel offset in a buffer.
> Say, something like this:
> 
> ```
> --- a/drivers/iio/buffer/industrialio-buffer-cb.c
> +++ b/drivers/iio/buffer/industrialio-buffer-cb.c
> @@ -151,6 +151,27 @@ struct iio_dev
>   }
>   EXPORT_SYMBOL_GPL(iio_channel_cb_get_iio_dev);
> 
> +int iio_find_channel_offset_in_buffer(const struct iio_channel 
> *channel,
> +                                     struct iio_cb_buffer *buffer)
> +{
> +       const struct iio_chan_spec *chan = channel->channel;
> +       struct iio_dev *indio_dev = channel->indio_dev;
> +       struct iio_buffer *buf = &buffer->buffer;
> +       int ind, i = 0;
> +
> +       if (chan->scan_index < 0)
> +               return -EINVAL;
> +
> +       for_each_set_bit(ind, buf->scan_mask, indio_dev->masklength) {
> +               if (ind == chan->scan_index)
> +                       return i;
> +               ++i;
> +       }
> +
> +       return -EINVAL;
> +}
> +EXPORT_SYMBOL_GPL(iio_find_channel_offset_in_buffer);

Almost.  You need to take into account the size of each
channel and the alignment rules as well (everything is naturally
aligned) which will unfortunately require searching the channel
list for each channel with a scan_index below this one.

Useful function to hav so I'm in favour of adding something like
this it will just need to also take the iio_dev to get access to the
sizes of other channels.

Note similar code occurs in iio_buffer_update_demux() (though what you need
here is thankfully rather simpler). 

We have iio_storage_bytes_for_si() to make things a bit simpler as it'll
do the reverse lookups for you. 
You'll need to export some of the utility functions.

However, I'd put this in a more generic location as it's potentially useful
for cases other than callback buffers and that should reduce what you need
to export.  Probably put it in industrialio-buffer.c / iio/buffer.h




> +
> ```
> 
> ...and then the only change in `adc-joystick` has to be:
> 
> ```
> --- a/drivers/input/joystick/adc-joystick.c
> +++ b/drivers/input/joystick/adc-joystick.c
> @@ -39,10 +39,13 @@ static int adc_joystick_handle(const void *data, 
> void *private)
>          bytes = joy->chans[0].channel->scan_type.storagebits >> 3;
> 
>          for (i = 0; i < joy->num_chans; ++i) {
> -               idx = joy->chans[i].channel->scan_index;
>                  endianness = 
> joy->chans[i].channel->scan_type.endianness;
>                  msb = joy->chans[i].channel->scan_type.realbits - 1;
>                  sign = tolower(joy->chans[i].channel->scan_type.sign) == 
> 's';
> +               idx = iio_find_channel_offset_in_buffer(&joy->chans[i],
> +                                                       joy->buffer);
> +               if (idx < 0)
> +                       return idx;
> 
>                  switch (bytes) {
>                  case 1:
> ```
> 
> On a side note, this potentially uncovered an issue in an unrelated 
> `ingenic-adc` driver,
> where data pushed into the buffer is always the size of all the 
> available channels, not just active ones.

That would be fine, if it were also setting available_scan_masks as then
the IIO core would repack only the requested channels (which is
what that update_demux mentioned earlier sets up).

However, given the driver is doing readl() only for the channels
that are enabled, it probably makes more sense to pack them correctly.

Jonathan


> I was using that driver while writing `adc-joystick`, which explains why 
> I never encountered your problem.
> 
> With all that said, let's wait for Jonathan to speak out before we 
> proceed with v2.
> 
> Cheers,
> Artur
> 
> >   
> >> 
> >> Cheers,
> >> Artur
> >>   
> >> >
> >> > Let's add Jonathan and Arthur for their take on this.
> >> >  
> >> > >
> >> > > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> >> > > ---
> >> > >  drivers/input/joystick/adc-joystick.c | 7 +++----
> >> > >  1 file changed, 3 insertions(+), 4 deletions(-)
> >> > >
> >> > > diff --git a/drivers/input/joystick/adc-joystick.c
> >> > > b/drivers/input/joystick/adc-joystick.c
> >> > > index 78ebca7d400a..fe3bbd0d4566 100644
> >> > > --- a/drivers/input/joystick/adc-joystick.c
> >> > > +++ b/drivers/input/joystick/adc-joystick.c
> >> > > @@ -32,24 +32,23 @@ static int adc_joystick_handle(const void *data,
> >> > > void *private)
> >> > >  {
> >> > >  	struct adc_joystick *joy = private;
> >> > >  	enum iio_endian endianness;
> >> > > -	int bytes, msb, val, idx, i;
> >> > > +	int bytes, msb, val, i;
> >> > >  	const u16 *data_u16;
> >> > >  	bool sign;
> >> > >
> >> > >  	bytes = joy->chans[0].channel->scan_type.storagebits >> 3;
> >> > >
> >> > >  	for (i = 0; i < joy->num_chans; ++i) {
> >> > > -		idx = joy->chans[i].channel->scan_index;
> >> > >  		endianness = joy->chans[i].channel->scan_type.endianness;
> >> > >  		msb = joy->chans[i].channel->scan_type.realbits - 1;
> >> > >  		sign = tolower(joy->chans[i].channel->scan_type.sign) == 's';
> >> > >
> >> > >  		switch (bytes) {
> >> > >  		case 1:
> >> > > -			val = ((const u8 *)data)[idx];
> >> > > +			val = ((const u8 *)data)[i];
> >> > >  			break;
> >> > >  		case 2:
> >> > > -			data_u16 = (const u16 *)data + idx;
> >> > > +			data_u16 = (const u16 *)data + i;
> >> > >
> >> > >  			/*
> >> > >  			 * Data is aligned to the sample size by IIO core.
> >> > > --
> >> > > 2.25.1
> >> > >  
> >> >
> >> > Thanks.  

