Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E7D4FE62C
	for <lists+linux-iio@lfdr.de>; Tue, 12 Apr 2022 18:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbiDLQrM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 Apr 2022 12:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbiDLQrK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Apr 2022 12:47:10 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B111F1B790;
        Tue, 12 Apr 2022 09:44:51 -0700 (PDT)
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KdBM04QPsz67QRR;
        Wed, 13 Apr 2022 00:41:32 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Apr 2022 18:44:49 +0200
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 12 Apr
 2022 17:44:48 +0100
Date:   Tue, 12 Apr 2022 17:44:47 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Chris Morgan <macromorgan@hotmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Artur Rojek <contact@artur-rojek.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chris Morgan <macroalpha82@gmail.com>,
        <linux-input@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] input: adc-joystick: Stop using scan_index for reading
 data
Message-ID: <20220412174447.000065bd@Huawei.com>
In-Reply-To: <SN6PR06MB5342FF9387BAE6EDD12CDC7DA5EA9@SN6PR06MB5342.namprd06.prod.outlook.com>
References: <20220408212857.9583-1-macroalpha82@gmail.com>
        <YlDqTKuo5rbkIL8V@google.com>
        <2941de6570a6f808d6ea6e71d137ef87@artur-rojek.eu>
        <SN6PR06MB5342727A065E9FA2223B6A45A5EB9@SN6PR06MB5342.namprd06.prod.outlook.com>
        <c7ace6661c11183586420b431adb6bab@artur-rojek.eu>
        <20220410184318.53c0de04@jic23-huawei>
        <SN6PR06MB5342FF9387BAE6EDD12CDC7DA5EA9@SN6PR06MB5342.namprd06.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml719-chm.china.huawei.com (10.201.108.70) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 11 Apr 2022 17:07:17 -0500
Chris Morgan <macromorgan@hotmail.com> wrote:

> On Sun, Apr 10, 2022 at 06:43:18PM +0100, Jonathan Cameron wrote:
> > On Sun, 10 Apr 2022 16:58:48 +0200
> > Artur Rojek <contact@artur-rojek.eu> wrote:
> >   
> > > On 2022-04-10 03:39, Chris Morgan wrote:  
> > > > On Sat, Apr 09, 2022 at 12:08:57PM +0200, Artur Rojek wrote:    
> > > >> Hi Chris & Dmitry,
> > > >> 
> > > >> On 2022-04-09 04:07, Dmitry Torokhov wrote:    
> > > >> > Hi Chris,
> > > >> >
> > > >> > On Fri, Apr 08, 2022 at 04:28:57PM -0500, Chris Morgan wrote:    
> > > >> > > From: Chris Morgan <macromorgan@hotmail.com>
> > > >> > >
> > > >> > > For my Odroid Go Advance I noticed that the adc-joystick driver was
> > > >> > > only reporting the y channel and on the x axis. After debugging, I
> > > >> > > found that the driver was trying to read values from channels 0 and
> > > >> > > 1 even though my device is using channels 1 and 2. By changing the
> > > >> > > code
> > > >> > > to use the axis index instead of the scan index when unpacking the
> > > >> > > data
> > > >> > > from the buffer, the joystick begins working as expected.    
> > > >> >
> > > >> > This sounds like some sort of misconfiguration, as your change
> > > >> > effectively removes the ability of using just some ADC channels for
> > > >> > joystick functionality...    
> > > >> 
> > > >> I agree, this sounds like either a case of misconfiguration, or an 
> > > >> issue in
> > > >> the ADC driver that this device is using.
> > > >> The axis index corresponds to the iio channel associated with the 
> > > >> joystick,
> > > >> but NOT to the order at which data is sampled by ADC.
> > > >> That's why each channel has a `scan_index` field. It sounds like in 
> > > >> Chris'
> > > >> case the channels have wrong scan indices.
> > > >> I'd start by verifying that in the ADC driver that is being used.
> > > >> 
> > > >> In any case, this patch is wrong and removes functionality that 
> > > >> existing
> > > >> devices depend on.    
> > > > 
> > > > I appreciate the feedback. If this driver is working as expected then
> > > > that means the issue I am experiencing is further up the stack. Based
> > > > on troubleshooting by getting the raw data that the rockchip-saradc
> > > > driver was putting into the triggered buffer and seeing what the
> > > > adc-joystick saw coming out of the triggered buffer I wonder if the
> > > > issue is with the rockchip-saradc driver? I noticed that the buffer
> > > > pushed by the driver's trigger handler would only (appear to) send the
> > > > channels that I was requesting data for. So basically the data buffer
> > > > would have the correct values in [0] and [1], but the adc-joystick
> > > > driver by using the idx would fetch values from [1] for x (which has
> > > > the y axis data) and [2] for y (which would have arbitrary data in
> > > > it, usually something around 65406 or so).
> > > > 
> > > > Do you think I should start looking at the rockchip-saradc driver then?
> > > > Should the saradc be putting stuff in the buffer for every channel with
> > > > empty data for channels that aren't to be reported?
> > > > 
> > > > Thank you.    
> > > 
> > > Chris,
> > > 
> > > I analyzed the IIO core code some more and I think you are correct in 
> > > your assessment.
> > > The data buffer that `adc-joystick` receives will be the length of all 
> > > the *active* channels combined.
> > > That would mean scan index specifies the order of the channels by which 
> > > they appear in the buffer, NOT their offsets in it.
> > > 
> > > That said, we can't rely on channel order from `joy->chans = 
> > > devm_iio_channel_get_all(dev);`,
> > > as channels might have out-of-order scan indices and thus this sequence 
> > > can't be used to iterate the buffer.
> > > I think the best approach would be to add an IIO helper to find a 
> > > channel offset in a buffer.
> > > Say, something like this:
> > > 
> > > ```
> > > --- a/drivers/iio/buffer/industrialio-buffer-cb.c
> > > +++ b/drivers/iio/buffer/industrialio-buffer-cb.c
> > > @@ -151,6 +151,27 @@ struct iio_dev
> > >   }
> > >   EXPORT_SYMBOL_GPL(iio_channel_cb_get_iio_dev);
> > > 
> > > +int iio_find_channel_offset_in_buffer(const struct iio_channel 
> > > *channel,
> > > +                                     struct iio_cb_buffer *buffer)
> > > +{
> > > +       const struct iio_chan_spec *chan = channel->channel;
> > > +       struct iio_dev *indio_dev = channel->indio_dev;
> > > +       struct iio_buffer *buf = &buffer->buffer;
> > > +       int ind, i = 0;
> > > +
> > > +       if (chan->scan_index < 0)
> > > +               return -EINVAL;
> > > +
> > > +       for_each_set_bit(ind, buf->scan_mask, indio_dev->masklength) {
> > > +               if (ind == chan->scan_index)
> > > +                       return i;
> > > +               ++i;
> > > +       }
> > > +
> > > +       return -EINVAL;
> > > +}
> > > +EXPORT_SYMBOL_GPL(iio_find_channel_offset_in_buffer);  
> > 
> > Almost.  You need to take into account the size of each
> > channel and the alignment rules as well (everything is naturally
> > aligned) which will unfortunately require searching the channel
> > list for each channel with a scan_index below this one.
> > 
> > Useful function to hav so I'm in favour of adding something like
> > this it will just need to also take the iio_dev to get access to the
> > sizes of other channels.
> > 
> > Note similar code occurs in iio_buffer_update_demux() (though what you need
> > here is thankfully rather simpler). 
> > 
> > We have iio_storage_bytes_for_si() to make things a bit simpler as it'll
> > do the reverse lookups for you. 
> > You'll need to export some of the utility functions.
> > 
> > However, I'd put this in a more generic location as it's potentially useful
> > for cases other than callback buffers and that should reduce what you need
> > to export.  Probably put it in industrialio-buffer.c / iio/buffer.h
> >   
> 
> Forgive me for being new to the iio subsystem, but how can I find out
> the alignment? Is it simply a matter of assuming the largest value is
> always the size of the alignment (meaning if we have a single channel
> enabled with a 2 byte value all channels are 2 bytes in size, even
> if the channel itself only reports 1 byte of data?
No each channel is naturally aligned after the earlier channels.
(Short of oddiities around x86_32) it's the same as alignment in a c structure
containing only the channels that are enabled.

So lets take an example.
Channel 0 - 16 bits.
Channel 1 - 8 bits
Channel 2 - 16 bits
channel 3 - 64 bits (usually timestamp.

If all enabled, then we end up with
0         2         3     4          6     8           16
[channel 0|channel 1|  pad|channel 2 | pad | channel 3 |


If only 0 and 2
0          2           4
|channel 0 | channels 2|

If only 0 and 3
0          2                             8          16
| channel 0|  Lots of padding            | channel 3 |

etc.

> 
> So if I understand correctly we need a helper function that translates
> the scan index (the channel?) into the joystick index, and by doing
> so we need to find the offset of each byte in the data buffer.

No. Translates the scan index to an offset into the buffer. Index is
not sufficient because it depends on what other channels are enabled.

> 
> So basically a helper function that does the following for a given
> buffer/channel:
> 
> - Gets the channels that are enabled (presume from the buffer
> scan_mask).
> - Identifies the data size of each channel.
> - Sets the offset size to the largest value for the channel size.

Nope. As above.

> - Returns the offset for the given channel in the buffer.
> 
> Then, in the adc-joystick driver we can store this offset in the
> driver data for each axis so we know exactly where in the buffer
> this data is.
> 
> Does that sound about right? Or am I way off?

More complex than that. Because of the alignment requirements.

> 
> (also, completely unrelated but while I have a captive audience, is
> there an easy way to either send a single trigger or set up a trigger
> for a given driver?
> I'd like to add a polling function to this and
> I'm trying to find the correct way to do it, but so far I've only
> found a userspace way to use an hrtimer set up via sysfs, I'd like
> to make it a driver option if I can).

You can set a trigger in code using iio_trigger_get() though we have
provision for using hrtimer triggers this way. I vaguely
recall a driver that provides both the trigger and acts as a consumer
it might be the potentiostat/lmp910000


Jonathan


> 
> Thank you very much!
> 
> > 
> > 
> >   
> > > +
> > > ```
> > > 
> > > ...and then the only change in `adc-joystick` has to be:
> > > 
> > > ```
> > > --- a/drivers/input/joystick/adc-joystick.c
> > > +++ b/drivers/input/joystick/adc-joystick.c
> > > @@ -39,10 +39,13 @@ static int adc_joystick_handle(const void *data, 
> > > void *private)
> > >          bytes = joy->chans[0].channel->scan_type.storagebits >> 3;
> > > 
> > >          for (i = 0; i < joy->num_chans; ++i) {
> > > -               idx = joy->chans[i].channel->scan_index;
> > >                  endianness = 
> > > joy->chans[i].channel->scan_type.endianness;
> > >                  msb = joy->chans[i].channel->scan_type.realbits - 1;
> > >                  sign = tolower(joy->chans[i].channel->scan_type.sign) == 
> > > 's';
> > > +               idx = iio_find_channel_offset_in_buffer(&joy->chans[i],
> > > +                                                       joy->buffer);
> > > +               if (idx < 0)
> > > +                       return idx;
> > > 
> > >                  switch (bytes) {
> > >                  case 1:
> > > ```
> > > 
> > > On a side note, this potentially uncovered an issue in an unrelated 
> > > `ingenic-adc` driver,
> > > where data pushed into the buffer is always the size of all the 
> > > available channels, not just active ones.  
> > 
> > That would be fine, if it were also setting available_scan_masks as then
> > the IIO core would repack only the requested channels (which is
> > what that update_demux mentioned earlier sets up).
> > 
> > However, given the driver is doing readl() only for the channels
> > that are enabled, it probably makes more sense to pack them correctly.
> > 
> > Jonathan
> > 
> >   
> > > I was using that driver while writing `adc-joystick`, which explains why 
> > > I never encountered your problem.
> > > 
> > > With all that said, let's wait for Jonathan to speak out before we 
> > > proceed with v2.
> > > 
> > > Cheers,
> > > Artur
> > >   
> > > >     
> > > >> 
> > > >> Cheers,
> > > >> Artur
> > > >>     
> > > >> >
> > > >> > Let's add Jonathan and Arthur for their take on this.
> > > >> >    
> > > >> > >
> > > >> > > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > > >> > > ---
> > > >> > >  drivers/input/joystick/adc-joystick.c | 7 +++----
> > > >> > >  1 file changed, 3 insertions(+), 4 deletions(-)
> > > >> > >
> > > >> > > diff --git a/drivers/input/joystick/adc-joystick.c
> > > >> > > b/drivers/input/joystick/adc-joystick.c
> > > >> > > index 78ebca7d400a..fe3bbd0d4566 100644
> > > >> > > --- a/drivers/input/joystick/adc-joystick.c
> > > >> > > +++ b/drivers/input/joystick/adc-joystick.c
> > > >> > > @@ -32,24 +32,23 @@ static int adc_joystick_handle(const void *data,
> > > >> > > void *private)
> > > >> > >  {
> > > >> > >  	struct adc_joystick *joy = private;
> > > >> > >  	enum iio_endian endianness;
> > > >> > > -	int bytes, msb, val, idx, i;
> > > >> > > +	int bytes, msb, val, i;
> > > >> > >  	const u16 *data_u16;
> > > >> > >  	bool sign;
> > > >> > >
> > > >> > >  	bytes = joy->chans[0].channel->scan_type.storagebits >> 3;
> > > >> > >
> > > >> > >  	for (i = 0; i < joy->num_chans; ++i) {
> > > >> > > -		idx = joy->chans[i].channel->scan_index;
> > > >> > >  		endianness = joy->chans[i].channel->scan_type.endianness;
> > > >> > >  		msb = joy->chans[i].channel->scan_type.realbits - 1;
> > > >> > >  		sign = tolower(joy->chans[i].channel->scan_type.sign) == 's';
> > > >> > >
> > > >> > >  		switch (bytes) {
> > > >> > >  		case 1:
> > > >> > > -			val = ((const u8 *)data)[idx];
> > > >> > > +			val = ((const u8 *)data)[i];
> > > >> > >  			break;
> > > >> > >  		case 2:
> > > >> > > -			data_u16 = (const u16 *)data + idx;
> > > >> > > +			data_u16 = (const u16 *)data + i;
> > > >> > >
> > > >> > >  			/*
> > > >> > >  			 * Data is aligned to the sample size by IIO core.
> > > >> > > --
> > > >> > > 2.25.1
> > > >> > >    
> > > >> >
> > > >> > Thanks.    
> >   

