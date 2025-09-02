Return-Path: <linux-iio+bounces-23643-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C9BB402A2
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 15:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2373A5406CD
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 13:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89300305E2D;
	Tue,  2 Sep 2025 13:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTnyE25+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B73305048;
	Tue,  2 Sep 2025 13:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756819089; cv=none; b=nh+kI6khNQSg/whNQt626jmAcp/+yZjSriXou6efyES+GGcpP3hnYZY6OhH99V8iwLBTWKHDE7qkv4sMcmZ/EWkXsryIIp7UBJj+3xCTGlU9QI+KPHV8YwEApjdiml4jTiTjJ7dbVYA8zrbbdLn0FcvDUwmFlXGOP2BwYv7aw78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756819089; c=relaxed/simple;
	bh=VNvLbUz1iPGZN84i/ahuhblFaByDg8xV+yVOfvJzNM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZJXDLRKqXYlknUUNNYTuoZAIgyV4kxgL3Txvwy9XkbM/RW+T3LJSudqRTi6qVCw+xIW6kBv6w4XfdSr54F3K6GJuCO5t9pBORI8L9R/5eCoDvJuJxjgNzi8/X5zRID06HsudJeqbw8XswQP0FfeSPxsr/8IVHEigb/k1YyNqdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTnyE25+; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-54488e51c37so1607975e0c.2;
        Tue, 02 Sep 2025 06:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756819086; x=1757423886; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GZ/ylrrWod48ZuAvL1xw5smyVmv1EILXwMIOSKZ9k1k=;
        b=mTnyE25+GHVcGgPMwp8Z8VHrx4GMoSJ1MnO1yRIk7dqUJSJIVnjMWjF1pKMsgeMxV/
         827if9V1dkATYrY+zXQg54HMTaHFKnohJPyD9Xzf5lSjSEnq5fbF9Jjxs4HGnE8Ku5+Q
         IcqBkM1S9224CtDNbxz4ODd+Kaau05XzfPhuSHuhVAnaA9IwCDx6jC+yzK0cLzyyJr36
         A+7yl2LavMH/DugGm5guE75Vp3qwiKcI0FruFCUVlT+yw/pjWMYzwB+jjo5IStMtUPFq
         EYU5tS8Asqcq6QXNlIpLzooWv1i80jDEcwlS2jizLH/RfJyWL8sev1YQV8eGGSM0eTLY
         f+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756819086; x=1757423886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZ/ylrrWod48ZuAvL1xw5smyVmv1EILXwMIOSKZ9k1k=;
        b=shIW4wOZN6mtZSxxfIqMQ/srC5IAsxpLT3c++W896yPlIouh4mkvP2njeGnCUQFjEC
         wTsPUXzWyZI78S7lwRSMaa6bTaHN0MxjxxmFxTxTLrmIdlMttolgqh9AgNY4s69K4IaO
         /G4gnzweaRGzF6+FTFucwXOepP8FXc89rEnZWwA0qNxXdEjqdW+0WG6xLND1vxzrsxNa
         Tl1mNbstcfLdtynsZk1qEnOuIEpOCG3SmmWF90iQObdPIH+laKxinJUXYiGWMhb8qhW5
         5pMi5pBTO318t6FzQzxIdLQEMXmt5GMSRcDrYCFfedJS8YQljYn73UpwF+ZkYpstYJns
         bKrg==
X-Forwarded-Encrypted: i=1; AJvYcCU/5bMfWtmUA6w0JPqljT+QWavx7wRsPaNYtvCDMNk+UCIkg/9UsJkjaL2neozpg7dNEQyvV1Rvi8uD@vger.kernel.org, AJvYcCUBAh1+Cy3gHd5lAQosqU23hBqRw7KbktK5xxcrbXRcy7CCe7T873O5NC+3WrFtNffA55aQiDb+3wVorZpb@vger.kernel.org, AJvYcCVyEH5rTehgIC3+S/jbAgETidAbM8Kikgq/n0yRSPZSG1Nwoa82Tdbn14el8/1Cu1+mSwjT6czQjZ4N@vger.kernel.org, AJvYcCWXFtH+czSyQSWEBgPGY0rK3GP24sxA3UelriPaiQHI7D9vRYMBS4k713mVSqiFdHRYGD67TB12cM2R@vger.kernel.org, AJvYcCXYDgUGyTBejwJDPZ/vzXIVr3N9pDgEkQETA8H3InynEBGL2IhXbxeOz0q4ZRnhSGCNNkqSJih9HSRw@vger.kernel.org
X-Gm-Message-State: AOJu0YyH4urcx1/1lb5hREgrklb3Dk5m0JmofJR06dtYiq2IiRxWal8t
	bv+HtICwI8FChPLR15aI8rxBbQBW8lOxI80IQpdYd9/J1LJyoq7J7Hp/
X-Gm-Gg: ASbGnctPNGzEiysif1dE4amj6gE1X2dTOjp8h4BetyyiEd5mAD2C1P8sNyxE3/UE4+X
	q+ZJkfGRjU8aRsLgG1QGWktOFqEzlrFUN9StEfYkoKE2aNDi3sX0Dkw3C8Dnnh8ZA0+uA9KdWYb
	sdwGlon4eC0ZxIeh6hY2fuvvMM5YsD2HUmqr8ejo3eD/a93TvFHmYwjMa/16wxi0xt+5UO9WI8K
	66+EWu6LA2UDB5+QgAHUS9KElPC2cVuyhRTWsc2+CHtQNfMJzH6dV7QjWfOsnDSINem0vDAGwfP
	dGz0rQsTlVMTo/Fq6sgZabUwlNDHjUwrgtscckw3KJ4cqIM3w+44RZSQesGhwISj7fn8yAxBxsz
	+3C9BnFCSyCdZHE5rQZmkuhhajsGH01NkCYuCsJgJMQ==
X-Google-Smtp-Source: AGHT+IEOCU6qlrch7aNEAQESmBVfsCgMcg0VsueRTfB86F5nzb5mtgIID7ngPh17lxRjoozcIQ+Czw==
X-Received: by 2002:a05:6122:8613:b0:544:b862:1055 with SMTP id 71dfb90a1353d-544b8621563mr1809035e0c.6.1756819081877;
        Tue, 02 Sep 2025 06:18:01 -0700 (PDT)
Received: from localhost ([2804:30c:1f77:e900:8ef5:b053:b8a:9345])
        by smtp.gmail.com with UTF8SMTPSA id 71dfb90a1353d-54491464b0csm5420089e0c.18.2025.09.02.06.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 06:18:00 -0700 (PDT)
Date: Tue, 2 Sep 2025 10:18:33 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
	Michael.Hennerich@analog.com, nuno.sa@analog.com,
	eblanc@baylibre.com, dlechner@baylibre.com, andy@kernel.org,
	corbet@lwn.net, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, broonie@kernel.org,
	Jonathan.Cameron@huawei.com, andriy.shevchenko@linux.intel.com,
	ahaslam@baylibre.com
Subject: Re: [PATCH 01/15] iio: adc: ad4030: Fix _scale for when oversampling
 is enabled
Message-ID: <aLbuqQ-1hhLGvsPZ@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1756511030.git.marcelo.schmitt@analog.com>
 <f9d40e8deb3d17a41b4fd6ecc1b8ac92275f0078.1756511030.git.marcelo.schmitt@analog.com>
 <20250830194308.32def0e5@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250830194308.32def0e5@jic23-huawei>

Hi Jonathan,

Thanks for having a look at this.
Comment inline.

On 08/30, Jonathan Cameron wrote:
> On Fri, 29 Aug 2025 21:40:24 -0300
> Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:
> 
> > Previously, the AD4030 driver was using the number of scan realbits for the
> > voltage channel to derive the scale to millivolts. Though, when sample
> > averaging is enabled (oversampling_ratio > 1), the number of scan realbits
> > for the channel is set to 30 and doesn't match the amount of conversion
> > precision bits. Due to that, the calculated channel scale did not correctly
> > scale raw sample data to millivolt units in those cases. Use chip specific
> > precision bits to derive the correct channel _scale on every and all
> > channel configuration.
> > 
> > Fixes: dc78e71d7c15 ("iio: adc: ad4030: remove some duplicate code")
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> 
> Hi Marcelo
> 
> I was assuming that when this said 'averaging' it actually meant
> summing (there is a note about using the upper precision bits to get the same
> scaling which is what we'd expect it were simply summing over X samples).
> 
> So given that we don't divide back down to get the original scaling I'm
> not following how this works.
> 
> E.g. If we 'averaged' just 2 values of 3 then we'd go from a value of 3 to
> one of 6.  Therefore I'd expect the scale to halve as each lsb represents
> half the voltage it did when we weren't averaging those 2 samples.

This makes sense and thank you for explaining it to me.
I did some more test and debugging on the remote setup and found out the device
was not correctly configured for averaging data on my tests for v1. I need to
tweak a few more things in the driver to get both device registers and spi
transfer configuration good for offload with averaging mode. I'll reply with
more details if I find something unexpected, or drop this patch on v2.

Thanks,
Marcelo

