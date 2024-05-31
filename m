Return-Path: <linux-iio+bounces-5569-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 663FB8D6C5F
	for <lists+linux-iio@lfdr.de>; Sat,  1 Jun 2024 00:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97C641C2325C
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 22:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAD580032;
	Fri, 31 May 2024 22:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9vDvH85"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270EA380;
	Fri, 31 May 2024 22:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717194132; cv=none; b=hyb/4H8xbm3HN4l5l5cd3MpjnXGDZ3eOP1x/Rq03evjq0vxkFb9a5mPiWn7Ljtu+iBoZlOzIIOLcoC4xut1mTFY4UOgqYWurSnYx9+eKALKFAXF/ppcsx8oc6K/GTVljq2K7+1wPazJNvJtFjB6N4/YNSY0fCSKZcEo0y4CoIs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717194132; c=relaxed/simple;
	bh=8aasfJYMSp7Rca3V+snQkwV21X6/KhsdEbYfIRJapRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CX4jrjkPU+z12AzksBID/v0aeifZ4yZka6W+L6EWUHJ5UGLb0pS4XuUUcvK8c3I0pdob7ltZpD8m267/g8d+QVYMpKXyjFBGkcEefdZytBhut6Xx0hDG7KBV2RwTMzQLeMd2DqRuf/N8KQlC1w2P8ZyiYEoSHEz1Gg+pMYuvQ/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9vDvH85; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7022cabdc0aso1950217b3a.1;
        Fri, 31 May 2024 15:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717194130; x=1717798930; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1AgJOdQzaSF+x48xZPHcAex543/+XUv+ldPOnodDgaw=;
        b=k9vDvH85Qd63mMOrJllfS3gTTq/6UNcxyh5mizvlMZCsfYT1GAQkFZOXR1Xcf+G4Vd
         4m1RrZ+Bi/7YcratdILT2xL61N3NcsWJZdtxwjGlnpOjX4WFdRePYCcoIYz08K4gJCO2
         XCStNONf8MtK6XwpVFoL0niBynQCu90Rwou8iCeBAGiNEyL7Dp2aTdWt6t3tJtlLZxTm
         fT1LlaWPgyTHT2x2PeQ1lALsDfaSrC4eMNBbwSLGex7ke0vh4fJaksQXAB52GFpD5bx0
         JWtASpsWdxdAWXkHenFR/09s9drCsXuen+aprAQ/GPvgWRzLImpx5xm7dD7fTjIs68Ri
         XkFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717194130; x=1717798930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1AgJOdQzaSF+x48xZPHcAex543/+XUv+ldPOnodDgaw=;
        b=F11xRWnrB4vNHvbuIFPROiC2FIgNTI4gDbeNcnCK8UOR/aAokOtvGTEvoExEmrbHFa
         W3psy+WJhh/v03Liz/l/tgOhHdXAzMGXFSc0BbmyWMFxBnVVujBetS4bJiD8LzDuPh5h
         EvVJBsotwcyfv5oqXtAmFsXc1n0rutxILdtjcj7FKVKsk18X/IsIbpL7MySi33ooaGqx
         DiJqEGXU86Rqq6Ka3zbjz27DX6NSpPTFsjUL4Lkv+lWDIsDH9FtiESN0paq+YUIE/m4J
         BjU96JR9uq4ggkmW03zfORpA3aId2IBHSTu/aKFE/x17uzEx2u2UpZAvcX02D/p+0JEh
         B13A==
X-Forwarded-Encrypted: i=1; AJvYcCUPVJJjS5tYIaFQFC77VhE4L7zkcuA8izvc/Ka/IK18k2Nfn/HirPZrgyBlJKZENPHTgZSnAfCMfaaOW8xvggMwDW9WWFOAq/6pJT0xLGNVmJBT5WU+sqloa85/zAm0+CB3nhQKgKK+tFQJoOUbQXKEUhDN8z7lb3wrVPLLOt+vY7nspQ==
X-Gm-Message-State: AOJu0YxFZ7gXK+Pv1Lh1cfDmGeszLXY7tO7ih34/XI+kqUW2krK3fuuh
	g4Iz5DEj56ZUTclQ1O3yLSzKsfwdjFa3uVdTT3baJRtvFjr2bbJdo1nl73gKCP4=
X-Google-Smtp-Source: AGHT+IGONFMeWhM6DGloHHRuKEmzh8MdNpvj9MZ2WZCIpzVApBH6H+bkiHK1nnz7IgrFO2mwTWMvmg==
X-Received: by 2002:a05:6a21:3a4a:b0:1af:86e4:bc99 with SMTP id adf61e73a8af0-1b26f12ce72mr4643339637.10.1717194130200;
        Fri, 31 May 2024 15:22:10 -0700 (PDT)
Received: from archlinux ([189.101.162.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242b2c438sm1834252b3a.202.2024.05.31.15.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 15:22:09 -0700 (PDT)
Date: Fri, 31 May 2024 19:22:02 -0300
From: Gustavo Silva <gustavograzs@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, lars@metafoo.de, christophe.jaillet@wanadoo.fr, 
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: vendor-prefixes: add ScioSense
Message-ID: <kluu6wchcz47duw5kdamlhacvms3bielepees7gjx5hhoqz4dh@bktawzj73nan>
References: <20240529001504.33648-1-gustavograzs@gmail.com>
 <8e27c8da-d856-4fab-bb12-3af07e13838e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e27c8da-d856-4fab-bb12-3af07e13838e@kernel.org>

On Wed, May 29, 2024 at 09:29:54AM GMT, Krzysztof Kozlowski wrote:
> On 29/05/2024 02:14, Gustavo Silva wrote:
> > Add vendor prefix for ScioSense B.V.
> > https://www.sciosense.com/
> > 
> > Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
> > ---
> 
> This is a friendly reminder during the review process.
> 
> It looks like you received a tag and forgot to add it.
> 
> If you do not know the process, here is a short explanation:
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> versions, under or above your Signed-off-by tag. Tag is "received", when
> provided in a message replied to you on the mailing list. Tools like b4
> can help here. However, there's no need to repost patches *only* to add
> the tags. The upstream maintainer will do that for tags received on the
> version they apply.
> 
> https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577
> 
> If a tag was not added on purpose, please state why and what changed.
> 
> Best regards,
> Krzysztof
> 

Hi Krzysztof,

Sorry, I totally forgot to add the tag. If we need a new version of
this patch series, I'll make sure to add it.

Also, thank you for mentioning b4, I'll definitely give it a try.

Best regards,
Gustavo

