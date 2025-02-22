Return-Path: <linux-iio+bounces-15979-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7235FA40AAF
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 18:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 532D817C2C3
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 17:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F88A1FF7DA;
	Sat, 22 Feb 2025 17:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQjYRxRD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B55D207DE5;
	Sat, 22 Feb 2025 17:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740245339; cv=none; b=rST9izpPp+WthV6yGWpHpFp2IKyts4iXZov+D+TObFMBjfUzDkHit3gOap3mM54+cry3mc/8wIRGJGcJpqWE9UuPsuZKjzsfBYBVuWrBCZSL1uneuwlv1dAPx1bu32peP9gO2TC608r4MqOFaxzGWC2gS4K/HgdGEnDp8vxXbfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740245339; c=relaxed/simple;
	bh=M7A9ywHp1u2eQzCwFdKOX8fCM22vGJdznCYCRWFfZwk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jx82DAxCwsh5h6iWBmzmruR3cK3zFSbXnW9e8lU6NiWeq1USpibL5/vkozW2DFkcMoT45LO2a98QAcoMqchcaXIZjCbz/LWhPxsPDOtItgzKXxPHHXwcZka5RJ2x7kQsYhdqBYoRxpF5nsCFYTXy/zpbs6mw7QS6MZXo+cH9HL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQjYRxRD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BCBCC4CED1;
	Sat, 22 Feb 2025 17:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740245338;
	bh=M7A9ywHp1u2eQzCwFdKOX8fCM22vGJdznCYCRWFfZwk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bQjYRxRDwpTmDcrpmUtddxANNa/rZUF6pQVfnngDbcDxx1ofhrJdshlWUHE8QdRIY
	 hxMFowiHQokfw5mfnN53mn81SDa9Ylq39W72Ot3hsqer5e8gPYMZ3IXfKGx8cHpp1q
	 5f4DnmqOg+8SyHYpoDpPipCN0NBWtEq3hrGQRH9LFIDTTBZR3ipcf9D8eF6ai039cu
	 DATg7n1syRAn1sNje2ffSkl3/9mInW645nV5ji+UB+gJqkoW4rj2lRhcjnQZxUxaQO
	 aBBLgM/7ANT+noh677bvwg/WZJMKYMJNGxhriXZLPMS7Zq+2wsp9itIjFubqaUoClv
	 cBvH2v3qaDzVw==
Date: Sat, 22 Feb 2025 17:28:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Alex Lanzano <lanzano.alex@gmail.com>
Cc: Gustavo Silva <gustavograzs@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: imu: bmi270: move private struct declaration
 to source file
Message-ID: <20250222172851.5ff3fa79@jic23-huawei>
In-Reply-To: <mtmwjyo2jd5pmne4od6fsq3qkhh7smeafviu3bhjoafpv55dur@seepjddh4y7z>
References: <20250219-bmi270-irq-v1-0-145d02bbca3b@gmail.com>
	<20250219-bmi270-irq-v1-1-145d02bbca3b@gmail.com>
	<mtmwjyo2jd5pmne4od6fsq3qkhh7smeafviu3bhjoafpv55dur@seepjddh4y7z>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Feb 2025 11:25:21 -0500
Alex Lanzano <lanzano.alex@gmail.com> wrote:

> On Wed, Feb 19, 2025 at 08:54:45PM -0300, Gustavo Silva wrote:
> > The device's private data struct is currently declared in the header
> > file, but it does not need to be exposed there. Move it to the driver's
> > core source file to avoid unnecessary #include directives or forward
> > declarations in the header.
> > 
> > Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>  
> Acked-by: Alex Lanzano <lanzano.alex@gmail.com>
A good cleanup. So applied before I even look at 2 and 3!

Thanks,

Jonathan

> > ---
> >  drivers/iio/imu/bmi270/bmi270.h      | 17 +----------------
> >  drivers/iio/imu/bmi270/bmi270_core.c | 15 +++++++++++++++
> >  2 files changed, 16 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/iio/imu/bmi270/bmi270.h b/drivers/iio/imu/bmi270/bmi270.h
> > index fdfad5784cc52043475b6816286619fac5824684..d94525f6aee85f21cc9e9ae1bc9c1db0dc00b927 100644
> > --- a/drivers/iio/imu/bmi270/bmi270.h
> > +++ b/drivers/iio/imu/bmi270/bmi270.h
> > @@ -6,22 +6,6 @@
> >  #include <linux/regmap.h>
> >  #include <linux/iio/iio.h>
> >  
> > -struct device;
> > -struct bmi270_data {
> > -	struct device *dev;
> > -	struct regmap *regmap;
> > -	const struct bmi270_chip_info *chip_info;
> > -
> > -	/*
> > -	 * Where IIO_DMA_MINALIGN may be larger than 8 bytes, align to
> > -	 * that to ensure a DMA safe buffer.
> > -	 */
> > -	struct {
> > -		__le16 channels[6];
> > -		aligned_s64 timestamp;
> > -	} data __aligned(IIO_DMA_MINALIGN);
> > -};
> > -
> >  struct bmi270_chip_info {
> >  	const char *name;
> >  	int chip_id;
> > @@ -32,6 +16,7 @@ extern const struct regmap_config bmi270_regmap_config;
> >  extern const struct bmi270_chip_info bmi260_chip_info;
> >  extern const struct bmi270_chip_info bmi270_chip_info;
> >  
> > +struct device;
> >  int bmi270_core_probe(struct device *dev, struct regmap *regmap,
> >  		      const struct bmi270_chip_info *chip_info);
> >  
> > diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
> > index 464dcdd657c4ba27fdb7620c80e9f05e2a831910..9f24d4044ed6f00f67fd3a8f5adda821c3140a18 100644
> > --- a/drivers/iio/imu/bmi270/bmi270_core.c
> > +++ b/drivers/iio/imu/bmi270/bmi270_core.c
> > @@ -78,6 +78,21 @@
> >  #define BMI260_INIT_DATA_FILE "bmi260-init-data.fw"
> >  #define BMI270_INIT_DATA_FILE "bmi270-init-data.fw"
> >  
> > +struct bmi270_data {
> > +	struct device *dev;
> > +	struct regmap *regmap;
> > +	const struct bmi270_chip_info *chip_info;
> > +
> > +	/*
> > +	 * Where IIO_DMA_MINALIGN may be larger than 8 bytes, align to
> > +	 * that to ensure a DMA safe buffer.
> > +	 */
> > +	struct {
> > +		__le16 channels[6];
> > +		aligned_s64 timestamp;
> > +	} data __aligned(IIO_DMA_MINALIGN);
> > +};
> > +
> >  enum bmi270_scan {
> >  	BMI270_SCAN_ACCEL_X,
> >  	BMI270_SCAN_ACCEL_Y,
> > 
> > -- 
> > 2.48.1
> >   


