Return-Path: <linux-iio+bounces-6903-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8290916CEF
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 17:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8FFE1C21D03
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 15:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBF317106D;
	Tue, 25 Jun 2024 15:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYt2Tlqf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12818170857
	for <linux-iio@vger.kernel.org>; Tue, 25 Jun 2024 15:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719328891; cv=none; b=qnxdcc12kjIK5RHJ0cQnCgAbW00gltERblh9Per4Gt0bZZmmCLD1jAXj4uCMGq7NwNDs3NxT1ajJkzaqU8ii7YWty0KYa/eRGwhApulOpJvU6tKCcQnLRgcZcYn7dHQyEHCkkSgA8YXMnBdSMVChdPYPYg3PdhZsyKBVdk/DsOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719328891; c=relaxed/simple;
	bh=s/QdVyNARVL88VvkXnYNT0ddG7dSt/krP8GiBnv8RnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ssYO67fWN1FGKpebjMJSk1JPIfdn+1SSn+MbsA+RjGE8plff8rvHnQFpqSvgbkFEMQfP6TXilYbH9SvO2cOKreiSp23gQZST/cWC35FiRv6CcJ9ZFQgqXzIFN1DwnBVmCi/LCr7kX/zeZVN7c7Bku8XFIGVzpWj3xg1RNPeQX+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYt2Tlqf; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6fa11ac8695so3310589a34.3
        for <linux-iio@vger.kernel.org>; Tue, 25 Jun 2024 08:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719328889; x=1719933689; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HahF/w32ffXismXCPXAilNQQxCuvIXYry39cFma1exQ=;
        b=fYt2TlqfjHgkmB3E1iSr+IdmIPLx/MFX6iMTOMQ/HG/WbVfVBbxVuk4TeoqZI6wiUg
         DbYXTzBZYpCg58lbLqZd0WgDrvq528no3mRYJ+oD9tkZKV+cp+ngQAH7SviH+6Sue7Vd
         P54ibtGHjgYm4rotPSbAM2wAsO4yMSsSm4c+BzM4mIeqLWYrEqBLFC9dxLn7MMl6+gos
         YkdUPSw6SBeutIAGvvf/dBHQuSyCtmAb5RdegCCUfP5vgvwlp6YYsn0X1eAQln8eKnZE
         b2zRoG9Y9mjh3vnGcm699QwtPCv2MX3YfpgoBk3sEf00Ql6XerJ7Mkx7VafGotwHGQiV
         r/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719328889; x=1719933689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HahF/w32ffXismXCPXAilNQQxCuvIXYry39cFma1exQ=;
        b=iR419/278Ttplh+7Xlr7xs1txxvZCbvj6LBh84owN8KslLfM3/xPnmNclKRrMZrDrh
         K/Q4EJPZLjgukpGwpW6+q3R6W9RmcADVT6Jsfn8Ek1G2kN/55vNdx8l0Ry/Y4WZzL+fV
         SdF41n+KiU2/ZW+ETOXL8XQrDE8jpr397o4FqggCWmtrX+UM6FMsSx9j58hTz+i819rJ
         5aCb6qwm+oGwRlcvA+dHPHc/BaPkSgx5/nuCyLLZcTYrRfxfx6vg0DER4eyohfqAFamv
         7YUnI/KYM95um1XYRQ+xMhXGzag7lwr0ZWBu1hRw9QDHCgz2+E0oQe6Ztyi7xs7qsVSj
         nhpA==
X-Gm-Message-State: AOJu0YyUErjmXmwLIO+xmv/VJDkEMHBbF1sq5Vos+gWtLJcBfmvBOWhp
	0tjiEP8a//86f7KpaQOeWmx+QiM/8bT3ABu9x1FdynmH8jN2eOKQ
X-Google-Smtp-Source: AGHT+IHecqNdQz01XFT4D2crUoYTSiLbrvp6BQYwDr3sp8Ba2+tAdJOg0SfLpb/JwGIkvMSvzilJew==
X-Received: by 2002:a9d:6a54:0:b0:700:cdca:a2d9 with SMTP id 46e09a7af769-700cdcaa509mr424912a34.2.1719328888926;
        Tue, 25 Jun 2024 08:21:28 -0700 (PDT)
Received: from shaak (modemcable063.135-226-192.mc.videotron.ca. [192.226.135.63])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b5223fa509sm42953276d6.51.2024.06.25.08.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 08:21:28 -0700 (PDT)
Date: Tue, 25 Jun 2024 11:21:26 -0400
From: Liam Beguin <liambeguin@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: adc: ltc2309: Fix endian type passed to
 be16_to_cpu()
Message-ID: <20240625152126.GA1271121@shaak>
References: <20240624193210.347434-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624193210.347434-1-jic23@kernel.org>

On Mon, Jun 24, 2024 at 08:32:10PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Picked up by sparse.
> 
> Cc: Liam Beguin <liambeguin@gmail.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Liam Beguin <liambeguin@gmail.com>

> ---
>  drivers/iio/adc/ltc2309.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ltc2309.c b/drivers/iio/adc/ltc2309.c
> index 888a71454070..5f0d947d0615 100644
> --- a/drivers/iio/adc/ltc2309.c
> +++ b/drivers/iio/adc/ltc2309.c
> @@ -103,7 +103,7 @@ static int ltc2309_read_raw_channel(struct ltc2309 *ltc2309,
>  				    unsigned long address, int *val)
>  {
>  	int ret;
> -	u16 buf;
> +	__be16 buf;
>  	u8 din;
>  
>  	din = FIELD_PREP(LTC2309_DIN_CH_MASK, address & 0x0f) |
> -- 
> 2.45.2
> 

