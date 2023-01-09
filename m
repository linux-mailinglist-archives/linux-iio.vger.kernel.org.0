Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34E8661F69
	for <lists+linux-iio@lfdr.de>; Mon,  9 Jan 2023 08:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjAIHq0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Jan 2023 02:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjAIHqZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Jan 2023 02:46:25 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1EA11A31
        for <linux-iio@vger.kernel.org>; Sun,  8 Jan 2023 23:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673250384; x=1704786384;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T8B8yN6mYunhyUhl5Qwf3fo1p+HfqxYFgFVPujVPU+o=;
  b=F6edtGkAPOoNPDJS17LxL+MnRXdw7/RtUx1W9U8Phy5/P8Guyqvdp815
   T/kuLj9UqcV1tNWDMkKIJwZ9TqOoK2aSdbFHOZutJG+xKK9qVNbiPK9ea
   IOuxyTZTUsVhIXkY105tl/7pyvovtXegMuv9i8IUbhXlMhWdoCpht4FGR
   l8AzHyFxPV/BOXdgf3Zcf6YCei5xzrLy7m34FdTMgbeG0H8n/yRj+aK83
   HEKWmIcQzoOnECPHeDbbG79BuUmrOCTCeYq7ENg6ySHyTY8tbJvJAVeQL
   U7jGJFV88Y9s6YJD9IeXV4pzgAk5krB0YJzro+0NrREqJs1tGUaravhYq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="409062923"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="409062923"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2023 23:46:23 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="606520728"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="606520728"
Received: from dperchan-mobl1.ger.corp.intel.com (HELO kronos) ([10.249.94.83])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2023 23:46:22 -0800
Message-ID: <0f4f02315c2c8e65dbe4f8481c2ec6d5f951990f.camel@intel.com>
Subject: Re: [PATCH] iio: hid: fix the retval in
 [accel|gyro]_3d_capture_sample
From:   Dmitry Perchanov <dmitry.perchanov@intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, lars@metafoo.de, demisrael@gmail.com
Date:   Mon, 09 Jan 2023 09:46:19 +0200
In-Reply-To: <20230108123256.5b27e9a9@jic23-huawei>
References: <80a61ea3eb5d00febdaf24ab27e3301fd8c70f74.camel@intel.com>
         <20230108122434.24c71555@jic23-huawei>
         <20230108123256.5b27e9a9@jic23-huawei>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 2023-01-08 at 12:32 +0000, Jonathan Cameron wrote:
> On Sun, 8 Jan 2023 12:24:34 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
> =

> > On Mon, 02 Jan 2023 20:51:27 +0200
> > Dmitry Perchanov <dmitry.perchanov@intel.com> wrote:
> > =

> > > From d12f607f83c0bdae6529d8cfbb0cf17f8920c380 Mon Sep 17 00:00:00 2001
> > > From: Dmitry Perchanov <dmitry.perchanov@intel.com>
> > > Date: Tue, 13 Dec 2022 17:44:01 +0200
> > > Subject: [PATCH] iio: hid: fix the retval in [accel|gyro]_3d_capture_=
sample
> =

> This block shouldn't be here in the email.
> =

> > > =

> > > Return value should be zero for success.
> > > This was forgotten for timestamp feature.
> > > Verified on RealSense cameras.
> > > =

> > > Signed-off-by: Dmitry Perchanov <dmitry.perchanov@intel.com>  =

> > =

> > Hi Dmitry,
> > =

> > I've taken this as it stands (needed to do a bit of hand editing to get
> > git to accept your email).  However, if you fancy doing some cleanup
> > it would be better still if these functions just returned directly in e=
ach
> > arm of the switch statement.  Drop the final return and the compiler
> > will moan if any path is not covered...
> > =

> > Applied to the fixes-togreg branch of iio.git and marked for stable inc=
lusion.
> =

> Actually, whilst applying I tried to add a fixes tag with the assumption =
these
> were probably both added at a similar time.  Unfortunately not (one was 2=
021,
> the other 2016).
> =

> As such I've dropped the patch.  Could you resend this as two separate pa=
tches, with
> fixes tags as appropriate.
> Fixes: 4648cbd8fb92 ("iio: hid-sensor-gyro-3d: Add timestamp channel")
> Fixes: a96cd0f901ee ("iio: accel: hid-sensor-accel-3d: Add timestamp")
> =

I will resend two separate patches.

Thanks,

Dmitry

> This is a fix we definitely want backported, so making it easy to do is i=
mportant.
> =

> Thanks,
> =

> Jonathan
> =

> =

> =

> > =

> > Thanks,
> > =

> > Jonathan
> > =

> > > ---
> > >  drivers/iio/accel/hid-sensor-accel-3d.c | 1 +
> > >  drivers/iio/gyro/hid-sensor-gyro-3d.c   | 1 +
> > >  2 files changed, 2 insertions(+)
> > > =

> > > diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/ac=
cel/hid-sensor-accel-3d.c
> > > index a2def6f93..5eac7ea19 100644
> > > --- a/drivers/iio/accel/hid-sensor-accel-3d.c
> > > +++ b/drivers/iio/accel/hid-sensor-accel-3d.c
> > > @@ -280,6 +280,7 @@ static int accel_3d_capture_sample(struct hid_sen=
sor_hub_device *hsdev,
> > >  			hid_sensor_convert_timestamp(
> > >  					&accel_state->common_attributes,
> > >  					*(int64_t *)raw_data);
> > > +		ret =3D 0;
> > >  	break;
> > >  	default:
> > >  		break;
> > > diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro=
/hid-sensor-gyro-3d.c
> > > index 8f0ad022c..698c50da1 100644
> > > --- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> > > +++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> > > @@ -231,6 +231,7 @@ static int gyro_3d_capture_sample(struct hid_sens=
or_hub_device *hsdev,
> > >  		gyro_state->timestamp =3D
> > >  			hid_sensor_convert_timestamp(&gyro_state->common_attributes,
> > >  						     *(s64 *)raw_data);
> > > +		ret =3D 0;
> > >  	break;
> > >  	default:
> > >  		break;  =

> =

> =


---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

