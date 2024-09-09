Return-Path: <linux-iio+bounces-9360-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC9C970E15
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 08:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1BBCB22008
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 06:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B08D1AD3F0;
	Mon,  9 Sep 2024 06:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huCwfcx4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7BA37160;
	Mon,  9 Sep 2024 06:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725864235; cv=none; b=V9d7M0dvDfiZ1+YDQ8XWPCjxvbdubwvT7+IzZnSStIRWfMfqhyL79sx/zQ6faqROq8VozS9X+tN67vyE/jO+ifsfym5y6XhLIhZGbq9/EyAMcMXJ9rh6pKM59pno0kAW2RISNhkUdvywABZ6ovVhzqnflmFeXhDOxPKzSEv0ZrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725864235; c=relaxed/simple;
	bh=SOXatR1/EnYCqDpW1JPuzcUbV8bogDJ7+gPwMI4B8bE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CaDkC8AA8mROUogWNNsQvFLqKPyinUT+B7FD+boc7rAGImwxVHRfNrM5z8Gw79wT822wZcavvo/yIdLVKL8PnS8v+W/HJR48Gwx5ZVp/ly5+lazIoYijkwDsPztlvgCGl+grp5uxizn6ORm2bEORwg3Du8ultMblOyEMsgtJyEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=huCwfcx4; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-848b77c89e0so275290241.0;
        Sun, 08 Sep 2024 23:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725864232; x=1726469032; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:msip_labels:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SOXatR1/EnYCqDpW1JPuzcUbV8bogDJ7+gPwMI4B8bE=;
        b=huCwfcx4LEZ9h0I6TXJaeeBPqXCI/dan3CuF/UmtelQGqLJ1yZB3WHnGH7Bwwv23jO
         GGb5bhkNRBiXCSRuQ5tbx8p5XsoqRzkfXovXdpUb1g3a7jwkzMo162lgBCmvOlUV9w+H
         OFbQhYTAZGq2yXEr1yuQhNnqfY0m63ZvFBijUPyVyj14TJetOdW0+7QCXzG8IwsreBpK
         Sm/YTv965WL4nXFILSneCrCdksBc2lEB8xVFXFfoFc4errOsI0DZpp3QK786Ugjrcjz7
         9V2pPv/a1TVrV1nmgvADNymkEar6+zii3nhyJCkcj1BUfGyY1rA+VppOlPFSA+DcUOi7
         OPtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725864232; x=1726469032;
        h=mime-version:content-transfer-encoding:msip_labels:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SOXatR1/EnYCqDpW1JPuzcUbV8bogDJ7+gPwMI4B8bE=;
        b=lHoWXiB02ICLAM35uDgx43z103ivaRXGJVV4mKKy5N/GbPUdaDU5JSEB2T883Ln7J5
         WcxEd/ci26E1KRk1Yo55RsERTEYeVgypwXwGZV4CsrfUOxVItLMn8kNvJKb3o/zTObo6
         VKcW7rkogJqU1kN1t7ErZmdfzbPYHGoCv9N7MsAKBAJRIw/VSZhSmvPmcvq7+z0gmgFa
         axLb/wt7jiJmoluzh8cWclmlQq1KlKH+aGA7KbDKq4t5kJ0HR/VUjI9Osh6uMqcCUU6+
         z35oG1kC+KN8LjcqzJ6gy4QBvXmEpSx52zo0abdB3iq8lkHU4ASbuqg8rYNM4Ceq7hp7
         FEPw==
X-Forwarded-Encrypted: i=1; AJvYcCX/iKXI3c/xN4PEwrXaipsfyNTSt5yXJrgKaLJf0S6Z+ABD0Rncu5JDRHtmXnR0GAYX4e/wUlTBLCc=@vger.kernel.org, AJvYcCX8+lQMV2jWztFJo6iBgImRmb2VtCj6GWSLLONbquurs29jY5RxgLx+lHqyxEsVzoNqI6yye9KYSunFY9Wi@vger.kernel.org
X-Gm-Message-State: AOJu0YwHVDfOVoD0hFAhrBLFcT5JWd3763s9lyMAl5m0NsuVWrV1UoCG
	E2exMy8KOHTFnW+non8x0JK90xDX60HK+T5/0NxEGu0BBf32kXQpEgRH86rEtt8=
X-Google-Smtp-Source: AGHT+IHjo47VxS9sXtSQVo5YonvLcotfBClbs+ChdJT14PxTCokyCvV5qMSqD7OFLL+va72kskDbsQ==
X-Received: by 2002:a05:6102:32c7:b0:493:de37:b3ef with SMTP id ada2fe7eead31-49bde1b5b56mr9924201137.13.1725864232001;
        Sun, 08 Sep 2024 23:43:52 -0700 (PDT)
Received: from SI6PR01MB6319.apcprd01.prod.exchangelabs.com ([2603:1046:c01:2821::5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a7a038b1sm186277285a.90.2024.09.08.23.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 23:43:51 -0700 (PDT)
From: jason liu <jasonliu10041728@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>, "lars@metafoo.de"
	<lars@metafoo.de>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject:
	=?gb2312?B?u9i4tDogu9i4tDogW1BBVENIXSBpaW8vaW52X2ljbTQyNjAwOiBhZGQgaW52?=
 =?gb2312?B?X2ljbTQyNjAwIGlkX3RhYmxl?=
Thread-Topic:
	=?gb2312?B?u9i4tDogW1BBVENIXSBpaW8vaW52X2ljbTQyNjAwOiBhZGQgaW52X2ljbTQy?=
 =?gb2312?Q?600_id=5Ftable?=
Thread-Index:
	ATMwLjIwFDm9LbMkFZaeBSo+6E5u8rI5M8nJgAAiAACACRXAgIAAnB8AgADWk4CAAHDr24AAGpOAgAL6loCAAZkXhJ1W2dgvgAOGa4CAAUkQ5Q==
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Mon, 9 Sep 2024 06:43:47 +0000
Message-ID:
	<SI6PR01MB63194A7F2D2FD7701DD0465BF5992@SI6PR01MB6319.apcprd01.prod.exchangelabs.com>
References:
	<FR3P281MB175720831E0817C23AD0B1BACE922@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
	<20240902113101.3135-1-jasonliu10041728@gmail.com>
	<CAJci1vC9pvdqEpA8sk+uB5jJGn_DKUruXFfY6tbG9mO07YxgHQ@mail.gmail.com>
	<FR3P281MB1757BEA60FF72A44847F1646CE9D2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
	<SI6PR01MB63197238674C8895885420D8F59E2@SI6PR01MB6319.apcprd01.prod.exchangelabs.com>
 <20240908115115.1bf1155d@jic23-huawei>
In-Reply-To: <20240908115115.1bf1155d@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator:
X-MS-Exchange-Organization-RecordReviewCfmType: 0
msip_labels:
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgSm9uYXRoYW4sDQoNCj4gSGkgSmFzb24sDQoNCj4gSSd2ZSBwaWNrZWQgdGhpcyB1cCwgYnV0
IHRoZSBwYXRjaCBzdWJtaXNzaW9uIGhhcyBhIG51bWJlciBvZiBpc3N1ZXMNCj4geW91IHNob3Vs
ZCBiZSBzdXJlIHRvIGZpeCBpbiBmdXR1cmUgcGF0Y2hlcy4NCj4NCkkgYW0gc29ycnkgZm9yIHRo
ZSBpc3N1ZXMsIGFuZCBJIHdpbGwga2VlcCB5b3VyIHN1Z2dlc3Rpb25zIGluIG1pbmQuDQpTbywg
ZG8gSSBzdGlsbCBuZWVkIHRvIHN1Ym1pdCBhIG5ldyBwYXRjaCB0byBmaXggdGhlc2UgaXNzdWVz
Pw0KTXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IHNpbmNlIHlvdSd2ZSBwaWNrZWQgaXQgdXAsIHRo
ZXJlJ3Mgbm8gbmVlZCBmb3IgbWUgdG8gcmVzdWJtaXQuDQpJcyBpdCByaWdodD8NCg0KPiBJIGhh
dmVuJ3QgdHJlYXRlZCB0aGlzIGFzIGEgZml4IGJlY2F1c2UgaXQgd2FzIG5ldmVyIHRoZXJlLCBi
dXQNCj4gaXQgbWF5IG1ha2Ugc2Vuc2UgdG8gcmVxdWVzdCBhIGJhY2twb3J0IHRvIHN0YWJsZSBh
ZnRlciBpdCBpcyB1cHN0cmVhbS4NCj4NClNvcnJ5LCBJIGRpZG6hr3QgcXVpdGUgdW5kZXJzdGFu
ZCB3aGF0IHlvdSBtZWFudC4NCldoeSBkaWQgeW91IHNheSAnaXQgd2FzIG5ldmVyIHRoZXJlJz8g
RG8geW91IG1lYW4gdGhhdCB0aGlzIGlzc3VlIGRvZXNuJ3QgZXhpc3Q/DQoNClRoYW5rcywNCg0K
SmFzb24NCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KRnJvbTog
Sm9uYXRoYW4gQ2FtZXJvbiA8amljMjNAa2VybmVsLm9yZz4NClNlbnQ6IFN1bmRheSwgU2VwdGVt
YmVyIDgsIDIwMjQgNjo1MSBQTQ0KVG86IGphc29uIGxpdQ0KQ2M6IEplYW4tQmFwdGlzdGUgTWFu
ZXlyb2w7IGxhcnNAbWV0YWZvby5kZTsgbGludXgtaWlvQHZnZXIua2VybmVsLm9yZzsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZw0KU3ViamVjdDogUmU6ILvYuLQ6IFtQQVRDSF0gaWlvL2lu
dl9pY200MjYwMDogYWRkIGludl9pY200MjYwMCBpZF90YWJsZQ0KDQpPbiBGcmksIDYgU2VwIDIw
MjQgMDU6MDI6NTkgKzAwMDANCmphc29uIGxpdSA8amFzb25saXUxMDA0MTcyOEBnbWFpbC5jb20+
IHdyb3RlOg0KDQo+IEhlbGxvLA0KPg0KPiBJJ20gZ2xhZCB0aGlzIHBhdGNoIGNvdWxkIGhlbHAu
IEFuZCBJIHdvdWxkIGxpa2UgdG8ga25vdywgaG93IHdpbGwgdGhlIHBhdGNoIHRvIGJlIGhhbmRs
ZWQgbW92aW5nIGZvcndhcmQ/DQo+DQpJdCBpcyBxdWV1ZWQgdXAgb24gdGhlIElJTyB0cmVlLiAg
R2l2ZW4gdGltaW5nIGl0J3MgcXVldWVkIGZvciA2LjEzLg0KTm90ZSB0aGF0IGZvciBub3cgdGhh
dCBpcyBvbmx5IHB1c2hlZCBvdXQgYXMgdGVzdGluZyBiZWNhdXNlIEkgd2lsbA0KYmUgcmViYXNp
bmcgdGhlIElJTyB0b2dyZWcgYnJhbmNoIG9uIDYuMTItcmMxLg0KT25lIHRoYXQgaXMgZG9uZSBp
dCB3aWxsIGFwcGVhciBpbiBsaW51eC1uZXh0Lg0KDQpJdCBzaG91bGQgZ28gdXBzdHJlYW0gYW5k
IGFwcGVhciBpbiBjaGFyLW1pc2MvY2hhci1taXNjLW5leHQNCmluIGFib3V0IDYgd2Vla3MuICBB
ZnRlciB0aGF0IEdyZWcgS0ggd2lsbCBzZW5kIGEgcHVsbCByZXF1ZXN0IGR1cmluZw0KdGhlIDYu
MTMgbWVyZ2Ugd2luZG93IGluIGFib3V0IDEyIHdlZWtzIHRpbWUgYW5kIGl0IHdpbGwgdGhlbiBo
b3BlZnVsbHkNCmdldCBtZXJnZWQgaW50byBMaW51cycgdHJlZSBiZWZvcmUgNi4xMy1yYzENCg0K
SSBoYXZlbid0IHRyZWF0ZWQgdGhpcyBhcyBhIGZpeCBiZWNhdXNlIGl0IHdhcyBuZXZlciB0aGVy
ZSwgYnV0DQppdCBtYXkgbWFrZSBzZW5zZSB0byByZXF1ZXN0IGEgYmFja3BvcnQgdG8gc3RhYmxl
IGFmdGVyIGl0IGlzIHVwc3RyZWFtLg0KDQpUaGFua3MsDQoNCkpvbmF0aGFuDQoNCj4gVGhhbmtz
Lg0KPg0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBGcm9tOiBKZWFuLUJh
cHRpc3RlIE1hbmV5cm9sIDxKZWFuLUJhcHRpc3RlLk1hbmV5cm9sQHRkay5jb20+DQo+IFNlbnQ6
IFRodXJzZGF5LCBTZXB0ZW1iZXIgNSwgMjAyNCA1OjI1IFBNDQo+IFRvOiBqYXNvbiBsaXUgPGph
c29ubGl1MTAwNDE3MjhAZ21haWwuY29tPg0KPiBDYzogamljMjNAa2VybmVsLm9yZyA8amljMjNA
a2VybmVsLm9yZz47IGxhcnNAbWV0YWZvby5kZSA8bGFyc0BtZXRhZm9vLmRlPjsgbGludXgtaWlv
QHZnZXIua2VybmVsLm9yZyA8bGludXgtaWlvQHZnZXIua2VybmVsLm9yZz47IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+DQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0hdIGlpby9pbnZfaWNtNDI2MDA6IGFkZCBpbnZfaWNtNDI2MDAgaWRfdGFi
bGUNCj4NCj4gSGVsbG8sDQo+DQo+IGxvb2tzIGdvb2QgZm9yIG1lIG5vdywgdGhhbmtzIGZvciB0
aGUgcGF0Y2guDQo+DQo+IEFja2VkLWJ5OiBKZWFuLUJhcHRpc3RlIE1hbmV5cm9sIDxqZWFuLWJh
cHRpc3RlLm1hbmV5cm9sQHRkay5jb20+DQo+DQo+IFRoYW5rcywNCj4gSkINCj4NCj4gX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBGcm9tOiBqYXNvbiBsaXUgPGph
c29ubGl1MTAwNDE3MjhAZ21haWwuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciA0
LCAyMDI0IDExOjAwDQo+IFRvOiBKZWFuLUJhcHRpc3RlIE1hbmV5cm9sIDxKZWFuLUJhcHRpc3Rl
Lk1hbmV5cm9sQHRkay5jb20+DQo+IENjOiBqaWMyM0BrZXJuZWwub3JnIDxqaWMyM0BrZXJuZWwu
b3JnPjsgbGFyc0BtZXRhZm9vLmRlIDxsYXJzQG1ldGFmb28uZGU+OyBsaW51eC1paW9Admdlci5r
ZXJuZWwub3JnIDxsaW51eC1paW9Admdlci5rZXJuZWwub3JnPjsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZyA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSF0gaWlvL2ludl9pY200MjYwMDogYWRkIGludl9pY200MjYwMCBpZF90YWJsZQ0KPg0K
PiBUaGlzIE1lc3NhZ2UgSXMgRnJvbSBhbiBVbnRydXN0ZWQgU2VuZGVyDQo+IFlvdSBoYXZlIG5v
dCBwcmV2aW91c2x5IGNvcnJlc3BvbmRlZCB3aXRoIHRoaXMgc2VuZGVyLg0KPg0KPiBIZWxsbywg
ZG9lcyBwYXRjaCB2MyBtZWV0IHRoZSByZXF1aXJlbWVudHM/DQo+DQo+IEJSLg0KPg0KPiBKYXNv
biBMaXUgPGphc29ubGl1MTAwNDE3MjhAZ21haWwuY29tPiDT2jIwMjTE6jnUwjLI1dbc0rsgMTk6
MzHQtLXAo7oNCj4gQWRkIHRoZSBpZF90YWJsZSBvZiBpbnZfaWNtNDI2MDAsIHNvIHRoZSBkZXZp
Y2UgY2FuIHByb2JlIGNvcnJlY3RseS4NCj4NCj4gU2lnbmVkLW9mZi1ieTogSmFzb24gTGl1IDxq
YXNvbmxpdTEwMDQxNzI4QGdtYWlsLmNvbT4NCj4gLS0tDQo+IFYxLT5WMjogZml4IHVwIHRoZSBm
b3JtYXR0aW5nIGFzIHJlcXVlc3RlZA0KPiAtLS0NCj4gVjItPlYzOiBhZGQgaWNtNDI2ODYgKElO
Vl9JQ01fNDI2ODYpIGFuZCBpY200MjY4OCAoSU5WX0lDTV80MjY4OCkNCj4gLS0tDQo+ICBkcml2
ZXJzL2lpby9pbXUvaW52X2ljbTQyNjAwL2ludl9pY200MjYwMF9pMmMuYyB8IDE3ICsrKysrKysr
KysrKysrKysrDQo+ICBkcml2ZXJzL2lpby9pbXUvaW52X2ljbTQyNjAwL2ludl9pY200MjYwMF9z
cGkuYyB8IDE3ICsrKysrKysrKysrKysrKysrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDM0IGluc2Vy
dGlvbnMoKykNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2ltdS9pbnZfaWNtNDI2MDAv
aW52X2ljbTQyNjAwX2kyYy5jIGIvZHJpdmVycy9paW8vaW11L2ludl9pY200MjYwMC9pbnZfaWNt
NDI2MDBfaTJjLmMNCj4gaW5kZXggZWJiMzFiMzg1ODgxLi45ZTY1ZmVmMDRjMzkgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvaWlvL2ltdS9pbnZfaWNtNDI2MDAvaW52X2ljbTQyNjAwX2kyYy5jDQo+
ICsrKyBiL2RyaXZlcnMvaWlvL2ltdS9pbnZfaWNtNDI2MDAvaW52X2ljbTQyNjAwX2kyYy5jDQo+
IEBAIC03MSw2ICs3MSwyMiBAQCBzdGF0aWMgaW50IGludl9pY200MjYwMF9wcm9iZShzdHJ1Y3Qg
aTJjX2NsaWVudCAqY2xpZW50KQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBpbnZfaWNtNDI2MDBfaTJjX2J1c19zZXR1cCk7DQo+ICB9DQo+DQo+ICsvKg0KPiArICog
ZGV2aWNlIGlkIHRhYmxlIGlzIHVzZWQgdG8gaWRlbnRpZnkgd2hhdCBkZXZpY2UgY2FuIGJlDQo+
ICsgKiBzdXBwb3J0ZWQgYnkgdGhpcyBkcml2ZXINCj4gKyAqLw0KPiArc3RhdGljIGNvbnN0IHN0
cnVjdCBpMmNfZGV2aWNlX2lkIGludl9pY200MjYwMF9pZFtdID0gew0KPiArICAgICAgIHsgImlj
bTQyNjAwIiwgSU5WX0NISVBfSUNNNDI2MDAgfSwNCj4gKyAgICAgICB7ICJpY200MjYwMiIsIElO
Vl9DSElQX0lDTTQyNjAyIH0sDQo+ICsgICAgICAgeyAiaWNtNDI2MDUiLCBJTlZfQ0hJUF9JQ000
MjYwNSB9LA0KPiArICAgICAgIHsgImljbTQyNjg2IiwgSU5WX0NISVBfSUNNNDI2ODYgfSwNCj4g
KyAgICAgICB7ICJpY200MjYyMiIsIElOVl9DSElQX0lDTTQyNjIyIH0sDQo+ICsgICAgICAgeyAi
aWNtNDI2ODgiLCBJTlZfQ0hJUF9JQ000MjY4OCB9LA0KPiArICAgICAgIHsgImljbTQyNjMxIiwg
SU5WX0NISVBfSUNNNDI2MzEgfSwNCj4gKyAgICAgICB7fQ0KPiArfTsNCj4gK01PRFVMRV9ERVZJ
Q0VfVEFCTEUoaTJjLCBpbnZfaWNtNDI2MDBfaWQpOw0KPiArDQo+ICBzdGF0aWMgY29uc3Qgc3Ry
dWN0IG9mX2RldmljZV9pZCBpbnZfaWNtNDI2MDBfb2ZfbWF0Y2hlc1tdID0gew0KPiAgICAgICAg
IHsNCj4gICAgICAgICAgICAgICAgIC5jb21wYXRpYmxlID0gImludmVuc2Vuc2UsaWNtNDI2MDAi
LA0KPiBAQCAtMTA0LDYgKzEyMCw3IEBAIHN0YXRpYyBzdHJ1Y3QgaTJjX2RyaXZlciBpbnZfaWNt
NDI2MDBfZHJpdmVyID0gew0KPiAgICAgICAgICAgICAgICAgLm9mX21hdGNoX3RhYmxlID0gaW52
X2ljbTQyNjAwX29mX21hdGNoZXMsDQo+ICAgICAgICAgICAgICAgICAucG0gPSBwbV9wdHIoJmlu
dl9pY200MjYwMF9wbV9vcHMpLA0KPiAgICAgICAgIH0sDQo+ICsgICAgICAgLmlkX3RhYmxlID0g
aW52X2ljbTQyNjAwX2lkLA0KPiAgICAgICAgIC5wcm9iZSA9IGludl9pY200MjYwMF9wcm9iZSwN
Cj4gIH07DQo+ICBtb2R1bGVfaTJjX2RyaXZlcihpbnZfaWNtNDI2MDBfZHJpdmVyKTsNCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2ltdS9pbnZfaWNtNDI2MDAvaW52X2ljbTQyNjAwX3NwaS5j
IGIvZHJpdmVycy9paW8vaW11L2ludl9pY200MjYwMC9pbnZfaWNtNDI2MDBfc3BpLmMNCj4gaW5k
ZXggZWFlNWZmN2EzY2MxLi43NTQ0MWIyYmUxNzQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaWlv
L2ltdS9pbnZfaWNtNDI2MDAvaW52X2ljbTQyNjAwX3NwaS5jDQo+ICsrKyBiL2RyaXZlcnMvaWlv
L2ltdS9pbnZfaWNtNDI2MDAvaW52X2ljbTQyNjAwX3NwaS5jDQo+IEBAIC02Nyw2ICs2NywyMiBA
QCBzdGF0aWMgaW50IGludl9pY200MjYwMF9wcm9iZShzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpKQ0K
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnZfaWNtNDI2MDBfc3Bp
X2J1c19zZXR1cCk7DQo+ICB9DQo+DQo+ICsvKg0KPiArICogZGV2aWNlIGlkIHRhYmxlIGlzIHVz
ZWQgdG8gaWRlbnRpZnkgd2hhdCBkZXZpY2UgY2FuIGJlDQo+ICsgKiBzdXBwb3J0ZWQgYnkgdGhp
cyBkcml2ZXINCj4gKyAqLw0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBzcGlfZGV2aWNlX2lkIGlu
dl9pY200MjYwMF9pZFtdID0gew0KPiArICAgICAgIHsgImljbTQyNjAwIiwgSU5WX0NISVBfSUNN
NDI2MDAgfSwNCj4gKyAgICAgICB7ICJpY200MjYwMiIsIElOVl9DSElQX0lDTTQyNjAyIH0sDQo+
ICsgICAgICAgeyAiaWNtNDI2MDUiLCBJTlZfQ0hJUF9JQ000MjYwNSB9LA0KPiArICAgICAgIHsg
ImljbTQyNjg2IiwgSU5WX0NISVBfSUNNNDI2ODYgfSwNCj4gKyAgICAgICB7ICJpY200MjYyMiIs
IElOVl9DSElQX0lDTTQyNjIyIH0sDQo+ICsgICAgICAgeyAiaWNtNDI2ODgiLCBJTlZfQ0hJUF9J
Q000MjY4OCB9LA0KPiArICAgICAgIHsgImljbTQyNjMxIiwgSU5WX0NISVBfSUNNNDI2MzEgfSwN
Cj4gKyAgICAgICB7fQ0KPiArfTsNCj4gK01PRFVMRV9ERVZJQ0VfVEFCTEUoc3BpLCBpbnZfaWNt
NDI2MDBfaWQpOw0KPiArDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBpbnZf
aWNtNDI2MDBfb2ZfbWF0Y2hlc1tdID0gew0KPiAgICAgICAgIHsNCj4gICAgICAgICAgICAgICAg
IC5jb21wYXRpYmxlID0gImludmVuc2Vuc2UsaWNtNDI2MDAiLA0KPiBAQCAtMTAwLDYgKzExNiw3
IEBAIHN0YXRpYyBzdHJ1Y3Qgc3BpX2RyaXZlciBpbnZfaWNtNDI2MDBfZHJpdmVyID0gew0KPiAg
ICAgICAgICAgICAgICAgLm9mX21hdGNoX3RhYmxlID0gaW52X2ljbTQyNjAwX29mX21hdGNoZXMs
DQo+ICAgICAgICAgICAgICAgICAucG0gPSBwbV9wdHIoJmludl9pY200MjYwMF9wbV9vcHMpLA0K
PiAgICAgICAgIH0sDQo+ICsgICAgICAgLmlkX3RhYmxlID0gaW52X2ljbTQyNjAwX2lkLA0KPiAg
ICAgICAgIC5wcm9iZSA9IGludl9pY200MjYwMF9wcm9iZSwNCj4gIH07DQo+ICBtb2R1bGVfc3Bp
X2RyaXZlcihpbnZfaWNtNDI2MDBfZHJpdmVyKTsNCj4gLS0NCj4gMi4yNS4xDQoNCg==

