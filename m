Return-Path: <linux-iio+bounces-10247-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA4B991EB3
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 16:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9639D1F21C1A
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 14:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC021BC5C;
	Sun,  6 Oct 2024 14:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oK11BPy5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C955B19A;
	Sun,  6 Oct 2024 14:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728223250; cv=none; b=k2HCrPSuD55LI/eW9pn2nYSc55nOyoGqwKS8guT7ha0r1//JP7u7AuNpTZ8E5Qz1Q/+ZllxdcLJ5nXs5xZXDCcP4KHpv6gt2LUGaNpUsQdHAc0gj4boQ3BQ9sAUO2qesNvy4aEGWJ5m6gBz0C8R90iVXX8Ot/wG5UOoYP6biiug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728223250; c=relaxed/simple;
	bh=XPRT0pHekL/5DaqO+7+/3pG8dmzrrjPPuTbE2XLWbsg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lEL1lqsfHL8HetNOuhGgnnG2xjqRfcZqEhbVUBVNhK3sDHRAa0YWZ7/iOnz/Gw6PC053J6+G0pUHCobTjaQJrjYFrWgaHw5sb9UKxMYxh7xgF5/69IB9mcAxTJAGY1dq5woNP/v6qEH291IPAsL5GKn6wrongLF2QQ6MiNYrFSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oK11BPy5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67884C4CECD;
	Sun,  6 Oct 2024 14:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728223250;
	bh=XPRT0pHekL/5DaqO+7+/3pG8dmzrrjPPuTbE2XLWbsg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oK11BPy5YaZtkJEJmGS6xf+sDrJxNVANXYT+lKv2OAk1UULjIIbdqHkfI1/Xa+YBM
	 8KyR4QidcyJL804MloLki/imtq67h/Y9MW/wrk4GiAJP6iIQCIM5WEKwFq4I7z2UUp
	 J5mUgpII+Em0/dI1+XAD1LUKND1+QFQTAPh+dhmWSKP36DVKuilvd+hs2hwsVPn4W0
	 s2TUCT8RWO0Cu8ty0WEMPtnIO4pu4Hj8aICJaVyedxKCVlRdLM377U8CwMK319PZ9i
	 OuGcF33ubH6sXIG+H6RySTR6CW4PHdScvbjTprNLf1g7NV6y1RjpLgjZFFx2TKVHvM
	 I4bSdu1QjGXJQ==
Date: Sun, 6 Oct 2024 15:00:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Mihail Chindris <mihail.chindris@analog.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, devicetree@vger.kernel.org,
 dlechner@baylibre.com, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 11/11] iio: dac: adi-axi-dac: add registering of
 child fdt node
Message-ID: <20241006150033.1bc2b749@jic23-huawei>
In-Reply-To: <20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-11-ceb157487329@baylibre.com>
References: <20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-0-ceb157487329@baylibre.com>
	<20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-11-ceb157487329@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 03 Oct 2024 19:29:08 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Change to obtain the fdt use case as reported in the
> adi,ad3552r.yaml file in this patchset.
> 
> The DAC device is defined as a child node of the backend.
> Registering the child fdt node as a platform devices.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>

One issue inline,

J
> @@ -750,6 +753,45 @@ static int axi_dac_bus_reg_read(struct iio_backend *back, u32 reg, u32 *val,
>  	return regmap_read(st->regmap, AXI_DAC_CUSTOM_RD_REG, val);
>  }
>  
> +static void axi_dac_child_remove(void *data)
> +{
> +	struct axi_dac_state *st = data;
> +
> +	if (st->dac_pdev)

This condition doesn't make sense - see below.

> +		platform_device_unregister(st->dac_pdev);
> +}
> +
> +static int axi_dac_create_platform_device(struct axi_dac_state *st,
> +					  struct fwnode_handle *child)
> +{
> +	struct ad3552r_hs_platform_data pdata = {
> +		.bus_reg_read = axi_dac_bus_reg_read,
> +		.bus_reg_write = axi_dac_bus_reg_write,
> +	};
> +	struct platform_device_info pi = {
> +		.parent = st->dev,
> +		.name = fwnode_get_name(child),
> +		.id = PLATFORM_DEVID_AUTO,
> +		.fwnode = child,
> +		.data = &pdata,
> +		.size_data = sizeof(pdata),
> +	};
> +	struct platform_device *pdev;
> +	int ret;
> +
> +	pdev = platform_device_register_full(&pi);
> +	if (IS_ERR(pdev))
> +		return PTR_ERR(pdev);
> +
> +	ret = devm_add_action_or_reset(st->dev, axi_dac_child_remove, st);
> +	if (ret)

If you hit this path, then st->dac_pdev is not set and we don't remove
it.  Set st->dac_pdev = dev before the devm_add_action_or_reset()
call and then drop the check in there as it will always be set.


> +		return ret;
> +
> +	st->dac_pdev = pdev;
> +
> +	return 0;
> +}

