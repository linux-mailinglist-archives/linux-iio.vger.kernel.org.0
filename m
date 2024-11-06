Return-Path: <linux-iio+bounces-11936-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D3E9BE1D6
	for <lists+linux-iio@lfdr.de>; Wed,  6 Nov 2024 10:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF81928523B
	for <lists+linux-iio@lfdr.de>; Wed,  6 Nov 2024 09:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532CE1DC1B2;
	Wed,  6 Nov 2024 09:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ky3ZD82E"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1811D63F3;
	Wed,  6 Nov 2024 09:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730883917; cv=none; b=rpfsyllJMQyjgzzYJxvZZl3wAlNu5FPxjLzweQUdfhFkzT3xL0a1EhCJ9R9/Nsup0H526K18QUg4VG93HwMzjqb8hHoTCBZsy9rd/bdUplDaQI93swW64VO/AfsU22PVFaxiEU69dzJOEKrwtORqR+bJVX46PVIBuhqmko/tA00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730883917; c=relaxed/simple;
	bh=bZxgR2PWLkGJRu+OTwhP61Fmug5IVUKMq4IwoiIgluY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UU/euSkHV3OqOEjdDEXuLafqrb8E1zlnSU8LChD7MlV4/t40JjkPlwKZTtD0btqno+UfmfNcTfFR2srvmYNVzUp9ocLwsCR9h9NmFnArumcNNfJqr3J4SuF4jvfOlfnAm8cowqo++zvAk1gnkLXmQYAw7Cot04saYhG461P0frI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ky3ZD82E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87BFCC4CECD;
	Wed,  6 Nov 2024 09:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730883916;
	bh=bZxgR2PWLkGJRu+OTwhP61Fmug5IVUKMq4IwoiIgluY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ky3ZD82EkBeaw9OP1Clsj5oXO+GrPp9xzmS+fUhDt/cjoqUGE6kVr5wAF59D1kK8i
	 EVZg4ThYgzlmFc2VXZ5qKC/ROcxD+cFIHUgSgsRX7WVCGK2ibN4R2ndJchcAj/4YJM
	 kcdtSw/pX9BT8k8GO3D36ZhIQo5z/1iF2A2tCS22i1/7hjonaZ8PVqh3QzgI8d2EFK
	 LtKusaT8HmrwvOXqrPeqmB2WBPp68YRJ5PeVBDi0mX1tZDY5BFhtcJrg88y9zHT7du
	 xW1YEb0nEhhEzuO2BRefHw7/JRl2niFE6HWHFVIQTbfwa+zeQAy+/U7BSjdnVN5vJ6
	 e9QvZGoQbJ/zw==
Date: Wed, 6 Nov 2024 09:05:09 +0000
From: Lee Jones <lee@kernel.org>
To: Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Pavel Machek <pavel@ucw.cz>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: mfd: sprd,sc2731: reference
 sprd,sc2731-efuse bindings
Message-ID: <20241106090509.GL1807686@google.com>
References: <efd200c3b5b75405e4e450d064b026f10ae2f8e0.1730709384.git.stano.jakubek@gmail.com>
 <cd8cc95b59c31418b174bba521dd2599a7929fda.1730709384.git.stano.jakubek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cd8cc95b59c31418b174bba521dd2599a7929fda.1730709384.git.stano.jakubek@gmail.com>

On Mon, 04 Nov 2024, Stanislav Jakubek wrote:

> Directly reference the sc2731-efuse bindings to simplify the schema.
> Remove the duplicate example from the efuse bindings.
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> ---
> Changes in V3:
> - new patch due to a missing dependency in the MFD tree 
> 
> Link to V2: https://lore.kernel.org/lkml/ZyExK01iprBHhGm6@standask-GA-A55M-S2HP/
> Link to V1: https://lore.kernel.org/lkml/Zr3X1RoQs7ElTnlJ@standask-GA-A55M-S2HP/
> 
>  .../devicetree/bindings/mfd/sprd,sc2731.yaml  | 10 +------
>  .../bindings/nvmem/sprd,sc2731-efuse.yaml     | 29 -------------------

Srini, you happy for this to go in via MFD?

-- 
Lee Jones [李琼斯]

