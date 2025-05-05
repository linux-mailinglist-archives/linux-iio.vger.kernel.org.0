Return-Path: <linux-iio+bounces-19087-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C31BAA921D
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 13:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 868BF3A6B7C
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 11:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2632A202C3E;
	Mon,  5 May 2025 11:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="m9HGVmni"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194E31F948
	for <linux-iio@vger.kernel.org>; Mon,  5 May 2025 11:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746444980; cv=none; b=kPmUAFsa1TryRWFGHHNE589NthFaRlqWeMweZrx47HIlV7WujAngTJHbeo/HSx5alnFQjhOA++i4f2ZKfF4LuF6EDsqw5g+l1kao3GFtU1/ccI3W4oU8PLD4d+q23NZAi04og9A51vXzgWlQAPecUNaJveBhcSCnUMtpek3TQqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746444980; c=relaxed/simple;
	bh=6+6LzI3cPXZGRevprqXsbs7mizaq+xNCap1FqHvXGZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sxDf0g+NyJe6jvGKYaO+xKhvCugE8jqY6R5PQS1VXlA0ETKq0kzdsIuhNO/6YVlE3SPTaOB/xhlsB12ugMbYPtgPBZSwsul62E7sheKsfnr7IEL7z3IT9fqJ9RN7SV3Kyd3GkY1l7J5uiXgr7GL2Dw2X1SZaE74FV2ysFJej6Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=m9HGVmni; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-39141ffa9fcso4604492f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 05 May 2025 04:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746444977; x=1747049777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XEN+uxzlpyNm2pKAMi5M1wIDfAZkX7ftsbauAryH7ng=;
        b=m9HGVmniMu8VW1vQ7IUGPl0f9fUgEzdi5gyyuIVzmWM3nd8PEFYs8gel47P8COmuo5
         /dxAsFiWy24c2pGeCDQIhuJJrUbESGlorTgtlbx6fCNa3oV6ug/WLGA9c6S60sPN6IrT
         GL9pwtiMTUIMDwr0sPL8a1JWft5P5ASNovSykcnpMuAqPQUQ1vp4w/gDNT/8ALZXnTBy
         akAa2otCOJfkYgTr85EBjqZgzN8sjmjGxVdhFSAccUFWAsm1/S+iEIM8vIkQ0vXX128q
         n638GvKOKUYnGQN8TVLLOoaoDQZN3PTQMIyiDJjKUiM/95deU/ayGnAD7972u2G8UXmE
         +qLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746444977; x=1747049777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XEN+uxzlpyNm2pKAMi5M1wIDfAZkX7ftsbauAryH7ng=;
        b=eKBBougGSvF+UWNFj9XmA7/czufLC9+GLU9kt1d7o38j2MxiNK2MHn3M/pEZl/LOl2
         uJGK2+6UH5aI3us0b/9VCK9M5gxjSmg0tYaEZAuLAosX7oVhBbfi6PSjKaOmndo3LupC
         kqbQsspAji+bNjx5+jKPFAQhrJnckejYzdsp8uHvkLQxBVIPjY7eMxVaYatRcR/6lVu0
         aNd3gK2tOt+UlI2yQRvhh4XSq9MX0oFNrfXqokTH15OadIxeA2rDU3kvQSW/7aBoF854
         6JzKFr6J8qGJ0rhX9AbIAeBx6pwRCWozv/KXT+hvjhqseaB3d+wyExPiLtWiJRS01WtN
         RD2g==
X-Forwarded-Encrypted: i=1; AJvYcCVK8jjJSRkOv5hcYfSj+0p/kRDE8er40m6uALpOXYQINy19kCmc/xDxwPiho9Ljk4IDkUwFu+F9TzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkFNIWMEXGd3jOK6S3HOC77tgZEQ5SPlAj5h7wv2QkDwtmqz8t
	Pw+5EyFa8njVI4JFsqYdlaGvACvAQ2i+04KjZ1+vCHeOba4+IvXIQSzCt059nSU=
X-Gm-Gg: ASbGncugiBBo6boqqiIj8qagTbKLwcJoHIb84xlXWnPYbMp4IykAwzdjAznaNuDvGTB
	VHg7ia/ddUioCmnXopvqWBldirVE/vHakamHh3EjARBjw1DWf36/ZaDLcpHUwLarjvDJXkAkhSK
	Pacw1Y3yejHjzk1rrrkAx9DjX7j553eivebqZKyvQ41/6PnUgxvuLFZtmmDEvA2t4umoisBYKom
	boMxR24arslHrsZpPIGb1cd9tepQP27rJr7Xm8wJ9rAKWsbyGHnFYvCToyDJH20+z471XQELsyB
	RB4UX8I/zH/AFIRjh4li3R4ul5jXzVxPzKtbBuk7nEqdCj2oITlIQ5B/3QVuOtY9ITLePiB1jdR
	YnesmNJI=
X-Google-Smtp-Source: AGHT+IHTOmIWFPX/MeaQQU4CMaDf8mN/ky6ULU0COcHUpnhRVcuiDnmIeGftxwou8pA/tHFTdIiuDA==
X-Received: by 2002:a05:6000:2289:b0:3a0:8c5a:6af3 with SMTP id ffacd0b85a97d-3a09cf4efa3mr5804818f8f.53.1746444977398;
        Mon, 05 May 2025 04:36:17 -0700 (PDT)
Received: from archlinux (host-87-8-31-78.retail.telecomitalia.it. [87.8.31.78])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae0c3dsm10443159f8f.12.2025.05.05.04.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 04:36:16 -0700 (PDT)
Date: Mon, 5 May 2025 13:35:06 +0200
From: Angelo Dureghello <adureghello@baylibre.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Beniamin Bia <beniamin.bia@analog.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: adc: ad7606: fix serial register access
Message-ID: <o3jxdmchpmn5edbeznqecslkw4tnrdei4qqnb66oyyqeizavmg@5uke2kr4hte7>
References: <20250418-wip-bl-ad7606-fix-reg-access-v3-1-d5eeb440c738@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418-wip-bl-ad7606-fix-reg-access-v3-1-d5eeb440c738@baylibre.com>

Hi Jonathan,

any news on this patch ? I would need it to proceed on other new ad7606
features, 

Thanks a lot,
angelo

On 18.04.2025 20:37, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Fix register read/write routine as per datasheet.
> 
> When reading multiple consecutive registers, only the first one is read
> properly. This is due to missing chip select deassert and assert again
> between first and second 16bit transfer, as shown in the datasheet
> AD7606C-16, rev 0, figure 110.
> 
> Fixes: f2a22e1e172f ("iio: adc: ad7606: Add support for software mode for ad7616")
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
> Changes in v3:
> - fix typo in commit descritpion.
> - Link to v2: https://lore.kernel.org/r/20250418-wip-bl-ad7606-fix-reg-access-v2-1-8b1ade67e185@baylibre.com
> 
> Changes in v2:
> - improve bug description.
> - Link to v1: https://lore.kernel.org/r/20250417-wip-bl-ad7606-fix-reg-access-v1-1-0ce341f3cfc3@baylibre.com
> ---
>  drivers/iio/adc/ad7606_spi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
> index 997be483ebb93293481b922e13ece4edb47e940a..bd05357a542cf7234d5bb6b718829d6b720262cd 100644
> --- a/drivers/iio/adc/ad7606_spi.c
> +++ b/drivers/iio/adc/ad7606_spi.c
> @@ -103,7 +103,7 @@ static int ad7606_spi_reg_read(struct ad7606_state *st, unsigned int addr)
>  		{
>  			.tx_buf = &st->d16[0],
>  			.len = 2,
> -			.cs_change = 0,
> +			.cs_change = 1,
>  		}, {
>  			.rx_buf = &st->d16[1],
>  			.len = 2,
> 
> ---
> base-commit: 8dc6b228d746b1a900bed28568defb2266fa4c43
> change-id: 20250417-wip-bl-ad7606-fix-reg-access-729c21478d1f
> 
> Best regards,
> -- 
> Angelo Dureghello <adureghello@baylibre.com>
> 

