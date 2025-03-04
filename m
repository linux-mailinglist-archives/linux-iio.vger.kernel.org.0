Return-Path: <linux-iio+bounces-16333-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3DBA4DD08
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 12:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4641163481
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 11:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4778F204595;
	Tue,  4 Mar 2025 11:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="QPJ6gZNr"
X-Original-To: linux-iio@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3F120408A;
	Tue,  4 Mar 2025 11:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741089117; cv=none; b=sL5uL064m4WS+ASas+LngcT9MHdmYWBr2E0pwuvUrYX3WHbbTWIrcSFYoDasro5Saij08gy8KGMnApwXfv+5iDFCj4WN3NEAtkqi8BIkYYOW4US4Eh/165ho/dBhF+s+dgqfOeZNh+zjaR8QKfVY0qF6Jwfc1yXaJcUgXeW0sQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741089117; c=relaxed/simple;
	bh=ZORSSI8hHMqNTUd769KOEGL22LAhx1YSnCohSo2v8sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kMht4QSQNeuUQYRgxpaVlfG1KoyqfRNxD3JvRJl9NJSiEQe4qDZJgPbCMABo8zOjfqMgT8gacE4K/TbDYFe0eM/DkqOZz9MpZD6VoUD4W+bOMhhmfbXQxaw4yL4JAfe1IdHeYF3mCwS+zh4T52icCl2UkbFYLAoG/05WssIWU8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=QPJ6gZNr; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=A7BcUa5tXuPI+9vyDPPd0uTPj0O1MIEgTcdt4y8X5tU=; b=QPJ6gZNrDg+cxTW7LNvXVCBkBa
	vVVjUmrpV/aKqbXivqMrAWRgJM95syI/HRd9sZvfpQu/kC/1Ip6QQ+esHqoXHeXNSYTUcXyUmmgTZ
	p283gRFz7GFEkUcHG8QO2fHVnWFTkvkZyfhh6s7RojemqbYNuA7oqEBua0v3O2mraeXydfyi/1K7k
	zWk/eFlMzDvZcBbXeTxqu2RpovRA/0JOUPrtm8bTg7lzvVUc68ueOWe9J8NR6K64XYhymSePYXUdW
	6I/ysTA70vUeGAJeTkkWPCR8yrR6YkyTQwTlfD3ro1qKFv/aqwDA0g205iPenC6GoXSxnCRjBQeFQ
	GCCktRBg==;
Received: from i53875a38.versanet.de ([83.135.90.56] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tpQoO-0002uG-3k; Tue, 04 Mar 2025 12:51:48 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Yao Zi <ziyao@disroot.org>,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH 2/4] iio: adc: rockchip_saradc: Add support for RK3528
Date: Tue, 04 Mar 2025 12:51:47 +0100
Message-ID: <11022969.nUPlyArG6x@diego>
In-Reply-To: <20250227184058.2964204-3-jonas@kwiboo.se>
References:
 <20250227184058.2964204-1-jonas@kwiboo.se>
 <20250227184058.2964204-3-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Am Donnerstag, 27. Februar 2025, 19:40:51 MEZ schrieb Jonas Karlman:
> The Successive Approximation ADC (SARADC) in RK3528 uses the v2
> controller and support:
> - 10-bit resolution
> - Up to 1MS/s sampling rate
> - 4 single-ended input channels
> - Current consumption: 0.5mA @ 1MS/s
> 
> Add support for the 4 channels of 10-bit resolution supported by SARADC
> in RK3528.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>




