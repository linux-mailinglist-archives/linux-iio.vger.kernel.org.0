Return-Path: <linux-iio+bounces-27549-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 799C9D02F68
	for <lists+linux-iio@lfdr.de>; Thu, 08 Jan 2026 14:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 715EB324AD1F
	for <lists+linux-iio@lfdr.de>; Thu,  8 Jan 2026 12:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2D546AF1B;
	Thu,  8 Jan 2026 12:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMwjUTQ7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F82F468BA3
	for <linux-iio@vger.kernel.org>; Thu,  8 Jan 2026 12:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767876208; cv=none; b=ZfIUL3f219Fbg/Wj/0Kp/o+8Ud3hY3T/EbkGXBOolvgxI4oXne3Hzw33CRGPpC9TfKUljEOByhGWlJyxWLX8lgnOM89JASuGjWXNm/PiCo8vaayo1mzggB/qkft3/3Hql4ZsbIkdKRYgFRFpPSk+Y+tYcApsOS/apUX3F3bg0/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767876208; c=relaxed/simple;
	bh=z7zT9xKe1ldz6nAdF7ki6sqTjzVHOouLduI1GDfGhsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSCi64Rj+647a1zOXO7SHlMZv4GUq76iLUpFkehpw9wkTvT8ybsYgDqTxH8d82Pc7I9+m7+oyeRnTDixj5HM1sd7k/NPabVMXCWU414XWr/BebbW1QOIJQy8VY8ozLZr1YDJv+OR8dhJn8gukQd7UF6j5Vq6LOdLCIkjB5FXZV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMwjUTQ7; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-11f3e3f0cacso3290158c88.0
        for <linux-iio@vger.kernel.org>; Thu, 08 Jan 2026 04:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767876206; x=1768481006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9P2Q5ai3Zs42eKrGWy8iPRExMHDLzwHYhJ4m6exqKKE=;
        b=TMwjUTQ73LCWUeUa5kmB1Jegg/NwUY7TvyqjMs1qfe87RVVvQRUJnvdd7Tm3aae5Le
         UImVT1ieyDojBqsqp/x38Ibyk7IFm1lFjn/AkbwcFEkdTIe0gIi6H7K8bssf4Z3rdlAX
         YrE7moXZz7pWX291rj7tA9xdkUARVFC5S56bBtADjDp+dsd66GB8N2IUyMRtAJ1EOSIv
         HeCjyoXUL4W/3h8HJBkWh81COR9voGEL/ywXu4R5Fp3ST2204he6xOI1XJKekuDpN+Ug
         t3QcEGIZsWDfvJ6IL/xm9XYIxDcizuiHeMHeuo8KAHS4Ti+Pvc5uaUuQq0P6HN+LBO/B
         3Plg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767876206; x=1768481006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9P2Q5ai3Zs42eKrGWy8iPRExMHDLzwHYhJ4m6exqKKE=;
        b=SHzOT6UYm1SHYUuD0FGanLgYMnJVLMXfo8O7/U8zT+3hd2OZrntO5g8hSFbf5T2lZ2
         Y9yG7zkcgVbKMGt3AAozshgQnOUYKVT7clFUGSeUKnU9LvKbp/HDV42l5vkhgalWLT+T
         fi0ERFZpUcdNRGp6lGPk3kJUAIqwVCb3+akZEczaCd2aKLyDfTKBvo3ncJMOgqw4q+f0
         HQrerPUqu6p4DVsScGb1Opihv5SQgqkpQdvEzTvdKFYYrxt8VF8zgr+1dtlfw5GHIKWX
         p3FGT6bLZfbaOL15jeZXB4XrIenm949vZmMtFLwZStPllBOm89eAZpMb2OEX2Eyj7cdQ
         v/sQ==
X-Forwarded-Encrypted: i=1; AJvYcCWl5r/uyvDhmU0MPbNpOfbXa7Q4Hv5/e+K3CHXOGXGbmEHNxZfNfdaAKLmKHPtsRM7MurmtHSqA5yk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAUeMp2ysuEZfQf14oVMlFhIUvOxq4KyeOFKzGahB+/0Pj0Og4
	3htvK6bMIHnEBy3T7Cu+0DnbWzlmVDGZNhld+WbhTdmPcZUthwLHWJYf
X-Gm-Gg: AY/fxX52fOVVLQ4aFo69X4E6L9+HzWwwISzUjjM2PJ2NQnYT5aGugxJNYUM9lYI7ULU
	3OKcVShmLoTqHu4NnaogFylQYl3hAzCN72tnLzwoJvBkbUacuuH6Q0AMl+uP8BfcX1rtMaSWXux
	wnT1ACqMwWeBejOUKvo8LYUZmTDkIoZFW3sjmEg87+ynRQ/wGE/QFktqkStEApi7c2Yu41Kxz5q
	GU1Qk+EXKa6G4f8+aV9ZRrCBxTDvaskjUHNxybkQJCODyUOYqNRZQ+F08aL14spp6lrp/DcD0gU
	ueitk+OCyA/zW3Wl0823gczIL6ucRt/YQZKfAc5HEBhO1IG2mb1KVTIYEHVvG8WJVhIbpe/gCDs
	NaEboziQlu/l7Nl9WMOIq8yuok7ZW4EqkhcfCM//33BFT4GJOeN99HR5T1zrEdHV4decsD86FqJ
	S8xPadIBdd7fu2t3SK8YU=
X-Google-Smtp-Source: AGHT+IFcqHdeQBlzUxRENKNW7abGlSOTFsAZXS0AEB4YmOtoPUwzEduwNrmBwXbKXhLN9NsnmA2wNw==
X-Received: by 2002:a05:7022:6baa:b0:11a:2ec8:de1c with SMTP id a92af1059eb24-121f8b65af5mr5726561c88.36.1767876205789;
        Thu, 08 Jan 2026 04:43:25 -0800 (PST)
Received: from localhost ([2804:30c:2766:a500:b70:8c42:f792:bef6])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f243421esm13964538c88.2.2026.01.08.04.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 04:43:25 -0800 (PST)
Date: Thu, 8 Jan 2026 09:45:11 -0300
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
Subject: Re: [PATCH v4 7/9] spi: axi-spi-engine: support
 SPI_MULTI_LANE_MODE_STRIPE
Message-ID: <aV-m15qu9tt1_GjP@debian-BULLSEYE-live-builder-AMD64>
References: <20251219-spi-add-multi-bus-support-v4-0-145dc5204cd8@baylibre.com>
 <20251219-spi-add-multi-bus-support-v4-7-145dc5204cd8@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219-spi-add-multi-bus-support-v4-7-145dc5204cd8@baylibre.com>

On 12/19, David Lechner wrote:
> Add support for SPI_MULTI_LANE_MODE_STRIPE to the AXI SPI engine driver.
> 
> The v2.0.0 version of the AXI SPI Engine IP core supports multiple
> lanes. This can be used with SPI_MULTI_LANE_MODE_STRIPE to support
> reading from simultaneous sampling ADCs that have a separate SDO line
> for each analog channel. This allows reading all channels at the same
> time to increase throughput.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

