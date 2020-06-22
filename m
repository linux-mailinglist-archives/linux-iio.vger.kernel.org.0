Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A050B203158
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jun 2020 10:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbgFVIFV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Jun 2020 04:05:21 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:1120 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725883AbgFVIFT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Jun 2020 04:05:19 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05M7xtHq007586;
        Mon, 22 Jun 2020 04:05:16 -0400
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2059.outbound.protection.outlook.com [104.47.36.59])
        by mx0b-00128a01.pphosted.com with ESMTP id 31sf37d1a3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Jun 2020 04:05:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/zULQzpGCj7RIxbI17CA4musGQQtRXtPsoYTScjE69WmcqUxvqqbwvKTKS/uymsJs4S6l5bn1Ajarhhupk+sdKK+jUxKCbVJHad1/mIgfeb0UUtz6eW860M4d5pVDz9OjzOPequrGnYjNpXztm9xRJ+ER3wKcEzWbHjvOMHwFN0tgU0EhjUEcE35YZkMnAHowChJUDSdXG/70u042UzK5rPiKHUEHGuH3PgGfHw5gyzClud3qGWcK3b9FRADHxEaV6ffFsb2H/eIC7kwgCCVsS4tXD85OO8OoRt3BPdUIbUNNsIxy7mBRuJCZjQ53qRI6gNhFcZRq1WBcKFUJk3Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xToXUgyZdzxOhFpo35qjKYJdRTzrr63ednNkgH5AtiI=;
 b=LFdPxgwoBf31rc7D9UVmPlOvJcWM9HgTD1MbAwEzs+tOGzToCN+uoJDV2o68y8LCryII2r6r/UsinCbdrxUtid8+n0lskv+Y58D7A3UDyaonXUNFp/6aWwt0YKxQeyOTh54shn2HlAHYMBGcqy+Z/+qPMHe9aeGzo6bln5QbagAbGZHiDOfEVo4ZOT7YtDu5mi0n0S0kL6FZNu1IGMsXg5S4B3YrFU6ajN/qWEVoLo/lkERq32hIj68phKgGhQv4jU9RgDdAwLD1t7TI6qtq1tLBRfSe6B8S7K514Mq4HJjsjudpsQT8bPmo/YduUu4isnzULQ6Vnb/VItw1nSoB+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xToXUgyZdzxOhFpo35qjKYJdRTzrr63ednNkgH5AtiI=;
 b=KPlFe5eNmE+R06n6+4vBFDpzg4gsHjCVGTTLWaPPvXEwNT1zA0oyLUTkcuJxcRzRWgc4wqdLOeKhIOHXm/Pfl7sXUI8pqFO+QDXMAL+aEJXFcllg52nWn5nL05aML2DSRNTdNqg+2YVPavSKHnQ2w9IU/KeyFmuS7JmfrK+ZQkU=
Received: from MWHPR03MB3199.namprd03.prod.outlook.com (2603:10b6:301:3f::29)
 by MWHPR03MB3087.namprd03.prod.outlook.com (2603:10b6:301:46::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Mon, 22 Jun
 2020 08:05:13 +0000
Received: from MWHPR03MB3199.namprd03.prod.outlook.com
 ([fe80::41d5:c2a2:5c61:404b]) by MWHPR03MB3199.namprd03.prod.outlook.com
 ([fe80::41d5:c2a2:5c61:404b%5]) with mapi id 15.20.3109.026; Mon, 22 Jun 2020
 08:05:13 +0000
From:   "Berghe, Darius" <Darius.Berghe@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v1 3/3] iio:adc:ltc2471: add dt binding yaml
Thread-Topic: [PATCH v1 3/3] iio:adc:ltc2471: add dt binding yaml
Thread-Index: AQHWRxfiZTDXvULAjUShILSZOmnVSKjkSYUA
Date:   Mon, 22 Jun 2020 08:05:13 +0000
Message-ID: <053ba6af36636cb5b87c885ef1c6e157405e4412.camel@analog.com>
References: <20200617133523.58158-1-darius.berghe@analog.com>
         <20200617133523.58158-3-darius.berghe@analog.com>
         <20200620163124.29d9cd38@archlinux>
In-Reply-To: <20200620163124.29d9cd38@archlinux>
Accept-Language: ro-RO, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 62ebbe47-09dd-4131-e20e-08d81682fde4
x-ms-traffictypediagnostic: MWHPR03MB3087:
x-microsoft-antispam-prvs: <MWHPR03MB30876EF373AC2E62210B30C696970@MWHPR03MB3087.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0442E569BC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C0AjcqbczQgniVbMpncg2QTblIB9zFqfT19UMEFMofa4UTdAyN6Mb+qRxxTvPITm6h6k+toR/2oiqb/6sm/r+WO0P9aP6Ak/L1sf4L7SHjDD/QvzMxhfiU0kIMCgmwaCv2noV6E6K1NY+criK3C6SjhCTBhlBDemxyAItw4u1UNlq3prIYAmJ33BZpqrYVBywSMLl0xCrAQwrbewrZNWi5Gkumb9nBJuKtU1pAuo0C4oZp0U73aYohmgVBCfSpOFBLBXzw+28ktmKxgdQVJGklY7XvpiTiuuXnyKyL/OEiTOZCXk0emM7Odf7DwPSohB69R94WBvryCEETOlb8mjFWd9BUHn1jZM+gYMmdSbbH0Y0twLPcSARagoofJ9HAWTeFDLCwlmwt+TiBFlHnJP7A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR03MB3199.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(39860400002)(346002)(376002)(396003)(83380400001)(66476007)(2906002)(6512007)(66446008)(64756008)(66556008)(8676002)(966005)(86362001)(478600001)(66946007)(76116006)(8936002)(91956017)(2616005)(5660300002)(36756003)(6486002)(71200400001)(6916009)(316002)(186003)(4326008)(26005)(54906003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: xM/3u/zOKPm4CjNxVX65oM6CxZYLBMRVrVk/VfkfviHvWOi6UJO4DFbfcUp9uVJaqOl6bXPllQszWao++/mwg/8gTQKhODtOiLxHt9XYBL6DE7h7V0iLBG3yX4KFsc1f6YrSBYmDgzQRWCCHEGu0mmDD1dWlfYi3LMjqQBLVO5Xceub35FIVSJBkfwEhlnyYBVtPoAnRF0dP/qFwTuIopdTkoP0Bx41XuoqNULo9eQwGnJbEZ78vctct8z9o34lUEHxU5PlXVn4A8C2eLYGwwjUiQBfBn30jRdjB2B9N/Y8dS3GK57PNwQMclI3Ib3mSDvmnJ+d8fH5kMlvnCF53hVjtHcRpXVtxPpTnk2DH01t8BEMHM3Ln/SGkOIbsL4TQJtmTw+7AnuHK2p0fduR7dasyt1177OkLfG6d7gfbyXGPcoL5hHfZ76/sfbDVSFUaBa+sM3q80fOYGJB5pr05/AXE9A+/kQzve12rJEuOViY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B77727A003F96648A21EF3C0CD1D51AD@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ebbe47-09dd-4131-e20e-08d81682fde4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2020 08:05:13.2311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JL+iWnAyzeTaR89QlbkWoVO8TJM2R9XB1awpUhP+BoEyIuPJ/Pdd7paB8TOcwcvbRzJBdbrJ7TwcFCB8XdtveV4pFG1r0lJ1bJiKCTiSyQQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB3087
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-22_02:2020-06-22,2020-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 cotscore=-2147483648 clxscore=1015 bulkscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006220060
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU2F0LCAyMDIwLTA2LTIwIGF0IDE2OjMxICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBXZWQsIDE3IEp1biAyMDIwIDE2OjM1OjIzICswMzAw
DQo+IERhcml1cyBCZXJnaGUgPGRhcml1cy5iZXJnaGVAYW5hbG9nLmNvbT4gd3JvdGU6DQo+IA0K
PiA+IEFkZCBkdCBiaW5kaW5nIGRvY3VtZW50YXRpb24gZm9yIGx0YzI0NzEgZHJpdmVyLiBUaGlz
IGNvdmVycyBhbGwgc3VwcG9ydGVkDQo+ID4gZGV2aWNlcy4NCj4gPiANCj4gPiBTaWduZWQtb2Zm
LWJ5OiBEYXJpdXMgQmVyZ2hlIDxkYXJpdXMuYmVyZ2hlQGFuYWxvZy5jb20+DQo+IEEgZmV3IHRo
aW5ncyBpbmxpbmUgYnV0IGJhc2ljYWxseSBmaW5lLg0KPiANCj4gV2Ugc2hvdWxkIGhvd2V2ZXIg
YWxzbyB0aGluayBhYm91dCBkb2N1bWVudGluZyBwb3dlciBzdXBwbGllcy4NCj4gRXZlbiB0aG91
Z2ggdGhlIGRyaXZlciBkb2Vzbid0IGN1cnJlbnRseSBjb250cm9sIHRoZSBiaW5kaW5nIHNob3Vs
ZA0KPiBiZSBhcyBjb21wbGV0ZSBhcyBwb3NzaWJsZS4NCj4gDQo+IEpvbmF0aGFuDQo+IA0KSGkg
Sm9uYXRoYW4sDQoNCkFuZCB0aGFua3MgZm9yIHRoZSByZXZpZXcgIQ0KDQpUaGlzIGNoaXBzIGhh
dmUgYSBmaXhlZCBpbnRlcm5hbCB2cmVmIG9mIDEuMjVWIHRoYXQgaXMgb3V0cHV0IG9uIHRoZSBS
RUZPVVQgcGluLCB0aGVyZSBpcyBubyBwbGFjZSBmb3IgY29uZmlndXJhdGlvbiBoZXJlLiBPciBw
ZXJoYXBzIGRpZCB5b3UgbWVhbiB0aGUgVkNDICgyLjdWLTUuNVYpID8gSSdtIG5vdCBzdXJlIHdo
YXQgdGhlIGFkZGVkIHZhbHVlIHdvdWxkIGJlIHRvIGFkZCB2cmVmLXN1cHBseSBhbmQgdmNjLXN1
cHBseSB0byB5YW1sIGlmIHRoZXkgYXJlIG5vdCBpbXBsZW1lbnRlZC4gSSBmaW5kIGl0IGNvbmZ1
c2luZy4NCg0KPiA+IC0tLQ0KPiA+ICAuLi4vYmluZGluZ3MvaWlvL2FkYy9hZGksbHRjMjQ3MS55
YW1sICAgICAgICAgfCA1MiArKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCA1MiBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2FkYy9hZGksbHRjMjQ3MS55YW1sDQo+ID4gDQo+ID4g
ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYWRjL2Fk
aSxsdGMyNDcxLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2Fk
Yy9hZGksbHRjMjQ3MS55YW1sDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAw
MDAwMDAwMDAwMDAuLjBiODRlMTRlYzk4NA0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2FkYy9hZGksbHRjMjQ3MS55YW1s
DQo+ID4gQEAgLTAsMCArMSw1MiBAQA0KPiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAo
R1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCj4gPiArIyBDb3B5cmlnaHQgMjAyMCBBbmFs
b2cgRGV2aWNlcyBJbmMuDQo+ID4gKyVZQU1MIDEuMg0KPiA+ICstLS0NCj4gPiArJGlkOiBodHRw
czovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvYmlu
ZGluZ3MvaWlvL2FkYy9hZGksbHRjMjQ3MS55YW1sKl9fO0l3ISFBM05pOENTMHkyWSF2VXBEd1Nz
bGNhTnJjM2RiNkFRNngzZ3pZSGJSX1d4T3RReVBpbmtlWkNqZ3BpUTRlbEViak16RHMxT0dFWVpv
dTRFJCANCj4gPiArJHNjaGVtYTogaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHA6Ly9k
ZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sKl9fO0l3ISFBM05pOENTMHkyWSF2
VXBEd1NzbGNhTnJjM2RiNkFRNngzZ3pZSGJSX1d4T3RReVBpbmtlWkNqZ3BpUTRlbEViak16RHMx
T0c0Y21SdVc0JCANCj4gPiArDQo+ID4gK3RpdGxlOiBBbmFsb2cgRGV2aWNlcyBMVEMyNDcxIDE2
LWJpdCBJMkMgU2lnbWEtRGVsdGEgQURDDQo+ID4gKw0KPiA+ICttYWludGFpbmVyczoNCj4gPiAr
ICAtIE1pa2UgTG9vaWptYW5zIDxtaWtlLmxvb2lqbWFuc0B0b3BpYy5ubD4NCj4gPiArDQo+ID4g
K2Rlc2NyaXB0aW9uOiB8DQo+ID4gKyAgQW5hbG9nIERldmljZXMgTFRDMjQ3MSAoc2luZ2xlLWVu
ZGVkKSBhbmQgTFRDMjQ3MyAoZGlmZmVyZW50aWFsKSAxNi1iaXQNCj4gPiArICBJMkMgU2lnbWEt
RGVsdGEgQURDIHdpdGggc2VsZWN0YWJsZSAyMDgvODMzc3BzIG91dHB1dCByYXRlLg0KPiA+ICsg
IGh0dHBzOi8vd3d3LmFuYWxvZy5jb20vbWVkaWEvZW4vdGVjaG5pY2FsLWRvY3VtZW50YXRpb24v
ZGF0YS1zaGVldHMvMjQ3MTNmYi5wZGYNCj4gPiArDQo+ID4gKyAgQW5hbG9nIERldmljZXMgTFRD
MjQ2MSAoc2luZ2xlLWVuZGVkKSBhbmQgTFRDMjQ2MyAoZGlmZmVyZW50aWFsKSAxNi1iaXQNCj4g
PiArICBJMkMgU2lnbWEtRGVsdGEgQURDIHdpdGggNjBzcHMgb3V0cHV0IHJhdGUuDQo+ID4gKyAg
aHR0cHM6Ly93d3cuYW5hbG9nLmNvbS9tZWRpYS9lbi90ZWNobmljYWwtZG9jdW1lbnRhdGlvbi9k
YXRhLXNoZWV0cy8yNDYxM2ZhLnBkZg0KPiANCj4gUHV0IHRoZXNlIHR3byBibG9ja3MgaW4gbnVt
ZXJpYyBvcmRlci4gIElmIHdlIGVuZCB1cCBhZGRpbmcgYSBidW5jaCBtb3JlDQo+IGRldmljZXMg
aXQgd2lsbCBiZSBtdWNoIG1vcmUgY29uc2lzdGVudCBpZiB0aGV5IGFyZSBvcmRlci4NCj4gDQoN
CkFjaywgd2lsbCBkby4NCg0KPiA+ICsNCj4gPiArcHJvcGVydGllczoNCj4gPiArICBjb21wYXRp
YmxlOg0KPiA+ICsgICAgZW51bToNCj4gPiArICAgICAgLSBhZGksbHRjMjQ3MQ0KPiA+ICsgICAg
ICAtIGFkaSxsdGMyNDczDQo+ID4gKyAgICAgIC0gYWRpLGx0YzI0NjENCj4gPiArICAgICAgLSBh
ZGksbHRjMjQ2Mw0KPiANCj4gUHV0IHRoZW0gaW4gbnVtZXJpYyBvcmRlci4NCj4gDQoNCkFjaywg
d2lsbCBkby4NCg0KPiA+ICsNCj4gPiArICByZWc6DQo+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+
ICsNCj4gPiArcmVxdWlyZWQ6DQo+ID4gKyAgLSBjb21wYXRpYmxlDQo+ID4gKyAgLSByZWcNCj4g
PiArDQo+ID4gK2V4YW1wbGVzOg0KPiA+ICsgIC0gfA0KPiA+ICsgICAgaTJjMCB7DQo+ID4gKyAg
ICAgIGx0YzI0NjFAMTQgew0KPiANCj4gU2hvdWxkIHVzZSBhIGdlbmVyaWMgbmFtZQ0KPiBhZGNA
MTQNCj4gDQoNCkFjaywgd2lsbCBkby4NCg0KPiA+ICsgICAgICAgIGNvbXBhdGlibGUgPSAibHRj
MjQ2MSI7DQo+ID4gKyAgICAgICAgcmVnID0gPDB4MTQ+Ow0KPiA+ICsgICAgICB9Ow0KPiA+ICsg
ICAgfTsNCj4gPiArICAtIHwNCj4gPiArICAgIGkyYzAgew0KPiANCj4gTm90IGEgbG90IG9mIHBv
aW50IGluIHR3byBleGFtcGxlcyBnaXZlbiBob3cgc2ltaWxhciB0aGV5IGFyZS4NCj4gSSdkIGp1
c3Qga2VlcCB0aGUgb25lLiANCj4gDQoNCkFjaywgd2lsbCBkby4NCkkgb25seSBjaG9zZSB0byBn
aXZlIHR3byBleGFtcGxlcyBiZWNhdXNlIHRoZSBjaGlwIGhhcyAyIHBvc3NpYmxlIEkyQyBzbGF2
ZSBhZGRyZXNzZXMgMHgxNCBhbmQgMHg1NCBkZXBlbmRpbmcgb24gdGhlIEFPIHBpbiB2YWx1ZSBi
ZWluZyBsb3cgb3IgaGlnaC4gQnV0IHlvdSdyZSByaWdodCwgdGhleSdyZSB0b28gc2ltcGxlIGFu
ZCBzaW1pbGFyLg0KDQpCZXN0IHJlZ2FyZHMsDQpEYXJpdXMNCg0KPiA+ICsgICAgICBsdGMyNDcz
QDU0IHsNCj4gPiArICAgICAgICBjb21wYXRpYmxlID0gImx0YzI0NzMiOw0KPiA+ICsgICAgICAg
IHJlZyA9IDwweDU0PjsNCj4gPiArICAgICAgfTsNCj4gPiArICAgIH07DQo+ID4gKw0K
