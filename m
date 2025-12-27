Return-Path: <linux-iio+bounces-27392-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85747CE0102
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 19:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27FBB30206AB
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 18:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5925F323416;
	Sat, 27 Dec 2025 18:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfOYI5/E"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D77A5464F;
	Sat, 27 Dec 2025 18:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766859499; cv=none; b=Ao8Po2FYg4pTMojV4ZG3r1b4eXsMaDa1HKDVjDoiejFLxi3+HPnmvUlM0QH7mDMA3bKCWw+l+APE541uypeHwNgy7TXpKC89YDwvKOS/5VYLoBpapCh9aSN7Y6hr0AjNECfbNo1RtGuZ6pAipx+xH8doYG7pWL+MMW2UFkKoanQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766859499; c=relaxed/simple;
	bh=z53un9l34kelY0KLvqcgvmsyIvHS3HHvIShjZIeLTPs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s1o2QOblV2xTOKcKYKGb1rgv+k2SZ7OcNCF+TNIfZ4zIClBIlfVslK3o4mZIh5DYsKUerOwEV8WVktBIjihRRgvyb2yxWFcDXUceXAayG/1kRDIiShSjxVWA070sBxj95VFDYNbqb3a1XEQ5O0CLQHT/IESXBz/kDcir3CqDPWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfOYI5/E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6DB7C4CEF1;
	Sat, 27 Dec 2025 18:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766859498;
	bh=z53un9l34kelY0KLvqcgvmsyIvHS3HHvIShjZIeLTPs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nfOYI5/EcmNmyVZ49Ffz9eEMGkH7zVpeMWHeZC8qum3iA7R5lRzM2DMeW7jOsUaxF
	 n87y9gZqb8X7iFR7aw7Kpq/DdFmCDQWOod5MLg8CqMO8ftx6XMHuTHLHZuCkx0D2MT
	 5I7Mck+QD+p/w6OMjP6GgvJh5qmYdBYqloHScXyayR7C8gHoQwh7jXyjYHrCD6KRhd
	 jv/ZGsRlpg/pDoMVmp5aW7k48jks15z5ZgxQStgvRdFSyHU2c+cjXxDrlzQZWTyvNR
	 EGYUL2RDK4yRM8n7EbKdopxaSGjhZ4zw6NhMNIUam4AMAVIQn6/eiGRfzqZr6vJtME
	 iszB4qIjESCLQ==
Date: Sat, 27 Dec 2025 18:18:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Kyle Hsieh <kylehsieh1995@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Beguin <liambeguin@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: ltc2309: add support for ltc2305
Message-ID: <20251227181808.3dbe5b0a@jic23-huawei>
In-Reply-To: <20251224-add_ltc2305_driver-v2-2-061f78cf45a3@gmail.com>
References: <20251224-add_ltc2305_driver-v2-0-061f78cf45a3@gmail.com>
	<20251224-add_ltc2305_driver-v2-2-061f78cf45a3@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Dec 2025 13:37:15 +0800
Kyle Hsieh <kylehsieh1995@gmail.com> wrote:

> Add support for the 2-channel LTC2305 ADC in the existing LTC2309 driver.
> The LTC2305 and LTC2309 share similar features: both are 12-bit,
> low-noise, low-power SAR ADCs with an I2C interface.
> The main difference is the number of channels: LTC2305 has 2 channels,
> while LTC2309 has 8 channels.
> 
> Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
Hi Kyle

This is a fairly small patch, so don't bother doing it this time, but
for future reference, if you are doing a refactor to enable something new
split it into a refactor patch (which makes no operational changes) and
a new stuff patch. Here first of those patches would introduce the chip_info
structure but only for existing supported devices.  That can be reviewed
easily to make sure there are not functional changes.  The second patch then
adds the entries for the new device (which can be checked against the datasheet).

When it is very small, in the interests of expediency we sometimes don't
worry too much about the ideal formation of patches.

In line I mention that the ltc2301 would be very easy to add as well if you
want to do so.  Otherwise looks good to me. I'll leave it on list a little
while though before applying.

> ---
>  drivers/iio/adc/ltc2309.c | 51 ++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 46 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/ltc2309.c b/drivers/iio/adc/ltc2309.c
> index 5f0d947d0615..0cf9bcae36c8 100644
> --- a/drivers/iio/adc/ltc2309.c
> +++ b/drivers/iio/adc/ltc2309.c
> @@ -1,8 +1,10 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> + * The LTC2305 is a  2-Channel, 12-Bit SAR ADC with an I2C Interface.
>   * The LTC2309 is an 8-Channel, 12-Bit SAR ADC with an I2C Interface.
>   *
>   * Datasheet:
> + * https://www.analog.com/media/en/technical-documentation/data-sheets/23015fb.pdf

If you wanted to, it should be trivial to also support the 2301 (I looked given the
odd datasheet file name!)  For families of parts it is common to add support based
on only have access to a small subset.


>   * https://www.analog.com/media/en/technical-documentation/data-sheets/2309fd.pdf

