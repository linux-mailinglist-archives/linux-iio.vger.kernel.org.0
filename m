Return-Path: <linux-iio+bounces-5294-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DA18CF03B
	for <lists+linux-iio@lfdr.de>; Sat, 25 May 2024 18:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D23A71C20CA8
	for <lists+linux-iio@lfdr.de>; Sat, 25 May 2024 16:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA4B8626D;
	Sat, 25 May 2024 16:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tPQhskNU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C133186266;
	Sat, 25 May 2024 16:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716655811; cv=none; b=e5Tfmii/yj2LSmBume2/LHk4q3KaiKh/EumlIgRC036gtH9PBRd90FQSykGHTh/MdcvjqR5P8B3jQiuvGNGMvWHxDZQ2A9ZYJPYF+tVu0+Je1uw8bz8snDhEiYGn+V3OUbRe0e3myy6v+vNwRpd33kQnr+faKEdGnx+8E46hNdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716655811; c=relaxed/simple;
	bh=Po64BNOAPUavZBRJmgyfjlSNPwIFCHAhQsnCckyFKU4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=clL3eteyQKLnhHr5iyGdAamNXnvvU9mnZ3w51j4PssNEtw5n7X00WFfIS8mXDXqeMmpZMyWiLyxVIB5H7gYpCsshAiE/0h4p290kOJSKrRMwn7MZqrumZtNCrLbGo6pse5LVnCOuOwi6jHRRGd4N7jtQJuJGhlqr0CUPZzdyrWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tPQhskNU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6549AC2BD11;
	Sat, 25 May 2024 16:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716655811;
	bh=Po64BNOAPUavZBRJmgyfjlSNPwIFCHAhQsnCckyFKU4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tPQhskNUKJCic0LwAzTxOQ+gLsCvqnMAKxFCkTnQq8HcM2CRaOijTnBxo7fO8blY0
	 jHLpLgPCiygf4KWVkMEoNWhhUBj6Arale/X/bhKb484kjGQi/WklG37Zlv4wbV4W+5
	 olnOF7wA4Q7jUof+mJihF57ZYLcXvaIetyo1SG4w/4sCq5yIx2gU7JjhlkvAD6hnZ8
	 MjMGvHhS3NGfohGawlVEnyC00SZbR9nX2/oripYRtsUpsTjHmd5RKrUp5cWrzmyAia
	 5pDkIghOBb1crqaCdlmCBRoEPLlv8OFKuW7amQDLVomP46pcEbiGH/ZFXFeF6mL5Ck
	 XFODvBENXTqxQ==
Date: Sat, 25 May 2024 17:50:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <trabarni@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Add support for more stk3311 variant
Message-ID: <20240525175000.7a448cf6@jic23-huawei>
In-Reply-To: <20240521-stk3311-v1-0-07a4966b355a@gmail.com>
References: <20240521-stk3311-v1-0-07a4966b355a@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 21 May 2024 17:34:50 +0200
Barnab=C3=A1s Cz=C3=A9m=C3=A1n <trabarni@gmail.com> wrote:

> This patch series remove probe failing when a compatible variant's chip i=
d is not
> defined in the driver like stk3311-a and make chip id additions easier.
> It adds stk3311-a and stk3311-s34 chip ids.
>=20
> I have tested stk3311-a in Xiaomi Redmi S2 (ysl) and Xiaom Redmi 5
> (rosy),
> it has 0x15 as chip id.
>=20
> stk3311-s34 chip id comes from this thread it should be compatible with
> this driver:
> https://lore.kernel.org/linux-iio/20200703194406.110855-1-megous@megous.c=
om/
>=20
> Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <trabarni@gmail.com>
Nice small and well presented series.  Thanks!

Applied to the togreg branch of iio.git.  Note I'll rebase that on rc1 in a=
 day
or two and it will initially just be pushed out a testing for 0-day to
see if it can find anythign we missed.

Thanks,

Jonathan

> ---
> Barnab=C3=A1s Cz=C3=A9m=C3=A1n (3):
>       iio: light: stk3310: relax failure to match id
>       iio: light: stk3310: make chip id check expandable
>       iio: light: stk3310: support more stk3311 variants
>=20
>  drivers/iio/light/stk3310.c | 31 ++++++++++++++++++++++++-------
>  1 file changed, 24 insertions(+), 7 deletions(-)
> ---
> base-commit: 124cfbcd6d185d4f50be02d5f5afe61578916773
> change-id: 20240521-stk3311-2ee6ddafb970
>=20
> Best regards,


