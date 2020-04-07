Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC8A1A0CD9
	for <lists+linux-iio@lfdr.de>; Tue,  7 Apr 2020 13:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgDGLaA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Apr 2020 07:30:00 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:19208 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726399AbgDGLaA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Apr 2020 07:30:00 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 037BPcDm003031;
        Tue, 7 Apr 2020 07:29:57 -0400
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by mx0b-00128a01.pphosted.com with ESMTP id 3079ubexph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Apr 2020 07:29:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MsdebdqEg9+m0KST8LW/sToPc+TKqyitrbj7PSeb5uH0tazAf3AZm3eXF8PxAggwRU6djZQWpbbKsh6JKYAWisTCs4PlfoGxhyGgjmDtk7eHp0xsK3oEX1Y0kqTirftDR7Im2nhCN8L+xD3kPFxP8+No4UnNYMIabjRG9T8LkL7AEFOl1iQRnMEe0w6OzlGunMT6BN5keS8NWqyv4z/L+mIckpEkc0yO5rF/DRro/+7MqlUYW/8dvxEipkwBaNcVDxVmb6MqFpS1Mm6qCjTwWxYlg9yZliPQENVyBi//BF886/lQr50lyFQFCS5shNdk3qKjIuCGOXT7jBKYwtAvAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPjoUDEg/2RqPqTzJP5N6B2k7r1XU4jOi/tNrE86Gnw=;
 b=eHaab2pj8zIHBwybV1iKwXWSZJnzTLyw9W5INIqGnT/H5eOMlFkF9o8fMWMLDA7yFR8ytlcFoxM/hki+XlIaybQl5fZenBy7wwOusaw8EUHWD2Juy6+5MEW9qeEdOJQfU+SW/RYQK2OXqZkDkK2MgC0II/Qa19yQ1FA8NBTwd9b/uSFfrI8zwniMRl/Q4dNMguMqIk/D2IV4qBVLEQnCrTbgxlWoqdFESV0rccOJ+XQ3nsNWqKnpuAQovCChYDoMEdHEhrQn0TSqcKmIXL/beDtiEiqpWF0R4U0+9X4vuWuoALVicAHJ5vvGujG4lgSDeUXwLecstKYRobMh69hGVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPjoUDEg/2RqPqTzJP5N6B2k7r1XU4jOi/tNrE86Gnw=;
 b=nDiZWLEQ10lwYed25oTK0n0hDishzJkiq3XIHl6EEmEwjx9W7aSTObaSNCFTj5qIlzccuufvMFwaZtV57XtXTUvwYnCpFNN9wNbE1WKc+0SM+lg0oB4IKflGFRDxinzqqSjX8l3yiNH69DB5C+TxUqKO8gdbSovTugQVEvbhJNY=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (20.178.27.206) by
 DM6PR03MB4380.namprd03.prod.outlook.com (20.178.27.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.19; Tue, 7 Apr 2020 11:29:55 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2878.018; Tue, 7 Apr 2020
 11:29:55 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "Markus.Elfring@web.de" <Markus.Elfring@web.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [v2] iio: core: move 'indio_dev->info' null check first
Thread-Topic: [v2] iio: core: move 'indio_dev->info' null check first
Thread-Index: AQHWDMlSZrUp5iveZ0qk1mOyXvaT86htfiwAgAAH+QA=
Date:   Tue, 7 Apr 2020 11:29:54 +0000
Message-ID: <2db41c0869d24d18b70f9ff5d4311fb86187c3e6.camel@analog.com>
References: <cb300eeb-6045-bd91-3e0e-902dd3b5d5d8@web.de>
         <3725f882accda683815f04c0eff0bb36c285fe62.camel@analog.com>
         <39d24c67-e83a-e414-e27e-041c7d5cea1a@web.de>
         <d25190f18a171d82f3300f00b00f50f62f636d28.camel@analog.com>
In-Reply-To: <d25190f18a171d82f3300f00b00f50f62f636d28.camel@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.27.135.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1130a8c7-b3e9-4e2c-c050-08d7dae6fef6
x-ms-traffictypediagnostic: DM6PR03MB4380:
x-microsoft-antispam-prvs: <DM6PR03MB438010786F0A7A09AEC97D77F9C30@DM6PR03MB4380.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 036614DD9C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(396003)(366004)(346002)(39860400002)(136003)(376002)(54906003)(66476007)(86362001)(5660300002)(76116006)(8676002)(66556008)(66946007)(91956017)(66446008)(64756008)(478600001)(81166006)(81156014)(71200400001)(6512007)(110136005)(26005)(316002)(8936002)(2906002)(4326008)(2616005)(36756003)(6506007)(186003)(6486002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +NC/u/v+Ioaq8xf2UhGSoMoAEkWzs8uJcz/w5MJFh2eCc1N283MFvvxkG3FgxtduKQ662c6v+j1K1lf4jzQguR/MtT9sgP+2WnIbkMZG1a4an0E6MmO2A7HMxaNSlrcpx6SF0ZXBRe8xYMmf3IrCK1r1wO7vBtjbzuv/sgXIlqo8Yw6YgdV3fm9xEyAXAmdhSDkQy/CpdVJLATJj5yyRtqjivAKR2QirZ/5FR47FT/WXQid/VmRmQR0CGkGjWcNvKQtxtpGQH75fnzxiwCEKFcZ1W/xeQuKf9Dbc9jzEf7PWyiT6OimJKuzTuG4TGL+wFh+AHaHHE1zuZLPm0wcTrhG4zb2OQc/7CQaALsBIF+wPgKDiKEsfVipCLzMTMp+PVy9/+Zwnp16WDJrl9BIwhsYkbDVye78ukf19iQ8Dxfql6/seSjXbeHl8sT41d8Im
x-ms-exchange-antispam-messagedata: 8CH2TgwSFcH1u/vQq9EPYXyXRiQQB0d9qEoqYoaCe9xAWVOPR0QsatsKn9ImdIxIFzL9d8MAxY6CroLB3Z5hHhkMclrPHgLRVR3E7yRIfzVb5Vanea8RbTs+NDHtkY0axN+h8HFU3HWfAx/KZNyxiQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0EFC8928B641E94B8550C7EA1ED42654@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1130a8c7-b3e9-4e2c-c050-08d7dae6fef6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2020 11:29:55.0032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ExNjDTkW3ke7XylCF+3FlQODg+PQaeURbOSuzull1C5lUM7LknTWYC8zrnUmFDQuhPBxKML/SCYboi5o2ZaJ6RYo7SzFEJENH78U9OJKi8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4380
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-07_03:2020-04-07,2020-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004070099
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDIwLTA0LTA3IGF0IDExOjAxICswMDAwLCBBcmRlbGVhbiwgQWxleGFuZHJ1IHdy
b3RlOg0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBUdWUsIDIwMjAtMDQtMDcgYXQgMTI6NDIgKzAy
MDAsIE1hcmt1cyBFbGZyaW5nIHdyb3RlOg0KPiA+IFtFeHRlcm5hbF0NCj4gPiANCj4gPiA+IFNv
LCBvdmVyIHRpbWUgSSBnb3QgdGhlIGhhYml0IG9mIG1lbnRpb25pbmcgJ0RvZXNuJ3QgZml4IGFu
eXRoaW5nLicNCj4gPiANCj4gPiBJIHN1Z2dlc3QgdG8gcmVjb25zaWRlciBzdWNoIGluZm9ybWF0
aW9uIG9uY2UgbW9yZS4NCj4gPiBXZSBjb21lIGFsb25nIGRpZmZlcmVudCBpbnRlcnByZXRhdGlv
bnMgZm9yIHJlbWFya2FibGUgc29mdHdhcmUgYWRqdXN0bWVudHMuDQo+ID4gDQo+ID4gDQo+ID4g
PiBpZiB0aGUgcGF0Y2ggZG9lc24ndCBmaXggYW55dGhpbmcuDQo+ID4gDQo+ID4gRG8geW91IGlt
cHJvdmUgdGhlIGlucHV0IHBhcmFtZXRlciB2YWxpZGF0aW9uIGEgYml0IGluIHByaW5jaXBsZSBo
ZXJlPw0KPiANCj4gSSB0aG91Z2h0IHRoYXQgd2FzIG9idmlvdXMgZnJvbSB0aGUgcmVzdCBvZiB0
aGUgZGVzY3JpcHRpb24gKyBwYXRjaC4NCj4gSSBndWVzcyBpdCBpc24ndC4NCj4gDQo+IEknbGwg
c2VlLg0KDQpTbywgaG93IGFib3V0IHRoaXM6DQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCiAgICBEb2Vzbid0IGZpeCBhbnl0aGluZy4gSnVzdCBtb3ZlcyB0
aGlzIHRvIGJlIHRoZSBmaXJzdCBjaGVjaywgYXMgaXQncyB2ZXJ5DQogICAgc2ltcGxlIGFuZCBm
YWlscyB0aGUgcmVnaXN0cmF0aW9uIGVhcmxpZXIsIGluc3RlYWQgb2YgcG90ZW50aWFsbHkNCiAg
ICBpbml0aWFsaXppbmcgdGhlICdpbmRpb19kZXYtPmxhYmVsJyBhbmQgY2hlY2tpbmcgZm9yIGR1
cGxpY2F0ZSBpbmRleGVzLCBhbmQNCiAgICB0aGVuIGZhaWxpbmcgd2l0aCB0aGlzIHNpbXBsZS1j
aGVjay4NCiAgICANCiAgICBUaGlzIGlzIGEgbWlub3Igb3B0aW1pemF0aW9uLCBzaW5jZSAnX19p
aW9fZGV2aWNlX3JlZ2lzdGVyKCknIHdpbGwgd2FzdGUNCiAgICBmZXdlciB2YWxpZGF0aW9uIGN5
Y2xlcyBpbiBjYXNlICdpbmRpb19kZXYtPmluZm8nIGlzIE5VTEwuDQotLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj8gICAgDQoNCg0KPiANCj4gPiBSZWdhcmRz
LA0KPiA+IE1hcmt1cw0K
