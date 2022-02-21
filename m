Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4704BEB4C
	for <lists+linux-iio@lfdr.de>; Mon, 21 Feb 2022 20:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbiBUTie (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Feb 2022 14:38:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233037AbiBUTib (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Feb 2022 14:38:31 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C3422524;
        Mon, 21 Feb 2022 11:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645472286; x=1677008286;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=B5bUxpkes2/OCh5Z6FyWOdA7QvsUtrE4q0iMEeuthm8=;
  b=V7xWif/h/jEbohJJoxLe9/APtNRjzttIyvdDpan72MvKVpDWnoRTzPVw
   MZl1ZcnXPBunUz+5NBYqWkr8P/W2P4sd0ecBb0SJfKgJikl9hYaasJ4zY
   Sag+x2N1Tvn4rF7e1W2xoZKtJ7bCEitqpqmkufATmCOsak7MaXXls181b
   Qe/by57/ho/B7eyr7RWml9RL+JphIWXcZSa2Saah/4fzclXv6S1q9GafS
   P8lQUFq13UNJ1X1u3X0jA7q/zguI7WEj3BePu5/mjcagCxknmg6c6fdHF
   bKOCAYEF5/8LTi++jqVM0GHj1rQAnMvun9P9Dytm/UFec2Rmyu+WRJujc
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="231529181"
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="231529181"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 11:38:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="507727584"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga006.jf.intel.com with ESMTP; 21 Feb 2022 11:38:06 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 21 Feb 2022 11:38:06 -0800
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 21 Feb 2022 11:38:05 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 21 Feb 2022 11:38:05 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 21 Feb 2022 11:38:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRb1ufAE4Jl8wODiVVK3jChthG5cpHPQHi0miZfmWCttySStMuGZFFX3tn2P+jJ6p4vGMnU/EbSncLOg6nHHpSVn4Ug/W+5mj/u+lvkp3rHmjM5PLn4kI90/iHErPcn9Wd7qsGSuAVeGTJws+lz97V0nDo12x4kYwgXA6BmnZv+VPEtGDApWgC69c/ew6nxESuAsKp1OqMANTclFobsGxYcR3oQWcu2Nb2BbVW6fvikPsxg5P66QXUbTptSSU5/wxRMq9D6rp9RgY728Wn4xzaS6T1SalijkRPy9WuV1LCGhYf8CQgHAYaQHD2hiSnwDvec/2LmM8zVpeN/NnDVr0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbtoIrAUNR5d8tLu6YhGjwY13MSC2P3CHbAJW45pa8c=;
 b=XFHyUFAe48X0jhSbYtdL1nfz/87/LpUm3tirn4rUCc4X7+VuA0x7+LKYW/8tZSt61d1RuKbQID9zsI1y7YiCX1Q2hPlbQYcOuea0m/deDp38xbMH+cBEcyk1OScGEajK0maMqd42s4caNmW2mbuXIP4ilZdtmt5SFJJH0bh/NA2iEsWSixYx+bkyC8eu2rWsGBtF5gBc/X4DFr4zLO1cOCSJkO+1qUwM60TzOhg/mF32uWT5+uwJjTnCgvlsbSDr13Fxz+vdRRKk/WMVztxSqLQtVP2j+rv/fh0RtVs8OmpWWGaMJ9E14sgwOxG7Wr66OP4yf/jRsQpqswjsw2iJ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by PH0PR11MB5904.namprd11.prod.outlook.com (2603:10b6:510:14e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Mon, 21 Feb
 2022 19:38:03 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::6c61:b102:e23e:69bd]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::6c61:b102:e23e:69bd%6]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 19:38:03 +0000
Message-ID: <6cd17744-d060-1094-098d-e30a10f96600@intel.com>
Date:   Mon, 21 Feb 2022 20:37:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.1
Subject: Re: [PATCH 2/8] PM: core: Add NS varients of
 EXPORT[_GPL]_SIMPLE_DEV_PM_OPS and runtime pm equiv
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>
CC:     Paul Cercueil <paul@crapouillou.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linux PM <linux-pm@vger.kernel.org>
References: <20220220181522.541718-1-jic23@kernel.org>
 <20220220181522.541718-3-jic23@kernel.org>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
In-Reply-To: <20220220181522.541718-3-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0068.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::15) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81a502f4-44bb-4b30-3035-08d9f571ad1d
X-MS-TrafficTypeDiagnostic: PH0PR11MB5904:EE_
X-Microsoft-Antispam-PRVS: <PH0PR11MB5904CA4430F078769CC9970ACB3A9@PH0PR11MB5904.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Kh8sQK3cx1V2gs8yp/xZKMpccpkha5YadZBXZbdJjpNFDZfV2HqQPiWcLNEibTze+Dn7teVAp4goJ680nxeu5SNTZZzuyD9xg6c9OAr+IhcUOzJyJ4e+9IOFQlOrYTF0+wJAsu+k+nwDE2hFHbnO57z9iHuyKsUAMi3iGICjBAcYrFE4bXKBVBlBYEkvTVgo5A06ke35NM2+60fB8OD7hqe64Kbe6wd8kPmHPCLtfb5Cz/O37UViOdrpT3dSQ15dmmKUjEsu+TDZgkj8p9yUmweb7rmRstdIp9vB7z08w6Vqse/IOr1tt+g9PUuzhmIIjNigEKYBCb+JqoXdmdnanmKY7zRWumCs5+EeBM9/jiC8q5Fh5O1dN2XFSlJX/1f8YUCu5asS4D13RStKtaOPpBHboDA7OYy8JNXXvJGOJD1Ssj4ecwaw1rpm4Vc2JCYcrSSd/tkJ8XjDLK+MMJ/Jp/DrBAkfS1XjMi6PygALDVEWMv3HYoUy0r39nQ/kdxTxPe9v8EAl6Gpk/7O3RtQ8zYqnOXGVQwoMlBlUhiSIvn6abKI70W7BqMTLAd/ti2f28yaGOOxhTL5AZWy+lWh2ytcm1dDVAJNSYJWlZQI9/YWttFE1c3htUkQKV26JzEnzNvoGlHIC0f+KQwIfmT+lfNiwTkOe9dtPMYSSes0ZnSePsY6rpskFK4FGFb9kNfHU3fCL9hWheCyc9O+9aH8Uno+v9rZy2V8vq+jM8L7nvg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(66946007)(8936002)(2906002)(66556008)(8676002)(4326008)(38100700002)(53546011)(6486002)(36916002)(6666004)(6512007)(6506007)(508600001)(86362001)(316002)(2616005)(5660300002)(36756003)(31696002)(186003)(26005)(83380400001)(31686004)(54906003)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czY3SG1BVjdvMm9JQ09meFUybW9UYktZcy96aUNHNUo3c3NiZStWTEdwdkdI?=
 =?utf-8?B?UWtibTdhM2xiMHNBdWtpUjBvcmRub1lNN2ora3B1SG1jbk9Sb3Fnd0V2WWFu?=
 =?utf-8?B?SkMrTjMrTHdTY0JtVHQybHRyTW1VYThEVUZuc3NTZkRab0FMVkgzVEUrRkt3?=
 =?utf-8?B?bDdESnVqbnVWTFBvdWFEWmpFZkpXaDNab1VFQUtkYkRqaUhoRXZYVnJmMkUw?=
 =?utf-8?B?M2VYeXNTcFkwU0Q5TURDNjF3Q29OYlpkY0x1WkRmdCtlTWFwSjhPdHg3VzhH?=
 =?utf-8?B?Q3dHcmNSN3E5QUFqR2RxdWUwRjBaRG9XRVVGbTYvdlFEY3MrcU03dFVNcTVZ?=
 =?utf-8?B?cklrOWEvaENCQU5VS0VtREQzK2pGSDRtcURiUnJ0SnUxQTJKYllUQjk1S1dj?=
 =?utf-8?B?K3ZHSjhWaXhraC9JbEF4N09ZcnV2VnNzZVVCeGxKb1puRzZFcWw2aEl1OW1C?=
 =?utf-8?B?NmNBL3RTTEMyVkcwVFU2N3YwL0RoK2RjTVUwdDh3bDg4MGhycFkyZVRTL2RG?=
 =?utf-8?B?NUN6K2VkbzkzNDV2OCtmMHZvS2h2Y05nckpQczIyY2dJRGpnZ3pyc2hJTEpx?=
 =?utf-8?B?bWdIL2dRckpKTG13YUpaSTVyNnNqYVFPQjBqU3E5MXdQeERlQ0p5U21kak53?=
 =?utf-8?B?N2lTVWxKZU9nOG9JcVA3UlpuMUdZdFpxV21Tc2NJTGNPdXYzSG4wckxNcHdU?=
 =?utf-8?B?eXZxS0o3MzZnS1pBSkdocFRVNzRHN2NBZXpYMXBteVhMeWlWZEN0c1g0M2Mz?=
 =?utf-8?B?NERtVHNoeVpUbThKSHMvQWxDeWNoeG4vUGd5ZWhpUFVBbUpEeDFMNERKenBL?=
 =?utf-8?B?TkNlQUppSlVHM3ZzclIrRDl3Wkx3T2c3M2VMMmxiMDQya2RUeXZmeUNGY2Q5?=
 =?utf-8?B?T2VRRkVUMm1qTUlTaEJMN0ZMQjZmeGdkbCtGTk9YclZDMUtrTlFyNWgva204?=
 =?utf-8?B?Q1UzcmU3ZWxPdERyWnZzY25lTStML0M4cWFzNUNuL3IvWEpUVWQvcW0zL2lt?=
 =?utf-8?B?SmI3c21UVi9nZXFUNENBS3lpTmV5VHNSck96d2hub1U4VHlzUkgxdFE4cUZI?=
 =?utf-8?B?cDV6TkI5RWUycjYzampvdXRDYWRGRVIvM042ZHhYa1RTSXY4NnJ6Ri9URWVy?=
 =?utf-8?B?VzR3M2hpY3FCOXB3MzZRbmgxZkVBdVZFbGpxa0tnYVBkVzJxQjhSTXNHNjVB?=
 =?utf-8?B?MDAycWtxUHlFQzRabkcycmtWT0R6VnE0aDA4aXl2VlRGQ1JPcVNrUjljUW5i?=
 =?utf-8?B?bVdGOHBiaFh2SVV6SnQ0U2h5bE00ZGl0RDFxK2FIZjUzRlJWUDMrOUpKYmhD?=
 =?utf-8?B?anR1cWZRUVhUT0lQMkxOMEozYllySGUvS2x2T2xQZ24rNTNhQUhzZjNCVWk0?=
 =?utf-8?B?V1Z4Qmk5dGlaMWxNY0F1dURwdEFzQjBRRzRCd2xzbGtUeHUzSHp1WnpYZWVM?=
 =?utf-8?B?T2pZZUZkMmZ2b0poZzNoejk2ZmdnL2VBM2lWTTNTUGVKbWtaWWIweXJ5Q3NV?=
 =?utf-8?B?SmF2T2JMSDhxVWY4NDJHVFFJajlFWGk1Q2FGZmFNajRrQSt1TlJkVlcyNXdE?=
 =?utf-8?B?cTZBa01DQy9rSXd5NWRObVYwQ2F5b3gwODkxWC9oSlI4K2loTmRKT0h3Nmsr?=
 =?utf-8?B?a3VpSTFlKzVGUStxb2RaN3ppakQ1VkJ6bE5WVzBJVi93aDdpcERxVTBwbXhD?=
 =?utf-8?B?bGkzZnVYWEg0ZFg5ZUhmNm1XcjlUcHhkT2p3eW0zWDJRNE9PWTQ0YlM1SjEw?=
 =?utf-8?B?c2x6d2ZDanhtd3BrL1hjaFMvOGZLWWNuckhzOEV1bjhmNk01V3QxUm1wbWtz?=
 =?utf-8?B?aUwzd01Cb2R2TFpUbGF1QWo2NW84SUVwaFBxSGFzSVYyOEZoYnpDdVhrZG1r?=
 =?utf-8?B?d3JuY0ptaFNidEpRUHNoeUMrOWUzUjBneXNMWCs1MHNWRWxaL1RFNmtDc0lk?=
 =?utf-8?B?ZHdsaTRycW1jTWJRYXNnWEd3eFFPRC9XL2V1OHkyQlRTMjNWeEYrM2ZudVkx?=
 =?utf-8?B?MjdMUU1yUVpXZnR3Q2VWdnBpYTNSYUtPWHFXemhGMk5ITS85cUlDdlZsMHJR?=
 =?utf-8?B?dEtRdXRPVEkxWlQvKzNWUlF6K28xcUVTYnZhVlJXU2Q2MitsRHdLdWg4aDg0?=
 =?utf-8?B?Qk1kT2hzZmRxdWV3TitMeC9ac2hHdjhQa2gvaGEzR3NPZ3lpWmNVQlllaXM2?=
 =?utf-8?B?aGdzTmwvMWQxeUlBMlV6a0lzMHdrczBhRnVQZDdHcVNOWDROZ1ozMmtrdnBs?=
 =?utf-8?B?Y0xuTjBJajJMVjdMR3pzS2NBQlVBPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a502f4-44bb-4b30-3035-08d9f571ad1d
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 19:38:03.6772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vImB4e0GKYMXztMmCEzKcg32+3QYET/oaDVEDaOQ45fuvk0e60xriwpxfqb3972I3ecBk8l+xG2uFZL7oTiC4LJWmoEtR/h9UR8JpQMuiJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5904
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

CC: linux-pm

On 2/20/2022 7:15 PM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> As more drivers start to use namespaces, we need to have varients of these
> useful macros that allow the export to be in a particular namespace.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Paul Cercueil <paul@crapouillou.net>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

I'd rather route this through linux-pm unless you have dependent changes.


> ---
>   include/linux/pm.h         | 14 +++++++++-----
>   include/linux/pm_runtime.h | 10 ++++++++--
>   2 files changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index f7d2be686359..112b8125d4be 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -368,13 +368,13 @@ const struct dev_pm_ops name = { \
>   
>   #ifdef CONFIG_PM
>   #define _EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, runtime_suspend_fn, \
> -			   runtime_resume_fn, idle_fn, sec) \
> +			   runtime_resume_fn, idle_fn, sec, ns)		\
>   	_DEFINE_DEV_PM_OPS(name, suspend_fn, resume_fn, runtime_suspend_fn, \
>   			   runtime_resume_fn, idle_fn); \
> -	_EXPORT_SYMBOL(name, sec)
> +	__EXPORT_SYMBOL(name, sec, ns)
>   #else
>   #define _EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, runtime_suspend_fn, \
> -			   runtime_resume_fn, idle_fn, sec) \
> +			   runtime_resume_fn, idle_fn, sec, ns) \
>   static __maybe_unused _DEFINE_DEV_PM_OPS(__static_##name, suspend_fn, \
>   					 resume_fn, runtime_suspend_fn, \
>   					 runtime_resume_fn, idle_fn)
> @@ -391,9 +391,13 @@ static __maybe_unused _DEFINE_DEV_PM_OPS(__static_##name, suspend_fn, \
>   	_DEFINE_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL)
>   
>   #define EXPORT_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
> -	_EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL, "")
> +	_EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL, "", "")
>   #define EXPORT_GPL_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
> -	_EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL, "_gpl")
> +	_EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL, "_gpl", "")
> +#define EXPORT_NS_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn, ns)	\
> +	_EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL, "", #ns)
> +#define EXPORT_NS_GPL_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn, ns)	\
> +	_EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL, "_gpl", #ns)
>   
>   /* Deprecated. Use DEFINE_SIMPLE_DEV_PM_OPS() instead. */
>   #define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index 9f09601c465a..6a8b9551ecad 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -41,10 +41,16 @@
>   
>   #define EXPORT_RUNTIME_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn) \
>   	_EXPORT_DEV_PM_OPS(name, pm_runtime_force_suspend, pm_runtime_force_resume, \
> -			   suspend_fn, resume_fn, idle_fn, "")
> +			   suspend_fn, resume_fn, idle_fn, "", "")
>   #define EXPORT_GPL_RUNTIME_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn) \
>   	_EXPORT_DEV_PM_OPS(name, pm_runtime_force_suspend, pm_runtime_force_resume, \
> -			   suspend_fn, resume_fn, idle_fn, "_gpl")
> +			   suspend_fn, resume_fn, idle_fn, "_gpl", "")
> +#define EXPORT_NS_RUNTIME_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn, ns) \
> +	_EXPORT_DEV_PM_OPS(name, pm_runtime_force_suspend, pm_runtime_force_resume, \
> +			   suspend_fn, resume_fn, idle_fn, "", #ns)
> +#define EXPORT_NS_GPL_RUNTIME_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn, ns) \
> +	_EXPORT_DEV_PM_OPS(name, pm_runtime_force_suspend, pm_runtime_force_resume, \
> +			   suspend_fn, resume_fn, idle_fn, "_gpl", #ns)
>   
>   #ifdef CONFIG_PM
>   extern struct workqueue_struct *pm_wq;


