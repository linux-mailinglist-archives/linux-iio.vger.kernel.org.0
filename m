Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA823CC1C4
	for <lists+linux-iio@lfdr.de>; Sat, 17 Jul 2021 10:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbhGQIOZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 17 Jul 2021 04:14:25 -0400
Received: from mail-eopbgr00108.outbound.protection.outlook.com ([40.107.0.108]:42318
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231228AbhGQIOY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 17 Jul 2021 04:14:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHHw1tIFZBD7ABiDPiVQ+vIiBanXf4V38Db7rc7xjQxKYXQPSv+WGxFk9HvXOJUKl1GtMB9H5Vy4RA1DzHRMf6pl8N++yvg/bEDzDbShsggWFr6NZwX+S+Uwk8JCJ99Dgqc0lL4vFGAH0qTtUFgPZFzkV8nud7/xFs8tPfQVy/j4N97QgNWhx8mD5YNnxqdYoEdGujoXc7DZ9F+oYnlssRXA+cFdIs02QeLJN66Ti5JgeTjTB9ASKn4iA0uus7g5Zef5MU+Hj1Mss/BlenMjCeZgUeKb9wb8bDvzL9rRyK7xx9Ac7RIkP4RCiAP85CWl9tEbtoFEh7976VgBhv8rfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0XMDFLH7jKiaD7qTXX8v9Lpw4RP0vGPlf+OzvKYRoM=;
 b=T2zmfOy9ddNzEta064+CoKWzJcxxCp5+mXnODtsL1h6IMgGfOO/7TQniikLRLMSgKl6YMAlffbBCL3MnGBVNAREhgWzXDKTzvCiwC49s05w3Y6muUT43uUo0JDSl+5DLNvjMl4Ozyn7XeBmj2iall8Evlks/GXkeugHKMxvgSJrq+pMXQ9daV6xrD/eGbS5pg4iV6iWGL7Kr6KV4SgSRcawXnrIliwjNC8oU+2U92uObcDsF3g8tcbAdzfarL1B5MR8GL5WiU6q12KeRVH4FNKV4xMRHEACg0ug5gpXdSiwBMX3egQjj88JVqWGG67Nfuw6YX0N644zp1xTIleFqlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0XMDFLH7jKiaD7qTXX8v9Lpw4RP0vGPlf+OzvKYRoM=;
 b=DzRzF1dV5Xcnkvqq+cgZY5hs3V76/s5CJPL+j+Gn0UzN6/HJ97+uUef800mr3Lhv10g1uSQLFnDKj187ynBRoP0BLRgXkRiOdeCmGuQeqvxESvMKSqyfu3dleLzwkKsjHLuUn+sNCQO4yReM0odByxFpFDd74hJPc6JlZG36pFk=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB7PR02MB5244.eurprd02.prod.outlook.com (2603:10a6:10:34::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.26; Sat, 17 Jul
 2021 08:11:25 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::14ca:a41:2218:3578]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::14ca:a41:2218:3578%6]) with mapi id 15.20.4308.026; Sat, 17 Jul 2021
 08:11:25 +0000
Subject: Re: [PATCH v5 05/10] iio: afe: rescale: add INT_PLUS_{MICRO,NANO}
 support
To:     Liam Beguin <liambeguin@gmail.com>, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
References: <20210715031215.1534938-1-liambeguin@gmail.com>
 <20210715031215.1534938-6-liambeguin@gmail.com>
 <8417f698-eef2-3311-625a-1ceb17d3e5b2@axentia.se>
 <CCUT1ZDDWS1J.3CGKX5J1MNFOX@shaak>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <cf709fec-e2f5-5ab3-42d0-7080e11eadae@axentia.se>
Date:   Sat, 17 Jul 2021 10:11:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <CCUT1ZDDWS1J.3CGKX5J1MNFOX@shaak>
Content-Type: text/plain; charset=utf-8
Content-Language: sv-SE
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1P189CA0002.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::15)
 To DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.233) by HE1P189CA0002.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Sat, 17 Jul 2021 08:11:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a7f50c1-f51c-468c-16fe-08d948fa7872
X-MS-TrafficTypeDiagnostic: DB7PR02MB5244:
X-Microsoft-Antispam-PRVS: <DB7PR02MB52440DDD4AFBA92015B4B3D6BC109@DB7PR02MB5244.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xx2VVtb9J/z32Ml3jwXv7DH2MsLtLCDVhdrwgBLp7bPHwIGAgTxonVBDVguK8T/sCoetoOLnglYona0Ldy+pu7ycwGGAvXY5mcImXxptGQoZU7QyCvqM0Q99WCC0iPnQ4lC3KqYt25WJ+sHX4QNLSTQJEAZnaQT6GlbO6yjLZvQFWP+bM5JbetOYtfeIz3ccE096LLcAr0yOWAak/PL05L9oaUqwrFQHkzFf+K5IRCeX9VbHrTNxmQTbVGnnvSjzPYdDVQ3tq5NQLr2/Lc9ypyjuofTvOLXzJwqboVijEWciMT9h6k3SCP09SMlrsKKwzcUvwhWZMROfjIz3KwLcMvTCRmc53Ek0inFMpxeFblKm/9rUyTloMSsHUjLzCWZPh+l4PdCNmv6tWMBWxaU6jIYPTQrmyJ6lozmbjFR4HE86HYj0PdtopRlYyNmcif3PT+iM1aZTpLo3zMCeMPJx5SLJn+ynhCm5RrUUXUJYucA93HA06F238tll22D+K1bxDN+cPwXfWy7YKh4OzniSfVCLif7kS7Uat78L/ox8HzmF28EmEHMut83u+5kKHMBsbv2MrNFWuo6pCj5eVIfHYhHawA4Ip7bE7kHWocRd3jiJZWzyLwnRxUZEhCuhfEvGwhVhF7lyuUGOwejFIUR2exDFhRDx1hNQqwJhWgg/Ve6kq1WBxqfpH7l7DBsw+H1ug0mnKHl/CvI+RZrHEOE1QJw3bAtqiSfsBWW/lzzob3Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(376002)(396003)(366004)(346002)(136003)(4326008)(5660300002)(316002)(16576012)(186003)(86362001)(8676002)(31696002)(83380400001)(8936002)(26005)(36756003)(31686004)(36916002)(478600001)(53546011)(66476007)(66556008)(6486002)(956004)(2616005)(66946007)(38100700002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVZUMjFLTHN4ZzY2QVhhcFZzVmdGOW84eW40YitpcWRRZHhaM0Ywa0pyOVVw?=
 =?utf-8?B?YUExVDJJYVV1TFhOMXBKaGhZdWptSkJqWVIyeTVnYXBGaWtEZmIzS24wWGRm?=
 =?utf-8?B?Q2syUlRGWEhGbE5IcUc0Z1JqcFBqUzNmNE1abzNvMkdNd3FvMFMvYlNsL2hv?=
 =?utf-8?B?eG04Mkk2dnIyemtmT05qZEFvUXU1QlcxeGszMC9aOU8zU3NwaUplTGlFaUJQ?=
 =?utf-8?B?enZQQ0RrRTdoMEZ4MnM2NnlWeGVXRFZ3U3JqSlFIYXJRUytkeEdhZU4rdGhR?=
 =?utf-8?B?QU5CUVkweGdGZjhCRllTcytWd1NRZlhPYmFQV2xNcG5DMytiN0NzeWRWY3Z4?=
 =?utf-8?B?c2cwczZIK0ZRMmQxSU5CNTJRSy8xSEtFSFZXZ3A5Q3pIZmkwRkk4VDhZTEJZ?=
 =?utf-8?B?ZXV3cklIWnhXRkdyenFBYUNKQjBHUHBGblFZclFYYzNXa2pkNEIwU2pPZHFl?=
 =?utf-8?B?T0t1a2pHeXlZcjhSRkRrellGSUJaNmw0MG9RMk1wSFB2eFkxUzVRN2JGRkJq?=
 =?utf-8?B?RGR5K2h1d0FXdC9PZ0NXOFpFV1FKWUdYdFZEK3ZLSFQxbW02WGxSb0oveHI2?=
 =?utf-8?B?UVBBUUVDTFhaQksySnFaUW1zRXN5cWQ1SENVMUx4eStQV3NGeVd3RHRDVDcw?=
 =?utf-8?B?TGhOcmhEcHZ4b1BVeWFsVHNxbDZFVnRvUldrWmVLd2VSRUE0VFFXQXU3TE5Q?=
 =?utf-8?B?bzdIVkgvVHgvNTdzaElESVJ4NnlINEtSZlZ6Q2JqeEVjWVM0TVo5TkJtSGU1?=
 =?utf-8?B?aWdJbGpQZnErQThpbVoyaWNlLzhJUkxIMzNHc3NzR0d0ZUVnNlMwbUJOcVpB?=
 =?utf-8?B?cTl4TmIvdG5pM1FmSDRyS0piSG5TaUo0QytXdkhlK2NRT0Q3amNFYjdFc0J1?=
 =?utf-8?B?UDlJTnhQRkltdGI2K3BpSndtM1BwZklYTDBqaWFMbzBqb0dHQUdobVFnallD?=
 =?utf-8?B?bkNEM0ltSCt3MkFzQmtnaW4xNEptVnpoeE5tUkovN1dmcVgzYURvRFo3N0Uw?=
 =?utf-8?B?b25DOWxxaGxwUU1QRW5hbU5JbU9PNGJuZWpWUmo3c3dRL3huTEFBQTUxTnQy?=
 =?utf-8?B?L3Y2dG1XcVVCYTJYOWlsTjFwd2N1WnVMMzFPQk9veEpEb1FqcEt5b3JTMDM0?=
 =?utf-8?B?NmhUZlZwdkF3VDZLZ3pkQ2diUWVJRVJHcC8zR1I5dkJqY3Y1VjdsaUpVd1pw?=
 =?utf-8?B?ODVaRi8vc0g3NnVneHpiY25EVlAxU3VCQm5sK2lUdXNSTTlEYVJPek5uZU40?=
 =?utf-8?B?SUFBVDlMSlIveFc1VjQ0LzdOYnJaTzN6c0szM3ozQlZkM1gwenJabzdON2NU?=
 =?utf-8?B?OGM0UllLR3JxN1g5RlhxeFhlZFJtclhlY2p4ekFXa1YxR2JmTktkbkdoVTBJ?=
 =?utf-8?B?dTBEeUpTMUwraEVFdTZpMUtmZmd3S0xSV28rcGNJZ0FhbWRoV0QwNDhSUTNB?=
 =?utf-8?B?cVk1b011RmNjL1NQT21Mb1krclZvSlFRNVZZODlIMjVVRXNhN1dGck84YkVU?=
 =?utf-8?B?L04wZVFnTFFoMlpNN2ttOFRibGY2M3M0c2syVGFENTFrUmVOcG51SjV0eEFr?=
 =?utf-8?B?STZLeTFUWUM5Z0R6bStaMmxvY2VLeU9UbFhJSkY0OHIrM2RUNHp2QnAxb0NI?=
 =?utf-8?B?RmgxbHNVVTlyVzFwUUI2UkFUdmoxdjUyUW9pZ3NCU2pFbFI4Mnd2UTVQVVpG?=
 =?utf-8?B?YXBzSXFkK2JGQ0hOSnUwZGpaSnQrNjdNcXNmYldxRjEzbzRtUGFZNU1FWGR1?=
 =?utf-8?Q?Dk0tKjoD8+4oi5pKgXPMorPojNlPAjbFf38jj8m?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a7f50c1-f51c-468c-16fe-08d948fa7872
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2021 08:11:25.1891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VyS9S1BT1XRbQdMQWYGWe+CHB8D10ULBeUqSdZqWLoCdd0bEsocLCGUBuyOzUBgZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB5244
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 2021-07-16 21:18, Liam Beguin wrote:
> On Thu Jul 15, 2021 at 5:48 AM EDT, Peter Rosin wrote:
>>
>> On 2021-07-15 05:12, Liam Beguin wrote:
>>> From: Liam Beguin <lvb@xiphos.com>
>>>
>>> Some ADCs use IIO_VAL_INT_PLUS_{NANO,MICRO} scale types.
>>> Add support for these to allow using the iio-rescaler with them.
>>>
>>> Signed-off-by: Liam Beguin <lvb@xiphos.com>
>>> ---
>>>  drivers/iio/afe/iio-rescale.c | 15 +++++++++++++++
>>>  1 file changed, 15 insertions(+)
>>>
>>> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
>>> index 4c3cfd4d5181..a2b220b5ba86 100644
>>> --- a/drivers/iio/afe/iio-rescale.c
>>> +++ b/drivers/iio/afe/iio-rescale.c
>>> @@ -92,7 +92,22 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
>>>  			do_div(tmp, 1000000000LL);
>>>  			*val = tmp;
>>>  			return ret;
>>> +		case IIO_VAL_INT_PLUS_NANO:
>>> +			tmp = ((s64)*val * 1000000000LL + *val2) * rescale->numerator;
>>> +			do_div(tmp, rescale->denominator);
>>> +
>>> +			*val = div_s64(tmp, 1000000000LL);
>>> +			*val2 = tmp - *val * 1000000000LL;
>>> +			return ret;
>>
>> This is too simplistic and prone to overflow. We need something like
>> this
>> (untested)
>>
>> tmp = (s64)*val * rescale->numerator;
>> rem = do_div(tmp, rescale->denominator);
>> *val = tmp;
>> tmp = ((s64)rem * 1000000000LL + (s64)*val2) * rescale->numerator;
>> do_div(tmp, rescale->denominator);
>> *val2 = tmp;
>>
>> Still not very safe with numerator and denominator both "large", but
>> much
>> better. And then we need normalizing the fraction part after the above,
>> of
>> course.
>>
> 
> Understood, I'll test that.

I made a thinko. The remainder should not be re-multiplied with the
numerator...

	tmp = (s64)*val * rescale->numerator;
	rem = do_div(tmp, rescale->denominator);
	*val = tmp;
	tmp = (s64)rem * 1000000000LL + (s64)*val2 * rescale->numerator;
	do_div(tmp, rescale->denominator);
	*val2 = tmp;

And that actually reduces the risk of overflow too, which is nice!

Cheers,
Peter

>> And, of course, I'm not sure what *val == -1 and *val2 == 500000000
>> really
>> means. Is that -1.5 or -0.5? The above may very well need adjusting for
>> negative values...
>>
> 
> I would've assumed the correct answer is -1 + 500000000e-9 = -0.5
> but adding a test case to iio-test-format.c seems to return -1.5...
> 
> I believe that's a bug but we can work around if for now by moving the
> integer part of *val2 to *val.
> 
> Liam
> 
>> Cheers,
>> Peter
>>
>>> +		case IIO_VAL_INT_PLUS_MICRO:
>>> +			tmp = ((s64)*val * 1000000LL + *val2) * rescale->numerator;
>>> +			do_div(tmp, rescale->denominator);
>>> +
>>> +			*val = div_s64(tmp, 1000000LL);
>>> +			*val2 = tmp - *val * 1000000LL;
>>> +			return ret;
>>>  		default:
>>> +			dev_err(&indio_dev->dev, "unsupported type %d\n", ret);
>>>  			return -EOPNOTSUPP;
>>>  		}
>>>  	default:
>>>
> 
