Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80D1BD4FA3
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2019 14:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbfJLMWy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Oct 2019 08:22:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726793AbfJLMWx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Oct 2019 08:22:53 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C91C2089C;
        Sat, 12 Oct 2019 12:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570882972;
        bh=ASXmjJt9r9f2wqoPIRQ3SYbzuzWHSIVGJw5QldTCVl8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=q9I3LG6CX+dkLgkjRXkIOr4H2SJuq98eQacWRv+nTPaj90oNIghVwUt0J3T3xZsBc
         S4gg9UfRhxZxDa+/kK5byIoMWj0XEQ9TtzahmKeySAhzSh6mJ+SKGkCXfWZOq+6RAz
         7sfkoc+RzqeU+mynwfJiyv6iW0LHKAq1OKX6xoqI=
Date:   Sat, 12 Oct 2019 13:22:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, sean@geanix.com, martin@geanix.com,
        rjones@gateworks.com, lorenzo.bianconi@redhat.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 07/13] iio: imu: st_lsm6dsx: rely on
 st_lsm6dsx_update_bits_locked configuring events
Message-ID: <20191012132248.2831a23a@archlinux>
In-Reply-To: <903ebb1b14412abdee3029417ae146515e49c685.1570367532.git.lorenzo@kernel.org>
References: <cover.1570367532.git.lorenzo@kernel.org>
        <903ebb1b14412abdee3029417ae146515e49c685.1570367532.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  6 Oct 2019 15:22:01 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Rely on st_lsm6dsx_update_bits_locked in st_lsm6dsx_write_event and
> st_lsm6dsx_event_setup routines since they can run concurrently with
> sensor hub configuration
> 
> Fixes: b5969abfa8b8 ("iio: imu: st_lsm6dsx: add motion events")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 25 +++++++++++---------
>  1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 7e9e1ef81742..023646762b4a 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -1483,6 +1483,7 @@ static int st_lsm6dsx_write_raw(struct iio_dev *iio_dev,
>  static int st_lsm6dsx_event_setup(struct st_lsm6dsx_hw *hw, int state)
>  {
>  	const struct st_lsm6dsx_reg *reg;
> +	unsigned int data;
>  	int err;
>  
>  	if (!hw->settings->irq_config.irq1_func.addr)
> @@ -1490,17 +1491,17 @@ static int st_lsm6dsx_event_setup(struct st_lsm6dsx_hw *hw, int state)
>  
>  	reg = &hw->settings->event_settings.enable_reg;
>  	if (reg->addr) {
> -		err = regmap_update_bits(hw->regmap, reg->addr, reg->mask,
> -					 ST_LSM6DSX_SHIFT_VAL(state, reg->mask));
> +		data = ST_LSM6DSX_SHIFT_VAL(state, reg->mask);
> +		err = st_lsm6dsx_update_bits_locked(hw, reg->addr,
> +						    reg->mask, data);
>  		if (err < 0)
>  			return err;
>  	}
>  
>  	/* Enable wakeup interrupt */
> -	return regmap_update_bits(hw->regmap, hw->irq_routing->addr,
> -				  hw->irq_routing->mask,
> -				  ST_LSM6DSX_SHIFT_VAL(state,
> -					hw->irq_routing->mask));
> +	data = ST_LSM6DSX_SHIFT_VAL(state, hw->irq_routing->mask);
> +	return st_lsm6dsx_update_bits_locked(hw, hw->irq_routing->addr,
> +					     hw->irq_routing->mask, data);
>  }
>  
>  static int st_lsm6dsx_read_event(struct iio_dev *iio_dev,
> @@ -1531,6 +1532,8 @@ static int st_lsm6dsx_write_event(struct iio_dev *iio_dev,
>  {
>  	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
>  	struct st_lsm6dsx_hw *hw = sensor->hw;
> +	const struct st_lsm6dsx_reg *reg;
> +	unsigned int data;
>  	int err;
>  
>  	if (type != IIO_EV_TYPE_THRESH)
> @@ -1539,11 +1542,11 @@ static int st_lsm6dsx_write_event(struct iio_dev *iio_dev,
>  	if (val < 0 || val > 31)
>  		return -EINVAL;
>  
> -	err = regmap_update_bits(hw->regmap,
> -				 hw->settings->event_settings.wakeup_reg.addr,
> -				 hw->settings->event_settings.wakeup_reg.mask,
> -				 val);
> -	if (err)
> +	reg = &hw->settings->event_settings.wakeup_reg;
> +	data = ST_LSM6DSX_SHIFT_VAL(val, reg->mask);
> +	err = st_lsm6dsx_update_bits_locked(hw, reg->addr,
> +					    reg->mask, data);
> +	if (err < 0)
>  		return -EINVAL;
>  
>  	hw->event_threshold = val;

