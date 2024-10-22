Return-Path: <linux-iio+bounces-10918-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 662D49A9C51
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 10:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D399BB21178
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 08:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D0716DECB;
	Tue, 22 Oct 2024 08:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c17O3H6A"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD64158D7B;
	Tue, 22 Oct 2024 08:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729585466; cv=none; b=re2hixvB/fhpYG3RRPP18zT/5U2jj5IKIbipy4Yk+tzwxpgXNalTidBAyzITv1/h3mgD0st8+2RFvDjcU0CNYUok35Ms8xi/MTcNUeJpzQqPXrpPElNFHJI8s0lgd01D8DjOjPY13hEmY5VyrMzHW4IC82yu9LGbn9gvsaPQTAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729585466; c=relaxed/simple;
	bh=ukPEnMSX5kbqTfKI6FalbDRRnwjbTnVhFzN7tzRJ8Fw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TVtj390UES4sBsEJfTu2f6n5+0cKsdrO1vq2OxlvArV0GWfTcJRcsn48VG4bPBy2nTR6VvzFAN7iEioWrm0idlPYOIKbd+6yazDOfOkNMV5MYFh7Ve4RieIj+lwfhQ9o9DVHfS3iM9zko+mNqhT3aYAJPv1eZc3+P7aB9V96gek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c17O3H6A; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43161e7bb25so40527725e9.2;
        Tue, 22 Oct 2024 01:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729585463; x=1730190263; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ukPEnMSX5kbqTfKI6FalbDRRnwjbTnVhFzN7tzRJ8Fw=;
        b=c17O3H6AbGnLYtDjJ8LN/KV8chyfI81Z+LZJFS5q6T45WX3x8E+yvYLGW/scr1pCDR
         LRhTMZ7gEetNLe9A1Mc7b/EhwyhuhsbM6eDyl9mdQvLSTjXoN7U2CxjCuG/cQxbbBKy7
         A6D9Eh8vKDW54PjEwj0Jm3ZQUT6P8tUNyuVi/z61TeyahPzYmyP0HmPUlzQClHhosItK
         BVwQbmePz4kDvu25FumaIIqKjebuPFEoe8mES01YR6KWsGCHaKOg1SRKgqRJ5XRFdW1W
         tcx/64SmYAlxqUvAEDQ+K6dnOgtKprK5aRR/bdETUPkBjD2hkXCPtR4z9Rd2qUM6YMVT
         pK0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729585463; x=1730190263;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ukPEnMSX5kbqTfKI6FalbDRRnwjbTnVhFzN7tzRJ8Fw=;
        b=AYkquIpEmyu43LCor5mznI8ZXwu77c95eomjVgLOSY4OOZfZAXSr9CHXvR+0PY8XLp
         j7nZU0WPXDIxP5v1pBCVKib7fR3SLTik2grbNZrdqGgThfSUWzQ5HOgs8leW+5P9uOdl
         kxYRHrT2kTG45ZNNqtCDXIUJPPmK5asklVjFhlau19cmeqDrSDKIUgDtdgVJE1QgiZj0
         UXPyZPzMYAr+yN9dRqggJjqQNjIImztiZijJWeXoY3sWyLSqLuRA4b2bIPP1s+Jb5bHm
         qjAQxsHCWTyiKBYMM4zJppptZbe8nvrELZqNIwaKqUawG2CoVBIwR4ws0ES3MBx1arF4
         i1lA==
X-Forwarded-Encrypted: i=1; AJvYcCUmX+cjrEwbSkcx9S9dHnmTnbrX1R2j7bAhSF1GkQ50hrFplGziTzHhkmJgIEweB5j0G3tEYL6JZZD+@vger.kernel.org, AJvYcCWQKQozdWLQepCrbw/tq5fOs9CHzfsZW8A1+1GJMU1Gzg87LEV9WOdnYHZPRkUMeNjcTlLx//RrIgcw6EOy@vger.kernel.org
X-Gm-Message-State: AOJu0YxdhQGcZsFi+e+lq5chf/S0D8UKu04HBIhAAOVhRVUfQpx/QJhp
	KRjDu/MNrc1fSiQ3/GkQM6DAjOyEyGgVe62b0G3HbCFI67E8b4L0
X-Google-Smtp-Source: AGHT+IGepLLb+O1n6mDqgL9Oop1ZhSrzptoKk9PYdaWutmvWNcfopSTKd5E6TrNqjp7YUqpfVXB/zg==
X-Received: by 2002:a05:600c:1c8d:b0:431:5044:e388 with SMTP id 5b1f17b1804b1-4317b90e37bmr19705365e9.22.1729585462328;
        Tue, 22 Oct 2024 01:24:22 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef15:2100:888:d3c6:a442:4910? (p200300f6ef1521000888d3c6a4424910.dip0.t-ipconnect.de. [2003:f6:ef15:2100:888:d3c6:a442:4910])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5c2d39sm82037085e9.37.2024.10.22.01.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 01:24:22 -0700 (PDT)
Message-ID: <9083e7ff5471e9f8c478a10a67a7c606b81c6287.camel@gmail.com>
Subject: Re: [PATCH 4/6] iio: adc: ad7606: rework scale-available to be
 static
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Alexandru Ardelean <aardelean@baylibre.com>, David Lechner
	 <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, jic23@kernel.org, krzk+dt@kernel.org,
 robh@kernel.org, 	lars@metafoo.de, michael.hennerich@analog.com,
 gstols@baylibre.com
Date: Tue, 22 Oct 2024 10:28:40 +0200
In-Reply-To: <CA+GgBR_tT5J8Lq7DmSw9GdETiRScXzPzcf5UkDk32GLP8tSrQw@mail.gmail.com>
References: <20241021130221.1469099-1-aardelean@baylibre.com>
	 <20241021130221.1469099-5-aardelean@baylibre.com>
	 <0a7c5305-b4f7-4166-8a8a-05cf6e3273cc@baylibre.com>
	 <CA+GgBR_tT5J8Lq7DmSw9GdETiRScXzPzcf5UkDk32GLP8tSrQw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.54.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVHVlLCAyMDI0LTEwLTIyIGF0IDA5OjU5ICswMzAwLCBBbGV4YW5kcnUgQXJkZWxlYW4gd3Jv
dGU6Cj4gT24gTW9uLCBPY3QgMjEsIDIwMjQgYXQgOToxN+KAr1BNIERhdmlkIExlY2huZXIgPGRs
ZWNobmVyQGJheWxpYnJlLmNvbT4gd3JvdGU6Cj4gPiAKPiA+IE9uIDEwLzIxLzI0IDg6MDIgQU0s
IEFsZXhhbmRydSBBcmRlbGVhbiB3cm90ZToKPiA+ID4gVGhlIG1haW4gZHJpdmVyIGZvciB0aGlz
IGNoYW5nZSBpcyB0aGUgQUQ3NjA3IHBhcnQsIHdoaWNoIGhhcyBhIHNjYWxlIG9mCj4gPiA+ICIx
LjIyMDcwMyIgZm9yIHRoZSDCsTEwViByYW5nZS4gVGhlIEFENzYwNyBoYXMgYSByZXNvbHV0aW9u
IG9mIDE0LWJpdHMuCj4gPiA+IAo+ID4gPiBTbywganVzdCBhZGRpbmcgdGhlIHNjYWxlLWF2YWls
YWJsZSBsaXN0IGZvciB0aGF0IHBhcnQgd291bGQgcmVxdWlyZSBzb21lCj4gPiA+IHF1aXJrcyB0
byBoYW5kbGUganVzdCB0aGF0IHNjYWxlIHZhbHVlLgo+ID4gPiBCdXQgdG8gZG8gaXQgbW9yZSBu
ZWF0bHksIHRoZSBiZXN0IGFwcHJvYWNoIGlzIHRvIHJld29yayB0aGUgc2NhbGUKPiA+ID4gYXZh
aWxhYmxlIGxpc3RzIHRvIGhhdmUgdGhlIHNhbWUgZm9ybWF0IGFzIGl0IGlzIHJldHVybmVkIHRv
IHVzZXJzcGFjZS4KPiA+ID4gVGhhdCB3YXksIHdlIGNhbiBhbHNvIGdldCByaWQgb2YgdGhlIGFs
bG9jYXRpb24gZm9yIHRoZSAnc2NhbGVfYXZhaWxfc2hvdycKPiA+ID4gYXJyYXkuCj4gPiA+IAo+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kcnUgQXJkZWxlYW4gPGFhcmRlbGVhbkBiYXlsaWJy
ZS5jb20+Cj4gPiA+IC0tLQo+ID4gCj4gPiAuLi4KPiA+IAo+ID4gCj4gPiA+IMKgc3RhdGljIHNz
aXplX3QgaW5fdm9sdGFnZV9zY2FsZV9hdmFpbGFibGVfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYs
Cj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGRldmljZV9hdHRy
aWJ1dGUKPiA+ID4gKmF0dHIsCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Y2hhciAqYnVmKQo+ID4gPiBAQCAtNzAzLDggKzY5MCwxNiBAQCBzdGF0aWMgc3NpemVfdCBpbl92
b2x0YWdlX3NjYWxlX2F2YWlsYWJsZV9zaG93KHN0cnVjdAo+ID4gPiBkZXZpY2UgKmRldiwKPiA+
ID4gwqDCoMKgwqDCoCBzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2ID0gZGV2X3RvX2lpb19kZXYo
ZGV2KTsKPiA+ID4gwqDCoMKgwqDCoCBzdHJ1Y3QgYWQ3NjA2X3N0YXRlICpzdCA9IGlpb19wcml2
KGluZGlvX2Rldik7Cj4gPiA+IMKgwqDCoMKgwqAgc3RydWN0IGFkNzYwNl9jaGFuX3NjYWxlICpj
cyA9ICZzdC0+Y2hhbl9zY2FsZXNbMF07Cj4gPiA+ICvCoMKgwqDCoCBjb25zdCB1bnNpZ25lZCBp
bnQgKCp2YWxzKVsyXSA9IGNzLT5zY2FsZV9hdmFpbDsKPiA+ID4gK8KgwqDCoMKgIHVuc2lnbmVk
IGludCBpOwo+ID4gPiArwqDCoMKgwqAgc2l6ZV90IGxlbiA9IDA7Cj4gPiA+IAo+ID4gPiAtwqDC
oMKgwqAgcmV0dXJuIGFkNzYwNl9zaG93X2F2YWlsKGJ1ZiwgY3MtPnNjYWxlX2F2YWlsLCBjcy0+
bnVtX3NjYWxlcywKPiA+ID4gdHJ1ZSk7Cj4gPiA+ICvCoMKgwqDCoCBmb3IgKGkgPSAwOyBpIDwg
Y3MtPm51bV9zY2FsZXM7IGkrKykKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBsZW4g
Kz0gc2NucHJpbnRmKGJ1ZiArIGxlbiwgUEFHRV9TSVpFIC0gbGVuLCAiJXUuJTA2dSAiLAo+ID4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB2YWxzW2ldWzBdLCB2YWxzW2ldWzFdKTsKPiA+ID4gK8KgwqDCoMKgIGJ1ZltsZW4gLSAx
XSA9ICdcbic7Cj4gPiA+ICsKPiA+ID4gK8KgwqDCoMKgIHJldHVybiBsZW47Cj4gPiA+IMKgfQo+
ID4gPiAKPiA+ID4gwqBzdGF0aWMgSUlPX0RFVklDRV9BVFRSX1JPKGluX3ZvbHRhZ2Vfc2NhbGVf
YXZhaWxhYmxlLCAwKTsKPiA+IAo+ID4gUHJvYmFibHkgYSByZWFzb24gZm9yIHRoaXMgdGhhdCBJ
IGZvcmdvdCwgYnV0IHdoeSBpcyB0aGlzIGhhbmRsZWQgaW4gYQo+ID4gY3VzdG9tIGF0dHJpYnV0
ZSBpbnN0ZWFkIG9mIGFkNzYwNl9yZWFkX2F2YWlsKCk/Cj4gCj4gWzFdCj4gU28sIHRoaXMgaXMg
YSBxdWlyayBvZiB0aGlzIGRyaXZlciB0aGF0IHdvdWxkIHJlcXVpcmUgYSBiaWdnZXIgY2xlYW51
cC4KPiBJdCBjb3VsZCBiZSBkb25lIGFzIGEgZGlmZmVyZW50IHNlcmllcy4KPiBPciAob3RoZXJ3
aXNlIHNhaWQpIEkgd291bGQgZG8gaXQgaW4gYSBkaWZmZXJlbnQgc2VyaWVzICh1bmxlc3MKPiBy
ZXF1ZXN0ZWQgb3RoZXJ3aXNlKS4KCkFncmVlZC4uLgoKPiAKPiBUaGVzZSBkZXZpY2UtbGV2ZWwg
YXR0cmlidXRlcyBhcmUgYXR0YWNoZWQgaW4gdGhlIHByb2JlKCkgb2YgdGhpcwo+IGRyaXZlciwg
YmFzZWQgb24gdGhlIEdQSU8gY29uZmlndXJhdGlvbnMgcHJvdmlkZWQgdmlhIERULgo+IFRoZXJl
J3MgdGhhdCBiaXQgb2YgY29kZQo+IAo+IMKgwqDCoMKgwqDCoMKgIGlmIChzdC0+Z3Bpb19vcykg
ewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoc3QtPmdwaW9fcmFuZ2UpCj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbmRpb19kZXYt
PmluZm8gPSAmYWQ3NjA2X2luZm9fb3NfYW5kX3JhbmdlOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBlbHNlCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBpbmRpb19kZXYtPmluZm8gPSAmYWQ3NjA2X2luZm9fb3M7Cj4gwqDCoMKgwqDCoMKg
wqAgfSBlbHNlIHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHN0LT5ncGlv
X3JhbmdlKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
aW5kaW9fZGV2LT5pbmZvID0gJmFkNzYwNl9pbmZvX3JhbmdlOwo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBlbHNlCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBpbmRpb19kZXYtPmluZm8gPSAmYWQ3NjA2X2luZm9fbm9fb3Nfb3JfcmFuZ2U7
Cj4gwqDCoMKgwqDCoMKgwqAgfQo+IAo+IFRoZSAicmFuZ2UiIHRoZXJlIHJlZmVycyB0byAic2Nh
bGVfYXZhaWxhYmxlIiwgd2hpY2ggaXMgb25seSBhdHRhY2hlZAo+IGxpa2UgdGhpcywgZm9yIEhX
IG1vZGUuCj4gQSByZXdvcmsgb2YgSFctbW9kZSB3b3VsZCBiZSBhIGdvb2QgaWRlYS4KPiAKCk1h
eWJlIGl0J3MgYWxzbyBkdWUgdG8gLnJlYWRfYXZhaWwoKSBub3QgYmVpbmcgYXJvdW5kIHdoZW4g
dGhlIGRyaXZlciB3YXMgZmlyc3QKYWRkZWQgKGJ1dCBub3Qgc3VyZSBhYm91dCB0aGF0KS4KCi0g
TnVubyBTw6EKCj4gCg==


