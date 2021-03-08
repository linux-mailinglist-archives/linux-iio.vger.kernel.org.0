Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F784330F51
	for <lists+linux-iio@lfdr.de>; Mon,  8 Mar 2021 14:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhCHNeD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Mar 2021 08:34:03 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:42834 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhCHNdn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Mar 2021 08:33:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1615210423; x=1646746423;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SQWcGNPX3wlOfCeV2S+BmbjI1XOhf1paeAviRjeB5P8=;
  b=dgj4ypw9EHLxd9olvM9QuPaj/927PN78oz5U3EJl1KzRJTCm8qg0ma4C
   AhRiV2vaqSVSrPDP4RsYEFABuRqUMj70WHwauT+y0b2A/rMJ3XWbjtyXm
   tXzc8seWIu4hxLcvgcqZBEE4HI/wBQ9+LXHiq79UOuK5yERMppR9nbyC8
   vNcq0raZkV2+FOaCfY2Fy66dUD47jCnHY4xHzf4+j/X3VWsG8QPpXUp8a
   RhcBxfPX8g5H4Q1lpsa9ndyKwS1vCvUDqhe3BXaBlUWttIo8xKGXOGpMe
   nYl9U6LpnvcwEArRCXACLaEKnC5IAUYnP0f5rOm66yYyjnFSPW8USj5yd
   g==;
IronPort-SDR: wRkgpbzzH14FFRwCI1fvA5rs+owZXgeB+h6ZBF6k+aTwDmo5M/8kEutKY2f7IEYAjoGZn+bEdl
 KemvBk3OoLbVdWtpif16MWFbsOCB8yKiJB6lzkAKmAB2A/dX5DIt0Flt8dHKg9QA07JA5yCcl6
 AmuaVxcxGcEOVYmqaoH47I/PPZveKS38TKnX4wLD8LjZiypl+K4IzwO9O034/i0DZjfsAo+1Co
 tEcXxIXq/mmk3XKlkSHlKyhQuzBSFXbmBAJvEs18g/pgxqIRK7BdJtxjkPE1DgfdG8BE5LLSQB
 6Dk=
X-IronPort-AV: E=Sophos;i="5.81,232,1610434800"; 
   d="scan'208";a="46662985"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Mar 2021 06:33:42 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 8 Mar 2021 06:33:40 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Mon, 8 Mar 2021 06:33:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=brcO7sHfFpn4CqU9khNIEtxkc/rloD4eqW05z7azskhxQ4M6wRsqzGAjWU7H8D5upNom1O5CO5AuGBk1DzLkby8WEu9RcQAwClWm0UJQNTGx8bF1Gpw2TauTd7gTSJsVq1RPjc8KCwsQkrFp5jGrkyDeiy9UnHZrKPAB6l3X6bLjgSCIxrZjdIcDNiDNd6TvYMnWlsZLnh1Q5q0LSvFUZushsmhgcJogg2nJBeSL2EEAEOe8iBhcDvy09DhqLutbV+Ssogt8YdA3mIRWwIdZq6ui2pdK8PWq7BFGv3/DnzgoH3ozS2XBlbMLvkF/cepi/deh0lkKk1zhlhc+jX1LHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQWcGNPX3wlOfCeV2S+BmbjI1XOhf1paeAviRjeB5P8=;
 b=COZdHoMNc03rjGGATLQV1x9//OWM2vQuFHE+jNBPKBFDMGgTy7efLPusQOuHUQUzs1rOqoSNLf87CgdhxbjZ72i8VB/M0h6Xdn2se0PWMtNwU2ZbtZuHm9PLMqCE8KzXFbmCeV89cnSR3/5Zg02P8HJxB22EVcu8VfRvzqbZKsoh2wAE/Cmvis1+97h4HOJ6p1oYB/1RIlNUsnMyCPW++h1519IrEC/8L9GZ07VI8WtWA5ywZEEF2LIXNJHpGSl6qctLLmJTg3o2wWaoX+4zq/jlgrPnREzkavYNMOAhnVi8hJ6TEZG77C7UjMiKH90Lcv2DsN6VELej2tQ40LrVYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQWcGNPX3wlOfCeV2S+BmbjI1XOhf1paeAviRjeB5P8=;
 b=SKbao+2TfgXf6SleThjkgBGZSb7AomJBSEZ3BDX3LpzKTs+ZqTgqijTr8nkKVX1F3KLYoH0Zv9DCL0wXJ62Jstby/xEuu2kuNJKAHdORK2BQFGfJPrNGuNK6QwH+gW1ifmPe3fS71p4g3WUTZfEbJAt+u0lBA0WwSx5a7lHR3Ic=
Received: from SJ0PR11MB4896.namprd11.prod.outlook.com (2603:10b6:a03:2dd::20)
 by BYAPR11MB3608.namprd11.prod.outlook.com (2603:10b6:a03:b1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.21; Mon, 8 Mar
 2021 13:33:39 +0000
Received: from SJ0PR11MB4896.namprd11.prod.outlook.com
 ([fe80::743e:9115:21df:d5a]) by SJ0PR11MB4896.namprd11.prod.outlook.com
 ([fe80::743e:9115:21df:d5a%5]) with mapi id 15.20.3890.038; Mon, 8 Mar 2021
 13:33:39 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <jic23@kernel.org>
CC:     <robh+dt@kernel.org>, <Ludovic.Desroches@microchip.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] iio: adc: at91-sama5d2: initialize hardware after
 clock is started
Thread-Topic: [PATCH 2/4] iio: adc: at91-sama5d2: initialize hardware after
 clock is started
Thread-Index: AQHXDqfZf3TGqQhBYkKVzKrEA1mzHap3PL0AgALlPIA=
Date:   Mon, 8 Mar 2021 13:33:38 +0000
Message-ID: <1e04b673-5d61-f4f1-34d1-4cb84a821796@microchip.com>
References: <20210301143256.16502-1-eugen.hristev@microchip.com>
 <20210301143256.16502-3-eugen.hristev@microchip.com>
 <20210306172038.482b2b9a@archlinux>
In-Reply-To: <20210306172038.482b2b9a@archlinux>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [86.121.125.229]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59eb7d94-8a6d-429f-e61b-08d8e236c85b
x-ms-traffictypediagnostic: BYAPR11MB3608:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB36084CF8DCA2777412F3F6D3E8939@BYAPR11MB3608.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7EMlSz7cQtQ4Y+5EqjwC+4JdoE7m+soVBte7gERObgVQiyp0UUV6FiUS5GGdnShP6s3NUZRePMz6+FXOppL61eXn3B9rDKiJ75/GFtOVMV7dUKk2OAvhNHZtmC4AEcc3I2AT/pXNHd/7dotj16tK6tOtp7SU7aJhx5Pl86KgDSf897IYxCXHsqu6X7H+gt43RgbhVTBQYyVei424wmBMQvO2Dk48bzj+qBI21vRR6AdzujxzXI8sCMCatxGYA5jUVfeJuOfubBJWVC06Aa4K43p2HjrxsVPi63uI0npUoHS3Hy1o7h2k0gRVdT3/tpd3Eu9SzlmxiVTvJqONudVPgVBlCfcVjjJzlrb1t1cgvXAYZrMUwlEaTIs91y3Ogw5eR2gedo5M4ZtrRgDNaryEDdW3LVDOf9+jIcBE8uSMxxxVO+WyjJ0YBHJ4l7aiQmF+TUKI1OI4jo024dUA1hEgfhTgy5O7StvAnWLJ2MORyXVIfS9pU/IlTix59uuPyZ2HCego3k2W7qIe3m6VroswAHzjc+RdF17WT3alSsfbQjKjR7XgKHGcMmVufUy5RNmxgs5riRP5djOpKJ8TnO/Tw7532Hotaot3pmQSoiHh+i4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4896.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(376002)(39860400002)(346002)(31696002)(86362001)(66446008)(66946007)(66476007)(64756008)(71200400001)(66556008)(8936002)(2906002)(53546011)(36756003)(6512007)(6486002)(91956017)(76116006)(316002)(54906003)(6506007)(478600001)(2616005)(5660300002)(6916009)(31686004)(26005)(186003)(8676002)(4326008)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?czE3TlRKSklKV3RNcGN5NmNrWkdLTlFibTgxM1o4QjlabG1USnYySFI1bXpp?=
 =?utf-8?B?WC9waXdaaTRVSndhdkNCTWFNeFRDOWlsVnhkcFJCNDNrWkE5a3pYSVJ6dGxi?=
 =?utf-8?B?Ri9kaksybm03TDZEWlppdkE0SDYvcUlNSkRoMmpaZnF5d1JDRE0zbDU3NE5h?=
 =?utf-8?B?YkhFdUtJMEVzSTBCTDRMcWNaSjF1SFYySVh4OU9zaURmSVdIN1BIM3FMUG9o?=
 =?utf-8?B?NkRHWkY0MjIyc2ZYL3kwdkNoSTk2ME1VbDhGby95RVpiUXFkeUVodmtVelhx?=
 =?utf-8?B?RFpaNFc5TVVpc21hUGZzL2pxNEM1aEgva1lPN3JGanJkdjhtUGZ1ZkgrY2ZG?=
 =?utf-8?B?R05YRmdQSnd5OUFRSE1mTy9OVUV3a3FZd2dXYnJiNGxXV3I3MURlUWRxNWJT?=
 =?utf-8?B?R25DVEs3WEN5ZmRIK1RLeFEvV1dnRjl6VDlINEVnUEsxU2dXR2t6Ujl3T0Fl?=
 =?utf-8?B?VzJ1N0tUNE05bDM2NGEzbzl1M2NtV3NEdElVQjlqVWs1cnNkRXcrbnU3Q1Jx?=
 =?utf-8?B?Q2lhU0hDZXdMcW1VUzdNaDY3VnR2Q0EzRUUxRVo1MkZDeDNPL0s3b0RnM3BN?=
 =?utf-8?B?UzRFMVkxV09iT2dTWk9vV21idmdFN1p6Y05zOE5NaXY3c2hDN3c1M01lMGhP?=
 =?utf-8?B?T3F0RTh1OTdrY05DRmtUNGo4Um9ROGxFQ2R2NTBCL09jWDF2d3dHV00vS3Zu?=
 =?utf-8?B?MSsxRE11SzlHNUhoblBQeC9NbTU1L0FETWF2SmN0NTVGZk5LaDVCMmc2bGU1?=
 =?utf-8?B?SUxrOHY4LzZRM0MwSVBXcUZNNXc2M2xVeFAzdjRZUEM1VTBvdGZxTHAvTnR1?=
 =?utf-8?B?S2kxR1dzUXdNeWpFZFcwZU9LcnhzY3dMcFEzRHl2bHlkWUFGUE5kOW1udHd4?=
 =?utf-8?B?N3VWSjB6MU1YUFR0QVBESkFFQnNXTU81T3Ryb25SYUpjTUtpdW01VlJ0cWpL?=
 =?utf-8?B?WUdMaXZLMDZvRUxxWmNWeklrZDZqMjdWeDlDZzJpL1FzY1pyc3pTVG1TTmF0?=
 =?utf-8?B?d0h1bnVoUENpRFZFa01FS1JLeTN2Rlcva1RvdW1MbGFzUGxzOHhNK3ZRZ3dl?=
 =?utf-8?B?cHJNYXBTVzFpbXU0NDRRcG8zejBhcHkwSjhvOG9aampWemY5M2l1WTRJcFRC?=
 =?utf-8?B?T1FhaDlHMndwNW9ScjJqUlhXaVRvZUxuYURKMHM4VmNzNGJ2ZDB4MUk5Nmor?=
 =?utf-8?B?T3NJWFdaTjJxZzcvVnB0bHU2SklHdlVoRlYvR2laaXFNTlFWRVpRQjlCNzR2?=
 =?utf-8?B?bzV1MFRPd1hCYUx2Qi9hSkcvNkJIREoyYjAyVHRiaVVuVWpuY05sQXJBM2pv?=
 =?utf-8?B?UWFRbEcwSEw5K1lHbmpwTHJiUkYvNEsxcEdoNkhTb3NlWFI2bzRLNlIzdk51?=
 =?utf-8?B?cUhJZDRrME9PUENsVmZBWmM1SksxRG5qaUxMM3hwK3ppZHFWOFl4N2ZhNVhH?=
 =?utf-8?B?OEJFRzRHZVdRT0xqVUYyUlFxa2FxVlVRVGZCK1RJSVdzaVlmRUJqNGx1RFhm?=
 =?utf-8?B?cWNwM1VNTGxlZWVJYkZoTzdUTkRhS3k2Ky9FazdJL1loMXFRUkdEWndsVEk0?=
 =?utf-8?B?OFhUSnlQSThzRTJtZEYrNWlCcXlCTE8rcTNwUkhiSGRwN2RHcmdJR3o0ZElk?=
 =?utf-8?B?aUYrT1BDaTMwSkdFV2owVHpRckxMaGF2MjcxVkJXYm0rSGp5RG9yY2VsV2NI?=
 =?utf-8?B?QmtwYm8rL3FLd2dkcU15RVZnTzZYS2dmdjhkeFVDcVI4ZU9WUFdYWTBWZENn?=
 =?utf-8?Q?9FkFRRe5GiGhAVB+5Uei2T1Vazy5tSzHtm6iFHG?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <241848D67023014CAC1B4CCB38A2942A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4896.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59eb7d94-8a6d-429f-e61b-08d8e236c85b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2021 13:33:38.9825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X21RdN1s1bORgqz0nnsEm99BTjZ5YyNYTlAZUVv/W1EYn0X170lRQOhpVrfbf0WjDd473yFY0TEDFZLi3tfk5OLPPHZ5Xg/4uyUV5w0d3bo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3608
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gMDYuMDMuMjAyMSAxOToyMCwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToNCj4gT24gTW9uLCAx
IE1hciAyMDIxIDE2OjMyOjU0ICswMjAwDQo+IEV1Z2VuIEhyaXN0ZXYgPGV1Z2VuLmhyaXN0ZXZA
bWljcm9jaGlwLmNvbT4gd3JvdGU6DQo+IA0KPj4gVGhlIGh3X2luaXQgaGFyZHdhcmUgaW5pdCBj
YWxsIG11c3QgaGFwcGVuIGFmdGVyIHRoZSBjbG9jayBpcyBwcmVwYXJlZCBhbmQNCj4+IGVuYWJs
ZWQuIE90aGVyd2lzZSwgd3JpdGluZyB0byB0aGUgcmVnaXN0ZXJzIG1pZ2h0IGxlYWQgdG8gYSBi
bG9jayBvcg0KPj4gZXh0ZXJuYWwgYWJvcnQuDQo+IA0KPiBGaXggZm9yIGV4aXN0aW5nIHBhcnRz
IG9yIHNvbWV0aGluZyBvbmx5IG5lZWRlZCBmb3IgdGhlIG5ldyBkZXZpY2VzPw0KPiBJZiBpdCdz
IGEgZml4IHdlIHNob3VsZCBiZSBsb29raW5nIHRvIGJhY2sgcG9ydCBpdCBzbyBwbGVhc2UNCj4g
cHJvdmlkZSBtZSB3aXRoIGEgZml4ZXMgdGFnLg0KPiANCj4gSWYgaXQncyBhIGZpeCBidXQgbm90
IHN1cGVyIHVyZ2VudCB0aGVuIGxldCBtZSBrbm93IGFuZCB3ZSBjYW4NCj4gdGFrZSBpdCB3aXRo
IHRoZSByZXN0IG9mIHRoaXMgc2VyaWVzIChhbmQgaGVuY2Uga2VlcCB0aGluZ3Mgc2ltcGxlKQ0K
DQpIaSBKb25hdGhhbiwNCg0KSXQncyBub3Qgc3VwZXIgdXJnZW50Lg0KQWN0dWFsbHkgdGhpcyBp
c3N1ZSBjb3VsZCBwb3RlbnRpYWxseSBpbXBhY3Qgb3RoZXIgcGFydHMsIGJ1dCBpdCB3YXMgDQpu
ZXZlciBoaXQsIGFzIHRoZSBjbG9ja2luZyBvZiB0aGUgQURDIGJsb2NrIGluIG9sZGVyIHByb2R1
Y3RzIGlzIGRvbmUgDQpkaWZmZXJlbnRseSBhbmQgdGhlIGJyaWRnZSBjb25uZWN0ZWQgdG8gdGhl
IGJsb2NrIGRvZXMgbm90IGhhbHQgaWYgDQpyZXF1ZXN0cyBhcmUgc2VudCB0byBhbiB1bmNsb2Nr
ZWQgQURDLiBNb3N0IGxpa2VseSB0aGV5IGFyZSBidWZmZXJlZCBhbmQgDQpzZXJ2ZWQgb25jZSBj
bG9jayB0aWNrcy4NCg0KRm9yIHRoZSBzYW1hN2c1LCB0aGUgQURDIGlzIGluIGFuIGFzeW5jaHJv
bm91cyBwYXJ0IG9mIHRoZSBhcmNoaXRlY3R1cmUgDQp0aGF0IGlzIGNsb2NrZWQgYnkgYSBnZW5l
cmljIGNsb2NrIHRoYXQgbXVzdCBiZSBvbiwgb3RoZXJ3aXNlIHRoZSBmdWxsIA0KQVhJNCB3aWxs
IHN0YWxsIGJlY2F1c2Ugbm8gcmVwbHkgaXMgY29taW5nIGFzIHRoZSBBREMgaXMgbm90IGNsb2Nr
ZWQuDQpJIGRvIG5vdCBmdWxseSBncmFzcCBpdCwgYnV0IHRoaXMgaXMgbXkgdW5kZXJzdGFuZGlu
Zy4NCg0KQW55d2F5IGl0IG1ha2VzIHNlbnNlIGZvciBhbGwgcHJvZHVjdHMgdG8gbm90IHJlYWQv
d3JpdGUgcmVnaXN0ZXJzIGluIA0KdGhlIGJsb2NrIGlmIHRoZSBjbG9jayBpcyBub3Qgc3RhcnRl
ZCB5ZXQuDQoNCkV1Z2VuDQoNCj4gDQo+IFRoYW5rcywNCj4gDQo+IEpvbmF0aGFuDQo+IA0KPj4N
Cj4+IFNpZ25lZC1vZmYtYnk6IEV1Z2VuIEhyaXN0ZXYgPGV1Z2VuLmhyaXN0ZXZAbWljcm9jaGlw
LmNvbT4NCj4+IC0tLQ0KPj4gICBkcml2ZXJzL2lpby9hZGMvYXQ5MS1zYW1hNWQyX2FkYy5jIHwg
NCArKy0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2FkYy9hdDkxLXNhbWE1ZDJfYWRj
LmMgYi9kcml2ZXJzL2lpby9hZGMvYXQ5MS1zYW1hNWQyX2FkYy5jDQo+PiBpbmRleCBhNzgyNmYw
OTdiOTUuLjYzMzI1ZjAzN2YwOSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvaWlvL2FkYy9hdDkx
LXNhbWE1ZDJfYWRjLmMNCj4+ICsrKyBiL2RyaXZlcnMvaWlvL2FkYy9hdDkxLXNhbWE1ZDJfYWRj
LmMNCj4+IEBAIC0xODMyLDEyICsxODMyLDEyIEBAIHN0YXRpYyBpbnQgYXQ5MV9hZGNfcHJvYmUo
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4+ICAgICAgICAgICAgICAgIGdvdG8gdnJl
Zl9kaXNhYmxlOw0KPj4gICAgICAgIH0NCj4+DQo+PiAtICAgICBhdDkxX2FkY19od19pbml0KGlu
ZGlvX2Rldik7DQo+PiAtDQo+PiAgICAgICAgcmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxlKHN0LT5w
ZXJfY2xrKTsNCj4+ICAgICAgICBpZiAocmV0KQ0KPj4gICAgICAgICAgICAgICAgZ290byB2cmVm
X2Rpc2FibGU7DQo+Pg0KPj4gKyAgICAgYXQ5MV9hZGNfaHdfaW5pdChpbmRpb19kZXYpOw0KPj4g
Kw0KPj4gICAgICAgIHBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYsIGluZGlvX2Rldik7DQo+Pg0K
Pj4gICAgICAgIHJldCA9IGF0OTFfYWRjX2J1ZmZlcl9hbmRfdHJpZ2dlcl9pbml0KCZwZGV2LT5k
ZXYsIGluZGlvX2Rldik7DQo+IA0KDQo=
