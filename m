Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73EB0395856
	for <lists+linux-iio@lfdr.de>; Mon, 31 May 2021 11:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhEaJqz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 May 2021 05:46:55 -0400
Received: from mail-am6eur05on2125.outbound.protection.outlook.com ([40.107.22.125]:35040
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230423AbhEaJqy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 31 May 2021 05:46:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYvcRV0IFcMRyvxUYF6cf+i7eghYv8GGLJ4e7RlR10pk2KW4qO7VrHxETXUy6LSvT4+pCzR9LfHdlJMKsiGAVjU5Iel0zi7fbxAa1jQx0rHV7IrCeZXHC6yQ6nBp0TtbRSIKzet5fr9C4OKTwl8Qg9KVeh82Xpa0bMZkNDLtt8YNcvHHxnqkN8OP7ZzvUn5YyI6+CQVf+6Lq/GGF5L78YMBKvEYPyZQPOsg8i+A5h3cjpetFwF1m1AcXqPPor+kxa2svH9PDI/eD8g4z1NTEQ2S5FhGaGcXjc9/c9RMv+MFuhSDAkjtdyzHViCe9w3edGGZguabej6HIQzR+3LMpDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/MoYY3ioEbSYdRK+mJljRbtPTxc7EsKEx/Kr6PKaU4=;
 b=If2D/+GVPeg00qci0yO2qeVAFMKcf1LVoIUbYRc+3l4/qdxbt5RkDUiPhark5FtbVCKuFrNMdpDJDG82IiRU2gbquFEG9j1N9GuHSOx4TN4gXjFJcbXAHTUXLdHK6DzNul4wzBrXjAkMwSN9SETwwCbTFR5rD8EvmWkPhOf+eqfCTbqkA5AUTvb6V+JHM2UKs6iEyNtUcO5ChNvNX32NOB89+GnNJdMHyyGorsbSDvTomU4EF0Icbvn/Sg0sGXzCSStzDDp4UzJGWAAWxk9evKqQmOcSQiVvEfJHhZiegLAzvciEEWNQmYPag01ebEx2Cd39vun+LchrL20mwsEr9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/MoYY3ioEbSYdRK+mJljRbtPTxc7EsKEx/Kr6PKaU4=;
 b=QUYvNLRtzMAGl3H2n1KhrD09iCbR+mnwuM+MaqDRwAveh4OfHUnkTXkbcLff3cTsiWgIoadllEcotp+WHZb9jkYXu5CHDAJ3ZXFhF2cOHeJ9PgVdkJ2E10NWCRXdRfIXlyq98MZDslOJP0As/mwU8Fz/ox58EisGU7X9fMsmcB4=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB9PR02MB6747.eurprd02.prod.outlook.com (2603:10a6:10:1fb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Mon, 31 May
 2021 09:45:12 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::d47d:ca8c:4fe6:3908]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::d47d:ca8c:4fe6:3908%3]) with mapi id 15.20.4173.030; Mon, 31 May 2021
 09:45:12 +0000
Subject: Re: [PATCH v1 2/9] iio: inkern: error out on unsupported offset type
To:     Liam Beguin <liambeguin@gmail.com>, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
References: <20210530005917.20953-1-liambeguin@gmail.com>
 <20210530005917.20953-3-liambeguin@gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <7e6e7e30-80b6-adfd-abda-7c9ac5333a47@axentia.se>
Date:   Mon, 31 May 2021 11:45:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20210530005917.20953-3-liambeguin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.229.94.233]
X-ClientProxiedBy: AM6P195CA0052.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:87::29) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.233) by AM6P195CA0052.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:87::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Mon, 31 May 2021 09:45:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92b71b44-3635-4fe6-b79f-08d92418c963
X-MS-TrafficTypeDiagnostic: DB9PR02MB6747:
X-Microsoft-Antispam-PRVS: <DB9PR02MB6747471EFCCDD1CBA97785EDBC3F9@DB9PR02MB6747.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5S1pTMwQAQdb5QCRQObUzF6kkG+dU903dm9Gj4WXKAiBnd6bBADm+wCbKUfCLK4VrFXonX9B51pOV18COa3zSRsTx7Q4fmfaY75tKv2RTRcavN841u/OX9Ha+NrdbXep6PQ375/eR8uej+F+ATLkqKJ9ig+oMvAV3JaXAN67m1+/u+RnTJK59y4LZPzWAUKaZLuvRhKwnIreEDhZtaIW7HBN8vIxVX55I4pG7L6vM02ZTOersVvMn2guogRzlZwpYZjAFoGeKdyjUKzIhH9TirHdma7vI1v1MYSvIx1uV3RwoxVEbLaasYyn8ESZWzBVCeUxCqMJYQ3LExUjZhU62xdhT+x1/fkNvCRtwFEbck982x7Yx4LmkdHQI58u/XWAE4R5rnsRinatWnV6lKKKWmRH+aGvGD4VorTkL5tjH2yXgl8jZST8EI9MLZr+FiWwtux47EJFzF+BlmQW4kaDSOr2RVokhQ3bKTmC0ZvOILjWqdMOX4CHW17D09qrPRNS8+UEqyi/l9WvMwgAsC9SmKmoaOGg4hZzn/RiyHMXHDHpxnMKMXE7hs3DjCV4cqVYBq5dkQQWBdPMgcJ/SwloBR9SzaxzgdspTEn4R0r3nYmLhmL11GaXLFED5cPkp82kabXMAH7rpCwV9h0RVQYMaoiO3YF+2TM47cRyHRQlo2KZkkRFhVyITMjNqIDT8ouO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(396003)(136003)(376002)(39840400004)(53546011)(16526019)(8936002)(6486002)(186003)(2906002)(5660300002)(36916002)(66476007)(8676002)(66946007)(4326008)(38100700002)(31686004)(83380400001)(2616005)(16576012)(956004)(31696002)(478600001)(86362001)(66556008)(316002)(26005)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0laZ1NGUWF2cjZzaExzeG1mZVdsMmQxN0RtTm93K08xZHhCSXB3RUpDWm9Y?=
 =?utf-8?B?OHhHNGlVaGppZDczaTJDQWE0aUlZMnVDdVp3QUIxOTVtdmJoYzRSZ0tueDZY?=
 =?utf-8?B?a3B5b1RMSlBiNHAvTDNrNWdyZTE5akY2a3RxMlVIMmFXcUZ4N043VFZ2N094?=
 =?utf-8?B?UGFRWHhWNytINkRzemdHTGkra2hDb2xqelhDVVdVV3c4bjlMK09laXBkbWFT?=
 =?utf-8?B?YVFUOTMwNUlnQzBqcXBLNjZTSDI5L0lTeHZKVkQ5VmVmem9QaVdlV29aMFNk?=
 =?utf-8?B?MUNGbDFJZXE3RXpxbythNkFPdWhsUkJMTWpOZXQrYVNMaWg1TUxrZEhXVCta?=
 =?utf-8?B?eTNnM0VHTzdaUXUzeWpCd1Z3TXlnN0w0VGdscUE2YjQzL1FDMVNhREdpLzN3?=
 =?utf-8?B?SjhUdG9Tdys3OEFHN1gwVVdVbk1ZY0xCRTJkRlY5ZkFwZHBKcDREdTlsVVcx?=
 =?utf-8?B?N0RqdDR1cTRHU1kyTmV1NElrcGhFOCtBK1JwYklhTnVQcHFEaUMvMi9KWmhG?=
 =?utf-8?B?ZVZySkhYcFZUUE9selVpVGtMclU4ZURlVFFyTCs2bzFhUzB2UlJNTlhISWFa?=
 =?utf-8?B?UFNoVlJGRnpTaGxyZFJCZkRtaG5HNVFmNGMxU2I3U3hMazB0cmtucTZ1T2Nl?=
 =?utf-8?B?bENMWnY4K1ljT0xHbkovU2hFWkUySk9WYUp1SGV1SmRLU1lIMDhxa0xISk9H?=
 =?utf-8?B?MjZyMlM0RlRQcFZTMTd5dXNJSEZrMnZwdWpreXRLZ2tsTCtBMkVFSEZhZWpm?=
 =?utf-8?B?S05YQVNZZ0RaZlZMZXhFVTRBRWdHS2p6SUhkcEN3ZDRzdUNMdmhReDNpdzFx?=
 =?utf-8?B?VzdUMmdGNklMWG16TFQrYmllekgwbVFSWVRHSFhaWFl5KzZhdC9mQmcxdXhM?=
 =?utf-8?B?UlpxK0JhOGJXNVBNcXZKdExYYW5xZGR5UG43OWxZUHN4dXNadFdBMkdybmVE?=
 =?utf-8?B?dE81SUw1bkQ2WUV1VGNKbU43bStlRXI2bDhCd3ZKVGpPdEVldVNEZEhBYnBU?=
 =?utf-8?B?TVl4akhmaVkwMXdDSERYZmtsOUdSNFNSV2w1RjZsVGNXZEw5QUVBdHNpZFp1?=
 =?utf-8?B?MExYKzBaVURNQk5pMXIwUFM5YmN2WVpvK2JyUEVraEdJTXcwbUdWdFA3b1pC?=
 =?utf-8?B?ZUpsQkdFMktxQXhaejlZWUhzNHAvbnRzaE9CRHJGRUVidXBNSU5LTFM4NWdU?=
 =?utf-8?B?YmM4dW0xRytTSzhSUTZjYTkxclN1ZlZXOEdaZFZTSURVTTNkVFVwOHZ0aGtX?=
 =?utf-8?B?dm5BWDd1TXFMRVA0VUwwa3c1bzVxUGorTFpQSS9EWFJXZWpSV3UyR0FjN0Y5?=
 =?utf-8?Q?xeF2ClT/9r?=
X-MS-Exchange-AntiSpam-MessageData-1: 7rN9mOWYZxPNr02IgryJIwpINJhZ5mNcjKDiy4y8hZahCwa0P2VeEsBxrkl8tEx0uOZyLmvsP5VxVmo7K0BBJ/1CeQiMorfGRM6r2XaYUKcAMPABKc//PpyvwLGkcUop/sixL1b9+OYZYooRZaNa2NQqRVOwea3DvH3qNEWXcHfcpeL9+6K7gXm8d5aMBx3fLT7fOldZvkEyMkmfh/BkExDRCB/wYNx9Q8ZsR6y0bvQsDmK9MfIwMbENoT8zib1JbDDvRNm9otYqrf1ljn5D1bLvG2+k63Uaoi58n+2dzVLEFGjf5dL37FiJM30uRsnl4bot9u2ovIvuwqW+KCtYfMAn
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 92b71b44-3635-4fe6-b79f-08d92418c963
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2021 09:45:12.7515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eKdeEjJzD4tOKpjxlTFmzgtZRfmaWWBqx3xgLSPN8/LfJjvV7Pf0CWvGDGNqi0D4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB6747
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi!

On 2021-05-30 02:59, Liam Beguin wrote:
> From: Liam Beguin <lvb@xiphos.com>
> 
> iio_convert_raw_to_processed_unlocked() assumes the offset is an
> integer. Make that clear to the consumer by returning an error when an
> unsupported offset type is detected.
> 
> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> ---
>  drivers/iio/inkern.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index 4b6a8e11116a..dede4536d499 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -595,8 +595,12 @@ static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
>  	int ret;
>  
>  	ret = iio_channel_read(chan, &offset, NULL, IIO_CHAN_INFO_OFFSET);
> -	if (ret >= 0)
> +	if (ret == IIO_VAL_INT) {
>  		raw64 += offset;
> +	} else if (ret >= 0) {
> +		dev_err(&chan->indio_dev->dev, "unsupported offset type");
> +		return -EINVAL;
> +	}
>  
>  	scale_type = iio_channel_read(chan, &scale_val, &scale_val2,
>  					IIO_CHAN_INFO_SCALE);
> 

This breaks the implicit truncation that happens for drivers that have
offsets of type IIO_VAL_INT_PLUS_{MICRO_DB,MICRO,NANO}

Implicit truncation might be more appropriate than an error?

However, to error out on fractional offsets etc still seem appropriate, but
there are corner cases where the existing code did the right thing. E.g.
a denominator of one or a fractional-log2 of zero, but a big denominator and
a smaller numerator would also just result in a relatively harmless truncation.

I don't know if it's really right to just break that?

Cheers,
Peter
