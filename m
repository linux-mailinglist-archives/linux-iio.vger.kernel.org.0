Return-Path: <linux-iio+bounces-7103-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB5291E67A
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jul 2024 19:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F28291C21BD0
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jul 2024 17:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9600C16EB60;
	Mon,  1 Jul 2024 17:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHx7u0vL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4785116E88B;
	Mon,  1 Jul 2024 17:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719854371; cv=none; b=NvjHMLvtJNEwhi+rPgwb7LG3nNUk/psmZ5ziatnqqg6stljtmfCpJZjKRiGXqQyZTKwf/ElUsdgbtPtqzy0wvT4sZbOWOb+HXODgpfoz9XpIFOxGhmLb4IULf+Qw4cmxSDWQ9Z+YI73cxwQa45dEZ8iD2dj7KkSX6iQ7N8QrfR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719854371; c=relaxed/simple;
	bh=F6Mg3Q9HtFWN3btjP5ziRej2VlTPFVg4j6vn1JweSfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7Cgol2meNWwVPzN8i93+Vbm8Vwbohghh3va991IH1ng2PvbTNB2dwnYTxdARsJBgEHDYTBYm7pLouVqMzcc1RU9O3Q8TRVejQJrpf+zcFIjqasVH60bfh2DsXuLgkHug1mC4JFkzQ2fkk8kRCkRMbehVNxWDS3OUg+PPrh+ilE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHx7u0vL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F88C116B1;
	Mon,  1 Jul 2024 17:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719854370;
	bh=F6Mg3Q9HtFWN3btjP5ziRej2VlTPFVg4j6vn1JweSfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SHx7u0vLf+kFXkUaPhxUr8J78oY6ddSvwzn4tjHaO8qiAeZxuucFdRm2vDrZOO8T/
	 MzL6oKjXa7TXAio2yY8E4j255UKeljiSIW91xWHq2iKYSyKPd+/HQlsBw6CkrGkrW4
	 r847M5mE+gZH1TBnO4e79zptI8uxQ6DMyyJ4oUvEHdlCEEEZ8/3FOOCyNVJJSo/Fui
	 J35ZkXzk3JMINehehfZdv3C5Hi9PzpGxocXfKB9ATBLm2LJVZK4Ya1D1IJjy7p1tuk
	 qJEp9eHbZulMa6TTWvEHi/3ggMbjOjR6Uk6j5zdzemeUfZ/mFXLl01BCl75YZrTlNh
	 pAxKYhOpNhVow==
Date: Mon, 1 Jul 2024 11:19:29 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: linux-fbdev@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Stefan Popa <stefan.popa@analog.com>, dlechner@baylibre.com,
	linux-iio@vger.kernel.org, Beniamin Bia <beniamin.bia@analog.com>,
	jstephan@baylibre.com,
	Michael Hennerich <michael.hennerich@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v2 04/10] dt-bindings: iio: adc: adi,ad7606: improve
 descriptions
Message-ID: <171985436896.136027.10830474139479480832.robh@kernel.org>
References: <20240628-cleanup-ad7606-v2-0-96e02f90256d@baylibre.com>
 <20240628-cleanup-ad7606-v2-4-96e02f90256d@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628-cleanup-ad7606-v2-4-96e02f90256d@baylibre.com>


On Fri, 28 Jun 2024 14:48:22 +0000, Guillaume Stols wrote:
> Reword a few descriptions, and normalize the text width to 80 characters.
> 
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad7606.yaml    | 33 +++++++++++++---------
>  1 file changed, 20 insertions(+), 13 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


