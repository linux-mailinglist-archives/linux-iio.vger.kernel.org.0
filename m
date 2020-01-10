Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 984F6136A77
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2020 11:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbgAJKGQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Jan 2020 05:06:16 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:17702 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727168AbgAJKGQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Jan 2020 05:06:16 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00AA4MaJ018437;
        Fri, 10 Jan 2020 11:05:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=Orqb4Kzs44B6SU4aLxj7f+Qu6NMAODCMej4io7GGS5M=;
 b=a7Pfwu94Dfr68ihKVpEQrnWKRtNIAvpCngKjgBGsIOqfhCV8u4TrvXXghrIa0GCrde8I
 fOT8I5ktcFhccr3JMzL9SdKR/f4XLkX/mY87BtGSgCANhN+mnPlhfK9kwaUEiNMRm0lg
 twI2wXR8z5W6brbdDoXVwLh5mmeq0V8XiZ4f5zHNnpeovIAmBTdwaXA1bnRETvO1kOE9
 kfq7Cc/xaFVpDr/E4pmZBgiC9WfHS/8U0QfUMKVbtmzHBJPdXpXhEpae10DayKWQFQeB
 V31tDJ8CqKQrPZMatfh08ZsIpxJQtPUjNTa/1kbP/yguAo/gy6PLEorIyiqpAI3NGDaw DA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xakkb72ge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jan 2020 11:05:53 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4EA5B10003A;
        Fri, 10 Jan 2020 11:05:48 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag5node2.st.com [10.75.127.14])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 39C942A6196;
        Fri, 10 Jan 2020 11:05:48 +0100 (CET)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG5NODE2.st.com
 (10.75.127.14) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 10 Jan
 2020 11:05:47 +0100
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Fri, 10 Jan 2020 11:05:47 +0100
From:   Olivier MOYSAN <olivier.moysan@st.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Fabrice GASNIER <fabrice.gasnier@st.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>
Subject: Re: [PATCH v2] iio: adc: stm32-dfsdm: fix single conversion
Thread-Topic: [PATCH v2] iio: adc: stm32-dfsdm: fix single conversion
Thread-Index: AQHVpSPpcOskt6+D7kOuxZv5WfyEPKfj4AOA
Date:   Fri, 10 Jan 2020 10:05:47 +0000
Message-ID: <1a4261a5-1835-a248-9094-c4e7236e7254@st.com>
References: <20191127130729.18511-1-olivier.moysan@st.com>
In-Reply-To: <20191127130729.18511-1-olivier.moysan@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="utf-8"
Content-ID: <216D40C44CFE484AB49CAC1B044E7CC9@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-10_01:2020-01-10,2020-01-09 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgSm9uYXRoYW4sIGFsbCwNCg0KS2luZCByZW1pbmRlciBvbiB0aGlzIHBhdGNoLg0KUmVnYXJk
cw0KT2xpdmllcg0KDQpPbiAxMS8yNy8xOSAyOjA3IFBNLCBPbGl2aWVyIE1veXNhbiB3cm90ZToN
Cj4gQXBwbHkgZGF0YSBmb3JtYXR0aW5nIHRvIHNpbmdsZSBjb252ZXJzaW9uLA0KPiBhcyB0aGlz
IGlzIGFscmVhZHkgZG9uZSBpbiBjb250aW51b3VzIGFuZCB0cmlnZ2VyIG1vZGVzLg0KPg0KPiBG
aXhlczogMTAyYWZkZTYyOTM3ICgiaWlvOiBhZGM6IHN0bTMyLWRmc2RtOiBtYW5hZ2UgZGF0YSBy
ZXNvbHV0aW9uIGluIHRyaWdnZXIgbW9kZSIpDQo+DQo+IFNpZ25lZC1vZmYtYnk6IE9saXZpZXIg
TW95c2FuIDxvbGl2aWVyLm1veXNhbkBzdC5jb20+DQo+IC0tLQ0KPiBjaGFuZ2VzIGluIHZlcnNp
b24gMjoNCj4gLSBjb3JyZWN0IHRpdGxlDQo+IC0tLQ0KPiAgIGRyaXZlcnMvaWlvL2FkYy9zdG0z
Mi1kZnNkbS1hZGMuYyB8IDIgKysNCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
DQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9hZGMvc3RtMzItZGZzZG0tYWRjLmMgYi9k
cml2ZXJzL2lpby9hZGMvc3RtMzItZGZzZG0tYWRjLmMNCj4gaW5kZXggZTQ5MzI0MmMyNjZlLi4w
MzM5ZWNkZDA2YmQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaWlvL2FkYy9zdG0zMi1kZnNkbS1h
ZGMuYw0KPiArKysgYi9kcml2ZXJzL2lpby9hZGMvc3RtMzItZGZzZG0tYWRjLmMNCj4gQEAgLTEy
MDQsNiArMTIwNCw4IEBAIHN0YXRpYyBpbnQgc3RtMzJfZGZzZG1fc2luZ2xlX2NvbnYoc3RydWN0
IGlpb19kZXYgKmluZGlvX2RldiwNCj4gICANCj4gICAJc3RtMzJfZGZzZG1fc3RvcF9jb252KGFk
Yyk7DQo+ICAgDQo+ICsJc3RtMzJfZGZzZG1fcHJvY2Vzc19kYXRhKGFkYywgcmVzKTsNCj4gKw0K
PiAgIHN0b3BfZGZzZG06DQo+ICAgCXN0bTMyX2Rmc2RtX3N0b3BfZGZzZG0oYWRjLT5kZnNkbSk7
DQo+ICAgDQo=
