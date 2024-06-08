Return-Path: <linux-iio+bounces-6071-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 659CF901302
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 19:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5A9E2823B1
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 17:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA5D13FF6;
	Sat,  8 Jun 2024 17:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rytt0HL9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C41F168B8;
	Sat,  8 Jun 2024 17:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717867369; cv=none; b=ji0XYCP0tnxq05QKH4tDYDa2RoyUy8yYSv63cVB2UismHiCMsovU3e39yTcVQL8lE3+ba73Ls1Uss0XN9scRTorYncl0FL6MH4DFHIEEnyJ2eTRkjq+9EIo0hDEE7CU25hFVjWvvA5nn4I1GwH/r6a0nzrr0DGd4GXb3msDoXhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717867369; c=relaxed/simple;
	bh=n9FcOdQmyRPVSwb30UUcTQuU6re91ctYyxj2TcrRaUA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NtF1BsMGx94hXkvO9J89FVGO9PS0+gJZM99OGDLsy+FdR1gJ6bxVFtx186q+HcsqAGi91ryayk3viyEzk6OIHIKwXOygGfDdyYrkAhkmcbq5HPcIxeLJqVk3rrQhMxwWMd9FelMz5eifuFDE8SycX6jcdsrRpvpaJOqyZRe+2fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rytt0HL9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 709B1C2BD11;
	Sat,  8 Jun 2024 17:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717867369;
	bh=n9FcOdQmyRPVSwb30UUcTQuU6re91ctYyxj2TcrRaUA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rytt0HL9O1Fg0TyVehQc/XOutd/VvayrxZx7iBET2X+sQaK3PKb/ydcVjbQZmRUPo
	 9qyvxFHocleE/VcLZaFoCv/AFjAD365hxV8/lCpPAUR/73UpoGgNyezN3srpf7cAYl
	 13gengO2/QQTKocYvQB51gxE/N7FnFr/UIzoxI1g5UAQL6n5zvffou1923+Xo/ZllH
	 3mG43b26A5bvLIqEj+N56jqbueCMKF/R+ulJO9lgwueOUjgnlaaie2E+1b5BQS8lN8
	 5DOfEOMuQUE6X7kAMVFvMDZjpvMaa4Lt5qdwW4AFwo5VoLwGqGIpiQmZWifGSbUm/D
	 wijBcLtG67hjA==
Date: Sat, 8 Jun 2024 18:22:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, Lucas Stankus
 <lucas.p.stankus@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Puranjay Mohan
 <puranjay@kernel.org>, Ramona Bolboaca <ramona.bolboaca@analog.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, Cosmin
 Tanislav <cosmin.tanislav@analog.com>, Marius Cristea
 <marius.cristea@microchip.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] iio: accel: adxl313: simplify with
 spi_get_device_match_data()
Message-ID: <20240608182240.1e3a8153@jic23-huawei>
In-Reply-To: <69e1a5b1-e5ce-4bcc-a0c4-2d02e777c296@linaro.org>
References: <20240606-spi-match-data-v1-0-320b291ee1fe@linaro.org>
	<20240606-spi-match-data-v1-1-320b291ee1fe@linaro.org>
	<7ecabb8e342b9bd4fc2552bce29dc8c7a98971ee.camel@gmail.com>
	<69e1a5b1-e5ce-4bcc-a0c4-2d02e777c296@linaro.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 7 Jun 2024 11:18:54 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 07/06/2024 10:57, Nuno S=C3=A1 wrote:
> > On Thu, 2024-06-06 at 16:26 +0200, Krzysztof Kozlowski wrote: =20
> >> Use spi_get_device_match_data() helper to simplify a bit the driver.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> ---
> >> =C2=A0drivers/iio/accel/adxl313_spi.c | 8 +-------
> >> =C2=A01 file changed, 1 insertion(+), 7 deletions(-)
> >>
> >> diff --git a/drivers/iio/accel/adxl313_spi.c b/drivers/iio/accel/adxl3=
13_spi.c
> >> index b7cc15678a2b..6f8d73f6e5a9 100644
> >> --- a/drivers/iio/accel/adxl313_spi.c
> >> +++ b/drivers/iio/accel/adxl313_spi.c
> >> @@ -72,13 +72,7 @@ static int adxl313_spi_probe(struct spi_device *spi)
> >> =C2=A0	if (ret)
> >> =C2=A0		return ret;
> >> =C2=A0
> >> -	/*
> >> -	 * Retrieves device specific data as a pointer to a
> >> -	 * adxl313_chip_info structure
> >> -	 */
> >> -	chip_data =3D device_get_match_data(&spi->dev);
> >> -	if (!chip_data)
> >> -		chip_data =3D (const struct adxl313_chip_info
> >> *)spi_get_device_id(spi)->driver_data;
> >> +	chip_data =3D spi_get_device_match_data(spi);
> >> =C2=A0 =20
> >=20
> > I understand you're sticking with the original code but since you're do=
ing this,
> > could we maybe add proper error checking for the call? Maybe Jonathan c=
an even
> > tweak that while applying...
> >=20
> > (same comment for patch 3) =20
>=20
> I consider that a separate patch/work, because it would have functional
> impact.

Agreed. Though error checking on these is normally paranoia / readability t=
hing
as we probed from some firmware match and all those entries are present, so
it should just work.


>=20
> Best regards,
> Krzysztof
>=20


