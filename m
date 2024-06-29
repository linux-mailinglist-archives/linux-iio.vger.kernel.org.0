Return-Path: <linux-iio+bounces-7050-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA2791CE6F
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 19:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44FC31C20F38
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 17:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A945F12FF83;
	Sat, 29 Jun 2024 17:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3bh7lQ9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C1321364
	for <linux-iio@vger.kernel.org>; Sat, 29 Jun 2024 17:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719683553; cv=none; b=GpSvlmDjSWNFam4Y9LPo6mCf++teGdj61DCzZRgYsDo/gFreHA3ip2V4G8huWMYdxxnQJ2oArgvm45Z61T++p6WSGpRvTeA3TUtqAGZhGoeomJ3suEw8hyuAeuoe56daG1uKhknhlRkhiMa9hbuZn5e3SU3hpabQ9GuFAyJQY24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719683553; c=relaxed/simple;
	bh=8bQdHzagqvrpNhpU8quVEDCFxDnRqh9YOIRSbLg+brA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UN+JPPvRg71tU/cFSbpCLcXuEhKR1E5KJjAlRZDnXN+OKSXRyY66W4QTium3KWXg4eTZqzTe0iRtYPGxOxQ/WlY51WpYh2yguufabuZ56BCSY1UAulvEaPbQESEl+MEfTvu1jWikb/uvZggSY7M9P/6RGx4wPgEmx7BlJS7iLmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3bh7lQ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 654F1C2BBFC;
	Sat, 29 Jun 2024 17:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719683552;
	bh=8bQdHzagqvrpNhpU8quVEDCFxDnRqh9YOIRSbLg+brA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z3bh7lQ9bZA8/XJECuUnI9mMWVr+37PFPqcqzrKrHQmUzH/KL+n3ypm0Eko6z8XE3
	 zB2qRNsgPNhO1YimsezpyDaokbw3Pg+Jc8VDuq76qgYCSJFx9c+nDFiK9eljZ1bje6
	 rPTNOXM5Oo/faPXlLhVVkTouXw9QdH98FgDduYLem9x7xcSlsntpB66wgKciB7BT3G
	 JXXEV7TN8M6ET/qGy0IEqt4PBLO5EjyrP9bbGfRmXzmtnu/rt6WadzeF9wV5XtsoTh
	 ty59sD/TcG9n1pIa+x95cDC0B8YpmPV87ST9BqDWLapvS/aRIkYphHST5jF4njGTg+
	 +PUcecIy5u/dQ==
Date: Sat, 29 Jun 2024 18:52:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc: Mudit Sharma <muditsharma.info@gmail.com>, lars@metafoo.de,
 dan.carpenter@linaro.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: light: apds9306: Fix error handing
Message-ID: <20240629185227.59478a11@jic23-huawei>
In-Reply-To: <bea64407-fcf4-4a87-bd77-6bd3f3e2f70b@tweaklogic.com>
References: <20240625210203.522179-1-muditsharma.info@gmail.com>
	<bea64407-fcf4-4a87-bd77-6bd3f3e2f70b@tweaklogic.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jun 2024 21:40:29 +0930
Subhajit Ghosh <subhajit.ghosh@tweaklogic.com> wrote:

> On 26/6/24 06:32, Mudit Sharma wrote:
> > The return value of 'iio_gts_find_int_time_by_sel()' is assigned to
> > variable 'intg_old' but value of 'ret' is checked for error. Update to
> > use 'intg_old' for error checking.
> > 
> > Fixes: 620d1e6c7a3f ("iio: light: Add support for APDS9306 Light Sensor")
> > Signed-off-by: Mudit Sharma <muditsharma.info@gmail.com>
> > ---
> >   drivers/iio/light/apds9306.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
> > index d6627b3e6000..66a063ea3db4 100644
> > --- a/drivers/iio/light/apds9306.c
> > +++ b/drivers/iio/light/apds9306.c
> > @@ -583,8 +583,8 @@ static int apds9306_intg_time_set(struct apds9306_data *data, int val2)
> >   		return ret;
> >   
> >   	intg_old = iio_gts_find_int_time_by_sel(&data->gts, intg_time_idx);
> > -	if (ret < 0)
> > -		return ret;
> > +	if (intg_old < 0)
> > +		return intg_old;
> >   
> >   	if (intg_old == val2)
> >   		return 0;  
> Hi Mudit,
> 
> Good find.
> Working well on my target dev board with your changes.
> 
> Reviewed-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.
Thanks,

Jonathan

> 
> 
> Regards,
> Subhajit Ghosh


