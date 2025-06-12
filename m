Return-Path: <linux-iio+bounces-20523-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 393D9AD687E
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 09:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05921189C4E1
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 07:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD031F584C;
	Thu, 12 Jun 2025 07:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RoLeQqKB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02164142E73;
	Thu, 12 Jun 2025 07:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749712117; cv=none; b=f0sGDolObGEppIllilv+VpGGhCExjBo4dJwFxlf6n6CwQUTsrfT8FUK1Ej/AftS3J19XsUqixc7OZxVe0n7G3rIK/pK1v9K76uY4R8fagH/Fn5EWp0OX2j8FDGlVjzhQeadq7JL4g4wM0LQr5uJpTQHfUdtGdIUWXXFaIPRzUKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749712117; c=relaxed/simple;
	bh=b7Pe4DM9eAzA6gWze+y1vzNSKpfWbxNREYiER4q37Ko=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AEPmvj5aauukqssEUFUJhO5QwvJ2y/kbw8M7BNP8iiJ4kU5RLy5pT87310j3QlklJVOpfw4f122eCC+8LoBhVVm0YW/D4YcCiPUscgmndE1sWgbxoZVSFT7YmyQ4+xxXa3qiktmPHln4vleUiqi5DoC65A3pbMRKcUxbpEvVFII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RoLeQqKB; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a365a6804eso341094f8f.3;
        Thu, 12 Jun 2025 00:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749712114; x=1750316914; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b7Pe4DM9eAzA6gWze+y1vzNSKpfWbxNREYiER4q37Ko=;
        b=RoLeQqKBeDN9Go8FyYRde80zCfzkwxUBHHONdlWYqZGHdCLA2GM+bY9Me+r6pkPbGZ
         PgallHfZWSSR3cZI8ISBxVtMB4ZEm/zYBQcsCsTzLdwCeCI7RvlIipienVRUSc5LN3LY
         pyAIgQMCssVd76Mpk9hq+CpPcP/JYtS9krPXmNC8diP7WvY6e/e/4fFiUpRnUdQ4CEQ+
         6AqKZy0hgVvW775M8Dw+fMqHyWgD9w3c1UhZM2n8IX+OoyGFympVA0cnLUFR3wLuE6DZ
         PlsQ5PgS87/IUzNjeGijyiK6b5/myAN8XJfea6jEHMw8V7ZXU51uhSJjoWxRXGmA/+gY
         ryug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749712114; x=1750316914;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b7Pe4DM9eAzA6gWze+y1vzNSKpfWbxNREYiER4q37Ko=;
        b=NIAzJHvu1HXA27w6xEh0BiIsZpRm7aWOjGVDA3Aa2tSJF6YSyrBV/Cx8xVVAQMMdOZ
         9G0TCxtTOnYZe1R+/lPgfEEklC9Mhjb5pNeMEwuuRPegsNDlWhoQNMLeKZQZctT7QCzc
         4MMR5UH7ePOmMe8QzHvpS694k4zTqR2u93D3q+VnCy/6IHwPJObWKLDj3CpJXCEYib2j
         nMm9oS4I2b+6pUtqrDhQQ2lFyvOd/83AxPjnWiLTIRL2O8dxMDHCk1V51dPkL+yelMAr
         YqLt4U6Dk7xb1QJtLWeGUpY+vmrmsSf0yqLQa4hsHEX4rb7g2B0Y+dLx2KUpMVj6vBYg
         z5bg==
X-Forwarded-Encrypted: i=1; AJvYcCWK3y4wpa4qRk6O2kWfaETlb9mUXIzed70aRmygIVMSX0AghxDEO0yElxQzD3QUe3Zm7lZHxALVHN2YHYc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq3dmqIkyxnEvY77rD3GU2zwK3Qi19P4hQi7zDZBUrPfS4xibe
	dWDNZpql0kmNEfPLDCB/OKP4tGppE04UfYysgHJ4CQK6RxLZOv/tNg3K
X-Gm-Gg: ASbGnctQT5lWXgP9FUsYgGb3rCMPUYx8Z1z4/L+DbVIYBWZBQpznqglj8W3S+ydnf5b
	8EPyikLn/DpdDbdZvRJXWccgJxwdjJl5exmA3aB9Zb2Dsv0R78mkkhXzEb6AJR8jqZNGKLH2dZS
	mFd0nQZXwNDY1v648b/gxV6AbVqb9ttayu0clvDLfHaLKgrb5a2nWgqjW8AkJQFJdHFBTz01DFc
	TlqJWDRjR0+UT38AN2NXp6FAWvdWhrQe/JpHO7KK4e86goInWMjKpDBiOTkuQpLSlzpW5RQtaOW
	0/ldXno0PgL0/vFyfv24I7wwrHRlumtnodO2vfUr5sXigA+SOZizB5/toMGBqxI0Ux4DG6XinXq
	j+jqGGqPfEE2uhpkKj5kppW7TgWntZtx5H0GV
X-Google-Smtp-Source: AGHT+IH9n/flMKLj/FWiSLfeeJnfPQDem5Xx/NLRMy+P0OfNN55bI6kHEInXGrhWHgDzIYMLSN833A==
X-Received: by 2002:a05:6000:2087:b0:3a5:52cc:346e with SMTP id ffacd0b85a97d-3a55868917fmr4618896f8f.6.1749712114059;
        Thu, 12 Jun 2025 00:08:34 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a56199b337sm1101091f8f.37.2025.06.12.00.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 00:08:33 -0700 (PDT)
Message-ID: <82d707b22803e2b363a2e0aa0bcf30bc1522f269.camel@gmail.com>
Subject: Re: [PATCH 00/28] iio: zero init stack with { } instead of memset()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Michael Hennerich
 <michael.hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Heiko Stuebner
 <heiko@sntech.de>,  Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Francesco Dolcini
 <francesco@dolcini.it>, =?ISO-8859-1?Q?Jo=E3o?= Paulo
 =?ISO-8859-1?Q?Gon=E7alves?= <jpaulo.silvagoncalves@gmail.com>, Leonard
 =?ISO-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,  kernel@pengutronix.de,
 Oleksij Rempel <o.rempel@pengutronix.de>, Roan van Dijk <roan@protonic.nl>,
 Tomasz Duszynski <tomasz.duszynski@octakon.com>, Jacopo Mondi
 <jacopo@jmondi.org>, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>, Mudit Sharma
 <muditsharma.info@gmail.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>,  =?UTF-8?Q?Ond=C5=99ej?= Jirman
 <megi@xff.cz>, Andreas Klinger <ak@it-klinger.de>, Petre Rodan
 <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com
Date: Thu, 12 Jun 2025 07:09:04 +0100
In-Reply-To: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-0-ebb2d0a24302@baylibre.com>
References: 
	<20250611-iio-zero-init-stack-with-instead-of-memset-v1-0-ebb2d0a24302@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gV2VkLCAyMDI1LTA2LTExIGF0IDE3OjM4IC0wNTAwLCBEYXZpZCBMZWNobmVyIHdyb3RlOgo+
IEpvbmF0aGFuIG1lbnRpb25lZCByZWNlbnRseSB0aGF0IGhlIHdvdWxkIGxpa2UgdG8gZ2V0IGF3
YXkgZnJvbSB1c2luZwo+IG1lbXNldCgpIHRvIHplcm8taW5pdGlhbGl6ZSBzdGFjayBtZW1vcnkg
aW4gdGhlIElJTyBzdWJzeXN0ZW0uIEFuZCB3ZQo+IGhhdmUgaXQgb24gZ29vZCBhdXRob3JpdHkg
dGhhdCBpbml0aWFsaXppbmcgYSBzdHJ1Y3Qgb3IgYXJyYXkgd2l0aCA9IHsgfQo+IGlzIHRoZSBw
cmVmZXJyZWQgd2F5IHRvIGRvIHRoaXMgaW4gdGhlIGtlcm5lbCBbMV0uIFNvIGhlcmUgaXMgYSBz
ZXJpZXMKPiB0byB0YWtlIGNhcmUgb2YgdGhhdC4KPiAKPiBbMV06IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xpbnV4LWlpby8yMDI1MDUwOTA5NDIuNDhFQkYwMUJAa2Vlc2Nvb2svCj4gCj4gLS0t
CgpSZXZpZXdlZC1ieTogTnVubyBTw6EgPG51bm8uc2FAYW5hbG9nLmNvbT4KCj4gRGF2aWQgTGVj
aG5lciAoMjgpOgo+IMKgwqDCoMKgwqAgaWlvOiBhY2NlbDogYWR4bDM3MjogdXNlID0geyB9IGlu
c3RlYWQgb2YgbWVtc2V0KCkKPiDCoMKgwqDCoMKgIGlpbzogYWNjZWw6IG1zYTMxMTogdXNlID0g
eyB9IGluc3RlYWQgb2YgbWVtc2V0KCkKPiDCoMKgwqDCoMKgIGlpbzogYWRjOiBkbG4yLWFkYzog
dXNlID0geyB9IGluc3RlYWQgb2YgbWVtc2V0KCkKPiDCoMKgwqDCoMKgIGlpbzogYWRjOiBtdDYz
NjAtYWRjOiB1c2UgPSB7IH0gaW5zdGVhZCBvZiBtZW1zZXQoKQo+IMKgwqDCoMKgwqAgaWlvOiBh
ZGM6IHJvY2tjaGlwX3NhcmFkYzogdXNlID0geyB9IGluc3RlYWQgb2YgbWVtc2V0KCkKPiDCoMKg
wqDCoMKgIGlpbzogYWRjOiBydHE2MDU2OiB1c2UgPSB7IH0gaW5zdGVhZCBvZiBtZW1zZXQoKQo+
IMKgwqDCoMKgwqAgaWlvOiBhZGM6IHN0bTMyLWFkYzogdXNlID0geyB9IGluc3RlYWQgb2YgbWVt
c2V0KCkKPiDCoMKgwqDCoMKgIGlpbzogYWRjOiB0aS1hZHMxMDE1OiB1c2UgPSB7IH0gaW5zdGVh
ZCBvZiBtZW1zZXQoKQo+IMKgwqDCoMKgwqAgaWlvOiBhZGM6IHRpLWFkczExMTk6IHVzZSA9IHsg
fSBpbnN0ZWFkIG9mIG1lbXNldCgpCj4gwqDCoMKgwqDCoCBpaW86IGFkYzogdGktbG1wOTIwNjQ6
IHVzZSA9IHsgfSBpbnN0ZWFkIG9mIG1lbXNldCgpCj4gwqDCoMKgwqDCoCBpaW86IGFkYzogdGkt
dHNjMjA0NjogdXNlID0geyB9IGluc3RlYWQgb2YgbWVtc2V0KCkKPiDCoMKgwqDCoMKgIGlpbzog
Y2hlbWljYWw6IHNjZDR4OiB1c2UgPSB7IH0gaW5zdGVhZCBvZiBtZW1zZXQoKQo+IMKgwqDCoMKg
wqAgaWlvOiBjaGVtaWNhbDogc2NkMzA6IHVzZSA9IHsgfSBpbnN0ZWFkIG9mIG1lbXNldCgpCj4g
wqDCoMKgwqDCoCBpaW86IGNoZW1pY2FsOiBzdW5yaXNlX2NvMjogdXNlID0geyB9IGluc3RlYWQg
b2YgbWVtc2V0KCkKPiDCoMKgwqDCoMKgIGlpbzogZGFjOiBhZDM1NTJyOiB1c2UgPSB7IH0gaW5z
dGVhZCBvZiBtZW1zZXQoKQo+IMKgwqDCoMKgwqAgaWlvOiBpbXU6IGludl9pY200MjYwMDogdXNl
ID0geyB9IGluc3RlYWQgb2YgbWVtc2V0KCkKPiDCoMKgwqDCoMKgIGlpbzogaW11OiBpbnZfbXB1
NjA1MDogdXNlID0geyB9IGluc3RlYWQgb2YgbWVtc2V0KCkKPiDCoMKgwqDCoMKgIGlpbzogbGln
aHQ6IGJoMTc0NTogdXNlID0geyB9IGluc3RlYWQgb2YgbWVtc2V0KCkKPiDCoMKgwqDCoMKgIGlp
bzogbGlnaHQ6IGx0cjUwMTogdXNlID0geyB9IGluc3RlYWQgb2YgbWVtc2V0KCkKPiDCoMKgwqDC
oMKgIGlpbzogbGlnaHQ6IG9wdDQwNjA6IHVzZSA9IHsgfSBpbnN0ZWFkIG9mIG1lbXNldCgpCj4g
wqDCoMKgwqDCoCBpaW86IGxpZ2h0OiB2ZW1sNjAzMDogdXNlID0geyB9IGluc3RlYWQgb2YgbWVt
c2V0KCkKPiDCoMKgwqDCoMKgIGlpbzogbWFnbmV0b21ldGVyOiBhZjgxMzNqOiB1c2UgPSB7IH0g
aW5zdGVhZCBvZiBtZW1zZXQoKQo+IMKgwqDCoMKgwqAgaWlvOiBwcmVzc3VyZTogYm1wMjgwOiB1
c2UgPSB7IH0gaW5zdGVhZCBvZiBtZW1zZXQoKQo+IMKgwqDCoMKgwqAgaWlvOiBwcmVzc3VyZTog
bXBsMzExNTogdXNlID0geyB9IGluc3RlYWQgb2YgbWVtc2V0KCkKPiDCoMKgwqDCoMKgIGlpbzog
cHJlc3N1cmU6IG1wcmxzMDAyNXBhOiB1c2UgPSB7IH0gaW5zdGVhZCBvZiBtZW1zZXQoKQo+IMKg
wqDCoMKgwqAgaWlvOiBwcmVzc3VyZTogenBhMjMyNjogdXNlID0geyB9IGluc3RlYWQgb2YgbWVt
c2V0KCkKPiDCoMKgwqDCoMKgIGlpbzogcHJveGltaXR5OiBpcnNkMjAwOiB1c2UgPSB7IH0gaW5z
dGVhZCBvZiBtZW1zZXQoKQo+IMKgwqDCoMKgwqAgaWlvOiB0ZW1wZXJhdHVyZTogdG1wMDA2OiB1
c2UgPSB7IH0gaW5zdGVhZCBvZiBtZW1zZXQoKQo+IAo+IMKgZHJpdmVycy9paW8vYWNjZWwvYWR4
bDM3Mi5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAzICst
LQo+IMKgZHJpdmVycy9paW8vYWNjZWwvbXNhMzExLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgNCArLS0tCj4gwqBkcml2ZXJzL2lpby9hZGMvZGxuMi1h
ZGMuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCA0ICst
LS0KPiDCoGRyaXZlcnMvaWlvL2FkYy9tdDYzNjAtYWRjLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAzICstLQo+IMKgZHJpdmVycy9paW8vYWRjL3JvY2tjaGlw
X3NhcmFkYy5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCA0ICstLS0KPiDCoGRy
aXZlcnMvaWlvL2FkYy9ydHE2MDU2LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfCA0ICstLS0KPiDCoGRyaXZlcnMvaWlvL2FkYy9zdG0zMi1hZGMuY8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMyArLS0KPiDCoGRy
aXZlcnMvaWlvL2FkYy90aS1hZHMxMDE1LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfCA0ICstLS0KPiDCoGRyaXZlcnMvaWlvL2FkYy90aS1hZHMxMTE5LmPCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCA0ICstLS0KPiDCoGRyaXZl
cnMvaWlvL2FkYy90aS1sbXA5MjA2NC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB8IDQgKy0tLQo+IMKgZHJpdmVycy9paW8vYWRjL3RpLXRzYzIwNDYuY8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDMgKy0tCj4gwqBkcml2ZXJzL2lp
by9jaGVtaWNhbC9zY2QzMF9jb3JlLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
IDMgKy0tCj4gwqBkcml2ZXJzL2lpby9jaGVtaWNhbC9zY2Q0eC5jwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMyArLS0KPiDCoGRyaXZlcnMvaWlvL2NoZW1pY2Fs
L3N1bnJpc2VfY28yLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCA2ICsrLS0tLQo+
IMKgZHJpdmVycy9paW8vZGFjL2FkMzU1MnIuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB8IDMgKy0tCj4gwqBkcml2ZXJzL2lpby9pbXUvaW52X2ljbTQy
NjAwL2ludl9pY200MjYwMF9hY2NlbC5jIHwgNSArKy0tLQo+IMKgZHJpdmVycy9paW8vaW11L2lu
dl9pY200MjYwMC9pbnZfaWNtNDI2MDBfZ3lyby5jwqAgfCA1ICsrLS0tCj4gwqBkcml2ZXJzL2lp
by9pbXUvaW52X21wdTYwNTAvaW52X21wdV9hY3BpLmPCoMKgwqDCoMKgwqDCoCB8IDQgKy0tLQo+
IMKgZHJpdmVycy9paW8vaW11L2ludl9tcHU2MDUwL2ludl9tcHVfcmluZy5jwqDCoMKgwqDCoMKg
wqAgfCA2ICsrLS0tLQo+IMKgZHJpdmVycy9paW8vbGlnaHQvYmgxNzQ1LmPCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgNCArLS0tCj4gwqBkcml2ZXJzL2lp
by9saWdodC9sdHI1MDEuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfCA0ICstLS0KPiDCoGRyaXZlcnMvaWlvL2xpZ2h0L29wdDQwNjAuY8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgNCArLS0tCj4gwqBkcml2ZXJzL2lp
by9saWdodC92ZW1sNjAzMC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHwgNCArLS0tCj4gwqBkcml2ZXJzL2lpby9tYWduZXRvbWV0ZXIvYWY4MTMzai5jwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgNCArLS0tCj4gwqBkcml2ZXJzL2lpby9wcmVzc3Vy
ZS9ibXAyODAtY29yZS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgNSArLS0tLQo+
IMKgZHJpdmVycy9paW8vcHJlc3N1cmUvbXBsMzExNS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfCAzICstLQo+IMKgZHJpdmVycy9paW8vcHJlc3N1cmUvbXBybHMwMDI1
cGFfaTJjLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgNSArLS0tLQo+IMKgZHJpdmVycy9paW8v
cHJlc3N1cmUvenBhMjMyNi5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fCA0ICstLS0KPiDCoGRyaXZlcnMvaWlvL3Byb3hpbWl0eS9pcnNkMjAwLmPCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAzICstLQo+IMKgZHJpdmVycy9paW8vdGVtcGVyYXR1
cmUvdG1wMDA2LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgNCArLS0tCj4g
wqAzMCBmaWxlcyBjaGFuZ2VkLCAzNCBpbnNlcnRpb25zKCspLCA4NSBkZWxldGlvbnMoLSkKPiAt
LS0KPiBiYXNlLWNvbW1pdDogNGM2MDczZmVjMmZlZTQ4MjdmYTBkZDhhNGFiNGU2ZjdiYmMwNWVl
Ngo+IGNoYW5nZS1pZDogMjAyNTA2MTEtaWlvLXplcm8taW5pdC1zdGFjay13aXRoLWluc3RlYWQt
b2YtbWVtc2V0LTBkMTJkNDFhN2VjYgo+IAo+IEJlc3QgcmVnYXJkcywKCg==


