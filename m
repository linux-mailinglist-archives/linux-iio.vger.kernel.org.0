Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D63AE20EC56
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jun 2020 06:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbgF3EEm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 30 Jun 2020 00:04:42 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:61732 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725805AbgF3EEm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 30 Jun 2020 00:04:42 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05U3xxcG025150;
        Tue, 30 Jun 2020 00:04:37 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-00128a01.pphosted.com with ESMTP id 31x85j6ae6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 00:04:37 -0400
Received: from m0167091.ppops.net (m0167091.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05U44afH031548;
        Tue, 30 Jun 2020 00:04:36 -0400
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by mx0b-00128a01.pphosted.com with ESMTP id 31x85j6ae3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 00:04:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRnllSvhi0NFB+Dqw64IMbcC5/T99fkaQVH80p0NwWdkVgvGWVIutzZAszafs0xYOGHL6YlbIeAFWIn7LKOrtu6xcbQ/eNwSO0qKFhgDg6ZVxQdmepAdz4gnauoHhyLOr/e8R8kud0KMf2nW08XAjSGvOTiPW8qNSd/RpSwvGReJEgIc54d+4f/G9KdRt4wATrQkdrCI2ekH3XpTzJ7eV18Ea60jNXiErYmylvbRrav9UxUZexr1CS6WHID6xv17ZIu5YFVlrpQXKmvof6zVj63tWFkAzh0kfiFGHzCAHy4ByOC5mLlFDTz7ZhGUiDGHhqKgWFQEgvddn/yaHg5SmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gTo4yuXzeJ1NxXlV2AplhpTkeKbTx1/hzXC0T11/ws=;
 b=g+HP8fQwx31DgnqksJX1v0JrOgiVxdEHQYG9qiRlcAjLZo1CSOeVXl5SDt670yFGpClUFKf++cUfF0/VhwcPMGUryL8YCN0Zt+xSLhbkdOZSYfgqFc5323yVR7wnXL2WAQpBPwfq5KkVXSsAOqzW4gGW9FszeUixVOvYHtkPJyN4Us+pFx91OPZQUASCY5iYl7OUv4inxAF9tlaEfYuHbIl+hWdZR2C/LlwKNwMJfuG93iIFOlQbi9b3xw9cyeuAfW8eKjtMtQjx1i0u6pKRfqv8iOfrnzFPA2DwGYFwrAITQt4Y4n06Pb490QbSnrMH5/x4CswdkuZZ4CUaC4MWyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gTo4yuXzeJ1NxXlV2AplhpTkeKbTx1/hzXC0T11/ws=;
 b=WMEgHaD5ZRfgSjZBb3brdxBpWXzNLoqT2wtuSB4kA7i69n3WVFcx234eMO1RiqvjHVvb2y7gw4Y42/eyLvUDuyoX49DyJ94K2iGt2f3PJYYeIrn0tA5rEERYbC1Jm3dp/p85i9v5CyYZarR/Pk3Ev2GPtoBtTzBf0Go9JPSmJ1Q=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB3850.namprd03.prod.outlook.com (2603:10b6:5:47::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.24; Tue, 30 Jun
 2020 04:04:34 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf%3]) with mapi id 15.20.3131.028; Tue, 30 Jun 2020
 04:04:34 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "lkp@intel.com" <lkp@intel.com>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [iio:testing 72/75] drivers/iio/industrialio-core.c:168:16:
 error: redefinition of 'iio_get_debugfs_dentry'
Thread-Topic: [iio:testing 72/75] drivers/iio/industrialio-core.c:168:16:
 error: redefinition of 'iio_get_debugfs_dentry'
Thread-Index: AQHWTmjZitX17LwYLkqlaT4dfZysAqjwik2A
Date:   Tue, 30 Jun 2020 04:04:34 +0000
Message-ID: <d28e0c7d603855c46808384d1526f68650f329a3.camel@analog.com>
References: <202006300641.79mJmGqB%lkp@intel.com>
In-Reply-To: <202006300641.79mJmGqB%lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=analog.com;
x-originating-ip: [188.27.128.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 464debd7-3251-4281-7bda-08d81caab314
x-ms-traffictypediagnostic: DM6PR03MB3850:
x-microsoft-antispam-prvs: <DM6PR03MB385058D9BDE5EB2BE4DB11ADF96F0@DM6PR03MB3850.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:514;
x-forefront-prvs: 0450A714CB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w2kRDMfMCvIS9piyjOBPpoy0NJ2tuy66hHoGnNaEckFYNRNFnvPMLAppXsInzXv3JFZKjtFMq7OZTZkFTGPi7wEy3dt/jJzKVX7HVp5uYJomSzxAI3fZ/TdKsiPGo38MAiuSI/DuKQbUiFuv7wWmOub2PbSuV5uYDw3/gFxDbtTETT/Q1OYPdMzLRusSonescSOYtBiYrgkTZvd2cGmzyD2hHloZr3MofEivjbm5zt+FCcOpVyb7EaouNTVDjUOuLc0Uu20fEllcPJzRbibet9Db+z1dQNCpi2xmqA1nCJ+Gf5YWcU8OMWhwBmpdOFRsaOQv6oNh/y+Fw6AYaNXJPjwiIuN+bTsyL7KMuGbSdeOn9DToMpRbVBVUCT2Pi2gyJ0G9JCYllwSY64Aj5OMkmA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(366004)(376002)(346002)(39860400002)(136003)(36756003)(83380400001)(6512007)(6916009)(5660300002)(86362001)(4326008)(8676002)(64756008)(66556008)(66476007)(2906002)(71200400001)(8936002)(66446008)(91956017)(76116006)(66946007)(316002)(54906003)(2616005)(478600001)(186003)(966005)(6486002)(26005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: jkBfie2eUTTbKbqGuN4sbJz5eKIvh3Jf2yawUUWjMti12QWm006xBtPIWLBlMaEVT1HeMJLJGp0Gm9jEyFzyIqNMRSVVzOnzVfJEaGG1VfBkaXrOch+iMxjoj/wSsQSe6bJZoHiHANnNNb9i+d2P1BJOJy9t09AnOsMla2vCvN0+wSqJZ+UWnACbi0OcMTDt10x7cZ7+NCxuYddde7of6DLLgSLc84JR+MrSlaGljGkR3u/12bcTt5a84+P7lwzmfcnnI4lrVyjfOclM4jQVaov/XznVPgViWEpgevUa1V86jDkZ6cB/8hAVxFQxhmWzuc01brTWY38oaB1efSl5RDurBxbEW+v9LrGnfOXMPdWD3kp27aa12h5nbpc/jUfVmmJr4hOCxRfWJqrvMS8dP+a4/YmZdyAZOGacnlNhrWCMdbRarPmTRRDpByr/F9CP39rk9APA6BhG5RN02NTow8FPiyEyhpKGAs8lizPgEJk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9D0DAB554A71CE499D81B710D21C2581@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4411.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 464debd7-3251-4281-7bda-08d81caab314
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2020 04:04:34.5928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 21AK4keHfbd6ci1XVfnCzcsaprubsMv9s8WA6pr0Cg6qkeej63fGSrwGV2yppdFz+8qH2tJQe8marZlMIYT+1BSHT0zwZIBlVwDgNCgZgc4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3850
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-06-29_21:2020-06-29,2020-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 cotscore=-2147483648 phishscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 clxscore=1011 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006300028
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDIwLTA2LTMwIGF0IDA2OjU3ICswODAwLCBrZXJuZWwgdGVzdCByb2JvdCB3cm90
ZToNCj4gW0V4dGVybmFsXQ0KPiANCj4gdHJlZTogICANCj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNv
bS92My9fX2h0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2pp
YzIzL2lpby5naXRfXzshIUEzTmk4Q1MweTJZIXNZa2JLbEZYVHY3VG9GUGM2SjRYYlVxQTdpcGdB
aV9OdDFFVUZRd3AxNUhqeUVpVE5VaDMtTXM5dUY3Z3ZHcDViYnlZVVEkDQo+ICAgdGVzdGluZw0K
PiBoZWFkOiAgIGZkMWU4YmI4ZWI0N2ZlNmM1YzhmYzI5YjgzYjU5NWI4Y2ZiZjNkYzcNCj4gY29t
bWl0OiBkNjM0ZjZiOWNjMzdiMTViN2I4YTQ1N2FiYjM3Y2Q3ODcyZTVhODk3IFs3Mi83NV0gaWlv
OiBjb3JlOiBtb3ZlDQo+IGRlYnVnZnMgZGF0YSBvbiB0aGUgcHJpdmF0ZSBpaW8gZGV2IGluZm8N
Cj4gY29uZmlnOiBzcGFyYzY0LXJhbmRjb25maWctYzAyMS0yMDIwMDYyOSAoYXR0YWNoZWQgYXMg
LmNvbmZpZykNCj4gY29tcGlsZXI6IHNwYXJjNjQtbGludXgtZ2NjIChHQ0MpIDkuMy4wDQo+IA0K
PiBJZiB5b3UgZml4IHRoZSBpc3N1ZSwga2luZGx5IGFkZCBmb2xsb3dpbmcgdGFnIGFzIGFwcHJv
cHJpYXRlDQo+IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4N
Cj4gDQo+IEFsbCBlcnJvcnMgKG5ldyBvbmVzIHByZWZpeGVkIGJ5ID4+KToNCj4gDQoNCk9oIHJp
Z2h0Lg0KVGhpcyBjYW4gaGFwcGVuIGlmIENPTkZJR19ERUJVR19GUyBpcyB1bmRlZmluZWQgYW5k
IENPTkZJR19JSU8gaXMgZGVmaW5lZC4NCldpbGwgZG8gYSBWMiBmb3IgdGhpcy4NCg0KDQo+ID4g
PiBkcml2ZXJzL2lpby9pbmR1c3RyaWFsaW8tY29yZS5jOjE2ODoxNjogZXJyb3I6IHJlZGVmaW5p
dGlvbiBvZg0KPiA+ID4gJ2lpb19nZXRfZGVidWdmc19kZW50cnknDQo+ICAgICAgMTY4IHwgc3Ry
dWN0IGRlbnRyeSAqaWlvX2dldF9kZWJ1Z2ZzX2RlbnRyeShzdHJ1Y3QgaWlvX2Rldg0KPiAqaW5k
aW9fZGV2KQ0KPiAgICAgICAgICB8ICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+
fn4NCj4gICAgSW4gZmlsZSBpbmNsdWRlZCBmcm9tIGRyaXZlcnMvaWlvL2luZHVzdHJpYWxpby1j
b3JlLmM6Mjc6DQo+ICAgIGluY2x1ZGUvbGludXgvaWlvL2lpby5oOjcyNDozMDogbm90ZTogcHJl
dmlvdXMgZGVmaW5pdGlvbiBvZg0KPiAnaWlvX2dldF9kZWJ1Z2ZzX2RlbnRyeScgd2FzIGhlcmUN
Cj4gICAgICA3MjQgfCBzdGF0aWMgaW5saW5lIHN0cnVjdCBkZW50cnkgKmlpb19nZXRfZGVidWdm
c19kZW50cnkoc3RydWN0DQo+IGlpb19kZXYgKmluZGlvX2RldikNCj4gICAgICAgICAgfCAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCj4gICAgZHJp
dmVycy9paW8vaW5kdXN0cmlhbGlvLWNvcmUuYzogSW4gZnVuY3Rpb24gJ2lpb19nZXRfZGVidWdm
c19kZW50cnknOg0KPiA+ID4gZHJpdmVycy9paW8vaW5kdXN0cmlhbGlvLWNvcmUuYzoxNzE6MjM6
IGVycm9yOiAnc3RydWN0DQo+ID4gPiBpaW9fZGV2X29wYXF1ZScgaGFzIG5vIG1lbWJlciBuYW1l
ZCAnZGVidWdmc19kZW50cnknDQo+ICAgICAgMTcxIHwgIHJldHVybiBpaW9fZGV2X29wYXF1ZS0+
ZGVidWdmc19kZW50cnk7DQo+ICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgIF5+DQo+
ICAgIGRyaXZlcnMvaWlvL2luZHVzdHJpYWxpby1jb3JlLmM6MTcyOjE6IHdhcm5pbmc6IGNvbnRy
b2wgcmVhY2hlcyBlbmQgb2YNCj4gbm9uLXZvaWQgZnVuY3Rpb24gWy1XcmV0dXJuLXR5cGVdDQo+
ICAgICAgMTcyIHwgfQ0KPiAgICAgICAgICB8IF4NCj4gDQo+IHZpbSArL2lpb19nZXRfZGVidWdm
c19kZW50cnkgKzE2OCBkcml2ZXJzL2lpby9pbmR1c3RyaWFsaW8tY29yZS5jDQo+IA0KPiAgICAx
NjcJDQo+ICA+IDE2OAlzdHJ1Y3QgZGVudHJ5ICppaW9fZ2V0X2RlYnVnZnNfZGVudHJ5KHN0cnVj
dCBpaW9fZGV2DQo+ICppbmRpb19kZXYpDQo+ICAgIDE2OQl7DQo+ICAgIDE3MAkJc3RydWN0IGlp
b19kZXZfb3BhcXVlICppaW9fZGV2X29wYXF1ZSA9DQo+IHRvX2lpb19kZXZfb3BhcXVlKGluZGlv
X2Rldik7DQo+ICA+IDE3MQkJcmV0dXJuIGlpb19kZXZfb3BhcXVlLT5kZWJ1Z2ZzX2RlbnRyeTsN
Cj4gICAgMTcyCX0NCj4gICAgMTczCUVYUE9SVF9TWU1CT0xfR1BMKGlpb19nZXRfZGVidWdmc19k
ZW50cnkpOw0KPiAgICAxNzQJDQo+IA0KPiAtLS0NCj4gMC1EQVkgQ0kgS2VybmVsIFRlc3QgU2Vy
dmljZSwgSW50ZWwgQ29ycG9yYXRpb24NCj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0
dHBzOi8vbGlzdHMuMDEub3JnL2h5cGVya2l0dHkvbGlzdC9rYnVpbGQtYWxsQGxpc3RzLjAxLm9y
Z19fOyEhQTNOaThDUzB5Mlkhc1lrYktsRlhUdjdUb0ZQYzZKNFhiVXFBN2lwZ0FpX050MUVVRlF3
cDE1SGp5RWlUTlVoMy1Nczl1RjdndkdveDJNZ0pFdyQgDQo=
