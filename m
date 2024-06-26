Return-Path: <linux-iio+bounces-6943-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCF2917CFC
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 11:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD5F6285AA4
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 09:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485B916F0D1;
	Wed, 26 Jun 2024 09:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkdD7vi6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B62C16EB64;
	Wed, 26 Jun 2024 09:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719395558; cv=none; b=KrxcJgASDPCVsAsAot/BrFydsg0LPxs0TnObPHWETpym4yeXmBMx8rpFgDBNg+uU2diioIZa+oeNpkT2d7k+J7+i39lfYMlg69lqBqMj+1n8QWPA1mhQUn69lUPxtBkzstEvBt5ekGEJzvnqQAXmpWA7pLwc2LX+bCPp6C5jP/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719395558; c=relaxed/simple;
	bh=CEq0I4obOCCO8SDIqFJqvRzxXub/VRZBECmqxp4hfnI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dnpiKvDGrcPSEpaC8wbdzI5hEDlPx+SVAp5gCHkmjt8OQbSV8fPO5ihO20lAIoIRc+03HgAPMVIjJg8gwpoW1rF1xOPqpMDhWfjc90D+bKxDnvKsjNGHegwaUduxExCTtYn3Xux43GkcHZOUYJJpz6H4DdARNW4iePrh+5XiGMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OkdD7vi6; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57d20d89748so15332a12.0;
        Wed, 26 Jun 2024 02:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719395555; x=1720000355; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CEq0I4obOCCO8SDIqFJqvRzxXub/VRZBECmqxp4hfnI=;
        b=OkdD7vi6jDuRlQZtzJfFNuEFGkvs/0pvEg8wheVaJShjap6kLB2gR6nnBYECHyN9nv
         OWQ2P2p6FOZ8jjb0gDfiR2DaF5A7R1r1E93CQnElHeT3DtApKBZr0YqBOwN4TWzBvQcy
         8SuytFtxSCGihEoUv06HAU06lLs2r+MJmR2CHdnNI/ij4vlcIPF/fr22rjTD3pTHgZnR
         x2GSQgtmS7MdAAQhA19uD0Te7Fu8tBhVedTSjK/hpPaZxiIUI28Pi1iSjqH3ta0odbtH
         zbwAEgiEJbw2eC1vDK6SZf2wx95T6NjTIlYKek48Pq3faj1NoRlK5W4IS7bwA32uyQfD
         910A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719395555; x=1720000355;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CEq0I4obOCCO8SDIqFJqvRzxXub/VRZBECmqxp4hfnI=;
        b=NhtFcVMXPkgsghBceeIwE8ZJgoQOAAL3ns5AEzVdd/Fdm7dDweGTYh786p8YzLgUKe
         H7/b+0jZ8n/+IdqFDM5qilvbx4Cl0Bj4VeodyRaFCfKB534wIskwIBo1mW48xTEPebEs
         l8oZxdBNID5tfWNdM0BE7Ew76Qq0IWCq4Wx+U1jH0YsppuD0+vblrzX+uQyKs3f4Q82D
         4X66V27qm4IlL/kIpv8g8Njtk4rhPf9wpBUcZ2NJdTh7zcGp1ExUTkXEUlpae8aPDlgb
         05Obsi2SpNPeyZ8TKPemmB7IUnXQVwb/G6MSEebR00zjY+8lYEgaqFk+I+B/dRoxBFUi
         Gj4g==
X-Forwarded-Encrypted: i=1; AJvYcCXWolENHOLIN5XzBv78xKlnLEFw0eMvgieUiqhsjD3U9te3J0/cFQu3oXReUa7B7pTetKIueCdzXbGxEn5Dwj8o65n3oHXjD+DURy+iNSWkP19yIGPcHJSomNsgL0BwQkM7yLwFtH/AZi9YTAb6UH9iItyYi9AVgrkkC+3UD9F8uQFbvp4YXiF7O/njmSeSbyFWYa/p5bbSjswPAcBAHg==
X-Gm-Message-State: AOJu0YxhW2/Y9eDZPXbJskeQHytw5vSRYJh2VmA7L4w1ILK6+cNA7sp3
	2yABdJ16AQDYZO1cZB4rMrCieCMsHX4DuxuEpt4rwVgsbX6BUKJQ
X-Google-Smtp-Source: AGHT+IHZHZAuMSxNZX/7yuNeqKyYjSrBmf8AQf3qeuhIfvJ9aUUoROOka1S/xZ1I9jo+Uu5hNsle6A==
X-Received: by 2002:a50:cd98:0:b0:57c:5f58:58c8 with SMTP id 4fb4d7f45d1cf-57d4a03f239mr6272523a12.40.1719395554678;
        Wed, 26 Jun 2024 02:52:34 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d30535010sm6984785a12.59.2024.06.26.02.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 02:52:34 -0700 (PDT)
Message-ID: <80a421342f645fef27fb99c6dc2fa4617239014b.camel@gmail.com>
Subject: Re: [PATCH v5 4/7] spi: spi-axi-spi-engine: Add support for MOSI
 idle configuration
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org, 
 lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
  nuno.sa@analog.com, dlechner@baylibre.com, corbet@lwn.net, 
 marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 26 Jun 2024 11:56:25 +0200
In-Reply-To: <072d74af9fc624490b84a1d001039424e572e827.1719351923.git.marcelo.schmitt@analog.com>
References: <cover.1719351923.git.marcelo.schmitt@analog.com>
	 <072d74af9fc624490b84a1d001039424e572e827.1719351923.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-25 at 18:54 -0300, Marcelo Schmitt wrote:
> Implement MOSI idle low and MOSI idle high to better support peripherals
> that request specific MOSI behavior.
>=20
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---

Acked-by: Nuno Sa <nuno.sa@analog.com>




