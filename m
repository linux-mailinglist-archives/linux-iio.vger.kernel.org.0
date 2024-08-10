Return-Path: <linux-iio+bounces-8402-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C532D94DC58
	for <lists+linux-iio@lfdr.de>; Sat, 10 Aug 2024 12:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 763FE1F21CEA
	for <lists+linux-iio@lfdr.de>; Sat, 10 Aug 2024 10:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2E0157467;
	Sat, 10 Aug 2024 10:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SU534EmE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD13A2F2A
	for <linux-iio@vger.kernel.org>; Sat, 10 Aug 2024 10:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723286485; cv=none; b=jySUsH98MVR0kzxtE9dBGyy4U2V5146WH0eudgl7l6RITOLc5GkwNGNjb6JWc+ladq+2fvbJdS0tl+nTGAWLAeNHYVhixReLInySlNvM7TZFJnqTKfWf8mZWJqSaE7SAuJUOfK+U7koq9WLpCaeNo+psCGZD/SaoF7aYBh6wFE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723286485; c=relaxed/simple;
	bh=VgObxcspbFOborTijEeTm+nhk1g5irx9P3dS0xF7WAM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HKyntOTch825HWfDd+sS/2hDJ67Mra/WlXT3k/T7FwrL3K7Wk4Lxm8wNOlyxHVJIsgRuPvpAJ1+Rk/8w8AABC4i5swMhBKWd9NE4Kumu5XJOGQtuDlZ7bvNiO0STwSbrpFqsNj+nZQY4NBJIN6l9XcrjlBWRZhOtlbkP7sryWrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SU534EmE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C0F3C32781;
	Sat, 10 Aug 2024 10:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723286485;
	bh=VgObxcspbFOborTijEeTm+nhk1g5irx9P3dS0xF7WAM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SU534EmEvFV3Qpfuwrllt0S2EzJNCdZgeJKTsYYj3FLYizejiYBgO7qoJFQ4SfvYW
	 CYHRV/o//aN6vmEHqDAgrSMHg/L8xNOmXvOC3Ab0sUIfVeKQ2ltIDh3+zZJiTSvSYs
	 hKZl4l23OLv7NMulD0MyjpAyLbL05iUk3s9ypLh8Pw4h2xM6ldYQ4cLHIB/KbPCula
	 DNru496ESYOMm+LNw9ia4GdUr7eFX7Ue2XejwpQBcWTwWkCfsgPUnAkyLHlj6wTFyh
	 OMIigsvtVuT/TycmourbjeRjvKQQWfyhipjumcKvbtcCDHpu9xwar2CcQjDOxqblIK
	 zV2Kz+IAY6JxA==
Date: Sat, 10 Aug 2024 11:41:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Dragos
 Bogdan <dragos.bogdan@analog.com>
Subject: Re: [PATCH 0/4] iio: imu: drop #ifdef around CONFIG_DEBUG_FS
Message-ID: <20240810114119.15917ccc@jic23-huawei>
In-Reply-To: <20240809-dev-adis-debugfs-improv-v1-0-d3adb6996518@analog.com>
References: <20240809-dev-adis-debugfs-improv-v1-0-d3adb6996518@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 09 Aug 2024 11:17:05 +0200
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> Hi,
>=20
> Small series to make the IMUs debugfs code a bit neater. As mentioned in
> the commit message, let's allow the compiler to drop any unused instead
> of guarding it with #ifdefs.
Applied.
>=20
> ---
> Nuno Sa (4):
>       iio: imu: adis16475: drop ifdef around CONFIG_DEBUG_FS
>       iio: imu: adis16480: drop ifdef around CONFIG_DEBUG_FS
>       iio: imu: adis16400: drop ifdef around CONFIG_DEBUG_FS
>       iio: imu: adis16460: drop ifdef around CONFIG_DEBUG_FS
>=20
>  drivers/iio/imu/adis16400.c | 18 ++++--------------
>  drivers/iio/imu/adis16460.c | 18 ++++--------------
>  drivers/iio/imu/adis16475.c |  9 +++------
>  drivers/iio/imu/adis16480.c | 18 ++++--------------
>  4 files changed, 15 insertions(+), 48 deletions(-)
> ---
> base-commit: 7cad163c39cb642ed587d3eeb37a5637ee02740f
> change-id: 20240809-dev-adis-debugfs-improv-e007579b5262
> --
>=20
> Thanks!
> - Nuno S=C3=A1
>=20
>=20


