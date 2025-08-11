Return-Path: <linux-iio+bounces-22562-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 143A2B207F3
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 13:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19DD7162F6E
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 11:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B07E26C391;
	Mon, 11 Aug 2025 11:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iScQZkX0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA29A1F3BBB;
	Mon, 11 Aug 2025 11:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754912038; cv=none; b=cDLWcEm0V4d+DLEbcbPFEuWfOotDxJ/KPmjXxC/IGSbwusp2F7SrjLjWJM4Bt9fQ+635m6Jo+0nGHdpiZMIUC82JYcbkMjI1VdRWREyIxxMbhA0EzysQECV71v4wgAEDH0kPJK0kKixf3yCunXz47yIyyh4dbGJId5OY2HnNJhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754912038; c=relaxed/simple;
	bh=6erDV3dWmY1VmGhYvFUL7sBwSAMLudOky0l7QkVqh18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q6vyZEvghVlzG1oTd061EtXOtRENVxNJ2FRqrZRoDlJQ4QZnIAMt2+C9ShQqDpGe4C1uIlTyFSSmBD6LOONbHe47HEvZxhBqgpfaoC3y6CpKWjAGlgD9R0Mftmqj6hN6pEsP4jvklX+GHLKDaa9KEuUvyqWbNr2YlThrYBVFGfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iScQZkX0; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b428dd79d46so2692177a12.0;
        Mon, 11 Aug 2025 04:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754912036; x=1755516836; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yzhE5mh7h5iLH0tJxHFhjEU465O3zl8W3NwCfnvCB90=;
        b=iScQZkX08xEZ33QrgKhzk0skOf66VmPT/MBdJY6KK9f0Me3wMkml7DT+r2g8zvREST
         K8FBr7bqXrtc05tGz/fZZ0N7/cNFsF/aY+QzEy5LAPhmi+fH9f1cRNnfu/L4FaTW990o
         qkLkdWjl1yefzcCIug6WehPide1mflkfKX6hVy1YtGRcH1CBRPbuumV047pQKwf99b81
         r5LURajYDzNGHvdUjEo+y4l7OKyDfk0wzOuBP+oYkbSFsVuBa3ENearmPlOolYa1nTVb
         6AzUPfhXiYzECWj0f2+/q0lnNpqOpEGqWFLtUJdgI65xaetiMKQaInFgfZ8h93RICT7D
         5w0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754912036; x=1755516836;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yzhE5mh7h5iLH0tJxHFhjEU465O3zl8W3NwCfnvCB90=;
        b=HuoaH7AJ0r8uAbeV+jFJBAiJKftdcby2nRTxJ6qVzj7PT4t3vndC9oGDEpDbxtuAUh
         Xm2oc80d+5mcuBfKCsprRbDfv2Ay3LmFUz/O6LoIFNPMyeIfZFi9kuCEBhlN25JRlUyP
         S4kC9WF2AtW1NJrn9z9h28JDEaADwtwV5JzrXcmPwyoWG2/8T9cBppgTtrqrO71UuaKX
         0mmP41T4Ry0GgEybWjV1MILfiMdjAH3w80kBH4qc4K/TnDMb/D2o6/+q9l5nsrSN7J4Z
         rSGr67j2nCCzdlWt+9cIXTzY+uQEs4tkztzROcIev7Y4JLtG3xokkByQYi0cebMV6JZn
         bFFA==
X-Forwarded-Encrypted: i=1; AJvYcCUa3lzALPOdgwLsi9xg8DC5S3L9reAyEph2/E9jhQMwA1yAS60FP1AEI5dN3fOl97EayFP6yRyHCUs8Q+sv@vger.kernel.org, AJvYcCVZ82JKAFePuq7okgC+X0OZEaNvG0nR73fXMSXgQVj6UD/WyJk7IhkmBGyMa45hsGCV83VVEgdjSEjv@vger.kernel.org, AJvYcCVgBnwDmIysxj332mnGgC5Tw0UktB2dC/xcWq1iMm/IOdFmyqlr7WLw/hRMt72bn06yNG2ANq6be8bK@vger.kernel.org
X-Gm-Message-State: AOJu0YyA35EpmuAYeOR5ZxF06gqQDM1L5IIUiVY4i5d02qVj1EF6DhfY
	tN9omVD1+e7tw6zKxw8pYvIBVLScdJk79YcdIwRZ8Z1MRwKuQZ+Hn30s
X-Gm-Gg: ASbGnctRq7Mf3rwOaL+ZF0RLI2A6JsbLpz+ElimOsfFbiSH9NAk6XN7UCWvvcoBJ/Pm
	U4Rn1oKpMV/9KnavcQWIiJ4oeilSzo/eFk/zzmtmQ2fpsB/Vu4e6nN51vF6xalIjQKcEA5pWkzQ
	GgKZR501ZT72tEt4ETtffrwx+bScQMCMZIOOTSW7YshbqU+GS1l8CNtX+36cgJn5XCoMZn0SjA2
	r2jJLSkVViENScf2gh4jxJuZmEQCbQD9a58WU5K0qZlonodLd+9f2FNRQsAuFw/vx2qoiPe5GYR
	fXcS0RzUWfja1Rvl8rIRJuG+MVU9jOGaXwB7b4CViwbDareMJinKlGHLRTLmX65UfVfc+BXL65N
	D7ie8WP/hg1C4r+Exl40SonCVdRm2IS4=
X-Google-Smtp-Source: AGHT+IFElQeL5UtBX94t/YLpZvrYgUr7vrXI2bq7A9QzLJkF1N7IEs6yBXsf+xU1+ZGqgIC2TGpQlQ==
X-Received: by 2002:a17:903:19cc:b0:242:a3fc:5900 with SMTP id d9443c01a7336-242c1ffce82mr165184435ad.8.1754912035858;
        Mon, 11 Aug 2025 04:33:55 -0700 (PDT)
Received: from localhost ([2804:30c:1f50:da00:c6fb:5400:5af6:282f])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-241d1ef6c28sm271233885ad.14.2025.08.11.04.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 04:33:54 -0700 (PDT)
Date: Mon, 11 Aug 2025 08:34:09 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: Replace bouncing Analog emails
Message-ID: <aJnVMXF07GeHPhtu@debian-BULLSEYE-live-builder-AMD64>
References: <20250724113826.61998-2-krzysztof.kozlowski@linaro.org>
 <20250728144901.3f646a4c@jic23-huawei>
 <20250809210438.23fb5fd0@jic23-huawei>
 <d6n24lux6pv47mb3z2bfdbtn5olsm46rdbnkwhjurkwh4a27kl@hkcedsvni4il>
 <d68f4783-ffdd-4fda-8ae4-65a211f9ffb1@kernel.org>
 <n35dcx77xlk7liosc6qdef423cuawvykrbn557qj72k5enear2@2akn2l3btwab>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <n35dcx77xlk7liosc6qdef423cuawvykrbn557qj72k5enear2@2akn2l3btwab>

On 08/11, Nuno Sá wrote:
> On Mon, Aug 11, 2025 at 11:52:23AM +0200, Krzysztof Kozlowski wrote:
> > On 11/08/2025 11:50, Nuno Sá wrote:
> > >>>> I don't know who from Analog should maintain these devices, so I chosen
> > >>>> author from Analog of one of last commits.
> > >>>>
> > >>>> Marcelo Schmitt, could you confirm that you are okay (or not) with this?  
> > >>>
> > >>> Nuno, Michael, other ADI folk.  Can someone confirm if we are making these Marcelo's
> > >>> problem?
> > >>>
> > >>
> > >> As amusing as it would be for me, I definitely can't pick this up without
> > >> some tags from ADI folk and Marcelo in particular!!
> > > 
> > > Normally in situations like this, it defaults to me but I'm happy if
> > > Marcelo is comfortable in assuming maintainership for these.
> > > 
> > > That said, I do think that for the adis* drivers it makes sense to be me.
> > 

Yeah, I'm not very familiar with the workings of phy-mac devices so Nuno is
definitively more qualified to maintain those.
Though, I'm fine in becoming co-maintainer if catching up on the need of any
review would be something feasible.

Thanks,
Marcelo

