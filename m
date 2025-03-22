Return-Path: <linux-iio+bounces-17203-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D85A6CA5E
	for <lists+linux-iio@lfdr.de>; Sat, 22 Mar 2025 14:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EE9C3BD452
	for <lists+linux-iio@lfdr.de>; Sat, 22 Mar 2025 13:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0281621D001;
	Sat, 22 Mar 2025 13:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXmPJwNg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5EA1F9F73;
	Sat, 22 Mar 2025 13:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742650762; cv=none; b=fyAaShkmL8Jlnee15fDycXLdmNYhXyuDrmvVvyW+sfyRb4zYv3ihp4MCQ8884aHO6O0NxrVeRAMEPEq/PJ8qNcrk5TZosPUgRI2cc0TQeCDf0CW3azpuj4Oj8/cHRaGqdc+tOgVDoJYFb+qKrYjzL1rgeG6RL+BOb3/9Td+3u0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742650762; c=relaxed/simple;
	bh=XKIrgqCUqKzr2rLYyevfJSm1vWGqKfiisyvyw/yc950=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHghjAI7QTeGg0RHhMTUHwqnoe5GayOrvQyBSiWXm0kub9kLgWZKnYW/UknlKpyKJ8z2Tk0h/QqB+0dwzMWD7b3V3qbWeyz1vqih3yv3Ellf0PmhXPhiSU/At85WeEaBqOL+anBJ5r2VtsSQ8abG4OnEW5RQV4OMASzRQAVxgmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iXmPJwNg; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-301918a4e1bso3839238a91.1;
        Sat, 22 Mar 2025 06:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742650761; x=1743255561; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P+EUS7u6sE/lUiUTaK0rB8xpgpACxlJdevNW8AvmFBk=;
        b=iXmPJwNg8E4VqgNGgXyFSDw+I0x1mwSOHY5cu3GJBjhRfUMz4rtKQ3mZZIJZU3mGvV
         kb1I1/gCj+BH/VNUbAkZEibJE10GQUPDsV/pKqS8yruc+k4auJVLkxWuYc3Adv1D2o4l
         JzUnYNnh5pCv+s/aksUuIQZFFITz1kPrE37eix8WFL/1JThWuIZXAlgfq4TqCpVOgV78
         HyVx6Kz3nclDwdIjN0vSUAtJSnBYMDkFWVOTGT2GI08h6upx7iPDEUQX3i9kDTmPAXBI
         Gb5KDaxngcd+HaVEDW++vAOzG4QZaD38bxN5RbsYT8WZrcoE5zaaIZRiJBirDxBiUBBV
         OA0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742650761; x=1743255561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+EUS7u6sE/lUiUTaK0rB8xpgpACxlJdevNW8AvmFBk=;
        b=OgNAimGBJavDsLh+NYattrj0a0JuHMy3vsCHPBh9KxnwGyykMmY4bkHH9szlHF+vhe
         i7Nq3gBr4LbN6q7Mb1pJapZu5w7XgESWnBHliDOrlxhjS28wnbWpu4ClFzaGC43Mb4h6
         mJ6zwOYYuCBRXrrH2nw/ee6CQAANC4a2rfD93FTdaGuVA0UUl7LtQcmSglSpJripVUcA
         Yexm7IJ7lPHg8ZDI1PMAovjUc2d0B/PykQOJfvHvT92/yoe9juvLJlCTxlxMVKFiYBy5
         gTv0zCkvWKcHhB/CmGxPQVsMOU9uwJ8Mb4sOoLEK3rHoCG1yBtKgV3D/MHorHU/7Ax6l
         OYSw==
X-Forwarded-Encrypted: i=1; AJvYcCWSYX7wNUgteLoXYNwnkrZFvD0+SgL/W1kVkBEpt1b/gmFdCaq2XNvn5hx8HYztLwad3han2zoJUjfyrMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHDtRnlMjEHyqnl3thWhdErBQ4AL9NiIoYWBdaT887nAhjHTbX
	OuSAwnQ2G49ZlmdBDiGKiP6zqzyFEnTLHxOydVbq/xCsSXDAep+W
X-Gm-Gg: ASbGncthRM5xKfBGKzfaOGtNudstpUGzXapinWi+rHb9rujm0pZURHXIfXwPXllDqKw
	vqpLwtjM608jUpVVjRhNzKTxV8aXOFsc/vrOAhuLZsxyYJJiJdsariuxppGJwyEAYqBdrGd30Tm
	6NZFDJyHC75c2nGz4M3TX31Oea5srUjxQsn91aO4E9icJbNrUBI4M6FLuNoOd8kz9GEFM6rmmSe
	PDG8YNp3QAMShW4FDgabCz6qN3EHa9Eu5H1gBunm7H6hC41HcGbdefoSAuW7DrL3m4POy5ZnK+v
	sVi0IXAOatuw6LizT/lnhBF1bFkWDj1ZT3uulMZeR8W7cBIIfXFs7A==
X-Google-Smtp-Source: AGHT+IGAMRI8qghoQ88hiRYeDKHXI01kQCTBp3E3XmT2HIRI1dnp6VXTaODfyPRS6ZuF/s9XRLJFog==
X-Received: by 2002:a05:6a20:d81b:b0:1f5:67c2:e3e9 with SMTP id adf61e73a8af0-1fe4342cc6emr12058393637.29.1742650760092;
        Sat, 22 Mar 2025 06:39:20 -0700 (PDT)
Received: from localhost ([2804:30c:b31:2d00:277c:5cbe:7f44:752b])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7390615874csm4122480b3a.143.2025.03.22.06.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 06:39:18 -0700 (PDT)
Date: Sat, 22 Mar 2025 10:40:17 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Siddharth Menon <simeddon@gmail.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH] iio: frequency: ad9832: devicetree probing support
Message-ID: <Z969wZRJxMCyVuqy@debian-BULLSEYE-live-builder-AMD64>
References: <20250322081108.202654-1-simeddon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250322081108.202654-1-simeddon@gmail.com>

LGTM, one minor suggestion inline.
With that applied,
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

On 03/22, Siddharth Menon wrote:
> Introduce struct for device match of_device_id
> 
> Suggested-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> Signed-off-by: Siddharth Menon <simeddon@gmail.com>
> ---
>  drivers/staging/iio/frequency/ad9832.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index 9a27acd88926..506478ddede3 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -439,6 +439,13 @@ static int ad9832_probe(struct spi_device *spi)
>  	return devm_iio_device_register(&spi->dev, indio_dev);
>  }
>  
> +static const struct of_device_id ad9832_of_match[] = {
> +	{ .compatible = "adi,ad9832" },
> +	{ .compatible = "adi,ad9835" },
> +	{},
I think Jonathan prefers to have a space separating the null terminator braces.
	{ },

> +};
> +MODULE_DEVICE_TABLE(of, ad9832_of_match);
> +
>  static const struct spi_device_id ad9832_id[] = {
>  	{"ad9832", 0},
>  	{"ad9835", 0},
> @@ -449,6 +456,7 @@ MODULE_DEVICE_TABLE(spi, ad9832_id);
>  static struct spi_driver ad9832_driver = {
>  	.driver = {
>  		.name	= "ad9832",
> +		.of_match_table = ad9832_of_match,
>  	},
>  	.probe		= ad9832_probe,
>  	.id_table	= ad9832_id,
> -- 
> 2.48.1
> 

