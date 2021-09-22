Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60048414171
	for <lists+linux-iio@lfdr.de>; Wed, 22 Sep 2021 08:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbhIVGCm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Sep 2021 02:02:42 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:14176 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231908AbhIVGCl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Sep 2021 02:02:41 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18M4n7e7021885;
        Wed, 22 Sep 2021 06:01:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=VNc5iaSLGO+11etq408ZH2/vWVZt/thGt1CVZL+UW3w=;
 b=GE6iXE53MBOgNcfq3AmwnYL+IfbeIZ6yosvXU31bCV671ychzyuFOHtZta46dlqBFRaf
 K1sp+3mDTO/9zhaF3C8x8TdFKkw+iUUoluBF/op9E5xO5NpFnMPCrbrAoXXLFV7Cq6Lq
 A8NAmFs6z7T6Hu/Ox3YkEfC0NB00M26RptW7pC4x/hLPzlGUDYvxUeXIMqaJW8O3t6HY
 voJ2rp9HtJT1dtI1tRvUg7ynUo/YeXVrjGAv3oyEULHmgTLjVRdh33lbk6MNPMlkCV+U
 8u1UBwzoyybu+sAachKKTS5YVDyko4MHLmAE1rJugcrFFZ1Ui21FkN7r6y+YdtbdlTWT /w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b7q4p1kkc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Sep 2021 06:01:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18M61191032558;
        Wed, 22 Sep 2021 06:01:07 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2173.outbound.protection.outlook.com [104.47.73.173])
        by aserp3020.oracle.com with ESMTP id 3b7q5a5uph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Sep 2021 06:01:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SnHB06hqyaatEjakzm6eO13Md1u8BSANDsjOEej0zt8LnwNqtYmvnDUGE2nB29HWY83jeet5f/hyMP2X9wTPnlGWbzZeEqCeaCNaeAIHPzT2hg8Od43Tq4/uOtIO2110c/L5TZwSsOkMi6nGFJEyrkpsmBs/AlEN1ghrLJBpYr6awhLPoWYpFqMfUohU/hH/ci2j62cqLKr98H8LwpMynhA6asobBRhNCufz0PEuboP5Q7uzT+oVVuwDo4tEPDshtNOO7a8B7fZhE4BA17Inj39g482CWUJu2eEciejmpu6zqwuVuf2loFriv4lICsln5qivmhYmAsFd7k2tuGGO5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=VNc5iaSLGO+11etq408ZH2/vWVZt/thGt1CVZL+UW3w=;
 b=KxvTW+gebe+5Qqk/3nCQpW+7FH8lw1ZoYfxKsSGC/PsTblpMMuvhiMzLnR7o8HBGNnKmv5PkGUgkymBC7/UFcmW0wAWIdUaw1lO6VhwHF8XRhpWCANrkKYbWCxgSpnLSUTE52NDA7aw2rgZJjVNPN6ohvbadHErIq0fkT7lFmAcPKeqcCMD4EPBr7MrygLoblIoV1goiCUesKbbj2hyqIEgjxEDm4iH9HtPlLZtjSsQwF1+WWJL990ipAi6K6Uyd2vitHkqSKV63s2EXS2PeFVVSg90nZ0jYyMfQP1tSvAIY4+CD8FGNwz9LEIXi3KXZsmPoPq5elUQ7quYaWK+iaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNc5iaSLGO+11etq408ZH2/vWVZt/thGt1CVZL+UW3w=;
 b=x7VOhrXspLIAaLeVJGKC2B/B6+8IFWwBIEvsMX/1H1HI7MpHTRoDHUqfLLqOcRnjkvctxJme3XKQwSl3iD50D9tJPtZjueDcgTJHbcMY7At5IPR+EWG9rSuQZMQBJxMQfVS4H5WjtuiTWQ6xWpBC6guPf3kOqWQp2DbMQ9xoYWQ=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 22 Sep
 2021 06:00:42 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4523.018; Wed, 22 Sep 2021
 06:00:42 +0000
Date:   Wed, 22 Sep 2021 09:00:26 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     lvb@xiphos.com, linux-iio@vger.kernel.org
Subject: Re: [bug report] iio: adc: ad7949: add vref selection support
Message-ID: <20210922060026.GW2116@kadam>
References: <20210921063509.GA26209@kili>
 <YUq63O3ksdr9R3pE@shaak>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUq63O3ksdr9R3pE@shaak>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0017.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::29)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JN2P275CA0017.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Wed, 22 Sep 2021 06:00:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b68439ac-6ad3-4398-c6e4-08d97d8e4f52
X-MS-TrafficTypeDiagnostic: CO1PR10MB4705:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4705D9A215BFA5F5ED1F2DF38EA29@CO1PR10MB4705.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p1HwglczMOooO8rrEIyOM2E7KqiO46yUsHAPI0xEY7FFFqxugYTjzegHA9eqMwy3flQf1lNF1I2tXRs/8zdvW64jwe4wORM3bPkjT/QMQPuf1lGU1sDh7qY8RI219ckgfVm7KJe8q+Wk0lP82sWNvfGRrtAlkc2szWIZMMCOWnxGlH/Bsuhnax8kMgoM07ecTN6t7oJbKgkMMFl0WNv7RKnKHUcx6Vr6ayjHLvMf5Wbipf83jo9FeDj0EvVUd6WbnvshB0CBxwOG34xW9SnIJCxqi81+2HvTywB3BpFiOxNPd/KRGC8I07qbGteXYIWCp0OgUE/RpwFHMwqE7AiOVGFslWWRvDXPjK5zl8JRY8bmOgtd+U19M1ucX8dJY/6teKRzg9gtti+JVhowySYCvlw2TPsA3Zskc4pEBkmV/3Rb/gA5iSMdScDF44TBuafdOytPSfkMPKxa2piM51bUmtiteUEBQQlBDieueVhpmGcBMky93/g+EZhETU2AzaBnfFklMa1qlmVUDgluSXu6hwwcUkftB7A00bPA10IfpkCMJBeaX6P4mB+UB9lrEv87qiCcXZl8gQm4tcaTetXhFdTi6CDRqMyXCBDAcDzmGU3Ti5wgJQ6H8K90WBTPbkY4N5htCGeWB+FbAnRuYdHIpNmLZkgfkLWdDYAKVAOt6gmEQeHWl51XXJm1laGa5J2j2BnzXTAUzMORlpptNQFPFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38350700002)(8676002)(38100700002)(55016002)(9686003)(186003)(1076003)(6916009)(8936002)(316002)(508600001)(956004)(33716001)(6666004)(44832011)(83380400001)(86362001)(4326008)(33656002)(66476007)(66556008)(66946007)(26005)(2906002)(6496006)(52116002)(9576002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eWpDytn+EwT4mpaux8+Y5euUrSfK4RoWd9I6eDiRkmVXxUh+p52N7jh+JjD0?=
 =?us-ascii?Q?VEHj27N+53iW9iOdm5aoSTjoqCyz/jurEDQeGkt03xmGD/wV/WrmIxwOG8J4?=
 =?us-ascii?Q?mmRX4tL457JWpO6LD3Dejpxk4YJ4f5mHJwoI+Ah+rHP41+144IwzMP5Jm2ZQ?=
 =?us-ascii?Q?ntiK/pG+hUsXUAgG6cdoL/GWB2RUD3BhpKmOF6vbWgD2duDg+EXHk362IgfU?=
 =?us-ascii?Q?BpiyvVVoWQ7KOsdkVU+Sp+HCXMvPjTGODu0ml3NIKPq1QfZ81xuUhWJtIBze?=
 =?us-ascii?Q?N8T69OHFGALtH+EuFo+pEpX7riQeXpm1iMn4VN8Nmvv+q5nBi3GpA4HAFidR?=
 =?us-ascii?Q?43Cn0UPKdlyUUh8AaGolVX266qLDR6XfFO7YsBMIF9VtQM++vUCqlIX8kHdn?=
 =?us-ascii?Q?WkDhBStZ1NtdNCaZuWYRHVhhdBRIzkRbO2MKSO2jXjfiLVl9ko0h6RN95wHZ?=
 =?us-ascii?Q?OQCz/e055NBE+/3rGMunPo2XtFpBuVPARu+7PGd0EEAfKr+vPOAeqZFFX0js?=
 =?us-ascii?Q?9mRoqRMYYbaYON6H6/qFE4sLXAzo7ip795nOxZz7VLp5ZuTRNK2xzNu8ygi0?=
 =?us-ascii?Q?ZVt/2pAvbUdFX54rrdNwZbc7nheh3PRML2Fpps5q5iuTy5T2dSxvMWxWJpk0?=
 =?us-ascii?Q?fzSLaKdScX9ySp1NhXzV/Ol2zBzxFwUQn4FII4OU0cJDoD5xMs+hhUdeeOem?=
 =?us-ascii?Q?4PhA58Pf4sSf9OlAXrk/MxbcRPTDsJYBf29akrswbrSJKhdrgADo6QPdfzoL?=
 =?us-ascii?Q?1BBAA2vQ1n2Mcg+xLVfiHzeg7S0WAUk6qVyJGk5JYLaRDvRx2NpZwNrHbnsI?=
 =?us-ascii?Q?qdeU+U+Auype9XZmCgtQIn1WsIsQZbTBe+bqliwMGFESTIg3onXqvu++TkrM?=
 =?us-ascii?Q?fy4mJsEVlv76xR4G69QT0kRdIW7fXGHfrYEzxLTIdtzEXrjY9baPbA7uC0Kw?=
 =?us-ascii?Q?Wu4+NFyNcOPTzZm9+EnoEiWeQBp+2VjE4blfhFR3F7oLhagoC+ac/TPNrbrt?=
 =?us-ascii?Q?woJvTvlK7FAt7jBuSN6mog3vtMhpgFS94t10eg32CHu3T8PhJ5ECEMyiOvSC?=
 =?us-ascii?Q?CzeCKNoWwJrfIMA2Q5zCF2n8nGX3fZ5LwEVTpiO43/aUYOb+hS1pJJ8HH3p8?=
 =?us-ascii?Q?nZhrVbb8+sJfIEQn5axKV7Df+Jxs7ohgFbgUH3NHmDKoGGgiTQRU0kVGAa9a?=
 =?us-ascii?Q?Gocu1pSzhDpEL2X9c27Si8xrLwR/U28Be6uxZaqm8Ylm1na0w1U99mjit2Av?=
 =?us-ascii?Q?uhU4lsDikFdoI5VIv0eoaLocv0sHayX7+gbzvz1e9UJ+6fGn0VId8KCIbg7Q?=
 =?us-ascii?Q?lr50gqq4tpPH56i9LV5xLzaq?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b68439ac-6ad3-4398-c6e4-08d97d8e4f52
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 06:00:42.4225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1QyVXNwTNy97JeER1otAeTaECg31hr2wThfAjVPa+Jr4pMb5Loyb679GsGkp8k2h7JbaNg7Wzu4S29xSAKBhthca9K6+IbLZIyLVP6Tc9Cw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4705
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10114 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109220041
X-Proofpoint-GUID: ypJthizul5CdEFqn5UyDf_TwqomT_kgb
X-Proofpoint-ORIG-GUID: ypJthizul5CdEFqn5UyDf_TwqomT_kgb
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Sep 22, 2021 at 01:10:52AM -0400, Liam Beguin wrote:
> > 
> >     369         if (IS_ERR(ad7949_adc->vref)) {
> >     370                 ret = PTR_ERR(ad7949_adc->vref);
> >     371                 if (ret != -ENODEV)
> >     372                         return ret;
> >     373                 /* unbuffered? */
> >     374                 ad7949_adc->vref = devm_regulator_get_optional(dev, "vref");
> >     375                 if (IS_ERR(ad7949_adc->vref)) {
> >     376                         ret = PTR_ERR(ad7949_adc->vref);
> >     377                         if (ret != -ENODEV)
> >     378                                 return ret;
> > 
> > Instead of returning NULL when the regulator is disabled it returns
> > -ENODEV.  How do you differentiate from an -ENODEV which is caused by an
> > error vs an -ENODEV which is caused because the optional regulator is
> > disabled?  You'll just have to hope that the errors are less common and
> > assume it means disabled.
> 
> I see.. So far, I've only used fixed-regulators to provide a constant
> voltage reference here, and I guess those are quite unlikely to fail.
> 
> > You might be doubting that devm_regulator_get_optional() can return
> > -ENODEV on error?  Look at the code and prepare your heart for sadness.
> 
> Thanks for the warning, I see what you meant now.
> 
> I wasn't able to use smatch to reproduce the error with the following:
> 
> 	make O=builds/smatch CHECK="~/dev/smatch/smatch -p=kernel" C=1 Image.gz
> 
> Would you have any pointer for that?

This requires building the cross function Database:

	~/dev/smatch/smatch_scripts/build_kernel_data.sh

The command takes 5 hours to run so here is a short cut which just
builds the minimum two files:

~/dev/smatch/smatch_scripts/kchecker --info drivers/regulator/core.c | tee out
~/dev/smatch/smatch_data/db/create_db.sh -p=kernel out
~/dev/smatch/smatch_scripts/kchecker --info drivers/regulator/devres.c | tee out
~/dev/smatch/smatch_data/db/reload_partial.sh out
~/dev/smatch/smatch_scripts/kchecker --spammy drivers/iio/adc/ad7949.c

> 
> Anyway, I believe the following would address the error you mentioned.
> 
> -- >8 --
> diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
> index 44bb5fde83de..3613f4e55e1c 100644
> --- a/drivers/iio/adc/ad7949.c
> +++ b/drivers/iio/adc/ad7949.c
> @@ -368,12 +368,14 @@ static int ad7949_spi_probe(struct spi_device *spi)
>  	ad7949_adc->vref = devm_regulator_get_optional(dev, "vrefin");
>  	if (IS_ERR(ad7949_adc->vref)) {
>  		ret = PTR_ERR(ad7949_adc->vref);
> +		ad7949_adc->vref = NULL;

This is not required because it will just be reassigned in a couple
lines.

>  		if (ret != -ENODEV)
>  			return ret;
>  		/* unbuffered? */
>  		ad7949_adc->vref = devm_regulator_get_optional(dev, "vref");
>  		if (IS_ERR(ad7949_adc->vref)) {
>  			ret = PTR_ERR(ad7949_adc->vref);
> +			ad7949_adc->vref = NULL;

But this also won't work.  Passing a NULL to regulator_enable() will
cause an Oops.  All the reference to ->vref need checks.  :/

>  			if (ret != -ENODEV)
>  				return ret;
>  		} else {

regards,
dan carpenter

