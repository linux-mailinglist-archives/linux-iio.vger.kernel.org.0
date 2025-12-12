Return-Path: <linux-iio+bounces-27059-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 964DFCBA032
	for <lists+linux-iio@lfdr.de>; Sat, 13 Dec 2025 00:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93C71306B503
	for <lists+linux-iio@lfdr.de>; Fri, 12 Dec 2025 23:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABFD3074A9;
	Fri, 12 Dec 2025 23:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="jiFkvtOO"
X-Original-To: linux-iio@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F204D4502A;
	Fri, 12 Dec 2025 23:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765580767; cv=none; b=DUcxMXiCcPavfWSrkQ5h1f2qPvxHsKFVIYrijYvJ+gpFbXMtCS+93d030/bEvLztPLl3fHf69MYo5oCx/CfzaCAHGsTDI8u71sVFuh32iDo6fhX/QLJkuQFzfb4F+2y85A2dnSVhE0N8/tAYbX4ARgiYl2ylTf5eaAQ6WhBBQrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765580767; c=relaxed/simple;
	bh=DQY0w1fKayo2dm/UmdPeUlums+FVDB79JNxL96B2CsY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TyQI3+YRyZkzLQAbGQfgKOqC8PD+LUYhEXGerGD2uwks7Nj8PX0KlZLfpZzL+cEhE8ElvFAMEzo/cGjNKqBIqDenIrCerYiEnIbyW9nuEdVmOmCmKcI+Qz1gMM1VuPWhm39J2UczxeRBScSPzSx1bfHBzYBh0fKjDVdXQqjtsvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=jiFkvtOO; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1765580756;
	bh=x5l4phBTQ5s3tak8rbu73PqDDxyijhO9BxipaFMLBH4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jiFkvtOOi1rI+ninI9Q/X+ONt7F0b8K8Rtwkl/uaSOPD7NAZAPpRNpd7GPDC5TIed
	 ITcpORYrpcHFtU2o2l+Zy1N+h6ZB2JsFmCrExwlHN4bxLny2EC+BBe262gzuKEILVs
	 LF2Mv+hq9Y0LnLOLiBRBlK+6VIX27ZX+ch2SPWSBORcBR4lc0a/w6pmqZSFVq2TRoW
	 2gjww3rFueIk87oOb+83aKxIDBVxL3I/IcpyOx5au3kcJTaXPvpYReuuNqW42GMeVg
	 kRmwx2MntlwLb9dcRj9Ad6S7kznj+oalmwbE/kszNE91aXFQdGvYYBXt49KwsoKpX7
	 j0V4K1M6Te7Cg==
Received: from [172.16.11.106] (fpcf41bac9.tkyc510.ap.nuro.jp [207.65.186.201])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id A6D3C64DF5;
	Sat, 13 Dec 2025 07:05:50 +0800 (AWST)
Message-ID: <35ec28a70d360b2139742e9f04ff77e4a907cd2b.camel@codeconstruct.com.au>
Subject: Re: [PATCH RFC 00/16] Eliminate warnings for AST2500 and AST2600
 EVB devicetrees
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,  Linus Walleij <linusw@kernel.org>, Joel Stanley
 <joel@jms.id.au>, linux-hwmon@vger.kernel.org, 	devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, 	linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, 	openbmc@lists.ozlabs.org,
 linux-gpio@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-iio@vger.kernel.org
Date: Sat, 13 Dec 2025 08:05:43 +0900
In-Reply-To: <20251212150631.GA3997751-robh@kernel.org>
References: 
	<20251211-dev-dt-warnings-all-v1-0-21b18b9ada77@codeconstruct.com.au>
	 <20251212150631.GA3997751-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Rob,

On Fri, 2025-12-12 at 09:06 -0600, Rob Herring wrote:
>=20
> Don't you see warnings for at25:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 89 (atmel,at25): 'size' is a required property
> =C2=A0=C2=A0=C2=A0=C2=A0 89 (atmel,at25): 'pagesize' is a required proper=
ty
> =C2=A0=C2=A0=C2=A0=C2=A0 89 (atmel,at25): 'address-width' is a required p=
roperty
>=20
> These are due to using the deprecated (since 2012) at25,byte-len,=20
> at25,addr-mode, and at25,page-size properties. I think it has been long=
=20
> enough you can just replace them with the new ones.

I don't see them, no. The series targets only the aspeed/aspeed-
ast2{5,6}00-evb.dts files, and neither of them contain at25 nodes. grep
suggests its only IBM platforms:

   > git grep -l at2 ../arch/arm/boot/dts/aspeed/*.dts*
   ../arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
   ../arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dts
   ../arch/arm/boot/dts/aspeed/ibm-power10-dual.dtsi
   ../arch/arm/boot/dts/aspeed/ibm-power10-quad.dtsi
   ../arch/arm/boot/dts/aspeed/ibm-power11-dual.dtsi
   ../arch/arm/boot/dts/aspeed/ibm-power11-quad.dtsi
   >

Once I've got the pieces of this series merged I'll encourage platform
owners to start cleaning up their own devicetrees on the basis that
there are no longer warnings that aren't their problem.

Thanks for your feedback so far!

Andrew

