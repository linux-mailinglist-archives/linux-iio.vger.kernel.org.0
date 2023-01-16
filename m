Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57AFF66D327
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jan 2023 00:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235508AbjAPXbD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Jan 2023 18:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235515AbjAPXak (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Jan 2023 18:30:40 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FFA2D155
        for <linux-iio@vger.kernel.org>; Mon, 16 Jan 2023 15:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1673911193;
  x=1705447193;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Lt8fgROi3NF+zrq0q0FhEhP0QCCrC6II/aF30eSxjUQ=;
  b=eL8wpT7vaRpiWDwMsK5jr530akeuKX2btNy7E7JH0n8FnSgUC89CsNo9
   ShmWGcCq25duEYnUtP065fXAKKJg4hOsCTJLv+OdxEg2LrbjXKaZqF/6B
   Og3iPkEdrXiRB1+Uh5apxXiyBCwfUgRx4sZUTxgMELLCu4BM/qdtwFUjR
   9+ICNWTAj+0ldhj8N+8dab1BEPd82dYRqHEmXrToIdVtMjMWeeuq1E8f4
   iyWiyP/JCxbRwibZ5bMXESmZVMJAwSepUgrZS3Ccmvh/gt8+DKeF3mg0G
   ghQ55sdkS4ahXP+Id5VcmUa02mMY6jXB2icj5h6R8LPw1DuKfs7Kp0geo
   w==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XqVphi8aHGyrIodcnpf+R0cLXb+AV6J/jzppKncjU22oN51vy/RDM6gDTc45iOxw1hXoQEI0M3igHHPdiVwLhOAmODp3trkXTtmvqdLWX9h0SY2/wt0TFLpjbcrIOTRgpLR+MiM/6A6w1GhyjkfqkrkT9AK0YnVqMx3T9Xn6DseAz7BnUgA6cqpx49IBV+mc9/nN7tKa+6fOg3NfWw/NkFEgud+id75XaX/LsYtOKNbjZR6zJPSRQgVAoDBtVn6Bc2LFXeWFQF7ELL0Mnpt1BEE4HLSN2F8s/LIKNCyKVxea4zKumBFwv7bkPW+mY7FDdmN3vrOr0yKiXElp1MZPFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lt8fgROi3NF+zrq0q0FhEhP0QCCrC6II/aF30eSxjUQ=;
 b=Mft0WPHr1jXh7nAcIHdR8vmsyX8alnl/AVtv4rGkA2Xu6kZBUfgQkCR8yEwVm0W7SbbxkmRNJvY8ueg4Zkmjt2zb1DA8nOPpZWfpNMaVbHsz4/cyhsPIpd9Py3wpZVKduhtLYrgB+nkUEe4oziCOhaIHBWPbBjYea4fJ7q6TXRw1ExB6hpWSNOUolahvpGF9RzCmd01de0Q094SL7s+BO/+Hn4+t9ka6lX/BIY8JOnHig9BuC9poGeIA3QkFcwYMHIMkRd6eHry/bW/WGPW2dumIg1PVF3w75SXt/ZIo9a8EYMKH0vxK+dxW0jU9pSKy4bbAIeCiPKHorU+97t+jwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lt8fgROi3NF+zrq0q0FhEhP0QCCrC6II/aF30eSxjUQ=;
 b=QV3bSZg9RPj+taSS2IhGM8go0hF18emZOC0PoD0h9TtP3pd4A5RdWRkGcxm+Uka+rY4B4Mm9OSe1nSKCJi+qAVl79Ut4lcbsF28JFQ5H1qrDh5WT1cI2yvycg4xWaYIqA64WnHavFgWJy8kXNsrMhE2gMBoCfejN6aB10ZRPIm8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Message-ID: <a5851acb-be2b-9d41-8b30-ce5094e34af5@axis.com>
Date:   Tue, 17 Jan 2023 00:19:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 3/3] iio: light: vcnl4000: Add interrupt support for
 vcnl4040
Content-Language: en-US
To:     <andriy.shechenko@saunalahti.fi>,
        =?UTF-8?Q?M=c3=a5rten_Lindahl?= <marten.lindahl@axis.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <kernel@axis.com>
References: <20230110134323.543123-1-marten.lindahl@axis.com>
 <20230110134323.543123-4-marten.lindahl@axis.com>
 <Y8Q5+9WogoIeFMmX@surfacebook>
From:   Marten Lindahl <martenli@axis.com>
In-Reply-To: <Y8Q5+9WogoIeFMmX@surfacebook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV3P280CA0039.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:9::8)
 To AS8PR02MB9529.eurprd02.prod.outlook.com (2603:10a6:20b:5a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB9529:EE_|AM7PR02MB6356:EE_
X-MS-Office365-Filtering-Correlation-Id: f4d041ba-ce30-448c-02b2-08daf8182a19
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XzKQhS8yIT+1e/vWZjKuRjErgfP7Qse90rQhjnI23FeBL9x9BlSHC4Zd8WVgK2E+T00CyevWPJ2wYu37zp2QZfP8qhvVAW5KaZmE+irnxqRWEysBF65lgbVXWJdZ9zS+XSxFBLtQM/d8K0ainX0PoDm6p+Uqihj7p9TOrsbZNpKVmecV4cGl7X3b+rR0Pxy1RyOnTuGLFWat04CKNk+Ud5hWfcArczfTkMl0JB8hJOp0cR7MGOLqVCk+B12aq/l4ALKJv9ivnkjiYlIxkPkwbMVrC7h/WsL53vJkToHvjLbSP+bDsdi/A1eDrkPRPEw7gkn3aTaYM222Lz2CRAuhcMRSi6eNFOMX1lj+lTRnHJr1xpjCfR1ihNwWbP0EqbS4YiEgxpEqwplbazAXZGycfHQrjeUsQ71+OA38C3soOZIJ5y0hyaM3KV4Zhh33oGXabMI+Xyzxg4WHnJxAeyFworTUQ9+pWmX0LKSmuOvHVR2i1r546NU9+l9McXN4f65yqDJ9qGa7VBZskGYw8S359WiK+s39jh4Bx0/L6tLiwzoSlWhCFqQvYM/CFkPquUyvTQ6QjB5Zt7OjHKW0zF3YPNun2DjA4ROCCIEnn2cWDiCmgl9i4GGsztnmUHfAEQZ0Cw5F3XR8NoRg/O3Zb1WBRWJODXbzS4vjxBnKOL5fEXR9xz2/KsHWzHjjdRqWoHZl23P2YVSEezUJ6IoCyf1ZUE2x7SI7oSHIClNEs2aKGp0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB9529.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(366004)(39850400004)(346002)(396003)(451199015)(6636002)(54906003)(2616005)(4326008)(8676002)(66476007)(6512007)(66556008)(186003)(31686004)(66946007)(478600001)(316002)(6862004)(41300700001)(8936002)(5660300002)(4744005)(6666004)(83380400001)(107886003)(2906002)(53546011)(6506007)(66574015)(38100700002)(31696002)(37006003)(6486002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEJsbGh4dk1jNlFLTTR6cmlOWnNsYm5jOFdONS9VYXVPZ2NZVDVqWEEva0xt?=
 =?utf-8?B?cTBrbC96M3Rpcmxqb095L1d0Y2ZicjIvNkpramk4Qmt2ekdEVVE3RS8vUnRi?=
 =?utf-8?B?RTNLYzVOMnpoY29VODY5WkhlRHh3ekRhVHJGajRHS1oxaWpQTVA1RmRYVG5y?=
 =?utf-8?B?TnVwd2lsRUJOYjVBMFJCc2FCOFZQZTIwcDRldG5tK3ZQaXlBeldBQ0o1Q294?=
 =?utf-8?B?OTQxaitQdWJLTmR4bTdMY0l0bHhVRk1MNlg2NzkrZ0hkZmZRTzl3MmVNY3Mx?=
 =?utf-8?B?aWdtcEhDZ0JHKzVSMUhvZkQ4M0U5RFVaTG5ENFNHR2h2bDY3cGlrVldYZm00?=
 =?utf-8?B?Y1hncXdXV3VQWWw4WVVNYlFYeDRSSVEvcHJnYmR5b1FmOHhhcENFZnorMExY?=
 =?utf-8?B?Y3NmU1cvR0tObUR4bkcrUTYrdXJuNTRVaEYzRlN2TkdBeHlPNzNkeTR6dGZu?=
 =?utf-8?B?aGZjVHZ4TlJ6RklJVmpXb0JGa3I4T3p2bEtYWStVaU1zUWNqQ05UeXhVMHpj?=
 =?utf-8?B?Q29tM3E5dlZFdHUrbWhUTTI3eDVDQjBFYlZjckp1TzRKVG51V012V3hmdW5F?=
 =?utf-8?B?V2gxMkxDY2dGcGpGZExaR2J2akMzN3J1aTU2b2JDdWFUL0ZGTVJ3eGdxaW43?=
 =?utf-8?B?T3lTajI2UUhHN2RWMjQzTFdOaTd3RGhRd0dVT1RtRHB2T1ZJbkF5L3VkRzZO?=
 =?utf-8?B?Q1l2RWRpV3BsSkFTZlN0LzZqRTJUcExLNWQzSHE2QjF3SlhJL1Y0NnVBOEV0?=
 =?utf-8?B?bTczMmN6amtGWUlNUkV1Z1JnaVgwZUY5QWl5OUo2a1VXeFUvbC82Wk1EdWdx?=
 =?utf-8?B?d2VSMkxVMjh3YnVYYU9haTlSZVlDVjhMR3l1b0NIaVN3blFkRW8rajA1d2s2?=
 =?utf-8?B?bnVxYzBOUVI1ZnV1a3FMYnBVMXRQV2IvTndZWVI4YXJ6ZmRSNmgvVHZCZGNE?=
 =?utf-8?B?Qnp1WUtKMFJiTFl6RWQ2VFVnSmpHMThGelE4eHlRSHNNS0xGTnRucHRBT1dR?=
 =?utf-8?B?UW8wNmJ2UXRWVXlWNVZPWCsvY01TaGFJSVVHeDNsaGt3VXUxb0VUc2gvcEdt?=
 =?utf-8?B?cXFIRjlzU2VVd0hUeEo2UUwxMTRCN2F1K0FQZjBoc1Y1eXdpcDcyRzdWWnVU?=
 =?utf-8?B?R1BFTjhQVTMzc05KQmsvRGtTZWdpYnphV0wwSzd5UTl2OVVyNEQ0Y2piWGxu?=
 =?utf-8?B?YXVRUzZIenBiWXN6RTRxdDVVVUhXS094NlUxOGIvNC9oMW5rd0JhRmM3Qzl1?=
 =?utf-8?B?cW5JZ1NyWXRlOUlKVXpnZlhxTDlSdkprSWZyS3RWV2dKajd4MkVtV0NVQ29S?=
 =?utf-8?B?a0RUNkROZkNJdVFXQ1N5dHZBdmphdllnS3dHa3pYWGxoL003TmVtRHdLQ0N2?=
 =?utf-8?B?WnBhRitUNnBGSCtFaGxONUE5OUJPL0dibkg4UFJUVTBSZ1hDVERTc2FyZDgy?=
 =?utf-8?B?VVQ1SnJYR2pJS3FZNlcxRFpqOUxtOXBsTm4xa3k3czExY1lyQUQ2eFoxNng2?=
 =?utf-8?B?T1gwOG8zMldsZUNXZ1VBQWhSNDNTaVVrRUM4NjNEUzN0cVBtVnIzcndycDhI?=
 =?utf-8?B?QVBWbC82dGpqZHFEZ3ltUXE4U0hrRHZzajlydGowS3U2WDl6L1dQWXNCd2lk?=
 =?utf-8?B?YnVSV1hoYkNEM0tSWE9XQnhISTNoMU1TaU5kMjVWTG5oQjBWb1NZRVRFZjFp?=
 =?utf-8?B?OUovQ2Z2YUhDc2V4eXhHTkN3YlRYbnFSSTNWM0drcXVnKzNGS1FRNDJwM2RW?=
 =?utf-8?B?dG5POW5TYXJpYXZGUm5xbERlbVE3VkVCSlhWOUFabjVWKzkwWDVxaGo5TXQv?=
 =?utf-8?B?bTIrbThtM3VUbXhXczFQUGc5T1I4UWRqeFhoTWkvOWJpdGsxRWpoVEd6Z3FR?=
 =?utf-8?B?RVRmSHdZZjVmRnhyTmhLS0J4THI1ZWcxUGQ2YzIrekFwK3BqRnpTZ3hrSWw2?=
 =?utf-8?B?MmV0eFJtVDBFOStseWFpNHIxMGtJYmc1MmZJNnQ2UThHL1VFSmROdDAzVFEw?=
 =?utf-8?B?QkZZUlBEL0hQODNHSzdiak90NzhUcXJ4cXQ5TWwvSi82eE1SVzJHcWt2OEVY?=
 =?utf-8?B?ZlNIRndwNXlnUG9lU1VQdDdEenl1YWhzazczSjUxZWI4MUMwMGZQcFNmc2M5?=
 =?utf-8?B?a2hGcTJtWGwwcFhxWVZZeHVUK0prZ21BSkI0Yi9vL21Ta2VsM3pwalh3NGNx?=
 =?utf-8?Q?NrRXSB3Xm/wTzSi6i0HKmKt91VHX8ThKLca3kfAS/9y9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d041ba-ce30-448c-02b2-08daf8182a19
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB9529.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 23:19:49.6469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fSSJN2phnNFIE4kAe59qgYgKAtzftZHJTKQ65u+jOxglKdRnXzKyNMAFZ965AwkT5YftqDPvRPCqjdQQprInSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB6356
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On 1/15/23 18:38, andriy.shechenko@saunalahti.fi wrote:
> Tue, Jan 10, 2023 at 02:43:23PM +0100, Mårten Lindahl kirjoitti:
>> Add support to configure proximity sensor interrupts and threshold
>> limits for vcnl4040. If an interrupt is detected an event will be
>> pushed to the event interface.
> ...
>
>> +	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
>> +	if (ret < 0)
>> +		goto out;
>> +
>> +	val = (u16)ret;
> Why do you need casting?

Hi Andy! I usually do this when assigning an int to a u16, since some 
compilers may complain about loosing precision.

In this case there is no such risk, so I guess it's fine to remove the 
cast. I can to that if you prefer so.

Kind regards

Mårten

