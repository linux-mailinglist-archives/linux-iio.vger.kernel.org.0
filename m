Return-Path: <linux-iio+bounces-7841-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F7193B16E
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jul 2024 15:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B88641C232BB
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jul 2024 13:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BC0158D65;
	Wed, 24 Jul 2024 13:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gd3nDJ2C"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F09184A3B;
	Wed, 24 Jul 2024 13:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721827007; cv=none; b=THWGzt2NjshZ8YDuqOmxLexzkXw5Vg1viaV9fsTxiYG0GZpqjPFORPefb93ugU8jJuJNs5sLku2/H+O7/E417PSLBoWT6pipddr08GMjjxSx7YwZ6sGNm/u7V9Tly6O1nUbi16PRFLgo97Tzk6PRuf64HpMXFnNXECTh9KggFbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721827007; c=relaxed/simple;
	bh=VJEbn3hx7Qfp9hFtEukB6X4Zq4vvWt2oaOtsIBvUpWg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aJmkfKzsWOh3p6AFR8kZgRNxX2hKEIMTvXAkaM8FBXfeLRdxU4IG0Fe089XS7CtsXFEo3C+MywPhx9sa5pmwln0XrPjnMW8E2fZQAbnjxYdLCqNlvUY1VRNQISiTzcBfhbRO1+qOnwKsz0m7aMcGmLTbb5kCXpubEf0FoJiyWQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gd3nDJ2C; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52efbb55d24so6357310e87.1;
        Wed, 24 Jul 2024 06:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721827004; x=1722431804; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VJEbn3hx7Qfp9hFtEukB6X4Zq4vvWt2oaOtsIBvUpWg=;
        b=gd3nDJ2CL4vUtHTZTK2MGxthbyJRhXYoY99hjYH85ZZlCgUmu+1yr1/5DXtPCnbl5w
         6VbifeRHi5SM2rjnZKWLtVIRKKWEWD4CPCC3AA55tIRyVDjN+eYwOy8A5UXXr2vGTvcn
         XdrJig37sGAEi2iQE6z1AAJu1NbA2o1m4vuwcqmmv9QiGh/1HOyd7Ae3YFbxCyOCNH2h
         ZexFJT372w7/6qiVIjGMYn1XdpR7efzfdQXfnE9VSJ/jNiSUROcakTkJnyDoccbCgj6G
         YenJ8Jr3a3v+xLfgWcfRdE67bNrkBlxOx4R6MuDUsr/J3j8XZtB1qk0oojRLaaFqhYc8
         Sibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721827004; x=1722431804;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VJEbn3hx7Qfp9hFtEukB6X4Zq4vvWt2oaOtsIBvUpWg=;
        b=kkQ5GO7r6OMSt3LerrWAyLt2KcnZn5EJoK0iuh5sBUWYzhqT6cqE4b8dqGTj21yerU
         gtkgpySwnmXiR0cMZQkLlQPI5Yw/SF4oRJoSJdNv1KHNWa/EnZCifF1D/149cdjWujh6
         X9UHMgHoQAtqOFHBDNQxqmbhP1VMGgoLtwh+Nzi70g9lDVGEgKOyZKLEcdAjL+yCZLck
         gHJZO/AwoQlTK6PSCNIi3h1orB10UlpbMv9eVnzKLFA8cmRVkiWP4EoPKgQVnodQxZok
         fB8/mFE/ezNq2lt8zizCotvGmL5TCY4mM9SE/wSNLYQhr18KauvzXsDcTpB5cG41dgYg
         1e2g==
X-Forwarded-Encrypted: i=1; AJvYcCVJuIE2D9b+4i9NAlGcyuO7cmzO5eonMROzRhaVDWndCrO9Zm+yw07l4447ooIgvVWJ6NN/YpoOwiDcTkARnWeWeIID+rLDRzouqP3RRvJwqdB1ETe3T51TweQKx6r73lVohz6ju0RZOOi+YrXjkGpi0l0of/pG7DLh5fQE0/BAYGoFt03aWDlGeG5lT4fexWORy6mimFx/G5C8t7rFWg==
X-Gm-Message-State: AOJu0YxRaZ8fEeqM+UlKbWN44FLrot6QF5gTE6Lz81R5jFA6UH2iEexK
	r0T+Y5ZAfUhLAyDY9WiX7uFEncJjrle2wonfZ7N6zMn0kQdjuigT
X-Google-Smtp-Source: AGHT+IEo5GcGQlbhMWSVyzXWNhjW7kQjqSRdND9lxP46rH6Ynn4NdW5veo+8NEowfdia47ZfhlZa9A==
X-Received: by 2002:a05:6512:1091:b0:52e:710e:e4d2 with SMTP id 2adb3069b0e04-52fcda70ff2mr2712545e87.33.1721827003212;
        Wed, 24 Jul 2024 06:16:43 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:359b:e801:d44:32b3:6924:10d1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7aba28329esm38563966b.142.2024.07.24.06.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 06:16:42 -0700 (PDT)
Message-ID: <d65739eededdf2f430f60736518a98aaa3f0b3ca.camel@gmail.com>
Subject: Re: [PATCH RFC v3 0/9] spi: axi-spi-engine: add offload support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>, 
 Jonathan Cameron
	 <jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Lars-Peter Clausen
	 <lars@metafoo.de>, David Jander <david@protonic.nl>, Martin Sperl
	 <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org
Date: Wed, 24 Jul 2024 15:16:42 +0200
In-Reply-To: <9fd9ed71-4b2d-49a7-9432-1747ae2e9aef@baylibre.com>
References: 
	<20240722-dlech-mainline-spi-engine-offload-2-v3-0-7420e45df69b@baylibre.com>
	 <75511e8371f7ffea1ed84a784231f3dc51363842.camel@gmail.com>
	 <9fd9ed71-4b2d-49a7-9432-1747ae2e9aef@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVHVlLCAyMDI0LTA3LTIzIGF0IDA4OjQ4IC0wNTAwLCBEYXZpZCBMZWNobmVyIHdyb3RlOgo+
IE9uIDcvMjMvMjQgMjozNSBBTSwgTnVubyBTw6Egd3JvdGU6Cj4gPiBIaSBEYXZpZCwKPiA+IAo+
ID4gCj4gPiBJIHRoaW5rIHRoZXJlIGFyZSB0aGluZ3MgdGhhdCB3ZSBuZWVkIHRvIGJldHRlciBm
aWd1cmUgYnV0IHRoaW5ncyBhcmUgaW1wcm92aW5nCj4gPiBJTU8gOikKPiA+IAo+ID4gSSdtIG9u
bHkgZG9pbmcgYSB2ZXJ5IHN1cGVyZmljaWFsIHJldmlldyBzaW5jZSBJIG5lZWQgdG8gYmV0dGVy
IGxvb2sgYXQgdGhlCj4gPiBwYXRjaGVzLi4uCj4gPiAKPiA+IEJ1dCBvbmUgdGhpbmcgdGhhdCBJ
IGRvIHdhbnQgdG8gbWVudGlvbiBpcyBhIHNjZW5hcmlvIChhbm90aGVyIGZ1bm55IG9uZS4uLikK
PiA+IHRoYXQgSSd2ZSBkaXNjdXNzaW5nIGFuZCB0aGF0IG1pZ2h0IGJlIGEgcmVhbGl0eS4gU29t
ZXRoaW5nIGxpa2U6Cj4gPiAKPiA+ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tK8Kg
wqDCoCArLS0tLS0tLS0tLS0tLS0tLS0tKwo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgwqAgfMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfAo+ID4gPiDCoFNPQy9GUEdBwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgwqAgfMKgwqAgQURDwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB8Cj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfMKgwqDCoCB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB8Cj4gPiA+IMKgwqDCoMKgwqAgKy0tLS0tLS0tLS0tLS0tLSvCoMKgwqDCoMKgwqAgfMKgwqDC
oCB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8Cj4gPiA+IMKgwqDCoMKgwqAg
fMKgIFNQSSBQUyBaeW5xwqAgfD09PT09PT09PT09PT09IFNQSSBCdXPCoMKgwqDCoMKgwqDCoMKg
IHwKPiA+ID4gwqDCoMKgwqDCoCArLS0tLS0tLS0tLS0tLS0tK8KgwqDCoMKgwqDCoCB8wqDCoMKg
IHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwKPiA+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoMKgIHzC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwKPiA+ID4gwqArLS0tLS0tLS0tLS0t
LS0tLS0tLS0tK8KgwqDCoMKgwqAgfMKgwqDCoCB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB8Cj4gPiA+IMKgfCBBWEkgU1BJIEVuZ2luZcKgwqDCoMKgwqAgfMKgwqDCoMKgwqAg
fMKgwqDCoCB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8Cj4gPiA+IMKgfMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHY9PT09PT09PT09PT09PT09IERBVEEgQnVz
wqDCoMKgwqDCoMKgwqDCoCB8Cj4gPiA+IMKgfCDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgdsKgwqAgfMKgwqDCoMKgwqAgfMKgwqDCoCB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB8Cj4gPiA+IMKgfMKgwqAgKy0tLS0tLS0tLS0tLS0tLSsgfMKgwqDCoMKgwqAgfMKg
wqDCoCB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8Cj4gPiA+IMKgfMKgIHwg
T2ZmbG9hZCAwwqDCoMKgwqAgfMKgIHzCoMKgwqDCoMKgIHzCoMKgwqAgKy0tLS0tLS0tLS0tLS0t
LS0tLSsKPiA+ID4gwqB8wqAgfMKgwqAgUlggREFUQSBPVVQgfMKgIHzCoMKgwqDCoMKgIHwKPiA+
ID4gwqB8wqAgfMKgwqDCoCBUUklHR0VSIElOIHzCoCB8wqDCoMKgwqDCoCB8Cj4gPiA+IMKgfMKg
ICstLS0tLS0tLS0tLS0tLS0rwqAgfMKgwqDCoMKgwqAgfAo+ID4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwKPiA+ICstLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKwo+ID4gCj4gPiBGcm9tIHRoZSBhYm92ZSwgdGhlIHNw
aSBjb250cm9sbGVyIGZvciB0eXBpY2FsIHJlZ2lzdGVyIGFjY2Vzcy9jb25maWd1cmF0aW9uIGlz
Cj4gPiBub3QgdGhlIHNwaV9lbmlnaW5lIGFuZCB0aGUgb2ZmbG9hZCBjb3JlIGlzIHByZXR0eSBt
dWNoIG9ubHkgdXNlZCBmb3Igc3RyZWFtaW5nCj4gPiBkYXRhLiBTbyBJIHRoaW5rIHlvdXIgY3Vy
cmVudCBhcHByb2FjaCB3b3VsZCBub3Qgd29yayB3aXRoIHRoaXMgdXNlY2FzZS4gSW4geW91cgo+
ID4gZmlyc3QgUkZDIHlvdSBoYWQgc29tZXRoaW5nIG92ZXJseSBjb21wbGljYXRlZCAoSU1ITykg
YnV0IHlvdSBhbHJlYWR5IGhhZCBhCj4gPiBjb25jZXB0IHRoYXQgbWF5YmUgaXQncyB3b3J0aCBs
b29raW5nIGF0IGFnYWluLiBJIG1lYW4gaGF2aW5nIGEgc3BpX29mZmxvYWQKPiA+IG9iamVjdCB0
aGF0IGNvdWxkIGRlc2NyaWJlIGl0IGFuZCBtb3JlIGltcG9ydGFudGx5IGhhdmUgYSBwcm92aWRl
ci9jb25zdW1lcgo+ID4gbG9naWMgd2hlcmUgYSBzcGkgY29uc3VtZXIgKG9yIG1heWJlIGV2ZW4g
c29tZXRoaW5nIGVsc2U/KSBjYW4gZ2V0KCkvcHV0KCkgYW4KPiA+IG9mZmxvYWQgb2JqZWN0IHRv
IHN0cmVhbSBkYXRhLgo+IAo+IEFsdGhvdWdoIGl0IGlzbid0IGN1cnJlbnRseSBpbXBsZW1lbnRl
ZCB0aGlzIHdheSBpbiB0aGUgY29yZSBTUEkgY29kZSwgSSB0aGluawo+IHRoZSBEVCBiaW5kaW5n
cyBwcm9wb3NlZCBpbiB0aGlzIHZlcnNpb24gb2YgdGhlIHNlcmllcyB3b3VsZCBhbGxvdyBmb3Ig
dGhpcy4KPiBUaGUgb2ZmbG9hZCBwcm92aWRlciBpcyBqdXN0IHRoZSBvbmUgd2l0aCB0aGUgI3Nw
aS1vZmZsb2FkLWNlbGxzIGFuZCBkb2Vzbid0Cj4gbmVjZXNzYXJpbHkgaGF2ZSB0byBiZSB0aGUg
cGFyZW50IG9mIHRoZSBTUEkgcGVyaXBoZXJhbC4KPiAKCkkgZ2V0IHRoYXQgYnV0IHRoZSB0aGlu
ZyBpcyB0aGF0IHdoZW4gdGhlIHNwaSBkZXZpY2UgY29uc3VtaW5nIGFuIG9mZmxvYWQgc2Vydmlj
ZSBpcwp1bmRlciB0aGUgc2FtZSBjb250cm9sbGVyIHByb3ZpZGluZyB0aGF0IHNlcnZpY2Ugd2Ug
aGF2ZSBndWFyYW50ZWVzIHJlZ2FyZGluZwpsaWZldGltZXMuIEluIGNhc2UgdGhlIG9mZmxvYWQg
aXMgYW5vdGhlciBjb250cm9sbGVyLCB0aG9zZSBndWFyYW50ZWVzIGFyZSBub3QgdHJ1ZQphbnlt
b3JlIGFuZCB3ZSBuZWVkIHRvIG1ha2Ugc3VyZSB0byBoYW5kbGUgdGhpbmdzIGNvcnJlY3RseSAo
bGlrZSB0aGUgY29udHJvbGxlcgpnb2luZyBhd2F5IHVuZGVyIG91ciBmZWV0KS4gVGhhdCdzIHdo
eSBhIHByb3BlciBwcm92aWRlci9jb25zdW1lciBpbnRlcmZhY2UgaXMgbmVlZGVkCmFuZCBJIHRo
aW5rIHRoYXQncyBhIHNpZ25pZmljYW50IHNoaWZ0IGZyb20gd2hhdCB3ZSBoYXZlIG5vdz8KCk91
dCBvZiBteSBoZWFkICh0aGUgbWluaW1hbCBpbnRlcmZhY2UpOgoKc3BpX2NvbnRyb2xsZXJfb2Zm
bG9hZF9yZWdpc3RlcigpIC0gd2UgbWF5IG5lZWQgYSBsaXN0IG9mIHJlZ2lzdGVyIG9mZmxvYWRz
IGluIHRoZQpjb250cm9sbGVyIHN0cnVjdC4KKGRldm1fKXNwaV9vZmZsb2FkX2dldCgpIC0gYW5k
IHRoaXMgb25lIGNvdWxkIHJldHVybiBhIG5pY2Ugc3RydWN0IHNwaV9vZmZsb2FkCmFic3RyYWN0
aW9uIHRvIHBhc3MgdG8gdGhlIG90aGVyIEFQSXMKc3BpX29mZmxvYWRfcHV0KCkKCk9yIGZvciBz
dGFydGVycyB3ZSBtYXkgc2tpcCB0aGUgcmVnaXN0ZXJpbmcgaW4gdGhlIGNvcmUgYW5kIGhhdmUg
aXQgcGVyIGRyaXZlciBidXQgaWYKd2UgYXNzdW1lIG1vcmUgY29udHJvbGxlcyB3aWxsIGhhdmUg
dGhpcyB3ZSBtaWdodCBqdXN0IG1ha2UgaXQgY29tbW9uIGNvZGUgYWxyZWFkeS4KCkp1c3Qgc29t
ZSBpZGVhcy4uLgoKLSBOdW5vIFPDoQoK


