Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFA018C7ED
	for <lists+linux-iio@lfdr.de>; Fri, 20 Mar 2020 08:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgCTHEv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Mar 2020 03:04:51 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:29422 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725802AbgCTHEv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Mar 2020 03:04:51 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02K70a0r008539;
        Fri, 20 Mar 2020 03:02:31 -0400
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by mx0b-00128a01.pphosted.com with ESMTP id 2yu88ss51f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Mar 2020 03:02:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DbL5p3keEdUK9nkM1DAhcuLo6B8tozf3ihldkxVS9rUktvpTJqBB9OhmbqfwoK4NdbuKR7C8aiBukJKzDl9kJYrznUhPYaS3p5i9lB8IYBgtZWiaEO42dEl8KCSHHAQ+o+yC/75lNg/CwLgDsuZ2O4UTcW9jsJ07GhTfqUyyDZ4SkfAbsK7Vu/bopQFFDcWePHhhSts6nQzGFMROepxTVK9eClCXSTSVfRFpOs7xjRDI7UBhKbzaWCZpUDn3URGUGGljnhIibnNmAgxAl4Sn8Gu/DdivGKx6e+5MQ1ivEmxLUbwsPNA317NEl8orVHSXtDsrW8O9rSuhskMvHDfwWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPcKjTfoSVN8w33tBDoXgdkd0JakfBdiQVgjb2K3428=;
 b=CKN4twHZBHnXY0lWm6oA5PudE4NwamU4vCCPQdIneVSzkIvZNzEOM4CyLQYgaZdLYAx4YlGUB2T+TTHe1PmHS2J8pIyMkEPYW261RhsunPDVVHmw7O3fEpIORTEwy5NOlKaouXDi+WafwLew3iZFnRLr2f4xr/4cWxMp+K5brO/f+2T/qeHYNTMwZXJBIbcGmMNMZ31LYTnfACC6w2b19/DR8WfvPGdt2zwpWjUUR9ftDhYx5ZEXQzZuafYUn/wBnIMsBAw0gEeWhnA+0TPUywbsPQL7S16jajbj3y8MzwjunbkuCfE6IANTPl7z+m+U8rDKjK5n8Eq1KeAOMo2KfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPcKjTfoSVN8w33tBDoXgdkd0JakfBdiQVgjb2K3428=;
 b=50mf+anpb4HcqP1Z4rgOVDFK1hQUYd+2CRZlOrs7umNXx6fbQDF5lBLzVo80FL2SQsX2IOS7OQSVpuEzHi2ge+8qjUPZebhqFf8AA2Ahpzz1a5BbFByxWGBXMwzU8PZnVe9rWTn4uX7O9/lafh+0N+DNcFuHPfyKFy9KcrEerQE=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB3547.namprd03.prod.outlook.com (2603:10b6:5:aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.19; Fri, 20 Mar
 2020 07:02:29 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2814.025; Fri, 20 Mar 2020
 07:02:29 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "alazar@startmail.com" <alazar@startmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH v3 0/2] Maxim MAX1241 driver
Thread-Topic: [PATCH v3 0/2] Maxim MAX1241 driver
Thread-Index: AQHV/gr8Nf7m8NULCU68qWj0b/BbY6hRD+SA
Date:   Fri, 20 Mar 2020 07:02:29 +0000
Message-ID: <5a82cd15222a7c3ede4cad6977bbd9845c82d28a.camel@analog.com>
References: <20200319162937.34664-1-alazar@startmail.com>
In-Reply-To: <20200319162937.34664-1-alazar@startmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.26.73.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 84034b56-b6cc-4412-d448-08d7cc9ca7a8
x-ms-traffictypediagnostic: DM6PR03MB3547:
x-microsoft-antispam-prvs: <DM6PR03MB3547AF2E13470C2A5C45FCAAF9F50@DM6PR03MB3547.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03484C0ABF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(136003)(39860400002)(376002)(396003)(199004)(86362001)(2906002)(110136005)(8676002)(316002)(2616005)(81166006)(81156014)(71200400001)(54906003)(8936002)(6486002)(186003)(478600001)(66946007)(6506007)(36756003)(91956017)(76116006)(966005)(4326008)(26005)(6512007)(66556008)(66446008)(5660300002)(66476007)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB3547;H:DM6PR03MB4411.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mOoGCfSLe00kR1PUFT1pZUHiE8T4RLCzOl8N8QnC0L71FiAu04JX2YW9i4UeHcqurD2ZNcTNducrk1nBAPW7j6wuuVHpjgKatjOFEBnw4xmMgdlR/GMwLCHD0Qx5y4X6JHRvD4x3fIbSVsS56aK56tXK/yRQc3s8wlR7/hvmOxurohL4GdS/WpbAI26UsVlv3jsuekH0PG5j8y1C4194qNj2INEQA33WQH/6FMgGimLOewjNZQzzfJ4kWwvELBpZyGdppPMIYKCXbeVW5FCuDpqr1tuPrXtByU5BTsK0jEvju+k5qnmnMrSiOaP3XMm+UZRzu4Uvy8CI+e8S95UnhUuAE0YaxZBMsr4JT/muVnZHdf771Iv291gIPQSWLLdvbaMhGBSwCUujgIbCd4/72o9ksnpNPIzsJGO9WKMdfODcMOGmyOCl8wscJg/o7ZkKQDfuHq7024EFGj3R6k9ykZrhwGqv0ufvMGXUwi3ADQqpVoKwiaFS2EZOdBzy92Gs7/MniPJ4Gbx1LgCaovHcng==
x-ms-exchange-antispam-messagedata: sjVuEF5xsVpXnxkhHKfFPWMzKJXeDPkJVNwmZlAQEYxs9+LzclQNphonWhzAvRmDamJDyv+bL1G9SLGkei7L4yr/pAU8kiYVkdEULEj2Kg40gY7bpCic/EbgUPkZL3f1WCH3ZRewpOMIhEuQyDQtqg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F8F65E161343464C80500717C8B46532@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84034b56-b6cc-4412-d448-08d7cc9ca7a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2020 07:02:29.4529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sNWQOrH7pKaH+5oorAobJUUynZZ2NV4T4C9S+M6NwwMbzxpsVaU0rnt2f8Qmg1Y33IGF9L/v6EsdfqUI7nX+nOOUez4/ZbPbl6DYmf7CHr4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3547
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-20_01:2020-03-19,2020-03-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003200030
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVGh1LCAyMDIwLTAzLTE5IGF0IDE4OjI5ICswMjAwLCBBbGV4YW5kcnUgTGF6YXIgd3JvdGU6
DQo+IEEgc2lsbHkgdHlwbyBmb3VuZCBpdHMgd2F5IGludG8gdGhlIHByZXZpb3VzIHZlcnNpb24g
b2YgdGhpcyBwYXRjaA0KPiBzZXJpZXMuIEZvcnR1bmF0ZWx5LCBBbGV4YW5kcnUgQXJkZWxlYW4g
c3BvdHRlZCBpdC4gSSdtIGEgbGl0dGxlDQo+IGVtYmFycmFzc2VkIHRvIHNob3cgbXkgZmFjZSBp
biBwdWJsaWMgcmlnaHQgbm93IC0tIHRoYW5rZnVsbHkgSSdtDQo+IHN0YXlpbmcgaG9tZSB0aGVz
ZSBkYXlzIGFueXdheS4NCg0KSSBzdGlsbCB3aW4gaW4gZW1iYXJyYXNzbWVudCBbZ2V0dGluZyBl
bWJhcnJhc3NlZF0gY29udGVzdHMuDQoNCj4gDQo+IE90aGVyIHRoYW4gdGhlIEtjb25maWcgdGV4
dCAod2hpY2ggY2xhaW1lZCB0aGlzIG1vZHVsZSB3YXMgbmFtZWQgbWF4MTExOA0KPiAtLSBsaWtl
IEkgc2FpZCwgSSB3ZWFyIG15IGNvZGUgbW9ua2V5IGJhZGdlIHdpdGggcHJpZGUuLi4pIG5vdGhp
bmcncw0KPiBjaGFuZ2VkIHNpbmNlIHRoZSBsYXN0IHZlcnNpb24uIEZvciByZWZlcmVuY2UsIHRo
ZSBsYXN0IHZlcnNpb24gaXMgaGVyZToNCj4gDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xp
bnV4LWlpby8yMDIwMDMxODIwMjgzNy41MTI0MjgtMS1hbGF6YXJAc3RhcnRtYWlsLmNvbS8NCj4g
DQoNCkZvciBmdXR1cmUgcGF0Y2hlczogaXQncyB1c3VhbGx5IGEgZ29vZCBpZGVhIHRvIGluY2x1
ZGUgY2hhbmdlbG9nIGluIGVhY2gNClYyLDMsNCxODQoNCkV4YW1wbGU6IA0KaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvbGludXgtaWlvLzIwMjAwMzE2MTU1MDM1LjI1NTAwLTEtYWxleGFuZHJ1LmFy
ZGVsZWFuQGFuYWxvZy5jb20vVC8NCg0KW3RoaXMgb25lIFtvZiBtaW5lXSBnb3QgdXAtdG8gVjEw
IDpwIDsgSSdsbCBhZG1pdCBJIGRpZG4ndCBkbyBhIGdvb2Qgam9iIHJpZ2h0DQpmcm9tIHRoZSBz
dGFydF0NCg0KPiBUaGFua3MhDQo+IA0KPiBBbGV4DQo+IA0KPiBBbGV4YW5kcnUgTGF6YXIgKDIp
Og0KPiAgIGlpbzogYWRjOiBBZGQgTUFYMTI0MSBkcml2ZXINCj4gICBkdC1iaW5kaW5nczogaWlv
OiBhZGM6IEFkZCBNQVgxMjQxIGRldmljZSB0cmVlIGJpbmRpbmdzIGluDQo+ICAgICBkb2N1bWVu
dGF0aW9uDQo+IA0KPiAgLi4uL2JpbmRpbmdzL2lpby9hZGMvbWF4aW0sbWF4MTI0MS55YW1sICAg
ICAgIHwgIDYyICsrKysrKw0KPiAgZHJpdmVycy9paW8vYWRjL0tjb25maWcgICAgICAgICAgICAg
ICAgICAgICAgIHwgIDEwICsNCj4gIGRyaXZlcnMvaWlvL2FkYy9NYWtlZmlsZSAgICAgICAgICAg
ICAgICAgICAgICB8ICAgMSArDQo+ICBkcml2ZXJzL2lpby9hZGMvbWF4MTI0MS5jICAgICAgICAg
ICAgICAgICAgICAgfCAyMDYgKysrKysrKysrKysrKysrKysrDQo+ICA0IGZpbGVzIGNoYW5nZWQs
IDI3OSBpbnNlcnRpb25zKCspDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9hZGMvbWF4aW0sbWF4MTI0MS55YW1sDQo+ICBjcmVh
dGUgbW9kZSAxMDA2NDQgZHJpdmVycy9paW8vYWRjL21heDEyNDEuYw0KPiANCg==
