Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 204B021C8AE
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jul 2020 13:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbgGLLKE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Jul 2020 07:10:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:59288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgGLLKE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 12 Jul 2020 07:10:04 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F25E2070B;
        Sun, 12 Jul 2020 11:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594552203;
        bh=1aTnEP1q68+qCfsrs27uEMUaWm9QNnoxTnh+7zXwsz8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mmdHd2O2TDjqc8ZQ2TLCofNiLeLpiGojxZQNKNLqkmIY8YrhJ0IZsKzIyeHciSNkx
         0xgetRK3RTwSdfGsQdFf3o9jR6bUqo39Ev97C2Kb3ntRu8mv5rI/3w7/kHCMWIsv9+
         F5+/c+zUbLwSfq9MXXc54eTTiZJ/Tmj3d6XgrfzI=
Date:   Sun, 12 Jul 2020 12:10:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, linux-iio@vger.kernel.org,
        lorenzo.bianconi@redhat.com
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: reset hw ts after resume
Message-ID: <20200712121000.46a93069@archlinux>
In-Reply-To: <f639082c-91b9-c056-673d-2835ba05ac03@geanix.com>
References: <15dadc531c5b30819a72b289ccd5c25e04f73657.1594388801.git.lorenzo@kernel.org>
        <f639082c-91b9-c056-673d-2835ba05ac03@geanix.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 11 Jul 2020 13:49:37 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> On 10/07/2020 15.49, Lorenzo Bianconi wrote:
> > Reset hw time sampling after the device resume in order to keep timing
> > in sync
> >
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>  
> Tested-by: Sean Nyekjaer <sean@geanix.com>
Hi Lorenzo,

Patch is fine, but I'd like a couple of changes to the description:
1. More detail!  For what we have here no one will have any real idea
of whether an issue they are seeing is the same one or not.
2. Fixes tag / or something telling me why this shouldn't be back ported.

Thanks,

Jonathan

> > ---
> >   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  3 +--
> >   .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 23 ++++++++++++-------
> >   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  |  2 +-
> >   3 files changed, 17 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > index b56df409ed0f..529970195b39 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > @@ -436,8 +436,7 @@ int st_lsm6dsx_update_watermark(struct st_lsm6dsx_sensor *sensor,
> >   				u16 watermark);
> >   int st_lsm6dsx_update_fifo(struct st_lsm6dsx_sensor *sensor, bool enable);
> >   int st_lsm6dsx_flush_fifo(struct st_lsm6dsx_hw *hw);
> > -int st_lsm6dsx_set_fifo_mode(struct st_lsm6dsx_hw *hw,
> > -			     enum st_lsm6dsx_fifo_mode fifo_mode);
> > +int st_lsm6dsx_resume_fifo(struct st_lsm6dsx_hw *hw);
> >   int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw);
> >   int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw);
> >   int st_lsm6dsx_check_odr(struct st_lsm6dsx_sensor *sensor, u32 odr, u8 *val);
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > index afd00daeefb2..7de10bd636ea 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > @@ -184,8 +184,8 @@ static int st_lsm6dsx_update_decimators(struct st_lsm6dsx_hw *hw)
> >   	return err;
> >   }
> >   
> > -int st_lsm6dsx_set_fifo_mode(struct st_lsm6dsx_hw *hw,
> > -			     enum st_lsm6dsx_fifo_mode fifo_mode)
> > +static int st_lsm6dsx_set_fifo_mode(struct st_lsm6dsx_hw *hw,
> > +				    enum st_lsm6dsx_fifo_mode fifo_mode)
> >   {
> >   	unsigned int data;
> >   
> > @@ -302,6 +302,18 @@ static int st_lsm6dsx_reset_hw_ts(struct st_lsm6dsx_hw *hw)
> >   	return 0;
> >   }
> >   
> > +int st_lsm6dsx_resume_fifo(struct st_lsm6dsx_hw *hw)
> > +{
> > +	int err;
> > +
> > +	/* reset hw ts counter */
> > +	err = st_lsm6dsx_reset_hw_ts(hw);
> > +	if (err < 0)
> > +		return err;
> > +
> > +	return st_lsm6dsx_set_fifo_mode(hw, ST_LSM6DSX_FIFO_CONT);
> > +}
> > +
> >   /*
> >    * Set max bulk read to ST_LSM6DSX_MAX_WORD_LEN/ST_LSM6DSX_MAX_TAGGED_WORD_LEN
> >    * in order to avoid a kmalloc for each bus access
> > @@ -675,12 +687,7 @@ int st_lsm6dsx_update_fifo(struct st_lsm6dsx_sensor *sensor, bool enable)
> >   		goto out;
> >   
> >   	if (fifo_mask) {
> > -		/* reset hw ts counter */
> > -		err = st_lsm6dsx_reset_hw_ts(hw);
> > -		if (err < 0)
> > -			goto out;
> > -
> > -		err = st_lsm6dsx_set_fifo_mode(hw, ST_LSM6DSX_FIFO_CONT);
> > +		err = st_lsm6dsx_resume_fifo(hw);
> >   		if (err < 0)
> >   			goto out;
> >   	}
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > index c8ddeb3f48ff..346c24281d26 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > @@ -2457,7 +2457,7 @@ static int __maybe_unused st_lsm6dsx_resume(struct device *dev)
> >   	}
> >   
> >   	if (hw->fifo_mask)
> > -		err = st_lsm6dsx_set_fifo_mode(hw, ST_LSM6DSX_FIFO_CONT);
> > +		err = st_lsm6dsx_resume_fifo(hw);
> >   
> >   	return err;
> >   }  
> 

