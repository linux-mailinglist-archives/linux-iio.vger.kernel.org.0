Return-Path: <linux-iio+bounces-2148-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92050848EBB
	for <lists+linux-iio@lfdr.de>; Sun,  4 Feb 2024 15:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 461861F22766
	for <lists+linux-iio@lfdr.de>; Sun,  4 Feb 2024 14:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B312230C;
	Sun,  4 Feb 2024 14:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewvmkLrE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FE8224E3;
	Sun,  4 Feb 2024 14:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707058530; cv=none; b=ikHLPfuHLcZlOQ8pCXAf9+6Q7EXMk7epkZXSL1mFSSHTSu8YDAKoYNcCJpHyk7v26v0Juwm25ez2p2NNM/EICNvZ8qYuxhPE99YnjfbM4W5u1Hhg2ms5hKK2W+jkGB3HlyBv+tSnCD11cZDl9QViGbpuCcqsRyMeo4C6J+OKcxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707058530; c=relaxed/simple;
	bh=OyV94v0393IG0/OU7LwhjrP51QUNc86Jl0gaqeKPyok=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iCwfM6m5LMHEOEZDs3JDKyWDB86t63k+Do+wfUiSn1ZzXgbxCd4LsyeGGpHUvgVqZhhgFPI0SnEsLZJ7b132IcXd4t5iiyhjHQufcMgVfbFf7boreDK1tFK/Glcqd63J1+U6JdeZ4vAi1K8rtoTWTa6opbAc1qZeaI7zxVCMdzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewvmkLrE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2446BC433F1;
	Sun,  4 Feb 2024 14:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707058529;
	bh=OyV94v0393IG0/OU7LwhjrP51QUNc86Jl0gaqeKPyok=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ewvmkLrEhw+YaT8n8F4wJbFy2pb3aPK69y+xHG1s32ySXdCGNg/Lu6WohM3IeOoWv
	 NAY63hcRApyVLw8gc6LEQQVONXNPyRL22hw5ttS3bs0lt6IJAO7Wf5jXMhG+wYlUFD
	 VlFuGivHTKcj4v3J51gyuu0naMdNYlDpj48/VY4fjtFLrB9YSYdz6LcaMZPI66kRhM
	 rRmQGRtnqGYxkMEIdNN1rXZ7OSsD2gu5Sqerz+E9oISv5F7hCX4f2AFCg9UFpR9nd/
	 /jsGOZYqoIig0E48z1u8CfZurZ+IsCGUqa8Yu6v8kYgf6Y3D1rbCposH+Vp1ebXgdG
	 40MulsEJ7FXjw==
Date: Sun, 4 Feb 2024 14:55:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Olivier
 Moysan <olivier.moysan@foss.st.com>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v8 3/7] of: property: add device link support for
 io-backends
Message-ID: <20240204145517.325eba4b@jic23-huawei>
In-Reply-To: <20240202-iio-backend-v8-3-f65ee8c8203d@analog.com>
References: <20240202-iio-backend-v8-0-f65ee8c8203d@analog.com>
	<20240202-iio-backend-v8-3-f65ee8c8203d@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 02 Feb 2024 16:08:34 +0100
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Olivier Moysan <olivier.moysan@foss.st.com>
> 
> Add support for creating device links out of more DT properties.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Given the fix is working it's way through a different tree, this
may get a little messy in the short term.  I've manually applied
it to my tree for now.

> ---
>  drivers/of/property.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index caa3e54aae13..0e91a5f4d0cb 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1245,6 +1245,7 @@ DEFINE_SIMPLE_PROP(interconnects, "interconnects", "#interconnect-cells")
>  DEFINE_SIMPLE_PROP(iommus, "iommus", "#iommu-cells")
>  DEFINE_SIMPLE_PROP(mboxes, "mboxes", "#mbox-cells")
>  DEFINE_SIMPLE_PROP(io_channels, "io-channels", "#io-channel-cells")
> +DEFINE_SIMPLE_PROP(io_backends, "io-backends", "#io-backend-cells")
>  DEFINE_SIMPLE_PROP(interrupt_parent, "interrupt-parent", NULL)
>  DEFINE_SIMPLE_PROP(dmas, "dmas", "#dma-cells")
>  DEFINE_SIMPLE_PROP(power_domains, "power-domains", "#power-domain-cells")
> @@ -1335,6 +1336,7 @@ static const struct supplier_bindings of_supplier_bindings[] = {
>  	{ .parse_prop = parse_iommu_maps, .optional = true, },
>  	{ .parse_prop = parse_mboxes, },
>  	{ .parse_prop = parse_io_channels, },
> +	{ .parse_prop = parse_io_backends, },
>  	{ .parse_prop = parse_interrupt_parent, },
>  	{ .parse_prop = parse_dmas, .optional = true, },
>  	{ .parse_prop = parse_power_domains, },
> 


