Return-Path: <linux-iio+bounces-19344-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1004BAB038F
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 21:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62BEC7B884D
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 19:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CD628A1C6;
	Thu,  8 May 2025 19:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vju7ThVE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE771F582E;
	Thu,  8 May 2025 19:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746732131; cv=none; b=jO2O304zTNgZPw2IVmJFk4t/hVo05uPda08UTrsxXtrQzAksVMAZR2OwQ8oEpAh6GkVZ4ym8utrGPlBvowKw6Ll4BeAN0P0jk4pgBtoi5wjXZr1p1vGRcdegRtBE5s9/OnZfdHOixCpxL9vOUw+6LajPLGepz1LHInAV1xsrp8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746732131; c=relaxed/simple;
	bh=N1PvpPKKjiE9dsDeMLAuNXlfejJHhvaBiTWzwJovZ6g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mnv74FReiS3cD/KRc5UOA2hhxKJ1NF2Ye83KtK7txH+bc5T2zI5TMhy17eKoFVl8xC18HFKOXDw/AtQROCmtzFTFZckWlS7e5yfNrtvwhUkurZ0QmlZH4F3Qh2QwZ+/Z+W433/hKDWbC2BIsrJwJEtPK2gKvmfyzerfWAq43ybk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vju7ThVE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FBD7C4CEE7;
	Thu,  8 May 2025 19:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746732129;
	bh=N1PvpPKKjiE9dsDeMLAuNXlfejJHhvaBiTWzwJovZ6g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Vju7ThVE6AlkYIkaDiYZddKroyNomDCe62CpzqPCBtCUcCcOHzjqB3mtElD/p/fQv
	 l7TWXKEku+yoqSaO39nWt7h7cnNxRGd2nQPWQU1RWlHhnuTBAKWA8vsa9L6KPZ31Ud
	 ZqYQVbpZou+N1ShCCVaegm4nun0sRJEHih6NaueSa0jNWzq0va4hrXcjKSagauljd8
	 A0YRNWhjaclosxwhIUgkXt6X0lUWne0AUH2AzY7O9I6nkcvK/aC4sx3G3MECDofsk0
	 qRzgaUfM7Kzr1E2f4mg9Dz/zU/PaSI57unMYXPFOBA9naUbWbQw7iZ0R2hm/EPThw1
	 ohtC+yu/HPFvg==
Date: Thu, 8 May 2025 20:22:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ahelenia =?UTF-8?B?WmllbWlhxYRza2E=?=
 <nabijaczleweli@nabijaczleweli.xyz>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: ssp_sensors: optimalize -> optimize
Message-ID: <20250508202202.38c19704@jic23-huawei>
In-Reply-To: <5a64aa3034c6127d7587de9b7045a12892c01ee5.1746558529.git.nabijaczleweli@nabijaczleweli.xyz>
References: <f6e465fee5a824a67be1ae7c3bc1b72adcf9471f.1746558529.git.nabijaczleweli@nabijaczleweli.xyz>
	<5a64aa3034c6127d7587de9b7045a12892c01ee5.1746558529.git.nabijaczleweli@nabijaczleweli.xyz>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 6 May 2025 21:10:02 +0200
Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz> wrote:

> Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xy=
z>
> ---
>  drivers/iio/common/ssp_sensors/ssp_spi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/common/ssp_sensors/ssp_spi.c b/drivers/iio/commo=
n/ssp_sensors/ssp_spi.c
> index f32b04b63ea1..b7f093d7345b 100644
> --- a/drivers/iio/common/ssp_sensors/ssp_spi.c
> +++ b/drivers/iio/common/ssp_sensors/ssp_spi.c
> @@ -104,7 +104,7 @@ static struct ssp_msg *ssp_create_msg(u8 cmd, u16 len=
, u16 opt, u32 data)
>  /*
>   * It is a bit heavy to do it this way but often the function is used to=
 compose
>   * the message from smaller chunks which are placed on the stack.  Often=
 the
> - * chunks are small so memcpy should be optimalized.
> + * chunks are small so memcpy should be optimized.
>   */
>  static inline void ssp_fill_buffer(struct ssp_msg *m, unsigned int offse=
t,
>  				   const void *src, unsigned int len)

Applied.

