Return-Path: <linux-iio+bounces-9560-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A97979158
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 16:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5969281760
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 14:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C268A1CFEB7;
	Sat, 14 Sep 2024 14:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXjRP3Sw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBD81474A4;
	Sat, 14 Sep 2024 14:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726323636; cv=none; b=gQJcTuU0RzQoWbxTy2YfvpmgW4q1ZG+nAnNf2oVij0iPtRpQeZQ9mLhpt1CDPk0vYApASIfXwi2So8JzpqDLZQNPYxrHHx4pI8Trfm1fPnU1webIvKI/YWiY8mMQ0Aw7CJzA/7OcsNapUDyLHULWIg7+NCrqOZZVgfmhMiM+RAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726323636; c=relaxed/simple;
	bh=Toc8h9doacic5ht8ArXiOOW3fp9RjuntcnupIXZq8UI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=izPaUCRtUib1iEeLPNrEsvaNUQyRKnaeZtqHwex1LT8+yJV7dRd8NNN7sG4ubolbfPs39H2xap6liAvGvTDrlSlbQi0IyRX7bzuGdUVnrn+u4o90DpkqwgBPvjsmtpuF3tO1ieXyjDX9ozo/xFqBLgehC4HR2bD9e+XsR11/dOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXjRP3Sw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 316DCC4CEC6;
	Sat, 14 Sep 2024 14:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726323636;
	bh=Toc8h9doacic5ht8ArXiOOW3fp9RjuntcnupIXZq8UI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XXjRP3Swj9b6HTRf2bPrAStED8VqjT0a9U9FIGE+wEIrQGWe/N67NIMVQ4gEuKYMX
	 VsHuvwIPw3XRX9jt0i8TH81sHOX/laulNBjv6bR8LwUdJIBV3ALw4o6N0AaKU1aqor
	 wqHwHtFXrpkPHwuMoC3WfnSYsWPUkdYQcESjhkRkGXKnVK9sT5E6G0Q2TxvNRsZcUY
	 qfSthgVWDd6dt0N4OkHqf6dPFbcv2kMVFPn+09hR9en1M1+TKJslAGdDeIBqc8NCFP
	 SBXlnFnMLrhuCdpzKlI84F1dwqfeGgw2Fi5RJotJ11c6boO078imLOXQlCi0zmVfJJ
	 8FbDjMfHXL+/g==
Date: Sat, 14 Sep 2024 15:20:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Denis Benato <benato.denis96@gmail.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Jagath Jog J
 <jagathjog1996@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, llvm@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH] iio: bmi323: Fix array reference in
 bmi323_core_runtime_suspend()
Message-ID: <20240914152029.366ef9f0@jic23-huawei>
In-Reply-To: <76068b7e-af53-4422-ad97-cf3070182ec4@gmail.com>
References: <20240909-iio-bmi323-fix-array-ref-v1-1-51c220f22229@kernel.org>
	<76068b7e-af53-4422-ad97-cf3070182ec4@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Sep 2024 21:10:35 +0200
Denis Benato <benato.denis96@gmail.com> wrote:

> On 09/09/24 18:38, Nathan Chancellor wrote:
> > Clang warns (or errors with CONFIG_WERROR):
> > 
> >   drivers/iio/imu/bmi323/bmi323_core.c:133:27: error: variable 'bmi323_ext_reg_savestate' is not needed and will not be emitted [-Werror,-Wunneeded-internal-declaration]
> >     133 | static const unsigned int bmi323_ext_reg_savestate[] = {
> >         |                           ^~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > bmi323_ext_reg_savestate is only used within sizeof() through
> > ARRAY_SIZE(), so it is not unused, but it will not be emitted in the
> > final binary because sizeof() is evaluated only at compile time.
> > bmi323_ext_reg_savestate should have been used in the second parameter
> > in the call to bmi323_read_ext_reg() in the second for loop in
> > bmi323_core_runtime_suspend().
> > 
> > Fixes: 16531118ba63 ("iio: bmi323: peripheral in lowest power state on suspend")
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > ---
> >  drivers/iio/imu/bmi323/bmi323_core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
> > index 671401ce80dcf947b7b64ea3af112d2a42ca5501..64dbce23ce17bcdd11c0d4c454dbeb9de17ef56c 100644
> > --- a/drivers/iio/imu/bmi323/bmi323_core.c
> > +++ b/drivers/iio/imu/bmi323/bmi323_core.c
> > @@ -2199,7 +2199,7 @@ static int bmi323_core_runtime_suspend(struct device *dev)
> >  	}
> >  
> >  	for (unsigned int i = 0; i < ARRAY_SIZE(bmi323_ext_reg_savestate); i++) {
> > -		ret = bmi323_read_ext_reg(data, bmi323_reg_savestate[i],
> > +		ret = bmi323_read_ext_reg(data, bmi323_ext_reg_savestate[i],
> >  					  &savestate->reg_settings[i]);
This is saving it in the wrong place.
Noticed as Dan sent out another patch for this that was different.

So I'll pick up his instead.  Note that similar bug exists in resume.

Jonathan

> >  		if (ret) {
> >  			dev_err(data->dev,
> > 
> > ---
> > base-commit: 5ba0cb92584ba5e107c97001e09013c1da0772a8
> > change-id: 20240909-iio-bmi323-fix-array-ref-a0672a8213f0
> > 
> > Best regards,  
> Hello Nathan,
> 
> Thank you kindly for spotting and fixing it.
> 
> Regrettably while integrating suggestions I received I also changed the patch semantic and due to my hardware not having the irq pin connected to the cpu this went unnoticed.
> 
> Best regards,
> Denis Benato


