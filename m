Return-Path: <linux-iio+bounces-4123-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F00B89AC00
	for <lists+linux-iio@lfdr.de>; Sat,  6 Apr 2024 18:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3CB11F21C10
	for <lists+linux-iio@lfdr.de>; Sat,  6 Apr 2024 16:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09303BBF5;
	Sat,  6 Apr 2024 16:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHGANBPA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEA63FB92;
	Sat,  6 Apr 2024 16:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712420365; cv=none; b=SX1zcxF1TTghClWbooY1qcKecw6FjjW93s+tVNI7MlFidXJQ766QEqgZI8iviqB+QtI41+J7oBPBNCwBIpoGm1fTvW1MUNAgtAuVnhQaj05SaklSYhRXmBU3CeFJSeW+3f5AQ5J7ycf9r8Wcx2CnmzHhHPPPzgm2JhD1HH358Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712420365; c=relaxed/simple;
	bh=hKjZzBjVc1EV183isG7l6YRJCa161WhqgGhK2XOXCD0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ub4drYtSnt8KK8ZO2WyX8eZtUUa2uavxvB8h4rY/hTv6lTmwKWHEoxR+DAdfPsclvVhLKzN+8M5FvL3NJdQkQ7v0CpgG3QtoixhSwnX7Pa4F1NyLTxmwTWBKTrmQRYQnVMOmioKQDU2MWCI8obAT1fMOD/nqt6Nz3iTWdxdwi8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHGANBPA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6038C433F1;
	Sat,  6 Apr 2024 16:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712420365;
	bh=hKjZzBjVc1EV183isG7l6YRJCa161WhqgGhK2XOXCD0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HHGANBPAyYiI03069rYTej43PliFKZaXWW6TKMvO1BrGrKJqa/4bORM8WH8UKGma0
	 u+xLzm5kASNGKrDYObvi3HusL3oqxFzIjf7yIp04/7fK6nK6sFVr5DDIMWRvlSbp+r
	 XetlyvhhlM+rpWRLONaDyvAG3ajjZvx5gwmpTnbfXt5uCDY9yBds4Em9G24Q7QNdGo
	 ike2jGcC2kPGfR1rlUqDbF0TCImG7S/Sm4c6JpxlGAXc5AUwQ7Mgjo7avajBrzozHV
	 qjkPQtoNsQojxRPlYDy5Hcz+KpSDle2tzwjI1Mm29C7YsrtOEbzBcAb765DeM41UFX
	 C+rwzEzgSuxdQ==
Date: Sat, 6 Apr 2024 17:19:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>, Dragos Bogdan
 <dragos.bogdan@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>, "Paul
 Cercueil" <paul@crapouillou.net>, Alexandru Ardelean
 <ardeleanalex@gmail.com>
Subject: Re: [PATCH v2 00/11] iio: dac: support IIO backends on the output
 direction
Message-ID: <20240406171909.4419dccd@jic23-huawei>
In-Reply-To: <20240405-iio-backend-axi-dac-v2-0-293bab7d5552@analog.com>
References: <20240405-iio-backend-axi-dac-v2-0-293bab7d5552@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 5 Apr 2024 16:59:58 +0200
Nuno Sa <nuno.sa@analog.com> wrote:

> Hi Jonathan,
>=20
> Here it goes version 2 of the output backend series. The main points in
> here:
>  - The refactoring the DMA BUF api for setup. I pretty much like how it
>    turned out. Note that Paul's patch ("iio: buffer-dmaengine: Support
>    specifying buffer direction") had to be updated accordingly.
>  - Introduction of the struct iio_info callback for getting the backend.
>    I'm not sure about this one as we have no user for it and we may not
>    have one for sometime. I like how the "default" implementation for
>    getting the backend turned out and it should cover 99% of the cases. It
>    will only fail if the iio parent device is not the same device where we
>    bound the backend.

I've not looked at it yet, but this description makes me think perhaps
that should be ripped out for now?  We can bring it back if we ever need it.

>  - As mentioned above, we now get the backend from the iio device
>    matching the IIO parent device with the device used when getting the
>    backend. This should cover almost all the cases I think. Should be very
>    unlikely to use a different device in devm_iio_backend_get() and
>    devm_iio_device_alloc().
>=20
> For the bindings, I still did not addressed Rob's point about dma-names.
> I did reply [1] but still no feedback.
>=20
> Anyways, full log:
>=20
> v1:
>  * https://lore.kernel.org/all/20240328-iio-backend-axi-dac-v1-0-afc808b3=
fde3@analog.com/
>=20
> v2:
>  * Patch 1:
>   - New patch.
>=20
>  * Patch 4:
>   - Make things consistent with the triggered buffer case.
>=20
>  * Patch 6:
>   - Fixed description as it's an output device;
>   - Avoid duplicating the "bindings" word in the commit title.
> =20
>  * Patch 7:
>   - Renamed vdd_3_3-supply -> vdd-3p3-supply;
>   - Added IRQ and vref properties;
>   - Avoid duplicating the "bindings" word in the commit title.
>=20
>  * Patch 8:
>   - New patch.
>=20
>  * Patch 9:
>   - Fixed some typos in kerneldocs;
>   - Add iio_backend_from_indio_dev_parent(). Default way of getting backe=
nds
>     from IIO devices;
>   - Explicitly differentiate frontends and backends ext_info in
>     iio_backend_extend_chan_spec().
>   - Spell out CW as CONTINUOUS_WAVE;
>   - Add _hz suffix in set_sample_rate().
>=20
>  * Patch 10:
>   - Rephrase comment in axi_dac_set_sample_rate() when DDS is disabled;
>   - Use the new iio_dmaengine_buffer_setup_ext() API;
>   - Passed tone as 0,1 value being 1 second tone.
>=20
>  * Patch 11:
>   - Fixed mixed spaces with tabs in ABI file and dac -> DAC;
>   - Add COMPILE_TEST to kconfig;
>   - Dropped operating mode enum. Use defines;
>   - Add comments for IIO enum operating mode and the value we need to
>     set on the device;
>   - Add spaces around {} in the reg_sequence;
>   - Always use Mu instead of mixture of Mu and MU;
>   - Don't error out if we do not recognize the part id;
>   - Make sure to deal with other errors than TIMEOUT in ad9739a_init().
>=20
> [1]: https://lore.kernel.org/linux-iio/04e2a0569953792673319f7fcab3fe03e6=
670c03.camel@gmail.com/
>=20
> ---
> Nuno Sa (7):
>       iio: buffer-dma: add iio_dmaengine_buffer_setup()
>       dt-bindings: iio: dac: add docs for AXI DAC IP
>       dt-bindings: iio: dac: add docs for AD9739A
>       iio: core: add get_iio_backend() callback
>       iio: backend: add new functionality
>       iio: dac: add support for AXI DAC IP core
>       iio: dac: support the ad9739a RF DAC
>=20
> Paul Cercueil (4):
>       iio: buffer-dma: Rename iio_dma_buffer_data_available()
>       iio: buffer-dma: Enable buffer write support
>       iio: buffer-dmaengine: Support specifying buffer direction
>       iio: buffer-dmaengine: Enable write support
>=20
>  Documentation/ABI/testing/sysfs-bus-iio-ad9739a    |  19 +
>  .../devicetree/bindings/iio/dac/adi,ad9739a.yaml   |  94 +++
>  .../devicetree/bindings/iio/dac/adi,axi-dac.yaml   |  62 ++
>  MAINTAINERS                                        |  17 +
>  drivers/iio/adc/adi-axi-adc.c                      |  16 +-
>  drivers/iio/buffer/industrialio-buffer-dma.c       | 100 +++-
>  drivers/iio/buffer/industrialio-buffer-dmaengine.c |  83 +--
>  drivers/iio/dac/Kconfig                            |  37 ++
>  drivers/iio/dac/Makefile                           |   2 +
>  drivers/iio/dac/ad9739a.c                          | 454 +++++++++++++++
>  drivers/iio/dac/adi-axi-dac.c                      | 635 +++++++++++++++=
++++++
>  drivers/iio/industrialio-backend.c                 | 179 ++++++
>  include/linux/iio/backend.h                        |  49 ++
>  include/linux/iio/buffer-dma.h                     |   4 +-
>  include/linux/iio/buffer-dmaengine.h               |  24 +-
>  include/linux/iio/iio.h                            |   2 +
>  16 files changed, 1698 insertions(+), 79 deletions(-)
> ---
> base-commit: 6020ca4de8e5404b20f15a6d9873cd6eb5f6d8d6
> change-id: 20240405-iio-backend-axi-dac-be99373b036b
> --
>=20
> Thanks!
> - Nuno S=C3=A1
>=20


