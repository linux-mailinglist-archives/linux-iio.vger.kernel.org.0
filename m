Return-Path: <linux-iio+bounces-21089-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 621DFAECA0D
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 21:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9907B3A5D4A
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 19:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE63F25BEF8;
	Sat, 28 Jun 2025 19:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QdpGTVRv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BEE221561
	for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 19:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751139302; cv=none; b=BjYkQOGStwOXJSlThS0UoAziYHIX8iSP+NW0m1dS3yW9edXx76fVbY12ertpukK6iPwlwTE5izYeYzpgEfFaUMlRsIu9RqvaKglEpKvlvJnqtyEJZlLT9SGVUBxhsUG9WISYdDEvfBDbLpsy+EB7ZI7F7/SF52vnB/R8vgz8x0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751139302; c=relaxed/simple;
	bh=me0GBiFpCPuIttbulTyQIXZU/0+othOGnQ83X3C3dWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOq97E78qSfvbJZHtRb0wS6Fz/a8o/SO2Ofd//gesA22dNxw17GwhDcJq81gKfX4bLO2JS2o7lx8F0BJCRnQlWLflrdx1VwfKopVfPUmmtX7SVqd79ib7YTzPSjGnnaHYJ0aesrrPKqKFSpB4b4AQBb4dvKa5D8einEL+SU6Ji8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QdpGTVRv; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-234d366e5f2so7885395ad.1
        for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 12:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751139300; x=1751744100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iHKDnUlLTqmdXQjkvRCxfzluB2rJv+pX3lyahvfq2jQ=;
        b=QdpGTVRvkeFW7IdNuTbgvYagltuOMuqRYFpy5I9hWcBUf8KfYhyxFX8HAWCWSLALmQ
         DXGEIO5hmi1OmHS1dc8SygA2IeaLsvT4MfFJYa8E3FNGaahYMl/R4I4O6ix+V4d+77uQ
         EIHZipfTjZ21olOSRklLhd+175ugR975k8vkJMv/+oJTQnPBggA03aLcXIL2ufJckf6z
         RFHEduq0HrT5njjsS6hshP+gfg6Wc7A1jqFt8npsCuD+IBbgKjnTO+vRgGSVqxHODkPe
         hxpxdywM8/BdxfXiYXmt5em5UdIS704dpW7TmHPfesLLppGPxt/tFhkXKWAqMXbnJ2Vx
         5Tdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751139300; x=1751744100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHKDnUlLTqmdXQjkvRCxfzluB2rJv+pX3lyahvfq2jQ=;
        b=pLgC4PWJaKzOHMbj2iBzQcCvBMJrUz/gfj18Y9i7kgQ+LuIwI2DoGQDgdDnsXah6fE
         QneWe02A/fyZuM+T+j2sjat3eX43jtWEc/PRvmCWIZECKVyVcVHouJ/5wrlrZZeTECb0
         1z6xCSGni695UK9COK3gn0t0RyCtws+s7tbYuWt64qTcYz+01zkHtz1beM5zjmaeAksS
         HNtqRwQmksRtiQEZnTZzQ/4vt2/LhQbSKKkK0hRefpLmu6u+TorDD+GQQwQYh1qcqK1l
         pGUc8YU9EmHN6hNsrw+5Vk4pDRhV4L+HfRJAj9ATC/SAQTil15Vo3ot2n+KtCiwHpetm
         zVQw==
X-Forwarded-Encrypted: i=1; AJvYcCVlR1/gPi+ZJ9z/sN6qTQjyTtSM0Qs2Z0bdGSphnLpf3tqNAbppFuNrwq9/PqOR6Hw5dA1Pz20+m1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH+Wg4Th5qAfX6E9YVrujKzjmIc4hKYeeqQwLN07ogcETdLkoG
	j0SJCJ8xqV3xc8eYhCKrfvUF8Hk5Ge9xZk7tNJnvZjpQ63oclpN0NS31Lk0FqVu9XmA=
X-Gm-Gg: ASbGncuSEptH0w26pHojgbOWo8ZJt7W1cIOqWTK+aLXaI/uiwp6yqZAQ0VwhSDYtmeq
	2IVSNzB9lGZ6Zt5YEcTlyPz0gCTw2x5K79RB+UbMOuFztDuk4CSf7FVZ2SUc8e+sG1rH6lbK5Z4
	ZPvX4QoYciCHP7M6JCVhiDr1yxCY2YKEDjPv/KvGSlv5jbpHri74S6ipYCqTjWzrnK/2xxF5YBL
	reNZeQq+FhnARgvmRskers09mdAYOxf765eaS7ZSJVKQEopXhCQNywfPKxmgJmfZficdijc/wv+
	PidKZDLZe45nGahSv2Ddyg43Wu2nYRVeck3X1dEPG/C3BLucJz9kNQYkwJaYe69A0VdZWPeR7lc
	a8DU5jkSkLluVXNNzRpS6rw==
X-Google-Smtp-Source: AGHT+IHeu4su47hMzl7j4en+VxJcuaRJIBgkjqjt+h8WPfbb35xW3vAml+KgyRy3W91TVd/V6Wf5/Q==
X-Received: by 2002:a17:902:e849:b0:234:986c:66d5 with SMTP id d9443c01a7336-23ac3bffbc6mr149337145ad.5.1751139299978;
        Sat, 28 Jun 2025 12:34:59 -0700 (PDT)
Received: from dev-linux (syn-076-088-115-008.res.spectrum.com. [76.88.115.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3ce960sm43929425ad.250.2025.06.28.12.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 12:34:59 -0700 (PDT)
Date: Sat, 28 Jun 2025 12:34:34 -0700
From: Sukrut Bellary <sbellary@baylibre.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Angelo Compagnucci <angelo.compagnucci@gmail.com>,
	Nishanth Menon <nm@ti.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/5] dt-bindings: iio: adc: ti,adc128s052: Add adc08c
 and adc10c family
Message-ID: <aGBDytRlnOalhicd@dev-linux>
References: <20250614091504.575685-1-sbellary@baylibre.com>
 <20250614091504.575685-2-sbellary@baylibre.com>
 <20250616-wandering-blazing-pug-ea09cc@kuoka>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616-wandering-blazing-pug-ea09cc@kuoka>

On Mon, Jun 16, 2025 at 09:19:07AM +0200, Krzysztof Kozlowski wrote:
> On Sat, Jun 14, 2025 at 02:15:00AM GMT, Sukrut Bellary wrote:
> > The adcxx4s communicates with a host processor via an SPI/Microwire Bus
> > interface. The device family responds with 12-bit data, of which the LSB bits
> 
> You have checkpatch warnings.
> 
> My ACK was given with conditional - PASSING checkpatch.
> 
> Does it pass? No. Don't add tags if you do not fulfill the criteria.
> 
> Drop the tag.
> 

Thanks for the review.
Sorry about that. while rearraging the commit message, it slipped beyond
75 chars limit.
I will fix this in v5 and will use the tag with no checkpatch warnings.

> Best regards,
> Krzysztof
> 

