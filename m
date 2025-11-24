Return-Path: <linux-iio+bounces-26412-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 72542C7F9BB
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 10:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 70B754E4F7A
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 09:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8B42F5483;
	Mon, 24 Nov 2025 09:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZdtpfeP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92C9263C8A
	for <linux-iio@vger.kernel.org>; Mon, 24 Nov 2025 09:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763976269; cv=none; b=gMLyabfddCksj0glad5XWgz174S51c4gnDoCFOiewDKYuKsN/g+KAqcsIybE8myU6SZxrbEINdQC+TjnWSbQWw7hOIrblZCoIC/fEEcxwW/bJgIZM0cQz9caAMXu8zBqyVm7pJjZVz9GPNeUulfIbWwgCp5JTgtvlkj1ELpQYh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763976269; c=relaxed/simple;
	bh=P3TNnHmbMQ7RiZfj11COEtOadWn9ZwdSOUvW0u0Lo8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nb5gBV9dFSzvJpNKMWl4zoudPxaBS1FXBIdfUOJJkGyzzgzXneh2X1JyBHDhF3R+PjNNyO6DLJWeSTTCmZLLSt/O4A/BrqbKlODS+nnug9e/hJ9acNazPJhXTAhM+SLtihxPHcgFW4HRmlWE7M3KdVY8joSINcLDxaaoK0WTxUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZdtpfeP; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b7291af7190so595887466b.3
        for <linux-iio@vger.kernel.org>; Mon, 24 Nov 2025 01:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763976266; x=1764581066; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=slSocduRhMtJsbQHXkMC9k8pMNaviAqpRIeDggJm8mI=;
        b=ZZdtpfePZFfUT/ZvhU2u/xPyRTq5AfkmYgwBxMgiIm7eNwOoFh9ZRn0tZvJR7Js6bv
         qyaRbzaYX6bvV3RvEsVZm9GQDMRBdu3iRP9eJFDv5Wl2HtYi0i49qYVJA7+2cTVlIPRX
         Lj1AQvJit2VCRos+jwBKM7u2pqXsbuJAaTJ4iZJ6yPn4X81ufl+9M8c8vmCQmVo67kHM
         u7wsRiB1AJTQ9L4ETsKRRXA2AkJKdzSAoM4NbvGh0QP1uwPAqZMZkOCq4LGgCHUhhwMX
         Je8I2P2viPlA2uIsQNLZs2Fwb6gDLY+Cur9+XIHp7LkZyEVBu+X1J0L4XQp4YVzIpUNa
         s6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763976266; x=1764581066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=slSocduRhMtJsbQHXkMC9k8pMNaviAqpRIeDggJm8mI=;
        b=HwftBhQi2RTzuvrRI7NF07Bhy1OhIs6ZqpE0/pui+2oAqj7imwmOYj97HDEiJI1RCi
         VS2DyHbvO41Tx73/LAwjaIEO1JCnotIV4N5HHNODq0Ah/8WFi2soioxzUTfNkysV5Wwl
         p3Jc+bXqFhzVaT6tkyC6p5Q0KcFryU6P9mmggGchQock5Co4orBwE/8d3elW4ysgwisI
         NAeLFLZTBLF5WyK77aLbJvF6SmV04bjtLHo0nqLjNaiXr2b5FhoYAJ+Od65QNqV2xXYD
         mE8ZNFZmcD7nNiaHDE2/wB6L51/JYqplBgZC8dDbMV3E63sBiATvN9A/xQqWP2svlwgX
         98TA==
X-Forwarded-Encrypted: i=1; AJvYcCWFn1fMXT5/XiRmBNFtBws3leeXy48I+pncqgjJDOu25Tb2fTbqtcC7WV/oL1Yx41EQ17dGS9fqYK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYtQoDjnJngQXwagrwa8HNBbw9Qh6nVinAIRqg9eBp9xdfJd2v
	HV107smrhSBv09bDlkTwaqL7nZMfjabGX+ZxDrgtq/Rqt0fJNEfp2nb9
X-Gm-Gg: ASbGncs8ZEGFdbT7t8mgxz3P1ryBt1kfgwnc2lc05R5WNZUHPDf5oE1FsXkAanztYCp
	/rZ/FgTg2gNxfmFt6/41OfId4m6Yk4Up+pdvE1vRU2hR2bMdpbPA6X1BQBnk4C0QkNYriYnKiNv
	OEK+mVBf7VNIK/mGe8+AW0BbR7Kl3ZB09TksmJvR74dJpbU0RDL9xme97HQUMD9nOB3SyOnxmRl
	rDoKuhojiDsW3VC3lcwstbO1XVIHKkFWqbbNU82qFOphQrqhk7DlBajN+0J2Zuda3J4mjI7ogMu
	1g8UKvjy9PuXYfTcjRPh0pb9FrbppNZj5Y2lEDuvc++5E0EtOpMRDbi4PPrE8Yib0GJ3zqJfrU/
	zB71z7JQgQGwMHm8HeRynV2YLHw01Ev2m7NVvoxANYD7ZlIBLplUwRKl5suB4ivkZ+TGPExkTFU
	Yl3yGDA1ro3sTgq3Y2kuXzf1RtMsJphAGo3E4J+TFRbV+q0KF0ErXIXMNtjbfgKtRPkap8
X-Google-Smtp-Source: AGHT+IG43taRGXlMb7A2ZG4Z0Lz7XxTi1f/W9lGskn1Ni6JWJYwXfKHzRtFJ/vmRNLd6ClmF9wOYDQ==
X-Received: by 2002:a17:907:8e96:b0:b47:2be3:bc75 with SMTP id a640c23a62f3a-b76718ab22emr1047239266b.60.1763976265537;
        Mon, 24 Nov 2025 01:24:25 -0800 (PST)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([2a02:3033:267:9a21:9532:f12d:5875:dc2c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7655028400sm1195719166b.56.2025.11.24.01.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 01:24:25 -0800 (PST)
Date: Mon, 24 Nov 2025 10:24:22 +0100
From: Jorge Marques <gastmaier@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Jorge Marques <jorge.marques@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 3/7] iio: adc: Add support for ad4062
Message-ID: <m4a3o4fbs5bhsru6fsmik3qtthvit3565lkp6itjyqzjbd55hd@whjpvtn7xngm>
References: <20251013-staging-ad4062-v1-0-0f8ce7fef50c@analog.com>
 <20251013-staging-ad4062-v1-3-0f8ce7fef50c@analog.com>
 <20251018171032.144a126c@jic23-huawei>
 <ou6qwayt4g7qaoe5dm7tdg6jl5dwquslpfbok6on5r2q2wytyl@wlqxj5y6ircj>
 <aSQMjZbc75cQtFqJ@smile.fi.intel.com>
 <o4kt2of4xql4azufjgiecm4jzuexgm6nkvr7aghbwfk6qd7yqd@r4plggehzces>
 <aSQhTd5Z7KyvHtbG@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSQhTd5Z7KyvHtbG@smile.fi.intel.com>

On Mon, Nov 24, 2025 at 11:11:41AM +0200, Andy Shevchenko wrote:
> On Mon, Nov 24, 2025 at 09:57:26AM +0100, Jorge Marques wrote:
> > On Mon, Nov 24, 2025 at 09:43:09AM +0200, Andy Shevchenko wrote:
> 
> ...
> 
> > I will submitted v2 shortly.
> 
> I think the "shortly" is not needed, please take your time, this seems missed
> v6.19-rc1 anyway.

Hi Andy,

I was submitting when this reached my mailbox. Still, noted the comment
on your next e-mail and no pressure on the release window, I just didn't
have further changes for this revision.

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
Thanks,
Jorge

