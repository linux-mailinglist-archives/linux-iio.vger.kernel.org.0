Return-Path: <linux-iio+bounces-25493-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A14EBC0EA40
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 15:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B00DB19C1EB7
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 14:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE70B2C235A;
	Mon, 27 Oct 2025 14:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWJqeX83"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881A219EEC2;
	Mon, 27 Oct 2025 14:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761576897; cv=none; b=h0ZN1zUt/bqPK0Wy4uMlDVACa4OyqM+gK13rwvWqZifaX/izuW0huGWPzSI5tkk7AAQ/OBzw+Z2k5Wt+P3ThkMX2CVsRfMv8oDAid4GFDEDi/D0Hj6HhlVVHIaaXX+ba/HgxsgLKeSmMqCFsrNCUX/3wnEE8cmjIXcgWe9h0afU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761576897; c=relaxed/simple;
	bh=55ciiXLhwxIAPj+42X+cECg3QUXl4PQE2uVMq1Zw59A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zpg/zuskch3GaUqibC5IDUAxvpbi9iALFcodY5NOa8NwpakUA0y4J4H8w4KXHJkbyVbA3l9dlZyTjaUloINgYAFgccX6wU7q/8ZqQh0wOHAFvFYXhwOblrV/6QvegHN2+DgNNlIiJ6bcR5YThr6GfEGz2NE2Srx9E40QXGoruMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWJqeX83; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B909C4CEF1;
	Mon, 27 Oct 2025 14:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761576897;
	bh=55ciiXLhwxIAPj+42X+cECg3QUXl4PQE2uVMq1Zw59A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GWJqeX837ZMlOjKwluohi0pGWxQV5CGd4PmwWrfaezb0pfpFPdpL24iDVoYrF/2Qa
	 IDI1Ti2mLFwWrK8Qs640Tp61ieNACXJdCnyOaR1R0BljFsP7J0SOTrmonwKmSqwK7F
	 K+TieD7E8BONx96RRDjc4fTMqErmyC65SzEspooNLhLiICr+HLO0IH2qDkhieJ0bAD
	 ULKXjwpjpiD7DbifEnhZqLusF/IaERB36Zjv+1vaakoUAlFrCwJNPMbQeOezInbz/4
	 9agszMQYUlsl88qrGCrVQ9ft0tbnAR6JETqxS5HO93/GbVtSaLRv/c0HG1eSfnB6FD
	 I2g6giA7WXJ8g==
Date: Mon, 27 Oct 2025 14:54:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] iio: accel: rohm: use regmap_reg_range()
Message-ID: <20251027145451.43e05bcd@jic23-huawei>
In-Reply-To: <cover.1761569177.git.mazziesaccount@gmail.com>
References: <cover.1761569177.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Oct 2025 14:50:07 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Use regmap_reg_range() when initializing regmap_range arrays
> 
> Clean-up couple of ROHM drivers which assign the reg_ranges directly.
> This reduces couple of lines of code.
> 
> NOTE: Changes are compile-tested only.
> 
Seem fine, so applied.

Thanks,

Jonathan

> ---
> 
> Matti Vaittinen (2):
>   iio: adc: rohm-bd79112: Use regmap_reg_range()
>   iio: adc: rohm-bd79124: Use regmap_reg_range()
> 
>  drivers/iio/adc/rohm-bd79112.c | 13 ++++--------
>  drivers/iio/adc/rohm-bd79124.c | 39 ++++++++--------------------------
>  2 files changed, 13 insertions(+), 39 deletions(-)
> 


