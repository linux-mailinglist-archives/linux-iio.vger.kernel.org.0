Return-Path: <linux-iio+bounces-1219-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F7C81C72A
	for <lists+linux-iio@lfdr.de>; Fri, 22 Dec 2023 10:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6446B23AFD
	for <lists+linux-iio@lfdr.de>; Fri, 22 Dec 2023 09:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC676D51E;
	Fri, 22 Dec 2023 09:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xgv+fwIK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AAFFBE2;
	Fri, 22 Dec 2023 09:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40d31116dbeso17803935e9.3;
        Fri, 22 Dec 2023 01:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703236236; x=1703841036; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3qa2I1UxNPe2V/ozbISaHM/D95eJhVfAiUESj4A1epk=;
        b=Xgv+fwIKLsie3I8tU7JGEhzLcdWw6WBoD1+TOK85MZ9ZEkYBj14bL/UIVMkuc7SK/c
         J+40+lTsUnJRdnWew4pjZnW1ddjW9Y7C7GKWdXcRUuz/NQnSP2MXpw9G2oN41+H2RxkL
         nM3CjEqMEgmDM58i9V+tVSeljJm00DGbUxGgtyIUy7wlyvhp2VwDU+/F4WFGjpjCbxja
         PlxLWjrJ/RNxnqfjqKUytmY5X4oLhZ3ngGehtmtn0Ep3Xj2eKYHgLrAx2WDxfWORNR9q
         gPbnc5eKrwdBEXFAmA27MknTR6wv/ul54SDmBgz/SJWa7iBmB0Ph/FBvW7W/4EkNiBVW
         o2ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703236236; x=1703841036;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3qa2I1UxNPe2V/ozbISaHM/D95eJhVfAiUESj4A1epk=;
        b=gu2pS9CXa7GKXZbgNiVaAvc7g0joRYWEPAvZnHcvvXoV/Gs7EXUy5ttSkZSGw7wLCK
         jfN78OX/GJaNnl4YFGM+TsjlpvTQ0lQDbhrUBx1o4yoVjKQdf/Aijd5D6Yco9/cpkona
         a/dHi9iT0xLHneX5Z1o7jGyZddcMesIZYGdbRJWWrMG+AVJ7KAvPFbkybcPW0TRFainP
         FWa5oISe4xfkItxvuKLJcWxj9g1aoQc3zlHDXnSz46H4864uGUIKg8x4ZHHJXPh9zyt/
         POv+mwnWZknvP/JHXFNly6rewpLs6KFzXKGKYG+4LgiVLgtHJRrP1pcnWX1sL6fti009
         oGnA==
X-Gm-Message-State: AOJu0Ywp+Xc+kOYUUObz8W8WVE6P17+SCew2yKJYu2OfslyjCo694iPW
	gZCEfwbBgCjZWDeLqL77oyo=
X-Google-Smtp-Source: AGHT+IFjMc0QAdRTGNyPSyCsuA5h5Jmx1Mynycf5tH9gooGSWWXmEMjr6hJ7zbqmbj47uxVUJZ9nPw==
X-Received: by 2002:a7b:c3c8:0:b0:40c:2cab:3573 with SMTP id t8-20020a7bc3c8000000b0040c2cab3573mr488393wmj.135.1703236236119;
        Fri, 22 Dec 2023 01:10:36 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:5877:261e:1d6d:8696? ([2001:818:ea8e:7f00:5877:261e:1d6d:8696])
        by smtp.gmail.com with ESMTPSA id f17-20020a05600c4e9100b0040c310abc4bsm13955103wmq.43.2023.12.22.01.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 01:10:35 -0800 (PST)
Message-ID: <df4146ef96af56356c77d2971bdf1c6445e13564.camel@gmail.com>
Subject: Re: [PATCH v4 7/8] iio: adc: ad9467: convert to backend framework
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, Olivier Moysan <olivier.moysan@foss.st.com>
Date: Fri, 22 Dec 2023 10:10:36 +0100
In-Reply-To: <20231221175209.457664b5@jic23-huawei>
References: <20231220-iio-backend-v4-0-998e9148b692@analog.com>
	 <20231220-iio-backend-v4-7-998e9148b692@analog.com>
	 <20231221175209.457664b5@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVGh1LCAyMDIzLTEyLTIxIGF0IDE3OjUyICswMDAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Ogo+IE9uIFdlZCwgMjAgRGVjIDIwMjMgMTY6MzQ6MTAgKzAxMDAKPiBOdW5vIFNhIDxudW5vLnNh
QGFuYWxvZy5jb20+IHdyb3RlOgo+IAo+ID4gQ29udmVydCB0aGUgZHJpdmVyIHRvIHVzZSB0aGUg
bmV3IElJTyBiYWNrZW5kIGZyYW1ld29yay4gVGhlIGRldmljZQo+ID4gZnVuY3Rpb25hbGl0eSBp
cyBleHBlY3RlZCB0byBiZSB0aGUgc2FtZSAobWVhbmluZyBubyBhZGRlZCBvciByZW1vdmVkCj4g
PiBmZWF0dXJlcykuCj4gPiAKPiA+IEFsc28gbm90ZSB0aGlzIHBhdGNoIGVmZmVjdGl2ZWx5IGJy
ZWFrcyBBQkkgYW5kIHRoYXQncyBuZWVkZWQgc28gd2UgY2FuCj4gPiBwcm9wZXJseSBzdXBwb3J0
IHRoaXMgZGV2aWNlIGFuZCBhZGQgbmVlZGVkIGZlYXR1cmVzIG1ha2luZyB1c2Ugb2YgdGhlCj4g
PiBuZXcgSUlPIGZyYW1ld29yay4KPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogTnVubyBTYSA8bnVu
by5zYUBhbmFsb2cuY29tPgo+IAo+IEEgZmV3IG1pbm9yIGNvbW1lbnRzLiBMb29rcyBnb29kIHRv
IG1lLgo+IAo+IEpvbmF0aGFuCj4gCj4gPiArc3RhdGljIGludCBhZDk0NjdfdXBkYXRlX3NjYW5f
bW9kZShzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2LAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb25zdCB1bnNp
Z25lZCBsb25nICpzY2FuX21hc2spCj4gPiArewo+ID4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IGFk
OTQ2N19zdGF0ZSAqc3QgPSBpaW9fcHJpdihpbmRpb19kZXYpOwo+ID4gK8KgwqDCoMKgwqDCoMKg
dW5zaWduZWQgaW50IGM7Cj4gPiArwqDCoMKgwqDCoMKgwqBpbnQgcmV0Owo+ID4gKwo+ID4gK8Kg
wqDCoMKgwqDCoMKgZm9yIChjID0gMDsgYyA8IHN0LT5pbmZvLT5udW1fY2hhbm5lbHM7IGMrKykg
ewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICh0ZXN0X2JpdChjLCBzY2Fu
X21hc2spKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqByZXQgPSBpaW9fYmFja2VuZF9jaGFuX2VuYWJsZShzdC0+YmFjaywgYyk7Cj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZWxzZQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXQgPSBpaW9fYmFja2VuZF9jaGFuX2Rpc2FibGUoc3Qt
PmJhY2ssIGMpOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChy
ZXQpCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJl
dHVybiByZXQ7Cj4gPiArwqDCoMKgwqDCoMKgwqB9Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqBy
ZXR1cm4gMDsKPiA+ICt9Cj4gCj4gPiDCoHN0YXRpYyBpbnQgYWQ5NDY3X3Jlc2V0KHN0cnVjdCBk
ZXZpY2UgKmRldikKPiA+IEBAIC00NDMsMjUgKzQ3NSw2MyBAQCBzdGF0aWMgaW50IGFkOTQ2N19y
ZXNldChzdHJ1Y3QgZGV2aWNlICpkZXYpCj4gPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIDA7Cj4g
PiDCoH0KPiA+IMKgCj4gPiArc3RhdGljIGludCBhZDk0NjdfaWlvX2JhY2tlbmRfZ2V0KHN0cnVj
dCBhZDk0Njdfc3RhdGUgKnN0KQo+ID4gK3sKPiA+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBkZXZp
Y2UgKmRldiA9ICZzdC0+c3BpLT5kZXY7Cj4gPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgZGV2aWNl
X25vZGUgKl9fYmFjazsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoHN0LT5iYWNrID0gZGV2bV9p
aW9fYmFja2VuZF9nZXRfb3B0aW9uYWwoJnN0LT5zcGktPmRldiwgTlVMTCk7Cj4gPiArwqDCoMKg
wqDCoMKgwqBpZiAoSVNfRVJSKHN0LT5iYWNrKSkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqByZXR1cm4gUFRSX0VSUihzdC0+YmFjayk7Cj4gCj4gQXMgcGVyIHRoZSBjb21tZW50
IG9uIHByZXZpb3VzIHBhdGNoIEknZCBqdXN0IGdldCBpdCB1c2luZyB0aGUgbm9ybWFsCj4gZnVu
Y3Rpb24gYW5kIGhhbmRsZSBQVFJfRVJSKC1FTk9FTlQpIGhlcmUgYXMgbWVhbmluZyB3ZSBuZWVk
IHRvCj4gdHJ5IHRoZSBvbGQgd2F5LgoKVGhhdCBtYWtlcyBzZW5zZS4gU28gd2UgY2FuIGFkZCBh
IGRldm1faWlvX2JhY2tlbmRfZ2V0X29wdGlvbmFsKCkgQVBJIHdoZW4vaWYgd2UKcmVhbGx5IG5l
ZWQgb25lIGFuZCBub3QganVzdCBmb3IgaGFuZGxpbmcgbGVnYWN5IGNvZGUuCgo+IAo+ID4gK8Kg
wqDCoMKgwqDCoMKgaWYgKHN0LT5iYWNrKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoHJldHVybiAwOwo+ID4gK8KgwqDCoMKgwqDCoMKgLyoKPiA+ICvCoMKgwqDCoMKgwqDCoCAq
IGlmIHdlIGRvbid0IGdldCB0aGUgYmFja2VuZCB1c2luZyB0aGUgbm9ybWFsIEFQSSdzLCB1c2Ug
dGhlIGxlZ2FjeQo+ID4gK8KgwqDCoMKgwqDCoMKgICogJ2FkaSxhZGMtZGV2JyBwcm9wZXJ0eS4g
U28gd2UgZ2V0IGFsbCBub2RlcyB3aXRoIHRoYXQgcHJvcGVydHksIGFuZAo+ID4gK8KgwqDCoMKg
wqDCoMKgICogbG9vayBmb3IgdGhlIG9uZSBwb2ludGluZyBhdCB1cy4gVGhlbiB3ZSBkaXJlY3Rs
eSBsb29rdXAgdGhhdCBmd25vZGUKPiA+ICvCoMKgwqDCoMKgwqDCoCAqIG9uIHRoZSBiYWNrZW5k
IGxpc3Qgb2YgcmVnaXN0ZXJlZCBkZXZpY2VzLiBUaGlzIGlzIGRvbmUgc28gd2UgZG9uJ3QKPiA+
ICvCoMKgwqDCoMKgwqDCoCAqIG1ha2UgaW8tYmFja2VuZHMgbWFuZGF0b3J5IHdoaWNoIHdvdWxk
IGJyZWFrIERUIEFCSS4KPiA+ICvCoMKgwqDCoMKgwqDCoCAqLwo+ID4gK8KgwqDCoMKgwqDCoMKg
Zm9yX2VhY2hfbm9kZV93aXRoX3Byb3BlcnR5KF9fYmFjaywgImFkaSxhZGMtZGV2Iikgewo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBkZXZpY2Vfbm9kZSAqX19tZTsK
PiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBfX21lID0gb2ZfcGFyc2Vf
cGhhbmRsZShfX2JhY2ssICJhZGksYWRjLWRldiIsIDApOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGlmICghX19tZSkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgY29udGludWU7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgaWYgKCFkZXZpY2VfbWF0Y2hfb2Zfbm9kZShkZXYsIF9fbWUpKSB7Cj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG9mX25vZGVfcHV0
KF9fbWUpOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBjb250aW51ZTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Cj4gPiArCj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgb2Zfbm9kZV9wdXQoX19tZSk7Cj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3QtPmJhY2sgPSBkZXZtX2lpb19iYWNrZW5k
X2dldF9mcm9tX2Z3bm9kZV9sb29rdXAoZGV2LAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAKPiA+IG9m
X2Z3bm9kZV9oYW5kbGUoX19iYWNrKSk7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgb2Zfbm9kZV9wdXQoX19iYWNrKTsKPiAKPiBJZiBpdCBsYW5kcyBmaXJzdCB0aGUgcGF0Y2gK
PiBSRkMgUEFUQ0ggMS80XSBvZjogQWRkIGNsZWFudXAuaCBiYXNlZCBhdXRvcmVsZWFzZSB2aWEg
X19mcmVlKGRldmljZV9ub2RlKQo+IG1hcmtpbmdzLgo+IHdpbGwgZ2V0IHJpZCBvZiB0aGlzIG1h
bnVhbCBoYW5kbGluZyBmb3IgeW91IGZvciBib3RoIHRoZSBjb250aW51ZSBhbmQgcmV0dXJuLgo+
IFRoaXMgd2lsbCBtYWtlIGEgdmVyeSBuaWNlIGV4YW1wbGUgZm9yIHRoYXQgOikKClllYWgsIGFu
ZCBJJ2xsIGhhcHBpbHkgcmViYXNlIG9uIHRoYXQuLi4KCi0gTnVubyBTw6EKPiAK


