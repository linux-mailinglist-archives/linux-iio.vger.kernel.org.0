Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCF53F4551
	for <lists+linux-iio@lfdr.de>; Mon, 23 Aug 2021 08:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234991AbhHWGxw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Aug 2021 02:53:52 -0400
Received: from mail-eopbgr60105.outbound.protection.outlook.com ([40.107.6.105]:14821
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234988AbhHWGxv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Aug 2021 02:53:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G621e58+DwBfpV6hre2begip134C+nRe9As6KisfAti2aZwCLwTVXBi+MWda67AhYt3mGsRLI1iIkstSlUiDkeDVpKid1crh9qjSQKX88TTe2BAUnODwIse4FdIrj9e26UO0RcYsCDpuIv537sqUaG/EUaYaHdNCcl7ff659/pc5AsWilLlccciKznmT4qA1LRJoU2VbLkx1Tasp7QIhUYjyQzfqoo8z+pRNpKHbHrj7okSsK3TE7r5TcRANxhmGFdnZRRZYT8fG6E2YeWcnr/ZrNiN0EKxiPDBqMl3nWZff64ybzdXuYLICY7OUzNfaRMDqw4Y+zqCXp3rwlyFugg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2S8Ew/ttGPunQxMQiq5ysxgMGZtW5Vs1udrtbE+pTE=;
 b=JGF2pP+C6JFWIKszjrt5mLPF56sD2ie8JEw1w964gNLB/XHnSBWHceCs5Z3DovDeJKDaTaHI/YSQXDQ9dC/iWehg7nFERNvLyP1qF/1LsdFiNSPfxldCdrFg+kX59WYsmhZt1/amGX1T9eVQB5ChmslADtV50poZEl8ruS+Lr6iNZNJi9X08FUhmg5ZpV4irJikd0PeJwQaJ7eaN53ZM3M1YMevym+3gQclW3zalzxMJjggR2ovjFL5OgKGbP5zMXvVjBbbVwGmSKo0lnERQBCHl/taH16/7IJGXE3ypFtBr2O9q9YAqmPZyEn61K2zMQ4K0pxTYcBspYSOdkly6jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2S8Ew/ttGPunQxMQiq5ysxgMGZtW5Vs1udrtbE+pTE=;
 b=HHILJ7XyGTza/BI/5fpVqDm5kguxMsxQ3O5Q32hf75vceLOf2c3koeiqVYA1e9cXf9l4yCH6pJuaGdXLS3/CAcp+RkmCqK4UL7NGFo/ewyjMgnRZRB4gxWcHRJHTeAs/Xph2OCUC0xBAcwQJfgYtHToHQYtw0FfWzKOTDwDjjmg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB8PR02MB5964.eurprd02.prod.outlook.com (2603:10a6:10:11e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Mon, 23 Aug
 2021 06:53:08 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::35c9:1008:f5af:55a]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::35c9:1008:f5af:55a%4]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 06:53:08 +0000
Subject: Re: [PATCH v8 09/14] iio: afe: rescale: fix accuracy for small
 fractional scales
To:     Liam Beguin <liambeguin@gmail.com>,
        kernel test robot <lkp@intel.com>, jic23@kernel.org,
        lars@metafoo.de
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org
References: <20210820191714.69898-10-liambeguin@gmail.com>
 <202108210716.pxy9O6XW-lkp@intel.com> <CDOSXWS42V5H.4Q06IYCLIBTG@shaak>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <db061ea7-d804-315d-68a8-d2b7ef6468b5@axentia.se>
Date:   Mon, 23 Aug 2021 08:53:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <CDOSXWS42V5H.4Q06IYCLIBTG@shaak>
Content-Type: text/plain; charset=utf-8
Content-Language: sv-SE
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR05CA0385.eurprd05.prod.outlook.com
 (2603:10a6:7:94::44) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.233) by HE1PR05CA0385.eurprd05.prod.outlook.com (2603:10a6:7:94::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 06:53:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 036a8824-d51a-4ab6-d40e-08d96602a9fc
X-MS-TrafficTypeDiagnostic: DB8PR02MB5964:
X-Microsoft-Antispam-PRVS: <DB8PR02MB59642C60E4B547A3C4730DF8BCC49@DB8PR02MB5964.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gpC4TnYoMw3hexeAMEyYoVen3XzeWkb385jWWY90+2xE3krIzTO7SL3M/OWY7Of9dqj1z/66BVZaRIssVTD8v9ckmf6U7mMTdcgm1IuKvCsvZXOdZXObK7XPXTueEBUTNq187XTpijVVZ91ZS//B/WFHhUuHhtO59tB9+zZ3CgB++kerrBP39t1EjQbn+ME6pyvBO18SmnuewB/dap/won5sfMeeoxF+ypdKmm5W85/LYCYcQDN+aqY/0nwYKVZQxFxsoX6BA3lqp3AZ3AAFW/oHrj5qxUrmGbfb2VK3Cz3I7bYZFRwVKf3WwNWowX+aMyR1JEwswJu74jNZ1JpIzpnPF5YcXgYu6TXhzbZKsgQRZvU+Vm+lqAaCLnGcCJsNDsIlNIk3Jw+u+Cd+dr+qjaJyYbG7+Y0gPrWuIJuHJAjZmvXroRiWWDrE7sAYsJb50kIg197LL8GjROWmBHZxpQ/OxkwOHcXwQFeyDnkQldZUHGEh89IHQ0GtJL3Ef1jdgob6tOpA9O36UinWVPDB3Pyu/2Z5J+FGhlPueWJ7KFU+k8aXR4E58NEBTn1uZL6EBguoF7bgj9V2i4IrZLJWw+AqMuimiepcYpD39GflyPJyJONPkbediAoyl31XmNia5L6IAVLQxwN8zsUvCFlMGH5ONvhyqXHxIBuFHhK0jIvlkczle/JxLeYg9D5JJYsbCLFSvE8FuiPwOsM4iQ6vzCg6QVEnfFiy0o3ZtUEX08ZVTgKh+DG4FarWlfZAmuOHaT3F74ogNg8iVmbC5O1OCatCVM9TbkIdF1dnbWEsg7h82xALzy+RRS922dKiwWea
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(39830400003)(366004)(136003)(346002)(316002)(110136005)(966005)(6666004)(66476007)(66556008)(8936002)(8676002)(16576012)(31696002)(2906002)(31686004)(36916002)(86362001)(5660300002)(26005)(36756003)(2616005)(4326008)(956004)(478600001)(6486002)(186003)(66946007)(38100700002)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDhoRGt6RzNSZWViRVFHNkZnaWFWU3haSytSNnFxelZpUFBWdGorZ0hQbUwx?=
 =?utf-8?B?OHk1NjJ5a2RXYmZCK3lGcUxDdEppT3BKUi9ZOVU4ZXorYUFrajV1N3lua0VE?=
 =?utf-8?B?c0xHOEY0cWttTk5SZHF5bUs4VmNpcVdmSnZrS255UmVOTTVkSE9KVWFTMzNo?=
 =?utf-8?B?YkJRQzNvYm9rU1BCSU9KTklZalpGWlhCQ2U2c1Qzamc0UWMxWmVuclBya3g1?=
 =?utf-8?B?d2NGQ2FkNW53d0JXWkRvbWtUNlRXbDVha1lLWmVhN20rbU1UYUdEeEZkVW1V?=
 =?utf-8?B?SmxKRTYydko1a3VRZTlHaHFUZVRFemFGQzNhOUlTRCt2b0tIVWxWaXdQVzda?=
 =?utf-8?B?QkpjZzM2ZnpjK1M2c0hlOURUUXQ0SkdRZ0pBclhseVV4djRsYlY0SnhETlZo?=
 =?utf-8?B?THhZN0R2eW9lKzNlRUpJVk42ZERRWEZFTnRsNHlzbGx1b2xETWhWSytoTmhH?=
 =?utf-8?B?dDZidVpSNDNjQ3ZqSnI4MmpTSGlMUzlJZGVVTUQzM0lQVm5hYm5wcDhGZjVt?=
 =?utf-8?B?bTRORkdGbEU5ZzZpOFMyWlpKU1FUN0pqUjh5TDJ3NWNpTGR3dVlsWVZXckc2?=
 =?utf-8?B?anBxUmhDUXhJSFZocGI4KzA3SUl1dzlkZ1NxbkhtUWpsVjlZQjZpK1RMOGpV?=
 =?utf-8?B?bnRmejQ1MG9HSllOaUx6QkVKZGNoWmt0bkZqQlQzY2dMejduL3V1b0pPcXVz?=
 =?utf-8?B?TVhUT08rWW51SUpEeXNpM1FqOTV5SlByQWhtdVlnUUN0TVVFZVZhak1QeHp3?=
 =?utf-8?B?T2t6UmVXa2ZKWXFIbi96d0E4cC9nbHdJLzlSQmFzSkorbUVnMTZocElaYUFM?=
 =?utf-8?B?OTBHVWFUTlgrOVJGb0Z1TzE3VktlUzd4bzRicG9MRUFocE1RZG00bkIwOVZD?=
 =?utf-8?B?MncvemRtR2Rrd0hzcGFRcXU4K0dzMWpUSUZ3c0dPTzMyNzROUTZMZHdUMTY2?=
 =?utf-8?B?NDhTelRrOWszT1ZSM3RRUGE3KzZZMW5zTTM0WE9LSFdaY0NKMm15dVJ6VlRT?=
 =?utf-8?B?a3NtbWNER3Y4S1ZIb2cvYUJSUFVnblZNYTNmbGwzZ2pyUDlXZUNGQXdHR0Z5?=
 =?utf-8?B?bktCOUlzbm9hSWxoM2luNUszUFZFSnMzNDJlek4yVU5UdkZ5TGlqZStKNEVa?=
 =?utf-8?B?NlBmUG9wNXdBYnlTZ1RtZnZaN0oyWmF5bHRsQ29qYTNObkdqVUhKYnZxN3hU?=
 =?utf-8?B?ektNK3BnbVM3cll0cUhUSUxqNC92VHEvYk1uTXEvYmczSTV6V0FWeTNtd0xt?=
 =?utf-8?B?R1ZnWjJlK2FETk13MHVsTHcxbFhOc2JyUXhqVENlMXcwbytSYUpROWp5MjZh?=
 =?utf-8?B?RmVVem9pUXVHeTdxZlBWcGRwNFgzYllvTjBKV3FYYmhHck5CZUVSSzhQbDdr?=
 =?utf-8?B?Rk1Ra05uT3pka0pVSWxYZGYxSEhpeXo2aTJldkFjRjVUUG02Q0doNjIxMlE4?=
 =?utf-8?B?T1cybytKWEFZZitLZlB3SnE4Yjl3bUtpKzdsNWdIbXNSYjh2MWpJRkQzRDdq?=
 =?utf-8?B?Qk9pU2U2dzdJOFNVYm5JNGx4RjdWMWtRcVR4RndaL1VHeFZiZFgxWUkzbVQr?=
 =?utf-8?B?Yld1SjRTTTJkMURiSmFZK3puTThwSWxicVdFOWl0SS95ZGJ3OVZVK3RKVXox?=
 =?utf-8?B?bUZJUlNUK2FrTXNmU3llckJpM09YbkY2TFNMT0gzUGNUNEJHK1YxNHlScllO?=
 =?utf-8?B?a05BUTAzMjRGMzJZTllJUkNHT3k1V21EVGRtM1J0VnBPNHd6UVExMTl1MXJU?=
 =?utf-8?Q?7eNsvrCVpGadSOp7JlDkWSk9NwdDyJRRKGLLvgL?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 036a8824-d51a-4ab6-d40e-08d96602a9fc
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 06:53:07.9941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xg8kaRsz6cOl/1P4tf5ox90G+O19wfjZFMi9+2/2IWtMvFUN0Evm6edtQSnOdJy2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR02MB5964
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2021-08-21 03:33, Liam Beguin wrote:
> On Fri Aug 20, 2021 at 7:37 PM EDT, kernel test robot wrote:
>> Hi Liam,
>>
>> Thank you for the patch! Yet something to improve:
>>
>> [auto build test ERROR on 6cbb3aa0f9d5d23221df787cf36f74d3866fdb78]
>>
>> url:
>> https://github.com/0day-ci/linux/commits/Liam-Beguin/iio-afe-add-temperature-rescaling-support/20210821-032112
>> base: 6cbb3aa0f9d5d23221df787cf36f74d3866fdb78
>> config: nds32-buildonly-randconfig-r005-20210821 (attached as .config)
>> compiler: nds32le-linux-gcc (GCC) 11.2.0
>> reproduce (this is a W=1 build):
>> wget
>> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
>> -O ~/bin/make.cross
>> chmod +x ~/bin/make.cross
>> #
>> https://github.com/0day-ci/linux/commit/e5c2e1505fa3f8cf9fe6d3a21f3a5c585efc6dce
>> git remote add linux-review https://github.com/0day-ci/linux
>> git fetch --no-tags linux-review
>> Liam-Beguin/iio-afe-add-temperature-rescaling-support/20210821-032112
>> git checkout e5c2e1505fa3f8cf9fe6d3a21f3a5c585efc6dce
>> # save the attached .config to linux build tree
>> mkdir build_dir
>> COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross
>> O=build_dir ARCH=nds32 SHELL=/bin/bash
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>> nds32le-linux-ld: drivers/iio/afe/iio-rescale.o: in function
>> `rescale_process_scale':
>>>> iio-rescale.c:(.text+0x5f4): undefined reference to `__divdi3'
>>>> nds32le-linux-ld: iio-rescale.c:(.text+0x5f8): undefined reference to `__divdi3'
> 
> My mistake, I'll replace the division by a div64_s64().
> 
> --- a/drivers/iio/afe/iio-rescale.c
> +++ b/drivers/iio/afe/iio-rescale.c
> @@ -53,7 +53,7 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
>  		else
>  			tmp = 1 << *val2;
>  
> -		 if (abs(rem) > 10000000 && abs(*val / tmp) < 100) {
> +		 if (abs(rem) > 10000000 && abs(div64_s64(*val, tmp)) < 100) {
>  			*val = div_s64_rem(*val, tmp, &rem2);
>  
>  			*val2 = div_s64(rem, tmp);
> 

At this point in the code, you know that tmp is a 32-bit value. *val
and rem are also 32-bit. It feels like a waste to not exploit that fact
and spend cycles doing lots of pointless 64-bit math on weakish 32-bit
machines.

Cheers,
Peter

> 
> The if statement is also misaligned here. I'll fix that too.
> 
> Thanks,
> Liam
> 
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>

