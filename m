Return-Path: <linux-iio+bounces-11380-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B289B1CEF
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 10:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 770AF1C20A97
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 09:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB61126C13;
	Sun, 27 Oct 2024 09:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kk3j+WKJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C44AD51;
	Sun, 27 Oct 2024 09:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730022543; cv=none; b=dxjmPUdKTXCsCRaqKIOn+jgsKZpebdrR/xm88e0z4+EMmo4q+p8WHeBTicsR3DFpZ7Wjppv8saJrFFEXm1Z4VHzhjWLP1lfrEjmCYaoq7wv/R51hfVTBHiQzbPgZTO+pYgSQpEwwO4Qa/DyBpJdXE7Kae0J/P9lV3XHJfnF9GRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730022543; c=relaxed/simple;
	bh=4Xo+BTvX/fRZw18CXj0mt5E4lf+3WhIOdjelvs3sb/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ze/LxTJSDXynx91seYJv9TxJw1VNv/gFgdLnS9hwUDkuOYvgJMvA/s3eh87zZ4B63c0Uzej7Sob36MWtoGu99X2ABl3awwzhBpgT35e/jaom4BQnr+3TktfyTCYiKGGkwQoBO/VMBWDuxtGSB3axldYCBXf1pXK1aPqOVGh7Xvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kk3j+WKJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0D5C4CEC3;
	Sun, 27 Oct 2024 09:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730022542;
	bh=4Xo+BTvX/fRZw18CXj0mt5E4lf+3WhIOdjelvs3sb/Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kk3j+WKJfIiFsC5DsJcTQZ43HmXouHxpYiSce1UAEJUu8CygaAyEOHIYMhD9TuQC9
	 Vl2ZdyHId0bwGUvhWek6Ot40TTI++7VlwllT+sLb06YkiFMjDRl+Z9bk5RjHW+0Rpo
	 g7WjRHRcoK1oY7IHLFjOUqj2AwIumWY6W6o7+crrIhRvbtDFt7SakwTd6iluJaoXyH
	 xL3wUUJnGs+WFILy1jET/yki6yPc0/7v4o6VuL8I8v5jw6X5Z6zkqozoGVq4ZEiwH7
	 oN+D0zfvd7inDx798MrRBYwmxRK3TaoR5+0Rf2neenyeK3tJxDEydVXEiIHNNLVMYq
	 /VQbuTMo8T4ig==
Date: Sun, 27 Oct 2024 09:48:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andriy.shevchenko@linux.intel.com, anshulusr@gmail.com,
 gustavograzs@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Stable@vger.kernel.org
Subject: Re: [PATCH v2 01/13] iio: chemical: bme680: Fix missing header
Message-ID: <20241027094853.00ed19cf@jic23-huawei>
In-Reply-To: <2024102100-sulfide-paving-17fb@gregkh>
References: <20241021195316.58911-1-vassilisamir@gmail.com>
	<20241021195316.58911-2-vassilisamir@gmail.com>
	<2024102100-sulfide-paving-17fb@gregkh>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Oct 2024 22:13:17 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Mon, Oct 21, 2024 at 09:53:04PM +0200, Vasileios Amoiridis wrote:
> > Add the linux/regmap.h header since the struct regmap_config is used
> > in this file.
> > 
> > Cc: <Stable@vger.kernel.org>
> > Fixes: 1b3bd8592780 ("iio: chemical: Add support for Bosch BME680 sensor")
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> > ---
> >  drivers/iio/chemical/bme680.h | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/iio/chemical/bme680.h b/drivers/iio/chemical/bme680.h
> > index b2c547ac8d34..dc9ff477da34 100644
> > --- a/drivers/iio/chemical/bme680.h
> > +++ b/drivers/iio/chemical/bme680.h
> > @@ -2,6 +2,8 @@
> >  #ifndef BME680_H_
> >  #define BME680_H_
> >  
> > +#include <linux/regmap.h>
> > +
> >  #define BME680_REG_CHIP_ID			0xD0
> >  #define   BME680_CHIP_ID_VAL			0x61
> >  #define BME680_REG_SOFT_RESET			0xE0  
> 
> Why is this needed in a stable release?  Does it fix a bug?
> 

Indeed this is just tidying up.  I've applied but dropped the tag and changed
title to Add missing.... as no reason for this to get backported that I know
of.


