Return-Path: <linux-iio+bounces-10651-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB91D99FED4
	for <lists+linux-iio@lfdr.de>; Wed, 16 Oct 2024 04:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1782C1C23723
	for <lists+linux-iio@lfdr.de>; Wed, 16 Oct 2024 02:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5348B13635C;
	Wed, 16 Oct 2024 02:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CI6dWPbJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7AB21E3A4;
	Wed, 16 Oct 2024 02:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729045923; cv=none; b=jfRFnzf1ii+bWJxF0nMwUpCymLEXLHIxcc9W2E+WcEYyMf7h7ovzOiaF35cJi7hXIB0gpVtXF+I8etRjKO2MCby+3UH25iKJjX0CrpM8nZDdPa4ya/W5EgDEjEGj3BFgS03AKacbn9z4lkVzSXlUsrnawWpKypRq3huJ1e9skHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729045923; c=relaxed/simple;
	bh=WdKr/Pe9elVGEuAnH/DJcmdEOa+a0S/Rw6mJjM8FvQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BaUe3i85sFi0mRpOKToWYz7UJ84XmwWV9P1CI2Po7W8jlzTekiYzLIfsJkbfRgEyjxosvRxLMZPCAZ9c2sFNJXXbB/yfBSKy2vTebXlD+KHCeUYe4GzQwvv2YBkMmewuKQHO0Q3YYEKyvt27QPRAi/M6vyybMY8jIClCfq9JMyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CI6dWPbJ; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b1109e80f8so451823985a.0;
        Tue, 15 Oct 2024 19:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729045920; x=1729650720; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TbHNPH2xdyoZRH9IL6wasUbaGaO506tl4MiXuX23CWg=;
        b=CI6dWPbJsw3/dPimHwKD6i/4mXtH1fL+dvpzkOZelyvx3y+GT5RlJMvjACVl0in3CO
         ICAibo1+bwoUiU2bMPEZHA31K98dEgMZJ4JNdmwPagzgJ65h40tG6zyR0Bd2W5Jhe6gD
         xGIAfHj1VcsNTRJNluycBtlBvNA21GHvQpSgX9ia0GC2ML90Uv2HnyTE1ueSuJP9dkQJ
         c5nONUdM7+c++5NOh1WOZUZbJE+zFrjlzK6FOvgKAFkkmMnj43n3nCMpl6BYDtDcHYAD
         EObmTlU97i5YF8vop0JpQ0JRf6emrea4sL5LC2HVEWe1For0uN5yRaeiKJFx21Cotjx2
         IvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729045920; x=1729650720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TbHNPH2xdyoZRH9IL6wasUbaGaO506tl4MiXuX23CWg=;
        b=DjccIRI9X4AnBVyH+6kiZ6vYxmMSUOPmAN5InBldAD8aINwEFPCX2k5I9/RHcCcq1q
         TFXTa+h+B3gsMsfNgiOM0Z5Lw+tn+2CMEEgw6cS7B1hmk1DIdGantY8//+iE3+1M1aWm
         GTwgoIM9QJRWbwFYu1c5YDdIC2LVLNLB9GSXP6uUUEp37zV/W6Jt22b7zkcdO2eXOuh5
         fvl8016/Pc2lScAf7EGu0BtKZLdBaAWZ6p+8DT/xky3vJzK/BM859asdO6c8gppxP7uc
         dUyFdu+UvXy3DJvEpMduLMm7LCQiNXigS98ZeI4nMh/+voBEF4KVuVsLHtSrYP6nzv/B
         a5+A==
X-Forwarded-Encrypted: i=1; AJvYcCW9YpVjCuWe4CVXy+A2Nxc1M0savs5fBqxYX9RXlUq/3lwYYFm6rPmUuh7x3QNpErJwLGh3r+KZbRY=@vger.kernel.org, AJvYcCX+JaJsJJpgKgeUX6z5qcj2y3/D977428RUf1gLbgkvHeMKhfuNho1qrYrnmxuxT/+dsi5XyNBndqVSvFzM@vger.kernel.org
X-Gm-Message-State: AOJu0YyfgtqgUF1DVfQhC6YqZqzDUntFcc4wLWQS/hXuelXvDSOEfFLx
	mtnQ2l7rButX1eNn3cqwdVUyW71PnhYgnE7elJbxbz/+yonhJTO02sNdhB+G
X-Google-Smtp-Source: AGHT+IGmC0os3v65z8t4rv1mALfIoUsbvsKKP9gV6/XHRwbIuBqtwwz37AJksoKYe9xQf0cgQmm8XA==
X-Received: by 2002:a05:620a:4724:b0:7a9:c333:c559 with SMTP id af79cd13be357-7b121008a92mr1665737985a.48.1729045920375;
        Tue, 15 Oct 2024 19:32:00 -0700 (PDT)
Received: from VM-Arch (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4607b0a68b4sm12673821cf.3.2024.10.15.19.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 19:31:59 -0700 (PDT)
Date: Tue, 15 Oct 2024 22:31:57 -0400
From: Alex Lanzano <lanzano.alex@gmail.com>
To: Yang Li <yang.lee@linux.alibaba.com>
Cc: jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] iio: imu: bmi270: Remove duplicated include in
 bmi270_i2c.c
Message-ID: <v3xzvojyycil7jszgxfnrwjiqxonz6aqrmfs6hgmru7pfuzgyv@3qrbzqo6p5mk>
References: <20241016003919.113306-1-yang.lee@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016003919.113306-1-yang.lee@linux.alibaba.com>

On Wed, Oct 16, 2024 at 08:39:19AM +0800, Yang Li wrote:
> The header files linux/module.h is included twice in bmi270_i2c.c,
> so one inclusion of each can be removed.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=11363
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/iio/imu/bmi270/bmi270_i2c.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/bmi270/bmi270_i2c.c b/drivers/iio/imu/bmi270/bmi270_i2c.c
> index e9025d22d5cc..71cc271cdf30 100644
> --- a/drivers/iio/imu/bmi270/bmi270_i2c.c
> +++ b/drivers/iio/imu/bmi270/bmi270_i2c.c
> @@ -3,7 +3,6 @@
>  #include <linux/module.h>
>  #include <linux/i2c.h>
>  #include <linux/iio/iio.h>
> -#include <linux/module.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/regmap.h>

Good catch!

Minor nit: Should remove the top module.h include instead to keep
alphabetical ordering.

