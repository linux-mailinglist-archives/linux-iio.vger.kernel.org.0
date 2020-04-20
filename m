Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5C31B016D
	for <lists+linux-iio@lfdr.de>; Mon, 20 Apr 2020 08:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbgDTGTX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Apr 2020 02:19:23 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:33522 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725815AbgDTGTV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Apr 2020 02:19:21 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03K6FHCl015229;
        Mon, 20 Apr 2020 02:19:19 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-00128a01.pphosted.com with ESMTP id 30fx6849fp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Apr 2020 02:19:18 -0400
Received: from m0167090.ppops.net (m0167090.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03K6JIji018542;
        Mon, 20 Apr 2020 02:19:18 -0400
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2059.outbound.protection.outlook.com [104.47.37.59])
        by mx0b-00128a01.pphosted.com with ESMTP id 30fx6849fm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Apr 2020 02:19:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFozGBWxwBfAPrm5u5PHd9tCcESdq1bcksOPOOREJBmI4clXqkd79H5pzlj477CqSSYHx0QLpdpotAmGSRN13si6+pJT6GFbjkYwTR+ZH29/sXRaa4qJrgCwn3NFp/j20jYQKtzffFsH2WJyQ2n6zOXzglMRNjQpIq7WokK/ZCSXMC4/+2KCkQlloDLtx1JJ+6U5kE3kjiIN00zCLzDl2SBLcbErKHbV+P4ZcEAWgkH5ptdBLT15iAfrs5/Xi5dQ6UzJvga60xREEngT/FouqidVFbeLXEkRikh20CKIKb1Hbsy5+cYiqe+hDkjNgNRTDhy9bSJMF6l22eoTI8KsAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiBEVxA1W9BxyD0uXl5ZTd8rhWKaYPH9vHfJgbsxF+U=;
 b=IMAGqIWkACBV5xQayqvsSpFTXdxZBhTSKqHYIorDcLvfN0RNJL+7c9NjGwm/1toFaDjPJQpz2avTwuWNnZ7/9Q2+606RSCqs0ofv5MzR0slA3YkdNjS0Z/13Jln0YawRPJuSRYg6hutJ6tqSPPbpVuJC6uWejf7dDmtilfRtBwBKFbr3lj1ciN5LlBuF01pT5eVATZ9F1Qk3YRIliw4fOEdFNe5/imHPi2sWmacJgeDQaw1mpxP4mAOaY+2uQCI6X+174JQDpQ2ePHhh5AIaj/h3uevEy0XOf6LQ+p+YojP8f1fKKNaDKWoP7VxsTwwXpycdfxcfp0/nKLcPjrYNzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiBEVxA1W9BxyD0uXl5ZTd8rhWKaYPH9vHfJgbsxF+U=;
 b=RGZCtSz79A9QusRBzSjn2+Tg1elQ6jiM4UJsEwUty7E8CMLKUKT3kRiifhvd0Jfrhx8LxC9+aCc5mC9sNo2YJkK644g3FWKflz785vNdeH8a/DQk2CwxaEdJM41BwBS7DHfWF5LF46U7nCSA6ERBGVXS6dBNVUQCHujE5pA0DXw=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4987.namprd03.prod.outlook.com (2603:10b6:5:1eb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Mon, 20 Apr
 2020 06:19:17 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2921.030; Mon, 20 Apr 2020
 06:19:17 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 7/7] iio: light: vl6180: swap of.h for mod_devicetable.h
 and drop of_match_ptr
Thread-Topic: [PATCH 7/7] iio: light: vl6180: swap of.h for mod_devicetable.h
 and drop of_match_ptr
Thread-Index: AQHWFlvXQj8wNMwlzUSC4y4MFUucEKiBi6OA
Date:   Mon, 20 Apr 2020 06:19:17 +0000
Message-ID: <0d3e8e58e39060ce9a28f2bb3b1d0161f4ed36f1.camel@analog.com>
References: <20200419150206.43033-1-jic23@kernel.org>
         <20200419150206.43033-8-jic23@kernel.org>
In-Reply-To: <20200419150206.43033-8-jic23@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.27.130.47]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 48f5431c-17ec-43a9-f991-08d7e4f2c152
x-ms-traffictypediagnostic: DM6PR03MB4987:
x-microsoft-antispam-prvs: <DM6PR03MB4987C6B05C97DBC274259FF5F9D40@DM6PR03MB4987.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 03793408BA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(396003)(136003)(376002)(39850400004)(346002)(366004)(76116006)(71200400001)(2906002)(8936002)(81156014)(8676002)(6486002)(4326008)(6512007)(91956017)(86362001)(6506007)(36756003)(2616005)(186003)(316002)(26005)(478600001)(110136005)(5660300002)(4744005)(64756008)(66556008)(66446008)(66946007)(66476007);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C1vfGkmDwMQ8g8GMcuARnKxZzY0yy69NXT7EPVelu/HOBtWsJhfAkRz5mCGbV4DKwqS8OrtjI2gUR6ZokNFE/DI2IfUD1lo/lIZAJ+DfN/KxW380olCi3sH6237Z6PwU6J+jsU7Y32DCeYXpzzbaIGM5iqQb19EU16LzqE8hgAl2waJ5D1J82M6R6UriUk0xcbGNysnrkrlXRvyHzmKZVHTDnQTnOH0ee1VotKEXay9OGNuzhcAegjqDNFKc19QMSckWL0CfO0890VY3CUiQ0K2kCZolDhNOhxy7x4ZtzV6euVnp5wZG4RWNSWg/Su0dMRtsrt8FoZ4eIfu9Ip6L79iIZuJ3u/7VnL9hNMdF7SflMCEjwUmIREOlDnrnFnNxXd7kg9UjbxYL/WK2CGqQ2UiQNtA1pshVfzzYZQJDNFTXdXrS9B7Cn9R1Gfe4zoEJ
x-ms-exchange-antispam-messagedata: yxj4Jk5KPltHEvp4DApGjN0p55J3YUmPgpq4c1+X62L1PrTmS5cVoHWYHJ+mKbqbTfkYBH4Ki5r4csgYzGfu/+uR4RHyucOJuQiW8Cp9N2vM0c+DFD9D3oBgvU585IEh//gnwDgufv7G3DE4PhkACw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <60B6E8B4D184EF47808A032476CD3DC4@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f5431c-17ec-43a9-f991-08d7e4f2c152
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2020 06:19:17.1784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5P9K6ZBAw9rhQSIWnFHunasbZ5Vn6T/VlugY8WYp7f2254biOMWbo7xncJ2RLLUNGzqfqzXPdj5cPFpgxFI2M/OgJxBakiatHRIo+zY5ies=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4987
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-20_02:2020-04-17,2020-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004200055
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDIwLTA0LTE5IGF0IDE2OjAyICswMTAwLCBqaWMyM0BrZXJuZWwub3JnIHdyb3Rl
Og0KPiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+
DQo+IA0KPiBFbmFibGVzIHByb2JpbmcgdmlhIEFDUEkgUFJQMDAwMSByb3V0ZSBhbmQgcmVtb3Zl
cyBhbiBleGFtcGxlIG9mDQo+IGFuIGFwcHJvYWNoIHdlIG5vIGxvbmdlciB3YW50IHBlb3BsZSB0
byBjb3B5Lg0KPiANCg0KVGhpcyBkb2Vzbid0IGluY2x1ZGUgJ2xpbnV4L21vZF9kZXZpY2V0YWJs
ZS5oJy4NCkknbSB3b25kZXJpbmcgbm93IGlmIGl0IGlzIG5lZWRlZCBhdCBhbGwuDQpTaG91bGQg
d2UgcmVtb3ZlIGl0IGZyb20gdGhlIHJlc3Q/DQoNCldpdGggdGhhdCBhZGRyZXNzZWQ6DQoNClJl
dmlld2VkLWJ5OiBBbGV4YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cu
Y29tPg0KDQo+IFNpZ25lZC1vZmYtYnk6IEpvbmF0aGFuIENhbWVyb24gPEpvbmF0aGFuLkNhbWVy
b25AaHVhd2VpLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2lpby9saWdodC92bDYxODAuYyB8IDIg
Ky0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2xpZ2h0L3ZsNjE4MC5jIGIvZHJpdmVycy9paW8v
bGlnaHQvdmw2MTgwLmMNCj4gaW5kZXggZDk1MzNhNzZiOGY2Li43ZTY3ZDdiM2JmYjYgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvaWlvL2xpZ2h0L3ZsNjE4MC5jDQo+ICsrKyBiL2RyaXZlcnMvaWlv
L2xpZ2h0L3ZsNjE4MC5jDQo+IEBAIC01MzcsNyArNTM3LDcgQEAgTU9EVUxFX0RFVklDRV9UQUJM
RShpMmMsIHZsNjE4MF9pZCk7DQo+ICBzdGF0aWMgc3RydWN0IGkyY19kcml2ZXIgdmw2MTgwX2Ry
aXZlciA9IHsNCj4gIAkuZHJpdmVyID0gew0KPiAgCQkubmFtZSAgID0gVkw2MTgwX0RSVl9OQU1F
LA0KPiAtCQkub2ZfbWF0Y2hfdGFibGUgPSBvZl9tYXRjaF9wdHIodmw2MTgwX29mX21hdGNoKSwN
Cj4gKwkJLm9mX21hdGNoX3RhYmxlID0gdmw2MTgwX29mX21hdGNoLA0KPiAgCX0sDQo+ICAJLnBy
b2JlICA9IHZsNjE4MF9wcm9iZSwNCj4gIAkuaWRfdGFibGUgPSB2bDYxODBfaWQsDQo=
