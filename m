Return-Path: <linux-iio+bounces-17916-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3C2A84755
	for <lists+linux-iio@lfdr.de>; Thu, 10 Apr 2025 17:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1738D9A4B08
	for <lists+linux-iio@lfdr.de>; Thu, 10 Apr 2025 15:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2311DDC11;
	Thu, 10 Apr 2025 15:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4fQScCd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D22F84039;
	Thu, 10 Apr 2025 15:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744297643; cv=none; b=e3Ip/wn9+eTdPXx8xjGr8XiJL23okCk/sOS9kluPtavJMYqjvxL6GFAMDPvR1qk++WUJqtRvDxs6pPk1rzBaKudV2AyJhlEvs1oIxaAmUqu6MU0tnIb4urKMRu+dTzRYsg8eGQobFALBTtzkKRDSLrjRTM+LkR6ASpBqzRYPZZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744297643; c=relaxed/simple;
	bh=eboaS5c05OyvAb+NBPFm2wN3NGNx/XKe73+3Wz4fRNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gce9G60G8BWWqmbu1gvD6tBJabixUEaOJVKCIMxri5SsHbi46lFRu6ppVWakWuq2IHR4UlbGr6PGOP86k/LRtMpLxVT+xBVHhpBq2KDcGVyG8Yd7dTbgjro2uCcipcNlZfzngGPuNJODQqnVj/eF2PpBsw1YSDRcsHA1+Afosg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4fQScCd; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-af28bc68846so916266a12.1;
        Thu, 10 Apr 2025 08:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744297641; x=1744902441; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=brD0jvjX625bzsG6fgbmQ6q3jKQyaVH5CAKGozygZW4=;
        b=Y4fQScCdBm7TYTc2CO/GK2xHK2xFEykki0+FIk13PeMSfMZSbypl3klPQdjaHfqCNh
         sdwHCz2ccdYIKyb1TjGx2lz8PaOfEfSJEsQBjzXX9PcIRIz/AGguNDB2R1Je5iOOlvAR
         FexJxObppUR/dXUUtLT+XKzR5oJfVymXGux/qcz2hqxQFTvQD50axZ3Avtz+xAqWD9Tu
         AdhDyc0osLPhQ6FSitAIQ7T83Bk+p6EJTgbM3Svuj+Pw3FsWqhr2WhK510mE4MRFybRq
         7YgMVlzMoW1bCs2INXe7FIRn611na87jiyjZgz4Z+k6d56r+BRCjPgTk0DX/IQItCsOK
         NSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744297641; x=1744902441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=brD0jvjX625bzsG6fgbmQ6q3jKQyaVH5CAKGozygZW4=;
        b=m61RxGzGY7+4IvBJhEYepWHS1BB3sp4b0uNkGcsf9JWKchkUIpn0ZDdeuZf0ggv8Ji
         ziO2fgJhR+kzPQw82gnKdh3dWG5/GyUk1tLVpghN7uk72xFdcRxhhsaXHPYjC5ABh3H5
         +28xZOmU0zXQfVA6/+fBjG4IjsM4R3FvzuueZsOfgJnwGfFepZQoDB1j4NF5NgHLdHkA
         Rl+v0DF8NR3ct6o607WSmBGI7SYKrHVB73vai8GGvnNc1SfUHPtMsPS+XI5m9hDPsEA3
         FrE37v34ee9XCs5L5eHxa345EUOB56YMQKnUKm2n9vKSIc9R8l/zo1JTtvFj2eYhb9a4
         lDQg==
X-Forwarded-Encrypted: i=1; AJvYcCVkake7YC+Cx7FIZVy8aaheNTdbh1BxYIKq59S7C6DI8kKmG7rIFXwWHfroBPWaOQZYB+EIBr2U5EBJ@vger.kernel.org, AJvYcCWOoPTpuowzbexyL11ACVpltt2AHkZKD6WSp6CTWtrn0Q0yE2gLJqd6f8oOS9MK0TXj6/Dr0K1roco=@vger.kernel.org, AJvYcCXquWq+VjRxMtO3cAbC6gZrBs34MxRPNZuMaV64U8e3W5GKqK6lmehzVB0z9yMm0evJOejQnecN1yBcifW3@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0RVEu3eY4oflf70ioG3l+DaYESkK5rSS19xeUrdIyH/7ejwyt
	m8n61z2PKJ16ZTpZHOIANlDd7bzXOxOI4YCXQPlkMKiw+WDBJKjN
X-Gm-Gg: ASbGncuOUce8+83DGyypqMzVm0ghJKr7dY9d/SuR5KY8hSOtcvRPjzG8vn1atrymToD
	mtgFJuWHJhHnJyqqPuZi3UfXtnyERTNWeOfBInJsw9YLxu7rmBmtGg/npXnDs69LkO13RZTbXAc
	aAHQvbgRrbraf7hTEXCVdBWEDI5upWdRT9HCBKehFB5/zy+b9Ri78BtWjuFF5bTHc3Jj797hhmq
	LlxCtuUW+mBsdz+K4jdrMrkD/h6BwJE2Hp7YBBqIY0Xd0qmVwJ82Jtm8lLe/z/oPW1qOEfyjXjX
	6BolBf9X2uCrwZNzdK1TGeZ/Qs6ef+rMzVx3lkcRVVxQueCSuA==
X-Google-Smtp-Source: AGHT+IFipQ50ghFnCXKI8zRF8Bt+A/DpNB00DQaIIZ1RLRoPjkBbjJFwo/iHx851n7lTd+u7pGjTKA==
X-Received: by 2002:a05:6a21:9214:b0:1f5:8153:9407 with SMTP id adf61e73a8af0-2016cd5ec22mr4138335637.20.1744297641304;
        Thu, 10 Apr 2025 08:07:21 -0700 (PDT)
Received: from localhost ([2804:30c:979:8400:d3a1:d5f7:94ea:b576])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73bb1d46586sm3471204b3a.64.2025.04.10.08.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 08:07:20 -0700 (PDT)
Date: Thu, 10 Apr 2025 12:08:27 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	corbet@lwn.net
Subject: Re: [PATCH v4 1/4] iio: adc: ad4000: Add support for SPI offload
Message-ID: <Z_fe69bn90oVjPNk@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1743110188.git.marcelo.schmitt@analog.com>
 <386ce043a0e3fc9e8ff71f17aef8de128ce5869e.1743110188.git.marcelo.schmitt@analog.com>
 <97d0cc16-cdd4-449c-87f5-f62e0515de97@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97d0cc16-cdd4-449c-87f5-f62e0515de97@baylibre.com>

On 04/09, David Lechner wrote:
> On 3/27/25 4:24 PM, Marcelo Schmitt wrote:
> > FPGA HDL projects can include a PWM generator in addition to SPI-Engine.
> > The PWM IP is used to trigger SPI-Engine offload modules that in turn set
> > SPI-Engine to execute transfers to poll data from the ADC. That allows data
> > to be read at the maximum sample rates. Also, it is possible to set a
> > specific sample rate by setting the proper PWM duty cycle and related state
> > parameters, thus allowing an adjustable ADC sample rate when a PWM (offload
> > trigger) is used in combination with SPI-Engine.
> > 
> > Add support for SPI offload.
> > 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
> 
> I think I spotted a bug. With that fixed...
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 
> > @@ -690,6 +942,15 @@ static int ad4000_prepare_3wire_mode_message(struct ad4000_state *st,
> >  
> >  	xfers[1].rx_buf = &st->scan.data;
> >  	xfers[1].len = BITS_TO_BYTES(chan->scan_type.storagebits);
> 
> Now this needs to be:
> 
> 	xfer->len = chan->scan_type.realbits > 16 ? 4 : 2;
> 
> Otherwise when there is SPI offload, this could read 2 words because
> storagebits is always == 32.

I've just tested both versions with ADAQ4003 and with AD7687.
There's no practical difference between the suggestion and what already is in
IIO testing. I don't mind sending a patch with the change, but don't think it
fixes anything.

Thanks,
Marcelo

