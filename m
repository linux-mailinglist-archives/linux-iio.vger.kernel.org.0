Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0477657A72C
	for <lists+linux-iio@lfdr.de>; Tue, 19 Jul 2022 21:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235642AbiGSTW7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Jul 2022 15:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbiGSTW7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Jul 2022 15:22:59 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02olkn2101.outbound.protection.outlook.com [40.92.44.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D14545E3
        for <linux-iio@vger.kernel.org>; Tue, 19 Jul 2022 12:22:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ox08k39fTpS2NdFqutItYDREBvLRB5uCtZLPag+FIQPgpJD/L5OrmEH/p/BhrjseYBXCEHKFGLkhNhQP9/vgtfbl3MIe6V/r8MBVkQVxQZH1zREgFunsIO/Vs4YPvPaPj2AqJKKOzkOIP3LtjefvMKwHvazEAGfaLZ03uZZLrC/a/a/AHQ7K5qb+ZWLOtZb1z4kvOy5cH+YQ+E4ZBaJ2cCD4aZJaCbU7SyTS9tVxVAUwo2N+HCrIlQ94c9Zdchx4J58Z0q++U5WdcxmEpZql3nRqoGoVgUpvfUoEe0uKVWHcY5246O1qP2oL1BfIfOI+balshaaery+j4Bk6gRf28Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4f/P3n+Qfo+K8hYVXkvtQz8DOA6xnJe6EnULX978tg=;
 b=GxxXQ3Dk3bOLgUHCIAq8WvNJk3QvsZ5czp+aWEJzdBvu6CH3bYWeIVjWJwKUh0Lj6fqga9Q/0JgMYE2VDy/YdDQeCWWxz9PxrGiR1ocTiO0QLWxRVs/FM7bRmRFU/Eh3t+2xPIBh2d8LtCyi1E7r6/BOBM7q0WfS9FFFrjJjTBvU7knuclpNQHwW2Xo5rP/qJZbc3822txEizbV9QQsyF4umJJp11/wJC+Zn79MWeVmWFJdxPeST88kS91nHXUSi4/5zRkuFWmAOHMjNnTSbVyEiCbDtV4qlBc3gxwmQXYSbNcYg/vueMrnWF7BuS7lbbV2Sqx6IiXpL6ML+6bk9Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4f/P3n+Qfo+K8hYVXkvtQz8DOA6xnJe6EnULX978tg=;
 b=fRR4ITbX5cJo3Zu+3ixS6dH/lIdBRYCstF24RcF2FLLSis/xKWYXg9CgXunkpDoXkocNH0MtkYybKHCUlr7uqJR1tjDCXl0j3/njVbHizRgckpqDAXBhMRbkTTk+YJhrI+T4rgrhnCA6HFn5eUWBjuFUSqBeRUJEQ1TDr2iTvHJmOSO0RAWMGyis7cFjBMxZwJ5dBF8ljNdzUoILuA9zTfsUHbMDAPO4avzizjLkEWO4RnNsICvyyZkeS5uHXhO+O6JLkzmEFhj07dSOjfrC0DCiFHzRx340xl0RIt8Znwf5Q0lRG6m6pGxGAgcuMbTTuA7V/zAi60cSvSQiRFVLDQ==
Received: from SN6PR06MB5342.namprd06.prod.outlook.com (2603:10b6:805:f9::31)
 by BYAPR06MB5336.namprd06.prod.outlook.com (2603:10b6:a03:c6::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Tue, 19 Jul
 2022 19:22:54 +0000
Received: from SN6PR06MB5342.namprd06.prod.outlook.com
 ([fe80::44f0:e97e:da1f:399d]) by SN6PR06MB5342.namprd06.prod.outlook.com
 ([fe80::44f0:e97e:da1f:399d%4]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 19:22:53 +0000
Date:   Tue, 19 Jul 2022 14:22:48 -0500
From:   Chris Morgan <macromorgan@hotmail.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Chris Morgan <macroalpha82@gmail.com>,
        linux-iio@vger.kernel.org, lars@metafoo.de
Subject: Re: [RFC] iio: multiplexer: Copy scan_type details from parent to
 child
Message-ID: <SN6PR06MB53423F1D1D1891C5E7BB9DB5A58F9@SN6PR06MB5342.namprd06.prod.outlook.com>
References: <20220718184312.11840-1-macroalpha82@gmail.com>
 <20220719095116.3dc46f3a@jic23-huawei>
 <f845f910-fb46-e38e-b4e2-709ae4da006b@axentia.se>
 <20220719151901.000020cf@Huawei.com>
 <SN6PR06MB534291E524FB941356E32D9BA58F9@SN6PR06MB5342.namprd06.prod.outlook.com>
 <c7994aeb-8b22-625c-a468-c74ca60943ab@axentia.se>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7994aeb-8b22-625c-a468-c74ca60943ab@axentia.se>
X-TMN:  [MSGd8sVkgfv6fHrzUhAUILXkLv7EJ3ko]
X-ClientProxiedBy: SN7PR04CA0170.namprd04.prod.outlook.com
 (2603:10b6:806:125::25) To SN6PR06MB5342.namprd06.prod.outlook.com
 (2603:10b6:805:f9::31)
X-Microsoft-Original-Message-ID: <20220719192248.GA23877@wintermute.localdomain>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a71cedc2-4bc1-450e-b051-08da69bc13c1
X-MS-TrafficTypeDiagnostic: BYAPR06MB5336:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6+0wkEL7bUNB1klKozUmEh1iqFGKlJk+w/FQ5RKNA8/WiGRONvSjW7AgBdpPnpq18SmDzEePUwfCCBLZN+jJSoyPrgkRZH/WrhlxiqYJnl3Ij++uF5R+Tu+tLhLSqdA3OCMl6lgGWNpF1P5MjbhxQyfYFjuvbbdYPzSO6ufSItwsIfCIvgCkqDiUDmWX1EyAckS2EBXqD7EAQ7l2OII10faDpIdwq4jXYA8BGOqkYnY413sdTLIos+TkBHI7H18PvvMEvM0jaPWJO/ErLAHutRiLH4q8TDwkPXsgfsRT7EAafak4U13N6BoopirGt+/PFMHDmkIV4w57KSHYvEyagBIIRd6ym5xN+PIvOGOpZJbqnYUc+ZqGmYs+N3rjdx0oB/RZZHpaqXGJPRQTHWqOokmIiKI+KGyWsxcNMe/96i3N2Gr3erv0/L+P+pOW/AxWFnO9I+iutMx0NiKD7fSum6WwrTd3IWDuNoA+rlyzBwipoBzHO3dfLo8gFu4jh20Fbw3RrktF6QioXbc9HEUngEjiOjfoOPkB3yBrOc7BA46ksFCG+6MDsUATGGftwkBLW6iCq8KYkW55D5aIDTvRyAFdtqIvIaJqXg4nR6yURmxdKBU5doVHevDkg5RRgX+9SXQRS71y8xgy4VWGS4qJyur8x4dqjUBlsv/ve7DhB4e9l0AZyPhUm6yLS180sroD
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2U2mRkAH0Op/sBUuLEMphZW874o0Uf6KvvujzbreXwf8Ef/MZ9CkG+F7Mo2N?=
 =?us-ascii?Q?XSU5dU2Y4aV1fwa4U3Zl+yVNeCrQllCfjuhWj7JtJ6ow6Wmf/au9xhY3gxkj?=
 =?us-ascii?Q?i3EU2F2swSRDfzUapszReET9yFsl0cZgcvbvMcHtHVOZG0MYX7TzZINSaenP?=
 =?us-ascii?Q?VFRzmeAR25gxBhU3NzrHz7IXV9V4IOlQJpniH+sa6+nWsgSavZ1vuM03rYIi?=
 =?us-ascii?Q?VRM6bwjaH+xYaHK2dmmL2DxnMFiB5M7zZ9tb99XkmvnYzOQ4jfBVW/pMddRK?=
 =?us-ascii?Q?rsZRtRK8xvPG/h9zMHZTaDZgXLpJqf+/u9ST6EODpx7hoo6btnr/b316nnlT?=
 =?us-ascii?Q?Nvn4mjXTO5ZOsHXW23NCBI7KBA4bhnE6Ay2UhD4pCMhRtQjFoQAPP5MiDUeh?=
 =?us-ascii?Q?li7EzCzujLGNyjHDcPm90u5LnmmfdvVEeWt3so3O96FK54DaQ2yUr1N53uW+?=
 =?us-ascii?Q?Y7b2j6RNsWioiL0mdulU9O0zQsC67JTemeVRz4wX6z1/tfel1W7PB/WyWJm5?=
 =?us-ascii?Q?oWYhz5KN5Os273B3DzrPfe7KN7hZq8/8jzWiFRCsTqoo8N1lkB1pmHx8t/u9?=
 =?us-ascii?Q?USIHi6+X7Q2Ow54UVus/OnPvDh5ZcAvO8hhaATShwXmrzI1sMhC4XKnVrpoR?=
 =?us-ascii?Q?LRNpV9UyQh1HqE8JhuhITfYew+8SdkkmmPiH/h7nWMK+N/FHTVTTO/+FQRmK?=
 =?us-ascii?Q?yj6RPoY5iDMFnFAnzF5NBsimsxOJ4MAjItoE2Kv2x4Ldx8vHDyuvz8EfgvrL?=
 =?us-ascii?Q?tGUP3qb8sS4ZR4PCXZDy4x7Ufkx3yn4tQMUWpY7utne9EHfQSV0P7CqML/Le?=
 =?us-ascii?Q?FzZNWNb60VNDDcIA4iHCDwx23XfyaVcqkSiNGDsQQ0PnG381EA5I5q9U5GOR?=
 =?us-ascii?Q?mr28EbHJPNiP2QulAbB/ZJpvWHJhSxW9Llxd2wG/9pSXuuKpb90PtZLvmamT?=
 =?us-ascii?Q?4gbviqAeZJRQ1ljGAB1iUiS9Ye/KaeO8hOa450DuY9gBAQ70CVgXLnVL4/oP?=
 =?us-ascii?Q?nKBx8mQSiaw1rPepONPtvu538ONSqKCud9A5nXXJzNeBtZUHx+GFbUl6rvtE?=
 =?us-ascii?Q?INuJ9LiNIxcrt5c6BaaEBk9MWe+k++wV7Ymdg0yvW+ZgttnN9KePTXUmA3eP?=
 =?us-ascii?Q?4EgcN70Rm9ITIDU1Fj5qvSIfZbEWvyAuNiAUeovn6TnyAKx365cvHTMZ6xh4?=
 =?us-ascii?Q?KhEQosMZ3mgpLm11Taa9FX5sTgeQKK75RqFU77h3wGHcI+EmzbgEpeQzPI7s?=
 =?us-ascii?Q?sUAk/QaQxEb1GEUNXSzBKKFfKqs2WSJUuHGS/HoPuA=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-89723.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a71cedc2-4bc1-450e-b051-08da69bc13c1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR06MB5342.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 19:22:53.7418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5336
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jul 19, 2022 at 07:54:18PM +0200, Peter Rosin wrote:
> 
> 
> 2022-07-19 at 16:44, Chris Morgan wrote:
> > On Tue, Jul 19, 2022 at 03:19:01PM +0100, Jonathan Cameron wrote:
> >> On Tue, 19 Jul 2022 15:27:24 +0200
> >> Peter Rosin <peda@axentia.se> wrote:
> >>
> >>> Hi!
> >>>
> >>> 2022-07-19 at 10:51, Jonathan Cameron wrote:
> >>>> On Mon, 18 Jul 2022 13:43:12 -0500
> >>>> Chris Morgan <macroalpha82@gmail.com> wrote:
> >>>>   
> >>>>> From: Chris Morgan <macromorgan@hotmail.com>
> >>>>>
> >>>>> Copy the scan_type details from the parent iio channel to the child.
> >>>>> The scan_type is otherwise empty and things like the storagebits are
> >>>>> zero (which causes a problem for the adc-joystick driver which
> >>>>> validates the storagebits when used through a mux). I'm submitting this
> >>>>> as an RFC because I'm not sure if this is the correct way to handle
> >>>>> this scenario (a driver that checks the storagebits used with the iio
> >>>>> multiplexer).
> >>>>>
> >>>>> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>  
> >>>> Seems sensible to me. Though Peter is expert on this one.  
> >>>
> >>> I really doubt that it is this simple. I'm no expert on buffered channels,
> >>> but after a quick look it certainly looks like adc-joystick requires
> >>> buffered channels. And iio-multiplexer does not support that at all. I
> >>> think it could be supported, but in that case the only obvious support
> >>> would be to support buffered channels one at a time, and the way I
> >>> read adc-joystick it expects to get one sample for each axes in one
> >>> go (i.e. the way "normal" ADCs deliver multiple parallel samples). See
> >>> e.g. the call to iio_channel_get_all_cb in adc-joystick, which dives
> >>> right into the buffered iio department.
> >>>
> >>> So, the stuff in scan_type (along with scan_index, which is highly
> >>> related) is only relevant for buffered channels, and iio_multiplexer is
> >>> currently limited by its
> >>>
> >>> 	indio_dev->modes = INDIO_DIRECT_MODE;
> >>>
> >>> which is ... not buffered. :-(
> >>>
> >>> The simplest way forward is probably to lift the requirement of buffered
> >>> channels from adc-joystick, but that might be a hard sell as that driver
> >>> would then probably be a lot bigger and more complex.
> >>>
> >>
> >> Got it in one ;)
> 
> I guess I'm old and can therefore allow myself to blather :-)
> 
> >> There is a recent series from Chris adding polled support to adc_joystick (not yet merged)
> >> https://nam12.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2F20220705190354.69263-1-macromorgan%40hotmail.com%2F&amp;data=05%7C01%7C%7Ccb22e6634f844f68126e08da69afae8c%7C84df9e7fe9f640afb435aaaaaaaaaaaa%7C1%7C0%7C637938500513929763%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=00HdVZvnHQNbQ1wFEON%2F9i%2B5b%2BicYb6gRhAJuKooZlA%3D&amp;reserved=0
> >> That just reads the channels one at a time via same interfaces used for
> >> sysfs reads so would work with the iio-mux I think.
> >>
> >> Jonathan
> > 
> > Right, correct that these two "work" together. Honestly the main thing
> > is that the adc-joystick driver checks for the storagebits, and that's
> > failing for me in this case when I use a mux. I added a one-liner to
> > the multiplexer code which added the parent information and that fixed
> > it. It's also possible that I could change the adc-joystick driver to
> > either not look for the storagebits or to change it to only look when
> > not doing polling mode. I just assumed that a missing scan_type was
> > an issue, so I added it and marked the patch as RFC because I wasn't
> > sure. If you want me to relax the adc-joystick check instead for polled
> > devices, I can.
> 
> Ah, ok, there's been new development. Nice!
> 
> As I said, I'm by no means a iio-buffer expert. On the contrary, I'm a
> total noob. So, be sure to take the following with a good pinch of salt,
> but I think that the adc-joystick driver in a mode that does not use
> iio-buffers should not then have artificial requirement on the buffer
> layout (scan_type). Don't forget the salt... :-)

This sounds like it makes the most sense to me now, since I wasn't aware
of the "scan_type" being associated with a buffer. I'll modify the
joystick driver and we can disregard this then.  Thank you.

> 
> > Note that the adc-joystick driver does work perfectly fine with a mux,
> > I'm in the very early stages of upstreaming some devices which use it
> > in such a manner (the Anbernic RG353, Anbernic RG503, Odroid Go Super
> > are example devices that use the adc-joystick with a mux downstream).
> 
> Cool!
> 
> Cheers,
> Peter
