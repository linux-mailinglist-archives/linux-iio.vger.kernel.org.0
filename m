Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3ECD591288
	for <lists+linux-iio@lfdr.de>; Fri, 12 Aug 2022 16:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237768AbiHLO4J (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Aug 2022 10:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234450AbiHLO4I (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Aug 2022 10:56:08 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07olkn2041.outbound.protection.outlook.com [40.92.15.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D8A816BB;
        Fri, 12 Aug 2022 07:56:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZizceAtCryvgJ5paBMGpIlijbzddsYcATS4fQE+Fq8cubEhsS5D95r2AiExlcRdui6Vf7EANNXZ7aut2rrouVEUGGpIRoW4kcGoNL5WBUnDXhatTjAn34Dmu3ko0YT0DwWD3Y7QA4mTjCSSMUPjWr5jRxyySbodLmBwBc3RcBng/9+GakfNGfO17l3yrlk+AqhfaEhNz5LwtOCvWkUrprcWmHC35VpwDEvb9oQ9SEJR/j4JZooi2nehTMTdnyqVYucpM+PB3UB5tDxbQXG1JmApRIfhSsqSJKdoyzYPeyyxO3NEU+u33cGcvIQ4g2bi/i/eHEsg1kfjnS5Zxlze0aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvo1OU0xHqJmdYnS1VO+MYWMfpQFpwtaRaJ7grMASsk=;
 b=L5pMEsUZdhlOEgsfgB/wxHlAVRwOY5cltKKLXFjvIX53VoHcSrq7gpJe/aLbE3QXbHg6y8N6RaLtF6e40O4Fy64V0HzbkLsbHrYJ9gFTHsAf7dn8S1l8Tfg+2n0tjNRLstu+ew/IkYAvefIS5j3DATn39WQUXTo34Pxs0CwE7xjiTxM4SWviqehlzFGSNzcvKYoMvS8t+dY6GPQ2+9q8BCakMTi8Fj0hfBJQFSy7LPTXBWP4AaJ8mQLSwEr/6I1mVmnttdRg+dMrSBOMyVrU3G35Ii39Ne/e3LqAxTJhD3qOyYcBnNFyTy6c6LDq/R2MV7oaPasJssj97YuTsAFxvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvo1OU0xHqJmdYnS1VO+MYWMfpQFpwtaRaJ7grMASsk=;
 b=nIST//i409U8tmFcCFFwdKhTgSl9ELCy3vwDeEYMCBMw8XhkPxkNgFU0YUBUlV+BQUa2XnewgT1XlL2xeybBfPTQ1cbU3dN4RTJM4XPyeYXn6yK5sBrKVnwug2e0tr9w3d35AaDc4/ZDCh50SrjfzJ/b5P/6SB7OmdoeV7r5tZtnV5K9zp07wfhUUz/QzX4pBV3VBH8Bk2GeSq6vhbwoAFynnv1rY3ppZHIEgZJXowYuzVVUJeP+kJfeumseQzccAp5SGjZx6gSqEhz3c1UQvG0BLwGZalKJsFNcPTjDjY53PLbQOm70ShaeW+qiU6YyEGd4ipE1OI32GRzRWJgTsw==
Received: from SN6PR06MB5342.namprd06.prod.outlook.com (2603:10b6:805:f9::31)
 by BYAPR06MB5576.namprd06.prod.outlook.com (2603:10b6:a03:d6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Fri, 12 Aug
 2022 14:56:04 +0000
Received: from SN6PR06MB5342.namprd06.prod.outlook.com
 ([fe80::20e7:bc40:7e9d:b46e]) by SN6PR06MB5342.namprd06.prod.outlook.com
 ([fe80::20e7:bc40:7e9d:b46e%4]) with mapi id 15.20.5504.025; Fri, 12 Aug 2022
 14:56:04 +0000
Date:   Fri, 12 Aug 2022 09:56:00 -0500
From:   Chris Morgan <macromorgan@hotmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Artur Rojek <contact@artur-rojek.eu>,
        Jonathan Cameron <jic23@kernel.org>,
        Chris Morgan <macroalpha82@gmail.com>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, paul@crapouillou.net,
        Maya Matuszczyk <maccraft123mc@gmail.com>
Subject: Re: [PATCH v12 2/3] Input: adc-joystick - Add polled input device
 support
Message-ID: <SN6PR06MB5342FF12160366A57986D78DA5679@SN6PR06MB5342.namprd06.prod.outlook.com>
References: <20220805171016.21217-1-macroalpha82@gmail.com>
 <20220805171016.21217-3-macroalpha82@gmail.com>
 <20220806152042.39bc5351@jic23-huawei>
 <9399f54366be973dba36a70cb3dcbfd9@artur-rojek.eu>
 <YvRUSBFGuMmjGsb4@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvRUSBFGuMmjGsb4@google.com>
X-TMN:  [wPuHaT8HM+wmeN/xlTk3298CYlPI1LjE]
X-ClientProxiedBy: DS7PR06CA0053.namprd06.prod.outlook.com (2603:10b6:8:54::8)
 To SN6PR06MB5342.namprd06.prod.outlook.com (2603:10b6:805:f9::31)
X-Microsoft-Original-Message-ID: <20220812145600.GA26030@wintermute.localdomain>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aad8311e-58ab-4a6b-9e05-08da7c72c78a
X-MS-TrafficTypeDiagnostic: BYAPR06MB5576:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: of8SRmXr8Y6k60MWIF2AAsqRF8c98zqRV2v3ULjCg4UdfnML0NO8vzeakBlY+I7SgK4b9RdtuCiiCh52ig+UCuJ2QciZba8nvwxfqD60dIgLRPvSv+GAqLTvq4P29Rc8NSYjinvpURkUm9JXasyoQuWj91Ehj6xcjJjT6tmp3Dl2KBSy9KLM9rMdR2TrM3AcXPti+uMYcm/IQOjrPEb+xBskajDiW6afXRB9o6hqTDqUpABiGLVZ0yGxAlovuLoZsVkCzvvwIFZirmYcPnZq5CtCpbcYG+qFhB9+sR1moxAgkJbgKvqeEEjVJxtVcYmBF4kvKR22stJTeUyi26K26wE9NAxuIgkxkogpHqmK4KEk8F/Xv0EqEN0KM/R943cFNAdmfvYtSYFeUzB1R9ZTqqK7nfTWcUu/nm9u1b8dLvw3XvugGrvZOvADCHLu4BgdI2I1p3AK+cjpILMWWDzhbPZPWXlKmJ1zmPyDvZIf1Qsm7E82ZDkO2Z+gTJ76rEa+TBmmqZX4Qaqy9iyTHKVvmFxspBeyLhz+iVRYWmMKDky8eZ6V6JC8GrsfmIOroWdKRQ80c6QY9WyXaETvf6kReEtYkHJOVBVAQhI4N6eT9AsKFlFlZtY+Ch/brS53C16cq+govQOZqwa/B2F+Kyzzp4LKwbhLTG100Tv7jobc3l6zvMCBEPC9/XUq7DzsEpzl
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EJlGvuYxkJ2muTjle3BRxDiNGK40/rZswtQ5L2ODa3irgzUhvmc9qESTn4Rj?=
 =?us-ascii?Q?Gb3Keg9KE1IHlokLQc6JhV/M6XM1EAX++sVLLXyloh8btk0E8iUzj8Ay4nHC?=
 =?us-ascii?Q?ymPFETGmuhBGxUODhW8xYR1h3ItSfZWi8EMaYgTh4IRb6z0Mjn0/dyOyv+4b?=
 =?us-ascii?Q?amvImwfV2kZlSf8u/K02/GiMMBVaoAn4YL6oTK96O5dwc7WFtHmDhUuX8p/M?=
 =?us-ascii?Q?8uertvhIDHzkfiaOzYWokG4xsNV9NpcJvUzF/LFpTyxXYSzaOHjPmer8hPoY?=
 =?us-ascii?Q?U7hsaNquLSMBVZ1dL5MPtAWNDpbKQCb6c48x9JL701/l3EupwNcPU/DspNoA?=
 =?us-ascii?Q?VN1F7sIlQokU+fccqIc+BI5Npkb1hP9IuDajHBzR2uB2jxhJRbMOgJNGSzWA?=
 =?us-ascii?Q?ocSh1ZFV2P5uVvBJqHhV1S7gDW5dQVoaiZECMb7ZEnvbjCzNHtDtP3lokvu0?=
 =?us-ascii?Q?Dox49hYPtIL06szU0ND83sJcCutuUvnFm97ynIZWjdaTjrSctZ5j07Z03pV2?=
 =?us-ascii?Q?ANqsGZ4H4M0wgG8wIVK9BDgtx2OZt8XDAatFKJLiwh9Gq6pzywdusWNsQSvx?=
 =?us-ascii?Q?4oy9BY+vTuGqVdeVnZyQ+ruGasYff2SvwGU+tMUFXof67Kre3VaOW7bMfQCv?=
 =?us-ascii?Q?mqrxXFCaaQ+2eunJp58QUbf4p1+3JlN8cBs7CSpZwt82AlNZY26yUcDBGYah?=
 =?us-ascii?Q?OYcVZfePY7+UVM+EzC6LuG40F5P28uoFXnga5Ag5T88a6EANPBcqaHPfd4eQ?=
 =?us-ascii?Q?R58tFcFw/y4WIdK7zvLUNY+LwGG/zHpZbyiN5gSBoSM29j6BNOYxvOJh1jZ9?=
 =?us-ascii?Q?ydITVbGVZ3RYqEfHwAJhZHPpeMqT2gnP5FgRO7XXEVpn8Ac/jpXCorQNTsbc?=
 =?us-ascii?Q?ALXGvYcxqFSCEvONUNPbCY9VLks4HI7ErIVeIZgz/roUtG3a7QMzYkcLFbwk?=
 =?us-ascii?Q?k8NOIGUcANEZpX2v64om3E+c2UtSCLB5hacbTNR+ngJnjN1zxGJvolY93adV?=
 =?us-ascii?Q?WsV+jmwC5PhVu9jXJfykOoQoznYjSgSAaL8zfEG6ntBsrJYjmWVgODddbRgu?=
 =?us-ascii?Q?Lh+yEJYrlelNEhQBS3PMRmfyw1H9+h0VBLdl1S0uk5ZO77ahigiWxlO0dVcs?=
 =?us-ascii?Q?01QnXnC0ohicWszuVf07k5rXg2M80d1eRLeR4slrsXAw1PaROTaoT40hJ/8S?=
 =?us-ascii?Q?a3WUQ8lPYg3ED2DWEFSO+0unjESuqC1t1ehbZMPHPi+pDyiFA+7J+6b0Iq0I?=
 =?us-ascii?Q?nKcApe+/Gq8fvj2e0U+ldT+skAlGIOoEDHRsraO24Q=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-89723.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: aad8311e-58ab-4a6b-9e05-08da7c72c78a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR06MB5342.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 14:56:04.8931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5576
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Aug 10, 2022 at 05:58:48PM -0700, Dmitry Torokhov wrote:
> On Sat, Aug 06, 2022 at 04:19:21PM +0200, Artur Rojek wrote:
> > On 2022-08-06 16:20, Jonathan Cameron wrote:
> > > On Fri,  5 Aug 2022 12:10:15 -0500
> > > Chris Morgan <macroalpha82@gmail.com> wrote:
> > > 
> > > > From: Chris Morgan <macromorgan@hotmail.com>
> > > > 
> > > > Add polled input device support to the adc-joystick driver. This is
> > > > useful for devices which do not have hardware capable triggers on
> > > > their SARADC. Code modified from adc-joystick.c changes made by Maya
> > > > Matuszczyk.
> > > > 
> > > > Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> > > > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > > Hi Chris,
> > > 
> > > Trying to avoid too much indentation has lead to an odd code structure.
> > > Still minor thing, so either way this looks fine to me.
> > > 
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > 
> > > > ---
> > > >  drivers/input/joystick/adc-joystick.c | 44
> > > > +++++++++++++++++++++++++--
> > > >  1 file changed, 41 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/input/joystick/adc-joystick.c
> > > > b/drivers/input/joystick/adc-joystick.c
> > > > index 78ebca7d400a..77dfb7dd96eb 100644
> > > > --- a/drivers/input/joystick/adc-joystick.c
> > > > +++ b/drivers/input/joystick/adc-joystick.c
> > > > @@ -26,8 +26,23 @@ struct adc_joystick {
> > > >  	struct adc_joystick_axis *axes;
> > > >  	struct iio_channel *chans;
> > > >  	int num_chans;
> > > > +	bool polled;
> > > >  };
> > > > 
> > > > +static void adc_joystick_poll(struct input_dev *input)
> > > > +{
> > > > +	struct adc_joystick *joy = input_get_drvdata(input);
> > > > +	int i, val, ret;
> > > > +
> > > > +	for (i = 0; i < joy->num_chans; i++) {
> > > > +		ret = iio_read_channel_raw(&joy->chans[i], &val);
> > > > +		if (ret < 0)
> > > > +			return;
> > > > +		input_report_abs(input, joy->axes[i].code, val);
> > > > +	}
> > > > +	input_sync(input);
> > > > +}
> > > > +
> > > >  static int adc_joystick_handle(const void *data, void *private)
> > > >  {
> > > >  	struct adc_joystick *joy = private;
> > > > @@ -179,6 +194,7 @@ static int adc_joystick_probe(struct
> > > > platform_device *pdev)
> > > >  	int error;
> > > >  	int bits;
> > > >  	int i;
> > > > +	unsigned int poll_interval;
> > > > 
> > > >  	joy = devm_kzalloc(dev, sizeof(*joy), GFP_KERNEL);
> > > >  	if (!joy)
> > > > @@ -192,8 +208,21 @@ static int adc_joystick_probe(struct
> > > > platform_device *pdev)
> > > >  		return error;
> > > >  	}
> > > > 
> > > > -	/* Count how many channels we got. NULL terminated. */
> > > > +	if (device_property_present(dev, "poll-interval")) {
> > > > +		error = device_property_read_u32(dev, "poll-interval",
> > > > +						 &poll_interval);
> > > > +		if (error)
> > > > +			return error;
> > > > +		joy->polled = true;
> 
> 
> device_property_read_u32() return -EINVAL if property is not present, so
> we can write:

Understood. Both ways can work but when I do the next revision I'll change it
to this.

> 
> 	error = device_property_read_u32(dev, "poll-interval", &poll_interval);
> 	if (error) {
> 		/* -EINVAL means the property is absent. */
> 		if (error != -EINVAL)
> 			return error;
> 	} else if (poll_interval == 0) {
> 		dev_err(...);
> 		return -EINVAL;
> 	} else {
> 		joy->polled = true;
> 	}
> 
> > > > +	}
> > > > +
> > > > +	/*
> > > > +	 * Count how many channels we got. NULL terminated.
> > > > +	 * Do not check the storage size if using polling.
> > > > +	 */
> > > >  	for (i = 0; joy->chans[i].indio_dev; i++) {
> > > > +		if (joy->polled)
> > > > +			continue;
> > > 
> > > Whilst I can see why did this, it is a rather 'unusual' code structure
> > > and that makes me a tiny bit uncomfortable. However if everyone else
> > > is happy with this then fair enough (I see it was Artur's suggestion to
> > > handle it like this).
> > Yep, I'm fine with the way it is right now :)
> > 
> > Acked-by: Artur Rojek <contact@artur-rojek.eu>
> > 
> > > 
> > > >  		bits = joy->chans[i].channel->scan_type.storagebits;
> > > >  		if (!bits || bits > 16) {
> > > >  			dev_err(dev, "Unsupported channel storage size\n");
> > > > @@ -215,8 +244,14 @@ static int adc_joystick_probe(struct
> > > > platform_device *pdev)
> > > >  	joy->input = input;
> > > >  	input->name = pdev->name;
> > > >  	input->id.bustype = BUS_HOST;
> > > > -	input->open = adc_joystick_open;
> > > > -	input->close = adc_joystick_close;
> > > > +
> > > > +	if (joy->polled) {
> > > > +		input_setup_polling(input, adc_joystick_poll);
> > > > +		input_set_poll_interval(input, poll_interval);
> > > > +	} else {
> > > > +		input->open = adc_joystick_open;
> > > > +		input->close = adc_joystick_close;
> > > > +	}
> > > > 
> > > >  	error = adc_joystick_set_axes(dev, joy);
> > > >  	if (error)
> > > > @@ -229,6 +264,9 @@ static int adc_joystick_probe(struct
> > > > platform_device *pdev)
> > > >  		return error;
> > > >  	}
> > > > 
> > > > +	if (joy->polled)
> > > > +		return 0;
> > > > +
> 
> This is no longer compatible with the latest driver code as input device
> registration has been moved to the very end, so you actually need to move
> getting bugger and setting up cleanup action into the "else" clause of "if
> (joy->polled)", even though it adds indentation level.

I'm afraid I don't understand the issue you are describing.
input_register_device is called before this section, and since it's allocated
with devm we shouldn't need to clean it up in the event of an error, right?
The two functions below this line (including the one establishing the
joystick cleanup) are only required for non-polled devices.

Thank you.

> 
> > > >  	joy->buffer = iio_channel_get_all_cb(dev, adc_joystick_handle, joy);
> > > >  	if (IS_ERR(joy->buffer)) {
> > > >  		dev_err(dev, "Unable to allocate callback buffer\n");
> 
> Thanks.
> 
> -- 
> Dmitry
