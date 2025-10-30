Return-Path: <linux-iio+bounces-25658-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D55C1F41F
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 10:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4B3C3ABE62
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 09:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCA831A805;
	Thu, 30 Oct 2025 09:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JugtqFC+"
X-Original-To: linux-iio@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E1F17A318;
	Thu, 30 Oct 2025 09:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761816209; cv=none; b=tCN4XKR5xnDcEQZ0oO+VtBKol5CKkOpAVnpUMxd2bBgWRtP5iq5qHyoz4tAUIpdH4zdZ2ja3NSU01dpsCvZ8NKNDkkj/cBxWv9W60DYes8mEI2qrq5vQQDcmPa8kdmqErIPfZxuX1l1Or3Adz1UMCqcggOBJSDOm9rsXa0SLFZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761816209; c=relaxed/simple;
	bh=vfjU7SCgYDMFO30HAISoEJD4pRpKsAR7TJkNaxWJ9j4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ByVb5QL0Fs5LWvp3f8yp1LRfaTiYQyyHuNmPN9oAOPn3U5ywSlJrYDLTfp1p0KEqD4xyF8UnJLnKZ00lQ5W6X6OMzmjyuPy/DKvwmgYCm/urB4wYsMqXRe6XiAsP0jKcdooAzOgXQlZoZDttP0RbDv6sOVbHLgzjJM8Oa31PbSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JugtqFC+; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761816206;
	bh=vfjU7SCgYDMFO30HAISoEJD4pRpKsAR7TJkNaxWJ9j4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JugtqFC+5sJwcESTnYce/Z9hW6PCkhUdr3OUrtCBQps7TwlulwSe1IHWdn9Kla0hL
	 Xvw13Ev+kh2D874lIhsYXZcvqGEHb4sOQik1PqoctefIN84BULFmuYNOlwfBMyybbr
	 eRL+D7rZPxYpWe6L/xP5q/2GSQbSy+tmZPIb242VU30IsRGFbgLqzLkLyLKP5Ru6u4
	 VeX5DNw6DLD+LuqgdVKjKuZTHyz+rY9pSK+rrZfqJgOXW3WtLECwXciQlPXKbZhQ7P
	 F766y3alxzRVMaPPMXl4C62E+TfXcvoDeff0jBJDGk2oMjYQjKbdSd+iMUlwWKNz5/
	 60aBeIjub63AA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 54EC717E13DE;
	Thu, 30 Oct 2025 10:23:25 +0100 (CET)
Message-ID: <95335943-9b63-40d5-89c0-6d616f811e59@collabora.com>
Date: Thu, 30 Oct 2025 10:23:24 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: iio: adc: Add compatible for MT8189 SoC
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc: kernel@collabora.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20251029-mt8189-dt-bindings-auxadc-v1-1-cd0496527a70@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251029-mt8189-dt-bindings-auxadc-v1-1-cd0496527a70@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 29/10/25 15:52, Louis-Alexis Eyraud ha scritto:
> Add compatible string for MT8189 SoC.
> The AUXADC IP in this chip is fully compatible with the one found in
> MT8173 SoC.
> 
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



