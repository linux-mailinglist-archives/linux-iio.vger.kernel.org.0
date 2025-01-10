Return-Path: <linux-iio+bounces-14113-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E113A09D7D
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 22:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 628F53A4CC3
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 21:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B53215164;
	Fri, 10 Jan 2025 21:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SicvUzHz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D3C20A5EE;
	Fri, 10 Jan 2025 21:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736546239; cv=none; b=GmYkQl8pDZ6m2uNJm4SlAy8A71h7okoPt/T8D3ZJJnLH/Y12hXYeCetqmCF+YsOHG/x+2yEhLXhWKJ9QkCtThnQ99zoz0FCOIzokuXzxBuZUs2jS6/pKXNzApOGmBld5yvA4FOwP4DeWT+HdURhgW7eaWTQ25phEIl8A4EWdb3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736546239; c=relaxed/simple;
	bh=TZ+FZ1YX7CO1sPkp5nhoK1WMFtYyJbUpPhodC84MfuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XTFvOP/0d5xlbX0saHNECR8wLWVgyKgt6ZooIDmE5OEUuspYfo5nrGNN2u6aRdFBkrYql1yvGhhHQXfGneTNr+pLmyENlzBF0PzCQxYzmqq46Z4aA+Hwi/fKbNznF2vdZd4NEJk1+06bv4xMeQe4+Rv7xwsKAZsLcO29TRVLJik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SicvUzHz; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5174d53437eso1408601e0c.2;
        Fri, 10 Jan 2025 13:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736546236; x=1737151036; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CwWxfRj26Fkhfcg8p9Iz2qwk0KLZZ6S6GGHfTECmvCs=;
        b=SicvUzHzlJOeNv8Ty2wt4hhMIGOScS8l4FJ+WFssO3n+aq2A6LYMV4WEX0Bx+lXcjU
         3Two2Sas7gxS5UzJ6iv7B9foyTUdf9anNH9/ucY57ccRoPrrTzFK7Kf5U6l+91xOBcSi
         iUJ9vQqmTQmuRSMHYPU9t2cveaXg1MxQkcujyEbPzAEo0so0MJqsXyaxNZUM2UyV9qDN
         W0A7Ch9NA6idBLeojRSdAibfyu1tmhOtG5bjgtT9FQBEjPn3O4YXfYv71W29Y/mI3es7
         3Qy8qdAam+yp0MTu6Z9Jp5keamZgE57FCzoLBL2jqWvu+e4GpqVkP47NaS1FVf+qhuHK
         Rfbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736546236; x=1737151036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CwWxfRj26Fkhfcg8p9Iz2qwk0KLZZ6S6GGHfTECmvCs=;
        b=rSISG1fFQr4vyvDpcRk9H21aGjXGnG+E1BvdQTuFqhUjpErtHpwU0M9++kx+WFpLcH
         CTnS8RqcVhZdXhGlvN2WLQZPnskpg5jYQCPJNapV/SeW2q6He0vkyWPywPuStaX5lqoW
         HCgxxmiYN53Dv7SCuuRX8JEPxWuTSTfowlv+xHcxilq/z9knJ/NNfFW+f+4I+Pu0HuU8
         8rUIPl7jRISxFVgVZOAjIG2p2wmNK9ctpKKVdF78LLbuMYtPdEJvRmZ4aGE4yjdlMWyT
         ZQQXUvbDo0OE3YdiApfLhm6WrRKogmh/5leaGm+q/TV/MygGkn7lH1mPr27JjsXZsLFI
         JgjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUr7ovkj+eT9EKlFCX9np7eQAUwhYLj8nakW6N/+Bwzt8s+yW8IqzysZOl+Y0Sxhs65fup8bc7zM9qMCiBo@vger.kernel.org, AJvYcCVwu5H5yLWqzCycbplT4oP2wzmMwzYkYpAVyMaBon0i2qQM+3WPYXBq1mNZ8imPc9L811inrIw8TJ9y@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+XR7Nw1vRYnji2TzD4T6PNzPsBXRZ17XK+3k/GzNNylGFGkxX
	gNRC3o28vwK5Y33KC8dCveVHlbH3jMnCGrQpf4/FDRcFTIcD70bY
X-Gm-Gg: ASbGncsbisHCRabz0k1cm+ozJrye1NAsWOR05YwGBGin+1cbOFhh+orenMLj3+e4iIK
	bv3qTfl37/QsskXz9AI/yFkTic3/0WIv2l46gxV8jfIDCtliH1EEBkgeno1hIO22T8lr2OKJEM3
	pBLO0gbnTGqY2naQmKE06hAt7v0PigImtJ6zt/RhAvRhTeWw1ENRhSZiCie6YOgD6S7nxypgcXV
	P9XtML6mbB8A76oR8Eh1k/xhyGRwxdaoZLDRR18Yw8GhladyBtwgntzKYpW/H1HaT8=
X-Google-Smtp-Source: AGHT+IHdGr9eV2KUnCJu7Em2jwYuhOennAImGvIup0jfFJ7zDShDGp0mjclB78FhPFWkKCSnCiyfFQ==
X-Received: by 2002:a05:6122:4387:b0:518:8e53:818b with SMTP id 71dfb90a1353d-51c6bdece20mr11847464e0c.0.1736546236065;
        Fri, 10 Jan 2025 13:57:16 -0800 (PST)
Received: from localhost ([2804:30c:1f79:9d00:c6c6:ec89:7531:7838])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51c7fbd340dsm2690345e0c.14.2025.01.10.13.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 13:57:14 -0800 (PST)
Date: Fri, 10 Jan 2025 18:57:47 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v1 06/15] iio: adc: ad7768-1: Update reg_read function
Message-ID: <Z4GX23ZXUM4mvjgY@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
 <4c2d06b873def8a9c3c1d4c8dbc829b655218eca.1736201898.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c2d06b873def8a9c3c1d4c8dbc829b655218eca.1736201898.git.Jonathan.Santos@analog.com>

On 01/07, Jonathan Santos wrote:
> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> 
> This patch adds an additional parameter to the register read function.
> By passing the data pointer to the function, the returned value will used
> only for status check.
> With this change, the status check won't be confused with a register value
> check:
> 
> ret = ad7768_spi_reg_read()
> if (ret){}
> 
> Also this change removes the probability to interpret a negative value as
> a return code (the ADC is a differential one)."
> 
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> ---
...
> @@ -190,7 +190,9 @@ static int ad7768_spi_reg_read(struct ad7768_state *st, unsigned int addr,
>  	if (ret < 0)
>  		return ret;
>  
> -	return (be32_to_cpu(st->data.d32) >> shift);
> +	*data = (be32_to_cpu(st->data.d32) >> shift);
Are the outer parenthesis needed?
*data = be32_to_cpu(st->data.d32) >> shift;
?

> +
> +	return ret;
>  }
>  

