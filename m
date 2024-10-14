Return-Path: <linux-iio+bounces-10586-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8398A99D804
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 22:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEB89B22464
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 20:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835861CFED2;
	Mon, 14 Oct 2024 20:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDsW238a"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF1C1D0492;
	Mon, 14 Oct 2024 20:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728936869; cv=none; b=jtETQuhXE6TugSjJMEow/T6LDBszlQTph3+KOXn+UOaQQ0ixSPXjHiZJaaFbEyTBhZLodbA0xz1xSsEjU3w6K+p7VMepuN8lAg760xAsvUvVW2KNcRJ5fvlhVZWBPTTlX82tOCnpvzm+vzWbGmY05P+AsoV69xxkVLQ/RyZGMjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728936869; c=relaxed/simple;
	bh=nGwpSRDiREpgO3GfqtyYak2rOwDtzQPR/ga2NpQROhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VljHpVitA1X160nxgD4VpvDsDLKKSFH2XfS1ZEyRTh9AZwoO17Sz4A6p70ZzMbMye6j1jPD8lQnpet82nzgavG7kBNSvLf3FFUCErhvca5soEJVLaf3ndsOgENX4lCSFHnAixpi71w3Gx9J0Rd9YsYk2V8OGJwjZRupENXwXiu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDsW238a; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-431160cdbd0so29552925e9.1;
        Mon, 14 Oct 2024 13:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728936866; x=1729541666; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BuTgoSmAu7R32A26a6EEGJkODHQDPwpdQJUMBsyfaMc=;
        b=QDsW238a0Xv6k48YfnihD3Y7fLyRRmganTcmNAEQK69nEag6bKA8ncr1HuW7PmH7KI
         IpK1Lb/azV/tu8W8Z1+qL3CWYVEEsF7gqyStV5c6ANEiEpdKwThdvXpl9JfjxuViGkVp
         nnf0/Gof1DqQ/fURCvJLKWnJCS1568lNutaPu5/IctXCpy1dCzV6A77fIdxuRRqq/g/M
         weNWAg43iPfRkbV3uhoqWuvfN44M8w9di3OKAYlaEf7EQjUnhW/5rl4dWSVfCrdsqBEl
         lEdERzFqJycpCTaCzICiLYWYDyqVXquA93+1XiePfyr6BM1wSsEvDd2jSmZuXbP8AUAT
         IsfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728936866; x=1729541666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BuTgoSmAu7R32A26a6EEGJkODHQDPwpdQJUMBsyfaMc=;
        b=BE6sA9uhIFlFoLik26OyEqUvh2bcP+DLbhmzzaDmHf+kIgqSDLGwLDFg4upEFVkWJX
         aP6Cf0n3KxgZ2najUYE1a7hi2wne2LHdotKKLLIFylGDor2eCQdotEi5erqQaAZxYksb
         9nyRjaGQSDGaPNSw1/lD8RErf4fJh6BhROSeN2QKhnH10GB0O5PT87wACIMQWI6AvpbL
         ymDHcfJOaUvDA3WgyY2Ng66kEV3NWkfJKwA7ZEhHGi2xVFgMMkOUgsc5/hKvuFggNwd1
         MIjmcEDXq3AdEmy72omFhNVk+DF/8pcdKuZZRCmOzwmNxK8hrRI9j3gCZm3zfMc9i53m
         iYqA==
X-Forwarded-Encrypted: i=1; AJvYcCWVY8reQqyH5+ZlTckyeLZrWKO4Yd68UbrFy2fXFyMakc6cq+0xC7amaGKEH8TeYBO3CSaGfJKh76i/@vger.kernel.org, AJvYcCWkH6Ta0f5H/OdbHeJQp4uOShTdML4NdP/X8OIyc94Uh+B0FCfQ+rK2np70+ImjgEiwuDoJ2FyQtYyMZALU@vger.kernel.org, AJvYcCXus9SZwOaG5+3x4SyPMZGMM6fuHAm5RbMK0dys/wzd5xxNXJB+Zp7MzyuVFGXXfHEttFDKppIdMTXf@vger.kernel.org
X-Gm-Message-State: AOJu0YzqlXfc/OSxy1LlvsQMsxhBKacAyguP3D6Tw990pXjT5NSrKKdl
	hhGPPfviK5ULfkZBq9SmNUNFut6AruQy+fcXUrmGdYEZkmvMFWBjxg3yHiqM
X-Google-Smtp-Source: AGHT+IEVVoJsZ0UeZgR/yhPNu16KKqW10F1kgvMH6JC1UCKxFBvNmFIkzhhqC+AwAL5HIQhWp0ph/g==
X-Received: by 2002:a5d:4c92:0:b0:374:c6b6:c656 with SMTP id ffacd0b85a97d-37d5529cb41mr10209582f8f.21.1728936865698;
        Mon, 14 Oct 2024 13:14:25 -0700 (PDT)
Received: from vamoirid-laptop ([2a04:ee41:82:7577:e435:fb96:76da:7162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b918073sm12245045f8f.113.2024.10.14.13.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 13:14:25 -0700 (PDT)
Date: Mon, 14 Oct 2024 22:14:23 +0200
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, anshulusr@gmail.com, gustavograzs@gmail.com,
	andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 09/13] iio: chemical: bme680: Move ambient temperature
 to attributes
Message-ID: <Zw17n7DB2LdgDct3@vamoirid-laptop>
References: <20241010210030.33309-1-vassilisamir@gmail.com>
 <20241010210030.33309-10-vassilisamir@gmail.com>
 <20241012130124.44c69521@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241012130124.44c69521@jic23-huawei>

On Sat, Oct 12, 2024 at 01:01:24PM +0100, Jonathan Cameron wrote:
> On Thu, 10 Oct 2024 23:00:26 +0200
> vamoirid <vassilisamir@gmail.com> wrote:
> 
> > From: Vasileios Amoiridis <vassilisamir@gmail.com>
> > 
> > Remove the ambient temperature from being a macro and implement it as
> > an attribute. This way, it is possible to dynamically configure the
> > ambient temperature of the environment to improve the accuracy of the
> > measurements.
> > 
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> New ABI? Would need docs.
> 
> However, I 'think' we have a few cases where we handle this via the slightly
> odd interface of out_temp_processed / _raw with a label saying it's
> ambient temperature.
> 
> The tenuous argument is that we have heaters that actually control the
> temperature and the affect of either heating the thing or just happening
> to know the external temperature ends up being the same. Hence use
> an output channel for this control.
> 
> Jonathan

Hi Jonathan,

Thanks for taking the time to review this. I saw your previous messages,
and I am not responding to all of them so as to not flood you with ACK
messages.

For this one though I have to ask. The last commit of this series is
adding support for an output current channel that controls the current
that is being inserted into an internal plate that is heated up in order
to have more precise acquisition of humidity and gas measurement. Does
it makes sense to add an ambient temp output channel as well?

Cheers,
Vasilis

