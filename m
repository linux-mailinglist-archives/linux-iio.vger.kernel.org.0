Return-Path: <linux-iio+bounces-6787-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8D2913F98
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 02:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5419AB21672
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 00:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6681138E;
	Mon, 24 Jun 2024 00:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="ikWtRn7y"
X-Original-To: linux-iio@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C1A1361;
	Mon, 24 Jun 2024 00:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719189493; cv=none; b=DPI6SJrde9ckXWl+oCnhWy6RI5Y222/hUAsyBiVVQ1uVL6AF8dNRi4HgflsK+matW7U8IvlK65gMD6Q4MYE9i8pk/kTC5SUQfMnmIHxTVdcFUB2v/YV42LTsKdWsZ6GjdEjavG8gHbc468ZkVTJLLzHJJIWUemdS2KLY9yIARgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719189493; c=relaxed/simple;
	bh=DKEYpgz0d3KtkghyncW6fFCgulDpzB03f6swFpdnWE8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YhFpPb7K+FMpO0p39GQ1vl38CGZKgc3O0ymEUO2H/GQfq6rMDBl7lOixwsEJW8yJg/FMbiOuYYc3alkYngCfZa8fSvatPquc2uI5A5WZVlgf42jtlLM+f17xMje8RhN6lYE+IE52W4HRD2jA+eff6Dvqa7RzaBW4sat+3hJ7sTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=ikWtRn7y; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp118-210-79-194.adl-adc-lon-bras32.tpg.internode.on.net [118.210.79.194])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 5D51E2009F;
	Mon, 24 Jun 2024 08:28:18 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1719188905;
	bh=DKEYpgz0d3KtkghyncW6fFCgulDpzB03f6swFpdnWE8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ikWtRn7yN7Ise0vcKddcWtskvinN6xOYIvvgomBM0u3faQxCrY2BhN/6QG9cQYymI
	 Alg6XDXdF2cal8IZz2T3NcoiHNf1jq3vV1eVaC1NPkmOm9MiFlD3FUqHrVKnIW+4rR
	 tt/OZguADkA/5xfiWttYJ0l7RdJUTW0Zn4iyEFUoVwfEz3Zgi6f4xmaWoXv+lvkosu
	 rz69u2eveZL7rzRWySQh9cW3dHe2Srdfv4eOslqM2tuMZ8dCX1i/Zh87NvBxgPLchk
	 B1V0Gs9X5DvSkmbXBkaNMBlUTlOQtxETkNCbGsqMrTpUXEUFUJ6pgGyTZ0/TsNLdNc
	 WAT3bpeO9l2Jw==
Message-ID: <b522733009008a22dd8975a92ad6d0b1c038c452.camel@codeconstruct.com.au>
Subject: Re: [PATCH 01/10] iio: adc: aspeed_adc: use
 devm_regulator_get_enable_read_voltage()
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>
Cc: Joel Stanley <joel@jms.id.au>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, Andreas Klinger <ak@it-klinger.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>,  linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,  linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Date: Mon, 24 Jun 2024 09:58:17 +0930
In-Reply-To: <20240621-iio-regulator-refactor-round-2-v1-1-49e50cd0b99a@baylibre.com>
References: 
	<20240621-iio-regulator-refactor-round-2-v1-0-49e50cd0b99a@baylibre.com>
	 <20240621-iio-regulator-refactor-round-2-v1-1-49e50cd0b99a@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-06-21 at 17:11 -0500, David Lechner wrote:
> This makes use of the devm_regulator_get_enable_read_voltage() helper
> function to simplify the code.
>=20
> The error return is moved closer to the function call to make it easier
> to follow the logic. And a few blank lines are added for readability.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Nice cleanup!

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>


