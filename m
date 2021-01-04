Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 181722E9CD3
	for <lists+linux-iio@lfdr.de>; Mon,  4 Jan 2021 19:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbhADSKf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Jan 2021 13:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbhADSKf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Jan 2021 13:10:35 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on0702.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0d::702])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F6BC061574
        for <linux-iio@vger.kernel.org>; Mon,  4 Jan 2021 10:09:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aD33HJT81xTQRXwqXEatQYt1FZRSlFAPZFUZrxx2LlPxM19oOdXnp3tDK+DWJ6VI6LpDqncQs8wT3fGvec9l6XNv0h3nFTQ11hg1B8c0xXTE/dFRTdWt0AFoaKWFxJtSgIUB5OGXpkJA9+DdXqb2CHkx+SAK2T8UmPSXFJQJ91rHIz2w0iT3L/f21NBhlLGXRsJtajOjwMEms83HZ/WkJfAddk2JtIDuRWCzjyHgYzKpJ7Qqwi66ug04cjwV+PJHpeYLw68mZsArilj97cRheVEfcR0r5C1ag6YA9L1sRDE/ZPef4QZa1lMXl9f1U4VYS0cME6v+Npc6/I9dYrRZ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vj36DMDF8Lk5Aoda6rjCIBgG72tvc5/L61hB4iF7G/s=;
 b=XddtTPgfHp0yAwiCIOkL08BPv2ATICRm3E9YJAvMmGDIIS08zuCEK5UipzrNG04DBjqT22Fz0qk43VQ7hBh+FnmBmQ2SsDh3KaL8y0PqYE3nn+Hvfq7VMbphXuNCpLzQbUXLXBFvfQ1CCJciyfyfHm4qVBqBvg6h0Y+9i1s6egWg4xQCey71OL3MMFfDVHc8z48UlUUV/vT4qqKB0iMMp027R5x7700KRFf8hwUsL0MQppMCKLGTsL3W1BCV94MiYQavQvOUAX5R2Mv7T/IkoILLkhO5Wo4MmmSMmVXrAQHRr0Jh3jyeobqPMfH7x2GM0/tzg9srKqGb7LisoHQt1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vj36DMDF8Lk5Aoda6rjCIBgG72tvc5/L61hB4iF7G/s=;
 b=CpQhCi/yOXkiobZCdMcCkOuogCll41lmE+KWJwpi6uo/9NBtSuOZqCppZYeZWTUetEhBL+vZfNk1WI66Lwg822qXD0jyZhGwB3CW2/ktpbua43qhsp99sVAUR3gv+shgDR0xAcx++SzNCafJZyhI4j/PVOyNamHFThfSpwTH+wo=
Authentication-Results: pmeerw.net; dkim=none (message not signed)
 header.d=none;pmeerw.net; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB9PR02MB6907.eurprd02.prod.outlook.com (2603:10a6:10:229::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.19; Mon, 4 Jan
 2021 18:09:32 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7975:bb50:c24:9e4f]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7975:bb50:c24:9e4f%6]) with mapi id 15.20.3721.024; Mon, 4 Jan 2021
 18:09:31 +0000
Subject: Re: [PATCH] iio: afe: iio-rescale: Support processed channels
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <20201101232211.1194304-1-linus.walleij@linaro.org>
 <CACRpkdZc=qGasbsL7DWbbRGyvxaX8hh2iU-QfLpkYGCD3UrqOw@mail.gmail.com>
 <435ebb1b-431c-fdeb-023e-39c6f6102e22@axentia.se>
 <20201213121615.55a86f77@archlinux>
 <c34cc481-0244-a68e-8ae4-75e8e62b18bb@axentia.se>
 <20201214150728.00001fa7@Huawei.com>
 <e755c671-a212-e93c-427c-66ab031289c3@axentia.se>
 <20201214163423.00005e6c@Huawei.com>
 <CACRpkdbOx0AiFOejZ5gtjQwQNo-qzuRRNVDhjAbAk1pGLMj8Yw@mail.gmail.com>
 <20210104171114.000042df@Huawei.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <cd3a24e7-d464-36fa-9363-ded612d01722@axentia.se>
Date:   Mon, 4 Jan 2021 19:09:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <20210104171114.000042df@Huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: sv-SE
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.229.94.233]
X-ClientProxiedBy: HE1PR0301CA0019.eurprd03.prod.outlook.com
 (2603:10a6:3:76::29) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.233) by HE1PR0301CA0019.eurprd03.prod.outlook.com (2603:10a6:3:76::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20 via Frontend Transport; Mon, 4 Jan 2021 18:09:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e323714d-80ed-4179-37f7-08d8b0dbe289
X-MS-TrafficTypeDiagnostic: DB9PR02MB6907:
X-Microsoft-Antispam-PRVS: <DB9PR02MB6907DF88E0C305A1A1B65F55BCD20@DB9PR02MB6907.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2zBawytE6v4eZNMmZjjdlDvtKiBrTS+ScTIvpezdMaoIwbZ6RsJI0auMeKsqeatlDRMWxZi5w5RA9FbcaqXdNy+iu8cC26guZVFmDCAYCJdHXRj7m29qU/a2P8LK6g5EcfxudkXG97LvgCpMpQj/dWkCTE2UwzLz3xi0OO2UrNwnIYHsbAHOFLnjiRf4RfniDcQXE5ySN6FHnibnMhbnvC/scnEm6zTxp0fLo9mV4kr7+jgv70X/F5n6ehM7Ram7HWt3Mu169Hqjd/iOEzzYk0a2bZlLMjHjALHgWpS1kUylkjaFOmiFKdqa4IEIg8PkEQfsX3SrZ7X4elRajHwK+9GMgMelOBLC0GpsVI7V6E9kJ5/zmd1kh4UEu1yx3r5LCS4kasWIjzv6N72Ek7VSsY4xHId2PCsdoDBQLvDkZYt5BYrtPhU3wXCs/wxkjcheMZlL0Ss1aNR5yHZmd979QfSf3lOpxxKNk4vmlsfBWGA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(376002)(396003)(136003)(346002)(366004)(53546011)(8936002)(478600001)(4326008)(26005)(186003)(16526019)(8676002)(36916002)(316002)(54906003)(16576012)(110136005)(66946007)(66476007)(66556008)(83380400001)(5660300002)(6486002)(86362001)(31696002)(31686004)(2906002)(2616005)(956004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WHFUdG4yZVZYRnpFSThqcFJBTmp0cUN3MG5RZWZydUpwNVNSbHJPb0JtQytJ?=
 =?utf-8?B?YUFZSFUzYS8xNHM0OVpvZXk1S0FaWm1CaDJwSVBDdjJ3RitCSS9sUFVQVndq?=
 =?utf-8?B?S3ZidGlRNll3dStaV0FMd0J5N0JKUDNCQ0pqRElvSEoyNFYyTkd1QkZ6QTRn?=
 =?utf-8?B?WU43UWQyckxIajlndXhBWmRvRHNISFZKc0lkaE4zUEN6L1dXM2tVOGZDYllq?=
 =?utf-8?B?b2RwNXBzaDIrN1RKMzhOdHhsYk90eC9zNmlibWNxWmJpcHBtOXdDZmp4Sm1B?=
 =?utf-8?B?a3NHazYvMFhaRzF3R0N6KzdqMlZkNnpySGxEZ0tQRldzZ1UyTXVMVTVNcGxn?=
 =?utf-8?B?aG1kdjk0dllpNWlzRmtzclNSeDVCczZsYUc3clhQL2dTeDlkcElGYTdlNXU2?=
 =?utf-8?B?Mm9EMWJrbXBoVkNPSVRyOHNYRWhvV2Q1L3plT1NYNHlxdWUvMzVsOFBxS0Zv?=
 =?utf-8?B?Rzg0YkwzZ25BSVFVdnFxeWpRMzE2OFhLb3RzeHhnZyt1KzVnU293MWhKZVFj?=
 =?utf-8?B?MGFHYXVkZFlSZW5wYWpySTV0cWUxUTRyaTY1elQyTmpxOUVzakQ2K0lqZlRs?=
 =?utf-8?B?d29WUnFOYTd0Tk5pc3M2MzlXZ2N5aDVveGd4VDZXU1JyWGFGVkdGSGIzSW41?=
 =?utf-8?B?aE9TbDczM01kdzQ0MG1aNXlEaWM2enNJblFXOFNkWHVOZWxwSGVzcVZsV1l0?=
 =?utf-8?B?azNITmhuYVh0Ky9qd2pQK3pweUxlTzAybElvUWpqSHJVNExqV2hoa2tmcFpF?=
 =?utf-8?B?dU9Fak1vNUw4bDlPVGxhTGRPSlRmeXZjLytJZDIyYVJNcUNGSGFWblFUOGtC?=
 =?utf-8?B?V1BPc1JpeSs4eTFQZGp3RUdLaXF6MUJtbVNVR2RQdlY3NUdZVEM2bUwyQTc2?=
 =?utf-8?B?U1dNcW1vaGRLbjhvcTJoTjRiTVFTR2wxRjlTTTJVb1RPeVFvZnhRMFFJQ2dW?=
 =?utf-8?B?anZveVhqRC9MQXpVNVordnM4Q1YvMEFzQTZBZ3RCRVdpSCtFSkZXcGtpWnMv?=
 =?utf-8?B?L3VWY2hLdG5kMjlMMTMzcHREcEZxRnczbklXQTd3WFBudGdTTzV5K2Yvc0xu?=
 =?utf-8?B?T3JJaDViMnkrWlVUY01aYjdxL1FxMUJpZkFpSmFENXNZdEJjRE5KbDMwMk9T?=
 =?utf-8?B?T1ZtQ2N4L3F2RVk3QjlyQmJSd24rZnpNZUUyUWI3MVJjNXY2ZFdpa1ZPV09B?=
 =?utf-8?B?MlF1WHpWa3JEOGY5R1BVWTExOFBQczdJVmxVdnlrSkNPdWptdlJjZm5xNldK?=
 =?utf-8?B?dWpqUVhZL2h5MUgxcy9RL2d6emNlZkErZTIvQ085QWRENWQ3Y2VycitKUStK?=
 =?utf-8?Q?iHowhh89zrrDbA1NTOVtNxEkVuTI9Fnb2G?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2021 18:09:31.5846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-Network-Message-Id: e323714d-80ed-4179-37f7-08d8b0dbe289
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5QcUWf+69GCBQEerwjtcR6pRNDI9U+Yjt4VjXzfYyt4jQY9vke8VagUw2RxsU6qJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB6907
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On 2021-01-04 18:11, Jonathan Cameron wrote:
> On Mon, 4 Jan 2021 15:45:07 +0100
> Linus Walleij <linus.walleij@linaro.org> wrote:
> 
>> On Mon, Dec 14, 2020 at 5:34 PM Jonathan Cameron
>> <Jonathan.Cameron@huawei.com> wrote:
>>> On Mon, 14 Dec 2020 16:30:22 +0100 Peter Rosin <peda@axentia.se> wrote:  
>>
>>>>>> And that gets transformed by the
>>>>>> rescaler into the processed values being presented as raw, with rescaling
>>>>>> added on top, but with the read_avail info for this new raw channel being
>>>>>> completely wrong.
>>>>>>
>>>>>> For the intended driver (ab8500-gpadc) this is not the case (it has no
>>>>>> read_avail for its raw channel). But it does have a raw channel, so adding
>>>>>> read_avail seems easy and I can easily see other drivers already doing it.
>>>>>> Haven't checked that though...  
>>>>>
>>>>> Drat. I'd failed to register this is one of those corner cases.  
>>>>
>>>> I'm not sure, I just browsed the code. Maybe I misread it?  
>>>
>>> It's doing both - you were right.  I think there are only a small number of
>>> drivers that have that history.
>>>
>>> Looks superficially like it's easy enough to catch this corner case and
>>> block it - so lets do that.  
>>
>> Sorry if I am a bit confused here. I don't understand what I am supposed
>> to do to proceed with using this driver with the ab8500 GPADC...
>>
>> Shall I fix something in the AB8500 GPADC as a prerequisite?
>> In that case I think I need some more pointers...
> 
> I confess I'm a bit lost, but I 'think' the problem we had
> left was around read_avail which doesn't play well if we
> it defined for the _raw value in the provider, but not the _processed value.
> 
> So if we detect their is a _processed channel (which we are going to use) we
> just need to make sure that we don't pass the read_avail for _raw through
> to be exposed by the rescale driver as the consumer as it will be garbage.
> Best plan is probably to just pretend the read_avail for the provider doesn't
> exist in this case.
> 
> @Peter, does that cover it of are there other similar cases?

Yes, that's it. Just hide _raw in read_avail if we are proceding with _processed
as _raw.

> It definitely also wants a big fat comment saying why we are hiding this!

Yup.

Cheers,
Peter
