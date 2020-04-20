Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 714831B0155
	for <lists+linux-iio@lfdr.de>; Mon, 20 Apr 2020 08:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbgDTGIq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Apr 2020 02:08:46 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:40196 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725825AbgDTGIq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Apr 2020 02:08:46 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03K68V9r011466;
        Mon, 20 Apr 2020 02:08:44 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com with ESMTP id 30fxf5vnd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Apr 2020 02:08:44 -0400
Received: from m0167089.ppops.net (m0167089.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03K68ibx011567;
        Mon, 20 Apr 2020 02:08:44 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by mx0a-00128a01.pphosted.com with ESMTP id 30fxf5vnd1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Apr 2020 02:08:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AO0MYNmanoIKe5ejnGQ4kFfwT0lBoF/SlI/lWLwfqiBndG7aG8+M5Wk4rbMa7+AArp0IlR0lvlXdZVrD+cN7KGaYeoA5iouU8SdkX+BWQdGGdkA48oVRHm19vF7eVcrqyJ0QKWQ9TOB/Tv1I5oowkGfXhdkts5q/fV5FjGWRzGQVg4QBOGAy/LZIAqwqFzJgADX6o2B9aWlsqJH5pMVND1sXOlvlXHWNbUxGHuuNwiGGjVnNk7n7FDdmh7zPZ0svUNQ861JUgR6LepP+NUWJ4sYOnq/obKorUpENkZ6XRnNjlSi+kjQ50agqOkaX18wiFT19u/eSduze7fDfRCZnig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Z4hqRf1N4aU1HSfq3TM31IPpIpJ34L2yadslKtz/rs=;
 b=TWdOKdi64x40RfqJavCW5xbLVF4GeGy1JUR4JrABgMPL4iy5EGMnX4EbnrviIqY8/20BXshCNs4dUgm93x8OE8nIt3p8Azim3OLAo6dDElrV4F6RK8Rvzuvb3XmxL6FbHNQ7u+tjT4edGRQdQVLeOBcT1qQIJ8jMLDkffrsEqCD0NaTRA2/aXRLl4vc1szVBFFQW0msE4sKgH3ZXBzhfIJXDrbiw7Z676gz8NPpmMmH28L0oz1pKuJHuCsr9xcO6h3Ii2L7KoWCDscQp3QL/e3DmSxq6TnwqEDjef70CSApMQ7zQSZKIb5Ukpcp0oPvbwoEbNKgpXLNAAxkXwGl9vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Z4hqRf1N4aU1HSfq3TM31IPpIpJ34L2yadslKtz/rs=;
 b=79I9L67kFsVgnxQHVGlkek3op1kF+r0FymyY+o9EHcaldYBOsEMReazqg8dYx/SP3/F6EZU/jreF/9s2azlfzjoUvovBqmkFMyJrWPuxST4A7zk7KsDaMNrvoFfdQos/4Ido8I6PBrJMEYAZCo3e10R1Uccc6DOhg7aClc/ds3A=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4153.namprd03.prod.outlook.com (2603:10b6:5:5c::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Mon, 20 Apr
 2020 06:08:42 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2921.030; Mon, 20 Apr 2020
 06:08:42 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 6/7] iio: light: st_uvis25: Add mod_devicetable.h and drop
 of_match_ptr
Thread-Topic: [PATCH 6/7] iio: light: st_uvis25: Add mod_devicetable.h and
 drop of_match_ptr
Thread-Index: AQHWFlvVKrmDM1KrcUiTim3J6wt5+6iBiK4A
Date:   Mon, 20 Apr 2020 06:08:42 +0000
Message-ID: <3c22767b5473698feda5f79f9580cdf0cbe8366f.camel@analog.com>
References: <20200419150206.43033-1-jic23@kernel.org>
         <20200419150206.43033-7-jic23@kernel.org>
In-Reply-To: <20200419150206.43033-7-jic23@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.27.130.47]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b994ea7f-9e4c-4971-0a37-08d7e4f14704
x-ms-traffictypediagnostic: DM6PR03MB4153:
x-microsoft-antispam-prvs: <DM6PR03MB4153C96C2C5095CCD5D510AEF9D40@DM6PR03MB4153.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:639;
x-forefront-prvs: 03793408BA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(136003)(346002)(396003)(376002)(39850400004)(366004)(86362001)(36756003)(6512007)(186003)(26005)(71200400001)(6506007)(478600001)(110136005)(2616005)(4326008)(2906002)(66946007)(76116006)(91956017)(8676002)(5660300002)(8936002)(316002)(66446008)(6486002)(64756008)(66556008)(66476007)(81156014);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O6hLM52nrj2wcyyNo1SZlNiY2HW32Qb7xQKaB00T0PupTb+h86rRcT3ub1+5nNkrl2gvrMHv7+vXav9Lrc1z7AC5Nrih5qH9HuQkxgeSW85PmK5hZu5RGzzfPVPdTl/BxhFFW+mCJkUfE6CvAE59csx6KuOJUEaGbqPjId5PjuC9iM853T/LnG7fBCYZe5qjEsq1UcJllsdk2eenkU+moqmbQRJtLiOrrYMgb6lHQK14f+cXEGz/v/WGC9i6JIcbwKHiFoehrEjMXyce0zauDKQCFfz6iKbpd0mbHQOvmBo7CIzuyVbB12Eu6hOFwrAqlAw2HCF1UarC1CT9CtjBlm5N0PDoRjIeb+dg9ejbYoX5uejx7hdq/6dIVECbHihQYcL8yBMgTlUxSejYhDRT8ajh/KJs4PxyQ5Uw4L3oDOvrRFQnOhrlfQsz6EzIYzHv
x-ms-exchange-antispam-messagedata: J3B4Qd4wBi9fPKFPHY3Bszxt2TLOcRfelOtILa4pFhbFp1E7djJGNajUxxKBarCT0f8pMjJFTgA6g6qlRcGobH1YM0/bOrrBeoW5hds6fnvyvc+dAUxjK4sqfvmPTvzZ5ojfNuj9CaLl+mdu1+A0Xg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <DCF39F1EA9F18544BBF938338CE6A9CC@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b994ea7f-9e4c-4971-0a37-08d7e4f14704
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2020 06:08:42.5533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t4PO+3V5PHQjykucvyWT6R93PSFl9isArXvQZiEetNkKOwFbNi9fBUWMI3KfaNim4GNInS1e43uPOjBkaYzayujxcI//ZzQt059PIg1zWOY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4153
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-20_01:2020-04-17,2020-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 mlxlogscore=925 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004200054
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDIwLTA0LTE5IGF0IDE2OjAyICswMTAwLCBqaWMyM0BrZXJuZWwub3JnIHdyb3Rl
Og0KPiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+
DQo+IA0KPiBFbmFibGVzIHByb2JpbmcgdmlhIEFDUEkgUFJQMDAwMSBhbmQgcmVtb3ZlcyBhbiBl
eGFtcGxlIHRoYXQgd2UgZG9uJ3QNCj4gd2FudCBwZW9wbGUgdG8gY3V0IGFuZCBwYXN0ZSBpbnRv
IG5ldyBkcml2ZXJzLg0KPiANCg0KUmV2aWV3ZWQtYnk6IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxl
eGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+DQoNCj4gU2lnbmVkLW9mZi1ieTogSm9uYXRoYW4g
Q2FtZXJvbiA8Sm9uYXRoYW4uQ2FtZXJvbkBodWF3ZWkuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMv
aWlvL2xpZ2h0L3N0X3V2aXMyNV9pMmMuYyB8IDMgKystDQo+ICBkcml2ZXJzL2lpby9saWdodC9z
dF91dmlzMjVfc3BpLmMgfCAzICsrLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vbGlnaHQv
c3RfdXZpczI1X2kyYy5jDQo+IGIvZHJpdmVycy9paW8vbGlnaHQvc3RfdXZpczI1X2kyYy5jDQo+
IGluZGV4IDQwMDcyNDA2OWQxOS4uOThjZDQ5ZWVmZTQ1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L2lpby9saWdodC9zdF91dmlzMjVfaTJjLmMNCj4gKysrIGIvZHJpdmVycy9paW8vbGlnaHQvc3Rf
dXZpczI1X2kyYy5jDQo+IEBAIC05LDYgKzksNyBAQA0KPiAgDQo+ICAjaW5jbHVkZSA8bGludXgv
a2VybmVsLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQo+ICsjaW5jbHVkZSA8bGlu
dXgvbW9kX2RldmljZXRhYmxlLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvaTJjLmg+DQo+ICAjaW5j
bHVkZSA8bGludXgvc2xhYi5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3JlZ21hcC5oPg0KPiBAQCAt
NTUsNyArNTYsNyBAQCBzdGF0aWMgc3RydWN0IGkyY19kcml2ZXIgc3RfdXZpczI1X2RyaXZlciA9
IHsNCj4gIAkuZHJpdmVyID0gew0KPiAgCQkubmFtZSA9ICJzdF91dmlzMjVfaTJjIiwNCj4gIAkJ
LnBtID0gJnN0X3V2aXMyNV9wbV9vcHMsDQo+IC0JCS5vZl9tYXRjaF90YWJsZSA9IG9mX21hdGNo
X3B0cihzdF91dmlzMjVfaTJjX29mX21hdGNoKSwNCj4gKwkJLm9mX21hdGNoX3RhYmxlID0gc3Rf
dXZpczI1X2kyY19vZl9tYXRjaCwNCj4gIAl9LA0KPiAgCS5wcm9iZSA9IHN0X3V2aXMyNV9pMmNf
cHJvYmUsDQo+ICAJLmlkX3RhYmxlID0gc3RfdXZpczI1X2kyY19pZF90YWJsZSwNCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvaWlvL2xpZ2h0L3N0X3V2aXMyNV9zcGkuYw0KPiBiL2RyaXZlcnMvaWlv
L2xpZ2h0L3N0X3V2aXMyNV9zcGkuYw0KPiBpbmRleCBjZDM3NjFhM2VlM2YuLmFmOWQ5NGQxMjc4
NyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9paW8vbGlnaHQvc3RfdXZpczI1X3NwaS5jDQo+ICsr
KyBiL2RyaXZlcnMvaWlvL2xpZ2h0L3N0X3V2aXMyNV9zcGkuYw0KPiBAQCAtOSw2ICs5LDcgQEAN
Cj4gIA0KPiAgI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L21v
ZHVsZS5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L21vZF9kZXZpY2V0YWJsZS5oPg0KPiAgI2luY2x1
ZGUgPGxpbnV4L3NwaS9zcGkuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+DQo+ICAjaW5j
bHVkZSA8bGludXgvcmVnbWFwLmg+DQo+IEBAIC01NSw3ICs1Niw3IEBAIHN0YXRpYyBzdHJ1Y3Qg
c3BpX2RyaXZlciBzdF91dmlzMjVfZHJpdmVyID0gew0KPiAgCS5kcml2ZXIgPSB7DQo+ICAJCS5u
YW1lID0gInN0X3V2aXMyNV9zcGkiLA0KPiAgCQkucG0gPSAmc3RfdXZpczI1X3BtX29wcywNCj4g
LQkJLm9mX21hdGNoX3RhYmxlID0gb2ZfbWF0Y2hfcHRyKHN0X3V2aXMyNV9zcGlfb2ZfbWF0Y2gp
LA0KPiArCQkub2ZfbWF0Y2hfdGFibGUgPSBzdF91dmlzMjVfc3BpX29mX21hdGNoLA0KPiAgCX0s
DQo+ICAJLnByb2JlID0gc3RfdXZpczI1X3NwaV9wcm9iZSwNCj4gIAkuaWRfdGFibGUgPSBzdF91
dmlzMjVfc3BpX2lkX3RhYmxlLA0K
