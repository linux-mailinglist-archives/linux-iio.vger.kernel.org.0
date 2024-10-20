Return-Path: <linux-iio+bounces-10812-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 913D09A53A0
	for <lists+linux-iio@lfdr.de>; Sun, 20 Oct 2024 13:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B776C1C210EB
	for <lists+linux-iio@lfdr.de>; Sun, 20 Oct 2024 11:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CDB18EFF8;
	Sun, 20 Oct 2024 11:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anCoLZ78"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19A8EAF1;
	Sun, 20 Oct 2024 11:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729422393; cv=none; b=Ca2xtkEgC7bBOMylpaPsd7rA9+R6lTqGIsP9I6ZjFJf6+bBXnTtsyrSYxYlmVvQKQbVcdOgKu5JyDjYcezBf7jvmzzpN2vEAQyjCw8FHJQ/RqvRXak6Ofv4yhEgVtlhih/dINUjAsGCsuGBxQUpCF0NMDmm6S8xsj/5s6dV09e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729422393; c=relaxed/simple;
	bh=LN5khDHXvLdv/NNKj8RyhijrqKa2dNUfl4WqHC+nBaM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fXWd49t7ZBnOvoGOAA2TCMHGpjyPIVF7KzSEtB81bqhfzkOoe0srTGR+SRiHhO225MBDIFBoPrxwbc16PJzxGI5Hik255o+6fthnrGPUSfZTtRDi7Hr900EIk9/ghcNzUguKjLB3h0HHaeeVkks+z8C3jt96LJchFLy1NSANNzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anCoLZ78; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 799A2C4CEC6;
	Sun, 20 Oct 2024 11:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729422392;
	bh=LN5khDHXvLdv/NNKj8RyhijrqKa2dNUfl4WqHC+nBaM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=anCoLZ78mBfJsiafWHdR+p8tROYbJLO5LNfDxyzPvWFZKVQdhcpBtRHslP1fIPd1z
	 VA0MwQgtim/RvKjwZVOL4ssGu/1IETsXlSl+2qwMOZQDEM72aHyMrjjhxjABR6vHOp
	 QOqCrBpFukh/a0SGMAgUmhMDMbp+eacNTwb+GRcZvpzxbHan7S3Uix/fPm4s6Tp6ys
	 X3icfkMAiwgajWSMVP1/QFofkgiy0GU6RN2QKseKxoEtwXq26r1hqoiROmaiERvz1Q
	 2LdXOq8PhnlJ3kowI60mDLi3PEYKxjxbLGM+JEjjWO5Y1f77dU6KBnA7GvwWpCwh63
	 SO/ob/OPzOigw==
Date: Sun, 20 Oct 2024 12:06:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ramona Alexandra Nechita <ramona.nechita@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Alexandru Ardelean
 <alexandru.ardelean@analog.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Nuno Sa
 <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>, George Mois
 <george.mois@analog.com>, Ana-Maria Cusco <ana-maria.cusco@analog.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH v7 2/3] Documentation: ABI: added filter mode doc in
 sysfs-bus-iio
Message-ID: <20241020120624.5f0f8494@jic23-huawei>
In-Reply-To: <20241014143204.30195-3-ramona.nechita@analog.com>
References: <20241014143204.30195-1-ramona.nechita@analog.com>
	<20241014143204.30195-3-ramona.nechita@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Oct 2024 17:31:59 +0300
Ramona Alexandra Nechita <ramona.nechita@analog.com> wrote:

> The filter mode / filter type property is used for ad4130
> and ad7779 drivers, therefore the ABI doc file for ad4130
> was removed, merging both of them in the sysfs-bus-iio.
> Since one of the drivers is available from 6.1, the version
> has been set to 6.1 for these attributes.
> 
> Signed-off-by: Ramona Alexandra Nechita <ramona.nechita@analog.com>
> ---

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6011af70c12e..2de269df7d3a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1262,7 +1262,6 @@ M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Supported
>  W:	https://ez.analog.com/linux-software-drivers
> -F:	Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
?  Spurious change.

>  F:	Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
>  F:	drivers/iio/adc/ad4130.c
>  


