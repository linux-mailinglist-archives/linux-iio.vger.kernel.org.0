Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E78822E8A9
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jul 2020 11:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgG0JQx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Jul 2020 05:16:53 -0400
Received: from mail-eopbgr80092.outbound.protection.outlook.com ([40.107.8.92]:2273
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726228AbgG0JQw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 27 Jul 2020 05:16:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEp22kv/0IoHje8sV6q49zBJ8Od//nPOdJoCchkeXFJrRniAzhrl9nHC8s1pTy0ZtJXOorumvy+7bRSqATyTdtYH9YPQVQW5VK5v2CQs2xX1TpeTjke7nWOQcjI3NOLBzFLjnv7jbuj8YhqHDtsyjt2zPSEQ3/S2QXWRBtr5crHEi0HYROcqo8cj1SVouIyluqS+L7AxfnUABH6CUBi++HKX8M4bOsVarEt7o/RWY1iR2NDE9EJEVuW+4W0AMWgwosuuGkCh+37+ClVoWkSVt1tHvHlZHPcg1QOhx1/Ti/n2XjJmFqIFc46pOa07NXO6UJQ02MdR36PCqlsPwJfDiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHfbDT8EtNYDA7usp/FkCa1wC81cH3WxvoiVgY79GYw=;
 b=FZXF0QjZ5wTORz1cma0oq3v94Mo49+7y7eWotxhQP3C11QAkVbPlzeiV0HmfyzI1qIsej/GYONZtJjTcizhPkmyzYOdIhElJ+216GR9XkvprTt8BBN0gpvVctM0H9DldWK6CsQwl/inVu2KuH+TterkX6wU6u425IKXW6/wMbNAfVDOh4z+XW1XmdPBnHOyCa5ZX/mQBKNsmuU/sA2yKBSbJiFQ/Do9cXb5/7geOzDCQ6e2oNBRabCmXGeOd5dc9iY/rBl6AmohKooZUPBgs4SiAbtFO70G+3t+oL3N+xCNrtEgT6K4U3NO+P6Bty/2Xj8f525u+viGNW4MX0W4vMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHfbDT8EtNYDA7usp/FkCa1wC81cH3WxvoiVgY79GYw=;
 b=UHP+9qf/qfp/HPjERn+Qgnz34TOKSuZbVyuqhgU+NnzW/3BqaE9DL+ZDFS8nF+Rm/wtO3V2jcb+yS34UQNXwwNWSMgrbhtgZey4v8wjNY28xDR7NqUD/D6pSV0NZVXu86KV5MutqrtCiKvam8hKrLaHdLHUY6Nn82jaboV+meJA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB7PR02MB4106.eurprd02.prod.outlook.com (2603:10a6:10:4c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Mon, 27 Jul
 2020 09:16:48 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::3890:7b1:97a6:1e47]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::3890:7b1:97a6:1e47%7]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 09:16:48 +0000
Subject: Re: [PATCH 2/2] iio: afe: rescale: Implement write_raw
To:     Jonathan Cameron <jic23@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     od@zcrc.me, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200210225438.112660-1-paul@crapouillou.net>
 <20200210225438.112660-2-paul@crapouillou.net>
 <20200215183249.2100b6e9@archlinux> <7CJSDQ.D8SUUUMJPNE02@crapouillou.net>
 <20200726134123.456bf3ad@archlinux>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <800f2305-ad72-01c5-b57d-03e8b9152cca@axentia.se>
Date:   Mon, 27 Jul 2020 11:16:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200726134123.456bf3ad@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HE1PR0901CA0059.eurprd09.prod.outlook.com
 (2603:10a6:3:45::27) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.226.217.78) by HE1PR0901CA0059.eurprd09.prod.outlook.com (2603:10a6:3:45::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21 via Frontend Transport; Mon, 27 Jul 2020 09:16:47 +0000
X-Originating-IP: [85.226.217.78]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f393d05-f8f4-4297-378d-08d8320dc9f1
X-MS-TrafficTypeDiagnostic: DB7PR02MB4106:
X-Microsoft-Antispam-PRVS: <DB7PR02MB41066827CF7758FF01397D14BC720@DB7PR02MB4106.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pQpPvIfPGhKf6k6oL49bUNhLSNmH/0MESGdXgRaRLGqQssiHZcBM0WICNhZVfMDP47czgwsWdQtmB5j4hOmLXRhJU9l+QsGo6TD9SRSaGUkALhFgDUgJItc5nMCkS6AiyzNAzk3HVdPX7eI1NaHNEtKTOHk735sdseD1ZpptRULVUODdzCUbUu41mJKRs4vIBM4KVTmOvwYD2GGTjS1eJ15EeOdlDzjmvNk7CsyQOHSEz6SYVIh6+2ncJqCNMRL3j5H26+CjItAS4xNXhJg2E7Z2jwcIALYRnP5xYF/gtD5MMbHYncjjfUYPRcwM4LyUhrsDexAUiYZ9gfn3uLx1l80HKQuuw2Mh3d57INTv7hqSGbiDBUXzI2OCMkRiDeAl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(39830400003)(376002)(136003)(346002)(366004)(66946007)(66556008)(956004)(2616005)(31696002)(66476007)(4326008)(110136005)(5660300002)(31686004)(26005)(8676002)(16576012)(16526019)(186003)(36916002)(316002)(2906002)(52116002)(6486002)(53546011)(508600001)(36756003)(6666004)(8936002)(86362001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: gavP1Fb1MTf9A+kaC3PIumKhpJxJuL8KY8H43BQ2Ge7UeWIO6yleOQyj9W0Tw2Pd2I/WaJuzLLZkmGJ1P/fPlI1mweA70rFhNmZvkQGq8VVlkS3MAsXzK2E8zoGXseBU8nheJHRFuhnCU9QpzPIyOtBnuIxILZjt4YB9fJbxhwSLybq1k3VinAIO7hfkeZdxYsGE3wdIUhvJtzCCRdmgxSrpIusytiQ+TIy7kCcUmeUNwuaWnhLIL7ylmK/wl3nRluNYKIxqlbMZX2xM5AzMyykl17EZXGsOtabAb6zo54OJngDWVjUD8+1o2f5EzUr3gDgasazT57DCQ1fD1PeBAiD9WBXEmEDDriAX/94MT9rZEt3qUlO3AfPq2heOCZBGTEDWS4CPMP4yM6UuFFwCzdIxYe5ekY1yAi5zN3sIgJhiepuirxjuz7SNt51VNyn6ubmAKD5WxFZDH6ANw59+uOhFX8ZFPVutfkvu57I/aNE=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f393d05-f8f4-4297-378d-08d8320dc9f1
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 09:16:48.0625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kTlOe6qWZJ6z+Y2oXC5VIDGJ9VE1Yv7lWTYowaurk6NtyX7dsPXeMFu1reDwGT5Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB4106
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi!

Sorry for the delay. Vacation...

On 2020-07-26 14:41, Jonathan Cameron wrote:
> On Tue, 21 Jul 2020 01:16:55 +0200
> Paul Cercueil <paul@crapouillou.net> wrote:
> 
>> Hi Jonathan,
>>
>> Le sam. 15 févr. 2020 à 18:32, Jonathan Cameron <jic23@kernel.org> a 
>> écrit :
>>> On Mon, 10 Feb 2020 19:54:38 -0300
>>> Paul Cercueil <paul@crapouillou.net> wrote:
>>>   
>>>>  Implement write_raw by converting the value if writing the scale, or
>>>>  just calling the managed channel driver's write_raw otherwise.
>>>>
>>>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>>>  ---
>>>>   drivers/iio/afe/iio-rescale.c | 22 ++++++++++++++++++++++
>>>>   1 file changed, 22 insertions(+)
>>>>
>>>>  diff --git a/drivers/iio/afe/iio-rescale.c 
>>>> b/drivers/iio/afe/iio-rescale.c
>>>>  index 95802d9ee25e..a48f6af9316d 100644
>>>>  --- a/drivers/iio/afe/iio-rescale.c
>>>>  +++ b/drivers/iio/afe/iio-rescale.c
>>>>  @@ -35,6 +35,27 @@ struct rescale {
>>>>   	int *scale_data;
>>>>   };
>>>>
>>>>  +static int rescale_write_raw(struct iio_dev *indio_dev,
>>>>  +			     struct iio_chan_spec const *chan,
>>>>  +			     int val, int val2, long mask)
>>>>  +{
>>>>  +	struct rescale *rescale = iio_priv(indio_dev);
>>>>  +	unsigned long long tmp;
>>>>  +
>>>>  +	switch (mask) {
>>>>  +	case IIO_CHAN_INFO_SCALE:
>>>>  +		tmp = val * 1000000000LL;
>>>>  +		do_div(tmp, rescale->numerator);
>>>>  +		tmp *= rescale->denominator;
>>>>  +		do_div(tmp, 1000000000LL);
>>>>  +		return iio_write_channel_attribute(rescale->source, tmp, 0,
>>>>  +						   IIO_CHAN_INFO_SCALE);  
>>>
>>> Why is val2 always 0?  Won't that only work if the backend device
>>> has integer scales?  
>>
>> Sorry, somehow I didn't see your answer.
>>
>> Indeed, this will only work if the backend device has integer scales, 
>> but what should I do? Just pass 'val2' instead of 0? Will the value be 
>> correct if I only apply the scale ratio to 'val'?
> 
> I think you'll need to include it through the calculation. Given you
> premultiply by 1000000000LL it should be easy enough to do.
> Then for the final do_div you can easily work out the val2 part.
> 
> I'm not sure we currently have an inkern interface to get the type
> of the channel attribute value though.  You may need to add one.

Right, I didn't originally add scaled writing as
1. I don't need it.
2. It's a rats nest, IIRC some drivers are picky in what they take and
   you would need some kind of matrix of how to best handle the different
   conversion cases. I just didn't want to go there, and this patch
   feels far too simple to be adequate. But then again, maybe my memory is
   poorer that I thought...

Cheers,
Peter
