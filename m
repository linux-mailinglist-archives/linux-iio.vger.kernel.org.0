Return-Path: <linux-iio+bounces-22016-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2468CB11A77
	for <lists+linux-iio@lfdr.de>; Fri, 25 Jul 2025 11:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC59FAE1472
	for <lists+linux-iio@lfdr.de>; Fri, 25 Jul 2025 09:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62CC2594BD;
	Fri, 25 Jul 2025 09:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xdl9VBcV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B17254873
	for <linux-iio@vger.kernel.org>; Fri, 25 Jul 2025 09:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753434260; cv=none; b=OnuTWefVBHXZMk0FmSqGywShTGptelKkaC2bg30pJuaWyxxPjHpsd1VClINwudLTX0Yy0fFdb20ZJcSlw1CwS6fXiIyCwQkJi3geNU+RsSI4G61YjWZW95yBq8kHOP1P/LSc1PAjtdLkjKeTK819x4rEb/c7hegl9thQENRfsq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753434260; c=relaxed/simple;
	bh=SdTce27tnNl2VaQZ34uRuiDgpAETwj3Q5UHnB/ZeIF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fe36WM3MNin9PPxlAxQ3zxjgJ0vSFloNSWC6nzkmRcWP4gEjgaVe3cA/BWfKQyleNKilBSd7oEIcaWWlPdX4puJxthvbGDeOpYNCJL3KzqTVcZL+EmfmFsx4LG83w0yEgGrPMqS+z8HGes7119vvwVFK+T3c/Hj7PbCxDNowJjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xdl9VBcV; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae0de1c378fso258102866b.3
        for <linux-iio@vger.kernel.org>; Fri, 25 Jul 2025 02:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753434257; x=1754039057; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m3QCs/VNwfIL6R6Be8bLzCAikzZ01MpzWZBS7upZ78s=;
        b=Xdl9VBcV5bV5+jJzAuxV6fFJaaDPMYozBHHAjbyfyEuz86G8kv10T69GJXmrAn+kDv
         Uh5E7r/3cOIp9MB8sOi10e+5+5hp4eB4xwjQAhNln7eqChCFp2b4Y+/rjvhcLY3ts30o
         sW6n2b8ob2H9TKefGF6QucypsOLQvdky7rOkezkqeP9PWn1jkjLjQH9RbxdCPUBWBzC7
         5En8MvQnITAlSGy7DhXaEqDj2fikOvmyUpQA63L1rwhf+uNXMfk9mS+wBr+QIknh3DKV
         U+E11L2Rzk140fAVnaLO6pj/c7Kn/Ok/uPVr8NL83a6Mfkv46AWasDfKBK/O4I394i/G
         KB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753434257; x=1754039057;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m3QCs/VNwfIL6R6Be8bLzCAikzZ01MpzWZBS7upZ78s=;
        b=lplbniGAcYZkHs7VfUvfdjtM1sWD07QjmvzE+OirNj6ZjkvKBwhXY+tUv0a84VUlOr
         JjPrFT6rHIINK+FJGvnfsgqxrUx2SMR7QXgsFdI5fAQn2OO9acwoAJusmid4BXmIz2Wc
         jfKNzvSYjRRJeQkQ2SsjOEOsrAMxhg0pcQRJPerskUvYxSaY9G+J3m5Ij8GHgdibGO3L
         vd8afGkLt67FvyfxuGb+Ng1crpOYKKD4Jh7cwhA5Kj6q2jEX2NbSLl4mB8aHrjpiVj7v
         jP8iyJO79OGNCIpKH+jKyAwkWMI6Rw1Kw3gQGKp01Ky6Ea60xll2TVLhmNUP9/qVUjXv
         lTdw==
X-Forwarded-Encrypted: i=1; AJvYcCXoAWfl6eZdQVomXUmK+4YpWKY4P3KizWei3XeQRKeJ0rAilc6mTyPeNQ3OnEmW2qQREmarhJph4PQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXYgxF+0BGpr1ONUxIYzXsFLbMEfCSWzy64v9GSWQPf68M/H3y
	aE36tbGIfM74j8/eqEpTkHEN/n3t/TpR8C551Ri05mbyGZFJSyDwU0gz
X-Gm-Gg: ASbGncvcYWM41tS4Vs+/EuYIflx9P5IrBrZNmm+/3MhSojxSQHrdXnwlYMZ/Us0uPEm
	bCZ04PxyktZTjLKWzEXaaPctElzRp3vJ+Kvye8J/b51paMGOvtu8D/ohKqg3ab4uSil0Jpvfo8A
	0RmOLenW7XQARG14CsJ6Qt/h190tTHnGMJZs5A9cRZfsUZGxE95R33IyfuHmb6BCj7RemAWJ3+S
	8q6ukcUqmrQTDoAxUa4darnmwraMwVbQ+ZAoPYIIxQFjXkZu1g6I2eA3DLt+lrE0lpQCW2twlPP
	3ltBhnJ/47bsZGX7RsHqgbNXiRB6XBovIUAHiEJksicuzVETw8m8jEADG3uak6JOFrP3jJ+yhNc
	xYaaK4CV+SvGZ
X-Google-Smtp-Source: AGHT+IHuKTotlwqmHtchQ1r4AuwoD113uhcuP2DWu5wXiVttc9/+mQpdDyFrLylleOAQmI14LyZ6Dw==
X-Received: by 2002:a17:907:dab:b0:ae3:53b3:b67d with SMTP id a640c23a62f3a-af61b0f99demr132731866b.1.1753434256870;
        Fri, 25 Jul 2025 02:04:16 -0700 (PDT)
Received: from nsa ([95.214.217.20])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47c58bbaesm233252966b.30.2025.07.25.02.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 02:04:16 -0700 (PDT)
Date: Fri, 25 Jul 2025 10:04:30 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] iio: buffer: buffer-cb: drop double initialization of
 demux list
Message-ID: <5yxun6jqws6j63vcaf7sxgyqevwt2nl47vdptm6vpgsffb5ro4@kledo6joqctj>
References: <20250725-iio-minor-cleanup-v1-1-4e561372142e@analog.com>
 <CAHp75Ve-ra-SbLv0aV=xaC8pLxGUh54v8rx6GHU4yeDtm8=Cbg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Ve-ra-SbLv0aV=xaC8pLxGUh54v8rx6GHU4yeDtm8=Cbg@mail.gmail.com>

On Fri, Jul 25, 2025 at 10:47:19AM +0200, Andy Shevchenko wrote:
> On Fri, Jul 25, 2025 at 9:32 AM Nuno Sá via B4 Relay
> <devnull+nuno.sa.analog.com@kernel.org> wrote:
> >
> > From: Nuno Sá <nuno.sa@analog.com>
> >
> > Drop the call to INIT_LIST_HEAD(&cb_buff->buffer.demux_list). That's
> > already done in iio_buffer_init(&cb_buff->buffer).
> 
> LGTM,
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> 
> ...
> 
> >         cb_buff->buffer.access = &iio_cb_access;
> > -       INIT_LIST_HEAD(&cb_buff->buffer.demux_list);
> 
> Looking at this I think ideally it would be nice to have the buffer
> type to be hidden from the users and only available via
> getters/setters.

I would say it's arguable at the very least. The buffer callback is
itself a buffer implementation (extends the inner buffer object) so it
kind of make senses it can access it's internals via buffer_impl.h.

Note that 'struct iio_buffer buffer' is not a pointer in 'struct
iio_cb_buffer'...

- Nuno Sá

> 
> >         cb_buff->channels = iio_channel_get_all(dev);
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko

