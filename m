Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01EB66BB90
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jul 2019 13:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfGQLhk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Jul 2019 07:37:40 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:27812 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726284AbfGQLhj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Jul 2019 07:37:39 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6HBWdtp006565;
        Wed, 17 Jul 2019 07:37:33 -0400
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2057.outbound.protection.outlook.com [104.47.32.57])
        by mx0b-00128a01.pphosted.com with ESMTP id 2tseucbjj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 17 Jul 2019 07:37:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MW3McMrZIdIiMV/5C2NSGFh8u84HFL35GeXji8sSBaBb8dy/zsewakx8WK/05rCUN6ycaT6bCOSL4xxAN9vJnFlMDGyviMEYBBEYpAFHPeQMRen0fq5d/ZESqPf5CQKhRWp2OTc9xLKMinhxTDKWhEgcRGZsPphlofjhWOSduHWLmZnW4TuO+cf9TdR4401atf5jYwx86fHr2mGUNyJI3H5SoB9ZBkKtc4raThrqj0c17Fjn6ro7bDXSZFcP0m86KMISdNgeIXfd88yqkgzXNlKoKWayx5KEDGqkJ4wiuQ/5q7S4Uaprm1ZQiG3KUtOhcImKkX25ME6i+c3Bjg73Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/62Li/+WOL8auDphTDFwIJWEWbcQlGVfO7J++KEICrI=;
 b=RdEGva+I3w+Wm2Dn9DVmx0tBli3V9n7qwBRfCV3eviUiUrFsTN+JxTREYUzzVKdD+Rbd0Lu+ZdmrNGxdLodefLkjZTwP9FTrYEGwnHreASmvv+IeBoRh9aIFE2+/FjerXcGm9FHVWAHnWK3+Im6kkxlwDdnIrzmmKYPXn13kZ8E9pIs58VHo407Yc0vlWahXlOSjZV029gQJsM8W5egy6/cOrY+ZXAsLqUlpa06OMGu5zGMqIyc4hMTHUlo7yBH8TgtfBmwXPp7QkgQdoMMeT1aM4IYD1KdtmtS4j09i0hndmgMXgA9V/HYFCZNqtEqTjOCTy5PxCY+RSdOF2E/u2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=analog.com;dmarc=bestguesspass action=none
 header.from=analog.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/62Li/+WOL8auDphTDFwIJWEWbcQlGVfO7J++KEICrI=;
 b=Cx/sFpIku+GNgdyXFdX+KMs4QNo9Z86U0R4bLFWz786pJXkMc8DQdUP40235Qaj8Wraw3t9iy/3RjttKPejUjJTY5E/vYa93zb+GRy2wp5VfnFR95JTKQCoy6oKqsWegu8JSFkXnaN6sJveEYknd9efbqSg/U4h9bTCz+6xVM6o=
Received: from BN6PR03CA0059.namprd03.prod.outlook.com (2603:10b6:404:4c::21)
 by BN6PR03MB3268.namprd03.prod.outlook.com (2603:10b6:405:42::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2073.10; Wed, 17 Jul
 2019 11:37:32 +0000
Received: from BL2NAM02FT030.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::204) by BN6PR03CA0059.outlook.office365.com
 (2603:10b6:404:4c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2073.10 via Frontend
 Transport; Wed, 17 Jul 2019 11:37:31 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT030.mail.protection.outlook.com (10.152.77.172) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2052.25
 via Frontend Transport; Wed, 17 Jul 2019 11:37:31 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x6HBbTkn022360
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 17 Jul 2019 04:37:29 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS7.ad.analog.com ([fe80::595b:ced1:cc03:539d%12]) with mapi id
 14.03.0415.000; Wed, 17 Jul 2019 07:37:31 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "jic23@jic23.retrosnub.co.uk" <jic23@jic23.retrosnub.co.uk>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/5] drivers: spi: core: Add optional stall delay
 between cs_change transfers
Thread-Topic: [PATCH 2/5] drivers: spi: core: Add optional stall delay
 between cs_change transfers
Thread-Index: AQHVK1fSomHfBxPFU0OCnjvN6Hk0n6auh/0AgBQlDwCADGdXgA==
Date:   Wed, 17 Jul 2019 11:37:30 +0000
Message-ID: <138d96e8af0f1c873046b7257c6c40a3d4b9d95e.camel@analog.com>
References: <20190625131328.11883-1-alexandru.ardelean@analog.com>
         <20190625131328.11883-2-alexandru.ardelean@analog.com>
         <20190626193438.7248d0a9@archlinux> <20190709141228.GC14859@sirena.co.uk>
In-Reply-To: <20190709141228.GC14859@sirena.co.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.65.145]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E005C72BC45774396FB9D4262E0F4AE@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(39860400002)(346002)(2980300002)(189003)(199004)(478600001)(305945005)(229853002)(8676002)(7636002)(7736002)(246002)(186003)(76176011)(54906003)(6116002)(2486003)(3846002)(356004)(6246003)(102836004)(316002)(7696005)(5660300002)(23676004)(2906002)(47776003)(106002)(8936002)(50466002)(86362001)(336012)(26005)(14454004)(2501003)(4326008)(36756003)(436003)(70586007)(14444005)(70206006)(426003)(2616005)(446003)(476003)(110136005)(11346002)(118296001)(126002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB3268;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4aefd7fc-a679-4338-c332-08d70aab27b7
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:BN6PR03MB3268;
X-MS-TrafficTypeDiagnostic: BN6PR03MB3268:
X-Microsoft-Antispam-PRVS: <BN6PR03MB3268CAEED874A9B6FC621EA0F9C90@BN6PR03MB3268.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 01018CB5B3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: PwatC3izswdn6/61KzDJYC+CwlHDBANnsDe6LwySF9jFuR4EC6UYeIT7NKMCLGaJ+yuaRsLC+76EJVHWZxYmV5RqaMe45U63Km41R+sRpEG7VeTyuC8DPAcKjB0S2aci/dbM4cf6BqI9oTqVfuL29Jwd5H7ZDQrWNcM0ifSv0btXcPa/V17euHFF0Bfy/SNyoSgVPrFo0ooNNEQJ1sPYbNsFifGkz3P/6DRZoaMUGpo1+ALj0SACnEnobAN98eHMrLXXA5rXhaeJ1BHY7YB2Tu/1VcJr9NNiHhDZy3mofb66NsffhOShk8A382MA0SQtboZNIkqQjwAXVY6c/tD58STkSM2oP4w/PzIG59yGeoX9Bb/UNvNimcRwcMZxgOHsf0It/0hTbj7UzFpqnC+OZWk6NrRdkkmcP87ZS52iq1c=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2019 11:37:31.7223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aefd7fc-a679-4338-c332-08d70aab27b7
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3268
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-17_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907170142
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDE5LTA3LTA5IGF0IDE1OjEyICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBXZWQsIEp1biAyNiwgMjAxOSBhdCAwNzozNDozOFBNICswMTAwLCBKb25hdGhhbiBDYW1lcm9u
IHdyb3RlOg0KPiA+IE9uIFR1ZSwgMjUgSnVuIDIwMTkgMTY6MTM6MjUgKzAzMDANCj4gPiBBbGV4
YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPiB3cm90ZToNCj4g
PiANCj4gPiA+IFNvbWUgZGV2aWNlcyBsaWtlIHRoZSBBRElTMTY0NjAgSU1VIHJlcXVpcmUgYSBz
dGFsbCBwZXJpb2QgYmV0d2Vlbg0KPiA+ID4gdHJhbnNmZXJzLCBpLmUuIGJldHdlZW4gd2hlbiB0
aGUgQ1MgaXMgZGUtYXNzZXJ0ZWQgYW5kIHJlLWFzc2VydGVkLiBUaGUNCj4gPiA+IGRlZmF1bHQg
dmFsdWUgb2YgMTB1cyBpcyBub3QgZW5vdWdoLiBUaGlzIGNoYW5nZSBtYWtlcyB0aGUgZGVsYXkN
Cj4gPiA+IGNvbmZpZ3VyYWJsZSBmb3Igd2hlbiB0aGUgbmV4dCBDUyBjaGFuZ2UgZ29lcyBhY3Rp
dmUuDQo+IA0KPiBUaGlzIGxvb2tzIGxpa2UgY3NfY2hhbmdlX2RlbGF5Lg0KPiANCj4gQXMgZG9j
dW1lbnRlZCBpbiBTdWJtaXR0aW5nUGF0Y2hlcyBwbGVhc2Ugc2VuZCBwYXRjaGVzIHRvIHRoZSAN
Cj4gbWFpbnRhaW5lcnMgZm9yIHRoZSBjb2RlIHlvdSB3b3VsZCBsaWtlIHRvIGNoYW5nZS4gIFRo
ZSBub3JtYWwga2VybmVsDQo+IHdvcmtmbG93IGlzIHRoYXQgcGVvcGxlIGFwcGx5IHBhdGNoZXMg
ZnJvbSB0aGVpciBpbmJveGVzLCBpZiB0aGV5IGFyZW4ndA0KPiBjb3BpZWQgdGhleSBhcmUgbGlr
ZWx5IHRvIG5vdCBzZWUgdGhlIHBhdGNoIGF0IGFsbCBhbmQgaXQgaXMgbXVjaCBtb3JlDQo+IGRp
ZmZpY3VsdCB0byBhcHBseSBwYXRjaGVzLg0KDQpBY2suDQpbU29ycnkgZm9yIHRoZSBsYXRlIHJl
cGx5OyBJJ20gYmFsYW5jaW5nIG90aGVyIHN0dWZmIGFzIHdlbGwgYW5kIHRlcnJpYmxlIGF0IGl0
XQ0KDQpJJ2xsIHByb2JhYmx5IHVwZGF0ZSBteSBwcmFjdGljZSB0byBhbHNvIGluY2x1ZGUgbWFp
bnRhaW5lcnMgdmlhIC0tY2MgdG8gYGdpdCBzZW5kLWVtYWlsYC4NClVwIHVudGlsIG5vdywgSSB3
b3VsZCBzZW5kIGVtYWlscyB0byBsaXN0cyBbYXMgbXVjaCBhcyBwb3NzaWJsZV0gYW5kIHRyeSB0
byBub3QgaW5jbHVkZSBwZW9wbGUgZGlyZWN0bHkuDQpNeSBhc3N1bXB0aW9uIHdhcyB0aGF0IHRo
ZSBsaXN0IGlzIGVub3VnaC4NCg0KSSdtIHN0aWxsIGFkanVzdGluZyB0byBob3cgdGhpbmdzIGdl
dCBkb25lIGluIHRoZSB2YXJpb3VzIExpbnV4IGtlcm5lbCBzdWJzeXN0ZW1zL3N1Ymdyb3Vwcy4N
Cg==
