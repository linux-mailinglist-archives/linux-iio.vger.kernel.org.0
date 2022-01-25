Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE58149B87E
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jan 2022 17:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242291AbiAYQVi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 25 Jan 2022 11:21:38 -0500
Received: from mx0c-0054df01.pphosted.com ([67.231.159.91]:52149 "EHLO
        mx0c-0054df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245523AbiAYQQD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Jan 2022 11:16:03 -0500
Received: from pps.filterd (m0208999.ppops.net [127.0.0.1])
        by mx0c-0054df01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20PCEDbQ028781;
        Tue, 25 Jan 2022 11:15:07 -0500
Received: from can01-to1-obe.outbound.protection.outlook.com (mail-to1can01lp2054.outbound.protection.outlook.com [104.47.61.54])
        by mx0c-0054df01.pphosted.com (PPS) with ESMTPS id 3dsvtr0wn6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 11:15:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YuvG0sliP9JY9WFtRWeLhzHkaeO5ueKCdfmF2lddY3P3WsGStplKyIC0Ot+xj2Bq8RMBquLeRiPbX7lskQg1b0QD0pEGPyciBIZIzSxFH0Jks5Ij/zl3wbXDAV0oG3IgDlNRHwfZ7ifXd/K+zu4gx/lfljIsJJJE9SBVongJLatLtjeuetwg9TyY++Vf3mAnOJjXh9AHxPoMIj3VMmQiqv9a0adCV0xE/evDXbcheV8G6rYQBEWLAKwYtBp0aNEmEzpibjvlKayDghP/Pz1lONrbExhnslbTaVfF9ZpSEWpw+IsSWhFwfTYVPzpTXa61MvKrWzZ+owoUFc3C2htttw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chy+u6A+BkIRiuVIKn8Zfez2DROQXpWblOLhdLhZmbw=;
 b=PPoHRvXrWbvzLG8CIuohNkfAir1O6RpNazlgEM3CpYvir50B4oCaLcv5U+8/Mfydn15+Ldh6POo1oJ9uRgVTC2gLtByL2p2S8QPDwVd6cbRlHjU4oBFDqB4eiURV9u1lIHsJOzQ8DZYO9D6rNgUlG87K4Tw2KdpD6OJCYPDDWEwc9yqm9/oXgQw3LXatF0UQSwT9ZG62FdTMW6qOih2MatOXVBzqUKO7aY89/sMvr8Vx4Ek10QDeJXyy9VZ+6w3Jb145Da5sq345WfT/RKKP5K0WSEsUovJClha3iTDP3e9W8mcGjhRM5tBvu0IKEwOyCowiW3/gpWsf7BM25J6BLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chy+u6A+BkIRiuVIKn8Zfez2DROQXpWblOLhdLhZmbw=;
 b=rRehOQYbaKrECkNKQI09XmGmsXhXdbWl5Ts8Brnqx1eVqME8x6XKhMOOj2kx0IwOQmWHseuqU0w72fd57Fr57AA/hsp9joTNTcsiZr1q/OyvZxKlzGFoJdQPbekewAadq/ZCgHXSRhtHmlE+6tog4kgltihWhF4KgUsL0nNibYE=
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:6a::19)
 by YQBPR0101MB8685.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:55::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Tue, 25 Jan
 2022 16:15:06 +0000
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6929:c39f:d893:b6c8]) by YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6929:c39f:d893:b6c8%2]) with mapi id 15.20.4888.020; Tue, 25 Jan 2022
 16:15:05 +0000
From:   Robert Hancock <robert.hancock@calian.com>
To:     "m.tretter@pengutronix.de" <m.tretter@pengutronix.de>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "manish.narani@xilinx.com" <manish.narani@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "anand.ashok.dumbre@xilinx.com" <anand.ashok.dumbre@xilinx.com>
Subject: Re: [PATCH 3/4] iio: adc: xilinx-ams: Fixed wrong sequencer register
 settings
Thread-Topic: [PATCH 3/4] iio: adc: xilinx-ams: Fixed wrong sequencer register
 settings
Thread-Index: AQHYDZl65EvCNJi2CES6Gp15w7AZTaxzbc4AgACEbIA=
Date:   Tue, 25 Jan 2022 16:15:05 +0000
Message-ID: <4c5fb3899a8aafa34106a668bcb2807b6f073036.camel@calian.com>
References: <20220120010246.3794962-1-robert.hancock@calian.com>
         <20220120010246.3794962-4-robert.hancock@calian.com>
         <20220125082108.GE25856@pengutronix.de>
In-Reply-To: <20220125082108.GE25856@pengutronix.de>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5 (3.28.5-18.el8) 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52eace8d-8464-44d3-0e6e-08d9e01dd9a3
x-ms-traffictypediagnostic: YQBPR0101MB8685:EE_
x-microsoft-antispam-prvs: <YQBPR0101MB86850A4647B1726A3D13B2ACEC5F9@YQBPR0101MB8685.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GZHJT5zy2FszWVn5IKBAhH7FpelFjgSVNS2BtnelBuYTXennzzGQJskslQKiT2HtEntKRwMS9bBL62ekgBzFqmJePsNyrTUeab0P7rIwE+ch9Nim6vaUy9Z/3RmAEGWWdkOm1mFOCAIULkgWl+OqCgNVVK25Ea+jvN2Y13roIGM+Mvjp+H4mr6WZ6gvUVLOCZaTP8H9wqycoFwJBpmilxmdvzpuPUQqV2wbiRCFQfosm77qE59L9YbF6KOPxEaWp9F2+kXvamVzrZkU+LasTdXXX6HjyyMoGJetT0h+4F6tYBRA1C3W908rMyLqNFPZF1Kj7KUE0YTGctLGKlq41kHib2THIpajDeZ01IgvD/uJdsySGcU6rFCpEUPRYtPLla5S9de93URv3qwi2KhUxdI9FRfdO2HYUHRUh1umc7ZIqTMyoXEHcOhj4zj400uywu9DECvBN7wGz2XvMgMS5d//5n5G0EAT7DRA2Tf1oSovxUDCjXVPaIZWiKZJjstI+LPu5q/KF7wx/+MQVzLTG4cHCovLyyqb4q95ocjNTJ+Lcrtq8brH9IJZ3o+QhPOViUhhPy2hRr0alcueFWhkQrxsHqotkesJRMffcEsu91BBYevOaz2G1F4j560ud+mLfUBuZTws7zkqHQxuI4sVfnFB+/Jj8heeIzkMmhOXrH2IESnkWJyJCMS5O7HHT2rFyX2vZx8KDxzQKErywuyaZbPzrykIp6P4n+5uQsnQFU4lR122eahMxIi3dI8+n+0ZGNTEsYbNa3NA8MyZycyfJcCxRi7tBO4aElD90mYjehy/OIgBriYUYB07vQeTJpl4sFqhQ1tBXQzBXsvqcCJaF9YtSq37bF32yfypirZN1nSg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(122000001)(7416002)(6512007)(44832011)(4326008)(8676002)(5660300002)(38070700005)(86362001)(2906002)(38100700002)(8936002)(83380400001)(54906003)(91956017)(508600001)(2616005)(64756008)(76116006)(66946007)(6916009)(66556008)(66476007)(66446008)(26005)(6486002)(36756003)(71200400001)(186003)(316002)(15974865002)(966005)(99106002)(18886075002)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUhXM1l2R1BGS2hFQk0zdHBlU1NUbmQ4emNpQ3ArMVlzcW5iZGJ6d0V2c3pw?=
 =?utf-8?B?TlNmNFVvd3NRbFlOc2MxSllaWjFINTk0ZlNIcXpHU052aVk0ZGpNVDRzU0pH?=
 =?utf-8?B?L0tYblZIMUY1b2ZTYzlwRWZMeEtZa0Y0RG5yY1Uwb0JyR1BYMTVwSG5scWho?=
 =?utf-8?B?elpKQlRVTEE3b0h4VUxRS3FSVDJlMEtaRU9lNUFNN0lRRVZCK0N4ZGlPWDFX?=
 =?utf-8?B?QmdnZnY3OTJGZHZMTjZVOFQvUW5xUkFHVWRRU2xJMnEwd1o1ejg5enM2MlpS?=
 =?utf-8?B?QVplcDU1blBsYVZUSGkwODFLQVkxS1E3eXRZd25STGk3MmZOZ3lvUVQreWI0?=
 =?utf-8?B?ZUE0ZDBlRWg4Y3hhSUZRa29GeFBRdTVSQU9CSUdTQ1hZY1k0aTNmR3I1bTQ3?=
 =?utf-8?B?Z3BXek5YVEk4dDB5aWZDSzJvZ3QzY0xKcnhVTS8xd3lmL1psdG5CaG8zZFZU?=
 =?utf-8?B?a2diSlNmT0ZzcDJ5a0pwNGNzb3VrSmpwY2tGZGRvZFZzOW1POG8zZDVkaW9M?=
 =?utf-8?B?eVF1WlA3UDhPZ3BtY2pyRW90ZXFWUkhxL3lpWWh3TTVYUHJGTkJxYW5vVjN6?=
 =?utf-8?B?OWQyNVluSkJMd2VHaUlCb3RNMWk2SlFBOUtvbHI3dHZCbnBSdVdkb1BkQTBu?=
 =?utf-8?B?MitGME5JUHZ2MjUraXY2em9DWG1tTmZHV2E0cVJ6TVNrUXRWdzM3eUdmcSts?=
 =?utf-8?B?cHVYQUZvVHBMTnJFWVFYRlhIRko1RklKSzZscnRCOUo1c2tHRzFRcUFnaWxT?=
 =?utf-8?B?Y1hHMzJiUDREQ1RpOHpUMUJxYi9OSVVmNUJvdytqYVh1djJCWEg2WlIxbS9S?=
 =?utf-8?B?MVJqcXVzc1VGZEhSSUh1LzA1dHNaL1F4VUcxNzdrRUZrT2t3Ymp4Z0hENXZl?=
 =?utf-8?B?NlhaSXQzQzF4RVZKUUNiNWdRUmRLSERZVy9XRUt1Z2M2SUJMSlA2VGhMSmhq?=
 =?utf-8?B?b1RQTXJiMDUybk1kNXRRWng4dVpvN0x2RGt3YlhBZWR5SWFnK1lKaWdpaFhi?=
 =?utf-8?B?L2Y4ak1NNEkvNTZOb0ZuMENZMnhCWlZPK0J1Z08vendUWHB0d3pZa1lmbGZV?=
 =?utf-8?B?bUxTWUYwUWxTQkNvTkhZOFMxZXlvTk4zakFEMUszNFVhVStZRTJ1NU9zZmFL?=
 =?utf-8?B?N25aamN6MlB5UWJ6Rzhvd1VSZUg4d3VwSHBFb2hMZ1N5SmlkUnhOeThnSFZE?=
 =?utf-8?B?QWN4TFdJU0lnQkVSTzNweC81c1NOTE5MZDZxbUVDckc1Tkd6RmFDOWlOUnBN?=
 =?utf-8?B?ZUJCVWtsd1hiSFZwYmR2bFRmbmlmdjRNVGQ0bGcrbDNtZXZnREJKT0hhQXl2?=
 =?utf-8?B?WFJ3ZVp4bmc2MlhDTDlGQnBVOGlLT2xsc3p2MzJKTWwzS1ZDNnNheWhIMThB?=
 =?utf-8?B?eDJZMXBFUGZrVEFINGV2d3lFNGxYdFk5Y0dnWVlhYkZuZXFnRmpBY0RzdnJq?=
 =?utf-8?B?UXhxNXZSd05DOS9CbHJ5b2RhZ3Q5TVo3cUZhY2pxOU1wTmdkaS9HRHFOUEFI?=
 =?utf-8?B?RFJabTBCY3U5VTU0WXNqeDc1K1oyeUp0TnQyaTNrL2FIWmpxczVDYTZRalE1?=
 =?utf-8?B?bEV6bDBBUWFPd3hhZFAybGd4ZWVhTXlrTVYxcldFK2RWY2QxU1lOdFQrejh0?=
 =?utf-8?B?SDY4YVpoV2hQU21NZy9Oc0d6NUV1RWVERjZjZE5NcWNDNjR5TXlRczZmZitm?=
 =?utf-8?B?cmZ6bHMvci9SbnUrbzFBdlpHRXNCUk04blNJNDYyTW1INEhwR1RRdjlZZ2tu?=
 =?utf-8?B?bU1Hc1lkTGlpTFVQVCtpZzM1c0todlJTR2s4RFphZ1dKb2pFMWQ3YVRadzhv?=
 =?utf-8?B?czZXSWtjOTZnWDRTNHZJZkpSZ3Y4RG0ySFA1WnBKTjN6SDE3NTZ0MERhUkhl?=
 =?utf-8?B?Uk1ROVp5NnVvajVhT1JZVmI4Sml0bWVtTS9WMlJFSkRKZHlwNnNHSkJPTHB2?=
 =?utf-8?B?TkpaK3J2ckM1ZXJtMTNHTVg1VkJ4WHdWZEdIUjQ0QmJ2ci9PUkI2SHQ3Njhn?=
 =?utf-8?B?Ynd0VVpwVWorUlFTTkhIQ3l6TUp0T2hCekkrcWZ1NlVQYWxKVXZXWnE0aGhP?=
 =?utf-8?B?dFVJNkp2eXFOb2VHN3JIS0xwTHlST0cxeHZydlNBRDg2NlUvM05YKzFPcWFt?=
 =?utf-8?B?UjNpVjlRV3VyNjZIdndTM2w0V1l1MVB1WGhiVUV2Q1lPWldnQzJKSGlCVTA0?=
 =?utf-8?B?KzVQMktQbmVLeHhjVzN1SXN5OG45NUtwZDR1d2RIUHEzSU5sbVpINVA1WVlx?=
 =?utf-8?Q?SON41BAZS0JOQFJrvO+/QpCwjXQS4M/ikoOglB18Og=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2C65E2A0E8AC3841BEA0CED96897D70D@CANPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: calian.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 52eace8d-8464-44d3-0e6e-08d9e01dd9a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2022 16:15:05.9338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b57807-562f-49ad-92c4-3bb0f07a1fdf
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sJAutMjmrDgiYPkxRUkL8ckUuIRNZZ4iCv20z8EQDnj8rdNthMxDWM1/KI2Pyk7nrY5QgSOAKKzIrS2Xzu3M3ADcZnc640VyODCGCTU+hfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB8685
X-Proofpoint-ORIG-GUID: mxhzIarMpZxpyBcT1uU4SrZGBTphX2bg
X-Proofpoint-GUID: mxhzIarMpZxpyBcT1uU4SrZGBTphX2bg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-25_03,2022-01-25_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 clxscore=1011 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201250104
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDIyLTAxLTI1IGF0IDA5OjIxICswMTAwLCBNaWNoYWVsIFRyZXR0ZXIgd3JvdGU6
DQo+IE9uIFdlZCwgMTkgSmFuIDIwMjIgMTk6MDI6NDUgLTA2MDAsIFJvYmVydCBIYW5jb2NrIHdy
b3RlOg0KPiA+IFJlZ2lzdGVyIHNldHRpbmdzIHVzZWQgZm9yIHRoZSBzZXF1ZW5jZXIgY29uZmln
dXJhdGlvbiByZWdpc3Rlcg0KPiA+IHdlcmUgaW5jb3JyZWN0LCBjYXVzaW5nIHNvbWUgaW5wdXRz
IHRvIG5vdCBiZSByZWFkIHByb3Blcmx5Lg0KPiA+IA0KPiA+IEZpeGVzOiBkNWM3MDYyN2E3OTQg
KCJpaW86IGFkYzogQWRkIFhpbGlueCBBTVMgZHJpdmVyIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBS
b2JlcnQgSGFuY29jayA8cm9iZXJ0LmhhbmNvY2tAY2FsaWFuLmNvbT4NCj4gPiAtLS0NCj4gPiAg
ZHJpdmVycy9paW8vYWRjL3hpbGlueC1hbXMuYyB8IDQgKystLQ0KPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2lpby9hZGMveGlsaW54LWFtcy5jIGIvZHJpdmVycy9paW8vYWRjL3hpbGlueC1h
bXMuYw0KPiA+IGluZGV4IGI5Mzg2NDM2MmRhYy4uMTk5MDI3YzkzY2RjIDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvaWlvL2FkYy94aWxpbngtYW1zLmMNCj4gPiArKysgYi9kcml2ZXJzL2lpby9h
ZGMveGlsaW54LWFtcy5jDQo+ID4gQEAgLTkxLDggKzkxLDggQEANCj4gPiAgDQo+ID4gICNkZWZp
bmUgQU1TX0NPTkYxX1NFUV9NQVNLCQlHRU5NQVNLKDE1LCAxMikNCj4gPiAgI2RlZmluZSBBTVNf
Q09ORjFfU0VRX0RFRkFVTFQJCUZJRUxEX1BSRVAoQU1TX0NPTkYxX1NFUV9NQVNLLA0KPiA+IDAp
DQo+ID4gLSNkZWZpbmUgQU1TX0NPTkYxX1NFUV9DT05USU5VT1VTCUZJRUxEX1BSRVAoQU1TX0NP
TkYxX1NFUV9NQVNLLCAxKQ0KPiA+IC0jZGVmaW5lIEFNU19DT05GMV9TRVFfU0lOR0xFX0NIQU5O
RUwJRklFTERfUFJFUChBTVNfQ09ORjFfU0VRX01BU0ssDQo+ID4gMikNCj4gPiArI2RlZmluZSBB
TVNfQ09ORjFfU0VRX0NPTlRJTlVPVVMJRklFTERfUFJFUChBTVNfQ09ORjFfU0VRX01BU0ssIDIp
DQo+ID4gKyNkZWZpbmUgQU1TX0NPTkYxX1NFUV9TSU5HTEVfQ0hBTk5FTAlGSUVMRF9QUkVQKEFN
U19DT05GMV9TRVFfTUFTSywNCj4gPiAzKQ0KPiANCj4gVGhlIFRSTSBzdGF0ZXMgdGhhdCBDb250
aW51b3VzIExvb3AgTW9kZSBpcyAyLCBidXQgU2luZ2xlIFBhc3MgU2VxdWVuY2UgTW9kZQ0KPiBp
cyAxLCBub3QgMy4gSXMgdGhlcmUgYSByZWFzb24sIHdoeSB5b3UgbmVlZCB0byBzZXQgYm90aCBi
aXRzPw0KDQpTaW5nbGUgcGFzcyBzZXF1ZW5jZSBtb2RlICgxKSBqdXN0IHJ1bnMgdGhlIHNhbWUg
c2VxdWVuY2Ugb25seSBvbmNlLiBUbyByZWFkDQp0aGVzZSB2YWx1ZXMgaXQgbmVlZHMgdG8gc3dp
dGNoIHRvIHNpbmdsZSBjaGFubmVsIG1vZGUgKDMpLg0KDQpUaGUgcmVnaXN0ZXIgYml0cyBhcmUg
ZGVmaW5lZCBpbiBUYWJsZSAzLTggb2YgDQpodHRwczovL3d3dy54aWxpbnguY29tL3N1cHBvcnQv
ZG9jdW1lbnRhdGlvbi91c2VyX2d1aWRlcy91ZzU4MC11bHRyYXNjYWxlLXN5c21vbi5wZGYNCiAu
DQoNCj4gDQo+IE1pY2hhZWwNCj4gDQo+ID4gIA0KPiA+ICAjZGVmaW5lIEFNU19SRUdfU0VRMF9N
QVNLCQlHRU5NQVNLKDE1LCAwKQ0KPiA+ICAjZGVmaW5lIEFNU19SRUdfU0VRMl9NQVNLCQlHRU5N
QVNLKDIxLCAxNikNCj4gPiAtLSANCj4gPiAyLjMxLjENCj4gPiANCj4gPiANCj4gPiBfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiA+IGxpbnV4LWFybS1r
ZXJuZWwgbWFpbGluZyBsaXN0DQo+ID4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnDQo+ID4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbF9fOyEhSU9Hb3MwayF5R0ZF
alNDMUJMMjBsd3VyYnk5MTRsZW4wSENMWHl6YXJ3eEtKUDlKeDMwcXZfcXJFUlNrUkpVaVZvXzJN
ZHVzTVZBJCANCj4gPiANCi0tIA0KUm9iZXJ0IEhhbmNvY2sNClNlbmlvciBIYXJkd2FyZSBEZXNp
Z25lciwgQ2FsaWFuIEFkdmFuY2VkIFRlY2hub2xvZ2llcw0Kd3d3LmNhbGlhbi5jb20NCg==
