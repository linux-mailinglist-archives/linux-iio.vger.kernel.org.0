Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B8471FDD9
	for <lists+linux-iio@lfdr.de>; Fri,  2 Jun 2023 11:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234933AbjFBJ3B (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 2 Jun 2023 05:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234914AbjFBJ2X (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Jun 2023 05:28:23 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608A610E3;
        Fri,  2 Jun 2023 02:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685698006; x=1717234006;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qowyfX7jdwuUaNUAzZolNHUEjSoT2Kl8hA0ojSlQA6M=;
  b=ksp+2NIQIX6nR2MdQyc9WbDjE7JYJiFD1AZHZigaC6BA7g1UhNkaITA0
   tF05j+tGa9lvW459+6mWdSbv0JerjfIua+A1eROTSuKEkE/lCK9fRVk34
   Ck28QxbMXqRb3fKXk4WM6KCf2fYlunHhSq5RF15VF8HYS79a8omZ8dTrk
   SUUYlfkiDu5MmXC7H24376T76ZHrldftlVmlJpWgzC6bPzrTqESjakVJz
   0+u4PkbUScCPyKXkMV6XqbI8jRq5L3RD+6AGZlv19uVcvxXK+xkwDl+a/
   ShD2fLEgVrobbwNSwz3WM27qNS53rvaupjdIOSSZi5XdRZC1VqrXnA1ob
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="359128750"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="scan'208";a="359128750"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 02:26:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="797534019"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="scan'208";a="797534019"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Jun 2023 02:26:44 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 2 Jun 2023 02:26:44 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 2 Jun 2023 02:26:44 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 2 Jun 2023 02:26:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P488qVC5/Ri2p+4RCd4nn2Ao7TWBQRK4VgoReVdwrshgsQ4+H1qR5ML/8Bj225z3qj4UDH3SSS9CHytHdWcUTnNfSXeETNMLlkKPLJqnaFl+3AobarjA8uU2+hh77u2zSrzQInG8gfVTuQ7QrhWocyLX9Pt4+xXfFq/bBo33sxU7rsEe+Uzp0pVYZtkZGmw9G/l/n2AvEai7ez8ZeoEtO3FQA08QyadgY6WxkQ/kkNbCEeAHZcyOXC635lF8hzdl9wFRMDA0jsjelLVZxJqZkIbFm9zAGTvScO6gUYZMnMmbSjnDDgSBXHU5D2JLIJcwgAJqvgNWViWFNGuukUrlzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qowyfX7jdwuUaNUAzZolNHUEjSoT2Kl8hA0ojSlQA6M=;
 b=f2JVNOm0/nwqLWlA46G0NuVn3iE4JZ3NrBaoFLvXGre9rDjumximAFWMEHLu+f890/ipbA9aH8pC+yrqIwzKSMx6841DgFg14we6i0EC/MYGs/HsX+nBnthXy3AWaXIFTfGN1npiX3VUHz7ujW7BL0xXxJR77Yb3kngo8ddCzEjjiCRngDte5YiApbNKRJR43m8ZZf/eghjJpKPiDKsMOtbCfq/3oZLq4j5WT9RwcXBSyNYI+Hb4n8qZdoeXKpZ1C9Liy4xRiPW+RWWuocnJmtA+mc5qf9QENU6V+jXMvtOKuEBcLOKg/l0FYRaDdu+JJa5QK4FV9iDYbCgAVfBJEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by BL1PR11MB5553.namprd11.prod.outlook.com (2603:10b6:208:31f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.24; Fri, 2 Jun
 2023 09:26:41 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92%6]) with mapi id 15.20.6455.024; Fri, 2 Jun 2023
 09:26:41 +0000
Message-ID: <cf385e99-de6d-b630-6ff5-94fb843feafb@intel.com>
Date:   Fri, 2 Jun 2023 11:26:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4 35/35] acpi/bus: Remove notify callback and flags
Content-Language: en-US
To:     <david.e.box@linux.intel.com>, <rafael@kernel.org>,
        <lenb@kernel.org>, <dan.j.williams@intel.com>,
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
        <Jason@zx2c4.com>, <robert.moore@intel.com>
CC:     <linux-acpi@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-hwmon@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <chrome-platform@lists.linux.dev>,
        <platform-driver-x86@vger.kernel.org>,
        <acpi4asus-user@lists.sourceforge.net>,
        <acpica-devel@lists.linuxfoundation.org>
References: <20230601132137.301802-1-michal.wilczynski@intel.com>
 <b067f6990c7e6e58c487770126a804500ce8a54a.camel@linux.intel.com>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <b067f6990c7e6e58c487770126a804500ce8a54a.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::16) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|BL1PR11MB5553:EE_
X-MS-Office365-Filtering-Correlation-Id: af30c8c0-bcd7-469a-3b5f-08db634b7946
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wp6z6sPyFL11oU19itRS8eUNlW3iKaFmiXZEZyUZ4jyYYCKMcCSG5y7MTO7JKmSEQHrF0K0p3DwbYtwRpMPyY1R10Lr1n0tj3yl+IiTPa0DT7Z1sTujLYqJ82YcOSQCvikhr/FNhbNGyH6a1SxgcKYf/6fqU0ssQNGkwCKA7Z2I6b3jngfkCpxFDFdr/jfkQO0/jyierxbuLF7tB3VSbZKT//VUdZbPWScDkOcGLYmp9DMaaz1it+R6LL/ChNLCJfo8hkQcP/qfxntV4z5mH3bJ50e4OCcdVwQSrm2aiXB5VFcVyy+CY79p4C5Y2kKrweoTc08OLEVqrDglUlpe+trIjYAG7RRgQtyQkZkJpwHYF1PswY3hRQQ4U3u+Y+N9gPmdREwjjeLhUgqXrqI7mJj1y+vjxKK0HcjAuJm9zbuOHLgZio7xCvf0VJT3e1YCTtw/GB4jNSNrijVmpTqXUAaPy20+P/0peYZ/ru8hpPncahiayOXk73rhQ2KvHeBH0b0p6vpVyE/uB9UuX4r+nG3WIMZc6F8JzQmxIHB22i9e3+wUoF5y6OelG1J3CA9OoFfF07vkoDunlCW4Sp++pbYajwoGihTVoZVYRkTISEugCROd1fowT7dRPw+eEmJ2ztOy/tOAxUXydJe2QROp5eCGpgA6GXcIEzlaUUGF0spk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(366004)(396003)(136003)(451199021)(36756003)(2906002)(86362001)(31696002)(7416002)(7406005)(5660300002)(31686004)(83380400001)(6486002)(6666004)(186003)(53546011)(6506007)(26005)(6512007)(921005)(478600001)(66556008)(4326008)(2616005)(6636002)(82960400001)(316002)(66476007)(41300700001)(38100700002)(66946007)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHVKb2djRVBSYi9YcWhHZVkrc3o0cjZQeE1aU2RNdnZobnZ2dlFuMjQzOHRp?=
 =?utf-8?B?TEJnT2tCTGIybVFRb2xlc2RsdnZpeGE2d1hNdVNEV29PMERobEprdmUwZ2RE?=
 =?utf-8?B?YkloQmtJU0Zmbnp3NGxFc0VRWXFydm8xbVNzd1hUeHR2ZklVOS90dXl2Q1VQ?=
 =?utf-8?B?L2F2WldweHMyWW5vTXQ2eGVHVU1oUGI0cjhVU0dJVThwcTZaVFlyZmIrWUY5?=
 =?utf-8?B?bmtNZTdlMWpWR1lMdXdkWXRacVpKR1pjbUppZzh6TVJmQ2k0SWJXZUFRV05G?=
 =?utf-8?B?VGx1MS9TSHYyVjB0c0VYQnlxTW1GNDROVnltV0R3T1d0TlFmTTRqRDVwZExi?=
 =?utf-8?B?YkthTFpCemtONFZSeklnYTBOZ0xaeEk0N0FOcEtVNXFxdkpKN3lGeU1hL0VO?=
 =?utf-8?B?MWg0UHRzVDNNV3lmZUNJNmt6R0Jza3gvZkJPaWczdktsMkNibmYvdDVXcVU3?=
 =?utf-8?B?Y2xFRzNEc1ZqK0tzbnd4Tkd2YUpwZnp0Q21aalBxU2dudmVNUUZ2MWFrM0Er?=
 =?utf-8?B?Y2ppdVBUaklab0ZEUjZPQUtqaVdxYlpzdVdnZGJ0WHRHOTZOeURaS0lGcWtN?=
 =?utf-8?B?c21Cek10N3JGdDNlZitSckp0UkZDZGdwNm80SGRNZDNzUWU5elRSTk5aWVlr?=
 =?utf-8?B?N3RiZ2c4b2RmalNnSDg2VDRkTzd1RlAyaGRSOEVIT0N0ekttSnE3N3U1aXhR?=
 =?utf-8?B?R1BseFNaeE1YSW1EdVNIMUpPZ09SM2RtL0JLZnhSUWduZ1YybzhuWExNcDNH?=
 =?utf-8?B?NkFjV25ESEliaVZMUVBVMDBKYmRoRmtmK3RpaEQzZVpsUjRPK3AyZ1BrZ0Vs?=
 =?utf-8?B?Z3ljZXNudmlvSUJmMnNXeW92MDZpZ09jMzdXaUFVYlFLbDhUSWUwTitCOVZ3?=
 =?utf-8?B?c1BtTnlpQUUvNVNENVdRSnExVWxNMW9WSVh0QWVzNVRKZGhUKzRNWUQrTmdu?=
 =?utf-8?B?M2tGK282NlU1V2FoNVZiV21HcmFtTjhOWlpJdnl4WmNObkxWeG1CYjV1MERr?=
 =?utf-8?B?eXVMSUl2dDE0ZXpZWDdiOGdkbGFIam8vZWpxTGpUeDlxWHlSQmtnUC9nTTkx?=
 =?utf-8?B?S0VjUlNyNHNCNmlNQ0tGbVZuNDgzMTZGVnVjVEhIMGR3ZmYrYWc5ckdWcDd0?=
 =?utf-8?B?MnZaVEtCNmlpUUNRdTFFcWlsTGQwdDkvak1RdHBsZkZXdEpWYnk5bzVKN3hi?=
 =?utf-8?B?SlJObks5bXBWVko2d0Nwb2ovbVhYQ3g4NlZDRjAxdHJnL2xjb1JuU3NtR2Ru?=
 =?utf-8?B?YVRjZHVXMDFmMlNzNnVWK3lQN1QzRFI0VTU2SkpRbyt5RklvVWFOUDJoaytm?=
 =?utf-8?B?OTdtdEVIN1dqNzBkOHVUT1FZYkRXVlVxRlFBdHY3ZE14cXR4MHpPZXJidlEr?=
 =?utf-8?B?NDh4blMreTAyNU5KQWpBRFgvU1dLbFR0TXRuQU9NYWcwWHlxS2JVQWpnWjhx?=
 =?utf-8?B?SEwyKzNPSWlEUUZyQUl5ZkJsUm4wenVoQ2Y5bUNwaUw0MmozTXBWdG9URSt3?=
 =?utf-8?B?VGMzUGVvUld2bDBUSUlWYm9qaCtmRVYyTDlZNEJzVXczMi9KTDlvOWQyeFpY?=
 =?utf-8?B?R20yL1RmQkE0dWIxRDhaUzZ3QWIzcFlBU1ZXK2ZkaG5uUXZXSjFIa0FwZDZQ?=
 =?utf-8?B?bmZicGJzbkdNZ2t5RUFNaFg5QWlyWWV1czIyZFdadzNyT3hqaHNaamRnNWpl?=
 =?utf-8?B?UThSaUIzZDQ4b1BybWJnbFdJeWN5emZkSHNnWDRnY2JGQS9nMFlNOEdxZzFD?=
 =?utf-8?B?NHVQdk5ONWtVVVU3Rlh5UTdHdUw2RExQaFVmY3BOKzlYQm5MaCtKbU5BOU1i?=
 =?utf-8?B?UVlmVTNyMnR5U2M4US8zVC8rNGxvS0Z3czdqK1E4V3I0WFI4VnFkdGQ3Qmx4?=
 =?utf-8?B?V1BxZGpjMDdUVG4zcW02RC9OMm84WWdtR3Q1Ymx5NlQzaytRUFQ1RWRCaER4?=
 =?utf-8?B?ZXBKQkYrV21aUmprMExKYWQyVlIycWRkMnZySFZRVXphMzc4YWFLb2tMZld0?=
 =?utf-8?B?bGdzK3Z4S1R3cXcydU11M3h2cis5WDhpMGFKZUI1RENLU2RSOWZoc2Z6Q1BW?=
 =?utf-8?B?QnNYcmt0MCt4SUhId0ZzUXcyZ083Mys1QVQweGhzOVkzUXVxYVc3S3FWbDlz?=
 =?utf-8?B?elI0YnhLcHgzb2V0K2N6U0dDMXA2WlBTMVRNT0ttM1pjN2RpSkhkWjZIUDJk?=
 =?utf-8?B?c1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: af30c8c0-bcd7-469a-3b5f-08db634b7946
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 09:26:41.5690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qvDxgpm7dRkscfocXBjl25EulyAN5elILdXK3jJAqN3U/jB2zkgfoEuwhwcbonCACwUpzRbjm45K3iucqbo8PokxVHgWww4UJIVFuWpjPr0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5553
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 6/2/2023 3:08 AM, David E. Box wrote:
> Hi Michal,
>
> On Thu, 2023-06-01 at 15:21 +0200, Michal Wilczynski wrote:
>> As callback has been replaced by drivers installing their handlers in
>> .add it's presence is not useful anymore.
>>
>> Remove .notify callback and flags variable from struct acpi_driver,
>> as they're not needed anymore.
>>
>> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
>> ---
>>  include/acpi/acpi_bus.h | 3 ---
>>  1 file changed, 3 deletions(-)
>>
>> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
>> index 7fb411438b6f..3326794d5b70 100644
>> --- a/include/acpi/acpi_bus.h
>> +++ b/include/acpi/acpi_bus.h
>> @@ -151,12 +151,10 @@ struct acpi_hotplug_context {
>>  
>>  typedef int (*acpi_op_add) (struct acpi_device * device);
>>  typedef void (*acpi_op_remove) (struct acpi_device *device);
>> -typedef void (*acpi_op_notify) (struct acpi_device * device, u32 event);
>>  
>>  struct acpi_device_ops {
>>         acpi_op_add add;
>>         acpi_op_remove remove;
>> -       acpi_op_notify notify;
>>  };
>>  
>>  #define ACPI_DRIVER_ALL_NOTIFY_EVENTS  0x1     /* system AND device events */
>> @@ -165,7 +163,6 @@ struct acpi_driver {
>>         char name[80];
>>         char class[80];
>>         const struct acpi_device_id *ids; /* Supported Hardware IDs */
>> -       unsigned int flags;
> Can ACPI_DRIVER_ALL_NOTIFY_EVENTS be removed as well?

Hi David,
Oh yeah, it should be removed as well,

Thanks !

>
>>         struct acpi_device_ops ops;
>>         struct device_driver drv;
>>         struct module *owner;

