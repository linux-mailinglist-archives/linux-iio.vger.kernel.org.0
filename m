Return-Path: <linux-iio+bounces-14169-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7209AA0A88E
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 12:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8575F166CE0
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 11:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F361A9B5D;
	Sun, 12 Jan 2025 11:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVrnx04l"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF9E33F7;
	Sun, 12 Jan 2025 11:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736681670; cv=none; b=HIZH4seMIrnLjz1b6Fz+owUSTWKh1LGKcEu2PQicru6zwcfMQcA1aN5LAcd82uKhimcjFXHi4bU5timJ9OTGFnYb8VST33o8VXn54n8WHizHhsUNntEBvXrPN3xz8BJbh/JkeRCH4Tnkok+ijAclyxBrCBVYeBMKFxU11rcep4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736681670; c=relaxed/simple;
	bh=LdheNZzpWdGa4ncFuyM1a+4zsi2aXQeJu2XOuMQaOi4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eu0MRe6ITYlji2BV3M12P74s3pQ70XWfY/Wp4BMtnMqDcSMHIZzVk4N6a707UTfr7ahMeWtViqe3CLqMCSGGK5vmZIrBs4XKT3iGICa3Dyd9kALJhjHMwp+qwxt97hYufmIoceYU/joG0m5IildDFK/K7iETd2ol5ScsY+A++q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVrnx04l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54C24C4CEE2;
	Sun, 12 Jan 2025 11:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736681670;
	bh=LdheNZzpWdGa4ncFuyM1a+4zsi2aXQeJu2XOuMQaOi4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MVrnx04lauQhMp6lxg52ZBi+v1YXbeesz7gc4R091TGt/eUSiwlXiBWcuBEFOmN8t
	 9/9PtNr+hGJM10B4SuuMKcjRMa8OQ99kCFwfPIPYjSe4umuA1TnXF5h19uc8uuk6mj
	 xW7RHregHj6fB5CDdhEsOTyJMv5jhpYTnbpmdKjNAiCuLdCmotKFqb9unXDEkX58O8
	 5QvjnYIsG3T/ti85GiiHa5iBNoPm8kWePU58Rf2OIpK8cnB8L3tKlqBePXafxDUA2b
	 C+WZaX03OvQUweyMRE0HcnFNpoG0vvMbwijO9lqUFWDvXxsFTKoZJ6iQl9UuXYHPuG
	 gYT6pFmDbJA4w==
Date: Sun, 12 Jan 2025 11:34:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 3/5] iio: adc: ad7380: do not store osr in private
 data structure
Message-ID: <20250112113420.3b705e0b@jic23-huawei>
In-Reply-To: <20250107-ad7380-add-alert-support-v3-3-bce10afd656b@baylibre.com>
References: <20250107-ad7380-add-alert-support-v3-0-bce10afd656b@baylibre.com>
	<20250107-ad7380-add-alert-support-v3-3-bce10afd656b@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 07 Jan 2025 09:48:27 +0100
Julien Stephan <jstephan@baylibre.com> wrote:

> Since regmap cache is now enabled, we don't need to store the
> oversampling ratio in the private data structure.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
I don't mind the solution you have here, but one passing comment inline.
Up to you on whether you take any notice!


> +static int ad7380_get_osr(struct ad7380_state *st, int *val)
> +{
> +	u32 tmp;
> +	int ret;
> +
> +	ret = regmap_read(st->regmap, AD7380_REG_ADDR_CONFIG1, &tmp);
> +	if (ret)
> +		return ret;
> +
> +	*val = ad7380_regval_to_osr(FIELD_GET(AD7380_CONFIG1_OSR, tmp));

All small values, so maybe cleaner to just return this instead
of using a parameter.

> +
> +	return 0;
> +}



