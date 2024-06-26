Return-Path: <linux-iio+bounces-6950-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 019189180B5
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 14:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C4A01F219E3
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 12:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3510F181322;
	Wed, 26 Jun 2024 12:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrzUPHdr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEF2180A9F;
	Wed, 26 Jun 2024 12:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719403952; cv=none; b=BqVgDJ3m78UV+mQULX8SRAy0DUeq08bKHwUvQ+9mF8azdlwT1xc5hkG2EGp91kJzfXvQxJiO3n6HwiSIXYBT2racORVqAJPUFsS9l613sURN189A0FKH/+4NcOT5D/reDUPK9tc/slXKbtL4+lf0PkGep52yuqzm8+I8VP85bq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719403952; c=relaxed/simple;
	bh=fQz4wCDRCJLOQHVyli+/5hjGJm3w1q7BbpFIa0/lJME=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BADzxsp50WabhYYJIRUVoN/Wj0Bgvq5LLKM0nCuLFi1vpTxqb43upGDxFyL5rzE0tk6/A/zOA6tveTDSeFGOmyChhrNb1/zt5OTOtixAR7MG7dDl+1YsqfegHRmDHK/h0vW2pVOWtKL5xIMvh1vfFL6cWYSpOnXQPnTSb0d6AA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KrzUPHdr; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ec17eb4493so89796211fa.2;
        Wed, 26 Jun 2024 05:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719403948; x=1720008748; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fQz4wCDRCJLOQHVyli+/5hjGJm3w1q7BbpFIa0/lJME=;
        b=KrzUPHdrsDWep6xQS9DxaBRe0DD6KcD04ehsHch9NFrAq9TTgqEJ6Nd9iz2kd9Fygr
         Na6YEizusybio5KmDfByeMVpkIgzUgXTCUOsgw++fZ5kZeyXYb6rlG53TuAahUSaN3To
         8SpGJQHErzFuwd1qOfps7H3hEpWxEF1AUt9taruCw+c2bdDwZ9NrkbN/VtNQ+YcZCWlj
         XamvJ+MeUk8dyQ8gHzrxPFvJog+zMTVwI2FRMI5prkhUP83VVp/HJ6GelfH784HUVeTT
         khxuA+X1OT3b/MZaIQBDhDtYfYEdDMGCO969bjOdaBWlhc/vDTYyuvsBQzYmoPzyV1Ge
         sniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719403948; x=1720008748;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fQz4wCDRCJLOQHVyli+/5hjGJm3w1q7BbpFIa0/lJME=;
        b=fRDXm3BAhT0BIey/D+wPV+rQJ5TpRAxH3uyl6TgKcotBkForz6+5lKZIk53xsHfTjY
         UashoV7lAIieUVRQFAgUiVP01OuwEz4McPVviQPaQAVFBzYt3V49jWeifE3ppxkcCgxY
         GYQnRu5jhZsV9R2CHzTBPbH9GyZmL+z2gGT65SJmq2mC+Q52OYYYemMvdn0xZ9EIlLcR
         bosiBBWXn0PVzJAUnAL5zEAdVV6jku3aHnxmSxbabqJsSGcNkfIonOQFyum2qtC4GSGd
         yW9Z/a3qUNjfmwmUTAhD7U6kgQueFmPUqaBUUBQGlAxmYOLMkiKbXpLuRJzzotcDpMqx
         I7UA==
X-Forwarded-Encrypted: i=1; AJvYcCUAcCYw/wer8sFwPI2XKT1vGC3zoqGR4LcOmkNn+/Gzn7t5oylVGDW01rHBCV6C71UoBkpdjwuB0+tXuoDSTZmRtQETRmiTflpQBl975u6NS0OsUU1Btc3kKksuex0QR1odd+Ft75HQPJmVd7HGzfh7CC9hAbHs/vRd2QhXaa5CUf9oKw==
X-Gm-Message-State: AOJu0YzzePVhUNJJF/bWEnPfBLhTu4lMb1DJUQX7u9+h5mRmqA/HVRsf
	YMDEk8mmOfBSQzXeOTA7eG0lqU7pVb0L5JpC7IJmL/BV+VCaUrbv
X-Google-Smtp-Source: AGHT+IGPuP9pwCzWgijUnGx8ceVmUnevln+2dyxiUAnDzQSWov/OGqOOeYUV6nbLSK5TZPVIBmn2Fg==
X-Received: by 2002:ac2:46ee:0:b0:52c:84ac:8fa2 with SMTP id 2adb3069b0e04-52ce182c12cmr7912098e87.7.1719403948092;
        Wed, 26 Jun 2024 05:12:28 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7279161095sm144404866b.26.2024.06.26.05.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 05:12:27 -0700 (PDT)
Message-ID: <a72569f7c1f5d9a7158fe774179ec8fc76016168.camel@gmail.com>
Subject: Re: [PATCH v6 5/6] iio: adc: ad7192: Add clock provider
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Alexandru Ardelean <aardelean@baylibre.com>, Alisa-Dariana Roman
	 <alisadariana@gmail.com>
Cc: Alisa-Dariana Roman <alisa.roman@analog.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Michael Hennerich
 <michael.hennerich@analog.com>,  linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>
Date: Wed, 26 Jun 2024 14:16:19 +0200
In-Reply-To: <CA+GgBR8r_W9X0hROUEw-xePyKAhOTBjJtf=cHbfWfvUUfk5j_g@mail.gmail.com>
References: <20240624124941.113010-1-alisa.roman@analog.com>
	 <20240624124941.113010-6-alisa.roman@analog.com>
	 <CA+GgBR8r_W9X0hROUEw-xePyKAhOTBjJtf=cHbfWfvUUfk5j_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVHVlLCAyMDI0LTA2LTI1IGF0IDA4OjQ4ICswMzAwLCBBbGV4YW5kcnUgQXJkZWxlYW4gd3Jv
dGU6Cj4gT24gTW9uLCBKdW4gMjQsIDIwMjQgYXQgMzo1MeKAr1BNIEFsaXNhLURhcmlhbmEgUm9t
YW4KPiA8YWxpc2FkYXJpYW5hQGdtYWlsLmNvbT4gd3JvdGU6Cj4gPiAKPiA+IEludGVybmFsIGNs
b2NrIG9mIEFENzE5WCBkZXZpY2VzIGNhbiBiZSBtYWRlIGF2YWlsYWJsZSBvbiBNQ0xLMiBwaW4u
IEFkZAo+ID4gY2xvY2sgcHJvdmlkZXIgdG8gc3VwcG9ydCB0aGlzIGZ1bmN0aW9uYWxpdHkuCj4g
PiAKPiAKPiBKdXN0IGEgcXVlc3Rpb24gdGhhdCBzaG91bGQgYmUgYWRkcmVzc2VkIGJ5IHRoZSBm
YWlsaW5nIG9mIHRoZQo+IGNsb2NrLXByb3ZpZGVyIHJlZ2lzdHJhdGlvbi4KPiBXaXRoIHRoYXQg
YWRkcmVzc2VkOgo+IAo+IFJldmlld2VkLWJ5OiBBbGV4YW5kcnUgQXJkZWxlYW4gPGFhcmRlbGVh
bkBiYXlsaWJyZS5jb20+Cj4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGlzYS1EYXJpYW5hIFJvbWFu
IDxhbGlzYS5yb21hbkBhbmFsb2cuY29tPgo+ID4gLS0tCj4gPiDCoGRyaXZlcnMvaWlvL2FkYy9h
ZDcxOTIuYyB8IDg5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPiA+
IMKgMSBmaWxlIGNoYW5nZWQsIDg5IGluc2VydGlvbnMoKykKPiA+IAo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvaWlvL2FkYy9hZDcxOTIuYyBiL2RyaXZlcnMvaWlvL2FkYy9hZDcxOTIuYwo+ID4g
aW5kZXggOTQwNTE3ZGY1NDI5Li45MDc2M2MxNDY3OWQgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJz
L2lpby9hZGMvYWQ3MTkyLmMKPiA+ICsrKyBiL2RyaXZlcnMvaWlvL2FkYy9hZDcxOTIuYwo+ID4g
QEAgLTgsNiArOCw3IEBACj4gPiDCoCNpbmNsdWRlIDxsaW51eC9pbnRlcnJ1cHQuaD4KPiA+IMKg
I2luY2x1ZGUgPGxpbnV4L2JpdGZpZWxkLmg+Cj4gPiDCoCNpbmNsdWRlIDxsaW51eC9jbGsuaD4K
PiA+ICsjaW5jbHVkZSA8bGludXgvY2xrLXByb3ZpZGVyLmg+Cj4gPiDCoCNpbmNsdWRlIDxsaW51
eC9kZXZpY2UuaD4KPiA+IMKgI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPgo+ID4gwqAjaW5jbHVk
ZSA8bGludXgvc2xhYi5oPgo+ID4gQEAgLTIwMSw2ICsyMDIsNyBAQCBzdHJ1Y3QgYWQ3MTkyX2No
aXBfaW5mbyB7Cj4gPiDCoHN0cnVjdCBhZDcxOTJfc3RhdGUgewo+ID4gwqDCoMKgwqDCoMKgwqAg
Y29uc3Qgc3RydWN0IGFkNzE5Ml9jaGlwX2luZm/CoMKgICpjaGlwX2luZm87Cj4gPiDCoMKgwqDC
oMKgwqDCoCBzdHJ1Y3QgY2xrwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgICptY2xrOwo+ID4gK8KgwqDCoMKgwqDCoCBzdHJ1Y3QgY2xrX2h3wqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGludF9jbGtfaHc7Cj4gPiDCoMKgwqDCoMKgwqDCoCB1MTbC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBp
bnRfdnJlZl9tdjsKPiA+IMKgwqDCoMKgwqDCoMKgIHUzMsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFpbmNvbV9tdjsKPiA+IMKgwqDCoMKg
wqDCoMKgIHUzMsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGZjbGs7Cj4gPiBAQCAtNDAxLDYgKzQwMyw4OCBAQCBzdGF0aWMgY29uc3QgY2hh
ciAqY29uc3QgYWQ3MTkyX2Nsb2NrX25hbWVzW10gPSB7Cj4gPiDCoMKgwqDCoMKgwqDCoCAibWNs
ayIKPiA+IMKgfTsKPiA+IAo+ID4gK3N0YXRpYyBzdHJ1Y3QgYWQ3MTkyX3N0YXRlICpjbGtfaHdf
dG9fYWQ3MTkyKHN0cnVjdCBjbGtfaHcgKmh3KQo+ID4gK3sKPiA+ICvCoMKgwqDCoMKgwqAgcmV0
dXJuIGNvbnRhaW5lcl9vZihodywgc3RydWN0IGFkNzE5Ml9zdGF0ZSwgaW50X2Nsa19odyk7Cj4g
PiArfQo+ID4gKwo+ID4gK3N0YXRpYyB1bnNpZ25lZCBsb25nIGFkNzE5Ml9jbGtfcmVjYWxjX3Jh
dGUoc3RydWN0IGNsa19odyAqaHcsCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVu
c2lnbmVkIGxvbmcgcGFyZW50X3JhdGUpCj4gPiArewo+ID4gK8KgwqDCoMKgwqDCoCByZXR1cm4g
QUQ3MTkyX0lOVF9GUkVRX01IWjsKPiA+ICt9Cj4gPiArCj4gPiArc3RhdGljIGludCBhZDcxOTJf
Y2xrX291dHB1dF9pc19lbmFibGVkKHN0cnVjdCBjbGtfaHcgKmh3KQo+ID4gK3sKPiA+ICvCoMKg
wqDCoMKgwqAgc3RydWN0IGFkNzE5Ml9zdGF0ZSAqc3QgPSBjbGtfaHdfdG9fYWQ3MTkyKGh3KTsK
PiA+ICsKPiA+ICvCoMKgwqDCoMKgwqAgcmV0dXJuIHN0LT5jbG9ja19zZWwgPT0gQUQ3MTkyX0NM
S19JTlRfQ087Cj4gPiArfQo+ID4gKwo+ID4gK3N0YXRpYyBpbnQgYWQ3MTkyX2Nsa19wcmVwYXJl
KHN0cnVjdCBjbGtfaHcgKmh3KQo+ID4gK3sKPiA+ICvCoMKgwqDCoMKgwqAgc3RydWN0IGFkNzE5
Ml9zdGF0ZSAqc3QgPSBjbGtfaHdfdG9fYWQ3MTkyKGh3KTsKPiA+ICvCoMKgwqDCoMKgwqAgaW50
IHJldDsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqAgc3QtPm1vZGUgJj0gfkFENzE5Ml9NT0RFX0NM
S1NSQ19NQVNLOwo+ID4gK8KgwqDCoMKgwqDCoCBzdC0+bW9kZSB8PSBBRDcxOTJfQ0xLX0lOVF9D
TzsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqAgcmV0ID0gYWRfc2Rfd3JpdGVfcmVnKCZzdC0+c2Qs
IEFENzE5Ml9SRUdfTU9ERSwgMywgc3QtPm1vZGUpOwo+ID4gK8KgwqDCoMKgwqDCoCBpZiAocmV0
KQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJldDsKPiA+ICsKPiA+
ICvCoMKgwqDCoMKgwqAgc3QtPmNsb2NrX3NlbCA9IEFENzE5Ml9DTEtfSU5UX0NPOwo+ID4gKwo+
ID4gK8KgwqDCoMKgwqDCoCByZXR1cm4gMDsKPiA+ICt9Cj4gPiArCj4gPiArc3RhdGljIHZvaWQg
YWQ3MTkyX2Nsa191bnByZXBhcmUoc3RydWN0IGNsa19odyAqaHcpCj4gPiArewo+ID4gK8KgwqDC
oMKgwqDCoCBzdHJ1Y3QgYWQ3MTkyX3N0YXRlICpzdCA9IGNsa19od190b19hZDcxOTIoaHcpOwo+
ID4gK8KgwqDCoMKgwqDCoCBpbnQgcmV0Owo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoCBzdC0+bW9k
ZSAmPSB+QUQ3MTkyX01PREVfQ0xLU1JDX01BU0s7Cj4gPiArwqDCoMKgwqDCoMKgIHN0LT5tb2Rl
IHw9IEFENzE5Ml9DTEtfSU5UOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoCByZXQgPSBhZF9zZF93
cml0ZV9yZWcoJnN0LT5zZCwgQUQ3MTkyX1JFR19NT0RFLCAzLCBzdC0+bW9kZSk7Cj4gPiArwqDC
oMKgwqDCoMKgIGlmIChyZXQpCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1
cm47Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgIHN0LT5jbG9ja19zZWwgPSBBRDcxOTJfQ0xLX0lO
VDsKPiA+ICt9Cj4gPiArCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBjbGtfb3BzIGFkNzE5Ml9p
bnRfY2xrX29wcyA9IHsKPiA+ICvCoMKgwqDCoMKgwqAgLnJlY2FsY19yYXRlID0gYWQ3MTkyX2Ns
a19yZWNhbGNfcmF0ZSwKPiA+ICvCoMKgwqDCoMKgwqAgLmlzX2VuYWJsZWQgPSBhZDcxOTJfY2xr
X291dHB1dF9pc19lbmFibGVkLAo+ID4gK8KgwqDCoMKgwqDCoCAucHJlcGFyZSA9IGFkNzE5Ml9j
bGtfcHJlcGFyZSwKPiA+ICvCoMKgwqDCoMKgwqAgLnVucHJlcGFyZSA9IGFkNzE5Ml9jbGtfdW5w
cmVwYXJlLAo+ID4gK307Cj4gPiArCj4gPiArc3RhdGljIGludCBhZDcxOTJfcmVnaXN0ZXJfY2xr
X3Byb3ZpZGVyKHN0cnVjdCBhZDcxOTJfc3RhdGUgKnN0KQo+ID4gK3sKPiA+ICvCoMKgwqDCoMKg
wqAgc3RydWN0IGRldmljZSAqZGV2ID0gJnN0LT5zZC5zcGktPmRldjsKPiA+ICvCoMKgwqDCoMKg
wqAgc3RydWN0IGNsa19pbml0X2RhdGEgaW5pdCA9IHt9Owo+ID4gK8KgwqDCoMKgwqDCoCBpbnQg
cmV0Owo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoCBpZiAoIUlTX0VOQUJMRUQoQ09ORklHX0NPTU1P
Tl9DTEspKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4gPiAr
Cj4gPiArwqDCoMKgwqDCoMKgIGluaXQubmFtZSA9IGRldm1fa2FzcHJpbnRmKGRldiwgR0ZQX0tF
Uk5FTCwgIiVzLWNsayIsCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZ3bm9kZV9nZXRfbmFtZShkZXZfZndub2Rl
KGRldikpKTsKPiA+ICvCoMKgwqDCoMKgwqAgaWYgKCFpbml0Lm5hbWUpCj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVOT01FTTsKPiA+ICsKPiA+ICvCoMKgwqDCoMKg
wqAgaW5pdC5vcHMgPSAmYWQ3MTkyX2ludF9jbGtfb3BzOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDC
oCBzdC0+aW50X2Nsa19ody5pbml0ID0gJmluaXQ7Cj4gPiArwqDCoMKgwqDCoMKgIHJldCA9IGRl
dm1fY2xrX2h3X3JlZ2lzdGVyKGRldiwgJnN0LT5pbnRfY2xrX2h3KTsKPiA+ICvCoMKgwqDCoMKg
wqAgaWYgKHJldCkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7
Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgIHJldHVybiBkZXZtX29mX2Nsa19hZGRfaHdfcHJvdmlk
ZXIoZGV2LCBvZl9jbGtfaHdfc2ltcGxlX2dldCwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgICZzdC0+aW50X2Nsa19odyk7Cj4gPiArfQo+ID4gKwo+ID4gwqBzdGF0aWMgaW50IGFkNzE5
Ml9jbG9ja19zZXR1cChzdHJ1Y3QgYWQ3MTkyX3N0YXRlICpzdCkKPiA+IMKgewo+ID4gwqDCoMKg
wqDCoMKgwqAgc3RydWN0IGRldmljZSAqZGV2ID0gJnN0LT5zZC5zcGktPmRldjsKPiA+IEBAIC00
MTIsNiArNDk2LDExIEBAIHN0YXRpYyBpbnQgYWQ3MTkyX2Nsb2NrX3NldHVwKHN0cnVjdCBhZDcx
OTJfc3RhdGUgKnN0KQo+ID4gwqDCoMKgwqDCoMKgwqAgaWYgKHJldCA8IDApIHsKPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdC0+Y2xvY2tfc2VsID0gQUQ3MTkyX0NMS19JTlQ7
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3QtPmZjbGsgPSBBRDcxOTJfSU5U
X0ZSRVFfTUhaOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0g
YWQ3MTkyX3JlZ2lzdGVyX2Nsa19wcm92aWRlcihzdCk7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBpZiAocmV0KQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgcmV0LAo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgICJGYWlsZWQgdG8gcmVnaXN0ZXIgY2xvY2sKPiA+IHByb3Zp
ZGVyXG4iKTsKPiAKPiBBIHF1ZXN0aW9uIGhlcmU6IGRvIHdlIHdhbnQgdG8gZmFpbCB0aGUgcHJv
YmUgb2YgdGhpcyBkcml2ZXIgd2hlbiBpdAo+IGNhbm5vdCByZWdpc3RlciBhIGNsb2NrIHByb3Zp
ZGVyPwo+IE9yIHNob3VsZCB3ZSBpZ25vcmUgaXQ/Cj4gTm8gcHJlZmVyZW5jZSBmcm9tIG15IHNp
ZGUuCgpTZW5zaWJsZSBxdWVzdGlvbi4uLiBJIHdvdWxkIHNheSBpdCBkZXBlbmRzLiBPbiBvbmUg
c2lkZSB0aGlzIGlzIGFuIG9wdGlvbmFsCmZlYXR1cmUgc28gd2Ugc2hvdWxkIG5vdCAoYXJndWFi
bHkpIGVycm9yIG91dC4gT1RPSCwgc29tZW9uZSBtYXkgcmVhbGx5IHdhbnQKKGFuZCByZWxpZXMg
b24pIHRoaXMgZmVhdHVyZSBzbyBmYWlsaW5nIG1ha2VzIHNlbnNlLgoKTWF5YmUgd2Ugc2hvdWxk
IGhhdmUKCmlmICghZGV2aWNlX3Byb3BlcnR5X3ByZXNlbnQoJnNwaS0+ZGV2LCAiI2Nsb2NrLWNl
bGxzIikpCglyZXR1cm4gMDsKCmluIGFkNzE5Ml9yZWdpc3Rlcl9jbGtfcHJvdmlkZXIoKS4gU28g
dGhhdCBpZiB3ZSBmYWlsIHRoZSBmdW5jdGlvbiwgdGhlbiB5ZXMsIHdlCnNob3VsZCBmYWlsIHBy
b2JpbmcgYXMgRlcgd2FudHMgdGhpcyB0byBiZSBhIHByb3ZpZGVyLiBBbHNvLCBub3QgcHJvdmlk
aW5nCiNjbG9jay1jZWxscyBtZWFucyB3ZSBkb24ndCByZWdpc3RlciB0aGUgY2xvY2suCgpIYXZp
bmcgc2FpZCB0aGUgYWJvdmUgSSB0aGluayB0aGF0IGZhaWxpbmcgZGV2bV9jbGtfaHdfcmVnaXN0
ZXIoKSBtZWFucyB0aGF0CnNvbWV0aGluZyBpcyBhbHJlYWR5IHJlYWxseSB3cm9uZyAob3Igd2Ug
aGF2ZSBhIGJ1ZyBpbiB0aGUgZHJpdmVyKSBzbyBsaWtlbHkgd2UKc2hvdWxkIGtlZXAgaXQgc2lt
cGxlIGFuZCBqdXN0IGFsd2F5cyBwcm92aWRlIHRoZSBjbG9jayBhbmQgcmV0dXJuIGFuIGVycm9y
IGlmCndlIGZhaWwgdG8gZG8gc28uCgpteSAyIGNlbnRzLi4uCgotIE51bm8gU8OhCgoK


