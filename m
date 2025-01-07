Return-Path: <linux-iio+bounces-13958-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42340A041CB
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 15:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34C377A2C07
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 14:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1561F37B4;
	Tue,  7 Jan 2025 14:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQoI+b1a"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972CA1F2374;
	Tue,  7 Jan 2025 14:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736258804; cv=none; b=UifflTjm9UWA2T1Nf/K2zbbbgEEIF8DX6jPkQFwlhaYtdMt1qr4tQchfKN0Q96V/2DW9zVGQsh47MVt4iiPmavJ+rr1voGwcCfKoLcM+SMx7asyq35Oa3etxVxi/ZWM0ig30KcLEkHTba/q4hvF5p8NNyZkNHocIIXrYWhV6+4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736258804; c=relaxed/simple;
	bh=gtu2JZ5e+++PAt97B0zZ70AP39fEi7/1hL6yFShiOpQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sm6T6PhIkpcGq+lz0EldO6dbr7Ycpx10N3Gcb2TsIXH0jJHioco17SoQWsEi7Jah3Ltjuy1NzqCgrPcL2FYEVqsd8sy+F1K9+J7ND4y4qKeLsydMjPU2dEYOGQKZp63nmTkB9J6dPM/9zS8jlghacqVIM6mUUAccVJ8hqIeuPJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQoI+b1a; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4361f65ca01so154778145e9.1;
        Tue, 07 Jan 2025 06:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736258797; x=1736863597; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtu2JZ5e+++PAt97B0zZ70AP39fEi7/1hL6yFShiOpQ=;
        b=QQoI+b1anz6FkK5riwU5/sa5m2C34RRHryBeFM0odwFD11OWBn/3wYRdYOw1pWGcbb
         lmB04VHGWzMRQZsSTBCyykxe3ekuUevZRIx4yeXG7IUW9U81iqaBSczCPqqG2JHDhrEZ
         0BiBHjucdRMhMLlzCitxjL7DUsHUXoMUMGKyQFnmunPX528+SKM/ABli9ZR04rPDbMfV
         o3ebowy1KaFRkHqvROv2Xg7MFDiil3/J9GFN6WptQgl+REtAe3eH9vX62OJ6Issb5iY3
         zncbkvh5J3JMU+6jHdIG/Y0lQqkjl7B7/2jqX+4zkhX29KqeiBeicsImBfDjx59NmsSz
         qubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736258797; x=1736863597;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gtu2JZ5e+++PAt97B0zZ70AP39fEi7/1hL6yFShiOpQ=;
        b=Y6S0HoZg6gXodg7g9usgX2QVbJgCMs18+DmTeq5dEjHogB8dUsVnJvOwvceJN2LSl6
         V1N1NreUJIvUTrXBhAXyAJOwIX94KVdZl4/baAqlKdQDlWST/KHEO5jj8kEEVHtIT/kU
         C5963rtuRS4StquFa7mILi6aymsbyNa24CG9nK8xZJFk/RDceona+VJv9sotR/xC7UcN
         9Q7cwWDWFp5N8+iVF5HxB9KDlQ2L48ekfZu2B5jdHW2qNyThVPpG8DpfXO7ZlhgxVmnb
         wB9ijNwWLwHjPOjRnBEyFzVINx9j2DHF0Y3Yuqy8mJb5bkGUeP8rfuOXnn4efQaeRJfs
         fFVw==
X-Forwarded-Encrypted: i=1; AJvYcCV64P9iW+QYYcJazlLAkL/+xdUqCQYVulw3rq0tIFUszAu0HgSrtSrCJiAcYc5p6vHnWAaGEDBQYbsw@vger.kernel.org, AJvYcCVN8jvzB6SCA55JavV6Zq2BNayWZnen1UaAavsdsGB9/C5QhL7jaQPtLljnGIJZa98eXkCewmkrIshr@vger.kernel.org, AJvYcCWKEGzNblZhPNUZmQeQGzDLPlf8WMbOmXvXx2jimDvZ9JtOz7qvYUe3Z90qYLip3dY3E2IhLPwDRxV7ChTY@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8XUoI12Vtl/NKdpN2j5yEWyBucEywr/dieqoi6wJHzkbIifo3
	NZN3BZW7dD/bFPuu3/JxngaTZl5EaLY1EAE3r27wL5SPJLKRDvIp
X-Gm-Gg: ASbGncuQIPcHLmjFlABW5hx1+uE5+6AjuQOEIM2XcIqcfvXFv6dUtqZ2xSaAXxzCXnp
	cvdM9LPRMK/bRrWTQ0lU/gkTr3GEJ8Hlc6uLKsA/xTiycRHokR5couIo+CVdJtkJ6Rk3O0MBjBa
	BJ8rcDM66XJwTW01sWdhIy/F1b2zmzAde8YTEaBk9N6iJVvSk6GUkInshtKb1eP7W1O91KBdBPV
	W4dwNDTph9kW9oEcd+9kf+jJUZB5N3Pfi7q+zLce9fU3XTfawvJascsjjIULtCGkVX6ZToYfycZ
	gG+AtNeXfbwYm4ZRD4s4++7gLoFK
X-Google-Smtp-Source: AGHT+IEOnFACU9muGCAJh47a+3xiDh1PixxVWfR+98vQ2MECLsNWythJDrldnuO0ZktlFUZGb2hG+Q==
X-Received: by 2002:a05:600c:4fd4:b0:436:1bbe:f686 with SMTP id 5b1f17b1804b1-43668b48084mr470986205e9.21.1736258797207;
        Tue, 07 Jan 2025 06:06:37 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c829120sm51854534f8f.6.2025.01.07.06.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 06:06:36 -0800 (PST)
Message-ID: <d2c31c3cc5542629b7ceb2347464260822fe3202.camel@gmail.com>
Subject: Re: [PATCH] dt-bindings: iio: Correct indentation and style in DTS
 example
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Lars-Peter Clausen
	 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron	 <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Puranjay Mohan	 <puranjay@kernel.org>, Joshua
 Felmeden <jfelmeden@thegoodpenguin.co.uk>,  Sankar Velliangiri	
 <navin@linumiz.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 	linux-kernel@vger.kernel.org
Date: Tue, 07 Jan 2025 14:06:35 +0000
In-Reply-To: <20250107125848.226899-1-krzysztof.kozlowski@linaro.org>
References: <20250107125848.226899-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVHVlLCAyMDI1LTAxLTA3IGF0IDEzOjU4ICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOgo+IERUUyBleGFtcGxlIGluIHRoZSBiaW5kaW5ncyBzaG91bGQgYmUgaW5kZW50ZWQgd2l0
aCAyLSBvciA0LXNwYWNlcyBhbmQKPiBhbGlnbmVkIHdpdGggb3BlbmluZyAnLSB8Jywgc28gY29y
cmVjdCBhbnkgZGlmZmVyZW5jZXMgbGlrZSAzLXNwYWNlcyBvcgo+IG1peHR1cmVzIDItIGFuZCA0
LXNwYWNlcyBpbiBvbmUgYmluZGluZy4KPiAKPiBObyBmdW5jdGlvbmFsIGNoYW5nZXMgaGVyZSwg
YnV0IHNhdmVzIHNvbWUgY29tbWVudHMgZHVyaW5nIHJldmlld3Mgb2YKPiBuZXcgcGF0Y2hlcyBi
dWlsdCBvbiBleGlzdGluZyBjb2RlLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEtyenlzenRvZiBLb3ps
b3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4KPiAtLS0KCkFja2VkLWJ5OiBO
dW5vIFNhIDxudW5vLnNhQGFuYWxvZy5jb20+Cgo+IMKgLi4uL2JpbmRpbmdzL2lpby9kYWMvYWRp
LGFkNTM4MC55YW1swqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxOCArKysrKysrKystLS0tLS0tLS0K
PiDCoC4uLi9paW8vaHVtaWRpdHkvc2Npb3NlbnNlLGVuczIxMC55YW1swqDCoMKgwqDCoMKgwqDC
oCB8IDEyICsrKysrKy0tLS0tLQo+IMKgLi4uL2lpby90ZW1wZXJhdHVyZS9tYXhpbSxtYXgzMTg2
NS55YW1swqDCoMKgwqDCoMKgwqAgfCAxOCArKysrKysrKystLS0tLS0tLS0KPiDCoC4uLi9iaW5k
aW5ncy9paW8vdGVtcGVyYXR1cmUvdGksdG1wMTE3LnlhbWzCoMKgwqAgfMKgIDYgKysrLS0tCj4g
wqA0IGZpbGVzIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKyksIDI3IGRlbGV0aW9ucygtKQo+IAo+
IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2RhYy9h
ZGksYWQ1MzgwLnlhbWwKPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8v
ZGFjL2FkaSxhZDUzODAueWFtbAo+IGluZGV4IDllYjk5Mjg1MDBlMi4uM2UzMjNmMWE1NDU4IDEw
MDY0NAo+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vZGFjL2Fk
aSxhZDUzODAueWFtbAo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9p
aW8vZGFjL2FkaSxhZDUzODAueWFtbAo+IEBAIC01NSwxOCArNTUsMTggQEAgZXhhbXBsZXM6Cj4g
wqDCoMKgwqDCoMKgwqDCoCAjYWRkcmVzcy1jZWxscyA9IDwxPjsKPiDCoMKgwqDCoMKgwqDCoMKg
ICNzaXplLWNlbGxzID0gPDA+Owo+IMKgwqDCoMKgwqDCoMKgwqAgZGFjQDAgewo+IC3CoMKgwqDC
oMKgwqDCoMKgwqDCoCByZWcgPSA8MD47Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbXBhdGli
bGUgPSAiYWRpLGFkNTM5MC01IjsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqAgdnJlZi1zdXBwbHkg
PSA8JmRhY3ZyZWY+Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlZyA9IDwwPjsKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBjb21wYXRpYmxlID0gImFkaSxhZDUzOTAtNSI7Cj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgdnJlZi1zdXBwbHkgPSA8JmRhY3ZyZWY+Owo+IMKgwqDCoMKgwqDC
oMKgwqAgfTsKPiDCoMKgwqDCoCB9Owo+IMKgwqAgLSB8Cj4gwqDCoMKgwqAgaTJjIHsKPiAtwqDC
oMKgwqDCoMKgICNhZGRyZXNzLWNlbGxzID0gPDE+Owo+IC3CoMKgwqDCoMKgwqAgI3NpemUtY2Vs
bHMgPSA8MD47Cj4gLcKgwqDCoMKgwqDCoCBkYWNANDIgewo+IC3CoMKgwqDCoMKgwqDCoMKgwqAg
cmVnID0gPDB4NDI+Owo+IC3CoMKgwqDCoMKgwqDCoMKgwqAgY29tcGF0aWJsZSA9ICJhZGksYWQ1
MzgwLTMiOwo+IC3CoMKgwqDCoMKgwqAgfTsKPiArwqDCoMKgwqDCoMKgwqAgI2FkZHJlc3MtY2Vs
bHMgPSA8MT47Cj4gK8KgwqDCoMKgwqDCoMKgICNzaXplLWNlbGxzID0gPDA+Owo+ICvCoMKgwqDC
oMKgwqDCoCBkYWNANDIgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlZyA9IDwweDQyPjsK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb21wYXRpYmxlID0gImFkaSxhZDUzODAtMyI7Cj4g
K8KgwqDCoMKgwqDCoMKgIH07Cj4gwqDCoMKgwqAgfTsKPiDCoC4uLgo+IGRpZmYgLS1naXQKPiBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vaHVtaWRpdHkvc2Npb3NlbnNl
LGVuczIxMC55YW1sCj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2h1
bWlkaXR5L3NjaW9zZW5zZSxlbnMyMTAueWFtbAo+IGluZGV4IGVkMGVhOTM4ZjdmOC4uMWUyNWNm
NzgxY2YxIDEwMDY0NAo+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9p
aW8vaHVtaWRpdHkvc2Npb3NlbnNlLGVuczIxMC55YW1sCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9odW1pZGl0eS9zY2lvc2Vuc2UsZW5zMjEwLnlhbWwKPiBA
QCAtNDMsMTMgKzQzLDEzIEBAIGFkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQo+IMKgZXhhbXBs
ZXM6Cj4gwqDCoCAtIHwKPiDCoMKgwqDCoCBpMmMgewo+IC3CoMKgwqDCoMKgwqAgI2FkZHJlc3Mt
Y2VsbHMgPSA8MT47Cj4gLcKgwqDCoMKgwqDCoCAjc2l6ZS1jZWxscyA9IDwwPjsKPiArwqDCoMKg
wqDCoMKgwqAgI2FkZHJlc3MtY2VsbHMgPSA8MT47Cj4gK8KgwqDCoMKgwqDCoMKgICNzaXplLWNl
bGxzID0gPDA+Owo+IMKgCj4gLcKgwqDCoMKgwqDCoCB0ZW1wZXJhdHVyZS1zZW5zb3JANDMgewo+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoCBjb21wYXRpYmxlID0gInNjaW9zZW5zZSxlbnMyMTAiOwo+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoCByZWcgPSA8MHg0Mz47Cj4gLcKgwqDCoMKgwqDCoCB9Owo+
ICvCoMKgwqDCoMKgwqDCoCB0ZW1wZXJhdHVyZS1zZW5zb3JANDMgewo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGNvbXBhdGlibGUgPSAic2Npb3NlbnNlLGVuczIxMCI7Cj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgcmVnID0gPDB4NDM+Owo+ICvCoMKgwqDCoMKgwqDCoCB9Owo+IMKgwqDCoMKg
IH07Cj4gwqAuLi4KPiDCoAo+IGRpZmYgLS1naXQKPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9paW8vdGVtcGVyYXR1cmUvbWF4aW0sbWF4MzE4NjUueWFtbAo+IGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby90ZW1wZXJhdHVyZS9tYXhpbSxtYXgzMTg2
NS55YW1sCj4gaW5kZXggN2NjMzY1ZTBlYmM4Li43YzBjNmFiNmZjNjkgMTAwNjQ0Cj4gLS0tIGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby90ZW1wZXJhdHVyZS9tYXhpbSxt
YXgzMTg2NS55YW1sCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lp
by90ZW1wZXJhdHVyZS9tYXhpbSxtYXgzMTg2NS55YW1sCj4gQEAgLTQwLDE1ICs0MCwxNSBAQCB1
bmV2YWx1YXRlZFByb3BlcnRpZXM6IGZhbHNlCj4gwqBleGFtcGxlczoKPiDCoMKgIC0gfAo+IMKg
wqDCoMKgIHNwaSB7Cj4gLcKgwqDCoMKgwqDCoCAjYWRkcmVzcy1jZWxscyA9IDwxPjsKPiAtwqDC
oMKgwqDCoMKgICNzaXplLWNlbGxzID0gPDA+Owo+ICvCoMKgwqDCoMKgwqDCoCAjYWRkcmVzcy1j
ZWxscyA9IDwxPjsKPiArwqDCoMKgwqDCoMKgwqAgI3NpemUtY2VsbHMgPSA8MD47Cj4gwqAKPiAt
wqDCoMKgwqDCoMKgIHRlbXBlcmF0dXJlLXNlbnNvckAwIHsKPiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqAgY29tcGF0aWJsZSA9ICJtYXhpbSxtYXgzMTg2NSI7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
IHJlZyA9IDwwPjsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3BpLW1heC1mcmVxdWVuY3kgPSA8
NDAwMDAwPjsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3BpLWNwaGE7Cj4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgIG1heGltLDMtd2lyZTsKPiAtwqDCoMKgwqDCoMKgIH07Cj4gK8KgwqDCoMKgwqDC
oMKgIHRlbXBlcmF0dXJlLXNlbnNvckAwIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb21w
YXRpYmxlID0gIm1heGltLG1heDMxODY1IjsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZWcg
PSA8MD47Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3BpLW1heC1mcmVxdWVuY3kgPSA8NDAw
MDAwPjsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzcGktY3BoYTsKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBtYXhpbSwzLXdpcmU7Cj4gK8KgwqDCoMKgwqDCoMKgIH07Cj4gwqDCoMKgwqAg
fTsKPiDCoC4uLgo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvaWlvL3RlbXBlcmF0dXJlL3RpLHRtcDExNy55YW1sCj4gYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvaWlvL3RlbXBlcmF0dXJlL3RpLHRtcDExNy55YW1sCj4gaW5kZXggNThh
YTE1NDI3NzZiLi5mYmJhNWU5MzQ4NjEgMTAwNjQ0Cj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2lpby90ZW1wZXJhdHVyZS90aSx0bXAxMTcueWFtbAo+ICsrKyBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vdGVtcGVyYXR1cmUvdGksdG1wMTE3
LnlhbWwKPiBAQCAtNDQsOCArNDQsOCBAQCBleGFtcGxlczoKPiDCoMKgwqDCoMKgwqDCoMKgICNz
aXplLWNlbGxzID0gPDA+Owo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoCB0bXAxMTdANDggewo+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29tcGF0aWJsZSA9ICJ0aSx0bXAxMTciOwo+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVnID0gPDB4NDg+Owo+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgdmNjLXN1cHBseSA9IDwmcG1pY19yZWdfM3YzPjsKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBjb21wYXRpYmxlID0gInRpLHRtcDExNyI7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cmVnID0gPDB4NDg+Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZjYy1zdXBwbHkgPSA8JnBt
aWNfcmVnXzN2Mz47Cj4gwqDCoMKgwqDCoMKgwqDCoCB9Owo+IMKgwqDCoMKgIH07Cgo=


