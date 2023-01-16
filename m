Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F40A66D289
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jan 2023 00:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbjAPXHg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Jan 2023 18:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235157AbjAPXHQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Jan 2023 18:07:16 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B602823C64
        for <linux-iio@vger.kernel.org>; Mon, 16 Jan 2023 15:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1673910373;
  x=1705446373;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UY/QVIpnYNYREzRQcUEYya7FU/D/bnXmEBrkhXU0GCM=;
  b=JMUEx7RrJVr4Tm+lm4Eco24HlI4CnsicrsL9zmZK1fHg60fpg0GarMXX
   5dORw+4wt66X2tBdL5W19PYVLmDAoUxqdx1JT5GQ4Kww+NO6NbMM3taKC
   W7T/TIwdyIo48FdiIK05CUidEo71pIQDPkmHQBkMJvErn+99CFfYzz8K1
   zH3uBHmh4yJznvy2k8W61Swaan1VV6o7dxoTZC+zmpLQhLlhxU+YkSfUL
   JtH5mbkZmP5lo59yR+GdJa+vAsjyhDnq96Cmqceyu/ycpNoQ5UcPO9SL9
   gYRiCNDMgdTy1J7O+dSS6wmW2g0sYcL3I1flCkemp4FgJCJEXR05mj65Z
   Q==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PyAR15prlcpYJQuZo6opfw/dETKRRMjruQam9MV08T+f17DMXOiMxlG5eKNFHfelYHbhj+SF0zKIaA49ihGdjIux+Vy4qO1X8m9fxUr4DKmyOw70cn/YeiPBA5B4xa3DX68oxHtdhvAn8wjHMNVJ94UZIJ3gDNeGRYSkgSdVjWV3rqEmU9Kh7lYJ5GBa2qjxw9rUIFaf34jZTR0YV4o0fXj52/BrHSD+b/m9ZYUJv4/KKlElGy1NhHv+39006D2WX32k3q30FXoLtzXoTwvktTk4Y0f0LcAau8r3uNMei91uZlcw6r677Ad5W55Us2ZJNI2/SmcZ0wE5RE+6+9anCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UY/QVIpnYNYREzRQcUEYya7FU/D/bnXmEBrkhXU0GCM=;
 b=lc06hnHoKMCsUFL7I9dx1l9xV2wceVt/Oi+S5xdqtz0Og2W38wHoaLJGBafWmvT5iXkUU6D4pXyWau+MVUbTYiX2DQIv5ssSlCgUviAPTTK7FlFiVVW89cqa0n+Nr1GzSIJyXoJjB99xx05MacdHqF1wPqekykagrqXKl5KcPtqdR1PU+9gonG4jxyHoyxmeN2OOa8LY73T9QRu+H7jARrNl/Qrr9zrk7sMDPQjk7REOZeaSyujGoQZix6ERSVrg61pSOk+66eGWJIUtu1sQ2gbYf80E5RZJk3TDOhFOCsjRRgtKAf8Ndmtf69402qIYDeF//f35QYQwvuoAqVsxfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UY/QVIpnYNYREzRQcUEYya7FU/D/bnXmEBrkhXU0GCM=;
 b=ZjL3xY9njbOIhWOCt9yVegX34OPFPqnPHmyeWsUSEoa5duRy5sLnTNV7ggOBwadV1G3teiiA8kPSRElsXbp9QEG+APwim9uLP0n6L1fzv74hT2XNkcfoiI2j0b8uYXi1ef/D5/VOafOstJvXoEkHXWYu+xyiqqSMsuMKawMqUxk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Message-ID: <6ca87240-3efb-5bc1-6ad7-78c861be296d@axis.com>
Date:   Tue, 17 Jan 2023 00:06:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 2/3] iio: light: vcnl4000: Make irq handling more
 generic
Content-Language: en-US
To:     <andriy.shechenko@saunalahti.fi>,
        =?UTF-8?Q?M=c3=a5rten_Lindahl?= <marten.lindahl@axis.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <kernel@axis.com>
References: <20230110134323.543123-1-marten.lindahl@axis.com>
 <20230110134323.543123-3-marten.lindahl@axis.com>
 <Y8Q6zrJ+AwzmO8KK@surfacebook>
From:   Marten Lindahl <martenli@axis.com>
In-Reply-To: <Y8Q6zrJ+AwzmO8KK@surfacebook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV3P280CA0041.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::19) To AS8PR02MB9529.eurprd02.prod.outlook.com
 (2603:10a6:20b:5a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB9529:EE_|DBAPR02MB6261:EE_
X-MS-Office365-Filtering-Correlation-Id: e0a7ad4e-f4e2-4940-6d44-08daf81640b5
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hfj0uGGmO3iRHA66crUulnkFZ3Hdk31i71NHzm4hd4ZZRwUe3LqkUCB6ys3vFwQN5B99yOhNNQ+L4/o2nYZtiSP1Qcb5F2QfVFYaCMlrtWxRf3x5x2ceGuvBytURxAfOeHWdamMvBHGNd9SYmvnbqJCZzGmRUUJ610jtp33AosHNBGqTQMrv/bXse/QtFRIkcU1oVpvDql05VjM7tCuypaG4oetlKoeJDVxhhRbtON2TqEslhUyz6uDqTzwii+dWj2aMVRnUmk8hEiuS78WysQMY/0pIZ7gcBR+5ffMkMkxBwXm6aXg0uV63WIMLiJT7Qx3q0FaDDmgOcHnYwCYuLX6VdAnMJ7uU36Uo+JOmmT7iqRwhM4Tbmhqi/9rD3Hb4Bwz/XUWHmFsX+JFvxcR2nYo9lJJwQnhd42CYunnGBa2s0A4IoMza8KUqGOK5/GHScvIQKjEVCW4Xexf4lW2JO7KwN4G58yQM07PVv+YytR5Hmbg7Kcp07Az7bjbipXRM4F2CkhMGsgEmS/OR0F/g3KctclVzZ2WLfBDRU/xShZOGVED7D/E//WiETcieU/ZizE1M6wPL5O5PKBmcEmSlH29BgQpZVGj8EroUi5ZhrwGgJQrlD9M71lUFiYJQn7XqQ/f9jOLlkmC5S42eD2MmLBJYF+PwN3iSQhAAMGvJFSYkV3skYwxEU0molg0Q/upMflLk8N45k44lqMdakwyUXjCt7w4t5yum838P55Sf6OZ+Qh3TXYx9qlDymia3+Swv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB9529.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(366004)(39850400004)(376002)(451199015)(31686004)(36756003)(66556008)(8936002)(6862004)(31696002)(66476007)(8676002)(66946007)(4326008)(2906002)(5660300002)(38100700002)(6636002)(316002)(6666004)(37006003)(54906003)(6486002)(41300700001)(66574015)(478600001)(107886003)(2616005)(53546011)(6512007)(6506007)(186003)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFE2cTVaUllzOFU1RVlZYWNXN09WYVFsanpPelRSMXovZnlOR002ekt4T2NP?=
 =?utf-8?B?REF0dDF4bDBoNEN5KzhLb3U0THpXWGFrTGRSVHhIbHJGR2FIbDNIWlJlbTJ5?=
 =?utf-8?B?M0E4Vlh0WVVYWERHSkNleG56WGNyN2VJM3hCVWRjZVdhd09GaXgrL0FwQVhD?=
 =?utf-8?B?d0MwaGxvTGFaUlVodERDNXUxbXpxTi9VYzRueEhDa3UzdTlpQnlta1B6TTQ3?=
 =?utf-8?B?bm5KR0JxN2psbmo5UGlGeUtBRTVMZHFxN29iNy9ZWWxKZzdVcjhvcTZHZ2tK?=
 =?utf-8?B?eE0zZlAxTkx4K0oyaWRqbGlWdEY1dm1Sc1RoSzlCL1I1NTlJZ1dXb2o5M3VV?=
 =?utf-8?B?NC9pNE04N3d6dWJpUDZNK1htRFVUWFZaMm5sb3pxd0pFVzVRRmN5U0FKb0lZ?=
 =?utf-8?B?N1FJY0d4NmJVU0FaM0c4VWlrUk9CV0pyL1JVWGFjRTk5bUt1YytqVWw1QWl2?=
 =?utf-8?B?aGZhTGhBcXF5cFBBeitBbmNnSmV4R2dIZTJmcmNGMklCNDc0eVdBY0RKeVoz?=
 =?utf-8?B?dTIzbE5kRXFzQXFZVU1WczZ2NVFLNm5ibzZoRUdRbUJYcS9wcnpBRXVlbU1I?=
 =?utf-8?B?RmM3ekoxMzZlemRHRnpqVVM2cnhRK0tENHFDeXY0VG1lRkYyYVBEdkFVRW1H?=
 =?utf-8?B?WitIak9MOWY4SUlRNnoxWkZHeXZuMUxFekNqbTFsL3BmV0lRRHJtKzQ4N0VD?=
 =?utf-8?B?NEkrZFQ2L29VUzRkY2xRYWJBcjcvaFF5N2NDVjB1S21EdVhDZUVQK1gxdEZ4?=
 =?utf-8?B?QzhpMHN4OEFidTR3S3g5RXJiZHh0MXhhQlZDN2tkUnIyUzVTTUVzSXdMN0Vq?=
 =?utf-8?B?Tk5TUVkxZXBwZEZjdEtlZVpWSE5RRk42L0R3d2ZSZGtXMUhhMmxYbGJTMVEz?=
 =?utf-8?B?VnEycU5pWG1VaE5lNGVVeUhqTkNub2JHVjhyNjBwaVYyVVVJc0xkUFJscm5S?=
 =?utf-8?B?TkFpWndTSnU5cUF0c3d2K2JDeWg5b0dzc3U0NmVqWDM5TVc0aXdTOENtNmxs?=
 =?utf-8?B?NHFtZDhRUnQzT3o4MkVKVzZMR0NMNFFwNmlBQWNhTTF2Wmh2OEI2a1ZCWVdB?=
 =?utf-8?B?NkZPa0NXMlpNM2NxcGkyUzYxNmo4djZaUmN0L3NTS29RWEJEanR1VFJmTURU?=
 =?utf-8?B?YzArL3NaNmhXTUdVV0drb0gvZmttcUZtSXFuTXBKVjFKZjEyQXBScUlDVldN?=
 =?utf-8?B?SHdYNEsxWW9LK1JIVUFER0hlWE8yRHJiaXVyaG9YM0FrSnlLRVRwOS9DaE5V?=
 =?utf-8?B?S3ZTZlk3NEJhOUNlYXltektMTGdMZGFDT0FJd2hpK3A4SEIwandRTUNFdnhB?=
 =?utf-8?B?NVViTGNGTUFhdHBXTUJPY1hnNlJ3VEE4OHU4WnpVSm5aaW1ka0dydGNOYWJ2?=
 =?utf-8?B?eGs1UzlrbXhxZlI1Q05ZSzVBUFRkTzVFdGRrWUVQdEo5UXJIdEV0QmczVitL?=
 =?utf-8?B?OEZNVGZwNjBzdzRUdkNsSWRiVHQ3UHRBRlVoWHZjR0ZHbklwdXdiTUhPOFlH?=
 =?utf-8?B?TnhIdFZiNVpsRkdveTNuRU5lWXFUbTFkU1hvRlhTeVl5RHViUit4ZGRLbzg5?=
 =?utf-8?B?RVRHM3dYaTRzWis3ZWJ0ajNIUm92UkxFU0U0K0J4NG04T3lGN0FIV2JzTVFV?=
 =?utf-8?B?eGl3Q1FZeEI0WWRxb2ZwY0k0RWtlWGJuQXVrd1dBQTBtSlhQc1N2RGVNMU1y?=
 =?utf-8?B?VHBCRUlKZ0prckdTSFAvdGlKdDJVOVd5UGRWNjdva2FQNkFPYUZZRDB2U0pJ?=
 =?utf-8?B?bVpjOGRMc3RxSUswV3pBTXpmK1BTWUExZ3RKSjlCZTY5R2xrVWY5SXgvOC9h?=
 =?utf-8?B?TE1xZGVCdzI1ZEUyMk1IQzdxdHppeGV4U0lUSXdVSmJ1SUdjYVMvcElKc1lS?=
 =?utf-8?B?LzNURFpJQzRSV3REMnFNM1JyMFE3cXBJL2VpY0I1ZlZHcVh2Uk5ORVVEOUVt?=
 =?utf-8?B?ZjRHLzc4N1RMaFZPRlRtUmdBTmxYcUIybk1KNC9sY0NxMnFnY2RDSDVwY2gx?=
 =?utf-8?B?M043VmRsRjAwYzRHN2FzQW1QeWt0R0ZaTnhWUXdoZlZzNmdGb3pxT2cyVVJz?=
 =?utf-8?B?Vk9PTXpGUEpHczM5bk84cXJhK2VyUVZyaldSTEwxbWVHWmdkeW1weWE1OEVr?=
 =?utf-8?Q?HZ9Y3m6UKe1qGY9kWTbktDlK5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a7ad4e-f4e2-4940-6d44-08daf81640b5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB9529.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 23:06:08.7282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nhlOG4zBL1m/+B0zzx+22jLBNLCYwXt5IoouQ0e7CQkA7ZFyCEnmmkincac4tDGYpmw2TqZrgvk7bs6g6aC6Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR02MB6261
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On 1/15/23 18:41, andriy.shechenko@saunalahti.fi wrote:
> Tue, Jan 10, 2023 at 02:43:22PM +0100, Mårten Lindahl kirjoitti:
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
> ...
>
>> -		ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev,
>> -						      NULL,
>
>> +		ret = devm_iio_triggered_buffer_setup(&client->dev,
>> +						      indio_dev, NULL,
> What the point of this part of the hunk?

Hi Andy! If you mean why these two lines are changed, I blame Lindent. 
But yes, I will change it back to reduce the noise.

>
> ...
>
>> +	if (client->irq) {
>> +		if (data->chip_spec->irq_thread) {
> I have checked the rest of the series and found nothing that prevents this to
> be written as
>
> 	if (client->irq && data->chip_spec->irq_thread) {
>
> This will reduce the noise in the patch.

No problem. I see your point. I'll send a new version.

Thanks!

Kind regards

Mårten

>
>>   	}
