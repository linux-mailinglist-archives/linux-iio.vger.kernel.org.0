Return-Path: <linux-iio+bounces-27882-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD07D38636
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 20:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CBEF30F49F1
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 19:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6912E3A1D1E;
	Fri, 16 Jan 2026 19:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQv75jdW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297DC3A0E86;
	Fri, 16 Jan 2026 19:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768592867; cv=none; b=mk8vF5u2ohPOAb/ZdmY8h1MLvoCth43tCVz3xkXeE2yEtG/kWggLhrxHcSMAMs7yztehypS178/ug0ewzQGA+1b3oZf+l3kA8OsUoP8NZKVEzvguwScGYCBZKJJ9uo9EVTu7D7OgyCLlDWH63eao5p3/DUBOiEN0hX4xJlL9ZKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768592867; c=relaxed/simple;
	bh=0UNsYEgiW8g29WfZOT3y/0SWdGdxw+2C6yO8H9+eny0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VQddhbI4b1DGCAtaaLzzfcOK0BtYtc17/CBWIpenf9BjyR+5k5Df4OBPiTAN445M3zweaBDTigarzcgjGRp2qnd+ETXHzyWkDlt9bg0ls6cwjxbJrgT96Vn9VkslE8TW7JmB6IFoFohnC6eylf8Ach4JT0yziA6cOCnqHuzPt5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQv75jdW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50FCC116C6;
	Fri, 16 Jan 2026 19:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768592866;
	bh=0UNsYEgiW8g29WfZOT3y/0SWdGdxw+2C6yO8H9+eny0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OQv75jdWfIWXUrwCHn/bN5NsvVx7XUQl3ivOCGT0jn6c9f7h7UMJ7jWfvKLo+/fx2
	 1twbx6dZ+kFqCachCEVr+vbYMJB8Xlp4xgMaSEuzraP8LaIprNBGlscSztKedYNNBo
	 GhvmshQfl9Wbsrl8XU6Xjr3h2T0x4WXwDP+YL+VqRPwrHe7T99inUvMU9p8l8h1opL
	 XvEbtQS9JILVdyOaTzYklRCUS0bH/TMUaePOs2FBTo2Mw3ZGcJuPZh0KQsqdyVF+WP
	 gQ6qsRX2IQZ00K4dBknoKokOycGIaCLVy913xJEAf4w5JZFb+yW5S0CKBSLiU/aabi
	 i0+zOV/2f7dRQ==
Date: Fri, 16 Jan 2026 19:47:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Francesco Lavra <flavra@baylibre.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iio: imu: st_lsm6dsx: Set FIFO ODR for
 accelerometer and gyroscope only
Message-ID: <20260116194738.48b6e3ff@jic23-huawei>
In-Reply-To: <aWjn3cCNhm9t_DCe@lore-desk>
References: <20260115122431.1014630-1-flavra@baylibre.com>
	<20260115122431.1014630-2-flavra@baylibre.com>
	<aWjn3cCNhm9t_DCe@lore-desk>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Jan 2026 14:13:01 +0100
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> > The st_lsm6dsx_set_fifo_odr() function, which is called when enabling and
> > disabling the hardware FIFO, checks the contents of the hw->settings->batch
> > array at index sensor->id, and then sets the current ODR value in sensor
> > registers that depend on whether the register address is set in the above
> > array element. This logic is valid for internal sensors only, i.e. the
> > accelerometer and gyroscope; however, since commit c91c1c844ebd ("iio: imu:
> > st_lsm6dsx: add i2c embedded controller support"), this function is called
> > also when configuring the hardware FIFO for external sensors (i.e. sensors
> > accessed through the sensor hub functionality), which can result in
> > unrelated device registers being written.
> > 
> > Add a check to the beginning of st_lsm6dsx_set_fifo_odr() so that it does
> > not touch any registers unless it is called for internal sensors.
> > 
> > Fixes: c91c1c844ebd ("iio: imu: st_lsm6dsx: add i2c embedded controller support")
> > Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > index 55d877745575..1ee2fc5f5f1f 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > @@ -225,6 +225,10 @@ static int st_lsm6dsx_set_fifo_odr(struct st_lsm6dsx_sensor *sensor,
> >  	const struct st_lsm6dsx_reg *batch_reg;
> >  	u8 data;
> >  
> > +	/* Only internal sensors have a FIFO ODR configuration register. */
> > +	if (sensor->id >= ARRAY_SIZE(hw->settings->batch))
> > +		return 0;  
> 
> I guess it is more clear to check if the sensor is acc or gyro here.
> What do you think? Something like:
> 
> 	if (sensor->id != ST_LSM6DSX_ID_GYRO &&
> 	    sensor->id != ST_LSM6DSX_ID_ACC)
> 	    return 0;

Disadvantage is that to check for overflow we have to know those are 0 and 1.
I'm not sure which is better of the two here. One is more logically correct
the other is easier to review :)

> 
> Regards,
> Lorenzo
> 
> > +
> >  	batch_reg = &hw->settings->batch[sensor->id];
> >  	if (batch_reg->addr) {
> >  		int val;
> > -- 
> > 2.39.5
> >   


