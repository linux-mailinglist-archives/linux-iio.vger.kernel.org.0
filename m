Return-Path: <linux-iio+bounces-27065-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 950F9CBB141
	for <lists+linux-iio@lfdr.de>; Sat, 13 Dec 2025 17:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E8BC305C81E
	for <lists+linux-iio@lfdr.de>; Sat, 13 Dec 2025 16:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A806E2D8DB1;
	Sat, 13 Dec 2025 16:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPjPd3Q5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58833274FE9;
	Sat, 13 Dec 2025 16:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765642720; cv=none; b=nXdWllITXgwILcMme3L3xfkLHga+GrBu4LetIBlM2GLv0Ked/ZniBLiiz5qXRRFBDdo76D54oaiqH9mUjTUCRrkTcVT44vJeX/WwyfuFrpJOZ/fGkK6Q8fMsuEW9JC2m+heiQQt20izJRunsLVXEib4Yvk7Infma7zQfnWz49nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765642720; c=relaxed/simple;
	bh=1xplBs9CLMsmlQ2SGdHKqlfNPkFwI+2hV/Jq9+neGfA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r0OyGBuzLfgcNVZ79KKMIuI3ASdIlI+uAjddsaFy7ial/3mOY+2tjUNy334caSOK+lGv6zLNlpob1k3UkDBfyzdMgzhygr+YfoRUWYI7xRODiJng7ett7G/L++MbTzQNmggBvtBtwIQUvzWam5nChR4yKQwCLa7nBxWPLjomHyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPjPd3Q5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D57C4CEF7;
	Sat, 13 Dec 2025 16:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765642719;
	bh=1xplBs9CLMsmlQ2SGdHKqlfNPkFwI+2hV/Jq9+neGfA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jPjPd3Q5NHYILCZVFK7odLWdG8vujuiENR5DxL6g8NWwHqlGzrhpJFxyvJmzX7dwI
	 mQpxoWce2cObADMh+PrCYGUmXILHPjsXCB4YhpeaL+T1iL8xznpMnMs9YVwGIefsi+
	 jlXk5LkoBGvgPVlAHJqkl3ekqdpjnPDJ5q9gODvDx1JzbtjmTNMWvVyfCT3XMmdE7Q
	 EofPYqM3GANvrHYa59w/VBtjpCuJVgg3x1mdAIiw5kdnpNMSLipqTLD6wZTCbY+CBZ
	 b+X2BZWnNHtQaE9Ng5Xh5kGQHPkMy6/OTu/QNXedFLBaXW2oDfuuGzo/o5hDYkubVU
	 ngRpwqokPY8mg==
Date: Sat, 13 Dec 2025 16:18:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Dragos Bogdan
 <dragos.bogdan@analog.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v5 0/2] iio: frequency: adf4377: add clock provider
 support
Message-ID: <20251213161828.4889853c@jic23-huawei>
In-Reply-To: <20251212144733.127890-1-antoniu.miclaus@analog.com>
References: <20251212144733.127890-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Dec 2025 16:47:30 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> This series adds clock provider functionality to the ADF4377 frequency
> synthesizer driver to address user requests for controlling output
> frequencies from userspace.
> 
> While implemented as an IIO driver, the ADF4377 is commonly used as a
> clock source. This patch series enables it to function as either:
> - A traditional IIO device (when #clock-cells is not specified)
> - A clock provider (when #clock-cells is present in device tree)
> 
> The implementation provides standard clock framework integration with
> rate control, enable/disable support, and maintains backward
> compatibility with existing IIO configurations.
Applied to the testing branch of iio.git. I'll rebase on rc1 once available
and then push that out as togreg for linux-next to pick up.

Thanks,

Jonathan

> 
> Antoniu Miclaus (2):
>   dt-bindings: iio: frequency: adf4377: add clk provider
>   iio: frequency: adf4377: add clk provider support
> 
>  .../bindings/iio/frequency/adi,adf4377.yaml   |   8 ++
>  drivers/iio/frequency/adf4377.c               | 122 +++++++++++++++++-
>  2 files changed, 128 insertions(+), 2 deletions(-)
> 


