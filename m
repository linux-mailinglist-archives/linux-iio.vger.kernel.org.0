Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3D4517E1A6
	for <lists+linux-iio@lfdr.de>; Mon,  9 Mar 2020 14:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgCINtS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Mar 2020 09:49:18 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:43138 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726536AbgCINtS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Mar 2020 09:49:18 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 029Dj0p7024830;
        Mon, 9 Mar 2020 09:49:16 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ym6bcdn4b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Mar 2020 09:49:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0d0YF2i85EI0Khvjgr/7LuIeRwLrnCb5QPwaA0f/rNPtEk7sm0PlchiaPw8nJIarMM9N+EvhdUUpx7E5N+zXB2QsXpjkMXCu3rHCYbLYon1PXmaP1Sn0wvtUSwEY4vTzBbsskC7jNMqo7jJ2dx2+KHFphmmA0G5soO8HBm17eIjL2jCclfVKn05tNMRhLiG4QJQ24yXZ5IU5vXwy1hqGHXE89Zc+NPhjOHtqU61fV3JTs4smZfZvQ/WQkErm7gMdzOHv30SsHixooAC4i5HL1T8j2JMKl4o8++YRIj9aSOwyGmFCOjde5SSZAGynjRsvfq8vpqN7r+34jwRNduuGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9d/hFzBxcDuGza/K2xp4O+1to+heQcSLqm8DG71mS0=;
 b=mBaqjqkflMXzNEuAUEMYJ9fjfc8hoCSInA/kHCbfqTZkBfnf7Y9tjIDzs1DxtwYNRyCg4zK+k0Z4e+htT4T1VIKW1CDwgX66Rlxq2Sdp2D3GEd4CSG/teMUM4I2y0AEvHv+tLFz2JwFywmuK/5EAxeV6xbPQTLkf4wOXvZHUv8WiavowCzg5K4dbe3sG5/4mQO6Y5vXnIJakweObqqZn2VsyhT5MFFKJE6CkQUD7dksOu8EUUUfg/rxipUhAJpCaDetl20AHrSDEebsSCcTEdg5dlw33ECOAp8OrQwwVb2lJP+/wyh5HAFFcfRrPx7tRVyQxYzIpOCNHB0y9tyqdcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9d/hFzBxcDuGza/K2xp4O+1to+heQcSLqm8DG71mS0=;
 b=u26t0s/Q3nzbZ6lbdK/vkMzNSkaFOd/Y76Eqdag5dSB+yaGaZ+g++t7v2dpRIR3JQX3C383+N4ODOOkiqUsf7rVT5XZKInvYWwdeyJRGsPHIa7aOWEu0m6FahaFVzDsq0KqbvQeho5bMp2jjmRM9Rq+jv8ZEfi/oC9KeCQJBs2M=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4028.namprd03.prod.outlook.com (2603:10b6:5:5e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Mon, 9 Mar
 2020 13:49:14 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::f8c4:f7f2:c7a0:cc19]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::f8c4:f7f2:c7a0:cc19%6]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 13:49:14 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "mdf@kernel.org" <mdf@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH v8 1/8] include: fpga: adi-axi-common.h: fixup whitespace
 tab -> space
Thread-Topic: [PATCH v8 1/8] include: fpga: adi-axi-common.h: fixup whitespace
 tab -> space
Thread-Index: AQHV86YcLfFvUC7MJkGk6PQIj2NY7qg9MSuAgABcmACAAr36AA==
Date:   Mon, 9 Mar 2020 13:49:14 +0000
Message-ID: <a2a8f3a0928dc071beee1ef2ff6f33add8694e42.camel@analog.com>
References: <20200306110100.22092-1-alexandru.ardelean@analog.com>
         <20200306110100.22092-2-alexandru.ardelean@analog.com>
         <20200307142521.3efbe4a4@archlinux> <20200307195646.GB38707@epycbox.lan>
In-Reply-To: <20200307195646.GB38707@epycbox.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0d1ce9f6-5420-41f5-eb2d-08d7c430a7cf
x-ms-traffictypediagnostic: DM6PR03MB4028:
x-microsoft-antispam-prvs: <DM6PR03MB4028C7C32FE493556BAEA7F0F9FE0@DM6PR03MB4028.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 0337AFFE9A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(136003)(346002)(376002)(199004)(189003)(186003)(26005)(86362001)(4326008)(2616005)(316002)(6506007)(110136005)(71200400001)(54906003)(8936002)(81166006)(81156014)(8676002)(2906002)(966005)(36756003)(91956017)(478600001)(5660300002)(6486002)(66946007)(66476007)(66446008)(64756008)(66556008)(6512007)(76116006);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB4028;H:DM6PR03MB4411.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0bXLUvFPh02gT1MLCgi7o502hXjQwYGw6zDGvQiR3H1VWapkVPJLtCaR1UEJH7Lzq06GWSd88np2qsJ9G/aMn2CK1AA6tezyRXCuVMlOOuS0ejWM8JfjeYJn1TC1dIBvZXCAaKkAMvdxei9FHPsYxofLTTAJ2pFQSD8bGB8Jn7CGkhvDJiIyjGxKNlBeeeNitrTIxNssNGbDGiTAmgr3pFv+hW1AuYxY+uU3CwAABcHZDVL8N8yBK27kQzCw3SqWKFLkuvKzpQyilCg0Gamb9gvVka6swymHxbcCXXTJeCjAa+q2bTu5+k4E6tmyEVQzJVVfJd/cnpCjTQta4CbLiU0jsrff9xCfpZ/KtpLKxJWxipB9VLft/BqkfJiWMqt5ivJAIQYBpITgg+jxd5GWc5S9GHyFdmdEp7Pq45azDWCluMVVXgKPC0k1kZ6Ii4t4AXqpxN3QHzQRZxiwjT7elWwUbAixRLYAXZDNEWJfFTV4PJrP2/ABU8A3l1z3zMoozTa0gRzpSsB50nEgBQFHMA==
x-ms-exchange-antispam-messagedata: Il7VmhTDYJYnhcCPuKiRzDHYa39/bsIUkj7GqFdDMR3UsPaRQvncnrAxy5VVvFGp132d8OAR3ZuzNyxJhBIEaIFvMdsJB1S/pZ3oPPF1i4HgBHM+54ZD9uAaCMF2DydJWzntQ25iNAF8euvFatqQLA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <59E13B88203C6C44A2052053412EEEB2@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d1ce9f6-5420-41f5-eb2d-08d7c430a7cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2020 13:49:14.7231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MKBMmvXr4GerRC6yVgSvjF200cAVXel2OVTVaftxShFYptl+q8lfxeFblIvlPmjAciSkFtfkX1zG6vGd88CGh1D9HpmdZ68FnxdwJaKki44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4028
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-09_04:2020-03-09,2020-03-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 mlxscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003090095
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU2F0LCAyMDIwLTAzLTA3IGF0IDExOjU2IC0wODAwLCBNb3JpdHogRmlzY2hlciB3cm90ZToN
Cj4gT24gU2F0LCBNYXIgMDcsIDIwMjAgYXQgMDI6MjU6MjFQTSArMDAwMCwgSm9uYXRoYW4gQ2Ft
ZXJvbiB3cm90ZToNCj4gPiBPbiBGcmksIDYgTWFyIDIwMjAgMTM6MDA6NTMgKzAyMDANCj4gPiBB
bGV4YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPiB3cm90ZToN
Cj4gPiANCj4gPiA+IFRoZSBpbml0aWFsIHZlcnNpb24gdXNlIGEgdGFiIGJldHdlZW4gJyNkZWZp
bmUnICYgJ0FESV9BWElfUkVHX1ZFUlNJT04nLg0KPiA+ID4gVGhpcyBjaGFuZ2VzIGl0IHRvIHNw
YWNlLiBUaGUgY2hhbmdlIGlzIHB1cmVseSBjb3NtZXRpYy4NCj4gPiA+IA0KPiA+ID4gU2lnbmVk
LW9mZi1ieTogQWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNv
bT4NCj4gQWNrZWQtYnk6IE1vcml0eiBGaXNjaGVyIDxtZGZAa2VybmVsLm9yZz4NCg0KSSdtIHN0
aWxsIGEgYml0IHZhZ3VlIG9uIHdobyBtYWludGFpbnMgd2hhdC4NClRoZSBpbml0aWFsIHZlcnNp
b24gb2YgdGhpcyBoZWFkZXIgZGlkIG5vdCBnZXQgc3VibWl0dGVkIHRvIE1vcml0eidzIGF0dGVu
dGlvbg0KQXBvbG9naWVzIGZvciB0aGF0Lg0KDQpJdCBjYW1lIHRvIGV4aXN0IGFzIGEgcmVzdWx0
IG9mIHVwc3RyZWFtaW5nIHBhcnRzIG9mIHRoZSBBREkgQVhJIERNQUMgZHJpdmVyLg0KDQpodHRw
czovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51
eC5naXQvY29tbWl0Lz9pZD1kMjdhYzJlMDJiZjI1NmQ0ZTgyNGU3YzFlMWUxYWZhMmI5NmNlZmNj
DQoNClRoZSBpbml0aWFsIGNvbXBsYWludCB3YXMgdGhhdCBzb21lIG1hZ2ljIG51bWJlcnMgd2Vy
ZSB1c2VkIGFuZCB0aGVuIEkgYWRkZWQNCnRoaXMgaGVhZGVyLCB3aGljaCBpcyBhIHNtYWxsZXIg
dmVyc2lvbiBvZiB0aGUgb25lIHdlIGhhdmUgaW4gdGhlIEFESSB0cmVlLg0KDQpUaGFua3MNCkFs
ZXgNCg0KPiANCj4gPiBXaGlsc3QgdGhpcyBpcyB0cml2aWFsIGl0IHN0aWxsIG5lZWRzIGFuIGFj
ayBmcm9tIHJlbGV2YW50IG1haW50YWluZXINCj4gPiBmb3IgdGhhdCBkaXJlY3RvcnkuIE1vcml0
eiBJIHRoaW5rLi4uDQo+ID4gDQo+ID4gSm9uYXRoYW4NCj4gPiANCj4gPiA+IC0tLQ0KPiA+ID4g
IGluY2x1ZGUvbGludXgvZnBnYS9hZGktYXhpLWNvbW1vbi5oIHwgMiArLQ0KPiA+ID4gIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4gDQo+ID4gPiBk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9mcGdhL2FkaS1heGktY29tbW9uLmggYi9pbmNsdWRl
L2xpbnV4L2ZwZ2EvYWRpLQ0KPiA+ID4gYXhpLWNvbW1vbi5oDQo+ID4gPiBpbmRleCA3ZmM5NWQ1
Yzk1YmIuLmViZDRlMDdhZTNkOCAxMDA2NDQNCj4gPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvZnBn
YS9hZGktYXhpLWNvbW1vbi5oDQo+ID4gPiArKysgYi9pbmNsdWRlL2xpbnV4L2ZwZ2EvYWRpLWF4
aS1jb21tb24uaA0KPiA+ID4gQEAgLTExLDcgKzExLDcgQEANCj4gPiA+ICAjaWZuZGVmIEFESV9B
WElfQ09NTU9OX0hfDQo+ID4gPiAgI2RlZmluZSBBRElfQVhJX0NPTU1PTl9IXw0KPiA+ID4gIA0K
PiA+ID4gLSNkZWZpbmUJQURJX0FYSV9SRUdfVkVSU0lPTgkJCTB4MDAwMA0KPiA+ID4gKyNkZWZp
bmUgQURJX0FYSV9SRUdfVkVSU0lPTgkJCTB4MDAwMA0KPiA+ID4gIA0KPiA+ID4gICNkZWZpbmUg
QURJX0FYSV9QQ09SRV9WRVIobWFqb3IsIG1pbm9yLCBwYXRjaCkJXA0KPiA+ID4gIAkoKChtYWpv
cikgPDwgMTYpIHwgKChtaW5vcikgPDwgOCkgfCAocGF0Y2gpKQ0K
