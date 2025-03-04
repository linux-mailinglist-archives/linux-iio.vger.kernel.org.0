Return-Path: <linux-iio+bounces-16332-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEA6A4DCD0
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 12:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CC7C7AC099
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 11:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B6E1FFC74;
	Tue,  4 Mar 2025 11:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="1EiI6HaY"
X-Original-To: linux-iio@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124AD1FFC50;
	Tue,  4 Mar 2025 11:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741088527; cv=none; b=BMxmgSJwcmZSEfL+tzvhXXt06+pwO5r+gTvhUyGZCqQjatdNa+XoiB7ND99zslRDB8SH3JPDDLSZYH3narG3aqKkQ4p15vBY65U5JMZHZjovol72hxcSi56t/fJ+WABfnXt2ygKch7LuEZ21uhW4f1cU/3qK4vO2LoPF6GXabiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741088527; c=relaxed/simple;
	bh=uqenW6FxHzjv93IlGq3O4/NtcfxeAquNgX50B3dpRGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FyjupuW5TdH9qJ5JPCLYu5OyZ3vAwVVoBArJAHKMUlPrcEGE9hxpAZEXF1LuYrD1Dux9aNkaAjUuZbxBJzbHRdDs/CaAGJfOvOWW9CT+m3YVAcW9gQfyRgtgx9awrYbR2LZ7DhunwLrM7VLHerVF3B3xkn9F3HPSLVu8oBLPBT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=1EiI6HaY; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LlkC1H6GlfM4Hx4kB9R2XcBn/wEpCBfNZPYyj4bbtvs=; b=1EiI6HaYvFggifFfi7bvm1wBKs
	6jLTW7PCJ7Oi2vW1Zf0AkcO74u/pGgwoED+2iUf225BS+ONodX0g1SV8YxrqrvwKSY8WMt6GozH1P
	Za4o+/iMmwj1Qw0wEj3pBbdIVFk7WC75pXwxpBQKIeCxbOo7uNOEimr07UiHkNUuq8vtnDXZIHZDN
	Pr+YjXaNZplYLFekBRhJMCkqBDIcsBz0Ou9tzeI5JAV3Zp0NwfswqRUul9gGRcVAKdO09RvtvpUQX
	VU6vKqFSwGb4C/efsUkU3OGme/KjRaIgYizLWDGK2QbngJTBqg+e4qWORjjtanbcZYqPjG2+8qE1f
	tsLW+eyQ==;
Received: from i53875a38.versanet.de ([83.135.90.56] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tpQer-0002qO-Nc; Tue, 04 Mar 2025 12:41:57 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonas Karlman <jonas@kwiboo.se>
Cc: Yao Zi <ziyao@disroot.org>, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jonas Karlman <jonas@kwiboo.se>
Subject:
 Re: [PATCH 1/4] dt-bindings: iio: adc: Add rockchip,rk3528-saradc variant
Date: Tue, 04 Mar 2025 12:41:56 +0100
Message-ID: <3748393.44csPzL39Z@diego>
In-Reply-To: <20250227184058.2964204-2-jonas@kwiboo.se>
References:
 <20250227184058.2964204-1-jonas@kwiboo.se>
 <20250227184058.2964204-2-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Am Donnerstag, 27. Februar 2025, 19:40:50 MEZ schrieb Jonas Karlman:
> The Successive Approximation ADC (SARADC) in RK3528 uses the v2
> controller and support:
> - 10-bit resolution
> - Up to 1MS/s sampling rate
> - 4 single-ended input channels
> - Current consumption: 0.5mA @ 1MS/s
> 
> Add a rockchip,rk3562-saradc compatible string for the 4 channels of
> 10-bit resolution supported by SARADC in RK3528.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



