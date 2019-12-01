Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 025EE10E381
	for <lists+linux-iio@lfdr.de>; Sun,  1 Dec 2019 22:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfLAVAK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Dec 2019 16:00:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:50736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726965AbfLAVAJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Dec 2019 16:00:09 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B177F2082E;
        Sun,  1 Dec 2019 21:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575234009;
        bh=juguYgmlXoR80oHtfdssciInLd1I7V0nPMc7/U+CoO0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m4Z0oCpvJvPz0/Fp3oVn+Yat/poc5cyFDbPH+lfS93lY9M5Jy9ZdX3D4L7s+O0TiF
         9Ono8b8GPfDrZP+y+1+4PYo3gJqEOc4yZQnF0OyYmYy49AIk7cC7D91IMgR60zdUXx
         Vv3HgjJQ2zHVd7R7yBQR1q6qtqYW60Til6ePXTlw=
Date:   Sun, 1 Dec 2019 21:00:05 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: fix checkpatch warning
Message-ID: <20191201210005.61876122@archlinux>
In-Reply-To: <4a1fefa9f941bf2c350b4a886fd05909e5ba8ea3.1575017118.git.lorenzo@kernel.org>
References: <4a1fefa9f941bf2c350b4a886fd05909e5ba8ea3.1575017118.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 29 Nov 2019 10:46:44 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Fix following checkpatch warning:
> 
> CHECK: Alignment should match open parenthesis
> +static int st_lsm6dsx_read_event(struct iio_dev *iio_dev,
> +                                  const struct iio_chan_spec *chan,
Fair enough on this tidy up, but the other bit of reorganization?
Why and why not mention it in the patch description?

Also, why the extra line break?  As far as I can see it can
be just fixed without that and still be under 80 chars.
Right now the only issue is that it's indented 2 spaces too many.

Jonathan


> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index a7d40c02ce6b..990643da9f4e 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -1607,12 +1607,13 @@ static int st_lsm6dsx_event_setup(struct st_lsm6dsx_hw *hw, int state)
>  					     hw->irq_routing->mask, data);
>  }
>  
> -static int st_lsm6dsx_read_event(struct iio_dev *iio_dev,
> -				   const struct iio_chan_spec *chan,
> -				   enum iio_event_type type,
> -				   enum iio_event_direction dir,
> -				   enum iio_event_info info,
> -				   int *val, int *val2)
> +static int
> +st_lsm6dsx_read_event(struct iio_dev *iio_dev,
> +		      const struct iio_chan_spec *chan,
> +		      enum iio_event_type type,
> +		      enum iio_event_direction dir,
> +		      enum iio_event_info info,
> +		      int *val, int *val2)
>  {
>  	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
>  	struct st_lsm6dsx_hw *hw = sensor->hw;
> @@ -1620,8 +1621,8 @@ static int st_lsm6dsx_read_event(struct iio_dev *iio_dev,
>  	if (type != IIO_EV_TYPE_THRESH)
>  		return -EINVAL;
>  
> -	*val2 = 0;
>  	*val = hw->event_threshold;
> +	*val2 = 0;
>  
>  	return IIO_VAL_INT;
>  }

