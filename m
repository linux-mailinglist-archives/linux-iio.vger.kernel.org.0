Return-Path: <linux-iio+bounces-27437-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1020DCEC4E8
	for <lists+linux-iio@lfdr.de>; Wed, 31 Dec 2025 18:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EA303027A47
	for <lists+linux-iio@lfdr.de>; Wed, 31 Dec 2025 17:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF9B29B224;
	Wed, 31 Dec 2025 17:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxTn50LC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3932F29AB05
	for <linux-iio@vger.kernel.org>; Wed, 31 Dec 2025 17:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767200521; cv=none; b=uzmVJC800k5jBmocYhMOs+cvvKYVUpLY+zvQgrHdfxI2JcGj/x7miEoLXIvDNdYvy9+nluRpF8YrbEFsE2n9sFH+RE3cvyfE7YDFp8PaayYuxj73Z2y2cXzipLsIj4IIqyP/7QtLjMqSayHQ7nTPxBaVVmcZ63V7WmlIZMTsKnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767200521; c=relaxed/simple;
	bh=mMLXhdcXOwdpuZU87w5b677CUsxr6DRjENU/LavuC54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USBpD5upiB+dWGVWzws3oPmrq4jW2pvXg92r8iRHZfIiTY2JsZEJ9qDiACFavw/VOsl3Ot+G7SkN54kYeX4XpL3Dim5jCxOA8DjnBF8W/cJVsn+UE8Lq34vdOYMVACQGEiIW5K6BQo649gRULHsYUbYuUQ7GzHmmSplFOwVvaok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxTn50LC; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c03eb31db80so8262497a12.2
        for <linux-iio@vger.kernel.org>; Wed, 31 Dec 2025 09:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767200518; x=1767805318; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oMn3cw3aEJ0zmXtOyEFlwSR70FDkFEfYpJtDF+IchA0=;
        b=hxTn50LCJpyniVlm/1qglwaG+ZkjB2KjLWMeg+e0zJrCE7ZHtrvXBjAtMS56VflSdF
         gKEJf8Tcd6dCBBW4s+YLFMaCEZY3GQsTdmfVlZFR0onf0poTUbfmp35qi+KuwwgGVsKP
         Q07TaHnjakkgMTuTCdE2egA3dfEtgkz0BzbhnT8s0PRHyJuH9aUZvNq8X4x9BhA0RvXH
         FKvsNRWdNdk4fudGwcJzQc0GzrMc3rI3l5CEfvKvWdRdq1idwiQ7OLb9UGDGPfoOb138
         YuNj8BD6ibObat+1xL7QdL2w0kNUElEEBcZ5D2NP2Jl+BGS97z0TEhetfR46J6Vaj2Tp
         ArbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767200518; x=1767805318;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oMn3cw3aEJ0zmXtOyEFlwSR70FDkFEfYpJtDF+IchA0=;
        b=rQwM3uTJm+hhJbLbk14wfEOipTxW/N63PQWMTiPYhdZM1UEJIwdLVZN9dqc07dpgvg
         CXw3PjkQ9ciJ6vSJqy5jJd7tUJrm2xRKjyvuijGI1LTV4cODQds/0x57iwaNLC7tYHXY
         dZPEyU7OLy39ygbPI6iLlK3qrPVUUASO6iWdBdHxCx4IQQchY+Rvxvc7prRZce6DlBzI
         xJDO5BXPrVla9n5IUP9dtDeeDY0gYHOHaYgOkJ2QsenEfbAvq4klNBsuRDL45S/sunjn
         56I0lghNXjVfgCT2J0OC+Ul+rD3iWZz25nnHXOdbilNlv+1/hEdCYrZYpiMNH8ZxlzwG
         1SxA==
X-Forwarded-Encrypted: i=1; AJvYcCWnYaJIieTlJOdBDTj/n7TWMJJ6gvxh9W62CO/y2iAYdQuEon1brgJa9oSByCBp0D2tdEzXMjn+Hjw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgm5t7bK8PNZTOEGXksf6uhL48eQtKps5dmRJjRdpitFo0ad9g
	dWcyNkFfAC5/i7rLhwWkmSX1YgoGTUYk35GPL9BxPQt66A1ihkbStZ8W
X-Gm-Gg: AY/fxX4CjAar9eiOqgC2DrpLBkGmlEwoN6eNDy765n4PEWHqAfrP3laVXxUulJsSOdA
	OD7JjjSTqzYevORFPEdirQPkWqU3Ni2ouoJNK1i290vj9cmxUlL/daTjJx3wIigM1yQqZIm00hi
	HfdZ9yk50D5tYkRqJ1r88lgjTuwm/E3nWNb8vPHX78z44/wawylavNwi5oXMO08bEg2enop3RjS
	5q7Vhb3BVBCyhRoTH56SQQ/R5WCDWXtrRqljRGuaPvBCk4u3SHzTVNWKUlRyjn5MUkFlKas92kY
	I6+GMot1NSAP56Jb9S8eoEscjgh9JJ3T9DYl+GJcfZcQBsytcYKI+wkcmA1NRmeOaRe7JKxn4r6
	lX4yZCtxxJHSvVqwmIewsdCIsfmWSIGCeD6uULuUcxdBPreshkJAR990k1r494SgimayEwbgsK/
	WI6WrOg9MND+cUrW4+Z9w6P2RPR84CcOOKuKJNMrSbD97QFiB8Vl2dYuFLNA6H75vCpyyGNifld
	JRHwd5ljjT90XP/M/6nxddGopMuDk1G4+58cFslzSgGkjSjGKzf2RJjtw==
X-Google-Smtp-Source: AGHT+IF5mMpUD3pGQhLGo8FdZ19mzbX7DDGvuk4xC4I4c0/qd0kwTCUg2LNoLn0QjKrxDnW1BcRvoQ==
X-Received: by 2002:a05:7301:3d17:b0:2ac:816:f31e with SMTP id 5a478bee46e88-2b05ec551cemr33300066eec.29.1767200517932;
        Wed, 31 Dec 2025 09:01:57 -0800 (PST)
Received: from localhost ([181.191.143.75])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b05ffad66fsm83064745eec.4.2025.12.31.09.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 09:01:55 -0800 (PST)
Date: Wed, 31 Dec 2025 14:01:52 -0300
From: Tomas Borquez <tomasborquez13@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 2/6] staging: iio: ad9832: convert to guard(mutex)
Message-ID: <km4v4ql7l7fra46c6ptekgfli5lfw557edim6w4klu7tn23jvq@grgvfyeyq2i4>
References: <20251230203459.28935-1-tomasborquez13@gmail.com>
 <20251230203459.28935-3-tomasborquez13@gmail.com>
 <CAHp75Vcr76Z=npXr0pu57oCrgmSWsLO4uB9qKLmmxSKap4R9MQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vcr76Z=npXr0pu57oCrgmSWsLO4uB9qKLmmxSKap4R9MQ@mail.gmail.com>

On Wed, Dec 31, 2025 at 12:50:54AM +0200, Andy Shevchenko wrote:
> On Tue, Dec 30, 2025 at 10:35 PM Tomas Borquez <tomasborquez13@gmail.com> wrote:
> >
> > Use guard(mutex) for cleaner lock handling and simpler error paths.
> 
> ...
> 
> Don't remember if it was in the previous rounds of review or somewhere
> else, but Jonathan (? IIRC) suggestd to use
> 
>   ret = foo(...);
>   if (ret)
>    return ret;
>   break;
>   ...
>   return len;

You are right, I should have sticked to that one since anyways I ended
up using that pattern on patch 5.

> However, this one just duplicates what is already in use. Have you
> checked the bloat-o-meter before and after and see if there is any
> difference in the compiled object file?

Jonathan's is better by 7 delta, so I'll stick with his

> -- 
> With Best Regards,
> Andy Shevchenko

