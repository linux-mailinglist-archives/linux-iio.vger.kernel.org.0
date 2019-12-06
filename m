Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 621CA1156B2
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2019 18:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfLFRqJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 6 Dec 2019 12:46:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:37050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbfLFRqJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 6 Dec 2019 12:46:09 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3BEE2245C;
        Fri,  6 Dec 2019 17:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575654368;
        bh=uy2D2T25IuOX4PtUcvX19734uZPmwrQHYd+L8BEJhS4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZIbioyM4PJI0qiOpS/zqca7zfBJuiEzqd74MDO1L0OVJfts2GOcXg6RAms6PLHD/f
         xWGxnfTspsIKM/0pGgyYc/+KT1+Dnp4iZkJ+Q6UfOYfVW2hhMqgDy1A7n1jgQdDhny
         prZQ1O+HzwGpJjsCWtsY1pF1K4xOtrfAO5TTuV9w=
Date:   Fri, 6 Dec 2019 17:46:04 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: imu: st_lsm6dsx: fix checkpatch warning
Message-ID: <20191206174604.59d947b1@archlinux>
In-Reply-To: <34b2e207df91e1645ba5a4d2b12dfd41bdd17336.1575236122.git.lorenzo@kernel.org>
References: <34b2e207df91e1645ba5a4d2b12dfd41bdd17336.1575236122.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  1 Dec 2019 23:38:18 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Fix following checkpatch warning:
> 
> CHECK: Alignment should match open parenthesis
> +static int st_lsm6dsx_read_event(struct iio_dev *iio_dev,
> +                                  const struct iio_chan_spec *chan,
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing to
hopefully pass completely unnoticed by the autobuilders.

Thanks,

Jonathan

> ---
> Changes since v1:
> - remove extra line break in routine signature
> - remove not related change
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index a7d40c02ce6b..ff5bac8ff9c6 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -1608,11 +1608,11 @@ static int st_lsm6dsx_event_setup(struct st_lsm6dsx_hw *hw, int state)
>  }
>  
>  static int st_lsm6dsx_read_event(struct iio_dev *iio_dev,
> -				   const struct iio_chan_spec *chan,
> -				   enum iio_event_type type,
> -				   enum iio_event_direction dir,
> -				   enum iio_event_info info,
> -				   int *val, int *val2)
> +				 const struct iio_chan_spec *chan,
> +				 enum iio_event_type type,
> +				 enum iio_event_direction dir,
> +				 enum iio_event_info info,
> +				 int *val, int *val2)
>  {
>  	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
>  	struct st_lsm6dsx_hw *hw = sensor->hw;

