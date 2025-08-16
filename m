Return-Path: <linux-iio+bounces-22831-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 278D1B28E9B
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 16:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3127916CD87
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 14:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB3B2DF3F9;
	Sat, 16 Aug 2025 14:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vFRTUtwo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCB91E520C
	for <linux-iio@vger.kernel.org>; Sat, 16 Aug 2025 14:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755355735; cv=none; b=eLFSKv+a5DVXR3Bdgvpw3WwaLdRzyiqcDFziSt10K5eAfLDUM8H1mkOVIh80xhu14PtL9MCZCrOzoBpMmtG/dtKYCTGQ8tDeMPMMlLm2EWs+B3Rcyr/Mh7+L1P1ummcuJ45cb7/fz7fZmw/p1EvuggczKUw9VwoZPw0r7wfvDqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755355735; c=relaxed/simple;
	bh=jgVl7ApfncLrYH28rpWtJ7UbvrbGj4+So88rtUEKb5c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o1lJ9h5JRA01VB2H7ZNI/ezR056vbPrYuXPmqMOux/3/oZbGEoSf8A8XAO+PvxpVcxYfxpZoip3uvPITFGm1wA9NJggGJh2NdJ9fauhDNHlJuMk3ABW39GCaERaF731Y5N2KMIq9Bx1/nKw1uVN2uFfYUDPbrQ0d6BrHHhqrfG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vFRTUtwo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E2DC4CEEF;
	Sat, 16 Aug 2025 14:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755355735;
	bh=jgVl7ApfncLrYH28rpWtJ7UbvrbGj4+So88rtUEKb5c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vFRTUtwovpc8WLEE+7Nm9aNNoXQLk0LliKVOMCYCgwwvOjkAEnXBiPmKKN60eZdPB
	 DitYWZiUXPC1VBqBV3un2TFKzbuUK8CR+DLvmzxGQEpCOJPAuyAE0ov4QfAYKI+hc+
	 624VT2cw7eSP1FT6NTHfsiC4nWD0HbkOlutL/k6Hj3kBWEXRuG5hMQPSUWkVGZwbho
	 0skwWiHz6OdZ0/YPLZ7Tu0zDboIGY6MYmRSu84ILHSft5vwkxcKdIWRN58Xscvdb4P
	 oZvzV9WIKlkz2xv+CkQvTB8VUBJaKBOic7WwvbY+LAy7btvjc/CLVOAgHjfkdmv7KX
	 zM2p3sMCeOt0A==
Date: Sat, 16 Aug 2025 15:48:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Mudit Sharma <muditsharma.info@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Abhash Jha <abhashkumarjha123@gmail.com>,
 Astrid Rost <astrid.rost@axis.com>, =?UTF-8?B?TcOlcnRlbg==?= Lindahl
 <marten.lindahl@axis.com>, Gwendal Grignou <gwendal@chromium.org>,
 Christian Eggers <ChristianEggersceggers@arri.de>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 05/16] iio: light: vcnl4035: Use
 iio_push_to_buffers_with_ts() to allow runtime source buffer size check.
Message-ID: <20250816154844.0de9563e@jic23-huawei>
In-Reply-To: <5388ed7a-4555-4932-9f31-d7d25e5d8474@gmail.com>
References: <20250802164436.515988-1-jic23@kernel.org>
	<20250802164436.515988-6-jic23@kernel.org>
	<5388ed7a-4555-4932-9f31-d7d25e5d8474@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Aug 2025 09:57:46 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 02/08/2025 19:44, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > As the sizing of the source data has to include space for an aligned
> > timestamp it is a common source of bugs.  Using this new function that
> > takes the size of the provided buffer enables runtime checks for
> > possible bugs.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >   drivers/iio/light/vcnl4035.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
> > index dca229e74725..2ebc1e9496f3 100644
> > --- a/drivers/iio/light/vcnl4035.c
> > +++ b/drivers/iio/light/vcnl4035.c
> > @@ -117,8 +117,8 @@ static irqreturn_t vcnl4035_trigger_consumer_handler(int irq, void *p)
> >   		goto fail_read;
> >   	}
> >   	scan.chan = val;
> > -	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
> > -					iio_get_time_ns(indio_dev));
> > +	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
> > +				    iio_get_time_ns(indio_dev));
> >   
> >   fail_read:
> >   	iio_trigger_notify_done(indio_dev->trig);  
> 
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> (Although, seeing there is 3 patches touching the same spot, I might 
> squash the patch 04/16 with the 03/16. I would leave this one as a 
> standalone so the fix can be backported without this new API, if needed).
Whilst all the same spot I'm keen to keep them separate as they are all
unrelated changes.

I'll be respinning this anyway with an additional fix for the buffer
type.

Jonathan

> 
> Yours,
> 	-- Matti
> 


