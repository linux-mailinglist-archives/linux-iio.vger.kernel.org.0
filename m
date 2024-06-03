Return-Path: <linux-iio+bounces-5707-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9017E8D8A07
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 21:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43EC91F26057
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 19:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37A0135A53;
	Mon,  3 Jun 2024 19:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXU/fq+t"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7036923A0;
	Mon,  3 Jun 2024 19:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717442597; cv=none; b=hFaks+mWlRNVsFpEV2O+3OSJ9SvrCYy+TBLYg+yG8qymXC7iJpbS0hiGFSoZ2wt62MD2VXwqlQy5dZa8NlAbzmiFRlzi2K9/6/TwAesRbIvsypbiwaiQedb9to/cHX89hzzsMRCb/l55OEXcLc152llSEaWNaKFRWT2aAZLXLMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717442597; c=relaxed/simple;
	bh=H7l3b6KtMYvqUP8MJmxyxv5SuPQuY0kBYaeXMcuur24=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FksHA9hZSZwTOHhUSl3P8jC1o16PfdDwNGVVF+X3LAv1EaCYQbkhbNilKcQyb0g07o7IctZ78CpHWmVu8g8ielR48ZU1b9guQ0aKV67VAe/c9Jjd8rOxY4KUxjwcBum4B0m8/dalcIUCV2InC5dUfQXxFfe3/ZnJkFZSf6Uq8yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXU/fq+t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C17CDC2BD10;
	Mon,  3 Jun 2024 19:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717442596;
	bh=H7l3b6KtMYvqUP8MJmxyxv5SuPQuY0kBYaeXMcuur24=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FXU/fq+tw7WbsPhS6oFRNkDgDNX84HNB5ytDLpDu48awP8ZUKScqIiNE2NrbBKpOZ
	 XlF+l/ilc8B1pvKEd3uPA91dT5Lrb8XHBghmaHtwJj8ftcW/Lh0mF6XDDe95/D2QY4
	 dLn2X15Tj1DoOLsdiRqOUpfkCWzyPGFeo/KYzebe8oY2igx1Y447Crr/RoNAGXQ9Xr
	 H/FXGBh6Q/CyBDMxfmYZjNIpkDUHvJMJQRhKOEEtt000A0KvdTJJdNlJiBaWdH7nRI
	 tMCO4m0JoLqWe+Y+Lz1MEVmcoskbOWw/CqlqyoJ5NKLc5NejyC6toYx7Boq81SmFMK
	 S0TdIcwfdedRw==
Date: Mon, 3 Jun 2024 20:23:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, himanshujha199640@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 04/17] iio: chemical: bme680: Fix sensor data read
 operation
Message-ID: <20240603202303.0b1054a3@jic23-huawei>
In-Reply-To: <20240602190015.GA387181@vamoiridPC>
References: <20240527183805.311501-1-vassilisamir@gmail.com>
	<20240527183805.311501-5-vassilisamir@gmail.com>
	<20240602134106.2538471a@jic23-huawei>
	<20240602190015.GA387181@vamoiridPC>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> > > +}
> > > +
> > > +static void bme680_wait_for_eoc(struct bme680_data *data)  
> > Don't call it wait as that implies something is being checked.
> > 
> > bme680_conversion_sleep() or something like that.
> >   
> 
> This sesnor has a sleep mode, so I think calling a function like that might
> make it a bit confusing, since we are not putting the sensor into sleeping
> mode but rather actually wait for the eoc.

Hmm. Bikesheding time. I don't like wait because it generally implies a
condition check.

Maybe just go more explicit
bme680_suspend_execution_until_conversion_done()
bme680_suspend_execution_whilst_converting()
or similar might be overkill but something along those lines.

The suspend execution terminology lifted from man usleep

> 
> > > +{
> > > +	int wait_eoc = bme680_conversion_time_us(data->oversampling_temp +
> > > +						 data->oversampling_press +
> > > +						 data->oversampling_press,
> > > +						 data->heater_dur);  

