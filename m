Return-Path: <linux-iio+bounces-9325-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64131970766
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 14:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 285A7281E0B
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 12:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B03161328;
	Sun,  8 Sep 2024 12:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSvhceZV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C056420B20;
	Sun,  8 Sep 2024 12:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725798575; cv=none; b=SxLG5hxcnHnlcHvTCy6xWUommK8tgWEM+3GuhIDfEDVbWAjc6qCNXZf3rDneSjzc44KsmJY+i4YkPRZzzWoa5kpVz9BSUMMbBrbmvNAgNzhc9wqZWqjC+gtqhsV7Fg804D7PGfyJj8oxr0Gw6AUNXN5L1Dft93tg4UQKLQEd+ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725798575; c=relaxed/simple;
	bh=LeSUaK5+Z0HiapwcQsbC1SlqrKMbt+ozqonDsvF2Mv4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YNXIjdRAqvryglgp52rJVUmJgorqqz4l60h4RAgh/ObgcmjH+e3uaR/qE9H7uSmIvbT5Z7rKhPtu7xKvn3XqtSVxml0IQpZR0ufzdNBp4FStILSCr4RwP/foXy6ZS5jpwGGNcMUF1tU2NhmcFG4adthNC1SiETcKPN1VJa4Z6Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSvhceZV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55BAC4CEC3;
	Sun,  8 Sep 2024 12:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725798575;
	bh=LeSUaK5+Z0HiapwcQsbC1SlqrKMbt+ozqonDsvF2Mv4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LSvhceZVZh+1TBVlGWhrfGv/G2cU+dJLyPs1gVC7ut659HwxFWgNuZLDiHsMukG23
	 AGUzfgYA7GvrT0/UyBGfj3t+xLg/x7s2m/67+txOB7S+Bg55z2z5HCJ4k+KLHbQv6F
	 iqKaMXtYOEY1YpbJ2Wi5cjsyNncvY5/JjHs9zbrr7uRgm11VfiCHYJKguruFBZOsd6
	 Gt0WpTKqCG7UY2LFJ6KMylpHlXW8ph668Vm0DK+ApuC1AOT8PtR0aXTGkGhEmffK3N
	 jRxE6Q6s/jKWCE80SXXrN/VRksDGb+pAaaN8DnZTl2abHFt21xODif0STd3Bm7V95k
	 CuldoOAhSJbLg==
Date: Sun, 8 Sep 2024 13:29:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>
Subject: Re: [PATCH v2 1/9] dt-bindings: iio: dac: ad3552r: add io-backend
 property
Message-ID: <20240908132925.331c5175@jic23-huawei>
In-Reply-To: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-1-87d669674c00@baylibre.com>
References: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
	<20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-1-87d669674c00@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 05 Sep 2024 17:17:31 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> There is a version AXI DAC IP block (for FPGAs) that provides
> a physical bus for AD3552R and similar chips. This can be used
> instead of a typical SPI controller to be able to use the chip
> in ways that typical SPI controllers are not capable of.
> 
> The binding is modified so that either the device is a SPI
> peripheral or it uses an io-backend.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>

>  
>  required:
>    - compatible
> -  - reg
> -  - spi-max-frequency
Sort of feels like both reg and spi-max-frequency
are valid things to specify. 

Maybe we have an excellent IP and dodgy wiring so want
to clamp the frequency (long term - don't need to support
in the driver today).

Maybe we have an axi_dac IP that supports multiple
front end devices?  So maybe just keep reg?
>  
>  additionalProperties: false
>  
> @@ -238,4 +254,26 @@ examples:
>              };
>          };
>      };
> +
> +  - |
> +    backend: axi_dac@44a70000 {
> +        compatible = "adi,axi-dac-ad3552r";
> +        reg = <0x44a70000 0x1000>;
> +        dmas = <&dac_tx_dma 0>;
> +        dma-names = "tx";
> +        #io-backend-cells = <0>;
> +        clocks = <&ref_clk>;
> +        dac {
> +            compatible = "adi,ad3552r";
> +            reset-gpios = <&gpio0 92 1>;
> +            io-backends = <&backend>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            channel@0 {
> +                reg = <0>;
> +                adi,output-range-microvolt = <(-10000000) (10000000)>;
> +            };
> +        };
> +    };
> +
>  ...
> 


