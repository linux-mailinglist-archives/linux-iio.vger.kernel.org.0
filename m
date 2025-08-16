Return-Path: <linux-iio+bounces-22791-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB62B28CD3
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 12:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B5837BB620
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 10:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F1A290DBC;
	Sat, 16 Aug 2025 10:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxCrGH+f"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7634C28D8CD;
	Sat, 16 Aug 2025 10:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755339902; cv=none; b=Ut5IhnK8aFNTW3vuW/a2WT+yFEvHbxVcTy27/VOrWRpNcLtRyqDEo7Vrb0YbAP7dQiHoPp+0IrQEIggQgwhZePHqlzPx9RIkNsb9sLJatLOJpt1CN2P/PaypgQC3jh3hkOM/zQ2tqyF4JgxxBd1AOFjpCiOBh1FYCP2fLGy1LxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755339902; c=relaxed/simple;
	bh=BropNB1sERJWBUWA58+0wXXW4EeF8t30O+jhk0LIUFU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a8Ci+ifGbaUuIYhG+D2AIY+wd/nNGlLQ1+lnL6LhWznrB0HPByZbsbQkP79eD+3yGxG10x/HtLHN1xBLP9vWE18POM/LqZQwcdx/wM4pxDaFtywYrV8D1h8jCaZI9esIkpvIilMMyXHNLMf8A00hWm8KExXczeBIUVDGiAGVV7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxCrGH+f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07109C4CEEF;
	Sat, 16 Aug 2025 10:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755339902;
	bh=BropNB1sERJWBUWA58+0wXXW4EeF8t30O+jhk0LIUFU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dxCrGH+fIyfK5BHNSlciUFVAy4CTH1nkbKKFdYGE/BB7VQ7OCw4Z3Gho6eZrgizrZ
	 PkBowUWQ6qXXTCVrdGZC4SVAICsm9UmIfYuIVoorvMwngq4G/8o8ney8OAAlCHWUho
	 7r6BlG9Si3exYULfn+XIuIfuLSy/zusRavmQARGipUfZXeKAKdFZQZ7UygpbHu5hZp
	 p8PnenO4euDP9daPDhtu6GZKabp0jRn2TzyFpXv72K1Xr+iV3ivY5ctlko5a6bnCHh
	 z2fXGor2+xP1F1lPkTS97JPVFcPr7asXhCkgV9iMp/jdsnohMdgsmo6ZTn2AlhULr9
	 EX3L976wMsFxQ==
Date: Sat, 16 Aug 2025 11:24:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Beguin <liambeguin@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: iio: adc: ltc2497: add lltc,ltc2495
 bindings
Message-ID: <20250816112454.37376453@jic23-huawei>
In-Reply-To: <20250815-ltc2495-v4-1-2d04e6005468@gmail.com>
References: <20250815-ltc2495-v4-0-2d04e6005468@gmail.com>
	<20250815-ltc2495-v4-1-2d04e6005468@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Aug 2025 12:02:02 +0200
Yusuf Alper Bilgin <y.alperbilgin@gmail.com> wrote:

> Update the binding documentation for LTC2497 to include LTC2495 to
> enable support for its internal temperature sensor, which requires a
> different I2C command format and a new IIO channel.
> 
> Signed-off-by: Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
See reply to v1.  

At least at first look it appears this should have a fallback compatible
as Krzysztof called out.

> ---
>  Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
> index 5cc6a96840778473895f436b7e2627d6240b254b..2a3e3dcc6ca7a48a0fccb88d8d42fee34efcff73 100644
> --- a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
> @@ -17,11 +17,13 @@ description: |
>  
>      https://www.analog.com/media/en/technical-documentation/data-sheets/2309fd.pdf
>  
> +  LTC2495:
>    LTC2497:
>    LTC2499:
>      16bit ADC supporting up to 16 single ended or 8 differential inputs.
>      I2C interface.
>  
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/2495fe.pdf
>      https://www.analog.com/media/en/technical-documentation/data-sheets/2497fb.pdf
>      https://www.analog.com/media/en/technical-documentation/data-sheets/2499fe.pdf
>  
> @@ -29,6 +31,7 @@ properties:
>    compatible:
>      enum:
>        - lltc,ltc2309
> +      - lltc,ltc2495
>        - lltc,ltc2497
>        - lltc,ltc2499
>  
> 


