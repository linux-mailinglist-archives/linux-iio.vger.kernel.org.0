Return-Path: <linux-iio+bounces-7071-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B08591D0DF
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jun 2024 11:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 011E81F21420
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jun 2024 09:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2998612DD8A;
	Sun, 30 Jun 2024 09:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEmDaHhs"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE6825762;
	Sun, 30 Jun 2024 09:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719740497; cv=none; b=pKf0x0Qph8vw2qqOgjZ3UJlpKRoqoFMHFBMPm9eQPE41TwcMlsa8CYNLE3cq9mjmDILHcrWhFcq+VDeAu1S1PUSU0+sfbaG+Ryw2ZNlTTUG3OurY/1h1tZixbqASBJ+OdSnJdAg+0VCZcWf8acyZq3lIRdX5rAP+k2n0J3EuAyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719740497; c=relaxed/simple;
	bh=O3gWqPJUtetF7geXgxkBYsZR8N/ecSKbSVODvNQ/i50=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d6O8vDnb2xfau4nnPWDfyakSEsX4cSYwI1NznZDqVjY7AHCsh9UDyaC6el/HOaK8vayVATlQwiVgaoJvhZlR7QRjVwXmvmITqXOvrgGJeOKZYIIOGNeu0xG/J1dEidlxYTvX9UPl+5KoVH1wWk/Hkn+Hal00b2GNoXNrscHuZTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEmDaHhs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41867C2BD10;
	Sun, 30 Jun 2024 09:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719740497;
	bh=O3gWqPJUtetF7geXgxkBYsZR8N/ecSKbSVODvNQ/i50=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bEmDaHhs9YXa++RPprItxDUKKO5XfTV0kewjxSWZtNlph3H1m1r/atOQ/kD5T+fYe
	 oOs+pXx6S+fholee7K9e+9sExHsf8pSD0C2jWI+9lqhLnOdXvWVmNZj0IsAd92M9w4
	 ACPFl4vjlVRdWgTIj1socgWWsEBua0oYFTXygSrkgOJgw7qlVaL3EWuYeLSqusJmHZ
	 yRUBjU2ufPHI1TMiFYR8NyfXC+laLLdogdnL64ZCv/8RdTmUFZj2UCwjF/mgo6FRvY
	 jBfqmgL1vXEBvAZSkcxvK4ij7WYRcXl6cNHz0lAE7Vys7thOvWXUe2ZvtgybwtyzEa
	 GOV/pD7qPKYSw==
Date: Sun, 30 Jun 2024 10:41:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: Alisa-Dariana Roman <alisa.roman@analog.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Michael Hennerich
 <michael.hennerich@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, David
 Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH v6 1/6] iio: adc: ad7192: use
 devm_regulator_get_enable_read_voltage
Message-ID: <20240630104126.05cb2d26@jic23-huawei>
In-Reply-To: <20240624124941.113010-2-alisa.roman@analog.com>
References: <20240624124941.113010-1-alisa.roman@analog.com>
	<20240624124941.113010-2-alisa.roman@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Jun 2024 15:49:36 +0300
Alisa-Dariana Roman <alisadariana@gmail.com> wrote:

> From: David Lechner <dlechner@baylibre.com>
> 
> This makes use of the new devm_regulator_get_enable_read_voltage()
> function to reduce boilerplate code.
> 
> Error messages have changed slightly since there are now fewer places
> where we print an error. The rest of the logic of selecting which
> supply to use as the reference voltage remains the same.
> 
> Also 1000 is replaced by MILLI in a few places for consistency.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>

On basis of nibbling away at outstanding patch sets to reduce the size
of v7 (assuming there is one) I'm going to pick up what I can now.
Basically we have a lot in flight and it's coming to the end of this
cycle so I want to be able to focus on the bits that need more eyes!

Applied this patch to the togreg branch of iio.git and pushed out as
testing for 0-day to poke at it.

Thanks,

Jonathan

