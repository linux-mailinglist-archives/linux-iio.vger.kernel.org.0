Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135D5613C1B
	for <lists+linux-iio@lfdr.de>; Mon, 31 Oct 2022 18:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbiJaRZM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 Oct 2022 13:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbiJaRZE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 31 Oct 2022 13:25:04 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D7D13CD1;
        Mon, 31 Oct 2022 10:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667237102; x=1698773102;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+hiJY8il6MGoqVQcQ4v4F5pxHzbeBUwCtH08aQNuuVk=;
  b=C/NSgAnWevOQ8qXVEyIwdlejXxCcx/ig0j+zyoL+HFrD8RWOubEYM7GL
   x9A1E4Z9O2kdE2EnD5ICK4+aFuD77ngDs5PaK7+dpznsmMzAWo49zPXpL
   axChUqOQaHQkagd/5Nli0yFvkPnvTs4/ycLtjwLKY1HJx+k7++2ywdma4
   Ih+aSTGNfX8GjWgR9AMzkPlgLlZ1yVDXiP7IYVa4IfDfSt09xLpoO9ZZy
   veoqVKmD1KIdYdSLqwTuptpcjsl9BvKK3e4ap7eBkc7/kPAeZwP3SMx4z
   z2zHA1ZF/68Lj3iITylP88g7tZF9NVbL3eghZkhM3rQp/h4sQULFP6+qu
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="307681193"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="307681193"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 10:25:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="776212553"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="776212553"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 31 Oct 2022 10:24:55 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 10:24:55 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 10:24:54 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 31 Oct 2022 10:24:54 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 31 Oct 2022 10:24:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UE5CgtUJCTSFLTQfMiERdSJf8oPxZr/D26Lc1RxcnC31KNucGNgzw11hhFFUDcsIkRAX0v2Q/RTcaGfK2px1yd3lV5uyOKq/DoeBHbf2MBaRKAzwbiNCFQNMpiz0cgtPM0u/cDfZ+1zytv8GTGzER1UnQpcA2/HonLe8HsPrmETPAgJhbvodALLnmUmmipIitktD0rtyprbUMv78GCbNgw7vNjtTRtQzsmCRFXua0mOj4WJ1mjohs7HANYGHZEQpQB/Wx/Bjdj9WACcR3yOdfv8LCU0zNoatzvKqTpw0nYzGShOV0IqyUmRVh1pDBHc2+Cpt9IC9jNH8hyVgd3nlfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hiJY8il6MGoqVQcQ4v4F5pxHzbeBUwCtH08aQNuuVk=;
 b=mAUxXLlqBNNdMfcZclQDE69aloGsDfNTiF4nTHUwHBQ9aDM8tN7OFCWt0CUaCl3/lMWEo4vRUQ3rdMG63XMR8vyyeCz4pP6XFCcAzs+vWflwvxvVu0NvdsIGG1Re7b2eKgdXXWEqOxmdgxXKEDuD1KAL1TGQWwglF90+FXzOt+L//n2274zRwwKZGVtNtvNeS5zWHSyPpIgjUJdrk69Msg5WG12J4YAD5JKo3VhPnTV6kqfiqoV0jJJeM76wlFxkQnVB/ghmgAmj/4eT17fTIlh2gq7+emiXmloSYPX2/oMfgRnj43rGKx0PUfCaXzn8XzPBB/uf3sAqrpdj5A0L7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by BL1PR11MB5415.namprd11.prod.outlook.com (2603:10b6:208:315::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 17:24:51 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::ce74:6470:a65c:5d7a]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::ce74:6470:a65c:5d7a%5]) with mapi id 15.20.5746.028; Mon, 31 Oct 2022
 17:24:51 +0000
From:   "Khandelwal, Rajat" <rajat.khandelwal@intel.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Subject: RE: [PATCH v6] iio: temperature: Add driver support for Maxim
 MAX30208
Thread-Topic: [PATCH v6] iio: temperature: Add driver support for Maxim
 MAX30208
Thread-Index: AQHY58ywMYnIRax/gUaRtP+D2GP1E64lf7iAgAMz1aA=
Date:   Mon, 31 Oct 2022 17:24:51 +0000
Message-ID: <CO1PR11MB4835BF50AD0BED735350F5B196379@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20221025171858.225242-1-rajat.khandelwal@linux.intel.com>
 <20221029160353.3999849b@jic23-huawei>
In-Reply-To: <20221029160353.3999849b@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|BL1PR11MB5415:EE_
x-ms-office365-filtering-correlation-id: e14e1750-15e4-4a47-e358-08dabb64d1ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XgY/qYTte/pWVV59daw/gS7J1cU24JD65C0+L642xkkU3EGAyJOw0sVOrfp3Lt6AVzo72e2lZ+gIr6vDr+LBHw6twaBuofLirwEE6dYBP0FE5kvc8cAnslxpaz3SL2O7Oha9a/FKt4nFXVfqozFkxkEUXw806/ySOWKYmrEHKB+i9lqnemTFIEzowUyayxRm0ojZ2ukmlpM/WrUKZ+aXZfORaHJ5zXbRmj0mK0YQaZVQ8ak9gpXAdoRyrRcKpEkRcCyhhqKpT9wCWkTMmjilKCUEUihF3pHxO1B2vAqQok7ltuPL/zIrkw3Yrj6rJKm/1zBdR5rTtwa9HvKVpiPtM2OwPm8nhAmLYXTUbWehEH9PoS+AjBN84GdzAEIyr1Xs6ZoNXWmY2+WitzHibZAbiw11qtdgmDkJ+TYRN3xCK1CjZ68oAmY439Z8HkquVuxdAUJj/+nIuXJNhkHXr3ZkLckBoY4pyJl44B+2WP+kTtoQIBDxukTrZlDTvZvctfgWCPHaFZrg3nk1OKS3qBqgxU0TQcD6A0Y4Xv4wUQDlu+wvItk7ev/+VH20RfDJfdJ2dn/oLl3OH9umfsDbz0bOJaUEhpv+nettdIasVNDfPPZpWwwchZc40Oeag7+q4QUoXq6qsyzluHJuyN4uWOz35uaOLpMT38gJCVTWhcamx9AKUWuDAdvHocVH77ATiASGMGoZTQcjYWVnvqTNB+Me6tjZ9ywyAVok+kkdiEaQtKhX3copmmiKBN7LC1OK1/5Ar9bITsYY1xu+7kspsMiIxZinxfq2zi5JX4uL2ZM0yS4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199015)(6506007)(7696005)(966005)(26005)(71200400001)(9686003)(66899015)(316002)(8676002)(478600001)(53546011)(66446008)(66946007)(76116006)(66556008)(66476007)(4326008)(64756008)(186003)(5660300002)(83380400001)(2906002)(8936002)(41300700001)(52536014)(30864003)(38070700005)(55016003)(33656002)(38100700002)(122000001)(54906003)(110136005)(86362001)(82960400001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFBpMXAwNGZjc0g0YW9Sd2tOazM3V2hWaUVvcDE2eTFFTE42bWE5bnl0UURR?=
 =?utf-8?B?bXBFb2FqOWRFT1dhaWZZVjJXWlVuT2Jua1lnQkV0cmZZZU0vUC9sSW5QODM5?=
 =?utf-8?B?d3Vhc1g3K3VxdWV6Q3JybTc2MTRscDRxb05ubnIvNXdMMk4rdXRnVlJTdndt?=
 =?utf-8?B?ZndlU0I2bFVKS0lZRTdEQzY1U0Joam0rT0JrY3o4WW1WeG05VXE5M1hkZXNY?=
 =?utf-8?B?dFFzYkI1NFk2S2JwMEtKSlpZUE9tdGh6MW9SbkZFaGk5Qm03R0ZMMzQ3MDNq?=
 =?utf-8?B?N0JrVVVhK0xQWWMzVU8rdDVmdkJPT2NKM0RXUDFXTmRaTVJYY3VnWlZtc3J2?=
 =?utf-8?B?MnpISVVSQ08xWHRkOThidVpkWWVUVFpaSERrdTB6bUpoazk0T3NVV3gzR2lZ?=
 =?utf-8?B?bFNSOG9wclhiZE43bkI1MjB0eXVuWnN1NTJRRVZKbUpkZ1RGMHZTWVdBWllw?=
 =?utf-8?B?RWtnVHA0VHU0ajZBUkI2M2t6UE0rM3I4RXhIUWt6N3JpT2hQbm1BZk5WNmFa?=
 =?utf-8?B?dnowQzVRZ1A5dlFmSmdCdkI3MGtsM2NJOFdIUTlBUGg4Z3QzQ3QzYjRJdFls?=
 =?utf-8?B?aFJ1ZjFZY1NadFRsSlpBbVpBMXBxR2E2V251b05icWpFYTNiV2s5Y0VYSjEz?=
 =?utf-8?B?N2RjcDcrTUJrdUc0RklDcjN1VjZkc01iMkJWNE96bk5TM01jTjc2Ym5pT1RD?=
 =?utf-8?B?MzRJSG9MOUtYWVVuSGo5MTJlUG50Z29ISGJvVkE4b3A1QlVzVGg1YUorcnR6?=
 =?utf-8?B?RlBSc3prR3dRaDJSb3ZaS1paQ3l0aytsd1lKeTdhNmJxc2Z6S1RXRVVUdG1Z?=
 =?utf-8?B?c3liVmkrMUJrUXlhcSs5RE4wYXhLWkZLUEZPUG1POE5DU1NHdWlmb0U0UFVt?=
 =?utf-8?B?cVVrMkZ4c3JtVGhHcWkxYkNOQXlDMFlURHErWEsvS1ZRM0VNSnJvZjRxaDVq?=
 =?utf-8?B?amo0MXBFaXlneXpVRS95ZVdyZUdOaFA3cWc2WHA4a0VuMnBDZjRIeUVwclVp?=
 =?utf-8?B?T3RsTWdybDR3QkJxZ3dwc3hZRXJOMjlJWHFOSUdrRFAyd3JFRkZIMjNOTmc0?=
 =?utf-8?B?V0ZIL0VMOVJvVVllVVhMZnJqaEhFZ2x1cTcrbERSTkIvMFl5VWF4ZmZwcVZ3?=
 =?utf-8?B?YXhwUmdFajl6dDlzRStzNFg3UkdndmU2c3dEaGRLTGJuK0JYeTNPUERwVEow?=
 =?utf-8?B?RTVWZnBaWGYyTUgvajNJZ29KUVNjbXpwcVAyUWl3NUdEMmNhYjNJZyt4ZVZs?=
 =?utf-8?B?UjIzamtTUFYvLzJHY3pzUXdoc3pFeWxmMTJJSnZNWGM5OGE5VzYzVGlFdWFD?=
 =?utf-8?B?NXZpVFhOTmZoUGNaRUdvRjE0d052SS9TUk0rdWVJeFhvM0pQQ1MzdTY2eVlI?=
 =?utf-8?B?UFRSQ0h1dU44aHNIT29UUjRXcFNRVmIzRk5uRTRnYWZyYzlFQ0x4eHdxLzRX?=
 =?utf-8?B?ZW1zS052VjE5dVVWaHdvVVpTSzd2dWx1eHNKWnRueTYzWWl3YnR1Zkh6OTQ1?=
 =?utf-8?B?VTBsMnM1ZmsvQmQvcjNBRXRxY05VQmduSWYreUswT1I5VW5mc0J4eHo4ZlJs?=
 =?utf-8?B?cTZ4UjBsNkw4OFlrVWd6MGJXSnM0QWdFajZWTDRvRGs5QlpKbHdDTzJZUTVi?=
 =?utf-8?B?TithOXZla2QvNFhwZE5UVEM3S0t6cGFnamdKRVBwSnZRT1dhYndlVGtFQXhT?=
 =?utf-8?B?cml2WjRvTVpFcjRrVGJ3eGtDSU44aEVSVncrVDBqeEJDNTNsNEZhSFh0UFdW?=
 =?utf-8?B?cWk3TlZyL1IzaVlzZytJWm50SHJOUTA1RVRiWDZ5VW9SMlk1RHNCNmdYS1p5?=
 =?utf-8?B?VUUxdkhBNEUxZHhTVmtBcDB4Mk82dVJ0MFcxVTI0cFgxY1V5bHc5Mk9GRHpC?=
 =?utf-8?B?UFE3Wmo0LzhOemFTTEVJeTB4VEw2U0hxYU1IVnl3OEJEUXZLN3pMN1JZRHFq?=
 =?utf-8?B?VzVjRS93RFkrakNDUXZZc2ZjZHdhTjM5WVhSZTlxOU5nV0lqUUMrYzRheXpF?=
 =?utf-8?B?V2JhSmZJSHo2Y1FJN2pqRXJDRGMxV3UvQTRKeDdXMFduak5nY1E5dld2S1pX?=
 =?utf-8?B?bzhNMnVLYmorbHhpY202aUNlUUo3TjJNajR3dWwrdUFYQTFXR2ZWZTlCbU5H?=
 =?utf-8?Q?h7uELssVk5FhZdbjNpn4AiJmx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e14e1750-15e4-4a47-e358-08dabb64d1ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 17:24:51.5213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VLS7NXXxrMcuwCT+ogyZqA6iO8Xm09bI7h9puw+AXyYupyQkUgjVFl6YqStuXzTMvAtfKz0dHJGO9EfL+LgePKTz+rDyRnxOxkUZRQjXtCU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5415
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgSm9uYXRoYW4sDQpVcHN0cmVhbWluZyBhIGRyaXZlciBzdXJlbHkgcmVxdWlyZXMgYSBsb3Qg
b2YgaW5xdWlzaXRpdmUgcmVhZGluZ3MuIDopDQpUaGFua3MgZm9yIGFja25vd2xlZGdpbmcgaW4g
ZGV0YWlsIHdoaWNoIGV2ZW50dWFsbHkgaGVscHMgbWUgdG8gd3JpdGUgYmV0dGVyIGNvZGUuIA0K
DQpPbiB0byB5b3VyIGNvbW1lbnRzIQ0KPkl0IGRvZXNuJ3QgdXNlIHRoZW0sIHNvIHVubGVzcyB5
b3UgaGF2ZSB0byBiZSBpbiB0aGF0IHN0YXRlIHRvIHVzZSB0aGUgY3VycmVudA0KPm1ldGhvZCwg
ZHJvcCB0aGUgbm90ZSBhbmQgZG9uJ3Qgc2V0IHRoZW0gdG8gZG8gdGhhdC4NCj4NCj5Zb3UgY2Fu
IGFkZCB0aGF0IHN1cHBvcnQgaWYgLyB3aGVuIHRoZSBkcml2ZXIgc3VwcG9ydHMgaXQuDQpJIGhh
dmUgZHJvcHBlZCB0aGUgZW50aXJlIEdQSU8gc2V0dGluZ3MgZm9yIG5vdy4gSSB3aWxsIGluY29y
cG9yYXRlIGl0IGluIHN1YnNlcXVlbnQNCnBhdGNoZXMgZm9yIHlvdXIgcGVydXNhbCBhbmQgdmVy
aWZpY2F0aW9uLiANCg0KPiBNZW50aW9uZWQgYmVsb3csIGJ1dCBJJ2QgcHJlZmVyIHRvIHNlZSB0
aGUgc3RyaW5nIGRpcmVjdGx5IGlubGluZS4NCkRvbmUuIA0KDQo+IEJlIG1vcmUgZXhwbGljaXQg
LSByZWFkcyBvZiB3aGF0Pw0KRG9uZS4NCg0KPkkgYWdyZWUgd2l0aCBHdWVudGVyJ3MgY29tbWVu
dCB0aGF0IHRoaXMgaXMgYSBiaXQgb3Zlcmx5IG5vaXN5LiBXZSBkb24ndCBleHBlY3QNCj5yYW5k
b20gcmVnaXN0ZXIgcmVhZHMgdG8gZmFpbCArIElJUkMgdGhlcmUgaXMgdHJhY2luZyBpbiB0aGUg
aTJjIHN1YnN5c3RlbSBpZiB3ZQ0KPmFyZSBnZXR0aW5nIHN1Y2ggZXJyb3JzLiAgIEhlbmNlIHBy
b2JhYmx5IHJlZHVjZSB0aGUgZXJyb3IgdG8gY292ZXIgb25seSBsYXJnZXINCj5ibG9ja3Mgb2Yg
Y29kZS4gIFJlYXNvbmFibGUgdG8gcmVwb3J0IHRoYXQgdGhlIHRlbXBlcmF0dXJlIHJlcXVlc3Qg
ZmFpbGVkIHBlcmhhcHMuDQpTbywgSSBraW5kIG9mIGp1c3Qgc3RhcnRlZCB1cHN0cmVhbWluZyBt
YXRjaGVzIGluIHRoZSBJSU8gY29tbXVuaXR5IGFsc28gZm9yIGNoYW5nZSBvZg0KZG9tYWlucyBh
bmQgb24gc2VlaW5nIG90aGVyIGRyaXZlcnMgd2hpY2ggd2VyZSByZXR1cm5pbmcgb24gZWFjaCBl
cnJvciwgSSB0aG91Z2h0DQptYXliZSBpdHMgcmVxdWlyZWQgaW4gSUlPPyBUaGFua3MgZm9yIHRo
aXMgY29tbWVudC4gSSBoYXZlIHJlbW92ZWQgdGhlbS4gDQoNCj5kZXZfZXJyKCkgIEZhaWxpbmcg
aXNuJ3QgZXhwZWN0ZWQgc28gaXQncyBhIGRldmljZSBlcnJvciBub3Qgc29tZXRoaW5nDQo+d2Ug
c2hvdWxkIG1lcmVseSB3YXJuIGFib3V0Lg0KT2ssIHNvIGhlcmUgSSBoYXZlIGluY29ycG9yYXRl
ZCBkZXZfZXJyIGJ1dCB3aGF0IEkgd2FudGVkIHdhcyBpZiBNQVgzMDIwOF9TVEFUVVNfVEVNUF9S
RFkNCmlzIHdyaXR0ZW4gc3VjY2Vzc2Z1bGx5IGFuZCBhbnkgZXJyb3IgaGFwcGVucyBhZnRlciB0
aGF0LCB0aGUgdXNlciBzdGlsbCBnZXRzIHJldHVybmVkIHRoZSBtb3N0IHJlY2VudA0KcmVhZGlu
ZyB3aGVuIHRoaXMgb3BlcmF0aW9uIGZhaWxzLiBTbywgSSBoYXZlIGNoYW5nZWQgaXQgaW50byBk
ZXZfZXJyIHdpdGggcHJpbnRpbmcNCiJUZW1wZXJhdHVyZSBjb252ZXJzaW9uIGZhaWxlZCwgcmVw
b3J0aW5nIHRoZSBsYXN0IGtub3duIHJlYWRpbmcuLi4iKSBXaWxsIHRoYXQgYmUgb2s/DQoNCj4g
RXJyb3IgcmV0dXJuIHRvIGluZGljYXRlIHdoYXQgaGFwcGVuZWQgLSB0aGVyZSBpcyBvbmUgZm9y
IHRpbWVvdXRzLg0KQXMgaW5kaWNhdGVkIGFib3ZlLCBpZiB5b3UgYXJlIGluIGZvciB0aGF0LCB0
aGVuIGhlcmUgd2Ugc2hvdWxkIGlkZWFsbHkgcmV0dXJuIDAgc2luY2UgZXZlbiBhZnRlcg0KdGhl
IGVycm9yLCB3ZSB3YW50IHVwZGF0ZV90ZW1wIHRvIGRvIGl0cyBqb2IgYW5kIHJldHVybiB0aGUg
bGFzdCByZWFkaW5nLiANCg0KPldoaWxzdCB5b3UgZGViYXRlZCB0aGlzIGxvZ2ljIHdpdGggR3Vl
bnRlciBpbiB2NSwgSSBkb24ndCBmb2xsb3cgdGhlIGNvbmNsdXNpb24uDQo+SWYgRklGT19PVkZf
Q05UUiA+IDAgdGhlbiBGSUZPX0RBVEFfQ05UUiA9PSBtYXhpbXVtIHZhbHVlLiAgTG9naWMgb2Yg
dGhpcyBpcw0KPmdpdmVuIGluIEZJRk9fREFUQSBSZWFkIEV4YW1wbGUgKFBhZ2UgMTYgb2YgdGhl
IHNwZWMpICBJdCBkb2Vzbid0IG1hdHRlciBhcyBzdWNoDQo+YmVjYXVzZSB5b3UgcmVhZCBGSUZP
X0RBVEFfQ05UUiBhZ2FpbiBhbnl3YXksIGJ1dCBpdCB3b3VsZCBiZSBtb3JlIG9idmlvdXMgd2hh
dA0KPmlzIGdvaW5nIG9uIGlmIHlvdSBqdXN0IHNldCBkYXRhX2NvdW50ID0gMzIgaWYgb3ZlcmZs
b3cgaGFzIG9jY3VyZWQuDQo+DQo+VGhlIG9ubHkgdGhpbmcgSSB3b3VsZCBhcmd1ZSB5b3UgJ21p
Z2h0JyB3YW50IHRvIGRvIHdpdGggdGhlIG92ZXJmbG93IGNvdW50ZXINCj5pcyB0byB1c2UgaXQg
dG8gaW5kaWNhdGUgd2UgbmVlZCB0byByZWFkIGF0IGxlYXN0IHRoZSBudW1iZXIgb2YgZWxlbWVu
dHMgaW4gdGhlIGZpZm8uDQo+SWYgdGhlcmUgYXJlIG5vIGFkZGl0aW9uYWwgZWxlbWVudHMgYXQg
dGhlIGVuZCwgd2FpdCB1bnRpbCB0aGVyZSBpcyBvbmUuIE90aGVyd2lzZQ0KPnlvdSBwb3RlbnRp
YWxseSBnZXQgdmVyeSBzdGFsZSBkYXRhIC0gaXQgbWlnaHQgaGF2ZSBiZWVuIG92ZXJmbG93aW5n
IGZvciBhIGxvbmcgdGltZSkNCj5UaGlzIGRlY3JlYXNlIGJ5IG1vcmUgdGhhbiAxIGlzIHdvcnJ5
aW5nLiAgSSBjYW4gdW5kZXJzdGFuZCBpdCBub3QgZGVjcmVhc2luZywgb3IgZXZlbg0KPmluY3Jl
YXNpbmcgKG5ldyBkYXRhIGNhbWUgaW4pLCBidXQgdGhpcyBjb25kaXRpb24gc291bmRzIGVpdGhl
ciBsaWtlIHdlIGFyZSBkb2luZyBzb21ldGhpbmcNCj53cm9uZyBvciB0aGVyZSBpcyBhIGhhcmR3
YXJlIGJ1Zy4NCk9rLCBldmVuIEkgc3RhcnRlZCBkb3VidGluZyB0aGUgbmF0dXJlIG9mIHRoZSBk
ZXZpY2UgSSBlbmNvdW50ZXJlZCB3aGVuIEkgdGVzdGVkIGl0Lg0KVGhlIHRoaW5nIGlzLCB0aGlz
IGRyaXZlciBhbHNvIGNvbWVzIHdpdGggYW4gRVYga2l0IHdoZXJlaW4geW91IGNhbiBwbHVnIGlu
dG8NClBDLCBkb3dubG9hZCB0aGUgc29mdHdhcmUgYW5kIGludGVyZmFjZSBpdCB2aWEgVVNCLiBX
aGVuZXZlciBJIGVtdWxhdGVkIHJlYWRzIGZyb20gdGhlDQpPUywgSSBlbmNvdW50ZXJlZCBlcnJv
bmVvdXMgY291bnRlciBkZWNyZW1lbnRzLiANCkhvd2V2ZXIsIEkgaGF2ZSB0ZXN0ZWQgaXQgdXNp
bmcgbmF0aXZlIEkyQyBvbiBteSBtaWNyb2NvbnRyb2xsZXIgYW5kIEkgZG9uJ3QgZXZlciBlbmNv
dW50ZXINCnN1Y2ggcmVhZGluZ3MsIHRodXMgY29uY2x1ZGluZyB0aGF0IHRoZSBzcHVyaW91cyBl
cnJvbmVvdXMgem9uZXMgb25seSBleGlzdCB3aGVuIHRoZSBFViBraXQNCmlzIGludGVyZmFjZWQg
dmlhIFVTQi4gDQpUaGFua3MgZm9yIGNyZWF0aW5nIHRoaXMgZG91YnQuIEkgaGF2ZSBzb2x2ZWQg
aXQgYnkgb25seSBkZWNyZW1lbnRpbmcgZGF0YV9jb3VudCB1bmxlc3MgaXQNCmJlY29tZXMgMC4g
DQpSZWdhcmRpbmcgZGF0YV9jb3VudCB2YXJpYWJsZSwgc28gd2hlbiBvdmVyZmxvdyBjb3VudGVy
IGlzID4wLCBJIHdhbnQgdG8gZGVjcmVhc2UgJ292ZXJmbG93IGNvdW50ZXInDQpudW1iZXIgb2Yg
dGltZXMgdG8gZ2V0IHRoZSByZXF1aXJlZCByZWFkaW5nIGFuZCB3aGVuIG92ZXJmbG93IGNvdW50
ZXIgaXMgPTAsIEkgd2FudCB0byBkZWNyZWFzZQ0KJ2RhdGEgY291bnRlcicgbnVtYmVyIG9mIHRp
bWVzIHRvIGdldCB0aGUgcmVhZGluZy4gSG9wZSBpdCBtYWtlcyBzZW5zZSBub3cgaW4gdGhlIG5l
dyB2ZXJzaW9uLg0KDQo+RXhjZXNzaXZlIGxpbmUgYnJlYWtzLiAgVGhpcyBpcyB1bmRlciA4MCBj
aGFycy4gIEluIGNhc2VzIHdoZXJlDQo+cmVhZGFiaWxpdHkgaXMgaGVscGVkIGJ5IGdvaW5nIGFi
b3ZlIHRoYXQgKHRob3VnaCB1bmRlciAxMDAgY2hhcnMpIHRoYXQNCj5pcyBmaW5lIHRvby4gIE1h
a2Ugc3VyZSB5b3UgdGlkeSB1cCBhbGwgc2ltaWxhciBjYXNlcy4NCkRvbmUuDQoNCj5JZiB0aGUg
ZHJpdmVyICd3b3JrcycgaW4gY3VycmVudCBmb3JtIHdpdGhvdXQgc2V0dGluZyB0aGlzIHN0dWZm
IHVwIEkgd291bGQNCj5wcmVmZXIgdGhhdCB5b3UgbGVhdmUgdGhpcyB1bnRpbCB5b3UgaGF2ZSBh
IHBhdGNoIGFjdHVhbGx5IHVzaW5nIHRoZSBHUElPIHNpZ25hbHMuDQo+VGhhdCB3YXkgd2UgY2Fu
IHJldmlldyBhbGwgdGhlIEdQSU8gcmVsYXRlZCBjb2RlIHRvZ2V0aGVyLg0KQXMgc3RhdGVkIGFi
b3ZlLCBJIGhhdmUgZHJvcHBlZCB0aGUgR1BJT3MgYWx0b2dldGhlciBmb3Igbm93IGFuZCB3aWxs
IG1ha2UgYSBwYXRjaCBpbiBmdXR1cmUNCmZvciB5b3UgdG8gcmV2aWV3IGl0LiANCg0KPlRoZSBl
eHByZXNzaXZlIG5hdHVyZSBvZiB0aGUgZmllbGQgZGVmaW5lIG1ha2VzIGl0IG9idmlvdXMgdGhp
cyBpcyBhIHJlc2V0Lg0KPnNvIEkgd291bGQgZHJvcCB0aGUgY29tbWVudC4NCkRvbmUuDQoNCj5t
b2R1bGVfaTJjX2RyaXZlcigpIHRvIGdldCByaWQgb2YgdGhpcyBib2lsZXJwbGF0ZS4NCkRvbmUu
DQoNClNlbmRpbmcgdjcgaW5jb3Jwb3JhdGluZyBhbGwgY29tbWVudHMuIFBsZWFzZSByZXZpZXcu
DQoNClRoYW5rcw0KUmFqYXQNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEpv
bmF0aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5vcmc+IA0KU2VudDogU2F0dXJkYXksIE9jdG9i
ZXIgMjksIDIwMjIgODozNCBQTQ0KVG86IFJhamF0IEtoYW5kZWx3YWwgPHJhamF0LmtoYW5kZWx3
YWxAbGludXguaW50ZWwuY29tPg0KQ2M6IGxhcnNAbWV0YWZvby5kZTsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtaWlvQHZnZXIua2VybmVsLm9yZzsgamRlbHZhcmVAc3VzZS5j
b207IGxpbnV4QHJvZWNrLXVzLm5ldDsgbGludXgtaHdtb25Admdlci5rZXJuZWwub3JnOyBLaGFu
ZGVsd2FsLCBSYWphdCA8cmFqYXQua2hhbmRlbHdhbEBpbnRlbC5jb20+DQpTdWJqZWN0OiBSZTog
W1BBVENIIHY2XSBpaW86IHRlbXBlcmF0dXJlOiBBZGQgZHJpdmVyIHN1cHBvcnQgZm9yIE1heGlt
IE1BWDMwMjA4DQoNCk9uIFR1ZSwgMjUgT2N0IDIwMjIgMjI6NDg6NTggKzA1MzANClJhamF0IEto
YW5kZWx3YWwgPHJhamF0LmtoYW5kZWx3YWxAbGludXguaW50ZWwuY29tPiB3cm90ZToNCg0KPiBN
YXhpbSBNQVgzMDIwOCBpcyBhIGRpZ2l0YWwgdGVtcGVyYXR1cmUgc2Vuc29yIHdpdGggMC4xwrBD
IGFjY3VyYWN5Lg0KPiANCj4gQWRkIHN1cHBvcnQgZm9yIG1heDMwMjA4IGRyaXZlciBpbiBpaW8g
c3Vic3lzdGVtLg0KPiBEYXRhc2hlZXQ6IGh0dHBzOi8vZGF0YXNoZWV0cy5tYXhpbWludGVncmF0
ZWQuY29tL2VuL2RzL01BWDMwMjA4LnBkZg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUmFqYXQgS2hh
bmRlbHdhbCA8cmFqYXQua2hhbmRlbHdhbEBsaW51eC5pbnRlbC5jb20+DQoNCkhpIFJhamF0LA0K
DQpDb25zaWRlciB1c2luZyByZWdtYXAgZm9yIHRoaXMuIEl0IHdpbGwgcHJvdmlkZSB5b3Ugd2l0
aCBzb21lIGhlbHBmdWwgdXRpbGl0eSBmdW5jdGlvbnMuICBJIGRvbid0IG1pbmQgeW91IHN0aWNr
aW5nIHRvIGRpcmVjdCBpMmMgY2FsbHMgdGhvdWdoIGlmIHlvdSBwcmVmZXIuDQoNClF1aXRlIGEg
ZmV3IHRoaW5ncyBpbmxpbmUgdGhhdCBoYXZlIGJlZW4gY29tbWVudGVkIG9uIGluIHByZXZpb3Vz
IHJldmlld3MuDQpNYWtlIHN1cmUgeW91IGluY29ycG9yYXRlIGFsbCBmZWVkYmFjayBvciB5b3Un
bGwgZW5kIHVwIGdvaW5nIHRocm91Z2ggbW9yZSB2ZXJzaW9ucyB0aGFuIHdvdWxkIG90aGVyd2lz
ZSBiZSBuZWNlc3NhcnkuDQoNCkpvbmF0aGFuDQoNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlv
L3RlbXBlcmF0dXJlL01ha2VmaWxlIA0KPiBiL2RyaXZlcnMvaWlvL3RlbXBlcmF0dXJlL01ha2Vm
aWxlDQo+IGluZGV4IGRkMDhlNTYyZmZlMC4uZGZlYzhjNmQzMDE5IDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2lpby90ZW1wZXJhdHVyZS9NYWtlZmlsZQ0KPiArKysgYi9kcml2ZXJzL2lpby90ZW1w
ZXJhdHVyZS9NYWtlZmlsZQ0KPiBAQCAtNyw2ICs3LDcgQEAgb2JqLSQoQ09ORklHX0lRUzYyMEFU
X1RFTVApICs9IGlxczYyMGF0LXRlbXAubw0KPiAgb2JqLSQoQ09ORklHX0xUQzI5ODMpICs9IGx0
YzI5ODMubw0KPiAgb2JqLSQoQ09ORklHX0hJRF9TRU5TT1JfVEVNUCkgKz0gaGlkLXNlbnNvci10
ZW1wZXJhdHVyZS5vDQo+ICBvYmotJChDT05GSUdfTUFYSU1fVEhFUk1PQ09VUExFKSArPSBtYXhp
bV90aGVybW9jb3VwbGUubw0KPiArb2JqLSQoQ09ORklHX01BWDMwMjA4KSArPSBtYXgzMDIwOC5v
DQo+ICBvYmotJChDT05GSUdfTUFYMzE4NTYpICs9IG1heDMxODU2Lm8NCj4gIG9iai0kKENPTkZJ
R19NQVgzMTg2NSkgKz0gbWF4MzE4NjUubw0KPiAgb2JqLSQoQ09ORklHX01MWDkwNjE0KSArPSBt
bHg5MDYxNC5vDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby90ZW1wZXJhdHVyZS9tYXgzMDIw
OC5jIA0KPiBiL2RyaXZlcnMvaWlvL3RlbXBlcmF0dXJlL21heDMwMjA4LmMNCj4gbmV3IGZpbGUg
bW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMDAwMDAwLi40MWIyNjc1NWNlMjcNCj4gLS0tIC9k
ZXYvbnVsbA0KPiArKysgYi9kcml2ZXJzL2lpby90ZW1wZXJhdHVyZS9tYXgzMDIwOC5jDQo+IEBA
IC0wLDAgKzEsMzIzIEBADQo+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1v
bmx5DQo+ICsNCj4gKy8qDQo+ICsgKiBDb3B5cmlnaHQgKGMpIFJhamF0IEtoYW5kZWx3YWwgPHJh
amF0LmtoYW5kZWx3YWxAbGludXguaW50ZWwuY29tPg0KPiArICoNCj4gKyAqIE1heGltIE1BWDMw
MjA4IGRpZ2l0YWwgdGVtcGVyYXR1cmUgc2Vuc29yIHdpdGggMC4xwrBDIGFjY3VyYWN5DQo+ICsg
KiAoNy1iaXQgSTJDIHNsYXZlIGFkZHJlc3MgKDB4NTAgLSAweDUzKSkNCj4gKyAqDQo+ICsgKiBO
b3RlOiBUaGlzIGRyaXZlciBzZXRzIEdQSU8xIHRvIGJlaGF2ZSBhcyBpbnB1dCBmb3IgdGVtcGVy
YXR1cmUNCj4gKyAqIGNvbnZlcnNpb24gYW5kIEdQSU8wIHRvIGFjdCBhcyBpbnRlcnJ1cHQgZm9y
IHRlbXBlcmF0dXJlIGNvbnZlcnNpb24uDQoNCkl0IGRvZXNuJ3QgdXNlIHRoZW0sIHNvIHVubGVz
cyB5b3UgaGF2ZSB0byBiZSBpbiB0aGF0IHN0YXRlIHRvIHVzZSB0aGUgY3VycmVudCBtZXRob2Qs
IGRyb3AgdGhlIG5vdGUgYW5kIGRvbid0IHNldCB0aGVtIHRvIGRvIHRoYXQuDQoNCllvdSBjYW4g
YWRkIHRoYXQgc3VwcG9ydCBpZiAvIHdoZW4gdGhlIGRyaXZlciBzdXBwb3J0cyBpdC4NCg0KPiAr
ICovDQo+ICsNCj4gKyNpbmNsdWRlIDxsaW51eC9iaXRvcHMuaD4NCj4gKyNpbmNsdWRlIDxsaW51
eC9kZWxheS5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L2lpby9paW8uaD4NCj4gKyNpbmNsdWRlIDxs
aW51eC9pMmMuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4gKyNpbmNsdWRlIDxs
aW51eC90eXBlcy5oPg0KPiArDQo+ICsjZGVmaW5lIE1BWDMwMjA4X0RSVl9OQU1FCQkibWF4MzAy
MDgiDQoNCk1lbnRpb25lZCBiZWxvdywgYnV0IEknZCBwcmVmZXIgdG8gc2VlIHRoZSBzdHJpbmcg
ZGlyZWN0bHkgaW5saW5lLg0KDQo+ICsNCj4gKyNkZWZpbmUgTUFYMzAyMDhfU1RBVFVTCQkJMHgw
MA0KPiArI2RlZmluZSBNQVgzMDIwOF9TVEFUVVNfVEVNUF9SRFkJQklUKDApDQo+ICsjZGVmaW5l
IE1BWDMwMjA4X0lOVF9FTkFCTEUJCTB4MDENCj4gKyNkZWZpbmUgTUFYMzAyMDhfSU5UX0VOQUJM
RV9URU1QX1JEWQlCSVQoMCkNCj4gKw0KPiArI2RlZmluZSBNQVgzMDIwOF9GSUZPX09WRl9DTlRS
CQkweDA2DQo+ICsjZGVmaW5lIE1BWDMwMjA4X0ZJRk9fREFUQV9DTlRSCQkweDA3DQo+ICsjZGVm
aW5lIE1BWDMwMjA4X0ZJRk9fREFUQQkJMHgwOA0KPiArDQo+ICsjZGVmaW5lIE1BWDMwMjA4X1NZ
U1RFTV9DVFJMCQkweDBjDQo+ICsjZGVmaW5lIE1BWDMwMjA4X1NZU1RFTV9DVFJMX1JFU0VUCTB4
MDENCj4gKw0KPiArI2RlZmluZSBNQVgzMDIwOF9URU1QX1NFTlNPUl9TRVRVUAkweDE0DQo+ICsj
ZGVmaW5lIE1BWDMwMjA4X1RFTVBfU0VOU09SX1NFVFVQX0NPTlYJQklUKDApDQo+ICsNCj4gKyNk
ZWZpbmUgTUFYMzAyMDhfR1BJT19TRVRVUAkJMHgyMA0KPiArI2RlZmluZSBNQVgzMDIwOF9HUElP
MV9TRVRVUAkJR0VOTUFTSyg3LCA2KQ0KPiArI2RlZmluZSBNQVgzMDIwOF9HUElPMF9TRVRVUAkJ
R0VOTUFTSygxLCAwKQ0KPiArI2RlZmluZSBNQVgzMDIwOF9HUElPX0NUUkwJCTB4MjENCj4gKyNk
ZWZpbmUgTUFYMzAyMDhfR1BJTzFfQ1RSTAkJQklUKDMpDQo+ICsjZGVmaW5lIE1BWDMwMjA4X0dQ
SU8wX0NUUkwJCUJJVCgwKQ0KPiArDQo+ICtzdHJ1Y3QgbWF4MzAyMDhfZGF0YSB7DQo+ICsJc3Ry
dWN0IGkyY19jbGllbnQgKmNsaWVudDsNCj4gKwlzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2Ow0K
PiArCXN0cnVjdCBtdXRleCBsb2NrOyAvKiBMb2NrIHRvIHByZXZlbnQgY29uY3VycmVudCByZWFk
cyAqLw0KDQpCZSBtb3JlIGV4cGxpY2l0IC0gcmVhZHMgb2Ygd2hhdD8NCg0KPiArfTsNCj4gKw0K
PiArc3RhdGljIGNvbnN0IHN0cnVjdCBpaW9fY2hhbl9zcGVjIG1heDMwMjA4X2NoYW5uZWxzW10g
PSB7DQo+ICsJew0KPiArCQkudHlwZSA9IElJT19URU1QLA0KPiArCQkuaW5mb19tYXNrX3NlcGFy
YXRlID0gQklUKElJT19DSEFOX0lORk9fUkFXKSB8IEJJVChJSU9fQ0hBTl9JTkZPX1NDQUxFKSwN
Cj4gKwl9LA0KPiArfTsNCj4gKw0KPiArLyoqDQo+ICsgKiBtYXgzMDIwOF9yZXF1ZXN0KCkgLSBS
ZXF1ZXN0IGEgcmVhZGluZw0KPiArICogQGRhdGE6IFN0cnVjdCBjb21wcmlzaW5nIG1lbWJlciBl
bGVtZW50cyBvZiB0aGUgZGV2aWNlDQo+ICsgKg0KPiArICogUmVxdWVzdHMgYSByZWFkaW5nIGZy
b20gdGhlIGRldmljZSBhbmQgd2FpdHMgdW50aWwgdGhlIGNvbnZlcnNpb24gaXMgcmVhZHkuDQo+
ICsgKi8NCj4gK3N0YXRpYyBpbnQgbWF4MzAyMDhfcmVxdWVzdChzdHJ1Y3QgbWF4MzAyMDhfZGF0
YSAqZGF0YSkgew0KPiArCS8qDQo+ICsJICogU2Vuc29yIGNhbiB0YWtlIHVwIHRvIDUwMCBtcyB0
byByZXNwb25kIHNvIGV4ZWN1dGUgYSB0b3RhbCBvZg0KPiArCSAqIDEwIHJldHJpZXMgdG8gZ2l2
ZSB0aGUgZGV2aWNlIHN1ZmZpY2llbnQgdGltZS4NCj4gKwkgKi8NCj4gKwlpbnQgcmV0cmllcyA9
IDEwOw0KPiArCXU4IHJlZ3ZhbDsNCj4gKwlpbnQgcmV0Ow0KPiArDQo+ICsJcmV0ID0gaTJjX3Nt
YnVzX3JlYWRfYnl0ZV9kYXRhKGRhdGEtPmNsaWVudCwgTUFYMzAyMDhfVEVNUF9TRU5TT1JfU0VU
VVApOw0KPiArCWlmIChyZXQgPCAwKSB7DQo+ICsJCWRldl9lcnIoJmRhdGEtPmNsaWVudC0+ZGV2
LCAiRXJyb3IgcmVhZGluZyByZWcgdGVtcGVyYXR1cmUgDQo+ICtzZXR1cFxuIik7DQoNCkkgYWdy
ZWUgd2l0aCBHdWVudGVyJ3MgY29tbWVudCB0aGF0IHRoaXMgaXMgYSBiaXQgb3Zlcmx5IG5vaXN5
LiBXZSBkb24ndCBleHBlY3QgcmFuZG9tIHJlZ2lzdGVyIHJlYWRzIHRvIGZhaWwgKyBJSVJDIHRo
ZXJlIGlzIHRyYWNpbmcgaW4gdGhlIGkyYyBzdWJzeXN0ZW0gaWYgd2UNCmFyZSBnZXR0aW5nIHN1
Y2ggZXJyb3JzLiAgIEhlbmNlIHByb2JhYmx5IHJlZHVjZSB0aGUgZXJyb3IgdG8gY292ZXIgb25s
eSBsYXJnZXINCmJsb2NrcyBvZiBjb2RlLiAgUmVhc29uYWJsZSB0byByZXBvcnQgdGhhdCB0aGUg
dGVtcGVyYXR1cmUgcmVxdWVzdCBmYWlsZWQgcGVyaGFwcy4NCg0KDQo+ICsJCXJldHVybiByZXQ7
DQo+ICsJfQ0KPiArDQo+ICsJcmVndmFsID0gcmV0IHwgTUFYMzAyMDhfVEVNUF9TRU5TT1JfU0VU
VVBfQ09OVjsNCj4gKw0KPiArCXJldCA9IGkyY19zbWJ1c193cml0ZV9ieXRlX2RhdGEoZGF0YS0+
Y2xpZW50LCBNQVgzMDIwOF9URU1QX1NFTlNPUl9TRVRVUCwgcmVndmFsKTsNCj4gKwlpZiAocmV0
IDwgMCkgew0KPiArCQlkZXZfZXJyKCZkYXRhLT5jbGllbnQtPmRldiwgIkVycm9yIHdyaXRpbmcg
cmVnIHRlbXBlcmF0dXJlIHNldHVwXG4iKTsNCj4gKwkJcmV0dXJuIHJldDsNCj4gKwl9DQo+ICsN
Cj4gKwl3aGlsZSAocmV0cmllcy0tKSB7DQo+ICsJCXJldCA9IGkyY19zbWJ1c19yZWFkX2J5dGVf
ZGF0YShkYXRhLT5jbGllbnQsIE1BWDMwMjA4X1NUQVRVUyk7DQo+ICsJCWlmIChyZXQgPCAwKSB7
DQo+ICsJCQlkZXZfZXJyKCZkYXRhLT5jbGllbnQtPmRldiwgIkVycm9yIHJlYWRpbmcgcmVnIHN0
YXR1c1xuIik7DQo+ICsJCQlnb3RvIHNsZWVwOw0KDQpDYW4gdGhpcyBoYXBwZW4gZm9yIGEgZG9j
dW1lbnRlZCByZWFzb24/ICBJZiBub3QgdHJlYXQgaXQgYXMgYSBjb21tcyBlcnJvciBhbmQgcmV0
dXJuIGl0Lg0KDQo+ICsJCX0NCj4gKw0KPiArCQlpZiAocmV0ICYgTUFYMzAyMDhfU1RBVFVTX1RF
TVBfUkRZKQ0KPiArCQkJcmV0dXJuIDA7DQo+ICsNCj4gKwkJbXNsZWVwKDUwKTsNCj4gKwl9DQo+
ICsJZGV2X3dhcm4oJmRhdGEtPmNsaWVudC0+ZGV2LCAiVGVtcGVyYXR1cmUgY29udmVyc2lvbiBm
YWlsZWRcbiIpOw0KDQpkZXZfZXJyKCkgIEZhaWxpbmcgaXNuJ3QgZXhwZWN0ZWQgc28gaXQncyBh
IGRldmljZSBlcnJvciBub3Qgc29tZXRoaW5nIHdlIHNob3VsZCBtZXJlbHkgd2FybiBhYm91dC4N
Cg0KPiArDQo+ICsJcmV0dXJuIDA7DQpFcnJvciByZXR1cm4gdG8gaW5kaWNhdGUgd2hhdCBoYXBw
ZW5lZCAtIHRoZXJlIGlzIG9uZSBmb3IgdGltZW91dHMuDQoNCj4gKw0KPiArc2xlZXA6DQoNCldo
eSBzbGVlcCBpbiBhbiBlcnJvciBwYXRoPyAgSXQncyBmYWlsZWQgLSB3aHkgZG8gd2UgdGhpbmsg
c2xlZXBpbmcgaXMgYSBnb29kIGlkZWE/DQoNCj4gKwltc2xlZXAoNTApOw0KPiArCXJldHVybiAw
Ow0KPiArfQ0KPiArDQo+ICtzdGF0aWMgaW50IG1heDMwMjA4X3VwZGF0ZV90ZW1wKHN0cnVjdCBt
YXgzMDIwOF9kYXRhICpkYXRhKSB7DQo+ICsJdTggZGF0YV9jb3VudDsNCj4gKwlpbnQgcmV0Ow0K
PiArDQo+ICsJbXV0ZXhfbG9jaygmZGF0YS0+bG9jayk7DQo+ICsNCj4gKwlyZXQgPSBtYXgzMDIw
OF9yZXF1ZXN0KGRhdGEpOw0KPiArCWlmIChyZXQgPCAwKQ0KPiArCQlnb3RvIHVubG9jazsNCj4g
Kw0KPiArCXJldCA9IGkyY19zbWJ1c19yZWFkX2J5dGVfZGF0YShkYXRhLT5jbGllbnQsIA0KPiAr
TUFYMzAyMDhfRklGT19PVkZfQ05UUik7DQpXaGlsc3QgeW91IGRlYmF0ZWQgdGhpcyBsb2dpYyB3
aXRoIEd1ZW50ZXIgaW4gdjUsIEkgZG9uJ3QgZm9sbG93IHRoZSBjb25jbHVzaW9uLg0KSWYgRklG
T19PVkZfQ05UUiA+IDAgdGhlbiBGSUZPX0RBVEFfQ05UUiA9PSBtYXhpbXVtIHZhbHVlLiAgTG9n
aWMgb2YgdGhpcyBpcyBnaXZlbiBpbiBGSUZPX0RBVEEgUmVhZCBFeGFtcGxlIChQYWdlIDE2IG9m
IHRoZSBzcGVjKSAgSXQgZG9lc24ndCBtYXR0ZXIgYXMgc3VjaCBiZWNhdXNlIHlvdSByZWFkIEZJ
Rk9fREFUQV9DTlRSIGFnYWluIGFueXdheSwgYnV0IGl0IHdvdWxkIGJlIG1vcmUgb2J2aW91cyB3
aGF0IGlzIGdvaW5nIG9uIGlmIHlvdSBqdXN0IHNldCBkYXRhX2NvdW50ID0gMzIgaWYgb3ZlcmZs
b3cgaGFzIG9jY3VyZWQuDQoNClRoZSBvbmx5IHRoaW5nIEkgd291bGQgYXJndWUgeW91ICdtaWdo
dCcgd2FudCB0byBkbyB3aXRoIHRoZSBvdmVyZmxvdyBjb3VudGVyIGlzIHRvIHVzZSBpdCB0byBp
bmRpY2F0ZSB3ZSBuZWVkIHRvIHJlYWQgYXQgbGVhc3QgdGhlIG51bWJlciBvZiBlbGVtZW50cyBp
biB0aGUgZmlmby4NCklmIHRoZXJlIGFyZSBubyBhZGRpdGlvbmFsIGVsZW1lbnRzIGF0IHRoZSBl
bmQsIHdhaXQgdW50aWwgdGhlcmUgaXMgb25lLiBPdGhlcndpc2UgeW91IHBvdGVudGlhbGx5IGdl
dCB2ZXJ5IHN0YWxlIGRhdGEgLSBpdCBtaWdodCBoYXZlIGJlZW4gb3ZlcmZsb3dpbmcgZm9yIGEg
bG9uZyB0aW1lKQ0KDQo+ICsJaWYgKHJldCA8IDApIHsNCj4gKwkJZGV2X2VycigmZGF0YS0+Y2xp
ZW50LT5kZXYsICJFcnJvciByZWFkaW5nIHJlZyBGSUZPIG92ZXJmbG93IGNvdW50ZXJcbiIpOw0K
PiArCQlnb3RvIHVubG9jazsNCj4gKwl9IGVsc2UgaWYgKCFyZXQpIHsNCj4gKwkJcmV0ID0gaTJj
X3NtYnVzX3JlYWRfYnl0ZV9kYXRhKGRhdGEtPmNsaWVudCwNCj4gKwkJCQkJICAgICAgIE1BWDMw
MjA4X0ZJRk9fREFUQV9DTlRSKTsNCj4gKwkJaWYgKHJldCA8IDApIHsNCj4gKwkJCWRldl9lcnIo
JmRhdGEtPmNsaWVudC0+ZGV2LCAiRXJyb3IgcmVhZGluZyByZWcgRklGTyBkYXRhIGNvdW50ZXJc
biIpOw0KPiArCQkJZ290byB1bmxvY2s7DQo+ICsJCX0NCj4gKwl9DQo+ICsNCj4gKwlkYXRhX2Nv
dW50ID0gcmV0Ow0KPiArDQo+ICsJLyoNCj4gKwkgKiBJZGVhbGx5LCBjb3VudGVyIHNob3VsZCBk
ZWNyZWFzZSBieSAxIGVhY2ggdGltZSBhIHdvcmQgaXMgcmVhZCBmcm9tIEZJRk8uDQo+ICsJICog
SG93ZXZlciwgcHJhY3RpY2FsbHksIHRoZSBkZXZpY2UgYmVoYXZlcyBlcnJvbmVvdXNseSBhbmQg
Y291bnRlciBzb21ldGltZXMNCj4gKwkgKiBkZWNyZWFzZXMgYnkgbW9yZSB0aGFuIDEuIEhlbmNl
LCBkbyBub3QgbG9vcCB0aGUgY291bnRlciB1bnRpbCBpdCBiZWNvbWVzIDANCj4gKwkgKiByYXRo
ZXIsIHVzZSB0aGUgZXhhY3QgY291bnRlciB2YWx1ZSBhZnRlciBlYWNoIEZJRk8gd29yZCBpcyBy
ZWFkLg0KDQpUaGlzIGRlY3JlYXNlIGJ5IG1vcmUgdGhhbiAxIGlzIHdvcnJ5aW5nLiAgSSBjYW4g
dW5kZXJzdGFuZCBpdCBub3QgZGVjcmVhc2luZywgb3IgZXZlbiBpbmNyZWFzaW5nIChuZXcgZGF0
YSBjYW1lIGluKSwgYnV0IHRoaXMgY29uZGl0aW9uIHNvdW5kcyBlaXRoZXIgbGlrZSB3ZSBhcmUg
ZG9pbmcgc29tZXRoaW5nIHdyb25nIG9yIHRoZXJlIGlzIGEgaGFyZHdhcmUgYnVnLg0KDQo+ICsJ
ICogUmV0dXJuIHRoZSBsYXN0IHJlYWRpbmcgZnJvbSBGSUZPIGFzIHRoZSBtb3N0IHJlY2VudGx5
IHRyaWdnZXJlZCANCj4gK29uZQ0KDQpOb3QgbmVjZXNzYXJpbHkgcmVjZW50IChldmVuIGlmIG1v
c3QgcmVjZW50IGF2YWlsYWJsZSkuIEltYWdpbmUgdGhpcyBydW5zIGFmdGVyIG92ZXJmbG93IGFu
ZCBydW5zIHJlYWxseSBxdWlja2x5Lg0KWW91IG1heSBub3QgZ2V0IGEgbmV3IHJlYWRpbmcuDQoN
Cj4gKwkgKi8NCj4gKwl3aGlsZSAoZGF0YV9jb3VudCkgew0KPiArCQlyZXQgPSBpMmNfc21idXNf
cmVhZF93b3JkX3N3YXBwZWQoZGF0YS0+Y2xpZW50LA0KPiArCQkJCQkJICBNQVgzMDIwOF9GSUZP
X0RBVEEpOw0KPiArCQlpZiAocmV0IDwgMCkgew0KPiArCQkJZGV2X2VycigmZGF0YS0+Y2xpZW50
LT5kZXYsICJFcnJvciByZWFkaW5nIHJlZyBGSUZPIGRhdGFcbiIpOw0KPiArCQkJZ290byB1bmxv
Y2s7DQo+ICsJCX0NCj4gKw0KPiArCQlkYXRhX2NvdW50ID0gaTJjX3NtYnVzX3JlYWRfYnl0ZV9k
YXRhKGRhdGEtPmNsaWVudCwNCj4gKwkJCQkJCSAgICAgIE1BWDMwMjA4X0ZJRk9fREFUQV9DTlRS
KTsNCj4gKwkJaWYgKGRhdGFfY291bnQgPCAwKSB7DQo+ICsJCQlkZXZfZXJyKCZkYXRhLT5jbGll
bnQtPmRldiwgIkVycm9yIHJlYWRpbmcgcmVnIEZJRk8gZGF0YSBjb3VudGVyXG4iKTsNCj4gKwkJ
CXJldCA9IGRhdGFfY291bnQ7DQoNCkZsaXAgdGhpcyBhcm91bmQgc28geW91IGNvbnNpc3RlbnRs
eSB1c2UgcmV0IGZvciByZXR1cm4gdmFsdWVzLiAgV2Ugc3RpbGwgaGF2ZSBwcm9ibGVtIHRoYXQg
ZGF0YV9jb3VudCBpcyBhIHU4IHNvIHRoZSBhYm92ZSB0ZXN0IGlzIGludmFsaWQuDQoNCgkJcmV0
ID0gaTJjX3NtYnVzX3JlYWRfYnl0ZV9kYXRhKGRhdGEtPmNsaWVudCwgLi4uKQ0KCQlpZiAocmV0
IDwgMCkgew0KCQkJZGV2X2VyciguLik7DQoJCQlnb3RvIHVubG9jaw0KCQl9DQoJCWRhdGFfY291
bnQgPSByZXQ7DQoNCkd1ZW50ZXIgcG9pbnRlZCB0aGlzIG91dCBpbiB2NS4NCg0KPiArCQkJZ290
byB1bmxvY2s7DQo+ICsJCX0NCj4gKwl9DQo+ICsNCj4gK3VubG9jazoNCj4gKwltdXRleF91bmxv
Y2soJmRhdGEtPmxvY2spOw0KPiArCXJldHVybiByZXQ7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBp
bnQgbWF4MzAyMDhfcmVhZChzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2LA0KPiArCQkJIHN0cnVj
dCBpaW9fY2hhbl9zcGVjIGNvbnN0ICpjaGFuLA0KPiArCQkJIGludCAqdmFsLCBpbnQgKnZhbDIs
IGxvbmcgbWFzaykNCj4gK3sNCj4gKwlzdHJ1Y3QgbWF4MzAyMDhfZGF0YSAqZGF0YSA9IGlpb19w
cml2KGluZGlvX2Rldik7DQo+ICsJaW50IHJldDsNCj4gKw0KPiArCXN3aXRjaCAobWFzaykgew0K
PiArCWNhc2UgSUlPX0NIQU5fSU5GT19SQVc6DQo+ICsJCXJldCA9IG1heDMwMjA4X3VwZGF0ZV90
ZW1wKGRhdGEpOw0KPiArCQlpZiAocmV0IDwgMCkNCj4gKwkJCXJldHVybiByZXQ7DQo+ICsNCj4g
KwkJKnZhbCA9IHNpZ25fZXh0ZW5kMzIocmV0LCAxNSk7DQo+ICsJCXJldHVybiBJSU9fVkFMX0lO
VDsNCj4gKw0KPiArCWNhc2UgSUlPX0NIQU5fSU5GT19TQ0FMRToNCj4gKwkJKnZhbCA9IDU7DQo+
ICsJCXJldHVybiBJSU9fVkFMX0lOVDsNCj4gKw0KPiArCWRlZmF1bHQ6DQo+ICsJCXJldHVybiAt
RUlOVkFMOw0KPiArCX0NCj4gK30NCj4gKw0KPiArc3RhdGljIGludCBtYXgzMDIwOF9ncGlvX3Nl
dHVwKHN0cnVjdCBtYXgzMDIwOF9kYXRhICpkYXRhKSB7DQo+ICsJdTggcmVndmFsOw0KPiArCWlu
dCByZXQ7DQo+ICsNCj4gKwlyZXQgPSBpMmNfc21idXNfcmVhZF9ieXRlX2RhdGEoZGF0YS0+Y2xp
ZW50LA0KPiArCQkJCSAgICAgICBNQVgzMDIwOF9HUElPX1NFVFVQKTsNCg0KRXhjZXNzaXZlIGxp
bmUgYnJlYWtzLiAgVGhpcyBpcyB1bmRlciA4MCBjaGFycy4gIEluIGNhc2VzIHdoZXJlIHJlYWRh
YmlsaXR5IGlzIGhlbHBlZCBieSBnb2luZyBhYm92ZSB0aGF0ICh0aG91Z2ggdW5kZXIgMTAwIGNo
YXJzKSB0aGF0IGlzIGZpbmUgdG9vLiAgTWFrZSBzdXJlIHlvdSB0aWR5IHVwIGFsbCBzaW1pbGFy
IGNhc2VzLg0KDQo+ICsJaWYgKHJldCA8IDApIHsNCj4gKwkJZGV2X2VycigmZGF0YS0+Y2xpZW50
LT5kZXYsICJFcnJvciByZWFkaW5nIHJlZyBHUElPIHNldHVwXG4iKTsNCj4gKwkJcmV0dXJuIHJl
dDsNCj4gKwl9DQo+ICsNCj4gKwkvKg0KPiArCSAqIFNldHRpbmcgR1BJTzEgdG8gdHJpZ2dlciB0
ZW1wZXJhdHVyZSBjb252ZXJzaW9uDQo+ICsJICogd2hlbiBkcml2ZW4gbG93Lg0KPiArCSAqIFNl
dHRpbmcgR1BJTzAgdG8gdHJpZ2dlciBpbnRlcnJ1cHQgd2hlbiB0ZW1wZXJhdHVyZQ0KPiArCSAq
IGNvbnZlcnNpb24gZ2V0cyBjb21wbGV0ZWQuDQo+ICsJICovDQo+ICsJcmVndmFsID0gcmV0IHwg
TUFYMzAyMDhfR1BJTzFfU0VUVVAgfCBNQVgzMDIwOF9HUElPMF9TRVRVUDsNCg0KSWYgdGhlIGRy
aXZlciAnd29ya3MnIGluIGN1cnJlbnQgZm9ybSB3aXRob3V0IHNldHRpbmcgdGhpcyBzdHVmZiB1
cCBJIHdvdWxkIHByZWZlciB0aGF0IHlvdSBsZWF2ZSB0aGlzIHVudGlsIHlvdSBoYXZlIGEgcGF0
Y2ggYWN0dWFsbHkgdXNpbmcgdGhlIEdQSU8gc2lnbmFscy4NClRoYXQgd2F5IHdlIGNhbiByZXZp
ZXcgYWxsIHRoZSBHUElPIHJlbGF0ZWQgY29kZSB0b2dldGhlci4NCg0KPiArCXJldCA9IGkyY19z
bWJ1c193cml0ZV9ieXRlX2RhdGEoZGF0YS0+Y2xpZW50LA0KPiArCQkJCQlNQVgzMDIwOF9HUElP
X1NFVFVQLCByZWd2YWwpOw0KPiArCWlmIChyZXQgPCAwKSB7DQo+ICsJCWRldl9lcnIoJmRhdGEt
PmNsaWVudC0+ZGV2LCAiRXJyb3Igd3JpdGluZyByZWcgR1BJTyBzZXR1cFxuIik7DQo+ICsJCXJl
dHVybiByZXQ7DQo+ICsJfQ0KPiArDQo+ICsJcmV0ID0gaTJjX3NtYnVzX3JlYWRfYnl0ZV9kYXRh
KGRhdGEtPmNsaWVudCwNCj4gKwkJCQkgICAgICAgTUFYMzAyMDhfSU5UX0VOQUJMRSk7DQo+ICsJ
aWYgKHJldCA8IDApIHsNCj4gKwkJZGV2X2VycigmZGF0YS0+Y2xpZW50LT5kZXYsICJFcnJvciBy
ZWFkaW5nIHJlZyBpbnRlcnJ1cHQgZW5hYmxlXG4iKTsNCj4gKwkJcmV0dXJuIHJldDsNCj4gKwl9
DQo+ICsNCj4gKwkvKiBFbmFibGluZyBHUElPMCBpbnRlcnJ1cHQgKi8NCj4gKwlyZWd2YWwgPSBy
ZXQgfCBNQVgzMDIwOF9JTlRfRU5BQkxFX1RFTVBfUkRZOw0KDQpUaGlzIGJlbG9uZ3MgaW4gYSBw
YXRjaCBhZGRpbmcgaW50ZXJydXB0IHN1cHBvcnQuIEl0IHNob3VsZCBub3QgYmUgaGVyZSB1bnRp
bCB0aGVuLg0KDQo+ICsJcmV0ID0gaTJjX3NtYnVzX3dyaXRlX2J5dGVfZGF0YShkYXRhLT5jbGll
bnQsDQo+ICsJCQkJCU1BWDMwMjA4X0lOVF9FTkFCTEUsIHJlZ3ZhbCk7DQo+ICsJaWYgKHJldCA8
IDApIHsNCj4gKwkJZGV2X2VycigmZGF0YS0+Y2xpZW50LT5kZXYsICJFcnJvciB3cml0aW5nIHJl
ZyBpbnRlcnJ1cHQgZW5hYmxlXG4iKTsNCj4gKwkJcmV0dXJuIHJldDsNCj4gKwl9DQo+ICsNCj4g
KwlyZXR1cm4gMDsNCj4gK30NCj4gKw0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBpaW9faW5mbyBt
YXgzMDIwOF9pbmZvID0gew0KPiArCS5yZWFkX3JhdyA9IG1heDMwMjA4X3JlYWQsDQo+ICt9Ow0K
PiArDQo+ICtzdGF0aWMgaW50IG1heDMwMjA4X3Byb2JlKHN0cnVjdCBpMmNfY2xpZW50ICppMmMp
IHsNCj4gKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmaTJjLT5kZXY7DQo+ICsJc3RydWN0IG1heDMw
MjA4X2RhdGEgKmRhdGE7DQo+ICsJc3RydWN0IGlpb19kZXYgKmluZGlvX2RldjsNCj4gKwlpbnQg
cmV0Ow0KPiArDQo+ICsJaW5kaW9fZGV2ID0gZGV2bV9paW9fZGV2aWNlX2FsbG9jKGRldiwgc2l6
ZW9mKCpkYXRhKSk7DQo+ICsJaWYgKCFpbmRpb19kZXYpDQo+ICsJCXJldHVybiAtRU5PTUVNOw0K
PiArDQo+ICsJZGF0YSA9IGlpb19wcml2KGluZGlvX2Rldik7DQo+ICsJZGF0YS0+Y2xpZW50ID0g
aTJjOw0KPiArCW11dGV4X2luaXQoJmRhdGEtPmxvY2spOw0KPiArDQo+ICsJaW5kaW9fZGV2LT5u
YW1lID0gTUFYMzAyMDhfRFJWX05BTUU7DQoNCkknbSBub3QgYSBodWdlIGZhbiBvZiBkZWZpbmVz
IGVpdGhlciBoZXJlIG9yIGluIHRoZSBkcml2ZXIgc3RydWN0dXJlIGluaXRpYWxpemVyLg0KVGhl
IHJlYXNvbiBiZWluZyB0aGF0IHdlIG5lZWQgY2xlYXIgdmlzaWJpbGl0eSBvZiB0aGVzZSBzdHJp
bmdzIGFuZCB0aGVyZSBpcyBubyBwYXJ0aWN1bGFyIHJlYXNvbiB3aHkgdGhleSBhcmUgdGhlIHNh
bWUuDQpTbyBJJ2QgcHJlZmVyIGdldHRpbmcgcmlkIG9mIHRoYXQgZGVmaW5lIGFuZCBwdXR0aW5n
IHRoZSBzdHJpbmdzIGRpcmVjdGx5IGluIGJvdGggbG9jYXRpb25zLg0KDQo+ICsJaW5kaW9fZGV2
LT5jaGFubmVscyA9IG1heDMwMjA4X2NoYW5uZWxzOw0KPiArCWluZGlvX2Rldi0+bnVtX2NoYW5u
ZWxzID0gQVJSQVlfU0laRShtYXgzMDIwOF9jaGFubmVscyk7DQo+ICsJaW5kaW9fZGV2LT5pbmZv
ID0gJm1heDMwMjA4X2luZm87DQo+ICsJaW5kaW9fZGV2LT5tb2RlcyA9IElORElPX0RJUkVDVF9N
T0RFOw0KPiArDQo+ICsJLyogUmVzZXQgdGhlIGRldmljZSBpbml0aWFsbHkgKi8NCg0KVGhlIGV4
cHJlc3NpdmUgbmF0dXJlIG9mIHRoZSBmaWVsZCBkZWZpbmUgbWFrZXMgaXQgb2J2aW91cyB0aGlz
IGlzIGEgcmVzZXQuDQpzbyBJIHdvdWxkIGRyb3AgdGhlIGNvbW1lbnQuICBUaGVyZSBpcyBhIHBy
aWNlIGluIG1haW50YWluYWJpbGl0eSB0byBjb21tZW50cyAodGhleSBvZnRlbiBiZWNvbWUgd3Jv
bmcgb3ZlciB0aW1lIGFzIGEgZHJpdmVyIGV2b2x2ZXMpLiAgQXMgc3VjaCBrZWVwIHRoZW0gZm9y
IHBsYWNlcyB3aGVyZSB0aGUgY29tbWVudCB0ZWxscyB1cyBzb21ldGhpbmcgbm90IGVhc2lseSBz
ZWVuIGZyb20gdGhlIGNvZGUuDQoNCj4gKwlyZXQgPSBpMmNfc21idXNfd3JpdGVfYnl0ZV9kYXRh
KGRhdGEtPmNsaWVudCwgTUFYMzAyMDhfU1lTVEVNX0NUUkwsDQo+ICsJCQkJCU1BWDMwMjA4X1NZ
U1RFTV9DVFJMX1JFU0VUKTsNCj4gKwlpZiAocmV0KSB7DQo+ICsJCWRldl9lcnIoZGV2LCAiRmFp
bHVyZSBpbiBwZXJmb3JtaW5nIHJlc2V0XG4iKTsNCj4gKwkJcmV0dXJuIHJldDsNCj4gKwl9DQo+
ICsNCj4gKwltc2xlZXAoNTApOw0KPiArDQo+ICsJcmV0ID0gbWF4MzAyMDhfZ3Bpb19zZXR1cChk
YXRhKTsNCj4gKwlpZiAocmV0IDwgMCkNCj4gKwkJcmV0dXJuIHJldDsNCj4gKw0KPiArCXJldCA9
IGRldm1faWlvX2RldmljZV9yZWdpc3RlcihkZXYsIGluZGlvX2Rldik7DQo+ICsJaWYgKHJldCkg
ew0KPiArCQlkZXZfZXJyKGRldiwgIkZhaWxlZCB0byByZWdpc3RlciBJSU8gZGV2aWNlXG4iKTsN
Cj4gKwkJcmV0dXJuIHJldDsNCj4gKwl9DQo+ICsNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gKw0K
PiArc3RhdGljIGNvbnN0IHN0cnVjdCBpMmNfZGV2aWNlX2lkIG1heDMwMjA4X2lkX3RhYmxlW10g
PSB7DQo+ICsJeyAibWF4MzAyMDgiIH0sDQo+ICsJeyB9DQo+ICt9Ow0KPiArTU9EVUxFX0RFVklD
RV9UQUJMRShpMmMsIG1heDMwMjA4X2lkX3RhYmxlKTsNCj4gKw0KPiArc3RhdGljIGNvbnN0IHN0
cnVjdCBhY3BpX2RldmljZV9pZCBtYXgzMDIwOF9hY3BpX21hdGNoW10gPSB7DQo+ICsJeyAiTUFY
MzAyMDgiIH0sDQo+ICsJeyB9DQo+ICt9Ow0KPiArTU9EVUxFX0RFVklDRV9UQUJMRShhY3BpLCBt
YXgzMDIwOF9hY3BpX21hdGNoKTsNCj4gKw0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZp
Y2VfaWQgbWF4MzAyMDhfb2ZfbWF0Y2hbXSA9IHsNCj4gKwl7IC5jb21wYXRpYmxlID0gIm1heGlt
LG1heDMwMjA4IiB9LA0KPiArCXsgfQ0KPiArfTsNCj4gK01PRFVMRV9ERVZJQ0VfVEFCTEUob2Ys
IG1heDMwMjA4X29mX21hdGNoKTsNCj4gKw0KPiArc3RhdGljIHN0cnVjdCBpMmNfZHJpdmVyIG1h
eDMwMjA4X2RyaXZlciA9IHsNCj4gKwkuZHJpdmVyID0gew0KPiArCQkubmFtZSA9IE1BWDMwMjA4
X0RSVl9OQU1FLA0KPiArCQkub2ZfbWF0Y2hfdGFibGUgPSBtYXgzMDIwOF9vZl9tYXRjaCwNCj4g
KwkJLmFjcGlfbWF0Y2hfdGFibGUgPSBBQ1BJX1BUUihtYXgzMDIwOF9hY3BpX21hdGNoKSwNCg0K
VHJ5IGJ1aWxkaW5nIHdpdGhvdXQgQUNQSSBzdXBwb3J0IGFuZCB5b3Ugc2hvdWxkIHNlZSBhIHdh
cm5pbmcgZnJvbSB0aGUgY29tcGlsZXIuICBTYWRseSBBQ1BJX1BUUigpIGlzIG5vdCBhcyBzbWFy
dCBhcyBpdCBzaG91bGQgYmUuDQpJZiBpbnRlcmVzdGVkLCB0YWtlIGEgbG9vayBhdCBob3cgcG1f
cHRyKCkgZGVhbHMgd2l0aCB0aGUgc2FtZSBpc3N1ZS4NCg0KQW55aG93LCBiZXN0IG9wdGlvbiBp
cyBqdXN0IGRvbid0IGJvdGhlciB3aXRoIEFDUElfUFRSKCkuDQpUaGUgc2F2aW5nIGluIG1vZHVs
ZSBzaXplIGlzIHRyaXZpYWwgYW5kIG5vdCB3b3J0aCB0aGUgaWZkZWYgbWFnaWMgbmVlZGVkIHRv
IG1ha2UgaXQgd29yayB3YXJuaW5nIGZyZWUuDQoNCg0KPiArCX0sDQo+ICsJLnByb2JlX25ldyA9
IG1heDMwMjA4X3Byb2JlLA0KPiArCS5pZF90YWJsZSA9IG1heDMwMjA4X2lkX3RhYmxlLA0KPiAr
fTsNCj4gKw0KPiArc3RhdGljIGludCBfX2luaXQgbWF4MzAyMDhfaW5pdCh2b2lkKSB7DQo+ICsJ
cmV0dXJuIGkyY19hZGRfZHJpdmVyKCZtYXgzMDIwOF9kcml2ZXIpOyB9IA0KPiArbW9kdWxlX2lu
aXQobWF4MzAyMDhfaW5pdCk7DQo+ICsNCj4gK3N0YXRpYyB2b2lkIF9fZXhpdCBtYXgzMDIwOF9l
eGl0KHZvaWQpIHsNCj4gKwlpMmNfZGVsX2RyaXZlcigmbWF4MzAyMDhfZHJpdmVyKTsNCj4gK30N
Cj4gK21vZHVsZV9leGl0KG1heDMwMjA4X2V4aXQpOw0KDQptb2R1bGVfaTJjX2RyaXZlcigpIHRv
IGdldCByaWQgb2YgdGhpcyBib2lsZXJwbGF0ZS4NCg0KTm90ZSB0aGlzIHdhcyBhIGNvbW1lbnQg
SSBtYWRlIG9uIHYxLi4uIEkgd29uZGVyZWQgaWYgSSdkIGJlZW4gaGFsZiBhc2xlZXAgc28gd2Vu
dCBsb29raW5nIDopDQoNCkpvbmF0aGFuDQoNCg==
