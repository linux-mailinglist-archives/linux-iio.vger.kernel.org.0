Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827434FC759
	for <lists+linux-iio@lfdr.de>; Tue, 12 Apr 2022 00:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348846AbiDKWJj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Apr 2022 18:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346790AbiDKWJi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Apr 2022 18:09:38 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2096.outbound.protection.outlook.com [40.92.20.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675B42126B;
        Mon, 11 Apr 2022 15:07:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKCv2WrpmCWhhKVQ0cQMdjhfED9eb53yvmVuUDuTB8W7jsg04vSje1SCaggDoUUucDH4g+sGAd3sBxXHNbscvQ5k89YTCU6YRHrYPSHja28nLvwvabVJug1CAUDm5iQdv87RTLQp/pNlJv0ZAbjeSkBvB/AxON23IKPbyZcNIbqd0onW/32/mfdatSpd5syiZHKhHLVLfqSOQwjK5M4A8KySkyiD4tS3qVpCNRJk7p7KtbbGvW0FZCGs+sYFn1qqzZo64WbqbopswWCuuSqVvQzyF/meWoVXhKWPFtF7wRLKXhffVYXFHUuZQ4uLmMkiasXCibHjj2BvD005ANgBJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=636hNLiu+iZsnwiHmo4dBnfP0CUOleJInEees7Em+fA=;
 b=Z8XuvSwcno9G4DppsrlYT8UsL9gYvfC0NOABWkiitY0Ugx/OsZqUzROABtLQ2IM6c/y28kkmWYkleyHwaDyM3rAVQx5h/C5EYSzD0ju72i9Kli9wFaPKj/gL7NlNStNqVScxB5XdwZkTlTLF7G25hwk7e/YYSl6WIDFmWbonZYIGhZnRw0nmY3aptHY5mDfwxSAbWyN15ePCTlgPvBmGNc6jY4hIzt8oGPPLzOH6LSDPyBf+5tz6CITjsqMLMJvxLIRCOmTRN5+fUwwSPf0TctRgZVfuN5Jn74hrFHhT5aYcdX0O0PgRJ4immZDtoc+tHDiSEbpTyG5ot2opFb6hqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=636hNLiu+iZsnwiHmo4dBnfP0CUOleJInEees7Em+fA=;
 b=NmYTu63dBbznhMX3SJUYM/uHYi58vtxww7kV8mSf2zKzcLwjpKQlly7skJN7l9Q/xpP1A7f6KWl708Eee9fg7YniUHIaG2SVBB3D1mrQsCehXpjd4ZA6y+ZXoAX4/lHC04tIcdiQvUiObXSDtYboao66MSBZTFOvUBpQxtDQrzzo85PKw7909R/uw0VXEFqq86Xa2lolZ24K1FatfpHKUXjpYI76q71mhuoEApe+pNIVOmw9rhlhJGC1wzl7ZxdZl92lxnaA+14GIjSWSLt668FyxkRoaCNbnOXJiTKJRaNULVs1zmh/QWI9gH6fB9K6jS9KqOc/lRe46yW112Sskg==
Received: from SN6PR06MB5342.namprd06.prod.outlook.com (2603:10b6:805:f9::31)
 by MW4PR06MB8900.namprd06.prod.outlook.com (2603:10b6:303:1b3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 22:07:20 +0000
Received: from SN6PR06MB5342.namprd06.prod.outlook.com
 ([fe80::f8ff:e4be:c1d6:35f8]) by SN6PR06MB5342.namprd06.prod.outlook.com
 ([fe80::f8ff:e4be:c1d6:35f8%4]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 22:07:20 +0000
Date:   Mon, 11 Apr 2022 17:07:17 -0500
From:   Chris Morgan <macromorgan@hotmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Artur Rojek <contact@artur-rojek.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chris Morgan <macroalpha82@gmail.com>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] input: adc-joystick: Stop using scan_index for reading
 data
Message-ID: <SN6PR06MB5342FF9387BAE6EDD12CDC7DA5EA9@SN6PR06MB5342.namprd06.prod.outlook.com>
References: <20220408212857.9583-1-macroalpha82@gmail.com>
 <YlDqTKuo5rbkIL8V@google.com>
 <2941de6570a6f808d6ea6e71d137ef87@artur-rojek.eu>
 <SN6PR06MB5342727A065E9FA2223B6A45A5EB9@SN6PR06MB5342.namprd06.prod.outlook.com>
 <c7ace6661c11183586420b431adb6bab@artur-rojek.eu>
 <20220410184318.53c0de04@jic23-huawei>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220410184318.53c0de04@jic23-huawei>
X-TMN:  [fstxwY8GX2NOArdQgrWBDG2bsgWpuns6]
X-ClientProxiedBy: SN4PR0501CA0152.namprd05.prod.outlook.com
 (2603:10b6:803:2c::30) To SN6PR06MB5342.namprd06.prod.outlook.com
 (2603:10b6:805:f9::31)
X-Microsoft-Original-Message-ID: <20220411220717.GA18409@wintermute.localdomain>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c962b9e-a139-4a32-2d41-08da1c07a5e8
X-MS-TrafficTypeDiagnostic: MW4PR06MB8900:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bth1zExUlkXDxPvaCDbF/ACsNOc8P8yATVY/E4KdEqpwMa0JySciVV9itJ0I5Cq8Ob+6zKuSMS+rCGsThWkHM48+qDoLrWLJ+q4UdBrkViOi3Xc+Qj9NNRjakKSUNZPRvcgSmodegQ3lW9JLpHm0D2BfW0P8xpiiqvOfMDULSG6Bo2AdYBO89hIdAljZBkP/uYzGqY79xRzJM4AZkDO2YV7XPrYBhZ2jQ9PNSq22/irq3eewbN+K6J+iZB36W6LO3Dcff2/ogLhcZ2KtJlfSdsyNxm3NIs1G1nShleiWWaOxPMvqi8CmyyfT5ZSX7+0gp4yZ+1Fs7DaEoFjebI6STFyhIQpQGghuGAq4aYfklN7RjKDG9CIGpujxb3fgqXRN5HkwJPTcIK3n8HLBZBLKn36P9mKdDZk77PcIrs3SXgtXbEMCdSPYz48CfLzCmR6/bgSUydHHVhSLWtJtG2AkaB/IWT5DBG46bybVAn+uykgmB28tK1KET18iLi6fxDOigFMDkPvb2RfWqzf497KiNHN1MzeHfweBMzMr54sGUbRBPjFBzO2KJlheNoUtNPzOtY3YnEy8xbx+0FXZjXeumg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8jIHJSvUrbrof1wxbp3ZrWTG56TrVmRUT/Wa/w6VI5DcbL+LwGRhCCXOvytQ?=
 =?us-ascii?Q?imeQhqHj6FhJlJLkS4NyalsYUGmC/VYZ+nlkdE4gKVyM1/ZCJMS/yQkM2kfV?=
 =?us-ascii?Q?3jo9xtQ2KW628NKF+J/M99FMRRY67A7FquKvs7ZnlILsAzP6eo52OfXAn32m?=
 =?us-ascii?Q?f4Z6tyfpWNsR6RqO1Sr2bU5JM3ODjoZloTqkhSVeWtVLQZQJR/zmioNNlWqz?=
 =?us-ascii?Q?HDQ8JoUJ2F3qqIWu4SYNvynwVUI154CEmTgGZDRXNe0flcE5YlxJ4tElv5b3?=
 =?us-ascii?Q?8RAtUvQcKvDZ6M5wpw7oKhY3yK8vh5MmYm6kL+5K/t/wwSddpUU8fzSgc0FG?=
 =?us-ascii?Q?ybEMOf1NzU6XwUydkif7m+q10KOUM6NDlGMUrzx7ZySg0mftROFgiUBZwQnp?=
 =?us-ascii?Q?Ot/8m821nwaKd1wf1cz3/ihJFk7/bNClP1c63lLuI5QmE5EAGJDYQZxV14l4?=
 =?us-ascii?Q?JGSNtNR01AiY7FDxvL1NBhbMqRaBYJRH5y/A6EU07Cg5KVzY3EqirbL+jbNj?=
 =?us-ascii?Q?vDTJkRCiiXT6jGmcvHUcB28+k/Q6jMaOTET9uN3me84gEzo0dN4PEwtPKwEi?=
 =?us-ascii?Q?2qiO5sVCuPLO8iSsp0stBiZfee5fpQXSb7tXFvab0JLMb3MFTJo4IxkGkGJP?=
 =?us-ascii?Q?pRHXR5SwGnTfzqg9Soj4T+G+Zr7RnRqBUNN9F2yE/sc/4cJRHKsN5/cNRGBX?=
 =?us-ascii?Q?hJxdagpGG4wIjuwFZ3fTOHgic80h4+r1MMcKYf0MO+O/U6j58K6rE00y7NFT?=
 =?us-ascii?Q?EQBKQE1k5rCDIR5XJ8HpLJaX5regQwbjxtRlD9UGwrmyBdYih0nMPwn6NKlF?=
 =?us-ascii?Q?TvEpYuXRwg4ixTSMhW58oaBCSD5ArkXrY6yHWA0n9vazk7xuCZ8oubR+DPuX?=
 =?us-ascii?Q?PmrKcJfwVMzgXqxp6PLELXTfxK9Bwaj5D+VEWp/Rx+2CetWGIR47SQaxfxlJ?=
 =?us-ascii?Q?M261JNh7GseuEZ6PYOHD26ZyaQjVs07JrVeTc4EuOSCI+2oIAfPNCj8+Sx+2?=
 =?us-ascii?Q?wNse6Yx+s4+HV1wCm1zHzu5brXBvIhgjZkh3pHjGvf077Ds6B45eNIdMVUQX?=
 =?us-ascii?Q?aZMbAeFEoSGReUtZAOEBMP8qBiQtfduMaiqsCIZVrEYc0SClcuZdjLAN8AH/?=
 =?us-ascii?Q?D01Vela27UEQYOUbvh33Upg8MfxwGoNXS2wl7Z8p1XIPftDmWoXU0JcWgbPh?=
 =?us-ascii?Q?xldJyfYhmnak0PFv4tkWl6XL/xqQALJ5Sj4GkB6IxpEnOglBHAgQw/WZ9CLD?=
 =?us-ascii?Q?xphzraD6zX/7zmJ8Gwccb03fmXk8N2xqk99d3ooVPrtPsbBsOEKEBtRYHgUI?=
 =?us-ascii?Q?zyJ1gWKoPwEaEabLPYZrIFD0l8JoXiC9wF+vrz5uvJmM0cvXNF5u37EYdlMS?=
 =?us-ascii?Q?qVKIxr87epnGGmwzROkIkTkKm1++iHLtgCwNawvVFjGwLDHMXSo3gqKid12U?=
 =?us-ascii?Q?KNQxlGp+aK8=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-89723.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c962b9e-a139-4a32-2d41-08da1c07a5e8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR06MB5342.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 22:07:20.5463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR06MB8900
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Apr 10, 2022 at 06:43:18PM +0100, Jonathan Cameron wrote:
> On Sun, 10 Apr 2022 16:58:48 +0200
> Artur Rojek <contact@artur-rojek.eu> wrote:
> 
> > On 2022-04-10 03:39, Chris Morgan wrote:
> > > On Sat, Apr 09, 2022 at 12:08:57PM +0200, Artur Rojek wrote:  
> > >> Hi Chris & Dmitry,
> > >> 
> > >> On 2022-04-09 04:07, Dmitry Torokhov wrote:  
> > >> > Hi Chris,
> > >> >
> > >> > On Fri, Apr 08, 2022 at 04:28:57PM -0500, Chris Morgan wrote:  
> > >> > > From: Chris Morgan <macromorgan@hotmail.com>
> > >> > >
> > >> > > For my Odroid Go Advance I noticed that the adc-joystick driver was
> > >> > > only reporting the y channel and on the x axis. After debugging, I
> > >> > > found that the driver was trying to read values from channels 0 and
> > >> > > 1 even though my device is using channels 1 and 2. By changing the
> > >> > > code
> > >> > > to use the axis index instead of the scan index when unpacking the
> > >> > > data
> > >> > > from the buffer, the joystick begins working as expected.  
> > >> >
> > >> > This sounds like some sort of misconfiguration, as your change
> > >> > effectively removes the ability of using just some ADC channels for
> > >> > joystick functionality...  
> > >> 
> > >> I agree, this sounds like either a case of misconfiguration, or an 
> > >> issue in
> > >> the ADC driver that this device is using.
> > >> The axis index corresponds to the iio channel associated with the 
> > >> joystick,
> > >> but NOT to the order at which data is sampled by ADC.
> > >> That's why each channel has a `scan_index` field. It sounds like in 
> > >> Chris'
> > >> case the channels have wrong scan indices.
> > >> I'd start by verifying that in the ADC driver that is being used.
> > >> 
> > >> In any case, this patch is wrong and removes functionality that 
> > >> existing
> > >> devices depend on.  
> > > 
> > > I appreciate the feedback. If this driver is working as expected then
> > > that means the issue I am experiencing is further up the stack. Based
> > > on troubleshooting by getting the raw data that the rockchip-saradc
> > > driver was putting into the triggered buffer and seeing what the
> > > adc-joystick saw coming out of the triggered buffer I wonder if the
> > > issue is with the rockchip-saradc driver? I noticed that the buffer
> > > pushed by the driver's trigger handler would only (appear to) send the
> > > channels that I was requesting data for. So basically the data buffer
> > > would have the correct values in [0] and [1], but the adc-joystick
> > > driver by using the idx would fetch values from [1] for x (which has
> > > the y axis data) and [2] for y (which would have arbitrary data in
> > > it, usually something around 65406 or so).
> > > 
> > > Do you think I should start looking at the rockchip-saradc driver then?
> > > Should the saradc be putting stuff in the buffer for every channel with
> > > empty data for channels that aren't to be reported?
> > > 
> > > Thank you.  
> > 
> > Chris,
> > 
> > I analyzed the IIO core code some more and I think you are correct in 
> > your assessment.
> > The data buffer that `adc-joystick` receives will be the length of all 
> > the *active* channels combined.
> > That would mean scan index specifies the order of the channels by which 
> > they appear in the buffer, NOT their offsets in it.
> > 
> > That said, we can't rely on channel order from `joy->chans = 
> > devm_iio_channel_get_all(dev);`,
> > as channels might have out-of-order scan indices and thus this sequence 
> > can't be used to iterate the buffer.
> > I think the best approach would be to add an IIO helper to find a 
> > channel offset in a buffer.
> > Say, something like this:
> > 
> > ```
> > --- a/drivers/iio/buffer/industrialio-buffer-cb.c
> > +++ b/drivers/iio/buffer/industrialio-buffer-cb.c
> > @@ -151,6 +151,27 @@ struct iio_dev
> >   }
> >   EXPORT_SYMBOL_GPL(iio_channel_cb_get_iio_dev);
> > 
> > +int iio_find_channel_offset_in_buffer(const struct iio_channel 
> > *channel,
> > +                                     struct iio_cb_buffer *buffer)
> > +{
> > +       const struct iio_chan_spec *chan = channel->channel;
> > +       struct iio_dev *indio_dev = channel->indio_dev;
> > +       struct iio_buffer *buf = &buffer->buffer;
> > +       int ind, i = 0;
> > +
> > +       if (chan->scan_index < 0)
> > +               return -EINVAL;
> > +
> > +       for_each_set_bit(ind, buf->scan_mask, indio_dev->masklength) {
> > +               if (ind == chan->scan_index)
> > +                       return i;
> > +               ++i;
> > +       }
> > +
> > +       return -EINVAL;
> > +}
> > +EXPORT_SYMBOL_GPL(iio_find_channel_offset_in_buffer);
> 
> Almost.  You need to take into account the size of each
> channel and the alignment rules as well (everything is naturally
> aligned) which will unfortunately require searching the channel
> list for each channel with a scan_index below this one.
> 
> Useful function to hav so I'm in favour of adding something like
> this it will just need to also take the iio_dev to get access to the
> sizes of other channels.
> 
> Note similar code occurs in iio_buffer_update_demux() (though what you need
> here is thankfully rather simpler). 
> 
> We have iio_storage_bytes_for_si() to make things a bit simpler as it'll
> do the reverse lookups for you. 
> You'll need to export some of the utility functions.
> 
> However, I'd put this in a more generic location as it's potentially useful
> for cases other than callback buffers and that should reduce what you need
> to export.  Probably put it in industrialio-buffer.c / iio/buffer.h
> 

Forgive me for being new to the iio subsystem, but how can I find out
the alignment? Is it simply a matter of assuming the largest value is
always the size of the alignment (meaning if we have a single channel
enabled with a 2 byte value all channels are 2 bytes in size, even
if the channel itself only reports 1 byte of data?

So if I understand correctly we need a helper function that translates
the scan index (the channel?) into the joystick index, and by doing
so we need to find the offset of each byte in the data buffer.

So basically a helper function that does the following for a given
buffer/channel:

- Gets the channels that are enabled (presume from the buffer
scan_mask).
- Identifies the data size of each channel.
- Sets the offset size to the largest value for the channel size.
- Returns the offset for the given channel in the buffer.

Then, in the adc-joystick driver we can store this offset in the
driver data for each axis so we know exactly where in the buffer
this data is.

Does that sound about right? Or am I way off?

(also, completely unrelated but while I have a captive audience, is
there an easy way to either send a single trigger or set up a trigger
for a given driver? I'd like to add a polling function to this and
I'm trying to find the correct way to do it, but so far I've only
found a userspace way to use an hrtimer set up via sysfs, I'd like
to make it a driver option if I can).

Thank you very much!

> 
> 
> 
> > +
> > ```
> > 
> > ...and then the only change in `adc-joystick` has to be:
> > 
> > ```
> > --- a/drivers/input/joystick/adc-joystick.c
> > +++ b/drivers/input/joystick/adc-joystick.c
> > @@ -39,10 +39,13 @@ static int adc_joystick_handle(const void *data, 
> > void *private)
> >          bytes = joy->chans[0].channel->scan_type.storagebits >> 3;
> > 
> >          for (i = 0; i < joy->num_chans; ++i) {
> > -               idx = joy->chans[i].channel->scan_index;
> >                  endianness = 
> > joy->chans[i].channel->scan_type.endianness;
> >                  msb = joy->chans[i].channel->scan_type.realbits - 1;
> >                  sign = tolower(joy->chans[i].channel->scan_type.sign) == 
> > 's';
> > +               idx = iio_find_channel_offset_in_buffer(&joy->chans[i],
> > +                                                       joy->buffer);
> > +               if (idx < 0)
> > +                       return idx;
> > 
> >                  switch (bytes) {
> >                  case 1:
> > ```
> > 
> > On a side note, this potentially uncovered an issue in an unrelated 
> > `ingenic-adc` driver,
> > where data pushed into the buffer is always the size of all the 
> > available channels, not just active ones.
> 
> That would be fine, if it were also setting available_scan_masks as then
> the IIO core would repack only the requested channels (which is
> what that update_demux mentioned earlier sets up).
> 
> However, given the driver is doing readl() only for the channels
> that are enabled, it probably makes more sense to pack them correctly.
> 
> Jonathan
> 
> 
> > I was using that driver while writing `adc-joystick`, which explains why 
> > I never encountered your problem.
> > 
> > With all that said, let's wait for Jonathan to speak out before we 
> > proceed with v2.
> > 
> > Cheers,
> > Artur
> > 
> > >   
> > >> 
> > >> Cheers,
> > >> Artur
> > >>   
> > >> >
> > >> > Let's add Jonathan and Arthur for their take on this.
> > >> >  
> > >> > >
> > >> > > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > >> > > ---
> > >> > >  drivers/input/joystick/adc-joystick.c | 7 +++----
> > >> > >  1 file changed, 3 insertions(+), 4 deletions(-)
> > >> > >
> > >> > > diff --git a/drivers/input/joystick/adc-joystick.c
> > >> > > b/drivers/input/joystick/adc-joystick.c
> > >> > > index 78ebca7d400a..fe3bbd0d4566 100644
> > >> > > --- a/drivers/input/joystick/adc-joystick.c
> > >> > > +++ b/drivers/input/joystick/adc-joystick.c
> > >> > > @@ -32,24 +32,23 @@ static int adc_joystick_handle(const void *data,
> > >> > > void *private)
> > >> > >  {
> > >> > >  	struct adc_joystick *joy = private;
> > >> > >  	enum iio_endian endianness;
> > >> > > -	int bytes, msb, val, idx, i;
> > >> > > +	int bytes, msb, val, i;
> > >> > >  	const u16 *data_u16;
> > >> > >  	bool sign;
> > >> > >
> > >> > >  	bytes = joy->chans[0].channel->scan_type.storagebits >> 3;
> > >> > >
> > >> > >  	for (i = 0; i < joy->num_chans; ++i) {
> > >> > > -		idx = joy->chans[i].channel->scan_index;
> > >> > >  		endianness = joy->chans[i].channel->scan_type.endianness;
> > >> > >  		msb = joy->chans[i].channel->scan_type.realbits - 1;
> > >> > >  		sign = tolower(joy->chans[i].channel->scan_type.sign) == 's';
> > >> > >
> > >> > >  		switch (bytes) {
> > >> > >  		case 1:
> > >> > > -			val = ((const u8 *)data)[idx];
> > >> > > +			val = ((const u8 *)data)[i];
> > >> > >  			break;
> > >> > >  		case 2:
> > >> > > -			data_u16 = (const u16 *)data + idx;
> > >> > > +			data_u16 = (const u16 *)data + i;
> > >> > >
> > >> > >  			/*
> > >> > >  			 * Data is aligned to the sample size by IIO core.
> > >> > > --
> > >> > > 2.25.1
> > >> > >  
> > >> >
> > >> > Thanks.  
> 
