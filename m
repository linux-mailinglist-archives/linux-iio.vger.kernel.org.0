Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFFD4AC629
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2019 12:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729533AbfIGKyq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Sep 2019 06:54:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:58644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729443AbfIGKyp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Sep 2019 06:54:45 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8326820854;
        Sat,  7 Sep 2019 10:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567853685;
        bh=RR0qR9syrBsLnzNd8WdUBWJTBYRbJcJ0yrYFmAg2ECE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U3+B9+7O9WBLMQFX2vljZQJ9gzL9vLpsfwsY5wvd9ekEyf9nft+7omUASXGXY6Rw5
         rACLKB0rEPAEWnLARqXwMMWwf7R7waHNLoawYS7m5Vgma4rvbrfAnM2rURJGboT3X1
         zj6APhQBRALsmjRRycuTPenBBeGMZ7hZq+BEQoAk=
Date:   Sat, 7 Sep 2019 11:54:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi83@gmail.com,
        denis.ciocca@st.com, mario.tesi@st.com, armando.visconti@st.com,
        martin@geanix.com
Subject: Re: [PATCH v4 6/6] iio: imu: st_lsm6dsx: prohibit the use of events
 and buffered reads simultaneously
Message-ID: <20190907115440.76b91bf4@archlinux>
In-Reply-To: <20190906121716.66194-6-sean@geanix.com>
References: <20190906121716.66194-1-sean@geanix.com>
        <20190906121716.66194-6-sean@geanix.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri,  6 Sep 2019 14:17:16 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> When events and buffered reads is enabled simultaneously, and the first
> event accours the interrupt pin stays high.
> 
> This can be reverted when we find a solution to allow events and
> buffered reads simultaneously.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 3 +++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c   | 3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index ef579650fd52..94e8884a1db1 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> @@ -601,6 +601,9 @@ int st_lsm6dsx_update_fifo(struct st_lsm6dsx_sensor *sensor, bool enable)
>  	struct st_lsm6dsx_hw *hw = sensor->hw;
>  	int err;
>  
> +	if (hw->enable_event)
> +		return -EBUSY;
> +

This strikes me as racey.  What stops you getting past the check and before
you get to the next line of code, an event is enabled? 

More than likely I'm missing a reason that can't happen, but a comment
here to explain why will make it immediately obvious!

>  	mutex_lock(&hw->conf_lock);
>  
>  	if (hw->fifo_mode != ST_LSM6DSX_FIFO_BYPASS) {
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 470821b54933..fdc44ff9601b 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -1277,6 +1277,9 @@ static int st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
>  	if (type != IIO_EV_TYPE_THRESH)
>  		return -EINVAL;
>  
> +	if (hw->fifo_mode != ST_LSM6DSX_FIFO_BYPASS)
> +		return -EBUSY;

Again, looks superficially racey.

> +
>  	if (state && hw->enable_event)
>  		return 0;
>  

