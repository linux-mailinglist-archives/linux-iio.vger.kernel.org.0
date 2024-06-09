Return-Path: <linux-iio+bounces-6117-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AC8901897
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 01:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D4531C20920
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 23:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF274D8BE;
	Sun,  9 Jun 2024 23:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+H5o3+o"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471DF481AA;
	Sun,  9 Jun 2024 23:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717974176; cv=none; b=gNTBVy85blS3JUGwT7YCrhWPSrGIvLP5ZMCUu1GdciQgQm77OCz/5AtZUvHNWDf0y0xErGuJPxF5eioFbPLDwR9ITyzM7fQDV2z/Q9qu9K2dqepP4NbKHNUKGaJkCZwNfuYn5FjAYAvhl2AQkOMgAbFN9TLfUraRd7Td2EheG0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717974176; c=relaxed/simple;
	bh=CYnhRQRDWbGclVC3i2Itdb6Mqo+o5mwhijUJyE+oSaE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUvT8F7OucBOdFHrz1CsE8Oo/mMIFgkugVP0oFsOVKUfqreBmN9sbKjeYbFCUPQKPQ0+EQUpeF8+6rY+PElLiPgYewQJ+3uvmvpGxJbWzwi79YWbZi4tx9fgEUV32HfCqkv+dmPzhKYqY2Iej2Bk2lDcBI6G6paBRXzb5DgPXDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+H5o3+o; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2eabd22d3f4so47013131fa.1;
        Sun, 09 Jun 2024 16:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717974173; x=1718578973; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZaG5LucQ3tNz46saV41+xEHLiLcU6Yyimk08gGwiVC8=;
        b=F+H5o3+o74YmEIVdMjl6U9gx7Q5qroWjVCEVP3CYN93uFE2QPpq6DxezU3m3hPE1UQ
         ofzduQ7YkLnDnYi7TXtwwiJI6a8dZgmuCVOOgMepjES4ilK3Mev8LDR5uBuPDnnHHi2Q
         HQfckXik86lvC4GP/4iuVGXFfdqJj2uaiYlJXtt4L20YU2IqOilp0kdAprvnoJQNINR9
         kyJrAACfK7kvmB0kemEMCSOxTHis+HTw1llEQvsT9CpEJHaMNsnngoWp+CZockpDsNdJ
         Ly/7RXeR+0jdbNX2cPh5iqWy9axD3ejqVfi/qqKwyBOt8D2HeOpblUV2PadjgtjAC9Dr
         XfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717974173; x=1718578973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZaG5LucQ3tNz46saV41+xEHLiLcU6Yyimk08gGwiVC8=;
        b=Fy/xgfMwwUiDPfZu8wYsnWvnECc8g3dvcajxg9RQok3/2hkPTFh/I5BIvbyHLvf/Rp
         fMJCm8KZAIMkBcY/623GOjdEVufgoQlWsb8BbQ2eBSNQ++v2Ys2pJ4RHF5YpsYwXj+sq
         QzRwk+Yu8g/zkt29f+zlYayYipkyT6Z+FmgfFyPPVwkPl1ltoC1IKS9fFBVueJdamv2U
         Al/oSAcju7B9qAduSpTPizqpXXYXVFkw9KnKyi3xDM35IAffv9OT7T7c8CI8/cMSLdQT
         Q55GfbqZZXmIURnE3OijXHH0+XQcFGcMsGxG5BteV2dtiV6kfttH4iS9TC6FFtNhhKl5
         mZ2w==
X-Forwarded-Encrypted: i=1; AJvYcCXAtieYlDskKChv3CUiuJHiGZxzaigvM7SG9GuN5G6wz/z4tKL7UPwJK5v03N0Oevgby4oQ46VYXmuJR9Hsg/9I+JP0k34kNAHKTBfwSxP69V9HvFnDGgpdMSJIQjfMIublAyirSwqr
X-Gm-Message-State: AOJu0Yx6W6IjRoOepSAzi0yDID2S6d2oRS2/T57M0pe5Z83QvouPi0Y0
	TIHGsTSX3L03bTAKEzaMR9uvw6s+2O4Syzb6B+Ay63YkLbiRjJO5
X-Google-Smtp-Source: AGHT+IFRi/l6nbPCxdigStc5X6Th7FQ9ITv+97HWWddXBIaf2GH4hAAzkqSeAV9ncuKEet/fBVMbtQ==
X-Received: by 2002:a2e:9185:0:b0:2d3:4b73:7b40 with SMTP id 38308e7fff4ca-2eadce25849mr42605731fa.17.1717974173070;
        Sun, 09 Jun 2024 16:02:53 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:635a:738f:880f:9ea5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57c7156e6c2sm2725702a12.9.2024.06.09.16.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 16:02:52 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Mon, 10 Jun 2024 01:02:50 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, dpfrey@gmail.com,
	himanshujha199640@gmail.com, lars@metafoo.de,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	mike.looijmans@topic.nl
Subject: Re: [PATCH v2 19/19] iio: chemical: bme680: Refactorize reading
 functions
Message-ID: <20240609230250.GA316369@vamoiridPC>
References: <20240606212313.207550-1-vassilisamir@gmail.com>
 <20240606212313.207550-22-vassilisamir@gmail.com>
 <20240609121234.7a458c4a@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240609121234.7a458c4a@jic23-huawei>

On Sun, Jun 09, 2024 at 12:12:34PM +0100, Jonathan Cameron wrote:
> On Thu,  6 Jun 2024 23:23:13 +0200
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > The reading of the pressure and humidity value, requires an update
> > of the t_fine variable which happens by reading the temperature
> > value.
> > 
> > So the bme680_read_{press/humid}() functions of the above sensors
> > are internally calling the equivalent bme680_read_temp() function
> > in order to update the t_fine value. By just looking at the code
> > this relation is a bit hidden and is not easy to understand why
> > those channels are not independent.
> > 
> > This commit tries to clear these thing a bit by splitting the
> > bme680_{read/compensate}_{temp/press/humid}() to the following:
> > 
> > i. bme680_read_{temp/press/humid}_adc(): read the raw value from
> > the sensor.
> > 
> > ii. bme680_calc_t_fine(): calculate the t_fine variable.
> > 
> > iii. bme680_get_t_fine(): get the t_fine variable.
> > 
> > iv. bme680_compensate_{temp/press/humid}(): compensate the adc
> > values and return the calculated value.
> > 
> > v. bme680_read_{temp/press/humid}(): combine calls of the
> > aforementioned functions to return the requested value.
> > 
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> 
> LGTM. All the other patches I didn't comment on are fine.
> 5 can wait for the non fix part of the series as it's just a typo.
> 7-14 look fine but probably have to wait for 1-4 and (v3 of) 6
> to get into the upstream of iio.git.
> 
> 16,18,19 all look good.
> 
> Note given you have two series that are dependent on fixes
> I might take v3 of patch 6 then send another fixes pull request
> before I rebase the main togreg branch on char-next (once it
> has those fixes). 
> 
> Getting complicated this cycle as a lot in flight!
> 
> Thanks,
> 
> Jonathan

Hi Jonathan,

Thank you very much again for the review, I will come back with the
requested fixes! I would appreciate a lot if you could push this fix
a bit forward, thanks!

Cheers,
Vasilis

