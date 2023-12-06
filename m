Return-Path: <linux-iio+bounces-671-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E66807672
	for <lists+linux-iio@lfdr.de>; Wed,  6 Dec 2023 18:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B19EF1C20B02
	for <lists+linux-iio@lfdr.de>; Wed,  6 Dec 2023 17:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6987B675A4;
	Wed,  6 Dec 2023 17:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byZCcy21"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DF360B97
	for <linux-iio@vger.kernel.org>; Wed,  6 Dec 2023 17:22:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C778C433C7;
	Wed,  6 Dec 2023 17:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701883324;
	bh=pV7QPg97SqibRfWwSXTJ9bM/ZwLkl3saXLiZ/F/SBFE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=byZCcy21iyxe8+gmGWSRlqCLkgZ9s3fdouAJLsRIYY9MKkS2kiVZDwhK2wmRtQz6g
	 /LBm8H6Pqq+LkqHKX/UG1LdvSIPkt1Pg0+gC5MzVw58gXwM8XlCuWX1+5rko/oRshc
	 x6Wih0D6eIKGIFe7C6lJrKQvmGhDbBZ77Yx2WAy0X6BuojkJMHXuj5WfAeo7obiLt5
	 TvFPWxVCq7uqehgWW5jItwjfrFHX06lX9B9gAl9mIFw+sn27opUC7pjnz/f6arzHst
	 JwcQvA9/pB/MmQhKI6Ihv1Qg/KIMkeH6xS7iGqnGFiD4C7AzdLbzfzicNLvv7iSSez
	 zRT1bskQnvh5w==
Date: Wed, 6 Dec 2023 17:21:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Marek Vasut <marex@denx.de>, linux-iio@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] iio: light: isl76682: Space consistency
Message-ID: <20231206172157.24439ca4@jic23-huawei>
In-Reply-To: <26aa7753-c597-4e5d-afd3-a407e5605335@gmail.com>
References: <20231205012246.104503-1-marex@denx.de>
	<26aa7753-c597-4e5d-afd3-a407e5605335@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 Dec 2023 09:21:02 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 12/5/23 03:22, Marek Vasut wrote:
> > Add missing space between { } to be consistent with the other { } .
> > No functional change.
> > 
> > Signed-off-by: Marek Vasut <marex@denx.de>  
> 
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
I squashed this into the driver patch.

Thanks,

Jonathan

> > ---
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Cc: Lars-Peter Clausen <lars@metafoo.de>
> > Cc: Matti Vaittinen <mazziesaccount@gmail.com>
> > Cc: linux-iio@vger.kernel.org
> > ---
> >   drivers/iio/light/isl76682.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/light/isl76682.c b/drivers/iio/light/isl76682.c
> > index 15a68609985b6..a17970fb3758e 100644
> > --- a/drivers/iio/light/isl76682.c
> > +++ b/drivers/iio/light/isl76682.c
> > @@ -328,7 +328,7 @@ static int isl76682_probe(struct i2c_client *client)
> >   
> >   static const struct i2c_device_id isl76682_id[] = {
> >   	{ "isl76682" },
> > -	{}
> > +	{ }
> >   };
> >   MODULE_DEVICE_TABLE(i2c, isl76682_id);
> >     
> 


