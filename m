Return-Path: <linux-iio+bounces-6991-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF40191AE54
	for <lists+linux-iio@lfdr.de>; Thu, 27 Jun 2024 19:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB7FAB248CB
	for <lists+linux-iio@lfdr.de>; Thu, 27 Jun 2024 17:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310B2199EAA;
	Thu, 27 Jun 2024 17:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSC/eHVs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F031865A;
	Thu, 27 Jun 2024 17:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719509981; cv=none; b=WjzaAoJk1pFoTblZsCCP0liEDEJX8AmyPAqY8H3fYXt2tWNdyffpXgsV7fasH7Ig0YiEYENJ0YdcugyvKdbAJNsDWGE+YQM5xT09G4jpnVh7ELQKq9TYLYrthKpUPePjvFssLlHJQCJyOXNOHHQrey+NHjvl2D0Yegdb0IFPCWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719509981; c=relaxed/simple;
	bh=aH1Umnhky55B8t61wZo0gg5wGOk7NzGGWbnnWx0lSoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LOJZUmisMZCRyGCrVwMA+ZNqdzpkxuknMM4/L68I+dyNs4aVN0Hzrz3qtmKihmdcCrOGsjTO3pSgqI74qXo8Amx7fqGaJneBLBBKFW7R8dU/Nok3CoKe3WWigIc041BM7gLTZIxO7k32aXBQnrXF6CDE5PshVIMbvN5sOsRc4jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bSC/eHVs; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5c2253cb606so975234eaf.2;
        Thu, 27 Jun 2024 10:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719509978; x=1720114778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s7WOcecaaOZ3rsj+Ub16kvTDYOxYiGT65TR4mfDnqck=;
        b=bSC/eHVsFdJB11sbmUzd3AZ1I1yU5Hy5Ir7ausBQv8sPgdq0lT9dcMQwaXC1dJs6Gt
         vkXxWmGj2Uz9XS7WKo0ojY4+LmYILTB6FBuRFfh6JVkGmkyY9yPZYaW5D/y4HU1yPSgq
         r2wOo+EjhNH6gyDJZQJleXdD1QL1zxQM9T3pF4qSxMC7hzPPWuVwxvNQeqGlSF7Fxkoz
         8GkDculgxYEd8sKb+cRC0zoL1gy+Ps69zKlyy90YjI1fo/hb5wGOIGGIxM6h2q6qC+JV
         dczG+aJEsaSZ0X//TkUBnYlzX/EbgRdE1q40DIaWAKsTvxxTB2x7qa2/PIyOswOFA8GH
         22/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719509978; x=1720114778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7WOcecaaOZ3rsj+Ub16kvTDYOxYiGT65TR4mfDnqck=;
        b=nKw9E/dn1OWoxY6k1qennFLzr9lpR7bFQf85yr6FdTRI5P6b54XYuljyp86hhzqQVE
         XlKc7aMSLPfuJb34mZy8F4MhtnI0EEdYYTI0MVqaRVpN3impg03EERscwWUElPcOTP7x
         NDAcTtr0wEDT3csFaaXLQy6VlPwM+qZkZbTu2k1QJHqfuoPSh2D01qebHR8DtCr7CiaN
         EmJOU20Yf82q0oDvi5wCZ/ryzQGwTTzw+74GVqtm4VR4nqujFXdMv8FBldHlRVf3TmRk
         gZoop6b0pmFSKdADf6PnPohR0Bvr132X6r2C8+CMCJ864CfACUFAzYBu8A5H1tM5Cin5
         eDlA==
X-Forwarded-Encrypted: i=1; AJvYcCWtX8PqXxEICJlX62BLHaB460//ZEEttXjImMIE4ZSI1AHhbXTHZXdcCHuHPnRWAxS3QShjtjRkM+rJq6hL1UNaKBFJkGcc8+7IgsGMBZ0KecUfvNsWLe4S+a8i0Qa8wEpHIcPCS/yTT332YTui7Y1CJGL+gO8Ph467WhYnOkn/X4GCUq8WMgcnr+2PDz9BFZm7+6t9AIfAqawMN5kcPn+CH9UydTlFP2CW5YL7VLgC2ug4BwWgiulRXQ==
X-Gm-Message-State: AOJu0YzrkQaYur3hAaF271Dm6HFgdTyYvtctYS0NWJ+mGQQYoNwTX0dl
	jUL34SjItvQpSK5+zUhl1W3+YE6oBUSYENLyG2eIqTHElZzAsnhP
X-Google-Smtp-Source: AGHT+IEGlLzYhJ39db3MWWvG5uOUIm3HV5EiLIKlEss/+fCmWIiT934iZZ4Ky2YFWCnOMl3U2dQAzw==
X-Received: by 2002:a05:6358:9211:b0:1a6:7c93:963c with SMTP id e5c5f4694b2df-1a67c93ac03mr215407955d.14.1719509978504;
        Thu, 27 Jun 2024 10:39:38 -0700 (PDT)
Received: from localhost ([2804:30c:96b:f700:cc1d:c0ae:96c9:c934])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72749854a9fsm1314642a12.92.2024.06.27.10.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 10:39:37 -0700 (PDT)
Date: Thu, 27 Jun 2024 14:41:05 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	nuno.sa@analog.com, corbet@lwn.net, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/7] spi: Enable controllers to extend the SPI
 protocol with MOSI idle configuration
Message-ID: <Zn2kMVDn5k1OFogA@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1719351923.git.marcelo.schmitt@analog.com>
 <add14694c64b574af742a5dcd5c9461e0ef5210a.1719351923.git.marcelo.schmitt@analog.com>
 <1d2cde40-ad55-4136-bc72-3d71515f7023@baylibre.com>
 <7ed7f957-3e07-42ce-894a-f3f9dcf512ea@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ed7f957-3e07-42ce-894a-f3f9dcf512ea@sirena.org.uk>

On 06/26, Mark Brown wrote:
> On Wed, Jun 26, 2024 at 09:57:32AM -0500, David Lechner wrote:
> > On 6/25/24 4:53 PM, Marcelo Schmitt wrote:
> 
> > > +#define SPI_CONTROLLER_MOSI_IDLE_LOW    BIT(8)  /* Can idle MOSI low */
> > > +#define SPI_CONTROLLER_MOSI_IDLE_HIGH   BIT(9)  /* Can idle MOSI high */
> 
> > These two flags above are still not used anywhere and are redundant with
> > the SPI_MOSI_IDLE_LOW/HIGH flags below so I don't think we should be adding
> > these.
> 
> Yes.

Oops, my bad. Removed them now for v6.

> 
> > Also, what is the plan for adding these flags to other SPI controllers. For
> > example, the IMX controller in [1] sounds like it should also support 
> > SPI_MOSI_IDLE_HIGH. And your comments on an earlier version of this series
> > made it sound like Raspberry Pi is always SPI_MOSI_IDLE_LOW, so should
> > have that flag.
> 
> I don't think we need a specific plan there, obviously it'd be nice for
> people to go through and enable but it's also fine to just leave this
> for someone who needs the support to implement.

