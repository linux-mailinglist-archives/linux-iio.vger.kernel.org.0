Return-Path: <linux-iio+bounces-7002-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4BF91C133
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2024 16:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7EB9287685
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2024 14:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB021C0076;
	Fri, 28 Jun 2024 14:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPQWxdGH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F341E53A;
	Fri, 28 Jun 2024 14:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719585521; cv=none; b=H88hTUMc9WZdrvHYDoujfZWepCcKS5ryMMvydn6PJ2fUcEwDXGm8vYHYEqe/Kd/kh/ETCZRwq/lmBr7YzzeuwZ0XWKquAwZ/79zOzxy39f5+7UuaQN6bhex0QXECA1Twlxs/eWOtgN52q5INfzD5r2ijY7mXl48qG7/LXT9gZGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719585521; c=relaxed/simple;
	bh=UnQJTA1Uho8wfMRllPRQMtJTW9ui2+eIhxm9q+jTY9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=blirdbgRKLQMAIclXHDg1mgt30SPpIJS8njJBR663T1qkBcVD5h/zzNUjWhI9ujqysCY7KfvIO1KBhlrJKE0hkjJt5sB4Ju5c6Hk4f46xt1696UxsugC9h6Q5AhLz27kcWLsqXAfCRzw4XWiqHSLjJeBhJQoW6p+vC0rdseN4I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SPQWxdGH; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7f3c878d6d4so27251039f.0;
        Fri, 28 Jun 2024 07:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719585519; x=1720190319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VcQyE0yYDNTSkXwDduYitSPJ1KKImtXfpamQ+jJEONA=;
        b=SPQWxdGHZS7cBj7J+Bjk/jPv8+wLO4TW9877MJ4gr0j7QypcVJQ42KdsXV6TckmKAz
         n1GbOtofbbOdjo+GwcXnEYc/XUuBtNNQAoTgDtCQzeqJ36GooMBdZ4In/fhrP4Luu+vA
         IUMzCBH1kQ2xV9e2Lx6I2rkLWQuzckuaD1nvm4M8/Yz1pRXFfmJjx72tYZ9jTxQNmY67
         Kj6ffmSyevjsTQic5hwiuDZzQJkmwlYs61hy0+yv7KgCh+Mj1JbR4Y4eBAw9Mf+vLBc5
         jz/Fx5Y4V0ANhOm8mBLtj3cmFok0rNYrAlEokEtyaAjPsSW/jMnbzQv/QCSL2q5obbsH
         OmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719585519; x=1720190319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VcQyE0yYDNTSkXwDduYitSPJ1KKImtXfpamQ+jJEONA=;
        b=eBKQNQyw3drzlYA6GDia24sdrCUsKJDx5DPfZLoD8Egr4WHkUqcApwI8J4w08MTsVQ
         Zk8/Fj49LLGyKObWCUFU2hrtJ9RLhmc3llSknEh14UJ3Ahy2CcYzRvzZPZNBV/XuRJ9X
         Z+zcn1oFhfHwctQlSjS5C3Fr3B1jfdB3QXN8a2NuWarq9Wu/dYNDVKkmjTV7CjpcnLsQ
         GNzVL0O7GK1OIJrVoYBkzVBceHMNlKjYXSCRZdBJfULq+r8xSdvoyYbAxz47GvYx9uqv
         f4gblYkP30Autva6ejiONbjspUdLtVJpBJY/266R/2BqxL0OH3o7jjjnlOjJtaJIkJQc
         lDYA==
X-Forwarded-Encrypted: i=1; AJvYcCX93dbdbSqJYEwWrUuWpqLvWl5RTZkZu5AOT7HZpkZQwwQrQ9cUU6t9kMyl/OrXipLfd5JsuskxkL5UuPr63DjzQrRpD0kC0lH5K1LDd9IJ9OZet8KKI+2RpummMMSwBCGpEDwddSqMVOEihEbNFvmLec7OGfMcdZvUxk5nARoccC6QheBkdeQwnOe+VL+XWgdHqNP5VM09tjSCG4nnPh4k/U+h29E0xtMjra9MInbw5FquKxqwEvWVXA==
X-Gm-Message-State: AOJu0YyC/L5vVDnxivFcWN16UIMk4XFu0N3REVZ5M6JfErYGzXHeUVek
	FJJJ0e1bIQ1X6Cey2vdu2seIPPqZDo81XeYU5iEkL+aK7GpRQkoa
X-Google-Smtp-Source: AGHT+IHz9FFo+xEdO4eMyfNJdkl4np8V035GYfOzDC08kq0lJxY+ZuMnFlw/XDfGatIYJ2F8lUlsOg==
X-Received: by 2002:a05:6602:1602:b0:7f3:d759:8fc2 with SMTP id ca18e2360f4ac-7f3d7599379mr765481339f.17.1719585518489;
        Fri, 28 Jun 2024 07:38:38 -0700 (PDT)
Received: from localhost ([2804:30c:96b:f700:cc1d:c0ae:96c9:c934])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6d1f77bcsm1380841a12.79.2024.06.28.07.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 07:38:37 -0700 (PDT)
Date: Fri, 28 Jun 2024 11:40:03 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, nuno.sa@analog.com, corbet@lwn.net,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 7/7] docs: iio: Add documentation for AD4000
Message-ID: <Zn7LQ8AJo0U1pzN7@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1719351923.git.marcelo.schmitt@analog.com>
 <e553a7c6ba88b3d8ae2db0963212fdce0919805a.1719351923.git.marcelo.schmitt@analog.com>
 <55d0cc07-c877-4510-a052-4458ee964615@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55d0cc07-c877-4510-a052-4458ee964615@baylibre.com>

On 06/26, David Lechner wrote:
> On 6/25/24 4:55 PM, Marcelo Schmitt wrote:
> > Document wiring configurations for the AD4000 series of ADCs.
> > 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
> >  Documentation/iio/ad4000.rst | 131 +++++++++++++++++++++++++++++++++++
> >  Documentation/iio/index.rst  |   1 +
> >  MAINTAINERS                  |   1 +
...
> > +Wiring connections
> > +------------------
> > +
> > +Devices of the AD4000 series can be connected to the SPI host controller in a
> > +few different modes.
> > +
> > +CS mode, 3-wire turbo mode
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> The datasheet also has the same diagram in _Figure 55. CS Mode, 4-Wire Turbo Mode
> Connection Diagram_. So maybe we should call this "register support mode" or
> something like that instead of mentioning 3 or 4-wire?
> 
Humm, ADAQ4003 datasheet has the same figure for CS Mode, 4-wire turbo mode
and CS mode, 4-wire with busy indicator although other datasheets have MOSI
to SDI in 4-wire turbo as you said. The register read/write functionality
sections say CNV must be brought low to access the configuration register.
I'll leave it as it is for now as I have not tested reg access with CNV high.
We can update this in the future if find out reg access to work in 4-wire mode.

> > +
> > +Datasheet "3-wire" mode is what most resembles standard SPI connection which,
> > +for these devices, comprises of connecting the controller CS line to device CNV
> > +pin and other SPI lines as usual. This configuration is (misleadingly) called
> > +"CS Mode, 3-Wire Turbo Mode" connection in datasheets.
> > +NOTE: The datasheet definition of 3-wire mode for the AD4000 series is NOT the
> > +same of standard spi-3wire mode.
> > +This is the only connection mode that allows configuration register access but
> > +it requires the SPI controller to support the ``SPI_MOSI_IDLE_HIGH`` feature.
> > +
> > +Omit the ``adi,sdi-pin`` property in device tree to select this mode.
> > +
> > +::
> > +
> > +                                         +-------------+
> > +     + ----------------------------------| SDO         |
> > +     |                                   |             |
> > +     |               +-------------------| CS          |
> > +     |               v                   |             |
> > +     |    +--------------------+         |     HOST    |
> > +     |    |        CNV         |         |             |
> > +     +--->| SDI   AD4000   SDO |-------->| SDI         |
> > +          |        SCK         |         |             |
> > +          +--------------------+         |             |
> > +                    ^                    |             |
> > +                    +--------------------| SCLK        |
> > +                                         +-------------+
> > +
> 
> I think the rest of the explanations are good.
> 

