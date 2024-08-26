Return-Path: <linux-iio+bounces-8780-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C862095ED24
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 11:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 076581C218DC
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 09:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DE9144307;
	Mon, 26 Aug 2024 09:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OqULYCcM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8B913AD3F;
	Mon, 26 Aug 2024 09:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724664574; cv=none; b=G1PIABKf2qZSdtfSInllpp6jE8ptTX3TIm0Z8zqz2iwMvvaFDMheC7UPnKKJPCefYGWGR+Rp2NrlO/a6qMKj9YhZHzbSTqUiw8iLlzj6Ygdv1qSn9iqwDwJZKt0h/vZDSMkyMr+rnqlgQRQBgY3u93+GhWdPJJSV34A8U9NDbcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724664574; c=relaxed/simple;
	bh=yFtaOyJ3oZbhPtFgbua649+GIjQJIk5xntNn98+IQR4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uxXLcEQxB3q1N4lGpfm/vJ3h2vYxDhU9pN7jjNTzgaSrKQovEtdXxvNtQwiZK2SqPSNihTZY5+BDblVTPPrWPo6Vm1NPDuGulA0jTYvXdRanpR2PRo6niewLgttBxdSxbjc7jOZg6wkNYTOh04LOftkcEQeaJQ4ellydD3ICTOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OqULYCcM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E477C8403F;
	Mon, 26 Aug 2024 09:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724664574;
	bh=yFtaOyJ3oZbhPtFgbua649+GIjQJIk5xntNn98+IQR4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OqULYCcMB+OSTkFPTgm+yOBeUzxkwxkyBwtdmIel/WsSxWu2ZNlIDHXQNcKmPA5bK
	 4hRiAhEiGpArK0PjhFbOS9puXePcIzL5fY1n+Uhtms88TEmiHlzEkF+EmHQfiScsZa
	 jyUVeB0M58jZnFjXyji46f0W+Xj1oic90Vi3P1IuewwiFQPbwhBAhGRNN98gI8YvDK
	 abwRya7rGwmYBdSVt0TZcjg4gd8MsJP62mGsdoKed0HPAddBx0Kzqrgv7q8yVk7Pwx
	 R37iDvoyS7gcHBwQhL/sZSmWoEWApOJ5PTNqPqeWN4Ciyt/Kz8JWv8MO21N/1nE0m3
	 zJ+JaYq2NCuJg==
Date: Mon, 26 Aug 2024 10:29:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Esteban Blanc <eblanc@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno Sa
 <nuno.sa@analog.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH 5/6] iio: adc: ad4030: add support for ad4632-16 and
 ad4632-24
Message-ID: <20240826102921.1c897357@jic23-huawei>
In-Reply-To: <20240822-eblanc-ad4630_v1-v1-5-5c68f3327fdd@baylibre.com>
References: <20240822-eblanc-ad4630_v1-v1-0-5c68f3327fdd@baylibre.com>
	<20240822-eblanc-ad4630_v1-v1-5-5c68f3327fdd@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Aug 2024 14:45:21 +0200
Esteban Blanc <eblanc@baylibre.com> wrote:

> AD4632-24 and AD4632-16 are 2 channels ADCs. Both channels are
> interleaved bit per bit on SDO line.
> 
> Both of them do not have evaluation board. As such, the support added
> here can't be tested. Support is provided as best effort until someone get
> their hands on one.
> 
> Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
This looks fine to me.


