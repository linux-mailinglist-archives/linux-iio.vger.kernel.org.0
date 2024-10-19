Return-Path: <linux-iio+bounces-10794-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 683EB9A4EC6
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 16:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20B7528841A
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 14:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66798149E00;
	Sat, 19 Oct 2024 14:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0SZ7Qoa"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4EA33CE8
	for <linux-iio@vger.kernel.org>; Sat, 19 Oct 2024 14:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729348935; cv=none; b=lBKQ+biWhqDBaALW8YqSVyJ33PBDGOdZctyYiUSX6W+8yJHmoS2pD8pr1G8MKcMjZWeXMOvzRznxoyVm9eB8U6xxQRvRNQjmencl/3UDKSu+pY9m2CW4yzqzKvP7//pmw1vshnP+EJ5ld1eWNotFfj7ycvuA8Ywdnb6D7sWc6qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729348935; c=relaxed/simple;
	bh=HqkndzPiZPI1rnBtxbzIp2pR6ssjmZYwmc+pHSr90J8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=opGpsyUKxIIa5z22Cmx6zFt4xJPXu4BHi9b53ZC464cmxxJBid7iwhJ51/6m9fUcVRwRTYyBh4o6feack+YJBnY8QH4O1b6Ys/UnboeT9+VRng12SND+2lJxnyQZXPWIif5eFRWrfZwVZt2vQC2Kwuy+WwuWxxNno/oq01717Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0SZ7Qoa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0670DC4CEC5;
	Sat, 19 Oct 2024 14:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729348934;
	bh=HqkndzPiZPI1rnBtxbzIp2pR6ssjmZYwmc+pHSr90J8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A0SZ7QoaKOHNFxtWejucwKFmXp7EcfrfqPYMNbyRpADf/q5J6pRFUL4nzl+lBol91
	 E4ZUW6g61yIeYHuVvh8SPa+C/PxWe5tNxJAjTeo0sK9jiW1mVkKeH9YVmh8695DUHQ
	 YFt+uF8w/ASGqsIgmVep7z8PW45kARJGy9Pz+ldrr3nOrFwGh+pjig6jnpPYyvtA4p
	 aFZt75kmwSdt9+qw4IA9HkxQJ87IT1edqH0F7j3d+no/lfKOb7Wo4EuoiRzgne78ww
	 hMzqWq72xUtZNJTe3Hr5btB9cVhB6cNvIxfOrgwD1g2GnW7yFkIGNVgaCumqlp8kat
	 vYq3RpyxzY51w==
Date: Sat, 19 Oct 2024 15:41:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 0/3] iio: addac: ad74413r: minor improvements
Message-ID: <20241019154140.76d3adc5@jic23-huawei>
In-Reply-To: <20241016-dev-ad74413r-minor-improv-v1-0-13c9c769237d@analog.com>
References: <20241016-dev-ad74413r-minor-improv-v1-0-13c9c769237d@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 16 Oct 2024 16:21:58 +0200
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> Minor improvements handling locking, reset gpio and vref voltage. No
> functional changes intended.
>=20
Applied.
> ---
> Nuno Sa (3):
>       iio: addac: ad74413r: drop reset_gpio from struct ad74413r_state
>       iio: addac: ad74413r: use devm_regulator_get_enable_read_voltage()
>       iio: addac: ad74413r: simplify with cleanup.h
>=20
>  drivers/iio/addac/ad74413r.c | 81 ++++++++++++++++----------------------=
------
>  1 file changed, 30 insertions(+), 51 deletions(-)
> ---
> base-commit: c3e9df514041ec6c46be83801b1891392f4522f7
> change-id: 20241016-dev-ad74413r-minor-improv-d8b061d44348
> --
>=20
> Thanks!
> - Nuno S=C3=A1
>=20
>=20


