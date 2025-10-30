Return-Path: <linux-iio+bounces-25666-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE53C1FCB2
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 12:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 048F91887684
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 11:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7850833F360;
	Thu, 30 Oct 2025 11:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sAe8V63J"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616F52820A4
	for <linux-iio@vger.kernel.org>; Thu, 30 Oct 2025 11:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761823406; cv=none; b=QFbumgANtych8zRFucWObu2lAJPc+K0ja9LdcSoCz5CQySRBopDnl5VdCl8mzx9+C1T1gPM5Fy5lirOal/kGBjD8Cy1eY0hCJsDBVeqI/ZJW8xEoyrUh0rwyxMOaAlv9vZe9IOB+aut4r19XrQlOwF+NPvROv177HlLQ9Q1Rk6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761823406; c=relaxed/simple;
	bh=oiUbO1d3hb2fwzyCZ+aN2Hxgm3x+P2N3m7QZfKf1EAY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JHRk439rAYDazdVk1jzqZ1wtd/dDFSUUifIGu3xusclcvwx3nX7jJii+JXREEWcMb7KPGPDMIddFBPTwBwUzZV2FNKsp0m+0BB7a7b5yVEulW47NenYW9LQRYRKKUeXO+bNnJ8F5XBZ9R04rYzfVdQWArXnMwc6YP0f7+lPjS8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=sAe8V63J; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-63e18829aa7so1240866a12.3
        for <linux-iio@vger.kernel.org>; Thu, 30 Oct 2025 04:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761823403; x=1762428203; darn=vger.kernel.org;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oiUbO1d3hb2fwzyCZ+aN2Hxgm3x+P2N3m7QZfKf1EAY=;
        b=sAe8V63JnpEcCGswa8MKd0Y7HagTC14/S30d7mhnq+oJ44/B9V7T4pjMLHi6nH3Pir
         y5Zdw4bOWV5k8Qh6VWxwf8h0OB/Xtc+PiJfXHOHzzI4oW5WQNcJ+wTYymjAGt+tnq8jQ
         IpFNk266U0Gyaih75FTZBWQW3tXmelFfy3UXxMjLo5SpODTvFCCqgSmxjNTRYAL3THaB
         PkZYQvY78OV9GDXjYuvvCUuZ0nJME4Jxv3vnIDrUy4ei8QYee9mDS3XhdEf8sBkqQTXA
         KWp0+hXEZTvzaEaOkebo9zLZUl8HfOQ5DHh27HKk+V0bP9jlTagKW9lNMGsfWv9Cb+nv
         H8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761823403; x=1762428203;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oiUbO1d3hb2fwzyCZ+aN2Hxgm3x+P2N3m7QZfKf1EAY=;
        b=ojHo91ks1XXYT2bzWluZC4Hs7godtrBEOJRpY4Jt8dvEt29WE7lb/qj57rOjRh9J/H
         rwslBVPxTb5DtxeQkT3RIUy8/uAR8QTs8DoUBAQJysQmTwroyKSi8WrublOibgneS5MG
         htlQF4JKKz03M7PRYom1gYakWB599jquKAxf8y+XFdk72w/qbuxhkIajLevQm4VTS/oA
         3cshVTLA1YS22D6vmBwdL5EWB0cPZkBNwl8lVHJMaXjNQGd1XZHUKPqtScfPlw7pH6AB
         n8dgzCEjnZ65MZio3R9eramWuyjMTrP5NPq/7AbGfCaeM6h3zK9gY7AZtcduuJqvVZhb
         ep9g==
X-Forwarded-Encrypted: i=1; AJvYcCX2spd+Ky4rvvTygmJYtlnW+QjFVDPnUvg/zvdgO2aEYq51XpLCTuaB/wskygX3KznrSe7DPtLCqN0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx892XkYJgvJZXITfxUT3Zo7ZmgzhpCcQ8CxJ880aSiXZ0Lo0X/
	Rx9Yjese0SvGkKyetzUI4umvE8kLOaolj/eyV0Sn/5ETfyBtbBQFABRyRCOZRN1Qy5w=
X-Gm-Gg: ASbGncuFoh/uOKWe82SUCkyXyOLgI6Yo9PuY/PnXcNVLbfoAfZ4d/7A/Vm6dQYU7G4d
	/uqL0z/knG4Onqw987W0rTS8QeYOYYL1I6QtFT9na6BXkILnY2PKdwTw9EeC5uRtGJVaEZt2J+w
	NiqwKj7rFIpjF34r5bk+1RYxT9i92ztWiXjsi69W3ge2p+/6aFDM7wF+QHG5FmXNdSTj8wgwkFC
	K7q7G8S7LsnPIRXqj7nPqLqVihSrdR9B366pwWT7foC+DBUVBWD9sTDJTEEYmU+pEyhdzfzxhXe
	GBfPMhzryzpK572oyOOia8M+yl7fa1cjoK4cmQZowJ+/66zQ3s1VsitHzsYal98gFvldwkEBPJc
	LqWHgN9QZx+7kIftz/aJVDJ9JVOTvPPNk8PngxQTcbbNavVRgkCnsQZiO8pIFdQpSiv4qo/785Q
	2MnZUXoGhtHb/8KY5fMBRSkZvbMODNvZcXuA1jjg==
X-Google-Smtp-Source: AGHT+IFc6m+nMDFkhuN6fkCkGUFwscTkxeKDllrODi6tgfhp7cY/9rkLZ7I78qym6yK6GnQjQmsvWQ==
X-Received: by 2002:a05:6402:5114:b0:63b:ef0e:dfca with SMTP id 4fb4d7f45d1cf-64061a20728mr2188847a12.4.1761823402628;
        Thu, 30 Oct 2025 04:23:22 -0700 (PDT)
Received: from [10.203.83.89] (mob-176-247-57-96.net.vodafone.it. [176.247.57.96])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7efd0c1fsm14634640a12.37.2025.10.30.04.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 04:23:22 -0700 (PDT)
Message-ID: <c1c7222b35a0a7bcddc5d88c92f64d2f2a75fdfd.camel@baylibre.com>
Subject: Re: [PATCH 8/9] iio: imu: st_lsm6dsx: add event configurability on
 a per axis basis
From: Francesco Lavra <flavra@baylibre.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Jonathan Cameron
 <jic23@kernel.org>,  David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 30 Oct 2025 12:23:19 +0100
In-Reply-To: <aQMgxUNA8XNhPZdG@smile.fi.intel.com>
References: <20251030072752.349633-1-flavra@baylibre.com>
	 <20251030072752.349633-9-flavra@baylibre.com>
	 <aQMgxUNA8XNhPZdG@smile.fi.intel.com>
Organization: BayLibre
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-P5Tv+66OR+vtWhWFF83f"
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-P5Tv+66OR+vtWhWFF83f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

T24gVGh1LCAyMDI1LTEwLTMwIGF0IDEwOjI0ICswMjAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
Cj4gT24gVGh1LCBPY3QgMzAsIDIwMjUgYXQgMDg6Mjc6NTFBTSArMDEwMCwgRnJhbmNlc2NvIExh
dnJhIHdyb3RlOgo+ID4gSW4gb3JkZXIgdG8gYmUgYWJsZSB0byBjb25maWd1cmUgZXZlbnQgZGV0
ZWN0aW9uIG9uIGEgcGVyIGF4aXMKPiA+IGJhc2lzIChmb3IgZWl0aGVyIHNldHRpbmcgYW4gZXZl
bnQgdGhyZXNob2xkL3NlbnNpdGl2aXR5IHZhbHVlLCBvcgo+ID4gZW5hYmxpbmcvZGlzYWJsaW5n
IGV2ZW50IGRldGVjdGlvbiksIGFkZCBuZXcgYXhpcy1zcGVjaWZpYyBmaWVsZHMKPiA+IHRvIHN0
cnVjdCBzdF9sc202ZHN4X2V2ZW50X3NyYywgYW5kIG1vZGlmeSB0aGUgbG9naWMgdGhhdCBoYW5k
bGVzCj4gPiBldmVudCBjb25maWd1cmF0aW9uIHRvIHByb3Blcmx5IGhhbmRsZSBheGlzLXNwZWNp
ZmljIHNldHRpbmdzIHdoZW4KPiA+IHN1cHBvcnRlZCBieSBhIGdpdmVuIGV2ZW50IHNvdXJjZS4K
PiA+IEEgZnV0dXJlIGNvbW1pdCB3aWxsIGFkZCBhY3R1YWwgZXZlbnQgc291cmNlcyB3aXRoIHBl
ci1heGlzCj4gPiBjb25maWd1cmFiaWxpdHkuCj4gCj4gLi4uCj4gCj4gPiArwqDCoMKgwqDCoMKg
wqBvbGRfZW5hYmxlID0gaHctPmVuYWJsZV9ldmVudFtldmVudF07Cj4gPiArwqDCoMKgwqDCoMKg
wqBuZXdfZW5hYmxlID0gc3RhdGUgPyAob2xkX2VuYWJsZSB8IEJJVChheGlzKSkgOiAob2xkX2Vu
YWJsZSAmCj4gPiB+QklUKGF4aXMpKTsKPiA+ICvCoMKgwqDCoMKgwqDCoGlmICghIW9sZF9lbmFi
bGUgPT0gISFuZXdfZW5hYmxlKQo+IAo+IFRoaXMgaXMgYW4gaW50ZXJlc3RpbmcgY2hlY2suIFNv
LCBvbGRfZW5hYmxlIGFuZCBuZXdfZW5hYmxlIGFyZSBfbm90Xwo+IGJvb2xlYW5zLCByaWdodD8K
PiBTbywgdGhpcyBtZWFucyB0aGUgY2hlY2sgdGVzdCBpZiBfYW55XyBvZiB0aGUgYml0IHdhcyBz
ZXQgYW5kIGtlcHQgc2V0IG9yCj4gbm9uZSB3ZXJlIHNldAo+IGFuZCBub24gaXMgZ29pbmcgdG8g
YmUgc2V0LiBDb3JyZWN0PyBJIHRoaW5rIGEgc2hvcnQgY29tbWVudCB3b3VsZCBiZQo+IGdvb2Qg
dG8gaGF2ZS4KCm9sZF9lbmFibGUgYW5kIG5ld19lbmFibGUgYXJlIGJpdCBtYXNrcywgYnV0IHdl
IGFyZSBvbmx5IGludGVyZXN0ZWQgaW4Kd2hldGhlciBhbnkgYml0IGlzIHNldCwgdG8gY2F0Y2gg
dGhlIGNhc2VzIHdoZXJlIHRoZSBiaXQgbWFzayBnb2VzIGZyb20KemVybyB0byBub24temVybyBh
bmQgdmljZSB2ZXJzYS4gV2lsbCBhZGQgYSBjb21tZW50LgoKPiAKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsKPiAKPiAuLi4KPiAKPiA+ICtzdGF0aWMgY29uc3Qg
c3RydWN0IHN0X2xzbTZkc3hfcmVnICpzdF9sc202ZHN4X2dldF9ldmVudF9yZWcoc3RydWN0Cj4g
PiBzdF9sc202ZHN4X2h3ICpodywKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVudW0KPiA+IHN0X2xzbTZkc3hfZXZlbnRf
aWQgZXZlbnQsCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBjb25zdAo+ID4gc3RydWN0IGlpb19jaGFuX3NwZWMgKmNoYW4p
Cj4gPiArewo+ID4gK8KgwqDCoMKgwqDCoMKgY29uc3Qgc3RydWN0IHN0X2xzbTZkc3hfZXZlbnRf
c3JjICpzcmMgPSAmaHctPnNldHRpbmdzLQo+ID4gPmV2ZW50X3NldHRpbmdzLnNvdXJjZXNbZXZl
bnRdOwo+ID4gK8KgwqDCoMKgwqDCoMKgY29uc3Qgc3RydWN0IHN0X2xzbTZkc3hfcmVnICpyZWc7
Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqBzd2l0Y2ggKGNoYW4tPmNoYW5uZWwyKSB7Cj4gPiAr
wqDCoMKgwqDCoMKgwqBjYXNlIElJT19NT0RfWDoKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqByZWcgPSAmc3JjLT54X3ZhbHVlOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGJyZWFrOwo+ID4gK8KgwqDCoMKgwqDCoMKgY2FzZSBJSU9fTU9EX1k6Cj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmVnID0gJnNyYy0+eV92YWx1ZTsKPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBicmVhazsKPiA+ICvCoMKgwqDCoMKgwqDCoGNhc2Ug
SUlPX01PRF9aOgo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJlZyA9ICZzcmMt
PnpfdmFsdWU7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYnJlYWs7Cj4gPiAr
wqDCoMKgwqDCoMKgwqBkZWZhdWx0Ogo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oHJldHVybiBOVUxMOwo+ID4gK8KgwqDCoMKgwqDCoMKgfQo+IAo+ID4gK8KgwqDCoMKgwqDCoMKg
aWYgKCFyZWctPmFkZHIpCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmVnID0g
JnNyYy0+dmFsdWU7Cj4gPiArwqDCoMKgwqDCoMKgwqByZXR1cm4gcmVnOwo+IAo+IMKgwqDCoMKg
wqDCoMKgwqBpZiAocmVnLT5hZGRyKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
cmV0dXJuIHJlZzsKPiAKPiDCoMKgwqDCoMKgwqDCoMKgLyogUGVyaGFwcyBhIGNvbW1lbnQgaGVy
ZSB0byBleHBsYWluIHRoZSBjaG9pY2UgKi8KPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuICZzcmMt
PnZhbHVlOwo+ID4gCldpbGwgZG8uCj4gCgo=


--=-P5Tv+66OR+vtWhWFF83f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEhleFT5U73KMewxTm7fE7c86UNl8FAmkDSqcACgkQ7fE7c86U
Nl833AwAo56B5J8jwaMwRZfxSZBiXXlGiXcihr/4WOhKCmcG94wZLv3nxhbFCFz1
9gNnk7THZeGhlfGUX8nlz85YhbcFtjStfqE+Nb1m9Y6AwGcAj6k+cs8vAQGYtZaP
YCFunzUO8WZ0Yg0XtW7toxkdmCVmuPppQUNFd1YDoF7BiyYPrdt+jipjGvpxGMUX
1HE2+fxYtt0T32f8XxXTd+jODRVI3jLGmfoYwWOdaVIcio2uQiaf6dMtXwDlLO7T
CpjvG0bhNT/YZu1vlYuZmZY4MP1lrEaWnwsbgxIImVLHaLnnlq6IUFkskbtXc5zt
0P/LVzYDnzKT+bG0572AJHeE0pdUBHoxwaTH2X1YNvIvrsAH9Di1U71CLBG+I+4j
D+gEeXcOInrxG3Zzzmd60DKxcA+wloD3UAxr3DWvoh1XZdfV2AJHNihJlxGwI24B
ZWEXiTxakdYApMMKgsfrw8PKr28nPPULLcmxJGglr1WMuxodn2G6GTGEcWDSKuOH
S4/mPwKH
=PGvm
-----END PGP SIGNATURE-----

--=-P5Tv+66OR+vtWhWFF83f--

