Return-Path: <linux-iio+bounces-3034-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F36B8626D0
	for <lists+linux-iio@lfdr.de>; Sat, 24 Feb 2024 19:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0A8D1C20B18
	for <lists+linux-iio@lfdr.de>; Sat, 24 Feb 2024 18:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCFD42041;
	Sat, 24 Feb 2024 18:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLOSgG1x"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0615F2907;
	Sat, 24 Feb 2024 18:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708800256; cv=none; b=q06ilPLP30IsnOxzcM9R3WS2t1yL3E7AfIBDtzSBJod9vOC+/HLfi4WLRgwJRxdvAvxD7A+nVa+oCZY5lozJtBwu/9PMRz/fmqFp9w7PFZ0AuWsa1lTSOfSjbZqS8MxPAcBZ1QJTgQbS8KNeST3R79a4osL8jFCaQ9aCqZuNkro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708800256; c=relaxed/simple;
	bh=ipPAoL9r5zvXvmOYiDe9bBCe64mlWIM8+1vj/QL2ZdA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ws1vONqDTIGuqPT0CjyKhqPDyjAnbHFPCdgKBWUhfpZIqI3fqB+APaBuCSRMoKpEHMDSagZZ/84hWFoXVPxxlcD+S9iGh5XLMgIxXZ0wI1XE7XGg/QFhiund6OVhT32oRZvfMSzOIseIrG9tx6KSGsjs/QY3a8qO8Yp31gGkQW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLOSgG1x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05745C433F1;
	Sat, 24 Feb 2024 18:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708800255;
	bh=ipPAoL9r5zvXvmOYiDe9bBCe64mlWIM8+1vj/QL2ZdA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oLOSgG1xVLfWJ3b4OwWBkJDBqY/D/9avwZ+F91Fgi4Wd3l+8pklQO/hj2UwLyIanw
	 j6+R1l//tg3wVnzlQge8H7lp6oLqz+hRiQL/6/VXadAXVbd29j1o/giItF3WUzaepv
	 YA7oB3HH2u9Vw4PAmTHNUFCxiK8r4v1vo/hRYZFl4Zp+27aDZKd0rZppoTy/xxWj82
	 WeDhKOuDmJ3MRSwPqPNrEMseIajxCZgyPx+6g/3Oc37iTR/ixj1sQBVUh6rHYFCEmF
	 DctRp8wmznOneu4EiCy/0RyOfAGNLyachKFSOZvOd4pdMtGCoh/SZWBVnRAjdcP6kE
	 nFrzm7oN3SH5Q==
Date: Sat, 24 Feb 2024 18:44:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>
Subject: Re: [PATCH 3/6] iio: temperature: ltc2983: convert to
 dev_err_probe()
Message-ID: <20240224184341.791e5263@jic23-huawei>
In-Reply-To: <20240222-ltc2983-misc-improv-v1-3-cf7d4457e98c@analog.com>
References: <20240222-ltc2983-misc-improv-v1-0-cf7d4457e98c@analog.com>
	<20240222-ltc2983-misc-improv-v1-3-cf7d4457e98c@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Feb 2024 13:55:54 +0100
Nuno Sa <nuno.sa@analog.com> wrote:

> Use dev_err_probe() in the probe() path. While at it, made some simple
> improvements:
>  * Declare a struct device *dev helper. This also makes the style more
>    consistent (some places the helper was used and not in other places);
>  * Explicitly included the err.h and errno.h headers;
>  * Removed an useless else if().
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>

Hmm. Up to you whether you rebase on top of the device_for_each_child_node_scoped()
patch - mostly depends if you give the new version a reviewed by or not!

If they land in the other order I can fix it up whilst applying.
After that series is in place though the number of places this will do

	dev_err_probe(dev, ret, "message\n");
	return ERR_PTR(ret);

Makes me wonder whether
	return ERR_PTR(dev_err_probe(dev, ret, "message\n")); is
too ugly or not?

Maybe we need a dev_err_probe_ret_ptr() but that's also ugly.

One comment inline which is why I didn't just pick this up today and send
a new version of this patch in my series.

Jonathan

> ---
>  drivers/iio/temperature/ltc2983.c | 190 ++++++++++++++++++++------------------
>  1 file changed, 98 insertions(+), 92 deletions(-)
> 
> diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
> index 23f2d43fc040..4b096aa3fbd8 100644
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
> @@ -656,11 +658,12 @@ ltc2983_thermocouple_new(const struct fwnode_handle *child, struct ltc2983_data
>  			 const struct ltc2983_sensor *sensor)
>  {
>  	struct ltc2983_thermocouple *thermo;
> +	struct device *dev = &st->spi->dev;
>  	struct fwnode_handle *ref;
>  	u32 oc_current;
>  	int ret;
>  
> -	thermo = devm_kzalloc(&st->spi->dev, sizeof(*thermo), GFP_KERNEL);
> +	thermo = devm_kzalloc(dev, sizeof(*thermo), GFP_KERNEL);
>  	if (!thermo)
>  		return ERR_PTR(-ENOMEM);
>  
> @@ -687,8 +690,9 @@ ltc2983_thermocouple_new(const struct fwnode_handle *child, struct ltc2983_data
>  					LTC2983_THERMOCOUPLE_OC_CURR(3);
>  			break;
>  		default:
> -			dev_err(&st->spi->dev,
> -				"Invalid open circuit current:%u", oc_current);
> +			dev_err_probe(dev, -EINVAL,
> +				      "Invalid open circuit current:%u",
> +				      oc_current);
Hmm. I'm in two minds on these. 
We don't get the advantage of return dev_error_probe() and I'm not seeing these
hitting EPROBE_DEFER so getting the debug advantages.


>  			return ERR_PTR(-EINVAL);
>  		}

