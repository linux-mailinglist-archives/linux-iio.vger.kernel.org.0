Return-Path: <linux-iio+bounces-16454-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0242CA542AC
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 07:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E79E21890CD9
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 06:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605811A00FE;
	Thu,  6 Mar 2025 06:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IknMz/Md"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F96C3B1A2;
	Thu,  6 Mar 2025 06:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741241918; cv=none; b=NoFm/WyLNRbWMaxZX+v0st+ISCC0/MHLQhPE1OpFYXvZVJSWgGfpA5CB1/PE0549N5jknD9uZIH8ZXldTTVjoXwicNCoCPs6LpRKW7ec3lltEJqbhNzAWAXZvELPI8enOfhfmkUTaQ/qTZogBnkWkA+bRkhmsiSfXNeuc0LvRR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741241918; c=relaxed/simple;
	bh=cYptXPy5X+7ifLDzzug9r1UdGIE2gk1bbD05ycCqZ5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRIVCeUy1rNoL1JLFfBkbjABkYm8lTLUt9CElzkIOOMlkkJP83rArC8aJ2zFeMs/qMtRrtM8fHUNvvm2rHncOJKXbnh6SvEaLIXIWlWoMwV3ete3kVLgoUnkTPVAOu+gbLI9wx6ligBs679noqVGFpzO2RL0TUR0SmylaI/WhVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IknMz/Md; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2240b4de12bso5843385ad.2;
        Wed, 05 Mar 2025 22:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741241916; x=1741846716; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p1pDx3clou25vOg1BAeTudGjS9gAt5tIU/BJlqO6TXQ=;
        b=IknMz/MdRk3+nbOEF3GEHsZzUirkS5Id39BzKm1KIDkZubdAz5WakfyPWCNJ4E1+xX
         CEIKktWFwuVVQDN6xF16HV9AZ1J4nISUqUFs6muRipqY1jq3bFXsAMtmnSOI5TKrcXV9
         mEXreKYxJRUzAxo00MXKqtfcJ964Cjz4ig3ejk6hW50DP9+UOyuj0We4M38gqvMtJ2sg
         P5nSeAjBYEj71wipXoMYGEVH/NvwUhs95JWtDw+1XY8XFZmYzHTTQsrA2MDmXKRoWNMZ
         2jnOcaf9K2YMhreRWsxKJxrIy4Iy6jEMMxenpKNMzU0QYk4NBBxPHXYj41rdLD+lb76Z
         bRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741241916; x=1741846716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1pDx3clou25vOg1BAeTudGjS9gAt5tIU/BJlqO6TXQ=;
        b=vX3CwNdbWax26lfwBZMaLNsdu29Trqg2ZUQ8CnNT7Xy+q+Gcz+8H30NjXAOLFBKhEd
         TPEqtvwx981KZdn1dSDDb5lbZpSv1WPz8j5t5gmQE8OgvhbKFGj9XuMJjUpdy6sx9oOn
         nq3VVzueqXT2hGzw91+hTWTxe2c/qUyHmzCJ9Qrh21wn+c9WS7xuxZ0+JJ8ViZenzU6d
         ZVRM8E8ioJ5eUxvxtU73QushVOyNROUNqOyJF39KQ+QDz+Z0+ZNCcB9T0a4ZyoLidecl
         uBBu5KfNfQRs/GXBUqI6CeUx5nvwpY4JfIawam+9TD5CxCCpjuOAiVKJF0XeDaVmD/yz
         vDgA==
X-Forwarded-Encrypted: i=1; AJvYcCUr/dkbwzKf6U2HnGtBd28oeNyVbL8T4SxHIE+9WKY3W0gD3ZO1l9XHj7nsBUVx2mHxBjSdlF7Uz0jCoS4c@vger.kernel.org, AJvYcCWr7BMPKHkroe8FiLuv4IIUxubfvqs1gv1TLmMEfyDShy2gJJSo89BYT1rUM8HhiOTBg6MPHP4UdUc=@vger.kernel.org, AJvYcCXe+DNHkRROSZX/GaMHwRWsdMgpIqNYOdpC6hUT+TV7ZhSC99dMjkrjEDrXbf4sM6/2h3ZjWy1HCTgcF7YnhOV1esE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL9dkX89xfoqBFAw8SLifUZB9nmJDYVhLze61xT2CYGtf6yXyo
	79iLKMBmx+XB6VSV1M+GcByG7XlzZ3GB7FJOV/gA11OHBAeyo5n5
X-Gm-Gg: ASbGncu8gEujNAoAglw3ZXs4XvC+zmtGqsDv9zJeGk0FdfY//3umPrugmMWUcdhsM9I
	PrxRh8QhwOCqDxMjDw9x6SCMcjhq/nadYp7mi2ZWhPb0xVUHsY3BKWmW6rUYe3mq76Qom1hNlce
	3N5tfLfmZBKSllvPmDxU7GRgYfqzqAISTD2JHpTEE31I95xDtZ6D2JfejspFJZ+67p0O9rf4g8b
	SvP42X/NtJOxEJqwmSV7BePVnawZ5fItt2g8hXZ+dlgmRr3TzYxC4vfnj7BrOSph1ScrEOucVPu
	QtBXnMhnDyfJ+FuJb7oQY8XsCqEMRSxF0W9vWpIrfhP9oQ==
X-Google-Smtp-Source: AGHT+IGUx+NT37Eom6rOUXlToD8lMehbcU/9o1mF2Cw2MPQNIaBYdlf+wBjth1S4mex8R3KADOw0xA==
X-Received: by 2002:a17:902:ecc1:b0:21f:3e2d:7d36 with SMTP id d9443c01a7336-223f1c79695mr84953375ad.1.1741241915686;
        Wed, 05 Mar 2025 22:18:35 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:423c:abab:b1b0:64e8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736982440d0sm519698b3a.59.2025.03.05.22.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 22:18:35 -0800 (PST)
Date: Wed, 5 Mar 2025 22:18:32 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Claudiu <claudiu.beznea@tuxon.dev>,
	prabhakar.mahadev-lad.rj@bp.renesas.com, lars@metafoo.de,
	linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH v3 1/2] iio: adc: rzg2l_adc: Open a devres group
Message-ID: <Z8k-OHsYvARkf3Rt@google.com>
References: <20250224120608.1769039-1-claudiu.beznea.uj@bp.renesas.com>
 <20250224120608.1769039-2-claudiu.beznea.uj@bp.renesas.com>
 <20250305142122.626336c3@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305142122.626336c3@jic23-huawei>

On Wed, Mar 05, 2025 at 02:21:22PM +0000, Jonathan Cameron wrote:
> On Mon, 24 Feb 2025 14:06:06 +0200
> Claudiu <claudiu.beznea@tuxon.dev> wrote:
> 
> > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > 
> > On all systems where the rzg2l_adc driver is used, the ADC clocks are part
> > of a PM domain. The code that implements the PM domains support is in
> > drivers/clk/renesas/rzg2l-cpg.c, the functions of interest for this commit
> > being rzg2l_cpg_attach_dev() and rzg2l_cpg_deattach_dev(). The PM
> > domains support is registered with GENPD_FLAG_PM_CLK which, according to
> > the documentation, instructs genpd to use the PM clk framework while
> > powering on/off attached devices.
> > 
> > During probe, the ADC device is attached to the PM domain
> > controlling the ADC clocks. Similarly, during removal, the ADC device is
> > detached from the PM domain.
> > 
> > The detachment call stack is as follows:
> > 
> > device_driver_detach() ->
> >   device_release_driver_internal() ->
> >     __device_release_driver() ->
> >       device_remove() ->
> >         platform_remove() ->
> >           dev_pm_domain_detach()
> > 
> > During driver unbind, after the ADC device is detached from its PM domain,
> > the device_unbind_cleanup() function is called, which subsequently invokes
> > devres_release_all(). This function handles devres resource cleanup.
> > 
> > If runtime PM is enabled via devm_pm_runtime_enable(), the cleanup process
> > triggers the action or reset function for disabling runtime PM. This
> > function is pm_runtime_disable_action(), which leads to the following call
> > stack of interest when called:
> > 
> > pm_runtime_disable_action() ->
> >   pm_runtime_dont_use_autosuspend() ->
> >     __pm_runtime_use_autosuspend() ->
> >       update_autosuspend() ->
> >         rpm_idle()
> > 
> > The rpm_idle() function attempts to runtime resume the ADC device. However,
> > at the point it is called, the ADC device is no longer part of the PM
> > domain (which manages the ADC clocks). Since the rzg2l_adc runtime PM
> > APIs directly modifies hardware registers, the
> > rzg2l_adc_pm_runtime_resume() function is invoked without the ADC clocks
> > being enabled. This is because the PM domain no longer resumes along with
> > the ADC device. As a result, this leads to system aborts.
> > 
> > Open a devres group in the driver probe and release it in the driver
> > remove. This ensures the runtime PM is disabled (though the devres group)
> > after the rzg2l_adc_remove() finishes its execution avoiding the described
> > scenario.
> > 
> > Fixes: 89ee8174e8c8 ("iio: adc: rzg2l_adc: Simplify the runtime PM code")
> > Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> +CC Greg KH given the in driver suggestion was his and I think
> this discussion is not necessarily over!  Also Dmitry for his info.

So let's ignore this specific driver. We know that at the moment
platform_remove() calls dev_pm_domain_detach() without waiting for
drivers to release their devm-managed resources. This means that devices
are potentially powered down and unresponsive when devm release handlers
are run. This behavior affects _all_ platform drivers using devm APIs.

We should not and can not go and require a fix to each individual
driver. This has to be solved at bus level. We have much fewer buses
than devices.

Driver core might supply helpers, but not all buses need this and like I
mentioned elsewhere buses themselves may want to switch to devm APIs for
their resources.

Thanks.

-- 
Dmitry

