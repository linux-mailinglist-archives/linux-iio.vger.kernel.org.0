Return-Path: <linux-iio+bounces-27042-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C623ACB7FC6
	for <lists+linux-iio@lfdr.de>; Fri, 12 Dec 2025 06:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFCFC304F666
	for <lists+linux-iio@lfdr.de>; Fri, 12 Dec 2025 05:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5C230E0EB;
	Fri, 12 Dec 2025 05:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="J3PD6WTS"
X-Original-To: linux-iio@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E7A13D503;
	Fri, 12 Dec 2025 05:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765519033; cv=none; b=r8td+y/Kcj1acYJ141RlOBmKQnWwgWEzUcj0Mv0Ks2qsT9PjAokUm+EK06a43fAWFpdbRetK5xnvoQ2+tAZcMIXrDncQWvup908ZHulrgoJ1DNItpXE9/lEKcLBbUIllhBaV4uXC+XnTXsc8aEtGC1Hi4Stt+6i0aSz0HYNUouQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765519033; c=relaxed/simple;
	bh=k3pW4njVf1DUpv0AFx57ijZPSUyXI5jespOKEgn3hvY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rM5I50wbZHY/F653Wp5QsuZEtwWaCIE7iw/5Zoqt6DRWTCLQWefGfM3JWRfLMRfFVK3OoZf4GGCyX8nAZJ+WQ61DLzAu71DhULNU9HgL+Ph8ryI7RWLQhI4vxxo18XE6CIafddsK5GygulGsUDelyMiiMscy7L2D1ZKozjnClPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=J3PD6WTS; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1765519027;
	bh=k3pW4njVf1DUpv0AFx57ijZPSUyXI5jespOKEgn3hvY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=J3PD6WTSf8ekEK5MjBN+upm8g4s4rxm4k5z12zKFqA3ek+bxXzUyS4c8MaMHvGQs0
	 G7DZqoCiA/YiML1XqCti6IxKmPt6L9akwKyHcdyzAGc1Ckfx4So0mSxZA8A9YSXF1r
	 aaCwi6OEDqZaMMEqZ/gaJ33dlBWwqctViCtVIvZnhGXJprkwX6HBbt+rIjxDHfSqYf
	 vxzaBexN5e+/qOhGZpeCU5BBosCif4uiy9AtK8ol5IToyDQb9LqIpjzriOnGpUeomn
	 9VorrpZqA3guKZtNmyXxFRFVnidHO+H91NjRfVkHTcHJlxM+h73KXkc00k8mmTdqQT
	 5zkLVYbcg/ZEw==
Received: from [10.200.3.67] (fs96f9c361.tkyc007.ap.nuro.jp [150.249.195.97])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 2935264DF1;
	Fri, 12 Dec 2025 13:57:02 +0800 (AWST)
Message-ID: <b31b9876a981f782ea9481402a4c9041cfef748a.camel@codeconstruct.com.au>
Subject: Re: [PATCH RFC 16/16] dt-bindings: mfd: Document smp-memram node
 for AST2600 SCU
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: openbmc@lists.ozlabs.org, linux-crypto@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, Joel Stanley <joel@jms.id.au>, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-mmc@vger.kernel.org,
 linux-aspeed@lists.ozlabs.org, 	devicetree@vger.kernel.org, Linus Walleij
 <linusw@kernel.org>, Conor Dooley	 <conor+dt@kernel.org>
Date: Fri, 12 Dec 2025 14:57:01 +0900
In-Reply-To: <176546866713.1487167.4918701456595372928.robh@kernel.org>
References: 
	<20251211-dev-dt-warnings-all-v1-0-21b18b9ada77@codeconstruct.com.au>
	 <20251211-dev-dt-warnings-all-v1-16-21b18b9ada77@codeconstruct.com.au>
	 <176546866713.1487167.4918701456595372928.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-12-11 at 09:57 -0600, Rob Herring (Arm) wrote:
>=20
> On Thu, 11 Dec 2025 17:45:58 +0900, Andrew Jeffery wrote:
> > The platform initialisation code for the AST2600 implements the custom
> > SMP bringup protocol, and searches for the relevant compatible. As a
> > consequence, define the requisite node and the compatible string, which
> > in-turn tidies up the dtb check results.
> >=20
> > Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> > ---
> > =C2=A0.../devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml=C2=A0=C2=A0=
=C2=A0 | 18 ++++++++++++++++++
> > =C2=A01 file changed, 18 insertions(+)
> >=20
>=20
> My bot found errors running 'make dt_binding_check' on your patch:
>=20
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml:140:16: [=
error] string value is redundantly quoted with any quotes (quoted-strings)

Bah, didn't update dt-validate prior to testing the series. Done so now
and have fixed the issue.

Andrew

