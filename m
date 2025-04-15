Return-Path: <linux-iio+bounces-18148-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D366CA8AB37
	for <lists+linux-iio@lfdr.de>; Wed, 16 Apr 2025 00:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29B951901E55
	for <lists+linux-iio@lfdr.de>; Tue, 15 Apr 2025 22:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559D227A939;
	Tue, 15 Apr 2025 22:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PJFxT1cV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9592522AD
	for <linux-iio@vger.kernel.org>; Tue, 15 Apr 2025 22:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744755477; cv=none; b=oZvTVcWwtnEwsmvwTdx2RbGQJAauECsGZ17/it82LuA04H3qiiXGWydJBvbbGNOBmWhV3WEFPZ/T7dg0JbGTFpe/QfmSmpEq+NqMNna55ozlTagr6eroliM087TppKjShXwK04YrPuqkT+6GtnSdzeJ/ahdjX6HaswD+vYzUUa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744755477; c=relaxed/simple;
	bh=hGlTveS2616ckTcGMpFiqiYVbcqh6/+6UFd/j7gYNa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uoRhKRYsAJ5r9FHW4jURuQd5q4HBMLsZHDTkYGrnXQ/UvstWTcLUFCzjZGNI6fIoMzSeOhFl93sd/3SknJS1se/ZGXShlqtg8q+jqSqq/fDS89lk30fh6XXXnFSBULqYOjQEjeNuIxPZjdjEWx6qB94DbwKE+dscU/++FMgQP6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PJFxT1cV; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-73bf5aa95e7so2688458b3a.1
        for <linux-iio@vger.kernel.org>; Tue, 15 Apr 2025 15:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744755474; x=1745360274; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4J73IHenn0V6xQDZgF63RJqhtreeLtTKV20Qod+uY/M=;
        b=PJFxT1cVupe5DkeyO+H6r69bYJLrQxSOAVNcTpPkXRLSEFx+qD7tPZeMSO26BJiFkP
         3GeJ78XywP38u9diAVmypwrJNNju0NjG9MX2P8b2XwIPKx9L/nqyodlsN87BghnktLNs
         pquXgxyfLcu0ltvOqzFqPX5Ez+FXy6i1J8AN69FnKbBipUaeHNMVMgwzux/VmrpdgEjd
         YqRhXYoYAYdDpS/0rQeVRv8nvxb+ORda69zIAmF7I9oN89H6tGT3MDPuxqoTHui0aktI
         1SpZWEfZ28lx5dQyugoDqQev/i7pfrCNev9ABdxz5OG6EATJoQdpOsePUh1EkmAjwsc1
         Bz5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744755474; x=1745360274;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4J73IHenn0V6xQDZgF63RJqhtreeLtTKV20Qod+uY/M=;
        b=kY3GQ/3YFG1YvKbSF2edag0kDDBzu1N3Dk96mxWTZQZlUdHGlOb2W4w0xO/E+Bk1D4
         2RqWZBB06ccZ5zIUqIGdL8sYHv6fXrvMa5DMzTtqOCOLIqQRVMubTGIETAOr088TV1d6
         biwfsXAkVx+IXffovYuzHF1bZ6w2/E8LDjPT1NBof5q8UnLbCRbQ3G2qNAlbv/ffNRo0
         kB8R0VPucd2OJEn/H/BnofYSJPGZmz6Tk0WSVRhOkI6vEwLeCDh1umsIL3XJyANTqY4C
         Z1110GZnHLM+tjZ/1o3nfZD9DzytAuDNazAkxbHADVj6n8q1k9fqDiZ/Hv2RMZ6PQtxL
         SEMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCNBOikc/rZ5dfBbLZ6DPu/YMX5iPVt4BcrozPoeP9U2RDfudK6VH8w9h+KUnFrpk47pUkSSRdM/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKaPgfXpd7ORJYYVl1I6mOhTuBAXumPG/El25ow30lvVCrwjqk
	+K71ZGewdSr9gjTj2AjmotdilhWLNeJCQPYGogdUk0nsnrMIWdoHz9Zr1xIgPL0=
X-Gm-Gg: ASbGncsZHdiRkjp/ZI+J1KVeCfe4ZKJyx5zDaaAAGHphMuktVhYtXKQr5McnGYRkcAp
	Okch6sre8sROX52tYOp5eaO6FRvKoi9gFRP5EmUAyD8E1RIA00tWrf+nsu9ccw6gyQz9aT5Icrd
	F11uX/poeqgVL0vyRiI+unhZI5sBjPv9U7YdoUBW4A6f4m0ijfRkrt0Bek7AyAKh0eKg+VNChLS
	Dw5WgDbt9rn47YVIEozHw2v5k259wurFQ3McpflUvbUa0FL0jO/vanfqaiO8y1WZDNai+5tN8NC
	Ta8iqY4bX5isCOW8zphjGLk7xxqYCF2GtbbkT57va0k1HQwaYcmOBm2HKPwudHi0BoMzxRKtMvs
	B
X-Google-Smtp-Source: AGHT+IFhuSJk+eLjcOi/3nG+9UyHOVKqlJoxNhC/IcW+qjXwSHez/LX3r8QEUmn6wUetBFK7viVoEg==
X-Received: by 2002:a17:90b:2dcb:b0:2ef:114d:7bf8 with SMTP id 98e67ed59e1d1-3085eecc278mr1070084a91.6.1744755474088;
        Tue, 15 Apr 2025 15:17:54 -0700 (PDT)
Received: from dev-linux (syn-076-088-115-008.res.spectrum.com. [76.88.115.8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30861212fbesm111911a91.23.2025.04.15.15.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 15:17:53 -0700 (PDT)
Date: Tue, 15 Apr 2025 15:17:46 -0700
From: Sukrut Bellary <sbellary@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Angelo Compagnucci <angelo.compagnucci@gmail.com>,
	Nishanth Menon <nm@ti.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH 0/2] iio: adc: ti-adc128s052: Add support for adc102s021
Message-ID: <Z/7bCn1S5wFQFaiT@dev-linux>
References: <20250408132120.836461-1-sbellary@baylibre.com>
 <20250412141047.4273a8b1@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250412141047.4273a8b1@jic23-huawei>

On Sat, Apr 12, 2025 at 02:10:47PM +0100, Jonathan Cameron wrote:
> On Tue,  8 Apr 2025 06:21:18 -0700
> Sukrut Bellary <sbellary@baylibre.com> wrote:
> 
> > The patch series adds the support for adc102s021 and family.
> > 
> > The family of devices are easier to
> > support since they all (no matter the resolution) seem to respond in
> > 12-bits with the LSBs set to 0 for the reduced resolution devices.
> 
> This has raced against Matti's series
> https://lore.kernel.org/linux-iio/cover.1744022065.git.mazziesaccount@gmail.com/
> Support ROHM BD79104 ADC
> 
> With hindsight that wasn't obvious from the patch series name though
> which should ideally have been
> iio: adc: ti-adc128s052: Support ROHM BD79104 ADC
> 
> Please rebase on the iio testing branch on kernel.org or on top of that series.
> Technically I've only applied the first 7 patches so far, but the 8th
> should be a simple change from that v3.
>  
> Matti, you volunteered as maintainer :)  Hence please take a look at
> this one.
> 
> One nice thing in there is we now have a __be16 buffer16 element that
> can avoid at least one cast in patch 2.

Ok, thanks.
I will work on the top of this series.

> Thanks,
> 
> Jonathan
> 
> > 
> > Changes in v3:
> > 	Patch 1:
> >         - No changes in dt-bindings
> > 
> > 	Patch 2:
> > 	- used be16_to_cpu() for the endian conversion.
> > 	- used config index enum while setting up the adc128_config[]
> > 
> > - Link to v2:
> > 	https://lore.kernel.org/lkml/20231022031203.632153-1-sukrut.bellary@linux.com/
> > 
> > Changes in v2:
> > 	Patch 1:
> > 	- No changes in dt-bindings
> > 
> > 	Patch 2:
> > 	- Arranged of_device_id and spi_device_id in numeric order.
> > 	- Used enum to index into adc128_config.
> > 	- Reorder adc128_config in alphabetical.
> > 	- Include channel resolution information.
> > 	- Shift is calculated per resolution and used in scaling and
> > 	raw data read.
> > 
> > - Link to v1: https://lore.kernel.org/all/20220701042919.18180-1-nm@ti.com/
> > 
> > Sukrut Bellary (2):
> >   dt-bindings: iio: adc: ti,adc128s052: Add adc08c and adc10c family
> >   iio: adc: ti-adc128s052: Add lower resolution devices support
> > 
> >  .../bindings/iio/adc/ti,adc128s052.yaml       |   6 +
> >  drivers/iio/adc/ti-adc128s052.c               | 149 +++++++++++++-----
> >  2 files changed, 118 insertions(+), 37 deletions(-)
> > 
> 

