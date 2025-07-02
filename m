Return-Path: <linux-iio+bounces-21256-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 470DAAF6207
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 20:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 672951C46CC7
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 18:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC952727F7;
	Wed,  2 Jul 2025 18:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5dIntmv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC842F7CE2;
	Wed,  2 Jul 2025 18:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751482635; cv=none; b=T0G3roFewziXUqwpaUGNVvi1vPR0S6pxxggD3g13Dn0IgkkoJOMTf9HpwyCkaTQfYxgUuvpUJ4juMXkkuvaA/pHx7GZdXDWpejia5hUQE2cSfzd3Wst03BiVNn2bBkq7wPIUmbwhcxt2wW0oBfAmm2T7//lLMDTVhqxzv/qnL38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751482635; c=relaxed/simple;
	bh=kC3Ij0+TwzLPJxztlRCaWKRcoSyo8G6Yo4Whg2rzTmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IeUsI+FHU6tuDjQkRJOd2tse8qvweqzo2g+gG5iJ30Io9KAGniGy3vmLMBtoMJASmW2Ngh8jbNqvBg1txMujzsRqOKahFZqJCOBhi1wsT4ZHOJos4vDtWrRNwFkP23sNRHBgMOWe5Nlo4o9grtgZ9uK3TXINsAWtqF+U4G1aNsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5dIntmv; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7d402c901cbso662829385a.3;
        Wed, 02 Jul 2025 11:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751482633; x=1752087433; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kZIAXJvKauaAlRkK7qxQW9qPzH50AGsUAE8RQQJUH+Y=;
        b=l5dIntmv5gBD/Be/Dqr/8HjR8lnXUy71WaB8vAxr/KBygeJkh/Ult/xV5NlMMmI4ES
         8Bua5rVADe9UY4NUj8lE0XayyFo3mkb2sTQ67UYn9jTSIR8QmUlwdeq2XJPcFHX9bgfC
         6nGHwiEbi4G5kO4Bq2FTpYFm1/x2qMcDlFBlKMunUQrSLfVWhqNeaDgIt19KUuiNeoPn
         fMUsps6GiiJCLpxmxR2yp5JZszSoTjJaFPjZuRq5SoGU06MC7n+bE4CqNQa6YomG2GsZ
         BlfOKGX46jR8iYz5lZ6kRM4CDojvqmq5eiMM47q8A3gIcf48Ko4UwxOuXSC062AFQfqJ
         da0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751482633; x=1752087433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZIAXJvKauaAlRkK7qxQW9qPzH50AGsUAE8RQQJUH+Y=;
        b=eT1sBOTPc/UB5IMSKBDDHT7Q5QoQ9Ai666tY8XKE7xRPeCmPQII+6w42AGCtHaQE6b
         EXWEwKvP8BdP9wYq86cJQ2vuJrm4klLa+Bp2Y9yuBra5lVQO4NZxTRFZMikbEKm02+1M
         +p6lnPbpgUt/YI2Akahj4Q6kZXni3STREcfb4CTvSVE9WU5XNPfahhSWtg1b7wZagyfQ
         cMqY96EZgBxDZlqGT4W7Ypjjt8i2R6EAoQgtxMXMUp8YdFP4/Q20xP/EavU9T7d8l0zk
         0rlBYKAkP7lBj3S4Y/actHAL6sd1iTS+Bm7UJK5VGDD8j7RLfyATXu0NseB9lr2cuQ6u
         Tn+w==
X-Forwarded-Encrypted: i=1; AJvYcCWMLZzbTYm80phW/XUDd+HuKjzKsutGvRf3yiJWeG1ZRScI9NanpEbgiMaD8pOU7HxQzkgsMEm2rV3cRcki@vger.kernel.org, AJvYcCXT7SzJF0GkpuBEVs2HGj2JU0CVtBR73MRHXw4moFFkM8C6C2ZOAwpwdYjAUWt82Z6Z1YEe6Gs0wY8e@vger.kernel.org, AJvYcCXcY7XDKra33ME9vsw4oT8e1wlpK7Un6p58xuvlk4e3AQhNkbisySeyV/mzmA1NhWs8Yaydiuzo3z8o@vger.kernel.org, AJvYcCXqtdGLVkK5wP67CbgcEj810Yr+6UXMGXdN3SYJM9bCfO5Ug1r+kiJls6pMLNU/YE1vVa7gp/D8qXf8qA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyF8o8ivc6vXUNCpAARedPzMa8nHdZbhx8Q3xRpe41b4HkTrt6G
	RFFCG7dIgrZiJiSvjuVxHrzI9SSf2wVzMTClMoBHbD2NuyrXEXj4DURu
X-Gm-Gg: ASbGnctNcQVN7HEpDOgKuTTidPY7+CgiCvynako/jMj7eRIR1TZ5IYX0TiSTkZKdJI3
	aY5zjP6dmMFWkOoWss29L/IGZR+J2yPE8Ndz+NydAgB6xny5C+fQcMYSfcanvn0vQMkFdTeEUrB
	25zfogu4aABmLoo0WvI9rw9DPHX6Vlmr73PxhLSjxqGUpoOCNDGH4R5kYVFQVMp9Hlw3RpWMQ2C
	1R+l+GRymWQMBRLQG2BYXnyJKqgUJQws24enmp60wSiptMKUFkfjSHJeYZLrz+Lo6sFTtagVrbi
	KdTdUCdERVlxljM++xUkbsOf9YyZWMdwp5NTLxUKjQx1FsZxDe6pIJdpDgWw2nr7tegsVg==
X-Google-Smtp-Source: AGHT+IEDEXEIqda75EtSySR3EUVNGEIZON8yl5WQFsWtxwa8n1GITiIvSiibTZKgp2uaIs7UnnNvOw==
X-Received: by 2002:a05:620a:4489:b0:7cd:5b2a:979e with SMTP id af79cd13be357-7d5c470457emr455087985a.30.1751482632870;
        Wed, 02 Jul 2025 11:57:12 -0700 (PDT)
Received: from localhost ([2804:30c:b15:b200:425a:de22:1d7f:2d4b])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7d443139b31sm990700685a.7.2025.07.02.11.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 11:57:12 -0700 (PDT)
Date: Wed, 2 Jul 2025 15:59:12 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, jic23@kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linus.walleij@linaro.org,
	brgl@bgdev.pl, broonie@kernel.org, lgirdwood@gmail.com
Subject: Re: [PATCH v7 00/12] iio: adc: Add support for AD4170 series of ADCs
Message-ID: <aGWBgLLtOzVGwXek@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1751289747.git.marcelo.schmitt@analog.com>
 <aGTpNNaW7cXC18Jt@smile.fi.intel.com>
 <aGUfapky2uh2tsFt@debian-BULLSEYE-live-builder-AMD64>
 <aGUi7r2dgnbqLOAH@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGUi7r2dgnbqLOAH@smile.fi.intel.com>

On 07/02, Andy Shevchenko wrote:
> On Wed, Jul 02, 2025 at 09:00:42AM -0300, Marcelo Schmitt wrote:
> > On 07/02, Andy Shevchenko wrote:
> > > On Mon, Jun 30, 2025 at 10:57:32AM -0300, Marcelo Schmitt wrote:
> 
> ...
> 
> > > >  6 files changed, 3601 insertions(+)
> > > 
> > > This is weird. At least patches 11 & 12 have '-' lines...
> > > 
> > Yeah, sorry about that. These ADCs are fancy such that the base driver is about
> > 1500 LoCs due to channel setup handling and support for multiple combinations of
> > voltage references and channel setups.
> > 
> > About the '-' lines, I will rework ad4170_parse_channel_node() on earlier
> > patches to avoid 3 line removals in patch 11. Patch 12 is only makes sense
> > after patch 7 and I think it would lead to '-' lines if coming before patch 10
> > since both increment the number of IIO channels. Anyway, I'll see how to further
> > reduce the number of lines being removed.
> 
> My point is that the above statistics is mangled and I don't know how I can
> trust the contents of this series if it already lied about that.

Looks like git format-patch summarizes the changes from all patches when
printing the statistics to the cover letter. Also, git format-patch doc [1]
says the 'changes' dirstat option (default behavior) doesn't count
rearranged lines as much as other changes. There are cover letters of other
patch sets where the number of '-' lines don't match the sum of lines
removed by each patch. [2] and [3] are examples of that.

[1]: https://git-scm.com/docs/git-format-patch
[2]: https://lore.kernel.org/linux-iio/20250630-losd-3-inv-icm42600-add-wom-support-v6-0-5bb0c84800d9@tdk.com/
[3]: https://lore.kernel.org/linux-iio/20250627-iio-adc-ad7173-add-spi-offload-support-v2-0-f49c55599113@baylibre.com/

This set doesn't remove stuff that existed prior to it so I think it makes
sense the cover letter to show that lines are only being added.

I'll send v8 with the change I mentioned earlier. Unless patches 11 and 12
already look good the way they are in v7.

Best regards,
Marcelo

