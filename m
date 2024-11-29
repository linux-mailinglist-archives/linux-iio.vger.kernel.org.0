Return-Path: <linux-iio+bounces-12837-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4650F9DEDA9
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 00:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B3CE281B80
	for <lists+linux-iio@lfdr.de>; Fri, 29 Nov 2024 23:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51942199FA1;
	Fri, 29 Nov 2024 23:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0MHP20w"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731B21993B7;
	Fri, 29 Nov 2024 23:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732924314; cv=none; b=J74YqcNLOPG5VbgQqDAT+KMqgFWMjhFePbpARooPlOQLfH6KYvxUur7pJxJtM+9jGh7Ql5Q5/VhAeE3BHdEsWGDj4xNNb4/yQWpbKC5ibEMaOJxEvkd1oWw6Opxh9pQGZJoUbcnVQuYRk+ogQTOqEE2QBpNes0Ufddt3Cl2uKDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732924314; c=relaxed/simple;
	bh=QAf6JaXTPzREM25KolzVPpSflRa5+iceDUL0A/Ut00E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuA0Hp6aQ5hHzCXBCiVDndLsTUKapxQ2NR1TNO1wQts1oRjN1rHk298A1p2V2aunW22VRVi1k2leQF9DuYxk9DAl9Wo1CvadEgZZ1M6XCoikLu1G1+47nij5uVDhST3WL3v38UmByQNLRdBHgZ5GkeadE+H8tcUXEelXVJlo7TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0MHP20w; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-382610c7116so1739064f8f.0;
        Fri, 29 Nov 2024 15:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732924311; x=1733529111; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R+oPJsLd4XUGTELFgJANK7OVs252hGEPEG/oKMLtm2s=;
        b=g0MHP20w0puhIa16JS9csOsNzr8tBbeaAhSOelgbfYmEL9/jFt2HU3lOxRAVWrj6GK
         r0oHJQOT174v0xfGNAwGJhKQ+QTEbkkX6RhjhTuABYcC6Dmc4gHwIGLWFCC8SZGov+sG
         vbO6iM34YghGl1ct5rwCwsyu8fUpLdn4hoe8N+68JG1mnGewe0FSz9Td9Pa0LMTOnW++
         qX3TD9jHvzq75w6gJES24nA1FoURCITnSqnOnpdJexXW344qXJZLDiAKpFUHLY+kTPC9
         HhrgKIXUm2fVdlVTkfUn4bRGHp94bGPZjWpB1BgoJujbX3QIUMCUmv9k0BhNaGPo79Ol
         tkPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732924311; x=1733529111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+oPJsLd4XUGTELFgJANK7OVs252hGEPEG/oKMLtm2s=;
        b=Ym3Rc+amM6Xw7SedBqhXsY7j7sbD9eIQwigc4Uyt0gsxCH81PbF0hwXAaGBhIrO7nD
         9Q7I+6G23XvL5GUUS3uXx5ZkqeDMmKBacv+T2b5f+RFkzRndBXfTSJ4f/dIHoBbvTLhV
         y9tiNsAA/WXeF2Y7LwY8Cwf9uEaQL9tOZGuee5z/NuxaYgkSAFn8LXw3AYqhRbI4Gzof
         3PmCPdGCib62dmqBiQ2s/5WSzYupzKoK1mkhKvNVLJfVZoSh9fYU9Nxd6ScBdz8dkeHq
         oRmrGcP5UdaWCvbMlOD8R+iyf4ruhjtiOEZOoLHMQ6et0LyEPYyCeO+j1R8ciutVw5js
         joAg==
X-Forwarded-Encrypted: i=1; AJvYcCU3zBMaLnQmtc0R6ZCULqgFtoGFA5nNvKwcVHQwkADHnjylA31YmxKVXAqh5TMI9PgL1pXC4KAE8q5V@vger.kernel.org, AJvYcCWCdEH53qkMUE14RsYInx3XifQgd+UD0YHctEWx1EuVKtqAjkcKAyBGQpIheqGa5cy/HeyOS5nqyYig@vger.kernel.org, AJvYcCXP7kRgCtJOu0b0RoK4ICSkIXEMU/Gx+QJyUKt7EFNkliaDP3COYJitmATs7cPJ8tCha2tf0nL/XynsBY+M@vger.kernel.org
X-Gm-Message-State: AOJu0YwlNsN6a30EQuIlAnlhkSNLDQX4C64qTeakax8/zMmgENpyqLH/
	xBigmnymsVVjsVcI8vvYpXkTjesa8vW6hrREAdIPYU2pWpL8I/Gw
X-Gm-Gg: ASbGncung1Npbjv6zbZu08ct+v+RPapq/rAUkNQrWx4xrC2jOzdOxiMeQoxkSkGmDSV
	yIUO1v+Bn9DEIhkziRxf/kzPuv/5Y1IzbtzMaJAsJe9i6J0FRHe4WAm/pSBHNymXP6kC0ecdlH2
	XebFJC31tMPkc9jnhb+yVSwFSJzqsCWxX0faL9zL42NdQF5BrHIzMBZ/boOHYnT2pOgxr/nh0TN
	6y8YOKm7ntIA62ztp1moUxGdPnp8U5OrEKF1lJpvWFELq46gMNHRX2zA8I=
X-Google-Smtp-Source: AGHT+IHnB3w+MAZr/zxyA33A3MR+qQnbNJS/dW57uXXoS86XixRDJ9d1eVtcH4/Wxe5TWbCcrgANZg==
X-Received: by 2002:a5d:6d05:0:b0:382:4b80:abdd with SMTP id ffacd0b85a97d-385c6eb6ce2mr11854967f8f.21.1732924310584;
        Fri, 29 Nov 2024 15:51:50 -0800 (PST)
Received: from vamoirid-laptop ([2a04:ee41:82:7577:2250:4c83:a8d5:547])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e32ee381sm506710f8f.76.2024.11.29.15.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 15:51:49 -0800 (PST)
Date: Sat, 30 Nov 2024 00:51:46 +0100
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
	ajarizzo@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] dt-bindings: iio: pressure: bmp085: Add SPI
 interface
Message-ID: <Z0pTkhFJKPf2rBk0@vamoirid-laptop>
References: <20241128232450.313862-1-vassilisamir@gmail.com>
 <20241128232450.313862-2-vassilisamir@gmail.com>
 <tqemkmoa5cewpfxkaltkxj4upgsonjm2br5pwmv7rdmz4gq4vc@2r522tx33gzh>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tqemkmoa5cewpfxkaltkxj4upgsonjm2br5pwmv7rdmz4gq4vc@2r522tx33gzh>

On Fri, Nov 29, 2024 at 08:22:00AM +0100, Krzysztof Kozlowski wrote:
> On Fri, Nov 29, 2024 at 12:24:48AM +0100, Vasileios Amoiridis wrote:
> > @@ -73,6 +77,19 @@ allOf:
> >      then:
> >        properties:
> >          interrupts: false
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          not:
> > +            contains:
> > +              enum:
> 
> You have just two variants in this "not-containts", so invert your
> clause. Easier code.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof
>

Hi Krzysztof,

Thank you very much for the review! I will fix it in the next version.

Cheers,
Vasilis

