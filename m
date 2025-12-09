Return-Path: <linux-iio+bounces-26981-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 681D1CB10ED
	for <lists+linux-iio@lfdr.de>; Tue, 09 Dec 2025 21:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 621BB3009F09
	for <lists+linux-iio@lfdr.de>; Tue,  9 Dec 2025 20:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FBF2F39DE;
	Tue,  9 Dec 2025 20:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClDra+oU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1FF27B4FA;
	Tue,  9 Dec 2025 20:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765313522; cv=none; b=DdVQTRcN/pIYgoHpXJjwDs/Uogl7hKaPWzIkBbLLtARcyjCzD4JvEso/aCjq1jlPxH6PwtYo2MZFdUZdYiKf60BajlIJV5MNW0rHQikPf4IXiAvUIOJLcRW12ZlLBoHJbNZa1PgBJ00wLMCla+Zy+lXBpXCCnfSq3N1Y4G+SwqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765313522; c=relaxed/simple;
	bh=VmN3AEFLBJHTbo1gne1kM6xJGtRrR6e+QjVlA5+pR1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dATgqWdzsZjPjhsPwV1I1nfsNuP/ktwgcPCSjWrXsT+bNC/ZrRkmE0cZQf+Bn/5fTlnDe5RiDhrgFo2FSjQxQ2vO/l0UjuS/gwdXQWt7UPTvVd6GwrDpe+GNWBA0ONW3K92P+HFuvKP67Dd2WPWuZCRTf7w7eVvKDi81LlCA9+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClDra+oU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A534C4CEF5;
	Tue,  9 Dec 2025 20:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765313521;
	bh=VmN3AEFLBJHTbo1gne1kM6xJGtRrR6e+QjVlA5+pR1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ClDra+oUA2mIIhPNqP4eXf4AQU2nmGqNLX9fhYIuRnfXlUyrtVrn9qqqPR3z6nPz0
	 2L1waK8jNjWT4VmtwImnKVc4Ph1hi4nZ+ysjnsKHLno2J8PaDQaFz78TzIGcjafmtu
	 6ivxnVKAP1zIkPIugKwj/1UBl+eFMydoLUIhqxWoB5ZJ68Cs4Q4909U2cvXCLcF9ov
	 ZLflbUCgqsmGSC1PFYHp4v/rFTf0o72a8/VJQ4BnyGudPP0k06N949jLgFBSgakPja
	 3Xx3RMQB9+eOrnBahQeOWs+oojspzhuGzdXtLAN+fgPaZ4Hf14xxORu4i841J5XZL/
	 B5SOQp1bWkmMg==
Date: Tue, 9 Dec 2025 14:51:58 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v6 1/2] dt-bindings: iio: amplifiers: add adl8113
Message-ID: <176531351772.1075654.11407839110196127214.robh@kernel.org>
References: <20251205144058.1918-1-antoniu.miclaus@analog.com>
 <20251205144058.1918-2-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205144058.1918-2-antoniu.miclaus@analog.com>


On Fri, 05 Dec 2025 16:40:40 +0200, Antoniu Miclaus wrote:
> Add devicetree bindings for adl8113.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v6:
>  - Use items list for ctrl-gpios instead of minItems/maxItems
>  - Simplify ctrl-gpios item descriptions (remove GPIO_ACTIVE_HIGH mentions)
>  - Remove maxItems (implied by items list)
> 
>  .../bindings/iio/amplifiers/adi,adl8113.yaml  | 87 +++++++++++++++++++
>  1 file changed, 87 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


