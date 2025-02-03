Return-Path: <linux-iio+bounces-14948-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C662A263DB
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 20:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E80651883F7A
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 19:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39351DACB1;
	Mon,  3 Feb 2025 19:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncTMX5z8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C347A1482F2;
	Mon,  3 Feb 2025 19:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738611587; cv=none; b=M8ikqXIyG3lK2l9RRq1iZLaRG+KxEjqeMwEYi/zwGKz8eGmf1Z8syL5yROc4/acFOs0OxRZjS+NQHnXh8tEaF8wCNiihHy8bYMrQlqeAyWlWlqvltnMcfTIhxN1Bcu0gsXTHK40KzKKPmCRX01vw+VQpozMyD1a8ouWVUqnMFZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738611587; c=relaxed/simple;
	bh=YB2lnBssnW+/mmFySL8jZ5cGXN9V3iOv57ncbm51pqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZzpS9HOwFzsY2fIAF3IuAXSHoRYTKyThoHef6rcf15HtbhMeRtmgvMTiN3igfacIdRit2YMpRJvyAnKD7AtsXBtVCr8tPGoDO4mVz1PFLbFf9Vs/2AzcLL6aamYEGuxEjn+Zu9/IQj5fS2FCG2M5wJE7e63S/41YbUGjCZEZqes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncTMX5z8; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43625c4a50dso33551855e9.0;
        Mon, 03 Feb 2025 11:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738611584; x=1739216384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e+6yQzsE1m30MzdI6XsO4uT02i7WzvqO5HylPTurSw4=;
        b=ncTMX5z8NvMjN1RMKKZdCHnyKhSj+5u6P3y3oQSL5tLo7uXsMvoQf5Gq3yIzc+jcxH
         4D5x4ZKvOr4QPOcGifgDoXbrQVr9zoj4oMlxpK2NHCVP+A1keFAINUl4Aml6XD5WZMao
         I8U9zblvpXHcGd966zuVB26pnyxxpelgDimJ4CSOXOmYDDZnUvITnNF9dK+U/rmOCpQZ
         2Yi15eB6Q/IGpsu3+CyPCyLCEiigsd4pFqJL6baqSdWKDvEZGpWWtOMs9DvCyQ/cv4LZ
         9Hmvey74xhPnOFZnTdkw1nW9OylJxkJ2dPkKfu52PkwYeU5DA2CT0BinxgcE2/9ikV1H
         DISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738611584; x=1739216384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+6yQzsE1m30MzdI6XsO4uT02i7WzvqO5HylPTurSw4=;
        b=vLAcpI6uFiT2MCLDfq0ODLjkHDdyYukpN5Q7pamOlAEoDVtt1HqMvIRlCEV02S2wjY
         liW9avLOFA/pMBWpbRsOWvp91OkJmzna/BmQDgUn1PNA+4htLz2jXLGPG2sBPxF+kX1c
         WLXXsTiI7BLk0IrtO9fyRMSD1eX8E2oPxYqTl+EJ4dHUCA6X0sECCb44cScK7euBc+/I
         l4I1/9cTKh6ZGED8K5vAa2nfrX9J9mgNGinpgPZxEPlrWpleDfWw+tP4LbJd5LDJyMQP
         KeAL/BCv+3lYqi7KmPWDNzlGhY3iWXJ2BftTe0Q32EqeGqy0tQI13rlC7cVRPVWyOI9n
         zawg==
X-Forwarded-Encrypted: i=1; AJvYcCVo17EsPiVe1eq5mi7bVBnxoOv8g5QjYdV4G8Y9g5aBoZaQTrgHF3c7ylMdYbosvCILFL2XaJY7OViyDzHJ@vger.kernel.org, AJvYcCWy5hdFtaF74jdY25S6FJeDKc/x/ZauEf3hnu6nARt5M8+sCmA5N8JLxVyv574nXZiVo9Eu5h8b2fE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNNuAhsvA8TBAkDrueJ7YZ7ydR726rTJY56J2AJxEHiucQYkVj
	8M4JTGHI+q++oX+toHaOVTDztEqQ/8xYp5JmLlwMGPvbsFfg6zIN
X-Gm-Gg: ASbGncsYS+R8cQm+tkjkVGTXrSxFKtUilujHgu1Hc4c2e1ttPinSbKP/OC4mCDwidTU
	kxlePQGWI1L9Am9q3vMtvYK6oGWAnX0gEUUUZnoXpbSm+JJg/ywXWi6Lik1coeyATkYP24xsDdW
	musNK3x6//DHl/jSdFEJMVbIvufN6++09bQPo2KevjzMzdzICTYYmQ9vvecik6CcX3d+JDrs0GQ
	owfHHJxe9iHS5lA6BPju2hItt4dPiUtX7MkIfpRKuAVm3Dbv44/RsPSaPMroV+twygKqpHMdaQx
	iJD1UIVlqnSLofceFYoVfRBOrju+14KIyDeJJ7Nc7fIzhdYP31+KNQ/kGmp8
X-Google-Smtp-Source: AGHT+IH1sBL5jBVOVps7J5M874KgT6V6Ww2mxh1ryRduaj/BB87Lr/EMkSr1R5mVWbzyjU9Wi65V4w==
X-Received: by 2002:a05:600c:45c5:b0:434:e2ea:fc94 with SMTP id 5b1f17b1804b1-438dc3c3292mr248962075e9.11.1738611583780;
        Mon, 03 Feb 2025 11:39:43 -0800 (PST)
Received: from antoni-VivoBook-ASUSLaptop-X512FAY-K512FA ([78.208.162.249])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c1cfa3dsm13849533f8f.93.2025.02.03.11.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 11:39:43 -0800 (PST)
Date: Mon, 3 Feb 2025 20:39:20 +0100
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: jic23@kernel.org, lars@metafoo.de, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: magnetometer: si7210: fix magnetic field
 measurement scale
Message-ID: <20250203193920.stcb5mhrt4vgmbae@antoni-VivoBook-ASUSLaptop-X512FAY-K512FA>
References: <20250202100709.143411-1-apokusinski01@gmail.com>
 <Z6CLw5h5EwDGanl-@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6CLw5h5EwDGanl-@smile.fi.intel.com>

On Mon, Feb 03, 2025 at 11:26:27AM +0200, Andy Shevchenko wrote:
> On Sun, Feb 02, 2025 at 11:07:10AM +0100, Antoni Pokusinski wrote:
> > Applying the current scale value to the raw magnetic field measurements
> > gives the result in mT.
> > 
> > Fix the scale by increasing it 10 times, so that the final result after
> > applying the scale is in Gauss.
> 
> No objections against this change, just wondering since these are
> the ABI changes (correct?) how should we really handle them in case
> some of the user space stuff already relies on 'bad' values?
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

Just to clarify: yes, this patch makes the output values compliant to
ABI (Documentation/ABI/testing/sysfs-bus-iio). According to the ABI, the
output values for the magnetic field should be in Gauss, but during
the driver development I missed the fact that I return values in mT
instead... (1 Gauss = 0.1mT)

BTW I see that the patch cb29542a178f ("iio: magnetometer: si7210: add
driver for Si7210") is still on the "testing" branch only, so perhaps
it's still not too late to apply the fix?

Kind regards,
Antoni


