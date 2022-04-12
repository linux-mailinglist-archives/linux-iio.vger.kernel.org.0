Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE394FE645
	for <lists+linux-iio@lfdr.de>; Tue, 12 Apr 2022 18:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241820AbiDLQuA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 Apr 2022 12:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354930AbiDLQt7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Apr 2022 12:49:59 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2078.outbound.protection.outlook.com [40.92.42.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985975F27F;
        Tue, 12 Apr 2022 09:47:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SiFkT8XOXW9qbC65iH3u1DHAWuwU/1s1ZCtx/GR2dH1YHPs+ptDSaKE73bdJkxNBvLdOdcLZXkF+xh9ih+TEBMpOcs14WNg/Qnkl4gBPZO/6eaA3zolcyFvHoTRnJfGxSIWfc1nWJS00U7Yw5DZPSjGHTGkQxal6MvJXXvFvwnDJ4cQZrM5MFUMyv2j9ZUwtNhRGGpVZ9uQzZ3iZEX7xCJhAhtEhsLVCNgq9UsRK5Lxspnzk0sqSZW2/0GRxZMlNhX7tLGGg8+fvSHISNdGighYUm25e6xJ5mmvU22L3qSr5PVtxUuYwg+Lt40iOZHm+BNohN6rbu7+gfcsd2SMx9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JBTNvB1zVxcpIAAz/CRutHdCeYVbIfec81pQHyWiqn0=;
 b=LBdQi9dvslFMOPXhDcnDZlwfSh+dR65Ws+Tli+RhEBtdfImCw/l15cVqyiq8tzSwsAOA/vSQ7qWRGOaa9InWQwl88H3uuk75EibNXQmrgiZKrVDWANrSJIBJOwknTYtcijkdVQU6JpB662u33B2y8ff1tYC0hhrU7qfZ9eSUZaBctjk5JW6GWi9QsPkz1fG1U2kSTF/AlqLY+NcrSJ43hXKiuDXN9SdNDdASKJH4ag8wPLQeoK4yIe9wU6Nu6aoNjSU/6TJEViZDuH0RoRy/4GXIvkCS6RIJzkxvLg9J8Wyd18X7P3gkxHHOEdEjmZGuEesDdTRrLhbQzMHrmGubsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBTNvB1zVxcpIAAz/CRutHdCeYVbIfec81pQHyWiqn0=;
 b=k6Is+8S4u0P7FbASWbycDR/U2yoEXPT7KuADsjUhck1EL/vpROZBSTANY0MbVQLNMnheCnFRMzGzCdoZLAUZ5gusaBQFq0J0AZCOLh8kta1+qOx6A83Mf0yP/VLy3d/Z88P+XHPbES9sFb2sToGVQkpzHLN8mJ7d2dLuVmXpvQs5FaojILX/hnzfK+463KmpXib/O/un6zC2d0eZ4KoeA2PFeROiBMQitRaVeXemIvodGDP2OTz2blfmxNsEhDIasW2K88zFV8ysxlkn57CI8Uacx78f6qQnPpOolpjq44Rukngw21Ftjx3J/u5rgkkZAAL6nNshPrLey2D6+3Nyww==
Received: from SN6PR06MB5342.namprd06.prod.outlook.com (2603:10b6:805:f9::31)
 by DM6PR06MB4106.namprd06.prod.outlook.com (2603:10b6:5:8a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 16:47:39 +0000
Received: from SN6PR06MB5342.namprd06.prod.outlook.com
 ([fe80::a902:50a5:5db0:a7ab]) by SN6PR06MB5342.namprd06.prod.outlook.com
 ([fe80::a902:50a5:5db0:a7ab%6]) with mapi id 15.20.5164.018; Tue, 12 Apr 2022
 16:47:39 +0000
Date:   Tue, 12 Apr 2022 11:47:35 -0500
From:   Chris Morgan <macromorgan@hotmail.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Artur Rojek <contact@artur-rojek.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chris Morgan <macroalpha82@gmail.com>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] input: adc-joystick: Stop using scan_index for reading
 data
Message-ID: <SN6PR06MB5342FED79A07F43C9C6C867BA5ED9@SN6PR06MB5342.namprd06.prod.outlook.com>
References: <20220408212857.9583-1-macroalpha82@gmail.com>
 <YlDqTKuo5rbkIL8V@google.com>
 <2941de6570a6f808d6ea6e71d137ef87@artur-rojek.eu>
 <SN6PR06MB5342727A065E9FA2223B6A45A5EB9@SN6PR06MB5342.namprd06.prod.outlook.com>
 <c7ace6661c11183586420b431adb6bab@artur-rojek.eu>
 <20220410184318.53c0de04@jic23-huawei>
 <SN6PR06MB5342FF9387BAE6EDD12CDC7DA5EA9@SN6PR06MB5342.namprd06.prod.outlook.com>
 <20220412174447.000065bd@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412174447.000065bd@Huawei.com>
X-TMN:  [myisM8eh8KhmFFM6kHgWwTLLnQy+Rdnx]
X-ClientProxiedBy: SA0PR11CA0063.namprd11.prod.outlook.com
 (2603:10b6:806:d2::8) To SN6PR06MB5342.namprd06.prod.outlook.com
 (2603:10b6:805:f9::31)
X-Microsoft-Original-Message-ID: <20220412164735.GA18833@wintermute.localdomain>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09ac8379-2fda-4b14-974c-08da1ca4272e
X-MS-TrafficTypeDiagnostic: DM6PR06MB4106:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uizIsCevlmGICJdNEaElE0jmTLPFUaQ3a8n8f8Wc/bh5l5v6M2khSZRLxZsEQ0nVRjbT8iXU2DCEa/0w8QG8/l+YZN4+G6IZ9aLmfIIQ5WYB3+OEe82xVUt/rvNswMO7D++03cHbH7LkzGu+bhPt6hxVIm0/CQPc1ehzZ97zV1gQBZ2NFlIeDkdRFSp5okJ/wyjuwxbxAqM0en+NWdqL75VH32/8PhhW8WEe80OCCEw+tDoK2c74P7dkcDfdpINEIGdI/29BNiEty3t4kYifuuFm9D88M38jP+Qai8SRkJI4ashH1eM0u1YQ7+LP09JXBAf26i9vElXaPgj3mjHw06SP46JKv7oUokQ8Ebd0rtwwcfHyD8CDmuKj2fOFps/JK8EX3ziMSxEOAJHvMqYhBts05amzhnAZbXiQu5HIUQLUULWA1JLeW2vLRH+VPh5J7ONPB8OtKkcqmXtzN80ZyQWQQzcJEdMKeT4v8MWDdJhb6nXFTQRuqu2ojSfCYAR3ZJ7Op6ekqvN59dbG6H0CKspjH+ACdxkGs6hYbTzi4s/RjJRfSNct5kAAaO4Voieg+oj5SbpAB/YkIl8tTJJHdg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nill9rIlCJnbvWfe8CYyg1OnkMu9GnO0GEfZ5VlMw69gtkFStM10/+EWmkpm?=
 =?us-ascii?Q?ndN4PrXenHliJcjnOqlg71S8R6VbpNloc+VgCa4WjWZrgCFcQqSpIzXlhrDV?=
 =?us-ascii?Q?wmNERHEdQ8/0l/VjaC56bbUd7GJ/WlEZbFy7kmKbGyVeySRXmH9pQTs9B4xo?=
 =?us-ascii?Q?9eZH/k2MnmIgiGcDS0bfQMwmANqB2jZ1o7QnRm2BErNhmyaPVFvupND7htzA?=
 =?us-ascii?Q?m4zGp8qyhymeqbDuU/6lISaCElZwVPNdpoqMb3icnnp7PVhKPe8foLh1hDq8?=
 =?us-ascii?Q?0oEv6xOTbb+Cz9XxoBo3JpSChSdvl7oBqK34uOY9wX211g6olbqaVr8kv3ji?=
 =?us-ascii?Q?F0zl7zBg4qJEXEX53QNHe/j5js+RhjZMEh2r2iDpL1LB92Qymz/n2kpKKOn4?=
 =?us-ascii?Q?+kOp+TcWv/fGEokzE/7x5+Nzs1uqwsbuOUb/HY0X7q+Rmcjrk50MqVIdOPFA?=
 =?us-ascii?Q?Kj+GwbJfJtBKyNrbQVEQjn1dtqM14/iRzyiAk6NaAWQMZJDvDZLPBO349UKf?=
 =?us-ascii?Q?jGt/FmdgmOTbwjbm2i2sO7HN0b/GAeg5UGjlDg52mugYBW2BC0kJeA2UYF7V?=
 =?us-ascii?Q?CcFnKSqYsmdcYYWyy1IrQTFZpM3IXhgJltHD5WTO45ufB6ObgpprF2Iu+MC+?=
 =?us-ascii?Q?D5NO6w/bg5SztWwNW+SdhBCjguPKyMUsE7QFVad/M7tFpGPao2Lh+1LgWNuv?=
 =?us-ascii?Q?lqVprgdPpupzXeRO9gp1UcR1ozLnXRo6JtmxnYMRuvB0XERaz6JfANKK/iVU?=
 =?us-ascii?Q?iLSbwPvAHqA88za0GoQgstY+auFTumw9rEzUItai3kFXtP+Pc9rTB7BzUEJl?=
 =?us-ascii?Q?tle+utlBCFF9CsAJET9DW3WhU1ti/OshbCVml6oU2XcFcO2CmagOgW4rtcPy?=
 =?us-ascii?Q?V+y1B1NGBCjAWYvlUi9EC97hsHpzOWkLUSuMGS7O/Ai5UinW/cLSgg9kos8i?=
 =?us-ascii?Q?Y6jI8CBVQpazgJAsPe7f3cqYczke4bmslpbHdavDmy9d+fo3f18f8jBI8tXz?=
 =?us-ascii?Q?d54MtXMpTRTbc0KgzDw+o8Fro+JD1ginpDvwt8C8eYCRoQfHuFKOAw36YkWW?=
 =?us-ascii?Q?yiljc65DMEYs+05a6TuUSNRdb8BZ8F3z3jSdDy29fEagVlJJe0DxnnJGYLCD?=
 =?us-ascii?Q?0cSJ3l5mlK0tra2IUReWQqzQCtBulXEFOtQl4wW82n+Ae5elkSpl0XMVC2U/?=
 =?us-ascii?Q?q5/pxeQjzzUNtCTs/7oaxWaLbjrKxw0B5yFbcv+FPOiqcAtLXD7R0vPM+ijJ?=
 =?us-ascii?Q?DGJT+IxM1LlxCLd9lI7caz2nJcnY7bUzNeNprDbsBEeNwBhkiid+lTJzk1jS?=
 =?us-ascii?Q?orXpE58UXvpO2qJUidmjf9UC6gpQwyzKtxDJaBz5Z5a/1dMFVi3F/krrMRvE?=
 =?us-ascii?Q?pfunw47AA8+RX22iUKf3moEdH2UOY/kVCS7gcbYJshq+HFBnAEHNfDhv78zx?=
 =?us-ascii?Q?wUvdPTt/Fbc=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-89723.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ac8379-2fda-4b14-974c-08da1ca4272e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR06MB5342.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 16:47:39.0018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB4106
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Apr 12, 2022 at 05:44:47PM +0100, Jonathan Cameron wrote:
> On Mon, 11 Apr 2022 17:07:17 -0500
> Chris Morgan <macromorgan@hotmail.com> wrote:
> 
> > On Sun, Apr 10, 2022 at 06:43:18PM +0100, Jonathan Cameron wrote:
> > > On Sun, 10 Apr 2022 16:58:48 +0200
> > > Artur Rojek <contact@artur-rojek.eu> wrote:
> > >   
> > > > On 2022-04-10 03:39, Chris Morgan wrote:  
> > > > > On Sat, Apr 09, 2022 at 12:08:57PM +0200, Artur Rojek wrote:    
> > > > >> Hi Chris & Dmitry,
> > > > >> 
> > > > >> On 2022-04-09 04:07, Dmitry Torokhov wrote:    
> > > > >> > Hi Chris,
> > > > >> >
> > > > >> > On Fri, Apr 08, 2022 at 04:28:57PM -0500, Chris Morgan wrote:    
> > > > >> > > From: Chris Morgan <macromorgan@hotmail.com>
> > > > >> > >
> > > > >> > > For my Odroid Go Advance I noticed that the adc-joystick driver was
> > > > >> > > only reporting the y channel and on the x axis. After debugging, I
> > > > >> > > found that the driver was trying to read values from channels 0 and
> > > > >> > > 1 even though my device is using channels 1 and 2. By changing the
> > > > >> > > code
> > > > >> > > to use the axis index instead of the scan index when unpacking the
> > > > >> > > data
> > > > >> > > from the buffer, the joystick begins working as expected.    
> > > > >> >
> > > > >> > This sounds like some sort of misconfiguration, as your change
> > > > >> > effectively removes the ability of using just some ADC channels for
> > > > >> > joystick functionality...    
> > > > >> 
> > > > >> I agree, this sounds like either a case of misconfiguration, or an 
> > > > >> issue in
> > > > >> the ADC driver that this device is using.
> > > > >> The axis index corresponds to the iio channel associated with the 
> > > > >> joystick,
> > > > >> but NOT to the order at which data is sampled by ADC.
> > > > >> That's why each channel has a `scan_index` field. It sounds like in 
> > > > >> Chris'
> > > > >> case the channels have wrong scan indices.
> > > > >> I'd start by verifying that in the ADC driver that is being used.
> > > > >> 
> > > > >> In any case, this patch is wrong and removes functionality that 
> > > > >> existing
> > > > >> devices depend on.    
> > > > > 
> > > > > I appreciate the feedback. If this driver is working as expected then
> > > > > that means the issue I am experiencing is further up the stack. Based
> > > > > on troubleshooting by getting the raw data that the rockchip-saradc
> > > > > driver was putting into the triggered buffer and seeing what the
> > > > > adc-joystick saw coming out of the triggered buffer I wonder if the
> > > > > issue is with the rockchip-saradc driver? I noticed that the buffer
> > > > > pushed by the driver's trigger handler would only (appear to) send the
> > > > > channels that I was requesting data for. So basically the data buffer
> > > > > would have the correct values in [0] and [1], but the adc-joystick
> > > > > driver by using the idx would fetch values from [1] for x (which has
> > > > > the y axis data) and [2] for y (which would have arbitrary data in
> > > > > it, usually something around 65406 or so).
> > > > > 
> > > > > Do you think I should start looking at the rockchip-saradc driver then?
> > > > > Should the saradc be putting stuff in the buffer for every channel with
> > > > > empty data for channels that aren't to be reported?
> > > > > 
> > > > > Thank you.    
> > > > 
> > > > Chris,
> > > > 
> > > > I analyzed the IIO core code some more and I think you are correct in 
> > > > your assessment.
> > > > The data buffer that `adc-joystick` receives will be the length of all 
> > > > the *active* channels combined.
> > > > That would mean scan index specifies the order of the channels by which 
> > > > they appear in the buffer, NOT their offsets in it.
> > > > 
> > > > That said, we can't rely on channel order from `joy->chans = 
> > > > devm_iio_channel_get_all(dev);`,
> > > > as channels might have out-of-order scan indices and thus this sequence 
> > > > can't be used to iterate the buffer.
> > > > I think the best approach would be to add an IIO helper to find a 
> > > > channel offset in a buffer.
> > > > Say, something like this:
> > > > 
> > > > ```
> > > > --- a/drivers/iio/buffer/industrialio-buffer-cb.c
> > > > +++ b/drivers/iio/buffer/industrialio-buffer-cb.c
> > > > @@ -151,6 +151,27 @@ struct iio_dev
> > > >   }
> > > >   EXPORT_SYMBOL_GPL(iio_channel_cb_get_iio_dev);
> > > > 
> > > > +int iio_find_channel_offset_in_buffer(const struct iio_channel 
> > > > *channel,
> > > > +                                     struct iio_cb_buffer *buffer)
> > > > +{
> > > > +       const struct iio_chan_spec *chan = channel->channel;
> > > > +       struct iio_dev *indio_dev = channel->indio_dev;
> > > > +       struct iio_buffer *buf = &buffer->buffer;
> > > > +       int ind, i = 0;
> > > > +
> > > > +       if (chan->scan_index < 0)
> > > > +               return -EINVAL;
> > > > +
> > > > +       for_each_set_bit(ind, buf->scan_mask, indio_dev->masklength) {
> > > > +               if (ind == chan->scan_index)
> > > > +                       return i;
> > > > +               ++i;
> > > > +       }
> > > > +
> > > > +       return -EINVAL;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(iio_find_channel_offset_in_buffer);  
> > > 
> > > Almost.  You need to take into account the size of each
> > > channel and the alignment rules as well (everything is naturally
> > > aligned) which will unfortunately require searching the channel
> > > list for each channel with a scan_index below this one.
> > > 
> > > Useful function to hav so I'm in favour of adding something like
> > > this it will just need to also take the iio_dev to get access to the
> > > sizes of other channels.
> > > 
> > > Note similar code occurs in iio_buffer_update_demux() (though what you need
> > > here is thankfully rather simpler). 
> > > 
> > > We have iio_storage_bytes_for_si() to make things a bit simpler as it'll
> > > do the reverse lookups for you. 
> > > You'll need to export some of the utility functions.
> > > 
> > > However, I'd put this in a more generic location as it's potentially useful
> > > for cases other than callback buffers and that should reduce what you need
> > > to export.  Probably put it in industrialio-buffer.c / iio/buffer.h
> > >   
> > 
> > Forgive me for being new to the iio subsystem, but how can I find out
> > the alignment? Is it simply a matter of assuming the largest value is
> > always the size of the alignment (meaning if we have a single channel
> > enabled with a 2 byte value all channels are 2 bytes in size, even
> > if the channel itself only reports 1 byte of data?
> No each channel is naturally aligned after the earlier channels.
> (Short of oddiities around x86_32) it's the same as alignment in a c structure
> containing only the channels that are enabled.
> 
> So lets take an example.
> Channel 0 - 16 bits.
> Channel 1 - 8 bits
> Channel 2 - 16 bits
> channel 3 - 64 bits (usually timestamp.
> 
> If all enabled, then we end up with
> 0         2         3     4          6     8           16
> [channel 0|channel 1|  pad|channel 2 | pad | channel 3 |
> 
> 
> If only 0 and 2
> 0          2           4
> |channel 0 | channels 2|
> 
> If only 0 and 3
> 0          2                             8          16
> | channel 0|  Lots of padding            | channel 3 |
> 
> etc.
> 
> > 
> > So if I understand correctly we need a helper function that translates
> > the scan index (the channel?) into the joystick index, and by doing
> > so we need to find the offset of each byte in the data buffer.
> 
> No. Translates the scan index to an offset into the buffer. Index is
> not sufficient because it depends on what other channels are enabled.
> 
> > 
> > So basically a helper function that does the following for a given
> > buffer/channel:
> > 
> > - Gets the channels that are enabled (presume from the buffer
> > scan_mask).
> > - Identifies the data size of each channel.
> > - Sets the offset size to the largest value for the channel size.
> 
> Nope. As above.
> 
> > - Returns the offset for the given channel in the buffer.
> > 
> > Then, in the adc-joystick driver we can store this offset in the
> > driver data for each axis so we know exactly where in the buffer
> > this data is.
> > 
> > Does that sound about right? Or am I way off?
> 
> More complex than that. Because of the alignment requirements.
> 
> > 
> > (also, completely unrelated but while I have a captive audience, is
> > there an easy way to either send a single trigger or set up a trigger
> > for a given driver?
> > I'd like to add a polling function to this and
> > I'm trying to find the correct way to do it, but so far I've only
> > found a userspace way to use an hrtimer set up via sysfs, I'd like
> > to make it a driver option if I can).
> 
> You can set a trigger in code using iio_trigger_get() though we have
> provision for using hrtimer triggers this way. I vaguely
> recall a driver that provides both the trigger and acts as a consumer
> it might be the potentiostat/lmp910000

I appreciate it, I'll look at that driver. In the mean time I think I
will have to defer to your expertise on the solution for this, but
I'm happy to test it once you think you have something working.

Thank you.

> 
> 
> Jonathan
> 
> 
> > 
> > Thank you very much!
> > 
> > > 
> > > 
> > >   
> > > > +
> > > > ```
> > > > 
> > > > ...and then the only change in `adc-joystick` has to be:
> > > > 
> > > > ```
> > > > --- a/drivers/input/joystick/adc-joystick.c
> > > > +++ b/drivers/input/joystick/adc-joystick.c
> > > > @@ -39,10 +39,13 @@ static int adc_joystick_handle(const void *data, 
> > > > void *private)
> > > >          bytes = joy->chans[0].channel->scan_type.storagebits >> 3;
> > > > 
> > > >          for (i = 0; i < joy->num_chans; ++i) {
> > > > -               idx = joy->chans[i].channel->scan_index;
> > > >                  endianness = 
> > > > joy->chans[i].channel->scan_type.endianness;
> > > >                  msb = joy->chans[i].channel->scan_type.realbits - 1;
> > > >                  sign = tolower(joy->chans[i].channel->scan_type.sign) == 
> > > > 's';
> > > > +               idx = iio_find_channel_offset_in_buffer(&joy->chans[i],
> > > > +                                                       joy->buffer);
> > > > +               if (idx < 0)
> > > > +                       return idx;
> > > > 
> > > >                  switch (bytes) {
> > > >                  case 1:
> > > > ```
> > > > 
> > > > On a side note, this potentially uncovered an issue in an unrelated 
> > > > `ingenic-adc` driver,
> > > > where data pushed into the buffer is always the size of all the 
> > > > available channels, not just active ones.  
> > > 
> > > That would be fine, if it were also setting available_scan_masks as then
> > > the IIO core would repack only the requested channels (which is
> > > what that update_demux mentioned earlier sets up).
> > > 
> > > However, given the driver is doing readl() only for the channels
> > > that are enabled, it probably makes more sense to pack them correctly.
> > > 
> > > Jonathan
> > > 
> > >   
> > > > I was using that driver while writing `adc-joystick`, which explains why 
> > > > I never encountered your problem.
> > > > 
> > > > With all that said, let's wait for Jonathan to speak out before we 
> > > > proceed with v2.
> > > > 
> > > > Cheers,
> > > > Artur
> > > >   
> > > > >     
> > > > >> 
> > > > >> Cheers,
> > > > >> Artur
> > > > >>     
> > > > >> >
> > > > >> > Let's add Jonathan and Arthur for their take on this.
> > > > >> >    
> > > > >> > >
> > > > >> > > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > > > >> > > ---
> > > > >> > >  drivers/input/joystick/adc-joystick.c | 7 +++----
> > > > >> > >  1 file changed, 3 insertions(+), 4 deletions(-)
> > > > >> > >
> > > > >> > > diff --git a/drivers/input/joystick/adc-joystick.c
> > > > >> > > b/drivers/input/joystick/adc-joystick.c
> > > > >> > > index 78ebca7d400a..fe3bbd0d4566 100644
> > > > >> > > --- a/drivers/input/joystick/adc-joystick.c
> > > > >> > > +++ b/drivers/input/joystick/adc-joystick.c
> > > > >> > > @@ -32,24 +32,23 @@ static int adc_joystick_handle(const void *data,
> > > > >> > > void *private)
> > > > >> > >  {
> > > > >> > >  	struct adc_joystick *joy = private;
> > > > >> > >  	enum iio_endian endianness;
> > > > >> > > -	int bytes, msb, val, idx, i;
> > > > >> > > +	int bytes, msb, val, i;
> > > > >> > >  	const u16 *data_u16;
> > > > >> > >  	bool sign;
> > > > >> > >
> > > > >> > >  	bytes = joy->chans[0].channel->scan_type.storagebits >> 3;
> > > > >> > >
> > > > >> > >  	for (i = 0; i < joy->num_chans; ++i) {
> > > > >> > > -		idx = joy->chans[i].channel->scan_index;
> > > > >> > >  		endianness = joy->chans[i].channel->scan_type.endianness;
> > > > >> > >  		msb = joy->chans[i].channel->scan_type.realbits - 1;
> > > > >> > >  		sign = tolower(joy->chans[i].channel->scan_type.sign) == 's';
> > > > >> > >
> > > > >> > >  		switch (bytes) {
> > > > >> > >  		case 1:
> > > > >> > > -			val = ((const u8 *)data)[idx];
> > > > >> > > +			val = ((const u8 *)data)[i];
> > > > >> > >  			break;
> > > > >> > >  		case 2:
> > > > >> > > -			data_u16 = (const u16 *)data + idx;
> > > > >> > > +			data_u16 = (const u16 *)data + i;
> > > > >> > >
> > > > >> > >  			/*
> > > > >> > >  			 * Data is aligned to the sample size by IIO core.
> > > > >> > > --
> > > > >> > > 2.25.1
> > > > >> > >    
> > > > >> >
> > > > >> > Thanks.    
> > >   
> 
