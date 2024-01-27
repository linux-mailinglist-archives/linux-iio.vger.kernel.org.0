Return-Path: <linux-iio+bounces-1950-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CD683EE1E
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jan 2024 16:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45B2F1F225C4
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jan 2024 15:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F18A28E31;
	Sat, 27 Jan 2024 15:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KaRR1lNb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFE3200D4
	for <linux-iio@vger.kernel.org>; Sat, 27 Jan 2024 15:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706371029; cv=none; b=FsR3osHu8N+VexDXQwsbgf/9xzvmCqPGzVlFjDAnVPpG8IUrVdC4LqyqjY2okGfvspWJTswAJmMgkJMeCVnHqoHlT2o8WanrX4rOtDlEu6sCSpieVOPySmO7zszlcl/E3ZKM6a5B7IyrYCdXXunlLEDm+MOdB4fCrRtujx9jzFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706371029; c=relaxed/simple;
	bh=vOyF8001JXzpv+7Phzp56KKuYEX/PMw16aCM4ubVl8o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C+zNksEji3s/FPjPU//kMWocDVHP2/p8P77FJF2SGHZZWAekHlV0e7ujMUTGnj9PM3jdRYNry66mXto5uF6kFLR9lQrbAzHhMBfSdIkch64um1QTV1eV2xpavre+QYfSPP3/nfBFW4EVAzLH6Vj+2KEQflIem/6YZjc1Zu+h0FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KaRR1lNb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C7C1C433F1;
	Sat, 27 Jan 2024 15:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706371028;
	bh=vOyF8001JXzpv+7Phzp56KKuYEX/PMw16aCM4ubVl8o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KaRR1lNbM5eP2+mEi9Pn488hLJg6Zus/9XFE+Ey+sw8StEU7YSRXLZtmazlLJ/Me0
	 L1m+WQioADtQSxa7ffhuqLiWr6P8O1REqWJDBN2gFnCjwusEw5tfFQ9kFz0kuwh1u2
	 SgFchqj4sEbhLz6JmEm2MvA2KEFk4NuOzuQoRbpAcaxti/j3hfwA3eZzwKB1c4ZVzW
	 1GaUIhZQuSDrEqCb4TzUZ7jZQcndlJcbPKjsU2m0n6b4KD8CntsPffpuk/KKzQ0iRk
	 rwLTtW55Hl6eV3IIFMFhXCN1g9iulxgCkSESVCFc5n5PxYEYoKmFw52KEkzki9e+RW
	 rleppUoiwpelA==
Date: Sat, 27 Jan 2024 15:56:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: <nuno.sa@analog.com>, linux-iio@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>, Denis Ciocca <denis.ciocca@st.com>
Subject: Re: [PATCH] iio: commom: st_sensors: ensure proper DMA alignment
Message-ID: <20240127155655.6495b465@jic23-huawei>
In-Reply-To: <20240122-dev_dma_safety_stm-v1-1-3a021614cbfb@analog.com>
References: <20240122-dev_dma_safety_stm-v1-1-3a021614cbfb@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Jan 2024 15:15:41 +0100
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno Sa <nuno.sa@analog.com>
>=20
> Aligning the buffer to the L1 cache is not sufficient in some platforms
> as they might have larger cacheline sizes for caches after L1 and thus,
> we can't guarantee DMA safety.
>=20
> That was the whole reason to introduce IIO_DMA_MINALIGN in [1]. Do the sa=
me
> for st_sensors common buffer.
>=20
> [1]: https://lore.kernel.org/linux-iio/20220508175712.647246-2-jic23@kern=
el.org/
>=20
> Fixes: e031d5f558f1 ("iio:st_sensors: remove buffer allocation at each bu=
ffer enable")
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  include/linux/iio/common/st_sensors.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/co=
mmon/st_sensors.h
> index 607c3a89a647..a02652cf4862 100644
> --- a/include/linux/iio/common/st_sensors.h
> +++ b/include/linux/iio/common/st_sensors.h
> @@ -258,7 +258,7 @@ struct st_sensor_data {
>  	bool hw_irq_trigger;
>  	s64 hw_timestamp;
> =20
> -	char buffer_data[ST_SENSORS_MAX_BUFFER_SIZE] ____cacheline_aligned;
> +	char buffer_data[ST_SENSORS_MAX_BUFFER_SIZE] __aligned(IIO_DMA_MINALIGN=
);
> =20
>  	struct mutex odr_lock;
Hi Nuno.

This is another problem.  There should be nothing after a DMA safe buffer e=
mbedded
in a structure like we do here.  We rely on C structure padding to ensure t=
he
rest of the __aligned(IIO_DMA_MINALIGN) region is unused and that doesn't w=
ork
if the buffer isn't the last element.

My guess is we are safe to just reorder this before the buffer.
Nuno, do you mind spinning a v2 that does that as well as the size change.

Jonathan

>  };
>=20
> ---
> base-commit: f9c0358aadcba16d04d139a5412b413eeee87afe
> change-id: 20240122-dev_dma_safety_stm-c7016673f4ec
> --
>=20
> Thanks!
> - Nuno S=C3=A1
>=20


