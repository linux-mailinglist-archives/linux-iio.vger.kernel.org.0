Return-Path: <linux-iio+bounces-27548-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B21FD02C33
	for <lists+linux-iio@lfdr.de>; Thu, 08 Jan 2026 13:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2711130662A8
	for <lists+linux-iio@lfdr.de>; Thu,  8 Jan 2026 12:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F85465D19;
	Thu,  8 Jan 2026 12:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEPN8acV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2875A4657F8
	for <linux-iio@vger.kernel.org>; Thu,  8 Jan 2026 12:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767876157; cv=none; b=bRvli6eH1aPmc72yZx9DKfh2PmUJbCPxyOHV9/P2VtU/BEi4+MjZ79rEYSFF3K+eMgT/RF1HnPw/c/ezUQvFUXYKknoQTD7XUMKfhPIEj7QQZJWSom3xSS3fcDcLF2IzmBrLMsOMKO88PsgCZqhFi4pDpTp9EQgpNkMnj+lHGUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767876157; c=relaxed/simple;
	bh=6wtGbh2+RP2QUwWE9UIqXXcEp3EZiqiCgv0n4SQ2vUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7WvbrYM9xmH19vK20xqNjs6ldnjVUBBXF7vnnfVXRd+uVeLtm9nau26F8pvB/iUISDn+T48lTo9wOET41FpTi3hZEJ8xGUdXroiWp5YHZtlz/VZCNyAbXFJ5FlcQz/KZCC8o/hFCioxuIR6Yo8PvjnBzmbCMceTNiKdEbyIICo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEPN8acV; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-2ae57f34e22so301363eec.1
        for <linux-iio@vger.kernel.org>; Thu, 08 Jan 2026 04:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767876155; x=1768480955; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iINcQgr3dcl7IwITqUtWTzuEmlrnp/IbXb1tjKBIgMo=;
        b=KEPN8acV47ycJ2LaC9cZjX8YgKn9GIKrsokTF2tfNcleQqIFZhx0Z5OM3aokWl7Kjk
         aRxOeWqpSUO9mvIcOpR/zhbrNF6Uc48Tw8AipNy1S9Q5T0CJ/khaYfNSneL7SSKAjoAh
         FHIpeWjO3/OuPgaqS3vj7mxmjT4iycF9d7E4pyfZquhaPo/OSnpA7ZFPWbmHZHMzX0Ik
         78zZwGdLZKIi/xndMyukXa5gMUtQcRZ+oSObG3uxgf2XaIfM4Xkl65yJYA8x3nm13PVF
         PAaMbSg1Uyw4vc9kodaZsIe3Lykz+MvtMHHtohN9VQxWn75f+r6+scRqBtJR1o7OlN/U
         AZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767876155; x=1768480955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iINcQgr3dcl7IwITqUtWTzuEmlrnp/IbXb1tjKBIgMo=;
        b=AgFq5qjYN29lNnwAqj/whCCOUd/eTu0TX6SyZGtg12t1/sxAyDqh1lnowdxXaOGWdp
         ZjdhDFc7+bid9tyB8Ovb0JWgmDERpnFuYI6dgw87FYHGVOVR2b5kLb8uuJqucCLxWd/g
         qusGlHmfjvvtVs7/YcDCPjsX1jMpTJbdBMrqA+1rRrp6W8OnjAlLywd6Zfbi7791w4Lo
         JZEG5/XlTI+JaUs5bjk05M9Khp1q4P6IadMu5r+9Z8363jSu9ERW08P8jEhTlxb4vOoT
         PoQD9VzCsF7JwuioSx+iDIrjNdSYv3f3A1Tz/y5kg/GCAdX5EiCmAi9NloFk9HyDhYYy
         Sr4w==
X-Forwarded-Encrypted: i=1; AJvYcCVPe3c7crCVsJ87o9CZXtlthvAMeUaUMa3VcWfEnUbctcLVn1jQkeyVrVgIRUcAI3jPkhxl9gUM1NE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1My/J+Jjr27A+PMUNzQNHDHNhWY81va6e3JQ2CT0yDX9s3JwT
	2Sa4mV3Y8+vLsqnXvKmv5LcehMj6cd8L6H/ePco9IPJ40cnLNA8rnAEU
X-Gm-Gg: AY/fxX5AzOfuHA2792TUE1wp9llzVD09EPhE4+roVfbSWKNjDa8DzqgpXVX+D+WlfvO
	J3ZqRvbyZ3bHhEiZuWSiXzyrMI9HgHg//Fb/GXajhLiwv5I80ul1+I0XErwl6Ra5VGqzdfICADC
	YbscHCBjTlpKOPMZQvL73yz7N4MdC+lwB5gF1zjyJmFMvypTXC8uf49VRY3YL2w8lBtqGOFo7Mx
	XROp+AQN7AX8qDg+WgjS+rt2dId1w2AbxHC6Fii7edhTyFouAOsp/GbklcwKdImCjX2pqPSNRM6
	MuBKkWoDBZGLZZ6pBQBWcQCazlMNNtk53LmNxlubMfv+7giVTrYIq9ep6GZZpvt9jtORKaS1W04
	Qb3jagaBCuQgLDJQ2gCfJ3dfYPai19eeg4e/jQXxdzg9Fq9Wgd80lY2DY65HItRAQ9Lhxkrj/kk
	lr0LMR2CP7J/ONlARswps=
X-Google-Smtp-Source: AGHT+IGKdzRBnHICTlRWGJzmFCnaBvcnI3d6GGx35do6Dsr1hh8Gc5HdQMPNrFaQ6n6EcK7eJyNvKw==
X-Received: by 2002:a05:7300:5613:b0:2b0:1607:6d02 with SMTP id 5a478bee46e88-2b17d2ba86cmr4428926eec.31.1767876155196;
        Thu, 08 Jan 2026 04:42:35 -0800 (PST)
Received: from localhost ([2804:30c:2766:a500:b70:8c42:f792:bef6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1707b21dasm9868181eec.27.2026.01.08.04.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 04:42:34 -0800 (PST)
Date: Thu, 8 Jan 2026 09:44:20 -0300
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
Message-ID: <aV-mpFCF_ET3AZ1B@debian-BULLSEYE-live-builder-AMD64>
References: <20251219-spi-add-multi-bus-support-v4-0-145dc5204cd8@baylibre.com>
 <20251219-spi-add-multi-bus-support-v4-5-145dc5204cd8@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219-spi-add-multi-bus-support-v4-5-145dc5204cd8@baylibre.com>

Actually, one more thing ...

On 12/19, David Lechner wrote:
> Add a new page to Documentation/spi/ describing how multi-lane SPI
> support works. This is uncommon functionality so it deserves its own
> documentation page.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
...
> +- :c:macro:`SPI_MULTI_BUS_MODE_STRIPE`: Send or receive two different data words
> +    at the same time, one on each lane. This means that the buffer needs to be
> +    sized to hold data for all lanes. Data is interleaved in the buffer, with
> +    the first word corresponding to lane 0, the second to lane 1, and so on.
> +    Once the last lane is used, the next word in the buffer corresponds to lane
> +    0 again. Accordingly, the buffer size must be a multiple of the number of
> +    lanes. This mode works for both reads and writes.
> +
> +    Example::
> +
> +        struct spi_transfer xfer = {
> +            .rx_buf = rx_buf,
> +            .len = 2,
> +            .multi_lane_mode = SPI_MULTI_BUS_MODE_STRIPE,
> +        };
> +
> +        spi_sync_transfer(spi, &xfer, 1);
> +
> +    Each tx wire has a different data word sent simultaneously::
In this example, the controller is reading data so the rx wires have different
data word received?

> +
> +        controller    < data bits <     peripheral
> +        ----------   ----------------   ----------
> +            SDI 0    0-0-0-1-0-0-0-1    SDO 0
> +            SDI 1    1-0-0-0-1-0-0-0    SDO 1
> +
> +    After the transfer, ``rx_buf[0] == 0x11`` (word from SDO 0) and
> +    ``rx_buf[1] == 0x88`` (word from SDO 1).

