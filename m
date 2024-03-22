Return-Path: <linux-iio+bounces-3676-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C44ED886732
	for <lists+linux-iio@lfdr.de>; Fri, 22 Mar 2024 07:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7740F2879E3
	for <lists+linux-iio@lfdr.de>; Fri, 22 Mar 2024 06:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAD010A1A;
	Fri, 22 Mar 2024 06:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJjew59V"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B0BB67D
	for <linux-iio@vger.kernel.org>; Fri, 22 Mar 2024 06:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711090721; cv=none; b=Xg+KUtZnyi0zAtRCaMDrNMdh7AFhwWy7t1wXBWeWvwPaKajGcVsUvDp6UoFM4wRTKQUKPgJCIK0AD6Z2n/ppBJuLfkG918hMVhCOCKEKQtmF2MKjpeDnDl5quAIlkdKjeach/vcnahEc3JwE3CWsSjbTkH0oMX9djbPJtZXjVT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711090721; c=relaxed/simple;
	bh=vUN4AF48FJSArhGzTIfmwNgQIl+vNFUoaTClS91wNPA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t1zm+TWANaH+zflNNIF9Q31uPI7FIwxxnV4/ZDKIYtH7OW1cmHwUZlkJX5HV7Bq6b4lZaZGXzfZMOnQdmG/TivtNsqrcJi7XahUGImH/9wBVTcErUoSElWvCNw/UYhSO5+/QE80GN277/+s/SEjpsbXrUQ8vCOz+lT3p/7EkP3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJjew59V; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-341808b6217so993916f8f.3
        for <linux-iio@vger.kernel.org>; Thu, 21 Mar 2024 23:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711090718; x=1711695518; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vUN4AF48FJSArhGzTIfmwNgQIl+vNFUoaTClS91wNPA=;
        b=XJjew59VSVnLER1SD9mhmRODgoII1XAEPqshvbtoJLgs7/AlVRXKbDW1vywoS1FJli
         8uxV0qH0TcjQw0uQiJqobHDqECzpMgMsoXSTz1CmrjWCSS8fAXlpaRZcelBzAdpb9VCD
         Tc+RSfzSYdEwWAn5Xw57o8VzjHoZS4VmUTgt2AT8bvEG10IDBOFhmx2xYiRplvjwywP1
         h+QJWvossKWNm5R7LsP1idYAmPMHmLM1/80dvY6MJwHaogttd9CQ6Fc/+4aSsTz5pRU9
         XasEiRZImxPRBRsQF75jO62Y8E8XprBArl11iiFujKbus8PgWy2miiGoBuFscUAXnuvW
         a0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711090718; x=1711695518;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vUN4AF48FJSArhGzTIfmwNgQIl+vNFUoaTClS91wNPA=;
        b=Svb4LqkM+qvzJXhQT9fgO4+n14wVzxT+9o5lS0XC6ZZaJo4D9Sr2wdDLKmiQwOwfSU
         fJfpXNyItkve6CngGvwg6pnE3m+Ln3W91z2nLS8PqqyCENRKM0+18NBo9eVA2xilvkBP
         ViJeYy1OSL5jgglYiXly+px/7ZPrLLiXxn7KS0yXk4c+ln1VW+y912NAEYc/iK2tQb9i
         nSkI2aLkvIm50VTuGK1VzqomLs5nG49j9siUTro06VW4Gsx25cl+5YtkAyB/V8jcb9dA
         pRANYkGqjbsox+U7xnTr2Iu5De8bBsODvs5uLb8K2tWqklB/4O3UAsZcofxrOfllTIE8
         e2QQ==
X-Forwarded-Encrypted: i=1; AJvYcCUs7JQVfizpjB45afLPdiFIdF2kjpaYN816UUGJdGv7tc4PoGHmYrE7hENTT2VviybETlOd93Fq4kgzsiDPEREpguiZIIngY0KF
X-Gm-Message-State: AOJu0YwlRhr6FU1U2kmlLrvcZ39OS7zCbBFR+Co1ZMYb88NwWiXJ7wFC
	aQ6moSL0zv+9clvtDiK6yXVGhCIcaN4fhouEoNccJztHY2NGYCiS
X-Google-Smtp-Source: AGHT+IFSXAeuLwEOExoxt9f60WyC7dsm3pH0vWJFtoOOfpRb1Mf/Ywjfwmmv+QPZLAMvVZl41o44EA==
X-Received: by 2002:a05:6000:4586:b0:341:b5d5:a1d6 with SMTP id gb6-20020a056000458600b00341b5d5a1d6mr551123wrb.50.1711090717598;
        Thu, 21 Mar 2024 23:58:37 -0700 (PDT)
Received: from ?IPv6:2001:a61:343e:8301:d737:22b0:7431:8d01? ([2001:a61:343e:8301:d737:22b0:7431:8d01])
        by smtp.gmail.com with ESMTPSA id z6-20020a5d4406000000b0033cf60e268fsm1322486wrq.116.2024.03.21.23.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 23:58:37 -0700 (PDT)
Message-ID: <8bfab6e0f3b5749a60ee66b488835e3b5d843f2f.camel@gmail.com>
Subject: Re: [PATCH 1/2] iio: adxl345: add spi-3wire
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Lothar Rubusch
 <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	linux-iio@vger.kernel.org, eraretuya@gmail.com
Date: Fri, 22 Mar 2024 07:58:36 +0100
In-Reply-To: <4a9c9108-9de0-4ff0-ad1e-1945b09f5388@kernel.org>
References: <20240319212713.257600-1-l.rubusch@gmail.com>
	 <20240319212713.257600-2-l.rubusch@gmail.com>
	 <7f349041-bf2f-434d-a9cd-a82ac902f613@kernel.org>
	 <CAFXKEHZr5S83sra6_eWPS+Hn03rFDPh5nmNHb9dfXYGjfpsx9g@mail.gmail.com>
	 <4a9c9108-9de0-4ff0-ad1e-1945b09f5388@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gRnJpLCAyMDI0LTAzLTIyIGF0IDA2OjM3ICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOgo+IE9uIDIyLzAzLzIwMjQgMDE6MzIsIExvdGhhciBSdWJ1c2NoIHdyb3RlOgo+ID4gCj4g
PiA+ID4gKwo+ID4gPiA+IMKgwqDCoMKgwqAgLyogQmFpbCBvdXQgaWYgbWF4X3NwZWVkX2h6IGV4
Y2VlZHMgNSBNSHogKi8KPiA+ID4gPiDCoMKgwqDCoMKgIGlmIChzcGktPm1heF9zcGVlZF9oeiA+
IEFEWEwzNDVfTUFYX1NQSV9GUkVRX0haKQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHJldHVybiBkZXZfZXJyX3Byb2JlKCZzcGktPmRldiwgLUVJTlZBTCwgIlNQSSBDTEssICVk
IEh6Cj4gPiA+ID4gZXhjZWVkcyA1IE1IelxuIiwKPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzcGktPm1h
eF9zcGVlZF9oeik7Cj4gPiA+ID4gCj4gPiA+ID4gwqDCoMKgwqDCoCByZWdtYXAgPSBkZXZtX3Jl
Z21hcF9pbml0X3NwaShzcGksICZhZHhsMzQ1X3NwaV9yZWdtYXBfY29uZmlnKTsKPiA+ID4gPiAt
wqDCoMKgwqAgaWYgKElTX0VSUihyZWdtYXApKQo+ID4gPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcmV0dXJuIGRldl9lcnJfcHJvYmUoJnNwaS0+ZGV2LCBQVFJfRVJSKHJlZ21hcCksICJF
cnJvcgo+ID4gPiA+IGluaXRpYWxpemluZyByZWdtYXBcbiIpOwo+ID4gPiA+ICvCoMKgwqDCoCBp
ZiAoSVNfRVJSKHJlZ21hcCkpIHsKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRl
dl9lcnJfcHJvYmUoJnNwaS0+ZGV2LCBQVFJfRVJSKHJlZ21hcCksICJFcnJvciBpbml0aWFsaXpp
bmcKPiA+ID4gPiBzcGkgcmVnbWFwOiAlbGRcbiIsCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgUFRSX0VSUihyZWdtYXApKTsKPiA+
ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBQVFJfRVJSKHJlZ21hcCk7Cj4g
PiA+IAo+ID4gPiBXaHkgYXJlIHlvdSBjaGFuZ2luZyBjb3JyZWN0IGNvZGUgaW50byBpbmNvcnJl
Y3Q/Cj4gPiAKPiA+IEknbGwgYWRqdXN0IHRoYXQuIEl0IGxvb2tzIG9kZCwgSSBhZ3JlZSwgYnV0
IGlzIHRoaXMgaW5jb3JyZWN0IGNvZGU/IEkgZm91bmQKPiA+IHNpbWlsYXIgY29kZSBpbiB0aGUg
bmVpZ2hib3IgYWR4bDMxMyBhY2NlbCBkcml2ZXIuIEkgbWF5IGNoYW5nZS91cGRhdGUKPiA+IHRo
YXQgdGhlbiwgdG9vLiBUaGFua8KgwqAgeW91IGZvciB0aGUgaGludHMuCj4gCj4gUGxlYXNlIGV4
cGxhaW4gd2h5IHlvdSBhcmUgZG9pbmcgdGhpcy4gSG93IGlzIHRoaXMgcmVsYXRlZCB0byBhZGRp
bmcgU1BJCj4gMy13aXJlIG1vZGU/Cj4gCj4gCgpZZWFoLi4uIEFscmVhZHkgYXNrZWQgdG8gc2Vw
YXJhdGUgdGhlIHJlZmFjdG9yIGZyb20gdGhlIGZlYXR1cmUgaW4gdHdvIGRpZmZlcmVudApwYXRj
aGVzLgoKLSBOdW5vIFPDoQo=


