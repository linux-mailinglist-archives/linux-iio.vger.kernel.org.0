Return-Path: <linux-iio+bounces-17279-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EF1A72BEE
	for <lists+linux-iio@lfdr.de>; Thu, 27 Mar 2025 09:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2B00189A6D5
	for <lists+linux-iio@lfdr.de>; Thu, 27 Mar 2025 08:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F1F20B7ED;
	Thu, 27 Mar 2025 08:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LXWs4mA0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D373220B1F5
	for <linux-iio@vger.kernel.org>; Thu, 27 Mar 2025 08:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743065862; cv=none; b=qukLkqmuJGbuVqo3hPWicSd4jGZZzY9OcgzOz/Xe8WOpfzBx2XQ8tSBykKa5OYFmFUFnEsvwdPYOOZh0s+tLEv9AmxGuJFDcfGqWm2IbeUF/WpU83/ONsbGc6PC0us5twxTfQQw94PQncAeofdxlKzy9FlxHXZ3vrm+j/SgAo2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743065862; c=relaxed/simple;
	bh=zA3DMC1VmWmNMDN8cvaRBASwF4IuKwVTadBoBZ7jbhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4SzgDtBUyGgKBOdRGVi7rfiSE3TkamwRCppDM0s0w9RbR1rYL8i/gwH1VT/yqPjmhRe9EDDxbkXt3ZK18uD8i3CavvgeSGeerYak/JWk7MKaj/lFllJ7mqW0DZMtI1b65m2S3ER9fQ7PIU0Oxki5mXIuYd6DevLVadMIZvROW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LXWs4mA0; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39ac8e7688aso495990f8f.2
        for <linux-iio@vger.kernel.org>; Thu, 27 Mar 2025 01:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743065859; x=1743670659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ILDVNVv1RvawRizYUQVDbq/vojCQOenZ2+2HfMuJMPA=;
        b=LXWs4mA0uf+uDk4bcBJAuIDVZK93dzIF36ZSSclJol+62HdH2bDQ2uM5N48zBSoDD0
         BXhU7/aqYgtc3XWyWQcwoO9X2nkxXNfnxleeWmPaidYraeGHPUUAvgG7IBCElLSluP/l
         TSgnIjfmM8/D0OY2KLboLc/51XGXtLjAS3s+m+C0tW6UZGsQ8pZRJcCxHiu44RfD4un5
         aXmeq6eBNFU0Bk+PkRRyqmxV0mIvpBugD2nXrwApqbW71MYo9dg6RxZJVZP5oitnPRKs
         M24NVse44XDvw3UYqpwRgfmxrJV0bJtgr/WZV6YIdfgsHOquzi5p1HdhdXN+t3Rk6Dg6
         AXaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743065859; x=1743670659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILDVNVv1RvawRizYUQVDbq/vojCQOenZ2+2HfMuJMPA=;
        b=Scs9RoCs/uxEOxjloGoRvGTEfjnZ3dkUeuN8J1xFHae8Iwb5bOuNPIO6AqwVQyDTLg
         UQCcIOnQ+W+X6M14O4/E5PZ2eXFKgCvFQAeO2TGO1rEmpIPhOwuHhPMQNRE+770pMj4V
         ijRlIsDcSI8P+j6yIHvX5hu4MaaMv2CCigNk7Cp3kq/2cVJ22oEloaxKonRsiyiuShpy
         HxBbaD1em+Yg6b7lNs1d2KR00WMVYw2pzbZmBvYIU/6BHVvNBykb4o+tYCgIAqdTNLLx
         woOoQZGfweZM2M0dxzfRQROHxX0bnUxvYJ0UJ7vYUjN344U3JzHu5joPw2LMGLHK5J55
         WM9A==
X-Forwarded-Encrypted: i=1; AJvYcCUGJPLPsd4xqyoeG2xr/kPyBmJ8PRKbAXnvWZI539scX8vB0eFRDu1U1KJduFzE/Op1a5aqrdoUcJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOrttPY5JrPgX9QcH8+yztSGO6H289g1i3pI9tHroFZVxJ9Q3X
	aTKTRhHkeQ0CjPhiNo1rcM+MDg3t234zv0IW4nK07N5T/Q6Pv4oH3eQgYz3pFaE=
X-Gm-Gg: ASbGnctk0O68vEIyE8t9vaWAK+xE/Cz1DGPlFuO9oopb573Wa2nOLfUssnWQBvC1KYf
	wq+NO2k9UP7dUC3dzISGCB3m64yAalNm5X48+wVzPF3i88nYPRPCRExWxSb6qJADP7ShXpgk/rR
	5FJ39vP6wl6+zSV8ahKuBqZ5ZqSmXT/mCKl+t5gSfkku/U4hXIMHlm+WuxbWW0r5P6OPkpw6xhu
	IXy2vVlkCdGfpf8vTJ7TKnjzCyDFZvG0tQrgFTiHCIUiLNLjhtm1nUWQ8RihLKdl7pWIdo9VVuz
	5xcp9YYsTL1yhDp/GhhnWGkE974hOZ2o2xjqORYFpLJEuWKZNCTUex9jOlm8yDaK+uoTVCoEsDf
	UHhX7RMlKnJE7iNSr+tA=
X-Google-Smtp-Source: AGHT+IF831tQlelv85SsABv3DgsXTx7KGpQ21LJbgFu8q9NZS/DONYGdNcdiUm3qsfAnp3/ISEkoUA==
X-Received: by 2002:a05:6000:188c:b0:399:737f:4df4 with SMTP id ffacd0b85a97d-39ad17583c0mr1910197f8f.28.1743065859078;
        Thu, 27 Mar 2025 01:57:39 -0700 (PDT)
Received: from archlinux (host-87-14-238-193.retail.telecomitalia.it. [87.14.238.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9efca6sm19475766f8f.93.2025.03.27.01.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 01:57:38 -0700 (PDT)
Date: Thu, 27 Mar 2025 09:56:26 +0100
From: Angelo Dureghello <adureghello@baylibre.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Jonathan Corbet <corbet@lwn.net>, Olivier Moysan <olivier.moysan@foss.st.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: dac: ad3552r-hs: add support for internal ramp
Message-ID: <yxhvtline3ey3ekybqfe3k4y4sm6746wpqwpydxv2brryironl@u2ezr3sryqxs>
References: <20250321-wip-bl-ad3552r-fixes-v1-0-3c1aa249d163@baylibre.com>
 <20250321-wip-bl-ad3552r-fixes-v1-4-3c1aa249d163@baylibre.com>
 <Z-R3E23hWiUKDc6q@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-R3E23hWiUKDc6q@debian-BULLSEYE-live-builder-AMD64>

On 26.03.2025 18:52, Marcelo Schmitt wrote:
> Hello Angelo,
> 
> Patch looks good to me.
> One minor comment bellow.
> 
> On 03/21, Angelo Dureghello wrote:
> > From: Angelo Dureghello <adureghello@baylibre.com>
> > 
> > The ad3552r can be feeded from the HDL controller by an internally
> > generated 16bit ramp, useful for debug pourposes. Add debugfs a file
> > to enable or disable it.
> > 
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > ---
> >  drivers/iio/dac/ad3552r-hs.c | 106 ++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 100 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
> > index 37397e188f225a8099745ec03f7c604da76960b1..41fe78d982a68980db059b095fc27b37ea1a461b 100644
> > --- a/drivers/iio/dac/ad3552r-hs.c
> > +++ b/drivers/iio/dac/ad3552r-hs.c
> > @@ -7,6 +7,7 @@
> ...
> > +
> > +static ssize_t ad3552r_hs_write_data_source(struct file *f,
> > +					    const char __user *userbuf,
> > +					    size_t count, loff_t *ppos)
> > +{
> > +	struct ad3552r_hs_state *st = file_inode(f)->i_private;
> > +	char buf[64];
> > +	int ret;
> > +
> > +	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf,
> > +				     count);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	buf[count] = 0;
> Shouldn't it be
> 	buf[count] = '\0';

Why ? I am zero-terminating the string properly.

> ?

Regards,
angelo

