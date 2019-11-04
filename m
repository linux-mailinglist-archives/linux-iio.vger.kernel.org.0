Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 020E2EE376
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2019 16:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbfKDPSO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Nov 2019 10:18:14 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:27100 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728646AbfKDPSN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Nov 2019 10:18:13 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA4F9xxD003999;
        Mon, 4 Nov 2019 10:18:11 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-00128a01.pphosted.com with ESMTP id 2w2a9yhr84-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Nov 2019 10:18:10 -0500
Received: from m0167091.ppops.net (m0167091.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xA4FDQ0Y006915;
        Mon, 4 Nov 2019 10:18:10 -0500
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp2050.outbound.protection.outlook.com [104.47.49.50])
        by mx0b-00128a01.pphosted.com with ESMTP id 2w2a9yhr82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Nov 2019 10:18:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lO0mfZv8Qf5tlFwlashC6mJ5du/zKv222fMN5OcnPbeO6NfhLKtVdRi3A1EY5lD9Br4ikVfJDLdXdOv5baJ5cHUx/q/O50sncU2NUF/KRto2R1IrNIuCNlmDx//9VBWAReVWHFTyDJcc64oyQ3DRFeUOfu9lmxpo//ggaDQJqjujgJ/hcT5FMiDiDrh/duQcbTGGXG2A/KQaqC06i6Kirv4efPXV3CwW8ir3UoTogB/QUJNDAQn/UiTevvH0Lo84rLkR5r8eTWAQeeOXm3vYuVXjANO5Zhdx4zlkJP4nLWDEakSyuN0ELeLTGhznyPep7Fv7oB0aCMv2i8vsJWL2TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmSNfLxqEPrG5hBcje3ilnA3cahcSmYR7vL4XlGpcBY=;
 b=nlNYZxGHRCYxs07xfFRiBS3D5+nbmULgRWZAImjEmOxDJpEC9clpa0KNJiVmahJTyLIfeaIGU/jj3i52oN3No0sY2qIlOCgPmgRHVZbsOYTLvU/nlTj/VxiN/tQTLnWAaW6eLzFP4cJ+nYja3WjBPnk2o8P7OQ9RuosCg+enUtp2+qUhqFwynX3A0690x/GQoAEZoDBJy55l5ZhNduMij7UnEXFcuCouuNJBBnK/UOPp+iIAUij0JBJSNFJCvZjMGAPI/O6/yY57bE1QXfAFZ5ynAmPIHYbDMbskwZyME60ypTkVrX9kULmVwrPKeA8ORkl9Vp+fsvVgMdhml6zTiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmSNfLxqEPrG5hBcje3ilnA3cahcSmYR7vL4XlGpcBY=;
 b=sFMdN9KJezkyPxdlCBeTbm7kuYdA1IqfV6sAeweb1+AkClZI4NexceK53iV4kE86j2jxGQ2vp8ylLYycEdi1W2/SXG4Y+9W6Rz0BVebDpnJeScoYv9rIF8Tf4cY8QtbNF2wrCHfSEjybgZpdwsngciCwd4TOQ7Qc7UN9iLpUepI=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5368.namprd03.prod.outlook.com (20.180.15.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 15:18:09 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c%3]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 15:18:09 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "maitysanchayan@gmail.com" <maitysanchayan@gmail.com>
Subject: Re: [PATCH] iio: dac: vf610: Use devm_platform_ioremap_resource
Thread-Topic: [PATCH] iio: dac: vf610: Use devm_platform_ioremap_resource
Thread-Index: AQHVgeptnVTbleNqu06EFCoV2qeHgKd7QksA
Date:   Mon, 4 Nov 2019 15:18:09 +0000
Message-ID: <997b426fd9211cda5b3bb8ae645c07c1dbb5af7e.camel@analog.com>
References: <20191013171732.2169010-1-jic23@kernel.org>
In-Reply-To: <20191013171732.2169010-1-jic23@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fd600f58-7293-4963-e857-08d7613a3345
x-ms-traffictypediagnostic: CH2PR03MB5368:
x-microsoft-antispam-prvs: <CH2PR03MB536876B55F2232C5562A31C4F97F0@CH2PR03MB5368.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:514;
x-forefront-prvs: 0211965D06
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(376002)(136003)(366004)(189003)(199004)(6116002)(3846002)(66556008)(76116006)(66476007)(66446008)(66946007)(256004)(2906002)(64756008)(99286004)(102836004)(26005)(6506007)(305945005)(2616005)(54906003)(2501003)(14444005)(316002)(76176011)(446003)(11346002)(118296001)(110136005)(36756003)(71200400001)(71190400001)(86362001)(478600001)(14454004)(6512007)(186003)(7736002)(6486002)(229853002)(486006)(476003)(4326008)(5660300002)(25786009)(8676002)(81166006)(8936002)(81156014)(6246003)(6436002)(66066001)(4001150100001);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5368;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lG0X96CeSuW0DYy3gubGNNIQqd5VDCVGoW4/6qPd3tU7K/q/H/iGxEu9PQ+HGDqTbkirZsTld2i56Wg8RJcCZqTdpc6TC5hiZVm9M1M7gcYj4OHDzZ1SZve5K1fegM3CirNzCxxVIDnmw0yRXWo8s/Z4z8Z8MZu5f94mQ0xrsDSTMsoAQ13Qjs4prpAx3sOtfRLBbVfC8zE1yACrcErscHG+aYtNFeNQF3uleJtcQq00fj+xOw4Oj2HTZixqJbhR8araoAZGtjQKS3KgmVsVNYbQ6zq7APzc1kGOqBXq59K3HFNku+qL14JpRzqWVlT5nWyjAhFsdJNAiCb9g0m2XNsuQu/3ejorcFGNCBCQJ+Wo9045Iv3ky3X/3hMlL5XKHzIEdCXCR90Q5ntzKPGtygi6cSSdrtk292WOKPWz3JShct5IkJQmwfJtepsS9Win
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A74CED951F181C49A1BE3F2225014D60@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd600f58-7293-4963-e857-08d7613a3345
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2019 15:18:09.1724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D3aiyv282xoc3DAK87/EwtDXoGDIEXwyDGOCpLYdfZlQsCtpmr7GkqxQc7X/ewXpjSpRJ1Oigw1G7gbzDbUpDuqr0dr5CifCgzuQCGAoUL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5368
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-04_09:2019-11-04,2019-11-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1911040151
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDE5LTEwLTEzIGF0IDE4OjE3ICswMTAwLCBqaWMyM0BrZXJuZWwub3JnIHdyb3Rl
Og0KPiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+
DQo+IA0KPiBSZWR1Y2UgbG9jYWwgYm9pbGVycGxhdGUuDQo+IFN1Z2dlc3RlZCBieSBjb2NjaW5l
bGxlDQo+IA0KPiBDSEVDSyAgIGRyaXZlcnMvaWlvL2RhYy92ZjYxMF9kYWMuYw0KPiBkcml2ZXJz
L2lpby9kYWMvdmY2MTBfZGFjLmM6MTg5OjEtMTE6IFdBUk5JTkc6IFVzZQ0KPiBkZXZtX3BsYXRm
b3JtX2lvcmVtYXBfcmVzb3VyY2UgZm9yIGluZm8gLT4gcmVncw0KPiANCg0KUmV2aWV3ZWQtYnk6
IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+DQoNCj4g
U2lnbmVkLW9mZi1ieTogSm9uYXRoYW4gQ2FtZXJvbiA8Sm9uYXRoYW4uQ2FtZXJvbkBodWF3ZWku
Y29tPg0KPiBDYzogU2FuY2hheWFuIE1haXR5IDxtYWl0eXNhbmNoYXlhbkBnbWFpbC5jb20+DQo+
IC0tLQ0KPiAgZHJpdmVycy9paW8vZGFjL3ZmNjEwX2RhYy5jIHwgNCArLS0tDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9paW8vZGFjL3ZmNjEwX2RhYy5jIGIvZHJpdmVycy9paW8vZGFjL3ZmNjEwX2Rh
Yy5jDQo+IGluZGV4IDBlYzRkMjYwOWVmOS4uNzFmOGE1YzQ3MWM0IDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2lpby9kYWMvdmY2MTBfZGFjLmMNCj4gKysrIGIvZHJpdmVycy9paW8vZGFjL3ZmNjEw
X2RhYy5jDQo+IEBAIC0xNzIsNyArMTcyLDYgQEAgc3RhdGljIGludCB2ZjYxMF9kYWNfcHJvYmUo
c3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldikNCj4gIHsNCj4gIAlzdHJ1Y3QgaWlvX2Rl
diAqaW5kaW9fZGV2Ow0KPiAgCXN0cnVjdCB2ZjYxMF9kYWMgKmluZm87DQo+IC0Jc3RydWN0IHJl
c291cmNlICptZW07DQo+ICAJaW50IHJldDsNCj4gIA0KPiAgCWluZGlvX2RldiA9IGRldm1faWlv
X2RldmljZV9hbGxvYygmcGRldi0+ZGV2LA0KPiBAQCAtMTg1LDggKzE4NCw3IEBAIHN0YXRpYyBp
bnQgdmY2MTBfZGFjX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYpDQo+ICAJ
aW5mbyA9IGlpb19wcml2KGluZGlvX2Rldik7DQo+ICAJaW5mby0+ZGV2ID0gJnBkZXYtPmRldjsN
Cj4gIA0KPiAtCW1lbSA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZShwZGV2LCBJT1JFU09VUkNFX01F
TSwgMCk7DQo+IC0JaW5mby0+cmVncyA9IGRldm1faW9yZW1hcF9yZXNvdXJjZSgmcGRldi0+ZGV2
LCBtZW0pOw0KPiArCWluZm8tPnJlZ3MgPSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2Uo
cGRldiwgMCk7DQo+ICAJaWYgKElTX0VSUihpbmZvLT5yZWdzKSkNCj4gIAkJcmV0dXJuIFBUUl9F
UlIoaW5mby0+cmVncyk7DQo+ICANCg==
