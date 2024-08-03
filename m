Return-Path: <linux-iio+bounces-8197-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6223D9469E3
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 15:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14AFB1F21381
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 13:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A54513A261;
	Sat,  3 Aug 2024 13:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0KryLqW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC111ABEA7
	for <linux-iio@vger.kernel.org>; Sat,  3 Aug 2024 13:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722692361; cv=none; b=SdJAfW1CdyYd3UT9EtnZheKmNcxTgfjAt/9PAV3OB0NRRxwSB9qZnSj6755SVj13YlckEAq2MvAzpEkarTVD0crB9FxyqKcMz8qkVquchT/fGpiUxUZ/wfGZHxkytHM1w7DKMJGswL0zxVaZDaxDyEOWWIU2Oaer2bQJuV3WpvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722692361; c=relaxed/simple;
	bh=NHChOokAIiR1I8061hkcQ6h2nOVEPwB1XRnNNn8aG3I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cAyF1l710Y42I4swIA6lpugpeWlw9ookpFVc87LjWyyXH1wEWhVEhBOQ9zj1oFBDy3Irp+paGbFhTpkTV8FsiZOr+P/Q3HQMEq4i4wzj+6kOI0hrcztewVy9agXk96e7ZDCoAQwBooXHa+//j+4POpuLFVuzTaKgtpSPy4hCIfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0KryLqW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99920C116B1;
	Sat,  3 Aug 2024 13:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722692360;
	bh=NHChOokAIiR1I8061hkcQ6h2nOVEPwB1XRnNNn8aG3I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W0KryLqWxWrUzD2g/PBEYDWUZNvd+t8Gwdku66808pZr73JvkN7j9wXtLVD9xw+sr
	 pVcqZQz7yD/ia1EJMHXeXytuDaW2vAsIMsNvlNi9qOWhqg9nRQxWwspIqqGxqXegKf
	 yHo+tF0M3tt9M0y0REmVbeWzenMH2ub8GnQo81ZvgQ7d11FkAuDeqs7Zb8FstJ6SdB
	 d/mKoEtiKvAQ6//RaF9UPvnce1e7BenFpZM9d8v4tquhzxgRoGApVYrpkWt2VxFWr5
	 dmqGiqcoNhVYYkzK9QwUV4WDffPqQ+nEu1VDT0+e6MCv+PRLyKc2WYIoPMdE8N7gtx
	 NaFX2/1C6PBiA==
Date: Sat, 3 Aug 2024 14:39:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>, Dragos Bogdan
 <dragos.bogdan@analog.com>
Subject: Re: [PATCH v2 0/8] iio: adc: ad9467: add debugFS test mode support
Message-ID: <20240803143915.5af127ea@jic23-huawei>
In-Reply-To: <20240802-dev-iio-backend-add-debugfs-v2-0-4cb62852f0d0@analog.com>
References: <20240802-dev-iio-backend-add-debugfs-v2-0-4cb62852f0d0@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 02 Aug 2024 16:26:58 +0200
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> This is the second version of the series. I ended up trying the new
> directory route and think it does look nice and more future proof.
> Biggest change is the first patch where we now pass an info like
> structure to devm_iio_backend_register(). Again, this is likely also a mo=
re
> future proof approach and we would likely need it sooner or later (one
> usage I see is for backends to pass in some constant information that
> could be consumed from frontends when doing backend_get()) =20
>=20
> v1:
>  * https://lore.kernel.org/linux-iio/20240709-dev-iio-backend-add-debugfs=
-v1-0-fb4b8f2373c7@analog.com/
>=20
> v2:
>  * Patch 1:
>   - New patch;
>=20
>  * Patch 2:
>   - Added backendY directory with the direct_reg_access and name
>     attributes;
>   - Get the backend name directly from the backend driver;
>   - Get the backend index from backend-names FW property;
>   - Added debugfs-iio-backend to the ABI docs.=20
Should also have docs for the ad9467 specific debugfs files.

Please add those in a follow up patch.

Applied to the togreg branch of iio.git and pushed out as
testing for all the normal reasons.

Thanks,

Jonathan

>=20
> ---
> Nuno Sa (8):
>       iio: backend: introduce struct iio_backend_info
>       iio: backend: add debugFs interface
>       iio: backend: add a modified prbs23 support
>       iio: adc: adi-axi-adc: support modified prbs23
>       iio: adc: adi-axi-adc: split axi_adc_chan_status()
>       iio: adc: adi-axi-adc: implement backend debugfs interface
>       iio: adc: ad9467: add backend test mode helpers
>       iio: adc: ad9467: add digital interface test to debugfs
>=20
>  Documentation/ABI/testing/debugfs-iio-backend |  20 ++
>  MAINTAINERS                                   |   1 +
>  drivers/iio/adc/ad9467.c                      | 255 ++++++++++++++++++++=
+++---
>  drivers/iio/adc/adi-axi-adc.c                 |  71 ++++++-
>  drivers/iio/dac/adi-axi-dac.c                 |   7 +-
>  drivers/iio/industrialio-backend.c            | 155 +++++++++++++++-
>  include/linux/iio/backend.h                   |  28 ++-
>  7 files changed, 499 insertions(+), 38 deletions(-)
> ---
> base-commit: 168bed989d651794d03638e1f7f7b5a800a6f425
> change-id: 20240802-dev-iio-backend-add-debugfs-0b13bb5a5b37
> --
>=20
> Thanks!
> - Nuno S=C3=A1
>=20
>=20


