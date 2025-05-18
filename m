Return-Path: <linux-iio+bounces-19635-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E645BABB10A
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 19:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88F79171E5D
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 17:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C350021D585;
	Sun, 18 May 2025 17:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DpIwt8Rh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799812AE7C;
	Sun, 18 May 2025 17:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747588472; cv=none; b=Turr/cwOzaAyEOr5tSo7oZg3hB+tQLfFFQ8eSMA8Py+QCRyJ7PrfyM3owzd6/A47qdxR5RNkIHifzayIIYJcmG+Ng3MaFoE15dxoB0k1YaFLh7eAYl2XF/L0eznqYjLDqUf1t7BrrQ0Ai7Y4Urr6peskZ2N0Gu6HLbExMGvSNUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747588472; c=relaxed/simple;
	bh=oUgpuVu6nBlz3PF1tITVHXlBKMU76vIVSEWCflnLtxc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UhTkVv3kWAaR5bG8nioKBULOWM8DTq5BDzLFZKj4Vz1HMbdmqt83sybAXZbbTMzFzNAR7hGKAujv71xIr9kQuIA6wpZPtWr+z3KuHemIIMucDH5J77i7SBj21au2UW1YNVnb91QnFhYWZ8gpOJmVX1nYHjkrOhnuDXAphFNIOy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DpIwt8Rh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB83C4CEE7;
	Sun, 18 May 2025 17:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747588471;
	bh=oUgpuVu6nBlz3PF1tITVHXlBKMU76vIVSEWCflnLtxc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DpIwt8RhkSUo1nRmmGYmjzvCuQMcghb/y9/mE2kLGXwa8vh9418xIIr0zumRevmQs
	 MXkFXQvoPIrQTACyYhzdten76xr5pkA8qvzK/NPrgXiMqEjVFfmgJFgfjQtrmzNltO
	 fKtK8/IcJM8k+So1ACORtoF+q7VThN7DGXBUUzOjFof/zR10hjULq9aEDh8/6flLu6
	 FgOzRMlkDWAu3uMGgLVbF0ifx7eIxRb+cAbH3r8QIuW0NSEta/Lix2nsb6B7cLJYLN
	 pg/YQkDNZmGx2z4LV20821Mqgt2iecuoqzZ337Amr1w5q9k0DuzkZXxs0YwqUnYv7W
	 2ryTk4gOCtPSQ==
Date: Sun, 18 May 2025 18:14:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 09/10] iio: adc: ad4080: add driver support
Message-ID: <20250518181424.15a2187b@jic23-huawei>
In-Reply-To: <20250516082630.8236-10-antoniu.miclaus@analog.com>
References: <20250516082630.8236-1-antoniu.miclaus@analog.com>
	<20250516082630.8236-10-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 May 2025 11:26:29 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for AD4080 high-speed, low noise, low distortion,
> 20-bit, Easy Drive, successive approximation register (SAR)
> analog-to-digital converter (ADC).
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
I'm not sure why by the patch I got from b4 for this was subtly corrupted
at the end.  I just deleted the non patch part and it was fine.

One other issue below that I fixed up.



> +static ssize_t ad4080_get_filter_type(struct iio_dev *dev,

should return an int.

> +				      const struct iio_chan_spec *chan)
> +{
> +	struct ad4080_state *st = iio_priv(dev);
> +	unsigned int data;
> +	int ret;
> +
> +	ret = regmap_read(st->regmap, AD4080_REG_FILTER_CONFIG, &data);
> +	if (ret)
> +		return ret;
> +
> +	return FIELD_GET(AD4080_FILTER_CONFIG_FILTER_SEL_MSK, data);
> +}

