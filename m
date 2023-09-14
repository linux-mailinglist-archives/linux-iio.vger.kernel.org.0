Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF227A056E
	for <lists+linux-iio@lfdr.de>; Thu, 14 Sep 2023 15:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238587AbjINNUU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 Sep 2023 09:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235397AbjINNUT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 Sep 2023 09:20:19 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50F11A5
        for <linux-iio@vger.kernel.org>; Thu, 14 Sep 2023 06:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1694697614; x=1726233614;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VRNJTmGYsq7eL2bpYrks/9ontnitlft9Po0iMKXqm3E=;
  b=L+8cyxzXvp178KejWbMD/7azz8jpIIiNkn5lPjnFgCpFKYIXW1E2Rn9t
   fSSrjrpj073dHcYc81+HGpFBKb+Bnt5QxFjFIbzyEN1TX5tWey4533BD4
   ggpjONu86QMdi4Digw3uqUAK73HvpKnyeK8Xda2vC6dVlfEC/75rqM7vV
   U7h5WqWoHriX0s8Uqy5ngycnEdGqoOfQ+NqFqcE14HCcYjof8Jn8OiZTq
   9TtRgKrT1kSVkEGGYoGXDxmGl3hEgT/kMunjo9luoWgZVWVhVgYoHb36O
   Vy5EdzZ7s16b9k5ivsD3MO6HOzRIJqsyzfLv0hZ6ktZTu2DujyCFY4+rT
   A==;
X-CSE-ConnectionGUID: IoZoVI0mQIKorGjM1dKr0Q==
X-CSE-MsgGUID: CydvWSNnS7WTM7Q9KRcVaw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="4528103"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Sep 2023 06:19:35 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 14 Sep 2023 06:19:35 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 14 Sep 2023 06:19:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=We7VwlxF2H/b/33JsVsdr5CkOCqmPMUVHBNt/SdKvQbJyDKukXLmqEkEOtQ+Ymus5rOFkMzPd/09bxYw1OeBHiY6Gp1mkGmGp+Y3Z1mPS14/a1Trs6EH1Yvefo0UG+BFQN6h2Puwk8/gwcNeTUoN3voeaeUSXVuW/r3xlGFJhszBx/LM9CCkDFq2sV0xUBAtrwAIbAlPnFKSVKXy7OmN6mdcvMuSSrYU2mXPvCUWHX+HcoYif/eHJYdlcGgJ8Fm6voFya7BBjYeZbO74TANVXPjGOdKfmYHdrb9QXmrUn7HGeaIORtvk42edlT+ZIHQT90bcOX8NMCCLYJEfFF9sug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRNJTmGYsq7eL2bpYrks/9ontnitlft9Po0iMKXqm3E=;
 b=OsUrss3C/cTVZhUx6yyNc2p3rIMyZDXj5ITObKBbE4gfE4gSbn3lj8DPvGpGQKSadNnFsF79JYq93vVbJwJblQAK064ZiJhT7dsZslBX135S8Ouf9ro94ehFh1PIXATlF7QzxdelT6TNgmk2MNuyJvfxSejp2Tmr/QQRWVuOUEEuJd3a9HOUc3CVOcj+6K/BOy+alPYv7X1JDg2X2xdCgmPxObXsewTQ41IlsL6I4gauskiEPZStuiWUusYy0aWwNTL3xItaWsquAnS/IXyOupmxlc0KV9504Zn/Bji/galK/uTmLAIq4L4Dp0w0fntwfwErDWmW9Dgw/Dr4JgLWFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRNJTmGYsq7eL2bpYrks/9ontnitlft9Po0iMKXqm3E=;
 b=uzoDrQIDwLnqrPRe0KjpvZS11TSr5ylhFoaepJmbaZ4gqm7qZieW+DqCtpu6oeJz/uA4No4kWEjGXW44EFEzo4FoZwLdEngHbuzZ6TXS6SynipYnw7v9k4bBsl0dHs5ivn9GYPM3OTfVOyQdQlx9I8kTMrB1Sdx/rkdE1TfK4YY=
Received: from IA1PR11MB6395.namprd11.prod.outlook.com (2603:10b6:208:3ac::14)
 by MW4PR11MB7077.namprd11.prod.outlook.com (2603:10b6:303:223::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Thu, 14 Sep
 2023 13:19:33 +0000
Received: from IA1PR11MB6395.namprd11.prod.outlook.com
 ([fe80::28aa:8cd3:b9e1:948a]) by IA1PR11MB6395.namprd11.prod.outlook.com
 ([fe80::28aa:8cd3:b9e1:948a%4]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 13:19:33 +0000
From:   <Marius.Cristea@microchip.com>
To:     <dan.carpenter@linaro.org>
CC:     <linux-iio@vger.kernel.org>
Subject: Re: [bug report] iio: adc: adding support for MCP3564 ADC
Thread-Topic: [bug report] iio: adc: adding support for MCP3564 ADC
Thread-Index: AQHZ5vJqtx7E4a0SvUid7365x7M5Q7AaL3GAgAAe24A=
Date:   Thu, 14 Sep 2023 13:19:33 +0000
Message-ID: <2d35a8d374dfd68c9c85fab2ec552555b1343a09.camel@microchip.com>
References: <5ba16a5c-71aa-4dc1-8be6-320750d10b73@moroto.mountain>
         <b936e5cf-fcd3-421b-917a-5673df02f631@kadam.mountain>
In-Reply-To: <b936e5cf-fcd3-421b-917a-5673df02f631@kadam.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6395:EE_|MW4PR11MB7077:EE_
x-ms-office365-filtering-correlation-id: cf65ff21-1da5-4f80-356c-08dbb5253c2c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rpO8Kn/PTzdaPKBJGbG0PWBh5erZgzUXaeL31jveFCTc5xS3z4Iczw6feLCQ2CITh6Mbs71h4uyIFO18sOj3aU+kAT3MR4jKk0XpjQbIBhZnr8M//6nsyCRBwQnuVLADamvlGHTuBitO0tzYdjV9CborV6HKSQ+lwij+fDNkJXnJQq70qcaOdOANdcjWDRGbZ8hokYsoiMRzLkHOkMY5+j2Fmew6GEbue34TeAY0r2v2dcrzOzBX+9DZLYRp/5B5A3JBBI2lLaEh7zFZTx8SCDu3kk6c2S8lHWW+d0LLL2oHd7nhH9u+rKPCaljRWx1vnXiQxK2JG2evnAvNUNsr4mk9zxWlH2qCrs4wJX3vMYt7WyqvU7PizVHkehthxS+5seyKGB+TaDSQsqNIs85J8tb3p52ML6weqPZGVV+Gbg2V3q6dLpcEn59R1v3Cqt5viwt9QVKpZrXKCESofuzu31PPCdb86JBF0mExm/PyouBEA5QPW4YzDu62vhQYzwNjVsJaxSl/A0/jZW4fzGwBQt74K1pl6BEDSu6Q7u+bZxXuLq+/V75iL1XcA8ZozeDEgTfXA4wrI52v2Lw25KEOU0Xxz2ubG/XS4ywngne082RKBsJMBV+T6O0OLEBw7NE8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6395.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(136003)(346002)(376002)(186009)(451199024)(1800799009)(8936002)(76116006)(6506007)(66899024)(71200400001)(83380400001)(66556008)(66946007)(64756008)(316002)(6916009)(66476007)(2616005)(26005)(4326008)(5660300002)(41300700001)(6512007)(8676002)(2906002)(478600001)(91956017)(6486002)(38070700005)(122000001)(36756003)(38100700002)(86362001)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dnJheDJrRHJ3ZDZCdG5aa2k2WWl6MTFVYUxmV0NsV3JMcnNyeHFoQXhqZUlQ?=
 =?utf-8?B?MEVJN1dLUVRvdkdpUk00MEkrS2xIclVvZ3diekc4OGV4ckdCYndOeEhsd0NF?=
 =?utf-8?B?azJhRURVaEhMblFIS1pwMVoxVzU1ajV0RHNoWmdRbVc1N2JsTEdpb05pS2d4?=
 =?utf-8?B?Y3dUL1BSNEYzbmpydGZ3K3FVWUsxazhFMHI5YmEza2R1OHNhQVVzTmVnVE52?=
 =?utf-8?B?djdDNVMxaWpqeUZFWHBCMmNtMjErTEsvTUNZVm50NUdUYmYwSVVpWmpoME5v?=
 =?utf-8?B?b21TVnhuNkUvVUMvSkpadjZmZUN3a0haZ21qUDc3TkRTUUJrbkpaN0ZwT3Fu?=
 =?utf-8?B?aDlmRXFKMUNRK09sY3FOTTUyNytteXJhK0MybG1sbVl2VGpOMlkzbGZsMXlN?=
 =?utf-8?B?S293TmpVK3hwbDdLclREa1BUQ2J0Z0ljaFcxd0QvRmZyZG5PQnhzSVl6T2lI?=
 =?utf-8?B?d0VySWFxMncxQ2xUeWFQNDdZbkZmUXQwaGVwaWF0MmJTQ05FQ1NjbVRGUldE?=
 =?utf-8?B?K2huVEt0WDU4MThYaVVXRGRtY2FzWnNXM2ljZXpBWWN1M0x0bFhDcE1IYXFx?=
 =?utf-8?B?Z1YwWm1OVWwwN1ZHS2F1c2czSnhYZmpDODRwT1ZuMkgwblZlZGo4dytib3Mw?=
 =?utf-8?B?ZUcxeG4vd29wZVpPcTBxQk9COGgxamVSL2JvSVlBdFo3NGxYSlA3UTEvbURy?=
 =?utf-8?B?YVg4ejFWYkZseUNhdUlnRUtjUVRLcGZIc0Q1MnlhYWtCajQ4NGJZbmRpY2t3?=
 =?utf-8?B?UDljcFh1WW54ci9nRmhjUjRCYWZkVEphUURNdXAxS2E3bEkybU85SWY0aS9v?=
 =?utf-8?B?SkZqQThxM2hwd1g0ZzJEUldyckZUQ3FFS3F1bENBR3UvWHBENFIrNUtFa2Rn?=
 =?utf-8?B?N3lUNnBnUmkzdFhkZkpnU1ZrWlRPaW83OU1aM3VDT3JZL2NndVZZbDJVYStX?=
 =?utf-8?B?VWdkN0pKZ3ZEVmh5WkwrU3piSHpWZTRpdmNPekhqcUNSakV4dzBYQy90WExw?=
 =?utf-8?B?SGRFNnNDRzNmWXFUV3RrcGlTUTlQTUNhMFJaOEQ2MVBjZTRCWlhaOHVPLzZ6?=
 =?utf-8?B?NXliOFplaFU5NHdnTGsvaGU1VmpNQTFXMHd5TW82Zkp6aFA4TTNuT25pSFNP?=
 =?utf-8?B?MUx4T3IyRmZQRVMzbGVFL3Z5cHBDUzZtVjU0YU9qOFJRcUJ2YzJyNzZJTFNu?=
 =?utf-8?B?bFFtWGhZd3lHSFlQbjB5OEJlbXNmYTZ3c2M3a05Qamp2TktpMytncU05b3FR?=
 =?utf-8?B?aU0yazhmcVk5UFVRVVkzMEU1OWJsekgwVWFKT0hUczlMc3k1WmRwZFQ3T2I0?=
 =?utf-8?B?Q3NlZzJXdWpoRXdFcGFCYjdrRFc0bldSZlhDcHZ6N2N0MDNZZG12N3kyVmRj?=
 =?utf-8?B?Qk1iNXlJRWxHdjlGUVBUVlJjOEpKa0Y3d3hadXRCUHUzazBST2YxejB5YjRF?=
 =?utf-8?B?NEUvNzlJMjRUT0VTY2VqRGhneHFxRndzaFJLSmJnY1NGMEpXV1owOGc3Vkti?=
 =?utf-8?B?ekF0cU1HSXJCNU8xQVlGR1JkbVFpbnd4MXBaVmNVZk1aaXY1aUtzZVIwYmxF?=
 =?utf-8?B?TmMvWCtYRkQvMXRCOW11V1lseUNNOHNJVDhKekUrQ05malZTTmRvUnhLV1hW?=
 =?utf-8?B?eDNuc05mL0NLN0xKU083RDZ2SDBEZVQyRHZyYkdScS9WWXRYTGZJSE5PaWJB?=
 =?utf-8?B?TzJ2aUQ4cVdUWFF2U3g0dVlPSjI5Z0xmd0dzd1o1Q2orbjU3Q0tXbWo3WTEy?=
 =?utf-8?B?NGM1RExOYm1KcU9vaGNVYlVTVmJsTTladmJ5UzhIei9USHB4YTFUZS9zYkpo?=
 =?utf-8?B?dml6YytYbm1XSFZJWGw5N2twM1VSK0F1S2I4dy9KV3Q4VHduNjc2bldpaGxF?=
 =?utf-8?B?RGF3WVVQWitsWEJWck1Rby91RlFXWTVjd3FFT2FCNCs0WENiVEJzL0pnSWVm?=
 =?utf-8?B?L3NIZE4vMks4bXJUU1J4ZThQVUlxNklLL3VhSHl2SmIvcDg4SnlqTGV0Tnp2?=
 =?utf-8?B?NVZLY1hCNUY5YkdQQUR5dFpCTzFVb0ROSzVGeVAvUmpRRDNOQnJnTjNOdmZ3?=
 =?utf-8?B?R3prWVc1cXR4T1ExMVRwMmlmZVM1TFBYN2JDdGxGRytCY2JpQ0hqclBpejZF?=
 =?utf-8?B?a3g3T0Vra0RMRExmNy9kK081aGZXdzhRYjhHWVZ5MkF0emwyQ2krMDVnemhG?=
 =?utf-8?B?MUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <45BFE135AD538F4CBFD303D17A95C8F1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6395.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf65ff21-1da5-4f80-356c-08dbb5253c2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2023 13:19:33.0968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xmnTDQ9/hrItmfmQovCsg2u1elxVcl7MZoNIokO0yLDscmflaqLK5xpe5Wo5oLSddCJlysnmFWyyYqtXxbxKYl9bMY3PATt7zL+I3ZyMuoQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7077
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGVsbG8gRGFuIENhcnBlbnRlciwNCg0KDQogIFRoYW5rIHlvdSBmb3IgeW91ciBmZWVkYmFjay4N
CkluZGVlZCwgaXQgd2lsbCBub3QgYWRkIG1vcmUgaW5mb3JtYXRpb24gaW4gdGhpcyBjYXNlIHNv
IHN1cmUgSSBjYW4NCnJlbW92ZSB0aGF0IGxpbmUuDQoNClBsZWFzZSwgdGVsbCBtZSBob3cgaXQg
aXMgYmVzdCB0byBwcm9jY2VkIG5leHQ6IHN1Ym1pdHRpbmcgYW5vdGhlcg0KUEFUQ0ggKFY2KSBp
biB0aGlzIGNhc2UsIG9yIHRvIGNyZWF0ZSBhIEZpeGVzIHRvIHRoZSBQQVRDSF9WNT8NCg0KQmVz
dCBSZWdhcmRzLA0KTWFyaXVzDQoNCg0KT24gVGh1LCAyMDIzLTA5LTE0IGF0IDE0OjI5ICswMzAw
LCBEYW4gQ2FycGVudGVyIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxp
bmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdQ0KPiBrbm93IHRoZSBjb250ZW50IGlz
IHNhZmUNCj4gDQo+IE9uIFRodSwgU2VwIDE0LCAyMDIzIGF0IDAxOjAxOjAyUE0gKzAzMDAsIERh
biBDYXJwZW50ZXIgd3JvdGU6DQo+ID4gSGVsbG8gTWFyaXVzIENyaXN0ZWEsDQo+ID4gDQo+ID4g
VGhlIHBhdGNoIDMzZWMzZTVmYzFlYTogImlpbzogYWRjOiBhZGRpbmcgc3VwcG9ydCBmb3IgTUNQ
MzU2NCBBREMiDQo+ID4gZnJvbSBBdWcgMjksIDIwMjMgKGxpbnV4LW5leHQpLCBsZWFkcyB0byB0
aGUgZm9sbG93aW5nIFNtYXRjaA0KPiA+IHN0YXRpYw0KPiA+IGNoZWNrZXIgd2FybmluZzoNCj4g
PiANCj4gPiDCoMKgwqDCoMKgIGRyaXZlcnMvaWlvL2FkYy9tY3AzNTY0LmM6MTQyNiBtY3AzNTY0
X3Byb2JlKCkNCj4gPiDCoMKgwqDCoMKgIHdhcm46IGFkZHJlc3Mgb2YgTlVMTCBwb2ludGVyICdp
bmRpb19kZXYnDQo+ID4gDQo+ID4gZHJpdmVycy9paW8vYWRjL21jcDM1NjQuYw0KPiA+IMKgwqDC
oCAxNDE4IHN0YXRpYyBpbnQgbWNwMzU2NF9wcm9iZShzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpKQ0K
PiA+IMKgwqDCoCAxNDE5IHsNCj4gPiDCoMKgwqAgMTQyMMKgwqDCoMKgwqDCoMKgwqAgaW50IHJl
dDsNCj4gPiDCoMKgwqAgMTQyMcKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGlpb19kZXYgKmluZGlv
X2RldjsNCj4gPiDCoMKgwqAgMTQyMsKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IG1jcDM1NjRfc3Rh
dGUgKmFkYzsNCj4gPiDCoMKgwqAgMTQyMw0KPiA+IMKgwqDCoCAxNDI0wqDCoMKgwqDCoMKgwqDC
oCBpbmRpb19kZXYgPSBkZXZtX2lpb19kZXZpY2VfYWxsb2MoJnNwaS0+ZGV2LA0KPiA+IHNpemVv
ZigqYWRjKSk7DQo+ID4gwqDCoMKgIDE0MjXCoMKgwqDCoMKgwqDCoMKgIGlmICghaW5kaW9fZGV2
KSB7DQo+ID4gLS0+IDE0MjbCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZXZfZXJy
X3Byb2JlKCZpbmRpb19kZXYtPmRldiwNCj4gPiBQVFJfRVJSKGluZGlvX2RldiksDQo+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBeXl5eXl5eXl5eXl5eXl4NCj4gPiBUaGlzIHdpbGwgY3Jhc2gNCj4g
DQo+IEFjdHVhbGx5IEkgdGhpbmsgdGhhdCBkZXZfZXJyX3Byb2JlKCkgaGFzIGEgY2hlY2sgZm9y
IHRoaXMga2luZCBvZg0KPiBidWcNCj4gc28gaXQgZG9lc24ndCBhY3R1YWxseSBjcmFzaC7CoCBU
aGUgY2hlY2sgaXMgYnVycmllZCBkZWVwIGludG8gdGhlDQo+IGNhbGwNCj4gdHJlZSB3aGVyZSBp
dCBwcmludHMgdGhlIG5hbWUgYW5kIGlmIHRoZSBhZGRyZXNzIGlzIDwgUEFHRV9TSVpFIGl0DQo+
IGp1c3QNCj4gcHJpbnRzIHRoZSBkZXZpY2UgbmFtZSBhcyAiKGVmYXVsdCkiLsKgIEJ1dCBpdCdz
IHN0aWxsIG5vdCBpZGVhbC4NCj4gDQo+IHJlZ2FkcywNCj4gZGFuIGNhcnBlbnRlcg0KPiANCg0K
