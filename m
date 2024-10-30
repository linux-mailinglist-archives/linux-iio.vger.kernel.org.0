Return-Path: <linux-iio+bounces-11604-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB519B6071
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 11:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E88BC1C215B5
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 10:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7212C6A3;
	Wed, 30 Oct 2024 10:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tbajf4iN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A477E1E3DF3
	for <linux-iio@vger.kernel.org>; Wed, 30 Oct 2024 10:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730285251; cv=none; b=Qo0NRzET2Bpz6IhgD1JE6aHX1X42DMZTYfGPGIQqP0TbEipRdINlQv7TPDjviaazhSBfmuSrajTzLxW+sWfmeRBD/eID+B4IzZujIKEyE7gL4CEWg8LP6HVIlo3E8grO8pl5MFW5/6LsZ12sALJWh4OEr/ui7bQ4Nt98sJ8KUeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730285251; c=relaxed/simple;
	bh=uusnrMKkwU4/Rd+T3S5PR9LlWSbDvbqgPrvPIlOGyGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okN7cgmtLGJdNCiPz4y0GP6UFdEm8zxW7Ax51QENrC/Uf2oGLqWgN0BZLUpGEmt7KbEGtme9wRHw5XgtJE7PxQY2U2whLd5z+85L+2mbDSmNSdi+SWNcFVoJrLE8gtK1quKIxFFWUvDwIp2ydD1kwAkeyYZ7Vp+JsCiXH9siXss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tbajf4iN; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539e7e73740so5488441e87.3
        for <linux-iio@vger.kernel.org>; Wed, 30 Oct 2024 03:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730285246; x=1730890046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RVQ4fy8h4cnmxa/mMX1f5z/7pQb5o/lGulLsihlTE/U=;
        b=tbajf4iNsDhw4SfZwB0cJCI1K96YrqvQIex+BsMDEWA3Jel7E/39B7e2J0ti5mnboW
         fBE2kK0rV5HKg8TE6KLoIoQ2kr+alED2QqJ3hwqby8ibLOaeEdSpQiorTdzhCWp8m2ld
         Om8P5UXWDK/oT2BFsCema//ODxv4jyxLRnYTmMkUfT8Ste1u0SaauSijehiRXKT+lFXE
         /FmY3088zB28Mmqq9uDtih8W9TDiOsS3k0xR144Kk7VBurigVALUVXn+MhqAzuYPuigw
         iju7k1a7frgzU8MxF34DyHFh0DlSfA5+fFtxL1YqwIFhlEW+vDmqbT8u7/5lV77jSLeL
         oECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730285246; x=1730890046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVQ4fy8h4cnmxa/mMX1f5z/7pQb5o/lGulLsihlTE/U=;
        b=NjhVTZg484zeNVoHzp0/meAAe/VQpT62XQWwTDvdBNHPSpU/kOU6B8NI9Dht39vvKh
         B0sBpHdBgqb1yC5INJWof2+9d2Alq8h/Jw785qympbb4wNaCsY7IgNMkNbNhSyIkhIow
         hlP5B0W3JHmvGE8UN8/729ijGLiqXd/C3IdJswa0BOZZHakUHUn0oRcHsOnpnZiyAtrB
         mTBxQLjOOHp+svai50PeUPZJzA+CsB4PSXFF3m3Bfj4gvt4IJfIcahJRBe75n3q6CXGW
         gQGZeZ8u85PkSkUGE5wUMcPwCxzUENpoJOq6J7ZrkUctSeEG8QM5LcGhXnZpQxKt/vuh
         JyZw==
X-Gm-Message-State: AOJu0YyGETllgm38vJdY33X6DCd02PELBIcKddC1sxQDIROyBMtAPXmC
	CGO4Kj72fZlUjcuswpGTsSrxaGvcQttVIrSw0s94xJJms5rZVK3XDOGpeUsurca7u313awUqLvr
	v
X-Google-Smtp-Source: AGHT+IGt3lKQkJEiejvEaJm5OL0FQ2PY5VnypqTLplb2VMJzNUkDcXM021VPOTBCcPot92rH2fUuQg==
X-Received: by 2002:a05:6512:1255:b0:539:93ef:9ed9 with SMTP id 2adb3069b0e04-53b7ecfc5ebmr1774863e87.36.1730285245644;
        Wed, 30 Oct 2024 03:47:25 -0700 (PDT)
Received: from localhost ([41.210.143.198])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b713f0sm15010944f8f.75.2024.10.30.03.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 03:47:25 -0700 (PDT)
Date: Wed, 30 Oct 2024 13:47:20 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [bug report] iio: chemical: bme680: generalize read_*() functions
Message-ID: <7c694cba-9444-415c-ac6e-458cdd600ae7@stanley.mountain>
References: <13f764f7-4cc4-4563-81f6-0393732729a6@stanley.mountain>
 <ZyIDKdX7NKopqT4W@vamoirid-laptop>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyIDKdX7NKopqT4W@vamoirid-laptop>

On Wed, Oct 30, 2024 at 10:58:01AM +0100, Vasileios Amoiridis wrote:
> On Wed, Oct 30, 2024 at 12:26:13PM +0300, Dan Carpenter wrote:
> > Hello Vasileios Amoiridis,
> > 
> > Commit 9b4071ab8cbe ("iio: chemical: bme680: generalize read_*()
> > functions") from Oct 21, 2024 (linux-next), leads to the following
> > Smatch static checker warning:
> > 
> > 	drivers/iio/chemical/bme680_core.c:760 bme680_read_raw()
> > 	warn: passing casted pointer '&chan_val' to 'bme680_read_temp()' 32 vs 16.
> > 
> > drivers/iio/chemical/bme680_core.c
> >     738 static int bme680_read_raw(struct iio_dev *indio_dev,
> >     739                            struct iio_chan_spec const *chan,
> >     740                            int *val, int *val2, long mask)
> >     741 {
> >     742         struct bme680_data *data = iio_priv(indio_dev);
> >     743         int chan_val, ret;
> >     744 
> >     745         guard(mutex)(&data->lock);
> >     746 
> >     747         /* set forced mode to trigger measurement */
> >     748         ret = bme680_set_mode(data, true);
> >     749         if (ret < 0)
> >     750                 return ret;
> >     751 
> >     752         ret = bme680_wait_for_eoc(data);
> >     753         if (ret)
> >     754                 return ret;
> >     755 
> >     756         switch (mask) {
> >     757         case IIO_CHAN_INFO_PROCESSED:
> >     758                 switch (chan->type) {
> >     759                 case IIO_TEMP:
> > --> 760                         ret = bme680_read_temp(data, (s16 *)&chan_val);
> > 
> > The bme680_read_temp() function takes an s16 pointer but we're passing a s32.
> > This will not work on big endian systems and even on little endian systems, we
> > haven't initialized the last 16 bits of chan_val so it's an uninitialized
> > variable bug.
> > 
> 
> Hi Dan,
> 
> Thanks for letting me know! What I could do is instead of reusing the
> int chan_val, I could use a local s16 temp_chan_val so there is no need
> for typecasting here.

That works.  Not a fan of the name though.  "temp" means "temperature" and "tmp"
means "temporary".  chan_val16 perhaps?

regards,
dan carpenter


