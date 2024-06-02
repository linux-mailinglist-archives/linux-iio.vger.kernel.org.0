Return-Path: <linux-iio+bounces-5652-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 838D78D779B
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 21:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 999981C215FE
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 19:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6EE6F2F2;
	Sun,  2 Jun 2024 19:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQV9e79B"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1507262B6;
	Sun,  2 Jun 2024 19:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717356796; cv=none; b=KkvD9InWwwKGQEwZBq03jx6Bsydmp4WOuaTYn+lTfwQWIKyNF687fJB5X4DBaQBinVP1BkXKj4Z2cSEgcH4iyw7alwdfWymlOlwCXtkTIGZWKPcizEhQORo2TxU1F2wgAicqSChqTDJKpG9p3BJMhj/8YWxFbG7tG//hNF++jJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717356796; c=relaxed/simple;
	bh=wDOGJ7K9BvluS0ZmCecLf73yd/zayll+pCe8UWtEHWs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6tySGDTUOuRYl2lxb3ipcRgOCvG2fTzWoBzXIxw7BdWm+UWt1jRt1m3PHw5i2SJSDntTycXe7IsSa3fJobOxnbkLkq44yfGrUONYaZr21OaMpqzEjj+wOiOL+QwtWC7mPQ3YxeoqkBz6ndOikDbagl+vobD1BEgqjI7Bo/Q5gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQV9e79B; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57a23997da3so3689967a12.3;
        Sun, 02 Jun 2024 12:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717356793; x=1717961593; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4eu3W+XFPl+uGV0l2UiAwpofofgTKazncZK8Z33QXGg=;
        b=QQV9e79Bx5S6UKexyH/POi64HOuVcI0pWDk8FM04hSpxkfOWS4TWU7ghePx/wogyDW
         9IUtE2g0Dc56eb2nMgA14u97yohzMxDRnxN2j2RvTgrStHxxzObtE4meQixz1Y6alxuP
         c56VNaz/i1Oz99aUgJdHpt2W/EelwJYtIEbYYs7wPbI8BDZCU0WnYzCcMKCkOhpE/Lo9
         kE1TDI08V8yjcVx5r+UJEklKBAGDRfte//8nawi89Fv4WOhtBGwZiv7UvXgc7HyZpvNw
         pOGTF8q9YVvTAdR9MKyRt4Nzbq0D2j+75jrJtBiLUpTx/Dp1EbJI/rDhWJPzotexN+RD
         HXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717356793; x=1717961593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4eu3W+XFPl+uGV0l2UiAwpofofgTKazncZK8Z33QXGg=;
        b=Mc2Z9PfsNUZ/wbBIJFeqZrXEtz3f7YZiS5RcSq8Jpo7qQhdgBNlFw2sXbZh76ja+Wo
         B/T8s6m98TZHCaNZdgXNp6w1H58wa6v6x2UC8ctDFn9AAL8uZsXshbd1+xmtwP4CV3rZ
         MPT2jud0pbr1iYOCUJBu5PyGolSmGG1sPkE8yUHF0GQXpSEJFDsCtN6cVX6NKh4BFyZH
         6JiauDeLSxR77pXYsVT4UN2IROROOV5nMzWm682EFvWiDKuDQvPy0NafcjvTHu5hJk/r
         BiF3FXOSJ/QZcD5zpF2ZUk8NPUAI3VyhL09Sb38UWgk5APMPmzTDAEMySBhU2zhFhhd6
         2NcQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2mDpxWj7GV120NiRMB0BK2ludv2m2l4VSUV6XkJbTCvtpNJB3qA/8EKTQHNf/fdN84P8FEio9hUxtnoTeGqidDNDvgSorqxSb4G8rwAQmT3cR/s3l9nEHJl2Dow2UL0GPKm8U/cMk
X-Gm-Message-State: AOJu0Yxj9NCg9ukNn93gtLLn25Nd9fvzdy8V5nfSfqyCLNQ3Yb9U4kWT
	DDBKCfSOJLY8bQW3RGE8OWreM2vcZ32hT63+VQFfgllOqDyQFsbn/aEXFw==
X-Google-Smtp-Source: AGHT+IGfkwH5TBggqgdgcMfeie2fbxZbLx5gpKtlV6KFvsicpLqPxGbQ574Rs5Ch3c4Igx8HDnEQSw==
X-Received: by 2002:a50:9ea9:0:b0:57a:1aa8:b4af with SMTP id 4fb4d7f45d1cf-57a3644b1c5mr5325458a12.32.1717356792900;
        Sun, 02 Jun 2024 12:33:12 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:add1:b1ad:7182:3e90])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31be5695sm4174003a12.55.2024.06.02.12.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 12:33:12 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Sun, 2 Jun 2024 21:33:10 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
	himanshujha199640@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 13/17] iio: chemical: bme680: Add read buffers in DMA
 safe region
Message-ID: <20240602193310.GE387181@vamoiridPC>
References: <20240527183805.311501-1-vassilisamir@gmail.com>
 <20240527183805.311501-14-vassilisamir@gmail.com>
 <20240602135908.7e4183a2@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240602135908.7e4183a2@jic23-huawei>

On Sun, Jun 02, 2024 at 01:59:08PM +0100, Jonathan Cameron wrote:
> On Mon, 27 May 2024 20:38:01 +0200
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > Move the buffers that are used in order to read data from the
> > device in a DMA-safe region. Also create defines for the number
> > of bytes that are being read from the device and don't use
> > magic numbers.
> > 
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> 
> Same response as previous.  I don't think it's necessary because
> of the custom regmap implementation.
> 
> My first instinct was the same as yours though!
> 
> Jonathan
> 
> 
Well, even if we end up not needing it, I would keep the values inside
the union just becasue it saves some space, and it keeps all the read
buffers in the same place. What do you think?

Cheers,
Vasilis

