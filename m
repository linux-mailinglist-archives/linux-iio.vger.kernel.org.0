Return-Path: <linux-iio+bounces-26725-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E45CA2C52
	for <lists+linux-iio@lfdr.de>; Thu, 04 Dec 2025 09:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A62AF3022A92
	for <lists+linux-iio@lfdr.de>; Thu,  4 Dec 2025 08:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD2D326949;
	Thu,  4 Dec 2025 08:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gc2LbE5w"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9277E2D321B;
	Thu,  4 Dec 2025 08:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764836053; cv=none; b=SkEyJBxU0zzPPCYF6Z5Y2SEPXRVhoosNSIUGhUJjpjlAtTXCMLg+4AUIPUEwLMkeAZpLJbM+6cEX7ke9zlxDHRb6XsO3BIMQWXAESEVX8frP48oy2BZ+8WLZxXXB3KblN+RilFe5fgwiN6talS74qXkF5iLIkEek6dUKfbc9y2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764836053; c=relaxed/simple;
	bh=y/mE6Hsjf5+EvwNp5XMJCQOSPMIGQfBFF4HGEOlovCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AgIz9Q8SehDncRSiSPvu2+vfFkubDdrxoPVCgMcKUM9DDkVkrWIwIw/7zq9Vkc9y94FM8mjpXYGOC6lAl6ykFT77XJ7UOSCT8+riZFLNAJN/KJHtkJUDjwoUErLdZn4eR8QGmqbX9d5kP5cQwTt0nEChWnWerFE4gLIvtGdng8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gc2LbE5w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C3B6C4CEFB;
	Thu,  4 Dec 2025 08:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764836053;
	bh=y/mE6Hsjf5+EvwNp5XMJCQOSPMIGQfBFF4HGEOlovCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gc2LbE5wp+bdAJXe3DkdEKRDDLK0hCH5/SiZ2UGo21c8tqdc69/YhzHgw2OGsdTzi
	 iDGDHDPuDORY+9+wuWKnlPTtZKTrVbj+rUNDY7qA2RVEnkE8S9AUpv3rhaK4C7gtfZ
	 AJrDs3jRcwUMNu5TnxlTK3oxvRlQegGuaQrN6V/pLKr3rr53+XB1AL27klU+BMMDr2
	 1ch2ImcCd4T8n3rvLxRLYItrqheGeoxMUjmPEyAGZhuoxAAPiOegc0PlfxGJ/Jvd1S
	 0u4KNQPrMPsG/jI9dZMp1UaVGnqLBFRPI0cnAdKGm7vooboFAf5kmz2VbSn5DkOaKE
	 wP3hOOhHCeFJA==
Date: Thu, 4 Dec 2025 09:14:10 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Michael.Hennerich@analog.com, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt@analog.com, 
	jonath4nns@gmail.com
Subject: Re: [PATCH v4 1/4] dt-bindings: iio: adc: ad7768-1: add new
 supported parts
Message-ID: <20251204-rampant-indigo-kudu-cdb5de@quoll>
References: <cover.1764101647.git.Jonathan.Santos@analog.com>
 <b2c005592b9788919fd32d4e8d7346e4be98d1a5.1764101647.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b2c005592b9788919fd32d4e8d7346e4be98d1a5.1764101647.git.Jonathan.Santos@analog.com>

On Wed, Nov 26, 2025 at 06:56:02PM -0300, Jonathan Santos wrote:
> Add compatibles for supported parts in the ad7768-1 family:
> 	ADAQ7767-1, ADAQ7768-1 and ADAQ7769-1
> 
> Add property and checks for AFF gain, supported by ADAQ7767-1
> and ADAQ7769-1, and for PGA gain, supported by ADAQ7768-1
> and ADAQ7769-1:
> 	adi,aaf-gain-bp
> 	pga-gpios
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


