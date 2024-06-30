Return-Path: <linux-iio+bounces-7082-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1CD91D146
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jun 2024 12:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D4C8282425
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jun 2024 10:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A5D13A89A;
	Sun, 30 Jun 2024 10:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDBUKEaX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD7A4084C;
	Sun, 30 Jun 2024 10:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719744735; cv=none; b=D7Jgvyy9R6awOT1x5HJY4LAwiE4HrTF/sdJxcVtUm6eIuTVYhC69CR20XYYlqKgEpFLMWer6oAugZyBUPTkA6Bp7ZeJMoEXeS0HzK+WWHK4eUkOWLEWzjzkFyjHa2hMcxIkR7etGmbecG6lQBwkp/JyYNSDaDh6pOgOZUoz3+aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719744735; c=relaxed/simple;
	bh=GlOyv5pCwvf164vGNZO0oDiGCeZTmoHYis09Nzt4RHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PTDZJaZeOyuS8c7nqTeyvuErRIue6b1ANV9vJC1PE3513A4AL/Nkmvm0i/HexxP+Af9RbdL1u14APCDFCTOMn9JNegF5C2xoXOVz1W3gdYOmTpF0Dm7MbWt8dc34Iyl04cCA6CiYXiVdh4ccXsq/B7PSspYIil8UVxYQjDhzYIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDBUKEaX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7CA2C4AF0E;
	Sun, 30 Jun 2024 10:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719744734;
	bh=GlOyv5pCwvf164vGNZO0oDiGCeZTmoHYis09Nzt4RHQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gDBUKEaXyCLDVuvJ24aScBh9v9+jZjaNuzCuxogzRs2jU4P1P4NNYoqiJ+KYgHZ9x
	 qxCMYyk0ym+nTa4sGvTMGBx59qHtqJxvmmFDa5D0Q6Xkp7/KwKu9A1kk2wKMDuHr2F
	 L9fSd0PKpSpOdmUT7sPHZQqevjFvAbsq95fFsrdoZqzw0OV8Ehl5guv1rTcP+Mu1hy
	 3jnx8wQOs+C25c4DTTrHD8kqPqSz6u4/5v8ZaI5zQT4NdFTRl5Dgvx4sYAdMpkwYm6
	 nIdtxfD3Rqs0JGB739OPj9fB1SsCRXWEUNc3dLX+HiBfOa2c1ezBm6DaBf9I04sKcB
	 kUzzgkRqtxM5w==
Date: Sun, 30 Jun 2024 11:52:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <broonie@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
 <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
 <conor+dt@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
 <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-spi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 2/7] spi: bitbang: Implement support for MOSI idle
 state configuration
Message-ID: <20240630115204.490c063d@jic23-huawei>
In-Reply-To: <b08e21823638c241228f4bc27a7bf5d4ed88d54a.1719686465.git.marcelo.schmitt@analog.com>
References: <cover.1719686465.git.marcelo.schmitt@analog.com>
	<b08e21823638c241228f4bc27a7bf5d4ed88d54a.1719686465.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 29 Jun 2024 16:05:05 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Some SPI peripherals may require strict MOSI line state when the controller
> is not clocking out data.
> Implement support for MOSI idle state configuration (low or high) by
> setting the data output line level on controller setup and after transfers.
> Bitbang operations now call controller specific set_mosi_idle() call back
> to set MOSI to its idle state.
> The MOSI line is kept at its idle state if no tx buffer is provided.

Slightly odd wrapping - this doesn't warrant 3 paragraphs, so I'd just
reflow it into one. 

I'm not a fan of counting F's, so would have gone with GENMASK for those
but it's not the local style, so fair enough to hard code them.
FWIW given it's been a long time since I messed around in SPI controller
drivers...

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> 
> Acked-by: Nuno Sa <nuno.sa@analog.com>
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

