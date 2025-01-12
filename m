Return-Path: <linux-iio+bounces-14152-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE672A0A6FE
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 03:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 696D7168483
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 02:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F69EE57D;
	Sun, 12 Jan 2025 02:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KU37AYEz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1DDBA3F;
	Sun, 12 Jan 2025 02:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736649456; cv=none; b=JQRYsDrzJSp2br3+ikUg7IsS2OEchgvPd6FfodXE2DrMg21d7H5FhEbnf8hLHB8Pv6SK7gOIqq8dM3Yp3WZ6y/UTLJiMxPWD1bGmFTg3d0cRmHqi6bByTQbv43wSpvWvRhtfGkxo073wP0qYVQt0rvAQwh1L1Ly/YwQmtwXImMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736649456; c=relaxed/simple;
	bh=RegtYUcZK3ZSUTHIVQ1/YKPKGfVNOsvuWKc+hS7R/Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mu8eVcLkYK7sboy7ch6KjaKhLP5blacC1ulJsKU9Enq3opzWWktNgTQfWkdEaWoHzKLv4fVIhJq816UBzuliukg+6s7xgKFZSIrHkJ6rVG5SmIS8v/pvLK+K6ZoqGXgLAUZIq/FrFI2tN5jqzFkLIuS3LdLwgcJffRLeqPJThrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KU37AYEz; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3eb9b58fbb5so335965b6e.2;
        Sat, 11 Jan 2025 18:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736649454; x=1737254254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQrcWbVrMJH+R7BYMJfx6l5KCb+efH/j3dR73uz/eVA=;
        b=KU37AYEzzV6IiPIb1+AgXPvr3T6LMfFjnhQMxqYbVzGVkdeCBOvhjv6Oyw+DJvCB9v
         TybUYpYEV8Cbl4k2vnEk4xpW/UTVJ1k6TouqORhkiskwzCenM+gHlyXQXMWiNpf4BsoD
         hEb9+08hagQD4KJPzXM46hYfS1oOBek5tG7vIBrW9kD3JFIoRWLqVsnAfgqB8sGSO2ej
         BvGWYdpmaknj6Wf8n8ofWzsImws7QhX3H228BpWJ1VRYQ0RpUl1XJ5wJH4R1v0+qK77e
         jKeM6D8KR0hQVOooJU90rj+IU5Yc/6J082ihW3UwkQa65VWw6dBDEdv64lJ2S4E4mwk+
         Ca9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736649454; x=1737254254;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQrcWbVrMJH+R7BYMJfx6l5KCb+efH/j3dR73uz/eVA=;
        b=mzl+QIidLJOvfJMv5CVKpEQVUULEbkBN2orO+wpYgOOm6+a72qK3OpoE2yMj8Tu7XG
         ACvb0kFyY8m7HO7doHvb7ILRodFVUSrSVKUmfei20Dxp0Q5/VuLFyRwg+nIa07txlu/0
         zU3J2lCeV4p713129cUiBcxoE+9wR/xf15FtkrXdD0ui+CjD+q6RuvFXM7wWbYWnUNgB
         W/zYTMacvwGolcsYBoqCKQym4BkvJoQ9RPk9XMFI1brcAqflYNVlSLatwcTGsMG7B/tr
         F9wAxf9UaaFBqnzKqs1zlCs+O/yVZlopYrvJcnKaDAT98Cf5tULdj3NxY45o8wK8cB1q
         1heA==
X-Forwarded-Encrypted: i=1; AJvYcCUmDIw9xdcrYiAjhlj6WqtN0Z2/uGCOQFP8unNEXN6QhJ1r5yYZkx/QtEi0vH7kRaqQLA3AsFwsYCjOC0Ln@vger.kernel.org, AJvYcCUxQDYEyNp/qLgkvkCenBvSotZTy/92mjTzw6j4NlEHVSCDmZ0Jl/dM5iGxJroi9VIosRuMul8xW6Hy@vger.kernel.org, AJvYcCXaj4MS/c1m1f0HvBZbE+WCFZBfOjmshxQr06C5cQdGC/xmONxfAsP0053gCnFFVZCPSzJlzzuOydb1@vger.kernel.org
X-Gm-Message-State: AOJu0YyO7Y52GWTFnMFKR41MgDAP5H493G9PujJZwW5M0KzbG5RyGPzt
	gEC0b2JLG4XNIiWTOu4B1XkULpl0V/Fbac+mVVdZOq1mS6Gx6qLN
X-Gm-Gg: ASbGncvDvghDwbuF3WSz04rQb6SHsR+UaI7eKzFXd4fd25RVE8iqvOH0fO+5d8Gl0wR
	lwF/OUPdtMivPSI+/AIPqXMy79rhov3+fHviWBEvgT3931Cx/yPUCSfWoUHKQ6n5eoFMSm5AiOL
	Zv4/PpniB4wlmZVjxw88pmTmmZgy+Tj6Lz/cSWTpku8FJ21Hzv5Q45+G/KFyxy1R9HAbwI1qQ01
	HoJ+lVRAjPgQAT54RsTT3N6SAMjXHOR4nBLtgpDSdcdc8iVaGSX1ZUJ+Vc2h2tkmiVdcSzxiW/T
	VQ==
X-Google-Smtp-Source: AGHT+IEQ1Bgxf3jAFAlZen7PhCfYe9sXociBSjNUi4zyvlTYaGB1j6DCnbrLpnAORc1G1gLqSHNNrw==
X-Received: by 2002:a05:6871:6503:b0:29e:6394:fd47 with SMTP id 586e51a60fabf-2aa06696be6mr2896254fac.4.1736649453674;
        Sat, 11 Jan 2025 18:37:33 -0800 (PST)
Received: from JSANTO12-L01.ad.analog.com ([189.121.203.94])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5f882756626sm2114397eaf.30.2025.01.11.18.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 18:37:32 -0800 (PST)
Date: Sat, 11 Jan 2025 23:37:29 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v1 10/15] iio: adc: ad7768-1: Add support for variable VCM
Message-ID: <Z4Mq6RBLWFZuf2Be@JSANTO12-L01.ad.analog.com>
Reply-To: 61060bc2-6450-4309-8e57-3d1bb32d3ab6@baylibre.com
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
 <a6999fc24a4c61498e55f23861997382df2ab4f4.1736201898.git.Jonathan.Santos@analog.com>
 <61060bc2-6450-4309-8e57-3d1bb32d3ab6@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61060bc2-6450-4309-8e57-3d1bb32d3ab6@baylibre.com>

On 01/07, David Lechner wrote:
> On 1/7/25 9:26 AM, Jonathan Santos wrote:
> > From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> > 
> > The VCM output voltage can be used as a common-mode voltage within the
> > amplifier preconditioning circuits external to the AD7768-1.
> > 
> > This change exports the VCM as an iio attribute and makes it available
> > for configuration.
> 
> We model common mode voltage inputs as a regulator consumer (e.g. vcm-supply in
> DT), so should we make this a regulator provider instead?
> 
> It could be used with "regulator-output" to be able to control it from sysfs
> or if the amplifier ends up in the devicetree for other reasons, the amplifier
> driver could control the regulator instead of requiring it to by done in sysfs.
>

Ok, that is an interesting approach, I will try this. It makes sense to
have it in the devicetree. 

