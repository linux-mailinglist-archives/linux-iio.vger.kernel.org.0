Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0295EE353
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2019 16:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbfKDPPg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Nov 2019 10:15:36 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:52412 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727796AbfKDPPg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Nov 2019 10:15:36 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA4F9wDx021659;
        Mon, 4 Nov 2019 10:15:32 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-00128a01.pphosted.com with ESMTP id 2w2a75hsy4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Nov 2019 10:15:32 -0500
Received: from m0167090.ppops.net (m0167090.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xA4FFWFN026169;
        Mon, 4 Nov 2019 10:15:32 -0500
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp2058.outbound.protection.outlook.com [104.47.49.58])
        by mx0b-00128a01.pphosted.com with ESMTP id 2w2a75hsy1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Nov 2019 10:15:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+/gKdvVDQB2QDY55yTe2BatFBI0uyMUvyKNEN1LP9VSORStzbceXt/Kbf5d93cuwtegwEzmBtTWtkbxs1agesw1uIkgOEXMY+VC2TF1TH9lwldqoh5nHEcA1AQk1mNY0Vc2hq8lS9vKCcbQ6S8Mc0t7DCQxs2uLFrTstQepz2LeRQVClKndirYkTSUi2mTuiFXGrS7Idl0auUdOmoGGn+1hd7nF2wv10uBZWi736v8jauvAPmvCFpJFLXAXLtr1BBrV2dVDW+/LuYQJcwQFbKpVN5UGukI/z4RBj7mvZq79Gdh8evQ9mLepcKUV9jvpo/0gBOwDDRYB55wTuplrsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjSr9gyLaUqg8q+L2tfrJgB0qZeRLnu07MoGj400SI8=;
 b=K/7R6plUVUJv/5ai8eUUNSwv5PJ/XpKOWpnG+DRAlbCTuFHFS/m/8nx0HL26oZuNN5iy2TF737U0XLAeEVViVAEOu58v41Ab3uRLGBkVD8soreqOOF1IaGI3N8PHpZ9p3sYGnWsGv85sFDwB4rFgZ9j4v42uokvGwGIs9xAS9QDmnhPiKQ0iM0R5BH6wQ+aX+45DsPigq2DGbLC1l4IZ6pOROvX8gWfo6/Je+xL4HNJaQqfgeOhehEYn11GNpQaxhLmENW91Wx0j9xwh/gDX6eZHxiwL9HaDHxIgC90jUsHXzOhvSyiHMzelu857nqL3J3bFaIPgnBrqFxuYeQOUTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjSr9gyLaUqg8q+L2tfrJgB0qZeRLnu07MoGj400SI8=;
 b=2lXwJzIS0JmWyiUgHAsSZur0ZSkStpw35p+OWh7ZjcfUfhZBwxgGcQ86t1Gk2wbURW/3y+V/9jaJOALea8eXUvpDgIva+dTYN1SrTnrFIzkKWBYLWboFV/9k4GyHP0fzWyyTMA5ixdLzgKtyDda528cosYWTYKFiV5UGX3SNYpI=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5368.namprd03.prod.outlook.com (20.180.15.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 15:15:30 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c%3]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 15:15:30 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "raveendra.padasalagi@broadcom.com" 
        <raveendra.padasalagi@broadcom.com>
Subject: Re: [PATCH] iio: adc: bcm_iproc_adc: drop a stray semicolon
Thread-Topic: [PATCH] iio: adc: bcm_iproc_adc: drop a stray semicolon
Thread-Index: AQHVgcCyXNZtEtY8hEKSOCWaPpFppKd7QeGA
Date:   Mon, 4 Nov 2019 15:15:30 +0000
Message-ID: <5f786ddb2265a0a11a046ab2750ca471f0fc893e.camel@analog.com>
References: <20191013121856.1782707-1-jic23@kernel.org>
In-Reply-To: <20191013121856.1782707-1-jic23@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bfd0df1f-5481-416a-9dfd-08d76139d476
x-ms-traffictypediagnostic: CH2PR03MB5368:
x-microsoft-antispam-prvs: <CH2PR03MB5368E049D1BEF70BB65F4060F97F0@CH2PR03MB5368.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:454;
x-forefront-prvs: 0211965D06
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(366004)(39860400002)(396003)(189003)(199004)(7736002)(186003)(6486002)(229853002)(486006)(4326008)(476003)(86362001)(6512007)(478600001)(14454004)(81156014)(81166006)(8936002)(6246003)(66066001)(4001150100001)(6436002)(4744005)(25786009)(5660300002)(8676002)(99286004)(102836004)(6506007)(26005)(305945005)(14444005)(316002)(54906003)(2616005)(2501003)(66556008)(66476007)(76116006)(6116002)(3846002)(64756008)(2906002)(66946007)(66446008)(256004)(71190400001)(71200400001)(446003)(11346002)(76176011)(36756003)(118296001)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5368;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1LmRBXpsNeG0iWBFzbwkeOPqC0UXePCuJCPgLtDW9rIslGcUGTDNH/N19WkEH5TFUMGsAj1vaSVMWPw+1Vyt06PRf4zVkZ97xbnstbvwRnsr4U/+pPjjn7nKlMESbC6qlej4KRXSoDlXcLWnaePW/aKSJV1VB7O1QGY1+7VTNvLO4ZlIjv5TpSUomSJWMVdX4wZtRALGd/+vZRdoe758hZEatvwYFI2nEn7tcM51HRi9YfUd8pq5dwnW1rKUlQEaf4pjZlYvDRlYheu42VcaNnKMBBvN7nZeAb9GO0xi8gCYfCv6pxgsX61xcH4ft6PgnJru50w/13tacuFboAhxyX2WmNQ3bY94/moIllmBaAAYaAg7eiq+jzgZpta2w5b8/kM1glM5ec0QG5PeJyETwZFNtniHJp6f9PNCDfKqOV5uJ3tenGhas+lzS0Cm6G1U
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8EDCB1CF37C63643A99A201AC2DB6BB5@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfd0df1f-5481-416a-9dfd-08d76139d476
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2019 15:15:30.0354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dUBBC4Y1JW/e1jOlLJLYBUj51yakOyF7ey7l1OZLgXxQlSwTaKv7H8X4KeIfvficqX0RIhj8sEg59WvVeNSTEKV+LTphaSTyfRu5zlHJ8pE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5368
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-04_09:2019-11-04,2019-11-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0 suspectscore=0
 clxscore=1011 phishscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1911040151
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDE5LTEwLTEzIGF0IDEzOjE4ICswMTAwLCBqaWMyM0BrZXJuZWwub3JnIHdyb3Rl
Og0KPiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+
DQo+IA0KPiBGb3VuZCBieSBjb2NjaW5lbGxlIC8gY29jY2ljaGVjaw0KPiANCj4gQ0hFQ0sgICBk
cml2ZXJzL2lpby9hZGMvYmNtX2lwcm9jX2FkYy5jDQo+IGRyaXZlcnMvaWlvL2FkYy9iY21faXBy
b2NfYWRjLmM6MzExOjMtNDogVW5uZWVkZWQgc2VtaWNvbG9uDQo+IA0KDQpSZXZpZXdlZC1ieTog
QWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4NCg0KPiBT
aWduZWQtb2ZmLWJ5OiBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5j
b20+DQo+IENjOiBSYXZlZW5kcmEgUGFkYXNhbGFnaSA8cmF2ZWVuZHJhLnBhZGFzYWxhZ2lAYnJv
YWRjb20uY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvaWlvL2FkYy9iY21faXByb2NfYWRjLmMgfCAy
ICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9hZGMvYmNtX2lwcm9jX2FkYy5jDQo+IGIvZHJp
dmVycy9paW8vYWRjL2JjbV9pcHJvY19hZGMuYw0KPiBpbmRleCA2NDZlYmRjMGE4YjQuLjVlMzk2
MTA0YWM4NiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9paW8vYWRjL2JjbV9pcHJvY19hZGMuYw0K
PiArKysgYi9kcml2ZXJzL2lpby9hZGMvYmNtX2lwcm9jX2FkYy5jDQo+IEBAIC0zMDgsNyArMzA4
LDcgQEAgc3RhdGljIGludCBpcHJvY19hZGNfZG9fcmVhZChzdHJ1Y3QgaWlvX2Rldg0KPiAqaW5k
aW9fZGV2LA0KPiAgCQkJCSJJbnRNYXNrIHNldCBmYWlsZWQuIFJlYWQgd2lsbCBsaWtlbHkNCj4g
ZmFpbC4iKTsNCj4gIAkJCXJlYWRfbGVuID0gLUVJTzsNCj4gIAkJCWdvdG8gYWRjX2VycjsNCj4g
LQkJfTsNCj4gKwkJfQ0KPiAgCX0NCj4gIAlyZWdtYXBfcmVhZChhZGNfcHJpdi0+cmVnbWFwLCBJ
UFJPQ19JTlRFUlJVUFRfTUFTSywgJnZhbF9jaGVjayk7DQo+ICANCg==
