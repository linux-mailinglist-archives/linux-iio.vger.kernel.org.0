Return-Path: <linux-iio+bounces-15953-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68384A4094B
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 16:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFBA13AEC90
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 15:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6341422DD;
	Sat, 22 Feb 2025 15:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyc6i1Cc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286EE2E40E;
	Sat, 22 Feb 2025 15:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740236618; cv=none; b=SKARndgJPnT/Zvo3YfAGn0nQ3o2aF5ZkJs06RE0Pp0osbeeGNTEyESBLMW+5fE1v+QVge3OVb6OW/8ps01BoJrt1taK5bOR/0JQvufrQOKLuY9P98oeJQw3kelcSykyS99m+vmb3+KH7QtTyFPIeoNB62kCKbR+owho0NsafOD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740236618; c=relaxed/simple;
	bh=0Gbj5Q16AxCucUHa4V+FVAa8ClryIt98kxjbCLFCYzw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l3Ih5jfTE6xdYq9CSQveqEws8BKp9uoIoNh5/w4D/yhNkzUVcMvVv43wL+ZfDX66JZfiUxxsfxU0FBtO48hCHoFgSpedwOb0PcXfIvQ2HgKYqycPbHEpIw6hiqhv1CFG7er29yhrnjCDqMM9uFErL7/sBsrlz9TQnalkwp0vHA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyc6i1Cc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00BB1C4CED1;
	Sat, 22 Feb 2025 15:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740236617;
	bh=0Gbj5Q16AxCucUHa4V+FVAa8ClryIt98kxjbCLFCYzw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nyc6i1CcD7C2Kb1UkIpGD9eUc5EmpMTjguRgnIdrYxYb1+1qe8Y8xkiUqyIDlWZyY
	 kJ6ia2bd2qHXfWTI6p3pGql9y7rTavoqLm9ZWC4YsdZ0XcJa99psgCVUTNQWK1FPSR
	 sLt5brQZhegxWUT8aY+nuh5phTKTN751H6OFyiItnop/0IbhwMfJoWcTrDL6v0t6aY
	 EmvhbJ5+o3wntvTLK0Nhev8tVA2eQwy0zlRZuJOEUG7u2G1z8VHWvAUzrGRT2glgFP
	 XCImhnFBvHDsGkIkP37Pbv48v2x5OHbCOzO8icpOu59B9A/2vOK9/kmPSck2o0I7Dw
	 bSxe2OII589ZQ==
Date: Sat, 22 Feb 2025 15:03:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 cosmin.tanislav@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] iio: accel: adxl367: fix setting odr for
 activity time update
Message-ID: <20250222150329.66d6e79b@jic23-huawei>
In-Reply-To: <20250221203352.41941-1-l.rubusch@gmail.com>
References: <20250221203352.41941-1-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Feb 2025 20:33:52 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Fix setting the odr value to update activity time based on frequency
> derrived by recent odr, and not by obsolete odr value.
> 
> The [small] bug: When _adxl367_set_odr() is called with a new odr value,
> it first writes the new odr value to the hardware register
> ADXL367_REG_FILTER_CTL.
> Second, it calls _adxl367_set_act_time_ms(), which calls
> adxl367_time_ms_to_samples(). Here st->odr still holds the old odr value.
> This st->odr member is used to derrive a frequency value, which is
> applied to update ADXL367_REG_TIME_ACT. Hence, the idea is to update
> activity time, based on possibilities and power consumption by the
> current ODR rate.
> Finally, when the function calls return, again in _adxl367_set_odr() the
> new ODR is assigned to st->odr.
> 
> The fix: When setting a new ODR value is set to ADXL367_REG_FILTER_CTL,
> also ADXL367_REG_TIME_ACT should probably be updated with a frequency
> based on the recent ODR value and not the old one. Changing the location
> of the assignment to st->odr fixes this.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Fixes tag?

Otherwise looks good to me.

> ---
>  drivers/iio/accel/adxl367.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
> index add4053e7a02..0c04b2bb7efb 100644
> --- a/drivers/iio/accel/adxl367.c
> +++ b/drivers/iio/accel/adxl367.c
> @@ -601,18 +601,14 @@ static int _adxl367_set_odr(struct adxl367_state *st, enum adxl367_odr odr)
>  	if (ret)
>  		return ret;
>  
> +	st->odr = odr;
> +
>  	/* Activity timers depend on ODR */
>  	ret = _adxl367_set_act_time_ms(st, st->act_time_ms);
>  	if (ret)
>  		return ret;
>  
> -	ret = _adxl367_set_inact_time_ms(st, st->inact_time_ms);
> -	if (ret)
> -		return ret;
> -
> -	st->odr = odr;
> -
> -	return 0;
> +	return _adxl367_set_inact_time_ms(st, st->inact_time_ms);
>  }
>  
>  static int adxl367_set_odr(struct iio_dev *indio_dev, enum adxl367_odr odr)


