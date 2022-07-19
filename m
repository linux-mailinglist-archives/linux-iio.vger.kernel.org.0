Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8537057A21B
	for <lists+linux-iio@lfdr.de>; Tue, 19 Jul 2022 16:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239834AbiGSOpF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Jul 2022 10:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240110AbiGSOoc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Jul 2022 10:44:32 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2010.outbound.protection.outlook.com [40.92.20.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0F6234
        for <linux-iio@vger.kernel.org>; Tue, 19 Jul 2022 07:44:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jeQ/KBGR3gK/lPykktOmnMWo91GIoohSQhCPf/wCjFmUYZ/BecDckmueDbHME+mjQShYueTYdkvuraQ84jFGLCuDb+kvmb/asziS7wD2USmqu39Oo/SJgLpfkiWpmA8wvVctZDBnP6FR35VPjEyuz8Wd38ulXrnQxW/OV0fJDv0sPTZTMWa9JWvYNWy4TDXcOxQqOz6qij3viLvyxY6YuBM0ox8aqoVx7ezrna+pgvJzuAnn3t47ClI9ndLZQJV62UqwQsvGRu6kUyKqznDX8LO2BPMQkivzYN2H8glwvq4yT4Fur2OfaQ2BunsED2/cUrTMNoq+gLb4eXCeytZ4mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zx0l4irUcJB5/eEdwWZWkS8M6GVdbz4u26BG/oYHg2g=;
 b=TZQ5kNCxGFVRTEjRRKThNm3qra5TNJMHJwuZQ2e1NHxv1RRmh3QWwvYSTZafJaDyYRhSR+ndmwXhvB1SHwnucM8jdAvGUNDYPelWyqrJkNR4lHAOa7dvsTwql2idtI4RdwMFjRvmJd8pCa/Gv5ou4bRGGm6PgO4TQpyy0y2j4UY/eaxTg1oXB5HbJ17OI3UMge4ghDCvCjD0FLqICCaAyT7FQ/8mCm7zzquZDpKDQ3jVZvGg4BuHEQfdTfSf9Wv4sO5w9aWr1RdAjPYYMAafvVX5Jiy/d8SfdN1AoHEIopiHPiO0wu3dj2cSXrvXTr6I9eXFA1JWdETnmA53ps+OWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zx0l4irUcJB5/eEdwWZWkS8M6GVdbz4u26BG/oYHg2g=;
 b=Szx4A7kMJzbCQDtTZI5LujLYiVuA/wKO1M/l7QiUEO7Ifc+vEbE88+rfnDtHJhn/MLIUV2qB31gdKu/k2ZGM2+U7drVJ6ncYvApZs5emRx4miAI6rso+FCLavaBKt2QyFTq2rcqqKKfTWw9PBUUKzbiohjujzoIDJsOdeXq34tWvYGKeZX6MW1a8V0ngDXqSbjCzaRnFIZSGoFvJToYghK11C/L7yuk3mWmy8curKSeHmhBTNf0Ay9czWQqncFhkFtzCUZxvH7TM89VrAPaOHRTkzupc8Jw1gTxWT63zn/R+YDPZQpod8APjDa3twz4qHiE6FJ6GyMiaddMrSb06JQ==
Received: from SN6PR06MB5342.namprd06.prod.outlook.com (2603:10b6:805:f9::31)
 by MW4PR06MB8970.namprd06.prod.outlook.com (2603:10b6:303:1bd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.22; Tue, 19 Jul
 2022 14:44:13 +0000
Received: from SN6PR06MB5342.namprd06.prod.outlook.com
 ([fe80::44f0:e97e:da1f:399d]) by SN6PR06MB5342.namprd06.prod.outlook.com
 ([fe80::44f0:e97e:da1f:399d%4]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 14:44:13 +0000
Date:   Tue, 19 Jul 2022 09:44:05 -0500
From:   Chris Morgan <macromorgan@hotmail.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Chris Morgan <macroalpha82@gmail.com>,
        linux-iio@vger.kernel.org, lars@metafoo.de
Subject: Re: [RFC] iio: multiplexer: Copy scan_type details from parent to
 child
Message-ID: <SN6PR06MB534291E524FB941356E32D9BA58F9@SN6PR06MB5342.namprd06.prod.outlook.com>
References: <20220718184312.11840-1-macroalpha82@gmail.com>
 <20220719095116.3dc46f3a@jic23-huawei>
 <f845f910-fb46-e38e-b4e2-709ae4da006b@axentia.se>
 <20220719151901.000020cf@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719151901.000020cf@Huawei.com>
X-TMN:  [97e790CQPsUX4lFnfzx8E+48iAFLwS5w]
X-ClientProxiedBy: DM6PR21CA0001.namprd21.prod.outlook.com
 (2603:10b6:5:174::11) To SN6PR06MB5342.namprd06.prod.outlook.com
 (2603:10b6:805:f9::31)
X-Microsoft-Original-Message-ID: <20220719144405.GA15897@wintermute.localdomain>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0016dd34-7b80-41cf-6e54-08da699524a7
X-MS-TrafficTypeDiagnostic: MW4PR06MB8970:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NCUPi3GMGNbfQe2tgeHja9GGQEhBYQGk2fvxWyGSqAkAbfSs/zv9T/6obeR4swgskZk0Go8SCOWQNSe7N7xhq4BSrgKlfEcqpK7PX9AmyWZWTFNnXqk9GLnv3mnABu7TOIEBZlfuskg41EFBbc8MkYOUNgDNVvt/TdrIcK2Li15IlsdOq2yhySlFFhTeHAaNE79u6icvuipmI6nATT55TYatRGF+fk4ZvsgOs88c1ViVraNumeshzScwdOeWngYbC9N2cJTCPk1V9e77YBvJkQK3M35thH5PawKRN/qfeBVd+GCfc/wWXmPFf4sdA218ZNv1mj87NsuzTilp25PsRnRWOzidzUnb8aLwBrtnd8AQYwR15MgaWWksiPhOeui3FOiwBxmOVlqLRYr4VfxW68TavLCuD6pcMGKRtcksfgcr2GDjauOIiUWuF07RFNbI5C0QrgQdqZTEAZaTqxlEnugQQFWP2DbJSSQtDdaQI5h8juS4TJAztyFjouKTJJk3Uh691hji7mrr78KF0QX3+Zwac32z2Q0GwXvIDwuuhmeVVl9YaF3VqCfK/5EP1R2T6Tkv9Ro1glfVZNb06zcuCJa3/Ewu4eDBooIS60wTcXFEgDl0jmqWWouxGgUpSrh3MZAEznpMFB2L0NR1hp3sihFX/Zb1QZdS6InAw9LbEKJ8E2fiHfQlfaMAONRaZ/h5
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?urtukEbMMrCKJbypnvbuqY9Hnyu9UhPQCfwPORVvI6lNhcKPKqYsxJ706Rca?=
 =?us-ascii?Q?cPLpXvKHxIQHw7en0bu7WfJeSsx+FZ4vkJUoHhehig5yZ8jRD6V49r+yMj2D?=
 =?us-ascii?Q?6y3RnUIi2BMAZ4BN+kCLz8qKeBRMs0zbyi59YS+567AXPSLo4YkRWhKyVMzh?=
 =?us-ascii?Q?EVpTm/IO85vt2ey5AMjGGbRbF6zogrV8F19InXPJetVwFPJuZ6na+wBp5Val?=
 =?us-ascii?Q?oRo8BCvG2Mez54+HHAbKHQP17G1KQgLXBq9B12tcLIGZtLwlRPY3/2Z1a0/I?=
 =?us-ascii?Q?gvvPiXFuhg1k/XBpJu3pAeaIs2kZihd3AVjcNXah7B/m7EJDkG7jJgy/SUgd?=
 =?us-ascii?Q?t7zE8XrDLruclRdevPTH18uxlmM9HtEzLs9TL1Lx2AUgY71oA00DutWNQPlA?=
 =?us-ascii?Q?MkT9tTfcq6gbzUfQrCXzGgtjcgQVaivpVfnrCLcQ87tnrMAQsf7vJcnyK0Vd?=
 =?us-ascii?Q?2kVcKiIk4T9c1uM4KkjFRIX+/u89IfjBkV+r13QGKdNCBtoYjRr2YSzBr+Px?=
 =?us-ascii?Q?s62Dl0PqGZyOimgRVRq+8jsFER4OfQuerfu2WnGymOUJHaYE7KNdwAto6as+?=
 =?us-ascii?Q?tlH3BCTzRjnYHmSEwE6K+DtMiLZBcIQ5ZPF8cbGjqEUFnDoCzry6Ls2TxM6Q?=
 =?us-ascii?Q?Siw72DBLpBCSbYQnQoRMRbKSaU8hp02rnTv57jUoRZkFWOmgzR15vdaCgcxk?=
 =?us-ascii?Q?PUxqrP3YqBeEMehpMQ4HvVK0SMEPcFxY3SeohlbQbrfw+qSA+90yes7i/1on?=
 =?us-ascii?Q?i1kKmS7T26MfX8Zgbv75kGoqxzYWhSzBxrGar+iKoi9OkjDSd4azkgnhAqkQ?=
 =?us-ascii?Q?Kfc3KV4kvwH9mzPTJ59v8qpNSp6VHBPiUqwOyGMFSowRinvgCrrJNigH6EmH?=
 =?us-ascii?Q?ryApummjwTb/yj0HfpPmkKKEkwM65hO3hvSqTXCWQcWaM8P5dK73oRLr9UYT?=
 =?us-ascii?Q?hUJj0HcbrLkbxzy+BCKas468rq1BTPlfckEw36R9gBeQfA0enRizLqPT1oTV?=
 =?us-ascii?Q?m5kzEGpZnrP1i0NzoI3LdaVqEv57s4MZvokSKLwHnLVzp7+CpnJSq7iTCRIO?=
 =?us-ascii?Q?6e4UYv7VbFHNE1fdUck3y0Ts200IiQMiNdReZZmJF+rXiTDwXNJ4GXfptTCM?=
 =?us-ascii?Q?Lx/+1GGZYqrDuucYH+2gJGVkbfxgzbolYletd3objJM4a6vrgX0zPLkXlC9F?=
 =?us-ascii?Q?imN4ThZCowh6L7KDNkUNbSLHXvs+kF7Ck1L6UPm1HXEI+1hepyVOl6+rE48b?=
 =?us-ascii?Q?MmjpGIW/sDbbu66dpVAbJYqzf+aE0WSIoeDNalBtyw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-89723.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0016dd34-7b80-41cf-6e54-08da699524a7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR06MB5342.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 14:44:13.1247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR06MB8970
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jul 19, 2022 at 03:19:01PM +0100, Jonathan Cameron wrote:
> On Tue, 19 Jul 2022 15:27:24 +0200
> Peter Rosin <peda@axentia.se> wrote:
> 
> > Hi!
> > 
> > 2022-07-19 at 10:51, Jonathan Cameron wrote:
> > > On Mon, 18 Jul 2022 13:43:12 -0500
> > > Chris Morgan <macroalpha82@gmail.com> wrote:
> > >   
> > >> From: Chris Morgan <macromorgan@hotmail.com>
> > >>
> > >> Copy the scan_type details from the parent iio channel to the child.
> > >> The scan_type is otherwise empty and things like the storagebits are
> > >> zero (which causes a problem for the adc-joystick driver which
> > >> validates the storagebits when used through a mux). I'm submitting this
> > >> as an RFC because I'm not sure if this is the correct way to handle
> > >> this scenario (a driver that checks the storagebits used with the iio
> > >> multiplexer).
> > >>
> > >> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>  
> > > Seems sensible to me. Though Peter is expert on this one.  
> > 
> > I really doubt that it is this simple. I'm no expert on buffered channels,
> > but after a quick look it certainly looks like adc-joystick requires
> > buffered channels. And iio-multiplexer does not support that at all. I
> > think it could be supported, but in that case the only obvious support
> > would be to support buffered channels one at a time, and the way I
> > read adc-joystick it expects to get one sample for each axes in one
> > go (i.e. the way "normal" ADCs deliver multiple parallel samples). See
> > e.g. the call to iio_channel_get_all_cb in adc-joystick, which dives
> > right into the buffered iio department.
> > 
> > So, the stuff in scan_type (along with scan_index, which is highly
> > related) is only relevant for buffered channels, and iio_multiplexer is
> > currently limited by its
> > 
> > 	indio_dev->modes = INDIO_DIRECT_MODE;
> > 
> > which is ... not buffered. :-(
> > 
> > The simplest way forward is probably to lift the requirement of buffered
> > channels from adc-joystick, but that might be a hard sell as that driver
> > would then probably be a lot bigger and more complex.
> >
> 
> Got it in one ;)
> There is a recent series from Chris adding polled support to adc_joystick (not yet merged)
> https://nam12.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2F20220705190354.69263-1-macromorgan%40hotmail.com%2F&amp;data=05%7C01%7C%7Cfc07a056f5ae40ecc37908da6991a298%7C84df9e7fe9f640afb435aaaaaaaaaaaa%7C1%7C0%7C637938371469723267%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=tAT8scZvG9Z8OVSgwdxog%2Bz55dzQC2TFddDa%2BQEX6e4%3D&amp;reserved=0
> That just reads the channels one at a time via same interfaces used for
> sysfs reads so would work with the iio-mux I think.
> 
> Jonathan

Right, correct that these two "work" together. Honestly the main thing
is that the adc-joystick driver checks for the storagebits, and that's
failing for me in this case when I use a mux. I added a one-liner to
the multiplexer code which added the parent information and that fixed
it. It's also possible that I could change the adc-joystick driver to
either not look for the storagebits or to change it to only look when
not doing polling mode. I just assumed that a missing scan_type was
an issue, so I added it and marked the patch as RFC because I wasn't
sure. If you want me to relax the adc-joystick check instead for polled
devices, I can.

Note that the adc-joystick driver does work perfectly fine with a mux,
I'm in the very early stages of upstreaming some devices which use it
in such a manner (the Anbernic RG353, Anbernic RG503, Odroid Go Super
are example devices that use the adc-joystick with a mux downstream).

Thank you.

> 
> > That said, I would of course love to see the generic solution with support
> > for buffered channels in the mux, but my guess is that that gets much
> > more difficult, at least if you need the kind of buffered support
> > expected by adc-joystick.
> > 
> > Or, am I misreading the whole situation and you have actually gotten it
> > to work with the below one-liner? If it works, fine by me, but I think
> > you also need to do something with scan_index?
> > 
> 
> 
> 
> > Cheers,
> > Peter
> > 
> > > One comment on the comment inline...  
> > >> ---
> > >>  drivers/iio/multiplexer/iio-mux.c | 3 +++
> > >>  1 file changed, 3 insertions(+)
> > >>
> > >> diff --git a/drivers/iio/multiplexer/iio-mux.c b/drivers/iio/multiplexer/iio-mux.c
> > >> index 93558fddfa9b..1de01ec878c4 100644
> > >> --- a/drivers/iio/multiplexer/iio-mux.c
> > >> +++ b/drivers/iio/multiplexer/iio-mux.c
> > >> @@ -322,6 +322,9 @@ static int mux_configure_channel(struct device *dev, struct mux *mux,
> > >>  	if (page)
> > >>  		devm_kfree(dev, page);
> > >>  
> > >> +	/* Copy scan type from parent to mux child. */  
> > > Comment is in the obvious category, so drop that.
> > >   
> > >> +	chan->scan_type = pchan->scan_type;
> > >> +
> > >>  	return 0;
> > >>  }
> > >>    
> > >   
> 
