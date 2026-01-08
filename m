Return-Path: <linux-iio+bounces-27561-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6DED04A23
	for <lists+linux-iio@lfdr.de>; Thu, 08 Jan 2026 18:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1F3E030854DD
	for <lists+linux-iio@lfdr.de>; Thu,  8 Jan 2026 16:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF862DB782;
	Thu,  8 Jan 2026 16:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZgTP4YF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f66.google.com (mail-ua1-f66.google.com [209.85.222.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BD72777FC
	for <linux-iio@vger.kernel.org>; Thu,  8 Jan 2026 16:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767890484; cv=none; b=kYQbNnXUPeVv5pATTcIOF8z8WfY7dODLjuD2+0SpkmrvcKqKguiFxq7bLNknOKBIBPqxLrezC0uruGKvYCWrWFmkcbtQ/Oz5jfW0uIPuDAPhqut3eE8onNkpOQi4ocWlBoBide66Ald9OjpMJX9DL1yT9u72Ij3v1iTAMZe4VTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767890484; c=relaxed/simple;
	bh=2SWvg0mnSNPKoEbzYd6Yyz8aYgMuu8vuLkO4K+rHnas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9VOpudbXdc9VS9lGqqHfIp9wIpHN0L0MWWe3WQ4+Sqhf8okb3flUw7qAVtERzb4r3/9B7d2Aj+WiUzZ4GejYWuil8HbES6EHZeLu7iYX/szpq77HU/5Cn08dAUwYMg5pVETsPwvVoI08YClKRm114UqKoP3v7e2fH/NGKiGyfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZgTP4YF; arc=none smtp.client-ip=209.85.222.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f66.google.com with SMTP id a1e0cc1a2514c-94124140e02so2098188241.1
        for <linux-iio@vger.kernel.org>; Thu, 08 Jan 2026 08:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767890482; x=1768495282; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4XSjy6GDoZa/I1UcaZttfnQzQ3rLxhESiNSFP7ANylI=;
        b=gZgTP4YFii/GrPRTnx9zbL+/gDTD+peFD5GIayRiAw4smUy6EJJ/jY4XVRCHTUrEBK
         4mluzxiQ0phiF9Z2sr8I0d0ZR2Xt2/K0mXpC+Ts8TMHZv9YWCnq4KR3d0A5Jok+t3P/i
         Mx6lPlW2reO01RqTRPB17PhANPfAnAGgkbntYwv/JUPmGWFtnjABf8J02REUSZT1WYP+
         OWEKhaGeoGmWrwPB9PqZVLfW3WbSdwXYmvWQDK7CmnGFArrH5CadFLsocQdFpxRKlkeR
         9bEc/Prbr+6GwxXoZLUfwxnY4BmBRTmXz1ADWWgnV4M2/4ImGahcAWyuF5RuPnRF/3IL
         Szjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767890482; x=1768495282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4XSjy6GDoZa/I1UcaZttfnQzQ3rLxhESiNSFP7ANylI=;
        b=aVAb1l5qnm6Mx1inEnqNb/NFuGCWwAB1qVJO1XKWsDw/x4HsEwLMjfXATqvFDADYit
         wstZBRj0EFaY4Lbv8vxWhgDQVEuz9Ha8mdclevJ8qDLJkp4csAaI/ZBl+Tf+Ayheq8tm
         JHa51jhq4FaIwEVMcozRN6+quDWA5wF2u6dvn/UPaFdGNELPxdyiE+Fc5EOtgS+jrM+L
         Um6+/CORywb590IsfAoBLhgN4wqd+WDJ9/9zL1VHEqokwqAEIcNASt6pNESDLu0rfQOq
         ZHMvfvyz1075FlM3YjLH7IbDPHXyNyGVzG9TUDbOFSQN4QCwXlAbLQUQF8sTqKgJsepg
         FhIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg+SdqaBNTfucwePp0rVzoBhMfzYxuSSgFiGYxr2wk1793j7anDhSl6ofZm62ioGlJwlGUFGzN+7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaBjOyajcK6VAJxD27/xGSI8hImFpAxP/snpUSBGj8RZq5Ko64
	O7E4oTf1np1ZN/KUzfGmpi7A9Onk81dgyFFRXOcIluDjWtuL8WufqksW
X-Gm-Gg: AY/fxX4+mqh0mMkKST3mFkFvxTwetPF2OdByGWYVRZP7zQj4qVuBpKhM2IgSFC5L1IS
	54ihpvWu7Znrx4HhBzBFr9T59pBLsbLy63mv66nVmvLaxcQCmAuyUBHXf4Ym9xspsJ8BaQJWlOK
	KKnreJHrEUYDb1StRk+KTMmHCjPV0fg3sOps2ol84R4vqIlFNyVQLNx2202xShTtD6Z0vx7CLIB
	zeVvU5y7EcZYo+ZHcN4q5/0QeUMa4z2sIkiXePx/ix2Pmq/p2c+9IIeJuzVBlQXkI6fKXXLakn4
	WEIVnyMChizG8EracKurJNCgmoctG8Z5emx0C7Nw+14ScWp4YpSWDQcYcmltfpc8LoVfSdA9RR6
	0A0W+OtUcEeppLns9F/vylBk9vGFnadP6n9sGOrofUF4yeiMf1X29nvQsJZKFAakCjiDv1/udsF
	4NPnD0umtN2DFKhNkT8TE=
X-Google-Smtp-Source: AGHT+IE4AtDbZKzZRalcqE7CcaXG0QiH66wB+saTxJ1rIfK77dWxMvmeKvWa/VQKArvH4J8jbd8fRg==
X-Received: by 2002:a05:6102:26cb:b0:5e5:5ed7:60ae with SMTP id ada2fe7eead31-5ecb6900d02mr2692035137.31.1767890482104;
        Thu, 08 Jan 2026 08:41:22 -0800 (PST)
Received: from localhost ([2804:30c:2766:a500:b70:8c42:f792:bef6])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ee9d013b3csm2213215137.5.2026.01.08.08.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 08:41:21 -0800 (PST)
Date: Thu, 8 Jan 2026 13:43:07 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 5/9] spi: Documentation: add page on multi-lane support
Message-ID: <aV_em6a5vxi_AZGg@debian-BULLSEYE-live-builder-AMD64>
References: <20251219-spi-add-multi-bus-support-v4-0-145dc5204cd8@baylibre.com>
 <20251219-spi-add-multi-bus-support-v4-5-145dc5204cd8@baylibre.com>
 <aV-mpFCF_ET3AZ1B@debian-BULLSEYE-live-builder-AMD64>
 <c93a528c-39d6-4e29-b64a-ecf75032b60d@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c93a528c-39d6-4e29-b64a-ecf75032b60d@baylibre.com>

On 01/08, David Lechner wrote:
> On 1/8/26 6:44 AM, Marcelo Schmitt wrote:
> > Actually, one more thing ...
> > 
> > On 12/19, David Lechner wrote:
> >> Add a new page to Documentation/spi/ describing how multi-lane SPI
> >> support works. This is uncommon functionality so it deserves its own
> >> documentation page.
> >>
> >> Signed-off-by: David Lechner <dlechner@baylibre.com>
> >> ---
> > ...
> >> +- :c:macro:`SPI_MULTI_BUS_MODE_STRIPE`: Send or receive two different data words
> >> +    at the same time, one on each lane. This means that the buffer needs to be
> >> +    sized to hold data for all lanes. Data is interleaved in the buffer, with
> >> +    the first word corresponding to lane 0, the second to lane 1, and so on.
> >> +    Once the last lane is used, the next word in the buffer corresponds to lane
> >> +    0 again. Accordingly, the buffer size must be a multiple of the number of
> >> +    lanes. This mode works for both reads and writes.
> >> +
> >> +    Example::
> >> +
> >> +        struct spi_transfer xfer = {
> >> +            .rx_buf = rx_buf,
> >> +            .len = 2,
> >> +            .multi_lane_mode = SPI_MULTI_BUS_MODE_STRIPE,
> >> +        };
> >> +
> >> +        spi_sync_transfer(spi, &xfer, 1);
> >> +
> >> +    Each tx wire has a different data word sent simultaneously::
> > In this example, the controller is reading data so the rx wires have different
> > data word received?
> 
> Yes, I tried to make that clear below by having a different value
> for each.

Yes, that part is clear. What came a bit odd when reading the doc is that the
first two examples ilustrate the controller writing data to the peripheral and
refer to buffers from controller's perspective ('sent over the tx wire', 
'data is mirrored on each tx wire').
IIUC, in this third example, the controller is reading data so we would describe
it like 'Each rx read has a different data word read simultaneously', no?


> > 
> >> +
> >> +        controller    < data bits <     peripheral
> >> +        ----------   ----------------   ----------
> >> +            SDI 0    0-0-0-1-0-0-0-1    SDO 0
> >> +            SDI 1    1-0-0-0-1-0-0-0    SDO 1
> >> +
> >> +    After the transfer, ``rx_buf[0] == 0x11`` (word from SDO 0) and
> >> +    ``rx_buf[1] == 0x88`` (word from SDO 1).
> 

