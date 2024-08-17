Return-Path: <linux-iio+bounces-8520-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C729955728
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 12:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C442B21692
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 10:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C76F148826;
	Sat, 17 Aug 2024 10:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6QvYROI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB0913E021;
	Sat, 17 Aug 2024 10:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723889951; cv=none; b=f/PYJn0HOtff3o/SUXuRN8ZfPi/wa3+dt/U86PZK2mIiVNJLkrZEaG64p/hB33AHqALLc8iGLofiDX23jzc9mnOASYNcXAhQyU2U6Zo0srCgzjQswzK5d+r0U/efJH41c1KyG/anSQBTmCT/+Ke5W9mt/iEHhBM15gePsBRBSIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723889951; c=relaxed/simple;
	bh=yq4xPAvlsqC1fAcFJqipBs6Ym77XzFEVD7SQoDh9GjM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J1KgxqxglVUIVqBL3qG5dGTNRPH7OIARFeReWF+f5uSpjj7ytMAt7BaNcsna9xsSnvHp0FqddYwCJfGR1XIDmTC1hqECvzA5UGc5nnzLAf5SF5ATFSlWfXLE2PjfF0vcFJGXHRrRZljEvFD5LLzdMo9Nz+0ZJKXJtZv5PF9S+D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6QvYROI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA73C116B1;
	Sat, 17 Aug 2024 10:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723889950;
	bh=yq4xPAvlsqC1fAcFJqipBs6Ym77XzFEVD7SQoDh9GjM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K6QvYROIwLjuERVEW8MC+T7pJs3aZkgByN3gVidXBUr2iLLah0tyNmgZy+ktcIiN7
	 MZR+aEAW8yZjhDbXvZ1WFEgnjmXmovPQqeiSBQ128CzVMEx4RPBJu45mu8a+u7oo7x
	 evdrrTq6YcGmx+cZPn4H38sNHMXQDmVy7VNJOWG1M3n0Myo1sUHTu6wvtrEnZ2kgEj
	 nXRhCyBO3CcUqqwn3YnEm1wy/zD+2gXr+hXoufyvtu0Sm7ZsN6XemnGVeTA6apnjdH
	 N+CWgi1E3qRJD9imnT53A46l9LNExFXayiOtYcPEC3LxMdf/RER4eMMTNqP/R7bkd5
	 A8z70PSIF2qYQ==
Date: Sat, 17 Aug 2024 11:19:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dumitru Ceclan via B4 Relay
 <devnull+dumitru.ceclan.analog.com@kernel.org>
Cc: dumitru.ceclan@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, mitrutzceclan@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Conor Dooley
 <conor.dooley@microchip.com>, Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH v3 0/3] Add support for AD4113
Message-ID: <20240817111902.2ed6b98a@jic23-huawei>
In-Reply-To: <20240812-ad4113-v3-0-046e785dd253@analog.com>
References: <20240812-ad4113-v3-0-046e785dd253@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 12 Aug 2024 11:13:13 +0300
Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org> =
wrote:

> This patch series adds support for the AD4113 ADC within the existing
> AD7173 driver.
>=20
> The AD4113 is a low power, low noise, 16-bit, =CE=A3-=CE=94 analog-to-dig=
ital
> converter (ADC) that integrates an analog front end (AFE) for four
> fully differential or eight single-ended inputs.
>=20
> The part is not released yet and the documentation is not public.
> Register map is identical to AD4114 besides the lower width data
> register and the GPIO register.
>=20
> Particularities of this model:
> - 16 bit data register
> - no temperature sensor
> - no current inputs
> - input buffers
> - internal reference
> - external reference REF-/REF+
> - no second external reference REF2-/REF2+
> - no AVDD2 supply
> - 2 GPIO pins with config bits starting at a higher position in register
> - 8 VINx inputs with voltage divider
> - 16 channel registers and 8 setup registers
>=20
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
Hi.

Series is fine, but I don't yet have the fix=20
[PATCH] iio: adc: ad7173: Fix incorrect compatible string
in the upstream of my togreg branch.

Hence this will have to wait a little while for that to be present.
Otherwise this will create a fiddly merge for linux-next etc.

Jonathan

> ---
> Changes in v3:
> - lowercase chip ID
> - add patch to correctly order chip IDs defines
> - picked up RB and ACK tags
> - Link to v2: https://lore.kernel.org/r/20240809-ad4113-v2-0-2a70c101a1f4=
@analog.com
>=20
> Changes in v2:
> - correctly set realbits and storagebits to 16 in iio_chan_spec
> - describe bindings restrictions in commit message due to lack of
>   sufficient diff context
> - describe model differences better in cover letter
> - Link to v1: https://lore.kernel.org/r/20240807-ad4113-v1-0-2d338f702c7b=
@analog.com
>=20
> ---
> Dumitru Ceclan (3):
>       dt-bindings: adc: ad7173: add support for ad4113
>       iio: adc: ad7173: order chipID by value
>       iio: adc: ad7173: add support for ad4113
>=20
>  .../devicetree/bindings/iio/adc/adi,ad7173.yaml    |  3 ++
>  drivers/iio/adc/ad7173.c                           | 38 ++++++++++++++++=
++++--
>  2 files changed, 39 insertions(+), 2 deletions(-)
> ---
> base-commit: 1c61e13d7dc9003662bd7fd6064dfea67e64b014
> change-id: 20240725-ad4113-baa63ff99245
>=20
> Best regards,


