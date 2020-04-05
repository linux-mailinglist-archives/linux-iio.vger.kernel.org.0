Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7596D19EB03
	for <lists+linux-iio@lfdr.de>; Sun,  5 Apr 2020 13:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgDELvp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Apr 2020 07:51:45 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:43033 "EHLO
        smtpout1.mo529.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726641AbgDELvo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Apr 2020 07:51:44 -0400
Received: from DAG2EX1.mxp2.local (unknown [10.108.20.177])
        by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 650082D5D796;
        Sun,  5 Apr 2020 13:51:41 +0200 (CEST)
Received: from gaetanandre.eu (37.59.142.106) by DAG2EX1.mxp2.local
 (172.16.2.3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 5 Apr 2020
 13:51:40 +0200
Date:   Sun, 5 Apr 2020 13:51:39 +0200
From:   =?iso-8859-1?Q?Ga=EBtan_Andr=E9?= <rvlander@gaetanandre.eu>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>
Subject: Re: [PATCH] iio: st_sensors: make scale channels also shared by type
Message-ID: <20200405115139.GA189531@ADVI0116>
References: <20200330145920.441528-1-rvlander@gaetanandre.eu>
 <20200405110217.0f6a38d0@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200405110217.0f6a38d0@archlinux>
X-Originating-IP: [37.59.142.106]
X-ClientProxiedBy: DAG8EX1.mxp2.local (172.16.2.15) To DAG2EX1.mxp2.local
 (172.16.2.3)
X-Ovh-Tracer-GUID: d4338d2e-e90b-4e15-ac67-f41ba5ea7f75
X-Ovh-Tracer-Id: 14289077196965495005
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedruddugdeghecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvffukfhfgggtugfgjghisehtkeertddttddunecuhfhrohhmpefirgotthgrnhgptehnughrrocuoehrvhhlrghnuggvrhesghgrvghtrghnrghnughrvgdrvghuqeenucffohhmrghinhepfhhrvggvuggvshhkthhophdrohhrghenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopefftefivdfgigdurdhmgihpvddrlhhotggrlhdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheprhhvlhgrnhguvghrsehgrggvthgrnhgrnhgurhgvrdgvuhdprhgtphhtthhopeimphhoshhtmhgrrhhkvghtohhssdhuphhsthhrvggrmhhinhhgsehlihhsthhsrdhsrhdrhhht
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Apr 05, 2020 at 11:02:17AM +0100, Jonathan Cameron wrote:
> On Mon, 30 Mar 2020 16:59:20 +0200
> Gaëtan André <rvlander@gaetanandre.eu> wrote:
> 
> > Scale channels are available by axis. For example for accelerometers,
> > in_accel_x_scale, in_accel_y_scale and in_accel_z_scale are available.
> > 
> > However, they should be shared by type as documented in
> > Documentation/ABI/testing/sysfs-bus-iio.
> > 
> > For each sensor (acceleros, gyros and magnetos) only one value is specified
> > for all the axes.
> > 
> > Existing, by axis, entries are preserved in order to to leave the old ABI
> > untouched.
> Hi Gaëtan,
> 
> Thanks for this.  Whilst I agree the ideal ABI would be to have just the
> shared version userspace should cope with the current version anyway as
> it would be the right option if for example the scale of x and y are controlled
> by one register field and z by another (this used to be common for accelerometers)
> 
> Any userspace software using this will have to assign a precedence to the
> two files that result and the most likely option is more specific first meaning
> the shared version is unused.
> 
> Hence I'd argue we aren't broke (just non ideal) and adding the additional
> interface just confuses matters.  Hence I would rather leave things how they
> currently are.  Do we have some userspace that is broken by this being less
> than ideal?
> 
Hi Jonathan,

Thanks for taking time to answer.

I don't have any point of view regarding what is better.

What I know is that iio-sensor-proxy [1] only looks for a common scale.
Hence, it won't work with ST sensors as is.

I could either do this patch or patch iio-sensor-proxy. What decided me
is that all ST sensors, if I am correct, use only one scale value for all axis.

If things are to be kept as is, then iio-sensor-proxy should be patched.

Also, note that currently in_acceleration_scale_{x, y, z} don't seem to
be documented.

Thanks,

Gaëtan

[1] iio-sensor-proxy: https://gitlab.freedesktop.org/hadess/iio-sensor-proxy/

> Thanks
> 
> Jonathan
> 
> > 
> > Signed-off-by: Gaëtan André <rvlander@gaetanandre.eu>
> > ---
> >  include/linux/iio/common/st_sensors.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
> > index 33e939977444..f31e309f0fd1 100644
> > --- a/include/linux/iio/common/st_sensors.h
> > +++ b/include/linux/iio/common/st_sensors.h
> > @@ -52,6 +52,7 @@
> >  	.type = device_type, \
> >  	.modified = mod, \
> >  	.info_mask_separate = mask, \
> > +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
> >  	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> >  	.scan_index = index, \
> >  	.channel2 = ch2, \
> > 
> > base-commit: b723e9431b77976b83efb90178dfcada3405321c
> 
