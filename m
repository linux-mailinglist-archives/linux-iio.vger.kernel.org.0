Return-Path: <linux-iio+bounces-14116-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7D7A09E23
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 23:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9C0B7A4B4D
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 22:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB24223719;
	Fri, 10 Jan 2025 22:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqEL/ehY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A002135DF;
	Fri, 10 Jan 2025 22:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736548443; cv=none; b=H5m/lFIxPndli721v95q4fzsh+ecIQLZI/Kxt6sbnZVOydJ2kFSLveA7QnxOHRGa4CTzvoJEeLOgzgDmryxDWIaabPPXPPAgSf+rIEEiBIEsV/XUAVU53K3cTZRF3Gdtkfo5A5jgquX+EmUWc/BvRZ8OZPsix3GLAdpYKh0SN7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736548443; c=relaxed/simple;
	bh=TeNFSjKjy8UcROaFLJc1GjjDATnrGgDfmChPlfsoqWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NfwphQzGHMtJGmFrNWOEGmmkGKIcvW4eyrk6GGRJY5tMJg4wACogYfbN7TraNmr9APjs3uEwUrjglbQ23mVV0vNO8QuxHnTAStvQQkTvS9EiOlzoCly7x/6b5EdGOrQqS9WmwYHtLz04y30QCBm/HdQIawiHEZm4iiXrdRYD65Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UqEL/ehY; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5187aa2c97dso981060e0c.2;
        Fri, 10 Jan 2025 14:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736548441; x=1737153241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+7m1HUJMB9GF2AZ+eHqMjKdwSe1SFU0f8P4kZQFjZo=;
        b=UqEL/ehYvj9VRhOkMxrS3xieCxOWye9T5oA8/9IDf+rZYQSBVzWKJadsxBl+K/qSMr
         gcRLibeib3OiGrGLDr6obo/aqX0KgEbzTCwnv0snzv3286qH5hyDHCm+3+KG/fS5Fbc1
         qmqYlwS6CxieXibZkYIgMsLLagPpcgpDfbzWbEVQsW/ieFp3CNqlFm59HdFHokvgFuQ3
         zo307DiVwpvIYXgRlkIcSwCcLKt5KyXEE7J4OCPC9nF7V+muLzpUi9lwakxIec7+zVwZ
         0D1nitYrWAph/mOoslrjNZkKVyTmPd9183xPMDA8wCXWgFOoG0bJPko4LKVRBJvB0xbX
         EI/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736548441; x=1737153241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+7m1HUJMB9GF2AZ+eHqMjKdwSe1SFU0f8P4kZQFjZo=;
        b=ZBry/N3fiWvZHeT+S2BiY1IvSYxD2a5oqWVT/do3jzUunE6ZLpQvGYI9l6VQi/+oTv
         pM4x9EZoDbFL6PQR+slrk/6kxePvzi9FER5wado9xIUznfWwLe8uSNjyOM+kvw3TDAPt
         dkspS2KW4lLo/khRwDVcU2sg5NskhRsncMsHm0AeV3Yu8hWCbNt5VwhFM6u5qUptI1Nl
         UrxW2PUEVQpuqfJN085r7cm0na8M035fSPP1Mil0oMIOcjBZVw2bhvZP5H65dP0VP/zN
         6uP7emzi1X39ZYTmc6nXwA9dflDL4SwwvEASwkFr48B8Wik1kZxDiUzEQHEg0gMLJwA0
         5Jmw==
X-Forwarded-Encrypted: i=1; AJvYcCVEfI19RDaHuneO4xMIsUnqSN1rKzL18XKNtDkqnsWXv00UJfN8dHrAIvojcHMEL/QGgjz5mm798JuL@vger.kernel.org, AJvYcCXfH2J/Aew3OuGp6Wv/gp7vB8fCZm/kDTB1Bhu7jVMDo3ek5NUcIrMHVavPxaDwLE7q2x4p4EXlaoRGKIWD@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo7JdcGD4k3gcO8CKEd7HmhonC6L8Bt00n0OnL944bZlKNsatC
	T9PeBAVCKd76pD01HVNhN53fHTPGkW2ZngHdWJbIUxZibZljlvvdaPoDp7qd
X-Gm-Gg: ASbGncuZR06UgVZr1USc5FOCzLVgcjuE4WLWSwb3MntEYEEYPof/aXbKkJMfWT+YYuH
	JzGmXuid2/nK2iCccgjL+2uHVTOpLmEYCg95FnSW5Ev1+Jc57JiQPGiJMrQxkTKpqfFw0cXMh7Q
	yiDWM66MPNdHL2rKOL8/4yPjrDd3Kw8Y8ypgygy5kn81kIcYs8e8/RINoRWKdANg4j3fIk1lLXW
	cPvaCKqrRaCuZClV0dzBQVd06uUCPfvlh5dHsIWrrHh5p9TsU3ZFrnqbvUw5nvzAms=
X-Google-Smtp-Source: AGHT+IHyzH5pNIEDMBF4z67ygBR9xYH0Unc7xpWSo32Po/JnjZ0KY+O5PN/uz73T521gyVkiMNlzyQ==
X-Received: by 2002:a05:6122:926:b0:50d:a31c:678c with SMTP id 71dfb90a1353d-51c6c356692mr12969887e0c.2.1736548441037;
        Fri, 10 Jan 2025 14:34:01 -0800 (PST)
Received: from localhost ([2804:30c:1f79:9d00:c6c6:ec89:7531:7838])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51c7fb9bcefsm2756906e0c.7.2025.01.10.14.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 14:34:00 -0800 (PST)
Date: Fri, 10 Jan 2025 19:34:31 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v1 11/15] iio: adc: ad7768-1: Add reg_write_masked
 function
Message-ID: <Z4GgdxU-EuR_xYrJ@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
 <67649c43050d161621bc0494638bfa71fed82ea8.1736201898.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67649c43050d161621bc0494638bfa71fed82ea8.1736201898.git.Jonathan.Santos@analog.com>

On 01/07, Jonathan Santos wrote:
> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> 
> This commit adds the ad7768_spi_reg_write_masked() which is a helper
> function for writing specific bits inside a register, without interfering
> with the other bit values.
> 
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> ---
>  drivers/iio/adc/ad7768-1.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index 574d735f2c3a..675af9ea856d 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -242,6 +242,21 @@ static int ad7768_spi_reg_write(struct ad7768_state *st,
>  	return spi_write(st->spi, st->data.d8, 2);
>  }
>  
> +static int ad7768_spi_reg_write_masked(struct ad7768_state *st,
> +				       unsigned int addr,
> +				       unsigned int mask,
> +				       unsigned int val)
> +{
> +	unsigned int reg_val;
> +	int ret;
> +
> +	ret = ad7768_spi_reg_read(st, addr, &reg_val, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	return ad7768_spi_reg_write(st, addr, (reg_val & ~mask) | val);
> +}
> +
ad7768_spi_reg_write_masked() should be added together with at least one
user of it otherwise it leads to build warnings.
Though, better if able to convert to regmap as David suggested.
regmap_set_bits() and regmap_update_bits() come for free.

>  static int ad7768_set_mode(struct ad7768_state *st,
>  			   enum ad7768_conv_mode mode)
>  {
> -- 
> 2.34.1
> 

