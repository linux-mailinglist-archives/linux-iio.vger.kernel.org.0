Return-Path: <linux-iio+bounces-4397-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DB68ABC02
	for <lists+linux-iio@lfdr.de>; Sat, 20 Apr 2024 16:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 363B528185D
	for <lists+linux-iio@lfdr.de>; Sat, 20 Apr 2024 14:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5745E1F176;
	Sat, 20 Apr 2024 14:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAEGC+2e"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EF1205E3A;
	Sat, 20 Apr 2024 14:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713623921; cv=none; b=iFavZT7p+Pbxj83qJueblxDDNjKjLZrb2dOBCPIqgCOAqdkuqK2+y5QAd2sZ4lFPWF5AZDfEJg0ncZO8QHiz6F4Fqv9CPSYNFKPmPaFdI4Vc4eN2LgWEHb4r7yKSty5V6VKT12he8MogB/glxy6tm18DnVfpAtoNjyG7cTNXcjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713623921; c=relaxed/simple;
	bh=VFxkmlqn+RSTBb47AWK4PuSgjK0lMr+BfRnZpJ6K+Ds=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jIdwfvfODwl8PCJcJDmUvGC7GhHxPbwNshQQ9obcStc8nrsTxaEDYe3gLDxhdaZtlqEcfHrNVERxfKAFhS23q5y1pV/lZ/mDshm/Nk2kO2cqnr9dq/ItYuEAZEpXwmdAYwqPHC8wIGGN9y5MEDDkzYebx8GIp4YdU9UFblHTTLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAEGC+2e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E63C072AA;
	Sat, 20 Apr 2024 14:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713623920;
	bh=VFxkmlqn+RSTBb47AWK4PuSgjK0lMr+BfRnZpJ6K+Ds=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SAEGC+2emBGS0n+xW4lx5Bn4zBsBtao9cWxPwlbjajlwxqpmbkz3MWUSqhCgio8ks
	 VdOdtmQyr85FgK7X0UZSqWeItYoWaVSqRrwGoldxvdNvRCvKglR0KUTrSKCUXPlgu1
	 1oX2MAP4Law0tFkpWtV3onFY/tfdi709Xc0T/ZIw2FTO/KQhex9UeEtN7vRanxlz4t
	 vJgFteDQUfGY3uRBmmLNkc2c6DYlIsWPcIe/WXqeN35QhNigmK9DaZgaYIluNyr8z9
	 lVCuiauQVIUu7ivLLRxwewu9KtUBmIi0iobL1+8oGFYQmAwAmY5fjV9kfZZEffPb9u
	 bbmcq5H12T4vw==
Date: Sat, 20 Apr 2024 15:38:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Dragos Bogdan <dragos.bogdan@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>, Paul
 Cercueil <paul@crapouillou.net>, Alexandru Ardelean
 <ardeleanalex@gmail.com>
Subject: Re: [PATCH v4 00/10] iio: dac: support IIO backends on the output
 direction
Message-ID: <20240420153826.1c4242c8@jic23-huawei>
In-Reply-To: <20240419-iio-backend-axi-dac-v4-0-5ca45b4de294@analog.com>
References: <20240419-iio-backend-axi-dac-v4-0-5ca45b4de294@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Apr 2024 10:25:33 +0200
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> Hi Jonathan,
>=20
> Here it goes v4. Added default value for full scale current and
> corrected the minimum value.

Applied to the togreg branch of iio.git and pushed out as testing.
As this only came out as v4 yesterday, I'll keep an eye open for additional
feedback before I push this out as a non rebasing tree
I will still add tags as well if anyone wants to give them as well!

Thanks,

Jonathan

>=20
> Full log:
>=20
> v1:
>  * https://lore.kernel.org/all/20240328-iio-backend-axi-dac-v1-0-afc808b3=
fde3@analog.com
>=20
> v2:
>  * https://lore.kernel.org/all/20240405-iio-backend-axi-dac-v2-0-293bab7d=
5552@analog.com=20
>=20
> v3:
>  * https://lore.kernel.org/r/20240412-iio-backend-axi-dac-v3-0-3e9d4c5201=
fb@analog.com=20
>=20
> v4:
>  * Patch 7:
>    - Added default value for full scale current;
>    - Corrected the minimum value for full scale current.
>  * Patch 10:
>    - Corrected the minimum value for full scale current.=20
>=20
> ---
> Nuno Sa (6):
>       iio: buffer-dma: add iio_dmaengine_buffer_setup()
>       dt-bindings: iio: dac: add docs for AXI DAC IP
>       dt-bindings: iio: dac: add docs for AD9739A
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
>  .../devicetree/bindings/iio/dac/adi,ad9739a.yaml   |  95 +++
>  .../devicetree/bindings/iio/dac/adi,axi-dac.yaml   |  62 ++
>  MAINTAINERS                                        |  17 +
>  drivers/iio/adc/adi-axi-adc.c                      |  16 +-
>  drivers/iio/buffer/industrialio-buffer-dma.c       | 100 +++-
>  drivers/iio/buffer/industrialio-buffer-dmaengine.c |  83 +--
>  drivers/iio/dac/Kconfig                            |  37 ++
>  drivers/iio/dac/Makefile                           |   2 +
>  drivers/iio/dac/ad9739a.c                          | 463 +++++++++++++++
>  drivers/iio/dac/adi-axi-dac.c                      | 635 +++++++++++++++=
++++++
>  drivers/iio/industrialio-backend.c                 | 179 ++++++
>  include/linux/iio/backend.h                        |  49 ++
>  include/linux/iio/buffer-dma.h                     |   4 +-
>  include/linux/iio/buffer-dmaengine.h               |  24 +-
>  15 files changed, 1706 insertions(+), 79 deletions(-)
> ---
> base-commit: aabc0aa90c927a03d509d0b592720d9897894ce4
> change-id: 20240412-iio-backend-axi-dac-b369adca46a0
> --
>=20
> Thanks!
> - Nuno S=C3=A1
>=20
>=20


