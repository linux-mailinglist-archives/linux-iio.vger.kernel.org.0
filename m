Return-Path: <linux-iio+bounces-20296-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCB4AD0E40
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 17:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C065316DED6
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 15:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626D71C84C0;
	Sat,  7 Jun 2025 15:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFgmWfNe"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8F116A956;
	Sat,  7 Jun 2025 15:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749311411; cv=none; b=lHUif8CBVPnV0rN+QJY7vWfBZVhFVsi6DXzz9iLEd4DheJkevo2vzp5SLyWgAbIewkHcMIX1qbZ3kaWTCJi+09EiNWclleI6bbAhFQ+m+CRHHbkKqFJmr0CTbDTTa72Rc+kfEyRf7HZfee1MTRbnXgoB8iq98uScwBEXGAIM7E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749311411; c=relaxed/simple;
	bh=Cf3YSEsgdXLpS9NxtTieDY5//GqWFe3FpK6Ry6r7ABk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cmu89vFVnB0ArpdWJvwTfN5sBQBx41MY30TawcRPdAZj1EtMEb5IubFhMk6nSdPi0k/5VMNMZvlM9rEH2rADm33+LfkNoJXlQueZASifQLN7pY0WNOFXE69B6VhZ5tdokMP0Key5yzOOyQDM86Jco9QwCDrTbNheFtl3cfJbEvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFgmWfNe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20394C4CEE4;
	Sat,  7 Jun 2025 15:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749311410;
	bh=Cf3YSEsgdXLpS9NxtTieDY5//GqWFe3FpK6Ry6r7ABk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dFgmWfNeq/4Yqz4e7DyszammCh1GybSgHQEONW0EuyhEX0D/eeXIspiuUWmOVx3zC
	 jso+E5CNmfH8yLoos4PDv3qEbNXy4yZz1779h9iALOgBJ/AyICSHqc7nJQe4Dl6au7
	 99Gsya1K08j/pKoewrGBmF0+l8BqljWq17co+g33pHCE05zAu+Fnzrs/WJvobbyF0R
	 JC/9UDjR03gGsfpGmoMJ6d03ycF5nA+hcRlNkJgp/igfNm1jkCVSGZqOM4CuJ624jP
	 BLDY9U8Si+FIm0OkKicE/cZzVLXNlrazHsisOIrGWbELSnnulqpwIaxPvLxEYOOsIc
	 7vjgxHKTHNU9Q==
Date: Sat, 7 Jun 2025 16:50:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Gustavo Silva <gustavograzs@gmail.com>, Alex Lanzano
 <lanzano.alex@gmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iio: imu: bmi270: add channel for step counter
Message-ID: <20250607165004.4673e9f5@jic23-huawei>
In-Reply-To: <aEKxhPFDQEIN1xnm@smile.fi.intel.com>
References: <20250605-bmi270-events-v2-0-8b2c07d0c213@gmail.com>
	<20250605-bmi270-events-v2-1-8b2c07d0c213@gmail.com>
	<aEKxhPFDQEIN1xnm@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Jun 2025 12:14:44 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Thu, Jun 05, 2025 at 07:05:01PM -0300, Gustavo Silva wrote:
> > Add a channel for enabling/disabling the step counter, reading the
> > number of steps and resetting the counter.  
> 
> ...
> 
> > +static int bmi270_update_feature_reg(struct bmi270_data *data,
> > +				     enum bmi270_feature_reg_id id,
> > +				     u16 mask, u16 val)
> > +{
> > +	u16 regval = 0;  
> 
> Redundant assignment.
> 
> > +	int ret;
> > +
> > +	ret = bmi270_read_feature_reg(data, id, &regval);
> > +	if (ret)
> > +		return ret;  
> 
> > +	set_mask_bits(&regval, mask, val);  
> 
> You can't do this on the 16-bit values on some architectures.
> Maybe it's easy to implement cmpxchg() for 16-bit values there,
> though.

It doesn't need to be atomic, so stick to traditional

	regval &= ~mask;
	regval |= bits;

And avoid the fun of architectural corner cases entirely.
> 
> > +	return bmi270_write_feature_reg(data, id, regval);
> > +}  
> 


