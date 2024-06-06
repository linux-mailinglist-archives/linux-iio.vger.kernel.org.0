Return-Path: <linux-iio+bounces-5968-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2797D8FF781
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 00:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4064D2841B8
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 22:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF72713C833;
	Thu,  6 Jun 2024 22:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="na+KN3/T"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACEA2F2B;
	Thu,  6 Jun 2024 22:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717711641; cv=none; b=PnJxnUuQ3mmzQNlVj52f5uHEpH4IgxUauFIad6MOMimu7sfko/luhlyqN6hf2WlS509LYJ4dr5E/79z0X4LbRtHnWvblIQSIRThDIVqYWR7vvlIsjyxVnw5eMMs36Va49JupTQRgSyfDnPjTsknUk5VpSb8cMRIDD04+rfc6TgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717711641; c=relaxed/simple;
	bh=74HpMXe+CG43MLy3G4Vs67xOq8UiLT5VdUaTnoZeUwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZzaafEuB8/46GVJ2POw4rySiNgda5Gt7vw3fKpdXS+dZWfLegLZqmVRJnLkxKkWIw/+Ntxm7+tNgZ+8qn0qc9z7Ia9ipb7TPM+40sb2EbmvPyznwd/PCz5DurgMv3YMOdWfQFd0LRUZMXzZmOKnYz5ZjRLajileGsksbZj0wCDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=na+KN3/T; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-681bc7f50d0so1843399a12.0;
        Thu, 06 Jun 2024 15:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717711639; x=1718316439; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uvkHEPEs0Z1iGFT7Wj+07l4Max2ilBTpn8C2Gm83KxA=;
        b=na+KN3/TLQsH+xIpUXHM8wSP+60bd4DA6wJ3KTrF0rJ0TPllVgfxgT1JPq3G1jrCNn
         5x6/2WtJ4WoUxESqGxHMgx0SrvN2KdpjGupK4H4xi0LtlE8ZZLuHxomsyBYkOFB/pdU7
         K79H2lvpST0k0vWusDG74jV0w2IB0IbGamALIDR91G1ATcOIn3uNVAMBf3iuAmQqqD4m
         8eEoTNTg18xyAJtPc7kxkYM1QVMuTWAI1RkWC6gokCRsF25xGZU0nF9rp0dQeo/xVXOt
         Fss0X3ZGOHdxk7es6pz9vmhKz9lQioo7Rxww+hD0TS9aP6KvO0P7zs3AfZ3mx+hzAm4l
         lihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717711639; x=1718316439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvkHEPEs0Z1iGFT7Wj+07l4Max2ilBTpn8C2Gm83KxA=;
        b=UROu1mxBkHg9Osixxb8Kau2+VzmZsxN/h5eIlOfHeQ/At2ON+egFsS7k9x+Lg9tkwT
         b908Ug/A0+v7jI0bHKD70mxZ9Gc6FTnL4n5YSy/EnjKURPDjpmpcLwuPq07yK+2C4Bzk
         9OnqtmKYTs7ZdOKICiIocEwDj8FVnmk1NPu02WfWkKM+hM/A/e8g8eVRnhNU2m2GygGn
         SswPm25nRwrqMfd9HFWFe69CnsgvGNFHgB+/sf/oc2HYptIdzN1UCQrRfDM5LyvHgLQj
         Uo+SEkhm7DN0UdqEYfOt0qi/cOLBWwfQgRBSx1n9X6fO9saa0Nvrl9+jN+BPTtbqFK1p
         UBhw==
X-Forwarded-Encrypted: i=1; AJvYcCViZvYc3sr20I8qTUFc3gA7GnMI/D+oYrEuU9fTctn8EGW2gd9ySaBKy8SJSeTxvohIUQ6Edi44pRKbs0xd7lqEBe/q48JkScXw1jIQ/Cn3VQqF6uqyvrAnPQCvx5qbneQimiVUCGDoEtHWAX5nUba9QwaEkkKwdp8pdrwhnrxyx7db13Nldp1IJUi5IhmzkUoCAKJn3rkt8EcDcO+uVg==
X-Gm-Message-State: AOJu0Yww/Wq3axU7JlW2myztMO3LucTWciO6iKzp3Jw/DaeWlKQ86OoZ
	7B9zMxiNzep4p7G4CesGFdqtyOapGm2z8TwpmsWHfUv3fXPgSUnvXxMz9bfn
X-Google-Smtp-Source: AGHT+IEws3XLyWSIeIljFrAA9FQiJ0XSw9ngJH1KYHPJcEukh2jwKKfcNOAsYsVT8N2DvNkYIBUNUg==
X-Received: by 2002:a17:902:e741:b0:1f6:8c90:3521 with SMTP id d9443c01a7336-1f6d013563cmr13693655ad.8.1717711639248;
        Thu, 06 Jun 2024 15:07:19 -0700 (PDT)
Received: from localhost ([2804:30c:167a:4100:8407:a7e5:9b87:8081])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7ed6c8sm20369285ad.241.2024.06.06.15.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 15:07:18 -0700 (PDT)
Date: Thu, 6 Jun 2024 19:08:30 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	nuno.sa@analog.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] spi: Add SPI mode bit for MOSI idle state
 configuration
Message-ID: <ZmIzXun2-DWl7cT-@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1717539384.git.marcelo.schmitt@analog.com>
 <e1d5d57f7a7481c84f64a764f9898122e278739b.1717539384.git.marcelo.schmitt@analog.com>
 <0a716b10-0ae0-425f-919a-ea5d8b7975b6@sirena.org.uk>
 <5dcd9701-2725-4aff-9e73-d8f2e038be75@baylibre.com>
 <d09485bf-bbb5-4a3f-84b8-54478c6d78cf@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d09485bf-bbb5-4a3f-84b8-54478c6d78cf@sirena.org.uk>

On 06/05, Mark Brown wrote:
> On Wed, Jun 05, 2024 at 11:37:48AM -0500, David Lechner wrote:
> > On 6/5/24 7:24 AM, Mark Brown wrote:
> > > On Tue, Jun 04, 2024 at 07:41:47PM -0300, Marcelo Schmitt wrote:
> 
> > >> The behavior of an SPI controller data output line (SDO or MOSI or COPI
> > >> (Controller Output Peripheral Input) for disambiguation) is not specified
> > >> when the controller is not clocking out data on SCLK edges. However, there
> > >> exist SPI peripherals that require specific COPI line state when data is
> > >> not being clocked out of the controller.
> 
> > I think this description is missing a key detail that the tx data line
> > needs to be high just before and also during the CS assertion at the start
> > of each message.
> 
> > And it would be helpful to have this more detailed description in the
> > source code somewhere and not just in the commit message.
> 
> Yes, there's no way anyone could infer this from any aspect of the
> series.  I think the properties also need a clearer name since someone
> might want the accelerator functionality at some point.

So, if I understand correctly, it would be desirable to also have flags and
descriptions for the MOSI idle configuration capabilities in include/linux/spi/spi.h.

Does the following definitions look good?
#define SPI_CONTROLLER_MOSI_IDLE_LOW		BIT(8)
#define SPI_CONTROLLER_MOSI_IDLE_HIGH		BIT(9)

Maybe also document the MOSI idle configuration feature in spi-summary.rst?

> 
> > > Even without that we'd need feature detection so that drivers that try
> > > to use this aren't just buggy when used with a controller that doesn't
> > > implement it, but once you're detecting you may as well just make things
> > > work.
> 
> > I could see something like this working for controllers that leave the
> > tx data line in the state of the last bit of a write transfer. I.e. do a
> > write transfer of 0xff (using the smallest number of bits per word
> > supported by the controller) with CS not asserted, then assert CS, then
> > do the rest of actual the transfers requested by the peripheral.
> 
> > But it doesn't seem like it would work for controllers that always
> > return the tx data line to a low state after a write since this would
> > mean that the data line would still be low during the CS assertion
> > which is what we need to prevent.
> 
> With the additional requirement it's not emulatable, but we'd still need
> the checks in the core.

