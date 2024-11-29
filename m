Return-Path: <linux-iio+bounces-12804-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBBE9DC07F
	for <lists+linux-iio@lfdr.de>; Fri, 29 Nov 2024 09:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27A04164BA0
	for <lists+linux-iio@lfdr.de>; Fri, 29 Nov 2024 08:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C059215F330;
	Fri, 29 Nov 2024 08:27:18 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A7515CD52
	for <linux-iio@vger.kernel.org>; Fri, 29 Nov 2024 08:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732868838; cv=none; b=Ie6z2H/tikmUzji83gHl7Snztovgls7Mssr6Qw1ss5zE5PQ82Wr1dupsA20bSyuBSWJeclpnCyAGf8+ZwG3FVsOYiaEv1mPiBKSf8W/m/lx4D4s/VpEl9qyulPKr39XxiwpgK6CUit25L4Dk2ZTsF1DcQDwdr4jI2bdnyBzIrKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732868838; c=relaxed/simple;
	bh=9OM38BJm2Kq1HfvqCnxzzLjQEMaZun8OpHg2xS5uaCU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=OqBoECrHUy0auqo8bbw8aLyKKoB6sRr2YaQ6a2ytK3sS0YyDnCPYRZTeOWUawSCtkUnZDUbzA1Bd4CxwhIwwyTrDpUKWaOoc6u2IXaKiFYUnev/tLoL2T85LOPOBk+6uBhsHzkBmwOnA+yoV7/HE7BqEMg9ww+AXZQvagg9VtWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-4-mUm5h4MMMhayiM6tA7IWsA-1; Fri, 29 Nov 2024 08:27:13 +0000
X-MC-Unique: mUm5h4MMMhayiM6tA7IWsA-1
X-Mimecast-MFC-AGG-ID: mUm5h4MMMhayiM6tA7IWsA
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 29 Nov
 2024 08:26:57 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 29 Nov 2024 08:26:57 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Jakob Hauser' <jahau@rocketmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Linus Walleij <linus.walleij@linaro.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, kernel test robot <lkp@intel.com>
Subject: RE: [PATCH] iio: magnetometer: yas530: Use signed integer type for
 clamp limits
Thread-Topic: [PATCH] iio: magnetometer: yas530: Use signed integer type for
 clamp limits
Thread-Index: AQHbQFyZWpVb6JGTu0SOPl1PuO8j1LLK0lfwgAKVsACAAIfQoA==
Date: Fri, 29 Nov 2024 08:26:57 +0000
Message-ID: <1120a755ef714cb1a1c546fa01939b1f@AcuMS.aculab.com>
References: <20241126234021.19749-1-jahau.ref@rocketmail.com>
 <20241126234021.19749-1-jahau@rocketmail.com>
 <a28168acf9374c60902cdb5aa7608dee@AcuMS.aculab.com>
 <2662b991-bd22-4ff8-b309-77f0e0f6dc86@rocketmail.com>
In-Reply-To: <2662b991-bd22-4ff8-b309-77f0e0f6dc86@rocketmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wfF6K8AGveLTSXj6LxGuhXhWmBzlg9MlE7Oi0bsW0Ac_1732868833
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogSmFrb2IgSGF1c2VyDQo+IFNlbnQ6IDI5IE5vdmVtYmVyIDIwMjQgMDA6MjANCi4uLg0K
PiA+IGFuZCBpdCBzaG91bGQgYmUgY2xhbXAoKSBub3QgY2xhbXBfdmFsKCkuDQo+IA0KPiBJIGFz
c3VtZWQgdGhhdCBjbGFtcF92YWwoKSBpcyBzdGlsbCBuZWVkZWQgYmVjYXVzZSBhY2NvcmRpbmcg
dG8gaXRzDQo+IGRlc2NyaXB0aW9uIGluIGN1cnJlbnQgbWFpbmxpbmUgKDYuMTIpIGluY2x1ZGUv
bGludXgvbWlubWF4LmgsIGNsYW1wKCkNCj4gZG9lcyAic3RyaWN0IHR5cGVjaGVja2luZyIuIFRo
ZSBpbnB1dCB2YWx1ZSBoW10gaXMgb2YgdHlwZSBzMzIgYW5kIHRoZQ0KPiBsaW1pdHMgZGVyaXZl
ZCBmcm9tICJoYWxmX3JhbmdlIiBhcmUgb2YgdHlwZSBpbnQuIEkgaGFkIGEgdHJ5IGNvbXBpbGlu
Zw0KPiB3aXRoIGNsYW1wKCkgYW5kIGRpZG4ndCBnZXQgYW55IHdhcm5pbmdzIG9yIGVycm9ycy4g
RG9lcyB0aGF0IG1lYW4gdGhhdA0KPiBjbGFtcCgpIGlzbid0IHRoYXQgc3RyaWN0IGluIHRoZSBj
dXJyZW50IGltcGxlbWVudGF0aW9uIChhbmQgY29uc2lkZXJpbmcNCj4gdGhlIHBhdGNoIGJlaW5n
IGJhY2twb3J0ZWQpPyBEb2VzIGl0IGp1c3QgY2hlY2sgc2lnbmVkbmVzcyBhbmQgaXMgdGhpcw0K
PiBiZWNhdXNlIGluIGN1cnJlbnQgX19jbGFtcF9vbmNlKCkgaXQgdXNlcyBfX2F1dG9fdHlwZT8N
Cg0KVGhlIGN1cnJlbnQgbWFpbmxpbmUgY29udGFpbnMgcmVsYXhlZCBjaGVja3MgLSB0aGUgY29t
bWVudCBpcyB3cm9uZy4NCg0KSW4gYW55IGNhc2UsIGFmdGVyIHRoZSBjaGFuZ2UsIHRoZXkgYXRl
IGFsbCAnaW50Jy4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwg
QnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVn
aXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==


