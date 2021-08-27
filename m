Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 558E93F9539
	for <lists+linux-iio@lfdr.de>; Fri, 27 Aug 2021 09:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244455AbhH0HhA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Aug 2021 03:37:00 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:33594 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244457AbhH0Hg7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Aug 2021 03:36:59 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17R6IkQm015051;
        Fri, 27 Aug 2021 07:35:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=x88zVL/26CdEfAIvIIJfHVOTsygrUK0oTbnAH0h53AY=;
 b=EnZil30Mw6PXk0ng304pdnnvH7DRsv16VwqRP81d0TZHtOyx8z26ca67adNzl3rxWSKM
 IqYshbLd4AJb+JxwFm2a1eFVF05/rLOHEqMmgdOt4bBWBKBj9bjwmeQnoexuXIta9idh
 XcP6ErOQviHAXSnNZI2Z0fvAXY7AlkTzi0tnnirJZoTXwoCpf7LywUqpN8YpefCufvJl
 YtNO4DfpjKfm6tG3FWptxG9vUEVcYmPlJn5d3/MP7tcVjuZ5Yj0HMcMl/8a/KKcm8D+5
 uSDdC7BFM+0w1IuMBg6UPi0MNaTjcnr4MmLW27MXhS7SAI1mFPEWrj7AaQLOa4RqBAWF MA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=x88zVL/26CdEfAIvIIJfHVOTsygrUK0oTbnAH0h53AY=;
 b=GI0It7ujSCCgCX/jl1YMsz2I3ljhZ6L08zGXH5VdjndZetnwO+knFBDaHQ05FiYa4YLM
 J8oIrbT1/PRqSGVi5pWSQRjgnurqZKnBq6EUAMADhQW3chM+Kkp9dHk7XJpSw/FLgHOP
 G0RVs4mwdWcunqk9c43ZtqpuJSdn1DtjVpCSO2HQv95vOAEDIsF5hatMRJVAg4PRXZk7
 pL4ERr0YnSbFayLMNg4pqriQjqzs9c+Rby50SAu+8PXf1y4ofZF8ms6GWReyeLUprCQr
 0RilqsfUg3PBovJebT0L3M5X3qE9wYCtH/q05dyZu4XSHAtVKzlVefDjxzsKrK30Mfvc FA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ap4xv2u3t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 07:35:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17R7PZgH126379;
        Fri, 27 Aug 2021 07:35:57 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by userp3020.oracle.com with ESMTP id 3akb91n10s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 07:35:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cq9DPilqB55kV02wLzDAh22Brqw/CcCm+2rI1VseBOzB6YoCdVIr/7M8c7PJMT50RVbxwa76X+8IY1SSmuzD2CK8eSbSlnOHoPT1H1Vpbmy2Yk8L0eugXcwA9HGrQpw13X7vwbNjBNZZbARTkAAiEntaEQcusVhXE7/5u1znsUdFAZW+h6iDitc/I45n1BM1qWaplEo6YWgEaIp9lGSjeLTmAaXIIv45Tw5FEfdrwl+piNhdAhEV6ZTmSmjyR7JfKX4axcA45eyI84gDpUCONeCDW1G0K0tfYN3u6AbLC5fAI0dGn2RQ9L+UO3Ck6naGpAMSZQkuD4C8r1HEDuXcow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x88zVL/26CdEfAIvIIJfHVOTsygrUK0oTbnAH0h53AY=;
 b=kFR4g1zoxtEQgXc2sfug4IrERzzkjd1lvMgqYiyMs/l+3fWAW9y3VgSMsAjmF5X/x+nge+cwxr4MUEcqiu4Mm0XlUbdF72y/Tz9Mrxt9kEhFUTnqLpygaoHER1poy+PjLaXZstt+bTvZdndjpAVSLcgRQGFs3SZNPBVCy5H6tJxuxDh0d4S/8InY9j7YMdYMtRk8RbkeIGQICHiCy27RLf65Ogf3TWaJw7HhPr7m7YPQPOyV2St96yLrY9K7mMN1Eb5sR1RFs16nieeDmZaVBANYhhFXopZamAoFdiPH0bVz0hR9ZAz3BTx8/6ixvokGBBZP6xTiNwjycIxgMN0PMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x88zVL/26CdEfAIvIIJfHVOTsygrUK0oTbnAH0h53AY=;
 b=tU5+Rxhrlz+UvzG6tX29h0lMviekU/2u/mpTsf1lgVEQ/YNTYwDuGSyqQLoTD7LSkPkCKGI41GZsnsgYHW3SPqFHWjNxYVRFZIE8I/9CHxTlQLJ+3QjM5vwJmWE5gDOHb3IzJuNNag7QYNqReYWonnIknhSSLV5fShWPgucbbcM=
Authentication-Results: wanadoo.fr; dkim=none (message not signed)
 header.d=none;wanadoo.fr; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4499.namprd10.prod.outlook.com
 (2603:10b6:303:6d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Fri, 27 Aug
 2021 07:35:54 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4457.019; Fri, 27 Aug 2021
 07:35:54 +0000
Date:   Fri, 27 Aug 2021 10:35:36 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     jic23@kernel.org, lars@metafoo.de, ardeleanalex@gmail.com,
        andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc128s052: Simplify 'adc128_probe()'
Message-ID: <20210827073536.GD1931@kadam>
References: <d769321da74eea17a1260b48d4ab16f416b37c74.1630002390.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d769321da74eea17a1260b48d4ab16f416b37c74.1630002390.git.christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0050.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::10)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (62.8.83.99) by JNAP275CA0050.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21 via Frontend Transport; Fri, 27 Aug 2021 07:35:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a88b48c-d7f8-4b86-ab6b-08d9692d4d50
X-MS-TrafficTypeDiagnostic: CO1PR10MB4499:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB44994096EAFF0E0B193D3C7F8EC89@CO1PR10MB4499.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nC2a2jCak/4aRV/BJjokbt3YT2GaM5IGwdXMAT+ADs5Q1fHaPK7jET4Wl57n1e/cyGkinoAS3jRA4v1ZjSoiL+wc0TFtWP22JgubKE6BmvXNTCS9e5v91EhlPMBwZ4VRXanj46a8aWXJqkdDjp1CoNvP0mAbdaF7KiEWq1eXderV6XlKrm3JG8ZXoC0XehNH8e9Yo1ym20DFTIpArWzCCvMqznzfa8IldLwLqGZU5f+qgMm1xH7y0rXR9sHcGdpXS0V+Ox6dMYDxTAWOlkuNsW+SGtptbXciFDSUxqGc1rAEaGNJmyWEpuMhC4suGD8TrzLkjFKc3ZEkfy47Sqj/WBXuQ93uamXNdUrz+kbjqj2kQCodSp3VdPi8SwHFvlWU2jj5bPsgB3uEr1t/AIhqttODC3e3Y4N7h3gJAdcxGS6Jred959XAd6v1sZCiaCh0A5t/3esLbtrOo8Gs95trFf3XCVtWTPIg+XFLKNVcYBjszFIfg3Kz3KR3QOgcfxgN0Dxt7goaCmMLh3tE4WB+obDZe+CcSPOThd3Q0c+9yV8SiHUTidusTYxO4eWesTHdpqLGtG05BcutvHVdkq/Omq2pb9XyUi/X7C0RECuT/foAXqqcExGfUbQx+eh/6KZuHSfHRzEsRniOuoARVqX9xzkqk9RHm54sfj53e2WuRpsbDkSkVHPJjzeN0oVMhx9rwzWcqv/lOKeA3eg4LtCoZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(366004)(39860400002)(396003)(376002)(8676002)(6916009)(33656002)(4744005)(52116002)(9686003)(6496006)(4326008)(83380400001)(2906002)(66946007)(55016002)(316002)(26005)(66476007)(66556008)(186003)(6666004)(9576002)(5660300002)(33716001)(8936002)(44832011)(86362001)(956004)(1076003)(478600001)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8ceKM3d/hLPFvQrSfqNkvI4gIbuF/cDMtLQw4t0qIlsZHIgKqlzJz5V5Ygn/?=
 =?us-ascii?Q?SqnE+MVNTu5e05HABMLvDmstgAr/nQouTWTkEiFoa1kw80sqIMy6qw70Ktx8?=
 =?us-ascii?Q?xemgymE5izelNi6BVYTaRQqmOBax9uBg8KcVI/TrrPEFdpZHtfypsD0rX0F4?=
 =?us-ascii?Q?onj8pjgsaF1nNgdT4e3sWmbxbr3MdGcxTolEw6q7Rpg5Q4pmOvAbUcuRdpgO?=
 =?us-ascii?Q?zGpkpHLlPQZX2HnAWqMfqi49P04FGRffEY7UqEv4rao8X3o/iKQzZ2nobF5l?=
 =?us-ascii?Q?kZgb6d3hRnGFjRqEdzNxxIaLg4efA3qFF605m7t5+d55JQWQnMHkUo7HSMwX?=
 =?us-ascii?Q?+jNA9yDUMUlbZr4vEcsyW+maCqg0bvFJ3dFOsLuagwkVQChQ9acKMP68YzWR?=
 =?us-ascii?Q?d3RP7tT4AvBPwRHovLXQBkgUzKBtQmqd1CkM/V//gIeUmB7VVA1xRoWugptb?=
 =?us-ascii?Q?optijI/OQSAiUZmYtWSXrvMVKNinHNPYJCyXcaMOXRbxLEQ7jDbryRWDnPCC?=
 =?us-ascii?Q?ncr/FBO5xsrNqm3AX/5K1HmNFUxEU+VPHV6dRJ7eqdzn3yy6lrrl/tfjiavS?=
 =?us-ascii?Q?dpRQIBOBDUaikb0s5Xf1lswT9WyerPDGFnGBgex5cKLW4np/WX8dokzbVkBy?=
 =?us-ascii?Q?iVjaBU1Qwwjo/n3FUgfu0cx4KvjtU2NpHNH8RM7cTvmiYdxvmbxyUs14QhoV?=
 =?us-ascii?Q?tOb+YjdjJH/EH5cmD1JebOFQ7GbjUSUc/ZuqX8XURMnWG0xN5q//N1OucA4J?=
 =?us-ascii?Q?B7KYq8vQn2/UXy0kj1mpYnrt5ZqIE2jWS1Ud3A/rw090ivPkBlFWGKqgizcW?=
 =?us-ascii?Q?VUK4W0W6LmAfBHKc6iZ+lNm9rhDnwSjuLAEfh1bSRkTSxBzsyC1u2iXnXWQ/?=
 =?us-ascii?Q?LlUjAlH2XT+yprOXDyN9Z3sICd8FVqSahwOLSjPYWCgc3GWkjMblOgZyTBFk?=
 =?us-ascii?Q?dKn7Q9jraiGGl004YwEtZtmigBplzXzmhWGkR1boCs+2MDrHuLXkj3dQuPX5?=
 =?us-ascii?Q?jISwov2nQmCsT9J/8C6KSh4NjWLkZcS3DpnYAdTGEB6Vx++HTTWrpxm7R2hR?=
 =?us-ascii?Q?+2fMzBR6P+FfsIZcvyack1tuFzQmxZ+q5yNgUuLYknbuf17qvO5aQVa3bQe1?=
 =?us-ascii?Q?4vxZrFnDXpVmfShD09+fs/KBfcm+iuMwiR4CTvr2cCp0jdOr1m/V/JSfdIKx?=
 =?us-ascii?Q?x1obCpv8Klb0BMz9YpktRzC5F/S/LpsqegpIsoIj/xblCe8pbuytrfVqQPXf?=
 =?us-ascii?Q?UFGQwK9FG8bmcpu8byruBesiQ7yqdF3Qx1EwL/CNlhEzU5tJzbONyHvUPxxP?=
 =?us-ascii?Q?M6EkkF6ns7HDr9ibqqExpEmZ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a88b48c-d7f8-4b86-ab6b-08d9692d4d50
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 07:35:54.3838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GyIQF5InzjOjEoDvNQGkCz+qWQRnqlTuACKSqHGrLsOm4LLQGGwZsLNWX4bnhx3qmwOwFabfLR+tyeDCd+BLGzgDvNFD906Hx9z3Ww0Lmy8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4499
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10088 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108270049
X-Proofpoint-ORIG-GUID: RR8RWrZ2qyQMitt-A-2iyVpdhTJ4oph0
X-Proofpoint-GUID: RR8RWrZ2qyQMitt-A-2iyVpdhTJ4oph0
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Aug 26, 2021 at 08:28:08PM +0200, Christophe JAILLET wrote:
> @@ -172,13 +167,23 @@ static int adc128_probe(struct spi_device *spi)
>  	ret = regulator_enable(adc->reg);
>  	if (ret < 0)
>  		return ret;
> -	ret = devm_add_action_or_reset(&spi->dev, adc128_disable_regulator, adc->reg);
> -	if (ret)
> -		return ret;
>  
>  	mutex_init(&adc->lock);
>  
> -	return devm_iio_device_register(&spi->dev, indio_dev);
> +	ret = iio_device_register(indio_dev);
> +
> +	return ret;

Since you're resending anyway then please do:

	return iio_device_register(indio_dev);

regards,
dan carpenter

