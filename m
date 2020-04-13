Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A823B1A6231
	for <lists+linux-iio@lfdr.de>; Mon, 13 Apr 2020 06:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbgDMEcj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Apr 2020 00:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgDMEci (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Apr 2020 00:32:38 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D4DC0A3BE0
        for <linux-iio@vger.kernel.org>; Sun, 12 Apr 2020 21:32:39 -0700 (PDT)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03D4TTTo018356;
        Mon, 13 Apr 2020 00:32:37 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-00128a01.pphosted.com with ESMTP id 30b7namy6p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Apr 2020 00:32:37 -0400
Received: from m0167091.ppops.net (m0167091.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03D4Twnp018426;
        Mon, 13 Apr 2020 00:32:36 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by mx0b-00128a01.pphosted.com with ESMTP id 30b7namy6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Apr 2020 00:32:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHY5lQA2+uJo1w/9vQunuwo85PckhpwM8K9vj+D5apRVoSwdnD/Mxeig8/OGePoTSXoNSC9M560xj3KGXcWlSMMm2Oe6lX+j0uK7YyZsnzL6h9RsI0ygJdnjkB51//P9XJwMQPrE765BsHVQevMo3RjAkluiORStZE3s8m3cgnjsPDADHj9xlYSfQ0aOOkBoBLGniZWVMRadm3QCJ9K9FpKlNRyaGBTsQO4ucWHwBRMpIyNUzKTitR485SC8ymCiCtyDj8hq9twgehNAU6Ts5GgUjoH3clq654MIMpQvXmV9Hh6rGsZXMEiHOmdoMMkpVgYQ0YG64UicxY4cI7myfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNUKjbdfF9fygkAg34+ysr4Nehd8xEOl0i1Tvz5ib1k=;
 b=iL49HmtLZPL4ytMrFwfI0WGU48IsEXwz/pxbIJ6EH6XNgHCDzheO3Le7zjLN3krnHy61ERKdS9EISzn3UgJKBJ1EW0hf5XVLjFpmC9yx3fOV/Ay2tTD3uxQarWsogJZttX3JqNUWe1e/8rC9KIxaY/XuREaCUy2D3e6PCQZLLPFieRNCHOpGKBPmgu1WhOrS7ZENBwpJmmv5JZuysbokgC3iI/5PNFmZWXxhdQ0PpxvxUZyq0TqDumXp3URMFpzRvqC1n6nEvt+VLP3VNEy250uhxAaVnrx0oAQ06Q2hhpwXKvQD/ltbqU19Yp4uKtoGBv/b9dW2hH31ingxD9zPeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNUKjbdfF9fygkAg34+ysr4Nehd8xEOl0i1Tvz5ib1k=;
 b=dnoZ6xFBU/wz0OR6lA9DXgMQGDqUURYxZV4H16FptP7J0u2V3T51C+UCa3NNIzZ7fYSt7PuoB+P4Vx8UIJ9aLdYjgDQh7IodDQYqDFTSj/P93sPt+a9VgYLqMvLa9wt4JOLxp+Qr1Og7XA21H938Om+Eoktm8OF1XRkeq9YNGL8=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB3787.namprd03.prod.outlook.com (2603:10b6:5:44::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17; Mon, 13 Apr
 2020 04:32:35 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2900.026; Mon, 13 Apr 2020
 04:32:35 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "daniel.baluta@gmail.com" <daniel.baluta@gmail.com>
Subject: Re: [PATCH 5/6] iio:magn:mmc35240: Drop unnecessary casts of val
 parameter in regmap_bulk*
Thread-Topic: [PATCH 5/6] iio:magn:mmc35240: Drop unnecessary casts of val
 parameter in regmap_bulk*
Thread-Index: AQHWC3ThLKuSkemPyU2QFqcogPbFpqh2g0aA
Date:   Mon, 13 Apr 2020 04:32:35 +0000
Message-ID: <056ba15c5b62fdbccaeaccf5496b68994a7357fa.camel@analog.com>
References: <20200405180321.1737310-1-jic23@kernel.org>
         <20200405180321.1737310-6-jic23@kernel.org>
In-Reply-To: <20200405180321.1737310-6-jic23@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.27.135.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b5dbf695-6fe2-4239-f977-08d7df63b07b
x-ms-traffictypediagnostic: DM6PR03MB3787:
x-microsoft-antispam-prvs: <DM6PR03MB37873359E949339B306A9AD6F9DD0@DM6PR03MB3787.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-forefront-prvs: 037291602B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(366004)(136003)(376002)(396003)(346002)(39850400004)(478600001)(110136005)(5660300002)(6512007)(36756003)(54906003)(2906002)(186003)(76116006)(26005)(316002)(91956017)(66946007)(66476007)(64756008)(66556008)(66446008)(4326008)(81156014)(2616005)(86362001)(8936002)(6486002)(71200400001)(6506007)(8676002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5wdVH2nKI/3CN7lQVraDzdjbTYoh+AWPkFOlubc8H+ytXeE4sEfMXq1WGjW65U2TJIz88c55KGdGOtou1xWZDjOQQX/t97N5dE/OXBStHw3nrO3JCgqCgWm+dUGJMuurtMoVzCaQzWNNarWjxTymnyUqa6Qh08LLpQ6kPqpvhQF6Ca2XgF3KTUYCYZV3518PslnabnO7257c3lqX4/E5T6BUjSpFLUJlk8k3oSgSMAwvMjlmN25270jYL8X5ysMCsvwaGdseTQTE2kD+c4G3P8HKI58hfSYs9/5yCYQvdyrbBnNpTZXBmFAHXiyGXm5WBvpkl9YRIToWiT1IYXG046wpcbU3LXirEbSnpOX8wSt5puOfHtgMFlRjOEI3QRi76ysGkF/iE5/pxVxM8BTlUUmrhMI7cQo4V7oGE8FgprBzg7+bFoKXt3gHR6BXrZlw
x-ms-exchange-antispam-messagedata: OkXs2LcgdaDbGiCaE34MHg0B7r5QkFEhThydnQU/yFNlyHtaYpqL++1d8YzGhHQH5t2pwBtXj/LO7AFMscQHKkR/UcvU8YqvXXjWY2NbEOOEeXNne/CWfALf5NymAT1ZAomjQE6BdYy2ZeI9m3J25w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C845EC1D1945554F898B2F0D904B1AB4@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5dbf695-6fe2-4239-f977-08d7df63b07b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2020 04:32:35.0946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wlxpYh+IHT/v+d9oPItLFi2JALs1ul/bOPmmQXHaXk8v6fhDWiRjZ8oBDkH2xhDvc+5WkNMsjLq3KUFEe2Xk+gM6pjZvUHtn99Cljdez6tc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3787
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-13_01:2020-04-12,2020-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 impostorscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004130040
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDIwLTA0LTA1IGF0IDE5OjAzICswMTAwLCBqaWMyM0BrZXJuZWwub3JnIHdyb3Rl
Og0KPiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+
DQo+IA0KPiBHaXZlbiB0aGUgcGFyYW1ldGVyIGlzIHZvaWQgKiwgY2FzdGluZyB0byB1OCAqIGlz
IHVubmVjZXNzYXJ5Lg0KPiANCg0KUmV2aWV3ZWQtYnk6IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxl
eGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+DQoNCj4gU2lnbmVkLW9mZi1ieTogSm9uYXRoYW4g
Q2FtZXJvbiA8Sm9uYXRoYW4uQ2FtZXJvbkBodWF3ZWkuY29tPg0KPiBDYzogRGFuaWVsIEJhbHV0
YSA8ZGFuaWVsLmJhbHV0YUBnbWFpbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9paW8vbWFnbmV0
b21ldGVyL21tYzM1MjQwLmMgfCA0ICsrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vbWFn
bmV0b21ldGVyL21tYzM1MjQwLmMNCj4gYi9kcml2ZXJzL2lpby9tYWduZXRvbWV0ZXIvbW1jMzUy
NDAuYw0KPiBpbmRleCA0MjVjZGQwN2I0ZTUuLjE3ODdkNjU2ZDAwOSAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9paW8vbWFnbmV0b21ldGVyL21tYzM1MjQwLmMNCj4gKysrIGIvZHJpdmVycy9paW8v
bWFnbmV0b21ldGVyL21tYzM1MjQwLmMNCj4gQEAgLTIzOSw3ICsyMzksNyBAQCBzdGF0aWMgaW50
IG1tYzM1MjQwX2luaXQoc3RydWN0IG1tYzM1MjQwX2RhdGEgKmRhdGEpDQo+ICAJCXJldHVybiBy
ZXQ7DQo+ICANCj4gIAlyZXQgPSByZWdtYXBfYnVsa19yZWFkKGRhdGEtPnJlZ21hcCwgTU1DMzUy
NDBfT1RQX1NUQVJUX0FERFIsDQo+IC0JCQkgICAgICAgKHU4ICopb3RwX2RhdGEsIHNpemVvZihv
dHBfZGF0YSkpOw0KPiArCQkJICAgICAgIG90cF9kYXRhLCBzaXplb2Yob3RwX2RhdGEpKTsNCj4g
IAlpZiAocmV0IDwgMCkNCj4gIAkJcmV0dXJuIHJldDsNCj4gIA0KPiBAQCAtMjk1LDcgKzI5NSw3
IEBAIHN0YXRpYyBpbnQgbW1jMzUyNDBfcmVhZF9tZWFzdXJlbWVudChzdHJ1Y3QgbW1jMzUyNDBf
ZGF0YQ0KPiAqZGF0YSwgX19sZTE2IGJ1ZlszXSkNCj4gIAlpZiAocmV0IDwgMCkNCj4gIAkJcmV0
dXJuIHJldDsNCj4gIA0KPiAtCXJldHVybiByZWdtYXBfYnVsa19yZWFkKGRhdGEtPnJlZ21hcCwg
TU1DMzUyNDBfUkVHX1hPVVRfTCwgKHU4ICopYnVmLA0KPiArCXJldHVybiByZWdtYXBfYnVsa19y
ZWFkKGRhdGEtPnJlZ21hcCwgTU1DMzUyNDBfUkVHX1hPVVRfTCwgYnVmLA0KPiAgCQkJCTMgKiBz
aXplb2YoX19sZTE2KSk7DQo+ICB9DQo+ICANCg==
