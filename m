Return-Path: <linux-iio+bounces-19048-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A78AA8799
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 18:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7D0D1897A3D
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 16:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759B41D5ADC;
	Sun,  4 May 2025 16:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQQPi4DD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298894C7C;
	Sun,  4 May 2025 16:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746374567; cv=none; b=n9DIqT7A9X4argqTiILRJNnPK0iVRZJ/zB/MMObnJg7IQ/QuTqXmaehANoWeNrSnJhWti6aKYhGmcFpdhFpntJwpheOAUxs/hO1DSaDgGiECf/6r1tbhG9w+hBPai8NAlo5XhWmmuIKYNbmK0rI5Ro0Y4UCiBer3XnhVofBIlvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746374567; c=relaxed/simple;
	bh=BFHMsTPszTF3xXY2zylqYXdY6IMVQpG3ks1nZ8p4z8E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N/t3qSx5WpgRYYLIxjxLRVvQfEpb2liNK0WYpuunhrq8g0LAu50iICYwQ7PckY+Aionf60Tg+fxyEvK14cS87pcV0IMlgqi5H254eDyI01lIZGZuGYp7lvbZm42jD9f2WCrK5tpGHBqErdc8/YLqXV618+ClH52PCp9HEfhm93M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQQPi4DD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D68C4CEEF;
	Sun,  4 May 2025 16:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746374566;
	bh=BFHMsTPszTF3xXY2zylqYXdY6IMVQpG3ks1nZ8p4z8E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fQQPi4DDj6DWJH2qy1/3yVtoRiCZHmgamzhDXRj3vRMhNpUx0jV/7Dr7FPRuwan8M
	 5CKP1Kg63STYQmyMGKz4un4rsjyQT8AAQKwKCM3f6B8spb68lWF0f9iens4L1vc0H/
	 UDDhgdKr1BsWP4V0pdqQU0Ay2MDDEa6QNLlAmKN1BwYevSZKLkAcu05OF6Xrdkhz2S
	 e7g8wVjb+iIzJnL0JY5jzdX8DjdzdI/GGUiAPyJsud5D10BtJNsD6UdDJImBijqex+
	 U4mxSTg4acWqYsY9W3vmZR+1lMcUmz6l1MLP5Tmh3USTgDyUQkJEykHnvO5On5CLUU
	 9Ve0P/G7WDFMA==
Date: Sun, 4 May 2025 17:02:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sayyad Abid <sayyad.abid16@gmail.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, javier.carrasco.cruz@gmail.com,
 olivier.moysan@foss.st.com, gstols@baylibre.com, tgamblin@baylibre.com,
 alisadariana@gmail.com, eblanc@baylibre.com, antoniu.miclaus@analog.com,
 andriy.shevchenko@linux.intel.com, stefan.popa@analog.com,
 ramona.gradinariu@analog.com, herve.codina@bootlin.com,
 tobias.sperling@softing.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/5] MAINTAINERS: add entry for TI ADS1262 ADC
 driver
Message-ID: <20250504170234.46b52188@jic23-huawei>
In-Reply-To: <20250501100043.325423-5-sayyad.abid16@gmail.com>
References: <20250501100043.325423-1-sayyad.abid16@gmail.com>
	<20250501100043.325423-5-sayyad.abid16@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  1 May 2025 15:30:42 +0530
Sayyad Abid <sayyad.abid16@gmail.com> wrote:

> Add a new MAINTAINERS section for the TI ADS1262 ADC driver, which includes
> the main source file and the device tree binding documentation.
> 
> Signed-off-by: Sayyad Abid <sayyad.abid16@gmail.com>
Better to add this (and build it up in stages) as part of the patch
that introduces the 1st file which should be the DT binding.  

That way checkpatch won't moan ;)

Jonathan


> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3cbf9ac0d83f..10b2e9293a99 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24187,6 +24187,13 @@ S:	Supported
>  F:	Documentation/devicetree/bindings/iio/adc/ti,ads7924.yaml
>  F:	drivers/iio/adc/ti-ads7924.c
>  
> +TI ADS1262 ADC DRIVER
> +M:	Sayyad Abid <sayyad.abid16@gmail.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/adc/ti,ads1262.yaml
> +F:	drivers/iio/adc/ads1262.c
> +
>  TI AM437X VPFE DRIVER
>  M:	"Lad, Prabhakar" <prabhakar.csengg@gmail.com>
>  L:	linux-media@vger.kernel.org


