Return-Path: <linux-iio+bounces-8389-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF1994DBE3
	for <lists+linux-iio@lfdr.de>; Sat, 10 Aug 2024 11:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 560CCB21CCC
	for <lists+linux-iio@lfdr.de>; Sat, 10 Aug 2024 09:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1FA14C58C;
	Sat, 10 Aug 2024 09:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SaLpRAZY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A184436E;
	Sat, 10 Aug 2024 09:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723281322; cv=none; b=QO1ZWPf3XxH7SaKZPNGhhovYymLeGMQHI5KIrIyQjSnCYR8HvEaVJiw7SB/0OyCUMDQyB4UKp3JOfKkn9GgBWpkToneuQw/Zb+yhzMB5e39onDSEBRUa9NJXb/HbHd8MdqYQGf2OswtIMatFibOAJ+5HhjbVCt9k77jbiUy3AJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723281322; c=relaxed/simple;
	bh=4jUI/8vLUn4atLkGFI6Gwc9rkYad1USbcCUKjP4w6r8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PH4Uwm/Zik1tPztKAoRGfk6ZsZ3iIk0w9Vsh1OTpXhqn4Gxq99RanTJ48dSL6w5D0i7CjHuXwoXa/I1mwetxDMY3Q/lS/I2EX7tXcjS3mEQKBdBO638wOxgWVjVs+6ddzJUpzz8iTjKryWRQrQShsnv24f5J1ba8ntq3H1gJxQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SaLpRAZY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43593C32781;
	Sat, 10 Aug 2024 09:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723281321;
	bh=4jUI/8vLUn4atLkGFI6Gwc9rkYad1USbcCUKjP4w6r8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SaLpRAZYOti5YU7qbko3JJJ2CZde5/24AD+JvX9dfRVjvcoGQDfAjAOzSyhgy5Imr
	 9jCV7MBLxGbVtwRE6Uup2c+E1ErsE7T/6so0OKjHWMlHUIj73THWgMZld3sIZ7lHUL
	 7jN36UFq60ttbWo+cyZY002tBYeDX6B8RsVIJAEpkJEK6Bzqtyrzb3p1q2QePM2CBf
	 zNlwA5u5mTKjeCCdowGQGDPDF3ISYgWktBTrZRVlQE1CVWzf+kKHF8gW89x6KW60RP
	 szk+SV7xD11uakyy9pVnbKhsBv0agBvG+NpHb3wpJjpVwdfrJIbbDZebmJPKGjrQMC
	 nsgJH6sLT4NPA==
Date: Sat, 10 Aug 2024 10:15:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Michael Hennerich <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: ad4695: fix common-mode-channel
Message-ID: <20240810101513.2e61cd9c@jic23-huawei>
In-Reply-To: <172322677990.966347.12423820402689548305.robh@kernel.org>
References: <20240808-iio-adc-ad4695-fix-dt-bindings-v1-1-5cf37b9547b0@baylibre.com>
	<172322677990.966347.12423820402689548305.robh@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 Aug 2024 12:06:40 -0600
"Rob Herring (Arm)" <robh@kernel.org> wrote:

> On Thu, 08 Aug 2024 16:12:08 -0500, David Lechner wrote:
> > The common-mode-channel property is a scalar, not an array, so we should
> > not be using items: in the schema when specifying allowable values.
> > 
> > Reported-by: Rob Herring <robh@kernel.org>
> > Closes: https://lore.kernel.org/linux-iio/CAL_JsqKaddw8FnPfdnhKhHUb8AcTxFadc_eZmxjX0QxFR80=mw@mail.gmail.com/
> > Fixes: b40cafc11436 ("dt-bindings: iio: adc: add AD4695 and similar ADCs")
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > ---
> >  Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >   
> 
> Thanks for the quick fix.
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> 


Applied and pushed out for next to pick up. 
Thanks,

Jonathan

