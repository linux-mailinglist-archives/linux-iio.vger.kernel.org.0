Return-Path: <linux-iio+bounces-9438-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2B9974B0F
	for <lists+linux-iio@lfdr.de>; Wed, 11 Sep 2024 09:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A57C81F2777B
	for <lists+linux-iio@lfdr.de>; Wed, 11 Sep 2024 07:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F6F13B5A9;
	Wed, 11 Sep 2024 07:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4c34r1s"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8960013B58D;
	Wed, 11 Sep 2024 07:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726038905; cv=none; b=rz0uNbPMIbh68RxOfKXE2jNDOYXq+4bh/s546Sxl7e8jMBjMjVUwzbYVilBDmBXpcd5XB+980xJWBSHGEjs6ugrY2dXvduTG8tUQsw/UukexJl23AhhN2q81Nb9KLe41KMVXEMfWmp/gnlQbGyYvwaNn+0UXxIEXk1gPFLdsDLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726038905; c=relaxed/simple;
	bh=qzF/rQ6fAJDdlgLge9hPamYVEcGziA2v89dCpug6A4s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ViikIP3CWe4Mecwl79ZmbC1YUDYto9ZOjcLF/C+dJYkZHeoLn1iQNGwXgfj6xTmpHKjnG920JF3a8iisKEl+JqPAxJM90q9DHm5WaXa+Ct28xKCu5rQmMcDZSHBa+7HrV6gnpp55jba8F3fpFKvAhQ5bFQzN+VWjDyDkhE4veaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4c34r1s; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c3c30e663fso1974985a12.1;
        Wed, 11 Sep 2024 00:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726038902; x=1726643702; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qzF/rQ6fAJDdlgLge9hPamYVEcGziA2v89dCpug6A4s=;
        b=P4c34r1sEw/YTbukdW815z21q9Rf0j/JQjHsaBiLyjwT3PYdawM6oaO1JUm09m9oEQ
         nPyN3LCzcXCAtmoo3ftErL9eeRCmG4xG2FMVvumtczFQRcQPDY5L0nL775eyRGXF63JJ
         jT7Xues5oFgXOuHTkb+1wvzuW6qSfIUmGqPCvo/19VP2wduFa2N8ikxPO+deW1lGHpAg
         OyajNuVGMXSy36I6wPygdaogqxYc+SMJiwf00q4tX0uWlyxDiX8BithufzfJ+L5WW2Qv
         C+f01IgSr6/aI8Aik1avPUucYT8rgQfUcJgh6JcBM8felIXNyPxMIg3JMNshzXaBC7UP
         e+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726038902; x=1726643702;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qzF/rQ6fAJDdlgLge9hPamYVEcGziA2v89dCpug6A4s=;
        b=boTI0RnRWjcoe00JkV7HgqbAfQBlt9YFvK+XIn2dwkWRYwJ3TFZ5rUCJozaYoS8mOR
         Chb/R97MfKUSx77MIyyV1bnmi5OJlvoh0tAVH+avBDA/zZXxRJR3XxNmlrldNjq2yx8L
         GUJTQOlp86mciCs0RQrGRRvn/l6+g21w8uqPW9k65hkG1JOn35XGnHRorqmUrbsXTFZB
         N7BZhkbw/ZtSxUZ9vVYH96XaYunk5z+NIzY44xvMRtRIH5PadwUCKPXTok+lYv+wp3z2
         pm/FI6Qj33UUHFJYoBOiR5AsHU88G0f2JORIxtiiyv9x0kC/9rhsgcuqsydGvwt2m908
         wcdA==
X-Forwarded-Encrypted: i=1; AJvYcCVqvZm4nKwuI+TNM3W2toztSc1KjqmLTRPyuzvGh+Ufpo0n1Uk6uvIOkibPZX8foCPqyoO92/ncfwYpjcwQ@vger.kernel.org, AJvYcCWg3aEJ2smCQrY//SjsSRuOv1gO4gFsRxZewiCeYsCt2Zln01cFH36Gqg1Bf2E2FFTvlp5c7vQ4eob2@vger.kernel.org
X-Gm-Message-State: AOJu0YyyVAHfexcDEYyd7EoQaV+vb+unP/oV+VtpCKsHoyQY5LS8sR5e
	U2ZvF6D2AEOWg26Vgt2sY3o7Ucc3pZOON0Pzty/gaPAXPM2jH3FgOARsjt0trJU=
X-Google-Smtp-Source: AGHT+IES2+7SvLDY+P6LiZ3XyfYyfYXRsR5Gau3fUW7rzhb2Hl+Pooi5EzP/Ye2n/aYNZ6PbSxtOUQ==
X-Received: by 2002:a05:6402:90a:b0:5c2:5f07:9f65 with SMTP id 4fb4d7f45d1cf-5c40bc2d913mr1748444a12.18.1726038901190;
        Wed, 11 Sep 2024 00:15:01 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:341e:1201:c434:b5b1:98a6:efed])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd41c7dsm5074783a12.13.2024.09.11.00.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 00:15:00 -0700 (PDT)
Message-ID: <bbdb74dd2dcd9653a714705d032a69a4bf547418.camel@gmail.com>
Subject: Re: [PATCH] dt-bindings: iio: dac: adi,ad56xx: Fix duplicate
 compatible strings
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: "Rob Herring (Arm)" <robh@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>,  Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Michael Auchter
 <michael.auchter@ni.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 11 Sep 2024 09:15:00 +0200
In-Reply-To: <20240910234440.1045098-1-robh@kernel.org>
References: <20240910234440.1045098-1-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVHVlLCAyMDI0LTA5LTEwIGF0IDE4OjQ0IC0wNTAwLCBSb2IgSGVycmluZyAoQXJtKSB3cm90
ZToKPiBhZGksYWQ1Njg2LnlhbWwgYW5kIGFkaSxhZDU2OTYueWFtbCBkdXBsaWNhdGUgYWxsIHRo
ZSBJMkMgZGV2aWNlCj4gY29tcGF0aWJsZSBzdHJpbmdzIHdpdGggdGhlIGV4Y2VwdGlvbiBvZiAi
YWRpLGFkNTMzN3IiLiBTaW5jZQo+IGFkaSxhZDU2ODYueWFtbCByZWZlcmVuY2VzIHNwaS1wZXJp
cGhlcmFsLXByb3BzLnlhbWwsIGRyb3AgdGhlIEkyQwo+IGRldmljZXMgZnJvbSBpdCBtYWtpbmcg
aXQgb25seSBTUEkgZGV2aWNlcy4gVXBkYXRlIHRoZSB0aXRsZXMgdG8gbWFrZQo+IHRoZSBkaXN0
aW5jdGlvbiBjbGVhci4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBSb2IgSGVycmluZyAoQXJtKSA8cm9i
aEBrZXJuZWwub3JnPgo+IC0tLQoKUmV2aWV3ZWQtYnk6IE51bm8gU2EgPG51bm8uc2FAYW5hbG9n
LmNvbT4KCj4gwqAuLi4vYmluZGluZ3MvaWlvL2RhYy9hZGksYWQ1Njg2LnlhbWzCoMKgwqDCoMKg
wqDCoMKgwqAgfCA1MyArKysrKystLS0tLS0tLS0tLS0tCj4gwqAuLi4vYmluZGluZ3MvaWlvL2Rh
Yy9hZGksYWQ1Njk2LnlhbWzCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDMgKy0KPiDCoDIgZmlsZXMg
Y2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgMzcgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdp
dCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vZGFjL2FkaSxhZDU2ODYu
eWFtbAo+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9kYWMvYWRpLGFk
NTY4Ni55YW1sCj4gaW5kZXggYjQ0MDBjNTJiZWMzLi43MTNmNTM1YmIzM2EgMTAwNjQ0Cj4gLS0t
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9kYWMvYWRpLGFkNTY4Ni55
YW1sCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9kYWMvYWRp
LGFkNTY4Ni55YW1sCj4gQEAgLTQsNyArNCw3IEBACj4gwqAkaWQ6IGh0dHA6Ly9kZXZpY2V0cmVl
Lm9yZy9zY2hlbWFzL2lpby9kYWMvYWRpLGFkNTY4Ni55YW1sIwo+IMKgJHNjaGVtYTogaHR0cDov
L2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjCj4gwqAKPiAtdGl0bGU6IEFu
YWxvZyBEZXZpY2VzIEFENTM2MCBhbmQgc2ltaWxhciBEQUNzCj4gK3RpdGxlOiBBbmFsb2cgRGV2
aWNlcyBBRDUzNjAgYW5kIHNpbWlsYXIgU1BJIERBQ3MKPiDCoAo+IMKgbWFpbnRhaW5lcnM6Cj4g
wqDCoCAtIE1pY2hhZWwgSGVubmVyaWNoIDxtaWNoYWVsLmhlbm5lcmljaEBhbmFsb2cuY29tPgo+
IEBAIC0xMiw0MSArMTIsMjIgQEAgbWFpbnRhaW5lcnM6Cj4gwqAKPiDCoHByb3BlcnRpZXM6Cj4g
wqDCoCBjb21wYXRpYmxlOgo+IC3CoMKgwqAgb25lT2Y6Cj4gLcKgwqDCoMKgwqAgLSBkZXNjcmlw
dGlvbjogU1BJIGRldmljZXMKPiAtwqDCoMKgwqDCoMKgwqAgZW51bToKPiAtwqDCoMKgwqDCoMKg
wqDCoMKgIC0gYWRpLGFkNTMxMHIKPiAtwqDCoMKgwqDCoMKgwqDCoMKgIC0gYWRpLGFkNTY3MnIK
PiAtwqDCoMKgwqDCoMKgwqDCoMKgIC0gYWRpLGFkNTY3NHIKPiAtwqDCoMKgwqDCoMKgwqDCoMKg
IC0gYWRpLGFkNTY3Ngo+IC3CoMKgwqDCoMKgwqDCoMKgwqAgLSBhZGksYWQ1Njc2cgo+IC3CoMKg
wqDCoMKgwqDCoMKgwqAgLSBhZGksYWQ1Njc5cgo+IC3CoMKgwqDCoMKgwqDCoMKgwqAgLSBhZGks
YWQ1Njgxcgo+IC3CoMKgwqDCoMKgwqDCoMKgwqAgLSBhZGksYWQ1Njgycgo+IC3CoMKgwqDCoMKg
wqDCoMKgwqAgLSBhZGksYWQ1NjgzCj4gLcKgwqDCoMKgwqDCoMKgwqDCoCAtIGFkaSxhZDU2ODNy
Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoCAtIGFkaSxhZDU2ODQKPiAtwqDCoMKgwqDCoMKgwqDCoMKg
IC0gYWRpLGFkNTY4NHIKPiAtwqDCoMKgwqDCoMKgwqDCoMKgIC0gYWRpLGFkNTY4NXIKPiAtwqDC
oMKgwqDCoMKgwqDCoMKgIC0gYWRpLGFkNTY4Ngo+IC3CoMKgwqDCoMKgwqDCoMKgwqAgLSBhZGks
YWQ1Njg2cgo+IC3CoMKgwqDCoMKgIC0gZGVzY3JpcHRpb246IEkyQyBkZXZpY2VzCj4gLcKgwqDC
oMKgwqDCoMKgIGVudW06Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoCAtIGFkaSxhZDUzMTFyCj4gLcKg
wqDCoMKgwqDCoMKgwqDCoCAtIGFkaSxhZDUzMzdyCj4gLcKgwqDCoMKgwqDCoMKgwqDCoCAtIGFk
aSxhZDUzMzhyCj4gLcKgwqDCoMKgwqDCoMKgwqDCoCAtIGFkaSxhZDU2NzFyCj4gLcKgwqDCoMKg
wqDCoMKgwqDCoCAtIGFkaSxhZDU2NzVyCj4gLcKgwqDCoMKgwqDCoMKgwqDCoCAtIGFkaSxhZDU2
OTFyCj4gLcKgwqDCoMKgwqDCoMKgwqDCoCAtIGFkaSxhZDU2OTJyCj4gLcKgwqDCoMKgwqDCoMKg
wqDCoCAtIGFkaSxhZDU2OTMKPiAtwqDCoMKgwqDCoMKgwqDCoMKgIC0gYWRpLGFkNTY5M3IKPiAt
wqDCoMKgwqDCoMKgwqDCoMKgIC0gYWRpLGFkNTY5NAo+IC3CoMKgwqDCoMKgwqDCoMKgwqAgLSBh
ZGksYWQ1Njk0cgo+IC3CoMKgwqDCoMKgwqDCoMKgwqAgLSBhZGksYWQ1Njk1cgo+IC3CoMKgwqDC
oMKgwqDCoMKgwqAgLSBhZGksYWQ1Njk2Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoCAtIGFkaSxhZDU2
OTZyCj4gLQo+ICvCoMKgwqAgZW51bToKPiArwqDCoMKgwqDCoCAtIGFkaSxhZDUzMTByCj4gK8Kg
wqDCoMKgwqAgLSBhZGksYWQ1Njcycgo+ICvCoMKgwqDCoMKgIC0gYWRpLGFkNTY3NHIKPiArwqDC
oMKgwqDCoCAtIGFkaSxhZDU2NzYKPiArwqDCoMKgwqDCoCAtIGFkaSxhZDU2NzZyCj4gK8KgwqDC
oMKgwqAgLSBhZGksYWQ1Njc5cgo+ICvCoMKgwqDCoMKgIC0gYWRpLGFkNTY4MXIKPiArwqDCoMKg
wqDCoCAtIGFkaSxhZDU2ODJyCj4gK8KgwqDCoMKgwqAgLSBhZGksYWQ1NjgzCj4gK8KgwqDCoMKg
wqAgLSBhZGksYWQ1Njgzcgo+ICvCoMKgwqDCoMKgIC0gYWRpLGFkNTY4NAo+ICvCoMKgwqDCoMKg
IC0gYWRpLGFkNTY4NHIKPiArwqDCoMKgwqDCoCAtIGFkaSxhZDU2ODVyCj4gK8KgwqDCoMKgwqAg
LSBhZGksYWQ1Njg2Cj4gK8KgwqDCoMKgwqAgLSBhZGksYWQ1Njg2cgo+IMKgCj4gwqDCoCByZWc6
Cj4gwqDCoMKgwqAgbWF4SXRlbXM6IDEKPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2lpby9kYWMvYWRpLGFkNTY5Ni55YW1sCj4gYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2RhYy9hZGksYWQ1Njk2LnlhbWwKPiBpbmRleCA1NmIw
Y2RhMGYzMGEuLmI1YTg4YjAzZGMyZiAxMDA2NDQKPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvaWlvL2RhYy9hZGksYWQ1Njk2LnlhbWwKPiArKysgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2RhYy9hZGksYWQ1Njk2LnlhbWwKPiBAQCAtNCw3
ICs0LDcgQEAKPiDCoCRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvaWlvL2RhYy9h
ZGksYWQ1Njk2LnlhbWwjCj4gwqAkc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1z
Y2hlbWFzL2NvcmUueWFtbCMKPiDCoAo+IC10aXRsZTogQW5hbG9nIERldmljZXMgQUQ1Njk2IGFu
ZCBzaW1pbGFyIG11bHRpLWNoYW5uZWwgREFDcwo+ICt0aXRsZTogQW5hbG9nIERldmljZXMgQUQ1
Njk2IGFuZCBzaW1pbGFyIEkyQyBtdWx0aS1jaGFubmVsIERBQ3MKPiDCoAo+IMKgbWFpbnRhaW5l
cnM6Cj4gwqDCoCAtIE1pY2hhZWwgQXVjaHRlciA8bWljaGFlbC5hdWNodGVyQG5pLmNvbT4KPiBA
QCAtMTYsNiArMTYsNyBAQCBwcm9wZXJ0aWVzOgo+IMKgwqAgY29tcGF0aWJsZToKPiDCoMKgwqDC
oCBlbnVtOgo+IMKgwqDCoMKgwqDCoCAtIGFkaSxhZDUzMTFyCj4gK8KgwqDCoMKgwqAgLSBhZGks
YWQ1MzM3cgo+IMKgwqDCoMKgwqDCoCAtIGFkaSxhZDUzMzhyCj4gwqDCoMKgwqDCoMKgIC0gYWRp
LGFkNTY3MXIKPiDCoMKgwqDCoMKgwqAgLSBhZGksYWQ1Njc1cgoK


