Return-Path: <linux-iio+bounces-4119-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F2989ABC4
	for <lists+linux-iio@lfdr.de>; Sat,  6 Apr 2024 17:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 829E31F21A06
	for <lists+linux-iio@lfdr.de>; Sat,  6 Apr 2024 15:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE53C3B18D;
	Sat,  6 Apr 2024 15:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/tXOGuK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0D62B9CE;
	Sat,  6 Apr 2024 15:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712418593; cv=none; b=JT0t02qn0XwMsPmPk+aUAWtMtmwAbxZwZdT7w5BGAe5UyEjF8NdCrLNbAzDnM4bQbPkK2Iva9upWEU1O6Tz3PWbCiZqncVOmqijQFmgyKEdCBeH1n4ZV6kk3pL0uuB+CAf/GqjxWqdo2e3Kz1wQDGfantX9pmbt0SA2WyWCqLq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712418593; c=relaxed/simple;
	bh=dt5gIwVJ9TpUm45a85VZLB2+AR9vyst2+0tiJqdgYtw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OTpqP4S54FOB5i2NmfxXIGJS/7yi9SPCERMLH8yF/PR8cJAf8/0lbH9xrwxI3UVjzJzAb9rdGy7fNi1TuDnJe+Z/muGkzoXSIN+sjP4LQ3Num99ZduTsHZpzJf5ESNHlYIntes1dOTCyOiBCxAJLJKNqn8KUtXhB0XIJSvp5x2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/tXOGuK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA903C433C7;
	Sat,  6 Apr 2024 15:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712418593;
	bh=dt5gIwVJ9TpUm45a85VZLB2+AR9vyst2+0tiJqdgYtw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h/tXOGuKTRsqfzGdY1v9r9nmrbowXeBSs+IjGpS9SUYbTTxQMUYeSPobEF2pZShRn
	 GAvTl7+oR9VNSmfrw2i/eC2cJ0GhXIfUsB1tKQ3jW1qaE87yCpOIXhKLglbE569jAi
	 DSRBWfpqgUjzQ937FozITu8o7o4iXFnk0oU+jjK/dp4EYjIt3Bg35dZHxBs4x52SIm
	 EDIU5fGD0uNYqz5RmdhTVirwOGoxCir4JVxa/sH5sPbwrl5rEGA1OzhD7Ip95c3zaO
	 DJK7rr9Mlkcgx9sQTy8G3Sy1ngRGU1+8BIDh0tkV5F50RWHmBCGT+nAge2Us2Pvw40
	 Ds1JZs81PpgaA==
Date: Sat, 6 Apr 2024 16:49:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5 0/2] iio: temperature: ltc2983: small improvements
Message-ID: <20240406164941.4e1bbe69@jic23-huawei>
In-Reply-To: <20240404-ltc2983-misc-improv-v5-0-c1f58057fcea@analog.com>
References: <20240404-ltc2983-misc-improv-v5-0-c1f58057fcea@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 4 Apr 2024 10:58:16 +0200
Nuno Sa <nuno.sa@analog.com> wrote:

> Hi Jonathan,
>=20
> As suggested by you, v5 only has the regulator stuff. I'll send another
> series for the new dev_errp_helper().
Applied.

Thanks,

Jonathan

>=20
> ---
> Changes in v5:
> - Dropped patches 1,2,5 and 6.
> - Link to v4: https://lore.kernel.org/all/20240328-ltc2983-misc-improv-v4=
-0-0cc428c07cd5@analog.com/
>=20
> ---
> Nuno Sa (2):
>       dt-bindings: iio: temperature: ltc2983: document power supply
>       iio: temperature: ltc2983: support vdd regulator
>=20
>  Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml | 4 +=
+++
>  drivers/iio/temperature/ltc2983.c                                  | 5 +=
++++
>  2 files changed, 9 insertions(+)
> ---
> base-commit: 6020ca4de8e5404b20f15a6d9873cd6eb5f6d8d6
> change-id: 20240222-ltc2983-misc-improv-1c7a78ece93f
> --
>=20
> Thanks!
> - Nuno S=C3=A1
>=20


