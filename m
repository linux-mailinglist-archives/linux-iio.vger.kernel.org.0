Return-Path: <linux-iio+bounces-9557-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 732A8979146
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 16:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AECCD1C21329
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 14:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B06A1CFEA9;
	Sat, 14 Sep 2024 14:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmYPP3sU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3614210E9;
	Sat, 14 Sep 2024 14:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726323068; cv=none; b=ms8Y42tdtiOukbXgSRWBCacpD63zmM3u66WG8qIRJJglu16g2/GUPc4AJvShH0XDz1rEDRqprg+K4LkzBUl5WMFLdPyLaN0itTIF+fADStv9Hu6Ibs+DGidrDTW6rrp+4mm2up0qnlEoA+yDa8CU4CJAWKthRQqh040hqOKOUfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726323068; c=relaxed/simple;
	bh=3nOXJXRyNZq2q0yoxkZo3eiyZlaYT59oNxT1os9EwV0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k7mY0So6djlUMe6l0veC/Z02rg6h2ReXS7QV0YlG8Fs7p8ombT2U7sQLx+4D8gj18e0MQLl+Psbzf70Lc2Uzgs9H3+texMEJv5rdKffY4UsQybMTDXPdtIncCnmCqHWiU++yun+VlwPAbP9YzdeKYkbcz43OqctFVmkfhSCe7FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FmYPP3sU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76308C4CEC0;
	Sat, 14 Sep 2024 14:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726323068;
	bh=3nOXJXRyNZq2q0yoxkZo3eiyZlaYT59oNxT1os9EwV0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FmYPP3sUacmEnrerDP8lpZ+05hF17xrftJhViMevKXCwZjMRnG0vsvPb5WOfdblxK
	 81tFdnQClrggS+cWw2CFAs7Qf+KAztvaGpcViFxP4CkljSAu7DVUs5Pc3bLxIMvaY1
	 s1eIeE6qdsIQQDLq8sohIAPT8r9OmKKqi+91KcEa004rrhE/kXwNcWvZHOo+P5m3/J
	 evZnNzUJch1CXeQiqh4u7pK3fiMv8eUtsurNiHKXyCeYaGHxME3ljY4L6wUwsvFB+B
	 Ro6c37Iv8O3gOAWQtB6IKplawiDemtUMPKwj9v6Pb2uZR6thgSrU97rotkguzj/fQa
	 oGuCcFakZmDcQ==
Date: Sat, 14 Sep 2024 15:10:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Denis Benato <benato.denis96@gmail.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Jagath Jog J
 <jagathjog1996@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, llvm@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH] iio: bmi323: Fix array reference in
 bmi323_core_runtime_suspend()
Message-ID: <20240914151059.3c2ba321@jic23-huawei>
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
Slight delay on these due to the likely opening of the merge window
meaning I probably won't get another pull request in.  That's fine
as these are fixes and can go in during rc1, but until rc1 is released
I won't have the driver in my fixes tree upstream.

Anyhow upshot is that I'll sit on this and the CONFIG_PM one until
after RC1.

Thanks,

Jonathan

> Best regards,
> Denis Benato


