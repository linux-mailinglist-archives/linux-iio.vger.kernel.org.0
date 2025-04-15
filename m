Return-Path: <linux-iio+bounces-18129-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F997A89784
	for <lists+linux-iio@lfdr.de>; Tue, 15 Apr 2025 11:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A24B47A1395
	for <lists+linux-iio@lfdr.de>; Tue, 15 Apr 2025 09:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E13D27B4E3;
	Tue, 15 Apr 2025 09:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDR7UbSH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9742E27B4EB;
	Tue, 15 Apr 2025 09:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744708091; cv=none; b=pbMeM7ZpWMi8aq8EHRH574jiCzFCRauYO/pJRcqLX8+jWcuFSIrHINUK7LoXFUPq2HKyO4Dvu2Sg/tefJUdIcYxgJ9ANe4SH4rlHw0hqe8eEQrMXrHD5+YajNQfjQ/cXvTFThE2MCOydfXRSB6WSRzEQx6D9igB07lzwWJ3YKpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744708091; c=relaxed/simple;
	bh=lfUREmygUPm0Jj5r1LTZOWueVQMn0sd7cjQR1OIjf3c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GG5fs7vMkJCMaq1aavY1Zr07vT+VZTX2YuBn0Vesww6uXyYCrHzdWoGj8b8dk6xixAlEodbkdA/Mwq8EGyYLyCrtvsO27SmrLnXElTPEdYODF7wgtQLnECgZ4S+it5dIrj/SGKfK/bf2euAS778e8ZMe5YEBVykYh2tYEpQ+fyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDR7UbSH; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39c14016868so4839987f8f.1;
        Tue, 15 Apr 2025 02:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744708088; x=1745312888; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lfUREmygUPm0Jj5r1LTZOWueVQMn0sd7cjQR1OIjf3c=;
        b=LDR7UbSH/EAttQLIO7bgdWcLHfqXHuHWuBQRcoUuesGWAmA+2lCJE8BSL1JhqxOzFP
         9antJ1Oe7r1evDk2iiBY52332Wwbyz3JbuoAMk6T5O6x+YexWPYpqiQ30NaI+4NMkzeR
         GEuRy9fSbmnI1fCe5M5vaE2cIST6PwjOmDUiaO133+Dwk0Db5VSGJQNCPu+O0QkQ8bbt
         f6LkqjfYyMz1Ir6RJ7lwRgPa3DmTY+Y4HcYk5R4x+uSPsqOGHa4l09GQFqdmx0D78gbd
         ykeS+DmZ3y2AQKSaR5azL5Mw9PBsM7vo9mxpBoEvD/nytctMjYnHoiAeFrGno/KKIhAT
         9uaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744708088; x=1745312888;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lfUREmygUPm0Jj5r1LTZOWueVQMn0sd7cjQR1OIjf3c=;
        b=dQwV+rEM6Vcfz6N7UoHa+PY/twQLooBvvGqStIVac/BX/HN0/XLuxxVUULfYs6cR5m
         MDHNnyHyzw9H3jnSdgeKwWE5+Oy0m5etixxBtfyrefpkNqOIlE6GG6pHezHkTPOBEvm+
         OqLc9JgOf2dXoB07APb4h2ljgj1ux1HYhjlroBICV8rJYTbrHHuDFs0irEWHZqjvx/Db
         XzvIKglKVzp7w3mruAgGgzXShFA+ke8i0ctUTqCw/p2ODhDJyECNoo1J+Uon3CV0OIf0
         poMGuHFUb+jzA8ZHizmtASVO+Hg9P8Nr5mQFxfo+ti5OBgcfzmZT0HmucvtbrCS+n+fg
         9Q5A==
X-Forwarded-Encrypted: i=1; AJvYcCUHQBJf7dEjzA2tIwuCsMa0aClK0259BJOmPz8g/0azDaofsZCq59sgK6tMc3IApF931n+KM2LBqFU=@vger.kernel.org, AJvYcCWhbYlZmX3O/YoySI6wdyhweKduDigUvP2zgrgnEY3mO6MMdniw5LnclTkxEIUJkHeqTSGL3hS2XK+6fkzQ@vger.kernel.org, AJvYcCXwx6meFILnY8vTY7B9wHBMxrRjVciyXqYlb9UbC61NJYdLY9UHcgx/nOBuLVRifhQa5aONdk/AI2Bq@vger.kernel.org
X-Gm-Message-State: AOJu0YwTr8qt0cRHsF1WIzWl5ZcjbaJRzkYL5BBYLy6rgKe4cVg8tRWQ
	7tsZt5Ld5R3tAdaFifGNdNsPqG05bC+y+ZVFZcpzF/mUUl2igFM2
X-Gm-Gg: ASbGnctCCh2LtqcCHYXNY4arqzz3dBGRYfG3gQ5zyJ7yfG+QcSm2g2robnvvUJk406y
	zNucrhIJZCj3qsqen3JVCZD8tRGXoFytR4s5rvp+CBovcFKGkg2LPt5ft+R5YwfaFfUyKOYW32K
	QUiqgQKc64XEmz9HckCXcqNxzxe5exGI4NC0lUgbKnXEnxHtnlU5b/aY1EG/21CdywdTSslObHj
	md/hINN+irss02/mCaDbesBkmDXAHW+VwzTiyf14Nb73OQROs1Fzbq+uG8gsZRxUDcPgSOMCj9A
	YFbSaPMf2GqzvlloN5fhLb+Teo/rwvY+wTmKeECt2qXTjwvURIuE9tYeisawjioCZuP2kKVIauT
	ox+Jdwr92lE8T
X-Google-Smtp-Source: AGHT+IHvFokkxMDwtcFkEpaJ0Z4DYBlnrZDQ/ooZwQvYNR1ae6siZqjs8Qu/4aQtubMfy6kh8zYE/Q==
X-Received: by 2002:a05:6000:40cd:b0:39c:268e:ae04 with SMTP id ffacd0b85a97d-39e9f3cf20dmr11718479f8f.0.1744708087834;
        Tue, 15 Apr 2025 02:08:07 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae96bf97sm13325934f8f.25.2025.04.15.02.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 02:08:07 -0700 (PDT)
Message-ID: <087b28aeecb54645a52627d84291a5ed6d309011.camel@gmail.com>
Subject: Re: [PATCH] docs: iio: ad3552r: fix malformed table
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, David Lechner	
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Jonathan Corbet
	 <corbet@lwn.net>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, 	linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, sfr@canb.auug.org.au
Date: Tue, 15 Apr 2025 10:08:09 +0100
In-Reply-To: <20250415-wip-bl-ad3552r-fix-doc-table-v1-1-717ffd320c9d@baylibre.com>
References: 
	<20250415-wip-bl-ad3552r-fix-doc-table-v1-1-717ffd320c9d@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVHVlLCAyMDI1LTA0LTE1IGF0IDA5OjQ0ICswMjAwLCBBbmdlbG8gRHVyZWdoZWxsbyB3cm90
ZToKPiBGcm9tOiBBbmdlbG8gRHVyZWdoZWxsbyA8YWR1cmVnaGVsbG9AYmF5bGlicmUuY29tPgo+
IAo+IEZpeCBtYWxmb3JtZWQgdGFibGUuCj4gCj4gRml4ZXM6IDlhMjU5YjUxZTNlYSAoImRvY3M6
IGlpbzogYWRkIGRvY3VtZW50YXRpb24gZm9yIGFkMzU1MnIgZHJpdmVyIikKPiBTaWduZWQtb2Zm
LWJ5OiBBbmdlbG8gRHVyZWdoZWxsbyA8YWR1cmVnaGVsbG9AYmF5bGlicmUuY29tPgo+IC0tLQoK
UmV2aWV3ZWQtYnk6IE51bm8gU8OhIDxudW5vLnNhQGFuYWxvZy5jb20+Cgo+IEZpeCBtYWxmb3Jt
ZWQgdGFibGUuCj4gLS0tCj4gwqBEb2N1bWVudGF0aW9uL2lpby9hZDM1NTJyLnJzdCB8IDIgKy0K
PiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+IAo+IGRp
ZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2lpby9hZDM1NTJyLnJzdCBiL0RvY3VtZW50YXRpb24v
aWlvL2FkMzU1MnIucnN0Cj4gaW5kZXgKPiA1ODI1MDdhYmU4YzRjMmVjYjUxYTFmODM4OWQ3ZGVl
YzQ0ZDIwMjIyLi5mNWQ1OWU0ZTg2YzdlYzgzMzhmM2Y0ZTgyZDdhMDc1ODdlM2QKPiA4NDA0IDEw
MDY0NAo+IC0tLSBhL0RvY3VtZW50YXRpb24vaWlvL2FkMzU1MnIucnN0Cj4gKysrIGIvRG9jdW1l
bnRhdGlvbi9paW8vYWQzNTUyci5yc3QKPiBAQCAtNTYsNyArNTYsNyBAQCBzcGVjaWZpYyBkZWJ1
Z2ZzIHBhdGggYGAvc3lzL2tlcm5lbC9kZWJ1Zy9paW8vaWlvOmRldmljZVhgYC4KPiDCoHwgRGVi
dWdmcyBkZXZpY2UgZmlsZXPCoCB8Cj4gRGVzY3JpcHRpb27CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHwKPiDCoCstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gLS0rCj4gwqB8IGRhdGFfc291cmNlwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfCBUaGUgdXNlZCBkYXRhIHNvdXJjZSwKPiBhc8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwKPiAtfMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgYGBub3JtYWxgYCwgYGBy
YW1wLTE2Yml0YGAsCj4gZXRjLsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgfAo+ICt8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfCBgYG5vcm1hbGBgLCBgYHJhbXAtMTZiaXRgYCwKPiBldGMuwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8Cj4gwqArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+IC0tKwo+
IMKgfCBkYXRhX3NvdXJjZV9hdmFpbGFibGUgfCBUaGUgYXZhaWxhYmxlIGRhdGEKPiBzb3VyY2Vz
LsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwKPiDC
oCstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gLS0rCj4gCj4gLS0tCj4gYmFzZS1jb21taXQ6IDMxYzUy
ZmUzYjJlZmVlYmZjNzJjYzUzMzY2NTNiYWFhOTg4OWI0MWUKPiBjaGFuZ2UtaWQ6IDIwMjUwNDE1
LXdpcC1ibC1hZDM1NTJyLWZpeC1kb2MtdGFibGUtNTg5MjkzYzliODYwCj4gCj4gQmVzdCByZWdh
cmRzLAo=


