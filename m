Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7CF8408573
	for <lists+linux-iio@lfdr.de>; Mon, 13 Sep 2021 09:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237599AbhIMHjB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Sep 2021 03:39:01 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:33182 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235185AbhIMHjA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Sep 2021 03:39:00 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18D6hlvk017750;
        Mon, 13 Sep 2021 07:37:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=CoigQrD7Egc+eP/9gvwZ9enyXvldjIRXpAPAh4gOlLM=;
 b=ol61nHhg+j+LjV4f9Dity5aPQ2hD0WQDjKeVuSV5UYwku2UM+3lLHxHkmCKvCWi2Dd5s
 UNeqptBKSpPc75nPU+iSnri+BLBnpHe1S8AqY/AWt82ghgiTUWpzKplx3fc6uVkD30vM
 oU05dUQbVkro1WCrmUdff4vUaePYcMvc1Z27ZgPZbfRIDbiH/RLMlOOit+CM9XPxGs6o
 X1+30gjCYRu8izd4v/CLqZ950WLfSmmWmWY+2fBYBL+wNo6/zg/orN0YzpfFbMF1i4Ds
 p1uOv6619qCSAviCpPzEicRiGJLt1UufTC5azXi34HrwG1ZqRe0HFE4bgEDwf+Cl5JiR GA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=CoigQrD7Egc+eP/9gvwZ9enyXvldjIRXpAPAh4gOlLM=;
 b=iULg7fTQO5SWuqneAGY9oreuHVxd+4Axb9QWhlucxweDzV5WEVoddfHaUE9+bA0ibNqc
 mxKlO40vUbILu7wy049vIZrMmeW8stnv+Fcwn0/TKSqzk5opGcY6HvtS9lzwgDyGHc9h
 FCJ1e+LqmTNB5g8e1Nnuw9djKpqGwU+pLh5DYTh3bIppurhwJXcoYcU/Hqud7OO1m6QV
 yGPr4AVMoVJXn186YvpuHdHTwCy7f7o4ADcSO/N09JIzkleBCciZHFa6Qwxt2lNxWq+K
 qN1rL9mdPvqKq7HveAyBO20QN6UDxiBewUEdwglbnSIsgLiuEMZ/wlr1nKGdVqDkwIQA Kw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b1h45hp2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Sep 2021 07:37:30 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18D7UUik077820;
        Mon, 13 Sep 2021 07:37:29 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by aserp3030.oracle.com with ESMTP id 3b0jgb59b3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Sep 2021 07:37:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZcoiLioHP81cBsKatJGf1GSQtHOGZvuVDnK4Fng5GtF91L06DUvALB5qMxpjLOUdoNAWgYFFn6/Us490kvOn+afNXWaGvJcCXAu4C08KDtgrPfLivGxKJbGkPixHUPTJXPlWhajeF0MKuN6AIRF5P8/IX7kEEYQfYcUYqT9a3x+P0ZjE0xr/RxTpF2LcIzSfm1Uo7Fn10k+uyKxWtT1HdoEf0sv5DRikwYxdMfcBOtc6hhdDiXb0AK2RgslbrUmWgyQf0vOEKWsbsBVTZTxwQ/3Wdn9dbFFyEe0s43moFbbH3bs0m6mebrPuy4HWW07z0pLqRRt5lQiRBamOP7Xcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=CoigQrD7Egc+eP/9gvwZ9enyXvldjIRXpAPAh4gOlLM=;
 b=icWvd3zbnIjf8ozFwezcKXG6gYAnSIwQBcbGtR9woeLokalNs2UWT6EXIVNfA1TZcLRO5dIFPFpifmtTjTLDQ4qofmQy9IFHe5TNC/uYdqu9+ltoX9xCmU6q8F+lC1rN/uJAxJJjb2QoHfF+XFLn7knA97J6Y+vxNF2tEHPrKBOrprPTb8BVJWpoM28mRwGCPHJGSH1zNj8o09SRESEOMCdjDTFdBrxEv0lY6/lMUHbv7qpva2DBGagoYzI3cwmm2kePIpUuBW8clv8c0tUviUctliSKq5XcpUY5PHfeAkXhsVu3HZnuhoPDTKJPvdqf8bXloAMuBYUMWZafvwaF+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CoigQrD7Egc+eP/9gvwZ9enyXvldjIRXpAPAh4gOlLM=;
 b=Thl5ZKSGL36rysVyx+UKutHupG3Cd+6j38uPPqmCZB+c7VoelGiPeaiTKsUao88HN83JV+JrWU1qE5kTshzl7e/7HKv8xSfpwPJOpgW8Ga1sm2exNbFPdBKlZDwOUBj97IouwRqYzQA+sLJzt3xQYGL0v+DTUxkvRz5SPvuQgTQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by CY4PR10MB1477.namprd10.prod.outlook.com
 (2603:10b6:903:2b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Mon, 13 Sep
 2021 07:37:27 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::95b6:2084:3b1c:27ba]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::95b6:2084:3b1c:27ba%7]) with mapi id 15.20.4500.018; Mon, 13 Sep 2021
 07:37:27 +0000
Date:   Mon, 13 Sep 2021 10:37:09 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Karol Wrona <k.wrona@samsung.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: ssp_sensors: add more range checking in
 ssp_parse_dataframe()
Message-ID: <20210913073709.GT1935@kadam>
References: <20210909091336.GA26312@kili>
 <20210911164253.260be729@jic23-huawei>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210911164253.260be729@jic23-huawei>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0015.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::27)
 To CY4PR1001MB2358.namprd10.prod.outlook.com (2603:10b6:910:4a::32)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JN2P275CA0015.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 07:37:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48da883e-a6bf-4d77-51d9-08d9768955a5
X-MS-TrafficTypeDiagnostic: CY4PR10MB1477:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR10MB14774F54E7DFBC21007D32018ED99@CY4PR10MB1477.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ia4g5a/EfyoQHBNTZy4G6t+I79Bz6i932AeDGyxDJRQK5DvnZX6voPaKTdLilyxCrsgbhwocGJ4y8+JJ+KyK8mBrXvQ9wdKglXN5RIcFqO0nclvEoMLZxwBNel+/ArDxv4rwMjBq9KQ/gKJRiz7P64LJ6mNNY2wi0typ4kU1OEbxyKrL+IFUr889pq3S/V4lWKnb5Q2T97Jar8wLkqLiOWnEYN/U/CpDkOCDkizzMIha2U+Z5wPQS+71EXO3oKWPzXk7dkOlSeiiUa2wKbMs7Fd5CFn5yoo0pVXaz9E10wKKE7Pl7/7cL6gDrwK5xLfZ2ffg0rr/6Q791qb633ZSgNvEY+pp99vhnVKHYZs6MvU7EFwchP4Yn2WhlmUn9TdrPFMjhupgOxF2fr2SwM/M2m5odVo435Zt/2r785sGczOA9N/ZQnvoSUnT4CUE/fmO9TiTF6SMjq70kYz4ao8ZyDSS1TfUkl2PhvoFAizrVJs5sbVSyxTfpyMt3ftdPzGDqJFeLo4wbZlr1tqCXaO8CBXMpzC942n8NwlMUfNGULQWL77DB1GfVopYrzY2bQy6cOkSgHxYYneoorfsVe4MYpe9fpQVms6FLH2yW/m3yOtJaS5eC5pP3Hj/YHzCCBrnmJ63BhpM1PxJkyOUgy2Lj5jh68CxrpNCzOxrjS0ksDAo+iDqV91tVE26SlD5n81s6KjwuCr2m6W6KAHSzHYpTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(39860400002)(396003)(366004)(84040400005)(38350700002)(44832011)(38100700002)(86362001)(316002)(9576002)(66556008)(83380400001)(6496006)(5660300002)(1076003)(52116002)(186003)(66476007)(6666004)(8936002)(8676002)(66946007)(956004)(478600001)(55016002)(9686003)(26005)(2906002)(4326008)(6916009)(54906003)(33716001)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zk52hyaAwLyeITSj+PWscHUqMi7TXzllahzCxbG0JRx7FrT7x/uemhp0wYk0?=
 =?us-ascii?Q?QTfFWFJg5HxWGHWwNTqyomazRzCk7pZBQOqqbbDrUqFsIb1FEwPpcsvQPuM7?=
 =?us-ascii?Q?rrHDK8q6W+u8oY4FlO8aATxsYXpKPmzf62pvCFIVXbPVqzE9Q9yaVhkOIS2g?=
 =?us-ascii?Q?E41qK2nu9QHzYHR0Gtw5g1/n87Y5i6ZVsoyGwMcC1nhhE5Xg2PVE4gUniivw?=
 =?us-ascii?Q?2KsmsELLaptxyCorwrClSMUAGhbya1QUeUT9e2uBpbzj3Dj93F0O1V2pxbBS?=
 =?us-ascii?Q?SsC5bprVTHLb4OHideYqQ4fgZs6EGIa6oT0veF+k1jlY1+tOOzKINC/d8rMu?=
 =?us-ascii?Q?z96rBQrrcTZCCWDNRbLSZos78GaQbfSr8cpkqfl4qt6r7uUXu1FNspFqPyzA?=
 =?us-ascii?Q?Ta5qiAhjTlshIIfziNfpmjxdCpVLzpd5/NZ1WixL07V4eTy5Qs8w4GW5KsYQ?=
 =?us-ascii?Q?Q4bIRyhbW3+JMlC02N0EVa5P7TSc0S7HdyPyjHw+6350u9//KHLg2iLIPuEY?=
 =?us-ascii?Q?3MLXQFS/rWbC5HLpLbsyZNW3lFMMwBeeyD572IjHKmbc5LyX7dlIS+nN5KFA?=
 =?us-ascii?Q?rcw4DGUD4Apngq496tW0RbvJaUsPxrBZArTLZkNBnLNauWae1Z3lA+53dJa3?=
 =?us-ascii?Q?wSy86kqEtMySIFLkXZoecJwWaBqlD4oykMW+QiBNH10UBQcu5eE4qCPDmyyH?=
 =?us-ascii?Q?lsQwnJ1vaydFSxEf18Zg5zYiq+Abc2HaT6xt+3ViKEb9iCJdJECKrC+TLWj8?=
 =?us-ascii?Q?I4pJWYFUcLJ3Eeu8hCZOhYOl+vhtjX5HZ+tXKJlXDMBicni+XR9YKG2ZEq36?=
 =?us-ascii?Q?gsOVub2fTU1UIpJJweJ8jPEvrhTfuX0NKnz4CFv4LLuMetUH21fHD1ZfKjFm?=
 =?us-ascii?Q?d+ltnbIzB0kgQiBCv9gGeGnivgw4f/4b5QeCmMzDNef8Cp/ty2Q8kikETqn/?=
 =?us-ascii?Q?HU9/1LEripOowNNdOei+Jbbxt0s2DAo3QIs07ZUnHGWypsGFftUhZbhhssqo?=
 =?us-ascii?Q?EunOYOE8bGPLpD0MzX+B/6hzVEJTVTYP2o9X5h/3dPROR4MRV4zLa+vCTTq8?=
 =?us-ascii?Q?Fq3OZlCqKy0CbUzHZQBMX9ezkDH0YDq8bmIbybN4GS/P4RJOR7u/jj/K3IRb?=
 =?us-ascii?Q?mnSzG/g9YaHJfKocLt4f3k8IXCMALMeeLmZ9+EYGO0fzVcBc49S13NdV4Uvr?=
 =?us-ascii?Q?dJUs/kRuIPFctWgyPa8R8kEaKslqleKG7igrFFlMqEEtar7IytIXFqnCO8Rc?=
 =?us-ascii?Q?cf1CV2qByMHIcMgpFOGt/ffhUGvY5S+VzfLxch4KVgwBGUx1UMw8+x8RU+PZ?=
 =?us-ascii?Q?KrW9v7uda+3z/Z3XsVZXPr2e?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48da883e-a6bf-4d77-51d9-08d9768955a5
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 07:37:27.3688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XBjvQiDM63bGrq8N0U27kbID5mV2lBoKeHN1B2ryKwK6BI+0ByZghPwWBb100jZpCx1g8NUb4MQeSXAWnajs9zZQILmu5fHOf4UXJXI7ozI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1477
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10105 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109130049
X-Proofpoint-ORIG-GUID: _2Ft_Q4xNYCKY-w0cQyc2FhYAzt-CUdu
X-Proofpoint-GUID: _2Ft_Q4xNYCKY-w0cQyc2FhYAzt-CUdu
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Sep 11, 2021 at 04:42:53PM +0100, Jonathan Cameron wrote:
> On Thu, 9 Sep 2021 12:13:36 +0300
> Dan Carpenter <dan.carpenter@oracle.com> wrote:
> 
> > The "idx" is validated at the start of the loop but it gets incremented
> > during the iteration so it needs to be checked again.
> > 
> > Fixes: 50dd64d57eee ("iio: common: ssp_sensors: Add sensorhub driver")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> This is only a fix if we assume that the len value check is there
> as a protection against buffer overrun rather than as a termination condition
> that occurs when parsing a valid record.
> 
> There is more paranoid checking in ssp_print_mc_debug() so it seems we aren't assuming
> valid data in there at least.
> 
> Still is this perhaps a case of hardening rather than a fix or am I missing something?
> 

Yeah.  This is from static analysis.  It's not a bug that probably
affects real life.

I guess it's debatable if it should get a Fixes tag, but I feel like
everything should be written in a hardened way.  Plus with the Fixes tag
it will get backported.

> As an aside, if that ssp_print_mcu_debug() reads a negative char it is then
> returned directly so we get a random small negative number as the error code which
> isn't going to be very useful.

That's true.  I will send that as a separate fix though.  Definitely
with a Fixes tag on that.  ;)

regards,
dan carpenter

