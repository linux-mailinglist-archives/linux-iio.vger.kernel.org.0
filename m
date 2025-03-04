Return-Path: <linux-iio+bounces-16313-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35963A4D3F2
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 07:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 979313AD9EB
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 06:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBCC1F4607;
	Tue,  4 Mar 2025 06:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Et2Uc7rM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5A9347C7
	for <linux-iio@vger.kernel.org>; Tue,  4 Mar 2025 06:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741070226; cv=none; b=onQFoJDL1/+PJyjWokE6ty2sbY7z5W7znkOfJNeCsl9liSl0MOEKorVo8NI/psiYg9c+WhgawAdaYtxqzzbJyBxSJybGAy5EG3hBbiPCDq5kuEHbmwH5FkDAYAEHrz/p2jO8Uc/23MGp98M3/DZx1DcOvOzid0mkZ+I4zGuqm9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741070226; c=relaxed/simple;
	bh=UMt2ZIzD4i/3+qQhSPSHEop7znwVILAj++vRqySJMaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHx2+BVbejyljECZp+w9yNgY87vGuWMffSs/ZJBHzXzAexGrGqLH8JEm3iep62mOPBvlXfJtWYolkWzTDGsAls1m4P98nfdch1dK2xf7dyjiiymrclN9tctSC6NmV7VUaudIg2gREo3sj6UZl7UYwQ9gjLWhH2Z8HxUsLyaSTao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Et2Uc7rM; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-abf64aa2a80so434977766b.0
        for <linux-iio@vger.kernel.org>; Mon, 03 Mar 2025 22:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741070221; x=1741675021; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MZODVp5qI7foXW09kyVwXfjrHAWYKs/CU5C/Z/8rz1U=;
        b=Et2Uc7rMNEMbeY3MTcVu7BHRt/ovc+d5j50nEgL0yK1mqGSxV4AuffIizoheIGDMTc
         iervZE0McyNANe/DwtbasuoVYIph7dOr4Q4Yol2AQy8b2wDcsN6i8op4n/kQmNRiT6sJ
         qNPta9N5X1I+RriSdEZHfWUjNsLQksZGG4ZCBPXxjXw1k8SCirrVdL/ZvZ8pMirLysr6
         2Bv1N36dJ+d/R4QpUMhuDrgWtAlOVp5O9CNheieT9oxcaulvslH5pCbeHxXvG8LX7Qq/
         9qpe61ip7Rg0Vg+G9ib0iis3K9VdYyXq8Zkvkq1dYqXjBZFb/lwnqXZU9PNGNzzv1wRn
         8Exg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741070221; x=1741675021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZODVp5qI7foXW09kyVwXfjrHAWYKs/CU5C/Z/8rz1U=;
        b=KDPyfEUovli42KRci9trlbwlD0zEsuiqzy5iVJw3+TmC29VYKxIdlItmsW4OQ40La9
         MsDsL7lttU6zmtJzKXLU4xTVn9JDKXb6IPS3S84eUoaoRw3sEN5oey1Cp2QyVb9rd9V9
         ldVwmt0NSu1ptinpFZApowdtS1NuVcelSlqurz5JRAV45r99/oCN7m6FjbVYD5Ua4mVB
         tQbbNh0LiZ23/L+AI2c4GtgQYDPZefVAizxWo1cxt0Jc/ZjnGcN8AadlRNmbv8G1KuOS
         jRKGex1A6gV8qjRY+iLQZXO6f0/fF1VOQN7Z5T78hy28+40dPdPqMByJD854IAvIv6jk
         s/1A==
X-Forwarded-Encrypted: i=1; AJvYcCVoLZZIb8ylVAdOcXEloD5gehFdiIv9j11sOKXO8+QBkGByd3Gl134r4lDPmSvgozKzEQoZDPcgJjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1v9Ny4+hoPX8B+3w8F4zIiHO5ubZKjLTAW42ICRfF+OgrHCmI
	4kHgBaaXN8XuXsOeO35x+BZfP13PJFiksVfl2Oy4QeKfInk+MLZ0Rhc16mUN13A=
X-Gm-Gg: ASbGncvN1ET25LCT86Iok1IBEvt5a7kiOnbHYEfdrR4Uhu2g45fvD5aW0z8dClpKKp9
	GW5uwB+iWys0tdsIAwD3GiIxdHjvOZRj9RaHxMPLLYRko7NoB/jc0shtX+VdDLv2m5uLYHQ9xaI
	63pzC8kG49fQuykkCt4uu20jPAkz5Tm04N8/0/7/b+UeM6ZBVVKW1BXrRnrgc02761R34OUz2Y/
	CIoSFjJ5KK7IKOSrvbivchrvR8Czk0MtsjIM+SqEEMXCfg+GGg8rY05Vs/pHGDQ6vL32epj81rG
	nVTWyocM9VTMDyxAUvjvFmq8jNVZHg4nC4iBqtyXmiIt0SfCsQ==
X-Google-Smtp-Source: AGHT+IE59zFK0k4FqZlCMkYs0jRqy9akgU6KdZPmbOJsPiyF1i1a53x6V4y4VmoHrSVjObFtMf/iuw==
X-Received: by 2002:a17:907:94cb:b0:ac1:ea29:4e74 with SMTP id a640c23a62f3a-ac1ea2951afmr373989566b.28.1741070220918;
        Mon, 03 Mar 2025 22:37:00 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abf6f85ea15sm367116166b.111.2025.03.03.22.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 22:37:00 -0800 (PST)
Date: Tue, 4 Mar 2025 09:36:56 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: sunliming@linux.dev
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, nuno.sa@analog.com,
	jic23@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, sunliming@kylinos.cn,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH] iio: imu: adis: fix uninitialized symbol warning
Message-ID: <c5b70fd8-2d03-4179-a8b8-5ee827fff978@stanley.mountain>
References: <20250304060518.1834910-1-sunliming@linux.dev>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304060518.1834910-1-sunliming@linux.dev>

On Tue, Mar 04, 2025 at 02:05:18PM +0800, sunliming@linux.dev wrote:
> From: sunliming <sunliming@kylinos.cn>
> 
> Fix below kernel warning:
> smatch warnings:
> drivers/iio/imu/adis.c:319 __adis_check_status() error: uninitialized symbol 'status_16'.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Signed-off-by: sunliming <sunliming@kylinos.cn>

Huh...  Someone is using lei to get their email.  This patch is fine and
it's theoretically the correct thing to do.

How the zero-day bot warnings work is the they are first sent to my gmail
account and I look them over and either forward them or ignore them.  Here
is the code:

drivers/iio/imu/adis.c
   305  int __adis_check_status(struct adis *adis)
   306  {
   307          unsigned int status;
   308          int diag_stat_bits;
   309          u16 status_16;
   310          int ret;
   311          int i;
   312  
   313          if (adis->data->diag_stat_size) {
   314                  ret = adis->ops->read(adis, adis->data->diag_stat_reg, &status,
   315                                        adis->data->diag_stat_size);
   316          } else {
   317                  ret = __adis_read_reg_16(adis, adis->data->diag_stat_reg,
   318                                           &status_16);
   319                  status = status_16;
   320          }
   321          if (ret)
   322                  return ret;
   323  

So if __adis_read_reg_16() fails, then the next line is an uninitialized
read.  But then the if (ret) check means that it's fine at run-time.
It's a false positive.  The other thing to consider it the UBSan will
also detect the uninitialized read at runtime and splat.  That's still a
false positive but it's a headache.  But when I was looking at this, I
decided that __adis_read_reg_16() was unlikely to fail in real life so I
decided to ignore this warning.

Initializing the variable to zero doesn't change runtime for sane configs
because everyone automatically zeroes stack variables these days.  It
just silences the Smatch warning.  So I'm fine with this patch.

(This email is for information only in case you were wondering why the
bug report was formatted strangely etc).

regards,
dan carpenter


