Return-Path: <linux-iio+bounces-18067-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBAAA87320
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 20:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC27D3B8523
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 18:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69101E5B95;
	Sun, 13 Apr 2025 18:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJQRgx9m"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743F31DA31F;
	Sun, 13 Apr 2025 18:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744567707; cv=none; b=hYZQ5Bax52NqoX4JN9tXGFy09JdsIWcPaeVmj9RRKXPRATIatRocSbmX6ZQd0k0A9EAVv7mDni2B7ctC/CDQRS2HAQpzpejt+TyqrHYSKjbj9dpybhrpOCY6wzECY8+IxZYd71g/f6dFO+wp0mDyyWegFF+AroBlwGLL6GIFSGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744567707; c=relaxed/simple;
	bh=98LFtn1tseprsMwLIYxoIRt09wt+dQXWBQe3wx8f7Us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cT02VX8fyrlKfVBh08Fw69RY2EhLMZS8dihleWg5yXZue+NYH/HahxQ5EmPfcar3n8wfiypbdh+uS68PR3ieeU+zpaXqk7UREtZg7VS7w9RnhCEApF6UV6QPkz7flb9ZpiUHwJSZ4mXgbsWvesQZAdF3ymhMrKYxulrzXDiCfR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJQRgx9m; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-736bfa487c3so3071744b3a.1;
        Sun, 13 Apr 2025 11:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744567705; x=1745172505; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8msCUUJodnedscKDvA6MjGmFcc4O0OyJw8Mm90R/Hx8=;
        b=eJQRgx9mMXbP2RCMV38AItYmeE9NBtkVu1dBcTAG8sEeSgfzmugpTdcyc/cZ4G36Ax
         qAJkwqbJtDxIx1sLnR5yR11B6KLlX8cVbWLJWe/cnU7VOpFO6J25fQ+keAdlyqcBiKqL
         1cW0cVMJjbUmGMJNC7tQ6tgdPXHxwy9s70ujatdqtwVCIXcHOybZvvVGsNHhuEjbl9V6
         fUT40QHm/zq5OeYgSv+W49wBm4A53rATEH/x4eyzVYHBzkSX3NLPRtnjaYz0eptU1m5T
         hysADZNetcRVlOT/UlIobxzWBGdu6+//RfShtqWfoFHG1xyxA8jGeULe53o+tE7YZRzN
         U6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744567705; x=1745172505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8msCUUJodnedscKDvA6MjGmFcc4O0OyJw8Mm90R/Hx8=;
        b=Bl257Z22OYEHjgPsgcNVivv9G76suLmpAVSbT/6ttITX1xqY9JqwEukM5Yxjhr57b3
         pn3Jq9FFykJqlSU8DXVT4GgbAzxxaTRwUsbWItrn1BOsuD9vKG2FKbcQN/GKYTOEd88v
         fN4J4rUTHZ/Qsctj4TpUFsJ/bORmikV6NW+zWH/uck2wl14zEmSlzHFNeJ1N3tGIciQj
         9A4MGPLv82+hU/3y5fkboaXckSgPaNS/+7sr1JNsjGJ4B/LuZidSbdt3NmjG2pb1zRlv
         htZ6g4GdURK8YM6IWHY/h6oPKOaZyptjaGwW1imO78uzQ6sjDmxv6T0LTU58yExC6vMF
         a2WQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRP2JXT798Nl3WllfsAYak2VHkQoo5HQcgMskwXpmFKCVKgoUaGt4Xvr6oWraImou5grEg917OIgO0KpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXcC27f1V4xJ0S0J8ya7EJ3X5NClg7Vp0LD17zpu/fpNFMfHU4
	p7uV0Um+N0D1HYqD2qFcwx1MkNxCXWziikYRD8PgyiHigHo4Bupq
X-Gm-Gg: ASbGncvq3wZQCOEfmhTFYiRuf9fSaWJuPliCUavLfeOypuzoy34wrb4kuaNGmzCh3N2
	6L4ZkDojZR3mVTjp1mxvX3VvDtwDJt/JnO/3sGpIciQbnvjLO7bA2l3cXcy/G2UuxQ4fFTBwPmX
	Lx5OxRFP9Q5D3KAcJAxGU+PfqweGWNKQIPTb8mpF75OJil0MMvw3APBIOO749dsbseOyGnoNKQ6
	uS1ooSwncDTO3q2Sbv297Z2NyFZedyCZx7+lc298lH8OBxzEWPZicJabVkQOOZpARuucEob84NX
	RD0ieUL/W9CGwHvJbBj3bwFrkjDXVtCsy+RZnFyIZWbN9gNl
X-Google-Smtp-Source: AGHT+IHHpazn8+vcBt0d5bUXCBCSA4Ri6OBXDZzp8cb/V4X1zMybbDxXn303XM70OY2H7CFwrfd8+Q==
X-Received: by 2002:a05:6a00:22ca:b0:736:a682:deb8 with SMTP id d2e1a72fcca58-73bd11ded49mr15615790b3a.8.1744567704616;
        Sun, 13 Apr 2025 11:08:24 -0700 (PDT)
Received: from localhost ([2804:30c:92d:f600:d5e4:543:c403:4767])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73bd21c4e51sm5397399b3a.55.2025.04.13.11.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 11:08:23 -0700 (PDT)
Date: Sun, 13 Apr 2025 15:09:33 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Siddharth Menon <simeddon@gmail.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH v6] iio: frequency: ad9832: Use FIELD_PREP macro to set
 bit fields
Message-ID: <Z_v93dtgks2CquIn@debian-BULLSEYE-live-builder-AMD64>
References: <20250413120354.19163-1-simeddon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250413120354.19163-1-simeddon@gmail.com>

Hi Siddharth,

Your patch looks good to me and I keep the review tag offered on the other email.
One small thing I noticed right before closing the driver. See comments below.

On 04/13, Siddharth Menon wrote:
> Use bitfield and bitmask macros to clearly specify AD9832 SPI
> command fields to make register write code more readable.
> 
> Suggested-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> Signed-off-by: Siddharth Menon <simeddon@gmail.com>
> ---
...
> +
> +		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_SYNCSELSRC) |
>  					st->ctrl_ss);
I think st->ctrl_ss alignment with the preceding parenthesis could also have
been adjusted since the patch is updating the very same assignment.
		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_SYNCSELSRC) |
						  st->ctrl_ss);
There are some other places where similar change could be done but these are
probably not a reason for a v7.

>  		ret = spi_sync(st->spi, &st->msg);
>  		break;
...
> -		st->data = cpu_to_be16((AD9832_CMD_FPSELECT << CMD_SHIFT) |
> +		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_FPSELECT) |
>  					st->ctrl_fp);
This one would have become 
		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_FPSELECT) |
						  st->ctrl_fp);

>  		ret = spi_sync(st->spi, &st->msg);
>  		break;
...
> -		st->data = cpu_to_be16((AD9832_CMD_FPSELECT << CMD_SHIFT) |
> +		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_FPSELECT) |
>  					st->ctrl_fp);
Same here
>  		ret = spi_sync(st->spi, &st->msg);
>  		break;
...
>  
> -		st->data = cpu_to_be16((AD9832_CMD_SLEEPRESCLR << CMD_SHIFT) |
> +		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_SLEEPRESCLR) |
>  					st->ctrl_src);
ditto

>  		ret = spi_sync(st->spi, &st->msg);
>  		break;
> @@ -396,7 +400,7 @@ static int ad9832_probe(struct spi_device *spi)
>  	spi_message_add_tail(&st->phase_xfer[1], &st->phase_msg);
>  
>  	st->ctrl_src = AD9832_SLEEP | AD9832_RESET | AD9832_CLR;
> -	st->data = cpu_to_be16((AD9832_CMD_SLEEPRESCLR << CMD_SHIFT) |
> +	st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_SLEEPRESCLR) |
>  					st->ctrl_src);
ditto

Regards,
Marcelo

