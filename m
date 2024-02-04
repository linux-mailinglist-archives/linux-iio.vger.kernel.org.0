Return-Path: <linux-iio+bounces-2150-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E967848EC5
	for <lists+linux-iio@lfdr.de>; Sun,  4 Feb 2024 16:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C09CF1C21ECC
	for <lists+linux-iio@lfdr.de>; Sun,  4 Feb 2024 15:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C3B22339;
	Sun,  4 Feb 2024 15:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ui6jVwem"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654B2224E3
	for <linux-iio@vger.kernel.org>; Sun,  4 Feb 2024 15:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707058907; cv=none; b=hJk8OXZRvBX3QG+eroJyR5bnRamcAGvGhS/+2fDzXIzaQzxM98QQA73IhiDdUbgKmZe5+pkEAiNXzNIJqYku/lwpsIMRI0yrcEU45jdL6sId6q+EOCNlTrX/CaPHbBcJDzIsW1ii1+Sq1vy/6FfcbM1/Gas9NL6b23oWeMhao5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707058907; c=relaxed/simple;
	bh=7qDRAB4TxkhmFoDiMqTZe8sj5t7wp99Y3ANS/rTKXCc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FlVfJlErY+/ENreHrLnnQ6psRkKURpoPntkShq4NJYUbxoryrDVrvLpQXB4oQ63ZltugdagIM66DtH3FdAsiuby29I7KJJgaXkwIXcJCxx2WBjBEXlTAE/1NwFvqR6Ku7WLtNfpoeN5y6JgnRkS1uCSWwPZOoxehLLTYrX7R1+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ui6jVwem; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87929C433F1;
	Sun,  4 Feb 2024 15:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707058906;
	bh=7qDRAB4TxkhmFoDiMqTZe8sj5t7wp99Y3ANS/rTKXCc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ui6jVwem/K8GJtYdSkBEowfk7SZIcctknbGeWEuEuVU0goBi/clG0/fGGCRhEoiX+
	 ge3xoJZ/cdjzGkrV8dpIeVTV07ZAyp8Sf9GPoms/yUFHTx54zn0YNzhH9/CRtVa8ql
	 FEK1EE9Ncn7xglAjn7yeP1a7SY61jRt2hmjWlOqA+WqupzAJ0Npm1+fOjqtsHs74lu
	 irljVRwOaTSZKdjxAcDYOTw5k3wwT8LcOv7Dre8eC5s8rRxjux9iZJyXy/x1rXhoBP
	 6amey76ykgZIlGiTi44fvmnl4j6L9uckaKxjr48AOCxKwr2NWqtk/s1x1ZU8AKQbZo
	 oVZukjT1QahuQ==
Date: Sun, 4 Feb 2024 15:01:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Denis
 Ciocca <denis.ciocca@st.com>
Subject: Re: [PATCH v2] iio: commom: st_sensors: ensure proper DMA alignment
Message-ID: <20240204150135.0fa5a808@jic23-huawei>
In-Reply-To: <20240131-dev_dma_safety_stm-v2-1-580c07fae51b@analog.com>
References: <20240131-dev_dma_safety_stm-v2-1-580c07fae51b@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 31 Jan 2024 10:16:47 +0100
Nuno Sa <nuno.sa@analog.com> wrote:

> Aligning the buffer to the L1 cache is not sufficient in some platforms
> as they might have larger cacheline sizes for caches after L1 and thus,
> we can't guarantee DMA safety.
>=20
> That was the whole reason to introduce IIO_DMA_MINALIGN in [1]. Do the sa=
me
> for st_sensors common buffer.
>=20
> While at it, moved the odr_lock before buffer_data as we definitely
> don't want any other data to share a cacheline with the buffer.
>=20
> [1]: https://lore.kernel.org/linux-iio/20220508175712.647246-2-jic23@kern=
el.org/
>=20
> Fixes: e031d5f558f1 ("iio:st_sensors: remove buffer allocation at each bu=
ffer enable")
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Applied to the fixes-togreg branch of iio.git and marked for stable. Thanks!

Jonathan

> ---
> Changes in v2:
>  * moved struct odr_lock before buffer_data.
> ---
>  include/linux/iio/common/st_sensors.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/co=
mmon/st_sensors.h
> index 607c3a89a647..f9ae5cdd884f 100644
> --- a/include/linux/iio/common/st_sensors.h
> +++ b/include/linux/iio/common/st_sensors.h
> @@ -258,9 +258,9 @@ struct st_sensor_data {
>  	bool hw_irq_trigger;
>  	s64 hw_timestamp;
> =20
> -	char buffer_data[ST_SENSORS_MAX_BUFFER_SIZE] ____cacheline_aligned;
> -
>  	struct mutex odr_lock;
> +
> +	char buffer_data[ST_SENSORS_MAX_BUFFER_SIZE] __aligned(IIO_DMA_MINALIGN=
);
>  };
> =20
>  #ifdef CONFIG_IIO_BUFFER
>=20
> ---
> base-commit: 1380d453434e276355458e712c743dd071ca1fa7
> change-id: 20240131-dev_dma_safety_stm-7c09782d87ed
> --
>=20
> Thanks!
> - Nuno S=C3=A1
>=20


