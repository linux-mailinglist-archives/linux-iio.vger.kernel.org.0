Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC2857A0C8
	for <lists+linux-iio@lfdr.de>; Tue, 19 Jul 2022 16:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238840AbiGSOKM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Jul 2022 10:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238853AbiGSOJv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Jul 2022 10:09:51 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70139.outbound.protection.outlook.com [40.107.7.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB3354664
        for <linux-iio@vger.kernel.org>; Tue, 19 Jul 2022 06:27:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kjiRrrEH/BhTOv2i/sgWG1SVn3tvPclOBeC4tVF1dlcAGpn2dB/hMU0JhmLH2KoTlcjgrkwkPwxZS/1pBOrh6vdxz9EdxfZnx/Oaxe/Zcx5jHHkLBZFu7VhDf/9/GBS9QPyQzP3ZBEoICLqed0WVqNcDhrfhUxoWZhQ/T9Wlyzl21mJT1qo4mIVh7riZFTa44MLsRvHfjk7/N7NVYsi7rXPXHoA7Uzcq0sbc1CIffaaboV7rpDx6XydmXX18M4rlN77TSHRoXBIn+smakGzMj90XFFxSrxOFiYQkrhuL3RY8IJOh9kytXxj2PtBphx4Z1qrZZMUgzUgpZia7YOQtew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gadJM7hsImESXGZWgSd9sWmSJ7V2pDFS/4rtFQu9vYg=;
 b=iOY7zeoOvUgNTrHj+gsFqMVY2nGzC9js2MUkh/E6oln8XzG/x3WAQihgdNbOnUP0Hh+h0dGaAsdMaH6fpKos4yEmHPzaLnWto5jjbYo1MhZKZ0nlCzNLxNHDIAH5/C6tlqyZU7gylWbVEw5Y6PASLvvks5fs+jTCYRm4mVMh5tckPQy3qu2wAvuvJuttEhCOT0GI3p6IKApUb09cX9+PUKesp8wSisAW58scWlhSyl+tEcteGDQ+u/0ez1dxUZbYw5H9SQYROZPm15rzvRiufxIsis8zvhHLbxcckcRhpKFqiQNQM80dutuPvUajwq9UGnZEOBeyzA066yQ+3GWHaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gadJM7hsImESXGZWgSd9sWmSJ7V2pDFS/4rtFQu9vYg=;
 b=l1RAQSeX4pC+YZv5QUzIU3ZW0OML0uKd9m0e+ot+nf9X+U5I82Ss/FgjovtFZZFcOtZU5ImaCKHkq1hfJ/geLwVQBOOwoSUbkh5iXXZr6NhiK5pl0n2WENX9dthCcKd+1oCf25o+dxT+kp2voenWpa8lYeltQodS1pr5G7cSwGk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by DU0PR02MB8644.eurprd02.prod.outlook.com (2603:10a6:10:3ef::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Tue, 19 Jul
 2022 13:27:11 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::11f2:df70:b231:2b45]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::11f2:df70:b231:2b45%4]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 13:27:11 +0000
Message-ID: <f845f910-fb46-e38e-b4e2-709ae4da006b@axentia.se>
Date:   Tue, 19 Jul 2022 15:27:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC] iio: multiplexer: Copy scan_type details from parent to
 child
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>,
        Chris Morgan <macroalpha82@gmail.com>
Cc:     linux-iio@vger.kernel.org, lars@metafoo.de,
        Chris Morgan <macromorgan@hotmail.com>
References: <20220718184312.11840-1-macroalpha82@gmail.com>
 <20220719095116.3dc46f3a@jic23-huawei>
From:   Peter Rosin <peda@axentia.se>
In-Reply-To: <20220719095116.3dc46f3a@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0012.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::23) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a30b8fd-0322-4f53-92a0-08da698a62f8
X-MS-TrafficTypeDiagnostic: DU0PR02MB8644:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4vv8sP97ckqaR8goCOFe2QaP2mtgDIA9Rxmde92BHhA5umyc8vA/mEb7zGEJDEmloqQXDR9jXPfQ7nUuqRJcAVNuJVqDEYIiff3snHyBDM9/6c0SnJatBF2JPdqII56JRxPA7F6iXkorMMk/eknzfWr1cjxM0EovAoaSCrNPxEmG0TO3Us/qpv50rRoDz66OhdHKuhR4JQrBghQT6Dw1xLjDxwYLO1t1eYkv7d2OUdAaX1nThcv8rTL62Xl3DvPri0+3fdgKFgZJIUxvCwWIv3nSK2Cnwfa6yDaP1KJrYKMOqnoSAtq8DebgbO24bykD0zMn54E+BqqZAay3mE5ixCuUd6n4O61SMdA6GWB0X9nzF6xC1Vn+Ab7fswNeLOOD8PcYtRY8oPNI4wx0RZ2ZUBZkTadyuygoztlPw6ym10m8Eja9OVz5XrcV0adzz8aWQ9V8nY7lGTqPc+ZhsaPvZSSeSmkh/rqJvK8zXNqT30d0pBfonH2l7pDpuSI1lur6G3FGfCrv1aUYAOK5bD5oHRS+dhI7Gg1a7c11gGQvDRhuB5MYAv/duCMd9quG+w4fImC3FdyeGg5CKzsNtF5UGQ36osL36fVQ6Pb00K+SfaB3+oZAuZtBaODtzoJ6S4xjDVwTWOevYEYE0tEZqGmFw7xsqy6tIGBLP2pNxsJ48rQLM2js4QfXvf7C7/f5nyMI/7joI2n3pe+lIb2QObBf99y2ayNzFf89c3aX+dPiiy5D5IPW5nPt0FTD40+mOGD4A/EzQcoIs1NtdE872g0Cdl3GcdVswYPZ+xwTAcdIfac2GGAc9XVaLC8qtwMnqUr+/7xnH8qN/rmW0SNq7KAirg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39830400003)(376002)(366004)(396003)(346002)(6512007)(31686004)(36756003)(6486002)(316002)(110136005)(6666004)(41300700001)(26005)(45080400002)(6506007)(2906002)(66946007)(38100700002)(5660300002)(8676002)(4326008)(66476007)(478600001)(66556008)(186003)(86362001)(83380400001)(31696002)(2616005)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ny9NaUR0T1cxTFdqaEw0TUNUYUtQSW16bitIMWVXb2FENXI1aUx1TWxleTFj?=
 =?utf-8?B?Z1gyNDYxMzhab0I3cE4wY0NjQ1JRUHV3MTErMEd4cVRFSWlIa2d0bnNrRWdU?=
 =?utf-8?B?eHhuWm9QcFcxZ1l5WFo3KzVtN0w2YmhWcnY3SU9EL2M1eXpWREJ0eDh4OTJH?=
 =?utf-8?B?aGVGb0ZaM3BZMjNoNHJleUpMNFBNWTg3RU1mYnBUZnJaRnZBclJDbDdSK0cz?=
 =?utf-8?B?Mjg5VkRjZmM5bUdJeVgyR1BiUldmRnJGY0lvYy9xUkNMbEk0aWd4czFXQVpo?=
 =?utf-8?B?Wmp3NUFjR1paY2ozb1l1TkE3dHBkSHpSNnU0TlVwK2liQStyWThUYXM4Z1ZU?=
 =?utf-8?B?aXByanVPeDhVZTZrWFFUNUZ0dVdFNXI4ZloxQ1Nsa2FsKzM5SWR6WE9qWHM5?=
 =?utf-8?B?NkkxYWhYMS96c0t2bWsyT1FIVGp6TjkwYUR3TzJPNnBOeU02VmRDbitOangx?=
 =?utf-8?B?S3M4RFE1czQwSVZabG1tUmljdUtnb1pnYnI2TjkweXVCRUxMRlFBQWxNQURl?=
 =?utf-8?B?bnA0V3FoU1YxcFpxQ2hhRkk2alcyUHVaTU5HK2RzYkJqaG0rVVdBY0dPQ1RN?=
 =?utf-8?B?WjVpbDBVQ2tFWWUvTThXREd6RDJZMVJES1pGOThhWWtMWENPWnkzVkNmK1NZ?=
 =?utf-8?B?cG1zaGNwdmtQM3Y3dGc4Um1LU09UcStYYVBRZ3Z1U2o0T1Z5cmdEYUgzam5q?=
 =?utf-8?B?b0MrekwwV0doSVhTZFBVNVJ3cE9FWkZYZEtISXRJdEdDcis4b2dZL3M0NjE2?=
 =?utf-8?B?bDB3YmZSUXg1RXc3UHRlc0lhLzF0ekovSWFrK0NoVkdWeDF3YzZkdk1qL1Ry?=
 =?utf-8?B?cFZYRU8zN0liamcyaDJXNUtvUFJXbWh2NzNtSC95NHhFTFduMDlZZDJsa1hy?=
 =?utf-8?B?bkQ5TGF6TGlWK0lmaWNuUDhjVFRscEN1c2FyOHdJTzJFQmpLa2ovdW5kUWxV?=
 =?utf-8?B?d0pISityUXJrMlU0K3o5QUxBUmZvVk4zNTljUVpmcmtBM0dqa0xjeW9naW9w?=
 =?utf-8?B?SWg2ZlRoWkc2OExUc1BQSVdlM3prTFVGVFpwVzZhcDVkdVAzRyttc3Bra2Y2?=
 =?utf-8?B?WTU2MzVINkhZemhsdFpjOUhtczVDMkdwZlFiTWFId1k0VVphYVRyUUdhcDFE?=
 =?utf-8?B?WHY5Unc2UVhsU2ZCem40aEZncFNVVUxCL2V4eDk4UVJPU3MrdVpPd3FoMGFr?=
 =?utf-8?B?Ukd1dTI4RFNqL3Z0eFBjYm4wN1Bka0xZSGU2RExYbE85QUdUMWdvcHFpTWQw?=
 =?utf-8?B?bHNJd0o5a1BCZVhMN3VIeXJEajcyd1lxTlJFaFNCY0hscGV3T1BTMXMrZnVL?=
 =?utf-8?B?QkdyUFJFcE42TGdGL2pSb1FNclZqZXdpWG5LWXZvTnIxdTYyaS9hdmdQNDZw?=
 =?utf-8?B?OFNRWEQ5T0tJR3AyTHUzMDJ1bW1FVEpzTkx4MnBIZkMzN3pXZ3ZvVUxRNXJI?=
 =?utf-8?B?MnExMHU5WStNV2JnVU5XTFNWelhHSUxic1B3NTRhRHJMZGxwY2JtYnFxRUl0?=
 =?utf-8?B?anErNUFPcHpVZytOMlRHOHc4aGRwWW41eU83d3VBU3YrR0tXWHdyQnFoOVpl?=
 =?utf-8?B?djdKOWxWeUNIQll4bHR4azVyZm8vU0srVXBMQzZIODFyR3c2WnNUbG0vc0wv?=
 =?utf-8?B?YzZGQjloTGJINk4wRTl4WjhQU3JFQURVRVplS2tTZmdDUUg0TDh6Myt0b1Nm?=
 =?utf-8?B?RTFyZldrTURoOUpteHNpZXA3WUc5VjFDdmtSemwrcjhvQ3pkMnNKSzNFYWlN?=
 =?utf-8?B?VmJxV3NkaTJ6aDlla3RJUWM3SlFOUUdzMDk1cXQvS1BwYTZzY0hjM2NJSGVq?=
 =?utf-8?B?VEs3ZHdPQ1NDR2YzaUkvVU9TMkU0aW9zNkYrKytrNk9UVFkzZ3BYLzRZTEV5?=
 =?utf-8?B?OFdxTWUxQmhhL3hTT3BUdHAwSFJWdEg4VjIvNnBPWDFzNXdwdEdObzBEZWgr?=
 =?utf-8?B?MnA1ZEdJd3ZtSnd3d2FHS05YRzk1VVpEQm5wZXNKS2cvZnRBTzNvaGJiRFpq?=
 =?utf-8?B?TVhtRVllbVQxdlI0UWMwdllZTU1KRXVWSXpFejMwdng1aEVvcGlUUGdIVWFH?=
 =?utf-8?B?Q0pBdEZyZjgrSVp2T3Z3YnRvbUJoVU4xcTU1RkRGcTRBbGNaV0hqa3hqbity?=
 =?utf-8?Q?ePp0pojKCLu5USKIIUHN/B2uJ?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a30b8fd-0322-4f53-92a0-08da698a62f8
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 13:27:11.4926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Za/wJ7avUFx/PhiXng3fC10dYuSHAznF1huSxo+HO/TnXI9S7bPiU3uRkuki/+NP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB8644
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi!

2022-07-19 at 10:51, Jonathan Cameron wrote:
> On Mon, 18 Jul 2022 13:43:12 -0500
> Chris Morgan <macroalpha82@gmail.com> wrote:
> 
>> From: Chris Morgan <macromorgan@hotmail.com>
>>
>> Copy the scan_type details from the parent iio channel to the child.
>> The scan_type is otherwise empty and things like the storagebits are
>> zero (which causes a problem for the adc-joystick driver which
>> validates the storagebits when used through a mux). I'm submitting this
>> as an RFC because I'm not sure if this is the correct way to handle
>> this scenario (a driver that checks the storagebits used with the iio
>> multiplexer).
>>
>> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> Seems sensible to me. Though Peter is expert on this one.

I really doubt that it is this simple. I'm no expert on buffered channels,
but after a quick look it certainly looks like adc-joystick requires
buffered channels. And iio-multiplexer does not support that at all. I
think it could be supported, but in that case the only obvious support
would be to support buffered channels one at a time, and the way I
read adc-joystick it expects to get one sample for each axes in one
go (i.e. the way "normal" ADCs deliver multiple parallel samples). See
e.g. the call to iio_channel_get_all_cb in adc-joystick, which dives
right into the buffered iio department.

So, the stuff in scan_type (along with scan_index, which is highly
related) is only relevant for buffered channels, and iio_multiplexer is
currently limited by its

	indio_dev->modes = INDIO_DIRECT_MODE;

which is ... not buffered. :-(

The simplest way forward is probably to lift the requirement of buffered
channels from adc-joystick, but that might be a hard sell as that driver
would then probably be a lot bigger and more complex.

That said, I would of course love to see the generic solution with support
for buffered channels in the mux, but my guess is that that gets much
more difficult, at least if you need the kind of buffered support
expected by adc-joystick.

Or, am I misreading the whole situation and you have actually gotten it
to work with the below one-liner? If it works, fine by me, but I think
you also need to do something with scan_index?

Cheers,
Peter

> One comment on the comment inline...
>> ---
>>  drivers/iio/multiplexer/iio-mux.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/iio/multiplexer/iio-mux.c b/drivers/iio/multiplexer/iio-mux.c
>> index 93558fddfa9b..1de01ec878c4 100644
>> --- a/drivers/iio/multiplexer/iio-mux.c
>> +++ b/drivers/iio/multiplexer/iio-mux.c
>> @@ -322,6 +322,9 @@ static int mux_configure_channel(struct device *dev, struct mux *mux,
>>  	if (page)
>>  		devm_kfree(dev, page);
>>  
>> +	/* Copy scan type from parent to mux child. */
> Comment is in the obvious category, so drop that.
> 
>> +	chan->scan_type = pchan->scan_type;
>> +
>>  	return 0;
>>  }
>>  
> 
