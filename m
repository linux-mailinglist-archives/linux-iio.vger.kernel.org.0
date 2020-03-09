Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62AC117E1CC
	for <lists+linux-iio@lfdr.de>; Mon,  9 Mar 2020 14:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgCIN6s (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Mar 2020 09:58:48 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:32168 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726632AbgCIN6s (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Mar 2020 09:58:48 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 029DvUbI016259;
        Mon, 9 Mar 2020 09:58:47 -0400
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ym9db5cfh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Mar 2020 09:58:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HqLfwEvmDYLFxsWAlS4QA4Io3sV+boPVap7Jf4r/TYqGcSEVGgNbXa1rZj2z/S28GEw+S3lKOMUC2mFKdFNn7YJdL5JdB+TPbM4KUnsGY3oMK4zdPVR7LHRkdeFx70T7yYWrqvG/u5cfleQ1JbI1ya79JbYoyYO/auQaP7DaJujbkNbUtvhR1PdeHalsGTT0jSbI2UFVNHu5hQxa+nMcXlFHexrCmU37/tkWf7Mhwq6Xhp7XlJ70cICBn+uQjcQQKu+Op6WBE7jpkJPipnE9/kV146nDoG3v2Oo3Wml6wO0tBIg4H5ejrDFLIQdC7GY4JRDz3+Edm4GxnkVKRs+84A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AhrzlkANeRUJ02ZJWIAj5eahF5oetBFTAajrkNfqOs8=;
 b=U7Yg5QX1VvqwztoUL9oUzWgXUueZAfxPX+xJf87lmpmZan74pwrng2Iq6coBr/AG+ocV3lojWgEScVJCGuy5gq9SxHHjBqIMwCPkBoaEo0teM859pAOOWwAmCrI4vZVHu87+gzoDAxNQyZlhEwDfy5mlBoRSrrvq6kestJvCPIn71MFnUnNNODCYZp22Z08V0sRz2AvXnzfU7EureK+CgN0MmyjSxTFCwL9N0JmlCPTR9vEH9XOpBnax64y5F+cG9pQ35r2N5XcPKy1JZIlcg96RwPMcljG699f7u/xXAyAFhdLanosQ5TzD6Ph5UVmYlvcwcnO+nTY12P52/fD7pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AhrzlkANeRUJ02ZJWIAj5eahF5oetBFTAajrkNfqOs8=;
 b=en4dNoeE1qFi0r+Zpo2U3j/rAJ2va4sfni3yHdN+C3HZQJ9Kpr+KJs5ASa02HpVhHLxwZ99CRG85NPQfpUw6+dfXowQxoInlCdgl5jzURE3dzRWsDy1+GMG6DRNh9gbQl0vM8R++yJtN/Avq+w9aSve4Y+kaYzC+9/JJDBhMD4E=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4761.namprd03.prod.outlook.com (2603:10b6:5:18d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Mon, 9 Mar
 2020 13:58:45 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::f8c4:f7f2:c7a0:cc19]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::f8c4:f7f2:c7a0:cc19%6]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 13:58:45 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "mdf@kernel.org" <mdf@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH v8 2/8] include: fpga: adi-axi-common.h: add version
 helper macros
Thread-Topic: [PATCH v8 2/8] include: fpga: adi-axi-common.h: add version
 helper macros
Thread-Index: AQHV86YcBP6rketQYUC8BeRDNruucag9MV4AgABcPoCAAsDIAA==
Date:   Mon, 9 Mar 2020 13:58:44 +0000
Message-ID: <f1022947596ef9f0d94ca606f26f236c84288b89.camel@analog.com>
References: <20200306110100.22092-1-alexandru.ardelean@analog.com>
         <20200306110100.22092-3-alexandru.ardelean@analog.com>
         <20200307142604.7d597667@archlinux> <20200307195613.GA38707@epycbox.lan>
In-Reply-To: <20200307195613.GA38707@epycbox.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c0efd62a-29d3-491b-7578-08d7c431fbae
x-ms-traffictypediagnostic: DM6PR03MB4761:
x-microsoft-antispam-prvs: <DM6PR03MB4761E722FC416281FD948B58F9FE0@DM6PR03MB4761.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0337AFFE9A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(136003)(396003)(346002)(366004)(199004)(189003)(4326008)(36756003)(71200400001)(54906003)(6486002)(6512007)(966005)(110136005)(316002)(8676002)(81166006)(81156014)(8936002)(26005)(91956017)(76116006)(186003)(6506007)(5660300002)(64756008)(66556008)(66446008)(66946007)(66476007)(478600001)(86362001)(2906002)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB4761;H:DM6PR03MB4411.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xs8T2h7wWDa61KOap6isvwFREmbLtG63NQarItkiBpeJPO34/OnbfBC7SgWJzE+EUEb2yNdVoe3k9wjBdHWdCX+1vyXTOCKNeKxgmqfMBKRLBybK5Nrf+N0V+90m6I3jzX+jF5rRBGAXScqnkvB+nBJyogt/nb8XdUUrb5jSkCxSFVuXgw2IAw3soK4JN9vfHIzK5eRMhsLVgtPnUC3b6KNKR6wdL2Vknwi6Bkx7iRZUUZfXRd1rEFMtP95h9pkFFUFtkmRFjkCyaecGPzsNXZ61ZETDIf6MuRJJcoPfMCIMsbszx+FLupkgORPUMsLeVvnTwAn015/cxS2fa5wNYYwo06S80+nK8AXuP/pTRnBtU/0dUhTOTZNjLhpuS9lH9d6wKlo6Nt2ior+GvgD5Al7Bxg7kYLFCj0p9HPJCgzqHB2IrYjhJlrx8wuvfQToxYpzWvt51b06zwUQOIXpFAi5M3oBeXmwbTNw9+jJVHL/+bTk+P8Jc5jboJtK5U0mylHEafhBym0GDFHN4L6csYQ==
x-ms-exchange-antispam-messagedata: g0FocDeOMXlmY8qmpJFcoEW9LsjhW7kfV5Fj4frcJkW+8OaB3mQRv2nHVD9p24mwWOab7Sd8L5f53BfkU4gvM4o/t0+ZOCKMZ+wslV7sRagS7po5WJO16DvC+gUUabs9tchVic4lpjpdJCIWS6euEQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <459DCDB9C617464AB06481564BFBBD0D@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0efd62a-29d3-491b-7578-08d7c431fbae
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2020 13:58:45.0061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vncXNmIcc54EfBM1MuMjUumN3ZRoY+bHdyBQ9puEgnE2ecG12c4jHZamNBWopbb9oOoecliVEjkN4JbZXIKn8efmy2y4w2LIIZlZ5RCN+WI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4761
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-09_04:2020-03-09,2020-03-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 mlxscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003090096
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU2F0LCAyMDIwLTAzLTA3IGF0IDExOjU2IC0wODAwLCBNb3JpdHogRmlzY2hlciB3cm90ZToN
Cj4gW0V4dGVybmFsXQ0KPiANCj4gT24gU2F0LCBNYXIgMDcsIDIwMjAgYXQgMDI6MjY6MDRQTSAr
MDAwMCwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToNCj4gPiBPbiBGcmksIDYgTWFyIDIwMjAgMTM6
MDA6NTQgKzAyMDANCj4gPiBBbGV4YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBh
bmFsb2cuY29tPiB3cm90ZToNCj4gPiANCj4gPiA+IFRoZSBmb3JtYXQgZm9yIGFsbCBBREkgQVhJ
IElQIGNvcmVzIGlzIHRoZSBzYW1lLg0KPiA+ID4gaS5lLiAnbWFqb3IubWlub3IucGF0Y2gnLg0K
PiA+ID4gDQo+ID4gPiBUaGlzIHBhdGNoIGFkZHMgdGhlIGhlbHBlciBtYWNyb3MgdG8gYmUgcmUt
dXNlZCBpbiBBREkgQVhJIGRyaXZlcnMuDQo+ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEFs
ZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+DQo+IEFja2Vk
LWJ5OiBNb3JpdHogRmlzY2hlciA8bWRmQGtlcm5lbC5vcmc+DQo+IA0KPiA+IEFnYWluLCB0cml2
aWFsIGJ1dCBuZWVkcyBhIE1vcml0eiBhY2sgYXMgaXQncyBoaXMgc3Vic3lzdGVtLg0KPiANCj4g
SSBoYWQgb3JpZ2luYWxseSBhc2tlZCB0byBub3QgcHV0IGl0IHVuZGVyIGluY2x1ZGUvbGludXgv
ZnBnYSwgYnV0IGFsYXMsDQo+IG5vdyBpdCdzIGhlcmUgOikNCj4gDQo+IEl0IG5ldmVyIG1hZGUg
bXVjaCBzZW5zZSBpbWhvIHRvIGRyb3AgaXQgdW5kZXIgbGludXgvZnBnYSBqdXN0IGJlY2F1c2UN
Cj4gaXQncyBhIGhhcmR3YXJlIGltcGxlbWVudGVkIGluIGFuIEZQR0EuLi4uDQoNCldlIGNhbiBh
bHdheXMgbW92ZSBpdC4NCkkgZG9uJ3QgcmVtZW1iZXIgYWJvdXQgYW55IGRpc2N1c3Npb24gb24g
dGhpcyBtYXR0ZXIuDQpPciBtYXliZSBJIHdhc24ndCBpbmNsdWRlZC4NCk9yIG1heWJlIEkgaGF2
ZSBzb21lIHNldmVyZSBjYXNlIG9mIGFtbmVzaWEgb3IgY2FyZWxlc3NuZXNzIGZvciBvbWl0dGlu
Zw0KdGhyZWFkcy4gSSBhbSB0ZXJyaWJsZSBhdCBmb2xsb3dpbmcgdGhyZWFkcy4NCg0KQXBvbG9n
aWVzIGZvciBhbnl0aGluZyBvbiBteSBwYXJ0Lg0KDQpJZiB5b3UgcHJvcG9zZSBhbm90aGVyIGxv
Y2F0aW9uLCBJIGNhbiBzcGluLXVwIGEgcGF0Y2ggb24gaXQuDQoNClRoZXNlIHJlZy1kZWZpbml0
aW9ucyBhcmUgY29tbW9uIHRvIGFsbCBBREkgSERMIHJlZ3MuDQpNYXliZSBtb3JlIG1heSBjb21l
IHVwIGFzIHN0dWZmIGdldHMgdXBzdHJlYW1lZC4NCg0KVGhlIGZ1bGwtYmxvd24vaW50ZXJuYWwg
dmVyc2lvbiB3ZSBoYXZlIGlzOg0KaHR0cHM6Ly9naXRodWIuY29tL2FuYWxvZ2RldmljZXNpbmMv
bGludXgvYmxvYi9tYXN0ZXIvaW5jbHVkZS9saW51eC9mcGdhL2FkaS1heGktY29tbW9uLmgNCg0K
SXQgdHJpZXMgdG8gZGVmaW5lIHNvbWUgdGhpbmdzIHRoYXQgYXJlIGNvbW1vbiBiZXR3ZWVuIElu
dGVsLCBYaWxpbnggYW5kIEFESSBJUA0KY29yZXMgYWNyb3NzIFt0aGVzZSBhbmQgaG9wZWZ1bGx5
IG90aGVyXSBGUEdBIGJvYXJkcy4NCkknbSBub3Qgc2F5aW5nIGl0J3MgZG9pbmcgYSBnb29kIGpv
YiBvZiB0aGF0IGF0IHRoZSBtb21lbnQuDQrCr1xfKOODhClfL8KvDQpUaGFua3MNCkFsZXgNCg0K
PiANCj4gQ2hlZXJzLA0KPiBNb3JpdHoNCg==
