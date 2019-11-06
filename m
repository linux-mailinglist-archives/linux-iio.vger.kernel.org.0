Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE60F1855
	for <lists+linux-iio@lfdr.de>; Wed,  6 Nov 2019 15:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfKFOUW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 6 Nov 2019 09:20:22 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:35724 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727645AbfKFOUW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 6 Nov 2019 09:20:22 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA6EIWST004750;
        Wed, 6 Nov 2019 09:19:54 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com with ESMTP id 2w2a4e7rx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Nov 2019 09:19:54 -0500
Received: from m0167088.ppops.net (m0167088.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xA6EJrmp005932;
        Wed, 6 Nov 2019 09:19:54 -0500
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2058.outbound.protection.outlook.com [104.47.32.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2w2a4e7rx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Nov 2019 09:19:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a87tPT+Xr830c4J7Xxvx43QDKSqDbZ2Cl2Vqn6gfaapVSfMJt9L6v8xDMXo7VHfloJGfwbL7Fom0rnLw/nEJEEg0h4Rjlm5NKMH3+pem4hzqZtFHgL6ji7AMYwyPRcxOQBou1l+8OYmGBhLUK4gJ8ScISrR2zCOkH2TSUz9l8yQiHnGDp4jxyY0QvfZ4DwaC4Fzi7zKMB5ZV9vhv/Xly2LayOkwutA/gwyTQkBGa2khQ/QC/C9vTTBbnAWkOYA5UwBxAPkhcAF9UXr4BYSheoxYsdjaCgFspo7LfezvCuJUcaHGlFT3upbMvolpBLB9bYUP1wxnAZrmbp94VpQdeBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTP+vvW97yGMLf03k8H9jXrPhdEkHwitzxLrE2PjqQ0=;
 b=Hoc18nA2YdkUX4L8DLX/LGk6bPvGIkS5w21CEd84bLr8juORC3YAOAy8xqXrd70iktNbd+V/Bg5Svi2iqcW/wk/SfgvgsJYYaNGynjm3ISm8+sX5a+q5SXmlLqQPD2lkwquR3rGvWsfoQ6MVlOLGY5cr5/KOp/XTr2eBg9xEEb3uK+7Y4HbsVUld9yb6gJoTxkT5NivU58fVTiSzrfhZTvfNTiohpYHVIQhaSL19AlPXXZ+zmHq2ROgcQMBW1sRapfBwz4OmPz0izzAoDFHup+3ykkz8JEQNtcdK2CWeHY0IDQkxB80CNBmiDdLhZlB/4gz9Uu0UvIFHvMnlmfOcOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTP+vvW97yGMLf03k8H9jXrPhdEkHwitzxLrE2PjqQ0=;
 b=xDVucej4oyGEi5l0xzeNFsPaJz+xk02d15PSjK/vdysjRYp6P83jJUWXmW4cBRnsPtYcMEarxyVKOsZ/F9FkFI51fef7v1GSO6t0QMcHMrXCszrzZEaM9R3Rr9kA3kdxJ/dRzu0GQELIooGiOc0ZVJH+xDOvBU2jgzp6Jtxy2CQ=
Received: from MN2PR03MB5117.namprd03.prod.outlook.com (52.132.169.145) by
 MN2PR03MB5022.namprd03.prod.outlook.com (52.132.170.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22; Wed, 6 Nov 2019 14:19:52 +0000
Received: from MN2PR03MB5117.namprd03.prod.outlook.com
 ([fe80::9d35:c43f:1cdd:4c7d]) by MN2PR03MB5117.namprd03.prod.outlook.com
 ([fe80::9d35:c43f:1cdd:4c7d%6]) with mapi id 15.20.2430.020; Wed, 6 Nov 2019
 14:19:52 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "lars@metafoo.de" <lars@metafoo.de>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: temperature: ltc2983: fix u32 read into a unsigned
 long long
Thread-Topic: [PATCH] iio: temperature: ltc2983: fix u32 read into a unsigned
 long long
Thread-Index: AQHVlBeUdoPWrASrBUa+bZTQPdnd2ad+MnkA
Date:   Wed, 6 Nov 2019 14:19:52 +0000
Message-ID: <dab9cfd93e6affa5d94f078154c3e181303bbf47.camel@analog.com>
References: <20191105202818.90065-1-colin.king@canonical.com>
In-Reply-To: <20191105202818.90065-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bb6fea16-2a3b-4ec2-fa05-08d762c463ca
x-ms-traffictypediagnostic: MN2PR03MB5022:
x-microsoft-antispam-prvs: <MN2PR03MB5022D44CBF60F55DB366667299790@MN2PR03MB5022.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39860400002)(366004)(396003)(189003)(199004)(486006)(26005)(6506007)(76176011)(256004)(476003)(186003)(14454004)(25786009)(305945005)(7736002)(11346002)(66066001)(446003)(2616005)(6486002)(2201001)(229853002)(2906002)(99286004)(76116006)(110136005)(6436002)(66946007)(6116002)(71190400001)(6512007)(86362001)(102836004)(71200400001)(316002)(5660300002)(2501003)(6246003)(8676002)(478600001)(118296001)(91956017)(66476007)(81156014)(66556008)(66446008)(81166006)(64756008)(36756003)(4326008)(3846002)(8936002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR03MB5022;H:MN2PR03MB5117.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oB8sBeanAIB/CfnTedIMj+NCXeTtDQeFVKsBNfMCyk18iN6uV7NiICSlzHHd8RTD8TlUUbx83LVLp9vv7sGvx+Hq+bvVPqT4MhE/OpCVXz8pV2ewCVF/W4f7ZZjICV93UfFk7Oe3dsV9CD95V/vgohEdojiWvYk5tKhOQU7WIijUTxwGmiXqieDUqvcsIC9oz9eY3OSD4qqlBW9Z1fYQVGAPSRNYdBpqbkKRs55nqIM5BJ/4cQfr3Uc6jShTKNTZkzVKcONtG5L4HzAajvxeLsVXjHiI3r+7iey9Oxl3Sr7nr3041gbaQgMV5B/hsTNXaMWBQ9Zjx45JOmnM7bBEEVQUHCU6a13ZU0gziJe0BvJTQa9OsJFnMvFK1Q7N940WiBbvgnseyVcgPYhvOQzM0T8xw52EREDxjFKFpovlLRVXH1O234E5uIvTT+7PRWEm
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5AED64D5BA055E40A111120D232609E3@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb6fea16-2a3b-4ec2-fa05-08d762c463ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 14:19:52.3075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PKW82vXST8ze9sc1QPx3Wnxw+kQE+BJ/S5+rlTCu6ZBGiv2pDcIxGqa3V7k9wYtF/+XJjU0qOetBNxI4MjqbJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5022
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-06_04:2019-11-06,2019-11-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 clxscore=1011 adultscore=0 impostorscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1911060141
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDE5LTExLTA1IGF0IDIwOjI4ICswMDAwLCBDb2xpbiBLaW5nIHdyb3RlOg0KPiAN
Cj4gRnJvbTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4NCj4gDQo+
IEN1cnJlbnRseSB0aGUgcmVhZCBvZiB0ZW1wIHVzaW5nIG9mX3Byb3BlcnR5X3JlYWRfdTMyX2lu
ZGV4IGlzDQo+IHJlYWRpbmcNCj4gYSB1MzIgdmFsdWUgaW50byBhIHVuc2lnbmVkIGxvbmcgbG9u
Zy4gIFRoaXMgcmVsaWVzIG9uIG1hY2hpbmUNCj4gZW5kaWFubmVzcw0KPiB0byB3b3JrIGNvcnJl
Y3RseSwgc28gZml4IHRoaXMgYnkgcmVhZGluZyBhIHUzMiB2YWx1ZSBhbmQgc2V0dGluZw0KPiB0
ZW1wDQo+IHRvIHRoaXMgdmFsdWUuDQo+IA0KPiBBZGRyZXNzZXMtQ292ZXJpdHk6ICgiUmVsaWFu
Y2Ugb24gaW50ZWdlciBlbmRpYW5uZXNzIikNCj4gRml4ZXM6IGYxMTBmMzE4OGU1NiAoImlpbzog
dGVtcGVyYXR1cmU6IEFkZCBzdXBwb3J0IGZvciBMVEMyOTgzIikNCj4gU2lnbmVkLW9mZi1ieTog
Q29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4NCj4gLS0tDQo+ICBkcml2
ZXJzL2lpby90ZW1wZXJhdHVyZS9sdGMyOTgzLmMgfCA2ICsrKystLQ0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2lpby90ZW1wZXJhdHVyZS9sdGMyOTgzLmMNCj4gYi9kcml2ZXJzL2lpby90ZW1wZXJh
dHVyZS9sdGMyOTgzLmMNCj4gaW5kZXggZGRmNDcwMjMzNjRiLi5kMzljMGQ2Yjc3ZjEgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvaWlvL3RlbXBlcmF0dXJlL2x0YzI5ODMuYw0KPiArKysgYi9kcml2
ZXJzL2lpby90ZW1wZXJhdHVyZS9sdGMyOTgzLmMNCj4gQEAgLTQ0NCw4ICs0NDQsMTAgQEAgc3Rh
dGljIHN0cnVjdCBsdGMyOTgzX2N1c3RvbV9zZW5zb3INCj4gKl9fbHRjMjk4M19jdXN0b21fc2Vu
c29yX25ldygNCj4gIAkJCWVsc2UNCj4gIAkJCQl0ZW1wID0gX19jb252ZXJ0X3RvX3Jhdyh0ZW1w
LA0KPiByZXNvbHV0aW9uKTsNCj4gIAkJfSBlbHNlIHsNCj4gLQkJCW9mX3Byb3BlcnR5X3JlYWRf
dTMyX2luZGV4KG5wLCBwcm9wbmFtZSwgaW5kZXgsDQo+IC0JCQkJCQkgICAodTMyICopJnRlbXAp
Ow0KPiArCQkJdTMyIHQzMjsNCj4gKw0KPiArCQkJb2ZfcHJvcGVydHlfcmVhZF91MzJfaW5kZXgo
bnAsIHByb3BuYW1lLCBpbmRleCwNCj4gJnQzMik7DQo+ICsJCQl0ZW1wID0gdDMyOw0KPiAgCQl9
DQo+ICANCj4gIAkJZm9yIChqID0gMDsgaiA8IG5fc2l6ZTsgaisrKQ0KDQpBY2tlZC1ieTogTnVu
byBTw6EgPG51bm8uc2FAYW5hbG9nLmNvbT4NCg0KVGhhbmtzLA0KTnVubyBTw6ENCg==
