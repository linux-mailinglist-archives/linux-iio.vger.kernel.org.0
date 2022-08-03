Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F935890D5
	for <lists+linux-iio@lfdr.de>; Wed,  3 Aug 2022 18:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236561AbiHCQxO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Aug 2022 12:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbiHCQxL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 Aug 2022 12:53:11 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2106.outbound.protection.outlook.com [40.92.40.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9838DAE49;
        Wed,  3 Aug 2022 09:53:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPU5wjYNzWJs6S8l8v3kJyTnydRwfV7LbZPw2RwZxugVz1/EXnjOmbCDItuJhFva9XTPBRCrafP7kVZqnCfU5xbxnj4BJb1RJaGgUVafazDyG4f43ANwKfHdrVs4jWSU2Awc8yH5ens9ay8OmGyZazd5TWbUJN1e9DZE3BFL7TEYgHMyrygdNg5hLNjlquzwp/tWdhx1WLJ1epx4MYVvkT3Av31Yp9a7JdfghcAHeerHEywylr5K5jAp7xXRsc3hvg4gfWljaoUXA1mKXoug+GqsOQgQAif6UcT9W4TdRExo7bHe/oX7yCQiqonF49VsoVoaB3WKfxYL4MnpimF1eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WMKSkFZ6t1U5b/YNY3mYOTw4K+BeJgj+EbmJKARVsI=;
 b=c7jJm1sfTwC6exqh7cLXcCNQqCY9/j1yxZv0Z9cxj5NpUIpmpo2OP/I3JY2lKDalPLmWbwQOBijBuZbwS277GOxTvirgeRU/2IUeTLuGI1OO36ah3v+mGHkvHQ4VXx+ZdwkPOEflj18qAK2j48IH6oygNDd/85/nagsVQncBBjD5Ala8H+yqswa/Phz2fdGRQG2xBGwcRl5hPgqdbasNfr0IUx7gt9Jvo2dfZexGZy95jJVui50aGOshT87hpo6YxL/Rpyi5WDAtUYoq2fJ3y61UZtdvhXi0CILVZZUpffQDRFupyA/3RLDs6qW6HOqnTWMdcifPdStCbVD5vpB/cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WMKSkFZ6t1U5b/YNY3mYOTw4K+BeJgj+EbmJKARVsI=;
 b=AfvnaL3aNN6lYqVxdQkU+wQlZNBT8/RGD39jjVs7CV9IB3StC+kmgqvfvd+ajSzDNataNhSm8b5OlSrs7J/mplC0bOpAM5vnDt3xppIIvga57UN4BepMLIbDsy96qUnhsikWWBUuLk5CY6k7CYOQ5V5mCrZkusJrg2PgSRXWl0F5p9S6ZW7nFlpZz4l1FgHiwOB3nUOyoXDLQrp35KRp5nT/4CtIio9OrpIZP6PI5zk5c29TkaDOcfZel2vrZX9lAFUhUEpa/i+2MvsMt9oz2X/bqrWqjB61EANuqH8o+2N6G2enGgjF5U9WvlXtv79CTDQNSAP1iis9XMWoEa4Ruw==
Received: from SN6PR06MB5342.namprd06.prod.outlook.com (2603:10b6:805:f9::31)
 by DM6PR06MB5548.namprd06.prod.outlook.com (2603:10b6:5:11d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Wed, 3 Aug
 2022 16:53:07 +0000
Received: from SN6PR06MB5342.namprd06.prod.outlook.com
 ([fe80::1474:5d4a:b9da:946c]) by SN6PR06MB5342.namprd06.prod.outlook.com
 ([fe80::1474:5d4a:b9da:946c%5]) with mapi id 15.20.5482.016; Wed, 3 Aug 2022
 16:53:07 +0000
Date:   Wed, 3 Aug 2022 11:53:00 -0500
From:   Chris Morgan <macromorgan@hotmail.com>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Chris Morgan <macroalpha82@gmail.com>, linux-input@vger.kernel.org,
        dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        jic23@kernel.org, paul@crapouillou.net, linux-iio@vger.kernel.org,
        Maya Matuszczyk <maccraft123mc@gmail.com>
Subject: Re: [PATCH v8 2/3] Input: adc-joystick - Add polled input device
 support
Message-ID: <SN6PR06MB53427F64B2A4AFCC8C12A0EBA59C9@SN6PR06MB5342.namprd06.prod.outlook.com>
References: <20220721164603.13534-1-macroalpha82@gmail.com>
 <20220721164603.13534-3-macroalpha82@gmail.com>
 <8c6efe60662609a92e2a4e758e784f66@artur-rojek.eu>
 <20220729163048.GA123@wintermute.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729163048.GA123@wintermute.localdomain>
X-TMN:  [Beh6MJxuXo9gOhlLZzDGkWbhj/w/KLu9]
X-ClientProxiedBy: DM6PR14CA0041.namprd14.prod.outlook.com
 (2603:10b6:5:18f::18) To SN6PR06MB5342.namprd06.prod.outlook.com
 (2603:10b6:805:f9::31)
X-Microsoft-Original-Message-ID: <20220803165300.GA15641@wintermute.localdomain>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e40f4677-06d3-4e2e-3f32-08da7570a359
X-MS-TrafficTypeDiagnostic: DM6PR06MB5548:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Ryk/YbnainROARvIYSKUCgnJy3Z1gEZtmAnjrTtbmx+jBT0ysxaDEgCi7fQIn0jg8Z6jZ9BCB574l8h/hmWH9W2OYQ2xqTTLyho9568R40OZSJDfgrNo2PVgNtyYSIRACGA0zHn7flMLk2uCmjRPSELtY9Cq5aX/KF4ezki934q8FlYTm4SCFIeOjIhEgl0pHO/JJTPdhsvNRqL9rS5H5FR9Vj6IOJExmgoxWW4sgFH7BIM5m17tuGzVHIx5YOmzQnykqfHmTECXnPd3XPml3ux3pV662rydEEYIN5EoB6Bb4bmj1XePAbvIxoX8h7tf5ixXgQCTTzVNvTmGRu4t/qXKKnOY64zSJrRnfvkW6VlMILRQFIkeBXppbsug7Sz/wS0ZR4E89RLxWqhh5639N3GD71Wz2Ve6psL5bHwTzqipUbwPBMRDme/gQmXQAGDzou2QzLgu2MVJghKkLwZMEprgIsh26+OWK84+5ipiQRfUKxGqwkCSs+Br0HNBkupTYanp02z0FZYeiVxuK9GP2tO6400eeO9mjP00CMvbptZmr/HXQijgRLFAfaJp1ODk0V5lCPV+HRwNDmJSKB3fjjaPHO9GMUZDZjIYqFOgHfAIHsuJB8TgDZvGcED5Aja88Ftk2qU6qG0KHbeECn8CXHe6kXV3tuPOAaUmDuANYJKO2rnec2VEgTXarcOZAV9
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BWBLcRLI+KkKzDr2bq9NegY3cA0JoFWC1uoYavv5+nuHi16X5XzvNkbaLkIK?=
 =?us-ascii?Q?277Ss8g52wA7SX2/k5ImPg1947RRB7XlqH5N2poUjjYj1Z/bucpMBWBrTiRT?=
 =?us-ascii?Q?dav8RvB331rn9ZTRsqecPCHmU5j/+cD/7DRFxG7ZhTG4Q4R9llar5elsWRFj?=
 =?us-ascii?Q?c5bL9YvsSYuEw+45SVxnlR4EPoqrZceAKhM9j9QhE2I+Rr9nSUeFg7wZyGmc?=
 =?us-ascii?Q?NdlkiUlEaZhx40EU9l/+6lPTji4doSHJR28re95oGYl8G3Z0IPlTj/LSzsAZ?=
 =?us-ascii?Q?5/tffyUP4WE0IVqn36zrv5RaiUpGAroKUwyxFu+w96X+XpHJvU4f2OVShR+N?=
 =?us-ascii?Q?SDE/XVzQANgYEpIg53jc9nOoNKGexziulHhRuKFxEFuiTS5idj1hFjVsDKbX?=
 =?us-ascii?Q?nUC34XExgHz6N7swJpOoKBsBR+lpfY9dEHY98B3SYKSh7EBoPZepCY/U64/a?=
 =?us-ascii?Q?VBnMlftRwtRi5sKMHvfaSsbbAKbBL0ueUNfO8kCuiTcy6kKaTySAyCMiU9Z7?=
 =?us-ascii?Q?Sg4XFuDGhDRs5a3UhS4sQz9mnaibiFNo1ln6ez75zLj8Sx9h0yWg/DdmBVH5?=
 =?us-ascii?Q?5jA+wXcggBdPsO2Uvvz3R9OQZ3jEDA+rkJF+LY0E5IG7a69afUFBSYLAl+/Y?=
 =?us-ascii?Q?JovldPAOYI492gEGBle2Sm62nrpz8mk1NZpKpaNZPu/vwS/556UJs+UmUf1i?=
 =?us-ascii?Q?dFrxoR1Wa2DZGfpVy4xc3g741A9iOV5pPspRFVOWyDNfH4nndyZ52nGY2D+T?=
 =?us-ascii?Q?0uQW6Oh8aE2yTuavffaoR6QoLMD5d7o+N4ILutazvkiojXuBN+E5b1oV9qRL?=
 =?us-ascii?Q?6kn3vyUlnIVyBx7NVd1T8lbBFO+Q0bw7muHP0fZ97mFkXikhi/KHd184A+/o?=
 =?us-ascii?Q?fcLEZxv3XVOT3fa7Rvl4YkV3IRjgcc244h+BC9qSgcH7FskjXyhpbdeLJNYh?=
 =?us-ascii?Q?qYSI+jTWqs0OnaY68epa72F2vKPOqWpO3AI/ThoYHa334ax0PLIeDsRAISjg?=
 =?us-ascii?Q?nkWPYIdDitAOXmqTWufNUWIfN3el6Q5//0HKKIeTFHfGYmHjBdKg9DR5dfbN?=
 =?us-ascii?Q?LnM71BAZ87IYmhskUdZZK9LcO+aRfST+2fJgRpsD3RTfsZSlVmYbdAhZDBF8?=
 =?us-ascii?Q?J7qEtQup7wWJnFRJfUOa0yA1kGam6F1Zm4gEnHAjube46HX3aLX9c6C48jDQ?=
 =?us-ascii?Q?f5uS72GRf7JaMzNMuMS7vj4KR+wqwrjeHmhuY8qZb3x2/W+kSSJRDzfpkJYO?=
 =?us-ascii?Q?R5JTp8NTBNn+kuTpIKBYXOc2dOX8pyWWP1DQ8QpHzg=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-89723.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e40f4677-06d3-4e2e-3f32-08da7570a359
X-MS-Exchange-CrossTenant-AuthSource: SN6PR06MB5342.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 16:53:06.9605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB5548
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jul 29, 2022 at 11:30:51AM -0500, Chris Morgan wrote:
> On Thu, Jul 28, 2022 at 10:26:07PM +0200, Artur Rojek wrote:
> > On 2022-07-21 18:46, Chris Morgan wrote:
> > > From: Chris Morgan <macromorgan@hotmail.com>
> > > 
> > > Add polled input device support to the adc-joystick driver. This is
> > > useful for devices which do not have hardware capable triggers on
> > > their SARADC. Code modified from adc-joystick.c changes made by Maya
> > > Matuszczyk.
> > > 
> > > Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> > > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > > ---
> > Hey Chris,
> > 
> > sorry for the late response. Comments in-line.
> > 
> > Cheers,
> > Artur
> > >  drivers/input/joystick/adc-joystick.c | 82 ++++++++++++++++++++-------
> > >  1 file changed, 62 insertions(+), 20 deletions(-)
> > > 
> > > diff --git a/drivers/input/joystick/adc-joystick.c
> > > b/drivers/input/joystick/adc-joystick.c
> > > index 78ebca7d400a..085b8e10dfb5 100644
> > > --- a/drivers/input/joystick/adc-joystick.c
> > > +++ b/drivers/input/joystick/adc-joystick.c
> > > @@ -26,8 +26,23 @@ struct adc_joystick {
> > >  	struct adc_joystick_axis *axes;
> > >  	struct iio_channel *chans;
> > >  	int num_chans;
> > > +	bool polled;
> > >  };
> > > 
> > > +static void adc_joystick_poll(struct input_dev *input)
> > > +{
> > > +	struct adc_joystick *joy = input_get_drvdata(input);
> > > +	int i, val, ret;
> > > +
> > > +	for (i = 0; i < joy->num_chans; i++) {
> > > +		ret = iio_read_channel_raw(&joy->chans[i], &val);
> > > +		if (ret < 0)
> > > +			return;
> > > +		input_report_abs(input, joy->axes[i].code, val);
> > > +	}
> > > +	input_sync(input);
> > > +}
> > > +
> > >  static int adc_joystick_handle(const void *data, void *private)
> > >  {
> > >  	struct adc_joystick *joy = private;
> > > @@ -178,7 +193,9 @@ static int adc_joystick_probe(struct platform_device
> > > *pdev)
> > >  	struct input_dev *input;
> > >  	int error;
> > >  	int bits;
> > > +	int chan_storage;
> > >  	int i;
> > > +	unsigned int poll_interval;
> > > 
> > >  	joy = devm_kzalloc(dev, sizeof(*joy), GFP_KERNEL);
> > >  	if (!joy)
> > > @@ -192,16 +209,31 @@ static int adc_joystick_probe(struct
> > > platform_device *pdev)
> > >  		return error;
> > >  	}
> > > 
> > > -	/* Count how many channels we got. NULL terminated. */
> > > +	if (device_property_present(dev, "poll-interval")) {
> > > +		error = device_property_read_u32(dev, "poll-interval",
> > > +						 &poll_interval);
> > > +		if (error)
> > > +			return error;
> > > +		joy->polled = true;
> > > +	}
> > > +
> > > +	/* Count how many channels we got. NULL terminated. Do not check the
> > > +	 * storage size if using polling.
> > > +	 */
> > As per Linux coding style, the multi-line comment opens with a lone `/*`
> > line. Also, move the second sentence into a new line for readability.
> 
> Gotcha, I always thought it could start this way but had to end with an
> empty line. I guess I learned something new.
> 
> > 
> > > +	chan_storage = joy->chans[0].channel->scan_type.storagebits;
> > >  	for (i = 0; joy->chans[i].indio_dev; i++) {
> > > -		bits = joy->chans[i].channel->scan_type.storagebits;
> > > -		if (!bits || bits > 16) {
> > > -			dev_err(dev, "Unsupported channel storage size\n");
> > > -			return -EINVAL;
> > > -		}
> > > -		if (bits != joy->chans[0].channel->scan_type.storagebits) {
> > > -			dev_err(dev, "Channels must have equal storage size\n");
> > > -			return -EINVAL;
> > > +		if (!joy->polled) {
> > > +			bits = joy->chans[i].channel->scan_type.storagebits;
> > > +			if (!bits || bits > 16) {
> > > +				dev_err(dev,
> > > +					"Unsupported channel storage size\n");
> > > +				return -EINVAL;
> > > +			}
> > > +			if (bits != chan_storage) {
> > > +				dev_err(dev,
> > > +					"Channels must be equal size\n");
> > > +				return -EINVAL;
> > > +			}
> > Just do `for (i = 0; !joy->polled && joy->chans[i].indio_dev; i++)`, as
> > this will terminate early if we're polling.
> > Then we'll also be able to restore the loop body to its original code and
> > get rid of that `chan_storage` helper.
> > 
> 
> Thank you, I was struggling to figure out how to get the code to do
> what I wanted while keeping it below 80 columns, this is perfect.

The suggested code doesn't work (because it doesn't count the channels, however
it gave me an idea to include a check in each of the if conditions below it to
look for joy->polled, and I think that works. I'll send v9 shortly. Thank you
for all your help.

> 
> > >  		}
> > >  	}
> > >  	joy->num_chans = i;
> > > @@ -215,8 +247,14 @@ static int adc_joystick_probe(struct
> > > platform_device *pdev)
> > >  	joy->input = input;
> > >  	input->name = pdev->name;
> > >  	input->id.bustype = BUS_HOST;
> > > -	input->open = adc_joystick_open;
> > > -	input->close = adc_joystick_close;
> > > +
> > > +	if (joy->polled) {
> > > +		input_setup_polling(input, adc_joystick_poll);
> > > +		input_set_poll_interval(input, poll_interval);
> > > +	} else {
> > > +		input->open = adc_joystick_open;
> > > +		input->close = adc_joystick_close;
> > > +	}
> > > 
> > >  	error = adc_joystick_set_axes(dev, joy);
> > >  	if (error)
> > > @@ -229,16 +267,20 @@ static int adc_joystick_probe(struct
> > > platform_device *pdev)
> > >  		return error;
> > >  	}
> > > 
> > > -	joy->buffer = iio_channel_get_all_cb(dev, adc_joystick_handle, joy);
> > > -	if (IS_ERR(joy->buffer)) {
> > > -		dev_err(dev, "Unable to allocate callback buffer\n");
> > > -		return PTR_ERR(joy->buffer);
> > > -	}
> > > +	if (!joy->polled) {
> > > +		joy->buffer = iio_channel_get_all_cb(dev, adc_joystick_handle,
> > > +						     joy);
> > > +		if (IS_ERR(joy->buffer)) {
> > > +			dev_err(dev, "Unable to allocate callback buffer\n");
> > > +			return PTR_ERR(joy->buffer);
> > > +		}
> > > 
> > > -	error = devm_add_action_or_reset(dev, adc_joystick_cleanup,
> > > joy->buffer);
> > > -	if (error)  {
> > > -		dev_err(dev, "Unable to add action\n");
> > > -		return error;
> > > +		error = devm_add_action_or_reset(dev, adc_joystick_cleanup,
> > > +						 joy->buffer);
> > > +		if (error)  {
> > > +			dev_err(dev, "Unable to add action\n");
> > > +			return error;
> > > +		}
> > >  	}
> > > 
> > >  	return 0;
> > 
