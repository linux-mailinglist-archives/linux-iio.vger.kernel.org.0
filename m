Return-Path: <linux-iio+bounces-24009-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5724DB5450E
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 10:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF6613B2382
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 08:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076112D595D;
	Fri, 12 Sep 2025 08:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBiUJwcL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14502D5400
	for <linux-iio@vger.kernel.org>; Fri, 12 Sep 2025 08:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757665162; cv=none; b=JzsimwJjeFP5hu7HA14KoJb4SQbJCepHzUzTVIUi8bs1vijb6Mv6ZmExgvRxmgEUoLbToLne1BEPPLpqZqdkI/W7oS4+6IHQHrfwJ6ytakYNEdb589pDtbaLzo6Ssdl1JCTSoKQs4fEpbBm/Ic+2evc5wfg1B5HlDXSwQAzDF/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757665162; c=relaxed/simple;
	bh=vhi2EuqavcXxwlfTir9+euMwzSozgelH/J4dWHMTo+U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sr5E4l1dX9pSSkF9ftuOgDQFyNXL2wS6dJMyrtOMmlVgLH2g734n1CcasZqfjnEjKTw0UU1NyVklCeiwAdJKAG9PV4Rvp+Ipu2zwSx9HB8Y3/9JkdIRuZTW92mPhDDPv0O3YaK8DGuZmYwvYz49c+VNGUU4J5At/B47Q6+0EQ60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBiUJwcL; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aff0775410eso460174366b.0
        for <linux-iio@vger.kernel.org>; Fri, 12 Sep 2025 01:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757665159; x=1758269959; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vhi2EuqavcXxwlfTir9+euMwzSozgelH/J4dWHMTo+U=;
        b=kBiUJwcL+Ssl/y+VyCe1RlJ8p4diXKWe6/ocsWXryJcH+ON/n9zHd0HjuaEi6gDKG0
         aeL+n2cg/fi00p4yI2p90zRUdmxFWiBme7khQX67aZkMG38en9nvCD8Mf6FBm8tA2P7A
         9CrAs1q3fOpRczrWGH9ngiHpztS1nivK13IxzUcRWzXqP18T9N9UnRYyMzKPuNMRKAMp
         Pm7m1qrnYxDkae5nK0BB+nqB7UYQoJ1TJIacJoRJLCw/c85P4K6ykSAPKs71eMCLcNBq
         hZoKo/2WVGd8FAW5KxuLGTIqltbv9Zgb0YWvxFxv8E6/uj3iOQ5tkJA2VEzYsjNwbh2y
         VLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757665159; x=1758269959;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vhi2EuqavcXxwlfTir9+euMwzSozgelH/J4dWHMTo+U=;
        b=dci3pxzy6CE4QSJUbyeYId8biTVwHSjas4YtDvCeJF9+nVUzK1HJfOT+AoiRP2zVbz
         xhtIeEXUnP7Hf7KI5WVGJToVJWRwJwk3Anh+epIyLNrR3YIigmz9zq3FrFxIVl23TWMd
         kaa/yyFfgr7PtdPALIi11v8WCvCdJ3NDPmHU4yGSutXAKGIZL4jqlAwJ/MqugMUlDQog
         nSnn+c4p+5H3x4fSkFeZFoHSURBlQ7VHVMlohsL4Rucu7XIkgEnAn+5hPsmkTSPxe+ve
         pIazitf20HoAlbauxJwZzzQvV1OMJt+wXxsCcZrmQ04ydNt9jhO9wZMy2NN2U6j/2gQL
         E57g==
X-Forwarded-Encrypted: i=1; AJvYcCVt1rb/YWfMtTMDyGVtMmzLekTLq/y/asUgLT/in69v0gTglbv/Hg7eZ3/jQwa+yas45JoYqoeC3nw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2bliebSuyros/Bq589S/AtMoPtYnRNeTeF5b5w7eAkh5LZE13
	AhVjVMFIOLEudLGWBLofdCw8PbnxLQDS9lvLudfsRKgIuDJrTExgv3UC
X-Gm-Gg: ASbGncvhkb/ji72byQ1b7gDRBotOKi9DwvGQX/c2KvWW1qw0LUWmx+RyjcBCLeLP3hk
	gUrY6zQdFGcA+h9mfe010L9r6xv/jE2miw5jMkrzEdKiJproXMqrYm1u2kjbemnYnPeNMJshclP
	hrddgx21ZeIkYsEseMDCR27pYl4s63/XDdKd24uUU5zFUYETa13X+SsLNinSF/stMsmmRJDIQWQ
	QoxaNEY3Npjb8yfPnGSstbkgW9NqHuzf7ybIJDrSNYt1PbEOVTPRlANnB4U5/Jezc5V2i7cQREy
	k8b7UBYc/JbxfH/zeZ8d8cdoNjNlyrzFJU6nsvFDIOvoglKrfSleiDvYCuX7meWH0WOMF8ZHr4u
	BBNgijg1bkf9oL89z0WqufRzc1kqIXY1Pew==
X-Google-Smtp-Source: AGHT+IGIb25WmUTwrRh32igxOEKD1OuE/LTa+jx62Fe1IbQtlhi43GGWY7MEtxlOVUMeowCxH3xDNw==
X-Received: by 2002:a17:907:6e8f:b0:afe:ac57:f0be with SMTP id a640c23a62f3a-b07a6934870mr642421066b.31.1757665158951;
        Fri, 12 Sep 2025 01:19:18 -0700 (PDT)
Received: from [10.5.0.2] ([185.128.9.236])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b334e599sm321218466b.108.2025.09.12.01.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 01:19:18 -0700 (PDT)
Message-ID: <5e279cf72409504861c80bb4d2e4e5f6bc59d94c.camel@gmail.com>
Subject: Re: [PATCH v2 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Daniel Lezcano
	 <daniel.lezcano@linaro.org>
Cc: David Lechner <dlechner@baylibre.com>, jic23@kernel.org,
 nuno.sa@analog.com, 	andy@kernel.org, robh@kernel.org, conor+dt@kernel.org,
 krzk+dt@kernel.org, 	linux-iio@vger.kernel.org, s32@nxp.com,
 linux-kernel@vger.kernel.org, 	devicetree@vger.kernel.org,
 chester62515@gmail.com, mbrugger@suse.com, 	ghennadi.procopciuc@oss.nxp.com
Date: Fri, 12 Sep 2025 09:19:43 +0100
In-Reply-To: <CAHp75Vc8u2N2AHWtnPRmRXWKN3u8Qi=yvx5afbFh4NLNb8-y9A@mail.gmail.com>
References: <20250910155759.75380-1-daniel.lezcano@linaro.org>
	 <20250910155759.75380-3-daniel.lezcano@linaro.org>
	 <d53b22d1-35d6-4fb8-ae56-3ba4953b64af@baylibre.com>
	 <ea57a466-97b3-49d4-8d1c-142fd49a0da2@linaro.org>
	 <CAHp75Vc8u2N2AHWtnPRmRXWKN3u8Qi=yvx5afbFh4NLNb8-y9A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gRnJpLCAyMDI1LTA5LTEyIGF0IDA4OjM4ICswMzAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
Cj4gT24gRnJpLCBTZXAgMTIsIDIwMjUgYXQgMjowM+KAr0FNIERhbmllbCBMZXpjYW5vCj4gPGRh
bmllbC5sZXpjYW5vQGxpbmFyby5vcmc+IHdyb3RlOgo+ID4gT24gMTEvMDkvMjAyNSAyMjoxMCwg
RGF2aWQgTGVjaG5lciB3cm90ZToKPiA+ID4gT24gOS8xMC8yNSAxMDo1NyBBTSwgRGFuaWVsIExl
emNhbm8gd3JvdGU6Cj4gCj4gWyAuLi4gXQo+IAo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIC8qIGlpb19wdXNoX3RvX2J1ZmZlcnNfd2l0aF90aW1lc3RhbXAgc2hvdWxkIG5vdCBiZSBj
YWxsZWQKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogd2l0aCBkbWFfc2FtcGxl
cyBhcyBwYXJhbWV0ZXIuIFRoZSBzYW1wbGVzIHdpbGwgYmUKPiA+ID4gPiBzbWFzaGVkCj4gPiA+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIGlmIHRpbWVzdGFtcCBpcyBlbmFibGVkLgo+
ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8KPiAKPiAvKgo+IMKgKiBCdHcsIGNv
bW1lbnQgc3R5bGUgZm9yIG11bHRpLWxpbmUKPiDCoCogY29tbWVudHMgaXMgd3JvbmcgZm9yIHRo
aXMgc3Vic3lzdGVtLgo+IMKgKiBVc2UgdGhpcyBhcyBhbiBleGFtcGxlLCBBbHNvLCByZWZlciB0
bwo+IMKgKiB0aGUgZnVuY3Rpb24gYXMgZnVuYygpLCBpLmUuIG1pbmQgdGhlIHBhcmVudGhlc2Vz
Lgo+IMKgKi8KPiAKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0aW1lc3RhbXAgPSBp
aW9fZ2V0X3RpbWVfbnMoaW5kaW9fZGV2KTsKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCByZXQgPSBpaW9fcHVzaF90b19idWZmZXJzX3dpdGhfdGltZXN0YW1wKGluZGlvX2RldiwKPiA+
ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW5m
by0+YnVmZmVyLAo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB0aW1lc3RhbXApOwo+ID4gPiAKPiA+ID4gSXMgaXQgT0sgdG8gY2FsbCB0aGlz
IHdpdGggc3BpbmxvY2sgaGVsZD8gSXQgbG9va3MgbGlrZSBpdCBjYW4gY2FsbAo+ID4gPiBkZXZt
X2tyZWFsbG9jKCkgd2hpY2ggbWF5IHNsZWVwLgo+ID4gCj4gPiBJdCBzaG91bGQgYmUgb2ssIGRl
dm1fa3JlYWxsb2MgaXMgaW4gdGhlIGNvZGUgcGF0aCBvZgo+ID4gaWlvX3B1c2hfdG9fYnVmZmVy
c193aXRoX3RzX3VuYWxpZ25lZCgpLCBub3QgaW4KPiA+IGlpb19wdXNoX3RvX2J1ZmZlcnNfd2l0
aF90aW1lc3RhbXAoKQo+IAo+IFRoaXMgaXMgYSBnb29kIG9ic2VydmF0aW9uLCBjYW4gd2UgZG9j
dW1lbnQgdGhpcyBpbiB0aGUgcmVzcGVjdGl2ZQo+IGtlcm5lbC1kb2M6cyBwbGVhc2U/IEFsc28g
YWRkIG1pZ2h0X3NsZWVwKCkubWlnaHRfc2xlZXBfaWYoKSBpbiB0aGUKPiBhcHByb3ByaWF0ZSBm
dW5jdGlvbnMuCgpUaGF0J3MgYSBnb29kIGlkZWEhCgotIE51bm8gU8OhCg==


