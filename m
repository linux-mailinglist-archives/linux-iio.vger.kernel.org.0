Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162986614FA
	for <lists+linux-iio@lfdr.de>; Sun,  8 Jan 2023 13:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjAHMTd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Jan 2023 07:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjAHMTc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Jan 2023 07:19:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2793A195
        for <linux-iio@vger.kernel.org>; Sun,  8 Jan 2023 04:19:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A1FFB802C5
        for <linux-iio@vger.kernel.org>; Sun,  8 Jan 2023 12:19:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57507C433D2;
        Sun,  8 Jan 2023 12:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673180368;
        bh=/191sD0XnLr8vs8uymSVNsbjJHKoNeDFv3BkzhEI05M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dQwbBYU7WNi3ZtrcK+KjWIrFTFeBZGsh5fCQV0UywOJILCutL7N+lsHdyiNPvUVAe
         rQrEyzPUm/BZG/srUC4JOSf2pjNNNssAXjvCjipNThHsqeT0/+R/dAnB313eoKvj94
         bbvFtSuG+LmtcDntoTyuh+M7RUcsA49uCS1+Ymp/RGALcoa3+CBcWD28h6oKsocfpn
         z/vvBCCF1reF+8/ozmJQrVOdQja7aSlv6CffSG+SgFuHd+TSCIImR5TschNXShWjJk
         O2yof/8VJal2nphcg9tDwzXyiYg1vQbXlHvUmaoHBPj6u4GarRA2mpjZAPBOmCE03f
         +a4UIH2q1Y4ng==
Date:   Sun, 8 Jan 2023 12:32:56 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dmitry Perchanov <dmitry.perchanov@intel.com>
Cc:     linux-iio@vger.kernel.org, lars@metafoo.de, demisrael@gmail.com
Subject: Re: [PATCH] iio: hid: fix the retval in
 [accel|gyro]_3d_capture_sample
Message-ID: <20230108123256.5b27e9a9@jic23-huawei>
In-Reply-To: <20230108122434.24c71555@jic23-huawei>
References: <80a61ea3eb5d00febdaf24ab27e3301fd8c70f74.camel@intel.com>
        <20230108122434.24c71555@jic23-huawei>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 8 Jan 2023 12:24:34 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 02 Jan 2023 20:51:27 +0200
> Dmitry Perchanov <dmitry.perchanov@intel.com> wrote:
> 
> > From d12f607f83c0bdae6529d8cfbb0cf17f8920c380 Mon Sep 17 00:00:00 2001
> > From: Dmitry Perchanov <dmitry.perchanov@intel.com>
> > Date: Tue, 13 Dec 2022 17:44:01 +0200
> > Subject: [PATCH] iio: hid: fix the retval in [accel|gyro]_3d_capture_sample
This block shouldn't be here in the email.

> > 
> > Return value should be zero for success.
> > This was forgotten for timestamp feature.
> > Verified on RealSense cameras.
> > 
> > Signed-off-by: Dmitry Perchanov <dmitry.perchanov@intel.com>  
> Hi Dmitry,
> 
> I've taken this as it stands (needed to do a bit of hand editing to get
> git to accept your email).  However, if you fancy doing some cleanup
> it would be better still if these functions just returned directly in each
> arm of the switch statement.  Drop the final return and the compiler
> will moan if any path is not covered...
> 
> Applied to the fixes-togreg branch of iio.git and marked for stable inclusion.
Actually, whilst applying I tried to add a fixes tag with the assumption these
were probably both added at a similar time.  Unfortunately not (one was 2021,
the other 2016).

As such I've dropped the patch.  Could you resend this as two separate patches, with
fixes tags as appropriate.
Fixes: 4648cbd8fb92 ("iio: hid-sensor-gyro-3d: Add timestamp channel")
Fixes: a96cd0f901ee ("iio: accel: hid-sensor-accel-3d: Add timestamp")

This is a fix we definitely want backported, so making it easy to do is important.

Thanks,

Jonathan



> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/iio/accel/hid-sensor-accel-3d.c | 1 +
> >  drivers/iio/gyro/hid-sensor-gyro-3d.c   | 1 +
> >  2 files changed, 2 insertions(+)
> > 
> > diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
> > index a2def6f93..5eac7ea19 100644
> > --- a/drivers/iio/accel/hid-sensor-accel-3d.c
> > +++ b/drivers/iio/accel/hid-sensor-accel-3d.c
> > @@ -280,6 +280,7 @@ static int accel_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
> >  			hid_sensor_convert_timestamp(
> >  					&accel_state->common_attributes,
> >  					*(int64_t *)raw_data);
> > +		ret = 0;
> >  	break;
> >  	default:
> >  		break;
> > diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> > index 8f0ad022c..698c50da1 100644
> > --- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> > +++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> > @@ -231,6 +231,7 @@ static int gyro_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
> >  		gyro_state->timestamp =
> >  			hid_sensor_convert_timestamp(&gyro_state->common_attributes,
> >  						     *(s64 *)raw_data);
> > +		ret = 0;
> >  	break;
> >  	default:
> >  		break;  
> 

