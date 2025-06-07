Return-Path: <linux-iio+bounces-20286-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C61AD0D6D
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 14:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBA391897F6E
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 12:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BC62253FF;
	Sat,  7 Jun 2025 12:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eX25nAtt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49424207DE2;
	Sat,  7 Jun 2025 12:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749299347; cv=none; b=sivPP/HSBQSJHF2hINIL10YdA3OYGI3kSpwNFUgJ+ZduZaJkCB9CY7Wj+ncl1gqUrMA1at9oaeE9Dox22LUCTaou936xBXqkNmv7aUuHwQV8gXtMXFg3qJayPPKtC7OtVlzGczC9/vJf5Od2EHZj4UEMGxKU18jO/H6tF59O910=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749299347; c=relaxed/simple;
	bh=yLr2SN6AWnsvGEoPz3p3WiRoZRj2v0VswxVquuGqpVo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gtqagiAlH1yv+ITheiywazq1DBCMVxk2FlicslDNP4GgIeId8P2z8aSOxE2lsFTQAbdx3ahaDUMMHZAZjVgjaM6fbAVe+iB5drzzH26tpBdnLdOHuktZrFai5/Jd+JTfjroHRp2h4AX+qs8DhWKLELM7SYlJfXbpcfmFqhu5heo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eX25nAtt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CEBCC4CEF0;
	Sat,  7 Jun 2025 12:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749299346;
	bh=yLr2SN6AWnsvGEoPz3p3WiRoZRj2v0VswxVquuGqpVo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eX25nAtt6HCijOGu+EywJzXgLdZs6vwQr5NxxiOMpj/OdPr3Tk84rPTZdDE5UaSUq
	 ObyJS8iibdD9PrGbnsyBt5HCnBqSRMPeyo2Lh8D3Mn6DcO0kk+K05syTiq0i6IYbA0
	 WFauSpED8ct+FrtCW8tiwKG5AauSnPP1CUet24bvM8yWdGNNUhFu/9BOJAA6WUSFlI
	 jkkQ0QruO0xyQDx+vtRdrGz+J/v4myrHLevcYegelHF6hWkZtoC3/OOUGuPB0+6zr7
	 bdLnpo4KV1MjDtlMndlLSy3zPOJiXnQcon4AQowb4+QsbbsvEfaqWvvUdbnjpZi68x
	 HNvcP8VCwZvQA==
Date: Sat, 7 Jun 2025 13:28:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
 <andy@kernel.org>, <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
 <marcelo.schmitt@analog.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <marcelo.schmitt1@gmail.com>,
 <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <lgirdwood@gmail.com>,
 <broonie@kernel.org>, <jonath4nns@gmail.com>, <dlechner@baylibre.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v10 04/12] dt-bindings: iio: adc: ad7768-1: Document
 GPIO controller
Message-ID: <20250607132855.20106540@jic23-huawei>
In-Reply-To: <cabbcbef9b1c8b4fcee5df82bbcb499eef9c5dcb.1749063024.git.Jonathan.Santos@analog.com>
References: <cover.1749063024.git.Jonathan.Santos@analog.com>
	<cabbcbef9b1c8b4fcee5df82bbcb499eef9c5dcb.1749063024.git.Jonathan.Santos@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Jun 2025 16:36:03 -0300
Jonathan Santos <Jonathan.Santos@analog.com> wrote:

> The AD7768-1 ADC exports four bidirectional GPIOs accessible
> via register map.
> 
> Document GPIO properties necessary to enable GPIO controller for this
> device.
> 
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
Small thing for future reference. Good to have DT patches early in a series but
please order those in the same order as you then make use of them later in the
series.  In this case the continued discussion on patch 9 means I can't pick
up patches 2/3 as they won't have a user yet.  That blocks me picking up
this and the GPIO controller support for now as well despite I think those
being ready to go.

Jonathan

> ---
> v10 Changes:
> * none.
> 
> v9 Changes:
> * none.
> 
> v8 Changes:
> * none.
> 
> v7 Changes:
> * none.
> 
> v6 Changes:
> * none.
> 
> v5 Changes:
> * none.
> 
> v4 Changes:
> * none.
> 
> v3 Changes:
> * none.
> 
> v2 Changes:
> * New
> ---
>  .../devicetree/bindings/iio/adc/adi,ad7768-1.yaml      | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> index 9a6df931edc3..18f93586fcdf 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> @@ -85,6 +85,14 @@ properties:
>        dt-bindings/iio/adc/adi,ad7768-1.h.
>      const: 1
>  
> +  gpio-controller: true
> +
> +  "#gpio-cells":
> +    const: 2
> +    description: |
> +      The first cell is for the GPIO number: 0 to 3.
> +      The second cell takes standard GPIO flags.
> +
>  required:
>    - compatible
>    - reg
> @@ -142,6 +150,8 @@ examples:
>              spi-max-frequency = <2000000>;
>              spi-cpol;
>              spi-cpha;
> +            gpio-controller;
> +            #gpio-cells = <2>;
>              vref-supply = <&adc_vref>;
>              interrupts = <25 IRQ_TYPE_EDGE_RISING>;
>              interrupt-parent = <&gpio>;


