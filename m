Return-Path: <linux-iio+bounces-6942-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C4B917C92
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 11:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAB8D28586F
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 09:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C9216CD0D;
	Wed, 26 Jun 2024 09:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQKCWQlt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C4416A92B;
	Wed, 26 Jun 2024 09:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719394419; cv=none; b=YJbcfpRguZRML58+XqIaPsiXjhl5tpWoVv/pw4KWKlXHrL9fhIFWZxzTrzgVT7NmuI5vapKE8EY59bJolQdGpPNRWiaCpnJOZtVubjT8oJeT218mV9CUtZp7JmX4YQ4cG1shnG/ndpImHT51YRsCt1t1WOr1/mAqkhbW+ZVQ9Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719394419; c=relaxed/simple;
	bh=RGUBpy2/O35yyXL2s/b6/hoNJdIxjQo9IHKY4w7ut/M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jf3Y5JSivv8kradFHqHtreoq0hURM6QyiFD9G8fLrnkPr0DQe0dhU3NTRapvk2BB0gxwyr/5V9HHTWV06a8HKQbhgV4KLkkFV3l/QTWvTLKC6ifv6bjr5rzVS1aQHv+mtb1eI0jMN6HIRAv6dvXxMI7AQDUsKOOFLqKxP5u/Duw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQKCWQlt; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a724b4f1218so475143466b.2;
        Wed, 26 Jun 2024 02:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719394416; x=1719999216; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RGUBpy2/O35yyXL2s/b6/hoNJdIxjQo9IHKY4w7ut/M=;
        b=WQKCWQlthTvgLPiCKoKDNL/kswqflE+/f2u3CcAabVsm95C6oD6zOFGA4RuXEJVyfs
         7dHIiVLG92/DP5eq2+44c28tDJ50s14HZ+C6y0ylgy6u8ADoBvYWyqSlvmHY9ZC/QOzm
         apYlTICu61HuEmGCpT3jWDstenH4XdrYf45uf6em43tCoNafziNfJLLuaiBdmuzv8ghz
         zvr0cyT7SBZJRylY+YpZGVK7m+ZXEPgGIQO0GaSzdZCUNrjUx8adpM16SYJ1zf06ODZK
         wRSDnlz6Zs2ip2mBs5UPERaBnoLpH7J+/dbfwfVXIL5yfKoVkeZBir21fV3GSBI8Mdv/
         YvFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719394416; x=1719999216;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RGUBpy2/O35yyXL2s/b6/hoNJdIxjQo9IHKY4w7ut/M=;
        b=NFTSHa5E8643t3JEy4U22cbEI5CrhLFBz/aBXAVlPqY0abIJ+9rNQykDHeP/kFOV1P
         bl8p+Q910h9KRQw8Z+Jfjy74ofkhK3fukXDvli4tLZq6TmvdIp8H4oYhwIQ8QyYa6lHe
         GTpFOpX1XJQ1GHOogjzXtqI4KPpXILY7BGChJVZb/AmfbxdsSVa4KSxh4ZWJdPn9QL9q
         uDIWmlCVSCY7icYkDKs2K6xyzBXtIt0cnKaULikx0JY0g83FRLat7H5t2mVw1gGmYPiK
         HwmZ0wIHaUzZqKdAacswr6BMfCyx3ELtLlzV2/nHFp/eLn8zMSVq5mFDOjRmroXzaDrb
         +Lhg==
X-Forwarded-Encrypted: i=1; AJvYcCWBXOzy9dbgZjzz6HOykbOPFGvJSy5mCoQ9DznUu3oVvflnrAfx3Ysy7Lq2mM1AdvZTHze+thzYzCnmN4bPGl12XYPHoM/XBioD+RL4ZAd0xY5gFZcLO3KQvrjj+bC9gAhq/MZyU0OucA2//VT1wPcHqVQEjuyzGPwp5jwYYMidKx7NaLGzNYBUU5T1YmqnvnxGTX8nfnrvwNBdO/lIRw==
X-Gm-Message-State: AOJu0YwbLW7nIsQll4+yuAlXEI6YWt3ZgObC9RKneO7uz+bzvlQCxUay
	/IaOPq3A+8JBBaM6S4yQRAe6IGc06nq3QUtcCdAC0HQKc9SnNVslooVFkdStIMvzyA==
X-Google-Smtp-Source: AGHT+IHPcdNxBeC2CgNzOB2usLX3JDpI9Yw2a9Lehbrg3aaDzCri0Guu2iEDzsDwzVnKYXiK0/fbkA==
X-Received: by 2002:a17:906:d509:b0:a6f:5192:6f4d with SMTP id a640c23a62f3a-a7242c4dfd3mr486601866b.8.1719394416381;
        Wed, 26 Jun 2024 02:33:36 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7250712ca5sm327076566b.100.2024.06.26.02.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 02:33:35 -0700 (PDT)
Message-ID: <8df8f780c83a98480a3d19b0751cb96735c4adaf.camel@gmail.com>
Subject: Re: [PATCH v5 1/7] spi: Enable controllers to extend the SPI
 protocol with MOSI idle configuration
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org, 
 lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
  nuno.sa@analog.com, dlechner@baylibre.com, corbet@lwn.net, 
 marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 26 Jun 2024 11:37:27 +0200
In-Reply-To: <add14694c64b574af742a5dcd5c9461e0ef5210a.1719351923.git.marcelo.schmitt@analog.com>
References: <cover.1719351923.git.marcelo.schmitt@analog.com>
	 <add14694c64b574af742a5dcd5c9461e0ef5210a.1719351923.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

CgpPbiBUdWUsIDIwMjQtMDYtMjUgYXQgMTg6NTMgLTAzMDAsIE1hcmNlbG8gU2NobWl0dCB3cm90
ZToKPiBUaGUgYmVoYXZpb3Igb2YgYW4gU1BJIGNvbnRyb2xsZXIgZGF0YSBvdXRwdXQgbGluZSAo
U0RPIG9yIE1PU0kgb3IgQ09QSQo+IChDb250cm9sbGVyIE91dHB1dCBQZXJpcGhlcmFsIElucHV0
KSBmb3IgZGlzYW1iaWd1YXRpb24pIGlzIHVzdWFsbHkgbm90Cj4gc3BlY2lmaWVkIHdoZW4gdGhl
IGNvbnRyb2xsZXIgaXMgbm90IGNsb2NraW5nIG91dCBkYXRhIG9uIFNDTEsgZWRnZXMuCj4gSG93
ZXZlciwgdGhlcmUgZG8gZXhpc3QgU1BJIHBlcmlwaGVyYWxzIHRoYXQgcmVxdWlyZSBzcGVjaWZp
YyBNT1NJIGxpbmUKPiBzdGF0ZSB3aGVuIGRhdGEgaXMgbm90IGJlaW5nIGNsb2NrZWQgb3V0IG9m
IHRoZSBjb250cm9sbGVyLgo+IAo+IENvbnZlbnRpb25hbCBTUEkgY29udHJvbGxlcnMgbWF5IHNl
dCB0aGUgTU9TSSBsaW5lIG9uIFNDTEsgZWRnZXMgdGhlbiBicmluZwo+IGl0IGxvdyB3aGVuIG5v
IGRhdGEgaXMgZ29pbmcgb3V0IG9yIGxlYXZlIHRoZSBsaW5lIHRoZSBzdGF0ZSBvZiB0aGUgbGFz
dAo+IHRyYW5zZmVyIGJpdC4gTW9yZSBlbGFib3JhdGVkIGNvbnRyb2xsZXJzIGFyZSBjYXBhYmxl
IHRvIHNldCB0aGUgTU9TSSBpZGxlCj4gc3RhdGUgYWNjb3JkaW5nIHRvIGRpZmZlcmVudCBjb25m
aWd1cmFibGUgbGV2ZWxzIGFuZCB0aHVzIGFyZSBtb3JlIHN1aXRhYmxlCj4gZm9yIGludGVyZmFj
aW5nIHdpdGggZGVtYW5kaW5nIHBlcmlwaGVyYWxzLgo+IAo+IEFkZCBTUEkgbW9kZSBiaXRzIHRv
IGFsbG93IHBlcmlwaGVyYWxzIHRvIHJlcXVlc3QgZXhwbGljaXQgTU9TSSBpZGxlIHN0YXRlCj4g
d2hlbiBuZWVkZWQuCj4gCj4gV2hlbiBzdXBwb3J0aW5nIGEgcGFydGljdWxhciBNT1NJIGlkbGUg
Y29uZmlndXJhdGlvbiwgdGhlIGRhdGEgb3V0cHV0IGxpbmUKPiBzdGF0ZSBpcyBleHBlY3RlZCB0
byByZW1haW4gYXQgdGhlIGNvbmZpZ3VyZWQgbGV2ZWwgd2hlbiB0aGUgY29udHJvbGxlciBpcwo+
IG5vdCBjbG9ja2luZyBvdXQgZGF0YS4gV2hlbiBhIGRldmljZSB0aGF0IG5lZWRzIGEgc3BlY2lm
aWMgTU9TSSBpZGxlIHN0YXRlCj4gaXMgaWRlbnRpZmllZCwgaXRzIGRyaXZlciBzaG91bGQgcmVx
dWVzdCB0aGUgTU9TSSBpZGxlIGNvbmZpZ3VyYXRpb24gYnkKPiBzZXR0aW5nIHRoZSBwcm9wZXIg
U1BJIG1vZGUgYml0Lgo+IAo+IFNpZ25lZC1vZmYtYnk6IE1hcmNlbG8gU2NobWl0dCA8bWFyY2Vs
by5zY2htaXR0QGFuYWxvZy5jb20+Cj4gLS0tCgpPbmUgbWlub3Igbml0Li4uIFdpdGggdGhhdDoK
CkFja2VkLWJ5OiBOdW5vIFNhIDxudW5vLnNhQGFuYWxvZy5jb20+Cgo+IMKgRG9jdW1lbnRhdGlv
bi9zcGkvc3BpLXN1bW1hcnkucnN0IHwgODMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Kwo+IMKgZHJpdmVycy9zcGkvc3BpLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
wqAgNyArKysKPiDCoGluY2x1ZGUvbGludXgvc3BpL3NwaS5owqDCoMKgwqDCoMKgwqDCoMKgwqAg
fMKgIDYgKysrCj4gwqBpbmNsdWRlL3VhcGkvbGludXgvc3BpL3NwaS5owqDCoMKgwqDCoCB8wqAg
NSArLQo+IMKgNCBmaWxlcyBjaGFuZ2VkLCA5OSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQo+IAo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL3NwaS9zcGktc3VtbWFyeS5yc3QgYi9E
b2N1bWVudGF0aW9uL3NwaS9zcGktCj4gc3VtbWFyeS5yc3QKPiBpbmRleCA3ZjhhY2NmYWU2Zjku
LjUxZGQ4YTEwNWI3ZSAxMDA2NDQKPiAtLS0gYS9Eb2N1bWVudGF0aW9uL3NwaS9zcGktc3VtbWFy
eS5yc3QKPiArKysgYi9Eb2N1bWVudGF0aW9uL3NwaS9zcGktc3VtbWFyeS5yc3QKPiBAQCAtNjE0
LDYgKzYxNCw4OSBAQCBxdWV1ZSwgYW5kIHRoZW4gc3RhcnQgc29tZSBhc3luY2hyb25vdXMgdHJh
bnNmZXIgZW5naW5lCj4gKHVubGVzcyBpdCdzCj4gwqBhbHJlYWR5IHJ1bm5pbmcpLgo+IMKgCj4g
wqAKPiArRXh0ZW5zaW9ucyB0byB0aGUgU1BJIHByb3RvY29sCj4gKy0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQo+ICtUaGUgZmFjdCB0aGF0IFNQSSBkb2Vzbid0IGhhdmUgYSBmb3JtYWwg
c3BlY2lmaWNhdGlvbiBvciBzdGFuZGFyZCBwZXJtaXRzCj4gY2hpcAo+ICttYW51ZmFjdHVyZXJz
IHRvIGltcGxlbWVudCB0aGUgU1BJIHByb3RvY29sIGluIHNsaWdodGx5IGRpZmZlcmVudCB3YXlz
LiBJbgo+IG1vc3QKPiArY2FzZXMsIFNQSSBwcm90b2NvbCBpbXBsZW1lbnRhdGlvbnMgZnJvbSBk
aWZmZXJlbnQgdmVuZG9ycyBhcmUgY29tcGF0aWJsZQo+IGFtb25nCj4gK2VhY2ggb3RoZXIuIEZv
ciBleGFtcGxlLCBpbiBTUEkgbW9kZSAwIChDUE9MPTAsIENQSEE9MCkgdGhlIGJ1cyBsaW5lcyBt
YXkKPiBiZWhhdmUKPiArbGlrZSB0aGUgZm9sbG93aW5nOgo+ICsKPiArOjoKPiArCj4gK8KgIG5D
U3ggX19fwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgCj4gX19fCj4gK8KgwqDCoMKgwqDCoMKgwqDCoCBcX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18vCj4gK8KgwqDCoMKgwqDCoMKgwqDCoCDigKLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCDigKIKPiArwqDC
oMKgwqDCoMKgwqDCoMKgIOKAosKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIOKAogo+ICvCoCBTQ0xLwqDCoMKgwqDC
oMKgwqDCoCBfX1/CoMKgwqDCoCBfX1/CoMKgwqDCoCBfX1/CoMKgwqDCoCBfX1/CoMKgwqDCoCBf
X1/CoMKgwqDCoCBfX1/CoMKgwqDCoCBfX1/CoMKgwqDCoCBfX18KPiArwqDCoMKgwqDCoMKgIF9f
X19fX18vwqDCoCBcX19fL8KgwqAgXF9fXy/CoMKgIFxfX18vwqDCoCBcX19fL8KgwqAgXF9fXy/C
oMKgIFxfX18vwqDCoCBcX19fL8KgwqAKPiBcX19fX18KPiArwqDCoMKgwqDCoMKgwqDCoMKgIOKA
osKgwqAgOsKgwqAgO8KgwqAgOsKgwqAgO8KgwqAgOsKgwqAgO8KgwqAgOsKgwqAgO8KgwqAgOsKg
wqAgO8KgwqAgOsKgwqAgO8KgwqAgOsKgwqAgO8KgwqAgOsKgwqAgOyDigKIKPiArwqDCoMKgwqDC
oMKgwqDCoMKgIOKAosKgwqAgOsKgwqAgO8KgwqAgOsKgwqAgO8KgwqAgOsKgwqAgO8KgwqAgOsKg
wqAgO8KgwqAgOsKgwqAgO8KgwqAgOsKgwqAgO8KgwqAgOsKgwqAgO8KgwqAgOsKgwqAgOyDigKIK
PiArwqAgTU9TSSBYWFhfX19fX19fX19fwqDCoMKgwqDCoMKgwqDCoCBfX19fX19fwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgX19fX19fX8KgwqDCoMKgwqDCoMKgwqAKPiBfX19fX19f
X1hYWAo+ICvCoCAweEE1IFhYWF9fLyAxwqDCoMKgwqAgXF8wX19fX18vIDHCoMKgwqDCoCBcXzBf
X19fX19fMF9fX19fLyAxwqDCoMKgwqAgXF8wX19fX18vIDHCoMKgwqAKPiBcX1hYWAo+ICvCoMKg
wqDCoMKgwqDCoMKgwqAg4oCiwqDCoMKgwqDCoMKgIDvCoMKgwqDCoMKgwqAgO8KgwqDCoMKgwqDC
oCA7wqDCoMKgwqDCoMKgIDvCoMKgwqDCoMKgwqAgO8KgwqDCoMKgwqDCoCA7wqDCoMKgwqDCoMKg
IDvCoMKgwqDCoMKgwqAgOyDigKIKPiArwqDCoMKgwqDCoMKgwqDCoMKgIOKAosKgwqDCoMKgwqDC
oCA7wqDCoMKgwqDCoMKgIDvCoMKgwqDCoMKgwqAgO8KgwqDCoMKgwqDCoCA7wqDCoMKgwqDCoMKg
IDvCoMKgwqDCoMKgwqAgO8KgwqDCoMKgwqDCoCA7wqDCoMKgwqDCoMKgIDsg4oCiCj4gK8KgIE1J
U08gWFhYX19fX19fX19fX8KgwqDCoMKgwqDCoMKgwqAgX19fX19fX19fX19fX19fX19fX19fX1/C
oMKgwqDCoMKgwqDCoMKgwqAgX19fX19fX8KgwqDCoMKgwqDCoMKgCj4gWFhYCj4gK8KgIDB4QkEg
WFhYX18vwqDCoMKgwqAgMSBcX19fX18wXy/CoMKgwqDCoCAxwqDCoMKgwqDCoMKgIDHCoMKgwqDC
oMKgwqAgMSBcX19fX18wX18vwqDCoMKgIDHCoAo+IFxfX19fMF9fWFhYCj4gKwo+ICtMZWdlbmQ6
Ogo+ICsKPiArwqAg4oCiIG1hcmtzIHRoZSBzdGFydC9lbmQgb2YgdHJhbnNtaXNzaW9uOwo+ICvC
oCA6IG1hcmtzIHdoZW4gZGF0YSBpcyBjbG9ja2VkIGludG8gdGhlIHBlcmlwaGVyYWw7Cj4gK8Kg
IDsgbWFya3Mgd2hlbiBkYXRhIGlzIGNsb2NrZWQgaW50byB0aGUgY29udHJvbGxlcjsKPiArwqAg
WCBtYXJrcyB3aGVuIGxpbmUgc3RhdGVzIGFyZSBub3Qgc3BlY2lmaWVkLgo+ICsKPiArSW4gc29t
ZSBmZXcgY2FzZXMsIGNoaXBzIGV4dGVuZCB0aGUgU1BJIHByb3RvY29sIGJ5IHNwZWNpZnlpbmcg
bGluZSBiZWhhdmlvcnMKPiArdGhhdCBvdGhlciBTUEkgcHJvdG9jb2xzIGRvbid0IChlLmcuIGRh
dGEgbGluZSBzdGF0ZSBmb3Igd2hlbiBDUyBpcwo+IGluYWN0aXZlKS4KCkZvcmdvdCB0aGlzIG9u
ZS4uLiBpbmFjdGl2ZSAtPiBkZWFzc2VydGVkIChvciBub3QgYXNzZXJ0ZWQpCgotIE51bm8gU8Oh
CgoK


