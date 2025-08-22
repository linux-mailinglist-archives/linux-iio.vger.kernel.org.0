Return-Path: <linux-iio+bounces-23161-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDD0B322D7
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 21:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E7F11881BD6
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 19:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3192D1F4E;
	Fri, 22 Aug 2025 19:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AaNE9rTn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092A219E7E2;
	Fri, 22 Aug 2025 19:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755890973; cv=none; b=ubMQtHcqyPbw4MRon6PExfL7SI0R7EOdeoqkcbmV0fDWLykTcpuzLcDhPcIjhuKySrz4KxGYrXAUXJcM/Cc6OefjFON0V4l0LAD1HGlVtNmp+xqJehjgLZvfzc39PBOuFFnAfXvKTxgIGJRezits7Flhk08JOIdkBCj5VuPsVPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755890973; c=relaxed/simple;
	bh=uApDTThiRZ+KbIYw88qsn5XBMywM1KpZuHbN7XP5Vmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0DrsWgjPIrYDgvRCKDQgLYWd/3RXquVx3mmJIgUcQtNw2BWx9Td6DE5LsOSN1B9eQWqj4XVtPKgk4oNAh+Unv8NrGIeJKuZVzILDJKx9Odph2oliu4uUU8+ZukXO4ZEceLVE76rGyLPYHjQSffCZZCfASFxOs6I5lG3aWlnoXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AaNE9rTn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C18C4CEED;
	Fri, 22 Aug 2025 19:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755890972;
	bh=uApDTThiRZ+KbIYw88qsn5XBMywM1KpZuHbN7XP5Vmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AaNE9rTnc1HM8hBV42IG2QwPFPYCcVMa9OAZPJDRL80rz/nrILTZafCeMzqfku8xD
	 y+Z+QvJ1IA4nYTWxX+37u6QVkei8AVhazVhwELlrByJlssjjR9tpfd7RPUxsUocLZb
	 OmIJ15+kvgwSgKuect8xy4CjKDUQDrYU6f8zosbeL/nj81Kw6+hrZ+7FCFXVY+GsX0
	 VO7XrKG6WPTDRAtUyCOCe9Qk528KUkqq9AZuSHyadi9ZeDBpZQWgisK5+XFY/DhnCx
	 5tC+G9cSWdqgbRwB16WZNOKkz7RrknzsLP7Z/InBBl9hPuyy/XxMi2l53suZ3L3iV0
	 525Fv/xj6nR1Q==
Date: Fri, 22 Aug 2025 14:29:31 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Kim Seer Paller <kimseer.paller@analog.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH] dt-bindings: iio: adi,ltc2664: Minor whitespace cleanup
 in example
Message-ID: <175589097127.178922.52729764188594464.robh@kernel.org>
References: <20250821083150.46554-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821083150.46554-2-krzysztof.kozlowski@linaro.org>


On Thu, 21 Aug 2025 10:31:51 +0200, Krzysztof Kozlowski wrote:
> The DTS code coding style expects exactly one space around '='
> character.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


