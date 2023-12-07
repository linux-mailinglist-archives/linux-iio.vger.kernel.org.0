Return-Path: <linux-iio+bounces-702-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB628083CA
	for <lists+linux-iio@lfdr.de>; Thu,  7 Dec 2023 10:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 687041C21F4F
	for <lists+linux-iio@lfdr.de>; Thu,  7 Dec 2023 09:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAA132C61;
	Thu,  7 Dec 2023 09:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cImFVwhW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4D819A
	for <linux-iio@vger.kernel.org>; Thu,  7 Dec 2023 01:04:14 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40b2ddab817so7719435e9.3
        for <linux-iio@vger.kernel.org>; Thu, 07 Dec 2023 01:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701939853; x=1702544653; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7DhaURTSepPXrBJdq5VKJ1mQQ2bK/DnByJ7q5/bfga4=;
        b=cImFVwhW2/eMTwMQ1EYsC7YJruX9Wl0vUYr1ZewKZRObo9ITAP2eZZKpx1AiHcsZA2
         PSU6Yfevmah/0v4t113EXVBUqxSh2otHlgfK7mCkQHJ7I13QWvHDTEiI1El+I5EbX23a
         4HZmE9wAow7SgRgUJ0Sj+Lm8EiVKCkOI0j/832qA9KGCrZYYLOK17wvJC8eCI1rtGowm
         KW39rd6FAgUZlggfqxfhKQ0gLLPOmp+PEkxYg45LEItK3fJw3lo0nHQdgWeJOTONo2Cu
         EdSVkhPiZlgUzfYP9t4QpSWZO9JJv8wYvCUiQUaMe9T7dVD5EzM9RUh/wWP+lzv3CWdg
         xrqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701939853; x=1702544653;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7DhaURTSepPXrBJdq5VKJ1mQQ2bK/DnByJ7q5/bfga4=;
        b=JG3ti1x9/5ZE7QY7aW6xC27ViRy7B/ZssKCCIEKTu66yUeJ9UhW2m8+GYACZk1vo6m
         GIlndrthX6PUk+RZdQCwKZCDPKjgkk04nW38EWC4dzmzawx7FKh8Dlb04/paR/jF7afC
         iBApgHw6RxxuUTewMp/2mJS1oElbguz78LViZ14W+08mnuLQ8N1ZMjdMqGpjDGMkALPI
         sqesT3IHwRsxR2GlJ8k1u06z6nG/NmFfbodZLn4ul4s0FEJiSMxx8erIY3QfsrOsBeoe
         1c59fDrEUCUadnCoIk8hnJPmnIhAd+eOfKTfvhpwTOWzr9LUiDpNW9I05eUE8RU4/4Ss
         dCrg==
X-Gm-Message-State: AOJu0Yz6DLZZPsdSCryGzzGewMLgGM9EP7zZrgfuLFPtsm/skmmzZxgE
	qcoatstZebzEg4as2qcvgkgo9LI/f5r9jp8K
X-Google-Smtp-Source: AGHT+IF/+2S05hvwrRgtNLGGQTBGrIf8OD4w8hyC892dTaGLQpDgnDngCzIhqUybCAoxuelJ/ygw6Q==
X-Received: by 2002:a1c:4c0d:0:b0:40c:22eb:81d3 with SMTP id z13-20020a1c4c0d000000b0040c22eb81d3mr1092993wmf.130.1701939852834;
        Thu, 07 Dec 2023 01:04:12 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id bg32-20020a05600c3ca000b0040b3e7569fcsm1263192wmb.11.2023.12.07.01.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 01:04:12 -0800 (PST)
Message-ID: <21b4820b5fc0ea8960c541398e271140f5f70a68.camel@gmail.com>
Subject: Re: [PATCH 1/8] iio: adc: ad9467: fix reset gpio handling
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>,  Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>
Date: Thu, 07 Dec 2023 10:04:12 +0100
In-Reply-To: <CAMknhBEgk_o9TqV4E6EDtg3JS5V8fZUx5JgrfcD+eQxHcqffnA@mail.gmail.com>
References: <20231205-iio-backend-prep-v1-0-7c9bc18d612b@analog.com>
	 <20231205-iio-backend-prep-v1-1-7c9bc18d612b@analog.com>
	 <CAMknhBEgk_o9TqV4E6EDtg3JS5V8fZUx5JgrfcD+eQxHcqffnA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gV2VkLCAyMDIzLTEyLTA2IGF0IDE2OjA5IC0wNjAwLCBEYXZpZCBMZWNobmVyIHdyb3RlOgo+
IE9uIFR1ZSwgRGVjIDUsIDIwMjMgYXQgMTE6MDbigK9BTSBOdW5vIFNhIHZpYSBCNCBSZWxheQo+
IDxkZXZudWxsK251bm8uc2EuYW5hbG9nLmNvbUBrZXJuZWwub3JnPiB3cm90ZToKPiA+IAo+ID4g
RnJvbTogTnVubyBTYSA8bnVuby5zYUBhbmFsb2cuY29tPgo+ID4gCj4gPiBUaGUgcmVzZXQgZ3Bp
byB3YXMgYmVpbmcgcmVxdWVzdGVkIHdpdGggR1BJT0RfT1VUX0xPVyB3aGljaCBtZWFucywgbm90
Cj4gPiBhc3NlcnRlZC4gVGhlbiBpdCB3YXMgYmVpbmcgYXNzZXJ0ZWQgYnV0IG5ldmVyIGRlLWFz
c2VydGVkIHdoaWNoIG1lYW5zCj4gPiB0aGUgZGV2aWNlcyB3YXMgbGVmdCBpbiByZXNldC4gRml4
IGl0IGJ5IGRlLWFzc2VydGluZyB0aGUgZ3Bpby4KPiA+IAo+ID4gV2hpbGUgYXQgaXQsIG1vdmVk
IHRoZSBoYW5kbGluZyB0byBpdCdzIG93biBmdW5jdGlvbiBhbmQgZHJvcHBlZAo+ID4gJ3Jlc2V0
X2dwaW8nIGZyb20gdGhlICdzdHJ1Y3QgYWQ5NDY3X3N0YXRlJyBhcyB3ZSBvbmx5IG5lZWQgaXQg
ZHVyaW5nCj4gPiBwcm9iZS4gT24gdG9wIG9mIHRoYXQsIHJlZmFjdG9yZWQgdGhpbmdzIHNvIHRo
YXQgd2Ugbm93IHJlcXVlc3QgdGhlIGdwaW8KPiA+IGFzc2VydGVkIChpLmUgaW4gcmVzZXQpIGFu
ZCB0aGVuIGRlLWFzc2VydCBpdC4gQWxzbyBub3RlIHRoYXQgd2Ugbm93IHVzZQo+ID4gZ3Bpb2Rf
c2V0X3ZhbHVlX2NhbnNsZWVwKCkgaW5zdGVhZCBvZiBncGlvZF9kaXJlY3Rpb25fb3V0cHV0KCkg
YXMgd2UKPiA+IGFscmVhZHkgcmVxdWVzdCB0aGUgcGluIGFzIG91dHB1dC4KPiA+IAo+ID4gRml4
ZXM6IGFkNjc5NzEyMDIzOCAoImlpbzogYWRjOiBhZDk0Njc6IGFkZCBzdXBwb3J0IEFEOTQ2NyBB
REMiKQo+ID4gU2lnbmVkLW9mZi1ieTogTnVubyBTYSA8bnVuby5zYUBhbmFsb2cuY29tPgo+ID4g
LS0tCj4gPiDCoGRyaXZlcnMvaWlvL2FkYy9hZDk0NjcuYyB8IDMzICsrKysrKysrKysrKysrKysr
KysrLS0tLS0tLS0tLS0tLQo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKSwg
MTMgZGVsZXRpb25zKC0pCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9hZGMvYWQ5
NDY3LmMgYi9kcml2ZXJzL2lpby9hZGMvYWQ5NDY3LmMKPiA+IGluZGV4IDM5ZWNjYzI4ZGViZS4u
NWVjZjQ4NmJmNWQxIDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy9paW8vYWRjL2FkOTQ2Ny5jCj4g
PiArKysgYi9kcml2ZXJzL2lpby9hZGMvYWQ5NDY3LmMKPiA+IEBAIC0xMjEsNyArMTIxLDYgQEAg
c3RydWN0IGFkOTQ2N19zdGF0ZSB7Cj4gPiDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBpbnTCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBvdXRwdXRfbW9kZTsKPiA+IAo+ID4g
wqDCoMKgwqDCoMKgwqAgc3RydWN0IGdwaW9fZGVzY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAqcHdyZG93bl9ncGlvOwo+ID4gLcKgwqDCoMKgwqDCoCBzdHJ1Y3QgZ3Bpb19kZXNjwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICpyZXNldF9ncGlvOwo+ID4gwqB9Owo+ID4gCj4g
PiDCoHN0YXRpYyBpbnQgYWQ5NDY3X3NwaV9yZWFkKHN0cnVjdCBzcGlfZGV2aWNlICpzcGksIHVu
c2lnbmVkIGludCByZWcpCj4gPiBAQCAtMzc4LDYgKzM3NywyMyBAQCBzdGF0aWMgaW50IGFkOTQ2
N19wcmVlbmFibGVfc2V0dXAoc3RydWN0IGFkaV9heGlfYWRjX2NvbnYKPiA+ICpjb252KQo+ID4g
wqDCoMKgwqDCoMKgwqAgcmV0dXJuIGFkOTQ2N19vdXRwdXRtb2RlX3NldChzdC0+c3BpLCBzdC0+
b3V0cHV0X21vZGUpOwo+ID4gwqB9Cj4gPiAKPiA+ICtzdGF0aWMgaW50IGFkOTQ2N19yZXNldChz
dHJ1Y3QgZGV2aWNlICpkZXYpCj4gPiArewo+ID4gK8KgwqDCoMKgwqDCoCBzdHJ1Y3QgZ3Bpb19k
ZXNjICpncGlvOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoCBncGlvID0gZGV2bV9ncGlvZF9nZXRf
b3B0aW9uYWwoZGV2LCAicmVzZXQiLCBHUElPRF9PVVRfSElHSCk7Cj4gPiArwqDCoMKgwqDCoMKg
IGlmIChJU19FUlIoZ3BpbykpCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1
cm4gUFRSX0VSUihncGlvKTsKPiA+ICvCoMKgwqDCoMKgwqAgaWYgKCFncGlvKQo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4gCj4gc2FtZSBjb21tZW50IGFzIGJl
Zm9yZSBhYm91dCByZXBsYWNpbmcgdHdvIGlmcyB3aXRoIG9uZToKPiAKPiDCoMKgwqDCoMKgwqDC
oCBpZiAoSVNfRVJSX09SX05VTEwoZ3BpbykpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHJldHVybiBQVFJfRVJSX09SX1pFUk8oZ3Bpbyk7Cj4gCgpCYWgsIGZvcmdvdCBhYm91dCB0
aGF0IG9uZS4uLiB3aWxsIGRvIGFzIHN1Z2dlc3RlZC4KCi0gTnVubyBTw6EKCj4gCj4gPiArCj4g
PiArwqDCoMKgwqDCoMKgIGZzbGVlcCgxKTsKPiA+ICvCoMKgwqDCoMKgwqAgZ3Bpb2Rfc2V0X3Zh
bHVlX2NhbnNsZWVwKGdwaW8sIDApOwo+ID4gK8KgwqDCoMKgwqDCoCBmc2xlZXAoMTAgKiBVU0VD
X1BFUl9NU0VDKTsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4gPiArfQo+ID4g
Kwo+ID4gwqBzdGF0aWMgaW50IGFkOTQ2N19wcm9iZShzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpKQo+
ID4gwqB7Cj4gPiDCoMKgwqDCoMKgwqDCoCBjb25zdCBzdHJ1Y3QgYWQ5NDY3X2NoaXBfaW5mbyAq
aW5mbzsKPiA+IEBAIC00MDgsMTggKzQyNCw5IEBAIHN0YXRpYyBpbnQgYWQ5NDY3X3Byb2JlKHN0
cnVjdCBzcGlfZGV2aWNlICpzcGkpCj4gPiDCoMKgwqDCoMKgwqDCoCBpZiAoSVNfRVJSKHN0LT5w
d3Jkb3duX2dwaW8pKQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBQ
VFJfRVJSKHN0LT5wd3Jkb3duX2dwaW8pOwo+ID4gCj4gPiAtwqDCoMKgwqDCoMKgIHN0LT5yZXNl
dF9ncGlvID0gZGV2bV9ncGlvZF9nZXRfb3B0aW9uYWwoJnNwaS0+ZGV2LCAicmVzZXQiLAo+ID4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgR1BJT0RfT1VUX0xPVyk7Cj4g
PiAtwqDCoMKgwqDCoMKgIGlmIChJU19FUlIoc3QtPnJlc2V0X2dwaW8pKQo+ID4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIFBUUl9FUlIoc3QtPnJlc2V0X2dwaW8pOwo+ID4g
LQo+ID4gLcKgwqDCoMKgwqDCoCBpZiAoc3QtPnJlc2V0X2dwaW8pIHsKPiA+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHVkZWxheSgxKTsKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHJldCA9IGdwaW9kX2RpcmVjdGlvbl9vdXRwdXQoc3QtPnJlc2V0X2dwaW8sIDEpOwo+
ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHJldCkKPiA+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gcmV0Owo+ID4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbWRlbGF5KDEwKTsKPiA+IC3CoMKgwqDCoMKgwqAgfQo+
ID4gK8KgwqDCoMKgwqDCoCByZXQgPSBhZDk0NjdfcmVzZXQoJnNwaS0+ZGV2KTsKPiA+ICvCoMKg
wqDCoMKgwqAgaWYgKHJldCkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVy
biByZXQ7Cj4gPiAKPiA+IMKgwqDCoMKgwqDCoMKgIGNvbnYtPmNoaXBfaW5mbyA9ICZpbmZvLT5h
eGlfYWRjX2luZm87Cj4gPiAKPiA+IAo+ID4gLS0KPiA+IDIuNDMuMAo+ID4gCj4gPiAKPiAKPiBX
aXRoIHRoZSBzdWdnZXN0ZWQgY2hhbmdlIGFib3ZlOgo+IAo+IFJldmlld2VkLWJ5OiBEYXZpZCBM
ZWNobmVyIDxkbGVjaG5lckBiYXlsaWJyZS5jb20+Cgo=


