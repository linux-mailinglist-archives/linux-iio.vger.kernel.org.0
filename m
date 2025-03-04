Return-Path: <linux-iio+bounces-16357-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F20A4E22E
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 16:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5805A17F36E
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 14:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8D225F96D;
	Tue,  4 Mar 2025 14:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AB0oO2uJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9109A25EFB7;
	Tue,  4 Mar 2025 14:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100001; cv=none; b=ACEgQgvZCqSw/AzDR99oJ6Ynoo7XaYdc1Uo7Lthgv9pEZzbX4csfQvpkMUNRIOeAyN5a3HwYiUlEoUyW3gKgICe6yehAh6+wy0f+qcjs3vzU6aWv2IXG26ZFQ5x4p5UjgG2vd3gW+tsMFjBEAXeXipDfqBSAKP97uL0HoP/l2dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100001; c=relaxed/simple;
	bh=Kcz1xSaYCO4WuUEozjJ51lTHWmOYaqQOEgsl0gD/6wA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CvMoc34790RQZuES53d9stK/CsPnX8CGZIsSHhJx4+bmd1vpwdbgpQCUgq6K4/vFQmITlmAeTLxkfDTlTu5X2EQBh3LXlZysrzlkzgZ4cVeguWqQ6xkt8TFNk2oDbgfJIfC4GlB2vP5WLbQBHhlGfbEiYUtiZREFAjDZIHr86eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AB0oO2uJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09142C4CEE7;
	Tue,  4 Mar 2025 14:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741100001;
	bh=Kcz1xSaYCO4WuUEozjJ51lTHWmOYaqQOEgsl0gD/6wA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AB0oO2uJ3Vj3LGVge6poAMubhQJr66E5Y4sg0ZWqrI+Ln30Icx4nQTgkzb37RJrgD
	 m1OAcM+4DMWfea6uA+YSJn1WxXytVcDGnaCLeOeI3/k6iy7opu7AOkBu10dXQJtWBp
	 vLFDJm6clTO4pQhxmXnnHcotvqVqcdA1IMC4wxLGBX/CyVKjZd3+oRWWICDmTj3GB6
	 vzb1bVYJncX3Yvn9fWzhm2iw6y7dR8gxJLUzoc1hnw2PXLH1beLfVfyegB3EBnAurR
	 9xw5EKaFhj02Mpf0lE1QLUraiHvOP1I8xfoNGMq44hAsBznOuP5Vf1T2XLaldAG2YF
	 Yc9jkBTMxdbzA==
Date: Tue, 4 Mar 2025 14:53:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Esteban Blanc 
 <eblanc@baylibre.com>, Michael Hennerich <michael.hennerich@analog.com>,
 Nuno =?UTF-8?B?U8Oh?=	 <nuno.sa@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] iio: adc: ad4030: fix error pointer dereference in
 probe()
Message-ID: <20250304145309.066aeaae@jic23-huawei>
In-Reply-To: <3c9bfa8bd08d835e0151fb66fce443457e2f2a98.camel@gmail.com>
References: <cc67cee7-9c65-46d2-aae3-f860fc3cc461@stanley.mountain>
	<3c9bfa8bd08d835e0151fb66fce443457e2f2a98.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 28 Feb 2025 13:22:37 +0000
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Fri, 2025-02-28 at 12:35 +0300, Dan Carpenter wrote:
> > The intention here was obviously to return an error if devm_regmap_init=
()
> > fails, but the return statement was accidentally left out.=C2=A0 This l=
eads to
> > an error pointer dereference when we call:
> >=20
> > 	ret =3D ad4030_detect_chip_info(st);
> >=20
> > Add the return statement.
> >=20
> > Fixes: ec25cf6f1ee3 ("iio: adc: ad4030: add support for ad4632-16 and a=
d4632-
> > 24")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > --- =20
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied.

