Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F12C5836F
	for <lists+linux-iio@lfdr.de>; Thu, 27 Jun 2019 15:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfF0N2G (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Jun 2019 09:28:06 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:60978 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726370AbfF0N2F (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Jun 2019 09:28:05 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5RDMnht007590;
        Thu, 27 Jun 2019 09:28:00 -0400
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp2056.outbound.protection.outlook.com [104.47.41.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2tcut7ggrh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 27 Jun 2019 09:27:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=QvEtZKbLdIK9QjHYOb4Usj22gbNX1wxU4D7eYAQc+jFdgtx11yd6TJfJwoqqkBWOv0oU4PL6tjBy20Va8tZXpxsN1MYZ7KiXBpXHP3Ex5surgvUKxTfxx2tUeqqfnFSf/n+TCd9J5M1yjLmgXFUmPCQCvTEL0f3Zxi9I6lUFDvE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhEz9AgUqf+/4ZR8Cls1I2/WsezVECWjUa8NU0FNtoo=;
 b=O5q9I2L9L2gD7CrmQnwiMmMQ8JlVPXxmYcwhIzA6e7vIc2Jx9pIMPCmUGa32f1Rl1TOB0G6JaydQX2gD68ObsSugxnGEpGojMXckn8DT0jRX4+M22dQnaCdbl1iAl9hFhKi+e2Iasle2I4yPsmyM+Sjx6VBf6VOdiP2bz48mmrA=
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=analog.com;dmarc=bestguesspass action=none
 header.from=analog.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhEz9AgUqf+/4ZR8Cls1I2/WsezVECWjUa8NU0FNtoo=;
 b=5OQO2Y4EUd/3MIY45s7HZBZmaugWkqth6RLHIsOmSbWHkMN8ZwhACBIjYCNPtKxje6lZ0gxpcAZs18CHoyYyMEUoYIShfdO3sgJ2U+mHV6R42IYLYHtzjlKO3ZygNT9bJsIacjr4ziS5sUo97dec9iZBkJJpeQVUsS6ceYjb4WA=
Received: from BYAPR03CA0011.namprd03.prod.outlook.com (2603:10b6:a02:a8::24)
 by BLUPR03MB550.namprd03.prod.outlook.com (2a01:111:e400:880::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.16; Thu, 27 Jun
 2019 13:26:53 +0000
Received: from CY1NAM02FT047.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by BYAPR03CA0011.outlook.office365.com
 (2603:10b6:a02:a8::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2008.16 via Frontend
 Transport; Thu, 27 Jun 2019 13:26:52 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT047.mail.protection.outlook.com (10.152.74.177) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2032.15
 via Frontend Transport; Thu, 27 Jun 2019 13:26:52 +0000
Received: from NWD2HUBCAS9.ad.analog.com (nwd2hubcas9.ad.analog.com [10.64.69.109])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x5RDQo25010992
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 27 Jun 2019 06:26:50 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS9.ad.analog.com ([fe80::44a2:871b:49ab:ea47%12]) with mapi id
 14.03.0415.000; Thu, 27 Jun 2019 09:26:51 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@jic23.retrosnub.co.uk" <jic23@jic23.retrosnub.co.uk>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/5] MAINTAINERS: add ADIS IMU driver library entry
Thread-Topic: [PATCH 1/5] MAINTAINERS: add ADIS IMU driver library entry
Thread-Index: AQHVK1fR/223EaeGrkunacjbMzAGl6auh3iAgAE80oA=
Date:   Thu, 27 Jun 2019 13:26:50 +0000
Message-ID: <0e47b26902a7fc41cb4bc633633b6b9426853da7.camel@analog.com>
References: <20190625131328.11883-1-alexandru.ardelean@analog.com>
         <20190626193247.09006ac4@archlinux>
In-Reply-To: <20190626193247.09006ac4@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.65.145]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <686CC9F63A84C94FBE8D98D8F4ADB3EC@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(376002)(396003)(2980300002)(189003)(199004)(102836004)(118296001)(86362001)(356004)(305945005)(186003)(6916009)(23676004)(7696005)(2501003)(5660300002)(2486003)(336012)(7736002)(7636002)(2351001)(70586007)(106002)(8676002)(70206006)(2616005)(36756003)(486006)(11346002)(2906002)(426003)(6246003)(476003)(14454004)(478600001)(54906003)(229853002)(47776003)(436003)(316002)(76176011)(126002)(26005)(6116002)(3846002)(5640700003)(246002)(4326008)(446003)(50466002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR03MB550;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6db0edd6-09d4-454a-01a6-08d6fb031def
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:BLUPR03MB550;
X-MS-TrafficTypeDiagnostic: BLUPR03MB550:
X-Microsoft-Antispam-PRVS: <BLUPR03MB550EA4C78D4D7B5368D80C5F9FD0@BLUPR03MB550.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 008184426E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: G0uMtr5/orel0Nt3rOFa+McqKNOgp0EjIEJRyn3HxLj/DuG6zJyOJ5tBsFvRzL+s7bed+k0hpNXs+HFhhLjRhChOWaCveL6sPHbW6y5h2+VBrUh+6Z1+9GIvyd+6xM3qiOAALvRyLXZ6hc4Xs0rumxePvxk59fEEIuHNFtT8qLJ3AsTnEuFBQxu7zOCAcyzwZRxLxq90Z++Y8STaV0ZuWsGxuU2s67E83KHyyWa5xYTsQ0KYgiYFv7tDz3jwK7wDH/n1MEizevblWIvsHjRLcC0JZ6Zv8vI2YjCOrvECRD2AMmVuZXMo2AUtFKf6/D8+i7PHSri3Q6W39pqeYzkJemdHCiRG9JBqQFhsTdDslAK527X5nELfxoKbb6hhfCXmfUzqgXVd/q8z2CXVQ6tP8QV9LSJGlSue1jTzbmY9lJc=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2019 13:26:52.0886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6db0edd6-09d4-454a-01a6-08d6fb031def
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR03MB550
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-27_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906270157
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gV2VkLCAyMDE5LTA2LTI2IGF0IDE5OjMyICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBUdWUsIDI1IEp1biAyMDE5IDE2OjEzOjI0ICswMzAw
DQo+IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+IHdy
b3RlOg0KPiANCj4gPiBUaGlzIGNoYW5nZSBhZGRzIHRoZSBBRElTIGRyaXZlciBsaWJyYXJ5IHRv
IHRoZSBNQUlOVEFJTkVSUyBsaXN0LCBhbmQgYWRkcw0KPiA+IG15c2VsZiBhcyB0aGUgY3VycmVu
dCBtYWludGFpbmVyIG9mIHRoaXMgbGlicmFyeS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBB
bGV4YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPg0KPiBIaSBB
bGV4YW5kcnUsDQo+IA0KPiBHaXZlbiB0aGlzIG9ubHkgaGFzIGEgdGFuZ2VudGlhbCByZWxhdGlv
bnNoaXAgdG8gdGhlIHJlc3Qgb2YgdGhlIHBhdGNoZXMNCj4gSSdsbCBwaWNrIHVwIG5vdy4NCj4g
DQo+IE1vcmUgZ2VuZXJhbGx5IHRoaXMgc2VyaWVzIGlzIGNvbXBsZXggZW5vdWdoIGEgY292ZXIg
bGV0dGVyIHdvdWxkIGhhdmUNCj4gYmVlbiBnb29kICsgNS81IGlzbid0IGFueXdoZXJlIHRoYXQg
SSBjYW4gZmluZD8NCg0KVGhhdCBpcyBhIGJpdCB3ZWlyZC4NCkkgZ3Vlc3Mgb3VyIG1haWwgc2Vy
dmVyIHdlbnQgYSBsaXR0bGUgYnVzdCB3aGVuIHNlbmRpbmcgdGhlIHNlcmllcyBhbmQgZHJvcHBl
ZCB0aGUgc2VyaWVzLg0KDQpTb3JyeSBhYm91dCB0aGF0Lg0KQWxleA0KDQo+IA0KPiANCj4gVGhh
bmtzLA0KPiANCj4gSm9uYXRoYW4NCj4gDQo+ID4gLS0tDQo+ID4gIE1BSU5UQUlORVJTIHwgNyAr
KysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBk
aWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUw0KPiA+IGluZGV4IDFlYjk3MTYw
OGFjNC4uNTQ0ZTIzNzUzZTk2IDEwMDY0NA0KPiA+IC0tLSBhL01BSU5UQUlORVJTDQo+ID4gKysr
IGIvTUFJTlRBSU5FUlMNCj4gPiBAQCAtOTMwLDYgKzkzMCwxMyBAQCBTOglTdXBwb3J0ZWQNCj4g
PiAgRjoJZHJpdmVycy9tdXgvYWRnczE0MDguYw0KPiA+ICBGOglEb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvbXV4L2FkaSxhZGdzMTQwOC50eHQNCj4gPiAgDQo+ID4gK0FOQUxPRyBE
RVZJQ0VTIElOQyBBRElTIERSSVZFUiBMSUJSQVJZDQo+ID4gK006CUFsZXhhbmRydSBBcmRlbGVh
biA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+DQo+ID4gK1M6CVN1cHBvcnRlZA0KPiA+
ICtMOglsaW51eC1paW9Admdlci5rZXJuZWwub3JnDQo+ID4gK0Y6CWluY2x1ZGUvbGludXgvaWlv
L2ltdS9hZGlzLmgNCj4gPiArRjoJZHJpdmVycy9paW8vaW11L2FkaXMuYw0KPiA+ICsNCj4gPiAg
QU5BTE9HIERFVklDRVMgSU5DIEFEUDUwNjEgRFJJVkVSDQo+ID4gIE06CVN0ZWZhbiBQb3BhIDxz
dGVmYW4ucG9wYUBhbmFsb2cuY29tPg0KPiA+ICBMOglsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmcN
Cg==
