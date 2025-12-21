Return-Path: <linux-iio+bounces-27304-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D997CD4542
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 21:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CBD533007AA1
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 20:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99813309DB4;
	Sun, 21 Dec 2025 20:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uu++x2F0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517F414F112;
	Sun, 21 Dec 2025 20:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766347222; cv=none; b=gIfHqcHyQmwAIFjQ/6/Bn+BSG2+ldrsKI/Ckbs/YvHasI5qS0AUS4id2Dcn/UoiRWKgrDDJPrrc1hgYeeUUJjMoaJb2wkgCf6aDdkMaDJcbXtP8qR52auQuS06B9jX93yEJHBthATiOb7GzPcRDnwdRqBVUCjHLukayd6lmhWC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766347222; c=relaxed/simple;
	bh=CVusULJ8KM2W/lYumfpzE/BPj4nL1hjM3N0N1bNEzwo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=al0NUNiFZSngwYj3xn0N46T5D463rJio2ehegV1QLiAPXCcu2Ml9C5aMK49DKiYguLHHxUBFTPyoU8tn1JUYPo/pCwtz5pkc3pLvHK9XsMTKiju/pJUUifMjo7n7qPjFt6BmxCBwtZ871545UMtvmimPP7voDHzEBY6fDNDmCp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uu++x2F0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13847C4CEFB;
	Sun, 21 Dec 2025 20:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766347221;
	bh=CVusULJ8KM2W/lYumfpzE/BPj4nL1hjM3N0N1bNEzwo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uu++x2F0/QKKgwNmiMxdlVbkFVtp3hlRmkoZxsnfGEl0D/aa4il32D+CdD1xCxn73
	 KZHugq0PnGL/4gZ72OMnBoRdaUXQ/56C9mCp1eqvGcUrJGI6VGh7hmPcsz/EE4S6Dc
	 cxdj/cyfIZ4+RaAg7QWpzoOwEevRHvVSb4Z44hjTIGWjj/G5hjZb3QJymbhYncZOK/
	 dtNvHPTop0nwO0sPaektUkXSzCzTnFEnKartki7nWmLnc1BkUXfzs4Pc1fdKVJX891
	 mHNqA6JwBfDmRbORVMufqawdF4adMZ73BBtNAsGN/96CcgsTpZtZbOkt9/Awo2pJC+
	 PuXTfgeB7HwPg==
Date: Sun, 21 Dec 2025 20:00:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Tomas Melin <tomas.melin@vaisala.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno Sa
 <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: ad9467: make iio backend optional
Message-ID: <20251221200014.29af7df8@jic23-huawei>
In-Reply-To: <20251216-b4-ad9467-optional-backend-v1-2-83e61531ef4d@vaisala.com>
References: <20251216-b4-ad9467-optional-backend-v1-0-83e61531ef4d@vaisala.com>
	<20251216-b4-ad9467-optional-backend-v1-2-83e61531ef4d@vaisala.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Dec 2025 11:40:06 +0000
Tomas Melin <tomas.melin@vaisala.com> wrote:

> Not all users can or want to use the device with an iio-backend.
> For these users, let the driver work in standalone mode, not coupled
> to the backend or the services it provides.
> 
> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
Hi Tomas,

>  static int ad9467_probe(struct spi_device *spi)
> @@ -1352,21 +1361,25 @@ static int ad9467_probe(struct spi_device *spi)
>  	indio_dev->channels = st->info->channels;
>  	indio_dev->num_channels = st->info->num_channels;
>  
> +	/* Using a backend is optional */

I'll largely defer to Nuno on the backend aspects but I would like a
lot more than a statement that it is optional in this comment.
At least something about where the data goes and what a real system
that didn't provide a backend would look like etc.

I can think of some setups where I'd be fine with this change and others
where I'd push back harder.

Jonathan


