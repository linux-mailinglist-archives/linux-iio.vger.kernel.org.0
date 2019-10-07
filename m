Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA176CDF1A
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2019 12:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbfJGKVn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Oct 2019 06:21:43 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:43012 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727262AbfJGKVn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Oct 2019 06:21:43 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x97AHh1E013111;
        Mon, 7 Oct 2019 06:21:18 -0400
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp2059.outbound.protection.outlook.com [104.47.49.59])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ven19qb35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Oct 2019 06:21:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sx4VCatAZeWcqzCKDoWl+9BGSCacLmWWNvX8XpvLSup56wZrODGtp5M9zzViyeCIboFsMZ1OsT2rk02cY8MqUxcg3FprF5P6vX0pPK+2mJvuhc5ah7tn0SlZiO1sHUP6RZ1Tdg9tY7BHEgwx/wf/jzvUSIdKEoFmbXvWsMMhNcVwWzKrq988hkMfMxHLvl00kxNH3lYldxDJorpcsjQLRPTQUeNlyLx0pTILZBQwngoaAyTzZgk9mLkL8Djp2DdvTrkAjU3trLDYJA1dIl4JXxTmRMoe0YvAXsOWOOGIyF1kFdnjsxaDa9Lsx/+0mfk8iwuXivZGluitbrn2QInCRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KV8frnN+FdI5bmyrJx5s+oE0CfCPOTLSPd6g60n8ABk=;
 b=cYupFWCxwnbnlMt4LejYXnAL1vJ0dDtYxa7F2voaRts3VTfsIcCurnP8tb1aI9MOwxaABUZylDZUTcuwPI9DwlCcFFg954hTKoRk2UkcyQev47WF8DTfyPUtwXZUiPfAAkVPs3AsPQKWQSYJssaK1MQeJNJHEyVDeeWnJJzCZKYtOzfgZulJDslCjdwsC9Vv5liwyqSGJViUhKSLx/KE42FARHXsHX2IM/nEaUK3MbRv47jCujFGGOnCPVZUHThvgWJmojBknOz6dqUJBZeeAvG+plpliuma2ZtTnctuvJvqR17/UuG4C06j2Xby/59H3T5BFBlaD81Be9b8AcRP4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KV8frnN+FdI5bmyrJx5s+oE0CfCPOTLSPd6g60n8ABk=;
 b=1CXg9d65SBZwS3L5yCJrSoOe1DHxMaKtM5Chdea5NV6b+i90wV4X6rqO3AoItMO62IDvBFYC57AeLEeSZJyxJ9+Asp2K6b8y72tvPbfGC1SARB+jJw/Sv7NoFDLFL0jQpmnH0smHErR4JD+AywQMnOfyNZw/kO5n2yNMTS0kj34=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5157.namprd03.prod.outlook.com (20.180.15.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Mon, 7 Oct 2019 10:21:16 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b%3]) with mapi id 15.20.2305.023; Mon, 7 Oct 2019
 10:21:16 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: light: Add binding for ADUX1020
Thread-Topic: [PATCH 1/2] dt-bindings: iio: light: Add binding for ADUX1020
Thread-Index: AQHVfPeSWEuDjz9rbUuvJ/9gUHtP1adO+AOA
Date:   Mon, 7 Oct 2019 10:21:16 +0000
Message-ID: <a60fb9ea8922c1eb532e0b7ef0a69abcc9306255.camel@analog.com>
References: <20191007101027.8383-1-manivannan.sadhasivam@linaro.org>
         <20191007101027.8383-2-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20191007101027.8383-2-manivannan.sadhasivam@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e2eeb7b2-0904-4e35-22bc-08d74b10169b
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: CH2PR03MB5157:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB51574FA68E4D7A746878102CF99B0@CH2PR03MB5157.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01834E39B7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(366004)(39860400002)(346002)(189003)(199004)(51914003)(229853002)(6486002)(14454004)(6436002)(6116002)(8936002)(2906002)(966005)(478600001)(3846002)(6306002)(6512007)(76176011)(66446008)(64756008)(66556008)(81166006)(8676002)(99286004)(81156014)(110136005)(54906003)(25786009)(316002)(256004)(6246003)(66476007)(66946007)(76116006)(186003)(4326008)(118296001)(7736002)(102836004)(305945005)(86362001)(71200400001)(71190400001)(26005)(66066001)(36756003)(446003)(11346002)(476003)(486006)(2616005)(6506007)(5660300002)(2501003)(2201001);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5157;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pADhzkJUvxQIUbPPI0BWg8Bel121m6+1yPh+yt3s/youiNrG4Tm/OhkkSy3xb0g6/prtfxlWOwXO4OsYqrjpon4eqYX3L0FRY7PwBjAClJdjQqiDQL7dfc8bRrNWNnaYOKcZxIcVcZIDIEsO4WAN3Xp14spD4KgZ4W57vjMgUZ8uqHQtTCLJYljQUkhvUhDyyLv3KkwyqT1EzXVeHTDaTm2/1CTRZN5SHy7Vg0ALdp21kaUht7MUK+2U1iLWXiOeJWg1plqoB3sFwuIcXi/06Z/Hex5tyaRJEuIDwSSV5rgmPanRLFoitRDCC31Xi6HkuMxAC8JLgJ4wgZxb1b5jmp06f9MHnmSmakq3UO8L9AxMNhmc7Gvbt8hOmBpNxRsiPIgEx7Bj8bAINK5gyco5ksr5Zpi1VYoEGAAC9iPX1u5oPWLXJ49s8hxQGWF4Pguu5AuJ+OiWw4+J0zSt4rHKvg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF8A9AF77AE07E4D978E832317E57F6C@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2eeb7b2-0904-4e35-22bc-08d74b10169b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2019 10:21:16.5869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qrCnf8VCrk5AiIUisfFSFGJUfNM+uGWVCNxPoV6722rmbnu8z4CTaCTScf3fGk0yIPpVl7d/zeZz0eSWbhRxeas1Kpnh6n264dAszijsmco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5157
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-07_02:2019-10-07,2019-10-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 clxscore=1011 mlxscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910070103
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gTW9uLCAyMDE5LTEwLTA3IGF0IDE1OjQwICswNTMwLCBNYW5pdmFubmFuIFNhZGhhc2l2YW0g
d3JvdGU6DQo+IFtFeHRlcm5hbF0NCj4gDQo+IEFkZCBkZXZpY2V0cmVlIGJpbmRpbmcgZm9yIEFu
YWxvZyBEZXZpY2VzIEFEVVgxMDIwIFBob3RvbWV0cmljDQo+IHNlbnNvci4NCj4gDQoNCkhleSwN
Cg0KVGhhbmtzIGZvciB0aGUgcGF0Y2hlcy4NCg0KVGhpcyBkdC1iaW5kaW5nIGRvY3MgaXMgaW4g
dGV4dCBmb3JtYXQuDQpkdC1iaW5kaW5nIGRvY3Mgbm93IG5lZWQgdG8gYmUgaW4gWUFNTCBmb3Jt
YXQuDQoNCkFsc28sIHBhdGNoZXMgZm9yIGR0LWJpbmRpbmdzIGRvY3MgdXN1YWxseSBjb21lIGFm
dGVyIHRoZSBkcml2ZXIgaXMgYWRkZWQuDQpTbywgdGhpcyBwYXRjaCBzaG91bGQgYmUgdGhlIHNl
Y29uZCBpbiB0aGUgc2VyaWVzLCBub3QgdGhlIGZpcnN0Lg0KDQpBbGV4DQoNCj4gU2lnbmVkLW9m
Zi1ieTogTWFuaXZhbm5hbiBTYWRoYXNpdmFtIDxtYW5pdmFubmFuLnNhZGhhc2l2YW1AbGluYXJv
Lm9yZz4NCj4gLS0tDQo+ICAuLi4vYmluZGluZ3MvaWlvL2xpZ2h0L2FkdXgxMDIwLnR4dCAgICAg
ICAgICAgfCAyMiArKysrKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMjIgaW5z
ZXJ0aW9ucygrKQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+IERvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9paW8vbGlnaHQvYWR1eDEwMjAudHh0DQo+IA0KPiBkaWZmIC0tZ2l0IGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9saWdodC9hZHV4MTAyMC50eHQN
Cj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2xpZ2h0L2FkdXgxMDIw
LnR4dA0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLmU4OTZk
ZGEzMGUzNg0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9paW8vbGlnaHQvYWR1eDEwMjAudHh0DQo+IEBAIC0wLDAgKzEsMjIgQEANCj4g
K0FuYWxvZyBEZXZpY2VzIEFEVVgxMDIwIFBob3RvbWV0cmljIHNlbnNvcg0KPiArDQo+ICtMaW5r
IHRvIGRhdGFzaGVldDogDQo+IGh0dHBzOi8vd3d3LmFuYWxvZy5jb20vbWVkaWEvZW4vdGVjaG5p
Y2FsLWRvY3VtZW50YXRpb24vZGF0YS1zaGVldHMvQURVWDEwMjAucGRmDQo+ICsNCj4gK1JlcXVp
cmVkIHByb3BlcnRpZXM6DQo+ICsNCj4gKyAtIGNvbXBhdGlibGU6IHNob3VsZCBiZSAiYWRpLGFk
dXgxMDIwIg0KPiArIC0gcmVnOiB0aGUgSTJDIGFkZHJlc3Mgb2YgdGhlIHNlbnNvcg0KPiArDQo+
ICtPcHRpb25hbCBwcm9wZXJ0aWVzOg0KPiArDQo+ICsgLSBpbnRlcnJ1cHRzOiBpbnRlcnJ1cHQg
bWFwcGluZyBmb3IgSVJRIGFzIGRvY3VtZW50ZWQgaW4NCj4gKyAgIERvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9pbnRlcnJ1cHRzLnR4dA0KPiAr
DQo+ICtFeGFtcGxlOg0KPiArDQo+ICthZHV4MTAyMEA2NCB7DQo+ICsJY29tcGF0aWJsZSA9ICJh
ZGksYWR1eDEwMjAiOw0KPiArCXJlZyA9IDwweDY0PjsNCj4gKwlpbnRlcnJ1cHQtcGFyZW50ID0g
PCZtc21ncGlvPjsNCj4gKwlpbnRlcnJ1cHRzID0gPDI0IElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0K
PiArfTsNCg==
