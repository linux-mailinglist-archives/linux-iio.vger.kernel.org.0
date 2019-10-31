Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAC08EB311
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2019 15:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbfJaOns (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 31 Oct 2019 10:43:48 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:40078 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727841AbfJaOns (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 31 Oct 2019 10:43:48 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9VEanTI007471;
        Thu, 31 Oct 2019 15:43:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=doa45AyeRCUKIq624C3k7To46WUJfux5rmxiTmrLR/w=;
 b=AXkprqGWy2E1dTo45qw/y3Y1G32n1qA8D+2Ovyem6+O6X/AdwjdaUSC9UzVPkkd7OICY
 DBn+0JhBB715ZeeT0hSfEtgLfoYVAeFglQ35kRS9yFKvsJw3euHYOeAknwHB9iIpQH5A
 y0qxBavE3+DsZ7ab5bok1o/wIGGsZbU2oPSGFKpKT8VaUj9UvnhMU77tmwxG/zRk7fiN
 UypyM3wSDMyk/fFxUBHZMOrL511S9wVECOzKRmGUnK9b2MHmaSi1vXGKN4PLFP/wKQug
 BAw4ZdTjUH+7supdEargDY8fhjaXL1xSAShrpQSTIlzakHr7d63gx5ZBcSvpv/UQTfC9 bA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2vxwf4aand-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Oct 2019 15:43:40 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EE689100034;
        Thu, 31 Oct 2019 15:43:39 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag4node3.st.com [10.75.127.12])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DEC882BE246;
        Thu, 31 Oct 2019 15:43:39 +0100 (CET)
Received: from SFHDAG4NODE3.st.com (10.75.127.12) by SFHDAG4NODE3.st.com
 (10.75.127.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 31 Oct
 2019 15:43:39 +0100
Received: from SFHDAG4NODE3.st.com ([fe80::68a8:f416:8e07:bb37]) by
 SFHDAG4NODE3.st.com ([fe80::68a8:f416:8e07:bb37%20]) with mapi id
 15.00.1473.003; Thu, 31 Oct 2019 15:43:39 +0100
From:   Mario TESI <mario.tesi@st.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>
CC:     "lorenzo.bianconi@redhat.com" <lorenzo.bianconi@redhat.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 0/2] support rational ODRs in st_lsm6dsx
Thread-Topic: [PATCH 0/2] support rational ODRs in st_lsm6dsx
Thread-Index: AQHVjPvCNTj9Qr+0TE2bGoP3OmJjc6d0yG+A
Date:   Thu, 31 Oct 2019 14:43:39 +0000
Message-ID: <6d746aaa-ad45-1a29-6f9d-ddc9ffa8f760@st.com>
References: <cover.1572203759.git.lorenzo@kernel.org>
In-Reply-To: <cover.1572203759.git.lorenzo@kernel.org>
Accept-Language: it-IT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E06D289814DBBD43BBE5F68C1BCF3991@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-31_06:2019-10-30,2019-10-31 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

VGVzdGVkLWJ5OiBNYXJpbyBUZXNpIDxtYXJpby50ZXNpQHN0LmNvbT4NCg0KDQpPbiAxMC8yNy8x
OSA4OjIxIFBNLCBMb3JlbnpvIEJpYW5jb25pIHdyb3RlOg0KPiBFeHByZXNzIE9EUnMgaW4gSFog
LyAxMCBpbiBvcmRlciB0byBzdXBwb3J0IHJhdGlvbmFsIE9EUnMgKGUuZy4gMTIuNUh6KS4NCj4g
VGhpcyBzZXJpZXMgd2lsbCBmaXggYW4gQW5kcm9pZCBDVFMgZmFpbHVyZS4NCj4gRXhwbGljaXRs
eSBkZWZpbmUgb2RyIHRhYmxlIHNpemUuDQo+IFRoaXMgc2VyaWVzIGlzIGJhc2VkIG9uICdpaW86
IGltdTogc3RfbHNtNmRzeDogZml4IE9EUiBjaGVjayBpbg0KPiBzdF9sc202ZHN4X3dyaXRlX3Jh
dycNCj4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMTIxNDI4MS8NCj4NCj4g
TG9yZW56byBCaWFuY29uaSAoMik6DQo+ICAgIGlpbzogaW11OiBzdF9sc202ZHN4OiBleHBsaWNp
dGx5IGRlZmluZSBvZHIgdGFibGUgc2l6ZQ0KPiAgICBpaW86IGltdTogc3RfbHNtNmRzeDogZXhw
cmVzcyBvZHIgaW4gSFogLyAxMA0KPg0KPiAgIGRyaXZlcnMvaWlvL2ltdS9zdF9sc202ZHN4L3N0
X2xzbTZkc3guaCAgICAgIHwgICA0ICstDQo+ICAgZHJpdmVycy9paW8vaW11L3N0X2xzbTZkc3gv
c3RfbHNtNmRzeF9jb3JlLmMgfCAyMDYgKysrKysrKysrKy0tLS0tLS0tLQ0KPiAgIGRyaXZlcnMv
aWlvL2ltdS9zdF9sc202ZHN4L3N0X2xzbTZkc3hfc2h1Yi5jIHwgIDMzICstLQ0KPiAgIDMgZmls
ZXMgY2hhbmdlZCwgMTMzIGluc2VydGlvbnMoKyksIDExMCBkZWxldGlvbnMoLSkNCj4=
