Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2914E6CAFB
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2019 10:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfGRIhd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Jul 2019 04:37:33 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:64392 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726397AbfGRIhc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Jul 2019 04:37:32 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6I8XA65004190;
        Thu, 18 Jul 2019 04:37:01 -0400
Received: from nam03-by2-obe.outbound.protection.outlook.com (mail-by2nam03lp2050.outbound.protection.outlook.com [104.47.42.50])
        by mx0b-00128a01.pphosted.com with ESMTP id 2ttgdmrj9g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 18 Jul 2019 04:37:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lbrxN0Na8EPcytGgOEOBstuOJXgu/YCOHCK2ABNuzGaNYeGqGsq/N7ndWtmB5kpC9GFS3A4HshQm9ah5y7NVq+7rff1P6j2dY8VtZy08ug+SJjJ91lubRl7n/7PEJMcjncK+6JoLAy2BCYjlxmheO1rRPymWEKVu/8h4Vv6CfqWiKbnrBWx6NORadm+gRElj4CBZMs7YDl0ALYIMd+PqsHhLsfbPpNoDF/UQOs4NbHbOxmzHmPJVOLu8g4mF97zLj2f7IAeDPfB8pBeP4Q4ZCVjzkTjhHMaRr+KCfEi+xjKDZVOTrwMo0otYUErS93VvqOqKnnMt2DC6HlEkQxpUwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVjZeoIDD8sAk2WxJuJP0iNTvgKW0d4xVFgElGFh6M0=;
 b=nLcZAoKE75KCpRedeeezbCNzQkRQ+Xx8/S/5ekcCLKxtE33DjrkDUnHCkjUCo7SlMe+K1t61IhpP8uhsEgZ1KwdCrKIldXGitRsF/HNUQuDUmiHPnjYkSd2GxSLD/63jtO1qfXeRdd6FKUuTrcISWLZXtKmohfzjdi8ozK3TgwL6KyIWkR+W2WfJfsRcS+c2ljrtWmi9dWQ+sFsQbXEy3HLh6FD1dTpW6xGrajTkeFFPRWH/XfgICTYQyiPXYdqSR+Hedi3NLhRX/iflSafZCK3D0Wg78EnPUzYLI2kIphm+WB4Rynp/SfhGxPmpEIPfhQmaAw46ewQzYWmNi4cqPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=gmx.de
 smtp.mailfrom=analog.com;dmarc=bestguesspass action=none
 header.from=analog.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVjZeoIDD8sAk2WxJuJP0iNTvgKW0d4xVFgElGFh6M0=;
 b=8eou+amAVw9C5NDFP2vf+L5qZu5y4UdosK8RamC0xYqqNLPIzUrkMphG9+932ARUBKHc3hxnyQF19cmWjGXBzWnzrbiGzrKFdlWfrY5q1eaJMYn9KWGZD5aUIn0+JUcLojP8+ct9iv5docZKLkKdkSRdpIPzwRxIo5yJvWwlXCs=
Received: from BN6PR03CA0060.namprd03.prod.outlook.com (2603:10b6:404:4c::22)
 by BN7PR03MB3825.namprd03.prod.outlook.com (2603:10b6:408:24::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2094.12; Thu, 18 Jul
 2019 08:36:59 +0000
Received: from SN1NAM02FT064.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::203) by BN6PR03CA0060.outlook.office365.com
 (2603:10b6:404:4c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2073.11 via Frontend
 Transport; Thu, 18 Jul 2019 08:36:59 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT064.mail.protection.outlook.com (10.152.72.143) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2032.15
 via Frontend Transport; Thu, 18 Jul 2019 08:36:58 +0000
Received: from NWD2HUBCAS9.ad.analog.com (nwd2hubcas9.ad.analog.com [10.64.69.109])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x6I8atmS002520
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 18 Jul 2019 01:36:55 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS9.ad.analog.com ([fe80::44a2:871b:49ab:ea47%12]) with mapi id
 14.03.0415.000; Thu, 18 Jul 2019 04:36:57 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
        "jic23@kernel.org" <jic23@kernel.org>
CC:     "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "daniel.baluta@gmail.com" <daniel.baluta@gmail.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
Subject: Re: [PATCH 00/14] iio: SPDX headers for core + non device driver
 parts.
Thread-Topic: [PATCH 00/14] iio: SPDX headers for core + non device driver
 parts.
Thread-Index: AQHVKQrTh365GKn2f0qadvTGCfjS2abPZG2AgAEUcwA=
Date:   Thu, 18 Jul 2019 08:36:56 +0000
Message-ID: <da136b3a95282ce975f4c3d7156b06c3c3e4f365.camel@analog.com>
References: <20190622145516.3231-1-jic23@kernel.org>
         <20190717170727.00001363@huawei.com>
In-Reply-To: <20190717170727.00001363@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.65.145]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <76B92D1BAD0A7243A32D9181FAA41D54@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(346002)(376002)(2980300002)(199004)(189003)(246002)(8936002)(305945005)(3846002)(6116002)(7636002)(4326008)(476003)(2906002)(6246003)(106002)(316002)(7736002)(110136005)(8676002)(54906003)(186003)(26005)(102836004)(36756003)(70206006)(47776003)(486006)(436003)(2501003)(426003)(70586007)(478600001)(2486003)(76176011)(23676004)(118296001)(7696005)(5660300002)(126002)(336012)(50466002)(11346002)(446003)(86362001)(14454004)(2616005)(229853002)(356004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR03MB3825;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9df4fb4b-1dea-4701-cfbe-08d70b5b191e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:BN7PR03MB3825;
X-MS-TrafficTypeDiagnostic: BN7PR03MB3825:
X-Microsoft-Antispam-PRVS: <BN7PR03MB382555DC297DC8D7CEE8D5F0F9C80@BN7PR03MB3825.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 01026E1310
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: MyG3kqlf+CvGFoUxuZqa/WLEMMhSI48YNdJ38e9snsbl8RG2Vl0kg6lgBh2q5419S8NKuP+khcupXDFUBb2vAwSWv8gT8oGaM+OBlYBTSlGBVWm3Eeu3L5JGtpINWGEsjNH7ZGvwugs9KAOUDJlFLifRuI6JcbA1tq087/6ZTFaNRjMa7ETpe+OmImwh41zIxnDZmVZMvneTfLnP9KLDTL2vAccEoWR9sOjo+7QYWZInFWtpX3aa2qvaN9U0apQlyw6NHb7KFBb2GKVsmHNxYbpZExzcGlT3gWv/PrM5JOoz8km80Fll1eEiliT/sa+1/IEdgEtU1Z3moOt6c+7PN3Qewj54pAwnmrHccy8vCtCsHfoaxiXyuPaevfboxyBbDjau4fY6+fT1/vsFYuRki+czLi05io3RgQJ4e2QOdRE=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2019 08:36:58.3650
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9df4fb4b-1dea-4701-cfbe-08d70b5b191e
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB3825
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-18_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907180099
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gV2VkLCAyMDE5LTA3LTE3IGF0IDE3OjA3ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBJZiBhbnlvbmUgaGFzIHRpbWUgdG8gc2FuaXR5IGNoZWNr
IHRoZXNlLCBpdCB3b3VsZCBiZSBtdWNoIGFwcHJlY2lhdGVkLg0KPiANCj4gQXQgc29tZXBvaW50
IEknbGwgdGFrZSBhIHZpZXcgb24gdGhlbSBiZWluZyB0b28gZHVsbCB0byBnYXJuZXIgcmV2aWV3
LCBidXQNCj4gSSByZWFsbHkgZG9uJ3QgbGlrZSBhcHBseWluZyBzdHVmZiB0aGF0IGhhc24ndCBo
YWQgYSBzZWNvbmQgc2V0IG9mIGV5ZXMgb24gaXQuDQo+IA0KDQpGb3VuZCBvbmx5IG9uZSBpbmNv
bnNpc3RlbmN5IGluIHBhdGNoIDA3LzE0Lg0KYE1PRFVMRV9MSUNFTlNFKCJHUEwiKWAgdnMgYC8v
IFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wYA0KDQpIb3BlZnVsbHkgdGhhdCBlbWFp
bC9yZXBseSBjb21lcyB0aHJvdWdoIG9uIHRoZSBwYXRjaCBpdHNlbGYuDQpJZiBub3QsIG1heWJl
IHRoaXMgZW1haWwgY29tZXMgdGhyb3VnaC4NCg0KDQo+IFRoYW5rcywNCj4gDQo+IEpvbmF0aGFu
DQo+IA0KPiBPbiBTYXQsIDIyIEp1biAyMDE5IDE1OjU1OjAyICswMTAwDQo+IDxqaWMyM0BrZXJu
ZWwub3JnPiB3cm90ZToNCj4gDQo+ID4gRnJvbTogSm9uYXRoYW4gQ2FtZXJvbiA8Sm9uYXRoYW4u
Q2FtZXJvbkBodWF3ZWkuY29tPg0KPiA+IA0KPiA+IFRoZXJlIGlzIGEgZ2VuZXJhbCBtb3ZlbWVu
dCB0b3dhcmRzIGVuc3VyaW5nIGFsbCBvZiB0aGUga2VybmVsIHNvdXJjZQ0KPiA+IGZpbGVzIGhh
dmUgU1BEWCBoZWFkZXJzLiAgSSBoYXZlIHByZXZpb3VzbHkgZXhwcmVzc2VkIHRoZSB2aWV3LCB0
aGF0LA0KPiA+IGxpa2UgbWFueSBjbGVhbnVwcyBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8gZG8gdGhl
c2Ugd2hlbiBvdGhlcndpc2UgdG91Y2hpbmcNCj4gPiB0aGUgcmVsZXZhbnQgcGFydCBvZiB0aGUg
Y29kZSwgcmF0aGVyIHRoYW4gY3JlYXRpbmcgbm9pc2UgdGhyb3VnaG91dC4NCj4gPiANCj4gPiBU
aW1lIHRvIGNoYW5nZSBteSBtaW5kIG9uIHRoYXQsIGFuZCBwdXNoIHRocm91Z2ggYWRkaW5nIHRo
ZXNlIHRvIElJTy4NCj4gPiANCj4gPiBFdmVuIGluIHRoZSBjb3JlIGNvZGUsIEkgd2FzIGxlc3Mg
dGhhbiBlbnRpcmVseSBjb25zaXN0ZW50IHdpdGggdGhlDQo+ID4gZXhpc3RpbmcgbGljZW5zZSBt
YXJraW5ncywgc28gdGhlcmUgYXJlIHBsYWNlcyB3aGVyZSB0aGUgZmlsZSBoZWFkZXJzDQo+ID4g
ZG9uJ3QgbWF0Y2ggd2l0aCB0aGUgTU9EVUxFX0xJQ0VOU0UgbWFjcm8uDQo+ID4gVGhlcmUgd2Vy
ZSBhbHNvIGhlYWRlcnMgdGhhdCBnYWluZWQgZGVmYXVsdCBTUERYIGxpY2Vuc2UgbWFya2luZ3MN
Cj4gPiB0aGF0IGFjdHVhbGx5IGFyZW4ndCBxdWl0ZSBjb3JyZWN0IGdpdmVuIHRoZSByZWxhdGVk
IGMgZmlsZXMgc29tZXRpbWVzDQo+ID4gZGlkIGhhdmUgd2VsbCBzdGF0ZWQgbGljZW5zZXMuDQo+
ID4gDQo+ID4gSWYgc29tZW9uZSBoYXMgdGltZSB0byBjaGVjayBteSBsb2dpYyBvbiB0aGUgdGhl
c2UgdGhhdCB3b3VsZCBiZSBncmVhdC4NCj4gPiANCj4gPiBGb3IgdGhlIGRyaXZlcnMsIG15IGlu
dGVudCBpcyB0byB1c2UgcmFuZG9tIHBlcmlvZHMgb2YgYm9yZWRvbQ0KPiA+IChJJ20gb24gc29t
ZSBsb25nIGhhdWwgZmxpZ2h0cyBpbiB0aGUgbmVhciBmdXR1cmUpIHRvIHNlZSBpZiBJIGNhbg0K
PiA+IHBsb3VnaCB0aHJvdWdoIHRoZW0uICBJZiBhbnlvbmUgd2FudHMgdG8gZ2V0IGFoZWFkIG9m
IHRoZSBnYW1lIGFuZA0KPiA+IGRvIHRoZWlyIG93biBkcml2ZXJzIHRoYXQgd291bGQgYmUgZ3Jl
YXQuICBUaGlzIGlzIHBhcnRpY3VsYXJseSB0cnVlDQo+ID4gaW4gdGhlIGJpZyBvY3RvcHVzIGRy
aXZlcnMgdGhhdCBzcHJlYWQgdGhyb3VnaG91dCB0aGUgSUlPIGRpcmVjdG9yaWVzDQo+ID4gYW5k
IGJleW9uZC4gIEknZCBsb3ZlIGl0IGlmIG90aGVyIHBlb3BsZSB0b29rIHRob3NlIG9uLg0KPiA+
IA0KPiA+IElmIGluIGRvdWJ0LCBkb24ndCBkbyBhIGdpdmVuIGZpbGUgb3IgcHV0IG91dCBhIGNs
ZWFybHkgd29yZGVkIGVtYWlsDQo+ID4gdG8gdGhlIGxpc3QgYXNraW5nIGZvciBoZWxwIQ0KPiA+
IA0KPiA+IEpvbmF0aGFuIENhbWVyb24gKDE0KToNCj4gPiAgIGlpbzogY29yZTogU1BEWCBoZWFk
ZXJzIGZvciBjb3JlIGZpbGVzLiBOb3RlIGZpeCB0byBNT0RVTEVfTElDRU5TRQ0KPiA+ICAgaWlv
OmNvbmZpZ2ZzOiBTUERYIGhlYWRlcnMuDQo+ID4gICBpaW86IHN3LWRldmljZTogU1BEWCBoZWFk
ZXJzDQo+ID4gICBpaW86IHN3LXRyaWdnZXI6IFNQRFggaGVhZGVycy4NCj4gPiAgIGlpbzogdHJp
Z2dlcmVkLWV2ZW50OiBBZGQgU1BEWCBhbmQgZml4IGhlYWRlciBsaWNlbnNlIHRvIG1hdGNoIHRo
ZQ0KPiA+ICAgICBjb2RlLg0KPiA+ICAgaWlvOmJ1ZmZlci1kbWE6IFNQRFggaGVhZGVycy4NCj4g
PiAgIGlpbzogYnVmZmVyLWNiOiBTUERYIGhlYWRlcnMNCj4gPiAgIGlpbzoga2ZpZm8tYnVmOiBB
ZGQgU1BEWCBoZWFkZXINCj4gPiAgIGlpbzogYnVmZmVyLWRtYWVuZ2luZTogU1BEWCBHUEwtMi4w
Kw0KPiA+ICAgaWlvOiB0cmlnZ2VyZWQtYnVmZmVyOiBTUERYICsgZml4IE1PRFVMRV9MSUNFTlNF
IHRvIEdQTHYyDQo+ID4gICBpaW86IHRyaWctaHJ0aW1lcjogU1BEWCBoZWFkZXIgR1BMdjINCj4g
PiAgIGlpbzogdHJpZy1pbnRlcnJ1cHQ6IFNQRFggaGVhZGVycy4gR1BMdjINCj4gPiAgIGlpbzog
dHJpZy1sb29wOiBTUERYIGhlYWRlcnMgR1BMLXYyDQo+ID4gICBpaW86IHRyaWctc3lzZnM6IFNQ
RFggaGVhZGVycyBHUEx2Mi4NCj4gPiANCj4gPiAgZHJpdmVycy9paW8vYnVmZmVyL2luZHVzdHJp
YWxpby1idWZmZXItY2IuYyAgICAgICAgfCAgOCArKystLS0tLQ0KPiA+ICBkcml2ZXJzL2lpby9i
dWZmZXIvaW5kdXN0cmlhbGlvLWJ1ZmZlci1kbWEuYyAgICAgICB8ICAzICstLQ0KPiA+ICBkcml2
ZXJzL2lpby9idWZmZXIvaW5kdXN0cmlhbGlvLWJ1ZmZlci1kbWFlbmdpbmUuYyB8ICAzICstLQ0K
PiA+ICBkcml2ZXJzL2lpby9idWZmZXIvaW5kdXN0cmlhbGlvLXRyaWdnZXJlZC1idWZmZXIuYyB8
ICA5ICsrKy0tLS0tLQ0KPiA+ICBkcml2ZXJzL2lpby9idWZmZXIva2ZpZm9fYnVmLmMgICAgICAg
ICAgICAgICAgICAgICB8ICAxICsNCj4gPiAgZHJpdmVycy9paW8vaWlvX2NvcmUuaCAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgOCArKystLS0tLQ0KPiA+ICBkcml2ZXJzL2lpby9paW9f
Y29yZV90cmlnZ2VyLmggICAgICAgICAgICAgICAgICAgICB8ICAyICstDQo+ID4gIGRyaXZlcnMv
aWlvL2luZHVzdHJpYWxpby1idWZmZXIuYyAgICAgICAgICAgICAgICAgIHwgIDggKysrLS0tLS0N
Cj4gPiAgZHJpdmVycy9paW8vaW5kdXN0cmlhbGlvLWNvbmZpZ2ZzLmMgICAgICAgICAgICAgICAg
fCAgNSArLS0tLQ0KPiA+ICBkcml2ZXJzL2lpby9pbmR1c3RyaWFsaW8tY29yZS5jICAgICAgICAg
ICAgICAgICAgICB8IDEwICsrKystLS0tLS0NCj4gPiAgZHJpdmVycy9paW8vaW5kdXN0cmlhbGlv
LWV2ZW50LmMgICAgICAgICAgICAgICAgICAgfCAgNCArKystDQo+ID4gIGRyaXZlcnMvaWlvL2lu
ZHVzdHJpYWxpby1zdy1kZXZpY2UuYyAgICAgICAgICAgICAgIHwgIDUgKy0tLS0NCj4gPiAgZHJp
dmVycy9paW8vaW5kdXN0cmlhbGlvLXN3LXRyaWdnZXIuYyAgICAgICAgICAgICAgfCAgNSArLS0t
LQ0KPiA+ICBkcml2ZXJzL2lpby9pbmR1c3RyaWFsaW8tdHJpZ2dlci5jICAgICAgICAgICAgICAg
ICB8ICA4ICsrKy0tLS0tDQo+ID4gIGRyaXZlcnMvaWlvL2luZHVzdHJpYWxpby10cmlnZ2VyZWQt
ZXZlbnQuYyAgICAgICAgIHwgIDYgKy0tLS0tDQo+ID4gIGRyaXZlcnMvaWlvL2lua2Vybi5jICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDggKysrLS0tLS0NCj4gPiAgZHJpdmVycy9p
aW8vdHJpZ2dlci9paW8tdHJpZy1ocnRpbWVyLmMgICAgICAgICAgICAgfCAgNiArLS0tLS0NCj4g
PiAgZHJpdmVycy9paW8vdHJpZ2dlci9paW8tdHJpZy1pbnRlcnJ1cHQuYyAgICAgICAgICAgfCAg
NSArLS0tLQ0KPiA+ICBkcml2ZXJzL2lpby90cmlnZ2VyL2lpby10cmlnLWxvb3AuYyAgICAgICAg
ICAgICAgICB8ICAzICstLQ0KPiA+ICBkcml2ZXJzL2lpby90cmlnZ2VyL2lpby10cmlnLXN5c2Zz
LmMgICAgICAgICAgICAgICB8ICA0ICstLS0NCj4gPiAgaW5jbHVkZS9saW51eC9paW8vYnVmZmVy
LWRtYS5oICAgICAgICAgICAgICAgICAgICAgfCAgMyArLS0NCj4gPiAgaW5jbHVkZS9saW51eC9p
aW8vYnVmZmVyLWRtYWVuZ2luZS5oICAgICAgICAgICAgICAgfCAgMyArLS0NCj4gPiAgaW5jbHVk
ZS9saW51eC9paW8vYnVmZmVyLmggICAgICAgICAgICAgICAgICAgICAgICAgfCAgOCArKystLS0t
LQ0KPiA+ICBpbmNsdWRlL2xpbnV4L2lpby9jb25maWdmcy5oICAgICAgICAgICAgICAgICAgICAg
ICB8ICA1ICstLS0tDQo+ID4gIGluY2x1ZGUvbGludXgvaWlvL2NvbnN1bWVyLmggICAgICAgICAg
ICAgICAgICAgICAgIHwgIDUgKy0tLS0NCj4gPiAgaW5jbHVkZS9saW51eC9paW8vZHJpdmVyLmgg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgNSArLS0tLQ0KPiA+ICBpbmNsdWRlL2xpbnV4L2lp
by9ldmVudHMuaCAgICAgICAgICAgICAgICAgICAgICAgICB8ICA4ICsrKy0tLS0tDQo+ID4gIGlu
Y2x1ZGUvbGludXgvaWlvL2lpby5oICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDkgKysr
LS0tLS0tDQo+ID4gIGluY2x1ZGUvbGludXgvaWlvL2tmaWZvX2J1Zi5oICAgICAgICAgICAgICAg
ICAgICAgIHwgIDIgKy0NCj4gPiAgaW5jbHVkZS9saW51eC9paW8vbWFjaGluZS5oICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgNSArLS0tLQ0KPiA+ICBpbmNsdWRlL2xpbnV4L2lpby9zd19kZXZp
Y2UuaCAgICAgICAgICAgICAgICAgICAgICB8ICA1ICstLS0tDQo+ID4gIGluY2x1ZGUvbGludXgv
aWlvL3N3X3RyaWdnZXIuaCAgICAgICAgICAgICAgICAgICAgIHwgIDUgKy0tLS0NCj4gPiAgaW5j
bHVkZS9saW51eC9paW8vc3lzZnMuaCAgICAgICAgICAgICAgICAgICAgICAgICAgfCAxMCArKysr
LS0tLS0tDQo+ID4gIGluY2x1ZGUvbGludXgvaWlvL3RyaWdnZXIuaCAgICAgICAgICAgICAgICAg
ICAgICAgIHwgIDUgKy0tLS0NCj4gPiAgaW5jbHVkZS9saW51eC9paW8vdHJpZ2dlcl9jb25zdW1l
ci5oICAgICAgICAgICAgICAgfCAgOCArKystLS0tLQ0KPiA+ICBpbmNsdWRlL2xpbnV4L2lpby90
cmlnZ2VyZWRfZXZlbnQuaCAgICAgICAgICAgICAgICB8ICAyICstDQo+ID4gIGluY2x1ZGUvbGlu
dXgvaWlvL3R5cGVzLmggICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDggKysrLS0tLS0NCj4g
PiAgMzcgZmlsZXMgY2hhbmdlZCwgNjcgaW5zZXJ0aW9ucygrKSwgMTQwIGRlbGV0aW9ucygtKQ0K
PiA+IA0KPiANCj4gDQo=
