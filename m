Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0071D7BA09
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2019 08:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfGaG6v (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 31 Jul 2019 02:58:51 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:19452 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726164AbfGaG6v (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 31 Jul 2019 02:58:51 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6V6w951004925;
        Wed, 31 Jul 2019 02:58:45 -0400
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp2055.outbound.protection.outlook.com [104.47.41.55])
        by mx0a-00128a01.pphosted.com with ESMTP id 2u2nnrtkbd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 31 Jul 2019 02:58:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFmBFQP/T6g3LceY7TMqESyU6nzNyyCqprzC903XE2A6WclGVsEW0QZ6KKx5yzOdDITmpdJbEf11ifPMn34qTF3n6flITU+ezsXUYwVJwEQ0b8QbYqMr4+PuCbL9AjOnENaoXEoJxF/kQD0Itei/j8PM/qMajOMKvt4l0mE9WkIhPevrP+h0FD/qcAdRWGGJWa0vw4Tfk4ecP8EccugB4Qq9Gla35pwRcCXuIrRrVC/FlUdwuImPg/YnY8uq4uunCC/aRDOH5VIOU4cuKvziZ+D3Z2cgiRzTREcUW62s1GNDmckwKQi0jb9AeB1fgwawbow6dG4P5amdGfUyo8w1ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4mbmUgaNVuEE6dQas7mf06+a8ShbHzqWorthx/rzjU=;
 b=jh17oCnhlO/NjmRtfxyiYIxvXo38sona1zTI0jaLpmX6fvhIgxBryJ/aJBiUkae4SJSVK/bQCFLd825377pXby4M4ABVZFR2NlVbzJcLWfddjSvtj4411nvtjsXk8PMCoQ7YhGWtnoDvFcHBAd4lryChHOSOicy/n9F3ndoPRcAARt6iQH7sYSWWGYMDL12pCz0yODqO/kNW29upQ8xKI975lAau8b9tE3yHzFXsoV7uV0Rmd/p8DDVEoS0NBq/QKJjr/nUcS/q+DZ5kzYE06huM9gB5hUh3mBNo4BPcGT4wHyZPqjt74ir6hoEyrEpk04R73LG68reBl4HpawuHgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=analog.com;dmarc=bestguesspass action=none
 header.from=analog.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4mbmUgaNVuEE6dQas7mf06+a8ShbHzqWorthx/rzjU=;
 b=oGVNcgOwr4ZW8lUiZcU+TX27zgGexLNpgJRNs/SnYQKFBiRPAA/tfdqz+Qs51Nbn20uoVYhq0wdUfOsteZislFamyuNdx0vAkXfabq5212pd/T9eLweUq295DuRVQQBZSFiXVj8dCr0f63oN5XDbd7pr6MdgKpJ4nKibunXDJdA=
Received: from BN3PR03CA0051.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::11) by CY4PR03MB3350.namprd03.prod.outlook.com
 (2603:10b6:910:51::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2115.15; Wed, 31 Jul
 2019 06:58:42 +0000
Received: from BL2NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by BN3PR03CA0051.outlook.office365.com
 (2a01:111:e400:7a4d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2115.14 via Frontend
 Transport; Wed, 31 Jul 2019 06:58:42 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT062.mail.protection.outlook.com (10.152.77.57) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2115.10
 via Frontend Transport; Wed, 31 Jul 2019 06:58:42 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x6V6wf3l020792
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 30 Jul 2019 23:58:41 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS7.ad.analog.com ([fe80::595b:ced1:cc03:539d%12]) with mapi id
 14.03.0415.000; Wed, 31 Jul 2019 02:58:41 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "denis.ciocca@st.com" <denis.ciocca@st.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 4/4] iio:pressure: preenable/postenable/predisable fixup
 for ST press buffer
Thread-Topic: [PATCH 4/4] iio:pressure: preenable/postenable/predisable
 fixup for ST press buffer
Thread-Index: AQHVRmtMbiZafreu3ECyaDkYRYEN1KbjU32AgABEu4CAASsNgA==
Date:   Wed, 31 Jul 2019 06:58:40 +0000
Message-ID: <2e2683cd5cbee9b8157d3c49ae674f5b48cb3a4c.camel@analog.com>
References: <20190730000305.30958-1-denis.ciocca@st.com>
         <20190730000305.30958-5-denis.ciocca@st.com>
         <c73657b4203d8112636751413c85f525f57dcc2a.camel@analog.com>
         <VE1PR10MB291275F4B3C439A1B86F8579EDDC0@VE1PR10MB2912.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <VE1PR10MB291275F4B3C439A1B86F8579EDDC0@VE1PR10MB2912.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.65.108]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <73C81CB381FC0C4191FBE1F7E33595F7@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(346002)(396003)(2980300002)(189003)(199004)(13464003)(7636002)(246002)(305945005)(478600001)(7736002)(356004)(966005)(5660300002)(2501003)(8936002)(2201001)(14454004)(6246003)(8676002)(486006)(126002)(476003)(2616005)(229853002)(50466002)(2906002)(53546011)(102836004)(336012)(436003)(76176011)(14444005)(26005)(186003)(3846002)(106002)(110136005)(5024004)(6116002)(316002)(70206006)(36756003)(86362001)(70586007)(47776003)(7696005)(6306002)(2486003)(11346002)(118296001)(446003)(426003)(23676004);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB3350;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02c311f8-6a77-4907-d299-08d7158485d2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:CY4PR03MB3350;
X-MS-TrafficTypeDiagnostic: CY4PR03MB3350:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <CY4PR03MB3350127BA12A55F74357D616F9DF0@CY4PR03MB3350.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 011579F31F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: KQNcWm6W23lC8t6OJXBet2yp2S2YjSViblC1ezevSp/s2mCLnBq4WYybiShzg0KPOkMazg7BTwz9TUXFMI0672rVKbJk2MsaRB+uze+UFL26Q8WATN3hrCZTnjMhSh2OcaeyflTtAUFOPqRwNh4rvzoQBPDl2PFqsIYtBw7bYMVXnO0wmTpFuETn1TzJoSGWOVMC3JBonOm7lE6V10FLYTpSgnMIvHIYpyVA4SFNJDZOZwYhMvct1JOm26X9pGq3OxM16rGlhtD66RbLSUZfEXdFnwb5LM+rotBypqJfj2MP//pUHbGQjr38dWlPRTZw5CN7BNSRFmLzMwsC4fGcJdbDKz3PFJevSZFBjEZJ2feh1ARRq/IwC3zHqi4AthP+4CPEpwJECFV/OfyKXqFC2pCl0b8KjBabfa7bFWEoZAI=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2019 06:58:42.0336
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02c311f8-6a77-4907-d299-08d7158485d2
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3350
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-31_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907310073
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDE5LTA3LTMwIGF0IDE2OjA4ICswMDAwLCBEZW5pcyBDSU9DQ0Egd3JvdGU6DQo+
IFtFeHRlcm5hbF0NCj4gDQo+IEhpIEFsZXhhbmRydSwNCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBBcmRlbGVhbiwgQWxleGFuZHJ1IDxhbGV4YW5kcnUuQXJk
ZWxlYW5AYW5hbG9nLmNvbT4NCj4gPiBTZW50OiBUdWVzZGF5LCBKdWx5IDMwLCAyMDE5IDI6MDIg
QU0NCj4gPiBUbzogamljMjNAa2VybmVsLm9yZzsgRGVuaXMgQ0lPQ0NBIDxkZW5pcy5jaW9jY2FA
c3QuY29tPjsgbGludXgtDQo+ID4gaWlvQHZnZXIua2VybmVsLm9yZw0KPiA+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggNC80XSBpaW86cHJlc3N1cmU6IHByZWVuYWJsZS9wb3N0ZW5hYmxlL3ByZWRpc2Fi
bGUNCj4gPiBmaXh1cCBmb3IgU1QgcHJlc3MgYnVmZmVyDQo+ID4gDQo+ID4gT24gTW9uLCAyMDE5
LTA3LTI5IGF0IDE3OjAzIC0wNzAwLCBEZW5pcyBDaW9jY2Egd3JvdGU6DQo+ID4gPiBbRXh0ZXJu
YWxdDQo+ID4gPiANCj4gPiA+IFRoaXMgcGF0Y2ggaXMgdHJ5aW5nIHRvIGNsZWFudXAgZm9yIGdv
b2QgdGhlIGJ1ZmZlcnMgb3BlcmF0aW9uIGZ1bmN0aW9ucy4NCj4gPiA+IFRoZXJlIGlzIG5vIG5l
ZWQgb2YgdXNpbmcgcHJlZW5hYmxlLCBhbGwgY2FuIGJlIGRvbmUgaW50byBwb3N0ZW5hYmxlLg0K
PiA+ID4gTGV0J3MgYWxzbyB1c2UgbG9naWNhbCBzZXF1ZW5jZSBvZiBvcGVyYXRpb25zIGFzIGFs
cmVhZHkgZG9uZSBpbiBhY2NlbA0KPiA+ID4gZHJpdmVyLg0KPiA+ID4gRmluYWxseSBhbHNvIHJl
bmFtZSB0aGUgZ290byBsYWJlbCB1c2luZyBvcGVyYXRpb24gdG8gcGVyZm9ybSBhbmQgbm90DQo+
ID4gPiB3aGVyZSBpdCBmYWlscy4NCj4gPiA+IA0KPiA+IA0KPiA+IFJldmlld2VkLWJ5OiBBbGV4
YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPg0KPiA+IA0KPiA+
IA0KPiA+IFVucmVsYXRlZCB0byB0aGlzIHBhdGNoLCBJIHdhcyB0aGlua2luZyB0aGF0IGl0IHdv
dWxkIGJlIGEgbmVhdCBpZGVhIHRvIG1vdmUNCj4gPiB0aGUgYGJ1ZmZlcl9kYXRhYCBhbGxvY2F0
aW9uIGluDQo+ID4gYGRyaXZlcnMvaWlvL2NvbW1vbi9zdF9zZW5zb3JzL3N0X3NlbnNvcnNfYnVm
ZmVyLmNgDQo+ID4gDQo+ID4gVGhpcyB3b3VsZCByZW1vdmUgc29tZSBkdXBsaWNhdGlvbiBvZiB0
aGlzIGFsbG9jICsgZnJlZSBpbiBkcml2ZXJzLg0KPiA+IA0KPiA+IE1heWJlIGluIHN0X3NlbnNv
cnNfdHJpZ2dlcl9oYW5kbGVyKCkgc29tZXRoaW5nIGxpa2U6DQo+ID4gDQo+ID4gaWYgKCFzZGF0
YS0+YnVmZmVyX2RhdGEpIHsNCj4gPiAgICAgc2RhdGEtPmJ1ZmZlcl9kYXRhID0gZGV2bV9rbWFs
bG9jKCkNCj4gPiAgICAgaWYgKCFzZGF0YS0+YnVmZmVyX2RhdGEpIHsNCj4gPiAgICAgICAgIGRl
dl9lcnIoaW5kaW9fZGV2LT5kZXYsICJGYWlsZWQgdG8gYWxsb2NhdGUgYnVmZmVyIGRhdGFcbiIp
Ow0KPiA+ICAgICAgICAgZ290byBzdF9zZW5zb3JzX2dldF9idWZmZXJfZWxlbWVudF9lcnJvcjsN
Cj4gPiAgICAgfQ0KPiA+IH0NCj4gPiANCj4gPiBVc2luZyBkZXZtX2ttYWxsb2MoKSBvciBhIHNp
bWlsYXIgZGV2bV8gdmFyaWFudCB3b3VsZCBiZSBuZWF0LCBzaW5jZSBpdCBnZXRzDQo+ID4gZnJl
ZSdkIHdoZW4gdGhlIGRldmljZSBnZXRzIHJlbW92ZWQuDQo+IA0KPiBOb3Qgc3VyZSBhYm91dCB0
aGUgc29sdXRpb24gcHJvcG9zZWQuDQo+IE1lbW9yeSBhbGxvY2F0aW9uIGlzIGFjdHVhbGx5IHJl
bGF0ZWQgdG8gaG93IG1hbnkgY2hhbm5lbHMgYXJlIGVuYWJsZWQsDQo+IG9uZSBwb3NzaWJpbGl0
eSBjb3VsZCBiZSB0byBhbGxvY2F0ZSB0aGUgbWF4aW11bSBidXQgbm90IHN1cmUgaXQncyB3b3J0
aC4uLg0KPiBNb3Jlb3ZlciB0aGUgbWVtb3J5IGFsbG9jYXRpb24gdGhlcmUgY291bGQgbGV0IGRy
aXZlciBtaXNzIHRoZSBmaXJzdCBzYW1wbGUgSSBndWVzcy4NCj4gDQoNCkkgc2VlLg0KV291bGQg
W3RoZW5dIG1vdmluZyB0aGUgYWxsb2NhdGlvbiBpbiBwcmVlbmFibGUgd29yaz8gYW5kIHRoZSBm
cmVlIGluIHBvc3RkaXNhYmxlPw0KDQpUaGluZyBpczogd2hlbiBpaW9fdHJpZ2dlcmVkX2J1ZmZl
cl9wb3N0ZW5hYmxlKCkgYW5kIGlpb190cmlnZ2VyZWRfYnVmZmVyX3ByZWRpc2FibGUoKSBnZXQg
cmVtb3ZlZCAoYW5kIGxvZ2ljIG1vdmVkIGludG8NCmNvcmUpLCB0aGVuIHRoZSBvcmRlciBjaGFu
Z2VzLCBhbmQgdGhlIGF0dGFjaCBwb2xsZnVuYyBnZXRzIGNhbGxlZCBiZWZvcmUgdGhlIGFsbG9j
YXRpb24uDQoNCg0KVGhlIGZpbmFsIGRlc3RpbmF0aW9uIGZvciB0aGVzZSBjaGFuZ2VzIGlzIHRo
aXMgY29tbWl0Og0KaHR0cHM6Ly9naXRodWIuY29tL2FuYWxvZ2RldmljZXNpbmMvbGludXgvY29t
bWl0L2VlZTk3ZDEyNjY1ZmVmOGMjZGlmZi0wYTg3NzQ0Y2U5NDVkMmMxYzg5ZWExOWYyMWZiMzVi
YlI3MjINClt0aGlzIGFuIG9sZGVyIGZvcm1dDQpJbiB0aGlzIGNvbW1pdCwgdGhlIGF0dGFjaC9k
ZXRhY2ggb2YgdGhlIHBvbGxfZnVuYyBpcyBtb3ZlZCBpbnRvIGNvcmUsIHNpbmNlIHRoYXQgaXMg
YWxsIHRoYXQgdGhlIDIgZnVuY3Rpb25zIGRvDQooaWlvX3RyaWdnZXJlZF9idWZmZXJfcG9zdGVu
YWJsZSgpIGFuZCBpaW9fdHJpZ2dlcmVkX2J1ZmZlcl9wcmVkaXNhYmxlKCkpDQoNCldoZW4gdGhl
IG1vdmUgaGFwcGVucyBbZm9yIHRoZSBTVCBkcml2ZXJzIGluIHBhcnRpY3VsYXJdIHRoZSBwb2xs
X2Z1bmMgaXMgYXR0YWNoZWQsIGFuZCB0aGVuIHRoZSBhbGxvY2F0aW9uIGlzIGRvbmUsIGFuZA0K
dGhlIGZyZWUgaXMgZG9uZSBmaXJzdCwgYW5kIHRoZW4gdGhlIHBvbGxfZnVuYyBpcyBkZXRhY2hl
ZC4NCg0KDQo+IA0KPiA+IFRoYW5rcw0KPiA+IEFsZXgNCj4gPiANCj4gPiA+IFNpZ25lZC1vZmYt
Ynk6IERlbmlzIENpb2NjYSA8ZGVuaXMuY2lvY2NhQHN0LmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4g
IGRyaXZlcnMvaWlvL3ByZXNzdXJlL3N0X3ByZXNzdXJlX2J1ZmZlci5jIHwgMzINCj4gPiA+ICsr
KysrKysrLS0tLS0tLS0tLS0tLS0tDQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlv
bnMoKyksIDIxIGRlbGV0aW9ucygtKQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9paW8vcHJlc3N1cmUvc3RfcHJlc3N1cmVfYnVmZmVyLmMNCj4gPiA+IGIvZHJpdmVycy9paW8v
cHJlc3N1cmUvc3RfcHJlc3N1cmVfYnVmZmVyLmMNCj4gPiA+IGluZGV4IGYyMWI2MzBhYmFhMC4u
NTQ4MjNjZmNmYWI1IDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9paW8vcHJlc3N1cmUvc3Rf
cHJlc3N1cmVfYnVmZmVyLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvaWlvL3ByZXNzdXJlL3N0X3By
ZXNzdXJlX2J1ZmZlci5jDQo+ID4gPiBAQCAtMjksNTMgKzI5LDQzIEBAIGludCBzdF9wcmVzc190
cmlnX3NldF9zdGF0ZShzdHJ1Y3QgaWlvX3RyaWdnZXIgKnRyaWcsDQo+ID4gYm9vbCBzdGF0ZSkN
Cj4gPiA+ICAJcmV0dXJuIHN0X3NlbnNvcnNfc2V0X2RhdGFyZWFkeV9pcnEoaW5kaW9fZGV2LCBz
dGF0ZSk7ICB9DQo+ID4gPiANCj4gPiA+IC1zdGF0aWMgaW50IHN0X3ByZXNzX2J1ZmZlcl9wcmVl
bmFibGUoc3RydWN0IGlpb19kZXYgKmluZGlvX2RldikgLXsNCj4gPiA+IC0JcmV0dXJuIHN0X3Nl
bnNvcnNfc2V0X2VuYWJsZShpbmRpb19kZXYsIHRydWUpOw0KPiA+ID4gLX0NCj4gPiA+IC0NCj4g
PiA+ICBzdGF0aWMgaW50IHN0X3ByZXNzX2J1ZmZlcl9wb3N0ZW5hYmxlKHN0cnVjdCBpaW9fZGV2
ICppbmRpb19kZXYpICB7DQo+ID4gPiAtCWludCBlcnI7DQo+ID4gPiAgCXN0cnVjdCBzdF9zZW5z
b3JfZGF0YSAqcHJlc3NfZGF0YSA9IGlpb19wcml2KGluZGlvX2Rldik7DQo+ID4gPiArCWludCBl
cnI7DQo+ID4gPiANCj4gPiA+ICAJcHJlc3NfZGF0YS0+YnVmZmVyX2RhdGEgPSBrbWFsbG9jKGlu
ZGlvX2Rldi0+c2Nhbl9ieXRlcywNCj4gPiA+ICAJCQkJCSAgR0ZQX0RNQSB8IEdGUF9LRVJORUwp
Ow0KPiA+ID4gLQlpZiAocHJlc3NfZGF0YS0+YnVmZmVyX2RhdGEgPT0gTlVMTCkgew0KPiA+ID4g
LQkJZXJyID0gLUVOT01FTTsNCj4gPiA+IC0JCWdvdG8gYWxsb2NhdGVfbWVtb3J5X2Vycm9yOw0K
PiA+ID4gLQl9DQo+ID4gPiArCWlmICghcHJlc3NfZGF0YS0+YnVmZmVyX2RhdGEpDQo+ID4gPiAr
CQlyZXR1cm4gLUVOT01FTTsNCj4gPiA+IA0KPiA+ID4gIAllcnIgPSBpaW9fdHJpZ2dlcmVkX2J1
ZmZlcl9wb3N0ZW5hYmxlKGluZGlvX2Rldik7DQo+ID4gPiAgCWlmIChlcnIgPCAwKQ0KPiA+ID4g
LQkJZ290byBzdF9wcmVzc19idWZmZXJfcG9zdGVuYWJsZV9lcnJvcjsNCj4gPiA+ICsJCWdvdG8g
c3RfcHJlc3NfZnJlZV9idWZmZXI7DQo+ID4gPiANCj4gPiA+IC0JcmV0dXJuIGVycjsNCj4gPiA+
ICsJcmV0dXJuIHN0X3NlbnNvcnNfc2V0X2VuYWJsZShpbmRpb19kZXYsIHRydWUpOw0KPiA+ID4g
DQo+ID4gPiAtc3RfcHJlc3NfYnVmZmVyX3Bvc3RlbmFibGVfZXJyb3I6DQo+ID4gPiArc3RfcHJl
c3NfZnJlZV9idWZmZXI6DQo+ID4gPiAgCWtmcmVlKHByZXNzX2RhdGEtPmJ1ZmZlcl9kYXRhKTsN
Cj4gPiA+IC1hbGxvY2F0ZV9tZW1vcnlfZXJyb3I6DQo+ID4gPiAgCXJldHVybiBlcnI7DQo+ID4g
PiAgfQ0KPiA+ID4gDQo+ID4gPiAgc3RhdGljIGludCBzdF9wcmVzc19idWZmZXJfcHJlZGlzYWJs
ZShzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2KQ0KPiA+ID4gIHsNCj4gPiA+IC0JaW50IGVycjsN
Cj4gPiA+ICAJc3RydWN0IHN0X3NlbnNvcl9kYXRhICpwcmVzc19kYXRhID0gaWlvX3ByaXYoaW5k
aW9fZGV2KTsNCj4gPiA+IC0NCj4gPiA+IC0JZXJyID0gaWlvX3RyaWdnZXJlZF9idWZmZXJfcHJl
ZGlzYWJsZShpbmRpb19kZXYpOw0KPiA+ID4gLQlpZiAoZXJyIDwgMCkNCj4gPiA+IC0JCWdvdG8g
c3RfcHJlc3NfYnVmZmVyX3ByZWRpc2FibGVfZXJyb3I7DQo+ID4gPiArCWludCBlcnIsIGVycjI7
DQo+ID4gPiANCj4gPiA+ICAJZXJyID0gc3Rfc2Vuc29yc19zZXRfZW5hYmxlKGluZGlvX2Rldiwg
ZmFsc2UpOw0KPiA+ID4gDQo+ID4gPiAtc3RfcHJlc3NfYnVmZmVyX3ByZWRpc2FibGVfZXJyb3I6
DQo+ID4gPiArCWVycjIgPSBpaW9fdHJpZ2dlcmVkX2J1ZmZlcl9wcmVkaXNhYmxlKGluZGlvX2Rl
dik7DQo+ID4gPiArCWlmICghZXJyKQ0KPiA+ID4gKwkJZXJyID0gZXJyMjsNCj4gPiA+ICsNCj4g
PiA+ICAJa2ZyZWUocHJlc3NfZGF0YS0+YnVmZmVyX2RhdGEpOw0KPiA+ID4gIAlyZXR1cm4gZXJy
Ow0KPiA+ID4gIH0NCj4gPiA+IA0KPiA+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaWlvX2J1ZmZl
cl9zZXR1cF9vcHMgc3RfcHJlc3NfYnVmZmVyX3NldHVwX29wcyA9IHsNCj4gPiA+IC0JLnByZWVu
YWJsZSA9ICZzdF9wcmVzc19idWZmZXJfcHJlZW5hYmxlLA0KPiA+ID4gIAkucG9zdGVuYWJsZSA9
ICZzdF9wcmVzc19idWZmZXJfcG9zdGVuYWJsZSwNCj4gPiA+ICAJLnByZWRpc2FibGUgPSAmc3Rf
cHJlc3NfYnVmZmVyX3ByZWRpc2FibGUsDQo+ID4gPiAgfTsNCg==
