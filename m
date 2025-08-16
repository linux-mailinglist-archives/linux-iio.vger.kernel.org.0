Return-Path: <linux-iio+bounces-22804-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE95CB28D9F
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 14:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 582FE1BC8999
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 12:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAB32D0C74;
	Sat, 16 Aug 2025 12:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMk0RpmS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3036F2C0F81;
	Sat, 16 Aug 2025 12:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755346959; cv=none; b=ktxM2UDhi3I+Vi2kTKUgl6WTPkZZdEuqTy9VJo28JvDQGChKmfH5n93Tf7OEKonj0WTKeV5lti7d+h2URckd2rqs0x6OJe/tNmhT2UeQBb1kHO1B2ZcWTlfbAYcBSTm6rgwoznH/7Od5pX3pTOEJNohG191Xsa1Hg8uipyQBX9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755346959; c=relaxed/simple;
	bh=vAtVNWIGht3Uq/xI95E4p6Nn6cD8BdQvgNswdlPeAeM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E5heZls0xxTUnjTz+7dYsdDBMl7Fjeph2VUihrVjBZ/RxACOag22F0aTpzUuFDrpvsXLksgbx/cEXZ6LmIU1Rqd+unM7SrQGdfnXc6WufaMqkFKQHHkvi9fw6M/MPid77Ztmf2HRVKrUfExP43OdZFwD91hGNMdSPlFErb4jyZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMk0RpmS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9CDC4CEEF;
	Sat, 16 Aug 2025 12:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755346956;
	bh=vAtVNWIGht3Uq/xI95E4p6Nn6cD8BdQvgNswdlPeAeM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iMk0RpmSvXelHX3acnouIxrjJs6QVRmSOD6KvE31Bkv8f+cW4xvq6klHL8Dma8ge1
	 wCnvfVzjB7mUTZBWFJsAL17HtIaufvsUFtrnEi/A+greRqOOH/EvMVZLPzr6KZYwLP
	 J/Fd2YbX8Pahz8iqBFu2ivuiYVWTGwl+ceBNboFjAkMQlfsHVp7PXo2UwyndzGih0k
	 EOXYyaA8yWoz8yIBDYAG264WnXZCXfckXJX0E3G+LIHHsteXCxor0eceQvKKrEsdRQ
	 XrMGxO4P4GhX3nmEytdr9oukZjr8lpO8PTPA0YEjayHzDGyatVueED5BhtZB5BDHON
	 SHXwrawxhpVhg==
Date: Sat, 16 Aug 2025 13:22:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/11] Support ROHM BD79105 ADC
Message-ID: <20250816132226.08e70314@jic23-huawei>
In-Reply-To: <cover.1754901948.git.mazziesaccount@gmail.com>
References: <cover.1754901948.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Aug 2025 11:50:00 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Add support for the ROHM BD79105 ADC
> (and do some minor simplifications to the ad7476 driver while at it).
> 
> The first 2 patches were originally sent as an RFC:
> https://lore.kernel.org/all/cover.1754041258.git.mazziesaccount@gmail.com/

Hi Matti

Applied to the togreg branch of iio.git. I'll initially push out as testing
though to get some build coverage before there is any chance of making
a mess of linux nex.t

Thanks

Jonathan

> 
> Revision history:
>   v3 => v4:
>    - Add patch:
>      8/11 "dt-bindings: iio: adc: ad7476: Drop redundant prop: true"
>    - Drop redundant true -branches also from the bd79105 binding
>    - Other patches unchanged.
> 
>   v2 => v3:
>    - Drop 5/10 "Limit the scope of the chip_info"
>    - Add 5/10 "use *_cansleep GPIO APIs"
>    - Multiple fixes as suggested during v2 review. More accurate
>      changelog included in individual patches
> 
>   v1 => v2:
>    - Two new patches:
>      5/10 "Limit the scope of the chip_info" and
>      6/10 "Drop convstart chan_spec"
>      Please, let me know if you think some of the changes should be
>      squashed.
>    - Multiple fixes as suggested during v1 review. More accurate
>      changelog included in individual patches
> 
>   Simplification RFC => ROHM BD79105 support series v1:
>    - Use spi_get_device_match_data()
>    - Fix uV to mV conversion
>    - Rewording of commit message
>    - Added patches 3 to 8.
> 
> Matti Vaittinen (11):
>   iio: adc: ad7476: Simplify chip type detection
>   iio: adc: ad7476: Simplify scale handling
>   iio: adc: ad7476: Use mV for internal reference
>   iio: adc: ad7476: Use correct channel for bit info
>   iio: adc: ad7476: use *_cansleep GPIO APIs
>   iio: adc: ad7476: Drop convstart chan_spec
>   iio: adc: ad7476: Conditionally call convstart
>   dt-bindings: iio: adc: ad7476: Drop redundant prop: true
>   dt-bindings: iio: adc: ad7476: Add ROHM bd79105
>   iio: adc: ad7476: Support ROHM BD79105
>   MAINTAINERS: A driver for simple 1-channel SPI ADCs
> 
>  .../bindings/iio/adc/adi,ad7476.yaml          | 100 +++-
>  MAINTAINERS                                   |   5 +
>  drivers/iio/adc/ad7476.c                      | 461 +++++++++---------
>  3 files changed, 311 insertions(+), 255 deletions(-)
> 
> 
> base-commit: 93ef68672bb353838cdf8314be8765c05768916b


