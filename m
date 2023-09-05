Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7FF7925BF
	for <lists+linux-iio@lfdr.de>; Tue,  5 Sep 2023 18:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243969AbjIEQTI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 Sep 2023 12:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354445AbjIELn3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 Sep 2023 07:43:29 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2043.outbound.protection.outlook.com [40.107.6.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5B41AD
        for <linux-iio@vger.kernel.org>; Tue,  5 Sep 2023 04:43:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJLyx2yVkSG6n4wyIMRIs5oi2TMV0RIQMOYEvZDWTxZ8HSdkhjLieu2bfeXlx/HCu2DgmQXefLHP1jGjXMgUsCqfCclC7/pSuBD68nOv/K1srvWUUHV2I2u74HvpgmwrcRI9a7ssyqHFmvamPrLcny26Cpb1KMm+9sR4kswgPH8jHNGhKczWXv3iznE0RiL76GNovcRNDjGPBmDVd8grA9p5AzkGcE1A70XVRRmSInI4eFVAI6zSbqN3aFV+q8LdssCMTI10wUw1XsSW4RjmaWOxhm+t/00w1acFZSFk+w6my1vC3Tfyg10rC5PmnM89cqn9+IOKKG5faX5xESk7Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpE9xLvyW14rGl3k+8irPCe+qpjDCNv2b/NsISWqUTk=;
 b=LLJjVd1aN22NwxfD2Nw2M7MPYUqagKHDNEitQ3SSEnxCYEjuWpZBzQ11KziDDvK6xFTwgbxhjZC82f6AOiYHYD+DdY58t91GpmsLLQO5bNQEoccl9oHCupPvrDJjFdF5DHU1D6/k33yWjtZ2mAaWLzAaUrrOsalS8mktcjp13LB1GOhCOZkpzgrjXUmAVzpl6Jt2ADbB5ZRsc2URissmFwoHnedwpMJu31oA3n5EIvLtgxYh3Dy4uu1hdRe9VOr8RdrqHj+ov35/kh3govW6lwORD52bLJnzqsMmydKPVcoDhzpfG6xFhLF6L6LKybe1uwsR5ZJgKOMKlJDeA6x7Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpE9xLvyW14rGl3k+8irPCe+qpjDCNv2b/NsISWqUTk=;
 b=KUAWwkHuyM5FW6hSl1G5Py5/CPfAnYQmCD2CElyZU0ea0u7A55pmJ5n5bGbTW8G4KllMZUWcOUI62lwGsoirF27EG9kzR84Hj0q2ie30w00C/2L2U7niZlXiiC0dUuePY8fTM6I8uijZK7oW33vmxqctRLMGbQwR5AWSSq4nd6SA4GBEc19nScLAXkanAGn4/YA/eNPORLAK6Ns26JMm5OCEMXD9lhn6KIYYq+IrBIWkSYNFwdZG6FF0m1TXYgruQoHTdTKdCCjZxqLuE8ncC4hlSSMMFiSmQEKZ6Xnf+Q+5vNmrxc3uCmlinnHgmKnixnNuPaQzchD4nEVgPFZxHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from HE1PR0602MB3625.eurprd06.prod.outlook.com (2603:10a6:7:81::18)
 by DB9PR06MB7306.eurprd06.prod.outlook.com (2603:10a6:10:211::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 11:43:23 +0000
Received: from HE1PR0602MB3625.eurprd06.prod.outlook.com
 ([fe80::cec4:e994:fbc6:5f07]) by HE1PR0602MB3625.eurprd06.prod.outlook.com
 ([fe80::cec4:e994:fbc6:5f07%6]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 11:43:22 +0000
Message-ID: <848d639c-43d1-bf92-2292-059dd1a019cf@vaisala.com>
Date:   Tue, 5 Sep 2023 14:43:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] iio: adc: ti-ads1015: support deferred probe
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org, lars@metafoo.de,
        u.kleine-koenig@pengutronix.de
References: <20230904101533.455896-1-tomas.melin@vaisala.com>
 <ZPW+MXuBSYEE1GfF@smile.fi.intel.com> <20230904141251.00002b7d@Huawei.com>
From:   Tomas Melin <tomas.melin@vaisala.com>
In-Reply-To: <20230904141251.00002b7d@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVX0EPF0000ED8D.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:3:0:5) To HE1PR0602MB3625.eurprd06.prod.outlook.com
 (2603:10a6:7:81::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0602MB3625:EE_|DB9PR06MB7306:EE_
X-MS-Office365-Filtering-Correlation-Id: b3ee575a-daac-4be5-f1aa-08dbae054ed6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FVJ0L1WL+8sx/hdj2AFnthQBeVxHO/1t7r9/cPWlKubFLTRgLMPrXEIvaTWGB27BIaF4fTWBAMudXxlhjDVvaQIfHOoUzNI3IbXIZeilVTDVbazdzjIC6j0EaypJwMAJqVhwPsbhDvZ2hsTIYjXy5HgOkjDMhb1ItwHJ/XBzIuthtNn4imR8W3sthMcC1YDJjH0y6FKEmo5nY9ATYwvGVucQ5/QyeCwkYVMqktGzfkiK+mJuKrYHi/6ew03XHlPsge8b1sqxZA4m+rMbO5bYZr/xir5xW09wXyowqQeA3yXwqFBetQHd9xKXmOxbV+4XpUkqJlPGXYHIIfe9TyG1gATDDgf3xxe+xVBNfsEBlihfZhRsWoItoGsGOuzT0BMpLEkkr2VxLIgNpF5K+PyJHdwaweixXQ8gwvL4jI68HAe/ixA8livY8PYI+wZhZqTVqRNxl3NeDbV4sY1ZBifct9sYBpwaz3fzsa7Ig+qNdlSUbdw5L0cVhoYQZHLJbUypLht76DQLF41bfOy5d38Lhu105+XYqKp1zXrhEsurdbZCp0VJZ7xaYFR5+s+o38twlNP7BPQvZYQCYHFn/yna6bjYCpp2T48ZhHruj7FZEWGEWUJcMShMXpCbqjehUODW1jo4kF/fc1MicNqdnh4CNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0602MB3625.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(366004)(39850400004)(346002)(451199024)(1800799009)(186009)(66476007)(66556008)(66946007)(31696002)(86362001)(41300700001)(316002)(110136005)(6512007)(2616005)(26005)(44832011)(53546011)(6486002)(6506007)(31686004)(4326008)(5660300002)(8936002)(8676002)(6666004)(478600001)(36756003)(38100700002)(83380400001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGVKSGNLNElMa2ZJa2JHR3dqRzU1a1d3dGN2Njl5ZU5xVHMvM0NodmtCQlhz?=
 =?utf-8?B?RnVMaE5oUGpjemxtTzR5NGNWRS9EQXZlUEhXd2ExckZuS1RzbURlM2pPQWN2?=
 =?utf-8?B?UEk0cVV0bTFJZW1HZUkrRENxWXlFN202UTlaaFIvRkNpZ1dTcnhTZ0RyNlVt?=
 =?utf-8?B?bFhXT2pBai85V3NlSUo4YStOalBxRW1jUVl5OU90R0JGYnUxdlNsNElPOWNS?=
 =?utf-8?B?ZmV3SEhvV0tqbU9zSk5IS3hJdlBIU1VycjEzMmhoQXFGY2Myei9takxWQVFG?=
 =?utf-8?B?TEgzSHY3SWc2a0d0WDR1ZTM4QUJiQk9wbUVITkNqWkwzR21JTFNXUXR5ZUlJ?=
 =?utf-8?B?S25ZS2M1VWN2OS9tcUVMSno0dGhjYzF2c1Q0Y25hclpUQnhFRTkrTjJWTlRQ?=
 =?utf-8?B?TllsWEJwMktJUkZOS3BNcTZ3bGpoZ0k1MS8rQldRZkNoYlNRVVpFNm9Va2Rz?=
 =?utf-8?B?WFdHbWhmOFJMckpySEZSeVRaa3pkSit4eThDaE9vSlM2K3dvQ1U3bFRZSVFC?=
 =?utf-8?B?RG5xVXNIb1VGenVaK2xYcndTRkwvMzFsazZqdFRmejU1VzFzUEQrd2ZzQzZN?=
 =?utf-8?B?bU4zUzJRNzJWQWFrS2tnZ3RrdFI0SGJaOHF4QlMrWmFpTkROYm93SE1RdE5R?=
 =?utf-8?B?TlMwYlFBdi9QSlpOUEh5SFVBOEtrQzFCYmtscEwzSmc1dy9jbEdHdGJNMXFI?=
 =?utf-8?B?aG9XMk5CVmFYZFpUMUtXV3Iwdy9McExwRXFGSklRdTBrUU1ZVm1wRFgxMGJO?=
 =?utf-8?B?eGc4dmhiS3VtblVIN3g3VVZOYmsyVHpRT3VCclU1aU1HQmc3Rnl4VFZJcjhF?=
 =?utf-8?B?MUdjd3BwT0lXVlFmcnpMU2FjZTU4eUhwODE1eFcxbUdsdGxsMzltcllWenJL?=
 =?utf-8?B?QnIwT1ZzRHBzQ25yeFJpWFNyVUJFdWY5akpOQjJMcVhlMExqR1UyU0RUVTVJ?=
 =?utf-8?B?VlFaeDVSL1ptTTdjQyt5aTlUQkRKQ2JkRVJaTHk3RnM5SDlnSFVob2w5RFZ1?=
 =?utf-8?B?QnU0UlZHTHVSMFk3dGdPdmMxeEVuNkVxSCtKRTlTS2k0K2YvQWhGeFUrU3p6?=
 =?utf-8?B?ZXJFZ3V4WWVERnY1cEZRdlgxQllkejVZNU1EK21JWE1JM0xXMXR0dlB2cUhB?=
 =?utf-8?B?VG0wTGxrUHVrRTlwTG44UVpjWUkweWhVS0dicHBNaDRDYVl2b3lnTlFUVnkx?=
 =?utf-8?B?Nk9PeWNFYkJlMHdRTS93U3d5SU56REJtLzVTMXcydEQva3BrNFZxSm1ZckZ3?=
 =?utf-8?B?TS9tK0lWTUR2cWFaQ0RDS2FuS080RnRCNEFIcnhodjVhQ0hmc2VJZW82Vmx5?=
 =?utf-8?B?VlhoQ0d0Uk5xeWR5Y1Fsd054Y0dBRFVsMkVoNEJqTkprQmdpNDFZZUxLMkRI?=
 =?utf-8?B?aXhabkpaWmdZWEpiTGc4QksydWxLYklNRDlQbUZkclNxcW52K2Y1VlVLSVFw?=
 =?utf-8?B?aVk2aGlrVlk0blVWZ1pyTkJKLzBaYkJObnZIWjB6cmZTeGFwd1l6TTNMS09T?=
 =?utf-8?B?YjJrNVYwNER1eitDL2c5Vk1sUGkvdm00bHptcXZuZDBSZXplZWVCWnZFRW05?=
 =?utf-8?B?VWE1UU9VbEZ6RERFMU9Hc2dXUkNYekc3RytwSlJ3WFd5SUZMZHdRbm9KYldW?=
 =?utf-8?B?ZEl5dUJkdWVWNkJDd3dQcFJaQmZXRVN1MEg3ckpCVlBnVEFQc2NOV2lRZ3ZJ?=
 =?utf-8?B?MXpvWGI5Q1ZERFd1a0dyNHI3WTVIQnhJWFluZ3VZdk1yVCtROEdqT2xJUU9N?=
 =?utf-8?B?Rlpmd0pJZmxNREtxQm5ZbVpQdkVmY0tUQkZ4dStCQUQ2TU56ekgyTTFHN3dL?=
 =?utf-8?B?YitqYzhOelIraFFwUlk3MlpldTY3WVJ0VHNtNXd0KzdtdUdRNmlnejNzd2lU?=
 =?utf-8?B?S0RXUTNVZWhNcndsTGFHS1RJUkVCdkJFMWZOd0UzSlJCcW5RcjBmaXdjNml3?=
 =?utf-8?B?ZXZOVFY3cDFZMjNPdDAvSml3ajh4cHBEYU1ZZ21IS1BQeE9BNDl5MzEvVDBM?=
 =?utf-8?B?VnJmbWZwMnl4NlVWd1V6MHBxVitaYlFBeXhjVm45QnNtQkc3NWJZWE05NGg4?=
 =?utf-8?B?dU9MdkQzYmU0N3BmcjRpT3o4OG1QQjEvSjJOZW9pK2NHbnlwUDh1VFNkejNo?=
 =?utf-8?B?aStUM0tUOGdsVXdsYmQ3OFRVZ0tBdWtqRTRzUkxIUUpaZEtGZ0xWcXB5eDhL?=
 =?utf-8?B?Rmc9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ee575a-daac-4be5-f1aa-08dbae054ed6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0602MB3625.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 11:43:22.5476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1uq09BvxZHE9EKSrMVjOVUkJN8eQCyTLP8tS9tDS+rENLWeSqWAx5uvGs5I9pClzhYQ76zkKxf5wsuVm7rOtvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR06MB7306
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 04/09/2023 16:12, Jonathan Cameron wrote:
> On Mon, 4 Sep 2023 14:23:29 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
>> On Mon, Sep 04, 2023 at 01:15:22PM +0300, Tomas Melin wrote:
>>> Support deferred probe for cases where communication on
>>> i2c bus fails. These failures could happen for a variety of
>>> reasons including bus arbitration error or power failure.  
>>
>>> +out:
>>> +	if ((ret == -EAGAIN) || (ret == -ENXIO))
>>> +		return -EPROBE_DEFER;
>>> +	return ret;  
>>
>> Oh my... This looks so-o hackish.
> 
> Agreed.  This is a non starter.
> 
>> If anything, it has to be fixed on the level of regmap I2C APIs or so.
>>
>> Maybe something like regmap_i2c_try_write()/try_read() new APIs that
>> will provide the above. Otherwise you want to fix _every single driver_
>> in the Linux kernel
> 
> Any probe ordering dependencies should be described by the
> firmware and the driver should 'get' the relevant resource.
> If there is anything not describable today then that is what we need
> to fix, not paper over the holes
> 
> So can we have specifics of what is happening here?
> 
> If it's arbitration with some other entity then fix the arbitration
> locking / hand over. If it's power, then make sure the relevant
> regulator get gotten and turned on + has the right delays etc.

Yes, right. In this use case, the ads1015 is connected to a channel of
a i2c multiplexer. When the mux is probed, it also enumerates all the
multiplexed buses and probes devices connected to them.
For some reason, it behaves so that the ads1015 is not detected on the
first attempt. Since it's a mux, connected to main i2c line, perhaps
there really is some bus arbitration issue, or then something else.

Anyways, when deferring the probe for the ads1015, and attempting later
again it probes fine.

So, it might be I've taken the wrong angle at this issue, but
it does solve the issue at hand. Obviously, there could be some issue
with the i2c mux driver, or then on hardware level too.

Point is, that if the communication to the i2c bus has some temporary
error like EAGAIN, why could it not be reasonable to try again at a
later time instead of giving up completely.

Thanks,
Tomas



> 
> Jonathan
> 
>>
>> ...
>>
>> $ git grep -lw builtin_i2c_driver | wc
>>       5       5     123
>> $ git grep -lw module_i2c_driver | wc
>>       1164    1164   35240
>>
>> (and more that don't use either of the above macros).
>>
> 
