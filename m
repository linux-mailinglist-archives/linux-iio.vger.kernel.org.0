Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A146A82085
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2019 17:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfHEPln (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Aug 2019 11:41:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:45534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726559AbfHEPln (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 5 Aug 2019 11:41:43 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D31D2086D;
        Mon,  5 Aug 2019 15:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565019702;
        bh=i+/SlONclzMp17yGb9OjvY/3Cos4bQ+BCFzghNYRJ0s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hlmAAZwDSFdex4DFQznJDsb8kzKdX5nbgueSG2Vq/5CFTUsKiG5RLl1VW7aqW7bxm
         XZyiWxmKh7xLtBPXj2XE8VEClt3TLg7iayuJB+9/RIfgbktWDW6zyAtqbK+wHVsnZ8
         wbMN8qUJaO9mWCDAL2QllrQq9oL+4LHEU8m+hokI=
Date:   Mon, 5 Aug 2019 16:41:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Martin Kepplinger <martin.kepplinger@puri.sm>,
        lorenzo.bianconi83@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: make IIO_CHAN_INFO_SCALE shared
 by type
Message-ID: <20190805164136.6541af1f@archlinux>
In-Reply-To: <20190805150435.GA15250@localhost.localdomain>
References: <20190801143908.27608-1-martin.kepplinger@puri.sm>
        <20190805152148.0ea55f6e@archlinux>
        <20190805150435.GA15250@localhost.localdomain>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 5 Aug 2019 17:04:35 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> > On Thu,  1 Aug 2019 16:39:08 +0200
> > Martin Kepplinger <martin.kepplinger@puri.sm> wrote:
> >   
> > > in_accel_x_scale, in_accel_y_scale and in_accel_z_scale are always
> > > the same. The scale is still defined to be in "info_mask_separate".
> > > 
> > > Userspace (iio-sensor-proxy and others) is not used to that and only
> > > looks for "in_accel_scale" for the scaling factor to apply.
> > > 
> > > Change IIO_CHAN_INFO_SCALE from being separate in all channel to be
> > > shared by type.
> > > 
> > > This removes in_accel_x_scale, in_accel_y_scale and in_accel_z_scale and
> > > makes available in_accel_scale.
> > > 
> > > Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> > > ---
> > > 
> > > AFAIK in all other drivers, IIO_CHAN_INFO_SCALE is "shared by type". Sure
> > > devices are different, but LSM6DSX devices still don't have different
> > > scales for x/y/z channels :)  
> > 
> > I'm fine with this, but would like a Lorenzo ack as we have had
> > devices in other series where these are not equal.   It used to
> > be common in accelerometers as I think it was hard to get a large
> > range in the vertical direction.  Doubt that applies on these modern
> > parts though!
> > 
> > Thanks,
> > 
> > Jonathan  
> 
> AFAIK all the supported sensors have the same sensitivity on all axis and so I
> am fine with this patch (it should be done in this way from day 0 actually :))
> but is it going to break uapi? if not feel free to add:
It's a gamble, but one we've made a number of times before when tidying this
sort of thing up.

Most code uses libraries that are capable of coping with both options so chances
are fairly low that anyone will notice.  It seems some code doesn't cope
with independent versions and will actually be fixed by this.

I'm not proposing to push this as a fix, but as a tidy up.
We may break a few custom scripts built against particular setups though.

I think it's a worthwhile enough tidy up to take the risk, particularly
if it fixes the interactions with some code bases (that incidentally
should have coped with this either way).

*crosses fingers*

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> 
> Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> Regards,
> Lorenzo
> 
> > 
> >   
> > > 
> > > thanks,
> > > 
> > >                               martin
> > > 
> > > 
> > > 
> > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > > index af379a5429ed..59c3ab7cbb6f 100644
> > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > > @@ -56,8 +56,8 @@ enum st_lsm6dsx_hw_id {
> > >  	.address = addr,						\
> > >  	.modified = 1,							\
> > >  	.channel2 = mod,						\
> > > -	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
> > > -			      BIT(IIO_CHAN_INFO_SCALE),			\
> > > +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
> > > +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
> > >  	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> > >  	.scan_index = scan_idx,						\
> > >  	.scan_type = {							\  
> >   

