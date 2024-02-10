Return-Path: <linux-iio+bounces-2392-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1998385066A
	for <lists+linux-iio@lfdr.de>; Sat, 10 Feb 2024 21:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD37F1F246DC
	for <lists+linux-iio@lfdr.de>; Sat, 10 Feb 2024 20:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6475FBB6;
	Sat, 10 Feb 2024 20:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8RZbiza"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FDC5F87F;
	Sat, 10 Feb 2024 20:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707598715; cv=none; b=WVu2I6a04vBFDImYCtzhQsCk+yO9o/nQaAwu0+iTdIFqe+suoUj7R9hM6z8PfSe5RrTbsAN2yoVFBV0hT8C5cWX5D0i37DHPcEBgO5UQEmcNT/4RTRERdV36wNUy61Z8mpYkxh5edfi1V3I7Jxb1EsvyUmQbP0myZS8pyXxwXxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707598715; c=relaxed/simple;
	bh=b9AKyfC28VqV6MaJxqxyP+fkc+y/Vurpp7AEGP3K/+E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=le7pQY55Le+V270bSLITf8Ib2DwHklRnhbarLm85JhmxoZlJkRxGGnue2kYsGFiy/SDLpOqKvWh8VVnX9YzsEK2bRFbKK6v2OJqSRYIDedqgxTalhYw7grVwuafagCBKffSdgUhHmz7tUz8jBQE/IpxaGFLLLcaYwo2UcMNt2HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8RZbiza; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40fb3b5893eso16322945e9.0;
        Sat, 10 Feb 2024 12:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707598712; x=1708203512; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b9AKyfC28VqV6MaJxqxyP+fkc+y/Vurpp7AEGP3K/+E=;
        b=b8RZbizaALYH8lemCpBBoRap2FxWmJPkB+Uy0ukd7Xy3+KbvdhM+1Wt6ezZSBs+imh
         X1FjAbRxgusQ3cjLYoNzk/NtNhrj2rNetV7KXVZ9RI4Cp1J9ofaJx9o/qbm9SWMRtWrU
         cz4lqiO6XXf/jqere9/rFGNkZ59XQkWi18lw4/pJMdRKo9WCyU7kswpXyZNxgojo8+io
         iWjFKQ3Vp/1F1qY67zZ35PdIGCL+aHDjLQFIIIRv4lcMmT/d0UFlWtIE4KSm64qpIDWg
         58om/hl9nM12Lcn/Qax8lWi8I6yKBF0k8UPmP5/3/lz9WKj/KyrdX4wRVLprkkQZnxaG
         Kvsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707598712; x=1708203512;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b9AKyfC28VqV6MaJxqxyP+fkc+y/Vurpp7AEGP3K/+E=;
        b=qxzoQqEzVFmC+1MUISrHRXrlt/6pw27F8lUrHrV16OTYJhhJ82byYStATTKQ3LRJGr
         Z9bznHc79cK1yEnRMaTWblgRWkpHDDnzEnn1lv2WDMJDagOyKUKjfofi5TZhexiucbs9
         TjbeDW+U8CAVgOetqUC+XASfEdes0wATK1Xq+G4rHYK0XHTZmHKBfad1N0ll0rI1pUvc
         EFwaSx0qDIphdRMHs8LClR8lDS3I2bYd0t5Mom0neBcVX5Pq0aWV90pk6AYtpx/xLRUC
         kuAt3HB8uoohtV7+rL3VeUyAa3r2pDmuCiOtZXgpXmRPI1O302thbsCYLTbVXlFXwa4H
         621w==
X-Gm-Message-State: AOJu0YyuO2ovhJ9jyt65yQ5zXK0PoGX24W5v+NYo93tbpR82WyMwpAZU
	s9LHFYCKbzlPdYt0n2EpZ7n3j1TUEZqkKVy59lia+GQtpQKxLCoj
X-Google-Smtp-Source: AGHT+IFcojfowu+UcpOCjlHcmcDjKFM510MFe4Qyahrr2jYs4Q55N6ltpATj3KcUu3UL0LfrxNMfJQ==
X-Received: by 2002:a05:600c:3544:b0:40f:d14a:624a with SMTP id i4-20020a05600c354400b0040fd14a624amr2340209wmq.18.1707598711660;
        Sat, 10 Feb 2024 12:58:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXTCs9RPcKZAw0K1Iw0Mm3ZzfGOT9n+uT4xj9SESuIVdV29W6ZMFCZaj6TezWkaausR5kn2P1I0GvuEMrXSJPpNMnIe2X+9a+1D2YqXIBue19QY+wvP6eQIVtS/YMGxTo1GvJxoiVtsZ291QcBMSsA5sTiyfGDFx2HuT0I4lb02ZNbpg2mb0TyNBLM+QKojtSs2s58qru81A7Z1vO4A/zZyp1aL6kDcRfchUCfA+38PNd9yT0OD+dLA4s+Ls1H1PjE5efV5f8d8HTcB07X72nUQmms6BEQ8JXIuJyh7BuLfYpmS915t8FLjbFNE/mYz67IVeGxKZiFf79qGSgFppOk0ZKdXmpRDa5Uo6Hib1h+spElbpg/juAbQFB25lNqnTg==
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id w6-20020a05600c474600b0040efc268713sm4266874wmo.26.2024.02.10.12.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 12:58:31 -0800 (PST)
Message-ID: <f2f56085a68e9ffb5ede2b9249a0dbdddfbefc34.camel@gmail.com>
Subject: Re: [PATCH v10 6/7] iio: adc: ad9467: convert to backend framework
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Nuno Sa <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>,  Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
 Frank Rowand <frowand.list@gmail.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>
Date: Sat, 10 Feb 2024 21:58:30 +0100
In-Reply-To: <CAHp75Vd0qcJiw7EPsSjLAG1G8RFymFuRif7FY2YVTBPK9M2KJQ@mail.gmail.com>
References: <20240209-iio-backend-v10-0-3ed842064318@analog.com>
	 <20240209-iio-backend-v10-6-3ed842064318@analog.com>
	 <CAHp75Vd0qcJiw7EPsSjLAG1G8RFymFuRif7FY2YVTBPK9M2KJQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gRnJpLCAyMDI0LTAyLTA5IGF0IDE4OjM3ICswMjAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
Cj4gT24gRnJpLCBGZWIgOSwgMjAyNCBhdCA1OjI24oCvUE0gTnVubyBTYSA8bnVuby5zYUBhbmFs
b2cuY29tPiB3cm90ZToKPiA+IAo+ID4gQ29udmVydCB0aGUgZHJpdmVyIHRvIHVzZSB0aGUgbmV3
IElJTyBiYWNrZW5kIGZyYW1ld29yay4gVGhlIGRldmljZQo+ID4gZnVuY3Rpb25hbGl0eSBpcyBl
eHBlY3RlZCB0byBiZSB0aGUgc2FtZSAobWVhbmluZyBubyBhZGRlZCBvciByZW1vdmVkCj4gPiBm
ZWF0dXJlcykuCj4gPiAKPiA+IEFsc28gbm90ZSB0aGlzIHBhdGNoIGVmZmVjdGl2ZWx5IGJyZWFr
cyBBQkkgYW5kIHRoYXQncyBuZWVkZWQgc28gd2UgY2FuCj4gPiBwcm9wZXJseSBzdXBwb3J0IHRo
aXMgZGV2aWNlIGFuZCBhZGQgbmVlZGVkIGZlYXR1cmVzIG1ha2luZyB1c2Ugb2YgdGhlCj4gPiBu
ZXcgSUlPIGZyYW1ld29yay4KPiA+IAo+ID4gR2l2ZW4gdGhlIGxhY2sgb2YgZmVhdHVyZXMgKGFu
ZCBkZXZpY2VzIHN1cHBvcnRlZCkgaW4gdGhlIGFkOTQ2NyBkcml2ZXIKPiA+IGNvbXBhcmVkIHdp
dGggdGhlIEFESSBvdXQgb2YgdHJlZSB2ZXJzaW9uLCB3ZSBkb24ndCBleHBlY3QgYW55IHVzZXIg
b2YKPiA+IHRoZSB1cHN0cmVhbSBkcml2ZXIgc28gbm8gb25lIHNob3VsZCBub3RpY2UgdGhlIEFC
SSBicmVha2FnZS4gSG93ZXZlciwKPiA+IGlmIHNvbWVvbmUgaXMgYWZmZWN0ZWQgYnkgdGhpcywg
QURJIHdpbGwgaGFwcGlseSBzdXBwb3J0IHRyYW5zaXRpb25pbmcKPiA+IHRvIHRoZSBiYWNrZW5k
IGZyYW1ld29yay4KPiAKPiAuLi4KPiAKPiA+IMKgc3RydWN0IGFkOTQ2N19jaGlwX2luZm8gewo+
ID4gLcKgwqDCoMKgwqDCoCBzdHJ1Y3QgYWRpX2F4aV9hZGNfY2hpcF9pbmZvwqDCoMKgIGF4aV9h
ZGNfaW5mbzsKPiA+IC3CoMKgwqDCoMKgwqAgdW5zaWduZWQgaW50wqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgZGVmYXVsdF9vdXRwdXRfbW9kZTsKPiA+IC3CoMKgwqDCoMKg
wqAgdW5zaWduZWQgaW50wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdnJl
Zl9tYXNrOwo+ID4gK8KgwqDCoMKgwqDCoCBjb25zdCBjaGFywqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgKm5hbWU7Cj4gPiArwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGludMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgaWQ7Cj4gPiArwqDCoMKgwqDCoMKgIGNvbnN0IHN0cnVjdMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgaWlvX2NoYW5fc3BlYyAqY2hhbm5lbHM7Cj4gPiArwqDCoMKgwqDCoMKgIHVuc2ln
bmVkIGludMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbnVtX2NoYW5uZWxzOwo+ID4gK8KgwqDCoMKg
wqDCoCBjb25zdCB1bnNpZ25lZCBpbnTCoMKgwqDCoMKgICgqc2NhbGVfdGFibGUpWzJdOwo+ID4g
K8KgwqDCoMKgwqDCoCBpbnTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IG51bV9zY2FsZXM7Cj4gPiArwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGxvbmfCoMKgwqDCoMKgwqDC
oMKgwqDCoCBtYXhfcmF0ZTsKPiA+ICvCoMKgwqDCoMKgwqAgdW5zaWduZWQgaW50wqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBkZWZhdWx0X291dHB1dF9tb2RlOwo+ID4gK8KgwqDCoMKgwqDCoCB1bnNp
Z25lZCBpbnTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZyZWZfbWFzazsKPiA+IMKgfTsKPiAKPiBT
ZWVtcyBsaWtlIHlvdSBoYXZlbid0IGNoZWNrZWQgdGhpcyBsYXlvdXQgd2l0aCBgcGFob2xlYC4K
PiAKCk5vdCByZWFsbHkuLi4gSUlSQywgSSBqdXN0IGNvcGllZCB0aGUgbWVtYmVycyBhcy1pcyBm
cm9tIHRoZSBwcmV2aW91cyBzdHJ1Y3QuIENhbiBiZQpkb25lIGxhdGVyIEkgZ3Vlc3MuLi4KCj4g
Li4uCj4gCj4gPiArc3RhdGljIGludCBhZDk0NjdfaWlvX2JhY2tlbmRfZ2V0KHN0cnVjdCBhZDk0
Njdfc3RhdGUgKnN0KQo+ID4gK3sKPiA+ICvCoMKgwqDCoMKgwqAgc3RydWN0IGRldmljZSAqZGV2
ID0gJnN0LT5zcGktPmRldjsKPiA+ICvCoMKgwqDCoMKgwqAgc3RydWN0IGRldmljZV9ub2RlICpf
X2JhY2s7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgIHN0LT5iYWNrID0gZGV2bV9paW9fYmFja2Vu
ZF9nZXQoJnN0LT5zcGktPmRldiwgTlVMTCk7Cj4gCj4gU2ltcGx5ICdkZXYnIGFzIHRoZSBmaXJz
dCBwYXJhbWV0ZXI/Cj4gCgpNYWtlcyBzZW5zZS4uLgoKPiAuLi4KPiAKPiA+ICvCoMKgwqDCoMKg
wqAgLyogSWYgbm90IGZvdW5kLCBkb24ndCBlcnJvciBvdXQgYXMgd2UgbWlnaHQgaGF2ZSBsZWdh
Y3kgRFQgcHJvcGVydHkgKi8KPiAKPiBUaGlzIHNlZW1zIHJlbGF0ZWQgdG8gRU5PRU5ULCBjb3Jy
ZWN0PwoKWWVhaCwgdGhlIGNvbW1lbnRzIGFyZSBpbiBsaW5lIHdpdGggdGhlIG9yaWdpbmFsIHZl
cnNpb24gb2YgdGhlIGNvZGUgd2hlcmUgSSB3YXMKZmlyc3QgY2hlY2tpbmcgZm9yIGVycm9ycy4K
Ci0gTnVubyBTw6EKCg==


