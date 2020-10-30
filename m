Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28DBC2A0552
	for <lists+linux-iio@lfdr.de>; Fri, 30 Oct 2020 13:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgJ3M1Z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 30 Oct 2020 08:27:25 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:29022 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbgJ3M1A (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Oct 2020 08:27:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1604060819; x=1635596819;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=KTWKV/bt9pNGfIGRanurXarWfi4YqPF4biQhAgAXMzQ=;
  b=PDrSz4foJN3mkimPW0wSZCC+mvYbkf2fh50jtCt3L7aHMgugiPKOoss6
   HVAejr7cSUHv8gWXK/GLsWRZ1fDyHC4HcPrRe+OqSZHh8RXrpgIjWJ3R4
   8jWJUPYa9JgEC8/SQYgRkqXbqIOm8WNUtYcdr3wzQEKApbYL3TFuukfJi
   dG68aulX9UP52PJfXYIERWEoQWWnNWka8Y916RgamBSRRnIUO4cuJ07Zv
   dVSOLllSLQQSZ6VQqZFRXQe474ff+yIQeHjH23OFgXZ8iWnJuV0nC7y6F
   /+sjIQ/Au9wHGEyX4ERrDe+0kSggMzfmNxL8zzGDLAqRRV5fVoh/dBjpL
   w==;
IronPort-SDR: ww0JPtMmSSJgwHO9ag0QY6u6vSrnMuXrkB1Kf8w7UNfay6gTNDUFH8iBAM9k4U4xVfmlL8Q/QK
 WXB3ytEAYm+2mK/TSvyA3IoiOo+zaedmrKIVcR+mSaQf/561c+cvqW1+0IR/jYt5fO1vc1XIdO
 5U1LOqRliRin4FDGHJekwkTyFY1yWKVA4SChvSSBslZ6/9l3Fq8vi6JyLIYKkyXohUe28UB/yi
 u5YTgLmEGK+0Y+M7JCjDCrO7ZqdKFPcCbZ1P7uefppfqwYVdbCWb/4Ym7mFn3K+opDdmifjV9+
 RC8=
X-IronPort-AV: E=Sophos;i="5.77,433,1596524400"; 
   d="scan'208";a="101577593"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Oct 2020 05:26:14 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 30 Oct 2020 05:26:14 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Fri, 30 Oct 2020 05:26:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JzpKO4PK1S8LTlXBN4W01SRa5qEQ1sDasR2m1zc4KMvGhAASLSWs3NjFlCCJlKbiFsJ0S7tm0e9I/+aTec0mKh9NdbGPZ6BeM/xtsYnpQZDD1RmUkgpRp6zNKu/3bDKEvSKJW5aOdE4yZq0KbiIql/xNX/xGRXMKw1fSqZp02AcGSpvVRhV+RfagJYGsjVKkAea+cTtXeriGrPDsI5kKed1KIKbtUlLHgIYxOPw2cm7+zM3yRELZ1uUdWB+J/ANs2IN0eSG7sqQRskdyihQkDVF9iZpjuVmve9DVGDr4b0ind2EnUYSS+hbsZ6eU1H1yN2q9IOdp8xZgSmVkPooLbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTWKV/bt9pNGfIGRanurXarWfi4YqPF4biQhAgAXMzQ=;
 b=kStF8AgNUeirgpZkjzD9NtHmVN5OqT4vw8sfIg/hkWLRvCllbbOl/fQ0ay1K/Ig/M6NoEegxA4eZw7J8Hp2Kl3lOMtjuo0USCWnzTjioAvVzxaVrK2cayr1FsLNs4pCCGR9IMRML8TQki08qhtR0FC/DkAvZb08AXlRnAYnC1BtT/rCO3oJ5cWLL2CsPKPt1eOhkg4pleYKhhYRzNP+JaNumwkgDh1ikEsksJu3U+mAF//z2EbjuqFYaRvARYlRNlVEtKP8v2oi/BT6nZ7FrXfrrZRZLIq30WJEmEZRlcNJINdEjWyI8OTJG2x9L1zRtTAB0kBs8wlNIygdo6JO6Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTWKV/bt9pNGfIGRanurXarWfi4YqPF4biQhAgAXMzQ=;
 b=g8kR4OhZzNOv8vW/bPg5VREdOgygjMu3NXnlJNI1X+ZvQdrSPVoOFc33uojVodCEMNPQhmoBdZYh7qdY7wOY4i8ab6OyMNOnok40u3kXEmHPzsyok/UByoY6226FGiZdlRmOQBtjDbrrdQWHkldUI1pJnVyhpZjxKgWJbw4c3pE=
Received: from BYAPR11MB2999.namprd11.prod.outlook.com (2603:10b6:a03:90::17)
 by SJ0PR11MB5104.namprd11.prod.outlook.com (2603:10b6:a03:2db::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Fri, 30 Oct
 2020 12:26:11 +0000
Received: from BYAPR11MB2999.namprd11.prod.outlook.com
 ([fe80::4854:dda7:8d0f:bb51]) by BYAPR11MB2999.namprd11.prod.outlook.com
 ([fe80::4854:dda7:8d0f:bb51%7]) with mapi id 15.20.3477.029; Fri, 30 Oct 2020
 12:26:11 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>
CC:     <alexandru.ardelean@analog.com>
Subject: Requirement for at91-sama5d2_adc timestamp buffer
Thread-Topic: Requirement for at91-sama5d2_adc timestamp buffer
Thread-Index: AQHWrrfWc5WFebfoFE2qfjGYfQ3FNw==
Date:   Fri, 30 Oct 2020 12:26:11 +0000
Message-ID: <8825686e-1fc4-65fd-e482-f25d46288ff7@microchip.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [82.76.158.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a6069b5-1702-41a8-d3e6-08d87ccefc96
x-ms-traffictypediagnostic: SJ0PR11MB5104:
x-microsoft-antispam-prvs: <SJ0PR11MB5104084EFE30A1D7ECD6D9B0E8150@SJ0PR11MB5104.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /txAtCzCuplPMvoNbCEGn7dM4EkLuFNmhIGmxBAViloWXyTQt8PfcaL3N0tzNMJix5WS+PdxwiF08GSiuXfempX+LTVx8cR1gqpRnSrZgNu/c97W/j0fAUFZ5bLFBsCsVlUhuQoMIiLu9+rosXRNdEMFIf5FtUKmQYcxREu4x03rH4G6QeT/bdENKfp3R7JUbC3RE1aNmN+kiM3Q9If3/4ig/DIWIs33jLlkGrw5XnFBM/JTunBGYbmjqisC+oTSyA8MSZxP7KPGY/oz7tqDAK0cMHCl1o0iPAg9oL5hML5/tO9BmBCkoGbHmCKXFFrItj47nIaC+uBOB8ck0aJHnhGWM0wvuJR6gUg/6XhvAdHOPSi8mi6BWSj1y6AfXRun
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(396003)(366004)(346002)(136003)(36756003)(31696002)(4326008)(110136005)(6512007)(8676002)(64756008)(2906002)(5660300002)(66446008)(6506007)(2616005)(66946007)(31686004)(91956017)(76116006)(186003)(66476007)(66556008)(26005)(4744005)(83380400001)(71200400001)(478600001)(6486002)(316002)(8936002)(86362001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: F7hM2tEfObk+OcfLVcMX6LzDFmSH7Oe8iBrzHHrHoEKHJlFW6zyx8zZXf8Z0N3XxvDcN5MxwYZ+k2+tYlLpcTXkPo8eMhoopzh8XXbayyxU/glSdVSUPsfDIiHXzzc4tilLjFMSeNcfbTWHrDa1MfLlgGyAlKeeBd+URVYdEV0G94ZaIAGXe97h0rkSsox+oyH1yf0YkHmvMXKgB6Ec5qcp0dTqTg/fNFUdHBv8c/uMjRICM9d52R/fYeNXS2BZW8w51eaiNzXmtZ1VqvB4Q2fZ5b0/CAMbzDQ/BnlR6xlsNTeJWlddK6YgKfO22kjAbP4FBXBe5UK1aZhDbBMZjcbR7DOwW3PH/Pg/j/RGVkfWIGlA6masF7MXe6+kDp+wvr+OSLxZ1LBPSFAPE57R6/VuhuvoRe1dkQrIFCka8lkmF5EE0nHxOHLrfqD8Z/Iv7cGa2fFGpLRu5O674rlirQoTDA53dbRD7m6nWcK2dfbXIVeQtWezd0ulpqXdZBY9up73Zo3ZW+Ve1NZAZqrrCy4LRgO8p+p4r15a/VQokDMA3ZZ8YlXQr2lnvpWhfmMdu5N0sdUwvChrbzc+hBZGDNLi0FFf65rQdZUDE34PTGpEV11B0E8+YsyH7IuO3a6Gw4pOxq6h4tPNFEidW7zRgWA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1117E368D28E89429D8ADB7E5FB9DADA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a6069b5-1702-41a8-d3e6-08d87ccefc96
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2020 12:26:11.5055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0jwDuHn1oPZG3Kv8lHkztzRcIKkZs7ozF6joOVC2fKaGJooRWxJ8Sqj45/kRnxXVewaxt0rCb7FMirCtiM9U+h5BXH5RZtY0ZiUT04DPWQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5104
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGVsbG8gSm9uYXRoYW4sDQoNCkkgZm91bmQgYW4gaXNzdWUgd2l0aCBhdDkxLXNhbWE1ZDJfYWRj
IGRyaXZlciwgbmFtZWx5LCB3aGVuIHVzaW5nIERNQSANCmFuZCB0aW1lc3RhbXAgaW4gdGhlIHNh
bWUgdGltZSwgdGhlIGhhcmR3YXJlIHByb3ZpZGVzIHRoZSBzYW1wbGUgaW4gdGhlIA0KZmFzaGlv
biAoMiBieXRlcyBwZXIgY2hhbm5lbCkgKiAobnVtYmVyIG9mIGNoYW5uZWxzKSAtIGFzIGNvcGll
ZCBieSB0aGUgDQpETUEgbWFzdGVyIHRvIG1lbW9yeS4NCkkgY29tcHV0ZSBhIHNvZnR3YXJlIHRp
bWVzdGFtcCAsIGFuZCB0aGVuIHB1c2ggdG8gYnVmZmVycyB3aXRoIHRpbWVzdGFtcC4NCkhvd2V2
ZXIgeW91ciBwdXNoIGNvZGUgd2lsbCB0cnkgdG8gd3JpdGUgdGhpcyB0aW1lc3RhbXAgaW5zaWRl
IG15IGJ1ZmZlciANCiEgYW5kIG92ZXJ3cml0ZSBteSBzYW1wbGVzLi4uIEkgaGF2ZSBtdWx0aXBs
ZSBzYW1wbGVzIGluIHRoZSBidWZmZXIgDQood2F0ZXJtYXJrIG51bWJlcikgYW5kIHRoZXJlIGlz
IG5vIHNwYWNlIGJldHdlZW4gdGhlbSBiZWNhdXNlIHRoZSANCmhhcmR3YXJlIGNvcGllcyB0aGUg
Y29udmVyc2lvbiBkYXRhIGRpcmVjdGx5IGluIHRoaXMgYnVmZmVyLg0KDQpEbyB5b3UgaGF2ZSBh
bnkgc3VnZ2VzdGlvbiBvbiBob3cgdG8gc29sdmUgdGhpcywgZXhjZXB0IDEpIGdpdmluZyB1cCB0
aGUgDQp0aW1lc3RhbXAgaW4gdGhpcyBtb2RlIG9yIDIpIGNvcHkgdG8gYW5vdGhlciBidWZmZXIg
d2l0aCBtb3JlIHNwYWNlIGZvciANCnRpbWVzdGFtcCBzdG9yYWdlID8NCg0KVGhhbmtzLA0KRXVn
ZW4NCg==
