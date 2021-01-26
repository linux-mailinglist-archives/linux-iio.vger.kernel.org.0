Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56949303CBF
	for <lists+linux-iio@lfdr.de>; Tue, 26 Jan 2021 13:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392442AbhAZMQS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 Jan 2021 07:16:18 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:59746 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405555AbhAZMPG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 Jan 2021 07:15:06 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10QCCA2g013495;
        Tue, 26 Jan 2021 07:13:19 -0500
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by mx0a-00128a01.pphosted.com with ESMTP id 368hk9hthy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Jan 2021 07:13:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OTvy1gCerFHjLNyCrZfHo1bjT4zTPiDm9Ab7zXdCDP9LEoG4dxSk33hHkseMfxcBs3VElfGSXJ53YsFN5fTaCbhPswn0KZKuNzAHM5gFYVdd6PjY8sOG2h+qeu5P3yhopWqF1dD+pER7HNxOdG3Cp3/xhnS+T1LJxBnIR0JIXF+3SlielwXMCsSFNC1Y8BTSvBS182GZdRW+iQ5DlGSln41sy+ydgWVEeZsQ/7WFR/0MzbeXHEWg7M4plV2pG5yKMZqNiJ3cFuB9ClDdnyQS7poilewySBnUqAYtnyluIC5UlPaqlUA9vEUWJOCLZZ9GJRXZujlXuZPN1mmABzrppg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxDQLP1S+KhmPbZhiaOiWAZ+hKIUXjYRr1jSbWmFWmI=;
 b=Y4cGjer9tCcV2BqxoIvtpjHC2jG+bLLC49HG3+582R1DvQuumgaji9neUPL9FqQOxc2TrWBh38BVnQR2CY/WkjemgRy4ZOefR94ZaS/f2nbzuD1/j1aaUSVjBXhiB8j4JNSCGecnaagQe4UMWuBxQRPGEuSEalEPgE2WQBUsqVNFMPPg/5kvV7O3EKG8K1EWf01JaVn0msLS34KkPHbi44yq2c9jTlSm+6LQeCC03nxuD1NSbHL9+n0S+r84BPumZPmlJVvp6HFUiwHHS6PLg8t0OsGeBa9CZpSLo6nkEcyGZtI9iXWs2CgSQBO6iQB5FXenl4UYuzDGObSoZ7JhUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxDQLP1S+KhmPbZhiaOiWAZ+hKIUXjYRr1jSbWmFWmI=;
 b=ouYFmTzT4BkZjxAv8mq0qLdcYmjQAj9AB/+0Rt7MWDA6JnPq8SouaoQsElmPZNj78OUO4xYCCAarXL6yAAsJjXmnmU4Dcyce8yxyyYNdkbbVTiMiUmYuA/VKDiH829Fsjg1GZWDPx/VU19rJ9M7GU6MJfNldFmW7AdXKTfF+3fk=
Received: from CY4PR03MB2631.namprd03.prod.outlook.com (2603:10b6:903:74::18)
 by CY4PR03MB3272.namprd03.prod.outlook.com (2603:10b6:910:5b::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Tue, 26 Jan
 2021 12:13:18 +0000
Received: from CY4PR03MB2631.namprd03.prod.outlook.com
 ([fe80::1c75:7035:43d8:f03b]) by CY4PR03MB2631.namprd03.prod.outlook.com
 ([fe80::1c75:7035:43d8:f03b%7]) with mapi id 15.20.3784.019; Tue, 26 Jan 2021
 12:13:18 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Subject: RE: [PATCH 0/4] Fix/Improve sync clock mode handling
Thread-Topic: [PATCH 0/4] Fix/Improve sync clock mode handling
Thread-Index: AQHW7+yvwBAeo8fdc0Cjm2mWkJ3cmao22FAAgAMArRA=
Date:   Tue, 26 Jan 2021 12:13:17 +0000
Message-ID: <CY4PR03MB2631ED95B4FF95FD8BF29EB699BC9@CY4PR03MB2631.namprd03.prod.outlook.com>
References: <20210121114954.64156-1-nuno.sa@analog.com>
 <20210124142036.44f7d58f@archlinux>
In-Reply-To: <20210124142036.44f7d58f@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctZGRlOGEyMmItNWZjZi0xMWViLThiMDMtZTRiOTdhN2NjNzEwXGFtZS10ZXN0XGRkZThhMjJkLTVmY2YtMTFlYi04YjAzLWU0Yjk3YTdjYzcxMGJvZHkudHh0IiBzej0iNTUzOSIgdD0iMTMyNTYxMzY3OTYwOTExNTQ4IiBoPSJGNlFUZ2JlTnVaY0NGQjVWRUVVRGNTRXZGSWc9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3fb0c1f4-b50a-4ac3-5c99-08d8c1f3c3f3
x-ms-traffictypediagnostic: CY4PR03MB3272:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR03MB3272B038DDAB8BDCF5BE1E3599BC9@CY4PR03MB3272.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w4181D1OiCYFws/s5LnpH4q5aqiL4pWi1ccA7w9Td7QG0V/cmvGC2ftu9gLl3yIYm7kUpkUDnAQYagMk9e+AV7m8h5XII6ZdMRT2TfL3pS8ZItZzfhBDXT2HJa7e3OL2PwZcC5Ze/R7rgwfGEZIcpHA2Ypk6S09UJmTpJeNmDoFUgi1U7dPHtW3siEGirFY4J+bUL6coBpJSnOmzlSZ/8K7IrR26meFpFG97C9/TcYZJ9b4NeBHSZUQbqQ9VEcIMgmOuxDXKMSTFMBsplbNeQhRfl3Qfl1Cin/kYHGW89Vqad5ZIDcF5jfj/k5eLJivwUcX0Nm2tXdRG+eu2HHYwpSFbCeNGk+1XAMDIyOdS29EHcT53DL+GCgPD1Lfi+v6sudCJG46ZgSw0kxkNZaPWhg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB2631.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(39860400002)(346002)(396003)(186003)(8676002)(6506007)(9686003)(2906002)(478600001)(83380400001)(107886003)(66446008)(66476007)(7696005)(55016002)(26005)(86362001)(71200400001)(53546011)(66946007)(54906003)(4326008)(316002)(52536014)(66556008)(8936002)(5660300002)(64756008)(76116006)(6916009)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Uk52L2YwbnN1SnVzSjZkZDViZnl6MUhBbERwcDJqdkFyOFpvVFc0RytQQWxU?=
 =?utf-8?B?UmJraStDVE9wc0NOV2VrREgwbzB6clVMNkllNjg4d0dTVzM2NUNLU2pQRmpL?=
 =?utf-8?B?QnRYU0tkR0JwTUFFbWNFUjM0QzFRVklqeGJ4aVNYMEx5bFpwRk9KTTBRYmhk?=
 =?utf-8?B?SWRsVGpOUTVSMU0rekloVDdsWGFUNExUZmk5Y2dHKzFyc2lJcUd6ZUJzaFNJ?=
 =?utf-8?B?WWRHcnlhRlV5WWJXbWU1NTN3a24wWjdDZmtCV3RsSXZ2bXcyTmtTSW9DbGda?=
 =?utf-8?B?bnQ4ZmJ4NU5IeENwUUoveC9XQWtQYUdoZzNTbGROT3g1SW45MU1nZTRmOWVm?=
 =?utf-8?B?aFo5dERoUnRFQ2x2QjQzYkE2cnRVM3lTSmZjWXY4TXlMNDlxZ2plMnlDdUpW?=
 =?utf-8?B?ZldYK1p2YkhmY0p1NGxQQkxBd0tUSUJoRjJaeWdlLzhxSnNRRnA2a2d6aTls?=
 =?utf-8?B?VkJZb3FQdFlFWTRkeXQxbUlkR0g4OEQzVGFiZ3dKQ0NpWVVuN3NHQkpwSStI?=
 =?utf-8?B?dmVvWklLZGJDTzc4RnhvbVZjOURTR1UvT2dSR3VySWRnYkJQaVh6STZzOU1I?=
 =?utf-8?B?aDJJTWNocUxBaGlKSmVIVHNWR3JiMHFIM2ZEODFvSktvWk85cmFTMXE3bEhQ?=
 =?utf-8?B?T0JXbFM3TWZiSnB4NDRpK21lZTE2SVRtOHpDcFBLWS80YldCRk9ZdXpuY2Y1?=
 =?utf-8?B?T0hjV05aZ011TFRZOGpXdDcxUmNRQnRTQUVoaWxuSnVLTCsrQ0I5YllnV0ow?=
 =?utf-8?B?YS9xVXNZVDNiZ2dOZW95S2taN2o5YWdsTTNIYjIvOFFWbEFiVU1tb2dzbCtK?=
 =?utf-8?B?emE2eEJwVzhzb0txTEErbFZEMElNNzhoNldjdjFvTE1KZDBkcFFaNWtwU3BE?=
 =?utf-8?B?dnc0Y1JqRWwvK2hqdkdCWXdBanhHWi8rQnlHRnRFcFg2N0tQOXNyb3krTEt3?=
 =?utf-8?B?RVdzeDRRcXpQYzdFNFk1ZlVHcTZSS2UvZVYrVDVSZS9sMzZBUHhnSDB1ckwx?=
 =?utf-8?B?czA5Z3I1NTExRWtjVUY1NWJuSGVjVCtOV2hzNE9NOVhvZGpzTkNRNWRPYXVD?=
 =?utf-8?B?TlhjQkE1VXlPZHRsS1FQcHRwcXN1c21XQ3J4WWMrMzdMa2ppUjFSVCtPcGZx?=
 =?utf-8?B?N0h5T1lOTmh4RU80NkFTQ3RvdGlMa2Q5aXQxVzNRbjEyUng1TnF0OHFxNC9l?=
 =?utf-8?B?ZWxhR0RTNk1qN1lISW9rZ0lrejlsNWIrdWxnVWZUMUpxL1BkOWFyaVloOXBu?=
 =?utf-8?B?ODJEdTlnMHdyZm1VOHNtbW1VaWZlczJmdEdPR3lWVmVLQ1pBbTlYQXBTQnRP?=
 =?utf-8?B?V0tUeEY5cnJCZlZqN2lGU2FrbU13WGkzREh5d3EzVTRZRGUrblhHbStuV0RY?=
 =?utf-8?B?eDFIaEhPbFJ2Nk80Vno4bFQwb0JIcERmSWdoampYeVcwbDJEb3hpdEJ0Nk91?=
 =?utf-8?Q?ONJU8JGe?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB2631.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb0c1f4-b50a-4ac3-5c99-08d8c1f3c3f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 12:13:17.9945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xSuRRju2ZgvByguxcSAYvlV9VexvAxSdLMvMqFT9XIYEP24TcZ1fqpdqtUvFkIbftxR2BEqMb3pMSzwn+i7PvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3272
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-26_07:2021-01-25,2021-01-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101260066
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9uYXRoYW4gQ2FtZXJv
biA8amljMjNAa2VybmVsLm9yZz4NCj4gU2VudDogU3VuZGF5LCBKYW51YXJ5IDI0LCAyMDIxIDM6
MjEgUE0NCj4gVG86IFNhLCBOdW5vIDxOdW5vLlNhQGFuYWxvZy5jb20+DQo+IENjOiBkZXZpY2V0
cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtaWlvQHZnZXIua2VybmVsLm9yZzsgUm9iDQo+IEhl
cnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47IFBldGVyIE1lZXJ3YWxkLVN0YWRsZXINCj4gPHBt
ZWVyd0BwbWVlcncubmV0PjsgTGFycy1QZXRlciBDbGF1c2VuIDxsYXJzQG1ldGFmb28uZGU+Ow0K
PiBIZW5uZXJpY2gsIE1pY2hhZWwgPE1pY2hhZWwuSGVubmVyaWNoQGFuYWxvZy5jb20+OyBBcmRl
bGVhbiwNCj4gQWxleGFuZHJ1IDxhbGV4YW5kcnUuQXJkZWxlYW5AYW5hbG9nLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCAwLzRdIEZpeC9JbXByb3ZlIHN5bmMgY2xvY2sgbW9kZSBoYW5kbGlu
Zw0KPiANCj4gT24gVGh1LCAyMSBKYW4gMjAyMSAxMjo0OTo1MCArMDEwMA0KPiBOdW5vIFPDoSA8
bnVuby5zYUBhbmFsb2cuY29tPiB3cm90ZToNCj4gDQo+ID4gVGhlIGZpcnN0IHBhdGNoIGluIHRo
aXMgc2VyaWVzIGlzIGp1c3QgYSBzaW1wbGUgaGVscGVyIHRvIGxvY2svdW5sb2NrDQo+ID4gdGhl
IGRldmljZS4gSGF2aW5nIHRoZXNlIGhlbHBlcnMgbWFrZSB0aGUgY29kZSBzbGlnaHRseSBuZWF0
ZXINCj4gKElNSE8pLg0KPiA+DQo+ID4gVGhlIGZvbGxvd2luZyBwYXRjaGVzIGludHJvZHVjZXMg
Y2hhbmdlcyBpbiB0aGUgc2FtcGxpbmcgZnJlcXVlbmN5DQo+ID4gY2FsY3VsYXRpb24gd2hlbiBz
eW5jIHNjYWxlL3BwcyBtb2RlcyBhcmUgdXNlZC4gRmlyc3QsIGl0J3MgaW1wb3J0YW50DQo+ID4g
dG8gdW5kZXJzdGFuZCB0aGUgcHVycG9zZSBvZiB0aGlzIG1vZGUgYW5kIGhvdyBpdCBzaG91bGQg
YmUgdXNlZC4NCj4gTGV0J3MNCj4gPiBzYXkgb3VyIHBhcnQgaGFzIGFuIGludGVybmFsIHJhdGUg
b2YgNDI1MCAoZS5nIGFkaXMxNjQ5eCBmYW1pbHkpIGFuZA0KPiB0aGUNCj4gPiB1c2VyIHdhbnRz
IGFuIG91dHB1dCByYXRlIG9mIDIwMFNQUy4gT2J2aW91c2x5LCB3ZSBjYW4ndCB1c2UgdGhpcw0K
PiA+IHNhbXBsaW5nIHJhdGUgYW5kIGRpdmlkZSBiYWNrIGRvd24gdG8gZ2V0IDIwMCBTUFMgd2l0
aCBkZWNpbWF0aW9uDQo+IG9uLg0KPiA+IEhlbmNlLCB3ZSBjYW4gdXNlIHRoaXMgbW9kZSB0byBn
aXZlIGFuIGlucHV0IGNsb2NrIG9mIDFIWiwgc2NhbGUgaXQgdG8NCj4gPiBzb21ldGhpbmcgbGlr
ZSA0MjAwIG9yIDQwMDAgU1BTIGFuZCB0aGVuIHVzZSB0aGUgZGVjaW1hdGlvbiBmaWx0ZXIgdG8N
Cj4gZ2V0DQo+ID4gdGhlIGV4YWN0IGRlc2lyZWQgMjAwU1BTLiBUaGVyZSBhcmUgYWxzbyBzb21l
IGxpbWl0cyB0aGF0IHNob3VsZCBiZQ0KPiA+IHRha2VuIGludG8gYWNjb3VudCB3aGVuIHNjYWxp
bmc6DQo+ID4NCj4gPiAgKiBGb3IgdGhlIGRldmljZXMgaW4gdGhlIGFkaXMxNjQ3NSBkcml2ZXI6
DQo+ID4gICAgICAtIElucHV0IHN5bmMgZnJlcXVlbmN5IHJhbmdlIGlzIDEgdG8gMTI4IEh6DQo+
ID4gICAgICAtIE5hdGl2ZSBzYW1wbGUgcmF0ZTogMiBrU1BTLiAgT3B0aW1hbCByYW5nZTogMTkw
MC0yMTAwIHNwcw0KPiA+DQo+ID4gICogRm9yIHRoZSBhZGlzMTY0OXggZmFtaWx5IChhZGlzMTY0
ODAgZHJpdmVyKToNCj4gPiAgICAgLSBJbnB1dCBzeW5jIGZyZXF1ZW5jeSByYW5nZSBpcyAxIHRv
IDEyOCBIeg0KPiA+ICAgICAtIE5hdGl2ZSBzYW1wbGUgcmF0ZTogNC4yNSBrU1BTLiAgT3B0aW1h
bCByYW5nZTogNDAwMC00MjUwIHNwcw0KPiA+DQo+ID4gSSdtIG5vdCAxMDAlIGNvbnZpbmNlZCBv
biBob3cgdG8gaGFuZGxlIHRoZSBvcHRpbWFsIG1pbmltdW0uIEZvcg0KPiBub3csDQo+ID4gSSdt
IGp1c3QgdGhyb3dpbmcgYSB3YXJuaW5nIHNheWluZyB3ZSBtaWdodCBnZXQgaW50byB0cm91Ymxl
IGlmIHdlIGdldA0KPiBhDQo+ID4gdmFsdWUgbG93ZXIgdGhhbiB0aGF0LiBJIHdhcyBhbHNvIHRl
bXB0ZWQgdG8ganVzdCByZXR1cm4gLUVJTlZBTCBvcg0KPiA+IGNsYW1wIHRoZSB2YWx1ZS4gSG93
ZXZlciwgSSBrbm93IHRoYXQgdGhlcmUgYXJlIEFESSBjdXN0b21lcnMgdGhhdA0KPiA+IChmb3Ig
c29tZSByZWFzb24pIGFyZSB1c2luZyBhIHNhbXBsaW5nIHJhdGUgbG93ZXIgdGhhbiB0aGUgbWlu
aW11bQ0KPiA+IGFkdmlzZWQuDQo+IA0KPiBTbyB0aGUgb3BlbmluZyBxdWVzdGlvbiBJJ2QgaGF2
ZSBoZXJlIGlzIGhvdyBjcml0aWNhbCBpcyB0aGUgYWN0dWFsDQo+IHVzZXJzcGFjZSBzYW1wbGlu
ZyByYXRlIHRvIHlvdXIgdXNlcnM/ICAgT2Z0ZW4gdGhleSBkb24ndCBtaW5kDQo+IGdldHRpbmcg
YSBsaXR0bGUgbW9yZSBkYXRhIHRoYW4gdGhleSBhc2tlZCBmb3IgKHNheSAyMDAuNUh6IHdoZW4g
YXNraW5nDQo+IGZvciAyMDApIGFuZCBjYW4gYWx3YXlzIHJlYWQgYmFjayB0aGUgYXR0cmlidXRl
IGFmdGVyIHdyaXRpbmcgaXQgdG8NCj4gZGlzY292ZXIgdGhpcyBoYXMgaGFwcGVuZWQuDQo+IA0K
DQpXZWxsLCBob25lc3RseSBJJ20gbm90IHJlYWxseSBzdXJlIGhlcmUuIEkgY2FuIGp1c3Qgc2F5
IChmcm9tIHRoZSBpbmZvIEkgZ290IGludGVybmFsbHkpIHRoYXQgc29tZQ0KdXNlcnMgYXJlIHJl
YWxseSB1c2luZyB0aGVzZSBwYXJ0cyB3aXRoIGEgZGF0YSByYXRlIGxvd2VyIHRoYW4gdGhlIGFk
dmlzZWQuIEhvd2V2ZXIsIEknZCBzYXkNCnRoYXQgdGhpcyB3b3VsZCBkZXBlbmQgb24gdGhlIHVz
ZSBjYXNlLiBGb3Igc29tZSBjcml0aWNhbCBjYXNlcywgSSB3b3VsZCBleHBlY3QgdGhhdCB1c2Vy
cyByZWFsbHkNCndhbnQgdG8gaGF2ZSBhbiBleGFjdCBzYW1wbGUgcmF0ZS4gVGhvdWdoIEknZCBh
cmd1ZSB0aGF0IGluIHRob3NlIGNhc2VzLCB0aGV5IHNob3VsZCBrbm93IHdoYXQNCnRoZXkgYXJl
IGRvaW5nIGFuZCBwcm92aWRlIGFuIG91dHB1dCByYXRlIHRoYXQgZml0cyBuaWNlbHkgKG11bHRp
cGxlIG9mIGJvdGggdGhlIGlucHV0IGNsb2NrIGFuZCBJTVUNCmludGVybmFsIHNhbXBsZSByYXRl
KS4gQW5kIGFzIHlvdSBzYWlkLCB0aGV5IGNhbiBhbHdheXMgcmVhZGJhY2sgdGhlIHZhbHVlIHRv
IGNoZWNrIGlmIHRoZXkgYXJlDQpnZXR0aW5nIHNvbWV0aGluZyB0aGF0IGlzIG5vdCByZWFsbHkg
d2hhdCB0aGV5IGV4cGVjdC4uLg0KDQo+IEFzIHN1Y2gsIG9uY2UgeW91J3ZlIGRpc2NvdmVyZWQg
dGhhdCB2YWx1ZSBkb2Vzbid0IGhhdmUgYW4gZXhhY3QNCj4gbWF0Y2gsIHBlcmhhcHMgdHdlYWsg
dGhlIG91dHB1dCBkYXRhIHJhdGUgdW50aWwgaXQgZml0cyBuaWNlbHk/DQoNCkkgZGlkIHRob3Vn
aHQgYWJvdXQgdGhpcy4gVGhlIHJlYXNvbiB3aHkgSSBkaWRuJ3Qgd2VudCBmb3IgaXQgaW4gdGhp
cyBmaXJzdCB2ZXJzaW9uIGlzIGJlY2F1c2Ugb2YgdGhvc2UNCndobyBzZWVtcyB0byByZWFsbHkg
d2FudCB0byBydW4gdGhlIHBhcnQgYXQgbG93ZXIgcmF0ZXMuIExldCdzIGFzc3VtZSB3ZSBoYXZl
IGFuIGlucHV0IGNsb2NrIG9mDQoxSFogYW5kIHNvbWVvbmUgd3JpdGVzIGFuIG91dHB1dCByYXRl
IG9mIDMwMDBTUFMuIFRoZSBvbmx5IHdheSB0byBhY2NvbXBsaXNoIHRoaXMgaXMgdG8gc2V0DQpz
eW5jX3NjYWxlIGF0IDMwMDAgYW5kIGxldCB0aGUgSU1VIHJ1biBhdCAzMDAwU1BTIHdpdGggZGVj
aW1hdGlvbiBvZmYgKERFQ19SQVRFPTApLiBJZiB3ZSBhcmUNCmdvaW5nIHRvIHR3ZWFrIHRoZSBv
dXRwdXQgcmF0ZSB0byBmaXQgbmljZWx5LCB3ZSB3b3VsZCBoYXZlIHRvIGZvcmNlIGl0IHRvIDQw
MDBTUFMgd2hpY2ggaXMNCnNpZ25pZmljYW50bHkgZGlmZmVyZW50IGZyb20gdGhlIGRlc2lyZWQg
MzAwMFNQUy4NCg0KPiBBIGJpdCBvZiBxdWljayBpbnZlc3RpZ2F0aW9uIHN1Z2dlc3RzIChieSBt
eSB3aWZlIHdobyBoYXBwZW5lZA0KPiB0byBiZSBzYXQgYWNyb3NzIHRoZSByb29tKSBzdWdnZXN0
cyB0aGF0IHlvdSBoYXZlIGEgaGlkZW91cyBzZXQNCj4gb2YgbG9jYWwgbWluaW1hIHNvIHlvdXIg
YmVzdCBiZXQgaXMgdG8gYnJ1dGUgZm9yY2Ugc2VhcmNoDQo+IChub3QgdGhhdCBiYWQgYW5kIHdl
IGRvbid0IGV4cGVjdCB0byBjaGFuZ2UgdGhpcyBhIGxvdCEpDQoNCkhtbSwgbm90IHN1cmUgd2hh
dCBkbyB5b3UgaGF2ZSBpbiBtaW5kIGhlcmUgOik/DQoNCi0gTnVubyBTYQ0KDQo+IA0KPiA+DQo+
ID4gVGhhdCBzYWlkLCB0aGUgcGF0Y2ggZm9yIHRoZSBhZGlzMTY0ODAgZHJpdmVyIGlzIGEgZml4
IGFzIHRoaXMgbW9kZSB3YXMNCj4gPiBiZWluZyB3cm9uZ2x5IGhhbmRsZWQuIFRoZXJlIHNob3Vs
ZCBub3QgYmUgYSAic2VwYXJhdGlvbiIgYmV0d2Vlbg0KPiB1c2luZw0KPiA+IHRoZSBzeW5jX3Nj
YWxlIGFuZCB0aGUgZGVjX3JhdGUgcmVnaXN0ZXJzLiBUaGUgd2F5IHRoaW5ncyB3ZXJlDQo+IGJl
aW5nIGRvbmUsDQo+ID4gd2UgY291bGQgZWFzaWx5IGdldCBpbnRvIGEgc2l0dWF0aW9uIHdoZXJl
IHRoZSBwYXJ0IGNvdWxkIGJlIHJ1bm5pbmcNCj4gd2l0aA0KPiA+IGFuIGludGVybmFsIHJhdGUg
d2F5IGxvd2VyIHRoYW4gdGhlIG9wdGltYWwgbWluaW11bS4NCj4gPg0KPiA+IEZvciB0aGUgYWRp
czE2NDc1IGRyaXZlcnMsIHRoaW5ncyB3ZXJlIG5vdCByZWFsbHkgd3JvbmcuIFRoZXkgd2VyZQ0K
PiBqdXN0DQo+ID4gbm90IG9wdGltYWwgYXMgd2Ugd2VyZSBmb3JjaW5nIHVzZXJzIHRvIHNwZWNp
ZnkgdGhlIElNVSBzY2FsZWQNCj4gaW50ZXJuYWwNCj4gPiByYXRlIG9uY2UgaW4gdGhlIGRldmlj
ZXRyZWUuIENhbGN1bGF0aW5nIHRoaW5ncyBhdCBydW50aW1lIGdpdmVzIG11Y2gNCj4gPiBtb3Jl
IGZsZXhpYmlsaXR5IHRvIGNob29zZSB0aGUgb3V0cHV0IHJhdGUuDQo+ID4NCj4gPiBOdW5vIFPD
oSAoNCk6DQo+ID4gICBpaW86IGFkaXM6IGFkZCBoZWxwZXJzIGZvciBsb2NraW5nDQo+ID4gICBp
aW86IGFkaXMxNjQ4MDogZml4IHBwcyBtb2RlIHNhbXBsaW5nIGZyZXF1ZW5jeSBtYXRoDQo+ID4g
ICBpaW86IGFkaXMxNjQ3NTogaW1wcm92ZSBzeW5jIHNjYWxlIG1vZGUgaGFuZGxpbmcNCj4gPiAg
IGR0LWJpbmRpbmdzOiBhZGlzMTY0NzU6IHJlbW92ZSBwcm9wZXJ0eQ0KPiA+DQo+ID4gIC4uLi9i
aW5kaW5ncy9paW8vaW11L2FkaSxhZGlzMTY0NzUueWFtbCAgICAgICB8ICAgOSAtLQ0KPiA+ICBk
cml2ZXJzL2lpby9pbXUvYWRpczE2NDc1LmMgICAgICAgICAgICAgICAgICAgfCAxMTAgKysrKysr
KysrKysrLS0tLQ0KPiA+ICBkcml2ZXJzL2lpby9pbXUvYWRpczE2NDgwLmMgICAgICAgICAgICAg
ICAgICAgfCAxMjAgKysrKysrKysrKysrKy0tLS0tDQo+ID4gIGluY2x1ZGUvbGludXgvaWlvL2lt
dS9hZGlzLmggICAgICAgICAgICAgICAgICB8ICAxMCArKw0KPiA+ICA0IGZpbGVzIGNoYW5nZWQs
IDE3OCBpbnNlcnRpb25zKCspLCA3MSBkZWxldGlvbnMoLSkNCj4gPg0KDQo=
