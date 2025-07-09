Return-Path: <linux-iio+bounces-21468-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0AFAFE28F
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 10:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 579891C42AF7
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 08:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435FE274668;
	Wed,  9 Jul 2025 08:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9C1zRrn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED640273D84;
	Wed,  9 Jul 2025 08:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752049674; cv=none; b=XoNQ1yVLia6+SFKdbeHd4vPvs9g54rqrc3pBRBwW4Y+87lZIElTQoms2iTkWwkxGo4XZjM727FM/X4R0z0to3/Q77m3/USxdPjzkNAOQHRRVJJyVkb61sSBXM0twWodnhSyBot2fAkVOyCGkHPeTTcm9RuUBm6qKzQ2FLiso+JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752049674; c=relaxed/simple;
	bh=JQ1+Vm+0K0y8h9HijNHayqn7WMa42BU+nZE0V6oZ0Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DPeptb2QIjsyza+cszjmUVzIOJyRtIOtDs+5BHmjw7FKrbJTFET+8c4GmCHAY6i3IYxHTYfk9rQUzj9FQZxismpQlnS4Q/PX2++sYdBFHkZ1/EgeiMBGBthl7eP42F6D/RAXiMEWgt3g0LBgpS1CUtxMPqBraomZaMVTimLCffg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9C1zRrn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F19C4CEEF;
	Wed,  9 Jul 2025 08:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752049673;
	bh=JQ1+Vm+0K0y8h9HijNHayqn7WMa42BU+nZE0V6oZ0Xw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m9C1zRrngUo+zKh1qz9o/lGUIhk+lgLUAzXQ1p4p7yV42CMp2UU43uCVuuof5vfDM
	 8UWVAh5dA0DKSUY1z8GCEf++dqYgg2kRO7zkXKOli2vGTngBMpk8RJQoNoAwDOXSft
	 Fm6lPLk+svrUkXC2uBZOEZUUnj8VSpdgoxgmZmUHxkcI1ELJOHrI/zOFPUz+Fcyv7V
	 YYJfeyB8msSWd43v4A7z3fRG7RbuuCwnaD1XcdOl5zzQIq1sBv8H7aPAx0vAS1DR8D
	 Sk/Ox8R/6ALoIRhA8JygHl0O9vdAnAxSW/vKtm8hr2huo8222T5tAGx21WKx7n1coP
	 2rOFj9FsmFR6A==
Date: Wed, 9 Jul 2025 10:27:50 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, s.hauer@pengutronix.de, 
	zhiyong.tao@mediatek.com, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: adc: Add support for MT7981
Message-ID: <20250709-industrious-marigold-snake-5a3eb5@krzk-bin>
References: <20250708220405.1072393-1-olek2@wp.pl>
 <20250708220405.1072393-2-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250708220405.1072393-2-olek2@wp.pl>

On Wed, Jul 09, 2025 at 12:04:03AM +0200, Aleksander Jan Bajkowski wrote:
> The temperature sensor in the MT7981 is same as in the MT7986.
> Add compatible string for mt7981.
> 
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
> ---
>  .../devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml   | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


<form letter>
This is an automated instruction, just in case, because many review
tags are being ignored. If you know the process, just skip it entirely
(please do not feel offended by me posting it here - no bad intentions
intended, no patronizing, I just want to avoid wasted efforts). If you
do not know the process, here is a short explanation:

Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions of patchset, under or above your Signed-off-by tag, unless
patch changed significantly (e.g. new properties added to the DT
bindings). Tag is "received", when provided in a message replied to you
on the mailing list. Tools like b4 can help here ('b4 trailers -u ...').
However, there's no need to repost patches *only* to add the tags. The
upstream maintainer will do that for tags received on the version they
apply.

https://elixir.bootlin.com/linux/v6.15/source/Documentation/process/submitting-patches.rst#L591
</form letter>

Best regards,
Krzysztof


