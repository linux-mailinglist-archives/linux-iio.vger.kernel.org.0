Return-Path: <linux-iio+bounces-26198-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E00EEC5A41C
	for <lists+linux-iio@lfdr.de>; Thu, 13 Nov 2025 23:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8EBA64E16EE
	for <lists+linux-iio@lfdr.de>; Thu, 13 Nov 2025 21:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9463324B3E;
	Thu, 13 Nov 2025 21:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEIqNwYV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F55322C81
	for <linux-iio@vger.kernel.org>; Thu, 13 Nov 2025 21:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763070910; cv=none; b=WngnSx9cYr5zHkB9acMFyWcF14FIqJD5nTM3iiFTyWKAR5DaGiXXkgh/ALcJu9VSBSoc5t+QSpHZLOgpPRxpHCAdEn9wqlgYLmHan4b8XhPQ8F4VRe83Q1Lv+5Pujpp4+V4kP6YTsNnCJF3KZJHKQjebbRDN26rWidy0iswsd8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763070910; c=relaxed/simple;
	bh=rVmOuDbePpQ2bGMVUUhPEgQqgnR0QGJ/V1GBCFoSda8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xoap9E1VxdpEMQGwwbiQGo4mWAjOhXzuBj5vihZkZsEz2asBBK44nVTBx7rXJPxpiGEdKXE5y6xfiXIwhgx1m2JMvs/3KCqDEprBqJaU/ceOwRyVS3+GeOy/a+nAXZfCUjb3+MOTQZKhaa4vuLGgdftaRty49PgFjrAhUX5zSP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dEIqNwYV; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-bc1f6dfeb3dso769052a12.1
        for <linux-iio@vger.kernel.org>; Thu, 13 Nov 2025 13:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763070908; x=1763675708; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VH/u9TyGr8RSTsWUVVlvs3UKeqS3V+ruCDTcFtD8HWs=;
        b=dEIqNwYVG9vuE+ZX4gYBL6p9FjDHiISo5L+ld1kit2Szw7XLS0w7BDK8hFBCjZsHqW
         mkxlRHXxht/2/Mg+BnZUALAYeukGBYz5jE0zduKHHfpE6ibPr+i0ptd+3U71iDsgZKMr
         2fWfu2DAlVTZWFkIFs+OYgdFBeqDWxN562NzYSptx2AeH6LMtG3T8atfQP5GPZStIhXl
         kyBJfZGaNrKa0F03zS5uxJFgxzxCbeooJW+P8HfZurrZfBUTSXRpRipqm/FMEd/eo3Dx
         LmGqrVAOxU0YFsl/tcoauzHtcCc6QU4ClRgn05aLs/jYMLxuSRsWu/8a9okM4mpeA9Gq
         Zz5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763070908; x=1763675708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VH/u9TyGr8RSTsWUVVlvs3UKeqS3V+ruCDTcFtD8HWs=;
        b=sGnqaV7E0ayHcyriYwQAs4pnIb3cdXYs8YFtA6KQYxpWLS1M39u75blGAgIVjbsbeZ
         NIdesHz+AUfgFO7Z+IzfzJWpVUhee4z3EGKJcppcu/t/e5LhNq94DqNqsz7PY+mg4IpB
         f1APlLzLNLINiotlU4bkEq7nDO9McPFAqnvD7I6xCp5WLGX8xUXTMn5eI7v6un0ZSZ2e
         qwnBikgzGG7hYRfs1ortJ1vE4ogA9v2DbAoiyryEvIFEl6zjMBl3D14ehsGnynrKokLg
         qvmQNgDkTDZoXRzXuYpW0KjBnZRlB86pkAfCm4HaJhkT8wedfoGhV32l3Bwp48uRqkeM
         eLsA==
X-Forwarded-Encrypted: i=1; AJvYcCVU7f3yQ5wg/xFZ00L3KnqanHAnpIdkOvfyGqmIqL9OegwzMKF+IlmfhFNtiKj2iVBoErPvt1A7974=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS0ZEsMzxgNDKBFGmuz1zZiBn/aZfw6NRnmz4Fjs68vQo+X27r
	WBlBwl6pn4dmZ3PGc24y9sQRMVSvoMj2CuulW7uONaiR2SRjkwLNBlr2
X-Gm-Gg: ASbGncslhcLNpJDI5QRiiVzy8hT0KtzAWWn/EuLWvRfP1+pNnvw+hKzsR1IjqgLNPG7
	B8J1IfWIrS9dBG7QDaUArfK/N6CkLPc3+pluYj9sjokzlhBW3FBUBYg2q3havgTAJ3SxVncVmeZ
	1KHuJKpC+kcz92SEiz+58Fh3WvYLxVc+0o7Fjq+s9XcNvs7Tbbo+3IU6XYiEgIOQyf8OtEJLJEC
	LvXeT8EhxMRRiPiGniT9wvVsZ/7iG2K29x94M0D2xLqfGrDLta/f0z27tLuB8dN/2fCrbAz/PyR
	46VG7lNCKLqdYjK0XhvLiYbechtmzl2+ed0PCEOOVOvVB/EJ5OZEkFeiklZ7TUKE7VflY/Y6KSd
	ZOjvOtksMH3/m6V/Eky85tfJzhnQCOyH4jruJXPOXj4uWKSgZYwzSPbSFU/FmkK5ngW57Bq+tDD
	N6q9YZ6BgvmA==
X-Google-Smtp-Source: AGHT+IHgNFq0jP1i0r3FaR4AOhj+yV3flfh8AIpVcJiaMVYJcKSzpwSp2u+su9PFlH3VrsqSc59x/Q==
X-Received: by 2002:a05:701b:2803:b0:119:e55a:9c03 with SMTP id a92af1059eb24-11b411fede8mr219766c88.31.1763070907987;
        Thu, 13 Nov 2025 13:55:07 -0800 (PST)
Received: from localhost ([2804:30c:1661:8a00:578a:911c:ac25:24a6])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-11b060886c9sm1319946c88.11.2025.11.13.13.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 13:55:06 -0800 (PST)
Date: Thu, 13 Nov 2025 18:56:26 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, jic23@kernel.org, nuno.sa@analog.com,
	dlechner@baylibre.com, andy@kernel.org,
	Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, corbet@lwn.net, cosmin.tanislav@analog.com
Subject: Re: [PATCH v1 1/3] dt-bindings: iio: adc: Add AD4134
Message-ID: <aRZUCtYzZCY9IQ5U@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1762777931.git.marcelo.schmitt@analog.com>
 <608ab00821af9f766c75d88f59940fed87cb6df7.1762777931.git.marcelo.schmitt@analog.com>
 <20251110-unsightly-blah-410539e95a18@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110-unsightly-blah-410539e95a18@spud>

On 11/10, Conor Dooley wrote:
> On Mon, Nov 10, 2025 at 09:45:18AM -0300, Marcelo Schmitt wrote:
> 
> > +  adi,control-mode:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    description:
> > +      Describes whether the device is wired to an SPI interface or not. The
> 
> Can you explain how you don't automagically know this from what bus
> you're on?

No. I mean, I should have realized we can imply SPI control mode from the bus node.
That's one fewer dt property :)

> 
> > +      PIN/SPI pin on the device must be set accordingly, i.e., PIN/SPI must be
> > +      set to logic high for SPI Control Mode, low for Pin Control Mode. When
> > +      absent, implies the SPI interface configuration.
> > +    enum: [ spi-control-mode, pin-control-mode ]
> > +    default: spi-control-mode
> > +
> > +  adi,asrc-mode:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    description:
> > +      Asynchronous Sample Rate Converter (ASRC) operation mode control input.
> > +      Describes whether the MODE pin is set to a high level (for master mode
> > +      operation) or to a low level (for slave mode operation).
> 
> I don't really get this one. If this is an input to the device that
> controls behaviour (master v slave) why is an option needed too? Clearly
> this is not a gpio but it seems like it could be one, in which case you'd
> need some sort of asrc-gpios property. Is it not possible to read the
> value of this setting out of the device's registers (maybe it's not when
> there's no spi interface connected?)?
> It's not used in your driver, so I can't look there easily to see what's
> going on.

The MODE pin defines whether the ODR pin will behave as input or output.
Currently, there are no plans for supporting ODR as output but, software would
need to do different things to control the output data rate in that case.
Though, the MODE pin state can indeed be read from a register. Same for DCLK pin
I/O direction and DCLK mode. They are also readable from device's registers.
So, that would be 4 fewer dt props total. Well, yeah, if the device is not
connected to an SPI host (pin control mode) then we can't read those. There are
no plans for supporting this device outside an SPI bus, but we would then
need these properties (or a separate binding). Not sure what to do here. 
Do I drop or keep adi,asrc-mode?

The MODE pin is sampled only when the AD4134 is powered on so I don't think we
would benefit from having a GPIO connected to that (if we keep a property to
describe the MODE pin state).

> 
> > +    enum: [ high, low ]
> > +    default: low

Thanks,
Marcelo

