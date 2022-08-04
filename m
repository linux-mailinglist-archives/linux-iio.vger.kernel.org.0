Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3798558A09E
	for <lists+linux-iio@lfdr.de>; Thu,  4 Aug 2022 20:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239405AbiHDSkW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Aug 2022 14:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237281AbiHDSkV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Aug 2022 14:40:21 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2047.outbound.protection.outlook.com [40.92.19.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FA854AFA;
        Thu,  4 Aug 2022 11:40:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gSXz5UCOL3PN3jf+kxbgjqkxQWvptV9dvBNFIITVMuOysgB2wbrHKoQxAJ6DZFiWF81z8oeT6HMlDbVnuyhxmHx0JrTLnwgbx3h40PNk7L3vO9xCfRwwmlSTGvsl0eJ28CuK6sJK65Xx0xJUUnu1Ohwpw3DZd/vT0u0CcjMEx7349/naUC6ezqI9oY4ISFla3DNuYyHxx1sngxf9Z7W8v1zkNU1c+0CX51Ix6zMrIEHae10rdqzndM3Ejq/klQmedl0cltdUcrTzBgOnUYqLGQdljh1gE8dNaawVN9Mz9z8t+JtHEZ4E9Gs4kfouAKIl5fXj5TmixtEXdqhYUpBpeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJhIPpl5+aDDP8EpTKNNyWewMB2dCFaoE3ObGWeBo3U=;
 b=IzYYxiacpKkIfYZFFCCZuItrHBF6h7BYmVzJq36lkq8RAZqHJ4XP6oXxbAwtO4UOzKK+10iyS0XQ+ncQf4RzKNze8munqSFxL7KtNzQ/NY/TLycidoJzngp30gutgkRg2xl4ZByoquPNzuTUjMCCkcAtexx2Qvp5CmUSCwuiDxIEUpoLxAz96/4uolcbo4euKkMA1hhHwrGS1SeyDRbxQY5iosYqJSPggYpCvMYWUTNfcr0w+J9+mbl9aGVdvefuG1h+H/BH50gFl48o/ra+CkdZDI6bgQcfIXuRuqmVq9I2UyWuFjFtcqTzLwlApoI4zE5lhoaAK2s2SbiYBRpcRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJhIPpl5+aDDP8EpTKNNyWewMB2dCFaoE3ObGWeBo3U=;
 b=S9ktHbvt4g9b7xTGw8lDTwlvX0kZLI63FuH1d+KBJQqY/87RfqdY4nKYU/G5rgWfvW8J/6dfL0R1u9o+qGqL5InSKqcAOe+qM6l3Mc8Jw8Nx0ZqB0CC2Qlal3AlbWLvLjMMCdIfyl+zujXPEt0x3KHZVHvPe0uSi3esgd80X3I4FVj7RpfJt8krj9D4EFq7SC22LEVcvJ5cwhcwt1NVkJIXvuMlT4h7ZNAHhKzaQ7uveAihJ7PK36BRHCJQyAfYT4MmZ+l7QuwBr0mRBfKOE4QAeEUZ0K2RrtYZsYHx4tFh3QUPZYYZMf0PXH+Cwtac6b6E99z3Kh5sE9+mO8hSpuA==
Received: from SN6PR06MB5342.namprd06.prod.outlook.com (2603:10b6:805:f9::31)
 by BN7PR06MB3876.namprd06.prod.outlook.com (2603:10b6:406:8d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 4 Aug
 2022 18:40:17 +0000
Received: from SN6PR06MB5342.namprd06.prod.outlook.com
 ([fe80::1474:5d4a:b9da:946c]) by SN6PR06MB5342.namprd06.prod.outlook.com
 ([fe80::1474:5d4a:b9da:946c%5]) with mapi id 15.20.5482.016; Thu, 4 Aug 2022
 18:40:17 +0000
Date:   Thu, 4 Aug 2022 13:40:10 -0500
From:   Chris Morgan <macromorgan@hotmail.com>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Chris Morgan <macroalpha82@gmail.com>, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org, dmitry.torokhov@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, jic23@kernel.org, paul@crapouillou.net,
        Maya Matuszczyk <maccraft123mc@gmail.com>
Subject: Re: [PATCH v10 2/3] Input: adc-joystick - Add polled input device
 support
Message-ID: <SN6PR06MB5342A254630D12D3F06BF52AA59F9@SN6PR06MB5342.namprd06.prod.outlook.com>
References: <20220803174505.21420-1-macroalpha82@gmail.com>
 <20220803174505.21420-3-macroalpha82@gmail.com>
 <5feecb7813f9718c3d980fe548997bff@artur-rojek.eu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5feecb7813f9718c3d980fe548997bff@artur-rojek.eu>
X-TMN:  [5kzMy7HUC+bzFh4/E6fpI1+bTkI6Bll7]
X-ClientProxiedBy: DM6PR06CA0088.namprd06.prod.outlook.com
 (2603:10b6:5:336::21) To SN6PR06MB5342.namprd06.prod.outlook.com
 (2603:10b6:805:f9::31)
X-Microsoft-Original-Message-ID: <20220804184010.GA15841@wintermute.localdomain>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96d40c00-f4f2-4998-5f1c-08da7648c6b9
X-MS-TrafficTypeDiagnostic: BN7PR06MB3876:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /5o+I7jXDafgyI6LMQETU29TmB8MDLXd3OjAmrerCbr9pRSkFCw5XS9I74okdnja5EhESN1L+vTiiSwz1PZolvu+AtuVk1EfcUJtZfUzg5iu9LTJ5bJQE/ffOSFbKWjZPqsOCruzYWkDdoBG1kD1QsE9zFJFKWovnwfxA5oKjr+9gnqMN0rboR5f3YBM118GHPwJBtbue2wn7dyf4U2bMrk6DNnYN9ARupZFqJ1kz77jWA7pymPqRu3oo+okBvnT6Xsfuf7w7tyZWQ1jVu5ASlqpuo4P/4UEnFECtb5rpEx1mxBJHD16Os+AYzxq9io1BUfRHosBFmBTYrjdy81S4jqYaGQ7HR6saFc2x1/1wO9vSoaqsN3eNYPSyBnyH905m0SzMltRQMjhrpqLxNI6GN3HJae4smp3vHNS/826ToZH42yk5JAxuDrf/RVvAtvA27VvsPwc8d2j5UskRZvc0zck0dsEyT7xBPfBbyYX5HD9iTodP1Es4btFzJUZ5vU4A7IH8AWCYZupXyDGea55YvQP+alH4/N0q0PNIDiJskPR82dd1um9mDo0l+WQ4+z2RcNjkpZmgYsK/CrldA/ER82KuIZLvxa6RdlrLZmsYMVjp71wAwF98pA7swQIH0iHILaQBV8e6Boll51VyF7fyrV8uXeVB1hNM5YkfvYD7qJBIDKpmAfdua7cEEeDvFIX
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JsfEqNp1U8+TGARnLASx87Mposqf4FoBjerY2Te2XOBTJQaSxqzkKAuX8Pct?=
 =?us-ascii?Q?brYDHCNcuB1blUGCuLs/wRYt9z2EKWcO8G1G4ckOF9lH2uTC86+fQACqdi2s?=
 =?us-ascii?Q?L3yO5uriuKgeH6laOkRVHx8UunqwTXgDFIIB7ZWiry551IhEPj0qWYmF06qw?=
 =?us-ascii?Q?xlMDZxWEoglK0cl8OJdfMoVpUMo0uUfK3VFAgvLcpQQHVQOHhyli2/sKSsMK?=
 =?us-ascii?Q?f6JOSk0SuqBxTtH1+XNdnmJkY4DDKALqcpho6WECxwLMmSPMBgwzNfsDFJd5?=
 =?us-ascii?Q?EgaPth7tTjB/D6gBEz9VIGu0dxDR6M+o8eorFQJp0b7iNPQfKAaWoTLtimHU?=
 =?us-ascii?Q?rBeYXYiMdlcmdvkgKGIUwQ24NaC5/RS2kzStpq2gZ8hTHiPhkMJk9tEahant?=
 =?us-ascii?Q?0wzFNKCI4kWkjeh8HJUWcMOrOYU6Ld+1PKYxokA4v2G0VQRx73b23MhmqLKg?=
 =?us-ascii?Q?2ghnyVx1xEwp2BysNoagWjfBkui+qsjMlm/AOY3L2UX+EfDxm2OlEoJQWHTj?=
 =?us-ascii?Q?8A+E/RS5hwh6++C9MNCABJRhYLwlTcPYsSj1gaWkN3LaczspFfjBvtNsyTHJ?=
 =?us-ascii?Q?Py3bIC0s4317tEuZachVmtJke2cSZhZiRa924CPguNaR25t3n8rW69y8HWHe?=
 =?us-ascii?Q?Lv76EvE1/d7eYKZw3oLZJc+sF3q7B5GRl66ji4+BEhMMgI7jSuw+9iIg9Jvq?=
 =?us-ascii?Q?AjsMWRaD9cw9uCFLrTh4WYOitvB2kFPVujsz4c2b2NSBetKB+cEbCEAjJtr4?=
 =?us-ascii?Q?lZF0G/OuaY01P747BuEYsa0wzu/OqbtBYpJnuw9Qtv3GTE28AFh6mh4sHsU/?=
 =?us-ascii?Q?tsQ6GC5Xk8Nhxq36ig4fjtefvQwbzgHqTLCDgQBjPFt2TBYC/Tv/OiOUfTGR?=
 =?us-ascii?Q?kcWeTU/pBSVPg975keN2eqtJ5hBpSS1HH/TvT3BPwn1PhFSkWahAwLxn1zOp?=
 =?us-ascii?Q?jcRTbDUkNEzga4VqAdxM9GEiLyIVzZn2qYdkoT9klbGZ+QLkmwCPoCR82MVo?=
 =?us-ascii?Q?GBWBvXnbAe5Bnw/w/Bh/irTr7tMNX+lJ81A6OmnMytofb2vVK5npV3SrtClr?=
 =?us-ascii?Q?q4YLIeOfNfUOKs/PQitqU9jd/PwHxeXkzqX5Irl2w+4rHJnqg0pe0fVT6Et4?=
 =?us-ascii?Q?GlDG9RGA9a2eoZ8mWIVCRjYUJPnfZmG/3lDr0JNYqM+t88DkQpjhaCnZPpkt?=
 =?us-ascii?Q?rAzhh2akODtJYO8SgLicxpvzy/gbX44RdUYYzIjWOwI62YVcy6hjNztsuOrJ?=
 =?us-ascii?Q?xQwm6XGO5BWRvyxdZOnJP7QHwHqqlDcwunpHbtHHUg=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-89723.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 96d40c00-f4f2-4998-5f1c-08da7648c6b9
X-MS-Exchange-CrossTenant-AuthSource: SN6PR06MB5342.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 18:40:17.8387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR06MB3876
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Aug 03, 2022 at 08:03:17PM +0200, Artur Rojek wrote:
> On 2022-08-03 19:45, Chris Morgan wrote:
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
> Chris,
> some minor details inline.
> >  drivers/input/joystick/adc-joystick.c | 53 ++++++++++++++++++++++++---
> >  1 file changed, 47 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/input/joystick/adc-joystick.c
> > b/drivers/input/joystick/adc-joystick.c
> > index 78ebca7d400a..a288ebfe254e 100644
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
> > @@ -179,6 +194,7 @@ static int adc_joystick_probe(struct platform_device
> > *pdev)
> >  	int error;
> >  	int bits;
> >  	int i;
> > +	unsigned int poll_interval;
> > 
> >  	joy = devm_kzalloc(dev, sizeof(*joy), GFP_KERNEL);
> >  	if (!joy)
> > @@ -192,11 +208,25 @@ static int adc_joystick_probe(struct
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
> > +	/*
> > +	 * Count how many channels we got. NULL terminated.
> > +	 * Do not check the storage size if using polling.
> > +	 */
> >  	for (i = 0; joy->chans[i].indio_dev; i++) {
> > +		if (joy->polled)
> > +			continue;
> >  		bits = joy->chans[i].channel->scan_type.storagebits;
> >  		if (!bits || bits > 16) {
> > -			dev_err(dev, "Unsupported channel storage size\n");
> > +			dev_err(dev,
> > +				"Unsupported channel storage size\n");
> This change is now unnecessary, as the line can fit in 80 chars again.
> >  			return -EINVAL;
> >  		}
> >  		if (bits != joy->chans[0].channel->scan_type.storagebits) {
> > @@ -215,8 +245,14 @@ static int adc_joystick_probe(struct
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
> > @@ -229,13 +265,18 @@ static int adc_joystick_probe(struct
> > platform_device *pdev)
> >  		return error;
> >  	}
> > 
> > -	joy->buffer = iio_channel_get_all_cb(dev, adc_joystick_handle, joy);
> > +	if (joy->polled)
> > +		return 0;
> > +
> > +	joy->buffer = iio_channel_get_all_cb(dev, adc_joystick_handle,
> > +					     joy);
> Same here.
> >  	if (IS_ERR(joy->buffer)) {
> >  		dev_err(dev, "Unable to allocate callback buffer\n");
> >  		return PTR_ERR(joy->buffer);
> >  	}
> > 
> > -	error = devm_add_action_or_reset(dev, adc_joystick_cleanup,
> > joy->buffer);
> > +	error = devm_add_action_or_reset(dev, adc_joystick_cleanup,
> > +					 joy->buffer);
> And here.

This one comes in at 82 when I make it a one-liner. I'll update the others but
leave this one here alone.

Thank you.

> >  	if (error)  {
> >  		dev_err(dev, "Unable to add action\n");
> >  		return error;
