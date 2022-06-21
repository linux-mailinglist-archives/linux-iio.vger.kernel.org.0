Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF247553DFC
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jun 2022 23:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355412AbiFUVlM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jun 2022 17:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355330AbiFUVlK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jun 2022 17:41:10 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07olkn2085.outbound.protection.outlook.com [40.92.15.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511A811834;
        Tue, 21 Jun 2022 14:41:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aM1nodT4A7gxi0l9dlW+x1drVRwwL42iJpPFBI7G7M2UAd+EGhHavwn1gBwu0th2pzVRMwEJ38/HoiPRpp/+hvFn+q8YGBNct6u598mEHSYwMdLOnPkyNQJURggt98K3lFDSdsqvCnABld6LhrFA7tIA/gSmcKWmt95sPoh+IOkn/29WzSjoitSbs7hsvqBpBOwhFIAzBDVPy6TOcr2X8tUNVZBvuk29l86Wbd8VQy1FIQvQ5R7uomu1ZaNNUz8kveUre82kKCb5LkWxVchgS04UsCpxY7WwOFkwgbW4a3ECZMSWiH1+M2ZTpsqzb9eC5M5wgv1RkBQa01jWgjVmWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nmwmJ6rVZfjQQpb7EYvqyN4KOpTLJ97aZHmOtoc7xeY=;
 b=CzTX/CDed0K26QOUAIGceNHfQ2OIe1ohZOEW8OsGjX3oskTwpDXrUsAdCkwhrdIhXzkkQfyUBDGdqF9agteMdA60NT8oIdY5CbB+/f4LLP2F/JLP4zFh2vUEKTsAz1hw4ivpnIfciLwtIiXu4f6tqtf2rNf9OpEHfIiNS3rBobnG2oJHPJzmW+B7IQi74T3vnqtAnl0dTcUZAhcKNxcfwtctdW2QsJwuLZ8ml/Nq4wS3FPaEwAGCXHivQIYehCC4qvQg3johF1ERSuC8l3gIMGXtaPxWc4djC2YCZSEAX0OvW2zyjehZfd1+sqgL0G4ejmV0EbLBGejEEsamSvnikw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmwmJ6rVZfjQQpb7EYvqyN4KOpTLJ97aZHmOtoc7xeY=;
 b=kLP3sET+pDFvTdS1DiQ1wPo4GfLEmOCbCz4nGOZNNnuEF3F/A/4D+JmBVlsVjkzc/Ss+e7BWX7EnbCtlX7/WJWtsVm4byhIBycQFC1RnoNcj4jOSuxWwxC/Hbq0+EQJrVFZwxGWrHsoluLmVpsBjAD30S91b5pDs+WQ5k/I8VApsZcBdgdOV+DnCFa1NXvMmxDeF4dEnuI/tHY3T3iLbsWoyfMC7v6VxRbP7fkZTHGS9bcMpb2IAwndvQ8PhEtUhGbPRIrA8VBIkIC9AXHxbSB3bJ+a45dgVv0rciTkxQwn3TsMziuINBEalrhHYhQIVvw6C9JekjmxzNgOk+FF9tQ==
Received: from SN6PR06MB5342.namprd06.prod.outlook.com (2603:10b6:805:f9::31)
 by PH0PR06MB8127.namprd06.prod.outlook.com (2603:10b6:510:ce::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Tue, 21 Jun
 2022 21:41:05 +0000
Received: from SN6PR06MB5342.namprd06.prod.outlook.com
 ([fe80::c0e4:f1d:b373:4360]) by SN6PR06MB5342.namprd06.prod.outlook.com
 ([fe80::c0e4:f1d:b373:4360%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 21:41:05 +0000
Date:   Tue, 21 Jun 2022 16:41:01 -0500
From:   Chris Morgan <macromorgan@hotmail.com>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Chris Morgan <macroalpha82@gmail.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        maccraft123mc@gmail.com, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        dmitry.torokhov@gmail.com, Paul Cercueil <paul@crapouillou.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 2/3] Input: adc-joystick - Add polled input device
 support
Message-ID: <SN6PR06MB5342A21E55CF37B348D6F48FA5B39@SN6PR06MB5342.namprd06.prod.outlook.com>
References: <20220613192353.696-1-macroalpha82@gmail.com>
 <20220613192353.696-3-macroalpha82@gmail.com>
 <ec496fcf808d73fe356d1961d89bf1ff@artur-rojek.eu>
 <SN6PR06MB5342762DE16AFC607CA9D5F9A5AD9@SN6PR06MB5342.namprd06.prod.outlook.com>
 <cdb956639e9550b287db31b762f7b764@artur-rojek.eu>
 <20220619163230.3130be79@jic23-huawei>
 <8225d239df59501b51fa71bac625827e@artur-rojek.eu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8225d239df59501b51fa71bac625827e@artur-rojek.eu>
X-TMN:  [nVMyWaum9uik7h1C3kXHpcgkAQx1V9I0n89LF+/H5Cgn1RLPwMzBWf5yZvjrfJSEnsR5HZYxHoM=]
X-ClientProxiedBy: CH2PR18CA0004.namprd18.prod.outlook.com
 (2603:10b6:610:4f::14) To SN6PR06MB5342.namprd06.prod.outlook.com
 (2603:10b6:805:f9::31)
X-Microsoft-Original-Message-ID: <YrI67Xa74f3xtUiv@Dixie>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a0939de-d4fd-48b6-6964-08da53cebdec
X-MS-TrafficTypeDiagnostic: PH0PR06MB8127:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bKUPekyRbbcOuolJp9Ajcpz33iHv2x6mTdPRToQ40kL01+IZj2wpfSdFgv7Y5r369EPnTHMj3svr/vzdeuLcesIj7EYpSAbuCmGrOh7ftMEBRPVCwPZTzgYYD8nPxTW9ylPtWPza/YUptqR7n6qEb0DDvY2Nk6HWr8pyE2Ql6nIIvLpjLqwne20Fc31x/JTVCV/FDPX8lv/1BsFFuObrZ5Y70MaFoOnHN+V6Z+SWHdfPYxKeo1l1jlNafZpEwgS/1GqzrNEukY4uRqrGHxTu9ISaQdGvvk2kAhg1YQSyJkbFq9vJyR0L/8bcBX/YxhBUc2zTNp1omI2JfTSFR5BQDS9Nwp8EYMkI1LHMHezZGGnaxnqXfZVYIyZ60Q+BgUp/yI6l5xaLKSKK68svh/bRuXqkiMscCIyMMxO0AUJVsZZMQ8wYUyCA9xBDO4RU/wLCAtRy2AmN/QgxY/A6so7wv9SSwqFTAMiCPAt79dnY2/QQ8pyi6LZ8Zp0joji6ghS0llmZGv5zibpE/W4hGWKcdkvvalJS6spKxCG/kdtZVTz+3yS8puG42qr+5wOVaIMRGkwQsAFJgNEvEzTODrvvZe8nxUOz21e0/68lN91GgIq7+h2qMrPqUFU6UsYIMTxL
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?140InzGRrUad7qqyouWDsJ7p3UmHE+ZWdld50f6IQstWT9Fcv+CbZ9MDeX1t?=
 =?us-ascii?Q?F+ZDuCXIwqohWOPMwsP8PbXDdHFgCrPdzHn5XwyLjJzyDodRsFnB5kNQxbHp?=
 =?us-ascii?Q?S20PRAo78Fb1LisgNaibJvPx+/chRvjEl+/r3j5Qg+914CgyW3FoaFGkrCWa?=
 =?us-ascii?Q?RtMWrLFLVzg6Hm+r3G4n5MyRop/ncwlM4/lc3pmFnyy1zbpxFzuA5VlhSqDZ?=
 =?us-ascii?Q?/sbUtXj65mJQPlqtI4/4Yi+ga2O7540RzKLu+SHSeS6Dkecfym3NYhTYaxtQ?=
 =?us-ascii?Q?6SWUNGAF0z0S5/DtBBm+opm7DLz02Xumfrbn9SfC4sdXA75P6sOBNrAERuBF?=
 =?us-ascii?Q?CPVviOX7tLRhx3ajNpk+G1wA5aJwWHZyg4+n+G31V43x+xP2Z3QAC49ydnai?=
 =?us-ascii?Q?iuNEkaFQvwuaF2TSQ8hmoGcoLI1Lk+bdxiHVWd/o7ascgMtjJ+eKCMz1NCC2?=
 =?us-ascii?Q?PF/ULGchXavStf8FAsLaj25COYbvDHizpizWmbsrFvVYUZbTIix0fOYUy2HU?=
 =?us-ascii?Q?PcAnAMx/NOY2Ws6wPUScY6bK24sr6gNKO+B9JxQAsGOW45e+eOHSHBRGtxty?=
 =?us-ascii?Q?8zZdrE+9cTz2N77D101TQYivyagw5mE5S6Ap0RiTYlU4x8CIGckkzRoXMPzR?=
 =?us-ascii?Q?SR8ciVpc5LwNWP+isO95WNCYa1DYpqCntr8V0X4e3tR2G4lgHaN8iWJ/gryz?=
 =?us-ascii?Q?PUKRe6WmLAOzp9SjTZGNeBDOdtmlInLvddtkedvQDM/xlZ9P+La4BCzQRr6t?=
 =?us-ascii?Q?wXlO/ueK3DbWHGlq2aEuNXC9DbMGVyO+F/jA+CUV4pEzZQ+xb/bI3lvOfVb/?=
 =?us-ascii?Q?lgEz5a6fmbC5eAPATSGhxJViWmvdiBBdbCfZDel6vTrkYiILrNNRsgC7LfiW?=
 =?us-ascii?Q?svng+Mnd1uC+UdB80FqTLFmDY9aZ3T56GWeMVFBS83tPa4w18WrT4AAbX3zh?=
 =?us-ascii?Q?iUtb6qz0SwOrkFwKwe3/Wo1Hd0Uvl4EIpgXP2UXmJUAPNqyRHUbjLOvHDQnP?=
 =?us-ascii?Q?q+/dVc3RKykuKpj1FsRvXexVlmQa1BGHBIy/jpAMycUbWITV+C//Fq7XYG5s?=
 =?us-ascii?Q?w0X179W+TFh7diPahlSP2UBHumufTAIwMJC8TdbCbRxgFDrg+tV01FYzDa4k?=
 =?us-ascii?Q?8bd4r6aSivx3Ykgs3oC1yKrxTQuus615iEeWp4O2Vvk7seqsIuHeZUqfDyRM?=
 =?us-ascii?Q?++A12/ToLnD4YB2Xi3pqveewSW6PNNx6NFfl7GmPEsDuNiX5QvKVVL6tdmzv?=
 =?us-ascii?Q?i7l+YPGy5d+7gSt8LVh5vpKjsbjmvcOLJRpJmq6xLTa2ukcM58NgyszL+lGQ?=
 =?us-ascii?Q?FHXtmqds01UTpaj75eDlFRYaPLRKezWR01VSTh40z+3IRCAc5xHxQIOiEq46?=
 =?us-ascii?Q?pwqOQ1cY1f4jUdlsPa6U4a1PkF0hFRoXYYSm9Z8HRy97mIJwbVBPkbyCbmMF?=
 =?us-ascii?Q?8zADMANBNTUE6isvoZ/DYJZOBiw3CleRxdxHc9+KrVbLjuRzHg/rzmlQcd8O?=
 =?us-ascii?Q?k+GHJBzqs87+V+WzMKURO3INBWBbAvSirDqX?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-89723.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0939de-d4fd-48b6-6964-08da53cebdec
X-MS-Exchange-CrossTenant-AuthSource: SN6PR06MB5342.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 21:41:05.0476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR06MB8127
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jun 19, 2022 at 06:31:17PM +0200, Artur Rojek wrote:
> On 2022-06-19 17:32, Jonathan Cameron wrote:
> > On Sat, 18 Jun 2022 15:08:29 +0200
> > Artur Rojek <contact@artur-rojek.eu> wrote:
> > 
> > > On 2022-06-15 17:12, Chris Morgan wrote:
> > > > On Wed, Jun 15, 2022 at 03:43:07AM +0200, Artur Rojek wrote:
> > > >> On 2022-06-13 21:23, Chris Morgan wrote:
> > > >> > From: Chris Morgan <macromorgan@hotmail.com>
> > > >> >
> > > >> > Add polled input device support to the adc-joystick driver. This is
> > > >> > useful for devices which do not have hardware capable triggers on
> > > >> > their SARADC. Code modified from adc-joystick.c changes made by Maya
> > > >> > Matuszczyk.
> > > >> >
> > > >> > Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> > > >> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > > >>
> > > >> Hi Chris,
> > > >>
> > > >> Comments inline. I also Cc'd Paul and Jonathan, who were attached in
> > > >> v2.
> > +CC linux-iio
> > 
> > > >>
> > > >> > ---
> > > >> >  drivers/input/joystick/adc-joystick.c | 52 +++++++++++++++++++++------
> > > >> >  1 file changed, 41 insertions(+), 11 deletions(-)
> > > >> >
> > > >> > diff --git a/drivers/input/joystick/adc-joystick.c
> > > >> > b/drivers/input/joystick/adc-joystick.c
> > > >> > index 78ebca7d400a..dc01cd0214d2 100644
> > > >> > --- a/drivers/input/joystick/adc-joystick.c
> > > >> > +++ b/drivers/input/joystick/adc-joystick.c
> > > >> > @@ -13,6 +13,10 @@
> > > >> >
> > > >> >  #include <asm/unaligned.h>
> > > >> >
> > > >> > +#define ADC_JSK_POLL_INTERVAL	16
> > > >> > +#define ADC_JSK_POLL_MIN	8
> > > >> > +#define ADC_JSK_POLL_MAX	32
> > > >> > +
> > > >> >  struct adc_joystick_axis {
> > > >> >  	u32 code;
> > > >> >  	s32 range[2];
> > > >> > @@ -26,8 +30,21 @@ struct adc_joystick {
> > > >> >  	struct adc_joystick_axis *axes;
> > > >> >  	struct iio_channel *chans;
> > > >> >  	int num_chans;
> > > >> > +	bool polled;
> > > >> >  };
> > > >> >
> > > >> > +static void adc_joystick_poll(struct input_dev *input)
> > > >> > +{
> > > >> > +	struct adc_joystick *joy = input_get_drvdata(input);
> > > >> > +	int i, val;
> > > >> > +
> > > >> > +	for (i = 0; i < joy->num_chans; i++) {
> > > >> > +		iio_read_channel_raw(&joy->chans[i], &val);
> Perhaps check the return value and leave early on error.

Okay, I'll do that.

> > > >> > +		input_report_abs(input, joy->axes[i].code, val);
> > > >> > +	}
> > > >> > +	input_sync(input);
> > > >> > +}
> > > >> > +
> > > >> >  static int adc_joystick_handle(const void *data, void *private)
> > > >> >  {
> > > >> >  	struct adc_joystick *joy = private;
> > > >> > @@ -215,8 +232,19 @@ static int adc_joystick_probe(struct
> > > >> > platform_device *pdev)
> > > >> >  	joy->input = input;
> > > >> >  	input->name = pdev->name;
> > > >> >  	input->id.bustype = BUS_HOST;
> > > >> > -	input->open = adc_joystick_open;
> > > >> > -	input->close = adc_joystick_close;
> > > >> > +
> > > >> > +	if (device_property_read_bool(dev,
> > > >> > "adc-joystick,no-hardware-trigger"))
> > > >> > +		joy->polled = 1;
> > > >> As mentioned in v2, I don't think a DT property is required here.
> > > >> Assuming
> > > >> the polled mode is a fallback for devices with no buffers, just do:
> > > >> ```
> > > >> 	joy->polled = !(joy->chans[0].indio_dev->modes &
> > > >> 			INDIO_ALL_BUFFER_MODES);
> > > >> ```
> > > >
> > > > Understood. I attempted this and noticed that it was showing I have
> > > > INDIO_BUFFER_TRIGGERED in addition to INDIO_DIRECT_MODE (the
> > > > INDIO_DIRECT_MODE is the only one specified at the hardware level
> > > > though). Should I just check for INDIO_BUFFER_SOFTWARE &
> > > > INDIO_BUFFER_HARDWARE instead? I think it's possible that the inclusion
> > > > of the industrialio_triggered_buffer module in my kernel is adding
> > > > this to the channel somehow?
> > > Having INDIO_BUFFER_TRIGGERED means that your saradc is capable of
> > > using
> > > the existing flow. You should be able to register a software trigger
> > > and
> > > use the adc-joystick driver without further issues.
> > > That said, this is where it gets problematic - there is no way to
> > > create
> > > an IIO trigger via Device Tree, since triggers don't describe any
> > > piece
> > > of hardware, and you shouldn't need to register it at runtime
> > > (configfs/sysfs) for communication between two kernel drivers
> > > either. At
> > > the same time, it's not adc-joystick's job to register an external
> > > trigger.
> > > 
> > > Jonathan,
> > > I don't know what the proper approach to this should be, perhaps you
> > > could assist?
> > 
> > You are correct in your description above. Device tree folk take the
> > view
> > that sysfs / hrtimer etc triggers are a policy decision so don't belong
> > in device tree.  In general you need some userspace code to stitch up
> > the trigger anyway (even ADCs that provide triggers of their own often
> > have several).
> > 
> > An alternative that may make sense here would be for the adc-joystick
> > driver to provide a trigger of it's own. That's easy enough to do,
> > but as things stand we don't provide a way to control the attached
> > trigger from other kernel drivers (i.e. you can't do the equivalent
> > of writing current_trigger for another device).
> > 
> > It's probably not implausible to add that though.  Is it worth it for
> > a joystick (vs doing what is done here), maybe not.
> > 
> > It would be worth doing if we cared about high performance (for some
> > ADCs
> > anyway) but here we don't really so the polled read functions are fine.
> > 
> > Note many ADC drivers only support running in either polled or buffered
> > mode in IIO because polling random channels when doing highly optimised
> > accesses tends to make the drivers complex.  Hence you might find this
> > doesn't work for all setups...
> > 
> > Thanks,
> > 
> > Jonathan
> 
> Jonathan,
> thanks for the detailed answer.
> 
> Chris,
> In light of the above, I think the best course of action should be to keep
> your polling code. It looks like your saradc has introduced [1]
> `INDIO_BUFFER_TRIGGERED` support exclusively for this very (adc-joystick)
> case. This means we can't use `indio_dev->modes` to determine whether the
> joystick can be polled, otherwise we might break behavior of existing
> hardware. I suggest that we get back to passing this intention via optional
> `poll-interval` DT property, that enables the polling path if present
> (indiscriminately of the IIO mode). Let's see what the Device Tree folk say
> about that :)
> 

Thanks. While I know there is a very strict policy of "don't break userspace"
I'm not aware of any consumers of the rockchip sardac using the adc-joystick
in production. I mean, it's in the tree for this one device but to this day
no one is shipping a distro with it to my knowledge, especially since the
driver has a major known issue I'm not able to fix at current time (has to do
with channels 1 and 2 being used instead of 0 and 1 for this specific SARADC).
What I'm getting at is if the current situation is wrong by adding the 
INDIO_BUFFER_TRIGGERED I don't think it's too late to change it right now.

Would the current poll code be best given the circumstances then? If you think
so, I'll go ahead and make all requested changes and resubmit it. I think I'm
understanding that what you want is for us to check for the existence of the
property of "poll-interval" which is the polling time in milliseconds. If this
value is present, use the polling code and if this value is not present, use
the existing code (regardless of what the hardware supports or doesn't).

Thank you once again for all your help and guidance.
-Chris

> Cheers,
> Artur
> 
> [1] https://nam12.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Fcommit%2F%3Fid%3D4e130dc7b41348b13684f0758c26cc6cf72a3449&amp;data=05%7C01%7C%7C43ade3c4216a47079d5208da52112487%7C84df9e7fe9f640afb435aaaaaaaaaaaa%7C1%7C0%7C637912530824693621%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=Gorf7r9PJr1CDBbRKVNXnRyBJBw2cy%2FLv9tPP24Q5B0%3D&amp;reserved=0
> > 
> > 
> > 
> > > 
> > > Cheers,
> > > Artur
> > > >
> > > > Thank you.
> > > >
> > > >> > +
> > > >> > +	if (joy->polled) {
> > > >> > +		input_setup_polling(input, adc_joystick_poll);
> > > >> > +		input_set_poll_interval(input, ADC_JSK_POLL_INTERVAL);
> > > >> > +		input_set_min_poll_interval(input, ADC_JSK_POLL_MIN);
> > > >> > +		input_set_max_poll_interval(input, ADC_JSK_POLL_MAX);
> > > >> > +	} else {
> > > >> > +		input->open = adc_joystick_open;
> > > >> > +		input->close = adc_joystick_close;
> > > >> > +	}
> > > >> >
> > > >> >  	error = adc_joystick_set_axes(dev, joy);
> > > >> >  	if (error)
> > > >> > @@ -229,16 +257,18 @@ static int adc_joystick_probe(struct
> > > >> > platform_device *pdev)
> > > >> >  		return error;
> > > >> >  	}
> > > >> >
> > > >> > -	joy->buffer = iio_channel_get_all_cb(dev, adc_joystick_handle, joy);
> > > >> > -	if (IS_ERR(joy->buffer)) {
> > > >> > -		dev_err(dev, "Unable to allocate callback buffer\n");
> > > >> > -		return PTR_ERR(joy->buffer);
> > > >> > -	}
> > > >> > +	if (!joy->polled) {
> > > >> > +		joy->buffer = iio_channel_get_all_cb(dev, adc_joystick_handle, joy);
> > > >> Please maintain line discipline of 80 chars to stay consistent with
> > > >> the rest
> > > >> of this driver.
> > > >
> > > > Understood, sorry about that.
> > > >
> > > >> > +		if (IS_ERR(joy->buffer)) {
> > > >> > +			dev_err(dev, "Unable to allocate callback buffer\n");
> > > >> > +			return PTR_ERR(joy->buffer);
> > > >> > +		}
> > > >> >
> > > >> > -	error = devm_add_action_or_reset(dev, adc_joystick_cleanup,
> > > >> > joy->buffer);
> > > >> > -	if (error)  {
> > > >> > -		dev_err(dev, "Unable to add action\n");
> > > >> > -		return error;
> > > >> > +		error = devm_add_action_or_reset(dev, adc_joystick_cleanup,
> > > >> > joy->buffer);
> > > >> Same here.
> > > >
> > > > Ditto.
> > > >
> > > >>
> > > >> Cheers,
> > > >> Artur
> > > >> > +		if (error)  {
> > > >> > +			dev_err(dev, "Unable to add action\n");
> > > >> > +			return error;
> > > >> > +		}
> > > >> >  	}
> > > >> >
> > > >> >  	return 0;
