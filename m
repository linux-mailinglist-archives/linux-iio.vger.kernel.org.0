Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA7F190628
	for <lists+linux-iio@lfdr.de>; Tue, 24 Mar 2020 08:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgCXHTG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Mar 2020 03:19:06 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:1648 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725951AbgCXHTG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Mar 2020 03:19:06 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02O7Hw7U031570;
        Tue, 24 Mar 2020 03:18:43 -0400
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ywfu58r3e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Mar 2020 03:18:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T54QDTff/QvjiTD5im3+hg1OJYfo8IgY2q06PqmsoUBxySSCi8pffPkzYcUPiAkFghpnip99uNjNMNG/zu5AERe6aESmMNXqVjEZFZABY6MVepNhGxhglHzWYN6YhCRrl6LtUPWp1fk50AYQDJxj/DmQp49jwY4pubYNI5OxM7MegzPnNJEVMOgk8PbPAcxyY90xQxJCimP51tl7o5u2vP9axQOl85YqIUK8jGOvYgB0AcDSLsWJelRRWa0hYZUpScyrlY/WzVgyZWUgBAIiMg4c3hUZOLtk2hlmoFhLeUjj+sAhcPe+NKfdOZB1bm82S0BIOInLaebfNshZEsKsew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RquEhf4hIazp/DO5viYm9SUcnmByCfdj6Fl3/8hE6ek=;
 b=IYA2zv1F9MEivF+ecIQN1n4dMFx8UlsVR2ED7QCF0SEtypde8cVV/FBdeWEonIBsJ6xKTgIQpo3LQsyw3TOkQhDHc+npYFiPpO1xhgEubKKrxc8fpNS/s5v102K2/YiUTL5SVz3g/FosbsV8zDiCLF8ecmQdpOkLkgsB/jvvClqKIaE0x11N3Jgv3taC8QgQDapgRwXJO0ozXk5DXwyeQnzByLaobMWAe1LWmki+z8sWRkKREnj3E8D1dar2snFoRxeZ+2Lc+4pvcWWvTJGJYlvDpe0DWMSsnO9z+3Cmy9kyKwh/I01zeCZ+fdyTC2De5JS3x1RX+hgNpukX/alB0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RquEhf4hIazp/DO5viYm9SUcnmByCfdj6Fl3/8hE6ek=;
 b=1R+H0RuuCuuhGGWDLUPyxq5cWRCS3Xe4xSL7IMlobfOJR8LWhYN7yDyNzg/CKM4z+N+hTw924V1YJeanU1d8D7Vs2CSTwS+sA5DcoK0Qs96MciS+L8H3U1r9od43z/Ukk+C+Qa13t749ef2baZJUGFcH9TWcQLpp6j2i/FFgR0s=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB3802.namprd03.prod.outlook.com (2603:10b6:5:50::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Tue, 24 Mar
 2020 07:18:40 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2835.023; Tue, 24 Mar 2020
 07:18:40 +0000
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
Subject: Re: [PATCH v3 1/4] staging: iio: adc: ad7192: Re-indent enum labels
Thread-Topic: [PATCH v3 1/4] staging: iio: adc: ad7192: Re-indent enum labels
Thread-Index: AQHWAIOyM0GegiihW0G94ym/VoVsuahXWNMA
Date:   Tue, 24 Mar 2020 07:18:40 +0000
Message-ID: <03bdda7494a9affadba0eead62a770874de2ca36.camel@analog.com>
References: <cover.1584904896.git.mh12gx2825@gmail.com>
         <5c6bef6462d135b748f58f8c2645c60234482f52.1584904896.git.mh12gx2825@gmail.com>
In-Reply-To: <5c6bef6462d135b748f58f8c2645c60234482f52.1584904896.git.mh12gx2825@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.26.73.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 37fb60e5-c355-4774-13da-08d7cfc393e2
x-ms-traffictypediagnostic: DM6PR03MB3802:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB3802231B384396D67E24B88AF9F10@DM6PR03MB3802.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:660;
x-forefront-prvs: 03524FBD26
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(39860400002)(346002)(366004)(64756008)(81156014)(86362001)(8676002)(2616005)(81166006)(66556008)(8936002)(76116006)(36756003)(91956017)(2906002)(186003)(71200400001)(7416002)(26005)(110136005)(6512007)(6506007)(54906003)(316002)(66446008)(66946007)(66476007)(4326008)(4744005)(6486002)(478600001)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB3802;H:DM6PR03MB4411.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: luQFaSCvOB7GVAe51p2ynOngoMdEhIP6Zlmbj2GTYf8NKZ7hG/D6eLhPUFyamc74vAxFZR4bYzkCUZUS9IpRECfb099JMkGSQvdYuQrcm9VFXUWtGTXpWjhLwtPPSRzj7/VMPLIv27LxlplEba8lrYe57R+O8giYO5ONBXKpcfhAJyaPWyFOY2HVITUMUO+L27/n/gEaoOsmYTpiqn5gWJneinhcD70Si/yDZ+I5eSmxkkHXLnYhJAeH/PKFah5NgnFBbEYk9SkZVNz7Iv6BNIVMxTaLrGblN/ROqTI/tskE+wI55+4JOlfrHcZ5z8kw2QOnRFIEdYxKZmQVvQoxtZlIErMN3w3EgcyRpLHnjUnDa0cwsgWKtf9LY7lnr0rbznJaGBKV8gTqA87ALcqby7x+MP5KBJ6Cr5yHCvfLeWfYCdbiQBau39VncQNtznzF
x-ms-exchange-antispam-messagedata: zSD3GoE6cQqM4tPQqb4sYpIkojIkwXl21TOOT/Kq0BU2RNQdWea1ts1ckriyjIFB5KXF75OmEqiceOzmtqLTyGWQMliHlBmv8xMSfR9Zi/5keqAflD4xhJciCaaRikfubGJIf49SSzVMNn14DkWUGA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B33B7994AB3A64B8CA6ED1DFE5C1651@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37fb60e5-c355-4774-13da-08d7cfc393e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2020 07:18:40.1924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IzF5lnNv6h4hTdxhUIFXIQszsp75C+M9Q6pCpgFTQf6DONun6LbQlm29w+dxJC2hRmEF+qRw40+DZC3mrbOkAPi4uLSSS9WLUDhmNLe0/l4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3802
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-24_01:2020-03-23,2020-03-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 clxscore=1011 impostorscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=899 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2003240037
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gTW9uLCAyMDIwLTAzLTIzIGF0IDAxOjI0ICswNTMwLCBEZWVwYWsgUiBWYXJtYSB3cm90ZToN
Cj4gW0V4dGVybmFsXQ0KPiANCj4gUmUtaW5kZW50IGVudW0gbGFiZWxzIGFzIHBlciBjb2Rpbmcg
c3R5bGUgZ3VpZGVsaW5lcy4gUHJvYmxlbQ0KPiBkZXRlY3RlZCBieSBjaGVja3BhdGNoIHNjcmlw
dC4NCj4gDQoNClJldmlld2VkLWJ5OiBBbGV4YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRl
bGVhbkBhbmFsb2cuY29tPg0KDQo+IFNpZ25lZC1vZmYtYnk6IERlZXBhayBSIFZhcm1hIDxtaDEy
Z3gyODI1QGdtYWlsLmNvbT4NCj4gLS0tDQo+IA0KPiBDaGFuZ2VzIHNpbmNlIHYyOg0KPiAJLSBO
b25lLiBWZXJzaW9uIG51bWJlciBpbmNyZW1lbnQgdG8gZm9sbG93IHBhdGNoIHNlcmllcyB2ZXJz
aW9uLg0KPiANCj4gQ2hhbmdlcyBzaW5jZSB2MToNCj4gCTEuIFNlcGFyYXRlZCBvdGhlciBjaGFu
Z2UgaW50byBhIHNlcGFyYXRlIHBhdGNoIGFzIHN1Z2dlc3RlZCBieQ0KPiAJICAgR3JlZyBLSC4N
Cj4gDQo+IA0KPiAgZHJpdmVycy9paW8vYWRjL2FkNzE5Mi5jIHwgNCArKy0tDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvaWlvL2FkYy9hZDcxOTIuYyBiL2RyaXZlcnMvaWlvL2FkYy9hZDcxOTIuYw0K
PiBpbmRleCA4ZWMyOGFhOGZhOGEuLjAyOTgxZjNkMTc5NCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9paW8vYWRjL2FkNzE5Mi5jDQo+ICsrKyBiL2RyaXZlcnMvaWlvL2FkYy9hZDcxOTIuYw0KPiBA
QCAtMTU3LDggKzE1Nyw4IEBADQo+ICAgKi8NCj4gIA0KPiAgZW51bSB7DQo+IC0gICBBRDcxOTJf
U1lTQ0FMSUJfWkVST19TQ0FMRSwNCj4gLSAgIEFENzE5Ml9TWVNDQUxJQl9GVUxMX1NDQUxFLA0K
PiArCUFENzE5Ml9TWVNDQUxJQl9aRVJPX1NDQUxFLA0KPiArCUFENzE5Ml9TWVNDQUxJQl9GVUxM
X1NDQUxFLA0KPiAgfTsNCj4gIA0KPiAgc3RydWN0IGFkNzE5Ml9zdGF0ZSB7DQo=
