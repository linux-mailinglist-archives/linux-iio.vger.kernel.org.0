Return-Path: <linux-iio+bounces-3266-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3560286F4C6
	for <lists+linux-iio@lfdr.de>; Sun,  3 Mar 2024 13:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD7BE2820F5
	for <lists+linux-iio@lfdr.de>; Sun,  3 Mar 2024 12:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E901BE4E;
	Sun,  3 Mar 2024 12:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjqDQONh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA35BE5A;
	Sun,  3 Mar 2024 12:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709468226; cv=none; b=odELfqn+or2TWUWQhLY420RWBZCjjWszPiI0Oms68BPQo+k4BX5rv3hUEnbFx45KOefOGaOfrANS9mSI8sm6M3oZW+JWKq4AgGxoYtU3+gFDfm4NgTszPvevciFnxtoP7pt8blv2ilbEsNmcjnln6BkEbymQMqff/6XuGOqpdAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709468226; c=relaxed/simple;
	bh=1Lr8hlwxn2OTZxHIhdRHf62rtWGtEQQ/FmpdEJQsh/w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VtnrGXn2/GYrQpn6ngRFyQfhSik00+JyH41Xx/cUO2nDgNVFOiIrE9xBpkFUBbW/F4fxy0jl/z0s1omfJsKJOCBYdTB6IQlRJwGPB1xBqYmwF7+8846ePbkP+G4zNkdbxLfDjsD2bOdwFWcLLBXed1vegh7ym5gJGptKPWDkdVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SjqDQONh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69E0C433C7;
	Sun,  3 Mar 2024 12:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709468225;
	bh=1Lr8hlwxn2OTZxHIhdRHf62rtWGtEQQ/FmpdEJQsh/w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SjqDQONhj4GhMtjZbBA2xyrAeCw+Ai6JEgbWeeaImVKqxqb+CYltNxT8Pv8GjWeAA
	 SyaJ8BSo0CStnOqbjN4/flUA95KrTVDqqNwmvxktT3b9NuN9dkNb/HFjWWx+mSj8YR
	 JFTJK7z6qSpK8k/RQsW33dPphaSBZUpGYVtO90LkUa3sWk0yW4Rw7p7lEv5PortRjH
	 dMKln/yBV8xPuxF/+SN1WtIivEnDJCSs0XLBxawpk4EnpHYcOKMl+SNPeyjpg0ZniR
	 DFEeS+1Fs5OV4dBZ6UdTJFJv9gmxjccCA3Mvd4j67pLODC7AhSRpi9vxryCLjDMFK3
	 thlX4F1VwPoog==
Date: Sun, 3 Mar 2024 12:16:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>
Subject: Re: [PATCH v3 1/3] iio: temperature: ltc2983: convert to
 dev_err_probe()
Message-ID: <20240303121653.22f115c1@jic23-huawei>
In-Reply-To: <20240301-ltc2983-misc-improv-v3-1-c09516ac0efc@analog.com>
References: <20240301-ltc2983-misc-improv-v3-0-c09516ac0efc@analog.com>
	<20240301-ltc2983-misc-improv-v3-1-c09516ac0efc@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 01 Mar 2024 18:14:50 +0100
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno Sa <nuno.sa@analog.com>
> 
> Use dev_err_probe() in the probe() path. While at it, made some simple
> improvements:
>  * Declare a struct device *dev helper. This also makes the style more
>    consistent (some places the helper was used and not in other places);
>  * Explicitly included the err.h and errno.h headers;
>  * Removed an useless else if();
>  * Removed some unnecessary line breaks.
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>

I'd rather see a proposal for dev_errp_probe() than a local solution.
We can fallback to local solution if it doesn't meet with approval!

Not that many uses in IIO so far, but seems some potential elsewhere.
There are already a few return ERR_PTR(dev_err_probe()) cases in tree
for low hanging fruit + looks like scmi_iio could benefit as another case
in IIO.

> ---
>  drivers/iio/temperature/ltc2983.c | 262 ++++++++++++++++++--------------------
>  1 file changed, 122 insertions(+), 140 deletions(-)
> 
> diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
> index 3c4524d57b8e..592887097117 100644
> --- a/drivers/iio/temperature/ltc2983.c
> +++ b/drivers/iio/temperature/ltc2983.c
> @@ -8,6 +8,8 @@
>  #include <linux/bitfield.h>
>  #include <linux/completion.h>
>  #include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
>  #include <linux/kernel.h>
>  #include <linux/iio/iio.h>
>  #include <linux/interrupt.h>
> @@ -206,6 +208,13 @@ enum {
>  #define to_temp(_sensor) \
>  		container_of(_sensor, struct ltc2983_temp, sensor)
>  
> +/* Helper macro for returning error pointers in probe() paths. */
> +#define ltc2983_errp_probe(dev, ret, fmt, ...)	({			\
> +	int ___ret = dev_err_probe(dev, ret, fmt, ##__VA_ARGS__);	\
> +									\
> +	ERR_PTR(___ret);						\

Given it's all wrapped up in a macro, I'd avoid the need for the ___ to try
and prevent shadowing an existing variable by just going with
	ERR_PTR(dev_err_probe(dev, ret, fmt, ##__VA_ARGS__))
and no ({ complexities.

If you really need to use a local variable, just through the hoops to make it unique
like the cleanup.h macros do.

> +})
> +



