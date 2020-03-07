Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D084C17CE03
	for <lists+linux-iio@lfdr.de>; Sat,  7 Mar 2020 13:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgCGMML (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Mar 2020 07:12:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:53008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgCGMML (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Mar 2020 07:12:11 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4E62206D5;
        Sat,  7 Mar 2020 12:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583583130;
        bh=P8N4UNcKSNSGMcRht8RlKDglPptQ3j1/8pnNFx0TVgE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mBerlUJISCnGRaiiA9XbYCDfLWqNhdnea1/0oLm4zKi6NqJK1C0jFQAywo/4CDGLp
         awlSHOdEcyeI1mIKgLIeXQ7ykavDyvSbGvk7O2zP8JK4mPbGqd2/dDUQj4RtqJx+SZ
         HpkXzKoxGK90efbbZRnl7WgDn1AuhbG3sqRJTHHs=
Date:   Sat, 7 Mar 2020 12:12:06 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Tachici <alexandru.tachici@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/6] iio: accel: adxl372: add iio events
Message-ID: <20200307121206.2d92521a@archlinux>
In-Reply-To: <20200225120909.12629-5-alexandru.tachici@analog.com>
References: <20200225120909.12629-1-alexandru.tachici@analog.com>
        <20200225120909.12629-5-alexandru.tachici@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 25 Feb 2020 14:09:07 +0200
Alexandru Tachici <alexandru.tachici@analog.com> wrote:

> Set INT1 interrupts to fire when activity/inactivity
> is detected by the device. On irq, push event code by calling
> iio_push_event().
> 
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
> ---
>  drivers/iio/accel/adxl372.c | 37 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
> index 775dc4f0aaf4..e669eaaaa07e 100644
> --- a/drivers/iio/accel/adxl372.c
> +++ b/drivers/iio/accel/adxl372.c
> @@ -114,6 +114,11 @@
>  #define ADXL372_STATUS_1_AWAKE(x)		(((x) >> 6) & 0x1)
>  #define ADXL372_STATUS_1_ERR_USR_REGS(x)	(((x) >> 7) & 0x1)
>  
> +/* ADXL372_STATUS_2 */
> +#define ADXL372_STATUS_2_INACT(x)		(((x) >> 4) & 0x1)
> +#define ADXL372_STATUS_2_ACT(x)			(((x) >> 5) & 0x1)
> +#define ADXL372_STATUS_2_AC2(x)			(((x) >> 6) & 0x1)
> +
>  /* ADXL372_INT1_MAP */
>  #define ADXL372_INT1_MAP_DATA_RDY_MSK		BIT(0)
>  #define ADXL372_INT1_MAP_DATA_RDY_MODE(x)	(((x) & 0x1) << 0)
> @@ -585,6 +590,27 @@ static int adxl372_get_status(struct adxl372_state *st,
>  	return ret;
>  }
>  
> +static void adxl372_push_event(struct iio_dev *indio_dev, s64 timestamp,
> +			       u8 status2)
> +{
> +	unsigned int ev_dir;
> +
> +	if (ADXL372_STATUS_2_ACT(status2))
> +		ev_dir = IIO_EV_DIR_RISING;
> +
> +	if (ADXL372_STATUS_2_INACT(status2))
> +		ev_dir = IIO_EV_DIR_FALLING;
> +
> +	if (ev_dir != IIO_EV_DIR_NONE)

Unless I'm missing something we don't have an enable / disable control for this
event.  Can we add one?

> +		iio_push_event(indio_dev,
> +			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> +						  0,
> +						  IIO_MOD_X_OR_Y_OR_Z,
> +						  IIO_EV_TYPE_THRESH,
> +						  ev_dir),
> +						  timestamp);
> +}
> +
>  static irqreturn_t adxl372_trigger_handler(int irq, void  *p)
>  {
>  	struct iio_poll_func *pf = p;
> @@ -598,6 +624,8 @@ static irqreturn_t adxl372_trigger_handler(int irq, void  *p)
>  	if (ret < 0)
>  		goto err;
>  
> +	adxl372_push_event(indio_dev, iio_get_time_ns(indio_dev), status2);
> +
>  	if (st->fifo_mode != ADXL372_FIFO_BYPASSED &&
>  	    ADXL372_STATUS_1_FIFO_FULL(status1)) {
>  		/*
> @@ -989,7 +1017,10 @@ static int adxl372_buffer_postenable(struct iio_dev *indio_dev)
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = adxl372_set_interrupts(st, ADXL372_INT1_MAP_FIFO_FULL_MSK, 0);
> +	mask = ADXL372_INT1_MAP_FIFO_FULL_MSK |
> +	       ADXL372_INT1_MAP_ACT_MSK	 |
> +	       ADXL372_INT1_MAP_INACT_MSK;
> +	ret = adxl372_set_interrupts(st, mask, 0);
>  	if (ret < 0)
>  		goto err;
>  
> @@ -1067,7 +1098,9 @@ static int adxl372_dready_trig_set_state(struct iio_trigger *trig,
>  	unsigned long int mask = 0;
>  
>  	if (state)
> -		mask = ADXL372_INT1_MAP_FIFO_FULL_MSK;
> +		mask = ADXL372_INT1_MAP_FIFO_FULL_MSK |
> +		       ADXL372_INT1_MAP_ACT_MSK	 |
> +		       ADXL372_INT1_MAP_INACT_MSK;
>  
>  	return adxl372_set_interrupts(st, mask, 0);
>  }

