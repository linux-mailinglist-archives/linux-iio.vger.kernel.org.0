Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99DCB6086C
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2019 16:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbfGEOwZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Jul 2019 10:52:25 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:35178 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727620AbfGEOwW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 Jul 2019 10:52:22 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x65DX431020377;
        Fri, 5 Jul 2019 09:35:18 -0400
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2051.outbound.protection.outlook.com [104.47.36.51])
        by mx0b-00128a01.pphosted.com with ESMTP id 2tgk5xq8hr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 05 Jul 2019 09:35:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvMyODo1wsk9maL6lmS9M4CI/cT065dmhi88sNFU8hM=;
 b=kzoh7AqSAGgTI8IXMzGIcd+Gsj3vtjxqa79+XTP8DAxtZ3YO6qNXPgiK46kZFs7h2qVftU5pXeobM2zvTc3DbXFq47hOpb0/h1G0BqCgJ4jev/hzxkzR5B1+m8J8AMxowRefJ1U32HIHWg4jKisiLJb8n9IG0cisYI5Of9NU1Uk=
Received: from BN3PR03CA0073.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::33) by SN6PR03MB3838.namprd03.prod.outlook.com
 (2603:10b6:805:6a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2052.18; Fri, 5 Jul
 2019 13:35:16 +0000
Received: from CY1NAM02FT055.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::201) by BN3PR03CA0073.outlook.office365.com
 (2a01:111:e400:7a4d::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2052.18 via Frontend
 Transport; Fri, 5 Jul 2019 13:35:16 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT055.mail.protection.outlook.com (10.152.74.80) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2032.15
 via Frontend Transport; Fri, 5 Jul 2019 13:35:15 +0000
Received: from NWD2HUBCAS8.ad.analog.com (nwd2hubcas8.ad.analog.com [10.64.69.108])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x65DZEXn006008
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 5 Jul 2019 06:35:14 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS8.ad.analog.com ([fe80::90a0:b93e:53c6:afee%12]) with mapi id
 14.03.0415.000; Fri, 5 Jul 2019 09:35:14 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH 3/3][V3] iio: Handle enumerated properties with gaps
Thread-Topic: [PATCH 3/3][V3] iio: Handle enumerated properties with gaps
Thread-Index: AQHVBY/z/hY+5eHS1kGQU0cKESrq0qZheMuAgAExjgCAWfqDAA==
Date:   Fri, 5 Jul 2019 13:35:14 +0000
Message-ID: <97a28b3d5a36886ca7980d56911fadcc2ddbb0c1.camel@analog.com>
References: <20190508111913.7276-1-alexandru.ardelean@analog.com>
         <20190508111913.7276-3-alexandru.ardelean@analog.com>
         <20190508131749.GM9224@smile.fi.intel.com>
         <780a4bcbf2e8a2d816efe2ed9613ac2b1594282e.camel@analog.com>
In-Reply-To: <780a4bcbf2e8a2d816efe2ed9613ac2b1594282e.camel@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.65.145]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6ABF6AD2E8343444BD79CB4869BCBAD5@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(346002)(136003)(2980300002)(199004)(189003)(50466002)(36756003)(336012)(4326008)(118296001)(6246003)(7736002)(7636002)(86362001)(76176011)(102836004)(478600001)(186003)(356004)(26005)(229853002)(7696005)(2486003)(5640700003)(23676004)(2351001)(6116002)(316002)(106002)(5660300002)(54906003)(2906002)(2501003)(70206006)(70586007)(47776003)(6916009)(14454004)(305945005)(436003)(426003)(8936002)(3846002)(126002)(476003)(2616005)(11346002)(8676002)(446003)(486006)(246002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR03MB3838;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31c824f5-1dd6-4bab-15cc-08d7014d9d59
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:SN6PR03MB3838;
X-MS-TrafficTypeDiagnostic: SN6PR03MB3838:
X-Microsoft-Antispam-PRVS: <SN6PR03MB3838B12618165FBDDE454233F9F50@SN6PR03MB3838.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 008960E8EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: wWnt8jfzKLREu8Qi0JV6MwVK8YGSS/f9Lv2CdCD9xW0HvwpGiz8WwMQ5s4SkQRQOGWZny1pNKpRcfGyGTt97A7JOA3uiyXNIUbmgN/+RYzFxlxX9wu8NJzSDver943KOl64HXA7zysDSbcaM0qw2g3L8CGGoxOv+EFsDlpFALjM222zKa54yvbksvnH6D7y1KbE+ZoPIWK842GWkQDIqY8syNMb9Xc/763fJzx48ZHmrzc37k4tB+15h7VnD+/miFQwb58jTXc8SkTHcNIiQHw8Iu/Gwxa4lZe19QW1mBHi1ki7v4J7ywEnfQmE+I8vXkJYC41DEDETkcW3X7X59rWxbH8F/tdx+X8DOMO4TNkgbCHeMyn8V4HJSpKZpCaigyEY7Qd3HI+Um4Ve/NcUHblKUhquOSIsO/X30fDuSwYE=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2019 13:35:15.5351
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31c824f5-1dd6-4bab-15cc-08d7014d9d59
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3838
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-05_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=877 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907050165
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVGh1LCAyMDE5LTA1LTA5IGF0IDEwOjMxICswMzAwLCBBbGV4YW5kcnUgQXJkZWxlYW4gd3Jv
dGU6DQo+IE9uIFdlZCwgMjAxOS0wNS0wOCBhdCAxNjoxNyArMDMwMCwgQW5keSBTaGV2Y2hlbmtv
IHdyb3RlOg0KPiA+IFtFeHRlcm5hbF0NCj4gPiANCj4gPiANCj4gPiBPbiBXZWQsIE1heSAwOCwg
MjAxOSBhdCAwMjoxOToxM1BNICswMzAwLCBBbGV4YW5kcnUgQXJkZWxlYW4gd3JvdGU6DQo+ID4g
PiBGcm9tOiBMYXJzLVBldGVyIENsYXVzZW4gPGxhcnNAbWV0YWZvby5kZT4NCj4gPiA+IA0KPiA+
ID4gU29tZSBlbnVtcyBtaWdodCBoYXZlIGdhcHMgb3IgcmVzZXJ2ZWQgdmFsdWVzIGluIHRoZSBt
aWRkbGUgb2YgdGhlaXINCj4gPiA+IHZhbHVlDQo+ID4gPiByYW5nZS4gRS5nLiBjb25zaWRlciBh
IDItYml0IGVudW0gd2hlcmUgdGhlIHZhbHVlcyAwLCAxIGFuZCAzIGhhdmUgYQ0KPiA+ID4gbWVh
bmluZywgYnV0IDIgaXMgYSByZXNlcnZlZCB2YWx1ZSBhbmQgY2FuIG5vdCBiZSB1c2VkLg0KPiA+
ID4gDQo+ID4gPiBBZGQgc3VwcG9ydCBmb3Igc3VjaCBlbnVtcyB0byB0aGUgSUlPIGVudW0gaGVs
cGVyIGZ1bmN0aW9ucy4gQSByZXNlcnZlZA0KPiA+ID4gdmFsdWVzIGlzIG1hcmtlZCBieSBzZXR0
aW5nIGl0cyBlbnRyeSBpbiB0aGUgaXRlbXMgYXJyYXkgdG8gTlVMTCByYXRoZXINCj4gPiA+IHRo
YW4gdGhlIG5vcm1hbCBkZXNjcmlwdGl2ZSBzdHJpbmcgdmFsdWUuDQo+ID4gPiANCj4gPiA+IEFs
c28sIGBfX3N5c2ZzX21hdGNoX3N0cmluZygpYCBub3cgc3VwcG9ydHMgTlVMTCBnYXBzLCBzbyB0
aGF0IGRvZXNuJ3QNCj4gPiA+IHJlcXVpcmUgYW55IGNoYW5nZXMuDQo+ID4gPiAtICAgICBmb3Ig
KGkgPSAwOyBpIDwgZS0+bnVtX2l0ZW1zOyArK2kpDQo+ID4gPiArICAgICBmb3IgKGkgPSAwOyBp
IDwgZS0+bnVtX2l0ZW1zOyArK2kpIHsNCj4gPiA+ICsgICAgICAgICAgICAgaWYgKCFlLT5pdGVt
c1tpXSkNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4gPiA+ICAgICAg
ICAgICAgICAgbGVuICs9IHNjbnByaW50ZihidWYgKyBsZW4sIFBBR0VfU0laRSAtIGxlbiwgIiVz
ICIsIGUtDQo+ID4gPiA+IGl0ZW1zW2ldKTsNCj4gPiA+ICsgICAgIH0NCj4gPiANCj4gPiBUaGUg
cHJvYmxlbSBoZXJlIHRoYXQgdGhlIHVzZXIgd2lsbCBoYXZlIG5vIGNsdWUgd2hlcmUgdGhlIGdh
cCBpcw0KPiA+IGhhcHBlbmVkLCB0bw0KPiA+IHNvbHZlIHRoaXMgd2UgbmVlZCBlaXRoZXIgYml0
bWFwIG9mIGFycmF5LCB3aGVyZSBzZXQgYml0cyBzaG93cyBkZWZpbmVkDQo+ID4gaXRlbXMsDQo+
ID4gb3IgdXNlIGNvbW1hLXNlcGFyYXRlZCBsaXN0IG9mIHZhbHVlcy4gVGhlIGxhdHRlciB3b3Vs
ZCBuZWVkIGFub3RoZXIgbm9kZQ0KPiA+IHNpbmNlDQo+ID4gd2UgZG9uJ3QgYnJlYWsgdXNlciBz
cGFjZS4NCj4gDQo+IEhtbW0uDQo+IEkgYW0gd29uZGVyaW5nIGlmIHRoZXJlIGFyZSBjYXNlcyB3
aGVyZSB1c2Vyc3BhY2Ugd291bGQgY2FyZSBhYm91dCByZXNlcnZlZA0KPiB2YWx1ZXMgYW5kL29y
IHBvc2l0aW9ucyBvZiByZXNlcnZlZCBiaXQtZmllbGRzLg0KPiBNYXliZSB5b3UgY291bGQgb2Zm
ZXIgZXhhbXBsZXMvdXNlLWNhc2VzIHdoZXJlIHRoaXMgaXMgbmVlZGVkLg0KPiANCj4gVG8gc29t
ZSBleHRlbnQgdGhlIGtlcm5lbCBbZHJpdmVycyAmIGZyYW1ld29ya3NdIHNob3VsZCBwcm9iYWJs
eSBub3QgbmVlZA0KPiB0byBleHBvc2UgdGhhdCAic3RyaW5nLWVudW0tWCIgID09IGBiaXRmaWVs
ZF8yYCBtYXRjaGluZzsgb3RoZXJ3aXNlIGl0DQo+IGRvZXNuJ3QgcmVhbGx5IGFkZCBtdWNoIHZh
bHVlIDsgdGhlIHdob2xlIHBvaW50IG9mIGZyYW1ld29ya3MgW2luIGdlbmVyYWxdDQo+IGlzIHRv
IG9mZmVyIHNvbWUgbGV2ZWwgb2YgYWJzdHJhY3Rpb24gdG8gSFcuDQo+IA0KPiBUaGUgb25seSBl
eGFtcGxlIEkgY2FuIHRoaW5rIG9mIFthdG1dLCBpcyB3aGVuIGEgcmVzZXJ2ZWQgYml0LWZpZWxk
IHdpbGwgYmUNCj4gdXNlZCBpbiB0aGUgZnV0dXJlLiBCdXQgdGhlbiwgdGhlIGRyaXZlciBzaG91
bGQgY2FyZSBhYm91dCB0aGlzLCBhbmQgbm90DQo+IHRoZSBmcmFtZXdvcmsuIFRoZSBkcml2ZXIg
c2hvdWxkIGRlY2lkZSB0aGF0ICJiaXRmaWVsZF8yIiB3aWxsDQo+IGVuYWJsZS9kaXNhYmxlIHNv
bWV0aGluZyBbaW4gdGhlIGZ1dHVyZV0sIGFuZCBzaG91bGQgYmUgY29uc2lkZXJlZCBpbiBhDQo+
IHN1Y2ggYSB3YXkgKHdoZW4gYmVpbmcgd3JpdHRlbikuIElmIHRoZSBkcml2ZXIgY2FuJ3QgbWFr
ZSB0aGlzIHByZWRpY3Rpb24gWw0KPiBhYm91dCAiYml0ZmllbGRfMiJdIHRoZW4gYSBuZXcgZHJp
dmVyIG11c3QgYmUgd3JpdHRlbiBhbnl3YXkuDQo+IA0KPiBCdXQgSSB3aWxsIGFncmVlIHRoYXQg
SSBtYXkgbm90IGhhdmUgYWxsIGFyZ3VtZW50cyBpbiBtaW5kIHRvIGJlIDEwMCUgc3VyZQ0KPiBv
ZiBhbGwgdGhpcy4NCj4gDQoNCkhleSwNCg0KSXMgdGhlcmUgYW55IGZlZWRiYWNrL2NvdW50ZXIt
YXJndW1lbnRzIGZvciB0aGlzPw0KDQpUaGFua3MNCkFsZXgNCg0KDQo+IFRoYW5rcw0KPiBBbGV4
DQo+IA0KPiA+IC0tDQo+ID4gV2l0aCBCZXN0IFJlZ2FyZHMsDQo+ID4gQW5keSBTaGV2Y2hlbmtv
DQo+ID4gDQo+ID4gDQo=
