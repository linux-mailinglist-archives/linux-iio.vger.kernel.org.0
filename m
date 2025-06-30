Return-Path: <linux-iio+bounces-21140-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F84AAED223
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jun 2025 03:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 574BE1894B87
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jun 2025 01:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74A9130A73;
	Mon, 30 Jun 2025 01:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Vw7XDZY2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E674F5E0
	for <linux-iio@vger.kernel.org>; Mon, 30 Jun 2025 01:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751245806; cv=none; b=Y0EmkI5hBUH+ud1yf5lhRbrTW0jdvN1MpiAx8a/P/EFXsFO4Qy//C9rp+Sbe0u0YjdK2YZ0k5SjdaXM/Q+QfxbcCKFmLXKAUE0zV+ASvEZYzuW/RBEwNAtH5z3nB9/x2vnbsseMp0giVlqNuwWxHw8kUKHHQX33+H17yTuyV8to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751245806; c=relaxed/simple;
	bh=7ADJAQfR2OvRUJxJ2i5My0GkntSVnVVUhyq6ffxNAtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2jF7KjIpGbwx8eImoD3nKQrdhzHz+FZ74gC83hYb3v1z03U0yFX/bOMd1uLh++m+vCcKweIvNII/yM61ALHLO1QirzOK5MCNzWKHT29ikcN9Bi6qg/pFTOSs/isxtrSiHOt8rZuAfjydBdJVqf+lILLtBIqh2Py3yOdwdZ6teE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Vw7XDZY2; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2352400344aso34728955ad.2
        for <linux-iio@vger.kernel.org>; Sun, 29 Jun 2025 18:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751245804; x=1751850604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uv7SvOY2KGW4wtTGtop8K/oyy0HDfxAOlONEn6vtf5c=;
        b=Vw7XDZY2oNr87RBFNR+RyBJJZ7auBunKxmoYfFVjzC9MJ02HfFWIxJxYV7O6X4QL1m
         T/r9s/54qM5spCRa44iWY2w2cC3KZ/7cpJiGB+tqiuh5iRis9hNMLDOv9XBDuRbqMK4B
         iW69zJpAiWjOqUgoxXz+RymAiHgAfvQI1oLF4WkTrJGUS8id11QHLClvXlTFpl1CpN5o
         86wgWQLLF1mwnIPymSgYI41mWjetyOwtVX8m3026y20sbxOBY7g5F5l5ppcbuviZcS4f
         WtZqpvbro+9u5sg1Z8fziHezs/D+VAZxvVQ4Zr1KNRiWX2xeKKLjwE3/IQvF018XKv2f
         ZZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751245804; x=1751850604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uv7SvOY2KGW4wtTGtop8K/oyy0HDfxAOlONEn6vtf5c=;
        b=C7vkopaQrVrQHUXzWe+20RnCRYR/xBTo9zfKM7W8p0/xeuo/UX2rGKeuh7tWDMWp5P
         q4ky/HxeuySnhABZ3R2dq2KLqXJ6td7AASb0g69kGVHpMp5FQNSvcXuB1O8I6KVcFqI6
         SmfGjarLYulghz9SpT/OYYroOOvn5ybw5aHjv7XfQWap8yxabd09az/9GUfYHhq45YCq
         y2vcJX2YL6hyERybh0PWxo6tysCSugh9vDLtAFKErT1r07RXa4mZgXngH3h1s7ulyZQr
         DCW2kbyFGdABcPl8OArS5AgmEEA5860DQcM26PfhNL68VfqYcqi6iiIB2MqohPxThE4O
         ra2g==
X-Forwarded-Encrypted: i=1; AJvYcCXKlXKGw4KOKTELZUm2cWJCePwItzhebuzsXd/x+obniJOS0+gDI69WBUpcfgKArmPPE7H8r4/HOxg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywylqvv5UF3l08tJFPOrpKpjEd5imNfc6Jl7RUMKqvZfcg+VTHh
	kVs3LrvuPTNVl7jW3dPz1FSaECQqW5Ce6AJlheMCeyNlwctKmGl7Y8/DXFbtfp6XqJ8=
X-Gm-Gg: ASbGncut8HLBQSGTGwYFkd4BP4d9zGLdUCr0sHadz86QHMmMOVinwU2ZWzywsdlReP+
	mtWoDFGyhXRw2O4UUuCgJbB3rLjMrIc7SDI1hY3s9LmEt/2EG6JAAWIQmwYvASIKCh5MnJtNSdx
	NHVz0WLuOmqr3fm8zLwD/hFL3lQmTH0QDw/dClo6S2Tq4IRJufx3Ll3bsXUVP/ErDH5QvmnUdDb
	jr/NoCPVZbovJ+yZUdGq1JbpOmST7GAin+/kUC6MlZpTmVlkTagvAYQTfV25abkDzCQ5puZgnW4
	50hSDRGXEUNPS5syoi4hfJkiPwP5zj1CZSH4tXK+F6Hm4HA4FCIoxCmzynF5+BpgBYqARDGH7lH
	jA3VVvKq7MAG/ma0syRXbdA4dsHxHhurp
X-Google-Smtp-Source: AGHT+IELVrA6xYh6a/9VG+5oY6f82d45viFI7VALj4GsK0dysu6/rXcokuZJ87CxZLgjM/7f+MW7vQ==
X-Received: by 2002:a17:902:f745:b0:224:1af1:87f4 with SMTP id d9443c01a7336-23ac3df1e80mr190330525ad.22.1751245804018;
        Sun, 29 Jun 2025 18:10:04 -0700 (PDT)
Received: from dev-linux (syn-076-088-115-008.res.spectrum.com. [76.88.115.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3b7a47sm68924625ad.166.2025.06.29.18.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 18:10:03 -0700 (PDT)
Date: Sun, 29 Jun 2025 18:10:00 -0700
From: Sukrut Bellary <sbellary@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Angelo Compagnucci <angelo.compagnucci@gmail.com>,
	Nishanth Menon <nm@ti.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/5] iio: adc: ti-adc128s052: Use shift and realbits
Message-ID: <aGHj6Ki7YjyIMh5X@dev-linux>
References: <20250614091504.575685-1-sbellary@baylibre.com>
 <20250614091504.575685-3-sbellary@baylibre.com>
 <20250614142743.23ee2203@jic23-huawei>
 <aGBKMcZGYOcXmKdB@dev-linux>
 <20250629172655.209e2bd2@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250629172655.209e2bd2@jic23-huawei>

On Sun, Jun 29, 2025 at 05:26:55PM +0100, Jonathan Cameron wrote:
> On Sat, 28 Jun 2025 13:01:53 -0700
> 
> > > > +		.type = IIO_VOLTAGE,					\
> > > > +		.indexed = 1,						\
> > > > +		.channel = (num),					\
> > > > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> > > > +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> > > > +		.scan_index = (num),					\
> > > > +		.scan_type = {						\
> > > > +			.sign = 'u',					\
> > > > +			.realbits = (real_bits),			\
> > > > +			.storagebits = 16,				\
> > > > +			.shift = (12 - real_bits),			\
> > > > +		},							\
> > > >  	}
> > > >  
> > > > +#define ADC128_VOLTAGE_CHANNEL(num) _ADC128_VOLTAGE_CHANNEL(num, 12)  
> > > 
> > > I wonder if it would be clearer to just have the 12 explicit in each entry
> > > and skip this two levels of macro thing?
> > >  
> > Do you mean to pass realbits to
> > ADC128_VOLTAGE_CHANNEL/_ADC128_VOLTAGE_CHANNEL as e.g.,
> > 
> > static const struct iio_chan_spec adc122s021_channels[] = {
> >         ADC128_VOLTAGE_CHANNEL(0, 12),
> >         ADC128_VOLTAGE_CHANNEL(1, 12),
> > };
> > 
> > I think we added 2nd level macros as ADC082_VOLTAGE_CHANNEL,
> > ADC102_VOLTAGE_CHANNEL, etc., to have a visual distinction for a different
> > part nos.
> 
> I think as we can have lots of parts with each resolution that will
> end up confusing.
> 
> > But I am ok if you prefer ADC128_VOLTAGE_CHANNEL with a second parameter
> > as real_bits.
> 
> I think that's going to be easier to follow.
>
Ok, I will change it in v5.

> Jonathan
> 

