Return-Path: <linux-iio+bounces-12730-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B77AF9DA8D4
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 14:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CAF8281C14
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 13:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E161FDE00;
	Wed, 27 Nov 2024 13:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cA0e2/Wa"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC2F1FCF57;
	Wed, 27 Nov 2024 13:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732714891; cv=none; b=uXko5xcnJQkZzrXJzGPYd7/5W1Qw9HW1DpOjmn82O9bo+Ji3FKf5F1K1z+NApzoXmIT2IA0a585OqrxzWDn9k5tfrIotCh5T9lig0Pw+IUbHgSV+pn+i5Kobp6O7wU3RcADxEaCr6bkawr3LNhBU6wUQjGXL0R+RHj6nKXHNK28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732714891; c=relaxed/simple;
	bh=CPyj+7nSVlYkOKZeImBcDL8Cmjb3+BOD5DpGo9NfM0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWnRYVNSyPEgjuq/KH/wcOTchVA4+/Q4RZW5q/PNog1JUA5N54dHyyBuOhxYKHJw5p8HLoK2Gz1DfI7sDpbaZeo2KyafeLE9KdDtxQY/ZF52PpfrxtZyzZloyyuY62SdpW/64nScY52Rqbox2RGQ1lc6ZZWE5UtZLDMzjgngXdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cA0e2/Wa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA35C4CECC;
	Wed, 27 Nov 2024 13:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732714890;
	bh=CPyj+7nSVlYkOKZeImBcDL8Cmjb3+BOD5DpGo9NfM0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cA0e2/Wa2r2jGvCPuE/1JMkxC0XReIge5XaLAT6mq4sVZi5s6C/mJ+DbIvaJKL1mJ
	 jA7wX99FitcaQ06W9Fyd2OD9qfyo3XpoeSnJ8Zgo+yYd/d+1UmSGqhZnuiBIZUf6zP
	 dSJ6I+/1HzvUFbHaCvLF1UxBRXP9JjNTDQ0PS9H07p0pmbHeW8PHYEqovUkl9PfpGm
	 oisyaW5oXGcIgMae+1FwCk3eWxvpHabMMS/EWtZl3iDPjk8Dp9W1pZ8nFjcm2GmSSY
	 3u3DHjBmeX0D2GqBO6Agv8andMo1eV5MSM3Xotz2YbASMtvdr0iKsCMO6d0OdX4ufU
	 5U/pcYAaQxKEg==
Date: Wed, 27 Nov 2024 07:41:28 -0600
From: Rob Herring <robh@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Alexandru Ardelean <aardelean@baylibre.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Dumitru Ceclan <dumitru.ceclan@analog.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Nuno Sa <nuno.sa@analog.com>, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 03/10] dt-bindings: iio: adc: adi,ad7124: Allow
 specifications of a gpio for irq line
Message-ID: <20241127134128.GA3230110-robh@kernel.org>
References: <20241122113322.242875-12-u.kleine-koenig@baylibre.com>
 <20241122113322.242875-15-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241122113322.242875-15-u.kleine-koenig@baylibre.com>

On Fri, Nov 22, 2024 at 12:33:22PM +0100, Uwe Kleine-König wrote:
> For the AD7124 chip the logical irq line (̅R̅D̅Y) is physically on the same
> pin as the spi MISO output (DOUT) and so reading a register might
> trigger an interrupt. For correct operation it's critical that the
> actual state of the pin can be read to judge if an interrupt event is a
> real one or just a spurious one triggered by toggling the line in its
> MISO mode.
> 
> Allow specification of an "rdy-gpios" property that references a GPIO
> that can be used for that purpose. While this is typically the same GPIO
> also used (implicitly) as interrupt source, it is still supposed that
> the interrupt is specified as before and usual.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)

Comment and R-by on v2 still apply.

Rob

