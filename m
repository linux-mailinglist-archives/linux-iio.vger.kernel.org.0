Return-Path: <linux-iio+bounces-360-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD9C7F8CB8
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 18:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25FE4281419
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 17:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D5E2C863;
	Sat, 25 Nov 2023 17:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hh023ng2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4293FBF5;
	Sat, 25 Nov 2023 17:23:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D37AFC433C7;
	Sat, 25 Nov 2023 17:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700933025;
	bh=gMkhf8RPl8pp028nV+oUvr++bgtB47tDt4Up7ve1fzQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hh023ng28djz1q4kDTHiPGNqU29wd1KvWNHRej6344yvso4XGCNTbbj3WxhlV2yZA
	 aAknmdPsVKQHmQfjV3gGIiXVnE+yGzxEhINmn//SXR+Iy0Edgq9Nw93nYs1XEDiJq+
	 HSGn3KMdZqaELxEvfBd+dnJX/Sk5VL0bM/mlXX2ST3My8fpXOaOIHuvb5W3kx7uzht
	 NccDLmRJ0POfOmFbgPXkWjBo/erH7oL+yl94BSx6txwa3/4OLOIOYYpDEehZgwxCFw
	 kp8GDQlRZn9mCZY6FNVJ9qVk1+hDkawhJCXh9YpNKZnpx/c4+o0KtO0Cxcx/90kNDV
	 6yEpTtt3NLznw==
Date: Sat, 25 Nov 2023 17:23:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Marius Cristea <marius.cristea@microchip.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: improve section MICROCHIP MCP3564 ADC
 DRIVER
Message-ID: <20231125172338.132cee83@jic23-huawei>
In-Reply-To: <20231122075629.21411-1-lukas.bulwahn@gmail.com>
References: <20231122075629.21411-1-lukas.bulwahn@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Nov 2023 08:56:29 +0100
Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> Commit 33ec3e5fc1ea ("iio: adc: adding support for MCP3564 ADC") adds a new
> iio driver and corresponding MAINTAINERS section. It however uses spaces
> instead of a single tab for all the entries in that MAINTAINERS section.
> 
> Although, the get_maintainer.pl script handles spaces instead of tabs
> silently, the MAINTAINERS will quickly get into a messy state with
> different indentations throughout the file. So, the checkpatch.pl script
> complains when spaces instead of a single tab are used.
> 
> Fix this recently added section using tabs instead of spaces.
> Further, add the driver's ABI documentation file to this section as well.
> 
> Fixes: 33ec3e5fc1ea ("iio: adc: adding support for MCP3564 ADC")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Good to cleanup, but I'm guessing no super rush to do so and this can wait for
next merge window.

As such, applied to the togreg branch of iio.git and initially pushed out
as testing for 0-day to ignore this one.

Jonathan

> ---
>  MAINTAINERS | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 04c6fcbb21aa..c74ec0681aa1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14213,11 +14213,12 @@ F:	Documentation/devicetree/bindings/regulator/mcp16502-regulator.txt
>  F:	drivers/regulator/mcp16502.c
>  
>  MICROCHIP MCP3564 ADC DRIVER
> -M:      Marius Cristea <marius.cristea@microchip.com>
> -L:      linux-iio@vger.kernel.org
> -S:      Supported
> -F:      Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
> -F:      drivers/iio/adc/mcp3564.c
> +M:	Marius Cristea <marius.cristea@microchip.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +F:	Documentation/ABI/testing/sysfs-bus-iio-adc-mcp3564
> +F:	Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
> +F:	drivers/iio/adc/mcp3564.c
>  
>  MICROCHIP MCP3911 ADC DRIVER
>  M:	Marcus Folkesson <marcus.folkesson@gmail.com>


