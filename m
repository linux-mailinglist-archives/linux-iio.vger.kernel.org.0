Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B13C18DE79
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 08:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgCUHRh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 03:17:37 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:4100 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728039AbgCUHRh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Mar 2020 03:17:37 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02L7DdM2022559;
        Sat, 21 Mar 2020 03:17:34 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-00128a01.pphosted.com with ESMTP id 2yw4ec1k54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 21 Mar 2020 03:17:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3p9bo6UKXqQ17elqvmxolTWrP92ZlgKlBKvD5YilRkEuN7VtQ4Ii6McjO41Ny8PLO/pLAM8kJHJwLrrpIQa/JvySHR4Z9iYGsTeTjahF82EH8Eq4pwSyek/lfp1VREwuoyVA25ZIatm0xfVnv218+F+N69eToC2F96tlEFLtnnyP8/3wjNoVpWjvjsx7WD6ZrtQhVE7XF1m8DROns2FaZRtQyvwh6qokjIYu6/zwbs7NQ/+YYIC0OAA5VK52z9stUPnp+4Ra6rIHRUOdGbIVVPe3hjUxFFJqZLu02Y/IPOHYnYW+pe8TSyDZlmADoEPqyp44Iy9ZKBE+AH4PUsQaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfFMnaKdhvsgFNI13AxbOizFw5hMZbD45wCcwTco4v8=;
 b=eIpH6wSMLtVNb+iZC+ONfugKP7pcTDHLFHnzderDfhb8pMVjDGGy2O0skRhAjQEUFULPQXGVrHy/C/9/uY0LjKfaA6DHEgAflgqW6V4aje1BgpAAtUpqsClZ4colEGzROb1dI4r3opDkMhhhPGxCJYoAn90SVQgJ2J+zrKBp53vPK330oU2LZgRls7jGrP+sOpCSozckTfDWEikwGbdx41M0OFTGQVtEsnQPW+OX7vOborY32zwrqcB+c7U9mHpDuwwY0Y21NzExy9qKShXVO5Lb92QzOejn/tDBo22zw/npXV1vZ1tqvFSv5EPOM+6gwGt5J3reORX5LWpzSx7lHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfFMnaKdhvsgFNI13AxbOizFw5hMZbD45wCcwTco4v8=;
 b=vG2KoNstkKXwI8O2CHgdYUfOeZQdEEcJfIjg5oJk3vQtpOGBB832wBgRWc66//f4h7ratYFdijbfiUU7Yi9+fLYSqBJTyrc48HWm988CwLu6FaN85U9K2BRPAVpMVjFCvitWkY1okE1dhRhZs8DAYCgaQnt9hmvylrWZ2LL+gMk=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB5003.namprd03.prod.outlook.com (2603:10b6:5:1e7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.18; Sat, 21 Mar
 2020 07:17:31 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2814.025; Sat, 21 Mar 2020
 07:17:30 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "tachicialex@gmail.com" <tachicialex@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>
Subject: Re: [PATCH 0/2] iio: dac: ad5770r: dt bindings fixes
Thread-Topic: [PATCH 0/2] iio: dac: ad5770r: dt bindings fixes
Thread-Index: AQHV/tF6DEq2TnRPCUSuEzqKI+oxtahSpOAA
Date:   Sat, 21 Mar 2020 07:17:30 +0000
Message-ID: <5a7729473f13cd7e9991b1ce0c1567d770eeb3e3.camel@analog.com>
References: <20200320160531.23732-1-alexandru.tachici@analog.com>
In-Reply-To: <20200320160531.23732-1-alexandru.tachici@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.26.73.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 351c8b3c-d76d-4035-f390-08d7cd67eb4c
x-ms-traffictypediagnostic: DM6PR03MB5003:
x-microsoft-antispam-prvs: <DM6PR03MB50030872CEB0F267D24758CCF9F20@DM6PR03MB5003.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 034902F5BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(39860400002)(136003)(396003)(199004)(2616005)(4744005)(5660300002)(66946007)(4326008)(2906002)(64756008)(66556008)(66476007)(66446008)(186003)(91956017)(36756003)(26005)(76116006)(86362001)(110136005)(6506007)(8936002)(81156014)(81166006)(8676002)(6512007)(478600001)(71200400001)(316002)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB5003;H:DM6PR03MB4411.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S3TonYZ9u/zKO6qzm/zpqF1yIXCslZB2M63bFVr1Wg7HewITaRHZOmU+N9jVGTiCiRvfASwVwtU9IVEUL1ELaQMP7lZmPtVUoq9WNIXOvekF1P7Mg1QvWqojig1wFUNePPUK7x5BbUGbAJihEFGiY+XAO9fcZASxJRpocw8mGPCuOlPgOhdZ8L/NSuv0/IMKMAQxyvjrrPMCMe2vh7U03XyMe7b5LswR/00U7S1tfh/VJ/C3JO/xdcRNEm8Pcxw0BiK00fiSwZrB9uW5SOaYsND5/+DmvFE6V5T6sbrKj1FdHI+dT00DVZTd/z5cwx6Ie8SrF3zaqC92RDt95MGIxXaNBghFItYrrz5id9LojsPio6zS2ZgK/+V/AWUfGRMCk69B4Uk+WRroDCrZMrmMiadJk5C+hF+hM653lkyGtscFfIXs11MUDl5Bjd/3B/VR
x-ms-exchange-antispam-messagedata: DCajHz/ZCRyQ0YBuE9307Z+dWwraUVyRD1SMCCZWT6zhAw8/xhNGXJQK9VWktWm20IidA9/RZT4S92MZybmXmstHWBwhs2IDzeCmAs+1zqT0PY0KvAlw61meSFYaz6oeFM3zQzzzIGOy5CYvBGv4Nw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <571498738DDC974B883F62A88C352EDC@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 351c8b3c-d76d-4035-f390-08d7cd67eb4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2020 07:17:30.7829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pS1WXrN3eUBQS9jHnnK2Pt01DT4eMRtrPx7T6W+PsCQP/EGl0KI1acaUXR+0HpjNwWgvWYKu+jq2Av72tUv5XWDhDZ1Wpg+8QAkxXOwOkhU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5003
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-21_01:2020-03-20,2020-03-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0
 mlxscore=0 bulkscore=0 adultscore=0 clxscore=1011 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003210041
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gRnJpLCAyMDIwLTAzLTIwIGF0IDE4OjA1ICswMjAwLCBBbGV4YW5kcnUgVGFjaGljaSB3cm90
ZToNCj4gW0V4dGVybmFsXQ0KPiANCj4gVGhpcyBhaW1zIHRvIHJlcGxhY2UgdXNlIG9mIG51bSBw
cm9wZXJ0eSBmcm9tIGR0IG5vZGVzIHdpdGgNCj4gcmVnIHByb3BlcnR5IGJvdGggaW4gZHQgYmlu
ZGluZ3MgYW5kIGRyaXZlciBhbmQgZml4DQo+IGR0IGJpbmRpbmdzIGVycm9ycy4NCj4gDQoNCk1h
eWJlIGRvIGEgUkVTRU5EIGZvciB0aGlzIGFuZCBhZGQNCi0tdG89ZGV2aWNldHJlZUB2Z2VyLmtl
cm5lbC5vcmcgLS1jYz1yb2JoK2R0QGtlcm5lbC5vcmcNCnRvIHRoZSBnaXQgc2VuZC1tYWlsIGNv
bW1hbmQNCg0KU3BlY2lmaWNhbGx5IGZvciB0aGlzLCB0aGUgRFQgbGlzdCBzaG91bGQgYmUgYWRk
cmVzc2VkLg0KQnV0IFtuYXR1cmFsbHldIHRoZSBJSU8gbGlzdCBzaG91bGQgYWxzbyBiZSBpbmNs
dWRlZC4NCg0KDQo+IDEuIHJlYWQgZnJvbSBmd25vZGUgcmVnIHByb3BlcnR5IGluc3RlYWQgb2Yg
bnVtIHByb3BlcnR5DQo+IA0KPiAyLiByZXBsYWNlIG51bSBwcm9wZXJ0eSB3aXRoIHJlZyBwcm9w
ZXJ0eSBhbmQgZml4IGR0DQo+IGJpbmRpbmdzIGVycm9ycw0KPiANCj4gQWxleGFuZHJ1IFRhY2hp
Y2kgKDIpOg0KPiAgIGlpbzogZGFjOiBhZDU3NzByOiByZWFkIGNoYW5uZWwgbnIgZnJvbSByZWcN
Cj4gICBkdC1iaW5kaW5nczogaWlvOiBkYWM6IEFENTU3MFIgZml4IGJpbmRpbmdzIGVycm9ycw0K
PiANCj4gIC4uLi9iaW5kaW5ncy9paW8vZGFjL2FkaSxhZDU3NzByLnlhbWwgICAgICAgICB8IDc3
ICsrKysrKysrKystLS0tLS0tLS0NCj4gIGRyaXZlcnMvaWlvL2RhYy9hZDU3NzByLmMgICAgICAg
ICAgICAgICAgICAgICB8ICAyICstDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDQxIGluc2VydGlvbnMo
KyksIDM4IGRlbGV0aW9ucygtKQ0KPiANCg==
