Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E661B014C
	for <lists+linux-iio@lfdr.de>; Mon, 20 Apr 2020 08:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725896AbgDTGFh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Apr 2020 02:05:37 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:34996 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725815AbgDTGFh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Apr 2020 02:05:37 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03K62WvQ031098;
        Mon, 20 Apr 2020 02:05:36 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com with ESMTP id 30fxf5vn5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Apr 2020 02:05:36 -0400
Received: from m0167089.ppops.net (m0167089.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03K63SQk032302;
        Mon, 20 Apr 2020 02:05:35 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by mx0a-00128a01.pphosted.com with ESMTP id 30fxf5vn5t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Apr 2020 02:05:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRUqZiZAt4S0KQIYVcgMVkLvUTHOwr9hrE8lfXdzmvb1QqxVNWCJKgbGbo7RjN0agsHN0jBFoyc11H8EX62TUx8DCO8vtM6TCf4M7mnf16Xox3xgwDAFU9Fc4h6+kWUwCdbPt7BuTL0PoPCA5518lSOQ7KnboTqc6jRmcq9Clv1VEB+Z4C+Mq2kcS8mpFehobK8z25APzcpJNTP8HMIDZORP9wy3Cf5GT6/2SShVVItab/qHjMsP10BuqbouS1VQGc/vfMKdlj6KNRivvQnCjxol7InGf5yj+vSsgpQ1LcwxjXpFtOcJZSTEPD8fgU2wz95e1F8QF0UMqdJB/+AWzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXxzkSnfQvN8XBW37ihWHyvrDCRZiLwwwsn9p1XF7JM=;
 b=L6Kwrwi7RtND41t+gC4RBKVxNnHZKx7yVViS9nRMptm8G+90r038jg5nBDWSoyDPobycfzijJX+G1vQaNO0gZMFE59svix5Yl1MWIFcT1p1cAWMsiLkVql5WbIk9aKcpEMeLRO1fe3/uNrf/XibtAZezkbI/dVxdDSmol+OKWEaduMlVYnk6Mhie6+3HH/50WfUk2icDZG58dR9YrtQfL/swQGPmxVcy5S3RpL4zXMZCXbSjlhQZz5XlHGHkn180veMYosZacxovgEQ1eCciG24qNrDOTvkaE2rbdQi+1T++dk2494T1x0YE+Qc3Wsp3mX4oYShj63SJscj+z46Q4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXxzkSnfQvN8XBW37ihWHyvrDCRZiLwwwsn9p1XF7JM=;
 b=mqz6LlY6hHNWzlD08HC4MkKc+NpW7KciOcYx+KbOQ3GZZISfKNa5Xh6qPUjoVL0fw73YJ1Q9w6sZBwafNm7CeUdbB2Gx+VLzD1c+NnglaS+/Aci10NB4p0GBocgIht+g8NkQmBwuOqKxP2wI8cFLiE/+IqR897K4agzZIST/K0k=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4153.namprd03.prod.outlook.com (2603:10b6:5:5c::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Mon, 20 Apr
 2020 06:05:34 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2921.030; Mon, 20 Apr 2020
 06:05:34 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 2/7] iio: light: cm32181: Add mod_devicetable.h and remove
 of_match_ptr
Thread-Topic: [PATCH 2/7] iio: light: cm32181: Add mod_devicetable.h and
 remove of_match_ptr
Thread-Index: AQHWFlvSHxJdF+7u/0SBeZtSC2RQh6iBh84A
Date:   Mon, 20 Apr 2020 06:05:34 +0000
Message-ID: <ed0dcb0d2f395c5835ad06150d4e3c63dcca0cba.camel@analog.com>
References: <20200419150206.43033-1-jic23@kernel.org>
         <20200419150206.43033-3-jic23@kernel.org>
In-Reply-To: <20200419150206.43033-3-jic23@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.27.130.47]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 836a8afa-964a-46c8-b01f-08d7e4f0d6fd
x-ms-traffictypediagnostic: DM6PR03MB4153:
x-microsoft-antispam-prvs: <DM6PR03MB4153FE3847A047B5033FF13CF9D40@DM6PR03MB4153.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 03793408BA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(136003)(346002)(396003)(376002)(39850400004)(366004)(4744005)(86362001)(36756003)(6512007)(186003)(26005)(71200400001)(6506007)(478600001)(110136005)(2616005)(4326008)(2906002)(66946007)(76116006)(91956017)(8676002)(5660300002)(8936002)(316002)(66446008)(6486002)(64756008)(66556008)(66476007)(81156014);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AyyFvhlHsP51ItvaDs2fwhHZf0YIWlBidnvCNNquUBiR6DMp7sCgOHgS4c50gRk7boakvJfcm01TfhuIZ465YSe3cvFjuXejntU8BpYHmg19k/d1jyoxDOMvfZa6df1ULrB36RwKIim9NFwVbHHnOCVKt3JpdZBuYMadtJNyke3XbJ7bca18cgAxCx/G5PV2cPf90GZjoaL0SbdQvDR0zUppMsdcZIeSQw0ZuNX/nQxKSpUx+F+OMHBin5EoZH+kqV9ddmIJacxETMBue4ElGNDzwHczgH53ONZANFhpnzaiajsi2lpwvkZPJRbgKm9NNl56OUUkPMcvpOpUVs8tIIBe8H9iUZU0yPbnmtOEtA0VGFx/hMR3R1MrYeFROW/j0RlcM1r2P5ZQOIznQcOCpgQkKPIfyRMN07TJK/96znbQDr/kjaJE2I2j5fx4tiQK
x-ms-exchange-antispam-messagedata: OYN32OTHLqWmdKdoIWcftEXKHBWG7uvhuSBefNmm5iFLYyDe5vql7ODf+jI/JUcmLCEMrELYvdifn/MRZ34dPRKk6MCgE89GHDkDhn/vfgcvXdrUmzfVLPVUURCg64g7fHmtYCoQ4e/3zgH7NWWWDQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <30777B8E033F59469A4BF5661678DB16@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 836a8afa-964a-46c8-b01f-08d7e4f0d6fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2020 06:05:34.6258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bq5hkzTaAU1R1G4HeSOe7l46I3A5ajLW+k5NTbyuzK0JTtMxwRyFZPS5XfSizPA/0HFxN8nkPtb4i73ari7xZyCUax5ImLhaPltqd00sO+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4153
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-20_01:2020-04-17,2020-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004200053
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDIwLTA0LTE5IGF0IDE2OjAyICswMTAwLCBqaWMyM0BrZXJuZWwub3JnIHdyb3Rl
Og0KPiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+
DQo+IA0KPiBFbmFibGVzIHByb2JpbmcgdmlhIHRoZSBBQ1BJIFBSUDAwMDEgcm91dGUgYnV0IG1v
cmUgaXMgbW9zdHkgYWJvdXQNCj4gcmVtb3ZpbmcgZXhhbXBsZXMgb2YgdGhpcyB0aGF0IG1pZ2h0
IGdldCBjb3BpZWQgaW50byBuZXcgZHJpdmVycy4NCj4gDQoNClJldmlld2VkLWJ5OiBBbGV4YW5k
cnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPg0KDQo+IFNpZ25lZC1v
ZmYtYnk6IEpvbmF0aGFuIENhbWVyb24gPEpvbmF0aGFuLkNhbWVyb25AaHVhd2VpLmNvbT4NCj4g
LS0tDQo+ICBkcml2ZXJzL2lpby9saWdodC9jbTMyMTgxLmMgfCAzICsrLQ0KPiAgMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvaWlvL2xpZ2h0L2NtMzIxODEuYyBiL2RyaXZlcnMvaWlvL2xpZ2h0L2NtMzIxODEu
Yw0KPiBpbmRleCA1ZjRmYjU2NzRmYTAuLjczYzQ4ZjQ2MjIwYyAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9paW8vbGlnaHQvY20zMjE4MS5jDQo+ICsrKyBiL2RyaXZlcnMvaWlvL2xpZ2h0L2NtMzIx
ODEuYw0KPiBAQCAtOSw2ICs5LDcgQEANCj4gICNpbmNsdWRlIDxsaW51eC9pMmMuaD4NCj4gICNp
bmNsdWRlIDxsaW51eC9tdXRleC5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPiAr
I2luY2x1ZGUgPGxpbnV4L21vZF9kZXZpY2V0YWJsZS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2lu
dGVycnVwdC5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3JlZ3VsYXRvci9jb25zdW1lci5oPg0KPiAg
I2luY2x1ZGUgPGxpbnV4L2lpby9paW8uaD4NCj4gQEAgLTM1NCw3ICszNTUsNyBAQCBNT0RVTEVf
REVWSUNFX1RBQkxFKG9mLCBjbTMyMTgxX29mX21hdGNoKTsNCj4gIHN0YXRpYyBzdHJ1Y3QgaTJj
X2RyaXZlciBjbTMyMTgxX2RyaXZlciA9IHsNCj4gIAkuZHJpdmVyID0gew0KPiAgCQkubmFtZQk9
ICJjbTMyMTgxIiwNCj4gLQkJLm9mX21hdGNoX3RhYmxlID0gb2ZfbWF0Y2hfcHRyKGNtMzIxODFf
b2ZfbWF0Y2gpLA0KPiArCQkub2ZfbWF0Y2hfdGFibGUgPSBjbTMyMTgxX29mX21hdGNoLA0KPiAg
CX0sDQo+ICAJLmlkX3RhYmxlICAgICAgID0gY20zMjE4MV9pZCwNCj4gIAkucHJvYmUJCT0gY20z
MjE4MV9wcm9iZSwNCg==
