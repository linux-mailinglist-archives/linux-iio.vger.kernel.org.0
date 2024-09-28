Return-Path: <linux-iio+bounces-9812-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA24988F9B
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 16:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69B30B215AE
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 14:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E1818873A;
	Sat, 28 Sep 2024 14:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAThjtkj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A62F186287;
	Sat, 28 Sep 2024 14:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727533525; cv=none; b=IZvOmvtV30I473X/lywtcBBQfqrcU4Snvf/qEQlkIpXBTvWwVUQkjyDZrrCwo+T6mJQD9ZUpN0jiu6BfZcaXM1vVX+MLaFpY5lIDEsjmZduVPJOreXiqvmFK71j7NHf2flen0sLQkxUByl3FK/B0CDV7RW9eqhE1T1Ngi08aQ4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727533525; c=relaxed/simple;
	bh=n/Y0Anj9nP0Sgfmkct6Br5yJAJkrMZ80Y0JmDNmOs14=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bSl68G3iPtXffkrUEtgum9IEzL2aDMUXh32uwwNvdYwrm/jOOqrtzELYwFIhB8Mydxjvcvq4seTXPFt1W8jn7Sw+L//uTbZblGmCEt9PaQ9iMArelBn/eYWpuMg5o3FeP0CQfcC+K22DZn9sLWLpfOqKupYO9GKNZW1ZLxOdbz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAThjtkj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BBAAC4CEC3;
	Sat, 28 Sep 2024 14:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727533524;
	bh=n/Y0Anj9nP0Sgfmkct6Br5yJAJkrMZ80Y0JmDNmOs14=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LAThjtkjZxXFpNqc4Shx4Tkjwl/raQB20DWTxaXmJnpWJWZUeKrTGPhVJ3KVQgKt1
	 V2eQvujJWO7QWo57DMmMyBb46A2eqgZkwZVlpVXQCBaEo9E0IdtxD9hzA4IMZUO4In
	 Py4GYPSuH//cFM7g0ghVmIO+l6n2bbyqkbmFuwIQZeQUG+3dPoM0jDbZAZZpRZ3j89
	 mYIEiukC4Vej2YFaUrFBxGGb07Zs7KVcej2uraSlYnJH+rd4ch1b1ob7A0XWMY93yu
	 G4wULi10wxi1+aLxuUGOBW09waRh6MFsLmsXwQ7MfOx54q8xC3FNnG3GNaqhqUNfIx
	 8UWWBwYUoGF2A==
Date: Sat, 28 Sep 2024 15:25:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, Jerome Brunet
 <jbrunet@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: adc: amlogic,meson-saradc: also allow
 meson8-saradc to have amlogic,hhi-sysctrl property
Message-ID: <20240928152517.7386f220@jic23-huawei>
In-Reply-To: <20240911-topic-amlogic-arm32-upstream-bindings-fixes-amlogic-hhi-sysctrl-v1-1-b8c3180b2fba@linaro.org>
References: <20240911-topic-amlogic-arm32-upstream-bindings-fixes-amlogic-hhi-sysctrl-v1-1-b8c3180b2fba@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Sep 2024 17:29:53 +0200
Neil Armstrong <neil.armstrong@linaro.org> wrote:

> The SARADC on the Amlogic Meson8 SoC also requires the amlogic,hhi-sysctrl,
> property, document it by adding the amlogic,meson8-saradc compatible in the
> adequate allOf:if:compatible:contains:enums along meson8b and meson8m2.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Applied to the togreg branch of iio.git.

Shout and provide a fixes tag if this should be in stable.

Jonathan

> ---
>  Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml
> index f748f3a60b35..b0962a4583ac 100644
> --- a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml
> @@ -98,6 +98,7 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - amlogic,meson8-saradc
>                - amlogic,meson8b-saradc
>                - amlogic,meson8m2-saradc
>      then:
> 
> ---
> base-commit: 47ac09b91befbb6a235ab620c32af719f8208399
> change-id: 20240911-topic-amlogic-arm32-upstream-bindings-fixes-amlogic-hhi-sysctrl-127d3feddf3a
> 
> Best regards,


