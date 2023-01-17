Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79F766E47A
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jan 2023 18:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbjAQRJR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Jan 2023 12:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbjAQRJL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Jan 2023 12:09:11 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF392CFEA
        for <linux-iio@vger.kernel.org>; Tue, 17 Jan 2023 09:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1673975350;
  x=1705511350;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pv32XW7P2SOZ1HvhlRIec1TeJkaj3iims5lPqtvAiNY=;
  b=m09sMMV8Q/EZTgVX1lSwyc8TiYCPESKCIyyNxm+Sdgr0WSfbQqeXqsT2
   Ox/m4UZEkWLfy8l+ce/qiG4GLS4PimcrumYMwwrYCfZG4dzrSrZwOhYoa
   nA+htZK6FzYKhplwyg+Nlrs66Oi3sZpS+zhKpjedYOghug4Rc1UbftKGY
   COfdcpFsFPe2EcNwnyahu0hZGei5l+MZLaIt8mltD9ceR4ukNqUaSB0TJ
   SvEHnasf7Pfim0AXi3HMn78Dcbx2yBLt45bDfWhw43paRaCIIuPBSfRyj
   92Etac2SCe3XwcP3U/IwsBkoI9FrHxaN5ojigG467aGZ+aoKIIYd/dEgS
   w==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ED+s+F+dBgsdLyyn0DvAwwr8AKkjcf3APkDkG1Rc/6vbaafl1VE3f+gErO/SeqUvstnAd+BAGXnFAfyPiaNrL7AC/VJIztXUXpxwWM2NCKAjt7hzo/l3dblbYWzoBnJPqRIiFkX81WMKnCrfabu4/Fmgrz8KJpG8RVMJvk7WwD6bhML6st0mmVVGW9IcslAY0L46PycBJ3npgjfRPnhuxypBlfi/JmxtAcUGmCJusZREbhhzfm9q4SmjfM0NeVEAEW5QeThXUeZKvrseCZTBR36v91WyYPJWuzYVels7OnTTKNTJP+KRoQK6nsHZwQ2oxBHNp9kM6qwR9/9vsvI+sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pv32XW7P2SOZ1HvhlRIec1TeJkaj3iims5lPqtvAiNY=;
 b=bTSbOG1pnyFk9A/PtFXvOwWJnM5th5uwClsmRlAsovMfVgLOyWzrH3kkinxwhlgXkPU66oUzCvMd7a2SAxkS+YthEfhBBAhKqWT20vkYADpBLpkoFtiIvQ5y0qLrmqyKA8ahYTsAH6a/+Kj1oi32HfjDWxYNckqU0/Ty1g4+iSjbiaDb+yq7461vftUVXNMH0fq15kk5i4+yO68c9qL/s0zWQ4Tzg44MTSWTBmpZ1nvt8M0NmLHBRv6fnJCugdEuuvQmI0dMniSIEO8FiVkwoL11vq/7rhf1uMx5QpEyiTza5EsOhSzKPBplo2QJn8AIwTx/Gp6UF7/ADwTY0ac1tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pv32XW7P2SOZ1HvhlRIec1TeJkaj3iims5lPqtvAiNY=;
 b=sn7gU+QkTOpbv5WOhiqJL3ZMNYCb/Ei0LYtB9VvzwS1pjqxSLbrPoKTg4ee0asV9hwJg57v5FVqgSS2WmMzZCMb/yAwNDS3W5Yvc3deg9T2OWSsa3myyvmN0v7w2cBcQnGcMFrTAWWLlEsVBFt1X7Sv34YCKHwBCOFizTbL5r78=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Message-ID: <9263ebbd-c757-3032-4e53-c25acc0b3164@axis.com>
Date:   Tue, 17 Jan 2023 18:09:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 2/3] iio: light: vcnl4000: Make irq handling more
 generic
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?Q?M=c3=a5rten_Lindahl?= <marten.lindahl@axis.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <kernel@axis.com>
References: <20230117152435.3510319-1-marten.lindahl@axis.com>
 <20230117152435.3510319-3-marten.lindahl@axis.com>
 <Y8bElUjlLNGFPH3p@smile.fi.intel.com>
From:   Marten Lindahl <martenli@axis.com>
In-Reply-To: <Y8bElUjlLNGFPH3p@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV3P280CA0022.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::12) To AS8PR02MB9529.eurprd02.prod.outlook.com
 (2603:10a6:20b:5a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB9529:EE_|VI1PR02MB6335:EE_
X-MS-Office365-Filtering-Correlation-Id: 3da1ac9a-b711-458a-d18b-08daf8ad89ad
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T6/xpNdZPHU2/ng24mRbi2/Awr3GIbCUIAnElML7ZG5FTmjg8B2Vr9rBhJtTExBOnYTU1foOBr3CicACp22ZStuHEfa6+m6zU54tMJNhjA4ZovpqywWKOQCh1HoMZTtE/7oCmCba/OuIL1IoQZyNerwvALRjSxFbNRSIoAPIgefFQ2azofzwqaD2sGMUppbBhcVOU14DjYgpEsh4DrJWQkh/hlFYe6IVFUTrTXeKlYNVXgvozCV6GNidtjY3IbRaXjAm0V0Jbuw2u2mmZrs5IIP1bjw9463M2eZSrELsugScoreSgxgcmrkeJiJ+dJKhQJnwmG+kOG6rr6BThjuuzDA/tGC6A8cvVkMdmvwJmI8xd5hsXyf8NhAtU+u2qPAFT7UzonrRNH3AK0Au2tglEO3hzfkm0JgGitNJSngNGQKOlRJEfGcatxxmi9eNR+l6kK+t6BJQZ/4gv36Vbe+xt5d9ngbS+5RIGXiqpAE7rnYvjI1EfiNNHeA9HimIN7b2qSYJYT+8YvCqCu+u5CrpFQsaYf7uwZApoSrFkfxB7vZ21FPOii8B3v2y4LZOekaTHRrbA+Cr0HsT087xX2EUhMqUbOTQdn589sNwLbtkJphRo88BForBc/4CnTfIWouzvCM5g/uoVJUwF2w98E5I69YKhk/9C1/BN4YZM2AueE+QvPD7T1OcOpVbACHTxCOTBmguGN5/gdqF+B4dm5A0yzrVjIGUB2KATQodD67+FCPoCZ7debQ+rnfrT8mK0D3r
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB9529.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39850400004)(346002)(396003)(376002)(366004)(451199015)(36756003)(31686004)(4326008)(5660300002)(2906002)(66946007)(66556008)(66476007)(8936002)(38100700002)(83380400001)(31696002)(8676002)(478600001)(6636002)(316002)(41300700001)(66574015)(6486002)(186003)(6666004)(54906003)(53546011)(6512007)(6506007)(107886003)(110136005)(2616005)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0M1akpWeTlmaS9zQzVReDRlYnIxdWFKMHBLRlNEQysxTjlmT0NIR1JNU09j?=
 =?utf-8?B?cXZLUk1UZE5EOWlqOGk3ZUNianV6cDBGek1aeVd0c0FmZ2F2dmJ4OWl5REF3?=
 =?utf-8?B?VXBIc25TdWtQT01ieFo2YlRNZEtSWFZZck9yREZJM0tCV1JIRDJwdHhJVDZB?=
 =?utf-8?B?TXF1Q25Lb2t1VEtETjFBM0NmRERFT1pCTUJUcHVDVUJRUWpPNVovaTgwcHhO?=
 =?utf-8?B?SU84TEMxSERPeEFXM0IrUWkxeHZLdnFzYU5KSXhrV2VZS2hRVkt3MVdYNVZm?=
 =?utf-8?B?QlR3dUtHckUwWEJsNDBLR09VRVFpZk9NR3dyWkF3SjMxOXU3cVhoL0JTMVRS?=
 =?utf-8?B?YlNjVnNDMXF5SllqZE9uZG5QTFJoS1JRRlZXUEJtSlpwaThmbUtxR2tJY1E1?=
 =?utf-8?B?WllKZmdOeU1YamhMVjh4VGorU3YzclZSV0ZTZ2luNVRHd1RDR29COFVTbkFJ?=
 =?utf-8?B?RHhSUVQxaFJwWUJBdEdhdzd6QXo2dmE3enZPb2ZFSFVoRXlDc1o4Z2xaeFhw?=
 =?utf-8?B?U2JQckxJV0ZuOWpIVWFZdXVsMnNneTdQcmNZcHhwUFMvU3FpaTJmV3Z4MG5K?=
 =?utf-8?B?U3g2MHlBV2pVcEM4NWt5VWQ5VTR0VEtRZUdTQWNWamlJdU5hSXdpQm5BbFRx?=
 =?utf-8?B?MFV1QTZWVWpZbVhlV0swRlNNRzM2QVoyUkFYM1ZPNFZXSm5xNTNWMGtIRG0z?=
 =?utf-8?B?dnplWktvMGV6V25JQ1VXekRGZ1BvMzAyaGRLbTBlMWNYcjFkTnk0UEhLUE1u?=
 =?utf-8?B?M2MxYVN0R0JtZys0OFNvQ3dXRlBYVzZUMVhBTW91dXFGN1ZBVHZhZUJhVW1Z?=
 =?utf-8?B?ZjZRRlhJNHdNN0tFdFN3dWZRUXQvaG1Tc1VDek1XeWVDcTZMeXVwaWZSNzRP?=
 =?utf-8?B?bnNRVVlrcktMSGlNQjAwWGVJWUIvVXBrcGdWYUR0c0ExREZ6OHlla1ZzRS9U?=
 =?utf-8?B?OEk5OGxWaWZyVWFUR3hoWFBhYW1OdTFVL0x0M1NnTS9HMFpqRHViMXAxbzV5?=
 =?utf-8?B?TW1kVFlVd3l4bFBXMGhHT3VTaEFPeEtrSUJ3S3E4NW5pT01Mc1MxczNjUnRj?=
 =?utf-8?B?OVZVSzNaN2dDcnh0bEZOL0VOTmx0dXYrRzdSMWxldjlmWUhuTElQN3NQV1FG?=
 =?utf-8?B?V3d1US82RFV6L1hPQTRtU2pYTXFXK1YxNkUyeXNNSEZVUFpCY3NFUDZRS0d2?=
 =?utf-8?B?d3Z3Y0V5bzYzSkxYR1FLd2ZxNVhrTE5kOVJXMzVESm90ZjBkaXRsYVQzUEZC?=
 =?utf-8?B?MExqN3FJcHd0eWd3ck0zNFNvcHFYclRjUXFLRDhneVE2MlJTNE5QRUM3TTBV?=
 =?utf-8?B?dWhjQ0J6OGg2ajF2MmZiazd1ZEVDQ1ZmQWE2b0x1ZDZ3c0piYXVlaHQzditL?=
 =?utf-8?B?ODQ2L0NmV3pCaC9HSFhuODlwbFFrbWxZY2xXQnJpY3krVlRBazU0dUxsMnYy?=
 =?utf-8?B?bjB2Qk8zb0ROOVNheXNSNzU2RUFyd2d0dEhxNmJ1Mi91QWlZZDc4NVlBNHdB?=
 =?utf-8?B?YXpSa2JLRklVekNSd3ZwQ2Z1YkRxVWhCYmVwcjAxblZ6S0RmOUc3ZXhMSkh2?=
 =?utf-8?B?MFR4T05kYWNwQjh6cHVmam10RVpuUWU5aWtuN3hNSVZ4RCtaSG5aeWVmOStC?=
 =?utf-8?B?SlhpZ25OL2xFMEhHRXVoc3JVWHIyZUNwdXg5MWwvaFNmNlJVQzdtOXN2ZkZ1?=
 =?utf-8?B?azFESUNzK1IxWDlpNU5CZExQRU16QUN5dUlRdDlwZG4zbjhyUU40ZEhHbURq?=
 =?utf-8?B?T1JCV1ZJaHphV3lHNm5TRzhnS3hpbVZQSmsxN0FIVnBTd2NCc1lGa3QxNWNH?=
 =?utf-8?B?QmFWeDlka3g2TFFRU1dkN0VMRjQrZWxOSEFlaGNVVmo4TXFRZTV6aysvWnVz?=
 =?utf-8?B?NVZkTU5LaDZrT2RMUzU4bFprYmtBN09qUWNlTHdrbkhOUHExM2h4UFVWR1Jz?=
 =?utf-8?B?eGxyMnVzOGZWZFhFUGxPZURVcVZZVjIvZS85WG1KcmNlcmNLdUpFcVN6blA1?=
 =?utf-8?B?cU5RZ2pvZFlOSlcrcFhvbHk0akNFVEdkWnVoZDhDd2ZzV1VnUVJNM01OeEdn?=
 =?utf-8?B?dzlSVkdXdEc1TXo3UG5udS9Wd3pFc1AwSE5NWXlSVGtkWVlRcjBrUVpCNmU0?=
 =?utf-8?B?dGtRbCs5bmx6RjVoUkVSc2VHbmFkZ3ZTTUUrdnlPdnArL0NyTlVhM3BMWElH?=
 =?utf-8?Q?PAfBO2KbRgyzblD8hGuBXH+1i/h3uW2pdo/kidYRw1b7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3da1ac9a-b711-458a-d18b-08daf8ad89ad
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB9529.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 17:09:05.0652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kEOyfZtszHho//XsOPnS3k6x+hTWza2rFbZCoAB3sBtsbU1Pc3T8OCbG1fBe9318qx/lzKzVTDrZwhMxVeHwQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB6335
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On 1/17/23 16:53, Andy Shevchenko wrote:
> On Tue, Jan 17, 2023 at 04:24:34PM +0100, Mårten Lindahl wrote:
>> This driver supports 4 chips, by which only one (vcnl4010) handles
>> interrupts and has support for triggered buffer. The setup of these
>> functions is hardcoded for vcnl4010 inside the generic vcnl4000_probe,
>> and thus ignores the chip specific configuration structure where all
>> other chip specific functions are specified.
>>
>> This complicates adding interrupt handler and triggered buffer support
>> to chips which may have support for it.
>>
>> Add members for irq threads and iio_buffer_setup_ops to the generic
>> vcnl4000_chip_spec struct, so that instead of checking a chip specific
>> boolean irq support, we check for a chip specific triggered buffer
>> handler, and/or a chip specific irq thread handler.
> Thank for an update!
>
> ...
>
>> -		ret = devm_request_threaded_irq(&client->dev, client->irq,
>> -						NULL, vcnl4010_irq_thread,
>> +		ret = devm_request_threaded_irq(&client->dev,
>> +						client->irq, NULL,
> But why first line has been changed now?
>
Sorry! I'll fix it!

Kind regards

Mårten

