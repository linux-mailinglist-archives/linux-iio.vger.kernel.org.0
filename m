Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4C310EAF4
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2019 14:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfLBNhf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Dec 2019 08:37:35 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:19252 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727435AbfLBNhf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Dec 2019 08:37:35 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB2DXVuj012599;
        Mon, 2 Dec 2019 08:37:06 -0500
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2057.outbound.protection.outlook.com [104.47.33.57])
        by mx0a-00128a01.pphosted.com with ESMTP id 2wkp76cw5c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Dec 2019 08:37:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lbT7mI49iJml1FNvgGdPwWFoZlSy9FgMeTd/4KEiIm8wAvoISbIAjRl3a1uurFtRwDMomYwhKc8drw9Dus49KfabLQUvrxz19nFvczljLzam/KcbcOxAMLUlbvar7yU8IfJtV57kJEKAUWkribq+tW2z5/rNkRgqSXryuUPnGrPvfGm9mNWOVpsg5jnIWkJJh6NVC6JUpWsM6H27dJ6zPExktQs1l4Vw4PEFuDINfP3gVxCbi8XkG173h7TkEf+7l45OY7L2vld+GnIG0xyBCxeZ0T1+NnZKaMeGMCyJ5senJc05OfD9uWejPfB0nDkXlHF5AXXFgeENaWzaR+P9gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0EEGHpYTv7StCBphBMMmTBouWubmofZIt9nNkfTGzo=;
 b=U9So1EFRsnhojt4JyINonFT7S0blN/fmvbfRfko6pQmeWw+lS04snjAy+MlNTVH69hMILBMrUayC9+GaaySpQDz3cJJSHkTSI177/QCtj3R3SZhnw7bADy+VZYQl9cNBnqpqZCvDrqaBNIEsfJmfEoLhkB+gBWrvCHrJKpg/j5wcOwCLseeZoTUX3/zwFbA71YX29nmT5Yjt0K2vqYFRuUsgngKwY4aoiyP85oALNWeW+ZzUJgY8UeoBYTPLvXavb/9bYwgwb1+eSJxsFRrFJpPq4bgNQvco3TaI7F9vN4/qrQQeXqqbFINwFtSaA80B8uuvJ3m94EKwW8CQoAP3sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0EEGHpYTv7StCBphBMMmTBouWubmofZIt9nNkfTGzo=;
 b=f9SFtoEE8LpuHbqjO96PryFKfEY+p4zkDDXDItk6lT+ht55Vy/CSElqA/owIJUi8vccY0VTE9aECPRP0e1z1yzjh9xkGSdfKsxYNJM2F9Xly5c3sXbXxk58ONpu7alrf4NqhWN7ul1VGnLnfIk/edV+Hu3TnAMsbxxntwWeQtNo=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5334.namprd03.prod.outlook.com (20.180.13.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Mon, 2 Dec 2019 13:37:04 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::38e7:c7c5:75cc:682c]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::38e7:c7c5:75cc:682c%5]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 13:37:04 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars.moellendorf@plating.de" <lars.moellendorf@plating.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
Subject: Re: [PATCH 1/3] iio: buffer: align the size of scan bytes to size of
 the largest element
Thread-Topic: [PATCH 1/3] iio: buffer: align the size of scan bytes to size of
 the largest element
Thread-Index: AQHVqRDBywD5xcdbbUiiYjAfYzvg0qem2WEA
Date:   Mon, 2 Dec 2019 13:37:04 +0000
Message-ID: <531d08db4d758cb8ab9f7e1955c7b918ff2b0c69.camel@analog.com>
References: <810ab64f-31bf-c4af-a655-7bddf364dae4@metafoo.de>
         <20191202130113.24005-1-lars.moellendorf@plating.de>
In-Reply-To: <20191202130113.24005-1-lars.moellendorf@plating.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 23cdc45d-b988-452b-8fea-08d7772cb7e6
x-ms-traffictypediagnostic: CH2PR03MB5334:
x-microsoft-antispam-prvs: <CH2PR03MB53347F3AB41EBF22CF793AB3F9430@CH2PR03MB5334.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0239D46DB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(39860400002)(366004)(396003)(199004)(189003)(66946007)(14444005)(256004)(2616005)(8936002)(6246003)(6486002)(76176011)(8676002)(6436002)(6506007)(186003)(6512007)(2201001)(81166006)(26005)(99286004)(81156014)(86362001)(229853002)(305945005)(110136005)(316002)(5660300002)(2501003)(478600001)(3846002)(76116006)(6116002)(66574012)(7736002)(102836004)(25786009)(71200400001)(71190400001)(2906002)(66066001)(11346002)(66446008)(64756008)(66556008)(66476007)(36756003)(446003)(14454004)(118296001);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5334;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6j1Wmo+fa/2BOrvTc4uLLx8an8a+uqDCaCWnD/esYtSCFlhotscVb5UNVag/a3xaLzZDosIrtQYz0M3vm4AcSwJpwTgF8qJZlz+ray4AVU+PyfCY2Tp8ZIpw6Z1uwJoByvIdbvCR8WAzwPjedN2rTG7/JFSv8+3SbNYBMIerGmXcwH03vgWJiA3ggQZcFJlA0ef+5HGq2LLh3p+ABGaouZxGG3hX5s356UomkUaml2uh+bPumQjE7NHLrz639bmJSF3KV/7om2PQ5AZIQPf14MBQ6XLVAYGr9m2MWivFo+FK0xPjAbPW/EIUjdmjJe15eWB7aPmCNXvTerrXEYIr9nAhPT/3ya4KfgiDkN8iZtGl0nT+ZZxW9CE+jZAX14l2+aB++zhzVW8P6IP/Mmoy9k9cG71mYJv57JkgR2AzmkXje00SZtntrm88+Z/va2Xm
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E2007E76CFC67489CE1E1BABB333A78@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23cdc45d-b988-452b-8fea-08d7772cb7e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2019 13:37:04.2427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r3WugnE8V6h8NFKmfU/C5pjawsa/rsZrINEg5AVMAQehyrrNNS+9HuKm3EGnGUv2HAqNaIKYssnVO9zCVgnEzwkiLls12UYSPzcD19hN6rY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5334
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-02_02:2019-11-29,2019-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 adultscore=0 priorityscore=1501 clxscore=1011
 mlxlogscore=999 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1912020124
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gTW9uLCAyMDE5LTEyLTAyIGF0IDE0OjAxICswMTAwLCBMYXJzIE3DtmxsZW5kb3JmIHdyb3Rl
Og0KPiANCg0KSGV5IExhcnMsDQoNClRoYW5rIHlvdSBmb3IgdGhlIHBhdGNoLg0KDQpDb3VsZCB5
b3UgYWRkIGEgZGVzY3JpcHRpb24gb2YgdGhlIHByb2JsZW0gaW4gdGhlIGNvbW1pdCBkZXNjcmlw
dGlvbj8NCllvdSBkaWQgYSByZWFsbHkgZ3JlYXQgam9iIG9uIGRlc2NyaWJpbmcgaXQgdmlhIGVt
YWlsIGVhcmxpZXIsIGFuZCBpdCB3b3VsZA0KYmUgZ3JlYXQgdG8gaGF2ZSBpdCBpbiB0aGUgZ2l0
IGhpc3RvcnkgYXMgd2VsbC4NCg0KQWxzbywgdGhpcyBwYXRjaCBpcyBtYXJrZWQgMS8zIDsgY3Vy
aW9zOiBhcmUgdGhlcmUgMiBtb3JlIHBhdGNoZXMgaW4gYSBzZXQ/DQpTb21ldGltZXMsIHNvbWUg
cGF0Y2hlcyBnZXQgbG9zdCB2aWEgZW1haWwgY2xpZW50cy9zZXJ2ZXJzLg0KDQpNYXliZSBKb25h
dGhhbiBbb3Igc29tZW9uZSBlbHNlXSBoYXMgc29tZSBtb3JlIHBvaW50cyB0byB0aGlzLg0KDQpU
aGFua3MNCkFsZXgNCg0KPiBTaWduZWQtb2ZmLWJ5OiBMYXJzIE3DtmxsZW5kb3JmIDxsYXJzLm1v
ZWxsZW5kb3JmQHBsYXRpbmcuZGU+DQo+IC0tLQ0KPiAgZHJpdmVycy9paW8vaW5kdXN0cmlhbGlv
LWJ1ZmZlci5jIHwgNiArKysrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9pbmR1c3RyaWFs
aW8tYnVmZmVyLmMNCj4gYi9kcml2ZXJzL2lpby9pbmR1c3RyaWFsaW8tYnVmZmVyLmMNCj4gaW5k
ZXggNWQwNWMzOGM0YmE5Li4yZjAzN2NkNTlkNTMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaWlv
L2luZHVzdHJpYWxpby1idWZmZXIuYw0KPiArKysgYi9kcml2ZXJzL2lpby9pbmR1c3RyaWFsaW8t
YnVmZmVyLmMNCj4gQEAgLTU0Niw3ICs1NDYsNyBAQCBzdGF0aWMgaW50IGlpb19jb21wdXRlX3Nj
YW5fYnl0ZXMoc3RydWN0IGlpb19kZXYNCj4gKmluZGlvX2RldiwNCj4gIAkJCQljb25zdCB1bnNp
Z25lZCBsb25nICptYXNrLCBib29sIHRpbWVzdGFtcCkNCj4gIHsNCj4gIAl1bnNpZ25lZCBieXRl
cyA9IDA7DQo+IC0JaW50IGxlbmd0aCwgaTsNCj4gKwlpbnQgbGVuZ3RoLCBpLCBsYXJnZXN0ID0g
MDsNCj4gDQo+ICAJLyogSG93IG11Y2ggc3BhY2Ugd2lsbCB0aGUgZGVtdXhlZCBlbGVtZW50IHRh
a2U/ICovDQo+ICAJZm9yX2VhY2hfc2V0X2JpdChpLCBtYXNrLA0KPiBAQCAtNTU0LDEzICs1NTQs
MTcgQEAgc3RhdGljIGludCBpaW9fY29tcHV0ZV9zY2FuX2J5dGVzKHN0cnVjdCBpaW9fZGV2DQo+
ICppbmRpb19kZXYsDQo+ICAJCWxlbmd0aCA9IGlpb19zdG9yYWdlX2J5dGVzX2Zvcl9zaShpbmRp
b19kZXYsIGkpOw0KPiAgCQlieXRlcyA9IEFMSUdOKGJ5dGVzLCBsZW5ndGgpOw0KPiAgCQlieXRl
cyArPSBsZW5ndGg7DQo+ICsJCWxhcmdlc3QgPSBtYXgobGFyZ2VzdCwgbGVuZ3RoKTsNCj4gIAl9
DQo+IA0KPiAgCWlmICh0aW1lc3RhbXApIHsNCj4gIAkJbGVuZ3RoID0gaWlvX3N0b3JhZ2VfYnl0
ZXNfZm9yX3RpbWVzdGFtcChpbmRpb19kZXYpOw0KPiAgCQlieXRlcyA9IEFMSUdOKGJ5dGVzLCBs
ZW5ndGgpOw0KPiAgCQlieXRlcyArPSBsZW5ndGg7DQo+ICsJCWxhcmdlc3QgPSBtYXgobGFyZ2Vz
dCwgbGVuZ3RoKTsNCj4gIAl9DQo+ICsNCj4gKwlieXRlcyA9IEFMSUdOKGJ5dGVzLCBsYXJnZXN0
KTsNCj4gIAlyZXR1cm4gYnl0ZXM7DQo+ICB9DQo+IA0KPiAtLQ0KPiAyLjIzLjANCj4gDQo=
