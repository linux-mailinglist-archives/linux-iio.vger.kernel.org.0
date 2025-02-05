Return-Path: <linux-iio+bounces-15033-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38113A2896A
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 12:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A3A81888629
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 11:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4223A22ACD7;
	Wed,  5 Feb 2025 11:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5bfCpcN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2321519BB;
	Wed,  5 Feb 2025 11:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738755451; cv=none; b=j918uRFsxjPaWFN1BcfSRIIQVXmM3BDez1ZRP4ldYwX3HhhcVsCTU9tClba94UveqA0nQwuHeo8/tq3/O5GQziycCh6z2jN+zaGT4gyYPM8TMsbz1xJj1CmtE0IdTM6rcZQPPisrZnAeRRha9L9wQFe6KFJCSQS8MP+7eSW6PjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738755451; c=relaxed/simple;
	bh=+u+OoxOHhVl8WY1y7KQ7OzxVVb/xHKnU1BjXuUqSEcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KwrWU7Y1yTE4zGn9FpOftQJwwLYrcIut14n6ICko23X5j38WX6DwyOQpYXT60FoDVOMsrGQm0i2JXqSDzAFnNbck7a1+TU3ZYA5hrbqpq6c7kXEWf2IOZbbgP16eKjSpB3EeDJf7pECFszndaVUv1usuqhHrjNHtC7Es5v8ZNuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5bfCpcN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D6AC4CED1;
	Wed,  5 Feb 2025 11:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738755450;
	bh=+u+OoxOHhVl8WY1y7KQ7OzxVVb/xHKnU1BjXuUqSEcE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C5bfCpcNo5iIzzfAS3ZONSyl5tnm1Ma6+TUGw4pCkCuQG2eCDsLk3Do9sDds7tps+
	 kRCdreit8krgVoDIjXVmY2SEYStZadiJx5swLKLtZbD44xYsV7n4eMflF8WHDkqQt3
	 UsZ7PVlzBh/N6pMLNAZxG5aN6PlxXs9SqjAiCustNX6cFrX/IkEcngcaFRon5k9g/3
	 qjBrGVGvZwADJF+UxLXXlEFZ5WcqdXEa017YH+egm3i+YNjIyir1MzUm/VjkjULq0l
	 /yrss0CbZkZmxCmxkN31fl0We7cCs+hYewo0DSsTVgodmWHXY2ziL4xsuybCy2sgEJ
	 1OjmJ1kvRs03w==
Date: Wed, 5 Feb 2025 12:37:26 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dharma Balasubiramani <dharma.b@microchip.com>
Cc: Mikael Gonella-Bolduc <m.gonella.bolduc@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: light: fix missing type definition
Message-ID: <20250205-enormous-wise-copperhead-c1c0a9@krzk-bin>
References: <20250205-brcm-binding-v1-1-a996a840d2d6@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250205-brcm-binding-v1-1-a996a840d2d6@microchip.com>

On Wed, Feb 05, 2025 at 09:48:45AM +0530, Dharma Balasubiramani wrote:
> Add the missing type definition for ps-cancellation-current-picoamp property.

It is not missing. You are using some older schema probably.

Best regards,
Krzysztof


