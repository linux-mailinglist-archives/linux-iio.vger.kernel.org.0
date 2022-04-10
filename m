Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6844FAE56
	for <lists+linux-iio@lfdr.de>; Sun, 10 Apr 2022 16:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236288AbiDJPBo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 Apr 2022 11:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239516AbiDJPBm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 10 Apr 2022 11:01:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A8B369ED;
        Sun, 10 Apr 2022 07:59:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F85761018;
        Sun, 10 Apr 2022 14:59:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6551BC385A4;
        Sun, 10 Apr 2022 14:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649602770;
        bh=ebOziZA9Caj40n/+Kl1vXjrJRJV4DT3ko2rPxflMVY4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ki0Hzkwwquhe87kylXJgitdKr8nF1vu8smwZUfBVjB0I/5vfjqNNJY9ynSV3nNmIO
         SftHFbjfWeSYOk9JFaz9VMPtgpwVfeky23uokaHuTeaM6mYTd7SwhGoO0S0nYmqIBU
         10UVCfaPRHieIiH94Iewn9CbMdxN4bmYBf5kuCw580XphND7IkYavRkauioEMPS74d
         mH347u3zGSlSA2hzHvBeUyUDKFJcsaqTussEndwDDJkXDE0M+nPR7KLyniILALfn60
         DqHuWuyqK4xLX2thjssKfeuZyyeh3IwLvW9cWRUt5auFyzdDpviAnqiQAIqRBwamXN
         7OxtCyYPix4kA==
Date:   Sun, 10 Apr 2022 16:07:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Chris Morgan <macromorgan@hotmail.com>
Cc:     Artur Rojek <contact@artur-rojek.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chris Morgan <macroalpha82@gmail.com>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] input: adc-joystick: Stop using scan_index for reading
 data
Message-ID: <20220410160720.7f28a2a3@jic23-huawei>
In-Reply-To: <SN6PR06MB5342727A065E9FA2223B6A45A5EB9@SN6PR06MB5342.namprd06.prod.outlook.com>
References: <20220408212857.9583-1-macroalpha82@gmail.com>
        <YlDqTKuo5rbkIL8V@google.com>
        <2941de6570a6f808d6ea6e71d137ef87@artur-rojek.eu>
        <SN6PR06MB5342727A065E9FA2223B6A45A5EB9@SN6PR06MB5342.namprd06.prod.outlook.com>
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

On Sat, 9 Apr 2022 20:39:18 -0500
Chris Morgan <macromorgan@hotmail.com> wrote:

> On Sat, Apr 09, 2022 at 12:08:57PM +0200, Artur Rojek wrote:
> > Hi Chris & Dmitry,
> > 
> > On 2022-04-09 04:07, Dmitry Torokhov wrote:  
> > > Hi Chris,
> > > 
> > > On Fri, Apr 08, 2022 at 04:28:57PM -0500, Chris Morgan wrote:  
> > > > From: Chris Morgan <macromorgan@hotmail.com>
> > > > 
> > > > For my Odroid Go Advance I noticed that the adc-joystick driver was
> > > > only reporting the y channel and on the x axis. After debugging, I
> > > > found that the driver was trying to read values from channels 0 and
> > > > 1 even though my device is using channels 1 and 2. By changing the
> > > > code
> > > > to use the axis index instead of the scan index when unpacking the
> > > > data
> > > > from the buffer, the joystick begins working as expected.  
> > > 
> > > This sounds like some sort of misconfiguration, as your change
> > > effectively removes the ability of using just some ADC channels for
> > > joystick functionality...  
> > 
> > I agree, this sounds like either a case of misconfiguration, or an issue in
> > the ADC driver that this device is using.
> > The axis index corresponds to the iio channel associated with the joystick,
> > but NOT to the order at which data is sampled by ADC.
> > That's why each channel has a `scan_index` field. It sounds like in Chris'
> > case the channels have wrong scan indices.
> > I'd start by verifying that in the ADC driver that is being used.
> > 
> > In any case, this patch is wrong and removes functionality that existing
> > devices depend on.  
> 
> I appreciate the feedback. If this driver is working as expected then
> that means the issue I am experiencing is further up the stack. Based
> on troubleshooting by getting the raw data that the rockchip-saradc
> driver was putting into the triggered buffer and seeing what the
> adc-joystick saw coming out of the triggered buffer I wonder if the
> issue is with the rockchip-saradc driver? I noticed that the buffer
> pushed by the driver's trigger handler would only (appear to) send the
> channels that I was requesting data for. So basically the data buffer
> would have the correct values in [0] and [1], but the adc-joystick
> driver by using the idx would fetch values from [1] for x (which has
> the y axis data) and [2] for y (which would have arbitrary data in
> it, usually something around 65406 or so).
> 
> Do you think I should start looking at the rockchip-saradc driver then?
> Should the saradc be putting stuff in the buffer for every channel with
> empty data for channels that aren't to be reported?

No the ADC driver should be packing the data (actually it may well be
the IIO core doing repacking depending on how clever the ADC in question is).
The joystick driver is too simplistic unfortunately. scan_index is not the index
of the data in the current scan - it is only guaranteed to be monotonic
in the sense that for any given channel it's position will be (packed as
best possible whilst being naturally aligned) after all channels with
lower scan indicies.  scan_index effectively refers to the order of
channels if 'all' channels are enabled.

Hence the driver should work out the ordering from scan_index
but not assume it corresponds to the position of the data
(to make things worse there is no guarantee that the channels have the
same number of bits so that should also be accounted for).

So to take a pathlogical example.  If you have x,y mapping to
scan index 5, 2 then only these two channels will be enabled.
The driver correctly handles the ordering because of the mapping
from channel to access code.  However to find the position
it needs to walk the channels.  It needs to know that 5 is
actually offset by whatever storagebits value the channel with
index 2 has (potentially with additional padding to ensure
we maintainer natural alignment - imagine, e.g. the channel with
scan_index = 2 might be 8 bit and the one with scan_index 5 might
be 16 bit.  In that case you would need to pad so the scan_index
5 channel is 16 bit aligned in the buffer.  If they were the
other way around there would be no padding between the channels.

The ordering of channels from the joystick channel specific bit
of the binding comes from device tree 'reg' value and the ordering
of the IIO map comes from io-channels ordering.  So these should
I think map one to one (without messing around with actual tests
I'm not 100% sure on these two ordering questions).

When the driver then maps all the channels in io-channels they will
in turn have scan_index values (and sizes)  Unfortunately to know
the ordering we'll have to index over them and put them in the
appropriate order.  I'd suggest just storing the resulting
offset in the data buffer during that initial scan so it can
be easily used later.

So some more complexity to handle I'm afraid!

Jonathan

+CC linux-iio as this issue might occur with other consumers - I clearly
haven't been paying close enough attention :(

> 
> Thank you.
> 
> > 
> > Cheers,
> > Artur
> >   
> > > 
> > > Let's add Jonathan and Arthur for their take on this.
> > >   
> > > > 
> > > > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > > > ---
> > > >  drivers/input/joystick/adc-joystick.c | 7 +++----
> > > >  1 file changed, 3 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/drivers/input/joystick/adc-joystick.c
> > > > b/drivers/input/joystick/adc-joystick.c
> > > > index 78ebca7d400a..fe3bbd0d4566 100644
> > > > --- a/drivers/input/joystick/adc-joystick.c
> > > > +++ b/drivers/input/joystick/adc-joystick.c
> > > > @@ -32,24 +32,23 @@ static int adc_joystick_handle(const void *data,
> > > > void *private)
> > > >  {
> > > >  	struct adc_joystick *joy = private;
> > > >  	enum iio_endian endianness;
> > > > -	int bytes, msb, val, idx, i;
> > > > +	int bytes, msb, val, i;
> > > >  	const u16 *data_u16;
> > > >  	bool sign;
> > > > 
> > > >  	bytes = joy->chans[0].channel->scan_type.storagebits >> 3;
> > > > 
> > > >  	for (i = 0; i < joy->num_chans; ++i) {
> > > > -		idx = joy->chans[i].channel->scan_index;
> > > >  		endianness = joy->chans[i].channel->scan_type.endianness;
> > > >  		msb = joy->chans[i].channel->scan_type.realbits - 1;
> > > >  		sign = tolower(joy->chans[i].channel->scan_type.sign) == 's';
> > > > 
> > > >  		switch (bytes) {
> > > >  		case 1:
> > > > -			val = ((const u8 *)data)[idx];
> > > > +			val = ((const u8 *)data)[i];
> > > >  			break;
> > > >  		case 2:
> > > > -			data_u16 = (const u16 *)data + idx;
> > > > +			data_u16 = (const u16 *)data + i;
> > > > 
> > > >  			/*
> > > >  			 * Data is aligned to the sample size by IIO core.
> > > > --
> > > > 2.25.1
> > > >   
> > > 
> > > Thanks.  

