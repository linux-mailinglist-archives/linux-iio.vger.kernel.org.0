Return-Path: <linux-iio+bounces-3887-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 318228903EB
	for <lists+linux-iio@lfdr.de>; Thu, 28 Mar 2024 16:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30550B21A07
	for <lists+linux-iio@lfdr.de>; Thu, 28 Mar 2024 15:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8305112F5A4;
	Thu, 28 Mar 2024 15:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Alh1k5Le"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4149EFC11;
	Thu, 28 Mar 2024 15:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711641287; cv=none; b=YhqwRPtEdTqf1/3Bu5lY84OR4iZ3d8s3Q850oAjSxCQSdCbcdTHvUnZSOwfgZxFjRS9TLeWR1EE9GJ0I6H8AcFuGi0pejlZdcWQcaEUpFeuTl4yWIKJuwrS7J7raEexA23nDoXhlQVkpfLKGrpgIon78f+/xC0ATcbncQdbvqhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711641287; c=relaxed/simple;
	bh=0Ip6Yql/K2NvP/eZeQvhfJEuMRg5fxViNOWR9VYL7Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qmP1KhGKEGGZuBIrmoVUowLk4572upB0MvW9s7msxJIeQvx6SjUC/56ZlsZVewTzgIvofPtmWObGeStmvoZPPA/BTjwKd92kHL+p58Hk1ICu4/p/c0ilZI9qeC0UBglEti84V63gr+5J87VR40L3qgU0toF9IdgoFXqppqLXFmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Alh1k5Le; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88420C433F1;
	Thu, 28 Mar 2024 15:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711641286;
	bh=0Ip6Yql/K2NvP/eZeQvhfJEuMRg5fxViNOWR9VYL7Cg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Alh1k5LeE+XO95Jb6CAzZkOKIuHKtStI5JaAmZRH2+j/Ci8gKN7BoHexYuX8e94Fa
	 QMEPl08RViEXaX6itqDiKW7c3+Mkz/8lsaCSXiPVLN2dRNa622SUsIYpkqhqsuGs3k
	 rRWNHuch4hRXyIZ2Zllg6ALa7xKm6LswJjsqU4QD9iuQA9jnLjMkP7Haq5YkTvF/Yq
	 kf4ZgFPqPE5HmFd2mS9Lb/PhtcFFtZwnwWC0abW2Yd77vCUi/mXP9DKDepP6HCiw7s
	 nM18sQjePQqzZnrfcZfLnf4fa+0zXP4NcS1edEsZaGMmkmp6dNfj9/9kcbcBX//JKU
	 bal6JmiVvqJiw==
Date: Thu, 28 Mar 2024 15:54:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Nuno Sa via B4 Relay  <devnull+nuno.sa.analog.com@kernel.org>,
 nuno.sa@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 Dragos Bogdan <dragos.bogdan@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>
Subject: Re: [PATCH 01/10] iio: buffer: add helper for setting direction
Message-ID: <20240328155431.55c1f435@jic23-huawei>
In-Reply-To: <d30c43f7f9d2db5b9c0e779d99f029da1a751636.camel@gmail.com>
References: <20240328-iio-backend-axi-dac-v1-0-afc808b3fde3@analog.com>
	<20240328-iio-backend-axi-dac-v1-1-afc808b3fde3@analog.com>
	<20240328143652.068492d0@jic23-huawei>
	<d30c43f7f9d2db5b9c0e779d99f029da1a751636.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 28 Mar 2024 16:18:04 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Thu, 2024-03-28 at 14:36 +0000, Jonathan Cameron wrote:
> > On Thu, 28 Mar 2024 14:22:25 +0100
> > Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
> >  =20
> > > From: Nuno Sa <nuno.sa@analog.com>
> > >=20
> > > Simple helper for setting the buffer direction when it's allocated us=
ing
> > > iio_dmaengine_buffer_alloc().
> > >=20
> > > Signed-off-by: Nuno Sa <nuno.sa@analog.com> =20
> > I wonder if we should align with the approach for triggered-buffers wit=
h and _ext
> > form of the registration function that takes a direction.=C2=A0 It seem=
s odd to allocate
> > one then change the direction.
> >  =20
>=20
> I agree it feels odd but I did not wanted to include buffer_impl.h in pla=
ces that
> should not have it :)
>=20
> This patchseries adds the direction to devm_iio_dmaengine_buffer_setup().=
 Maybe what
> we need is to have a non devm variant iio_dmaengine_buffer_setup() and tu=
rn
> iio_dmaengine_buffer_alloc() static again. Maybe that would make things a=
 bit more
> consistent.=C2=A0In fact looking closer into that file, I would get rid o=
f:
>=20
> devm_iio_dmaengine_buffer_alloc() and __devm_iio_dmaengine_buffer_free()=
=C2=A0
>=20
> and have:
>=20
> devm_iio_dmaengine_buffer_setup() and iio_dmaengine_buffer_setup() that m=
ake use of
> iio_dmaengine_buffer_free() and iio_dmaengine_buffer_alloc().=20
>=20
> I think it would make more sense like the above. Thoughts?

Sounds reasonable to me

Jonathan

>=20
> - Nuno S=C3=A1
>=20


