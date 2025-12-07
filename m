Return-Path: <linux-iio+bounces-26873-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CBECAB517
	for <lists+linux-iio@lfdr.de>; Sun, 07 Dec 2025 14:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A0763056C7C
	for <lists+linux-iio@lfdr.de>; Sun,  7 Dec 2025 13:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFB429B795;
	Sun,  7 Dec 2025 13:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ao4WAa4E"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F3B21FF2E;
	Sun,  7 Dec 2025 13:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765112848; cv=none; b=UBlr+EqRNBpTo+SOqlZlpA/DHTqOByy7MC9MJrglejJB/LAmxT6f3amWbXJdnJu/2alut1rhx6+naSgBaljdfNvS94TXXZUmiplHq8Mk00/mzUi0YFqXAQq5ghChU0SKnOiRS7z2inXgxjqZKZmeTmG20DqhEndnQym1xlzy67c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765112848; c=relaxed/simple;
	bh=FT5NsmMzWNC/GHAkRWOoCeQPcqizQ3gwHXTCa15ttGs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rpR9ChJm1mJ//m2/2nhDdcgWjJXjlqFig/hx2gwXbdLEf1apIDKMJbj6z2teUZcfcOnwTWD5hADSwtW1e0DZtkV9xi5mIK2I9j+zEMXPYccZArq/lbDPOcIAvkiyPUswBEO+i08VtcOh1JQRcCtfBRnyyoxJ6UjeEqMt6A2CpzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ao4WAa4E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9716FC4CEFB;
	Sun,  7 Dec 2025 13:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765112848;
	bh=FT5NsmMzWNC/GHAkRWOoCeQPcqizQ3gwHXTCa15ttGs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ao4WAa4EAjZ0/SgLKocqkLd1hnO+IBJqJJPYXgEEn6sp7mBtsW7G+29F4kVQ19U8i
	 Txgft33u0ikvkDVeOjf0FJZbl1eRvjuELF20VtTck4zcyPSM02I56f8drY2WHPerOJ
	 D4UwFKh0uQJLZrs+V5b1oyJU+s6tk30MrF6zVFhz87d7MK1LW9mzSkEVCrsdlO5Ob/
	 NkQwNb8Z33ZKrXlZnCFU97K9kiAMRJRYvKrOST8N/KUvmn/gk+BgpAomFZ1OPzjo/z
	 1ir446ozZC1H9ffduu63V1W3lkIjpqx7zIFjYlQop3JKGcBZe4xrbybsFTwHhsgHZE
	 oOufyY0rw6bPQ==
Date: Sun, 7 Dec 2025 13:07:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Tomas Melin <tomas.melin@vaisala.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Alexandru
 Ardelean <alexandru.ardelean@analog.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v3 1/2] iio: adc: ad9467: fix ad9434 vref mask
Message-ID: <20251207130714.62310009@jic23-huawei>
In-Reply-To: <20251203-ad9434-fixes-v3-1-38d14f28456f@vaisala.com>
References: <20251203-ad9434-fixes-v3-0-38d14f28456f@vaisala.com>
	<20251203-ad9434-fixes-v3-1-38d14f28456f@vaisala.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 03 Dec 2025 09:28:11 +0000
Tomas Melin <tomas.melin@vaisala.com> wrote:

> The mask setting is 5 bits wide for the ad9434
> (ref. data sheet register 0x18 FLEX_VREF). Apparently the settings
> from ad9265 were copied by mistake when support for the device was added
> to the driver.
>=20
> Fixes: 4606d0f4b05f ("iio: adc: ad9467: add support for AD9434 high-speed=
 ADC")
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad9467.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> index f7a9f46ea0dc405e25f312197df4b2131871b4bc..2d8f8da3671dac61994a1864a=
82cdbef7f54c1af 100644
> --- a/drivers/iio/adc/ad9467.c
> +++ b/drivers/iio/adc/ad9467.c
> @@ -95,7 +95,7 @@
> =20
>  #define CHIPID_AD9434			0x6A
>  #define AD9434_DEF_OUTPUT_MODE		0x00
> -#define AD9434_REG_VREF_MASK		0xC0
> +#define AD9434_REG_VREF_MASK		GENMASK(4, 0)
> =20
>  /*
>   * Analog Devices AD9467 16-Bit, 200/250 MSPS ADC
>=20


