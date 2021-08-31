Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C79D13FC2F0
	for <lists+linux-iio@lfdr.de>; Tue, 31 Aug 2021 08:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236670AbhHaGqA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Aug 2021 02:46:00 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:1969 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235644AbhHaGqA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Aug 2021 02:46:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1630392305; x=1661928305;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=35Eq1eQNqE8YpYrbWIQV0yFe7XHSRKdUOhMoXgFeSXw=;
  b=WUV5b39+6S/u/ZgNR+KNzPfzOx+qwnAF/Sqy8jycVY50pgc+sHI2bXK0
   OgjRz3IEHoYtJdRJLa+xcc6HTQcVgNB0Wli9J+KR3VfZI3E1KI33ug4P/
   Voe6P303n/pP/im3iIvavo5mLxorZvWGRbiOzV13Zdb7poDQ1cdN9ayjb
   2Cob9HRUaEpgBRdmtn0PGaYZok0Abbkefag1Qw8cPC75GYWRAPeL3P944
   +ofYdFHDNrM4BvHaK87HoEfNefpz2sWI0kxVNzqvFW4ASmtTvyGUq2Mu6
   r0vhPSlosJ+u0iE4sBO6pCYr7BeR5iBO7NkHeTG1lsNJ7ugbFi1NCJvz+
   g==;
IronPort-SDR: SAwI7fr41rcFu6guQZyUoSlZCRQPlG9ucVsJ8K5w5WrGoyYq6F3cwvoMftxidr7yu6LDTXj637
 NCW3EjK/dS5V+Zk70H2u3UU4Ddt4wz662oOClMFSSUTEYB5uM19QD6K1cQmV+ZaK5kvnDfhjc3
 m3yOyUhuZucs60Id53+T/plEOFfkF5KSYqBQ7IdY0Lsknn1EUmN7YFZp32s1rBl/tbJUB2oOoB
 MefV4wtCXYOLI3cb4BBWY9PDq5Ke2/2x5aaRD9LCjW4+zKY0j82duTe9hmOQ3Ay050duNujysV
 kjbK/7t9BH50GzUMNKQdwYnt
X-IronPort-AV: E=Sophos;i="5.84,365,1620716400"; 
   d="scan'208";a="142205728"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Aug 2021 23:45:03 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 30 Aug 2021 23:45:03 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14 via Frontend Transport; Mon, 30 Aug 2021 23:45:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jsQHQV5UZTUPVTjQBjue6yKkiZc0Kip3/8Na1DwWW/bfuUGFceHAyNu4HAqDAhh26mC+N46N67H6bVH3IXnDrD6kqTSFvgOAbjbBZdwWynasZTA3iJHfPNKZDJqDtSQFlMdwi/FKe0R5Xh2TA2kXMbdN+XeCRNCTh95DEtyKs8R9S8u+ERNENe8ChW0YKlbBLZo0CzmK/z5jdfQf9rr9mR/WKIgV4lZZ6lti+gUM8ruVrBbEfix2PWDZCKg5iC6qU0Tent/lAQ2GIIkJt8Pv80ZLN62Yw4oSZ4Nm5M2MnJvXMSjmsVqorRqYc1BOci+3S8fO5VM3KS5AzyxTcnR57g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35Eq1eQNqE8YpYrbWIQV0yFe7XHSRKdUOhMoXgFeSXw=;
 b=YKkJjEu3c12Z3DvsXI/8ZHOQpwtoIXqPWSTY3t5ekVg8lCb1btrcn8Z2YEfwuGbFTyUSip+463JxQTDHeTtxs7YjNBKl1vV06jh5MaBiTxesfarFKIf+IVRpHgBkNcI5JEY3V3qflVNPMYoEox/c/ZFjvZCp8i0oN7qly/TsnX6/ijWGd9vSzsNLMPEXriihVC1ten+DHR9Oa7cTYUIX6nKSBIG4m4exSD61+Obhoh13QSgfnmvpZ5N4b8RPWw8JLcr9+xF2g0iAyovlZxV4YRZdnCBRnRyEl7E37lfwhyFFXRoiPSA0OmQ+TSEjaBTJ50tt77PocC1ZlnYgz9Wyaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35Eq1eQNqE8YpYrbWIQV0yFe7XHSRKdUOhMoXgFeSXw=;
 b=N7vthcksbw6E+kWKzPPaIwMOhwzq6a8gU5z52ZAPlBTLlCT5ViqzjME6jO9sC+aGIkhzgKqXCqBaSXSg3XLB/ySTtNH0+uK12Mu92qPl1iiZFEjoTagcFdYfifzRP1ZNcdJB/hpGchOH9wggcVsT8JJBeKFmiC3tVB8R5ns5MNI=
Received: from BN9PR11MB5514.namprd11.prod.outlook.com (2603:10b6:408:103::7)
 by BN7PR11MB2801.namprd11.prod.outlook.com (2603:10b6:406:b4::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Tue, 31 Aug
 2021 06:45:02 +0000
Received: from BN9PR11MB5514.namprd11.prod.outlook.com
 ([fe80::c5c0:630e:5d91:342b]) by BN9PR11MB5514.namprd11.prod.outlook.com
 ([fe80::c5c0:630e:5d91:342b%6]) with mapi id 15.20.4478.017; Tue, 31 Aug 2021
 06:45:01 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <Nicolas.Ferre@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <Ludovic.Desroches@microchip.com>
Subject: Re: [PATCH v2 05/10] iio: adc: at91-sama5d2-adc: add support for
 separate end of conversion registers
Thread-Topic: [PATCH v2 05/10] iio: adc: at91-sama5d2-adc: add support for
 separate end of conversion registers
Thread-Index: AQHXmN8TbDFbZIlyDUONQzBgCMchsKuNNbIA
Date:   Tue, 31 Aug 2021 06:45:01 +0000
Message-ID: <7d2607ce-4cfc-63f9-dad2-a5ef5c9538b5@microchip.com>
References: <20210824115441.681253-1-eugen.hristev@microchip.com>
 <20210824115441.681253-6-eugen.hristev@microchip.com>
In-Reply-To: <20210824115441.681253-6-eugen.hristev@microchip.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55c63347-eb87-4677-12d2-08d96c4adbbf
x-ms-traffictypediagnostic: BN7PR11MB2801:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR11MB2801078D12EB09B315DD1EB4E8CC9@BN7PR11MB2801.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iLUrAinPAt9leKougs/cVWZs22CCBOzTSuQDk8WVquuBIWvAr3yxmZBtX3RWkd1NChm3k/STzkEoR1o1HgDFsMXozHQTg9IcSt0nuo9B55SX1cyyp2S1KXb5crDfOCEIIxIr+AEHXwqiovPJ4NK5TxW/LxZ9J2k3aLnNZuBcF9R2zIgIlyDntO0i/vk1horl3yOoXjUN1v3Y5Sefa2rdY1d/mzoY+hnN79ng5Xj5p2eqQgGKF9afIHhnvDNs/NMNfGoQ36KY1JyGBeBvC/aqLqSoM1BDf/BB8wD/1P5mP7vOsx2v9G9q7eKJ/7vrklgTIL+s2UZodZ3xux1lAK8fmPE1YtF0YAKB+hHPC0EaCASMTvjbdE00LvS2fCS9+zlp/XX4Lg1GwdHF8uVoYHR7wwa2Opzm0Si/pRkQ9TnDooruagcdy6cNp2SZkl8tjrPr6/7DFwM0DDtG/CG0GD7aZ9ScfH7Lh/76i65AMszvlBh09Mkx27iCKbj7m0HTyoT5HuT2Z1cmlxfc693521vIQIUeHjTIo/koSjDxUZaZwBnrJ1cLGJdoA3xuDL50uLLK8Ymr194A8Ga/1U4+wNnfDzzuRNwYL1GnE66ecan/+psbx29uV2Au1d/ldty5Xw3vleBe/dDhX+Dqu2v3do4DA4oe8JUL0jGM3kSQLVCACGzAlAlQLNhGDYbEvlH8xqVma3/OEGjCmphlmwthk1ckE5Qb0EDYg7AbAfR0PcQQtmBdD7c0cmzEe8rTChcjjR7I9xoxiWpSfEibNOgiZSpf6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5514.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(39860400002)(346002)(376002)(136003)(110136005)(66446008)(31696002)(53546011)(2616005)(4744005)(38070700005)(83380400001)(8676002)(6506007)(86362001)(54906003)(4326008)(64756008)(478600001)(66476007)(66556008)(5660300002)(76116006)(31686004)(107886003)(186003)(36756003)(66946007)(316002)(6636002)(122000001)(2906002)(6486002)(71200400001)(8936002)(38100700002)(26005)(6512007)(91956017)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ukw1UTNaV1Arc2ZCQ3hpR0tFUk1FdkxVaEU5QUhZWkltS1h6d29MOWJoYndk?=
 =?utf-8?B?U242UWEwUEh2eFJINzA5dkd4dk85RUloK2dLMlMyaDZ0YXdjOXpRSloxNUVq?=
 =?utf-8?B?SVJ6RTJtOFpTNi9NY0hVcjZGWmxMbjhSOHR1TzFCRXJLZkZzdE9uWklyNVlU?=
 =?utf-8?B?SU5QQjVJUFM0TVV4ay9Kc3hzVGo1cHB0SjM5Qmk1MU8vcUdRVms0SElpclM4?=
 =?utf-8?B?cmVIZ1d0WTNEVXd0TlNTTmNZZ0d6SEY3V2JhZlZ4YjYxeU1EcXN1NjhiTTh6?=
 =?utf-8?B?L1J3QzlDUG5VOTB6d0NwU2dGR0M4K2Uyd2xhalo1dVdrQURNUjlnUGJUSWdI?=
 =?utf-8?B?WU5XZm5PL1RaQkhKRGoyU0JtVGdadVYyZzBJejhMdkUzVXFuVURoa2tpdUQx?=
 =?utf-8?B?S01OdGJuQmFvMWY5T3V2TncvQmhDS2g2VVdkSC8zWXBoTWJROGRkelVvREQw?=
 =?utf-8?B?bklRU0ZEWUpTRFhSTEhZK24rVHBkQUJUb0hIemYyK1lTeEozL0pyRGhDV005?=
 =?utf-8?B?OXJ4aWE1K1BxSVNRcmxUL0wxb3JjMEVxNVdYNGhzYmtiSVhaclVjdnNTY0w3?=
 =?utf-8?B?Q3RQYktFd1Qzb0VYSkZzcDJRdytNTmhaNlIwZ0l5aUFGWmRMVFpBem1USlFR?=
 =?utf-8?B?MStOYjJpdkhLK0ZNTXliNnhuOFlMb2xSQ3g3N3FKYmthRVczdmJxdzc2Yjd0?=
 =?utf-8?B?OCtFZFpVbnBTTDNsaHBRMnpmanFtaEFCREYyNUIvbzBoU0k5ZkFiRjZzYzZH?=
 =?utf-8?B?Mmg5ZnlxOElUUkRVeU5BSTJsTXdZWmFzM25kWTBhTm9oOGVabWtRMTJGWTlQ?=
 =?utf-8?B?RFZlSzMvTGlGV1FscmxLMWVFbnFralhrekpPYnVrS2F4NFpJZ2VVeTZCbjlD?=
 =?utf-8?B?WU5vSWNrQktVUC9PZyszYzNmUnV0SHYvNGZFaE9oaFFwWDBBQ1FPVW14dkk4?=
 =?utf-8?B?cmdDRG9IU0F3VnhBdzk2VTVKRDJUdkc3WVd5cDM5OVhjZ29IaXpsc2xaN3Ft?=
 =?utf-8?B?WHJ4RjRwQ1ZsMitiaWZQQjlvTGk3UFdyWnBSWm5FanF6N2hLSFhaeEMxWGdu?=
 =?utf-8?B?S2d5cVo3aldLengzSmhpOFo2aGlBeVJNb1FYSHJjMHpXbGxyU0ZMSmx1ZTc5?=
 =?utf-8?B?TUJ4NExwSVRWUVZlbkNJM1FVbUxMQlNQemc5dmlvaXRibHlJdytieDY5VC91?=
 =?utf-8?B?bWVkT1VFb2JOaDNIMys1eTZtb1czejg1QjB2Rk9DdTJjVUhwWnVIeVZyRG9X?=
 =?utf-8?B?bTJMbE1DL2JHT25XM1BxUGRmNitqNUxSU1Z2cEZmcnZxdmFaTDFaNUlLV2cw?=
 =?utf-8?B?MFVXeUIxMVg3YkZIRjFBNVhMTUVmTmhEc1dycVhRYXJvQWpFejdYdGpFUGg0?=
 =?utf-8?B?SEtDMVlZWFllUXZCcHFkeXdXdTdWVzVhSG0zcU55SWRqeUt6UU1HZVlnd2Ur?=
 =?utf-8?B?Vmp4azFUK1ZmdFNLSWNlejBlNjFDSVhJd3ZjeldFQmhiYWs1VS81NHpJeGg0?=
 =?utf-8?B?RjYrZk00U0lzbllCTUhMUFRCM1N0RnlDdEEzUkt4ZWptbFdJZUNOV0I3aEo0?=
 =?utf-8?B?dEF0STJFL1FvL0R2STdodmdRVmFMQ3JsMmtlVVhQY1pYMis2cThuYnROV3ls?=
 =?utf-8?B?SjhkSWNLL2Q0emplVnZTSG4zTURIUkkwK3JIcVYvTkVVL1YvV216ZElKV1h2?=
 =?utf-8?B?NGpjY1NSZ0NKUTdtSk0rSHRlNnQyV0lPVmgwcjY4ZFAvbHY5dlY3T05iN2lu?=
 =?utf-8?Q?NWryDF7UvIzhF2n6bI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B038FCEAF1D6FF49A874180029B4BC01@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5514.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c63347-eb87-4677-12d2-08d96c4adbbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2021 06:45:01.8802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qh0LePtEFJ0dTxCN1+7lMixufHmEhOuP4tWsXXUl7fikMG1+d5rKqYPFAWTMvkLd+UVuq1QwG/Wh11m4krEh8pjghzPU5iwErKo+DC5FUOE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2801
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gOC8yNC8yMSAyOjU0IFBNLCBFdWdlbiBIcmlzdGV2IHdyb3RlOg0KPiBTb21lIHBsYXRmb3Jt
cyBoYXZlIHNlcGFyYXRlZCB0aGUgZW5kLW9mLWNvbnZlcnNpb24gaW5mb3JtYXRpb24gZnJvbSB0
aGUNCj4gdXN1YWwgSVNSL0lNUi9JRVIvSURSIHJlZ2lzdGVycywgaW50byBFT0NfSVNSL0VPQ19J
TVIvRU9DX0lFUi9FT0NfSURSLg0KPiBUbyBjb3BlIHdpdGggYm90aCB2YXJpYW50cywgaGVscGVy
cyBhcmUgYmVpbmcgYWRkZWQsIHRoYXQgd2lsbCBtYWtlDQo+IGNvZGUgbW9yZSBjbGVhciBhbmQg
bW9yZSBlYXN5IHRvIHJlYWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBFdWdlbiBIcmlzdGV2IDxl
dWdlbi5ocmlzdGV2QG1pY3JvY2hpcC5jb20+DQo+IC0tLQ0KDQpIaSBKb25hdGhhbiwNCg0KSWYg
eW91IGNhbiBzdGlsbCBtYWtlIGNoYW5nZXMgb24geW91ciB0ZXN0aW5nIGJyYW5jaCwgSSBub3Rp
Y2VkIGEgdHlwbyANCmluIHRoZSBzaG9ydGNvbW1pdCBvZiB0aGlzIHBhdGNoIDogJ2F0OTEtc2Ft
YTVkMi1hZGMnIGluc3RlYWQgb2YgDQonYXQ5MS1zYW1hNWQyX2FkYycgLCBncmVwcGluZyB0aHJv
dWdoIGNvbW1pdHMgaW4gdGhlIGZ1dHVyZSBtaWdodCBtaXNzIA0KdGhpcyBwYXRjaCwgc28gbWF5
YmUgeW91IGNhbiBjaGFuZ2UgaXQgPw0KDQpUaGFua3MsDQpFdWdlbg0K
