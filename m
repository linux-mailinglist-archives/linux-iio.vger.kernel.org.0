Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCFD722139
	for <lists+linux-iio@lfdr.de>; Mon,  5 Jun 2023 10:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjFEIj6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Jun 2023 04:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjFEIjv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Jun 2023 04:39:51 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1169B0;
        Mon,  5 Jun 2023 01:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685954391; x=1717490391;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CExL3+TWs7SGw/bxTYZeGjaBmuLmPUH1SbPU5zWi834=;
  b=SjvlLNZyKjNxL/Nhca2trF8r8PG+WSOq3tdXO8NOtQm6CI9OwN4X+F3A
   1NZJVYztWNEeYlCZ8r5gWxT0OrKHQs5d7+h9cPlGxzFKuq6EvexLQJTG4
   DinUxS+E/mZo2kKPuPRBCoh7GSnpAFSk0BQBgwRn0L7tMwYZZ/ktz3lmo
   4NgaUZabGo1CTm5GUAeNytnghDLBD5mOnOAPHPu948KHQYJOJMIt9CxhL
   He8uWsbUcK9l1IYwEw5pmdgBJ3i2SuMhadH9ESAdbp8Zl7bw5rIBoxo1U
   FlTEhGvE50gxBWmPfufRBydhiECoVLRS619YwElpfnB2SeyRBsFX0JOzr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="422140803"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="422140803"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 01:39:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="711736419"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="711736419"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP; 05 Jun 2023 01:39:48 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 5 Jun 2023 01:39:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 5 Jun 2023 01:39:47 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 5 Jun 2023 01:39:47 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 5 Jun 2023 01:39:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8eDqlJXyjLYn0aNZpA2WcOfMy35OabtJ+C12x5ARbRP8EhJjnXq1oypcingyOulUMzKtot4hKHuMt06IhwL9OlboR9BR9t/CFkt/THMEl7WHoic0lkjxL5rVsFktXGS4ZgJYZYPDZLWQyI+sDnn2q15pbJtP2t717PxZasRDKChs+4SAMBHiC5ytCjAqOqSYmwFd8SLp+DA4NZnxwKxehbM82dYj3zvMy5kDq+humcmkVb5gLqdgBrohPMoENwiKIzoypNHPgGN3KN2CgA0UPU+HUKA1RaJDEZ4dxN5NjZTqAQDnrFrgMtnzeJVgyl1xrjnqNLSF/f4eF98fF3pcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CExL3+TWs7SGw/bxTYZeGjaBmuLmPUH1SbPU5zWi834=;
 b=TRcohc5gppEaP0hLWj88ns2f33nFfoTTppkFC10D+hqxwBUcJlAN1cxupmzvvwpcyB73UJfyrBFe4eHrZDQiaoQ1zGqKphDOhQCODI1aNwR72zHYeI85FbOEC8N+TkqAqeKZL1voORRy0t/BFiyQIp3+63/Ey5x80TkaEW7SFb4Nw/kYHiZK79jo0eIcipUONec/l0eXN+0PNMZFtviBag50D3/usPQ3IeJp1dzLlc/AeyZrdJFVkoINlPs9mQtWoIbmW8oahU7rvG8DHsIu0SxBMOPlronbPwuF6cvEsBiG0rNse0Quw14Mxde679x9zZqcJFcVPrJW/I3OkBwcLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by IA1PR11MB6417.namprd11.prod.outlook.com (2603:10b6:208:3ab::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.31; Mon, 5 Jun
 2023 08:39:39 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92%6]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 08:39:39 +0000
Message-ID: <9180d191-9713-b6a0-6a77-43310f9fe9df@intel.com>
Date:   Mon, 5 Jun 2023 10:39:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4 00/35] Remove .notify callback in acpi_device_ops
Content-Language: en-US
To:     <andy.shevchenko@gmail.com>
CC:     <rafael@kernel.org>, <lenb@kernel.org>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <dave.jiang@intel.com>,
        <ira.weiny@intel.com>, <rui.zhang@intel.com>, <jdelvare@suse.com>,
        <linux@roeck-us.net>, <jic23@kernel.org>, <lars@metafoo.de>,
        <bleung@chromium.org>, <yu.c.chen@intel.com>,
        <hdegoede@redhat.com>, <markgross@kernel.org>,
        <luzmaximilian@gmail.com>, <corentin.chary@gmail.com>,
        <jprvita@gmail.com>, <cascardo@holoscopio.com>, <don@syst.com.br>,
        <pali@kernel.org>, <jwoithe@just42.net>, <matan@svgalib.org>,
        <kenneth.t.chan@gmail.com>, <malattia@linux.it>,
        <jeremy@system76.com>, <productdev@system76.com>,
        <herton@canonical.com>, <coproscefalo@gmail.com>, <tytso@mit.edu>,
        <Jason@zx2c4.com>, <robert.moore@intel.com>,
        <linux-acpi@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-hwmon@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <chrome-platform@lists.linux.dev>,
        <platform-driver-x86@vger.kernel.org>,
        <acpi4asus-user@lists.sourceforge.net>
References: <20230601131655.300675-1-michal.wilczynski@intel.com>
 <ZHsd-je7kDDpii2q@surfacebook>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <ZHsd-je7kDDpii2q@surfacebook>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0263.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::6) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|IA1PR11MB6417:EE_
X-MS-Office365-Filtering-Correlation-Id: ff2cd1e1-0a1c-4940-cd27-08db65a066b3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I81km9XkAdrKdb+0AikqOYzGcyF6FLa2Wgyg2T9UiLO7IGlPl0nPJs57PkxnrkzUpAyKE/Dp3kf51Mm2qt0GYrm4f8iYOBWol9Sw2pchmltFfEoOF9LyfmW51XfZ7ZK/+YT+r5QRGCIjuJObZd/Qx4vXnWCbByzxFGAe7KPxEJvFlQFzHFfse+MAmCVj67kmG6WErFf0UwUv1tbnSBqL0wuITgvkFVR+ULcDinSKqi2cYyHoSVbOLpie6RiUbVMZFS7KVryCc2QScfyl21BUDEW1HRSPeC9X+m0FOxgPyc5HOB9JyYGvmaSzg+SaNcUyVgWafTD31gABZlDd6hw/1jv5w+vlz+CBA7Qqfk567ZC+p7+7Qws0BaFITfLyxEXtjrNHXnWw2NY2eD3jIb+WkpoMuLXB+rLFa1lPHiD9jVC0EhH0LhVbfa1v3CeoLxFhjudSuFiJD8RpDm+vf96yD2xs1Zzl7M4UoP81dKMRIFnGY163d/ZCMCn5zypU/0NUZzytLGdRBZ+iEb4d4ZrrIKM2J4mjYWAgEn4E22pPF1fEg4GcE57D8EIvwak/kHBM+VU5bciNGNFivL7QRRsmJx19m00OBmNiunee/i4hw0NNCxHoMc6D6EGs2wDaQNakaxjTMiBAchDkHgZI8wLxEacIX+NWLwJ33Z6UW/mM9WrE80lgt0FQFwoC1RRFy3y8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199021)(41300700001)(316002)(7416002)(7406005)(82960400001)(5660300002)(2906002)(4326008)(66946007)(66556008)(66476007)(6916009)(31686004)(8676002)(8936002)(478600001)(6666004)(6486002)(31696002)(86362001)(186003)(36756003)(2616005)(38100700002)(53546011)(26005)(6512007)(6506007)(83380400001)(142923001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEFXQUJPa2QzQitDeHh0aVZ5SUN3VmVYazVCQUx5OVpQVWoyMHBCb0FFaUdP?=
 =?utf-8?B?cW9JUjdsV0NiSitOS2NHQW1lZ1ZWc2U5V3ZNZjl4cVB6YTM3MUZ4c2FSSUJi?=
 =?utf-8?B?Vm1ubHE0bVg0cXFCYTViU1lsa1RqaTNjaEN6eE80UEZYWjUrY3ZFY3BIaGE1?=
 =?utf-8?B?dFhFU01pb1R6TGM0T0pYa2ZrUENheERidDhXRkErZ3lEcnQxYUNIRmNGT3Av?=
 =?utf-8?B?NTg0bWV3U2ZUZU55Y2dUY3JndjBBOG9wWUJYWkpOdVI0bWIxN01mbzdLbXJD?=
 =?utf-8?B?bjY3RlhLRjlJS0xFL3ZZOXlabkM0KzJGTFh0YUdneHBKRWFtdXp2VDNXWWxR?=
 =?utf-8?B?OVBQNkRpakhaVWIxMllkL1dvQ2hKMXNndEJLSm5qVUtyTDFFcFZTTEZGTFVu?=
 =?utf-8?B?UklEVE9Ydm1jY3hXdDE5a1UrNTVydkZPZnNkNzM4ZEp1QWxha1k0bW02T1NP?=
 =?utf-8?B?VkpPV2xWbU84N0F5cDQwZWFvZTBTZ2VjOTVzNTZaMk1UaHFEVU5INGtodzdO?=
 =?utf-8?B?a056WktqUlNGL3JvdWxrOFVJZG0zdFV3YlVBUXBGdkNwcURrU1RjYjk5NjBW?=
 =?utf-8?B?ZjFKekJFL3BxTFprNmplUmFXUER1eXNrTEhVNDg0REs1aWtLVFVYbGwwWSt6?=
 =?utf-8?B?aGV3K2lKL1hkWW9wSGxKWkt4ZzhjUEtOVEVreXVRMU9zR05PQWMxenV1L21l?=
 =?utf-8?B?NUNuekJlY3RUOC9hQ2hxTHp2Q1lHcHI0M3NFNUtMaS9TWjZ3S0NmL2tlaFVK?=
 =?utf-8?B?N3RpdyttRjVoenp0WVZhT1BxOVdoSEJ5dk01RWdhVVhMOElpN2xiSHVmc09n?=
 =?utf-8?B?K3Naekd1V1FSSUlEbzNET1E3b1JFdkFLK0tLNFQ2U1IrblNqMkNzWU5sQk4z?=
 =?utf-8?B?TmY1dTFvNDdEenRpeWt5SDl6Z2hQWmJBOW1sZXZCeDJobGZKUEJDMjdJQ1BZ?=
 =?utf-8?B?SFM2eUpDd2NCUmcvcHRkTEVYb05lTi85ckZXWG1tWEJqbW44OXBQTGM5RGhx?=
 =?utf-8?B?VUFxaS9YblZHZEdZMTd0UW5ESTJXTFJQdGlkTGFJWGhHd3lWaHhzYXA3NmMr?=
 =?utf-8?B?M3QrMWxjRlFFQ054M0t2VWpyMzlTU3hjenV1QjgzbTdzTXhyZXcrZUcvTTlS?=
 =?utf-8?B?TE8yMUdvbitNeEJ6WE9PWDhXa2R6d2R3aGwzWkZKOGdWajQvOVJFdXJMaTI5?=
 =?utf-8?B?WG4xNnRYeXdkL01ZV0t4YTZSWXo5MDhEUmZVNmdQYU1CbkM0L05BaWtwbnpT?=
 =?utf-8?B?Nlhmck1Md1UrUUY1S0F3NGg2NldzWnJiT2FtRHRva2Vpd3R3VG13SkxUZTd0?=
 =?utf-8?B?bjdkYXJveHp0cUF3Z01Oc21oTi9CekZ1L21sS0Z5K3F3Q0EyUlV2VEtSMzRa?=
 =?utf-8?B?SFE2ckJUT0gyKzBkYTFtS1NhTGp0SjZEbWpRS2hKaFlHZzExdmEvVHNEOUVB?=
 =?utf-8?B?cFlYQXZCT0Erdmh0Y05oZmJoRXVjQjVrZ2FUUTZ5OVJrM0QxUVV0VnIzSVMw?=
 =?utf-8?B?TGRXclV6T0RQM0luUTNmR1I1aGcrMVg3YUVnczFOWDJZVVhHN3NINklHbEUz?=
 =?utf-8?B?WU0yYk5NOWVwUVV3c215TFZ5MStDY1RMem1reElxcGt1aE1KYzZ1eEIwblFs?=
 =?utf-8?B?WXlabUNwSU50Znp1OGxOZ2RwYVU5TnYvWkFFTmZCZGxPRCtHRUozTHRoWEVP?=
 =?utf-8?B?Nktzb2hGcG0velNLb3o0WTAxWGs0eE4rV1RQeitza0FoSnFBbzMvMFZCalNI?=
 =?utf-8?B?ZHVrMmdzbEZkQnZhUGZtMG04TEk3c3JFa3VDNkh1OGdCTFUxRktjY2E2Y0hM?=
 =?utf-8?B?L0FOVVlTcDZqNGd6b24wQk81ZTBsMUhwWmZnd0VUaWxrQ0REa29CMktlS2FI?=
 =?utf-8?B?SjhKeitkdCtUKzNrcDRNRlBSaW9SdUNKRzN6cEJmZURZVTNnL0JQSEp0dEZ3?=
 =?utf-8?B?eVJmRXNWVTJtMHlwbURFdklRTTU2a0QwcnZ2VDVvQklZUHVHUUhNQzhwSUN2?=
 =?utf-8?B?S3VKdHk4ZTVCNHlUSytBWkRVY3ZaQXc4dXBSbHl4K0k5LzlkdlM1aWNEcHJ3?=
 =?utf-8?B?MnpTWE9STTlXYmMwK3hjZjRQQUpLTFRCVm11RDNRU3NMRXgvSkZadStCOVdN?=
 =?utf-8?B?dWwxeTdnVFJ1VGVIdTg2QmRKdlh1cHc1YTdXQUlWWTYyTUpQZTVST2ZNVVJ3?=
 =?utf-8?B?R0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ff2cd1e1-0a1c-4940-cd27-08db65a066b3
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 08:39:39.7911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cKcZq+9O9pZx5feikXpWXKeL6Lme2ZrDYhlzfyHTjBHyeRpxKWq+bE1sqmxQxoGuyPqUVtlhCyBbJAiGrzweNkOleu3kFNDjpQ/LpM4k2KU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6417
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 6/3/2023 1:03 PM, andy.shevchenko@gmail.com wrote:
> Thu, Jun 01, 2023 at 03:16:55PM +0200, Michal Wilczynski kirjoitti:
>> Currently drivers support ACPI event handlers by defining .notify
>> callback in acpi_device_ops. This solution is suboptimal as event
>> handler installer installs intermediary function acpi_notify_device as a
>> handler in every driver. Also this approach requires extra variable
>> 'flags' for specifying event types that the driver want to subscribe to.
>> Additionally this is a pre-work required to align acpi_driver with
>> platform_driver and eventually replace acpi_driver with platform_driver.
>>
>> Remove .notify callback from the acpi_device_ops. Replace it with each
>> driver installing and removing it's event handlers.
> Somehow this thread is screwed up in a sense of linking messages.
> Even on the archives there are rather individual patches.
>
> Please, be sure you are always use --thread when formatting it.
> Yet you have a possibility to Cc different patches to the different
> mailing lists and people.

Hi,
Thank you for this remark, I was trying to be clever and tried to send a patch
in a bit non-canonical way. So I've send a cover letter and a couple of other
major bits of a solution to everyone from the output of scripts/get_maintainer.pl
run on every patch from this series.

./scripts/get_maintainer.pl /home/mwilczyn/patches/remove_notify_external/*

(where remove_notify_external contains all patches generated for this patchset)

For the rest I used --to-cmd and --cc-cmd options of git send-email. This way I could
send patches with minor changes to every driver to only specified people marked
by get_maintainer.pl for this individual patch.

Hope that when re-sending with next revision --thread can help.

>

