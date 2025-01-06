Return-Path: <linux-iio+bounces-13936-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A2CA031B6
	for <lists+linux-iio@lfdr.de>; Mon,  6 Jan 2025 21:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 216B03A15EE
	for <lists+linux-iio@lfdr.de>; Mon,  6 Jan 2025 20:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51251DFE24;
	Mon,  6 Jan 2025 20:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzc+8enB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBC21C69D;
	Mon,  6 Jan 2025 20:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736197179; cv=none; b=TAqQaVKI/Ol1kioww4el4iVwzyJMtnzgSxUPlVf8LFi25og/miSOTerC5EW+nOOe0C2vA4XSKV6wyqUYxJpmr8e0x/RMj6rjeZnejAvNFVZ1mET5F2EK2xLBgnHtXYutqhIWw8+vNzzwB5iRejed40YSJCSesfYfv5N47INFBaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736197179; c=relaxed/simple;
	bh=/Tq8zsr139QW20C83yqonaXy2b1o+Hy3a/z/8/8gRbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PoKrajGog+JxFRX/SoAFVY0l+9rJczBbpvMQ+/fYme3Gwjwgnp12D3WR087MSjsXsZjlFCUgLlARz5I05nvsyvggmoLNEZrfRLJkpVqDox8ykLLq9RdHerIa7TTU/eMHEMaPfnYWmPSEzErTpv91Nf+fEwhGK+k/S1xzz1MlQic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzc+8enB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC8FC4CED2;
	Mon,  6 Jan 2025 20:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736197178;
	bh=/Tq8zsr139QW20C83yqonaXy2b1o+Hy3a/z/8/8gRbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hzc+8enBvs/dRpzL7bLq1UHeOpVW07/GRhTWl+5WaOh2ys/fflfsiu/AHHFPVYsDS
	 CpbPIwWIR2gUMGfNyODNjTf5OCoDU4crS8/5Uv8JhV5qRTzVux583X97Qw9mNtGyhY
	 cYX2hooij1993EnX/pJWkb8SQdz+rGo4EU0n3bbLIl2lb2KmH0Btxsrj0H1u7yRIn3
	 XamsPBk2ZFkxSx4HBNst75hSJDuS/u6l2G2rYJYzvJb28QktdgbnjK4XoxZpiw8TaZ
	 eCKRchuahoBINByyvZ2DjWui6R/vaeyesiSMuB0lGKAsfb1oluBlzZKnIEovepJHsB
	 fSBzXQNqdGUDg==
Date: Mon, 6 Jan 2025 14:59:37 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: jassisinghbrar@gmail.com, jic23@kernel.org, tony.luck@intel.com,
	luca@z3ntu.xyz, gregkh@linuxfoundation.org,
	konrad.dybcio@linaro.org, marijn.suijten@somainline.org,
	srinivas.kandagatla@linaro.org, linux-hardening@vger.kernel.org,
	lars@metafoo.de, andersson@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, evgreen@chromium.org,
	robh+dt@kernel.org, linux-iio@vger.kernel.org,
	keescook@chromium.org, linux-arm-msm@vger.kernel.org,
	kernel@collabora.com, agross@kernel.org, gpiccoli@igalia.com,
	devicetree@vger.kernel.org, a39.skl@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/11] dt-bindings: sram: qcom,imem: Document MSM8976
Message-ID: <173619715113.948940.15329023588634748469.robh@kernel.org>
References: <20221111120156.48040-1-angelogioacchino.delregno@collabora.com>
 <20221111120156.48040-5-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111120156.48040-5-angelogioacchino.delregno@collabora.com>


On Fri, 11 Nov 2022 13:01:49 +0100, AngeloGioacchino Del Regno wrote:
> Add compatible for MSM8976 IMEM.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  Documentation/devicetree/bindings/sram/qcom,imem.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!

Really, Bjorn should have picked this up with the rest of the series.

