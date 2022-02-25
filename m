Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448934C40E9
	for <lists+linux-iio@lfdr.de>; Fri, 25 Feb 2022 10:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbiBYJGh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Feb 2022 04:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbiBYJGg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Feb 2022 04:06:36 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA732399E7;
        Fri, 25 Feb 2022 01:06:05 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21P4ckhS006299;
        Fri, 25 Feb 2022 09:05:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=YcIdi3DN4pa/GhXcrjTq5FhUs6NhSfhIecWdXZ7IX68=;
 b=DyCmJ8zNlZBL+Wx+7Mx+KuUqhC438EzMHO4YLD6hB08dE0fOufg8uupulMgAd2ciM6lE
 GFQmhmWADIEs8pMNj0c8UN7wdkRiQc+s4JEOjpVVodgyGCfPhapqK55r7u/U9YiFJnL+
 cw3UsZ62Q9upNbY7JyHEZiHG3LaBGZ8yUG42AFV0L5zKjbTPIRQj/w82mEyFgGu/8fNg
 TyXGbvf0PFUMH1m4RIAhqHwNIoWmFDDNLNp5UadAgxZLqooNWFu1nf6O634DRTvJwRbf
 NOs/XWlhkkJZiVYnC4zrGgrAlNhqPCkw0a384OKGUZGwbnlHvqgEioA4w/5RTe28k4rf CQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ecv6f1j0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 09:05:22 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21P90cSH184106;
        Fri, 25 Feb 2022 09:05:21 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2042.outbound.protection.outlook.com [104.47.51.42])
        by aserp3020.oracle.com with ESMTP id 3eb484jrm0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 09:05:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RhWMM6N3YclXSbBXAPhkSZ+pPld9BmTudXMR8RcRZqb087nK6sMxhn3akpfpXtTGXvHckliddnRMefSwE+WER41kTVDXbRzsuKyh8tk4swnAlDn2SPxfZV1hKJeHEIbPDz1XhzQ9vx+wT1JKKJzdOrK3j8vvx1IvtGFKXMbciyE5EimVu5usl9TkqY9F1lWUa64ub3kIu1dIuz1n7TFYayZkWfmpD3+YttyoUGKhsiSz633/xTKX4s1Dfi3BMEL4GX6ctYytEuMCX0M4QjrjGjzKPo1AkhWDRzah/LyyZUQ60iouRv4AqrpK2+VdY7YXnhLt8IccDRda46IpclR9pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YcIdi3DN4pa/GhXcrjTq5FhUs6NhSfhIecWdXZ7IX68=;
 b=LD1TxrB2wVgm+1e3hmY87cRlRbtOvDYUxr8XATw6Z9cYnhLVIz+25SKpJLymlS2vR+tMspmh2lSusPJi6fCg7Js4X4+UFdkClLVp5WQqvsfuxEA7zomEg/5Cgi/UqviZe+HkXqUPyUx0uCXtm3lzTe7I32evJvGazkxRpr9lZkRRIkXGnt65nA9mPBUk7bNPnSUy98cQ6IhxUnKkLWEf0cMJV5+wWxlB78cEWtHAZLe6ZC9nfrGEA8hGhciQAUPdGPgccmUHQbwi5ozyoygCWuVVgah1yBzZmK3oFiD4jd/lEfOTG9rIqKK1/e8aaxd8WwF2mkv7Vv03DVOoExLcUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YcIdi3DN4pa/GhXcrjTq5FhUs6NhSfhIecWdXZ7IX68=;
 b=SFp+pvVA0gfV0aJZ4eh6gLEL7134N7P6WKc/+rDf+B9HNQZLPTeIM2WmPE6rkbf6ksJl1FWyBKqrucLmT5GAKIenXvlUpYTxfU3ygz9qOBQXJ4+xKqFpmCSYvQhVAa1frjsDda+YttJMzfT3u2iD4CP3fsiDnD1V5TxncoOMQKY=
Received: from BN6PR1001MB2354.namprd10.prod.outlook.com
 (2603:10b6:405:31::21) by CY4PR10MB1751.namprd10.prod.outlook.com
 (2603:10b6:910:b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Fri, 25 Feb
 2022 09:05:18 +0000
Received: from BN6PR1001MB2354.namprd10.prod.outlook.com
 ([fe80::54d3:796a:b63a:2582]) by BN6PR1001MB2354.namprd10.prod.outlook.com
 ([fe80::54d3:796a:b63a:2582%7]) with mapi id 15.20.5017.024; Fri, 25 Feb 2022
 09:05:17 +0000
Date:   Fri, 25 Feb 2022 12:04:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        sumit.semwal@linaro.org, amit.pundir@linaro.org,
        john.stultz@linaro.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v8 2/9] mfd: qcom-spmi-pmic: expose the PMIC revid
 information to clients
Message-ID: <20220225090452.GP3943@kadam>
References: <20220221220743.541704-1-caleb.connolly@linaro.org>
 <20220221220743.541704-3-caleb.connolly@linaro.org>
 <Yhft4zNcbD3ojN6i@builder.lan>
 <YhiYY/sXMvQ4VCZd@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhiYY/sXMvQ4VCZd@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: CTXP275CA0003.ZAFP275.PROD.OUTLOOK.COM (2603:1086:100::15)
 To BN6PR1001MB2354.namprd10.prod.outlook.com (2603:10b6:405:31::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5ba87eb-9fcf-43f9-4162-08d9f83df129
X-MS-TrafficTypeDiagnostic: CY4PR10MB1751:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB1751542EBBF63BAF5ABA6C308E3E9@CY4PR10MB1751.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y7a1L2l9nPderKsINLu6HR2Zz7UaDcxxNA4jBJ4L7qZKCiEO9/Y7VHTgf8u5e7t7xgrBwLjRkp3sVnXOQxlRe3pjwU3fBJVPY7JoYXSXLFNX0aD3SWgwttqDcn+qN7KLTCAnF8xBfhhOR0qzYK7tp4EFBo2THQ4V2ZxqwRIVjAbLs4HRr1vj5RbMxmLL19Ljt0S1z523iWOtZeNuFfSjuSHdLe6oKU6dRQbuMjZUl13I+4n4hnoz+a8M230vCRVAg3zsjZyMXWd+sN9wyzfHmuLnQAReESmEr1//+HB89k9zwZ/r2aJXUGHCU8WcNEFHOKJiL9q2Iqce77mDJB8jftEDEetjSIfHoxT4+bRM28nMpEDNZ+O8isocBICA4q5GVy0QrTR7bpq0gIvox76Ekjj3TueLPk+zOTKePbOmmV9o0rl8Z4ixNFDq4klw674aTKYMR21vYgBt8C9q7vfB6dA8fvR+0gltryyPA+anPdRMek9FwTBszH+0fmgmvR2VbeYFvpHMYiu09E/2j28jXvhQBdRwyCMsXnNcJl4Vu4uOA7SmUhdLHpSWqDH2ucGvq2Wq5zaJQbUH8RJDVmkLtHhvraZgm5zTd0CEUnZw9kDqdosIc1JHXVn+QLqQuSLUeGd+eeP8l8pAx6+lH+acdckAVOHTm74tTvAie3K/uDTl+t0qdq+XBz2fpXeq9nvOyhksBYCnD6/h0IFHoqTQRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1001MB2354.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(2906002)(38350700002)(38100700002)(7416002)(8936002)(44832011)(5660300002)(26005)(186003)(6666004)(52116002)(6506007)(86362001)(33656002)(4326008)(8676002)(66476007)(316002)(54906003)(66946007)(66556008)(33716001)(6916009)(508600001)(6512007)(9686003)(6486002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2J/DmrLESTywfyYXHjcSpZ2WTngW+8K4DGfmz4Nn79UKElz6fnncydd+MQHR?=
 =?us-ascii?Q?wAnneih+I88KgMVhp/DfxlAnHmaI5WEAG2jTas3f5v7S+hKHapb2Dpo56iSc?=
 =?us-ascii?Q?xQ69oVW2U4Y81US54R+JZI7k7ooYpjpQVmYozs5/nBIwrXGYwGVZbJAocCjB?=
 =?us-ascii?Q?aP+C0rjLOlCKLTAk6pqxiHuzHpid5t6qN2TNhfZqnV+hofTA8mebRVjLcKk3?=
 =?us-ascii?Q?B1okdYSSUZREy+t1HWIB8fj+uwf1oYYeyzknG1NcA8colOO+9JPlN8rdPnmm?=
 =?us-ascii?Q?3WqsxBmK2p0+eoR0YDN10hIMN45FKK5cloDZiugQtVdK1dwu4UIOc4H6O38u?=
 =?us-ascii?Q?pF8CLNjJjNVUAljZML/U6fngjRE2r6ZycuAZ4IJUgWF+uYWKg1A1cXcpLgG3?=
 =?us-ascii?Q?J7MMEBq/z1U6rka+JqaunbqQuAC5nZyhLPr7i8oir9cafeRxoz62Fp4J2PxC?=
 =?us-ascii?Q?CLPb/3o7aQMA0jspt/KwWeNadmjtyuEr6Zu7o/iXdIpwvImYLOntME0/7hog?=
 =?us-ascii?Q?y4RFZ0lDaXovNP4hjmBx4PwftZQBvGCpXlifGo3KlOGSb7S2529xPxhaReR4?=
 =?us-ascii?Q?WBtQKFkMsz8ebiVvCYpcFzXb800duGOvh5XawJcmCko5IFidgtCHHOd7ArbN?=
 =?us-ascii?Q?Scrtht0JMB4HN+NCj2fdNgu4VyUUku/TNALa6ArR6A3pjOc8ZUc8a7q/bAfM?=
 =?us-ascii?Q?xaDDA++96SfZ1GB4Yx3QXqkRNFBM0Eiyr0xQQZxGKI2XumPb2FIqOmtqsFc0?=
 =?us-ascii?Q?eqpe4yRfxPtApkywFFKSOygO8Y0ah55XMwwiwwJkkE+YQydQtfD+tBwn0/g8?=
 =?us-ascii?Q?MtuXt3GSAeapK8Vk1E+lmf/aWiKQ+P11pqkjLbJQo7zB7xqlN5ajwRlGtV+C?=
 =?us-ascii?Q?tvHS2WVLR/tXpKKdc4hVWFbcbZSXZ3NT6WR52Ntd1aLZH6tQOv3qlPGufI5r?=
 =?us-ascii?Q?/A3qwQbMics+uPpfRJ1w8l3Dbt6E1BogMH6shjCyU0psnxTFmc9tzXKfsWUc?=
 =?us-ascii?Q?aT6qI01JUyygawGiNttrO6KUcPBbo947LXjjkz49WCDQgVjlJM0RoBpbOtAi?=
 =?us-ascii?Q?LRmzL/tgpRfC33nxkQwYsgnY7prPvMw1+nzPhrPfFDyifqTdg/GW3EkuNA6S?=
 =?us-ascii?Q?jojsiAalvRZ3tJ2W9ynS7x1TkBu41JbBTlcnm4v5vQFVuNCavKBi3ow73G1T?=
 =?us-ascii?Q?ytd0gfG6kGi80Kba7c4B9UbpAQE8NOkKpct+6mmxei0rvIz3hkAwtIYtsls/?=
 =?us-ascii?Q?3LSVM5et4KFu80beO2SABVbw4fyCk9n6SVx2/7mkAmecrxG4RkYuA63wclQP?=
 =?us-ascii?Q?I9rQ4zP5WphDlv1VoVOnpetLbRDapYStHJMtqCAll3jmdUU+sRIRZH26Qswl?=
 =?us-ascii?Q?jxbR8gSuS/dbNppXur8hK70N/p+SvaO/CV7nuxZM/vzDPEOjnTLuZJ78gEO7?=
 =?us-ascii?Q?ftLXc4e86pEMjTsxLXqtymT2QVkCTmKGomcbxq3f5g91/iVjs4xG1oVWviEM?=
 =?us-ascii?Q?eedCWhCY9YqY/GXbdJMFtOmBH7Bwn/Ii1et5ohVDChJt5Do/oEqy/f1FvEHf?=
 =?us-ascii?Q?IGNEGCxsrDCTLYDJDe6RXqk/ZcqyJFbcxVGcEsUi3xTgQb2nDTSVP9I6xr2N?=
 =?us-ascii?Q?vX+bRydr0/0okcn7YgurDnhPzxVpw3it1WV4i774GhN8ouHF1X6zqD5OqYpy?=
 =?us-ascii?Q?40PgCg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ba87eb-9fcf-43f9-4162-08d9f83df129
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1001MB2354.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 09:05:17.8435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rr/g2OgH/8s8xvvQ0Bmvc+3eZGuZ7hmPIy3aW+MO2Kd+GTO5fIWRkgOCq4DnC+sH8I7E/DYu33z4LRCSt0b5Tmc4i9+M7y/HrFVQLwUp8dI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1751
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10268 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202250046
X-Proofpoint-GUID: R2Y2w2TQBglW7CYNxvI1rwqjGLyKCw_f
X-Proofpoint-ORIG-GUID: R2Y2w2TQBglW7CYNxvI1rwqjGLyKCw_f
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Feb 25, 2022 at 08:50:43AM +0000, Lee Jones wrote:
> On Thu, 24 Feb 2022, Bjorn Andersson wrote:
> 
> > On Mon 21 Feb 16:07 CST 2022, Caleb Connolly wrote:
> > 
> > > Some PMIC functions such as the RRADC need to be aware of the PMIC
> > > chip revision information to implement errata or otherwise adjust
> > > behaviour, export the PMIC information to enable this.
> > > 
> > > This is specifically required to enable the RRADC to adjust
> > > coefficients based on which chip fab the PMIC was produced in,
> > > this can vary per unique device and therefore has to be read at
> > > runtime.
> > > 
> > > [bugs in previous revision]
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > 
> > This says is that "kernel test robot" and Dan reported that something
> > needed to be fixed and this patch is the fix for this.
> > 
> > So even though their emails asks for you to give them credit like this
> > you can't do it for new patches.
> 
> Right, or else you'd have to give credit to anyone who provided you
> with a review.  This could potentially grow to quite a long list.
> 

I always feel like people who find crashing bugs should get credit but
no credit for complaining about style.  It's like we reward people for
reporting bugs after it gets merged but not before.

We've had this debate before and people don't agree with me or they say
that it's fine to just include the Reported-by kbuild tags and let
people figure out from the context that probably kbuild didn't tell
people to write a new driver.

Also I think that counting Reviewed-by/Acked-by tags should be
discouraged.  It's useful as a communication between maintainers but it
shouldn't be rewarded.

regards,
dan carpenter
