Return-Path: <linux-iio+bounces-27041-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 02ECCCB7FA2
	for <lists+linux-iio@lfdr.de>; Fri, 12 Dec 2025 06:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF54430542D1
	for <lists+linux-iio@lfdr.de>; Fri, 12 Dec 2025 05:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5EC2C3261;
	Fri, 12 Dec 2025 05:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Uw8M944d"
X-Original-To: linux-iio@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A723C465;
	Fri, 12 Dec 2025 05:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765518837; cv=none; b=hEcV4I83eFLlwSjhYTsPbFu6dKatj3Tf6mdClugvTejKApZuR6/EOlXDSgkVQ7iutM5Tg9aJtvoyWQAc0VBDs8VFBivXcS5dAhPdO+5qD2ff3RJfx/obmElKUVhceLQ19D+zoU4llX2OpRxV1Io70cco9qB6isAub448TCVKHL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765518837; c=relaxed/simple;
	bh=nymakgngEqa2xYkDvgOemL5CEXBpo6nJY1AxWDMssYE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I1dbUTmCKraRQ1D7RTz3+nscMtCAbHjVtvj04mcb98IDmT+EBibxi0hEj51drStuGqib7LVlViFPvm4UaWiiyEe6Zxx+/UQT0nEpsobnujSkIJEcqK3U3/xiFq4ErPYYcfQPVjam8cy5PjJiT14uWAS7OZB5nI9GG8/POCc1psk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Uw8M944d; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1765518832;
	bh=nymakgngEqa2xYkDvgOemL5CEXBpo6nJY1AxWDMssYE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Uw8M944ddkCuo7TKw8vEj0pe9OVwdCUR8ds3VFZPFMoGmmwDDDDAS5gllwdBymtwM
	 rlDGAzgGt52r4DknCy8cSmpnb+STxVnuP+58X3njR8XEUE3LPK8wc55CYRB6ncShPt
	 Q9HW3vTE4rmKy34NEZULugrDyDarw5QL4j5BlqZUJU+1EpGr018H44Wss2dG4RtA5z
	 G0nU4S+rVQ/srzIa5VHUITWlgoDw8+w6nQpRxd33duGKJDOJ6rJApS+PrqshimNe6q
	 hPGK3ovU2t66VXQENfH5OUA8po09EOFJqrDF52BnIjDrfd1EqSGAojvi8IYet+JMx4
	 ThFy1QSuMkcOQ==
Received: from [10.200.3.67] (fs96f9c361.tkyc007.ap.nuro.jp [150.249.195.97])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 16C2664DF1;
	Fri, 12 Dec 2025 13:53:46 +0800 (AWST)
Message-ID: <97f2eee63e1ed908866c10721b9f0a57036723dc.camel@codeconstruct.com.au>
Subject: Re: [PATCH RFC 01/16] dt-bindings: hwmon: Convert
 aspeed,ast2400-pwm-tacho to DT schema
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Linus Walleij
	 <linusw@kernel.org>
Cc: Joel Stanley <joel@jms.id.au>, linux-hwmon@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org,
 linux-mmc@vger.kernel.org, 	linux-crypto@vger.kernel.org,
 linux-iio@vger.kernel.org
Date: Fri, 12 Dec 2025 14:53:42 +0900
In-Reply-To: <f17d93db-f96b-469d-88f0-0878a0fc9fe7@roeck-us.net>
References: 
	<20251211-dev-dt-warnings-all-v1-0-21b18b9ada77@codeconstruct.com.au>
	 <20251211-dev-dt-warnings-all-v1-1-21b18b9ada77@codeconstruct.com.au>
	 <f17d93db-f96b-469d-88f0-0878a0fc9fe7@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-12-11 at 12:27 -0800, Guenter Roeck wrote:
> On 12/11/25 00:45, Andrew Jeffery wrote:
> > From: "Rob Herring (Arm)" <robh@kernel.org>
> >=20
> > Convert the ASpeed fan controller binding to DT schema format.
> >=20
> > The '#cooling-cells' value used is 1 rather than 2. '#size-cells' is 0
> > rather 1.
> >=20
> > Some users define more that 8 fan nodes where 2 fans share a PWM. The
> > driver seems to let the 2nd fan just overwrite the 1st one. That also
> > creates some addressing errors in the DT (duplicate addresses and wrong
> > unit-addresses).
> >=20
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
>=20
> I am not sure I understand what the plan is here. I am assuming it will b=
e
> applied through a non-hwmon branch.
>=20
> Acked-by: Guenter Roeck <linux@roeck-us.net>

Thanks Guenter.

Apologies for confusion there. The series is currently a collection of
miscellaneous binding stuff that I felt needed DT maintainer input, so
I avoided adding driver subsystem maintainers in To/Cc to minimise
noise. Rob's feedback at [1] needs to be addressed - I'll make sure
you're in To: once that's sorted.

Andrew

[1]:
https://lore.kernel.org/all/20251211170333.GA1557987-robh@kernel.org/

