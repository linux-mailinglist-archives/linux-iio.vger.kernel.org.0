Return-Path: <linux-iio+bounces-14841-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC20A24AF0
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 18:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3183E3A6EEE
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 17:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834EA1C5F0C;
	Sat,  1 Feb 2025 17:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAeKtwlF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E10AAD27;
	Sat,  1 Feb 2025 17:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738429779; cv=none; b=QE524XOtlAL2o27vFzasOCJb0QHCGT6wMGt+c16sjtVAfN8jLaW0usCqXemRxLLYaq3xwVeJu5/9cPl1ZUkLO6/WrwKIUTQvwnV+0P67Cqmbn4YXsu/VnAESUuYud3sYLaEI38zVHJEWSlKaPfcfz5jGE2R1dlYLGn8HqOn/YJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738429779; c=relaxed/simple;
	bh=93jzYYYwy+f3AOZkq4YAuvBQig70r3Qr6WNPyLJkaEs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L0RODR7U1jqMwSmPVlLak/tR2DPX88H6UrB+exPK4s+FOJzQ7QM1s5RD09D6wY+YS8ccWnK1hYrU/pBAMEoaBDovV92ZP1UlcmBgvtt2sFhDr0JWdcPO8pZXONV3JvygM2yYOuxXY33vXuA8nJp00mqJG6Zyy8tbJA0bHqeDovw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAeKtwlF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E74FC4CED3;
	Sat,  1 Feb 2025 17:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738429778;
	bh=93jzYYYwy+f3AOZkq4YAuvBQig70r3Qr6WNPyLJkaEs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SAeKtwlFotM/7I7sIYbXlKiTWHseKlJC7z/k9gfe01DyeWY67Lbrpio/Zd+Z4FK7h
	 tyKIRaT3TMyVZVBn8FgMZmRfNSqffvI/p/wg6JrpJaya7fle5q60CVBGpDcKCzcsdk
	 J8vva6uJwqmgD57UyGu3vfOtCLmRQXrH/4DNrVZ9MPxjE3vdn3GvEl2Kcujr9wdAjz
	 xMUZ9YIGpbb+vdyBYOYkm+KOmOSz6H0ODr6Tw5Mg21Nd88Z9uMt4P2YT+MIZAlbX4f
	 Um4iPQCr69KYY7bZY7Evv87kbTDmvHlsJkjtdrHqnDKbNDhvVrgB75tgYbzT5aoBpL
	 OdCwTDQv8RvaA==
Date: Sat, 1 Feb 2025 17:09:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v1 07/12] iio: accel: adxl345: show tap status and
 direction
Message-ID: <20250201170933.26b8625c@jic23-huawei>
In-Reply-To: <20250128120100.205523-8-l.rubusch@gmail.com>
References: <20250128120100.205523-1-l.rubusch@gmail.com>
	<20250128120100.205523-8-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jan 2025 12:00:55 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Provide information in the iio tap event about the tap direction. This
> can be verified using 'iio_event_monior adxl345'. Reading out the
> ACT_TAP_STATUS register is also in preparation for activity events.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>

So, this confuses me a little.  You have separate controls on
enabling the directions but only a single bit to indicate that a tap
was detected. Can only one be enabled at time?  If not how does
reporting only one direction make sense?

That aside, why not squash this with the previous patch?


Jonathan


> ---
>  drivers/iio/accel/adxl345_core.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 0d991f3ec10c..7831ec511941 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -800,17 +800,26 @@ static const struct iio_buffer_setup_ops adxl345_buffer_ops = {
>  	.predisable = adxl345_buffer_predisable,
>  };
>  
> -static int adxl345_get_status(struct adxl345_state *st, unsigned int *int_stat)
> +static int adxl345_get_status(struct adxl345_state *st, unsigned int *int_stat,
> +			      enum iio_modifier *act_tap_dir)
>  {
>  	unsigned int regval;
>  	bool check_tap_stat;
>  
> +	*act_tap_dir = IIO_NO_MOD;
>  	check_tap_stat = FIELD_GET(ADXL345_REG_TAP_AXIS_MSK, st->tap_axis_ctrl) > 0;
>  
>  	if (check_tap_stat) {
>  		/* ACT_TAP_STATUS should be read before clearing the interrupt */
>  		if (regmap_read(st->regmap, ADXL345_REG_ACT_TAP_STATUS, &regval))
>  			return -EINVAL;
> +
> +		if (FIELD_GET(ADXL345_Z_EN, regval) > 0)
> +			*act_tap_dir = IIO_MOD_Z;
> +		else if (FIELD_GET(ADXL345_Y_EN, regval) > 0)
> +			*act_tap_dir = IIO_MOD_Y;
> +		else if (FIELD_GET(ADXL345_X_EN, regval) > 0)
> +			*act_tap_dir = IIO_MOD_X;
>  	}
>  
>  	return regmap_read(st->regmap, ADXL345_REG_INT_SOURCE, int_stat);
> @@ -835,7 +844,8 @@ static int adxl345_fifo_push(struct iio_dev *indio_dev,
>  	return 0;
>  }
>  
> -static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat)
> +static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
> +			      enum iio_modifier act_tap_dir)
>  {
>  	s64 ts = iio_get_time_ns(indio_dev);
>  	int ret;
> @@ -843,7 +853,7 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat)
>  	if (FIELD_GET(ADXL345_INT_SINGLE_TAP, int_stat)) {
>  		ret = iio_push_event(indio_dev,
>  				     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
> -							IIO_MOD_X_OR_Y_OR_Z,
> +							act_tap_dir,
>  							IIO_EV_TYPE_GESTURE,
>  							IIO_EV_DIR_SINGLETAP),
>  				     ts);
> @@ -866,12 +876,13 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
>  	struct iio_dev *indio_dev = p;
>  	struct adxl345_state *st = iio_priv(indio_dev);
>  	int int_stat;
> +	enum iio_modifier act_tap_dir;
>  	int samples;
>  
> -	if (adxl345_get_status(st, &int_stat))
> +	if (adxl345_get_status(st, &int_stat, &act_tap_dir))
>  		return IRQ_NONE;
>  
> -	if (adxl345_push_event(indio_dev, int_stat) == 0)
> +	if (adxl345_push_event(indio_dev, int_stat, act_tap_dir) == 0)
>  		return IRQ_HANDLED;
>  
>  	if (FIELD_GET(ADXL345_INT_WATERMARK, int_stat)) {


