Return-Path: <linux-iio+bounces-10232-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F80991E3E
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 14:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DDB31F21AB4
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 12:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065A4175548;
	Sun,  6 Oct 2024 12:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpGjpN1L"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73D054F95;
	Sun,  6 Oct 2024 12:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728218104; cv=none; b=QP3d1KrsCj4tL6oj3O3sb2dTAbd0Vw/XubfZEzey3j6Gk33jOC0+K7iowik01wZZoN3vyjZ3LLLdPcLMnlrf6XR0nBTk28gIzG9BxnWPcFruc+5XbA9q/NVMrTZqLG8lcJXAUMRQYiK3KpwNMsnGGqevsXLyYTsYSUo+aGzVTdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728218104; c=relaxed/simple;
	bh=h3SNGhBjTTSf5mR7IH3HuSRamIcY1suVQJtnIoobHi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFWF0vFVhLk/7sO1GSbBtds+l6ngfUGqTsOVWhrVLhEXERoL4OTB8HpGUwRANXzELqki94z3RA7bDMFke/s6zK8ToigA4H8BdciDiNh97DosuLNRYkbCBqgFjo4gupWz8vx/zh1VNwhgq5xbLepFZNr/UQVB4zsaIGEeTpJIDSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpGjpN1L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CAA8C4CEC5;
	Sun,  6 Oct 2024 12:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728218104;
	bh=h3SNGhBjTTSf5mR7IH3HuSRamIcY1suVQJtnIoobHi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZpGjpN1LimCK4XuwXJXeGjKVNfcugT4LyCo4ObaVglyFK1W3xif68yKp1x7/bfhF0
	 GVMO7Tk3JqUijNGb3NjT+4m2ZWi8sSl9aLnzA+0jEbwhBgH688zL6Zh29CrNVvqYGm
	 xGnxBRM/8g76o8rPjEwsl6qsc8Qkc5errI2Tl9FnjocsYX2MSkn/1NVoh09zJq6W8l
	 vIssWgEggDcFjMyV91Ko6m4p76Ci4ji3/zpBemwhCInVqQ72WBR71m/eYnDpizKerg
	 H50hMGa4+8H//TMhsq7UGBWR/hr7zgCw4bs66yjo0oI7R5VuH/5cRZfzXzNpdj700P
	 HySGL4nkl88Pw==
Date: Sun, 6 Oct 2024 14:34:59 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Per-Daniel Olsson <perdaniel.olsson@axis.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, rickard.andersson@axis.com, 
	kernel@axis.com
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: light: Document TI OPT4060 RGBW
 sensor
Message-ID: <hgv7h3l7bucgeu4fq6w6q4ikhjp6nzfrl6cxiwdghwkzm6gpdu@565oyl3h6zqn>
References: <20241005165119.3549472-1-perdaniel.olsson@axis.com>
 <20241005165119.3549472-2-perdaniel.olsson@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241005165119.3549472-2-perdaniel.olsson@axis.com>

On Sat, Oct 05, 2024 at 06:51:18PM +0200, Per-Daniel Olsson wrote:
> Add devicetree bindings for the OPT4060 RGBW color sensor.
> 
> Signed-off-by: Per-Daniel Olsson <perdaniel.olsson@axis.com>
> ---
>  .../bindings/iio/light/ti,opt4060.yaml        | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/ti,opt4060.yaml

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


