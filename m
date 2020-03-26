Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBD81193AB5
	for <lists+linux-iio@lfdr.de>; Thu, 26 Mar 2020 09:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgCZIVU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Mar 2020 04:21:20 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:23252 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726298AbgCZIVT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Mar 2020 04:21:19 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02Q8JP9k029819;
        Thu, 26 Mar 2020 04:20:56 -0400
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ywcs68b8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Mar 2020 04:20:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/u+h4ve2fQW2uBc6y2+TbDsKXQsKQUQyVce/wX3y1tB9HH9RqI8lbDZA+2h5ZI8Ruw7s3f4QPC+cz7B8GKkCNsGnMLnl4Fj3JB3ErjsesZfyuwAQ6SxDJ8jJnl5SuLgV5rOWZ5Mek6lUEHsZGzG/h2ZmyxavDZDud7Pu85jKLMfQlYl6UKOXKexRBdPCy0MDV20O2OunK8G7DLD8/5HUzGLjcHc3DNiCSoqg106AeptlThncXt/bsGnlDKBcGcdg8iuYFFerHndfE+PIi9bww/XPQUQXHJe96+1jYqbULmW4hmm3ekyJZev4IQNbJWy2Q3hb3fBY1cFf028Yff19A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0MLdikgKuNmvliggHl/vdv8XRLxlE49QvE8GRyO2QDU=;
 b=l47t+rRi/vIRkWRhcBwPxppmPlVXt064ErDg7zLBrRRQeIeWp7vXbn5oSpTst9UxAF8hgJlB8S4h0LlBwQxdSy57JTPrcFmnMnGBy+OfGH7QKIZ831fKsCrgeeD/oQbrmDwOLilnM3Y7rAQqgzAxuJB/PZku7Mvr04hxWVUKC/F+09llNcviErDNnc/EZrIbJzevFpQ2u3QSSj8mEq6LvEMAz6XtoDli2EKp72COGFlLjucW4831HdIbQP8czku95wWPgmsNS92BvDxBvikAgT3LVwgfuxO+HvckClIOYuFecWyDTmMqF6eVPvycT2r0Jflhgj2vFiTXTpXVjwG1DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0MLdikgKuNmvliggHl/vdv8XRLxlE49QvE8GRyO2QDU=;
 b=BJBYPalk7OjdRI6kTkPrkTW9zBcZRFWPK5Sa8eyXMwWYOY3w2SwT+oXms7vs4AAJgxrO62TaHAasnD7tmIi+X5wZ8uTC2HVBrGYzdYO2llbob5ZBLu19KKmP5C0le2tCwkDmLK9xWezP7mMhJAiaohgCAt2iQ4wmCWTU7uPt1b4=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4746.namprd03.prod.outlook.com (2603:10b6:5:18b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Thu, 26 Mar
 2020 08:20:53 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2856.019; Thu, 26 Mar 2020
 08:20:53 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "mh12gx2825@gmail.com" <mh12gx2825@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "outreachy-kernel@googlegroups.com" 
        <outreachy-kernel@googlegroups.com>,
        "kieran.bingham@ideasonboard.com" <kieran.bingham@ideasonboard.com>,
        "daniel.baluta@gmail.com" <daniel.baluta@gmail.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
Subject: Re: [PATCH v3 2/4] staging: iio: adc: ad7192: Correct macro names
 from SYNC to SINC
Thread-Topic: [PATCH v3 2/4] staging: iio: adc: ad7192: Correct macro names
 from SYNC to SINC
Thread-Index: AQHWAIPWdNjC6a8Q90u08HIcfB7EiahajuCA
Date:   Thu, 26 Mar 2020 08:20:53 +0000
Message-ID: <723d7898f5e011c33a9f8eef3d1c29cc41ba2fea.camel@analog.com>
References: <cover.1584904896.git.mh12gx2825@gmail.com>
         <a5aea6836da9aa2f950449225892ee18f10e217c.1584904896.git.mh12gx2825@gmail.com>
In-Reply-To: <a5aea6836da9aa2f950449225892ee18f10e217c.1584904896.git.mh12gx2825@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.26.73.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8e4f3be5-bb43-4610-d472-08d7d15e99f8
x-ms-traffictypediagnostic: DM6PR03MB4746:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB474601FD0ABA66C11F06CF17F9CF0@DM6PR03MB4746.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0354B4BED2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(376002)(39860400002)(136003)(2616005)(36756003)(8676002)(26005)(81156014)(8936002)(6486002)(81166006)(4326008)(2906002)(6512007)(186003)(110136005)(6506007)(478600001)(316002)(66556008)(66446008)(5660300002)(7416002)(54906003)(64756008)(86362001)(66946007)(76116006)(91956017)(71200400001)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB4746;H:DM6PR03MB4411.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9oUk7jGkml3ITlmRVOUCWQ3p8GIEhgQrFFKkwCKycTFVOdmtc34RhkwIefM+w82nJdoIQHnD15Md8eFwR4Lg8iH8ibmEH+UPMA+Ee4FFxAnxuGnb/L0p1dbP1p10cxkzBQ5k3mn+Im8YhbBpk5i/Qs6KYCBJt+ccpRnSu21fVKqS7AdFxMBzuUJaVhQYtIcTNi4YYIWEcxWglh/o7s39kscqRB+dlGt9/zvXm/gXJ0Mdk69Up5re/crsST4SsJYmPIedvogQHYD+tLzF1rkXL8BApuLynRg1kEi3xBPQSbc0NwppH/dcdFwLirHtMy+n1PiqkjYL5hh4h9JIUoF2D48vUtsef+xxBYHFHNLr9kveTvniOPlQO4ZKbm9h2FNHgACQkUBY2sQ75jmmv0L/QPPqr2G9I+HAtAmYk6ZIqGOw4MAgldvRH6ksulhdL7Ns
x-ms-exchange-antispam-messagedata: vIUdULUDL+K8BhEb4Js1e4zOgHbZa+zeqWzOEupuZYoeDdI9VCKxKVWbO9OfySI2EFb2yM/t6W8VPCq0j4Pp6syQnvz6S0c5CIs1wb4Rn8bPULy9B03Rd+5p8dPMOIAEcCi3wcBENExY1OX65FwCYg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <87D4DB3938E30B4F99D92AC4479BA3DC@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e4f3be5-bb43-4610-d472-08d7d15e99f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2020 08:20:53.5957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VuQHm5Zbs5fSs5tWebcNQ9kjr3NA+i3PaH4Deg0KuDN2v8B39XiWVwkqZSNLphJJnpok1B+qAPNttZ3FlNidR1f6Am8BC9tgOs06EvTlZDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4746
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-25_15:2020-03-24,2020-03-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003260060
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gTW9uLCAyMDIwLTAzLTIzIGF0IDAxOjI1ICswNTMwLCBEZWVwYWsgUiBWYXJtYSB3cm90ZToN
Cj4gW0V4dGVybmFsXQ0KPiANCj4gVGhyZWUgbWFjcm9zIGluY2x1ZGUgU1lOQyBpbiB0aGVpciBu
YW1lcyB3aGljaCBpcyBhIHR5cG8uIFVwZGF0ZSB0aG9zZQ0KPiBuYW1lcyB0byBTSU5DLg0KPiBG
aXhlczogNzdmNmEyMzA5MmMwICgic3RhZ2luZzogaWlvOiBhZGM6IGFkNzE5MjogQWRkDQo+IGxv
d19wYXNzXzNkYl9maWx0ZXJfZnJlcXVlbmN5IikNCg0KeW91IGNhbiBrZWVwIHRoZSBjb21taXQg
ZGVzY3JpcHRpb24gYXMgbG9uZyBhcyBpdCBuZWVkcyB0byBiZTsgbm8gbmVlZCB0byB3cmFwDQpp
dDsgDQoNCj4gDQoNCm90aGVyIHRoYW4gdGhhdDoNCg0KUmV2aWV3ZWQtYnk6IEFsZXhhbmRydSBB
cmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+DQoNCj4gU2lnbmVkLW9mZi1i
eTogRGVlcGFrIFIgVmFybWEgPG1oMTJneDI4MjVAZ21haWwuY29tPg0KPiBTdWdnZXN0ZWQtYnk6
IExhcnMtUGV0ZXIgQ2xhdXNlbiA8bGFyc0BtZXRhZm9vLmRlPg0KPiANCj4gLS0tDQo+IA0KPiBD
aGFuZ2VzIHNpbmNlIHYyOg0KPiAJLSBOb25lLiBWZXJzaW9uIGluY3JlbWVudCB0byBmb2xsb3cg
cGF0Y2ggc2VyaWVzIHZlcnNpb25pbmcuDQo+IA0KPiBDaGFuZ2VzIHNpbmNlIHYxOg0KPiAJLSBO
b25lLiBQYXRjaCBhZGRlZCBpbiB2MiB2ZXJzaW9uIGFzIHN1Z2dlc3RlZCBieSBTdGVmYW5vLg0K
PiANCj4gDQo+ICBkcml2ZXJzL2lpby9hZGMvYWQ3MTkyLmMgfCAyMCArKysrKysrKysrLS0tLS0t
LS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2FkYy9hZDcxOTIuYyBiL2RyaXZlcnMv
aWlvL2FkYy9hZDcxOTIuYw0KPiBpbmRleCAwMjk4MWYzZDE3OTQuLmQ5YTIyMGQ0MjE3ZiAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9paW8vYWRjL2FkNzE5Mi5jDQo+ICsrKyBiL2RyaXZlcnMvaWlv
L2FkYy9hZDcxOTIuYw0KPiBAQCAtMTQ0LDkgKzE0NCw5IEBADQo+ICAjZGVmaW5lIEFENzE5Ml9F
WFRfRlJFUV9NSFpfTUFYCTUxMjAwMDANCj4gICNkZWZpbmUgQUQ3MTkyX0lOVF9GUkVRX01IWgk0
OTE1MjAwDQo+ICANCj4gLSNkZWZpbmUgQUQ3MTkyX05PX1NZTkNfRklMVEVSCTENCj4gLSNkZWZp
bmUgQUQ3MTkyX1NZTkMzX0ZJTFRFUgkzDQo+IC0jZGVmaW5lIEFENzE5Ml9TWU5DNF9GSUxURVIJ
NA0KPiArI2RlZmluZSBBRDcxOTJfTk9fU0lOQ19GSUxURVIJMQ0KPiArI2RlZmluZSBBRDcxOTJf
U0lOQzNfRklMVEVSCTMNCj4gKyNkZWZpbmUgQUQ3MTkyX1NJTkM0X0ZJTFRFUgk0DQo+ICANCj4g
IC8qIE5PVEU6DQo+ICAgKiBUaGUgQUQ3MTkwLzIvNSBmZWF0dXJlcyBhIGR1YWwgdXNlIGRhdGEg
b3V0IHJlYWR5IERPVVQvUkRZIG91dHB1dC4NCj4gQEAgLTM2Nyw3ICszNjcsNyBAQCBzdGF0aWMg
aW50IGFkNzE5Ml9zZXR1cChzdHJ1Y3QgYWQ3MTkyX3N0YXRlICpzdCwgc3RydWN0DQo+IGRldmlj
ZV9ub2RlICpucCkNCj4gIAkJc3QtPmNvbmYgfD0gQUQ3MTkyX0NPTkZfUkVGU0VMOw0KPiAgDQo+
ICAJc3QtPmNvbmYgJj0gfkFENzE5Ml9DT05GX0NIT1A7DQo+IC0Jc3QtPmZfb3JkZXIgPSBBRDcx
OTJfTk9fU1lOQ19GSUxURVI7DQo+ICsJc3QtPmZfb3JkZXIgPSBBRDcxOTJfTk9fU0lOQ19GSUxU
RVI7DQo+ICANCj4gIAlidWZfZW4gPSBvZl9wcm9wZXJ0eV9yZWFkX2Jvb2wobnAsICJhZGksYnVm
ZmVyLWVuYWJsZSIpOw0KPiAgCWlmIChidWZfZW4pDQo+IEBAIC00ODQsMTEgKzQ4NCwxMSBAQCBz
dGF0aWMgdm9pZCBhZDcxOTJfZ2V0X2F2YWlsYWJsZV9maWx0ZXJfZnJlcShzdHJ1Y3QNCj4gYWQ3
MTkyX3N0YXRlICpzdCwNCj4gIA0KPiAgCS8qIEZvcm11bGFzIGZvciBmaWx0ZXIgYXQgcGFnZSAy
NSBvZiB0aGUgZGF0YXNoZWV0ICovDQo+ICAJZmFkYyA9IERJVl9ST1VORF9DTE9TRVNUKHN0LT5m
Y2xrLA0KPiAtCQkJCSBBRDcxOTJfU1lOQzRfRklMVEVSICogQUQ3MTkyX01PREVfUkFURShzdC0N
Cj4gPm1vZGUpKTsNCj4gKwkJCQkgQUQ3MTkyX1NJTkM0X0ZJTFRFUiAqIEFENzE5Ml9NT0RFX1JB
VEUoc3QtDQo+ID5tb2RlKSk7DQo+ICAJZnJlcVswXSA9IERJVl9ST1VORF9DTE9TRVNUKGZhZGMg
KiAyNDAsIDEwMjQpOw0KPiAgDQo+ICAJZmFkYyA9IERJVl9ST1VORF9DTE9TRVNUKHN0LT5mY2xr
LA0KPiAtCQkJCSBBRDcxOTJfU1lOQzNfRklMVEVSICogQUQ3MTkyX01PREVfUkFURShzdC0NCj4g
Pm1vZGUpKTsNCj4gKwkJCQkgQUQ3MTkyX1NJTkMzX0ZJTFRFUiAqIEFENzE5Ml9NT0RFX1JBVEUo
c3QtDQo+ID5tb2RlKSk7DQo+ICAJZnJlcVsxXSA9IERJVl9ST1VORF9DTE9TRVNUKGZhZGMgKiAy
NDAsIDEwMjQpOw0KPiAgDQo+ICAJZmFkYyA9IERJVl9ST1VORF9DTE9TRVNUKHN0LT5mY2xrLCBB
RDcxOTJfTU9ERV9SQVRFKHN0LT5tb2RlKSk7DQo+IEBAIC01NzYsMjUgKzU3NiwyNSBAQCBzdGF0
aWMgaW50IGFkNzE5Ml9zZXRfM2RiX2ZpbHRlcl9mcmVxKHN0cnVjdA0KPiBhZDcxOTJfc3RhdGUg
KnN0LA0KPiAgDQo+ICAJc3dpdGNoIChpZHgpIHsNCj4gIAljYXNlIDA6DQo+IC0JCXN0LT5mX29y
ZGVyID0gQUQ3MTkyX1NZTkM0X0ZJTFRFUjsNCj4gKwkJc3QtPmZfb3JkZXIgPSBBRDcxOTJfU0lO
QzRfRklMVEVSOw0KPiAgCQlzdC0+bW9kZSAmPSB+QUQ3MTkyX01PREVfU0lOQzM7DQo+ICANCj4g
IAkJc3QtPmNvbmYgfD0gQUQ3MTkyX0NPTkZfQ0hPUDsNCj4gIAkJYnJlYWs7DQo+ICAJY2FzZSAx
Og0KPiAtCQlzdC0+Zl9vcmRlciA9IEFENzE5Ml9TWU5DM19GSUxURVI7DQo+ICsJCXN0LT5mX29y
ZGVyID0gQUQ3MTkyX1NJTkMzX0ZJTFRFUjsNCj4gIAkJc3QtPm1vZGUgfD0gQUQ3MTkyX01PREVf
U0lOQzM7DQo+ICANCj4gIAkJc3QtPmNvbmYgfD0gQUQ3MTkyX0NPTkZfQ0hPUDsNCj4gIAkJYnJl
YWs7DQo+ICAJY2FzZSAyOg0KPiAtCQlzdC0+Zl9vcmRlciA9IEFENzE5Ml9OT19TWU5DX0ZJTFRF
UjsNCj4gKwkJc3QtPmZfb3JkZXIgPSBBRDcxOTJfTk9fU0lOQ19GSUxURVI7DQo+ICAJCXN0LT5t
b2RlICY9IH5BRDcxOTJfTU9ERV9TSU5DMzsNCj4gIA0KPiAgCQlzdC0+Y29uZiAmPSB+QUQ3MTky
X0NPTkZfQ0hPUDsNCj4gIAkJYnJlYWs7DQo+ICAJY2FzZSAzOg0KPiAtCQlzdC0+Zl9vcmRlciA9
IEFENzE5Ml9OT19TWU5DX0ZJTFRFUjsNCj4gKwkJc3QtPmZfb3JkZXIgPSBBRDcxOTJfTk9fU0lO
Q19GSUxURVI7DQo+ICAJCXN0LT5tb2RlIHw9IEFENzE5Ml9NT0RFX1NJTkMzOw0KPiAgDQo+ICAJ
CXN0LT5jb25mICY9IH5BRDcxOTJfQ09ORl9DSE9QOw0K
