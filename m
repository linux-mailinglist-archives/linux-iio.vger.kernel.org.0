Return-Path: <linux-iio+bounces-13252-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F749E8755
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 19:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4841028126F
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 18:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FD918B46A;
	Sun,  8 Dec 2024 18:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOkvFW5s"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBF8145324;
	Sun,  8 Dec 2024 18:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733682994; cv=none; b=TOZrirxODEII+R0p4fIaTnIQv6CHjH4woV7BfECWhAHkwEIVRAR/3c/uPNCQNcVd/eZDAE2hzIVlxcFrvZntKdS0VLLWZ3ralzksMvU3rv1fz7EQo7KRr86xqaKw8sOInOx8UnbL+nq8B2GuZa/rQ4+DVwLS2SRBarFy48cZbMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733682994; c=relaxed/simple;
	bh=uwAwsLiH1v9vvBoijhXpg91ZUnsxj/E1OcMHFiIkXaA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DdU9TxZtJQ0mxQWNItnFtrsoobR4rYagu1ZHqNYoGxmUUufxnIuUAqldBLsqBSv0pn/cGGyp6hGLBf9lqpMK9mu6GXEdtmgohS00P7BtPM7UBt+frycnit1o3qp6UQIUuDK/o3HOCfoB8F12HdAXBv3JaisAQzg+vTW8FRpjqbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOkvFW5s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F521C4CED2;
	Sun,  8 Dec 2024 18:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733682993;
	bh=uwAwsLiH1v9vvBoijhXpg91ZUnsxj/E1OcMHFiIkXaA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JOkvFW5s8uKXTyGjX3r8mhT8MueRbz/nIrRPSKQXDQ29kFgQwBmk2m4x2oEZQ2bSp
	 5EqCNaJ2QTTWSGeljk6bVPBzzghxRiEHXbz3n0TUke2KcNnBP46Bt0G1fQJ54IJA6X
	 yVHVwwt6FVYusvdJAeMWk52YH7WwxKR5bmsEC56Tkslx5s8X4oarw6vNmfxnfq55/C
	 2jxiXJftH74xo3/I241AhKJdSQK/bUTFGkfYDhsjzfIBFTgjnVRpGNsM9Qh0M7XqTy
	 EhQlLfJGwhJZ23Tw4+xofVCqqaKl0iv46nzYuX2dgADzMJ3B9gcEspKpKZ1FO1JCmR
	 p3dMl97ibWNyA==
Date: Sun, 8 Dec 2024 18:36:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Antoni Pokusinski
 <apokusinski01@gmail.com>, Francesco Dolcini <francesco@dolcini.it>,
 =?UTF-8?B?Sm/Do28=?= Paulo =?UTF-8?B?R29uw6dhbHZlcw==?=
 <jpaulo.silvagoncalves@gmail.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?B?Sm/Do28=?= Paulo =?UTF-8?B?R29u?=
 =?UTF-8?B?w6dhbHZlcw==?= <joao.goncalves@toradex.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, stable@vger.kernel.org
Subject: Re: [PATCH 01/11] iio: temperature: tmp006: fix information leak in
 triggered buffer
Message-ID: <20241208183623.62080663@jic23-huawei>
In-Reply-To: <521fffbf-6de8-4ce5-8af1-45c4029c7e60@gmail.com>
References: <20241125-iio_memset_scan_holes-v1-0-0cb6e98d895c@gmail.com>
	<20241125-iio_memset_scan_holes-v1-1-0cb6e98d895c@gmail.com>
	<521fffbf-6de8-4ce5-8af1-45c4029c7e60@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Dec 2024 20:28:12 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> On 25/11/2024 22:16, Javier Carrasco wrote:
> > The 'scan' local struct is used to push data to user space from a
> > triggered buffer, but it has a hole between the two 16-bit data channels
> > and the timestamp. This hole is never initialized.
> > 
> > Initialize the struct to zero before using it to avoid pushing
> > uninitialized information to userspace.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 91f75ccf9f03 ("iio: temperature: tmp006: add triggered buffer support")
> > Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> > ---
> >  drivers/iio/temperature/tmp006.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/tmp006.c
> > index 0c844137d7aa..02b27f471baa 100644
> > --- a/drivers/iio/temperature/tmp006.c
> > +++ b/drivers/iio/temperature/tmp006.c
> > @@ -252,6 +252,8 @@ static irqreturn_t tmp006_trigger_handler(int irq, void *p)
> >  	} scan;
> >  	s32 ret;
> >  
> > +	memset(&scan, 0, sizeof(scan));
> > +
> >  	ret = i2c_smbus_read_word_data(data->client, TMP006_VOBJECT);
> >  	if (ret < 0)
> >  		goto err;
> >   
> 
> @Jonathan, this patch requires 91f75ccf9f03 ("iio: temperature: tmp006:
> add triggered buffer support"), which is in the mainline kernel, but not
> accessible from iio/fixes-to-greg.
> 

Yeah. That happens briefly around merge windows.  In this particular
case to just after rc1 as there were some tree wide refactors that
needed merging.  Sometimes it takes me a few days to find the time to
rebase.  Doing anything mid merge window is a challenge at best.

> Is there any branch in IIO where the fixes and the new features are put
> together? I would like to rebase my series to automatically get rid of
> the applied patches, but iio/fixes-to-greg (where the patches were
> applied) does not have the feature this patch fixes. Of course I can
> manually drop the applied patches, but that is error-prone.
No. I don't push out such a tree, though I often do test merges.

You could use linux-next for your automation as that normally contains
both the fixes-togreg and togreg branches. Mind you that doesn't right
now because of the merge issue mentioned above,

Jonathan

> 
> This is not the first time I face this inconvenience, and I suppose
> there is a cleaner way that I might be missing, or maybe that branch I
> am looking for already exists.
> 
> Thanks and best regards,
> Javier Carrasco


