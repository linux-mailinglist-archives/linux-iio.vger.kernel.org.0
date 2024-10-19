Return-Path: <linux-iio+bounces-10773-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8155B9A4D34
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 13:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3783D1F22D9E
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 11:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975591E009B;
	Sat, 19 Oct 2024 11:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="be1noTTo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6CA1DE4D8;
	Sat, 19 Oct 2024 11:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729338260; cv=none; b=hQO8AC9we5nPZ0WDNEIo7gr/g0HLqnsp8iOHGvSJZ/E5viUCZGwbqPCHOeBR3+BZSNBL84IHj5YkUeI7Uw+OMEHwMXNrGjbLzmU0y42GieA5zD1aUFIBAf/0evvv34KAzgMyYvM2DbzvUhKbn8ElAxnJkczRj2FseIb85W9UYi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729338260; c=relaxed/simple;
	bh=j0ZrhGvEH9zRaEfnu7yNqrMSBl2wcgkRgC8NcJp20YQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FtI3JFNCrdzSjlbTjtv2huSMfBGSdyIrdC9Zu54IykrD6e3MHo2nubEx0XTq8f2SGM1qK5uAUX1qdp21GIOz9JS7FIsd44VXlPT14WthxAWv4ADcybabgZd8ojOYVfTuTUsyQUAeAaFwpiOe0BR2WexQr1ftlXrWiTPpemHl0H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=be1noTTo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31CC7C4CEC5;
	Sat, 19 Oct 2024 11:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729338259;
	bh=j0ZrhGvEH9zRaEfnu7yNqrMSBl2wcgkRgC8NcJp20YQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=be1noTToADKS2hGIy/FAoUF4DZGMYeGiA5VgX5LVHI3Cm6hesJs87HuWX16G+ZGNf
	 4NhsLMtLYmY6pmRmm0A1b1fLdW82+0K33NN146V3FfW340mruW2YdCoDY0OuFRwHBZ
	 tt7oze1Tqdv6KRbyzHwj5sV8IlkldNHBT9ayCmfWPlCaev7LAhkW5JB2KDagX00x0p
	 j+d4EPkcz9rsyv3HCs4NjRqVJPGi14EUny/4enza0rxXKDpfNhqMwmLjUTE+rKOiAv
	 uSz8+oKAc9VpDDdf5ErBCB5A6Uj7of/Y5S7hU7RqbdmGBpKU4WE+y+p8BcCd7ZGbyR
	 32DRg4Txx9tCw==
Date: Sat, 19 Oct 2024 12:44:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Justin Weiss <justin@justinweiss.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Derek J . Clark"
 <derekjohn.clark@gmail.com>, Philip =?UTF-8?B?TcO8bGxlcg==?=
 <philm@manjaro.org>
Subject: Re: [PATCH v2 6/6] iio: imu: bmi270: Add scale and sampling
 frequency to BMI270 IMU
Message-ID: <20241019124410.554c2817@jic23-huawei>
In-Reply-To: <20241018233723.28757-7-justin@justinweiss.com>
References: <20241018233723.28757-1-justin@justinweiss.com>
	<20241018233723.28757-7-justin@justinweiss.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Oct 2024 16:36:12 -0700
Justin Weiss <justin@justinweiss.com> wrote:

> Add read and write functions and create _available entries.
> 
> Signed-off-by: Justin Weiss <justin@justinweiss.com>
Hi Justin,

Just one trivial comment from me.

Jonathan



> +
> +static int bmi270_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long mask)
> +{
> +	struct bmi270_data *data = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		return bmi270_set_scale(data, chan->type, val2);
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return bmi270_set_odr(data, chan->type, val, val2);
> +	default:
> +		return -EINVAL;
> +	}
> +
Unreachable code, so drop this return.
> +	return 0;
> +}
>

