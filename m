Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 864561B0150
	for <lists+linux-iio@lfdr.de>; Mon, 20 Apr 2020 08:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgDTGGS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Apr 2020 02:06:18 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:64496 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725825AbgDTGGR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Apr 2020 02:06:17 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03K62WvT031098;
        Mon, 20 Apr 2020 02:06:16 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com with ESMTP id 30fxf5vn7d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Apr 2020 02:06:16 -0400
Received: from m0167089.ppops.net (m0167089.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03K66GgW002349;
        Mon, 20 Apr 2020 02:06:16 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by mx0a-00128a01.pphosted.com with ESMTP id 30fxf5vn7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Apr 2020 02:06:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EisZqp0lWPmoHcYXECJU3i/cF7LaYJK36dfTZRIQGYkYvc22s9mac2tHPl4JGxJUh3KE8cwzT5VR0fuQkelYGWrS2nyBiy2XIkTUmxsocXNkJheLycTbJtgpMnCk6N1mQiwyus/Z3j+ycPO6bviyq3dIfsR6rQdgilWuHc5/7IwHmoy2jI1/P8HRzrUL900avr1v6MrVVCM4FZPFX83hn1IgCkVyKV4E+g+WaPZtuR4csM8+xAph65I5E/GzFlKc2Argh1tLTx/TjbbteqbQeJsQaCIMB8GS2bxKrcmBw1h0q3VGIrJTGlPh1UDbOysCFcEmcRGJq9aBtLpqXmCXAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7RJF5SLywTLLrAk5S8WBgOs1puF1JAc/rvIMlDAxx4=;
 b=iG8hhkymylqP6hBKvnJS60xTO93zI3KLuVc4DeNKNyFuOo3iK80JEEgK4ny6aFnzjK1UOH2cnSn8uTok8+h5VtNrZi0q3X0H7cre5ym24ynrovdDFdvEcXhXEQNKyfTs5FIVMJVjUF0mxKTsxYcTXfrVrB2I/P9S5x1IDWpYdzPDt+QRYVfWXNuqoBIum36FCHgtcIlZvND7NtSg+pXeIUfSu1pY7+6NZFMcrM6vfcPeB1SFIOq27L/zz9ADfEelIDobxWx5bD9jmEo0RwOBQS5fIWPFaFY4EY68VmDAfD7BZSaWxCVISyg2RAKZRFg3uDUCe9W9NCH8PncE2MTwdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7RJF5SLywTLLrAk5S8WBgOs1puF1JAc/rvIMlDAxx4=;
 b=uYSfV1e4T6LAdo2qv3ja4DFAK75J3N1JMxjsJCSOg0jpIB6d5s4nYlQ/grImohbTDeJT/U0zZfAOInRqCMSzYRNWTIogpTX2D1ekOIWfSfPf1EAVZKOqsPV0I1Z2Kfu9apiCwD2u3ENk1pEUHJQr1WTn09kWjqIuMDcSscrilq8=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4153.namprd03.prod.outlook.com (2603:10b6:5:5c::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Mon, 20 Apr
 2020 06:06:15 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2921.030; Mon, 20 Apr 2020
 06:06:15 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 5/7] iio: light: opt3001: Add mod_devicetable.h and drop
 use of of_match_ptr
Thread-Topic: [PATCH 5/7] iio: light: opt3001: Add mod_devicetable.h and drop
 use of of_match_ptr
Thread-Index: AQHWFlvVF6vdKdCKKk+XaUt7WnG5O6iBh/+A
Date:   Mon, 20 Apr 2020 06:06:15 +0000
Message-ID: <7d4a3ae71aec2c16dafce6dd45bdb857adb2e635.camel@analog.com>
References: <20200419150206.43033-1-jic23@kernel.org>
         <20200419150206.43033-6-jic23@kernel.org>
In-Reply-To: <20200419150206.43033-6-jic23@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.27.130.47]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 77f66cc3-092a-4b89-ee54-08d7e4f0ef18
x-ms-traffictypediagnostic: DM6PR03MB4153:
x-microsoft-antispam-prvs: <DM6PR03MB4153B07C4619AE8FBB94D401F9D40@DM6PR03MB4153.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1107;
x-forefront-prvs: 03793408BA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(136003)(346002)(396003)(376002)(39850400004)(366004)(4744005)(86362001)(36756003)(6512007)(186003)(26005)(71200400001)(6506007)(478600001)(110136005)(2616005)(4326008)(2906002)(66946007)(76116006)(91956017)(8676002)(5660300002)(8936002)(316002)(66446008)(6486002)(64756008)(66556008)(66476007)(81156014);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9fmwoA1Kb9jn0EQw6KnIzmjGKCtuSBEJxWxSAtqmUGx/3DBwQdvrdp/otjzgGvETSopK2yIvCCcueNi/qJDSHjkmGnvdypGBeSNBYKKLFXw2WgAygt9JS9CDpbqzy7SQ+P5zW1soXv5L8nYa/HBEhI54xXZcS4lbcZRzMIeHWGnvRGqa5jNe1Bhd0oVj3WrKUw/qqBXlwGCb7tWAzRk4Hz7XjQin4j0lvWLdTCFbG1QQutuwEyzFgHu+G3AniyWr29QFXKjEi613mr+wKdLinF8iXY2kbaO1cpPRX4sG+wlneErCgEL7jmtN5xxVMfkiwBcFX5VQDxIjUovGvhP2WevBwySAuGlYsN6QknhFJmbr0iaUHOPRVpCV3o3RurmjElrXSztcVukcsteB8Tf7P9+D9qRb76WokVmFnY8VceDD6NGkzfmORO17ZpksNCXd
x-ms-exchange-antispam-messagedata: 72orE7pZmi1t9XEWMY7STCdHJlHJ+F6pIktpBIa3Z9nbdViOPyjTh/HwSi/MHzOuZVzqvG5wiuY3P8+SblO8vLMLV/2iTA7WvwutS5KLTJAS4R1lm4dmPiObBUObPaE5Q1B3xLWQ0yvNOcwzU9A5rQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B1147D0E8936F4D858D0B7025826D17@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f66cc3-092a-4b89-ee54-08d7e4f0ef18
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2020 06:06:15.0357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EYhAzTBKEHkRtsDF6XWxn60D6drelRYyQ8NTtijV7tsrIa4fzTk606J2mMAreJHKtiaiDpI67AMiEXf5+lvcOeP+apeu7hPR0A8TzYiS3CY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4153
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-20_01:2020-04-17,2020-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004200053
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDIwLTA0LTE5IGF0IDE2OjAyICswMTAwLCBqaWMyM0BrZXJuZWwub3JnIHdyb3Rl
Og0KPiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+
DQo+IA0KPiBFbmFibGVzIHByb2JpbmcgdmlhIEFDUEkgUFJQMDAwMSBidXQgbW9zdGx5IGFib3V0
IHJlbW92aW5nIGV4YW1wbGVzDQo+IHRoYXQgbWlnaHQgYmUgY29waWVkIHRvIG5ldyBkcml2ZXJz
Lg0KPiANCg0KUmV2aWV3ZWQtYnk6IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVs
ZWFuQGFuYWxvZy5jb20+DQoNCj4gU2lnbmVkLW9mZi1ieTogSm9uYXRoYW4gQ2FtZXJvbiA8Sm9u
YXRoYW4uQ2FtZXJvbkBodWF3ZWkuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvaWlvL2xpZ2h0L29w
dDMwMDEuYyB8IDMgKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vbGlnaHQvb3B0MzAwMS5j
IGIvZHJpdmVycy9paW8vbGlnaHQvb3B0MzAwMS5jDQo+IGluZGV4IDkyMDA0YTI1NjNlYS4uODJh
YmZhNTdiNTljIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lpby9saWdodC9vcHQzMDAxLmMNCj4g
KysrIGIvZHJpdmVycy9paW8vbGlnaHQvb3B0MzAwMS5jDQo+IEBAIC0xNiw2ICsxNiw3IEBADQo+
ICAjaW5jbHVkZSA8bGludXgvaXJxLmg+DQo+ICAjaW5jbHVkZSA8bGludXgva2VybmVsLmg+DQo+
ICAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvbW9kX2Rldmlj
ZXRhYmxlLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvbXV0ZXguaD4NCj4gICNpbmNsdWRlIDxsaW51
eC9zbGFiLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvdHlwZXMuaD4NCj4gQEAgLTg0NCw3ICs4NDUs
NyBAQCBzdGF0aWMgc3RydWN0IGkyY19kcml2ZXIgb3B0MzAwMV9kcml2ZXIgPSB7DQo+ICANCj4g
IAkuZHJpdmVyID0gew0KPiAgCQkubmFtZSA9ICJvcHQzMDAxIiwNCj4gLQkJLm9mX21hdGNoX3Rh
YmxlID0gb2ZfbWF0Y2hfcHRyKG9wdDMwMDFfb2ZfbWF0Y2gpLA0KPiArCQkub2ZfbWF0Y2hfdGFi
bGUgPSBvcHQzMDAxX29mX21hdGNoLA0KPiAgCX0sDQo+ICB9Ow0KPiAgDQo=
