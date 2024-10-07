Return-Path: <linux-iio+bounces-10297-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1E39935E9
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 20:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A5D02863AE
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 18:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E4F1DDC29;
	Mon,  7 Oct 2024 18:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F56kTJpb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB031DDC19;
	Mon,  7 Oct 2024 18:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728325151; cv=none; b=G0y2AoBpqdvzjOwzlyZZmshS3onSFkWqGJT8F8EBia1OUP1mIgjqLW7crwYu8hAkhBsMXS1Xrw7OcJK0AJUaSgB8tTLfI1hXH8StV671fXaKd2P/7UfBGMWG0rTZuuo+y0aegixVd5/9p3fwAwGfmgd+NoLs9ESW2HB4kCl37Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728325151; c=relaxed/simple;
	bh=qQA6uGhJh0navPHbWVU0cNsT9ZnnibRhRSL94S8Rsis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=piJRAsvxNl65K45JNRqngzU2aIQABsVm/sAziq45Un60LeToBLAk0T21hpJO2BMuJkz7enECkzrcPGJON13IwN7JJzzVS5NsvL87R1VzL5j/y5qeW6Wg84YCngfGtO+Tzey4rEqXMcpA+G/hpGTp9UwIm44MTj1n2d82oe+xNy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F56kTJpb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8647C4CEC6;
	Mon,  7 Oct 2024 18:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728325150;
	bh=qQA6uGhJh0navPHbWVU0cNsT9ZnnibRhRSL94S8Rsis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F56kTJpbnmyKekS9/Im+8fmvusGyGDEqQ/TYdP2R+XyA/4XoYgQkhuOkXZWCq0TQL
	 t5tL6c0yVIzL890mfU+0zUNZowmhmIiq977rkuMBu45cRnhUtrYevaZNos5Qg4Mzvs
	 2S6dQaFCBTElYDHVaa1vhfAk5zCMjl6D+kcp3WfuXutNzu403A9S0OtqHkrX9hxwa5
	 wpZMblPJ5rA5uJ/mnMbyEy0F+/zFCKIp2Uy3cAODGqDCuhToYc8OoOaaa6X7N6v3NU
	 NNUd8OdqvzSWjFTIL3p2anAfJ3a1Tafk6AtmLpncGO75irltnJ9j2Ev4Eyp4YOPpzz
	 O39FhEcB4SmRA==
Date: Mon, 7 Oct 2024 13:19:10 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: Add Allegro
 MicroSystems, Inc
Message-ID: <172832514942.1898067.3097467627060908054.robh@kernel.org>
References: <20241007-topic-input-upstream-als31300-v1-0-2c240ea5cb77@linaro.org>
 <20241007-topic-input-upstream-als31300-v1-1-2c240ea5cb77@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007-topic-input-upstream-als31300-v1-1-2c240ea5cb77@linaro.org>


On Mon, 07 Oct 2024 15:14:38 +0200, Neil Armstrong wrote:
> Link: https://www.allegromicro.com/en/about-allegro
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


