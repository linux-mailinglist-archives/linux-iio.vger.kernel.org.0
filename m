Return-Path: <linux-iio+bounces-10244-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9828991E9E
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 15:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E853C1C20C6D
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 13:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2539176FDF;
	Sun,  6 Oct 2024 13:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fs8/Ul/F"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C07EC5;
	Sun,  6 Oct 2024 13:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728222239; cv=none; b=YX37CC/oNeYnOMexbukwyEUZjTP9SeRDcsn0Gdc4ScBvIV41oTh1rlR+nooq94Lk7+2cqh/BC+n97RlpowDFYQ80hG0951ZpIHGKctAV7okt/a95gqlK4KkQKORjHd6IcJ9AJmQHJEPiDZx9K0qZkHnQ5oFvAS5XF8+IH2t/fUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728222239; c=relaxed/simple;
	bh=I0oaN/mY2wrPG/uojHPfeCkMG+gszDmCMqODoHZcs6k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UeMaE6/awpP50+cKq1dq6aERbPB5FVPs6neGC9+ZqG94B0wrqctmrP0neVrWDvAl8DPU4Jz7tk9M+/clgWQsMmlzMuBfKTkRjRUhOkH7utJrYbfS6ChgbOk7AkdUTcOrlLPovtem5WT6EfD9bezJDoCkvWftg7uV0jvqtjqWotA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fs8/Ul/F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0366DC4CEC5;
	Sun,  6 Oct 2024 13:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728222239;
	bh=I0oaN/mY2wrPG/uojHPfeCkMG+gszDmCMqODoHZcs6k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Fs8/Ul/Fq3FOggK3zWmgAclFaX8CnSFpoF1fYZoeQB4oiAYUGAR4YiVlFpgCHe1ne
	 0RcAv+DQqqD55JVQI0hHtujPP4GKyinsh/tPQHHyPRGHMzvFzyFfWuUMSmxFGHCuVV
	 54kNImAxD/UTOO91fwvSY1Z77oUMHuD2UrRrM4ByQmBxTVNDHWOKddIb1omt+qKcFW
	 /CT2SvgQ8QvhLAjDpqt3p5sZOUE7CuiKWWBF8hilTeFaYahJubJQupXq2wcKYCRL8D
	 K4q+29t1K5xcJiDvqYIRB8lP75xbe0e2gkChb60dpb5tKSPwHcBfXx71qftn6bmsS3
	 sb8mmDo0zHNlw==
Date: Sun, 6 Oct 2024 14:43:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Mihail Chindris <mihail.chindris@analog.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, devicetree@vger.kernel.org,
 dlechner@baylibre.com, Mark Brown <broonie@kernel.org>,
 stable@vger.kernel.org
Subject: Re: [PATCH v4 04/11] dt-bindings: iio: dac: ad3552r: fix maximum
 spi speed
Message-ID: <20241006144344.7d2fcbd2@jic23-huawei>
In-Reply-To: <20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-4-ceb157487329@baylibre.com>
References: <20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-0-ceb157487329@baylibre.com>
	<20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-4-ceb157487329@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 03 Oct 2024 19:29:01 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Fix maximum SPI clock speed, as per datasheet (Rev. B, page 6).
> 
> Fixes: b0a96c5f599e ("dt-bindings: iio: dac: Add adi,ad3552r.yaml")
> Cc: stable@vger.kernel.org
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
I'm going to take this the slow way as it probably doesn't affect any
existing DTS so can wait a while and taking it via the fixes
branch would slow down the rest of the series.

I am keen though to cut down how many patches are in revisions
though so I've picked this one up today. Please rebase on
my tree before sending v5 to pick this up.

Applied to the togreg branch of iio.git

Thanks,
Jonathan
> ---
>  Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> index fc8b97f82077..41fe00034742 100644
> --- a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> @@ -30,7 +30,7 @@ properties:
>      maxItems: 1
>  
>    spi-max-frequency:
> -    maximum: 30000000
> +    maximum: 66000000
>  
>    reset-gpios:
>      maxItems: 1
> 


