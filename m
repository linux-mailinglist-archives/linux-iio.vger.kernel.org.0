Return-Path: <linux-iio+bounces-17721-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F272A7D463
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 08:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 118ED188E8BA
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 06:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61630225402;
	Mon,  7 Apr 2025 06:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PpF661kA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114802135A4;
	Mon,  7 Apr 2025 06:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744008133; cv=none; b=rkgj/XmF80G9t8jvWPRTh9zeJ5JJPmEfBbVLkgnw/INle7lYAe0zXSFyUcU4IzWjJn6uBHFe/3Lgy132V8ppcEHx+iEvg3VQUl5Ny805+FXy6+wLIGptnpQfLC5BXP5VCHOAqhVMMiZiACkGg/C2SN/nSEvNXF9NjPvaQWE4ld0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744008133; c=relaxed/simple;
	bh=1epuAsdGFjQXiJ2zP58eqOumz3WPiiL81pXNiCSsDD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ct9niZSdzVfhxBQfWdrMMcK/cnpwdQAd7LvnLjYrd6eE/AKg5xZPwoOzMNjLCbL7qVq+h/m8P4vBq1nP+NcOZtkifHqp6kX3J8NzTkrqKav8+GjjWV1tCzmUHZRMmOXJg4+BLhp4vZwwJuHcpSSR1gtWHGxO20MX/WC0f6J9bLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PpF661kA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D71C4CEDD;
	Mon,  7 Apr 2025 06:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744008132;
	bh=1epuAsdGFjQXiJ2zP58eqOumz3WPiiL81pXNiCSsDD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PpF661kAnBfxzvjmehRL0O/UIuUDgm8Z+tKNZRuRQ39rw/Uw5ybGGR4ORZzATTdye
	 e1NK5sKL4FVyesiH3DuGhuy8caeILuuXQDPrOrPtSIyo0BsHOLiJyA3wR+KHcclqRs
	 +MCguyvtHQbQXSlmWKTJc+dipw+BlchVkzc/rsMw3eoB9YuBuRcrF0ejpvaTbzgUzb
	 ODXrCjo7hhgzN97ekoiwOfQnhTY03QWfGD/9OMHrEHMw6ZfXzAiJLxQ4hvW+3n+0eG
	 ANEds0obpOaBxzGOxNy5GblWSY+XWgLqETIXwTuVAYQ1xBvIr1XM5Br2znZDqJyY8x
	 q8AXkOh5Asgxg==
Date: Mon, 7 Apr 2025 08:42:10 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Jonathan Corbet <corbet@lwn.net>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: iio: adc: ad7380: add AD7389-4
Message-ID: <20250407-rebel-succinct-skink-beb6cf@shite>
References: <20250401-iio-ad7380-add-ad7389-4-v1-0-23d2568aa24f@baylibre.com>
 <20250401-iio-ad7380-add-ad7389-4-v1-1-23d2568aa24f@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250401-iio-ad7380-add-ad7389-4-v1-1-23d2568aa24f@baylibre.com>

On Tue, Apr 01, 2025 at 05:50:08PM GMT, David Lechner wrote:
> Add compatible and quirks for AD7389-4. This is essentially the same as
> AD7380-4 but instead of having no internal reference, it has no external
> reference voltage supply.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


