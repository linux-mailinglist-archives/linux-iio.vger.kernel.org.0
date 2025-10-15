Return-Path: <linux-iio+bounces-25088-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A20BDDEF2
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 12:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 83B284E9496
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 10:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26AF2E2DCB;
	Wed, 15 Oct 2025 10:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nrfuj0MS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F0A18C933
	for <linux-iio@vger.kernel.org>; Wed, 15 Oct 2025 10:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760523332; cv=none; b=mksm92Asz16YVESifct4K88U+OhVyh8NGRce54d9EHBOdjBOh23EZQTkJhrmQIXqm2ySYBJK2I1LRJ8bZ7x/CTRSShEU2geQm7gGym+fpam8DOyg6gEHp6oTuBuSNhEeqzuatrlUCNKvuY6dw5pZjuEWlZSBvu5IxWHG58AJbFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760523332; c=relaxed/simple;
	bh=m/wcwtb8FLbmT7nb2hxNG0FTRwvyqk4uZgc1P7N8kjw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uQoY8oU5ZqjDc8o9f507dV2ko64p0k12Ob0czNrncvJj8kC3VCB5JmsdbirdaRpRrm9cuDH6M3R8Qlahy8+Du8oCHISJylxz/xmqQbX/i3k68OrBifTM1wnAcQSMM1nXWEygouwULdMEpxU7s/wF2k12Cud7x0tQO33HDWzQpxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nrfuj0MS; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4710022571cso3862175e9.3
        for <linux-iio@vger.kernel.org>; Wed, 15 Oct 2025 03:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760523329; x=1761128129; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m/wcwtb8FLbmT7nb2hxNG0FTRwvyqk4uZgc1P7N8kjw=;
        b=Nrfuj0MS8UCv2jMsfkxWP4Z8JhnH5EYwX3946phjl+W27Szrd9TkfjvATaYOnwvQuL
         pb8nX2QDaMsGiLyvt37iEalkAoVORSh74YENU7Dl58r26Pgk+rde1OymVIu8A7lhXZEu
         7pre5CF/fXORxyJr+AMVB/reWsnCIdgqSphsJd+BUL2n7HSOKZjWyZH+zPc3PU3+Hr9o
         CQKK29DDVtHynNjzHb4pewIcvGRS4ujnNAtbMlC9mJBDozvNDRhYpnTqabQDAgSmMblA
         j5gESLNPB/Uz0y0n7yfJyHgRncdx+Y5c7MV/66wg+ehX/ARtu6X4yFiUhV9w7nQNeWZD
         xweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760523329; x=1761128129;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m/wcwtb8FLbmT7nb2hxNG0FTRwvyqk4uZgc1P7N8kjw=;
        b=Jdw4apsFF6uhkpxXyUXl2EN44XwAVS0QbsqJ1PemoIcvz870iZ6805q9VICx36bb0/
         Fe51hmsf245JFPYCt8TMcdJAXgabImsB/y3w1djVC73DsVUGR7hWRbM+WGm53OF1TJxe
         xuCXgwXw4ADgZOrOzgSjylR/ZpFLB385kDKUiaVtwYr3GDSK8oN8j10Z5FE7IY+qsP0/
         95vGi7CogqaiUUqPwzrN5++B+1JTvnePhtTndjGFphdPbeRP3RE4DSJsVoVQO3Tk9sDL
         lSK3emcsJTBda8Ot6sfnRTSBRe3ye3/zz4GHgKZvPagYlEO866Lqqsny8oelaGoPF8p+
         uy0A==
X-Forwarded-Encrypted: i=1; AJvYcCWU+hm1VR5fdP7SqY6Uj4ljIHP3h9GxMvI75YCBOu9rYrR6oJXMB1duKcTKg7az4EYKy5ebSxQhQXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSDrjOjIStlGq9Kdnwzpyq9CkIMAdnUDyhKzBakWccKAhbJxMJ
	bcvp6CcDNPJAQP0xFEXn9FTreavwnzCvQt/EZK6X3bOn18ez/7j0Fn/t
X-Gm-Gg: ASbGncuA4ZHECz3MqJsSoE1taM4UFjYRaVOgpzBvbqybftEqCgEbH2A8n1+puc82rOb
	D8lMc+HLNmCsZXxiPAcWQ9/V6iS/BBnJLxFIqR/s8Ud70Tg/K34LSTu7HMMGykNqhJMg20pqJCg
	oJ50NUMOchJTqCOCU+uErdTga415W7vPTXGat2HxGerNDe6ZHZd7uoDPhFfPidaF07jsnE1Zqd6
	IhzuRyt2O/xxTuVtWcZWS6VXCoTA9g9fgBRM4SpSZc162d+0SpklRY7/sGdQDouxo7D8HifkqR/
	PakRn6i/fM4VsvhdyV8kCA0bnIXlF8WNEhS4/wrwNkRjSOOHtHdGIVrL3gFof6XynF5pLSrglqT
	atLP4qteZe2yeJjZyqGEa9263QA9/h/cDjQSr+4f3gojj1ycSgg==
X-Google-Smtp-Source: AGHT+IGlbr6rnLZhnuFfgtsP9rjL+H5wzb0gqjtGnO3gCF1NLUUhKtDH+KPfBCySuv+/43Z7NZFylw==
X-Received: by 2002:a05:600c:4ec8:b0:46d:27b7:e7e5 with SMTP id 5b1f17b1804b1-46fa9b08d79mr222596995e9.32.1760523328748;
        Wed, 15 Oct 2025 03:15:28 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47101c03644sm22553675e9.8.2025.10.15.03.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 03:15:28 -0700 (PDT)
Message-ID: <9269eadc1ea593e5bc8f5cad8061b48220f4d2b2.camel@gmail.com>
Subject: Re: [PATCH 3/6] spi: add multi_bus_mode field to struct spi_transfer
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,  Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Michael Hennerich
 <michael.hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=	
 <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko	
 <andy@kernel.org>
Cc: Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org
Date: Wed, 15 Oct 2025 11:16:01 +0100
In-Reply-To: <20251014-spi-add-multi-bus-support-v1-3-2098c12d6f5f@baylibre.com>
References: 
	<20251014-spi-add-multi-bus-support-v1-0-2098c12d6f5f@baylibre.com>
	 <20251014-spi-add-multi-bus-support-v1-3-2098c12d6f5f@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVHVlLCAyMDI1LTEwLTE0IGF0IDE3OjAyIC0wNTAwLCBEYXZpZCBMZWNobmVyIHdyb3RlOgo+
IEFkZCBhIG5ldyBtdWx0aV9idXNfbW9kZSBmaWVsZCB0byBzdHJ1Y3Qgc3BpX3RyYW5zZmVyIHRv
IGFsbG93Cj4gcGVyaXBoZXJhbHMgdGhhdCBzdXBwb3J0IG11bHRpcGxlIFNQSSBidXNlcyB0byBi
ZSB1c2VkIHdpdGggYSBzaW5nbGUKPiBTUEkgY29udHJvbGxlci4KPiAKPiBUaGlzIHJlcXVpcmVz
IGJvdGggdGhlIHBlcmlwaGVyYWwgYW5kIHRoZSBjb250cm9sbGVyIHRvIGhhdmUgbXVsdGlwbGUK
PiBzZXJpYWxpemVycyBjb25uZWN0ZWQgdG8gc2VwYXJhdGUgZGF0YSBidXNlcy4gSXQgY291bGQg
YWxzbyBiZSB1c2VkIHdpdGgKPiBhIHNpbmdsZSBjb250cm9sbGVyIGFuZCBtdWx0aXBsZSBwZXJp
cGhlcmFscyB0aGF0IGFyZSBmdW5jdGlvbmluZyBhcyBhCj4gc2luZ2xlIGxvZ2ljYWwgZGV2aWNl
IChzaW1pbGFyIHRvIHBhcmFsbGVsIG1lbW9yaWVzKS4KPiAKPiBUaGUgcG9zc2libGUgdmFsdWVz
IGZvciB0aGlzIGZpZWxkIGhhdmUgdGhlIGZvbGxvd2luZyBzZW1hbnRpY3M6Cj4gCj4gLSBTUElf
TVVMVElfQlVTX01PREVfU0lOR0xFOiBPbmx5IHVzZSB0aGUgZmlyc3QgYnVzLiBUaGlzIG1lYW5z
IHRoYXQgaXQKPiDCoMKgwqAgaXQgaXMgb3BlcmF0aW5nIGp1c3QgbGlrZSBhIGNvbnZlbnRpb25h
bCBTUEkgYnVzLiBJdCBpcyB0aGUgZGVmYXVsdAo+IMKgwqDCoCB2YWx1ZSBzbyB0aGF0IGV4aXN0
aW5nIGRyaXZlcnMgZG8gbm90IG5lZWQgdG8gYmUgbW9kaWZpZWQuCj4gCj4gwqDCoMKgIEV4YW1w
bGU6Cj4gwqDCoMKgwqDCoMKgwqAgdHhfYnVmWzBdID0gMHg4ODsKPiAKPiDCoMKgwqDCoMKgwqDC
oCBzdHJ1Y3Qgc3BpX3RyYW5zZmVyIHhmZXIgPSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAu
dHhfYnVmID0gdHhfYnVmLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLmxlbiA9IDEsCj4gwqDC
oMKgwqDCoMKgwqAgfTsKPiAKPiDCoMKgwqDCoMKgwqDCoCBzcGlfc3luY190cmFuc2ZlcihzcGks
ICZ4ZmVyLCAxKTsKPiAKPiDCoMKgwqDCoMKgwqDCoCBjb250cm9sbGVywqDCoMKgID4gZGF0YSBi
aXRzID7CoMKgwqDCoCBwZXJpcGhlcmFsCj4gwqDCoMKgwqDCoMKgwqAgLS0tLS0tLS0tLcKgwqAg
LS0tLS0tLS0tLS0tLS0tLcKgwqAgLS0tLS0tLS0tLQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
U0RPIDDCoMKgwqAgMC0wLTAtMS0wLTAtMC0xwqDCoMKgIFNESSAwCj4gCj4gLSBTUElfTVVMVElf
QlVTX01PREVfTUlSUk9SOiBTZW5kIGEgc2luZ2xlIGRhdGEgd29yZCBvdmVyIGFsbCBvZiB0aGUK
PiDCoMKgwqAgYnVzZXMgYXQgdGhlIHNhbWUgdGltZS4gVGhpcyBvbmx5IG1ha2VzIHNlbnNlIGZv
ciB3cml0ZXMgYW5kIG5vdAo+IMKgwqDCoCBmb3IgcmVhZHMuCj4gCj4gwqDCoMKgIEV4YW1wbGU6
Cj4gwqDCoMKgwqDCoMKgwqAgdHhfYnVmWzBdID0gMHg4ODsKPiAKPiDCoMKgwqDCoMKgwqDCoCBz
dHJ1Y3Qgc3BpX3RyYW5zZmVyIHhmZXIgPSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAudHhf
YnVmID0gdHhfYnVmLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLmxlbiA9IDEsCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAubXVsdGlfYnVzX21vZGUgPSBTUElfTVVMVElfQlVTX01PREVfTUlS
Uk9SLAo+IMKgwqDCoMKgwqDCoMKgIH07Cj4gCj4gwqDCoMKgwqDCoMKgwqAgc3BpX3N5bmNfdHJh
bnNmZXIoc3BpLCAmeGZlciwgMSk7Cj4gCj4gwqDCoMKgwqDCoMKgwqAgY29udHJvbGxlcsKgwqDC
oCA+IGRhdGEgYml0cyA+wqDCoMKgwqAgcGVyaXBoZXJhbAo+IMKgwqDCoMKgwqDCoMKgIC0tLS0t
LS0tLS3CoMKgIC0tLS0tLS0tLS0tLS0tLS3CoMKgIC0tLS0tLS0tLS0KPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIFNETyAwwqDCoMKgIDAtMC0wLTEtMC0wLTAtMcKgwqDCoCBTREkgMAo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgU0RPIDHCoMKgwqAgMC0wLTAtMS0wLTAtMC0xwqDCoMKgIFNESSAx
Cj4gCj4gLSBTUElfTVVMVElfQlVTX01PREVfU1RSSVBFOiBTZW5kIG9yIHJlY2VpdmUgdHdvIGRp
ZmZlcmVudCBkYXRhIHdvcmRzIGF0Cj4gwqDCoMKgIHRoZSBzYW1lIHRpbWUsIG9uZSBvbiBlYWNo
IGJ1cy4KPiAKPiDCoMKgwqAgRXhhbXBsZToKPiDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3Qgc3BpX3Ry
YW5zZmVyIHhmZXIgPSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAucnhfYnVmID0gcnhfYnVm
LAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLmxlbiA9IDIsIC8qIG11c3QgYmUgbXVsdGlwbGUg
b2YgbnVtYmVyIG9mIGJ1c2VzICovCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAubXVsdGlfYnVz
X21vZGUgPSBTUElfTVVMVElfQlVTX01PREVfU1RSSVBFLAo+IMKgwqDCoMKgwqDCoMKgIH07Cj4g
Cj4gwqDCoMKgwqDCoMKgwqAgc3BpX3N5bmNfdHJhbnNmZXIoc3BpLCAmeGZlciwgMSk7Cj4gCj4g
wqDCoMKgwqDCoMKgwqAgY29udHJvbGxlcsKgwqDCoCA8IGRhdGEgYml0cyA8wqDCoMKgwqAgcGVy
aXBoZXJhbAo+IMKgwqDCoMKgwqDCoMKgIC0tLS0tLS0tLS3CoMKgIC0tLS0tLS0tLS0tLS0tLS3C
oMKgIC0tLS0tLS0tLS0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFNESSAwwqDCoMKgIDAtMC0w
LTEtMC0wLTAtMcKgwqDCoCBTRE8gMAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgU0RJIDHCoMKg
wqAgMS0wLTAtMC0xLTAtMC0wwqDCoMKgIFNETyAxCgpPdXQgb2YgY3VyaW9zaXR5LCBob3cgZG9l
cyB0aGlzIHdvcmsgZm9yIGRldmljZXMgbGlrZSBBRDQwMzAgd2hlcmUgdGhlIHNhbWUgd29yZApp
cyBraW5kIG9mIGludGVybGVhdmVkIGJldHdlZW4gU0RPIGxpbmVzPyBJIGd1ZXNzIGl0IHdvcmtz
IHRoZSBzYW1lIChpbiB0ZXJtcyBvZgpTVykgYW5kIGlzIHVwIHRvIHNvbWUgSVAgY29yZSAodHlw
aWNhbGx5IGluIHRoZSBGUEdBKSB0byAicmUtYXNzZW1ibGUiIHRoZSB3b3JkPwoKPiAKPiDCoMKg
wqDCoMKgwqDCoCBBZnRlciB0aGUgdHJhbnNmZXIsIHJ4X2J1ZlswXSA9PSAweDExICh3b3JkIGZy
b20gU0RPIDApIGFuZAo+IMKgwqDCoMKgwqDCoMKgIHJ4X2J1ZlsxXSA9PSAweDg4ICh3b3JkIGZy
b20gU0RPIDEpLiBJZiB0aGUgdHJhbnNmZXIgd2FzIGxvbmdlciwKPiDCoMKgwqDCoMKgwqDCoCB0
aGUgZGF0YSB3b3VsZCBjb250aW51ZSBpbiBhbiBhbHRlcm5hdGluZyBmYXNoaW9uLgo+IAo+IFNp
Z25lZC1vZmYtYnk6IERhdmlkIExlY2huZXIgPGRsZWNobmVyQGJheWxpYnJlLmNvbT4KPiAtLS0K
Ckxvb2tzIGdvb2QgYW55d2F5cywKCkFja2VkLWJ5OiBOdW5vIFPDoSA8bnVuby5zYUBhbmFsb2cu
Y29tPgoKPiDCoGluY2x1ZGUvbGludXgvc3BpL3NwaS5oIHwgNiArKysrKysKPiDCoDEgZmlsZSBj
aGFuZ2VkLCA2IGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9z
cGkvc3BpLmggYi9pbmNsdWRlL2xpbnV4L3NwaS9zcGkuaAo+IGluZGV4Cj4gYzMxNDE5NGQ0ZTdl
MmIzOTY3OTVlY2UxMGUxNDIxMThjYTA1ZjRlYi4uN2QyMmVmNTA3N2QxMjI5Y2FjMjU3NDgzMWY4
MDA5MmM1OTFiCj4gOTcyZiAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3NwaS9zcGkuaAo+
ICsrKyBiL2luY2x1ZGUvbGludXgvc3BpL3NwaS5oCj4gQEAgLTk3Niw2ICs5NzYsOCBAQCBzdHJ1
Y3Qgc3BpX3JlcyB7Cj4gwqAgKsKgwqDCoMKgwqAgKFNQSV9OQklUU19TSU5HTEUpIGlzIHVzZWQu
Cj4gwqAgKiBAcnhfbmJpdHM6IG51bWJlciBvZiBiaXRzIHVzZWQgZm9yIHJlYWRpbmcuIElmIDAg
dGhlIGRlZmF1bHQKPiDCoCAqwqDCoMKgwqDCoCAoU1BJX05CSVRTX1NJTkdMRSkgaXMgdXNlZC4K
PiArICogQG11bHRpX2J1c19tb2RlOiBIb3cgdG8gc2VyaWFsaXplIGRhdGEgb24gbXVsdGlwbGUg
YnVzZXMuIE9uZSBvZiB0aGUKPiArICrCoMKgwqDCoMKgIFNQSV9NVUxUSV9CVVNfTU9ERV8qIHZh
bHVlcy4KPiDCoCAqIEBsZW46IHNpemUgb2YgcnggYW5kIHR4IGJ1ZmZlcnMgKGluIGJ5dGVzKQo+
IMKgICogQHNwZWVkX2h6OiBTZWxlY3QgYSBzcGVlZCBvdGhlciB0aGFuIHRoZSBkZXZpY2UgZGVm
YXVsdCBmb3IgdGhpcwo+IMKgICrCoMKgwqDCoMKgIHRyYW5zZmVyLiBJZiAwIHRoZSBkZWZhdWx0
IChmcm9tIEBzcGlfZGV2aWNlKSBpcyB1c2VkLgo+IEBAIC0xMTEyLDYgKzExMTQsMTAgQEAgc3Ry
dWN0IHNwaV90cmFuc2ZlciB7Cj4gwqAJdW5zaWduZWQJY3NfY2hhbmdlOjE7Cj4gwqAJdW5zaWdu
ZWQJdHhfbmJpdHM6NDsKPiDCoAl1bnNpZ25lZAlyeF9uYml0czo0Owo+ICsJdW5zaWduZWQJbXVs
dGlfYnVzX21vZGU6IDI7Cj4gKyNkZWZpbmUgU1BJX01VTFRJX0JVU19NT0RFX1NJTkdMRQkwIC8q
IG9ubHkgdXNlIHNpbmdsZSBidXMgKi8KPiArI2RlZmluZSBTUElfTVVMVElfQlVTX01PREVfU1RS
SVBFCTEgLyogb25lIGRhdGEgd29yZCBwZXIgYnVzICovCj4gKyNkZWZpbmUgU1BJX01VTFRJX0JV
U19NT0RFX01JUlJPUgkyIC8qIHNhbWUgd29yZCBzZW50IG9uIGFsbCBidXNlcyAqLwo+IMKgCXVu
c2lnbmVkCXRpbWVzdGFtcGVkOjE7Cj4gwqAJYm9vbAkJZHRyX21vZGU7Cj4gwqAjZGVmaW5lCVNQ
SV9OQklUU19TSU5HTEUJMHgwMSAvKiAxLWJpdCB0cmFuc2ZlciAqLwo=


