Return-Path: <linux-iio+bounces-9358-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65975970DDE
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 08:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E4331C21E09
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 06:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884CC1ACE0B;
	Mon,  9 Sep 2024 06:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ej0kJoqF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C99B176FBD;
	Mon,  9 Sep 2024 06:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725863335; cv=none; b=F3M8AdDMArXvsRAkN8Pi/2Fq6DJOiDptp5uBPVEb5Vwik3kH8y2ErV278fqw3dTnWJQyJ6PFH3GIfPOl+5rVGM3YwLmWzIil3VZnDqofDQsoRN45ipcEjsDT+BVxO+grnyd26+tqxR3Rfm+4Z8TA0489kvVJYD1etXZ1AJ7HaFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725863335; c=relaxed/simple;
	bh=vvELSPvT8UWs+PW7fQc4nobj2xRxzohNYvouiA2zvJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rEIb7uF45OpoAGC3aRacBKeXP0oU6C9tEV9rkF0aDdmQPWBZbtqTZxzs+S8i+IC82b98Vr/fxjEJ/tGyWVAG/8WmM4gPYzoc9GjsEqQtuCa3CHuY501FmEbC3JOXZpt5XYxZlxHDbQu3dkeA8JvOQlWq3GRk0uEbTz97JDXxIDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ej0kJoqF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF6B5C4CEC5;
	Mon,  9 Sep 2024 06:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725863334;
	bh=vvELSPvT8UWs+PW7fQc4nobj2xRxzohNYvouiA2zvJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ej0kJoqFnW8EeHSMrviM6zRrldOaL4F5iqMqV1dNwYrbBSXMR9jMr0jBc7NBZMGRE
	 Xs4Vj+z+etBEWtZ/zC0dYlT2VMATpr3COaUDm1Uwz5XPeJ9+aIzIL3oCsCqtoRVLpS
	 C55wqkhStBo5jVZ/RTbhsYfpzaXnMEXCZjEVlN87TpEvh3dqZNx/G+UElK5BycqzxR
	 mC+VWegXfHx7q5MjJSsE9IAlq0sQ4aCbVzLp6QNNor1VuBJ6KPlDXlnEHM+uNd3ONU
	 hWXXDIzxvvD9JprQ1ZCTgMjoSvQjElgYNy1QZ6GeDxiNVFLW5Bct1CMpgogAwpSYAF
	 7zYEi3OH7s2Fw==
Date: Mon, 9 Sep 2024 08:28:50 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, 
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: temperature: tmp006: document
 interrupt
Message-ID: <ccrcxtfn3dvi6hj7j5mxflm7izhjigqb7vrqnzyklewa57nx2t@beuz42fgblmj>
References: <20240908172153.177406-1-apokusinski01@gmail.com>
 <20240908172153.177406-3-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240908172153.177406-3-apokusinski01@gmail.com>

On Sun, Sep 08, 2024 at 07:21:55PM +0200, Antoni Pokusinski wrote:
> TMP006 sensor has a DRDY (data ready) active-low interrupt which
> indicates that a new measurement is ready to be read.
> 
> Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
> ---
>  .../devicetree/bindings/iio/temperature/ti,tmp006.yaml      | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

<form letter>
This is an automated instruction, just in case, because many review tags
are being ignored. If you know the process, you can skip it (please do
not feel offended by me posting it here - no bad intentions intended).
If you do not know the process, here is a short explanation:

Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions, under or above your Signed-off-by tag. Tag is "received", when
provided in a message replied to you on the mailing list. Tools like b4
can help here. However, there's no need to repost patches *only* to add
the tags. The upstream maintainer will do that for tags received on the
version they apply.

https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577
</form letter>

Best regards,
Krzysztof


