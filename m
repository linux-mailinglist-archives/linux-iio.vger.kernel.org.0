Return-Path: <linux-iio+bounces-10465-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB48F99AA75
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 19:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF1FF1C20E95
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 17:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D301CCEED;
	Fri, 11 Oct 2024 17:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMtXmRsH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8721A1CCB31;
	Fri, 11 Oct 2024 17:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728668157; cv=none; b=VFHjI32map04x3WmdbQ9/aLS2ETO4u+Xa5RVeqrr+uAvwUoPri+aDDRzlJNPk3rQwYd1qsMeL7NZGvmu5Il5nsbvFLqWXm+V75/WK+2Ln8VIHH6hFE97uAq0JleoQSOk3l3efha1bPsFOgKcp3huuse0LMcm+TrWfbVisnDxjaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728668157; c=relaxed/simple;
	bh=IYbGB9zTZe3U4tbPtF6I2VuL+FdnP/iE5YbWhTENcA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZXTe3VPzEtUpCxCp6hVXcB59lhImp9qJmFlRi4sAhkXvjEaxOALRfEHGpUAVkLfX3iMyW5TdvdMk4UbogQomsdaSFNHqi8VF7jKZImwew7HXzTfEAUMNLOOy8bQnd7Coz9S49QUtymGzujoQtkdT5fxYi0UiPDcSejSFIyu4Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMtXmRsH; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43117ed8adbso21631155e9.2;
        Fri, 11 Oct 2024 10:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728668154; x=1729272954; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lWWmMF+4cpC5c54790uxJHV+gvXu/38t3jODh8WCL1I=;
        b=TMtXmRsHojJElYIJk5G86EsOTTcqRoB1+I0s1mLxsK7XG0P0O8k7i8f9B9HZky7GyJ
         mXsJt6uoBFhmd4100oEO6wOlEkhwfmTYIryFO5/HVF3fUNra163IRY+QJnXhZI33YlkB
         hlGfu3BGinVQV+U+ZUhNV3qQMs/kP+JEEVK97CsUna4+N1Y3rtxVExcoKtyV2azoqhoH
         lUCZBL0aAv00I8tAV5TF90hq9KSqHKQ8O4J+zpyqDE1j9MwY3KEtNzxh8Qe5ewKcUZ7C
         sKdow9M5WMeNZ0IzrPOBu4U47V+mRVXYHVeUVec7AWm9p13MQZHSQ923xM/bDEAF1sER
         qU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728668154; x=1729272954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWWmMF+4cpC5c54790uxJHV+gvXu/38t3jODh8WCL1I=;
        b=cyqCaz9VdlSVNYb/7UVuPLzmJt9bGj9gyzCAYE3LqcO79vzURv7tYHcwnLmMbH8ifC
         B9NqFyi9m11Rq1kp6JexT+Tb8d6zBHwT9uhNEyVY77iMQbNlcZYX3SQevpK9BNWcT8NC
         pm/FXGJw305j8WAzbxUqNX1ZLJLaXPDSgkYnMomTvFXqGS+15OIMFqn7VZ9vIZ37M5CD
         cRguGn+cuzPpqrOgxmrK5V3SfPwisPDUNUK9ol4RDwuxOxecuQHi3+rNT1+QNl/voOk7
         /RmY+aijvLiR0TkarBa84e+FCeBk23/WFFP5ZX0gMgB8/N+k0BSu6ALtJQSKRYi0haOL
         IURA==
X-Forwarded-Encrypted: i=1; AJvYcCV5+CPFpq5QKNCWZDzkwtNBICVtLMW8dqzMsCFUA3yiTl8+PJAMiPgrTPfXNwozz2/bFoCqdCqyy70v1u6r@vger.kernel.org, AJvYcCVT4FYD87XkIfgV/SUdtihXjtkyyD4u4uL6s3AD+3T6oo+iIy2kdPCTVyVUvB6LREknBk5zcEbRHCwZ@vger.kernel.org, AJvYcCWw3aAyrKMH4KTElwWcoIZJjrBylAcnPPYuaOCIbSUPHJNUqi/4hKmRRhZ5bseygL8siUUNJ+O2iVp2@vger.kernel.org
X-Gm-Message-State: AOJu0YxtGadWSKZuHDv8BXfE5IpnACT+gfPKgKP8iAvlnpgSbGzeWYp1
	2G9/J/2ptrwvSp6bPadKyem9sVnn2bFAZRKrE08ffRtgCkWLxqEn
X-Google-Smtp-Source: AGHT+IHlbWMalnq6TxqUn2FGn+wxIKQNsE0A9Dg3qiymPAAswYQzCLia0kJLFZN+dVleeD4Jm07Ezw==
X-Received: by 2002:adf:eac4:0:b0:37d:5130:b380 with SMTP id ffacd0b85a97d-37d5ff8a2a4mr379362f8f.23.1728668153637;
        Fri, 11 Oct 2024 10:35:53 -0700 (PDT)
Received: from vamoirid-laptop ([2a04:ee41:82:7577:73c8:39ee:29b7:ae8c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7f25dc6sm234259266b.72.2024.10.11.10.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 10:35:53 -0700 (PDT)
Date: Fri, 11 Oct 2024 19:35:50 +0200
From: Vasileios Aoiridis <vassilisamir@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: kernel test robot <lkp@intel.com>, jic23@kernel.org, lars@metafoo.de,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	ang.iglesiasg@gmail.com, linus.walleij@linaro.org,
	biju.das.jz@bp.renesas.com, javier.carrasco.cruz@gmail.com,
	semen.protsenko@linaro.org, 579lpy@gmail.com, ak@it-klinger.de,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v8 1/4] iio: pressure: bmp280: Use sleep and forced mode
 for oneshot captures
Message-ID: <Zwlh9rxuEcxSu37C@vamoirid-laptop>
References: <20241007194945.66192-2-vassilisamir@gmail.com>
 <202410111221.YIeXHxOv-lkp@intel.com>
 <ZwkDoSeXA1T4VD0L@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwkDoSeXA1T4VD0L@smile.fi.intel.com>

On Fri, Oct 11, 2024 at 01:53:21PM +0300, Andy Shevchenko wrote:
> On Fri, Oct 11, 2024 at 12:32:12PM +0800, kernel test robot wrote:
> > Hi Vasileios,
> > 
> > kernel test robot noticed the following build warnings:
> > 
> > [auto build test WARNING on 96be67caa0f0420d4128cb67f07bbd7a6f49e03a]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Vasileios-Amoiridis/iio-pressure-bmp280-Use-sleep-and-forced-mode-for-oneshot-captures/20241008-035238
> > base:   96be67caa0f0420d4128cb67f07bbd7a6f49e03a
> > patch link:    https://lore.kernel.org/r/20241007194945.66192-2-vassilisamir%40gmail.com
> > patch subject: [PATCH v8 1/4] iio: pressure: bmp280: Use sleep and forced mode for oneshot captures
> > config: i386-randconfig-006-20241011 (https://download.01.org/0day-ci/archive/20241011/202410111221.YIeXHxOv-lkp@intel.com/config)
> > compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241011/202410111221.YIeXHxOv-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202410111221.YIeXHxOv-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>):
> > 
> > >> drivers/iio/pressure/bmp280-core.c:1051:3: warning: variable 'meas_time_us' is uninitialized when used here [-Wuninitialized]
> >     1051 |                 meas_time_us += BMP280_PRESS_HUMID_MEAS_OFFSET +
> >          |                 ^~~~~~~~~~~~
> >    drivers/iio/pressure/bmp280-core.c:1046:32: note: initialize the variable 'meas_time_us' to silence this warning
> >     1046 |         unsigned int reg, meas_time_us;
> >          |                                       ^
> >          |                                        = 0
> >    drivers/iio/pressure/bmp280-core.c:2452:2: warning: variable 'offset' is uninitialized when used here [-Wuninitialized]
> >     2452 |         offset += sizeof(s32);
> >          |         ^~~~~~
> >    drivers/iio/pressure/bmp280-core.c:2437:17: note: initialize the variable 'offset' to silence this warning
> >     2437 |         int ret, offset;
> >          |                        ^
> >          |                         = 0
> 
> Rarely, but looks like this suggestion is okay, rather I would do it as 'else'
> branch and convert '+=' in the 'if' part to be '='.

Hi Andy,

I though exactly the same, thanks for confirming my thoughts and thanks
for taking the time to suggest it!

Cheers,
Vasilis

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

