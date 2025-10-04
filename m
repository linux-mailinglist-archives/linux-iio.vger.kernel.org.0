Return-Path: <linux-iio+bounces-24704-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF50BB8DBA
	for <lists+linux-iio@lfdr.de>; Sat, 04 Oct 2025 15:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6BB00346E8A
	for <lists+linux-iio@lfdr.de>; Sat,  4 Oct 2025 13:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DD227FD78;
	Sat,  4 Oct 2025 13:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDfA6ttu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B792765E2;
	Sat,  4 Oct 2025 13:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759583562; cv=none; b=eY60PJbWPqU3ht1/t96cyfQvysazmoe1d4rppaWb8rdxwPJ6XyyN2sHAg4mwD1wLhPj+KP9H8hbpLweoXjzuPpFyFveTQ1JffsF1Vtd9Q7Lp/0tFcmLUZqVTn0JYJMyuObEhIyUbqwUXmgpZxrII8u8LJjepTkVALHDO/hv0p7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759583562; c=relaxed/simple;
	bh=ElbmqKxSpvT9cD73o61l65VRUnn2RptQHPKQcI48BD4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wldqevsp8EQxUJg1L5hrSdNjCWGTwjStlnhN9WBRVaxARweXbs8YVFGiMq/Xnx98ZamboKKZbRpbfX8zR4waN9jZeLeccv934Lrb9HjDMwdITXx4SSVTyPBO3B46H0ck49BacRkWlaXlp3ohKaUVaLN7ILrveFk2p60qbrrziWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDfA6ttu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55CBC4CEFA;
	Sat,  4 Oct 2025 13:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759583562;
	bh=ElbmqKxSpvT9cD73o61l65VRUnn2RptQHPKQcI48BD4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FDfA6ttuczln4tMzS/Lnev1OCEBhodUflNfFW2dDAcbQFiFhIBFONF9BgHHKbaIet
	 WexNlwYiXOhEg5bsdXw8VcYYJVvIZL0dYV6pRRN3bURZdh7kvvSbYJhzbe4SX8ngQb
	 Idvw/tDxxWFaxj3DcqID0PWAMKLu1a0oPe1QioqVXHS3/6h8+VDGXKtENcdeLSmO/6
	 4oCejeBdAB4RBE0Tg5FoX8BvmAZM2pOnyNoXyX7fnY8nKdkW25B7OEgG8MBROqSjUX
	 ZYfCTOwjtAHUb3q6HeoWdz0y3kKtEcDGpPyIyt35S58VDSiWgiFxSvwOvlyQDX96Ox
	 J5khA6zOs00gQ==
Date: Sat, 4 Oct 2025 14:12:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Shrikant Raskar <raskar.shree97@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 matt@ranostay.sg, skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH 1/2] dt-bindings: iio: max30100: Add pulse-width
 property
Message-ID: <20251004141231.632c311d@jic23-huawei>
In-Reply-To: <20251004015623.7019-2-raskar.shree97@gmail.com>
References: <20251004015623.7019-1-raskar.shree97@gmail.com>
	<20251004015623.7019-2-raskar.shree97@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  4 Oct 2025 07:26:22 +0530
Shrikant Raskar <raskar.shree97@gmail.com> wrote:

> The MAX30100 sensor supports multiple LED pulse widths (200us, 400us,
> 800us, 1600us). These settings affect measurement resolution and power
> consumption. Until now, the driver always defaulted to 1600us.
> 
> Introduce a new device tree property `maxim,pulse-width` that allows
> users to select the desired pulse width in microseconds from device
> tree.
> 
> Valid values are: 200, 400, 800, 1600.
> 
> This prepares for driver changes that read this property and configure
> the SPO2 register accordingly.
> 
> Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>
Hi Shrikant,

Explain why this is in some way related to characteristics of how the
system containing this chip is built (wiring, lenses etc).  Otherwise
this might instead be something that should be controlled from userspace
not firmware.

Also, give a little more on why we care about controlling it at all.
Is there a usecase where power use of this chip matters?  Mostly I'd expect
it to be in measurement equipment with relatively short measuring periods.

Jonathan

> ---
>  .../devicetree/bindings/iio/health/maxim,max30100.yaml      | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/health/maxim,max30100.yaml b/Documentation/devicetree/bindings/iio/health/maxim,max30100.yaml
> index 967778fb0ce8..55aaf2ff919b 100644
> --- a/Documentation/devicetree/bindings/iio/health/maxim,max30100.yaml
> +++ b/Documentation/devicetree/bindings/iio/health/maxim,max30100.yaml
> @@ -27,6 +27,11 @@ properties:
>        LED current whilst the engine is running. First indexed value is
>        the configuration for the RED LED, and second value is for the IR LED.
>  
> +  maxim,pulse-width:
> +    maxItems: 1
> +    description: Pulse width in microseconds
> +    enum: [200, 400, 800, 1600]
> +
>  additionalProperties: false
>  
>  required:
> @@ -44,6 +49,7 @@ examples:
>              compatible = "maxim,max30100";
>              reg = <0x57>;
>              maxim,led-current-microamp = <24000 50000>;
> +            maxim,pulse-width = <1600>;
>              interrupt-parent = <&gpio1>;
>              interrupts = <16 2>;
>          };


