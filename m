Return-Path: <linux-iio+bounces-10300-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D306993774
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 21:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95D8C1C237C4
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 19:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CE91DE3A2;
	Mon,  7 Oct 2024 19:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJQMn+7s"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CA91DDC11;
	Mon,  7 Oct 2024 19:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728329750; cv=none; b=NBcyT8sNl+sEJf/ykyjLc3EjUD+cxwl5eXSOY6oaRMzJpRnKhCp9FJe/fHath7npE/1VlRagHH5r/A6uhZb0dOOrUXiaj4CbB2twd5kOFLGHQHJkduN3Sy/O69AoYAAItgxZVf0HRVc1TDKcg+0a4Lai9oijt56MATvQItjKSzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728329750; c=relaxed/simple;
	bh=kWFLwWrcIf/mtTgEjy31aroiIFL3jKyoADoPkk0mT5Q=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CSWLlVZKy8YajsKRBaWuyz8BMG9qvRwvj8IPFyvcbavykoGSygD493fp3YkiNjjvP7kmrIMzNfwiL9lKjkXhmVDcRa4I9mjinW6jo/E+o25izYFdthAxmn28CJEUJzv9jcYyudKQGx0Xdifpj/BxIt047Ku3Yu+11iotHm4Kn+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJQMn+7s; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cafda818aso50046535e9.2;
        Mon, 07 Oct 2024 12:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728329748; x=1728934548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0bheIRjcH4v7VE2ENqH0F2Pl1AX1kVV8vBl4CU3cvNQ=;
        b=iJQMn+7sbZWHGNasF32v5G8xGK95GeyfzEGwcbEi4401cJNcS1P/a+eTI5Sejw5ZhH
         JsOZS+U7wY/ELsbAdOIPvUqXygXSu01R3y4xDFYti9QO2onRgudRrYf4q0aLimAbCxMu
         KJqwOZMHV545+nSOTfIjiT5YsQSD0E/ZCrxeIOyr71cs6Pm5D8TMCvBo3goOMKN8grIs
         i9Jx8Z5NpWk0jt+0sRtsa3x2aHMyEPNV44T3jW93918K9LUi7cHOQiVCcRadWVWqWEuj
         rUfGETMKhJn5ipFnRIFbCKjfGhikC5WpCUykovhytq1/8t9HwoulNHdYt5t4H0gboDxw
         NrAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728329748; x=1728934548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bheIRjcH4v7VE2ENqH0F2Pl1AX1kVV8vBl4CU3cvNQ=;
        b=qq443VxbgZjqMmWj0K3LIAfGaa1GqycqRwn6B9wptVyj4VuiJVsVUWCQ1MkwlP1mfT
         aH5jhTMt3rXSguXgu3O9iDStNPmBCXLVNmSlqAquJaKgUfN0uelV+GEfnt9Vp//5AtsC
         LAjHWaLEK2MJ+bT0Vd2xS9c1vbJfYmfgcK8mvtcRhj9AQPgmRFjbuVuqgJ2BvULuAnP6
         WLViEL279om/NCz0MLkVhZtUSwciUaF1BBIHrzcjeOJpQfGb6eivC5n3FwoYBt8bFI1b
         C+VFw/uyOp9DHFHyba5nWdPNBJuzFasnJdC67MPIyaFN9OgrtZ9kYL7BvK5KcOPgDVjK
         h3FA==
X-Forwarded-Encrypted: i=1; AJvYcCXHr67Spa6g0bgvP5uiYX03ctdjj2KxAqBZe2GcBIGXlDhZR5T8cm6c1VjUmYetdRT6jiKjTwrtEvVlVMGu@vger.kernel.org, AJvYcCXpLyb8ZZQsssczFU4FBQeQL0yQIFMmUZH2IvUTXXH/vjDdvayY2e+DBnxXIirtkteRYyeI8X8UHJI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo3vIkdoXx9XPCcJHeq30qIhvbvTTc5w9rkx3/fQv2uS/b6U3I
	9fxkuETK76vvLbaK81/u34xcjYR6KKUhHF+M8WzPFK3OiyvTpVB2
X-Google-Smtp-Source: AGHT+IG6upGYaHHo24Hk2+tzgPUF/utiefOnGhp8zXryEhAE3VO+BitbA5i/WjhrVNeW9Ub0kQJzQA==
X-Received: by 2002:a05:600c:1d20:b0:42c:c080:7954 with SMTP id 5b1f17b1804b1-42f85aef0c8mr93954645e9.30.1728329747225;
        Mon, 07 Oct 2024 12:35:47 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:b658:eac0:bb05:9042])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89eaabd0sm84397095e9.24.2024.10.07.12.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 12:35:46 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Mon, 7 Oct 2024 21:35:44 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, dan.carpenter@linaro.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] pressure: bmp280: Improve pushing of data to
 buffer
Message-ID: <20241007193544.GA64797@vamoiridPC>
References: <20240930202353.38203-1-vassilisamir@gmail.com>
 <20241006150517.00dada74@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241006150517.00dada74@jic23-huawei>

On Sun, Oct 06, 2024 at 03:05:17PM +0100, Jonathan Cameron wrote:
> On Mon, 30 Sep 2024 22:23:51 +0200
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > Changes in v3:
> > 
> > [PATCH v3 1/2]:
> > 	- Remove fixes tag
> > 
> > [PATCH v3 2/2]:
> > 	- Use internal s32 *chans variable to better visualize what is
> > 	  taking place in the data->sensor_data.
> > 	- Use proper size/alignment to the data->sensor_data.
> > 
> > P.S. After this patchseries is applied, I will rebase this [1] and resend it.
> > 
> > [1]: https://lore.kernel.org/linux-iio/20240914002900.45158-1-vassilisamir@gmail.com/
> Applied to the togreg branch of iio.git and pushed out as testing for all the normal
> boring reasons.
> 
> Thanks,
> Jonathan
> 

Hi Jonathan, thanks a lot!

Cheers,
Vasilis

> > 
> > ---
> > v2: https://lore.kernel.org/linux-iio/20240929112511.100292-1-vassilisamir@gmail.com/
> > v1: https://lore.kernel.org/linux-iio/20240823172017.9028-1-vassilisamir@gmail.com/
> > 
> > Vasileios Amoiridis (2):
> >   iio: pressure: bmp280: Use unsigned type for raw values
> >   iio: pressure: bmp280: Use char instead of s32 for data buffer
> > 
> >  drivers/iio/pressure/bmp280-core.c | 69 +++++++++++++++++++-----------
> >  drivers/iio/pressure/bmp280.h      |  4 +-
> >  2 files changed, 46 insertions(+), 27 deletions(-)
> > 
> 

