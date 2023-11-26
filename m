Return-Path: <linux-iio+bounces-398-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7661D7F9415
	for <lists+linux-iio@lfdr.de>; Sun, 26 Nov 2023 17:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27BB6280F55
	for <lists+linux-iio@lfdr.de>; Sun, 26 Nov 2023 16:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C735D2F9;
	Sun, 26 Nov 2023 16:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZp3YvSo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17355CA72
	for <linux-iio@vger.kernel.org>; Sun, 26 Nov 2023 16:45:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C50C433C8;
	Sun, 26 Nov 2023 16:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701017119;
	bh=KgPzN+Jynd6WFhH48kIrB5sYJ7ttUnUMYb5szlSwP1o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SZp3YvSopFhoZVniNSP48lpXmVx+wFEFSl+x2aun2MIq+Vz/c2HbIVlpyylhPjoLx
	 kvPv3OQTtr0hRfmeTHAG4OakKDTZGNAYxuy82InWeyrrI92LtUdOnZwKZduMpMmZb5
	 waGsgvm80tirPqlIg5lVZyJ0bJsIsbacH++NUwVv0EJYXNPdMdWbohUOXyBz5ahREN
	 U5+9HZ3pmngMnVsRJwa6AAKajUB3roK+x2FrrBmu7PcfIWHvgQbbe+5IO4dROfUErc
	 0D9EXc/L9Gq0BOQaQydDGZqqy54mci4VbB+utssCJ2cGilydZiQ0BIVbBOKExILyfp
	 D1sO2MLtWc00g==
Date: Sun, 26 Nov 2023 16:45:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc: <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, kernel test robot
 <lkp@intel.com>, Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH] iio: imu: adis16475: use bit numbers in assign_bit()
Message-ID: <20231126164511.1ad5c10c@jic23-huawei>
In-Reply-To: <20231106150730.945-1-nuno.sa@analog.com>
References: <20231106150730.945-1-nuno.sa@analog.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 6 Nov 2023 16:07:30 +0100
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> From: Nuno Sa <nuno.sa@analog.com>
>=20
> assign_bit() expects a bit number and not a mask like BIT(x). Hence,
> just remove the BIT() macro from the #defines.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Closes: https://lore.kernel.org/r/202311060647.i9XyO4ej-lkp@intel.com/
> Fixes: fff7352bf7a3ce ("iio: imu: Add support for adis16475")
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/adis16475.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
> index b7cbe1565aee0..eb7c74be030e2 100644
> --- a/drivers/iio/imu/adis16475.c
> +++ b/drivers/iio/imu/adis16475.c
> @@ -70,8 +70,8 @@
>  #define ADIS16475_MAX_SCAN_DATA		20
>  /* spi max speed in brust mode */
>  #define ADIS16475_BURST_MAX_SPEED	1000000
> -#define ADIS16475_LSB_DEC_MASK		BIT(0)
> -#define ADIS16475_LSB_FIR_MASK		BIT(1)
> +#define ADIS16475_LSB_DEC_MASK		0
> +#define ADIS16475_LSB_FIR_MASK		1
>  #define ADIS16500_BURST_DATA_SEL_0_CHN_MASK	GENMASK(5, 0)
>  #define ADIS16500_BURST_DATA_SEL_1_CHN_MASK	GENMASK(12, 7)
> =20


