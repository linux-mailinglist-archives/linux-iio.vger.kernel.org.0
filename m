Return-Path: <linux-iio+bounces-14960-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD88EA26DFA
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 10:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34EC8165481
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 09:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09111207675;
	Tue,  4 Feb 2025 09:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CqHNfwPj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB8C20371A
	for <linux-iio@vger.kernel.org>; Tue,  4 Feb 2025 09:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738660405; cv=none; b=khu91Opv3ELLsQ0DTGBOQM0oJvp3vvOce+wAjrIxvThg9nEr/KhqBjufXkQJW6OTIs/MhJZa83o/vfBKMhO1lKa/xMaSsepCUHtG/bCfhB026QQvt4b50xs5PHZrTQs71rZcmHe9aedUSFuyon39WAOeIzPuTTQ89zSN/FWa0Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738660405; c=relaxed/simple;
	bh=guCYDEZfatS1noOg8DFizCB8qPAd1cKHdGMwaAKnd70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUbs08aK8l2LYwH6c73HYDBkjEwh7cG3T2kaCjGgbIE3R6bxmW20H3mwopt0LZrRA5PLEC908KGBS18mHkQZidj0uXHeejr2ZsFpbD0q/KGQC4xX8oIVxan1AWtg534njFxTgtUBjsknfYZCd6GIcVkQuTNThTKvpFVOmEM1uOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CqHNfwPj; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-436202dd7f6so61822295e9.0
        for <linux-iio@vger.kernel.org>; Tue, 04 Feb 2025 01:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738660401; x=1739265201; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yr/+ZLUNk+4n8++2+mVlj1ZU6ASEvzQYyto4goLfiVo=;
        b=CqHNfwPjbUzFRB+Hopk4e7WJ3Lo78c9q1Q8Q/KEJSrSNVrtZNgRGDpylLkeuZa3PY0
         xBEGGWReBMkkID0U7+zrolo+bfaj2M4BCZEeU9kM4hInpwkk0HfnW6MjWCnQSPb/Op4n
         Qqwllxxh+p9QZFs8UnskFTtGH8j5LXicxDNReqrzL4Y/5MJqvr11fqgmvcZERFRPyu01
         9Zk+aXJFXpkWgBpsxTBeQWGaowHZYPh9scSL8yFcHGtaWmeKIzL9erKN0GaMvBtVkEui
         fipxpEb4eEkIfMCLj5/wKKVNprDSofNuoVxTR55yPFw5WHaxZ0RHDFe+9iBPCspDidkX
         1PDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738660401; x=1739265201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yr/+ZLUNk+4n8++2+mVlj1ZU6ASEvzQYyto4goLfiVo=;
        b=hclNL5raqJMfKL274la0+VzSTAKN4+45TL2lceGYsQ/3t5diiyaN6vWnI5Lk01JHou
         WyOStjeSkTFCX68oYJJ6UycaLX5R8sNY5iKvjm+0oP/xL7CzowtRxmLaL6FmptVPQAVr
         YKQKX4z1ZIYQS6zkIMzKG8/qtcgAofv37Ed3XaTjU3UNTwEUWb4MpC7nxlkB4HEmTY8i
         Ey5nKhyZIQozjS6lUO7jrlib6MhDYKgoInrw6PFT/0dd1n9X75gPB0teNN7/pkblEBdA
         4NlbDtHxVri5Y+52CYvbtfIjMHqbpI/Kp0WYv7ReZ7yiDkRtGtgB+ASD4MZeprfvZ0Ts
         czLA==
X-Forwarded-Encrypted: i=1; AJvYcCWvpVVhpQvC7+d0+Vmd1Uz2vh9W35wJ2z2JF4F3eumSOI2v4cnjMw56P2dwM7jWXDZO58SSh5zLJQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD5teK+OBUjAPXOMzhN0RgzTfcJjX8Gnz8xtNZTOJ6bXq/FFI/
	e2dupf0+IKmGb1TGURg2g+VapOrlvJWqjB1pIGvGa1vNyFjOnI0u7HS+jqUgcx8=
X-Gm-Gg: ASbGnctCtZy6x2Y0WjF9lYznsCgg1hO0fJ6EEzKqRCVp3hkwJ9uAOSMZ9bovF9WxlF2
	7lN+2ora8MFz8PB6zvIBze2c/ONchZuHa4xAPRubh+UIYPSnLZQyldF2qSzuIi54wIo2Zv+wTse
	G610KMg7jqZEUsW3W5iIJcAn0FzLE/lO+YkNFUWBnhi0MgKFxr+2QJzqO11OjGzwUbjKPeyhgYI
	GlbSbOnUq1eKFxPaN4uEEbTgmUznKeQvg+Jby6/1cAUnNgkXPMF8yx14DuXRWUWqfChIkIe0H3d
	wadHuy+yK78fwV8/xSmimkp3ZvWTthtm2Qpu4bqF+2pBDcIaxIVniigX0lYV
X-Google-Smtp-Source: AGHT+IEbzL0EqLuDwQ6Yf31TGo6zlY2GXAZdCWOhx7/P2QuqO2JQc1DkrMAkqHEyKCWJuqpiYC70vg==
X-Received: by 2002:a05:600c:35d3:b0:434:f586:753c with SMTP id 5b1f17b1804b1-438dc3c3790mr229867965e9.7.1738660401236;
        Tue, 04 Feb 2025 01:13:21 -0800 (PST)
Received: from dfj (host-95-244-234-244.retail.telecomitalia.it. [95.244.234.244])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438e245efbcsm179835275e9.33.2025.02.04.01.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 01:13:20 -0800 (PST)
Date: Tue, 4 Feb 2025 10:12:05 +0100
From: Angelo Dureghello <adureghello@baylibre.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: oe-kbuild-all@lists.linux.dev, Nuno Sa <nuno.sa@analog.com>, 
	linux-iio@vger.kernel.org
Subject: Re: [jic23-iio:testing 23/47] drivers/iio/dac/adi-axi-dac.c:731
 axi_dac_bus_set_io_mode() warn: always true condition '(mode >= 0) =>
 (0-u32max >= 0)'
Message-ID: <l575dzyjzix2xnljfadw5uuu3qdzhmtcbkyg6eaccf2h5dtvsz@ju5mqszl2vzb>
References: <202502040758.DJqHqhLO-lkp@intel.com>
 <rhmmbt3yqfqhodivu2smuu4g2i77sqyzr3jjjxtvjsny7a6jgd@64bong6elaul>
 <20250204085744.000075d4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204085744.000075d4@huawei.com>

On 04.02.2025 08:57, Jonathan Cameron wrote:
> On Tue, 4 Feb 2025 09:43:17 +0100
> Angelo Dureghello <adureghello@baylibre.com> wrote:
> 
> > Hi Jonathan,
> > 
> > On 04.02.2025 07:23, kernel test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git testing
> > > head:   315198c0a370da031f5c3d504b99f771a0c545ab
> > > commit: 493122c53af1915b4b5b5f47a8c446973ebff052 [23/47] iio: dac: adi-axi-dac: add bus mode setup
> > > config: m68k-randconfig-r071-20250204 (https://download.01.org/0day-ci/archive/20250204/202502040758.DJqHqhLO-lkp@intel.com/config)
> > > compiler: m68k-linux-gcc (GCC) 14.2.0
> > > 
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-kbuild-all/202502040758.DJqHqhLO-lkp@intel.com/
> > > 
> > > smatch warnings:
> > > drivers/iio/dac/adi-axi-dac.c:731 axi_dac_bus_set_io_mode() warn: always true condition '(mode >= 0) => (0-u32max >= 0)'
> > > 
> > > vim +731 drivers/iio/dac/adi-axi-dac.c
> > > 
> > >    724	
> > >    725	static int axi_dac_bus_set_io_mode(struct iio_backend *back,
> > >    726					   enum ad3552r_io_mode mode)
> > >    727	{
> > >    728		struct axi_dac_state *st = iio_backend_get_priv(back);
> > >    729		int ival, ret;
> > >    730	  
> > >  > 731		if (!(mode >= AD3552R_IO_MODE_SPI && mode <= AD3552R_IO_MODE_QSPI))  
> > >    732  
> > 
> > not clear to me the reason of this warning, maybe because mode is an enum ?
> > Should i take any action ?
> 
> Currently there are only a few modes in there and that range covers them all I think.
> So warning is correct, but we perhaps want this check there as hardening against future
> addition of more modes.  Maybe an explicit switch with all modes listed and a default
> will have same effect and be better defense anyway against future changes?
> 
> Jonathan

thanks, clear now. 
Is maintaining the waring an issue ?
Another chance may be adding a AD3552R_IO_MODE_MAX as last item ?

angelo
> 
> 
> > 
> > 			return -EINVAL;
> > >    733	
> > >    734		guard(mutex)(&st->lock);
> > >    735	
> > >    736		ret = regmap_update_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
> > >    737				AXI_DAC_CUSTOM_CTRL_MULTI_IO_MODE,
> > >    738				FIELD_PREP(AXI_DAC_CUSTOM_CTRL_MULTI_IO_MODE, mode));
> > >    739		if (ret)
> > >    740			return ret;
> > >    741	
> > >    742		return regmap_read_poll_timeout(st->regmap, AXI_DAC_UI_STATUS_REG, ival,
> > >    743				FIELD_GET(AXI_DAC_UI_STATUS_IF_BUSY, ival) == 0, 10,
> > >    744				100 * KILO);
> > >    745	}
> > >    746	
> > > 
> > > -- 
> > > 0-DAY CI Kernel Test Service
> > > https://github.com/intel/lkp-tests/wiki  
> > 
> > Thanks,
> > regards,
> > angelo
> 

