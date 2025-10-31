Return-Path: <linux-iio+bounces-25717-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FDDC23AF5
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 09:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3009D40324A
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 08:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C168B3321C0;
	Fri, 31 Oct 2025 08:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zNV0YwNP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBAA2D2499
	for <linux-iio@vger.kernel.org>; Fri, 31 Oct 2025 08:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761897911; cv=none; b=ZdixWw0X96LTs43ptdb0r6Z6cCSdyr3CzAzhLRhq4KGiNCG5yUKbRLKfZDKdAgYPXXh6WKaudJitWTLuE3A60g4R13c1juNY06z8cfcKsOu1Z7osioH8S2zboWvWPACjzGLSnOZQ+hphXWgpfpWMd5RwreGCuFQg8G+nRquMNb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761897911; c=relaxed/simple;
	bh=mD0xW8QVtnKgD1gZQLzzt3/Jly+T1bkCMJOeJ1R80Hc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JDqMSj1nrRp3jhH7edgm0noC8grBlycL6libnaP0Fpw9hn6cB/MZ5lNtghZvsTeYWiM4+rHtY2Xk7pshihQR7+P6+qg/+966RiQ7kWJ5F4h1NquvpNUWUBjHNMHUI9mGtEa9E+ql97dwM2lf5rZe5NDAgqKhdvuWUz3eYSLBp/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zNV0YwNP; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b64cdbb949cso252131366b.1
        for <linux-iio@vger.kernel.org>; Fri, 31 Oct 2025 01:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761897905; x=1762502705; darn=vger.kernel.org;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mD0xW8QVtnKgD1gZQLzzt3/Jly+T1bkCMJOeJ1R80Hc=;
        b=zNV0YwNPjk/HmigNdpfr75UIYl3wk6bNvV+04c2yaJk3XuUbwmxnC8d0eAgRvG5jhH
         NYRgnEywM79MlPn0qUjBJyyy8IFAF7mNOLxSO4Bg/kLJjPotT3if+f9DcmOcnweTwwgz
         EIKFxqEhvZmmYb6bQwQyd3XrTt08BWGTXbpYJNNZq7hrWNu0tNZOI6Mpfrwu7iQPUG8x
         L1NtHCFNvNw9ZPwT9W+oqL+f0kxHIR2LlfIMdGDFIgr3TtUvZXppj9Z739av00wS4KYd
         jaljGPmzx1UTjN6PVAjJ24+SeW63C7FBK5y342LD2dqpECJI0aHC/mLVDVGym9QJcHCw
         /hBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761897905; x=1762502705;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mD0xW8QVtnKgD1gZQLzzt3/Jly+T1bkCMJOeJ1R80Hc=;
        b=IOwJ1K20q2DgMF15ly23RzXbbAD9SsHS9wePkUZez1bV4Y8BVlr4wU6426/EHuICRA
         SyZHddy9n5mi9y/z32BHeQ3bJvEAo+RwQ5BAW5DrATUAjphbbPl2azn0qKByKszfKrI0
         cqis0Xn6ztJDXFLClwBD1NdHfZp5XdHYidl7S7gOt37n1yd5ZXZo+jdvAJRtYr66euf5
         3Wi2z6+Wlv+k8TO/op0z+YoKUVl2JVirHDd9+X7jTKEBZ8w0YBW2pqDH0Hy04tJjiUdb
         G3z8Nc8GcIPJZOdO8+idb8UfRGeM3gceLaP96bBXtJASO7AkVyKtqYqX30HoiI0aZ6u4
         OROA==
X-Forwarded-Encrypted: i=1; AJvYcCUzP/JqcRocUhzsWtOBLoLHbZ11tsPL+YWeErZO4ZFZDC4pOCn+2x698Rnyf0bebqTTK2+MnFjYQt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWF/xn6nLv6f2zSoIcIvnBZNqnIpPfl1YPDkjRDO2yJL/Y2CWc
	WOIm+F/qorJAGFqZi3OzQEiodTzbjXYYm1ubU5BIySKjvgJ1WuZfDCyl7Jl2t8CfM3wpsEbCRwD
	1XJrY
X-Gm-Gg: ASbGnctAyerIkXdK+WfQatYF3PvFeM7zOHDULP64A47YfOkT5mlo+Uc3OWYcn7HoEse
	gtSejZR+CA2q379khP1oeq30gG5R1f8Y62dG9pi6ckPcVTS6WEnoZf67o0GTN0eIilPBBbufZjI
	HaBiKn972Eyk0ttR+Mg8K5pU6c+uGLB6j7lKl0sNunQTX33CnFyFQf81aq3uQ/zQDYcq1nSTxs3
	79KK05SySnYpUEO3SHSCoymyzGO9MDyj8rpJoOLQiUw49rdCTBXSXTt5nL6n5a7RoLSTubUDgdC
	ZnE7vLNtqWJJWfddYj1fkfMDpZRH+F/VtZfY4LiUnKYcSCO0wYIIg3Voo/sfVh8UM9PthzexTsl
	hUjExYKD+n50uTZPPjBvZehjzNfvqhYSRtSidoS+ZCEz9HhK2WpWxgC50Q9/48UFbfBhDRXFv27
	gHKlyoEZD1tYDUVp2x8qb4WJ7QU60fUumaBEnel7d20c+HfwJmmtu0hYz1P3UA
X-Google-Smtp-Source: AGHT+IEG7PHRhOHpijuZ94sWsW74TnKdkyTWb8DZdTCzy6ZoIsKO5klDA673KDunUlstHrt9kN3+CQ==
X-Received: by 2002:a17:906:7314:b0:b6d:6950:a7b7 with SMTP id a640c23a62f3a-b707061d8edmr244446566b.44.1761897905072;
        Fri, 31 Oct 2025 01:05:05 -0700 (PDT)
Received: from [10.203.83.168] (mob-176-247-67-93.net.vodafone.it. [176.247.67.93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077c3ea35sm109814366b.34.2025.10.31.01.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 01:05:04 -0700 (PDT)
Message-ID: <55cf525d734878369f936834cca60ce7972d268a.camel@baylibre.com>
Subject: Re: [PATCH 1/9] iio: imu: st_lsm6dsx: dynamically initialize
 iio_chan_spec data
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>,  Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,  linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 31 Oct 2025 09:04:58 +0100
In-Reply-To: <aQOVcCinTd-ZJJX3@lore-desk>
References: <20251030072752.349633-1-flavra@baylibre.com>
	 <20251030072752.349633-2-flavra@baylibre.com> <aQOVcCinTd-ZJJX3@lore-desk>
Organization: BayLibre
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-NCr1XTwotSCxM0ebAV+p"
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-NCr1XTwotSCxM0ebAV+p
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

T24gVGh1LCAyMDI1LTEwLTMwIGF0IDE3OjQyICswMTAwLCBMb3JlbnpvIEJpYW5jb25pIHdyb3Rl
Ogo+ID4gVXNpbmcgdGhlIFNUX0xTTTZEU1hfQ0hBTk5FTF9BQ0MoKSBtYWNybyBhcyBhIHN0YXRp
YyBpbml0aWFsaXplcgo+ID4gZm9yIHRoZSBpaW9fY2hhbl9zcGVjIHN0cnVjdCBhcnJheXMgbWFr
ZXMgYWxsIHNlbnNvcnMgYWR2ZXJ0aXNlCj4gPiBjaGFubmVsIGV2ZW50IGNhcGFiaWxpdGllcyBy
ZWdhcmRsZXNzIG9mIHdoZXRoZXIgdGhleSBhY3R1YWxseQo+ID4gc3VwcG9ydCBldmVudCBnZW5l
cmF0aW9uLiBBbmQgaWYgdXNlcnNwYWNlIHRyaWVzIHRvIGNvbmZpZ3VyZQo+ID4gYWNjZWxlcm9t
ZXRlciB3YWtldXAgZXZlbnRzIG9uIGEgc2Vuc29yIGRldmljZSB0aGF0IGRvZXMgbm90Cj4gPiBz
dXBwb3J0IHRoZW0gKGUuZy4gTFNNNkRTMCksIHN0X2xzbTZkc3hfd3JpdGVfZXZlbnQoKSBkZXJl
ZmVyZW5jZXMKPiA+IGEgTlVMTCBwb2ludGVyIHdoZW4gdHJ5aW5nIHRvIHdyaXRlIHRvIHRoZSB3
YWtldXAgcmVnaXN0ZXIuCj4gPiBSZXBsYWNlIHVzYWdlIG9mIHRoZSBTVF9MU002RFNYX0NIQU5O
RUxfQUNDKCkgYW5kCj4gPiBTVF9MU002RFNYX0NIQU5ORUwoKSBtYWNyb3Mgd2l0aCBkeW5hbWlj
IGFsbG9jYXRpb24gYW5kCj4gPiBpbml0aWFsaXphdGlvbiBvZiBzdHJ1Y3QgaWlvX2NoYW5fc3Bl
YyBhcnJheXMsIHdoZXJlIHRoZQo+ID4gc3RfbHNtNmRzeF9ldmVudCBzdHJ1Y3R1cmUgaXMgb25s
eSB1c2VkIGZvciBzZW5zb3JzIHRoYXQgc3VwcG9ydAo+ID4gd2FrZXVwIGV2ZW50czsgYmVzaWRl
cyBmaXhpbmcgdGhlIGFib3ZlIGJ1ZywgdGhpcyBzZXJ2ZXMgYXMgYQo+ID4gcHJlbGltaW5hcnkg
c3RlcCBmb3IgYWRkaW5nIHN1cHBvcnQgZm9yIG1vcmUgZXZlbnQgdHlwZXMuCj4gCj4gSSBhZ3Jl
ZSB3ZSBhcmUgbWlzc2luZyB0aGUgRml4ZXMgdGFnIGhlcmUuCgpBY2sKClsuLi5dCgoKPiA+ICtz
dGF0aWMgaW50IHN0X2xzbTZkc3hfY2hhbl9pbml0KHN0cnVjdCBpaW9fY2hhbl9zcGVjICpjaGFu
bmVscywgc3RydWN0Cj4gPiBzdF9sc202ZHN4X2h3ICpodywKPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGVudW0gc3RfbHNt
NmRzeF9zZW5zb3JfaWQgaWQsIGludAo+ID4gaW5kZXgpCj4gCj4gcGxlYXNlIHRyeSB0byByZXNw
ZWN0IHRoZSA3OSBjb2x1bW4gbGltaXQgKEkgc3RpbGwgbGlrZSBpdCA6KSkKCk9LCgo+ID4gK3sK
PiA+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBpaW9fY2hhbl9zcGVjICpjaGFuID0gJmNoYW5uZWxz
W2luZGV4XTsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoGNoYW4tPnR5cGUgPSAoaWQgPT0gU1Rf
TFNNNkRTWF9JRF9BQ0MpID8gSUlPX0FDQ0VMIDoKPiA+IElJT19BTkdMX1ZFTDsKPiAKPiBJIHRo
aW5rIHlvdSBzaG91bGQgcmV0dXJuIGFuIGVycm9yIGhlcmUgaWYgaWQgaXMgbm90IFNUX0xTTTZE
U1hfSURfQUNDIG9yCj4gU1RfTFNNNkRTWF9JRF9HWVJPLgoKV2lsbCBkbwoKPiA+ICvCoMKgwqDC
oMKgwqDCoGNoYW4tPmFkZHJlc3MgPSBody0+c2V0dGluZ3MtPmNoYW5fYWRkcl9iYXNlW2lkXSAr
IGluZGV4ICoKPiA+IFNUX0xTTTZEU1hfQ0hBTl9TSVpFOwo+ID4gK8KgwqDCoMKgwqDCoMKgY2hh
bi0+bW9kaWZpZWQgPSAxOwo+ID4gK8KgwqDCoMKgwqDCoMKgY2hhbi0+Y2hhbm5lbDIgPSBJSU9f
TU9EX1ggKyBpbmRleDsKPiA+ICvCoMKgwqDCoMKgwqDCoGNoYW4tPmluZm9fbWFza19zZXBhcmF0
ZSA9IEJJVChJSU9fQ0hBTl9JTkZPX1JBVyk7Cj4gPiArwqDCoMKgwqDCoMKgwqBjaGFuLT5pbmZv
X21hc2tfc2hhcmVkX2J5X3R5cGUgPSBCSVQoSUlPX0NIQU5fSU5GT19TQ0FMRSk7Cj4gPiArwqDC
oMKgwqDCoMKgwqBjaGFuLT5pbmZvX21hc2tfc2hhcmVkX2J5X2FsbCA9IEJJVChJSU9fQ0hBTl9J
TkZPX1NBTVBfRlJFUSk7Cj4gPiArwqDCoMKgwqDCoMKgwqBjaGFuLT5zY2FuX2luZGV4ID0gaW5k
ZXg7Cj4gPiArwqDCoMKgwqDCoMKgwqBjaGFuLT5zY2FuX3R5cGUuc2lnbiA9ICdzJzsKPiA+ICvC
oMKgwqDCoMKgwqDCoGNoYW4tPnNjYW5fdHlwZS5yZWFsYml0cyA9IDE2Owo+ID4gK8KgwqDCoMKg
wqDCoMKgY2hhbi0+c2Nhbl90eXBlLnN0b3JhZ2ViaXRzID0gMTY7Cj4gPiArwqDCoMKgwqDCoMKg
wqBjaGFuLT5zY2FuX3R5cGUuZW5kaWFubmVzcyA9IElJT19MRTsKPiAKPiB3aGF0IGFib3V0IHJl
ZHVjaW5nIHRoZSBzY29wZSBvZgo+IFNUX0xTTTZEU1hfQ0hBTk5FTF9BQ0MvU1RfTFNNNkRTWF9D
SEFOTkVMIGhlcmUKPiB0byBpbXByb3ZlIHRoZSBpaW9fY2hhbl9zcGVjIHN0cnVjdCBpbml0aWFs
aXphdGlvbiBzaW5jZSBtb3N0IG9mIHRoZQo+IGZpZWxkcyBhcmUKPiBhbHdheXMgdGhlIHNhbWUg
YmV0d2VlbiBkaWZmZXJlbnQgc2Vuc29ycy4KCkRvIHlvdSBtZWFuIGRlY2xhcmluZyBhIGxvY2Fs
IHN0cnVjdCB2YXJpYWJsZSBpbml0aWFsaXplZCB2aWEKU1RfTFNNNkRTWF9DSEFOTkVMKCkgYW5k
IHRoZW4gY29weWluZyBpdHMgY29udGVudHMgdG8gdGhlIGR5bmFtaWNhbGx5CmFsbG9jYXRlZCBz
dHJ1Y3Q/IEknbSBub3QgY2xlYXIgd2hhdCBiZW5lZml0cyB0aGF0IHdvdWxkIGdpdmUgdXM7IGlu
IGZhY3QsCkkgdGhpbmsgaXQgd291bGQgaW5jcmVhc2UgdGhlIGNvZGUgc2l6ZSAoYm90aCBpbiB0
ZXJtcyBvZiBMT0MgYW5kIGNvbXBpbGVkCmJpbmFyeSBzaXplKSwgYmVzaWRlcyB0aGUgYWRkaXRp
b25hbCBvdmVyaGVhZCBvZiBtZW1vcnkgY29weWluZy4KCj4gCj4gPiArwqDCoMKgwqDCoMKgwqBj
aGFuLT5leHRfaW5mbyA9IHN0X2xzbTZkc3hfZXh0X2luZm87Cj4gPiArwqDCoMKgwqDCoMKgwqBp
ZiAoaWQgPT0gU1RfTFNNNkRTWF9JRF9BQ0MpIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBpZiAoaHctPnNldHRpbmdzLT5ldmVudF9zZXR0aW5ncy53YWtldXBfcmVnLmFkZHIp
IHsKPiAKPiDCoMKgwqDCoMKgwqDCoMKgaWYgKGlkID09IFNUX0xTTTZEU1hfSURfQUNDICYmCj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBody0+c2V0dGluZ3MtPmV2ZW50X3NldHRpbmdzLndha2V1
cF9yZWcuYWRkcikgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLi4uCj4gwqDCoMKgwqDCoMKg
wqDCoH0KPiAKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgY2hhbi0+ZXZlbnRfc3BlYyA9ICZzdF9sc202ZHN4X2V2ZW50Owo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjaGFuLT5udW1fZXZlbnRfc3BlY3Mg
PSAxOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0KPiA+ICvCoMKgwqDCoMKg
wqDCoH0KPiA+ICvCoMKgwqDCoMKgwqDCoHJldHVybiAwOwo+ID4gK30KPiA+ICsKPiA+IMKgc3Rh
dGljIHN0cnVjdCBpaW9fZGV2ICpzdF9sc202ZHN4X2FsbG9jX2lpb2RldihzdHJ1Y3Qgc3RfbHNt
NmRzeF9odwo+ID4gKmh3LAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
ZW51bQo+ID4gc3RfbHNtNmRzeF9zZW5zb3JfaWQgaWQsCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBjb25zdCBjaGFyICpuYW1lKQo+ID4gwqB7Cj4gPiDCoMKgwqDCoMKg
wqDCoMKgc3RydWN0IHN0X2xzbTZkc3hfc2Vuc29yICpzZW5zb3I7Cj4gPiDCoMKgwqDCoMKgwqDC
oMKgc3RydWN0IGlpb19kZXYgKmlpb19kZXY7Cj4gPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgaWlv
X2NoYW5fc3BlYyAqY2hhbm5lbHM7Cj4gCj4gbml0OiBjaGFuIHRvIGJlIGNvbnNpc3RlbnQKPiAK
PiA+ICvCoMKgwqDCoMKgwqDCoGludCBpOwo+ID4gwqAKPiA+IMKgwqDCoMKgwqDCoMKgwqBpaW9f
ZGV2ID0gZGV2bV9paW9fZGV2aWNlX2FsbG9jKGh3LT5kZXYsIHNpemVvZigqc2Vuc29yKSk7Cj4g
PiDCoMKgwqDCoMKgwqDCoMKgaWYgKCFpaW9fZGV2KQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqByZXR1cm4gTlVMTDsKPiA+IMKgCj4gPiArwqDCoMKgwqDCoMKgwqBjaGFubmVs
cyA9IGRldm1fa3phbGxvYyhody0+ZGV2LCBzaXplb2YoKmNoYW5uZWxzKSAqCj4gPiBTVF9MU002
RFNYX0NIQU5fQ09VTlQsIEdGUF9LRVJORUwpOwo+IAo+IDc5IGNvbHVtbiBsaW1pdCBoZXJlLiBJ
IGd1ZXNzIHlvdSBjYW4gdXNlIGV2ZW4gZGV2bV9rY2FsbG9jKCkgaGVyZS4KCldpbGwgZG8KCj4g
PiArwqDCoMKgwqDCoMKgwqBpZiAoIWNoYW5uZWxzKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHJldHVybiBOVUxMOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgZm9yIChpID0g
MDsgaSA8IDM7IGkrKykgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChz
dF9sc202ZHN4X2NoYW5faW5pdChjaGFubmVscywgaHcsIGlkLCBpKSA8IDApCj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBOVUxMOwo+ID4g
K8KgwqDCoMKgwqDCoMKgfQo+IAo+IG5ldyBsaW5lIGhlcmUuCj4gCj4gPiArwqDCoMKgwqDCoMKg
wqBjaGFubmVsc1szXS50eXBlID0gSUlPX1RJTUVTVEFNUDsKPiA+ICvCoMKgwqDCoMKgwqDCoGNo
YW5uZWxzWzNdLmNoYW5uZWwgPSAtMTsKPiA+ICvCoMKgwqDCoMKgwqDCoGNoYW5uZWxzWzNdLnNj
YW5faW5kZXggPSAzOwo+ID4gK8KgwqDCoMKgwqDCoMKgY2hhbm5lbHNbM10uc2Nhbl90eXBlLnNp
Z24gPSAncyc7Cj4gPiArwqDCoMKgwqDCoMKgwqBjaGFubmVsc1szXS5zY2FuX3R5cGUucmVhbGJp
dHMgPSA2NDsKPiA+ICvCoMKgwqDCoMKgwqDCoGNoYW5uZWxzWzNdLnNjYW5fdHlwZS5zdG9yYWdl
Yml0cyA9IDY0Owo+ID4gwqDCoMKgwqDCoMKgwqDCoGlpb19kZXYtPm1vZGVzID0gSU5ESU9fRElS
RUNUX01PREU7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgaWlvX2Rldi0+YXZhaWxhYmxlX3NjYW5fbWFz
a3MgPQo+ID4gc3RfbHNtNmRzeF9hdmFpbGFibGVfc2Nhbl9tYXNrczsKPiA+IC3CoMKgwqDCoMKg
wqDCoGlpb19kZXYtPmNoYW5uZWxzID0gaHctPnNldHRpbmdzLT5jaGFubmVsc1tpZF0uY2hhbjsK
PiA+IC3CoMKgwqDCoMKgwqDCoGlpb19kZXYtPm51bV9jaGFubmVscyA9IGh3LT5zZXR0aW5ncy0+
Y2hhbm5lbHNbaWRdLmxlbjsKPiA+ICvCoMKgwqDCoMKgwqDCoGlpb19kZXYtPmNoYW5uZWxzID0g
Y2hhbm5lbHM7Cj4gPiArwqDCoMKgwqDCoMKgwqBpaW9fZGV2LT5udW1fY2hhbm5lbHMgPSBTVF9M
U002RFNYX0NIQU5fQ09VTlQ7Cj4gPiDCoAo+ID4gwqDCoMKgwqDCoMKgwqDCoHNlbnNvciA9IGlp
b19wcml2KGlpb19kZXYpOwo+ID4gwqDCoMKgwqDCoMKgwqDCoHNlbnNvci0+aWQgPSBpZDsKPiA+
IC0tIAo+ID4gMi4zOS41Cj4gPiAKCg==


--=-NCr1XTwotSCxM0ebAV+p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEhleFT5U73KMewxTm7fE7c86UNl8FAmkEbaoACgkQ7fE7c86U
Nl9X7wv/W8evEEkV/aMMcPYvQlZlimnferu4Dhp3Y5e7nNAosm1Vnsq7EsMcQmPf
VuEWj/RyT2H2YLFoprfWVPgGJt77I2DMz2cecyVeByFtDFg894feiZD0eCJGiCkT
2XANEyIJzm62YxCEAwfW+PtgeFOVAS1D0HVWMRDbir4V4xo6WTHd9DrB4/W0NBcO
bHGrjsj0Wyd+xMXooxuyfgNrR/wifa72wrWO0GcwepkWPynmp60pFUCPRjUAXUae
EzNMiAgpq5keF+j8ETVsysSszaUnc4Dhgb1dYVGnnJaJJLnrDvcIF5j4m5S4MU1U
Zb3Sa6OfR4p9KBZup4K0XWYEgU0zcTFbq8PNQtu/3/DQUO8NpdVcc0pkx72gL4HS
pTR5QpQDkMcb+63fxkwDiMv36GuH3FqFGERil//FJeYsWGxp5SHDQHiLzJUZuwjB
+zBtyYZBhRsyVI7txkTeucyMBiPdOngoSXOERIcua19TfR2kF3MIGQdSqQLOmJIx
Cj/DEgEa
=yLJB
-----END PGP SIGNATURE-----

--=-NCr1XTwotSCxM0ebAV+p--

