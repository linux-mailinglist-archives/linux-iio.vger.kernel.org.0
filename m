Return-Path: <linux-iio+bounces-17667-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F24FAA7CE09
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 15:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBB467A607D
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 13:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C186F1A4F1F;
	Sun,  6 Apr 2025 13:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nckVRFiK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813452AEE0
	for <linux-iio@vger.kernel.org>; Sun,  6 Apr 2025 13:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743945361; cv=none; b=F/mhlyMNenZdTd0tkOvpn1Q3C9M4nnNhF5ErCTPJSIIOG9wKeZZHnLBZzpvyfPfnTh49VVQjZnjec0i5efWlvGvABPwpG1mfWx7hvPHAzKZDG7xP/hybEA2QbfWDeQVNA9cPqqcdHfoMUzROc1jyff7qltt+1YFa/SuEb2Njhdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743945361; c=relaxed/simple;
	bh=Xi5ElabfPIusXEZFG0IsVj5lw0zk5gOsHLKusqtwf/o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f6Y7deBHu+6WM6KIliWWf7n42yZjb7yVPRn02Dj9h3YGyxwgNIV5w9rzchOSpfoXvD1ImxndqNFY40lQwWDC0/z6Y8D3pxQoL7gNh9OkF8Up2sagUN9FNDTbE6Xufuxw7bQttUu7AhP+2j2u4YGij24xa9noRHLBgs2e7GxcvRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nckVRFiK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B6CC4CEE8;
	Sun,  6 Apr 2025 13:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743945360;
	bh=Xi5ElabfPIusXEZFG0IsVj5lw0zk5gOsHLKusqtwf/o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nckVRFiKHDqCwh3tA1BmgIQYaPI1uCXDpLCTGdVsC1CtNe39ErBVM9D5tObvvRkXM
	 O55RwOAgCbSBuy0EDzhBSyiNwRodj0ojK7HbDHZNIFWPEtlvLNsokFJ4duAGpedAc9
	 Bv7ELwuhbFf5j0O3rCbSqpOD1hexs9GxwhsYZ61WP50dxtxNXnHkTCeVBymQmu+Cy+
	 PObEroL0+UnsXOeisgzZxb5+x24q7vD1kWg1wOzoJXXFOp63cwMBeRDzW3xO4/cGLd
	 hr8hHSM42iBqNzO6YJlQxRGYVQHg0fV/ryf2d023F4LDr25EkLSZhPRfl219pridkP
	 PyedQYQk/IkTA==
Date: Sun, 6 Apr 2025 14:15:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Cosmin Tanislav
 <demonsingur@gmail.com>, Roan van Dijk <roan@protonic.nl>, Jyoti Bhayana
 <jbhayana@google.com>, Nishant Malpani <nish.malpani25@gmail.com>, Eugene
 Zaikonnikov <ez@norphonic.com>, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>, Shen Jianping
 <Jianping.Shen@de.bosch.com>, Matti Vaittinen <mazziesaccount@gmail.com>,
 Yasin Lee <yasin.lee.x@gmail.com>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 18/37] iio: imu: st_lsm6dsx: Factor out parts of
 st_lsm6dsx_shub_write_raw() to allow direct returns
Message-ID: <20250406141552.38325230@jic23-huawei>
In-Reply-To: <Z-uHkmGOXu1venxl@lore-desk>
References: <20250331121317.1694135-1-jic23@kernel.org>
	<20250331121317.1694135-19-jic23@kernel.org>
	<4ad0f22c-fdb9-47cb-b5a1-2802f47124d4@baylibre.com>
	<Z-uHkmGOXu1venxl@lore-desk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Apr 2025 08:28:34 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> > On 3/31/25 7:12 AM, Jonathan Cameron wrote:  
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > 
> > > By factoring out all the code that occurs with direct mode claimed
> > > to a helper function, that helper function can directly return simplifying
> > > code flow.
> > > 
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Cc: Lorenzo Bianconi <lorenzo@kernel.org>
> > > ---
> > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 65 +++++++++++---------
> > >  1 file changed, 35 insertions(+), 30 deletions(-)
> > > 
> > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> > > index c1b444520d2a..17a74f5adfc0 100644
> > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> > > @@ -614,53 +614,58 @@ st_lsm6dsx_shub_set_full_scale(struct st_lsm6dsx_sensor *sensor,
> > >  }
> > >  
> > >  static int
> > > -st_lsm6dsx_shub_write_raw(struct iio_dev *iio_dev,
> > > -			  struct iio_chan_spec const *chan,
> > > -			  int val, int val2, long mask)
> > > +__st_lsm6dsx_shub_write_raw(struct iio_dev *iio_dev,
> > > +			    struct iio_chan_spec const *chan,
> > > +			    int val, int val2, long mask)
> > >  {
> > >  	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
> > >  	int err;
> > >  
> > > -	err = iio_device_claim_direct_mode(iio_dev);
> > > -	if (err)
> > > -		return err;
> > > -
> > >  	switch (mask) {
> > >  	case IIO_CHAN_INFO_SAMP_FREQ: {
> > > +		struct st_lsm6dsx_hw *hw = sensor->hw;
> > > +		struct st_lsm6dsx_sensor *ref_sensor;
> > > +		u8 odr_val;
> > >  		u16 data;
> > > +		int odr;
> > >    
> > I would be tempted to rename `err` to `ret` so we don't have to introduce
> > a new `odr` variable.  
> 
> I guess keeping odr variable makes the code more readable.
Hmm. I'm not sure either way.  Will keep this as a potential follow up.

Jonathan

> 
> Regards,
> Lorenzo
> 


