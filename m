Return-Path: <linux-iio+bounces-7771-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EC5938603
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jul 2024 21:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17E9EB20BF4
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jul 2024 19:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CAB16A95B;
	Sun, 21 Jul 2024 19:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4gW2CGO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FA1168489;
	Sun, 21 Jul 2024 19:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721591506; cv=none; b=CRoMMAYcEdDIlnUi3+RkbmcnQQ+EN4WxGDSAs64E56jCL1xWKSKkmPEY7XeILzE2380J0/xEWE1boNA8KFDvR5BiE6jT0BUTuWYrv2fY061fCU+a1kX/d7q8B2lEBT2CSh5PwxcQy/5Ba+3AdLoxPPsaAjg/Rrh8vNCycBNLd9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721591506; c=relaxed/simple;
	bh=ojnD7l7U4WXhnJ21gEjURp81rgMITCfE9m6Uir1OCRo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPD5BmIhehh1NY+pJKP/34V2PowUwrmtdswBaBBQ8n5mu6dAht2L14qdKdjUh26RW3E2iNHt/4CTxiA1N+7LxjgukOYzRV6E7xwN4fdZFzEaH8grRHKYpqcQiedQIuTwRez4ZwOa6w6PlQrMvDDEPAar0jQj8QY7wdYW5sPMnfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4gW2CGO; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5a3b866ebc9so1756450a12.3;
        Sun, 21 Jul 2024 12:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721591503; x=1722196303; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OXhJvxTh+FJgkdIwlUcd/DX9E13ffHM6KEgpQ3vYsc4=;
        b=i4gW2CGOlQLSW4YbeRqaHZGECsat6WKbhtIH21w0aiZdjV29AKJlMOHvKdLzuOZu5C
         M/RyMo+lBAgt/dN5rAa03gH0/Xa/5VEKuZdrCfCCB3kRLfWVe3jSLJ5FJTRuwjD2sD3x
         BGZgb3YqKtl9FVlB019v2AbsUl5ajoR71jasJED9vkgSJN7QzpQHwrzwnNqB5z0sIuU+
         n/FGnudDdNjENU0V14hX5ROijiVtAERAuGZjU+OslLCppocdHGCNi37oq3XU0KE36+9b
         VYrQbXo/TrSvBNH4lwkDrXJYGcAVbsRhQD+cjzffYNwEz54/JRgL9roQOk+rU44iDvBC
         JcYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721591503; x=1722196303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OXhJvxTh+FJgkdIwlUcd/DX9E13ffHM6KEgpQ3vYsc4=;
        b=GQ+4t2YxQ45YwOPWGE6RFGQlsgFC0mzT5XlFhNp1IgzaJNP84oVYBWerjeyGqnvDc4
         U9SlszOlNLvMjfX7tusGwlY3A/k63WyQQfvTEC6SwogdIDkYYHUcmnwhuOAqYl0T9yod
         ullCrURbTrTXJ4sP9wnVMYoPPjSHfGHXcLLDoB6Ieu5JebSjn7kKl5bVbLEKvXUw50a7
         UZN/fk4m6paaFt5X01Vj7uTuC3OR9QNbNaZzUyUB3xTWu95tIUI4fS8LZXaKbpap6gYX
         tdwvgEfX76QsF/+wIlU/eOUM7BiO9a55q32611NtDmeBi7hX7zj2xjKDW78MH2fXfloe
         dXRg==
X-Forwarded-Encrypted: i=1; AJvYcCXIEggjbNpI0x7Thuw34BmtsQnqZ6ZSWxHTtUTJ3vHxUMi9Pwa2zJ+6nQN4YhMkw+2f9FEpsxhQ7sYUty1Q3zRCIw4a6nNcVlwzrYD5mSoHwWNHFFCNmYdkk3t5qJGwqvWuZRlbgnFl7c4T0YmR7r85RjD2vAjOmGtuEDsHxSAzi5ejwQ==
X-Gm-Message-State: AOJu0YzymlAf+q51Hzc+iDM2C27Cpj+Axptxi18k7JBkfeLTMs5VCCl+
	cpOxyEXVVQujmtNuZ3YXoNiGdUl0aep2q3J5IzxtKfX2sVcjFf26
X-Google-Smtp-Source: AGHT+IHBeqZ9eTSz0bR9gAKqLV6LP7oKJq2WEwJizcoWMFJtTzi9WLC2fIcSpqdgq0NvFVRH+UkYIA==
X-Received: by 2002:a05:6402:528c:b0:5a2:1693:1a2e with SMTP id 4fb4d7f45d1cf-5a479871105mr3211157a12.18.1721591503002;
        Sun, 21 Jul 2024 12:51:43 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:bc21:fb27:f4e6:6867])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30c2f8645sm4909057a12.72.2024.07.21.12.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 12:51:42 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Sun, 21 Jul 2024 21:51:40 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 01/10] iio: pressure: bmp280: Fix regmap for BMP280
 device
Message-ID: <20240721195140.GA325365@vamoiridPC>
References: <20240711211558.106327-1-vassilisamir@gmail.com>
 <20240711211558.106327-2-vassilisamir@gmail.com>
 <20240720120429.46aea886@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240720120429.46aea886@jic23-huawei>

On Sat, Jul 20, 2024 at 12:04:29PM +0100, Jonathan Cameron wrote:
> On Thu, 11 Jul 2024 23:15:49 +0200
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > Up to now, the BMP280 device is using the regmap of the BME280 which
> > has registers that exist only in the BME280 device.
> > 
> > Fixes: 14e8015f8569 ("iio: pressure: bmp280: split driver in logical parts")
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> This fix is for an ancient issue (2016) so I'm not going to rush it in
> but will mark it for stable inclusion.  Advantage of taking this through
> the main tree is we can move faster with the rest of the series.
> So applied to the testing branch of iio.git which will be rebase on rc1
> when available and become togreg for this cycle.
> 
> Thanks,
> 
> Jonathan
> 
> 

Hi Jonathan,

No problem at all! Yes indeed it's an old fix and I am in no rush at all
so th simpler the better :)

Cheers,
Vasilis

