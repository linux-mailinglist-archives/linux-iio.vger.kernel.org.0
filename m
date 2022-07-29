Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B598458536C
	for <lists+linux-iio@lfdr.de>; Fri, 29 Jul 2022 18:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbiG2Qa4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 Jul 2022 12:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiG2Qaz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 Jul 2022 12:30:55 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04olkn2066.outbound.protection.outlook.com [40.92.46.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F92511C2E;
        Fri, 29 Jul 2022 09:30:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBywtHLGyM/v8NyZLwG+yqPxlGn3cQlz5o2rNGxQyprJ4zzADrwwjde+vCbBPzQfXzr7IZYryxlQWgqMRSb7eXs+OW7DJnqC5HIPVatc40LG3NBegjInF1B2XMRFjT31b9eUOWnkR2Unl6jsVdPOBGrtV+kAeSPMaGmZHHTo4WxczlVp2L43Gp1ED9Do9TIg4T817gpOiK6yUB4fz3CcURE6B8WIO8rs4yowDzPO3U3vznA1zJh0vnUuBWd3rqdyPDrCyLqEkcJO0EO6/pXasD9Cddn6q1NRPnCs2VUT/czUGRY2jlwX9VhraGj2TNGzGB0Ux2+kC8ox+fy0l9Yv9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f2wH/U/EPxs1fpl2Tfbsb+QmHV2PiIAIbfV/adnCaW4=;
 b=M+9PKrO0fL53fKHO8P61FGzTMSwW+6nqgjzBePS73bhYO2ZlgFInxMXFWoSP0eZaVhU75EO8CRh5oIAu06i87A9mlx10rXBMPMLsNzudz50kjPsFVG+0oxAKSSC8/uq0QWlTr+336MjwGhctmWucJVDDwR60mlHDH05K/FxYId0+5dGv4/mfbDtgR6bzbitTFI4Ci8qkdLTkB5Q6JRfiaxhYtAL08lkbWXgrn8TBn1xU4eMNrdylSCsSJORUzXYCPYtssuctHSqdbofA3gdtR4ogIXwY9EmqDJMQ+3/RnZmptRt+4no9eNuok5MOehQrWip5BGtn5C63yP7RZkykeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2wH/U/EPxs1fpl2Tfbsb+QmHV2PiIAIbfV/adnCaW4=;
 b=DSUEkNLRfBal5z1qzPGrBGo0aY6cskKWrQAVcy/6SwgUWLi+BInO54DYVXYRJHrdVSCOJ+O8+avlcu4fS+jIzR0xOGBp1PXaIWik3Fy4n5qGgHAyPIfbN98DmgFCJ6Sj53wn37Iw3k8EQ6JgiiUxKY6+zHOX4UGdYywuqhi/XlL0wmpCbbc+loeluV6WGQ2cEs6vAjcelINBAQOA/2lANWfWozZIcnZJF0OBQRszqH1jQbcGI2D57UAdIRGcCWsufYDDn8rEeefUmp6hDAsb7lx5hftGVQYO0DxDZXnp443m+2DZusd7LbsuEd0YOGe9x5xzzO9C8bkyFy9zhXp4GA==
Received: from SN6PR06MB5342.namprd06.prod.outlook.com (2603:10b6:805:f9::31)
 by BL0PR06MB4644.namprd06.prod.outlook.com (2603:10b6:208:5e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Fri, 29 Jul
 2022 16:30:51 +0000
Received: from SN6PR06MB5342.namprd06.prod.outlook.com
 ([fe80::1474:5d4a:b9da:946c]) by SN6PR06MB5342.namprd06.prod.outlook.com
 ([fe80::1474:5d4a:b9da:946c%5]) with mapi id 15.20.5482.012; Fri, 29 Jul 2022
 16:30:51 +0000
Date:   Fri, 29 Jul 2022 11:30:48 -0500
From:   Chris Morgan <macromorgan@hotmail.com>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Chris Morgan <macroalpha82@gmail.com>, linux-input@vger.kernel.org,
        dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        jic23@kernel.org, paul@crapouillou.net, linux-iio@vger.kernel.org,
        Maya Matuszczyk <maccraft123mc@gmail.com>
Subject: Re: [PATCH v8 2/3] Input: adc-joystick - Add polled input device
 support
Message-ID: <SN6PR06MB53424C8BD8C59B39CBAC9105A5999@SN6PR06MB5342.namprd06.prod.outlook.com>
References: <20220721164603.13534-1-macroalpha82@gmail.com>
 <20220721164603.13534-3-macroalpha82@gmail.com>
 <8c6efe60662609a92e2a4e758e784f66@artur-rojek.eu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c6efe60662609a92e2a4e758e784f66@artur-rojek.eu>
X-TMN:  [75e5GlD17DkQezseRuCe29yGoDZrN1A0]
X-ClientProxiedBy: SA0PR12CA0003.namprd12.prod.outlook.com
 (2603:10b6:806:6f::8) To SN6PR06MB5342.namprd06.prod.outlook.com
 (2603:10b6:805:f9::31)
X-Microsoft-Original-Message-ID: <20220729163048.GA123@wintermute.localdomain>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1816574-6434-486d-9787-08da717fb389
X-MS-TrafficTypeDiagnostic: BL0PR06MB4644:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ARQw3Qwbbp+e132Pd5Pc8LPizlIeIViStSVCGBMRQ4bPj6LLeRRD3NHukcudkH9QTBHQ5/51HdxH8N0pWPi18ShZt2qolvllRY/0fovCwRcn9gikgqBLzlqjV1lq8EfZGhtEOqkbMXHcAsoQmGahlegj8BfXftbpIDy/Z5Cw19UTbYl567Kj+NUrRcOFBF17f2x129pp2ql3e9wQUjQOJDOv3zOFUGw7G8omeX1glUrrDTPJtlIpBsy9+hTc67uVYmIvGTJT4YLMY0UQ6szhST1cOOlSlqVcWrkWa4wp0sNamj6UUhjJRbyzFBcZq1Yx31IDfyK0HKhvfYViX+tng2W2qIeFfKHepNq1vz5I0b68s/p/qhgGzjnfyfbs177XGGFBfrY6YHL/BZpNTDiA2d4erUYDNPS0WkH987rGv7c3lpIzJHn21FwOcwSdfOwXUAMWFoUR5UbgBld0txN420Kd738lFTotivcmWUtt2dqTxS+V7b5WD3ig3qM10BRpmh+wZe/MGcP7Wte8m3qnis6QRsI+gWxOBgsilyVKhnP5AFHFXBlfKk8MPm2ZS1IaPC6E5TYHCVyn5QRzNCo3yGwC6/d7Y3g6xps/Hva0nj2zxYcTfpRAeGU4t7Vk/747rDiu2Qo3KnD9bAvFAt6f2B2ZpJLzbvnIaxOiRybFQpgCRa8Xri1FdN1OY0Vd3vf5
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jhnvaIdAUAOABwwAKRxAkSJqIXppJlR+TsOqMa0rIh03v0i38852N7TbKAdr?=
 =?us-ascii?Q?nLTgeZ3zkpBlZhfe1TdT79NqspBhdYWNclJKoy+0541L4YH/SZtQ4s/ytKau?=
 =?us-ascii?Q?OpeTr3TbrzrndQAR/DQpEwx7C+7MOWQXXP8INXJz0+9ZkiYlzK9qjPDnba0C?=
 =?us-ascii?Q?53YAO983C4mZklGGzgXw3ksQ1BN/IqAkyC1wBVijkrPuqE9CVQF1DmS/UzJd?=
 =?us-ascii?Q?fZj14XDKF4Pa5H/BPK+Wp5I48767IgG97bAki00qkGfAhk5b9Exy4Xt0GJtf?=
 =?us-ascii?Q?gakLwJo6FPLR5FFOkZfY/NL1hRwS0j8g5RAQVCeHpfj29Tf2Aq0Z4tVD5ye7?=
 =?us-ascii?Q?8or7zJXuw1YSA1ScenkSslJoVS2zv/+zPGpLWI6sfyO+gVpZMOkUpnrJcUzU?=
 =?us-ascii?Q?tvJ0q6gl3Z/wnZE23LIHD7rgZOGlcmmG+fYASj8JLugUXWPsWKN61Dr/+X4a?=
 =?us-ascii?Q?G/Groeh3T1hTqr6JDgeYwY2EtHV2zsWugukiR9GwW0kN/gL7HMZwxbIy9Mlw?=
 =?us-ascii?Q?OJ4S8+iTVZ+bLfwW+WF34MElx4vAjYv6tQvs9zIMLPtwDgIKYkFe9fzhwk2q?=
 =?us-ascii?Q?qhfUnyZvtuQCYyuxf/zblR22uOe6F+ZsFjg8kf1UYzuXXOCdnnYAi0jqbCe+?=
 =?us-ascii?Q?xUpghGLqb8azPtTBwd0QBip5PQKnisbD+xnvssXgm9ze4fLIgNazzOZ8BeaY?=
 =?us-ascii?Q?vmMRTVoMwrQ+CiycVnBZy/a5cCv9QoZgziNZJRF9hzG4hwu9+mmDzquqF6VA?=
 =?us-ascii?Q?kisBCe4VOsjUimLEZ6cBFMpJ+zze6uwsWu8JxIzB7WKxo8XJVKoORW6C8mUL?=
 =?us-ascii?Q?steIGuaUPBzFleVDPSZB+kXwnDq97QRau3wx5tp53hNv/PuY+ZpwxSsE4icX?=
 =?us-ascii?Q?9kwaOOdAf7TSGaoXoLfqeOMag8zadKK0B7jAzEDPPfgiRzzXxDb5/Nz5hNzk?=
 =?us-ascii?Q?5B3riaGy+ysa0+Zy3uGDLDaPwuGoiPQr+7iWDBd3/vSWrxF64Qi+g+2D8Jxr?=
 =?us-ascii?Q?cfCcMNrApYpHMHsvBaxNSPsvedhYFVk2lr4c3nGFnxYnVzDyOOdPzTGK+ReT?=
 =?us-ascii?Q?WKw/4B394ONyRGlZFot6Fm32pswwMRI8UNKFHjtqVYIEsnTOUi7W82rb7sxd?=
 =?us-ascii?Q?0Ca1+EZVIiiK2IBFO07OJNBsJCswh4UmSUuLd3ykfaza2JN5TvnPT8HHYYTe?=
 =?us-ascii?Q?uWa3UCbojr/5DPVkeAv8C5pikjhuMifj7orscdUSS+FAoPK1xYsHXnoQaftm?=
 =?us-ascii?Q?5xv8RnmfXu3nAF5XVk5jiM25j4rctWDU/9UWOkzq5g=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-89723.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f1816574-6434-486d-9787-08da717fb389
X-MS-Exchange-CrossTenant-AuthSource: SN6PR06MB5342.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 16:30:51.8114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR06MB4644
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jul 28, 2022 at 10:26:07PM +0200, Artur Rojek wrote:
> On 2022-07-21 18:46, Chris Morgan wrote:
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Add polled input device support to the adc-joystick driver. This is
> > useful for devices which do not have hardware capable triggers on
> > their SARADC. Code modified from adc-joystick.c changes made by Maya
> > Matuszczyk.
> > 
> > Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > ---
> Hey Chris,
> 
> sorry for the late response. Comments in-line.
> 
> Cheers,
> Artur
> >  drivers/input/joystick/adc-joystick.c | 82 ++++++++++++++++++++-------
> >  1 file changed, 62 insertions(+), 20 deletions(-)
> > 
> > diff --git a/drivers/input/joystick/adc-joystick.c
> > b/drivers/input/joystick/adc-joystick.c
> > index 78ebca7d400a..085b8e10dfb5 100644
> > --- a/drivers/input/joystick/adc-joystick.c
> > +++ b/drivers/input/joystick/adc-joystick.c
> > @@ -26,8 +26,23 @@ struct adc_joystick {
> >  	struct adc_joystick_axis *axes;
> >  	struct iio_channel *chans;
> >  	int num_chans;
> > +	bool polled;
> >  };
> > 
> > +static void adc_joystick_poll(struct input_dev *input)
> > +{
> > +	struct adc_joystick *joy = input_get_drvdata(input);
> > +	int i, val, ret;
> > +
> > +	for (i = 0; i < joy->num_chans; i++) {
> > +		ret = iio_read_channel_raw(&joy->chans[i], &val);
> > +		if (ret < 0)
> > +			return;
> > +		input_report_abs(input, joy->axes[i].code, val);
> > +	}
> > +	input_sync(input);
> > +}
> > +
> >  static int adc_joystick_handle(const void *data, void *private)
> >  {
> >  	struct adc_joystick *joy = private;
> > @@ -178,7 +193,9 @@ static int adc_joystick_probe(struct platform_device
> > *pdev)
> >  	struct input_dev *input;
> >  	int error;
> >  	int bits;
> > +	int chan_storage;
> >  	int i;
> > +	unsigned int poll_interval;
> > 
> >  	joy = devm_kzalloc(dev, sizeof(*joy), GFP_KERNEL);
> >  	if (!joy)
> > @@ -192,16 +209,31 @@ static int adc_joystick_probe(struct
> > platform_device *pdev)
> >  		return error;
> >  	}
> > 
> > -	/* Count how many channels we got. NULL terminated. */
> > +	if (device_property_present(dev, "poll-interval")) {
> > +		error = device_property_read_u32(dev, "poll-interval",
> > +						 &poll_interval);
> > +		if (error)
> > +			return error;
> > +		joy->polled = true;
> > +	}
> > +
> > +	/* Count how many channels we got. NULL terminated. Do not check the
> > +	 * storage size if using polling.
> > +	 */
> As per Linux coding style, the multi-line comment opens with a lone `/*`
> line. Also, move the second sentence into a new line for readability.

Gotcha, I always thought it could start this way but had to end with an
empty line. I guess I learned something new.

> 
> > +	chan_storage = joy->chans[0].channel->scan_type.storagebits;
> >  	for (i = 0; joy->chans[i].indio_dev; i++) {
> > -		bits = joy->chans[i].channel->scan_type.storagebits;
> > -		if (!bits || bits > 16) {
> > -			dev_err(dev, "Unsupported channel storage size\n");
> > -			return -EINVAL;
> > -		}
> > -		if (bits != joy->chans[0].channel->scan_type.storagebits) {
> > -			dev_err(dev, "Channels must have equal storage size\n");
> > -			return -EINVAL;
> > +		if (!joy->polled) {
> > +			bits = joy->chans[i].channel->scan_type.storagebits;
> > +			if (!bits || bits > 16) {
> > +				dev_err(dev,
> > +					"Unsupported channel storage size\n");
> > +				return -EINVAL;
> > +			}
> > +			if (bits != chan_storage) {
> > +				dev_err(dev,
> > +					"Channels must be equal size\n");
> > +				return -EINVAL;
> > +			}
> Just do `for (i = 0; !joy->polled && joy->chans[i].indio_dev; i++)`, as
> this will terminate early if we're polling.
> Then we'll also be able to restore the loop body to its original code and
> get rid of that `chan_storage` helper.
> 

Thank you, I was struggling to figure out how to get the code to do
what I wanted while keeping it below 80 columns, this is perfect.

> >  		}
> >  	}
> >  	joy->num_chans = i;
> > @@ -215,8 +247,14 @@ static int adc_joystick_probe(struct
> > platform_device *pdev)
> >  	joy->input = input;
> >  	input->name = pdev->name;
> >  	input->id.bustype = BUS_HOST;
> > -	input->open = adc_joystick_open;
> > -	input->close = adc_joystick_close;
> > +
> > +	if (joy->polled) {
> > +		input_setup_polling(input, adc_joystick_poll);
> > +		input_set_poll_interval(input, poll_interval);
> > +	} else {
> > +		input->open = adc_joystick_open;
> > +		input->close = adc_joystick_close;
> > +	}
> > 
> >  	error = adc_joystick_set_axes(dev, joy);
> >  	if (error)
> > @@ -229,16 +267,20 @@ static int adc_joystick_probe(struct
> > platform_device *pdev)
> >  		return error;
> >  	}
> > 
> > -	joy->buffer = iio_channel_get_all_cb(dev, adc_joystick_handle, joy);
> > -	if (IS_ERR(joy->buffer)) {
> > -		dev_err(dev, "Unable to allocate callback buffer\n");
> > -		return PTR_ERR(joy->buffer);
> > -	}
> > +	if (!joy->polled) {
> > +		joy->buffer = iio_channel_get_all_cb(dev, adc_joystick_handle,
> > +						     joy);
> > +		if (IS_ERR(joy->buffer)) {
> > +			dev_err(dev, "Unable to allocate callback buffer\n");
> > +			return PTR_ERR(joy->buffer);
> > +		}
> > 
> > -	error = devm_add_action_or_reset(dev, adc_joystick_cleanup,
> > joy->buffer);
> > -	if (error)  {
> > -		dev_err(dev, "Unable to add action\n");
> > -		return error;
> > +		error = devm_add_action_or_reset(dev, adc_joystick_cleanup,
> > +						 joy->buffer);
> > +		if (error)  {
> > +			dev_err(dev, "Unable to add action\n");
> > +			return error;
> > +		}
> >  	}
> > 
> >  	return 0;
> 
