Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDE5118C923
	for <lists+linux-iio@lfdr.de>; Fri, 20 Mar 2020 09:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgCTIqP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Mar 2020 04:46:15 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:22246 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726657AbgCTIqO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Mar 2020 04:46:14 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02K8a7M1002677;
        Fri, 20 Mar 2020 04:45:54 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by mx0b-00128a01.pphosted.com with ESMTP id 2yu88sscdt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Mar 2020 04:45:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GAXFTsL7608tomu1E8NFbLimEptgoKL89hxxed7ZoJpYCrzC8as8nqO78QxTh1Wmo9pRCxHlMX0p5HnWMM7L6V9fSxtXQSzi65CYGJVtVdQ9K8n1EYIAak/lFc6+qGzt5k5KbcgGTCkpdb3t0GhAuAmHf3vi/LwaVK+WZB9x4kMPF9mOQbs31VWQQI0ppYWqDQa9aX2GalsLhoDIvGG/srkJuDFTi9iI7BV4TbjxiCZg3rCVxvTvU/p2FYVz9Dk5ckgyObRbgvzLpqnXbEp4gtqRjM+/gOjOXc7dfkBl2GDlVpsR97NVE6ayn6O4XtktIpErgPe927TwGIP6LhAlCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMdKegEZ1hXg4ec5pF4JAALHGuWGhHWm7bhNKnUfBm0=;
 b=LuRTJJGY6uZ0qz32n0jfqHOTy/V3KKN+JW2Km7SG3q92PddEOrpWF7K66vp4nCq2HlC8xMpLY0Al9Kiu6oibrhdwqim/Japc3WeCY5L+VFj3lIw6XnO2uZW6xIcXV0Hiip8vKchlp1egYCjZiq/D0gB2XmKdfe9j6iJUH9UF5GvYqDhQD2Yp9hMlYdBeKzBRoxA/IWJCYKl5zdpCFSpveNKs40AIAN2F6DPMkBFGNoKflAJiDgrCvqwVG8zCWVms4K+2QlBmD8taKIXTjYcrDZxda57cNGRGx+kDrhOjqZReNrUhlQEhc+24YddJH9wIrenAk7ZN3XhiyxbERKapoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMdKegEZ1hXg4ec5pF4JAALHGuWGhHWm7bhNKnUfBm0=;
 b=U/S2yZ4vvO3dsSxv/buvXEi/dqvG0rWeR/phHLyoF6j5+u+4OwgrBsn+2sMsJrQZSjSn6OQAxeXlxQhRN8WyrjmLpK+ywFqYX3PpPpgVzrxrve89rrmBYOl5Vf1PzERV+72w79uFCTKcWfumHbqKA0xec2Sl0vqSfXyAbLLXPfM=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4842.namprd03.prod.outlook.com (2603:10b6:5:182::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Fri, 20 Mar
 2020 08:45:50 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2814.025; Fri, 20 Mar 2020
 08:45:50 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "alazar@startmail.com" <alazar@startmail.com>
CC:     "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
Subject: Re: [PATCH v3 2/2] dt-bindings: iio: adc: Add MAX1241 device tree
 bindings in documentation
Thread-Topic: [PATCH v3 2/2] dt-bindings: iio: adc: Add MAX1241 device tree
 bindings in documentation
Thread-Index: AQHV/gr+PDsQL0XiZ0O93eXWBhyAxKhREqOAgAAVo4CAAAR+AA==
Date:   Fri, 20 Mar 2020 08:45:50 +0000
Message-ID: <2932042ff29a437195337be22b1c9fcb2c07ded7.camel@analog.com>
References: <20200319162937.34664-1-alazar@startmail.com>
         <20200319162937.34664-3-alazar@startmail.com>
         <2bad089fd8302ed514f673dae4ba8264b35fff16.camel@analog.com>
         <20200320083307.GA1871@leena.republic>
In-Reply-To: <20200320083307.GA1871@leena.republic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.26.73.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bb068473-531c-4414-1f04-08d7ccab17c0
x-ms-traffictypediagnostic: DM6PR03MB4842:
x-microsoft-antispam-prvs: <DM6PR03MB484245BFA7CD1E11E2D0124EF9F50@DM6PR03MB4842.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03484C0ABF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(136003)(396003)(346002)(199004)(316002)(54906003)(2616005)(36756003)(6506007)(5660300002)(64756008)(76116006)(66476007)(66946007)(26005)(66556008)(186003)(2906002)(91956017)(66446008)(86362001)(6512007)(6486002)(81166006)(81156014)(8676002)(478600001)(71200400001)(6916009)(4326008)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB4842;H:DM6PR03MB4411.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qsi63OTfXpgjKg/aeeS+9k2SN2+6RQ8hT7GaQKdfET5epWNpsV0lbDtyS7/QlnKJBaFWTLdClL7dslSC0a34BoYLjb+EgYFctN7QkRZ2KpFjR/ZAF4lseiUhgOOyYrT6c9tI/tjaIRKPjQAVoz4m13xp3rxml8WAQylvCIk6OaVoEJA18ZEKxZKgHTXaQcHRHnqD39KMSFIFv+USFZBV3IbYJd2wPnyN1+1FZmsKkwtDMSHQ6YARJqAcYGvBZuvnD58Ds5YmtZJlraVdo7hCDRIpLb4EThkNsPcsIaBNrpo1d8RxwQGCSjSKjVA/KtqvHEQkl87h/4bkbOt7+CLwIwrejiW3fbPyYgy8L1tGvYsyAIs/YRxJQd2fSn+DeqyDipd01DXpnoGD37TOU+nFlE2o8B7RqENGM3nC0Lfp5K+nT6xDfgv2LFVmyEa1O6hU
x-ms-exchange-antispam-messagedata: YI0uAy6ChG3IwPNhlSTnIgIDUDq9lZUhz+G7ZhHHDb68dytbyWZfPTUAwGVD8zZEcZ1hYQ/9QCTuKP/QKapJtIvDRSL5XewljztF2oFsnGHyxQgb8EULJGyjUOVd7LmAmL8ZGQDlqHzc5mwT+ACIWQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F8ADBBAFE942043B19B8BCCAB774F7E@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb068473-531c-4414-1f04-08d7ccab17c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2020 08:45:50.4256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XUCWXDDGD/ss/B3MATF6ixahjH7vouvX4iIqzRQxnZQDnT/6ssPioj7oSvQTenhDeM8l4yjZ5BoEtzMkaH7z+ujskDOVh2N/A3z6nA/1Exg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4842
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-20_01:2020-03-19,2020-03-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003200038
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gRnJpLCAyMDIwLTAzLTIwIGF0IDEwOjMzICswMjAwLCBBbGV4YW5kcnUgTGF6YXIgd3JvdGU6
DQo+IFtFeHRlcm5hbF0NCj4gDQo+ID4gPiArICByZWc6DQo+ID4gPiArICAgIGRlc2NyaXB0aW9u
OiBTUEkgY2hpcCBzZWxlY3QgbnVtYmVyIGZvciB0aGlzIGRldmljZQ0KPiA+IA0KPiA+IFJvYiB3
aWxsIHByb2JhYmx5IGNvbXBsYWluIHRoYXQgeW91IGRvbid0IG5lZWQgdG8gZG9jdW1lbnRbYWRk
IGRlc2NyaXB0aW9uXQ0KPiA+IHRvDQo+ID4gc3RhbmRhcmQgYXR0cmlidXRlcyBbbGlrZSBTUEkn
cyAncmVnJyBwYXJhbWV0ZXJdDQo+ID4gSnVzdCBsaXN0aW5nIGl0IGhlcmUsIHNob3VsZCBiZSBz
dWZmaWNpZW50LiBTbywgeW91IGNhbiBkcm9wIHRoZQ0KPiA+IGRlc2NyaXB0aW9uLg0KPiANCj4g
TWFrZXMgc2Vuc2UgLS0gc2hvdWxkJ3ZlIHRob3VnaHQgb2YgaXQsIGNvbnNpZGVyaW5nIEkgZHJv
cHBlZCB0aGUgZG9jDQo+IGZvciBzcGktZnJlcXVlbmN5IGFzIHdlbGwuIE15IGJyYWluIGlzIHN0
aWxsIHdpcmVkIHRvIHRoZSBub24tc3RhbmRhcmQNCj4gdHh0IGRvY3MgaXQgc2VlbXMsIHNvcnJ5
IQ0KPiANCg0KSSB0aGluayBtYW55IHBlb3BsZSBhcmVuJ3QgeWV0IHN1cGVyLWNvbWZvcnRhYmxl
IHdpdGggdGhlIG5ldyB5YW1sIGZvcm1hdCwgd2hpY2gNCnByb2JhYmx5IG1ha2VzIFJvYidzIGxp
ZmUgYSBiaXQgZGlmZmljdWx0Lg0KDQpJIGd1ZXNzIGl0IHNob3VsZCBiZWNvbWUgZWFzaWVyIG9u
Y2UgdmVyc2lvbiA1LjQrIGJlY29tZXMgbW9yZSBwb3B1bGFyLg0KDQo+IEknbSBnb2luZyB0byBt
YWtlIGEgdjQgZm9yIHRoaXMgKEkgdGhpbmsgSSBuZWVkIHRvIHJlb3JkZXIgdGhlIHBhdGNoDQo+
IHNlcmllcyBhbnl3YXkgLS0gdGhlIGR0LWJpbmRpbmdzIHNob3VsZCBjb21lIGZpcnN0KSBhbmQg
Q2M6IHRoZQ0KPiBkdC1iaW5kaW5ncyBsaXN0IHdpdGggYXMgd2VsbC4NCg0KVGhlIG9yZGVyIG9m
IHRoZSBiaW5kaW5ncyB2cyBjb2RlIGlzIGEgYml0IHJlbGF4ZWQgW2F0bV0uIEJ1dCBtYXkgYmVj
b21lIG1vcmUNCnN0cmljdCBbbGF0ZXIgYXQgc29tZSBwb2ludF0uIEkgdGhpbmsgdGhlIG9mZmlj
aWFsIHZlcnNpb24gaXMgYmluZGluZ3MtZmlyc3QgJg0KZHJpdmVyLW5leHQsIGJ1dCBpdCdzIHN0
aWxsIGFjY2VwdGVkIHRvIGRvIGl0IHRoZSBvdGhlciB3YXkgYXJvdW5kLg0KDQo+IA0KPiBUaGFu
a3MgYWdhaW4gZm9yIGFsbCB5b3VyIGhlbHAhDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEFsZXgN
Cg==
