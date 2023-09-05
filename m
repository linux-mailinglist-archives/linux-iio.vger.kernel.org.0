Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD21792859
	for <lists+linux-iio@lfdr.de>; Tue,  5 Sep 2023 18:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244352AbjIEQTM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 Sep 2023 12:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353401AbjIEGNj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 Sep 2023 02:13:39 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2063.outbound.protection.outlook.com [40.107.20.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9766CE6
        for <linux-iio@vger.kernel.org>; Mon,  4 Sep 2023 23:13:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqUvdm4hBig74yT+snSTSE6GtPZyij6nybAc3HG0TNasnSGZVJ9ai+xpysnsW+x0m8BgFHiKbu6wUXh5KsSBs0RtiWYS345BzErODesr43Z+pUAYS57oj3DXZ4rRbldDCQc50+AVla9Z/mkTyVw1F0Tx4ach1T/PYIEOn/7vTyJf2E13rIEoya0BjTqkRThMpfvKze3onXLKWtPO8flUmjeFg76QKQUflj/l2kQi9uH5Q7nAKeTBKzafoxy831rKzvly8TnRc1ldsKkqWIErdB73rBBPdjKdp0OtP3GkJgKpb9Tltyu4NTsmjwf1c3vSzqOX0+FwarmPSrhly4YHcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kj0NLzp+DmhulA/8+/L3L+HXiIwOUA7YyS83rkHmPKc=;
 b=j5ScnGRsqr9JxoaCZF/Lg18oA63UmQSIpEPOW2wuAgtXV7DVB7qSk4lkStA2Fxyq2ntZS6KHNkHBa9vwjWybnD7vgb5kt5YruDJP6XbuAAYdTe6fVnIF5HpkCWXMZKauCDAZTk+QzlOaz+HEg+owIptzc/ZamODj1ZDgwMjkwn9tNzbr32GF3uVW8LyznWZeHataYpIyKvwahFqHoeo5LWpG1Qm9jyzqREaHd+IusztjvaPdJo+5L52V4HgDjd6wvuSybzrhhdj6fFVDiFANkcL/I8o+wSk3MM9PUA0SqDbSYNsNqN9TxULQiDqHGZdVDRy1vWI4Lami6wxZOvjDfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kj0NLzp+DmhulA/8+/L3L+HXiIwOUA7YyS83rkHmPKc=;
 b=I56q0dkEq7meWcvYTFaCZSiLa5tiPUyew3NIa2438u8SkyHf/HPOn70CiPRxojZvzWw3PTIVHpyPqKqjwDkAfeXxWAmwebgI2e02ZM03lXOxRpxBHZO5fC46/n4nVKoOZH5aHXNcVdN4guX1bo42D0e/N9qtAUNoMPB0pSjFmzInsIfoHa7tOCJ9RwTSdXFXiP25ywNMlUOYeWUC/hoCjy7FPnyyrOKMRIJ6qfr7B6KMl8+qse35tYMmO5dCA4ETlS0v5I3mXjumPULJgzv/I8no30h2jpElgk31eb8GQdjHYFy21cP988fPAQ4kW+/+cYfI+mMtj46PxIKMrqUsSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from HE1PR0602MB3625.eurprd06.prod.outlook.com (2603:10a6:7:81::18)
 by DU0PR06MB8525.eurprd06.prod.outlook.com (2603:10a6:10:355::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 06:13:32 +0000
Received: from HE1PR0602MB3625.eurprd06.prod.outlook.com
 ([fe80::cec4:e994:fbc6:5f07]) by HE1PR0602MB3625.eurprd06.prod.outlook.com
 ([fe80::cec4:e994:fbc6:5f07%6]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 06:13:32 +0000
Message-ID: <e12f3459-7025-89a1-704b-209391cb8f55@vaisala.com>
Date:   Tue, 5 Sep 2023 09:13:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] iio: adc: ti-ads1015: support deferred probe
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org, lars@metafoo.de,
        u.kleine-koenig@pengutronix.de
References: <20230904101533.455896-1-tomas.melin@vaisala.com>
 <ZPW+MXuBSYEE1GfF@smile.fi.intel.com>
Content-Language: en-US
From:   Tomas Melin <tomas.melin@vaisala.com>
In-Reply-To: <ZPW+MXuBSYEE1GfF@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0045.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::18) To HE1PR0602MB3625.eurprd06.prod.outlook.com
 (2603:10a6:7:81::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0602MB3625:EE_|DU0PR06MB8525:EE_
X-MS-Office365-Filtering-Correlation-Id: 514dc0de-c866-4254-f81d-08dbadd73ac4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GCD7rwFPtlNalWEqcWpkh4jDu2ah8VjNb6YyMQoQGN9EzzbwTgay8D/XO4wy89KXAaf5XdSdF5VRLtoxfxUovREK6vsxaRcbN32lo6H+/ZZ9ezyD1ce/cIKutOVMwosUmHeLo1YPBvQbMyhwYMopR9Zp+83Pv9s1vYH/e9s1Nf9xDCU2nUJIn/NVvSvNX2j5PqOseEPraGkcyOUuMm/VaFkzg5oFHXNhQ8Fi8UGDHFQU5+gvxMQYFAoaO6Wvz6L+nKFnqW3SRJnXHiqSWfKNRi49ouL36rPncpaWX4YCSVt8hOdD5SAA2moRPyMdzukvScryJdaA8vmxkrUtORYBk+tsJ5kcuERpjbSNFE0xyWJPvIZzLgFuNB9ljMibBz+glog3gakrRk3A7f0dPmHvBGSk1KBcinWN0OvEH6nFkHymAv5PVFc2ImPH+W86duipbzePku9UmrF+SUkROY6UNyI1ogG1LSZ5opu3feVx+PqisfFDwG8jvhg5ISpPYvvuPNZwVVklCs7Gjc2HQbH5j4MZpM5/ImjDMCDYx6INTvSp1/LW0eba5m9DHwQZXdwacj3bp/48nYUf3lN1raUQ4/HoOUnhu8FSfqJ3m/M97BwxGqkx4coaMWYV89jOwAPwnV4P5OrnDbbR2Y2T762rdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0602MB3625.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(39860400002)(396003)(346002)(1800799009)(186009)(451199024)(83380400001)(2906002)(38100700002)(36756003)(86362001)(31696002)(6506007)(6512007)(41300700001)(53546011)(6486002)(6916009)(316002)(66476007)(66556008)(66946007)(2616005)(4326008)(8676002)(8936002)(478600001)(6666004)(31686004)(44832011)(5660300002)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2Q1UUNlMklHVlB4VXdaeDhhVHE4bEV4T2VsTkQxWEwvSUVGR3NsZ2ZUYktM?=
 =?utf-8?B?UVVXWTcyVG9HbzFjZ21FQzRtMXljS1FLa3dwdmsycEJ5RVd3WXI1WjViN3cy?=
 =?utf-8?B?QWkwUHJMNVh2VWJITklTRjRDVmFVbjZYSUlESWkyQzVWRFpDc2MrSHVra0Ex?=
 =?utf-8?B?WG5zQmRHZ2dIRTUvSlc4UFprQU9ORStpV1NNU2hubVRxZGg4U2VCVDdOdWpx?=
 =?utf-8?B?UE9NMXNja0xDY2ZjTm1CMmRYVkluOXBnNlgwYW8xNDBSQThjY3Zpb2I3Zi9V?=
 =?utf-8?B?NXkyNXQzcnhWdjBXMWFUREVPZ1hLVXA4amNWU3UxVkNndys5emJlRkJheXh4?=
 =?utf-8?B?a3pBZ0ljeG5GaUpSZXJKNXFaZEQ2OHFWWkpjSnJNc1JoZitqamdlNE9uZW83?=
 =?utf-8?B?VnAxTjh5ejRDTGYrZmozOTVKL3RvYnpnVW5jd2I4SC9uQVdvTTFOcUZSa2Vz?=
 =?utf-8?B?OTVOREJHNGJSKytsM2U0anp6QWZlT0FOdjlKc2xSM252S24rT1hBUkpRcDkr?=
 =?utf-8?B?cDZJYVNwQzY4b2VEY2xMZlhGaTVnWGpZODFINDEvYmVuVjhnNUhiTzV4YTIy?=
 =?utf-8?B?U2xIZCtnOVI2RVdDTXA2RnZXRGpVd1hMWHhlT2tva2RoQ0RUNVBPeForSm9X?=
 =?utf-8?B?N3BiaUJmRzJkeEJVdU0yYjJHcXJKdVB5VGFYd1laWTl5SUJpdm84SUFCMmRP?=
 =?utf-8?B?bFMzeE1zUDlUUGtoNWFkWHgyYVIxR2pNMXdQV3dWSGZ4ZVNGdUd6cXlMdEdY?=
 =?utf-8?B?RXh5M1BYbVF5ckRTN1BsOWFycE9oWTN6TkxUSUczVjBFVERmM1VIYzR0YS9D?=
 =?utf-8?B?Z3NKNUVKTFpXRnJBd0tJWDMwOStpY1NoQnMwaXhmWERXcThFcG9GdFhPN1VG?=
 =?utf-8?B?ekE3VHhDVlZmWkQwVlJSQVZDaUo2MHRROTc2TmtRbjBibzNjSlJDaDBOYzM3?=
 =?utf-8?B?R1BSNkNkTTUzRVo5UTNJNzVnbzk4dTZaOVBjdmNMdVBYQnlyRHFQQUNtSzhw?=
 =?utf-8?B?K24wSXhVeFZ2a2RvOGZqYkhtbzladnBjUTJVUG1nRXE1MitVcDg0UlNSbi9F?=
 =?utf-8?B?VXNpdEFkNmRqQkh3T2NxYkNtZFd2RDJqK0ZmckpTSEdJQVZzOWNScFY5V1BS?=
 =?utf-8?B?clhkcFFwNlZFMXkrV3g2ak1yVnlpYXFnSTFDaXRXbmY1bmtqOGY3S1BtcFQ4?=
 =?utf-8?B?SldGQnhiY2dZc2tvYno3OUN1OENvdXplQmlyY1VjOWNVNXB6MGNtU0NFRnBi?=
 =?utf-8?B?aGVoVGJ1ODJONVhDY0RDZzJWL1lrM0RnSGRXM0h1UDRnQVFDWG1ISlF3ZGVr?=
 =?utf-8?B?ZkdPQzcraTNId3dBQ1lpRXpoV3N5RmRaZlhWQlNlc0QvTXNsaDVIbjdpc2Zy?=
 =?utf-8?B?Uy9wdmFkSDN4SEl3c00wSFhFaWVwb2lhYWxYNmw2YWZzWFdpSnNWdkhhWm9u?=
 =?utf-8?B?Tzc5RFNUVVMzMTNwWmhIUjdmNFdpL090VzBaRzFqb09MTkM3a3pQMncwMk5N?=
 =?utf-8?B?OXV5b2oySk5lUm5xaDhMRmI5NUNDdjgzMjNXNkZ2QTJGN0pFVDZpdzZzZWVY?=
 =?utf-8?B?SHloeFRDQmFOWXdqZVhUekovQnFTNGE1RTZxVE96Z2RMMDF2d1dXSHFzUzY2?=
 =?utf-8?B?ZGpKWklhR2MzL2tHVWYzV2tHd2JOTUV4enBDUnlRRlAwTlJWaVZQME1yOVB0?=
 =?utf-8?B?T1dIdFZSQkZZZ1IvY2RWMjlnZlpkcGZnb3NtZWpRY282TDA1Q3krbVlycDBp?=
 =?utf-8?B?bDZEYjVJY0lCK0R1REUycGVUb2RkK0piSjB3YXNXYmFpYWllVjgrd21pWXJI?=
 =?utf-8?B?NDZDUXgwVW56d2pmVlVjU0xXZmFIdVRuTTFteFBmMnhhMUo5SUxGL1B1TSsw?=
 =?utf-8?B?cCs0NUd0ZHZJZXdTRFdaaGR0blZNY2ZLNmFUb3IwSCt4U2tUVHl4OERtSmdh?=
 =?utf-8?B?R3UzdFlIR1FNWUtYVHZDa3pNZ3ZyVDJiZ0VwNXJjYnpNdXJ3M1VNNXcyL2xM?=
 =?utf-8?B?SHd6Q1U3TlpxNGNld2V4TmlURGlRUi80Ym1WeWN5THlubjQ1dDUyREJ5OHJ4?=
 =?utf-8?B?K0JNdE54SURDR1RoaEpNa0szaForTE5KK1FBZDF5bUVzTzgvd0JSYW5ZTHlO?=
 =?utf-8?B?THkwREsrTXZWRUtCeXlDT1hTSnM2QkR6MmNXeDBvcExOanAyc3Eza3RVL092?=
 =?utf-8?B?U1E9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 514dc0de-c866-4254-f81d-08dbadd73ac4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0602MB3625.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 06:13:32.0743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bqzASPAh+vJkoYENEGJiCo3DxROmDMsj8ah3DLBEFAhgzjk4Mq5A3M9Sehoz3PusQ5CiodmAE4J/r9wrcbXzNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR06MB8525
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 04/09/2023 14:23, Andy Shevchenko wrote:
> On Mon, Sep 04, 2023 at 01:15:22PM +0300, Tomas Melin wrote:
>> Support deferred probe for cases where communication on
>> i2c bus fails. These failures could happen for a variety of
>> reasons including bus arbitration error or power failure.
> 
>> +out:
>> +	if ((ret == -EAGAIN) || (ret == -ENXIO))
>> +		return -EPROBE_DEFER;
>> +	return ret;
> 
> Oh my... This looks so-o hackish.> If anything, it has to be fixed on the level of regmap I2C APIs or
so.As such this does fix a real world issue. Providing some helpers for
this on regmap level would probably be great. To add such an API I
suspect there should first be existing users for it, and this would be
one example.
Until there would be such an generic API, I'm not sure if there are many
other alternatives than to check for invalid returns and defer the probe.

Thanks,
Tomas


> 
> Maybe something like regmap_i2c_try_write()/try_read() new APIs that
> will provide the above. Otherwise you want to fix _every single driver_
> in the Linux kern>
> ...
> 
> $ git grep -lw builtin_i2c_driver | wc
>       5       5     123
> $ git grep -lw module_i2c_driver | wc
>       1164    1164   35240
> 
> (and more that don't use either of the above macros).
> 
