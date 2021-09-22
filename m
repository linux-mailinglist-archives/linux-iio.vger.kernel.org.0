Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2E74149BE
	for <lists+linux-iio@lfdr.de>; Wed, 22 Sep 2021 14:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236001AbhIVMzJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Sep 2021 08:55:09 -0400
Received: from mail-db8eur05on2132.outbound.protection.outlook.com ([40.107.20.132]:53984
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236002AbhIVMzJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 22 Sep 2021 08:55:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VdQ9Z6odikL3p3xOK+nompZgsLihqOuP05cjvd68RiGBobuRKFLfsf+WF0As5NZU92srHgIurBCNwmkS8k1XPECj0n9y/sXYKzIg4wT+DhN1JtehA2OM2ErsNNQFezoUHeWPgsYHYKeWv1n0uiZp2Ftd075fmphfOVmbKGOXa7mDtSfB7eoJ+x7HswdNVfzQ2x3rXbGG0ktGkqcZ9GRotakKOnLDVI4Mhqbry+FUuVbItW/0SjT6ycmzsK12sldvRZErmrzbQw9wHNTXxopSqjZXVtxZImZPzNn2RNvWfOnZCtAICHyWSPUeJMf/8R4bD3+y56w3DkXCHLc5oxaExA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=36iFNmcVeQnVsKQDYYIB3HAHAIoczNet43VjBAPUR5A=;
 b=OFefWVdOUIlE74RobnjHqo+sETiRszggyVkgwqmoBCV+2kUgEyCHyYjNxLgkOwThmzGCh4K7unIHskA8EmhiT/W6FTRbKvN0poeFu7KVx53XBFdP/RUVcPdtIgJKkuGiZAWXIu/dwmbNqJUux0rzHfHIINYAbc1S9iXAWYDada5yd4vgyJvWNttc6d5KABg1lDJ3wI0j93SypRp5SXniMTO9L/uoXB/V5fjgWb/wlG3OBjNvzkdZphf2TI6fUk+xvULtUYj6e2Mda5BboT6fzLp6UYiDKHUDOWU2x37z22467NvPtSAXQmtXGevIeulWtLE4Nc2+4oiFTu4eVIyPIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36iFNmcVeQnVsKQDYYIB3HAHAIoczNet43VjBAPUR5A=;
 b=kGleJev9WL7EUNhmDIDH6DwUWJZI5TP0mF34eL/LRXcDh46YyCUOHCGb2YwGdWPogNyJdZRned2KJAC1iHn1wVoh4K1tCil0NjZw70/7avLnCmrf6l2VATYFsSMvHpdhgfm82faHxxHlM7z4kt0/cBI3xJX9ou71+X2nnBFPo+4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB8PR02MB5387.eurprd02.prod.outlook.com (2603:10a6:10:ee::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Wed, 22 Sep
 2021 12:53:37 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::35c9:1008:f5af:55a]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::35c9:1008:f5af:55a%4]) with mapi id 15.20.4523.018; Wed, 22 Sep 2021
 12:53:37 +0000
Subject: Re: Reading ADC that comes from a multiplexer
To:     Fabio Estevam <festevam@gmail.com>
Cc:     linux-iio@vger.kernel.org
References: <CAOMZO5Cwdn_-to8G+RvVUbG+UkYM7+budUsvWVLeY7PutoO2Mw@mail.gmail.com>
 <74f1974b-ac08-96f1-887e-99580a2bf212@axentia.se>
 <CAOMZO5Bhs3qLwgqGYHO7Oswr1qvarkzmNFyWQi3-_geZTj3BVA@mail.gmail.com>
 <CAOMZO5A0a20_+JHmCMYXLuZYCE04GDTqt0x_GXtVxA5Q4MSAog@mail.gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <73d0ede5-8a35-7e3e-e685-235f39ea28e7@axentia.se>
Date:   Wed, 22 Sep 2021 14:53:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <CAOMZO5A0a20_+JHmCMYXLuZYCE04GDTqt0x_GXtVxA5Q4MSAog@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR02CA0098.eurprd02.prod.outlook.com
 (2603:10a6:7:29::27) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (185.178.140.238) by HE1PR02CA0098.eurprd02.prod.outlook.com (2603:10a6:7:29::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Wed, 22 Sep 2021 12:53:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 217ec587-bda1-48bc-d06e-08d97dc7fe5d
X-MS-TrafficTypeDiagnostic: DB8PR02MB5387:
X-Microsoft-Antispam-PRVS: <DB8PR02MB5387A0D758970D194ED81460BCA29@DB8PR02MB5387.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xUpdkm+JQxCLQzR/Aj93U5i9xS6sZRdTeBU8fr9bKFq04iihwIOuAIcKJ/eBteGHC0KLeI38wh/DRwx1uV69TGoi9wEme9aGd1ioew9YWuSxLaLSq/bzyGzACnJ7j3k+tDF81Vitw69wfy385LBPTcFN7XGuAOfnl/4LS6WSWPj5uT8M1hxk3WuEp8Jb5JeZUIeeDhAEBCBhIa86hJVxGDJPM6w3KwJbvxHnohASy+HItDDZ0+8nrY/rIxc/aTDUHOEtmmvbj59vOY9K51Kqx8q9aU8mextSWHUjlJ8INEM1lDJ5+bRKMG+0NQ7961FWqJ5bCkbjHcBhyjRZVvNoqMEuDyWGLb+LgGE8gRdKjA5MnR9xg+6iEnp/rxykqd2zXItAQixWAJFWs5+y0AEVbviwd4DLGeuRSKwUtxvwQONT6tbZ0DMj9N911MmvsmCC/tOqvDhcNEckIRa5uGWPT/WfNpNEHHb0UbtxrwvNAgTI+98k+k/AhP35cmSEU5PXrQR1vJZde7FSRCaC44sAeTs0B478zf+vttTCHUuqE4YqWKa/XF6hYTlSW1hV1wORE9z6kMv0bnQeutANgCDwbXoXj450Lo5Mqswr7ArKcSmWG5W/Ui1EKBVrHTjeTjvHLfMBMNbC7oXP9mpWYjbe05nx/8Sc49/MKtoDgfzBYYFzLPtrGapSveTxSK7Eur9IpwqJesp9iZ7LFQrbMkVMCE2Xd2Lw6kHNyLE091O0ysU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(366004)(136003)(376002)(396003)(346002)(66556008)(5660300002)(8676002)(508600001)(66476007)(316002)(66946007)(4326008)(2616005)(6916009)(53546011)(26005)(86362001)(16576012)(956004)(8936002)(6486002)(38100700002)(31696002)(31686004)(2906002)(36756003)(36916002)(186003)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uzlsbit1VDE4TU5iTTNtcTdQL2JOM3BDbkxzbEsrWk5BWTJ0NzFYRy9WdVZl?=
 =?utf-8?B?bFNOa1pNcU5OdzFRcUczTUIvRFp2NUtsUzQvd05GNGNlcEtNTE1zYlBBdmVF?=
 =?utf-8?B?ZWJVNTVqZlJxU0hucXliZ211UWVQdDV4dFVDNlR5ek5pSS91OU5iaDR4NmNG?=
 =?utf-8?B?NktOREVPYVA2UnVXSHlJai9kc0t2aUNrNThwcjA4OUtlVStBbmdFMzJGUzA5?=
 =?utf-8?B?ZEVYbjlNeHBGV1FKUFdmTmNJSXNjUDFUUEdFbEF6UEVoMU8xZjF0VWNRYUQx?=
 =?utf-8?B?Sk1MSGlvZkh6RVNSS2xuZmQwRmRTVXd6Yk0ybTlUdGFNUlFUZy9FTEwvY2ZL?=
 =?utf-8?B?YkRtSUVnRzlFVktsSjVDYWplTXpYejIwNUU5ZjQvcUhMNStRWXZUb0ZrcnJz?=
 =?utf-8?B?bDg5VmxHT0ZYS25ZZHJSZ3EvRzN0YWp0TE53NzBqTUFIcDVYaENiRWwzRlgy?=
 =?utf-8?B?NVdBVzVIT2M3UzAxQ2M5VzBNZUJTSFkzTzJsTitRUkJyM0FhcVBZb0V3MkJj?=
 =?utf-8?B?K240cmdHNHk5enZYWTlZZ3ptaEZ4Ykw5UG5qVzE5TGlKMUlWVGZhcC9jTmFT?=
 =?utf-8?B?MG1YQk83WVQxcW5OSUhxdzJxV1FVYlFlc3ptbXliR1dzU3lmZHczcm9sTlEx?=
 =?utf-8?B?SUpvdEorR3R2TExiSmRqVEJ3bE9oL0x2VUxuTlN4eW1yajNwbHhxQ0dTSU5v?=
 =?utf-8?B?QkpmNjViSVhKRFVNdG1MQ1ZrZzhsNXkzbHNMeVdUeGtQamRpMFN2Wmtmc2xR?=
 =?utf-8?B?WFFUREh6YXZ2UWhMMlNhS0lrd1I3ZzV0aC9saGlZOVBGT09nbzU4S1lkeEdh?=
 =?utf-8?B?cEFuZTY3dWtnRTVqV3hnRWJBbmowUThlUk9FLzNCV2N1YTBSQWQwRi9yYXBE?=
 =?utf-8?B?bEhsZ0FVSmkzMFVDa2RhQzRKWGg3TEhubjdFT3NyNlg5a3FOYzNLL1A4b3V5?=
 =?utf-8?B?cWthR1l1MkVWRE8renRRVEF2enVSV3hGYnB4SUVlamhZNi9Ba0FCc1NLZU9H?=
 =?utf-8?B?SXg4NVVkcVJSdzNnMXJzSTVIUy9ZNEN2R1BjTUNsUHpoWE54MlY4ZVd0Qm1U?=
 =?utf-8?B?OVlDOTBRVGw0a09Kam5wS1gvS3ZKdlV2cFkrdG5YYmh2VVhTaCtITHBmKzZH?=
 =?utf-8?B?VE9jRGkvSi85a2pjKzJtamJGSTNJTkVnbDdTdnUveElhUWJRU1pUdjRPenk0?=
 =?utf-8?B?MEgyMVRISHlwQjN6Y2FzVTY3Mk1nQXU3N25UM2RZbTJaZ1dwV1pqMTUvSFFV?=
 =?utf-8?B?VmhPd1IzNE16c29wbFNYMnM4UGRaTENFb0RuRklVUk9NWW4zRHNVQ0ZqbHdW?=
 =?utf-8?B?QWlrS3o0ZFdWL1dFQW9LUDhwM0o2M016VFFuSy93ZVJNajFmKzB1NUpUQTUv?=
 =?utf-8?B?d245ZklsKzNkTzhVa0tJYzErSUY2TE90ZXJWbG5OYUlHL2JwNFN1a04vemRa?=
 =?utf-8?B?Q3c4UXpkK3VZekYxSGRNRit4UnpiL1Uwc0JPMGhYTGg4YU5CMWVYKzFyWGpE?=
 =?utf-8?B?UnlzTkMrbDA0eUNLMlpSTzdtdjMvMXpnQzduRjBVYlhzRVFGc0FuKzdic3hl?=
 =?utf-8?B?UmVROE0vSHg1YUpNeHBOcWZHTUx4R3JPdGw1RHNvNjF6OWJMNWpMeW1XTGMz?=
 =?utf-8?B?T1haYktZbm1Gb0VnSmRyT3dxUXpCSjBwTzlvaHFtS2drV254SkpRQkZZZXM0?=
 =?utf-8?B?bm5XcFFDOUJCYkVOV0ZnQ2svWnRkYzBNdlhMNThUZUQxNC8vcXdmU3RXbWFK?=
 =?utf-8?Q?RvtHk+XHvRzU4QYkg6eS0bl93g1cLhymkC06YOE?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 217ec587-bda1-48bc-d06e-08d97dc7fe5d
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 12:53:37.0170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZRfxqZt2WLv+ky6btYWt8JYMrnELUaHwiuWcupqXnYoNqppvxkMimQeB+Bx1GPLm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR02MB5387
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2021-09-22 14:44, Fabio Estevam wrote:
> Just realized that iio-mux.c does not get probed.
> 
> In mux_probe():
> 
> parent = devm_iio_channel_get(dev, "parent");
> 
> is always returning -EPROBE_DEFER, even though I passed:
> 
>         io-channel-names = "parent";
> 

I think that's because the "parent" channel (i.e. <&adc 4> in your case)
is referring to a node that is not providing any iio channels at all.

Just because you added "#io-channel-cells = <1>;" to that node, does not
make it so. The driver has to support it as well.

Cheers,
Peter
