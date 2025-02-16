Return-Path: <linux-iio+bounces-15571-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABEEA3751E
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 16:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65C743AF1B2
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 15:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D503F55897;
	Sun, 16 Feb 2025 15:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRSZxcYf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86669E567;
	Sun, 16 Feb 2025 15:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739720154; cv=none; b=i0GhyQwdVzoH9pyNZe8GBCb2tOWB9lokY1tFD9mqtRBA38yadXziOuTXZIxEFzYz4GM4tr+6EhC7MRd2TZJHuIEO5pBllUybsGy9/0LMu1HnFqmn2EVr4/IAPUx2tW1U2tY0Tl70spTPG1XKtYr2unaaks2agXU9+53aJFXFEmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739720154; c=relaxed/simple;
	bh=im7EejYh1JkWLynv0CkzdgGuK+7EquNaxfXvQsffwa0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X0b3OAteQDFD6/TWWMOIYvZAHWcqEhaFWCSnozgww8/I3VZ3N3jc708aj8Jkw+0fK4hI4Ap1jovKjO81/kaaIurrU0kBD3Fvntoa183hiW1qrUuokqAvjZ8o1rHnr9VGsXAYaYptGjyAgSFuBZ+LogCTARotFE7QuyOYhHvGUUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRSZxcYf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4420C4CEDD;
	Sun, 16 Feb 2025 15:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739720154;
	bh=im7EejYh1JkWLynv0CkzdgGuK+7EquNaxfXvQsffwa0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NRSZxcYfylQjUOHTur1IjBUobHbsYjwgScOt3lBEdqrSZiXVP3ikSxjxoFJXtyFsJ
	 JEoZzTSLFosZad5uRA2hWVbbXk9FW90NlsGTW4OzO2OywvCbAXmN0JkuqY/OCg9Mzg
	 +7FXrcAFEUc6Xo6Z2bXip6DQsg4YMyvFocLmvyzvSXekyge1VqMXK1cocytky7Zlg3
	 VLIXlqaDX/PXUx/PdvJk2d4UzywWTGMavZ/TgZOd9WOyYpb3uWQeAjaJpsqo8Tb/aT
	 VGkuO+FeUkrOWUP+WkVYxws96johQZulr0PYfQol1yDdB+vkvm38wlkKS+Wd1BwYie
	 xWiEb537BNFCQ==
Date: Sun, 16 Feb 2025 15:35:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Esteban Blanc <eblanc@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Conor Dooley
 <conor.dooley@microchip.com>
Subject: Re: [PATCH v4 1/6] dt-bindings: iio: adc: add ADI ad4030, ad4630
 and ad4632
Message-ID: <20250216153544.4f9e79c9@jic23-huawei>
In-Reply-To: <20250214-eblanc-ad4630_v1-v4-1-135dd66cab6a@baylibre.com>
References: <20250214-eblanc-ad4630_v1-v4-0-135dd66cab6a@baylibre.com>
	<20250214-eblanc-ad4630_v1-v4-1-135dd66cab6a@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Feb 2025 13:22:31 +0100
Esteban Blanc <eblanc@baylibre.com> wrote:

> This adds a binding specification for the Analog Devices Inc. AD4030,
> AD4630 and AD4632 families of ADCs.
> 
> - ad4030-24 is a 1 channel SAR ADC with 24 bits of precision and a
>   sampling rate of 2M samples per second
> - ad4032-24 is a 1 channel SAR ADC with 24 bits of precision and a
>   sampling rate of 500K samples per second
> - ad4630-16 is a 2 channels SAR ADC with 16 bits of precision and a
>   sampling rate of 2M samples per second
> - ad4630-24 is a 2 channels SAR ADC with 24 bits of precision and a
>   sampling rate of 2M samples per second
> - ad4632-16 is a 2 channels SAR ADC with 16 bits of precision and a
>   sampling rate of 500K samples per second
> - ad4632-24 is a 2 channels SAR ADC with 24 bits of precision and a
>   sampling rate of 500K samples per second
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Esteban Blanc <eblanc@baylibre.com>

Git moaned about a stray blank line at the end of the file. I deleted it whilst
applying.

Jonathan
>  M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
>  L:	linux-iio@vger.kernel.org
> 


> 


