Return-Path: <linux-iio+bounces-22620-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D083B22A8E
	for <lists+linux-iio@lfdr.de>; Tue, 12 Aug 2025 16:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B92E1BC7CCF
	for <lists+linux-iio@lfdr.de>; Tue, 12 Aug 2025 14:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2160C2EA140;
	Tue, 12 Aug 2025 14:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ByJWkm5E"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7882C2E9EBA
	for <linux-iio@vger.kernel.org>; Tue, 12 Aug 2025 14:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755008065; cv=none; b=tO1rLKPSbUUL9+1fayMsNu4Lor9jFJohN15jxqhs0Q+paKQMzw8HuyYv0rJZyIToThsm+Dt65VO9aoKATpYFQfsbcK4fcb7Jozju28ttzE0TOAyjBTnxOx6VpUcEaLtmZHW3bFaJcuF1ulXqAOqBbEzBU/oXPU7VjnpLiOWsOWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755008065; c=relaxed/simple;
	bh=VOrN2ubbBIqZL6ACC5YLGsBML4O76tGsoWugdQXqhFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=s5uODbtVdv9Qkm9CycpepPJ1xB3sH/7aK8ucmB8rjiy07kzgumDDbsOBPCK/7Ez2e35ZCC5CNqj9p3cbdJIrR+5Gkrm8GusPOY/uCOTC4jbwDcuGWuA/c+9CXnLl8b6uK+yNO1FcGslTPwLYyNOvQDkSBwAZ9Kg8aTHtxMai5Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ByJWkm5E; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-433f78705b3so3755401b6e.2
        for <linux-iio@vger.kernel.org>; Tue, 12 Aug 2025 07:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755008062; x=1755612862; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S9JFvODxrp3INgeLQ2lh71r04HRljjS+BMggYVRuom4=;
        b=ByJWkm5E1YS4exYdd/GQJvLbGdzJRRpUG+aGqy0c88CR21g+5gVtCXA4jD7MPXQiLc
         XChJLMLLWjT2vI4X2hZrAi4vpg4VLl60PnNrdioQq8tdriiQsRtcCH7eu0d9eJvJM95m
         pJOip0vDu/gQrb1+XaXtf8FBZRNTYufLx7weSuyifSsygposJ4+XrnuCbq/5QAm0YP1a
         vL4YVFEaFzA/r8oirETR7A44BxAXwkKT2f7sZ8dx3aJ8eztaSLbme2wYc4VU2TjcgTLQ
         gojraIENTLlRHz/5Sz8qORB1VUbH1Tf9TCUFgAHgxSHD3JNcw6LdbERjlIeQGtYjOFgM
         AoLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755008062; x=1755612862;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S9JFvODxrp3INgeLQ2lh71r04HRljjS+BMggYVRuom4=;
        b=nvRp6aD1lGBLU1ulH+73iWSiM/QgKfN3p8mFJ361Ioza1IXjyfEiY4Kek9YrRzIK0r
         18UYfmwCl28q91QL/2BmEfEbNUy2JWw8P2Eg1jxsFtQKN25ie3+o9chmcFWQuII/rmvo
         S0G7CNRHx3bMTtah7mWl9Yh043p4LceE2/rr4JE7CaH5oOdRVFosrI0x3GJgOrtczRx0
         VrNGvfz296UmpHZrpVfKo7iHTkiT9z9avSrysXZOpf4+iuzPsk4QVRLaHU3sRGfKUL6B
         Rf9fz87/szfru9UY3G9YqtjlDwtM6dkW+RXdD+xlH6qIS4PgquBm2gipaPY5flFTRJ1/
         NUfg==
X-Gm-Message-State: AOJu0YwV8OUhI7NoGfE5qjoZNJsbCBZ6ghoE79Vufz/TaBoKCvluZaUZ
	DH2i7DWwXuSygEZ1jlh4VORtH1GUq3h6XLZicoNHccmhAFW+DS982Q1yJyvY/YEOU7SM/Lrm1Qo
	3rt4N
X-Gm-Gg: ASbGnctVWQBR29KLdac3sGy2QHCP5eE4fQddFWkXEfF6k/FKBpoGLg377l3deS9LFnL
	mToB4cd4Usjf53Z3DUGbXWQUYYXjU6x+onBE3ab3lXpurr0GGr2knrjsGGVF1aWlztTdrv+7k9e
	l2J5+FQyC4EnpDZz9Uzhm741CwA89pzA3tj6KBWh028Noz1rjp/ovUj6oO1QB0JFusHUp9Xz93N
	lEZH1MFJP+BsTk6cqDhYi4GRyFQVnNp3tXQdhpUvMhZ0BLQCZuQliHKpG01dLOlohI/TzGnBpQi
	7i9S3Cx4pvdE8QA5wovYW6KRqlpNU5pXdfipxN2JFCtq8alGDGl23EWDz+HHp8HMceDXU10HWvz
	KlW6cunfWWV30R0UxNLsfpozojNe2/1J37LfE9RiTbZtluJS4WQiWIskcLDMB+BPEa5kmlOMP7U
	Z6Px5dH78QlQ==
X-Google-Smtp-Source: AGHT+IEtoJxvREztmmLyayeVebmTU4emvKlWvLczPhI9CWi+q8javZL4aDKPipxHraD95DmGO59i1g==
X-Received: by 2002:a05:6808:1527:b0:434:a19:b926 with SMTP id 5614622812f47-43598024f1bmr9898701b6e.37.1755008062424;
        Tue, 12 Aug 2025 07:14:22 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:1fd1:71c7:ca6b:f533? ([2600:8803:e7e4:1d00:1fd1:71c7:ca6b:f533])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-435ce8efb8bsm194220b6e.36.2025.08.12.07.14.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 07:14:21 -0700 (PDT)
Message-ID: <36e135d2-0952-484f-ac6b-b753dbc1b4db@baylibre.com>
Date: Tue, 12 Aug 2025 09:14:21 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: iio_format_list() should set stride=1 for
 IIO_VAL_CHAR
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@anaog.com>, Andy Shevchenko <andy@kernel.org>
References: <vidvwybkm3vwmtopihyaj6tlvswwa5ixmgptfzpk5ujl2ixjjb@olz6275ftabs>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <vidvwybkm3vwmtopihyaj6tlvswwa5ixmgptfzpk5ujl2ixjjb@olz6275ftabs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/12/25 6:12 AM, Ben Collins wrote:
> iio_format_list() sets a stride across the val array of 1 for INT
> type, and 2 for all others. Add IIO_VAL_CHAR so it also gets a
> stride of 1 assuming val is an array of integers with char type
> values.
> 
> No drivers currently use this, but I found this issue adding an
> avail callback for IIO_INFO_THERMOCOUPLE_TYPE for a driver I'm
> working on.
> 
> Signed-off-by: Ben Collins <bcollins@kernel.org>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: Nuno Sá <nuno.sa@analog.com>
> Cc: Andy Shevchenko <andy@kernel.org>
> 
> ---
>  drivers/iio/industrialio-core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 159d6c5ca3cec..eb6a54f8115de 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -790,6 +790,7 @@ static ssize_t iio_format_list(char *buf, const int *vals, int type, int length,
>  
>  	switch (type) {
>  	case IIO_VAL_INT:
> +	case IIO_VAL_CHAR:
>  		stride = 1;
>  		break;
>  	default:

Reviewed-by: David Lechner <dlechner@baylibre.com>


