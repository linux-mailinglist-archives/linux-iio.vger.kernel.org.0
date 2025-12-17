Return-Path: <linux-iio+bounces-27155-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7B4CC9A75
	for <lists+linux-iio@lfdr.de>; Wed, 17 Dec 2025 23:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 78109303A1F5
	for <lists+linux-iio@lfdr.de>; Wed, 17 Dec 2025 22:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE4230C361;
	Wed, 17 Dec 2025 22:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="fApoOOfA"
X-Original-To: linux-iio@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2806F3A1E8B;
	Wed, 17 Dec 2025 22:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766008861; cv=none; b=kkJ3zMPWh3UnjLGnb3H8xmuoxVVFMHi0Ub+urysIaK311ZRgNFGFS8x8Bcbq8xDv0ecOoD6ehCpPN9ATOKZePoiBXdggy5AxjGvupSoDgqJjBgJqXLeLqwI+DiDuWN7WQKSh03cqKIQv9diJmUFVoP1RX1JQWgDc7RyNyWB9AU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766008861; c=relaxed/simple;
	bh=fzcRsvXylZN9aaLtqwzTReh1wZfElthhV45WDpSLtLM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jyuubBEny0KLgYy4W/5+HMQjYevBiiKPAOzShk01bvRz5rlVAK1qSKjQOkSiGYJX6hLYY4CO6Zcj8VOsVeaYLRfcfEMFYYnDi3ql69GUm8KQitEZy0cMj4SeqxhzKWhvyqiFwYYwwcL4Qw4INVZJuiAr1qh1aT9ZY4JHhMo5xHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=fApoOOfA; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1766008855;
	bh=fzcRsvXylZN9aaLtqwzTReh1wZfElthhV45WDpSLtLM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fApoOOfAOl/WLHh2U99ktvCT0tJMUee5y+YJOw2D6yPmlO3QXfrC4pXyDavNvNOFQ
	 0ZrLl2bX3drG8K46ydoTHG/YL8MJMBt3Pe/eVVR1eqZnijWe1OvGNMSVrM8q7bfXJs
	 brC4+s/JlkwpbSiFhenmsEWkVTI5ibT6QqI+0gUr7p0qDPwDtBCBsWoXwo43xF/+vi
	 lMW7yiKE8BHSKDNwW7TiyML1D20eSbBYZFMhNZ2ZHfluXXf1HbQdQv358qvwkwywKt
	 VaVXXCJC+ozudhxI89GAzXLN1F4yrkcFrCPjXWe8s43Y7u44/mfwV4Ignyu/jXDdJn
	 fUSaF6GA/zSUg==
Received: from [192.168.68.115] (unknown [180.150.112.216])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 5400D7C1B2;
	Thu, 18 Dec 2025 06:00:54 +0800 (AWST)
Message-ID: <d6046a94820cda6bfcc3953d6c737152a9f0cf37.camel@codeconstruct.com.au>
Subject: Re: [PATCH RFC 01/16] dt-bindings: hwmon: Convert
 aspeed,ast2400-pwm-tacho to DT schema
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,  Linus Walleij <linusw@kernel.org>, Joel Stanley
 <joel@jms.id.au>, linux-hwmon@vger.kernel.org, 	devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, 	linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, 	openbmc@lists.ozlabs.org,
 linux-gpio@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-iio@vger.kernel.org
Date: Thu, 18 Dec 2025 08:30:51 +1030
In-Reply-To: <CAL_JsqJUaKKsJ8BCNbVXe4vLVsQ2Av7VuWqf9DnUKHeLzLb8NQ@mail.gmail.com>
References: 
	<20251211-dev-dt-warnings-all-v1-0-21b18b9ada77@codeconstruct.com.au>
	 <20251211-dev-dt-warnings-all-v1-1-21b18b9ada77@codeconstruct.com.au>
	 <CAL_JsqJUaKKsJ8BCNbVXe4vLVsQ2Av7VuWqf9DnUKHeLzLb8NQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-12-17 at 09:37 -0600, Rob Herring wrote:
> On Thu, Dec 11, 2025 at 2:46=E2=80=AFAM Andrew Jeffery
> <andrew@codeconstruct.com.au> wrote:
> >=20
> > From: "Rob Herring (Arm)" <robh@kernel.org>
> >=20
> > Convert the ASpeed fan controller binding to DT schema format.
> >=20
> > The '#cooling-cells' value used is 1 rather than 2. '#size-cells' is 0
> > rather 1.
>=20
> Okay, I can't figure out why I thought '#cooling-cells' needed to be 1
> here. I don't see that anywhere in the tree. The driver for sure only
> supports 2, so anything that's not is an error in any case.

Yeah, I'd started doing some digging to understand your statement about
it needing to be 1 but hadn't got to the bottom of it.

If it can be 2 then great, I can fix up the #size-cells and resend.

Andrew

