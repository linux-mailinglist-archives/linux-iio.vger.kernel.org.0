Return-Path: <linux-iio+bounces-4219-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBD98A3BF9
	for <lists+linux-iio@lfdr.de>; Sat, 13 Apr 2024 11:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB3F81C20E11
	for <lists+linux-iio@lfdr.de>; Sat, 13 Apr 2024 09:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6651E515;
	Sat, 13 Apr 2024 09:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URe3+xG8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6E14A33
	for <linux-iio@vger.kernel.org>; Sat, 13 Apr 2024 09:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713001080; cv=none; b=Lrz3fnNQQUshVq10PnWPRvqOTzZQeVW9CoblFpfRHIj3tn6MGauDzIXM9U4XybINV1MCsNeMrdlzda+EhW237zdVzuCNlXYdx/hJkmM3X3Sud24w9NNERm9dx1ifKBTn4c677UQFwVuPmW9obW7TgJMzWS3OJ3vFFGNoQfs6r/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713001080; c=relaxed/simple;
	bh=+h5i09i7fA0BAXVvnVaLk5d99fDqy+jcnQhs78byFEM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JbWNZfdK1YqsUiXCDSvM/VTNoiCBRuHAm74QG9vDIzmksRQW7lRa5n98GBN/iQaTXD8e7nYkLbR/lsNj/yCL3wuKpCjR3vp4X7D6w7g/ZH3kYPqqI31oL11ky5TTJrnDpT45bKzczsm+/7FjM+s8dNJ3YaIFj3IaIWCtr9cvoCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URe3+xG8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95EBAC2BBFC;
	Sat, 13 Apr 2024 09:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713001080;
	bh=+h5i09i7fA0BAXVvnVaLk5d99fDqy+jcnQhs78byFEM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=URe3+xG8Rxq1Itw1TDL84UccSHDtHr5WGqYk4VOpZeUUzGVSChxSUBbaqjOW6CDI+
	 /eh7Tvme/NQZQzMb76tT77A911Jy3YH5q1swOjryOaGLXnHE6kXEmBbRHfPkzCIzxe
	 zM8tPW6nX8K4VThwQRToFCr3lNgkXzsGP1bS6+U53IymRVHvzU3TZZAAhgFMsteEXI
	 066/ubE46yaVku6NlKk4lnSGE5YYRtn8ZjV/yK+OIrNU+5pdPh6rPNujxZnTXfT2w/
	 pORZr93rF+73sDbBEkKZQ7Db9WXmEqiCEahX+PB0yTa00/y0T1N9sqxomNvyYvp9iD
	 UgPx3zRShdong==
Date: Sat, 13 Apr 2024 10:37:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: <linux-iio@vger.kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Mihail Chindris <mihail.chindris@analog.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Tomislav Denis
 <tomislav.denis@avl.com>, Marek Vasut <marex@denx.de>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Dmitry Baryshkov
 <dmitry.baryshkov@linaro.org>, Marijn Suijten
 <marijn.suijten@somainline.org>, Marius Cristea
 <marius.cristea@microchip.com>, Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v6 3/8] iio: adc: stm32: Fixing err code to not indicate
 success
Message-ID: <20240413103744.2bbff9c0@jic23-huawei>
In-Reply-To: <900004c4-0a30-4dff-85ba-ad6f61fe3818@foss.st.com>
References: <20240330185305.1319844-1-jic23@kernel.org>
	<20240330185305.1319844-4-jic23@kernel.org>
	<900004c4-0a30-4dff-85ba-ad6f61fe3818@foss.st.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Apr 2024 14:31:20 +0200
Fabrice Gasnier <fabrice.gasnier@foss.st.com> wrote:

> On 3/30/24 19:53, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > This path would result in returning 0 / success on an error path.
> > 
> > Cc: Olivier Moysan <olivier.moysan@foss.st.com>
> > Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> > Fixes: 95bc818404b2 ("iio: adc: stm32-adc: add support of generic channels binding")
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  drivers/iio/adc/stm32-adc.c | 1 +
> >  1 file changed, 1 insertion(+)
> >   
> 
> Hi Jonathan,
> 
> You can add my:
> Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Applied. I'll take this via the slow path and queue it for next merge window rather
than rushing it through as a fix.

Thanks

Jonathan


> 
> Best Regards,
> Thanks,
> Fabrice
> 
> > diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> > index b5d3c9cea5c4..283c20757106 100644
> > --- a/drivers/iio/adc/stm32-adc.c
> > +++ b/drivers/iio/adc/stm32-adc.c
> > @@ -2234,6 +2234,7 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
> >  			if (vin[0] != val || vin[1] >= adc_info->max_channels) {
> >  				dev_err(&indio_dev->dev, "Invalid channel in%d-in%d\n",
> >  					vin[0], vin[1]);
> > +				ret = -EINVAL;
> >  				goto err;
> >  			}
> >  		} else if (ret != -EINVAL) {  
> 


