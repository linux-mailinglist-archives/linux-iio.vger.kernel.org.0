Return-Path: <linux-iio+bounces-27313-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AFCCD5DD1
	for <lists+linux-iio@lfdr.de>; Mon, 22 Dec 2025 12:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2B66C3012FBA
	for <lists+linux-iio@lfdr.de>; Mon, 22 Dec 2025 11:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3EF32E72F;
	Mon, 22 Dec 2025 11:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="vARL6LrT"
X-Original-To: linux-iio@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9636032E6A6;
	Mon, 22 Dec 2025 11:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766404244; cv=none; b=cWmChwtZ2lgC/04kYZZ+ZEVXyBvnNzjv0+KACSG2C34+FAX4O72aM16MfqrIax0iwrnRXlRphen+z33suHdUwsDzAE7s6pBg9CNMK1VMhcGB+VCcG+1VRyqjWC8scA8pEi3opQ6f6znkes/kthw5JIn0m78W3Vp4o+PxeJQ71cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766404244; c=relaxed/simple;
	bh=0aXanO5uHbe1WJbJ5I4bx1Yk50Kg+tCs8blk4kQHzFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F54NcAnOBeBiMc2Hhb/Mx5NVAoxqDMJfdwLf5gkdUYpCOgmcq0GimnvYPHSX9cLKnbaNHkX392UX6FBgd/607WIwkccYld7Qn5HoKnfFF0W3o3O0109DZA5YwrTd8HKcqQK/lBUyS2+Mq9rDFX2qj8e3yZDF+Ya4zfxOl0ItE4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=vARL6LrT; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=ruyy63GwboUn7+9s5l67HuCdYOrz3XONvrYdWrJbZr8=; b=vARL6LrT+8uqJV8RIB88I7spsT
	VcvqJXHZ2ESVBUXH8pmBDr6rSZIyusgktlb9xTjaFrNyB/hP0IW8zYhI19KcMG8Ehy65OagQl2NpD
	TvOU/srFlHluBlH5fGPr9Q5HTM6c0cwQoTMUXlnRNLZwLLZbv5gR7+7pFsbX1gH7H4D0EDey8RiC+
	G4KGL3ST5Evr8aKquQSLsW7cZKzGnoZJc418sSO+RcGMthBaCf76o8PLPjSP49so+VUv53GzEFn64
	jlSn2FLqebJcj1lyUNi7AmfUI1VaA9OeuWjOUgqhJfIOWnKlBB974EL1TCGYkXx+5mU3oT4QIiMD/
	MYPy1VZw==;
Received: from [194.95.143.137] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vXeQT-0004nF-5v; Mon, 22 Dec 2025 12:50:09 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-rockchip@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH 3/3] iio: adc: rockchip: Simplify probe() with local 'dev'
Date: Mon, 22 Dec 2025 12:50:07 +0100
Message-ID: <5782401.ejJDZkT8p0@phil>
In-Reply-To: <20251221142602.47368-6-krzysztof.kozlowski@oss.qualcomm.com>
References:
 <20251221142602.47368-4-krzysztof.kozlowski@oss.qualcomm.com>
 <20251221142602.47368-6-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Sonntag, 21. Dezember 2025, 15:26:05 Mitteleurop=C3=A4ische Normalzeit s=
chrieb Krzysztof Kozlowski:
> Simplify the probe function by using a local 'dev' variable instead of
> full pointer dereference.  This makes several lines shorter, which
> allows to avoid wrapping making code more readable.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Yep, makes the code definitly nicer to read

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



