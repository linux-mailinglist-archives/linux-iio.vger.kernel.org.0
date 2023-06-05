Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E3A722152
	for <lists+linux-iio@lfdr.de>; Mon,  5 Jun 2023 10:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjFEIpG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Jun 2023 04:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbjFEIo5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Jun 2023 04:44:57 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221B7116;
        Mon,  5 Jun 2023 01:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685954691; x=1717490691;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ySn0zqZhbKrPfR7xWycH04iY+MYbR6r8SKLRtGw479E=;
  b=fYwmD3RRaHPVFpCl6GA4MFYntkFO99+2rusO/dYpEHvES/8Lp3n53Nuz
   0Ne2tIQS270A5aFWiY4Z+BGU6S6h8A3GFq/dJKzOwtwdWFS0PSWve9XAW
   Jx7C9rlCS/UEBDVTGaXWCcRI4sBVZ3/WmN474xJDkOe0D5iKPU1JH8tV3
   CIxkttiYLfjpTJsZrO31Rh+1tPFJLAgSlRnHHJ7a9P1GLSZsG6ilr1hWq
   NlfPp2jiCRhlfA3QZSaopikNx6ehbUJ3gl36BpLqnK9xWFNksII0dLjDA
   v90hCni17MNHQGr/f4JxFshv2ZQ2UpDmWQLE3tJ8V6x+kr62PcAMYwgHW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="355172042"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="355172042"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 01:44:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="738300700"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="738300700"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 05 Jun 2023 01:44:45 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 5 Jun 2023 01:44:44 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 5 Jun 2023 01:44:44 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 5 Jun 2023 01:44:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JND9omByX+xtI6SDrc2E6iG9iFcLGLf9QpYAfXTKv+Lb7r0VRop15SmIdJjIQWuWanyLRXlN0DTMG3Jj4uMpl07v2gqjnIQrbr8NB87xSA3hiAvf71as4JasJ7yKORXNlQc/WGWPQJxMkUcTobvbE6cbXO+s5oZ0hOG1He6Wn36+Z/zx5+7o+md5qdnFrSTEzkbUCh0XHNIHeOosvRHuzciF9QaWJj3p/Aq57EEtwt1reKbcr3VAEYHwsq03iuS/zqqVRR29WNE5Ak7fPk5P1SqQvngBVGBogrubLBS/Xc/dFLRI1UHgnABs6uorwq4a3/FEJXzUPxZwrSsOI7Sdvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61zrJObzPlOp1XFgdQm38xCIIfcsDYdpVv27UVh2YgY=;
 b=TNgyGFjaCCVYkFACnu+SDebxbpxuvqe+uv0gVtbEO4R+xB7dW0acsgEKiUrSzPcRxbeEvSyTxRsf0JmBePhPWrNOtfNeGPjQxNAQQ4crFxFX9MXRzZy0p3sA0E5Xjl9qwZJY6aHhtHsIUMrgV6MgR4jEKXtmKoDONsuBi1gwfllLkK+RiIcC1z1H+qtjg04QoR9tJtoea3JB+wo/R2gB1GtlcXBme7CyUp4xEC8ddYFsre/rz+Ld/2MjFN8oKlVaemAqV8arRWNUsU7p8ktz9Dy6MSvO3FUwHdNLp1iocEEEWtYK4LgEHPH/s3dR2AKRVpa2G7OxgGkLYFD0IJEnNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by IA1PR11MB6417.namprd11.prod.outlook.com (2603:10b6:208:3ab::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.31; Mon, 5 Jun
 2023 08:44:41 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92%6]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 08:44:41 +0000
Message-ID: <eb5ed997-201a-ffc4-6181-b2f8a6d451a8@intel.com>
Date:   Mon, 5 Jun 2023 10:44:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4 01/35] acpi: Adjust functions installing bus event
 handlers
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, <rafael@kernel.org>,
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
References: <20230601131719.300720-1-michal.wilczynski@intel.com>
 <4500594.LvFx2qVVIh@kreacher>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <4500594.LvFx2qVVIh@kreacher>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0284.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::32) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|IA1PR11MB6417:EE_
X-MS-Office365-Filtering-Correlation-Id: 57f4fe7f-314d-4335-c9af-08db65a11a86
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rbpRGljlcoS05thkSNVTxQYs3HQgEIoHG1z7KIr1uPm6Dzs2HNfX4+4frgTpgT0sSUkW+MdYVoL4Sh81u6kOYOi/RrkBtN4ItC1vQOvbSA0FkW8XSqgYWoqmvcFKmUGQ+t/hvmbPkT+KgkGnflIGSX30z7VfWGkHFXi+loy1tEWd4YgLroIxs8vgN0JDar6I2WTZKc3gGlUuDEaerMtSBkd7LRWM2WegPTr/P7d4BwL/vzppM2Ml8zlk4WdKLBpd3WNkVhI6Dwyub69JMdQhcCeP9X7UGX216R4rQmmbxbNGegr9BM8CPY9wjAXzIz1FugqcXEMboOknbkghYdJ5G9NCFsb8XJBowshu7IaNX5VCtvv++/Rkiu8KBLrOu0AdmAIKnm3FrlR1LfXUtaTgT9RA4QnYnzLmX9saQLbLLYGu29aWbs8sstsP5J74qTeDONaJ1uuG+lRCZIqJJ51W9pddFJ3afg+ICU2cb77OdsZNZlaPsy+Fvl7qtjcZNHPcuyI0eHBLcJ9/0f0002ENlDbU/yTF8eCpdSmMUUr/gw7+ut3gjcrN7QVs520VrjpTtKEP3tqOCile1fqlKMzKRo/gfanYaDNvjzTfC/S5DhzWnPT8GR0fQXi8LzW8FuFZW2lWheJe5GZ/UYPKy2PGfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199021)(41300700001)(316002)(84970400001)(7416002)(7406005)(921005)(82960400001)(5660300002)(30864003)(2906002)(4326008)(6636002)(66946007)(66556008)(66476007)(31686004)(8676002)(8936002)(478600001)(6666004)(6486002)(31696002)(86362001)(186003)(36756003)(2616005)(38100700002)(53546011)(26005)(6512007)(6506007)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFlKMDh5Q0c3VFQ0Qm1BS0FzbldnUWFVUXVMVlpSQTkyVGpRZTBjc3pBM1hF?=
 =?utf-8?B?TDNVckRLYXEzQW43VEx1azQyaWhkenRUVG9Ma3VHSll1b2RxMGpTdnpaMkZ2?=
 =?utf-8?B?bU1uWGRHeWlLOWZUZllKZmllNGVRdWd4NTBXcWIxSE1HNkFaSTc5U21LUlly?=
 =?utf-8?B?RnZaU0ZHMFdrdm1jZktiNkY4WEpjWEJsdWdtMExaeVYybjZTdEN0REZXbWF6?=
 =?utf-8?B?WTVTcWt6ZkJSMzVlSDIwZkdtODNYNElObE51Mlh0YU9XbzZ0eGxYVlpDMnRr?=
 =?utf-8?B?eVEzUjRpT0pRckFpSXhibFpQb0pQWnpqejArYWY0TldkOWVOOHhKNmY2M3c5?=
 =?utf-8?B?YjNyZUF0Z2VsM2hma1BScGJiaEh6cGFnTFBDR2FuOWNRZ3RFYTJEWTZJV0J1?=
 =?utf-8?B?ODFJRElZR2x1dWpQQWxWbXpYbE55eUE0MmQyTWhzWFgxNi95T2M1UUorOTlF?=
 =?utf-8?B?WGpkdUZpS1pPT041K25DYzNXcTZHeXg4cnhDYnVwS3dzaW8yYjZOdU1kUlRl?=
 =?utf-8?B?cExiZ25BeFpueDFoV0hCZ1RIcW5KRmdtc25nWXQ1UERqOURmRnJOdWFneWVk?=
 =?utf-8?B?U1BMa0xXWkJ0TkZpcE01R3JBd1J3L1N3UDRtcVhaaDhQdVNhemZZOE9LdlhV?=
 =?utf-8?B?OU0rQmFlQ2YzWkt6L3Z5OHFjZnhXYXBMcUpDTjZtb2g2UXcxMzRYYjk4bHpN?=
 =?utf-8?B?T3dLNVhPb3pPb1phSGdvUVc2NGFvR293SVZHQ05ZcU9KSmxpTzhaM0tlYnUr?=
 =?utf-8?B?bDRWTVNsOWJXWklVY1pLL0ZLOXdSSnZMVkFRMTR0elk3MlBmYk9jSXlsaWZB?=
 =?utf-8?B?Nm8xa0x1UWFwR2hTRmdReUExYU5QcE0yamNqclRCMldKdUNaaGppM016SUZP?=
 =?utf-8?B?a2daaEJKbVN1WVJpVGFzMG5vSTMrTU5JTW9NemthVk1XdzkvVW5naEtjaEl5?=
 =?utf-8?B?c1o1MDJSUURlaUdLY0J5ZGpsbTBnNXJsYlVEY1U3OGYvSndvSWh4aEFLSzJR?=
 =?utf-8?B?TGloRDNzUHFLK2pKcGNJS1c1dVJNZjM2NXNpdU41dE9DazhHMDVvYXN5U0pX?=
 =?utf-8?B?dVh0UWo5UURSd09kWm80a0tWYkdKR1p6ZTVGQjdHMzNoSzFvQ1MwTGhoNUh3?=
 =?utf-8?B?am1EeFdxOFkwQ0JpYkhBR05lTXVkaTg3SHM3U3FxdTVUdEQvRDJ1Smg5SEtj?=
 =?utf-8?B?MzZWeHdLMzlxNGl4YVp4ZU95bE5QZThucmJ6N0p6SDZzSHlFOVpuT0wrNXlx?=
 =?utf-8?B?Y09FQlhQYnVQTGg5U0lUMnRmb2F4NlFkVEhHTTJ2eFE3TklBTUZUbWpMUC85?=
 =?utf-8?B?NG9rQXY5eGM3NXRmbVh3VkNEVXQvL0ZJUzlnSTNYbUk1SkxWSEorR0ZVTU0v?=
 =?utf-8?B?NEY0bm9XMVE2bUFWejdOdElTYVpaUnBObmo2QXJwajhjdnVVaGFuUGJuVzR2?=
 =?utf-8?B?V29SL3hQM1lPRXVwRGZ3T0U2UlpUR0FKY1VXMEp1a2doVHFWOXp1L3FLRXRh?=
 =?utf-8?B?M3p3NGhrZ2VQS2Q1eXlGM0xvcjhQODhsYmVhOUhHVGV2KzA2YmFvckd6Y05x?=
 =?utf-8?B?blNOWlNOZ002SVk5QlcydmY5Z0RwcVM0VGR4RXVjT0Q5d2U2RVd2dmxydTU5?=
 =?utf-8?B?cC9TSGRoeTI3ZU9tVFRmSi84L1N6OTM3SjRMQjVXZXNTL0xjT3pOSmRlZ0sz?=
 =?utf-8?B?YkFKR2NGSEVFbjUwaW55UkhKdzh1TzFvUzdzN2FwS3ZYRDYzYVU0N2tKK3gy?=
 =?utf-8?B?U05YaSs2WHQyQzU2bFEzdjNqYytseU5KYU5oL1BpYmE1K1VpcTZLVkcxOHVj?=
 =?utf-8?B?ckdLZzZmNjExTEJpbXlTS0NXV3BHbWdOQXF5U0NxUW9VeU9RR2ZIMEZ3a3Jz?=
 =?utf-8?B?c3dhb0t5NjZKU1FML2VLa0JjcHMwQk9FZGNPdHBvQU1Ndm00QWY3TktFVUlY?=
 =?utf-8?B?dnJLQkFBcjRIRlVETnZDZFBHUkdCUlR2UEJ2cjZDN1M0V1FmVmdqUEpRdGRt?=
 =?utf-8?B?TjFCWUhRZkJqUE5paFRLNTNtR1BETlhrOW9rZGIzQU9FNDlaUGhKSUNPZEw4?=
 =?utf-8?B?d2Z0cWViVDVBbzJBZUFyQUdFRUIxTHYrU2h4MFVON1BGT1lkOTA2Z0UzOUFD?=
 =?utf-8?B?b1VGdmRwL0R4L2tHVWprUHRGVnBEZVRwWm1tbFZFZHgzUkM3MXhKUUlCV0N4?=
 =?utf-8?B?dmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 57f4fe7f-314d-4335-c9af-08db65a11a86
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 08:44:41.4841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wMf3ZwyMXpniPsb/0R5rAgIcB2JRQQbQkR+nksjWefPflJfpFqLwOR9M2yAkd1lq1NLxpx054pOcM7+UjEzbuBgx7ESlea06/JqtdfEuivE=
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



On 6/2/2023 8:34 PM, Rafael J. Wysocki wrote:
> On Thursday, June 1, 2023 3:17:19 PM CEST Michal Wilczynski wrote:
>> Currently acpi_device_install_notify_handler() and
>> acpi_device_remove_notify_handler() always install acpi_notify_device()
>> as a function handler, and only then the real .notify callback gets
>> called. This is not efficient and doesn't provide any real advantage.
>>
>> Introduce new acpi_device_install_event_handler() and
>> acpi_device_remove_event_handler(). Those functions are replacing old
>> installers, and after all drivers switch to the new model, old installers
>> will be removed at the end of the patchset.
>>
>> Make new installer/removal function arguments to take function pointer as
>> an argument instead of using .notify callback. Introduce new variable in
>> struct acpi_device, as fixed events still needs to be handled by an
>> intermediary that would schedule them for later execution. This is due to
>> fixed hardware event handlers being executed in interrupt context.
>>
>> Make acpi_device_install_event_handler() and
>> acpi_device_remove_event_handler() non-static, and export symbols. This
>> will allow the drivers to call them directly, instead of relying on
>> .notify callback.
>>
>> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
>> ---
>>  drivers/acpi/bus.c      | 59 ++++++++++++++++++++++++++++++++++++++++-
>>  include/acpi/acpi_bus.h |  7 +++++
>>  2 files changed, 65 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
>> index d161ff707de4..cf2c2bfe29a0 100644
>> --- a/drivers/acpi/bus.c
>> +++ b/drivers/acpi/bus.c
>> @@ -535,7 +535,7 @@ static void acpi_notify_device_fixed(void *data)
>>  	struct acpi_device *device = data;
>>  
>>  	/* Fixed hardware devices have no handles */
>> -	acpi_notify_device(NULL, ACPI_FIXED_HARDWARE_EVENT, device);
>> +	device->fixed_event_notify(NULL, ACPI_FIXED_HARDWARE_EVENT, device);
>>  }
>>  
>>  static u32 acpi_device_fixed_event(void *data)
>> @@ -550,11 +550,13 @@ static int acpi_device_install_notify_handler(struct acpi_device *device,
>>  	acpi_status status;
>>  
>>  	if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON) {
>> +		device->fixed_event_notify = acpi_notify_device;
>>  		status =
>>  		    acpi_install_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
>>  						     acpi_device_fixed_event,
>>  						     device);
>>  	} else if (device->device_type == ACPI_BUS_TYPE_SLEEP_BUTTON) {
>> +		device->fixed_event_notify = acpi_notify_device;
>>  		status =
>>  		    acpi_install_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
>>  						     acpi_device_fixed_event,
>> @@ -579,9 +581,11 @@ static void acpi_device_remove_notify_handler(struct acpi_device *device,
>>  	if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON) {
>>  		acpi_remove_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
>>  						acpi_device_fixed_event);
>> +		device->fixed_event_notify = NULL;
>>  	} else if (device->device_type == ACPI_BUS_TYPE_SLEEP_BUTTON) {
>>  		acpi_remove_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
>>  						acpi_device_fixed_event);
>> +		device->fixed_event_notify = NULL;
>>  	} else {
>>  		u32 type = acpi_drv->flags & ACPI_DRIVER_ALL_NOTIFY_EVENTS ?
>>  				ACPI_ALL_NOTIFY : ACPI_DEVICE_NOTIFY;
>> @@ -592,6 +596,59 @@ static void acpi_device_remove_notify_handler(struct acpi_device *device,
>>  	acpi_os_wait_events_complete();
>>  }
>>  
>> +int acpi_device_install_event_handler(struct acpi_device *device,
>> +				      u32 type,
>> +				      void (*notify)(acpi_handle, u32, void*))
>> +{
>> +	acpi_status status;
>> +
>> +	if (!notify)
>> +		return -EINVAL;
>> +
>> +	if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON) {
>> +		device->fixed_event_notify = notify;
>> +		status =
>> +		    acpi_install_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
>> +						     acpi_device_fixed_event,
>> +						     device);
>> +	} else if (device->device_type == ACPI_BUS_TYPE_SLEEP_BUTTON) {
>> +		device->fixed_event_notify = notify;
>> +		status =
>> +		    acpi_install_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
>> +						     acpi_device_fixed_event,
>> +						     device);
>> +	} else {
>> +		status = acpi_install_notify_handler(device->handle, type,
>> +						     notify,
>> +						     device);
>> +	}
>> +
>> +	if (ACPI_FAILURE(status))
>> +		return -EINVAL;
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(acpi_device_install_event_handler);
>> +
>> +void acpi_device_remove_event_handler(struct acpi_device *device,
>> +				      u32 type,
>> +				      void (*notify)(acpi_handle, u32, void*))
>> +{
>> +	if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON) {
>> +		acpi_remove_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
>> +						acpi_device_fixed_event);
>> +		device->fixed_event_notify = NULL;
>> +	} else if (device->device_type == ACPI_BUS_TYPE_SLEEP_BUTTON) {
>> +		acpi_remove_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
>> +						acpi_device_fixed_event);
>> +		device->fixed_event_notify = NULL;
>> +	} else {
>> +		acpi_remove_notify_handler(device->handle, type,
>> +					   notify);
>> +	}
>> +	acpi_os_wait_events_complete();
>> +}
>> +EXPORT_SYMBOL(acpi_device_remove_event_handler);
>> +
>>  /* Handle events targeting \_SB device (at present only graceful shutdown) */
>>  
>>  #define ACPI_SB_NOTIFY_SHUTDOWN_REQUEST 0x81
>> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
>> index a6affc0550b0..7fb411438b6f 100644
>> --- a/include/acpi/acpi_bus.h
>> +++ b/include/acpi/acpi_bus.h
>> @@ -387,6 +387,7 @@ struct acpi_device {
>>  	struct list_head physical_node_list;
>>  	struct mutex physical_node_lock;
>>  	void (*remove)(struct acpi_device *);
>> +	void (*fixed_event_notify)(acpi_handle handle, u32 type, void *data);


Hi,
Thank for you review,

> This is a rather confusing change, because ->remove() above is not a driver
> callback, whereas the new one would be.
>
> Moreover, it is rather wasteful, because the only devices needing it are
> buttons, so for all of the other ACPI device objects the new callback pointer
> would always be NULL.
>
> Finally, it is not necessary even.

I was thinking about resolving this somehow in compile-time, but I guess was a bit
afraid of refactoring too much code - didn't want to break anything.

>
> The key observation here is that there are only 2 drivers handling power and
> sleep buttons that use ACPI fixed events: the ACPI button driver (button.c in
> drivers/acpi) and the "tiny power button" driver (tiny-power-button.c in
> drivers/acpi).  All of the other drivers don't need the "fixed event notify"
> thing and these two can be modified to take care of all of it by themselves.
>
> So if something like the below is done prior to the rest of your series, the
> rest will be about acpi_install/remove_notify_handler() only and you won't
> even need the wrapper routines any more: driver may just be switched over
> to using the ACPICA functions directly.

Sure, will get your patch, apply it before my series and fix individual drivers to use acpica
functions directly.

Thank you for your help !
Regards,
Michał

>
> [This patch is untested and is really 3 patches in one, but since I've cut it
> already, I'll send it properly next week after some button driver testing.]
>
> ---
>  drivers/acpi/bus.c               |   53 +++++-----------------------------
>  drivers/acpi/button.c            |   60 +++++++++++++++++++++++++++++++++------
>  drivers/acpi/tiny-power-button.c |   49 ++++++++++++++++++++++++++-----
>  3 files changed, 101 insertions(+), 61 deletions(-)
>
> Index: linux-pm/drivers/acpi/tiny-power-button.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/tiny-power-button.c
> +++ linux-pm/drivers/acpi/tiny-power-button.c
> @@ -19,18 +19,52 @@ static const struct acpi_device_id tiny_
>  };
>  MODULE_DEVICE_TABLE(acpi, tiny_power_button_device_ids);
>  
> -static int acpi_noop_add(struct acpi_device *device)
> +static void acpi_tiny_power_button_notify(acpi_handle handle, u32 event, void *data)
>  {
> -	return 0;
> +	kill_cad_pid(power_signal, 1);
>  }
>  
> -static void acpi_noop_remove(struct acpi_device *device)
> +static void acpi_tiny_power_button_notify_run(void *not_used)
>  {
> +	acpi_tiny_power_button_notify(NULL, ACPI_FIXED_HARDWARE_EVENT, NULL);
>  }
>  
> -static void acpi_tiny_power_button_notify(struct acpi_device *device, u32 event)
> +static u32 acpi_tiny_power_button_event(void *not_used)
>  {
> -	kill_cad_pid(power_signal, 1);
> +	acpi_os_execute(OSL_NOTIFY_HANDLER, acpi_tiny_power_button_notify_run, NULL);
> +	return ACPI_INTERRUPT_HANDLED;
> +}
> +
> +static int acpi_tiny_power_button_add(struct acpi_device *device)
> +{
> +	acpi_status status;
> +
> +	if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON) {
> +		status = acpi_install_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
> +							  acpi_tiny_power_button_event,
> +							  NULL);
> +	} else {
> +		status = acpi_install_notify_handler(device->handle,
> +						     ACPI_DEVICE_NOTIFY,
> +						     acpi_tiny_power_button_notify,
> +						     NULL);
> +	}
> +	if (ACPI_FAILURE(status))
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
> +static void acpi_tiny_power_button_remove(struct acpi_device *device)
> +{
> +	if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON) {
> +		acpi_remove_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
> +						acpi_tiny_power_button_event);
> +	} else {
> +		acpi_remove_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
> +					   acpi_tiny_power_button_notify);
> +	}
> +	acpi_os_wait_events_complete();
>  }
>  
>  static struct acpi_driver acpi_tiny_power_button_driver = {
> @@ -38,9 +72,8 @@ static struct acpi_driver acpi_tiny_powe
>  	.class = "tiny-power-button",
>  	.ids = tiny_power_button_device_ids,
>  	.ops = {
> -		.add = acpi_noop_add,
> -		.remove = acpi_noop_remove,
> -		.notify = acpi_tiny_power_button_notify,
> +		.add = acpi_tiny_power_button_add,
> +		.remove = acpi_tiny_power_button_remove,
>  	},
>  };
>  
> Index: linux-pm/drivers/acpi/button.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/button.c
> +++ linux-pm/drivers/acpi/button.c
> @@ -135,7 +135,6 @@ static const struct dmi_system_id dmi_li
>  
>  static int acpi_button_add(struct acpi_device *device);
>  static void acpi_button_remove(struct acpi_device *device);
> -static void acpi_button_notify(struct acpi_device *device, u32 event);
>  
>  #ifdef CONFIG_PM_SLEEP
>  static int acpi_button_suspend(struct device *dev);
> @@ -153,7 +152,6 @@ static struct acpi_driver acpi_button_dr
>  	.ops = {
>  		.add = acpi_button_add,
>  		.remove = acpi_button_remove,
> -		.notify = acpi_button_notify,
>  	},
>  	.drv.pm = &acpi_button_pm,
>  };
> @@ -409,15 +407,13 @@ static void acpi_lid_initialize_state(st
>  	button->lid_state_initialized = true;
>  }
>  
> -static void acpi_button_notify(struct acpi_device *device, u32 event)
> +static void acpi_button_notify(acpi_handle handle, u32 event, void *data)
>  {
> +	struct acpi_device *device = data;
>  	struct acpi_button *button = acpi_driver_data(device);
>  	struct input_dev *input;
>  
>  	switch (event) {
> -	case ACPI_FIXED_HARDWARE_EVENT:
> -		event = ACPI_BUTTON_NOTIFY_STATUS;
> -		fallthrough;
>  	case ACPI_BUTTON_NOTIFY_STATUS:
>  		input = button->input;
>  		if (button->type == ACPI_BUTTON_TYPE_LID) {
> @@ -450,6 +446,17 @@ static void acpi_button_notify(struct ac
>  	}
>  }
>  
> +static void acpi_button_notify_run(void *data)
> +{
> +	acpi_button_notify(NULL, ACPI_BUTTON_NOTIFY_STATUS, data);
> +}
> +
> +static u32 acpi_button_event(void *data)
> +{
> +	acpi_os_execute(OSL_NOTIFY_HANDLER, acpi_button_notify_run, data);
> +	return ACPI_INTERRUPT_HANDLED;
> +}
> +
>  #ifdef CONFIG_PM_SLEEP
>  static int acpi_button_suspend(struct device *dev)
>  {
> @@ -492,6 +499,7 @@ static int acpi_button_add(struct acpi_d
>  	struct acpi_button *button;
>  	struct input_dev *input;
>  	const char *hid = acpi_device_hid(device);
> +	acpi_status status;
>  	char *name, *class;
>  	int error;
>  
> @@ -568,6 +576,26 @@ static int acpi_button_add(struct acpi_d
>  	error = input_register_device(input);
>  	if (error)
>  		goto err_remove_fs;
> +
> +	if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON) {
> +		status = acpi_install_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
> +							  acpi_button_event,
> +							  device);
> +	} else if (device->device_type == ACPI_BUS_TYPE_SLEEP_BUTTON) {
> +		status = acpi_install_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
> +							  acpi_button_event,
> +							  device);
> +	} else {
> +		status = acpi_install_notify_handler(device->handle,
> +						     ACPI_DEVICE_NOTIFY,
> +						     acpi_button_notify,
> +						     device);
> +	}
> +	if (ACPI_FAILURE(status)) {
> +		error = -ENODEV;
> +		goto err_input_unregister;
> +	}
> +
>  	if (button->type == ACPI_BUTTON_TYPE_LID) {
>  		/*
>  		 * This assumes there's only one lid device, or if there are
> @@ -580,11 +608,13 @@ static int acpi_button_add(struct acpi_d
>  	pr_info("%s [%s]\n", name, acpi_device_bid(device));
>  	return 0;
>  
> - err_remove_fs:
> +err_input_unregister:
> +	input_unregister_device(input);
> +err_remove_fs:
>  	acpi_button_remove_fs(device);
> - err_free_input:
> +err_free_input:
>  	input_free_device(input);
> - err_free_button:
> +err_free_button:
>  	kfree(button);
>  	return error;
>  }
> @@ -593,6 +623,18 @@ static void acpi_button_remove(struct ac
>  {
>  	struct acpi_button *button = acpi_driver_data(device);
>  
> +	if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON) {
> +		acpi_remove_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
> +						acpi_button_event);
> +	} else if (device->device_type == ACPI_BUS_TYPE_SLEEP_BUTTON) {
> +		acpi_remove_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
> +						acpi_button_event);
> +	} else {
> +		acpi_remove_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
> +					   acpi_button_notify);
> +	}
> +	acpi_os_wait_events_complete();
> +
>  	acpi_button_remove_fs(device);
>  	input_unregister_device(button->input);
>  	kfree(button);
> Index: linux-pm/drivers/acpi/bus.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/bus.c
> +++ linux-pm/drivers/acpi/bus.c
> @@ -530,65 +530,30 @@ static void acpi_notify_device(acpi_hand
>  	acpi_drv->ops.notify(device, event);
>  }
>  
> -static void acpi_notify_device_fixed(void *data)
> -{
> -	struct acpi_device *device = data;
> -
> -	/* Fixed hardware devices have no handles */
> -	acpi_notify_device(NULL, ACPI_FIXED_HARDWARE_EVENT, device);
> -}
> -
> -static u32 acpi_device_fixed_event(void *data)
> -{
> -	acpi_os_execute(OSL_NOTIFY_HANDLER, acpi_notify_device_fixed, data);
> -	return ACPI_INTERRUPT_HANDLED;
> -}
> -
>  static int acpi_device_install_notify_handler(struct acpi_device *device,
>  					      struct acpi_driver *acpi_drv)
>  {
> -	acpi_status status;
> -
> -	if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON) {
> -		status =
> -		    acpi_install_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
> -						     acpi_device_fixed_event,
> -						     device);
> -	} else if (device->device_type == ACPI_BUS_TYPE_SLEEP_BUTTON) {
> -		status =
> -		    acpi_install_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
> -						     acpi_device_fixed_event,
> -						     device);
> -	} else {
> -		u32 type = acpi_drv->flags & ACPI_DRIVER_ALL_NOTIFY_EVENTS ?
> +	u32 type = acpi_drv->flags & ACPI_DRIVER_ALL_NOTIFY_EVENTS ?
>  				ACPI_ALL_NOTIFY : ACPI_DEVICE_NOTIFY;
> +	acpi_status status;
>  
> -		status = acpi_install_notify_handler(device->handle, type,
> -						     acpi_notify_device,
> -						     device);
> -	}
> -
> +	status = acpi_install_notify_handler(device->handle, type,
> +					     acpi_notify_device, device);
>  	if (ACPI_FAILURE(status))
>  		return -EINVAL;
> +
>  	return 0;
>  }
>  
>  static void acpi_device_remove_notify_handler(struct acpi_device *device,
>  					      struct acpi_driver *acpi_drv)
>  {
> -	if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON) {
> -		acpi_remove_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
> -						acpi_device_fixed_event);
> -	} else if (device->device_type == ACPI_BUS_TYPE_SLEEP_BUTTON) {
> -		acpi_remove_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
> -						acpi_device_fixed_event);
> -	} else {
> -		u32 type = acpi_drv->flags & ACPI_DRIVER_ALL_NOTIFY_EVENTS ?
> +	u32 type = acpi_drv->flags & ACPI_DRIVER_ALL_NOTIFY_EVENTS ?
>  				ACPI_ALL_NOTIFY : ACPI_DEVICE_NOTIFY;
>  
> -		acpi_remove_notify_handler(device->handle, type,
> -					   acpi_notify_device);
> -	}
> +	acpi_remove_notify_handler(device->handle, type,
> +				   acpi_notify_device);
> +
>  	acpi_os_wait_events_complete();
>  }
>  
>
>
>

