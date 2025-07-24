Return-Path: <linux-iio+bounces-21935-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B44FBB1077F
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 12:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4FED1CE3011
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 10:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D663C25F988;
	Thu, 24 Jul 2025 10:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+KOmwgg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873EE25E828;
	Thu, 24 Jul 2025 10:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753351980; cv=none; b=ENnbvfourRX/QZr9HsQK2a7cwWHfUm8x9I67OOfkwoLLdGG+pAPirXpBdFLEMhZrLXhKpuzHpCh/jJ2HDDFW6DuJQdH5aVpCwYzZQ0JP5VaLj6rAmaaO06TaM4sbCafmyMfTPirawP5SDXcJjVWGgcKaC2G/lzqf9zoN2xKGpHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753351980; c=relaxed/simple;
	bh=MKTJsXoh0ovoIVsPRZJbybf8oVQe3fF6tNG1svHyD9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e7qPJ65kx14r6AMQoX9FF5LTk+hTpS25/JNOuNOEVUjay85CcjUR8eQmq3sRo8403iK1ZVC6cEw8pwFrXRcJUdrAICZyIWlIyaNb8fkVZuUnRZ6HL0/n3kNeyQaTlu5ZDsl1ye4vfnKU8Qwht2SCRXoAK60+LQk2cKERe8aKLyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+KOmwgg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C04C4CEF4;
	Thu, 24 Jul 2025 10:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753351979;
	bh=MKTJsXoh0ovoIVsPRZJbybf8oVQe3fF6tNG1svHyD9Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F+KOmwgg+z7e6KttvqwjToMUUNQKbMcch6Kaqh7mZiJe+e9MtjQqK0QFMCc/r6Sja
	 p+D1xm97+/1DEirZQdiS8y+/KFaz8D6qlqH/lfgk8mS6gp58TEMqhj6XVq6SYaXY5J
	 zQuYjzsOKaKulq2ezVsbW2oiw0HNwtpngA5XWMEv7MyE5aSpR/zbmzYjpcXTHEcitb
	 TfjwB0SaDiSzB8/wFtEMf3vnCWpMBWKbirWtqS8e6MvX9yNTXf0K3in3uJsMhAoGaZ
	 Tmo1DaoDs2g06Y13IpqoEM1crzlFMx2a8w1h76uWBwcDwvJC1BSwoH7wUiLJemnoiU
	 GobqWa0flpRbQ==
Date: Thu, 24 Jul 2025 11:12:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Suthar <sanjaysuthar661996@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 ribalda@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, neil.armstrong@linaro.org,
 khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com
Subject: Re: [PATCH v3] dt-bindings: cleanup: fix duplicated 'is is' in YAML
 docs
Message-ID: <20250724111247.669d6955@jic23-huawei>
In-Reply-To: <20250722170513.5854-1-sanjaysuthar661996@gmail.com>
References: <20250722170513.5854-1-sanjaysuthar661996@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Jul 2025 22:35:13 +0530
Sanjay Suthar <sanjaysuthar661996@gmail.com> wrote:

> Fix minor grammatical issues by removing duplicated "is" in two devicetree
> binding documents:
> 
> - net/amlogic,meson-dwmac.yaml
> - iio/dac/ti,dac7612.yaml
> 
> Signed-off-by: Sanjay Suthar <sanjaysuthar661996@gmail.com>

I'd have no problem with the argument that this can go through either
tree if there was any interaction between the files or the changes, but
here there isn't. This is just causing potential mess if either tree ends
up with other changes overlapping this for no benefit.  Please split into
two patches, one for each subsystem.  You should be fine to keep the
various tags given here for the new patches.

Jonathan


> ---
> Changes since V2:
> - Corrected the subject line
> - link to v2 : https://lore.kernel.org/linux-iio/20250720182627.39384-1-sanjaysuthar661996@gmail.com/T/#u
> 
>  Documentation/devicetree/bindings/iio/dac/ti,dac7612.yaml      | 2 +-
>  Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac7612.yaml b/Documentation/devicetree/bindings/iio/dac/ti,dac7612.yaml
> index 20dd1370660d..624c640be4c8 100644
> --- a/Documentation/devicetree/bindings/iio/dac/ti,dac7612.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/ti,dac7612.yaml
> @@ -9,7 +9,7 @@ title: Texas Instruments DAC7612 family of DACs
>  description:
>    The DAC7612 is a dual, 12-bit digital-to-analog converter (DAC) with
>    guaranteed 12-bit monotonicity performance over the industrial temperature
> -  range. Is is programmable through an SPI interface.
> +  range. It is programmable through an SPI interface.
>  
>  maintainers:
>    - Ricardo Ribalda Delgado <ricardo@ribalda.com>
> diff --git a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
> index 0cd78d71768c..5c91716d1f21 100644
> --- a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
> @@ -149,7 +149,7 @@ properties:
>        - description:
>            The first register range should be the one of the DWMAC controller
>        - description:
> -          The second range is is for the Amlogic specific configuration
> +          The second range is for the Amlogic specific configuration
>            (for example the PRG_ETHERNET register range on Meson8b and newer)
>  
>    interrupts:


