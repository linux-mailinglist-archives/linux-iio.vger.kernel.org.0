Return-Path: <linux-iio+bounces-24966-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF0DBD0569
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 17:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9EE81887B38
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 15:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFED2D4B6C;
	Sun, 12 Oct 2025 15:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MaeAustd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E33217A2EC;
	Sun, 12 Oct 2025 15:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760282282; cv=none; b=E0G/PDlSoZ2eagbmNHWFjQQMoPy2LtvBevezNMIsKSJTqljoHH2scQqpze88lSbAmPO5sVLPq2Hn7j8Jl3YUgICiVqMY4cSEMVHu7zj5AkiUYXUkkFi1/WmREMdebNQOiWZ0fqpJ1EbSDN6ZWOSZaSfEiE89D8Wwc3vOpYv3ufI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760282282; c=relaxed/simple;
	bh=Jl8wbestm5JCwGJh7lwNqWSGyJflr3YZZ8ibRMTTmAA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cVZNXPO07Yt+aL4XKwKLlQZek3jtCsTgjuTVdAtqECBzWPlJ4Obznp5+6GIdJvfyRiKGFBN1jsKzm3JZr6AcTX/XCNzgmziXlqNK/k1EoJmBxu4ipmHxcXVhfURC06UuYTTf0NbJqOY/Til/Cam8FtYB+UQpOsQkrNAXreeqTec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MaeAustd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FDC9C4CEE7;
	Sun, 12 Oct 2025 15:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760282279;
	bh=Jl8wbestm5JCwGJh7lwNqWSGyJflr3YZZ8ibRMTTmAA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MaeAustd6R/gg1rhKmyO55MwhT3SPNsbrZLSjQ920VuZkJHP1FI8SAQcyCGne66AV
	 3vDbApjjO9PR8XQR1yQM97SYRFqBqrYn9QhY33Iu6uhTrnkR+gc0X899FULHafZRY8
	 pXe46BUocoE1/BCmNA4hVjBuc0hs2fen/ADvBo1xiju8yj9yJoGBCKZshr9kPmEERE
	 4T22pfjEqruLlhQmihgZPlObG95M0q08KHtsuLLnN3Ri3jBrNAStR4Br+Ser+drQ7E
	 CjHzx6MwE2aT2c1oqsFY+1Q7aUj2yLAXsLvW/s543gUN6o0zKFFmgnk0R88yMmg0wB
	 yql3ryBXWbrbw==
Date: Sun, 12 Oct 2025 16:17:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 14/19] iio: accel: bma220: add i2c module
Message-ID: <20251012161750.1c06b57f@jic23-huawei>
In-Reply-To: <20251005-b4-bma220_improvements-v4-14-0f449ba31585@subdimension.ro>
References: <20251005-b4-bma220_improvements-v4-0-0f449ba31585@subdimension.ro>
	<20251005-b4-bma220_improvements-v4-14-0f449ba31585@subdimension.ro>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 05 Oct 2025 16:12:23 +0300
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Add the bma220_i2c module.
> 
> Note that this kernel module transparently shifts all register addresses
> 1 bit to the left, so all functions will operate based on the SPI memory
> map.
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
Applied. Note that it was only when I reached here I realized I failed
to add the bma220.h when hand applying things earlier.  Anyhow I went
back and fixed that up, but there a few little differences in ordering.
I took the view it was close enough that I didn't go back and do it a 3rd time.
Nothing affects eventual state, just position of the temporary struct spi_device;
forwards declaration I think.

Anyhow, after that this applied cleanly so all good

Thanks,

Jonathan

