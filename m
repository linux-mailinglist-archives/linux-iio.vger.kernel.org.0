Return-Path: <linux-iio+bounces-2261-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA09F84BB66
	for <lists+linux-iio@lfdr.de>; Tue,  6 Feb 2024 17:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A457A285F30
	for <lists+linux-iio@lfdr.de>; Tue,  6 Feb 2024 16:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DD64A15;
	Tue,  6 Feb 2024 16:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+gx8UKW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9132EB675;
	Tue,  6 Feb 2024 16:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707238294; cv=none; b=eUJZzvISKp9DgRB+nIQe59pAW7PVj3oA2ajzU6fI/UBVcAhsbRBS5haoZMUQJ7p45hcrBC8TXROHH8/v0FVF91kkKmJGAaOqx+/OyFcsASkfrgJxIuItsLLdoH/I05DAGeydmyh5a2FmhtKIKvyA2dZ3TzSiG6bkS1qHow7Zo4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707238294; c=relaxed/simple;
	bh=sD3m9KPje2n+6RusIja6iNui11mpTmA5RhVDbs8YGq0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TMF+sGu+g449Du/OVVvqernqfp0QrDTBr/q/qK7TSShjKA2uS2Gdbk0CC2nKPYkt3UU6hT8BleMv3KRWMuC+mkOtUaMNM/YmCpNSnxjIfJEzBrv8wwQdbUReKF90JBAQDClOc1G0TPIaBmFpUTrKPRl/e4p00rg4fIFrzk/mY3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+gx8UKW; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40f02b8d176so51004385e9.1;
        Tue, 06 Feb 2024 08:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707238291; x=1707843091; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sD3m9KPje2n+6RusIja6iNui11mpTmA5RhVDbs8YGq0=;
        b=K+gx8UKW07XFu6j+n07N/L8qY9gY5xoSexXCta53At3NLjmn2ihjoF53DtC+LLqCoa
         A1tq0qIna4bAnUjynUJD0UfbnCVW175eO7wslPMpOm1zVQcj42WgfvVgyuZ9u3dlwER5
         hwgBmCB+8Awahy0+IRjK0hKhBs3Ngk1v7vcvcdGdkqU34iKM7JT3J7TGBjj9o5gNFYKt
         iehAJvSARUxz76FBCCjUBVxqJVdt7Wy/mu1GapSj2pUeawBHIqGp+f1fEQVplmxiKy0k
         sy4fe15EWBDXw+0uG2D6FjDwZudJDYBLRslsnDEgXOrysPnpnjjVYUSLbOHx4L/+qAhm
         GMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707238291; x=1707843091;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sD3m9KPje2n+6RusIja6iNui11mpTmA5RhVDbs8YGq0=;
        b=qpePmOOR8Zk0MFg75Wl5/VDND0EBWTZoRDGvS+FLY1GyO2QHH2+BRHf23qbWX8UeRL
         u/z8CiVmJid44zcvjTZmxV979sI0eEfRaLfAA5GJ4wZRl43oIR8xBdfpuHDOemJedXg8
         DRExvZYGVj0d7uuOgeYImUjvFdRrtdoUhHZIxdB8Pz0OQkqhX7c/2/Mpf7WJfshOe9MB
         XZ6JaNsw21+Jp4yvD/Ck0vQGfqh73puasZk959xWe7vb8gQ+Idx+aFE9iPButUf2GWnY
         HO7Yt+qpoGpMpTU/Lq+jf0o1lHNzPp17e74pmZ5cfi4JtPf8bVd/LGQblZ2oWjJbXMxJ
         4JxA==
X-Gm-Message-State: AOJu0YxSZwB9/zCuaVAKNzDHXv1e01VgGRGcPU1MC/wlHvq5M9XyeI/O
	nn4frDiHIh2OzvIzd9kqJVSP/MWMP4/p6tw8f8dsTdNQDJTexzAKOVhSqSyUSpc=
X-Google-Smtp-Source: AGHT+IF/pe/Kz50S8hjKb2NqOJFX/+8NQEqPHo/cspVLQhtQYcqXplLkOBpIAdQW93xaJzzElmLHfg==
X-Received: by 2002:a05:600c:3d86:b0:40f:ed18:e9d2 with SMTP id bi6-20020a05600c3d8600b0040fed18e9d2mr1075521wmb.7.1707238290463;
        Tue, 06 Feb 2024 08:51:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXpCMQpPAyJJ2UQv1/yq1Kz87blRyq61C1FkVPDZXVEF3Svg0aeJq5go6pJVLZ6z7WciJpaaZCgYj5mkqjuR4TaXlazf6+5KDjbiN97IfRf7mph2HSMWxkAevnzOXcPL8DxGLffaDLLt3hNr+L3p7UsB2k4wJd3AAA2H6cnEpT6JxOLGdH6RsfJJwfiYN/yGkViOvpT1WFvnUrAFJKh0VF+ZMBc62uN2xeYe6mRnMrv63+dny90jK1pvQ8VA0UBcCB16LfuMAqmkVdSOgUO+NpygsMARdGSBSNtoJO5AJxlDqubLAWjdaeVxOxaMTPT4ma4nRuXYGhd5kTpa8p4p0TSUzCoZdU9YoGe02q9bWO7TOiKBSiFfB36xTZZ2umzZg==
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c4f8500b0040fdc645beesm2556019wmq.20.2024.02.06.08.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 08:51:30 -0800 (PST)
Message-ID: <f6ed72343be50c358db8e7e36d9afa875f788425.camel@gmail.com>
Subject: Re: [PATCH v9 6/7] iio: adc: ad9467: convert to backend framework
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>, nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>,  Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
 Frank Rowand <frowand.list@gmail.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>
Date: Tue, 06 Feb 2024 17:51:29 +0100
In-Reply-To: <CAHp75VeWV0+hqCoUb4YvfObnEAv0AaYJmXgpxJLfve+mBwhkyQ@mail.gmail.com>
References: <20240206-iio-backend-v9-0-df66d159c000@analog.com>
	 <20240206-iio-backend-v9-6-df66d159c000@analog.com>
	 <CAHp75VeWV0+hqCoUb4YvfObnEAv0AaYJmXgpxJLfve+mBwhkyQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVHVlLCAyMDI0LTAyLTA2IGF0IDE2OjIwICswMjAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
Cj4gT24gVHVlLCBGZWIgNiwgMjAyNCBhdCAxMjowOOKAr1BNIE51bm8gU2EgdmlhIEI0IFJlbGF5
Cj4gPGRldm51bGwrbnVuby5zYS5hbmFsb2cuY29tQGtlcm5lbC5vcmc+IHdyb3RlOgo+ID4gCj4g
PiBGcm9tOiBOdW5vIFNhIDxudW5vLnNhQGFuYWxvZy5jb20+Cj4gPiAKPiA+IENvbnZlcnQgdGhl
IGRyaXZlciB0byB1c2UgdGhlIG5ldyBJSU8gYmFja2VuZCBmcmFtZXdvcmsuIFRoZSBkZXZpY2UK
PiA+IGZ1bmN0aW9uYWxpdHkgaXMgZXhwZWN0ZWQgdG8gYmUgdGhlIHNhbWUgKG1lYW5pbmcgbm8g
YWRkZWQgb3IgcmVtb3ZlZAo+ID4gZmVhdHVyZXMpLgo+ID4gCj4gPiBBbHNvIG5vdGUgdGhpcyBw
YXRjaCBlZmZlY3RpdmVseSBicmVha3MgQUJJIGFuZCB0aGF0J3MgbmVlZGVkIHNvIHdlIGNhbgo+
ID4gcHJvcGVybHkgc3VwcG9ydCB0aGlzIGRldmljZSBhbmQgYWRkIG5lZWRlZCBmZWF0dXJlcyBt
YWtpbmcgdXNlIG9mIHRoZQo+ID4gbmV3IElJTyBmcmFtZXdvcmsuCj4gPiAKPiA+IEdpdmluZyB0
aGUgbGFjayBvZiBmZWF0dXJlcyAoYW5kIGRldmljZXMgc3VwcG9ydGVkKSBpbiB0aGUgYWQ5NDY3
IGRyaXZlcgo+IAo+IEdpdmVuCj4gCj4gPiBjb21wYXJlZCB3aXRoIHRoZSBBREkgb3V0IG9mIHRy
ZWUgdmVyc2lvbiwgd2UgZG9uJ3QgZXhwZWN0IGFueSB1c2VyIG9mCj4gPiB0aGUgdXBzdHJlYW0g
ZHJpdmVyIHNvIG5vIG9uZSBzaG91bGQgbm90aWNlIHRoZSBBQkkgYnJlYWthZ2UuIEhvd2V2ZXIs
Cj4gPiBpZiBzb21lb25lIGlzIGFmZmVjdGVkIGJ5IHRoaXMsIEFESSB3aWxsIGhhcHBpbHkgc3Vw
cG9ydCBpbiB0cmFuc2l0aW9uaW5nCj4gCj4gc3VwcG9ydCB0cmFuc2l0aW9uaW5nCj4gCj4gPiB0
byB0aGUgYmFja2VuZCBmcmFtZXdvcmsuCj4gCj4gLi4uCj4gCj4gPiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAubWF4X3JhdGUgPSAyNTAwMDAwMDBVTCwKPiAKPiA+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIC5tYXhfcmF0ZSA9IDUwMDAwMDAwMFVMLAo+IAo+ID4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLm1heF9yYXRlID0gMTI1MDAwMDAwVUwsCj4gCj4gLi4u
Cj4gCj4gPiArc3RhdGljIGludCBhZDk0NjdfdXBkYXRlX3NjYW5fbW9kZShzdHJ1Y3QgaWlvX2Rl
diAqaW5kaW9fZGV2LAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb25zdCB1bnNpZ25lZCBsb25nICpzY2FuX21h
c2spCj4gPiArewo+ID4gK8KgwqDCoMKgwqDCoCBzdHJ1Y3QgYWQ5NDY3X3N0YXRlICpzdCA9IGlp
b19wcml2KGluZGlvX2Rldik7Cj4gPiArwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGludCBjOwo+ID4g
K8KgwqDCoMKgwqDCoCBpbnQgcmV0Owo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoCBmb3IgKGMgPSAw
OyBjIDwgc3QtPmluZm8tPm51bV9jaGFubmVsczsgYysrKSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBpZiAodGVzdF9iaXQoYywgc2Nhbl9tYXNrKSkKPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSBpaW9fYmFja2VuZF9jaGFu
X2VuYWJsZShzdC0+YmFjaywgYyk7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBl
bHNlCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0
ID0gaWlvX2JhY2tlbmRfY2hhbl9kaXNhYmxlKHN0LT5iYWNrLCBjKTsKPiAKPiA+ICsKPiAKPiBV
bm5lZWRlZCBibGFuayBsaW5lLgo+IAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
aWYgKHJldCkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCByZXR1cm4gcmV0Owo+ID4gK8KgwqDCoMKgwqDCoCB9Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKg
IHJldHVybiAwOwo+ID4gK30KPiAKPiAuLi4uCj4gCj4gPiArwqDCoMKgwqDCoMKgIHN0LT5iYWNr
ID0gZGV2bV9paW9fYmFja2VuZF9nZXQoJnN0LT5zcGktPmRldiwgTlVMTCk7Cj4gPiArwqDCoMKg
wqDCoMKgIC8qIElmIG5vdCBmb3VuZCwgZG9uJ3QgZXJyb3Igb3V0IGFzIHdlIG1pZ2h0IGhhdmUg
bGVnYWN5IERUIHByb3BlcnR5ICovCj4gPiArwqDCoMKgwqDCoMKgIGlmICghSVNfRVJSKHN0LT5i
YWNrKSkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAwOwo+ID4gK8Kg
wqDCoMKgwqDCoCBpZiAoUFRSX0VSUihzdC0+YmFjaykgIT0gLUVOT0VOVCkKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBQVFJfRVJSKHN0LT5iYWNrKTsKPiAKPiBUaGlz
IGxvb2tzIGhhY2tpc2guLi4KPiAKClRoaXMgd2FzIHN1Z2dlc3RlZCBieSBKb25hdGhhbiBzbyBJ
J20ga2VlbiBpbiBsZWF2aW5nIGl0IGFzLWlzCgotIE51bm8gU8OhCgo=


