Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD28A793512
	for <lists+linux-iio@lfdr.de>; Wed,  6 Sep 2023 07:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238047AbjIFF7U (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 6 Sep 2023 01:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjIFF7U (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 6 Sep 2023 01:59:20 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2050.outbound.protection.outlook.com [40.107.8.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F93C1BB
        for <linux-iio@vger.kernel.org>; Tue,  5 Sep 2023 22:59:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UvlFynDJz+CMLWeMO4OX6oqA+lZQNvaGlszJNiJNsru0k76qdnhhtqJK7pEPYz2CutRl++aF/ZKpxx9KxrmzSvX662xLNIQOeN5fc5jL3LguGd7rJC4pZzgWgRpi/pg/M2jsVEO89QK4rdSDVgq4xi+FNw4ljsqahod38wlXYisUU0IGfL1b7kD6cIS0lrIB6gzhPIAdy7lGBHbqnOEokekE2c2327uRIY8ZKbnxjUQW1qb2pwUAHROps0+BSrwO7peT9W+FsPn6uIgDGy5wCXSZy5uOovNNtPDTI/ws9c8D/8Rs3Xr16TyT9Omu2ntG+CsjhcSUbDWH1hjfsXTvKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4w7enhfaqcCChX9echJaiwfmD+lRv3qT6sto+bjWkGE=;
 b=Tdi16+GFQLqDdz9jmMF0AqZpa5p7BJiIEBuqMy8Bxu8zJz+QaKzSQ1vEZMOkrK0NT4mUhBZT2QRxreasX+nqAhfFEVRefpDuPIPguEDhGtUjNi5deWGEgquJmYtuuPrRDla/XiCKrisD3Q7eXvOHP9BKnHvIE8FyCo/ovP4VBpRwkt0OiyxGKL4wSyF9dTB6R30si3/CYZzorYhdL8lVqMDWfuW6h/MiNVsL3XMQSLwrsQ+TENNrpXmIU2i4Ier7zEMQqY8a8dX0+CVN10zNUYWhto0/IfH09D0UPZ0GrmDE+yaZxz3aUNyQlcnGl9/vyoY2zeanILEJ6zKTZUH2vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4w7enhfaqcCChX9echJaiwfmD+lRv3qT6sto+bjWkGE=;
 b=LyeTmdiJD+rdGBFhRbXK8Jbuszxm8TEvTqEG+Ya3I/f59oGA9RuL8EN+MIUiBUSIkyWV1zMKvF538rjCNy3zke8wps0Q6QiVycKfxfijEY0j88B/yqoGjTnnL04qq8g7//UW/0GDeq0zhVb8Dk94tokQB3hT5WlLqiOQMELCYHxh484F/fw100218QGSelYr+xwXLva07gokSUs8fiyfaC35yIthRWBIHVM4Mpg7i9JpxAXX5KgZxoE9Tsw/4fGENiC7C2IZVVYp9rJO5utO6o02HlyGh42PQBmeCH10Jzur48Dhnq3AESE4blQWNzSCL7zUG+hp84ihnlYOs2Q3ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from HE1PR0602MB3625.eurprd06.prod.outlook.com (2603:10a6:7:81::18)
 by VI1PR06MB6463.eurprd06.prod.outlook.com (2603:10a6:800:11d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 05:59:13 +0000
Received: from HE1PR0602MB3625.eurprd06.prod.outlook.com
 ([fe80::cec4:e994:fbc6:5f07]) by HE1PR0602MB3625.eurprd06.prod.outlook.com
 ([fe80::cec4:e994:fbc6:5f07%6]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 05:59:13 +0000
Message-ID: <b34d2c94-ae78-c7ee-9352-12f4ee1c0294@vaisala.com>
Date:   Wed, 6 Sep 2023 08:59:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] iio: adc: ti-ads1015: support deferred probe
Content-Language: en-US
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        u.kleine-koenig@pengutronix.de
References: <20230904101533.455896-1-tomas.melin@vaisala.com>
 <ZPW+MXuBSYEE1GfF@smile.fi.intel.com> <20230904141251.00002b7d@Huawei.com>
 <848d639c-43d1-bf92-2292-059dd1a019cf@vaisala.com>
 <38f995ab-99de-1d88-696e-edc78e24c8b2@metafoo.de>
From:   Tomas Melin <tomas.melin@vaisala.com>
In-Reply-To: <38f995ab-99de-1d88-696e-edc78e24c8b2@metafoo.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVYP280CA0009.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:fa::23) To HE1PR0602MB3625.eurprd06.prod.outlook.com
 (2603:10a6:7:81::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0602MB3625:EE_|VI1PR06MB6463:EE_
X-MS-Office365-Filtering-Correlation-Id: b6820e51-6b7f-4e12-f25e-08dbae9e64d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fGh6W6hKuNJGGQUmYcd0nKIe0SZE8v1N/tgluLCmRc1BGafrOLS7UbFlaFNUTO9z4iKdak8aEqZIKZd7Pf+dt4ZlmdgBU+YP/NBDFT/2oFUalpiHKhrq531OXvmkTsd5PiAZ335cFYKVfBsHTJ4ZjkktpsS3mJhFcR+gWFRxYLLG4a2qyk4y+YaUItDbzhjbC6VBXhjlaQeDiCn+o5Tu16SNC9J+qf23KHL+xt3CRpeQmSk7KdJafd6klVcNrQ+OnwUOKmcOTKAJM1QO3LX/Ge01DUYJPqSWnBCG4jrLS1Am7marIHXRBn7AToY0b29vonLPHf7ZQ+tEz2pjw8+/h2reTwjd6Elb5NqfKiftbJGIo3jmgXyQhZ9CnOzmiJGJrKi3nhiOoUOvxlFc4ZLh7gqROQvInJKWyXQ/YuT+SOTu6x4P6UbS9bAq8g64OLI0eRAZbsSL8D2TkBzsRLtiWZZBgMlheSRZL48umEN5hTqNLkM8GbN3z4V7TiHiH+GoiU17P136yB88K5S0viEaZndKH127NyNdhLdwQzOAZjAuxYcxe70Vi+g68IKj6oTNDctFyALVS4LKVcH9JAGwpMSAoA/aMtPR9BSQamQnBF2aOnAUBUE5OBZUP42uAvnmi0OgR4jfoTtTo0xr51RABg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0602MB3625.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39850400004)(376002)(366004)(396003)(346002)(186009)(1800799009)(451199024)(66476007)(8936002)(83380400001)(478600001)(4326008)(8676002)(41300700001)(66946007)(6666004)(53546011)(110136005)(66556008)(6512007)(2616005)(316002)(26005)(6486002)(6506007)(38100700002)(2906002)(44832011)(5660300002)(31696002)(86362001)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0RZWm5tMnpLdnJPQ0hpSG9FRG51RTlkYmJ4dGxkNVg5VFdMYkdIR2pTWkdn?=
 =?utf-8?B?a2hoSXowYWZBM2xyaVF4amEyUVRURy9Kb3ZxSyt5MjlwbVhYR1dDQTlIa0E1?=
 =?utf-8?B?WWdOWU9naVZ2OFJTb202THBHVE02eDBNRzZhcjE1Y0RqVFU5RTRNbDlzQzVm?=
 =?utf-8?B?RVAydDUyOXFLZjk2dzZ5NE1OSWNDMmpOdnhvVVpxZ3FOM29UQnBmNmR5Ukhw?=
 =?utf-8?B?QzZTeVVndFBjNlp5RDR6bVNDbnNzajNGVG5PWUk0M3NhOE96dFd5ZDFUekhC?=
 =?utf-8?B?SCtHeXhjaExoM3dSa0hkazRnU2t0NWRRenluVVIwT21UeXRocnh0V00rVlll?=
 =?utf-8?B?YVZ3Q1pabFdWTDlITjlndXJLTk1UNmNhQ1cwazMxNFBKOHI0UHFGRXZHc216?=
 =?utf-8?B?Vmg3a0x3MFM5WER0enFsYTIwa0N5a2lVQW9MbmdiUTRna1M1eUsrV1k5STBJ?=
 =?utf-8?B?b1hpWHFnRjIwMkpXR2VNbEhFeXBBd3BOZk4rbjQvVTBkaXlMSEpRNkNsSW5l?=
 =?utf-8?B?VGt5QU1Ranc2KytCREpwSDA0aStmTURGNUI4Q2xPNDNrL05BYjBpK1d6Vlcr?=
 =?utf-8?B?WGo4QjlSSGduSll3akU2S05FKzhLVm92ZC9vZjBvaFpYRjBKNjEzMVJORGxt?=
 =?utf-8?B?RXJIWHZFc0xQQ1pnOTVoWjFtWFJkV25JSDN5YlBWUjRnWEIzZmhBajVuUmFl?=
 =?utf-8?B?VktjRldWZlQ1K1BJOVlJbHlKcXQvUXJtaThReEtWR0MrRi84cUxWbWp4TFRE?=
 =?utf-8?B?d29VZ1REbjBoekt6b0ljcWRuZnFJQTh4eFdyQ2ZmOHJSRUErbm9Ecm5JL0Mw?=
 =?utf-8?B?ZVBqQ24xa3dhdzdEcjJzeWt3V1BlWjJyQi9kMnhiTmU1SmxjTlkrTDc3bXFi?=
 =?utf-8?B?SmVSU1QzK3RWaHZoK1pzcW9xY2o5YmMxRTBrbXVDV3M5eFBhVTdDQUluaHNs?=
 =?utf-8?B?aCsvNGpvLzJJUFcwalBCdVluVGFhcG05bm4rWGdlNnJwc2J5dnF6WWwvRGpz?=
 =?utf-8?B?aXVlOFhjNmNrblhOeUVwblJoSGJjZWVDSHZRN2JCcXNLNU8xbGphRUlndXBS?=
 =?utf-8?B?RzZxMndrQmd3NUpLanlHMFNYektSMExzL1cxSkZWM1kzbXJOWXRJVDFXZmlD?=
 =?utf-8?B?MTF1Rk9TSmJlcGlKQ3RXUTNkVDlLcGdzUHp1cHFFVHN4NGszSUdTMFRyNDRX?=
 =?utf-8?B?T3M0OWNOUVVZUUV5aC9LM01jS2p0aVVZU25NSGtlOVhvaFJ6VFJyZEZ1dllJ?=
 =?utf-8?B?MXQwUzhPcUZTaSszWjA2RFBOeXloUUdrU3B6dElDdzFYWjhjYzFlakkramU4?=
 =?utf-8?B?ZGxqYnh1elBlblF5d1ZZc2R0NUh3YUdCNktmM2paQXdOMW56aEJLTkgzY3RR?=
 =?utf-8?B?cXNKUmFkNDlrOFFFOUM2emFHZkRSdWlYM1lQRXdEK3FGQmFTbGxmK2o1MGY3?=
 =?utf-8?B?VldRYStoeFpyaGsrcGRUOFlPa1Y3SnAvQkM3QkhLcloxbDZiN2k2SGpxZHBq?=
 =?utf-8?B?eFJ3TzQ1TTNlR3Bod2ZEZWEra3ZWS1NaQUxlOGlleDgzZEIrQk9zZFFIdTZ3?=
 =?utf-8?B?L0dDS01SbUhPZm1sc3I5ZVNQcDJUNjRFZGRsWFFVcmFSUlJkUlBvUW41cW9V?=
 =?utf-8?B?RUlXNngrWENsT0lIR1FlR2NwQkJYcHcwSnRuNkUva2taS2FRaytOeFJ6SU5j?=
 =?utf-8?B?VWxPc3A2MjFkZW1GcDhVWHZpaTdxeWNYSk9EdGVnU25YUXFTR0dzbm1GalBZ?=
 =?utf-8?B?WFZGTmhkOVNYTDhQN3Rvd3lSbm5uN05wdmdlOHdUcHNmMWY2Rlg0b3JvVW41?=
 =?utf-8?B?T2NEZjFTSGRvbjRYbjBqYWtZWDNTSTFRNEVnRHFBTFVpTU5pTXF5eUJ4bkRR?=
 =?utf-8?B?V0dMeFBBWGFkSkQvZGpvZ29RS0Fpd3c3REpNRGVTbGtpMTBJNStFMTY5a3Ns?=
 =?utf-8?B?MTJ3MVhnMTBKTlhwZWhNNU9MRnlNTUdnTFdPdm5QSDlhUTlSUlUvNlJhVjg1?=
 =?utf-8?B?bTBmUHNITU1aSDhGdU9TUlJOTUZzRjNDSXFRbE1iMElsejhrWHJaTXcxcDZj?=
 =?utf-8?B?WFB3enRuNjRsdlVNRS9lMkY0RXJRQ2kzc0N5ODNVUjA2Mi9mOHY3ODd5dHBl?=
 =?utf-8?B?aVA5WGZQSk1pZkl1a1lyL094USt6bG8xUk00Q3F0eGw1T3MwZTRvQWhtME5h?=
 =?utf-8?B?cFE9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6820e51-6b7f-4e12-f25e-08dbae9e64d2
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0602MB3625.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 05:59:12.8041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z5vQHlv8cOLY0gqM0uNMQNmZAr/yzEnxdKxfTRUpL5eft9PwS/wywS15iGJtAZKDcCCwGSiVsc2Eb8uhNC9pSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB6463
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 05/09/2023 15:31, Lars-Peter Clausen wrote:
> On 9/5/23 04:43, Tomas Melin wrote:
>> Hi,
>>
>> Point is, that if the communication to the i2c bus has some temporary
>> error like EAGAIN, why could it not be reasonable to try again at a
>> later time instead of giving up completely.
> 
> The way probe deferral works, or is supposed to work, is that if a 
> driver detects that it is missing a resource to initialize the device it 
> can return EPROBE_DEFER to try again later. Once a new resource becomes 
> available it will try again. In your case there is no resource 
> dependency, but just a random failure. So there is no guarantee that 
> probe will actually be called again since there might not be any new 
> resources that become available.
> 
> The solution you've implemented might work on your specific platform, 
> but it does not work by design, it only works by chance. Returning 
> EPROBE_DEFER for things like IO errors is not the right approach. If you 
> need a quick hack you can for example write a small userspace script 
> that will trigger re-probe of the device at system startup.
Right, I will need to take a different approach with this. Thanks for
the input!

Tomas


> 
> 
