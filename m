Return-Path: <linux-iio+bounces-812-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E6380C48E
	for <lists+linux-iio@lfdr.de>; Mon, 11 Dec 2023 10:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDBB81C209C4
	for <lists+linux-iio@lfdr.de>; Mon, 11 Dec 2023 09:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3385C21356;
	Mon, 11 Dec 2023 09:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/dP0wDD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A06B4
	for <linux-iio@vger.kernel.org>; Mon, 11 Dec 2023 01:29:26 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-336166b8143so1689959f8f.3
        for <linux-iio@vger.kernel.org>; Mon, 11 Dec 2023 01:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702286965; x=1702891765; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7dVrpejSy2qu5xD6f0ZzCOioQ8ISn7yudTcSKTPnS/8=;
        b=e/dP0wDD5IpeD/AlXqTkYjvmzp7jtNEfJGoH0fpjTbyD57nX2y1F4eq9jq3fyLGCdn
         qADmWwpqgEzeASlfddo2/sGd8LSoTb1qg8XlnvlQMEkHn5eWw8pOswgi1RrvPxr+N3hb
         CFrPcyTSGyxq8Fs1TPbPOx7Aytl6KIIutxZ33Ih6XJydaIVnvww+WIxQe4IUKGSY9QAm
         UGJGdzXU7X3macqf90MWJ465h3wzVWpZbmWYplp+Yy/ZVu9vt7DB9I6O3xmpxUTlRZfg
         OhVLp7H8JEUGBSep2fbRG6fxnaJ/R/X2otxDBcnI/KcgAuySMU6+OVhbpg1Zl8w1cZjr
         397w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702286965; x=1702891765;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7dVrpejSy2qu5xD6f0ZzCOioQ8ISn7yudTcSKTPnS/8=;
        b=ZmRpF+2Px1d/IKQihzTA5kAW+Wyx3j6jIh+NEHsl6ukPRUOLKMW5dTyAF2QTjgAGGW
         Ziouyc7fKVcV1sOsy67fNWliIgJMCbio8ZBZeEE+HgHWmzYc7UUe6R6XkKNKX7fN8L7l
         gvHTlNOegf3Uw6HJPtRptvcR5k9fSAepceKtqsxyQuyYw35bC8uC9oOXc/wlCvGpDvdb
         QRvUYgNd10g8sgE9VZ5gFe4DFHBEz8DrVM+7s1BTJVjgptcfEbtlc1+0tDH1TlwvxKZz
         5v3GaKHF1+F2+TrlNjMPnL9t0P9ZYVd13BDQm6TVMWmsUfE+MjjfQDAYhd/Tv7QdnpCz
         DYiQ==
X-Gm-Message-State: AOJu0YzwTjDTOPEsNr2R1SPjDLDIGjXpmKBOXuspSNiNE1GE82vnte3w
	0lC/BWj7uBUKGqiLI9b6zbQ=
X-Google-Smtp-Source: AGHT+IEmr9JOlRu+O/qD6lLuaAmuQgdNpT78O1tepUj4lxoUust6+u5HIhNJgPK1Zl/ZZrstFCr+FA==
X-Received: by 2002:a05:6000:1248:b0:334:bc94:c166 with SMTP id j8-20020a056000124800b00334bc94c166mr1927699wrx.58.1702286964959;
        Mon, 11 Dec 2023 01:29:24 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id m1-20020a056000008100b00334b3208700sm8065403wrx.49.2023.12.11.01.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 01:29:24 -0800 (PST)
Message-ID: <91aa6dde16434aaa3fbc30eeb8c944a89fca4983.camel@gmail.com>
Subject: Re: [PATCH 4/8] iio: adc: ad9467: fix scale setting
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com, 
 linux-iio@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>,  Lars-Peter Clausen <lars@metafoo.de>
Date: Mon, 11 Dec 2023 10:32:27 +0100
In-Reply-To: <20231210112700.57fcdbf5@jic23-huawei>
References: <20231205-iio-backend-prep-v1-0-7c9bc18d612b@analog.com>
	 <20231205-iio-backend-prep-v1-4-7c9bc18d612b@analog.com>
	 <CAMknhBF84oWxgGpyj=6S013qCrqHXRFk6Apub94FN6SUcWSmsA@mail.gmail.com>
	 <5a157ef34eb4c713f66ee49f088747135d4d1cd9.camel@gmail.com>
	 <20231210112700.57fcdbf5@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.50.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gU3VuLCAyMDIzLTEyLTEwIGF0IDExOjI3ICswMDAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Ogo+IE9uIFRodSwgMDcgRGVjIDIwMjMgMTE6MDI6MzYgKzAxMDAKPiBOdW5vIFPDoSA8bm9uYW1l
Lm51bm9AZ21haWwuY29tPiB3cm90ZToKPiAKPiA+IE9uIFdlZCwgMjAyMy0xMi0wNiBhdCAxNzow
MSAtMDYwMCwgRGF2aWQgTGVjaG5lciB3cm90ZToKPiA+ID4gT24gVHVlLCBEZWMgNSwgMjAyMyBh
dCAxMTowNuKAr0FNIE51bm8gU2EgdmlhIEI0IFJlbGF5Cj4gPiA+IDxkZXZudWxsK251bm8uc2Eu
YW5hbG9nLmNvbUBrZXJuZWwub3JnPiB3cm90ZTrCoCAKPiA+ID4gPiAKPiA+ID4gPiBGcm9tOiBO
dW5vIFNhIDxudW5vLnNhQGFuYWxvZy5jb20+Cj4gPiA+ID4gCj4gPiA+ID4gV2hlbiByZWFkaW5n
IGluX3ZvbHRhZ2Vfc2NhbGUgd2UgY2FuIGdldCBzb21ldGhpbmcgbGlrZToKPiA+ID4gPiAKPiA+
ID4gPiByb290QGFuYWxvZzovc3lzL2J1cy9paW8vZGV2aWNlcy9paW86ZGV2aWNlMiMgY2F0IGlu
X3ZvbHRhZ2Vfc2NhbGUKPiA+ID4gPiAwLjAzODE0Ngo+ID4gPiA+IAo+ID4gPiA+IEhvd2V2ZXIs
IHdoZW4gcmVhZGluZyB0aGUgYXZhaWxhYmxlIG9wdGlvbnM6Cj4gPiA+ID4gCj4gPiA+ID4gcm9v
dEBhbmFsb2c6L3N5cy9idXMvaWlvL2RldmljZXMvaWlvOmRldmljZTIjIGNhdAo+ID4gPiA+IGlu
X3ZvbHRhZ2Vfc2NhbGVfYXZhaWxhYmxlCj4gPiA+ID4gMjAwMC4wMDAwMDAgMjEwMC4wMDAwMDYg
MjIwMC4wMDAwMDcgMjMwMC4wMDAwMDggMjQwMC4wMDAwMDkgMjUwMC4wMDAwMTAKPiA+ID4gPiAK
PiA+ID4gPiB3aGljaCBkb2VzIG5vdCBtYWtlIHNlbnNlLiBNb3Jlb3Zlciwgd2hlbiB0cnlpbmcg
dG8gc2V0IGEgbmV3IHNjYWxlIHdlCj4gPiA+ID4gZ2V0IGFuIGVycm9yIGJlY2F1c2UgdGhlcmUn
cyBubyBjYWxsIHRvIF9fYWQ5NDY3X2dldF9zY2FsZSgpIHRvIGdpdmUgdXMKPiA+ID4gPiB2YWx1
ZXMgYXMgZ2l2ZW4gd2hlbiByZWFkaW5nIGluX3ZvbHRhZ2Vfc2NhbGUuIEZpeCBpdCBieSBjb21w
dXRpbmcgdGhlCj4gPiA+ID4gYXZhaWxhYmxlIHNjYWxlcyBkdXJpbmcgcHJvYmUgYW5kIHByb3Bl
cmx5IHBhc3MgdGhlIGxpc3Qgd2hlbgo+ID4gPiA+IC5yZWFkX2F2YWlsYWJsZSgpIGlzIGNhbGxl
ZC4KPiA+ID4gPiAKPiA+ID4gPiBXaGlsZSBhdCBpdCwgY2hhbmdlIHRvIHVzZSAucmVhZF9hdmFp
bGFibGUoKSBmcm9tIGlpb19pbmZvLiBBbHNvIG5vdGUKPiA+ID4gPiB0aGF0IHRvIHByb3Blcmx5
IGZpeCB0aGlzLCBhZGktYXhpLWFkYy5jIGhhcyB0byBiZSBjaGFuZ2VkIGFjY29yZGluZ2x5Lgo+
ID4gPiA+IAo+ID4gPiA+IEZpeGVzOiBhZDY3OTcxMjAyMzggKCJpaW86IGFkYzogYWQ5NDY3OiBh
ZGQgc3VwcG9ydCBBRDk0NjcgQURDIikKPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBOdW5vIFNhIDxu
dW5vLnNhQGFuYWxvZy5jb20+Cj4gPiA+ID4gLS0tCj4gPiA+ID4gwqBkcml2ZXJzL2lpby9hZGMv
YWQ5NDY3LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgNDcgKysrKysrKysrKysrKysrKysrKysr
KysKPiA+ID4gPiDCoGRyaXZlcnMvaWlvL2FkYy9hZGktYXhpLWFkYy5jwqDCoMKgwqDCoMKgIHwg
NzQgKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gPiA+ID4gLS0tLS0tLQo+ID4gPiA+
IMKgaW5jbHVkZS9saW51eC9paW8vYWRjL2FkaS1heGktYWRjLmggfMKgIDQgKysKPiA+ID4gPiDC
oDMgZmlsZXMgY2hhbmdlZCwgNjYgaW5zZXJ0aW9ucygrKSwgNTkgZGVsZXRpb25zKC0pCj4gPiA+
ID4gCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2FkYy9hZDk0NjcuYyBiL2RyaXZl
cnMvaWlvL2FkYy9hZDk0NjcuYwo+ID4gPiA+IGluZGV4IGJhZGJlZjJjZTlmOC4uM2M4YmQ2Yzgy
MWE0IDEwMDY0NAo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvaWlvL2FkYy9hZDk0NjcuYwo+ID4gPiA+
ICsrKyBiL2RyaXZlcnMvaWlvL2FkYy9hZDk0NjcuYwo+ID4gPiA+IEBAIC0xMjAsNiArMTIwLDcg
QEAgc3RydWN0IGFkOTQ2N19zdGF0ZSB7Cj4gPiA+ID4gwqDCoMKgwqDCoMKgwqAgc3RydWN0IHNw
aV9kZXZpY2XCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICpzcGk7Cj4gPiA+ID4gwqDCoMKg
wqDCoMKgwqAgc3RydWN0IGNsa8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAqY2xrOwo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGludMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG91dHB1dF9tb2RlOwo+ID4gPiA+ICvCoMKgwqDC
oMKgwqAgdW5zaWduZWQgaW50wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
KCpzY2FsZXMpWzJdOwo+ID4gPiA+IAo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBncGlv
X2Rlc2PCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKnB3cmRvd25fZ3BpbzsKPiA+ID4g
PiDCoMKgwqDCoMKgwqDCoCAvKiBlbnN1cmUgY29uc2lzdGVudCBzdGF0ZSBvYnRhaW5lZCBvbiBt
dWx0aXBsZSByZWxhdGVkIGFjY2Vzc2VzCj4gPiA+ID4gKi8KPiA+ID4gPiBAQCAtMjE2LDYgKzIx
Nyw3IEBAIHN0YXRpYyB2b2lkIF9fYWQ5NDY3X2dldF9zY2FsZShzdHJ1Y3QKPiA+ID4gPiBhZGlf
YXhpX2FkY19jb252ICpjb252LAo+ID4gPiA+IGludCBpbmRleCwKPiA+ID4gPiDCoMKgwqDCoMKg
wqDCoCAuY2hhbm5lbCA9IF9jaGFuLMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
Cj4gPiA+ID4gXAo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgIC5pbmZvX21hc2tfc2hhcmVkX2J5X3R5
cGUgPSBCSVQoSUlPX0NIQU5fSU5GT19TQ0FMRSkgfMKgwqDCoMKgwqDCoMKgwqDCoAo+ID4gPiA+
IFwKPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQklUKElJT19DSEFOX0lO
Rk9fU0FNUF9GUkVRKSzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgCj4gPiA+ID4gXAo+ID4gPiA+ICvCoMKgwqDCoMKgwqAgLmluZm9fbWFza19zaGFy
ZWRfYnlfdHlwZV9hdmFpbGFibGUgPSBCSVQoSUlPX0NIQU5fSU5GT19TQ0FMRSksCj4gPiA+ID4g
XAo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgIC5zY2FuX2luZGV4ID0gX3NpLMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoAo+ID4gPiA+IFwKPiA+ID4gPiDCoMKgwqDCoMKgwqDCoCAuc2Nh
bl90eXBlID0ge8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgCj4gPiA+
ID4gXAo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAuc2lnbiA9IF9zaWdu
LMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAKPiA+ID4gPiBcCj4gPiA+ID4gQEAgLTM3MCw2ICsz
NzIsMjYgQEAgc3RhdGljIGludCBhZDk0Njdfd3JpdGVfcmF3KHN0cnVjdCBhZGlfYXhpX2FkY19j
b252Cj4gPiA+ID4gKmNvbnYsCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqAgfQo+ID4gPiA+IMKgfQo+
ID4gPiA+IAo+ID4gPiA+ICtzdGF0aWMgaW50IGFkOTQ2N19yZWFkX2F2YWlsKHN0cnVjdCBhZGlf
YXhpX2FkY19jb252ICpjb252LAo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGlpb19jaGFuX3NwZWMgY29uc3QgKmNo
YW4sCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBjb25zdCBpbnQgKip2YWxzLCBpbnQgKnR5cGUsIGludCAqbGVuZ3RoLAo+ID4g
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgbG9uZyBtYXNrKQo+ID4gPiA+ICt7Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoCBjb25zdCBzdHJ1
Y3QgYWRpX2F4aV9hZGNfY2hpcF9pbmZvICppbmZvID0gY29udi0+Y2hpcF9pbmZvOwo+ID4gPiA+
ICvCoMKgwqDCoMKgwqAgc3RydWN0IGFkOTQ2N19zdGF0ZSAqc3QgPSBhZGlfYXhpX2FkY19jb252
X3ByaXYoY29udik7Cj4gPiA+ID4gKwo+ID4gPiA+ICvCoMKgwqDCoMKgwqAgc3dpdGNoIChtYXNr
KSB7Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoCBjYXNlIElJT19DSEFOX0lORk9fU0NBTEU6Cj4gPiA+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKnZhbHMgPSAoY29uc3QgaW50ICopc3Qt
PnNjYWxlczsKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqdHlwZSA9IElJ
T19WQUxfSU5UX1BMVVNfTUlDUk87Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgLyogVmFsdWVzIGFyZSBzdG9yZWQgaW4gYSAyRCBtYXRyaXggKi8KPiA+ID4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqbGVuZ3RoID0gaW5mby0+bnVtX3NjYWxlcyAqIDI7wqAg
Cj4gPiA+IAo+ID4gPiBNYXliZSB1c2UgQVJSQVlfU0laRSgqaW5mby0+c2NhbGVzKSBoZXJlIGlu
c3RlYWQgb2YgaGFyZC1jb2RpbmcgMj/CoCAKPiA+IAo+ID4gTm90IHRvIGtlZW4gb24gdGhhdCBh
cyB0aGUgY29tbWVudCBzaG91bGQgYWxyZWFkeSBzYXkgZXZlcnl0aGluZyBhYm91dCB0aGUKPiA+
IGhhcmRjb2RlZAo+ID4gMi4KPiA+IAo+IEkgZG9uJ3QgbWluZCBlaXRoZXIgd2F5LCBidXQgdGhl
IGNvbW1lbnQgb25seSBzYXlzIGl0J3MgYSAyRCBtYXRyaXgsIG5vdCB0aGF0Cj4gdGhlIGRpbWVu
c2lvbgo+IGlzIDIgKiBudW1fc2NhbGVzIC0gaXQgY291bGQgZWFzaWx5IGJlIDE0ICogbnVtX3Nj
YWxlcwoKT29wcywgdG90YWxseSByaWdodCEgRm9yIHNvbWUgcmVhc29uIEkgd2FzIHNlZWluZyB0
aGUgY29tbWVudCBhcyAiMiBjb2x1bW5zIiBpbgp0aGUgbWF0cml4IHdoaWNoIGlzIG9idmlvdXNs
eSBub3QgdHJ1ZSAoYnV0IEkgc3VzcGVjdCB0aGF0IHdhcyB0aGUgaW50ZW50IG9mIHRoZQpjb21t
ZW50KQoKLSBOdW5vIFPDoQoK


