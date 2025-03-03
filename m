Return-Path: <linux-iio+bounces-16249-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01133A4B75D
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 06:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ED0816C0EE
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 05:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5361B85FD;
	Mon,  3 Mar 2025 05:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxaukFGG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB52AD27;
	Mon,  3 Mar 2025 05:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740978281; cv=none; b=QqbPcf3nP7uRcQe1KoR1t50sBI5x124m7N1YoyzGDgmVKlTzzf6vwuk95eLK0f/Okzxg81RijNkEyk5txpd81LWcPI+aGPWjSpvVdcKoKKZ1hEwPWigZqqV7KLPtboocmUxlptAoiI+Hgr5fxyzKNj2d8IspiN7YPpq+n7JbqUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740978281; c=relaxed/simple;
	bh=ak2JvtkXpdCXNdZWrJpngnDwqqTP4VAWI8V98k0pKL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCsKuTZF5w7ZWd4op+eLLBH+NblPIBpcHXfa1DSMWe8CN32M5tIOet1O2GKCrqu6QeTbPCGJ9YFzQQbtta/P605A8rdXAplnwfDL7fMiqKsnhKeIbTbk5NBtzmy5P3AGEKhiV+HVaXCsSolKEyyoXHThX0Rg557iTWyfZ6Bg6PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NxaukFGG; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-223594b3c6dso65116655ad.2;
        Sun, 02 Mar 2025 21:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740978279; x=1741583079; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0MpZ1k7dX/F+Pw+v841rvHm+uxj93+81TQIaphP5Kq8=;
        b=NxaukFGGoHvO1DNLp8egEwqfppBVxnVDUI0vJ0CC76djtoMdpGLSeyn+n9oX0iR7OE
         IuUybPX3ahuhlaWCutSmX7uNmXB9ZZxL0VNJwDhwxFRauuv0Dz3q3vs7hD+rdZCm0At9
         jQbrIhQed/N1b9KZhN69sGoZhNhsBwBB/S7/sY/rCwU758et/7FRGnKrnsHZmsRbM8+N
         Mxt/uUKYZoRQMSVyBcbTiopnUhNZ9m+Vb2neNCx/gmszmTfmullsXy1Dwk/yqZCyAjEv
         ZAEdOMMMvP48fwiBq0+cB9zKWYsm7LCcxkxSfYaRsQpTQVLjz0aJp7g9TsadWxE5je+w
         YX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740978279; x=1741583079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0MpZ1k7dX/F+Pw+v841rvHm+uxj93+81TQIaphP5Kq8=;
        b=s9XBwG6FdQ7LjnqR/TeU0w3CK6Bj4ggSnAejHrnSUDQ5ie7/GXXHroLr4n6ZKy17Fw
         4/2bkUKYMte/nkdy42g1oQZlC0F7D4wiTND0jPakB7JO8ggTh3X5LjfhIBD7Jo4ZsHHR
         c4kfEi+tO6+054Oz/FnmyTj2F4LrZrKkfag907EX+1SvEpkrR2ljl2eGfLYY/QYJgZme
         s7kPm/5bmbTPDJ2dTVnVKuWanLmIZH2pNYBlYnwj7u4yCUb3Ybzkm2yEFgWM7rZc7gxH
         9Taw8Wl3T9+h3obuHc3NEH+JJ6OqWPHTuKcNMMejEFJbawkbsM3H1kIiQopAKrLajl7C
         FWqg==
X-Forwarded-Encrypted: i=1; AJvYcCVNa74SfDYUsTyF6clF5aq6xokqHeoUbTgoWLwZXLCqyjA+ueZ/B0cCKldpqGro9u//4ekVBYgW0RU=@vger.kernel.org, AJvYcCXhTPYS4WvZEhORcjdtV4lF0kLcurSbm9KC9auSvT4RtZa3nCUGQIgrO3IW13eq+0nGM2TUc5u6nrBFyO5D@vger.kernel.org
X-Gm-Message-State: AOJu0YyR0XdRVEsEf4sSWU+P8eeyhKvSRJM6wAGrRm09AFBZX/PSEqK1
	G8JJjX94uJ5El0GWOgqnaDgWcr/lqPdGBEApLigNJ1IVE5XIwCiPtkGYf+RBnXY=
X-Gm-Gg: ASbGncuzvlXIF6m4aPYMaDR5p3rfYrLqig4CQ/vy6oD1UoE/pNGeeTJzS43gDQqg4pX
	Cjes+dyR9v3mpV/SaxU1MulPnPWyhuRGhcev5Lym4/7zRvMCxvJ/HWZ0x4EoEibToOFZUj6uXG4
	w3MsdzJPZUggauUQuIsYQ+YQPlP2sEplD8cmX2WmBBlUfT6nU2HKwbZCjdrx0hUPQJb+Toc9RYI
	2lXpo1vth33jiQ797K2xVK6cywt+OErNlF9gGmlnYVQPrEg4OijYpdseaDw7FlXtdGMv49P8Msv
	vpG2Xskdyv1DBjrdLPUbkTccRDrwoMdCLY7YpnsX6LBjfn4DZkb8amU=
X-Google-Smtp-Source: AGHT+IGeK/uCwqTgR67WHW8NRryne9Z9hLT8og2opBdBcEq55fkcfoQND4y+Y5hAsll/xewqqucAhg==
X-Received: by 2002:a17:903:3ba5:b0:223:37ec:63d3 with SMTP id d9443c01a7336-22368fa903fmr144894375ad.18.1740978278852;
        Sun, 02 Mar 2025 21:04:38 -0800 (PST)
Received: from localhost ([2804:30c:1f21:4300:1cf6:c485:6555:b1c5])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73652cdcd1bsm1291152b3a.97.2025.03.02.21.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 21:04:38 -0800 (PST)
Date: Mon, 3 Mar 2025 02:05:30 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Saalim Quadri <danascape@gmail.com>
Cc: marcelo.schmitt@analog.com, dragos.bogdan@analog.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: GSoC Proposal 2025
Message-ID: <Z8U4mr1vO-TWz91c@debian-BULLSEYE-live-builder-AMD64>
References: <20250228113304.63160-1-danascape@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228113304.63160-1-danascape@gmail.com>

Hello Saalim,

On 02/28, Saalim Quadri wrote:
> Hi everyone, I am Saalim Quadri an undergrad student at Dayananda Sagar College of Engineering, pursuing Electronics and Communications.
> I wish to participate in the GSoC 2025 as a part of the Linux Foundation, IIO Project.
> 
> I have been contributing to the Linux Kernel and have more than 10 accepted patches.
> I have also worked with Android Linux Ecosystem in the past years, and have worked on several subsystems, backports and fixes.
> 
> I started looking into https://wiki.linuxfoundation.org/gsoc/2025-gsoc-iio-driver and Analog Devices Inc. and I am interested in writing
> the driver for ADE9113 ADC.
> 
> In that sense, I would like to know if anyone in the IIO community could provide with some suggestions for my proposal, and a positive impact.
> Any suggestion or hint is appreciated!

Well, aside from the "Tips for writing a good proposal" section in the project's
page, I would also consider Jonathan's comments on previous proposals [1].

If you are looking for a task list, see kernelnewbies IIO tasks page [2] and
some suggested changes for IIO staging drivers [3].


[1] https://lore.kernel.org/linux-iio/20240326185207.20f8987e@jic23-huawei/
[2] https://kernelnewbies.org/IIO_tasks
[3] https://lore.kernel.org/linux-iio/Z8U0lsntJpTuBzyT@debian-BULLSEYE-live-builder-AMD64/

Regards,
Marcelo

