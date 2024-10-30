Return-Path: <linux-iio+bounces-11638-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF4E9B6962
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 17:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07DED1F2235C
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 16:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366A42144DA;
	Wed, 30 Oct 2024 16:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SBJXQAtK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82021E8850
	for <linux-iio@vger.kernel.org>; Wed, 30 Oct 2024 16:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730306410; cv=none; b=HbkGYC2AL4IWvziHS2iH5mxIBVnEym4zw10aBTIR6OQ5/BunOh9HxssKdaaCf56w/tqTIRXZa2dFdVyyIhEWSnS30sSMagWFFSWp/o0lTzi9fUVEkG+IVoufwPkWfLAnuigXvbWukahT27I76XTevncpjarxdklfbUJ5Ekel044=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730306410; c=relaxed/simple;
	bh=nrhCmKGD+AaTUsfqhymnAx1dJjdb8ikav25+eW+Luko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAxjiPvdd2LywIRxXqpdSXGL8pbXBIEAiC778aTciGX31y5NbpAg6dVgYm3ruVi7xIVopr6yAzieNrIN3E+tfHEqTlkgAHx+GYcg8taEXsn2yRaKAnfFz93cMB+SQYZFxyjOQFO7lrNNt+0mIxKgmA6PNbt/rJku5t7247DTsVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SBJXQAtK; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4314fa33a35so195385e9.1
        for <linux-iio@vger.kernel.org>; Wed, 30 Oct 2024 09:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730306406; x=1730911206; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7zmFyjji57mcSsfmXafAgfgTEwFnEojG8+pAJJc16wE=;
        b=SBJXQAtKDEd510MWb+uW0nxnJMXn7QSpw6iQ58mCf8VnG6+c0O05OACsVo4sFXRdS3
         ClbDVvQ/nEI4DM8+Ck1CNSJfldWsj4NwbJKyhcwnaOxMFPvFiJ/Em4hhATphY991a3ii
         nJeCjrAAWMEbYWrC2Hs6/oXI75Uk8YGF2NEiYeHGi7wWNRS8re7IpNBH5k5Kpfr8G2td
         nsz/+0/4wxTScLTJWzu8PDk5gcTG71iEFrKfM0G5geHpRt+676lIreQKzkv7C+cKUvEQ
         JeKBCmaICK4rTwyx7Hw5aArUec6paBIG0KGp3eRzTwI5u5LSdcLhxrHXn8E/USNdWN1E
         UH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730306406; x=1730911206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zmFyjji57mcSsfmXafAgfgTEwFnEojG8+pAJJc16wE=;
        b=u+0xz11NmufwCDqRh6ym10zzqr/GCyCs2CbUFlOzByim+A1fLnYEu6fyRIjTK/Ztfv
         kyWppWhv1LGcKm6zGtHuqCHs//wXpXqX9o5Aas3ltfVN/kL3WHI4bZvR3IAg41q35+Gk
         Ls006P1VnMIyfzrRZvuXeHcSHtB0Pj5+9gaNs5xBArp5mQi9i2Ld7ul+gPBNkjMM3ruy
         YWCHurZkj9KqKzFjWwgS16HPjE3eoscUACFWrqvzZj/MQrXuZ1CuLmeJ9rmNVpkflmgC
         E+DwkopiyuVZTvTt2PVBY1tEy6McVpDHrAkwjNhULJcVjOBXNtMu4jRfhOcG2HaPd9cl
         72ww==
X-Gm-Message-State: AOJu0YxSUkxLTWgBqrht0Tes8VLjDgKLPUoVV2LE0FxAm/ak4nivaq79
	nV6QfSbNY4HYmOtDjye5oEX09R/xBvzC10VkK5T0lwk1Val4buyXyb5kZz7l8ig=
X-Google-Smtp-Source: AGHT+IFqwZhZ8T7eBCVYnGYoorWDx2fZSrVWC+jo09cqIsBo4zMsrYPFnIQNA6+MM1zpnJGQQHBSOQ==
X-Received: by 2002:a05:600c:4753:b0:431:5632:4497 with SMTP id 5b1f17b1804b1-431bb9d1122mr40505145e9.26.1730306406201;
        Wed, 30 Oct 2024 09:40:06 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b47a41sm15780315f8f.52.2024.10.30.09.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 09:40:05 -0700 (PDT)
Date: Wed, 30 Oct 2024 19:40:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [bug report] iio: chemical: bme680: generalize read_*() functions
Message-ID: <5f57df67-8e5d-49ac-ba1c-c9a39b70a1a2@stanley.mountain>
References: <13f764f7-4cc4-4563-81f6-0393732729a6@stanley.mountain>
 <ZyIDKdX7NKopqT4W@vamoirid-laptop>
 <7c694cba-9444-415c-ac6e-458cdd600ae7@stanley.mountain>
 <ZyJgj_E3qXw-Vj2C@vamoirid-laptop>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyJgj_E3qXw-Vj2C@vamoirid-laptop>

On Wed, Oct 30, 2024 at 05:36:31PM +0100, Vasileios Amoiridis wrote:
> On Wed, Oct 30, 2024 at 01:47:20PM +0300, Dan Carpenter wrote:
> > On Wed, Oct 30, 2024 at 10:58:01AM +0100, Vasileios Amoiridis wrote:
> > > On Wed, Oct 30, 2024 at 12:26:13PM +0300, Dan Carpenter wrote:
> > > > Hello Vasileios Amoiridis,
> > > > 
> > > > Commit 9b4071ab8cbe ("iio: chemical: bme680: generalize read_*()
> > > > functions") from Oct 21, 2024 (linux-next), leads to the following
> > > > Smatch static checker warning:
> > > > 
> > > > 	drivers/iio/chemical/bme680_core.c:760 bme680_read_raw()
> > > > 	warn: passing casted pointer '&chan_val' to 'bme680_read_temp()' 32 vs 16.
> > > > 
> > > > drivers/iio/chemical/bme680_core.c
> > > >     738 static int bme680_read_raw(struct iio_dev *indio_dev,
> > > >     739                            struct iio_chan_spec const *chan,
> > > >     740                            int *val, int *val2, long mask)
> > > >     741 {
> > > >     742         struct bme680_data *data = iio_priv(indio_dev);
> > > >     743         int chan_val, ret;
> > > >     744 
> > > >     745         guard(mutex)(&data->lock);
> > > >     746 
> > > >     747         /* set forced mode to trigger measurement */
> > > >     748         ret = bme680_set_mode(data, true);
> > > >     749         if (ret < 0)
> > > >     750                 return ret;
> > > >     751 
> > > >     752         ret = bme680_wait_for_eoc(data);
> > > >     753         if (ret)
> > > >     754                 return ret;
> > > >     755 
> > > >     756         switch (mask) {
> > > >     757         case IIO_CHAN_INFO_PROCESSED:
> > > >     758                 switch (chan->type) {
> > > >     759                 case IIO_TEMP:
> > > > --> 760                         ret = bme680_read_temp(data, (s16 *)&chan_val);
> > > > 
> > > > The bme680_read_temp() function takes an s16 pointer but we're passing a s32.
> > > > This will not work on big endian systems and even on little endian systems, we
> > > > haven't initialized the last 16 bits of chan_val so it's an uninitialized
> > > > variable bug.
> > > > 
> > > 
> > > Hi Dan,
> > > 
> > > Thanks for letting me know! What I could do is instead of reusing the
> > > int chan_val, I could use a local s16 temp_chan_val so there is no need
> > > for typecasting here.
> > 
> > That works.  Not a fan of the name though.  "temp" means "temperature" and "tmp"
> > means "temporary".  chan_val16 perhaps?
> > 
> > regards,
> > dan carpenter
> >
> 
> That's the reason I used temp in the name, because we are reading a
> temperature channel in this line.

Ha.  Okay.  Good then.

regards,
dan carpenter


