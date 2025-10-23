Return-Path: <linux-iio+bounces-25361-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EB926BFFA7A
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 09:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ABB90568CE6
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 07:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2932C028A;
	Thu, 23 Oct 2025 07:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HEFdjfkO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54254236453
	for <linux-iio@vger.kernel.org>; Thu, 23 Oct 2025 07:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761204675; cv=none; b=eV0ENVVimPVj1lC9AmdQUgExeaQI+4N3VqG4A2uZ8oN7THbLNxTR9EnDJHa3k/QU3S6S+Ok+ysdj1yl1uAy66uSWNdUbbzUu5FdTB6LerM+rTbuFCI40n/RF/eO364Q5DYGgH9m+rNHRGp3IQnN3Jak6ebjcL2FZy2YPTJ4ycFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761204675; c=relaxed/simple;
	bh=aFRDzPkcK9NfGl8UTUu2FSysM7F5S+eQ7XxMTHyQQzY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=E76GqEZ+EPVghVnROwWPL6B7P7hj7SB93j+LSoUl6Pnpp11D9iloNsphluUWv5GXUOgtjQsbF6uWNVYwjc9h7jnsLl7AqPJ6Sq+KZCDJNXng9+/1q8k4r4Uykh13MXtbm+ezEFlSJ3GH7GM5G4OvQE3G2V71zgOW8thBPa50v5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HEFdjfkO; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-471b80b994bso5968485e9.3
        for <linux-iio@vger.kernel.org>; Thu, 23 Oct 2025 00:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761204672; x=1761809472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A3Zl0NzO6dgztEpIBfhUUKoZHrDlf3kwSQWoMIJPwEA=;
        b=HEFdjfkO7k87QHghfzIzojCtt0S0nv35/wt7CM/JFkqmB4Es5+y1zr+/2JWrELweTo
         fLcjJ56OyDyw73tpkCXf0pEM/Ra/A1+QFheeRlogGers4ba1k8C/Dyuqe+07R13jiIgf
         S56OzC6VhaegbcT0AH1f5Dii++gz/VSee72T4dnINMHd0r8QV24uQjkyIeAEvXrHvy7P
         IU2yDTlhKd48cG0uyQUdxJZKMSYNwjQQTjVa/AI7oD2RxseZbfrzXAQsDmxKtm2kwZ1d
         N9tYGgICibo5NcmuDC/WEZfBxUKznly8HL2DFYAD/LVI3H8FYa6Ns5CNiagf2qumJYnR
         lbqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761204672; x=1761809472;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A3Zl0NzO6dgztEpIBfhUUKoZHrDlf3kwSQWoMIJPwEA=;
        b=pjjpHyYKvgWPwmqRqiSUPDnV0CSppFJ/dvD3OFd6s4DXx4eTT2d74fCXH9tJbIcljl
         t7PiVJYL+qqbJxAgzipy1g1PQnhu5Ou5Jo7YFa9VFDScM0wkLUKDdCvR4LN86zkzFkRr
         53dS1eJqggNOE80T0P8j0M9QUz0QUlqDkllfzXJR3Lh4q7fLQrHSOwSUh9pIM2rElmr+
         WCYdWVIlS65j8Gw2P/U74e15z0fghkUiU7QXzI6BNuopbxFnW/Y33ajn0U1nEI9U+A47
         d6koNroc5/NSV+UIYOhURK0eRECCof6h0QhsPk+PV04Q0fEZDbYaNz2JYt6sSPOfLnSP
         z7dQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4oo2pqfnC3ihY+yDP/PrhakqMJW5Ku8IKLcee1xQNuBR+bUuPCnqCVNoikvAYgaAnr/l9ahCTYFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBdjbbobfoAGo/my2y4BEYDU5bqNSfNcUKRA6G/SUzR1nvLppD
	7oXJDgEm/NPbKltLKHQ2A1ck+UK+j2agaaxgn+aAfVJpMLKeq0ll/Ru1rFzD9jXh/lY=
X-Gm-Gg: ASbGncughIdj+5aGdDJW296RHoMiajtCPZ6liK4zBA/eThdWag524giPnua4RKJvT8v
	PSLjOFeHDZjB7Ni/BAp5GPmyl4nOvIeXo5ESQKODszMG42ER/GLePtyZmN4CxdWCGXQWiGFayLp
	o5Wtr3rayR1fA7iP0ijKXi5+QZDE2yWs5aIINRiKdnP/Rl89c1xa0p7b5ZHe8zEo7xJP4ZuG4o+
	ZZWu25vuZSQB2df3qN+DJd3lze8TqvPsZfzs5FLir1dOu3qar3hzmXNLJcTrlgNPB/vyXFDFJo5
	dZ48mE/hxSyUh8VX1gDXGDvVIU/Q38Ae1jv1/dcgOKaT5kA7wc4BqUSLaPypipFJPOOMiIdyNt8
	L+iUEJNS7LaB/Uj/YciFxVcFbJ/ubfpl4mICovobsAEgOCwUoZAm4RsfvponBckrYUvJQbQCCX2
	VmzStdzch3AxPdUD5A
X-Google-Smtp-Source: AGHT+IGlhOgrTrFS3lTljK8PD6tgtfOcB8wV5TTCZ+KMjcR3xg+VWPl4LfT+6SvDqRlsNkBtYEe0Eg==
X-Received: by 2002:a05:600c:45c9:b0:471:115e:87bd with SMTP id 5b1f17b1804b1-4711791c601mr162939935e9.26.1761204671516;
        Thu, 23 Oct 2025 00:31:11 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-475c428dafesm80214005e9.6.2025.10.23.00.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 00:31:11 -0700 (PDT)
Date: Thu, 23 Oct 2025 10:31:07 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Ariana Lazar <ariana.lazar@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ariana Lazar <ariana.lazar@microchip.com>
Subject: Re: [PATCH 2/2] iio: adc: adding support for PAC1711
Message-ID: <202510230847.CEW0lvJl-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015-pac1711-v1-2-976949e36367@microchip.com>

Hi Ariana,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Ariana-Lazar/dt-bindings-iio-adc-adding-support-for-PAC1711/20251016-002337
base:   19272b37aa4f83ca52bdf9c16d5d81bdd1354494
patch link:    https://lore.kernel.org/r/20251015-pac1711-v1-2-976949e36367%40microchip.com
patch subject: [PATCH 2/2] iio: adc: adding support for PAC1711
config: loongarch-randconfig-r072-20251019 (https://download.01.org/0day-ci/archive/20251023/202510230847.CEW0lvJl-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 15.1.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202510230847.CEW0lvJl-lkp@intel.com/

New smatch warnings:
drivers/iio/adc/pac1711.c:473 pac1711_retrieve_data() error: uninitialized symbol 'ret'.
drivers/iio/adc/pac1711.c:924 pac1711_read_raw() error: uninitialized symbol 'tmp'.
drivers/iio/adc/pac1711.c:1124 pac1711_of_parse_channel_config() error: uninitialized symbol 'ret'.

Old smatch warnings:
drivers/iio/adc/pac1711.c:1079 pac1711_setup_vbus_range() warn: unsigned 'ret' is never less than zero.
drivers/iio/adc/pac1711.c:1079 pac1711_setup_vbus_range() warn: error code type promoted to positive: 'ret'
drivers/iio/adc/pac1711.c:1102 pac1711_setup_vsense_range() warn: unsigned 'ret' is never less than zero.
drivers/iio/adc/pac1711.c:1102 pac1711_setup_vsense_range() warn: error code type promoted to positive: 'ret'
drivers/iio/adc/pac1711.c:1377 pac1711_probe() warn: passing positive error code '1' to 'dev_err_probe'

vim +/ret +473 drivers/iio/adc/pac1711.c

de2a3cdfd6e76b2 Ariana Lazar 2025-10-15  450  static int pac1711_retrieve_data(struct pac1711_chip_info *info,
de2a3cdfd6e76b2 Ariana Lazar 2025-10-15  451  				 u32 wait_time)
de2a3cdfd6e76b2 Ariana Lazar 2025-10-15  452  {
de2a3cdfd6e76b2 Ariana Lazar 2025-10-15  453  	int ret;
de2a3cdfd6e76b2 Ariana Lazar 2025-10-15  454  
de2a3cdfd6e76b2 Ariana Lazar 2025-10-15  455  	/*
de2a3cdfd6e76b2 Ariana Lazar 2025-10-15  456  	 * check if the minimal elapsed time has passed and if so,
de2a3cdfd6e76b2 Ariana Lazar 2025-10-15  457  	 * re-read the chip, otherwise the cached info is just fine
de2a3cdfd6e76b2 Ariana Lazar 2025-10-15  458  	 */
de2a3cdfd6e76b2 Ariana Lazar 2025-10-15  459  	if (time_after(jiffies, info->chip_reg_data.jiffies_tstamp +
de2a3cdfd6e76b2 Ariana Lazar 2025-10-15  460  			msecs_to_jiffies(PAC1711_MIN_POLLING_TIME_MS))) {
de2a3cdfd6e76b2 Ariana Lazar 2025-10-15  461  		ret = pac1711_reg_snapshot(info, true, PAC1711_REFRESH_REG_ADDR,
de2a3cdfd6e76b2 Ariana Lazar 2025-10-15  462  					   wait_time);
de2a3cdfd6e76b2 Ariana Lazar 2025-10-15  463  
de2a3cdfd6e76b2 Ariana Lazar 2025-10-15  464  		/*
de2a3cdfd6e76b2 Ariana Lazar 2025-10-15  465  		 * Re-schedule the work for the read registers timeout
de2a3cdfd6e76b2 Ariana Lazar 2025-10-15  466  		 * (to prevent chip regs saturation)
de2a3cdfd6e76b2 Ariana Lazar 2025-10-15  467  		 */
de2a3cdfd6e76b2 Ariana Lazar 2025-10-15  468  		cancel_delayed_work_sync(&info->work_chip_rfsh);
de2a3cdfd6e76b2 Ariana Lazar 2025-10-15  469  		schedule_delayed_work(&info->work_chip_rfsh,
de2a3cdfd6e76b2 Ariana Lazar 2025-10-15  470  				      msecs_to_jiffies(PAC1711_MAX_RFSH_LIMIT_MS));
de2a3cdfd6e76b2 Ariana Lazar 2025-10-15  471  	}

ret isn't initialized on the else path.

de2a3cdfd6e76b2 Ariana Lazar 2025-10-15  472  
de2a3cdfd6e76b2 Ariana Lazar 2025-10-15 @473  	return ret;
de2a3cdfd6e76b2 Ariana Lazar 2025-10-15  474  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


