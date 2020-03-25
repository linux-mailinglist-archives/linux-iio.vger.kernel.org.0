Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04DD2192768
	for <lists+linux-iio@lfdr.de>; Wed, 25 Mar 2020 12:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbgCYLmj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Mar 2020 07:42:39 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:62534 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726658AbgCYLmj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Mar 2020 07:42:39 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02PBapmn023026;
        Wed, 25 Mar 2020 07:42:32 -0400
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2053.outbound.protection.outlook.com [104.47.46.53])
        by mx0b-00128a01.pphosted.com with ESMTP id 2ywcp9v2tk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Mar 2020 07:42:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eq6PuOPrSu+06/D2Q0RTfMT6Rfe8NaZpnhMVVbbZh4i70+UYpPosrzJDh4e55caEdyWUFXXV41IgGcoiumFz+FoeHUdXlw8V7LfY6rfd0d7U1YQM28EmZNUL6I1ExAmZJwRjPYPE+qvKS/Wf3EGjL5X6PSaOUoz/HhlCIpzuYqmzxd0WSi8MKmsAMcxdYumDaBRn5EP99nIvqT48YF/XZ2dghWna1gyd35KmmoGNT53iQ/Ywgi0FWNbE28l/a6ysYTPeFwIZci6Z9SgbhaAqOuyqrECyMcia3KjQImbKBX7lz6Rq8GrlJfYCBbwAFMnjlzkmqSU3TaIFXvLvr6yN/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=paeodH4vxfItiNrirxflWRw30fx7UuPEDXPnXpGx4O0=;
 b=J467XBYehFmnTa/zmcIEvJ0S7ihpmwaQmLMCv4cbxHguOUUScg1FKPmaYLB8rOd6GNzgy7elnQCHpKpqQvq+LMDG8MEQezuxuFs5XKbTd4kDpzhVtUnmdUreVbKnOKLkYHaQbvTci8fSXyz3V8mMZsKuZwe/0mC3sZZfAWc0G3hnVi+9IXSrlvfKmdkXe9O5eT6hx94HA+S1GXSAjgX9qBgoMBTZMGpEDR9b+Bxv0O8CSNaPxjNLxKaiMwuq+P6JenVSiGp2w5hI0gHLxdb0R/sNw5GGUNfCNJVThJxDCI1EpMDXzs2Mog2PGbZeeA6YvoxkuaJlaV0pIsL/VashDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=paeodH4vxfItiNrirxflWRw30fx7UuPEDXPnXpGx4O0=;
 b=fwYnO69/t0PaDlJiPxAP+GddrfO/jU+a6WUeGAp4DUGtwhEWa5CnR61xFMFDwXKp1edItSJblaIiYO/Rtp3uSJoHAPrbbyESOsS+vrO73VrpNO/hv8YHp4cw9DX2xdm1rTNmlSt1YZm40o801f4w6zzA1QYST183v4kXtq+TGxY=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB5356.namprd03.prod.outlook.com (2603:10b6:5:22b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Wed, 25 Mar
 2020 11:42:31 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 11:42:31 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: light: isl29125: fix
 iio_triggered_buffer_{predisable,postenable} positions
Thread-Topic: [PATCH] iio: light: isl29125: fix
 iio_triggered_buffer_{predisable,postenable} positions
Thread-Index: AQHV8f3por7q6sIx9UGzYXWLE5VEgahZUewA
Date:   Wed, 25 Mar 2020 11:42:31 +0000
Message-ID: <5ced40e32260e5e99ca37dcf8ecdc77b25eb5153.camel@analog.com>
References: <20200304082425.18600-1-alexandru.ardelean@analog.com>
In-Reply-To: <20200304082425.18600-1-alexandru.ardelean@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.26.73.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eb9f23d6-1183-46f6-a314-08d7d0b19a57
x-ms-traffictypediagnostic: DM6PR03MB5356:
x-microsoft-antispam-prvs: <DM6PR03MB535678A62E25B2C079E2C24CF9CE0@DM6PR03MB5356.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(396003)(366004)(136003)(6506007)(71200400001)(66556008)(66446008)(8936002)(2616005)(91956017)(66946007)(6486002)(76116006)(66476007)(64756008)(26005)(110136005)(2906002)(478600001)(54906003)(186003)(86362001)(6512007)(36756003)(4326008)(5660300002)(316002)(8676002)(81166006)(81156014)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB5356;H:DM6PR03MB4411.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8lBTPmDPdl+omQKMtdPu9gUfsCHkrz4y8BjEcbc3s2+AFhVFBezZxKQ5caqmgOU7hU5yzBGpQcqRHXwMXZPkFLSgL6D9Lt0eYUgycjT9rQv+qdMkBhoa5MWYiDJZNb8QpbXXyZ+1zgq6PT15emW7nAIsQtXQ2L6fbhndVVJZ3++ggxGE6Qk9lHZzKGtgCWIR/k4Hm1xq3RVZhMgMeIrA9ZXtRcFSzxZ5dMQMHT7ufC2TmRf0LlR4aDBAOPJpJh++vAVGkdhUTLGeiE7L1qTCRjT9wOVSzTnTBAkkG+U4kptjUl9JHyI4ZxNej/qsmT+CKszPwbMFN/ldRn/M7OzSPnVm24C/ARWSxfJh/qhvPnevdNY5XhLjy2MCGrymhZqugyo/bzVlrq3YDns0DIdB1l4kt7/LoPaSWWHTkmQAKBS4gNwh1nCxnriYm9xeYnX5EXJjODt8LnBO3KOfIOzwS2fXTuPHpMv585+DXqdiNOfj6t2ocPZgSLlUKoUuvdnE
x-ms-exchange-antispam-messagedata: nu3i1v69xCxXFQ/sQ2JyqxltimUMxeg1V7k7/0pTYIbAeGpqx7ZRpo7TJme6OJmdA+/BuoXazzZ16fIZ/IE/NJMQ+hq9Tx8GXf+UtXAJvk/IAp0uiJHwasT6aOeC3jRHVycnaS3mLJu+KOGw8FDQlw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C5BAB40F1033044A4C10A3A14D7D562@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb9f23d6-1183-46f6-a314-08d7d0b19a57
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 11:42:31.2558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B4J3z0Cli8RPnIL5ski/WyXlA+ve+ntHyJ3X6qFW9Zky8tFGeLWG9szvz3SxEZOxbHOWAoK++DFYPxnblO64krZQcyBw2uShD2vbib+Akyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5356
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-25_05:2020-03-24,2020-03-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003250101
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gV2VkLCAyMDIwLTAzLTA0IGF0IDEwOjI0ICswMjAwLCBBbGV4YW5kcnUgQXJkZWxlYW4gd3Jv
dGU6DQo+IFRoZSBpaW9fdHJpZ2dlcmVkX2J1ZmZlcl97cHJlZGlzYWJsZSxwb3N0ZW5hYmxlfSBm
dW5jdGlvbnMgYXR0YWNoL2RldGFjaA0KPiB0aGUgcG9sbCBmdW5jdGlvbnMuDQo+IA0KPiBGb3Ig
dGhlIHByZWRpc2FibGUgaG9vaywgdGhlIGRpc2FibGUgY29kZSBzaG91bGQgb2NjdXIgYmVmb3Jl
IGRldGFjaGluZw0KPiB0aGUgcG9sbCBmdW5jLCBhbmQgZm9yIHRoZSBwb3N0ZW5hYmxlIGhvb2ss
IHRoZSBwb2xsIGZ1bmMgc2hvdWxkIGJlDQo+IGF0dGFjaGVkIGJlZm9yZSB0aGUgZW5hYmxlIGNv
ZGUuDQo+IA0KPiBUaGlzIGNoYW5nZSByZXdvcmtzIHRoZSBwcmVkaXNhYmxlL3Bvc3RlbmFibGUg
aG9va3Mgc28gdGhhdCB0aGUgcG9sbGZ1bmMgaXMNCj4gYXR0YWNoZWQvZGV0YWNoZWQgaW4gdGhl
IGNvcnJlY3QgcG9zaXRpb24uDQo+IEl0IGFsc28gYmFsYW5jZXMgdGhlIGNhbGxzIGEgYml0LCBi
eSBncm91cGluZyB0aGUgcHJlZW5hYmxlIGFuZCB0aGUNCj4gaWlvX3RyaWdnZXJlZF9idWZmZXJf
cG9zdGVuYWJsZSgpIGludG8gYSBzaW5nbGUNCj4gaXNsMjkxMjVfYnVmZmVyX3Bvc3RlbmFibGUo
KSBmdW5jdGlvbi4NCg0KcGluZyBvbiB0aGlzIHBhdGNoDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+DQo+IC0t
LQ0KPiAgZHJpdmVycy9paW8vbGlnaHQvaXNsMjkxMjUuYyB8IDI4ICsrKysrKysrKysrKysrKysr
KystLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCA5IGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2xpZ2h0L2lzbDI5MTI1LmMg
Yi9kcml2ZXJzL2lpby9saWdodC9pc2wyOTEyNS5jDQo+IGluZGV4IGUzNzg5NGYwYWUwYi4uOTU2
MTFmNWVmZjAxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lpby9saWdodC9pc2wyOTEyNS5jDQo+
ICsrKyBiL2RyaXZlcnMvaWlvL2xpZ2h0L2lzbDI5MTI1LmMNCj4gQEAgLTIxMywxMyArMjEzLDI0
IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaWlvX2luZm8gaXNsMjkxMjVfaW5mbyA9IHsNCj4gIAku
YXR0cnMgPSAmaXNsMjkxMjVfYXR0cmlidXRlX2dyb3VwLA0KPiAgfTsNCj4gIA0KPiAtc3RhdGlj
IGludCBpc2wyOTEyNV9idWZmZXJfcHJlZW5hYmxlKHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYp
DQo+ICtzdGF0aWMgaW50IGlzbDI5MTI1X2J1ZmZlcl9wb3N0ZW5hYmxlKHN0cnVjdCBpaW9fZGV2
ICppbmRpb19kZXYpDQo+ICB7DQo+ICAJc3RydWN0IGlzbDI5MTI1X2RhdGEgKmRhdGEgPSBpaW9f
cHJpdihpbmRpb19kZXYpOw0KPiArCWludCBlcnI7DQo+ICsNCj4gKwllcnIgPSBpaW9fdHJpZ2dl
cmVkX2J1ZmZlcl9wb3N0ZW5hYmxlKGluZGlvX2Rldik7DQo+ICsJaWYgKGVycikNCj4gKwkJcmV0
dXJuIGVycjsNCj4gIA0KPiAgCWRhdGEtPmNvbmYxIHw9IElTTDI5MTI1X01PREVfUkdCOw0KPiAt
CXJldHVybiBpMmNfc21idXNfd3JpdGVfYnl0ZV9kYXRhKGRhdGEtPmNsaWVudCwgSVNMMjkxMjVf
Q09ORjEsDQo+ICsJZXJyID0gaTJjX3NtYnVzX3dyaXRlX2J5dGVfZGF0YShkYXRhLT5jbGllbnQs
IElTTDI5MTI1X0NPTkYxLA0KPiAgCQlkYXRhLT5jb25mMSk7DQo+ICsJaWYgKGVycikgew0KPiAr
CQlpaW9fdHJpZ2dlcmVkX2J1ZmZlcl9wcmVkaXNhYmxlKGluZGlvX2Rldik7DQo+ICsJCXJldHVy
biBlcnI7DQo+ICsJfQ0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICB9DQo+ICANCj4gIHN0YXRpYyBp
bnQgaXNsMjkxMjVfYnVmZmVyX3ByZWRpc2FibGUoc3RydWN0IGlpb19kZXYgKmluZGlvX2RldikN
Cj4gQEAgLTIyNywxOSArMjM4LDE4IEBAIHN0YXRpYyBpbnQgaXNsMjkxMjVfYnVmZmVyX3ByZWRp
c2FibGUoc3RydWN0IGlpb19kZXYNCj4gKmluZGlvX2RldikNCj4gIAlzdHJ1Y3QgaXNsMjkxMjVf
ZGF0YSAqZGF0YSA9IGlpb19wcml2KGluZGlvX2Rldik7DQo+ICAJaW50IHJldDsNCj4gIA0KPiAt
CXJldCA9IGlpb190cmlnZ2VyZWRfYnVmZmVyX3ByZWRpc2FibGUoaW5kaW9fZGV2KTsNCj4gLQlp
ZiAocmV0IDwgMCkNCj4gLQkJcmV0dXJuIHJldDsNCj4gLQ0KPiAgCWRhdGEtPmNvbmYxICY9IH5J
U0wyOTEyNV9NT0RFX01BU0s7DQo+ICAJZGF0YS0+Y29uZjEgfD0gSVNMMjkxMjVfTU9ERV9QRDsN
Cj4gLQlyZXR1cm4gaTJjX3NtYnVzX3dyaXRlX2J5dGVfZGF0YShkYXRhLT5jbGllbnQsIElTTDI5
MTI1X0NPTkYxLA0KPiArCXJldCA9IGkyY19zbWJ1c193cml0ZV9ieXRlX2RhdGEoZGF0YS0+Y2xp
ZW50LCBJU0wyOTEyNV9DT05GMSwNCj4gIAkJZGF0YS0+Y29uZjEpOw0KPiArDQo+ICsJaWlvX3Ry
aWdnZXJlZF9idWZmZXJfcHJlZGlzYWJsZShpbmRpb19kZXYpOw0KPiArDQo+ICsJcmV0dXJuIHJl
dDsNCj4gIH0NCj4gIA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBpaW9fYnVmZmVyX3NldHVwX29w
cyBpc2wyOTEyNV9idWZmZXJfc2V0dXBfb3BzID0gew0KPiAtCS5wcmVlbmFibGUgPSBpc2wyOTEy
NV9idWZmZXJfcHJlZW5hYmxlLA0KPiAtCS5wb3N0ZW5hYmxlID0gJmlpb190cmlnZ2VyZWRfYnVm
ZmVyX3Bvc3RlbmFibGUsDQo+ICsJLnBvc3RlbmFibGUgPSBpc2wyOTEyNV9idWZmZXJfcG9zdGVu
YWJsZSwNCj4gIAkucHJlZGlzYWJsZSA9IGlzbDI5MTI1X2J1ZmZlcl9wcmVkaXNhYmxlLA0KPiAg
fTsNCj4gIA0K
