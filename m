Return-Path: <linux-iio+bounces-27569-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C8656D06B73
	for <lists+linux-iio@lfdr.de>; Fri, 09 Jan 2026 02:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F56D3038381
	for <lists+linux-iio@lfdr.de>; Fri,  9 Jan 2026 01:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BB0223336;
	Fri,  9 Jan 2026 01:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="FBjtDv7p"
X-Original-To: linux-iio@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C0D18A6DB;
	Fri,  9 Jan 2026 01:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767921460; cv=none; b=uXDwWQCaW0RG2RNtNQGnZv2lUWV1bA3ug6U7FZpY6Dv0ZJny51IcmvNVYm0muiS7Twir7QZhOI/jVQMtMglKZ9lMfbJGTVovFU0s+xNsKiLBZroH7CVmXpMWEozF32H9AsBWhC8WgtuS/PPYtyowN/aQcspWBtm+Z4xpzFv2Hjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767921460; c=relaxed/simple;
	bh=LwK/7HWLNZdkoZbc3509z1EnYSgWBHAg3nkDVt2PhWA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JI6lSq8H6SmPq2g86DvOjTaangqmhqUWCJYhGliUTEiSaAoS7BpeJ6vvFpQEzJGN5uZ7TKLA3O9K+73vBnBYZ40KIRnSBkELOP5ucHSpiPxNpBlEezWtHIsqKhwBeAFt9EqskVNrxSkH+SqrG4A15ty/zaALgqobaIuE+/r/G58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=FBjtDv7p; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1767921457;
	bh=LwK/7HWLNZdkoZbc3509z1EnYSgWBHAg3nkDVt2PhWA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FBjtDv7pUlyQuW0vTX7EesZslU0r4uFRyOYi3Pd0Wk1zqc/bokiLlqYR2AXRqdXQk
	 un0pBO2N1yEdS8OFrG7NJALuJBb/q23oequJ5ojCDahrnrnxx/fmtvfgnfgpeq+2Pz
	 qEJlRwU+TSyYDQP5W9AiQXE1h71pfWaL/iiHY0PtblZi1OuGyc351stq1fSiAlWHKA
	 2IiJlURKUoesVvWjY+4dLPSRfNwBOhZBpsYR7kgqWUkClGJFtqpfpiPAJdFrhG2i99
	 uR4bvL5JVJU9D5mkJh8dRa22b3yH+faWEKPL+wFc9MPp8AndVUW0P+zAGOe/ukAKVp
	 gg1TEqZF5zEhw==
Received: from [192.168.68.115] (unknown [180.150.112.60])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 081A87E142;
	Fri,  9 Jan 2026 09:17:36 +0800 (AWST)
Message-ID: <0b94a728bdee2483d0e963bdae69178539ed7721.camel@codeconstruct.com.au>
Subject: Re: [PATCH RFC 03/16] pinctrl: aspeed: g5: Allow use of LPC node
 instead of LPC host controller
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Linus Walleij <linusw@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 linux-hwmon@vger.kernel.org, 	devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, 	linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, 	openbmc@lists.ozlabs.org,
 linux-gpio@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-iio@vger.kernel.org
Date: Fri, 09 Jan 2026 11:47:36 +1030
In-Reply-To: <CAD++jL=TXQyGD5nSdg37KK=OrUJDwi=2pXQciLr+udC9hjCVkw@mail.gmail.com>
References: 
	<20251211-dev-dt-warnings-all-v1-0-21b18b9ada77@codeconstruct.com.au>
	 <20251211-dev-dt-warnings-all-v1-3-21b18b9ada77@codeconstruct.com.au>
	 <CAD++jL=TXQyGD5nSdg37KK=OrUJDwi=2pXQciLr+udC9hjCVkw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-12-31 at 22:38 +0100, Linus Walleij wrote:
> On Thu, Dec 11, 2025 at 9:46=E2=80=AFAM Andrew Jeffery
> <andrew@codeconstruct.com.au> wrote:
>=20
> > There's currently a wart where the Aspeed LPC host controller has no
> > binding specified, but the pinctrl binding depends on referencing its
> > node.
> >=20
> > Allow specification of a phandle to the parent LPC controller instead.
> > Fall back to testing for a compatible parent node if the provided
> > phandle doesn't directly resolve to the LPC controller node.
> >=20
> > Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
>=20
> Reviewed-by: Linus Walleij <linusw@kernel.org>
>=20
> I guess when this is non-RFC I will just apply these two patches.

Yeah, no dramas. I intend to split what remains to be applied into
separate (non-RFC) follow-up series now that many of the changes have
been applied.

Andrew

