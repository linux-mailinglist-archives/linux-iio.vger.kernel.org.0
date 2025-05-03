Return-Path: <linux-iio+bounces-19018-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C126FAA80E6
	for <lists+linux-iio@lfdr.de>; Sat,  3 May 2025 15:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 910171B61667
	for <lists+linux-iio@lfdr.de>; Sat,  3 May 2025 13:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CC6275866;
	Sat,  3 May 2025 13:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pueu93Rc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE809EEBB;
	Sat,  3 May 2025 13:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746280553; cv=none; b=KHAfUNmvzlf7DulJb9c1AjRJQeuS62FC2/kTgEYzTVYDWIq08EqDXqOwTrHtcDwjwJw1Qj4l3QEmp7CLJW9AAOLydz2Hgi1mSlCmW9oQtpaX8JqYSRkvlQSTtGjnX+dEzFi4V6+61GTC8hsk2XlO7uCl2VltaMA+vayvAJxHu/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746280553; c=relaxed/simple;
	bh=JVSKOu5SCPtH31XM67BYwV7lZoni8LHG7Aym8C8zsBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pr0vpxeLo/AzYf7yt1XdAJcxdYFvYNugSgSPtAUSaGSZD26JTVqU7aiEU02dV1UP++8XJ9gbk9vwatswAcHnHG1e5o4K++VOCIHqS1RWTcpdhXeF3Glo4VQ2q6n9IPsagyMuUu/V/Qrfytec2u0zHysu7zjZF2IenrPz76/DHEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pueu93Rc; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2255003f4c6so32437975ad.0;
        Sat, 03 May 2025 06:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746280551; x=1746885351; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sQxpjKwxVJwW17qm7YNjoZcnUxqGHc3Vct7PxbSbEt8=;
        b=Pueu93RcM7Z/6H+v8RsrrU2uAxqvKMA+PSpRca3y8RIQ7n9BwFoTpC9klIVFPCQwT2
         xQwFMIryHtQC0Q67ojor5pyigdSNUBlUEl4CcQ30k/IH/ajy7CUGHmPGVPVZW6MJCwRf
         nycIOXuvjD3iCi1hwWSQSe69nIWj8xv6+bozPr3a9KBI0/uUXhJhM7rwQO0LUzd3Yqrt
         cqjfq/5pBDkmUZyArt3/Tfv9/+FcYLAagBjiTdit+Q/+Uarqz78pOUbxBaParwH9xiy0
         rubL8kw8VsalHBdGnGIhzqbz0R4ntobkOwViOQmZflBrkLRmSH6yER+KLN6n5a3za8XV
         1pRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746280551; x=1746885351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQxpjKwxVJwW17qm7YNjoZcnUxqGHc3Vct7PxbSbEt8=;
        b=Lj2WhYLwnyxlXcolUkWyIOMWNWD+nglmGNC++uR8VJfhGU54WyVDf5wHd6UZ07k9MU
         GcuLYnL2ksi3e1tMgKW6GfgzTGw5re9QjT3a+nn4XkeisOy0vTB9CVK4ORtd/K+KjMDP
         I2tz/mAUUnlTLRFIYGv6XahVxqrXwwgcUIi+++Eg+U2iNwWlyM401hnWKhsSq+t0NvWB
         ULcNSgbjs1xWoWmlI9Jk655QAVWAJmdhiGAN8PVGqfh6WHw7RydnxPgL2VIRtqYpovN8
         gt241W83JLUSa6L0rDYE/iFLGlbIqY9Rv2eDIr0SI+w5uM/MfmaCne4bvtSbbjhTXBer
         zhpA==
X-Forwarded-Encrypted: i=1; AJvYcCUXQT5tZBEmKVFcoplCrJmlWmwatr03RfEH1muNXWXwKeI6mhKjv4vpZJrkBdG/FX97rlcFFYCzNpxvqi1A@vger.kernel.org, AJvYcCVPxneC6DgpcGAaiqAtnmbZSvQ9HrPH5ZdMH4bG+tncgS1Qtb7PFs0Bg8O8Bf5xVt0teo+r/V9i7YA=@vger.kernel.org, AJvYcCW66GAeag8/UJi8ppR8IaYy2M50MdlFKkRaxiIgasyEJFCUh/0kVVEk8wMUQ64mRjypsk6Ndrml@vger.kernel.org
X-Gm-Message-State: AOJu0YxX3ACnVs2qNN8b+cd61M7YDkF0attcklg5VZhEYlYHVkQMOYMw
	mF3kuPBCP1sH7gIlMjxJDLvtvTZuwXOsREHvkEWY/Yhzq04uTxYt
X-Gm-Gg: ASbGnctsXDhZGj79OaIp+4wfwVLEuCpklFac6k+7fMQZKgucA7X3AOOuE0ECZ69MS0P
	4kLLZn4w26h8Od2pbyzI4wlaaj7eWAThuDkqUgGwFdozDBDGDfO1ouHVi2x9vQlmmKgO/ipLMrY
	ra9/kvIsOyE1nHxsIxDuxW5KtItxOZfDWcRvSAGAWY04Sy6meRZf0mdVhmTeuCNUACubS9S7VAO
	RfHVpDBsbuOIxEw2dSrl0dDSaA9tD4jricLl7nAm5jUSM/cJEtNWU2QW4GYLmwNRcn+wRN5JUsu
	BI11f0ybZ7f8uFEWhxqfgW5toin8DHu/Wp9dJZs9l4UdILfPnA==
X-Google-Smtp-Source: AGHT+IHZmasQz743a0tfLtopxIWf41pLhz95umr4dtL/nWfbwqDglC1Sp8B9VX7iQDYnqcdQ/6ksoA==
X-Received: by 2002:a17:903:1aec:b0:224:1935:fb91 with SMTP id d9443c01a7336-22e10313ad3mr103369155ad.27.1746280550820;
        Sat, 03 May 2025 06:55:50 -0700 (PDT)
Received: from localhost ([2804:30c:4024:1700:8e03:72a4:b895:b221])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b1fb3c3f72fsm2436641a12.49.2025.05.03.06.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 May 2025 06:55:50 -0700 (PDT)
Date: Sat, 3 May 2025 10:57:09 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: accel: fxls8962af: Fix sign temperature scan
 element
Message-ID: <aBYgtRyJQXGWDgHl@debian-BULLSEYE-live-builder-AMD64>
References: <20250502-fxls-v2-0-e1af65f1aa6c@geanix.com>
 <20250502-fxls-v2-2-e1af65f1aa6c@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502-fxls-v2-2-e1af65f1aa6c@geanix.com>

On 05/02, Sean Nyekjaer wrote:
> TEMP_OUT register contains the 8-bit, 2's complement temperature value.
> Let's mark the temperature scan element signed.
> 
> Fixes: a3e0b51884ee ("iio: accel: add support for FXLS8962AF/FXLS8964AF accelerometers")
> Suggested-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>

Sort of nitpinking but I think the commit description could be more assertive.
The main idea is that we want to make the scan element signed because the
data read from the TEMP_OUT register is in two's complement format and not
having the scan element marked as a signed number may cause it to be mishandled
and miss displayed. Nevertheless, I do think the patch is good so

Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

