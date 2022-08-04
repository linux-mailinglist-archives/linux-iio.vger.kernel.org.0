Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC0958A0EF
	for <lists+linux-iio@lfdr.de>; Thu,  4 Aug 2022 20:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235043AbiHDS4V (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Aug 2022 14:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbiHDS4U (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Aug 2022 14:56:20 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2064.outbound.protection.outlook.com [40.92.42.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2677175B9;
        Thu,  4 Aug 2022 11:56:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B6tKgAReaaxlgC299Z/7h/HdA2QSpyGvGK7lHvYqqqYFGpOJz6s0rIQGnPgXDdlPOVHmyBQWhNwvroDQQ2ra/7VXP+QMBab8zR/C7eXFSGkfGDnVrRS7O0eh1rg2KL0hoQ6f80PH48GLuyG9t4pupQ7bCE6qCmXHSx7YrlVPxafuHbNFSMZuImSXPfWH1HOI8ZDleOwpNp60K6Sd1VZ42ZiMw9+yldS2jtg6vA/heVm+IZTZ/xWEe6cT7MJCLzGBVxy0lYNelVKhTEdJZNsGV9cGVtmlBdERq/p0Fc6ELy7RegfFuW4PDTBVEi/FiJa7zcrgqUjR4yd53RdDSUrxoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RirWpW3ZkPXDFyhjZ9qYXiAfw7ArBwSbXdfwwPcsFM8=;
 b=PXOqYg9rVHERcjEGU6a0TBf687E7a+Tk4oFYq3yYCME6NpmhTrfJhC2Dup4P8o3eGScIWoVtoF5Rtf2CRvONKrEEXeGTxKLZyqm61YkT64AceUPJI+qgDsN22Q/6RVLeJcm6hUvXZhsbgizC5rY+5nQ9Bo6S5PKFGv3Ww/dfXY/B44XBgXyquClWcB+f64XNJ0Uw/p5BtcpRm80qxx/a48XCI7oGBwnPpl6WP5hcjosA8LI1qNMrj0l0fsWkr8wtwwJLAb9/64dSt0xEZdQTbbuBD58+Tnd2IUnQsr85hR7KU3ElrKRqcogJCZXii0ffpcSUeWeW40X9ZUIAUuBBdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RirWpW3ZkPXDFyhjZ9qYXiAfw7ArBwSbXdfwwPcsFM8=;
 b=JNPqD62Zc/XtcpG+zhzSK/hx62ZbQkWjQ4SuGm76dZaC/Nhw5GJYcsdmRs9UBJmcP2pAdwBybfrc+aPmbvUyOGNeyi6AiYEeLEmv+IAr1yTdTFd1H7AWGUa2elZuZ3YCzhLHzje5ZX90KRWVEmL+PB4wCQiwnYiCjv27HhI9pSS3TJua8S5R83x0dyRdylIKiN4JfQDf/C7MkgtJNfJP7uSSdA+5qhXP0zyg3tuOBJxBn0zJCPyHtw/OoAP0Km8P0h0nsOs+yuFiMrNj4XFSnYWka8ZLoYGF/EZZfkgXMbVe5aBHZGeK+ioOqKbF7eGIlsMTnIunr4LNKWYgtZeuIg==
Received: from SN6PR06MB5342.namprd06.prod.outlook.com (2603:10b6:805:f9::31)
 by BYAPR06MB3862.namprd06.prod.outlook.com (2603:10b6:a02:8a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.15; Thu, 4 Aug
 2022 18:56:14 +0000
Received: from SN6PR06MB5342.namprd06.prod.outlook.com
 ([fe80::1474:5d4a:b9da:946c]) by SN6PR06MB5342.namprd06.prod.outlook.com
 ([fe80::1474:5d4a:b9da:946c%5]) with mapi id 15.20.5482.016; Thu, 4 Aug 2022
 18:56:14 +0000
Date:   Thu, 4 Aug 2022 13:56:08 -0500
From:   Chris Morgan <macromorgan@hotmail.com>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Chris Morgan <macroalpha82@gmail.com>, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org, dmitry.torokhov@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, jic23@kernel.org, paul@crapouillou.net,
        Maya Matuszczyk <maccraft123mc@gmail.com>
Subject: Re: [PATCH v10 2/3] Input: adc-joystick - Add polled input device
 support
Message-ID: <SN6PR06MB5342C21BF78B531E86BCE82FA59F9@SN6PR06MB5342.namprd06.prod.outlook.com>
References: <20220803174505.21420-1-macroalpha82@gmail.com>
 <20220803174505.21420-3-macroalpha82@gmail.com>
 <5feecb7813f9718c3d980fe548997bff@artur-rojek.eu>
 <SN6PR06MB5342A254630D12D3F06BF52AA59F9@SN6PR06MB5342.namprd06.prod.outlook.com>
 <ef8e0d24f9607b1957f0eaa6b6510ff3@artur-rojek.eu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef8e0d24f9607b1957f0eaa6b6510ff3@artur-rojek.eu>
X-TMN:  [gNySNyPvfUsewlcGEa8tjK0RJeQvNQy7]
X-ClientProxiedBy: SA9PR13CA0046.namprd13.prod.outlook.com
 (2603:10b6:806:22::21) To SN6PR06MB5342.namprd06.prod.outlook.com
 (2603:10b6:805:f9::31)
X-Microsoft-Original-Message-ID: <20220804185608.GA20984@wintermute.localdomain>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 323782db-300d-4ce0-a19a-08da764b00f7
X-MS-TrafficTypeDiagnostic: BYAPR06MB3862:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rrUnoJB5HC/Mg2rRMGHO55lmfoFRqgU4ZwshxCKSJPGGXDpWBIKLY48DSMEoCHrzWjapTowb8EIG35K3yvO6icAwlgBslyfcB6UgBXMj3VCAvEwPJ/AckFiOy/Ei4e3h97flXQHgqtthimDV2JRoew4gm55GuRkfg2IExeePbVyjYbwDZYDGmn65DGiLVI7zO/9nx/Nd2TaKK2zPkw5KP9endiU6GsuFq3QEW3PXspCHE1m35rBUIUFthxOpV2+4AvhKPJkXL+oH5QuLByYFESysb9wa/qYDPHP9oul04ywf0FFAsy2BH7y/cGTiF0Z78ys2usdX2EQ4bejVxR9MVJFPOJxhCYfVD7x0oAkDNLJt2C39aNLcawv+ABZjjbuwcJYgmiDL2uPXWXd/kL7Gv4X+9+iIe2+Bt26aLwjintk4BnWMtVuDaGjxYw2fMfq6781JIrhv2e1dNmncLNTVcd/Go4In2NPRQ3oDBT1EmNkLFrdyIxhwh/QS134KlTP6zzNL7akVdMUaTFsEvRzNE+HLb6H43A0zp/xbGxfd0Pqkm8XNcUcBlfc+ULmsB9jbID6DR1MMnzXhLvunw7uvEcY3FfjH/rDfRy2sdG3pVSH7+J9w8WoHS01vYwHJMPgmN8fIqolu1yWD/R6Jbnvp2JOAWN6NfmrP8MmdKfVNT+H3LZdPBGXPv3OwD8304gAs
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cz9qbyMgH/ogfxinA9j5TgLXt/qI5705rt5M4xTxwlLpIJIL48BD65tRWUgZ?=
 =?us-ascii?Q?XGeDqdbQARWTookPNzewPRtwdFEA08+ehIPSLBguEYaYcA9R1UL4xbj+HgtD?=
 =?us-ascii?Q?oXsn6hX68jFPWdaLFEuxQw5R88e1USiLGH91Ohqg7gYrp7iwl5AFpKLLtV2O?=
 =?us-ascii?Q?PLTslgFvrF0mW0a0Kcc6O5G6fLt8e2tc6k3fPyB9imBddg849zjOhqI/D3Sv?=
 =?us-ascii?Q?U2ULP09w/AsmtrPlcqkK7fGo11CY05yWapOwaNQjyC6avTotBM6LW25woUru?=
 =?us-ascii?Q?v4LqkYbESHaHXeQc2G/HvQo9KGECDWP9gJ3v1y8MAj4B51jbn+D9WlH7V0XD?=
 =?us-ascii?Q?twnlsZulxg1OOW7/sayiZ0O7TuMp9t6K2WVFgb4AgsaVfcjr5AZfcxzMpnou?=
 =?us-ascii?Q?q84kZGu23CC6Nqldkrwmp9RFu1z+UgvC5ODeGh9vk73zSvSCclg251D3/goz?=
 =?us-ascii?Q?SMTOCxWeYs0PX9hRmZTN54W2RWQDgvvhsKj09V9JLAQYCBhF15fwyXilMdZ9?=
 =?us-ascii?Q?SwwovKPNWRjFBTnxFna/CB5u1Jgxjx+bC5U2L1ymOjHIyEC0cEkAum/zqn4+?=
 =?us-ascii?Q?ghSBsv9CY24hWFKl7SloWqz0q5QmlIBQQyEhB7yFLp09UzZk0Cpsa2yOxISN?=
 =?us-ascii?Q?ecaebJ/f0QyhFnNMf2dc4OyvCF2h22h073LOiet+CoQ+CkifXEqcyd24wwVt?=
 =?us-ascii?Q?SwYscHYC4xsdW/qcWyCA43ht4yRO7NZKPwG7YEtbMBuL+KhSvZ14Exmw9VD9?=
 =?us-ascii?Q?LTsjdcXJudREYL8x/uJy34pgx3YL+Ox3gz4AQxroVMMTRZTL32gCnlx7SwkV?=
 =?us-ascii?Q?oTH3/Je4VihXGsvVQ4NNV3JucIh3SWqSdUDi2+kyTLNJLnX0oMWCijJ9PDl6?=
 =?us-ascii?Q?aoknY0UQbHRRzyd1SHZCIeq8Q66v4PshJs21V+AaJY1Quo88vMxYdAJjxquP?=
 =?us-ascii?Q?HJuwIcmvJ7otd9mAM3/IYnZvzST4bK+D3TFUt8ysRT+JAycAkqQld1+OKNLq?=
 =?us-ascii?Q?9CR571HYmZYizorO4Qo7NRWSQUSUB6sKNrbgNap1G0SQmZIuVleNtlGRxtaK?=
 =?us-ascii?Q?qCqUjTtvk/3DbnhRSKWj9Q4Q+etDo858giVDG2bf2qyYd/PmOQ5Gxu2c6DDq?=
 =?us-ascii?Q?m1juNTszolkrdOk73urdJBMzReF+qUPxvFAa3SFxx5UEa8jh1wsTIv1hj3ts?=
 =?us-ascii?Q?chnNbaBdsLwK1vCAEq45K3zyKTRAHdTi6+W0q3hY1pkI0uKescy19CmbsnyZ?=
 =?us-ascii?Q?5Bj4F/fPeZD+ywTC7qU2+aVEw0fTPvNKuTrtauoYYg=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-89723.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 323782db-300d-4ce0-a19a-08da764b00f7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR06MB5342.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 18:56:14.1887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB3862
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Aug 04, 2022 at 08:52:03PM +0200, Artur Rojek wrote:
> On 2022-08-04 20:40, Chris Morgan wrote:
> > On Wed, Aug 03, 2022 at 08:03:17PM +0200, Artur Rojek wrote:
> > > On 2022-08-03 19:45, Chris Morgan wrote:
> > > > From: Chris Morgan <macromorgan@hotmail.com>
> > > >
> > > > Add polled input device support to the adc-joystick driver. This is
> > > > useful for devices which do not have hardware capable triggers on
> > > > their SARADC. Code modified from adc-joystick.c changes made by Maya
> > > > Matuszczyk.
> > > >
> > > > Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> > > > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > > > ---
> > > Chris,
> > > some minor details inline.
> > > >  drivers/input/joystick/adc-joystick.c | 53 ++++++++++++++++++++++++---
> > > >  1 file changed, 47 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/drivers/input/joystick/adc-joystick.c
> > > > b/drivers/input/joystick/adc-joystick.c
> > > > index 78ebca7d400a..a288ebfe254e 100644
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
> > > > @@ -179,6 +194,7 @@ static int adc_joystick_probe(struct platform_device
> > > > *pdev)
> > > >  	int error;
> > > >  	int bits;
> > > >  	int i;
> > > > +	unsigned int poll_interval;
> > > >
> > > >  	joy = devm_kzalloc(dev, sizeof(*joy), GFP_KERNEL);
> > > >  	if (!joy)
> > > > @@ -192,11 +208,25 @@ static int adc_joystick_probe(struct
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
> > > > +	}
> > > > +
> > > > +	/*
> > > > +	 * Count how many channels we got. NULL terminated.
> > > > +	 * Do not check the storage size if using polling.
> > > > +	 */
> > > >  	for (i = 0; joy->chans[i].indio_dev; i++) {
> > > > +		if (joy->polled)
> > > > +			continue;
> > > >  		bits = joy->chans[i].channel->scan_type.storagebits;
> > > >  		if (!bits || bits > 16) {
> > > > -			dev_err(dev, "Unsupported channel storage size\n");
> > > > +			dev_err(dev,
> > > > +				"Unsupported channel storage size\n");
> > > This change is now unnecessary, as the line can fit in 80 chars again.
> > > >  			return -EINVAL;
> > > >  		}
> > > >  		if (bits != joy->chans[0].channel->scan_type.storagebits) {
> > > > @@ -215,8 +245,14 @@ static int adc_joystick_probe(struct
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
> > > > @@ -229,13 +265,18 @@ static int adc_joystick_probe(struct
> > > > platform_device *pdev)
> > > >  		return error;
> > > >  	}
> > > >
> > > > -	joy->buffer = iio_channel_get_all_cb(dev, adc_joystick_handle, joy);
> > > > +	if (joy->polled)
> > > > +		return 0;
> > > > +
> > > > +	joy->buffer = iio_channel_get_all_cb(dev, adc_joystick_handle,
> > > > +					     joy);
> > > Same here.
> > > >  	if (IS_ERR(joy->buffer)) {
> > > >  		dev_err(dev, "Unable to allocate callback buffer\n");
> > > >  		return PTR_ERR(joy->buffer);
> > > >  	}
> > > >
> > > > -	error = devm_add_action_or_reset(dev, adc_joystick_cleanup,
> > > > joy->buffer);
> > > > +	error = devm_add_action_or_reset(dev, adc_joystick_cleanup,
> > > > +					 joy->buffer);
> > > And here.
> > 
> > This one comes in at 82 when I make it a one-liner. I'll update the
> > others but
> > leave this one here alone.
> It doesn't relate to the polled input functionality anymore, so please
> remove it. I'll correct such minor mistakes with a larger cleanup patch
> eventually.

Sorry, I resent too fast. I'll wait until tomorrow and send this (one last
time hopefully) with this other line removed.

Thank you.

> 
> Cheers,
> Artur
> > 
> > Thank you.
> > 
> > > >  	if (error)  {
> > > >  		dev_err(dev, "Unable to add action\n");
> > > >  		return error;
