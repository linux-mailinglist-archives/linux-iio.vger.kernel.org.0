Return-Path: <linux-iio+bounces-17345-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1122A75A95
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 17:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDF6A1887027
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 15:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F681D6188;
	Sun, 30 Mar 2025 15:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWHotYpZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089603C3C;
	Sun, 30 Mar 2025 15:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743348059; cv=none; b=QgjCpvLCcA3roTwYoFsKzFwTPlC14bJxwU3pFom+vNbvfI6AZW/qp2aZgcSq/Trdnb/uthV0nmaR9/1bGv/LplxiT7TreVh1AV1O1YgeZowLlKixXSwrp9LE6YWnuRuM7HqMcL/1bwh0hLaC+1NQ3VxFB0OXP5v6CzBJswa5LQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743348059; c=relaxed/simple;
	bh=oQBHCv7DobR7jB6Gje3HM4w198/A3db3aYK2BFd9MtI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aimzq4sRuCih+4RwxsY1PQvCso7Y/2I+UkACGiZhAKdKIj5M89/eeyjWfKmNofYFpHWyjdZIx+RwEvWfW9R9P1d8ZOpFMLkXI5pWOnoKRFynDnizYsgrteFk3qp/jiF2+RrpAg73lUoREUSn7uXMSmHGwADEHlNRZDgv9MWRMJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWHotYpZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A903AC4CEDD;
	Sun, 30 Mar 2025 15:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743348058;
	bh=oQBHCv7DobR7jB6Gje3HM4w198/A3db3aYK2BFd9MtI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oWHotYpZFtgKuYolSJIz8K9VroC+raF4bGZFZXztn40XLO7tc/0iA46ynFKRIijBU
	 KH2BjqzoSDC3Anea4iGQpyYc7S/RobmAQUO5TsSN5P7NoZ/67OOvWINFVdWJYGRt/s
	 vpGCWj0sNP+mqfwDHzgu5CsFWZrf3YoTtt8CAc7wtyd22IUk7Nzq4ujg5dGD/I5unO
	 gqroXgQ3VlHQYpjDemF6/xerhhZWROHkl93XMHz7sr4jS6CRUXTEk1PfiuGdlp4gDp
	 G1DGtxWiVsK7G/IxuDU+hZIT3CS2x6s58UODXSVPqoEp5WGB72S1PqKJ2665gvjUsB
	 yo4+UHbJpA82g==
Date: Sun, 30 Mar 2025 16:20:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sam Winchenbach <sam.winchenbach@framepointer.org>
Cc: linux-kernel@vger.kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com, antoniu.miclaus@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, bpellegrino@arka.org, Sam Winchenbach
 <swinchenbach@arka.org>
Subject: Re: [PATCH v8 5/6] iio: core: Add support for writing 64 bit attrs
Message-ID: <20250330162049.737de22a@jic23-huawei>
In-Reply-To: <20250330161721.7d718fd0@jic23-huawei>
References: <20250328174831.227202-1-sam.winchenbach@framepointer.org>
	<20250328174831.227202-6-sam.winchenbach@framepointer.org>
	<20250330161721.7d718fd0@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 30 Mar 2025 16:17:21 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 28 Mar 2025 13:48:30 -0400
> Sam Winchenbach <sam.winchenbach@framepointer.org> wrote:
> 
> > From: Sam Winchenbach <swinchenbach@arka.org>
> > 
> > Prior to this patch it was only possible to read 64 bit integers.
> > 
> > Signed-off-by: Sam Winchenbach <swinchenbach@arka.org>
> > ---
> >  drivers/iio/industrialio-core.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > index a2117ad1337d5..b2436b8f3eeae 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -965,8 +965,10 @@ static ssize_t iio_write_channel_info(struct device *dev,
> >  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> >  	int ret, fract_mult = 100000;
> >  	int integer, fract = 0;
> > +	long long integer64;
> >  	bool is_char = false;
> >  	bool scale_db = false;
> > +	bool is_64bit = false;
> >  
> >  	/* Assumes decimal - precision based on number of digits */
> >  	if (!indio_dev->info->write_raw)
> > @@ -990,6 +992,9 @@ static ssize_t iio_write_channel_info(struct device *dev,
> >  		case IIO_VAL_CHAR:
> >  			is_char = true;
> >  			break;
> > +		case IIO_VAL_INT_64:
> > +			is_64bit = true;
> > +			break;
> >  		default:
> >  			return -EINVAL;
> >  		}
> > @@ -1000,6 +1005,13 @@ static ssize_t iio_write_channel_info(struct device *dev,
> >  		if (sscanf(buf, "%c", &ch) != 1)
> >  			return -EINVAL;
> >  		integer = ch;
> > +	} else if (is_64bit) {
> > +		ret = kstrtoll(buf, 0, &integer64);
> > +		if (ret)
> > +			return ret;
> > +
> > +		fract = (int)(integer64 >> 32);
> > +		integer = (int)(integer64 & 0xFFFFFFFF);  
> I forgot on previous reviews but for this case we have wordpart.h
> 
> 		fract = lower_32_bits(integer64);
> 		integer = upper_32_bits(integer64);
oops. Other way around obviously!

> 
> I'll tweak that whilst applying.
> 
> >  	} else {
> >  		ret = __iio_str_to_fixpoint(buf, fract_mult, &integer, &fract,
> >  					    scale_db);  
> 
> 


