Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2589718E7BB
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 10:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgCVJJX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 05:09:23 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:18758 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725987AbgCVJJX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 05:09:23 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02M92YNC025808;
        Sun, 22 Mar 2020 05:09:12 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-00128a01.pphosted.com with ESMTP id 2ywcp9jvwj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 22 Mar 2020 05:09:12 -0400
Received: from m0167091.ppops.net (m0167091.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 02M99Clq032122;
        Sun, 22 Mar 2020 05:09:12 -0400
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2054.outbound.protection.outlook.com [104.47.45.54])
        by mx0b-00128a01.pphosted.com with ESMTP id 2ywcp9jvwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 22 Mar 2020 05:09:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZwjR0+0ryqqa3nmfNTcGsmmxf5WAi4O/niloWDp93uNU06/q2z+gSFyO4eUxnmKrvWSndknkKxuIMKtfUehh3mG6B2CzhuCgcCRl9/pTjFPeLwoI9Q8Lc0X5LLFljeR4kqditW3igtJpxupxGomv47o0vMTNNNv3S3ufroOnr7mtgMKe9yOG4o63tezsXU/oflxrpaEGwMgnObDoJezNs/jlaGxNs5Wyzw1F6hlAYh7iMan+6ioGCEMHD9MYuftnw7KdQLFyeFquAmlSvgtlItBWFbakmx5zd4YFWxRIY4MWu4bfP5T9Q8SwnP1uLUg8jduS8Tc39TSiC8pqlFPmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGa/HcmyTtBtCtvagB2tESZ+jEhcZRu3Ox5gDq3UD/Q=;
 b=VyrJkacclhQQrkvg81fB5WZVWWtC8G5VF0LH1meqtgvyJpRowV19GM47oYxrNGt/hLwmyZ7LfhMOggkgRba89Z8BIrevNgInaJK018gA7Iyy8gxX1q6BYQl5Z6+jUfWWKcD9ih6YpRNmqZ9k5i88ZMKU/Ls++dw53SqjOfRIBQb9RET/NTdAvQgrKmXtzpVcZ/57CQSwCku0oRLU3mnBLKjmbAC72tUTaYy0SJCiWijby6XZCCtJuFF1tulqDYknICZz6NdpUWyZAJYpCkdwV7nvhTbOu8iThDjk9iTgVGIkcjhjSdrnNtMLWqGh1qnHiBmVrPpVtlR/vziBL8Dnhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGa/HcmyTtBtCtvagB2tESZ+jEhcZRu3Ox5gDq3UD/Q=;
 b=aXwJE/AopqOz00taQ2m9VvZddCFJtnaIrz9+Lgkevzn8O/LnmT5BRPZb0tVdX635Kl7WEUzO/tPSDM+uAWoCbfz8cfD1MA2dQ6iCF0ZMKEtFc5Hy7+uPEiBr9zfo7pQDPivELbD21ZOwLch6F4DAORwb9DF45wYRzdRFyfQKUu0=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB5131.namprd03.prod.outlook.com (2603:10b6:5:1f0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Sun, 22 Mar
 2020 09:09:10 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2814.025; Sun, 22 Mar 2020
 09:09:10 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "joe@perches.com" <joe@perches.com>
CC:     "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "ardeleanalex@gmail.com" <ardeleanalex@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: Re: [PATCH] MAINTAINERS: remove Stefan Popa's email
Thread-Topic: [PATCH] MAINTAINERS: remove Stefan Popa's email
Thread-Index: AQHV/GkdYDTl6mIztkSu/yTbmh4uNKhTerSAgAAFpACAAAKygIAA1zuA
Date:   Sun, 22 Mar 2020 09:09:10 +0000
Message-ID: <6175728c63483acc80cf36f40e17fa5bac18d545.camel@analog.com>
References: <20200317143336.6098-1-alexandru.ardelean@analog.com>
         <20200321194859.GA2813896@smile.fi.intel.com>
         <c026dcc85e8454a1ea191c20ba03ce2072271af9.camel@perches.com>
         <CAHp75VcAo4qHvFyVkv3Keq63XD_HfSvJ=1LBbxYTM0kYGWJh_g@mail.gmail.com>
In-Reply-To: <CAHp75VcAo4qHvFyVkv3Keq63XD_HfSvJ=1LBbxYTM0kYGWJh_g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.26.73.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eaeefa18-b712-4a9e-1fc6-08d7ce40aef4
x-ms-traffictypediagnostic: DM6PR03MB5131:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB5131D8E92B2EFC489881C867F9F30@DM6PR03MB5131.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0350D7A55D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(396003)(346002)(376002)(366004)(136003)(199004)(36756003)(8676002)(81166006)(81156014)(8936002)(2906002)(66476007)(53546011)(66556008)(66446008)(64756008)(54906003)(110136005)(316002)(6486002)(86362001)(66946007)(91956017)(76116006)(6512007)(6506007)(2616005)(186003)(71200400001)(5660300002)(4326008)(107886003)(26005)(7416002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB5131;H:DM6PR03MB4411.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IUH0KrWQLL/Veliq0G9jneRLHIjSKkFUU/pfZvJl168dhfPufCNBpPMESnF4GRDc+744TYO3XgrzUSpu4hYcZ8ZAA5ZMZn6FbRMxP7AuZpGuRdXW2emeaA9mlBbPZccfJCwclDjMiZ+EXNr7lRNKVfTmzeUmDWDwy7CTQ//LQQqbdJ8s8Mb+xIhYUvgpISvdVObG2wyQFDvYvYRxevp/RkJ7/io44Q14ncDBD4vyG990UbeQaDs95H+KMG90MqSuyWKzwRXL9ucnm/F0Peq+WJQyA7qhO6jzr2j6tZ7nyIzWxkVUcIflfePWi7xNXoysSlW2aZtuMLyva3syduR4dY8xVkCfPUWrK46790lzLNDQV2Fv0v4BMOXs5lnP/NOD1nDPs+YETJCXcbLJt40l1bwttg911rJgqdOanx2XoVfPQ9feTW6lS4uW7oBUH3pS
x-ms-exchange-antispam-messagedata: 1HkmjKs8KcB2mhClYBVpLWzlOmHazpDcUf7xG7n3JRHJEFYewD5s3AErcpOaJ2jioGkGSI0SGA36yolM5LHxjmAeBh1NmSU6B75Lqqdv6eSYgAi2piyoLXuyWq8N8/A2pcoo0aWXcWvkYzzGMVNZow==
Content-Type: text/plain; charset="utf-8"
Content-ID: <B546BFFDDD941C4AA9948549B0AF419F@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaeefa18-b712-4a9e-1fc6-08d7ce40aef4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2020 09:09:10.2798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Rc+jMB1IhKIKMV7heYSVMc59pnOEvtMSo2IBubkNwLWbFuowkvzoeHM2vdESxZ8T+hxk/E4O0a8LNktej63W8AvbdI/+csBLhQIIdFUV44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5131
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-22_02:2020-03-21,2020-03-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 priorityscore=1501 clxscore=1011 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003220053
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU2F0LCAyMDIwLTAzLTIxIGF0IDIyOjE4ICswMjAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
DQo+IFtFeHRlcm5hbF0NCj4gDQo+IE9uIFNhdCwgTWFyIDIxLCAyMDIwIGF0IDEwOjExIFBNIEpv
ZSBQZXJjaGVzIDxqb2VAcGVyY2hlcy5jb20+IHdyb3RlOg0KPiA+IE9uIFNhdCwgMjAyMC0wMy0y
MSBhdCAyMTo0OCArMDIwMCwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiA+ID4gT24gVHVlLCBN
YXIgMTcsIDIwMjAgYXQgMDQ6MzM6MzZQTSArMDIwMCwgQWxleGFuZHJ1IEFyZGVsZWFuIHdyb3Rl
Og0KPiA+ID4gPiBUaGUgZW1haWwgaXMgbm8gbG9uZ2VyIGFjdGl2ZS4gVGhpcyBjaGFuZ2UgcmVt
b3ZlcyBTdGVmYW4ncyBlbWFpbCBmcm9tDQo+ID4gPiA+IHRoZQ0KPiA+ID4gPiBNQUlOVEFJTkVS
UyBsaXN0IGFuZCByZXBsYWNlcyBpdCB3aXRoIE1pY2hhZWwgSGVubmVyaWNoJ3MuDQo+ID4gPiA+
IA0KPiA+ID4gDQo+ID4gPiBBcmUgeW91IHBsYW5uaW5nIHRvIGZpeCBlbnRyaWVzIGFzIHBhcnNl
LW1haW50YWluZXJzLnBsIGRvZXM/DQo+ID4gPiAoTWF5YmUgaW4gYSBzZXBhcmF0ZSBjaGFuZ2Us
IGJ1dCBhbHNvIHdoeSBub3QgaGVyZSkNCj4gPiANCj4gPiBJIHRoaW5rIHBlcmhhcHMgeW91IHNo
b3VsZCBub3QgYXNrIHBlb3BsZSB0byB1c2UgcGFyc2UtbWFpbnRhaW5lcnMNCj4gPiBvbiBzcGVj
aWZpYyBzZWN0aW9ucyBhbnltb3JlIGFzIGl0J3MgcmF0aGVyIGNvbmZ1c2luZyB0byB1c2UgYW5k
DQo+ID4gaXQncyBiZXN0IGRvbmUgYXMgYSBvbmUtc2hvdCBieSBMaW51cyBvbmUgZGF5LiAgSSBo
b3BlIHNvb24uDQo+IA0KPiBXaHkgbm90PyBUaGUgYmVuZWZpdHMgYXJlDQo+ICAtIHBlb3BsZSB3
aWxsIGtub3cgYWJvdXQgdGhlIHRvb2wNCj4gIC0gdGhlIHBhcnRpY3VsYXIgc2VjdGlvbnMgd2ls
bCBiZSBmaXhlZCBzaW5jZSB0aGV5IGFyZSB0b3VjaGluZyB0aGUgZGF0YSBiYXNlDQo+IA0KPiBB
bmQgaXQgZG9lc24ndCBwcmV2ZW50IExpbnVzIG9yIGFueWJvZHkgdG8gcnVuIHRoZSBzY3JpcHQg
aW4gdGhlIGZ1dHVyZS4NCj4gDQo+IEFjdHVhbGx5IGl0IHdpbGwgdGVhY2ggcGVvcGxlIGFoZWFk
IHRvIHVzZSB0aGUgdG9vbCB0aGVuIGluIHRoZSBmdXR1cmUNCj4gd2Ugd29uJ3Qgc2VlIHN1Y2gg
ZHJhc3RpYyBkZXZpYXRpb24gaW4gb3JkZXJpbmcuDQo+IA0KDQppIGd1ZXNzIHRoaXMgbWVhbnMg
aXQncyBhIG5vb3AgZm9yIG1lIG5vdw0K
