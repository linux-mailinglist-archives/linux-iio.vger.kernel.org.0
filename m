Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491B04CB9D1
	for <lists+linux-iio@lfdr.de>; Thu,  3 Mar 2022 10:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbiCCJHV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Mar 2022 04:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiCCJHU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Mar 2022 04:07:20 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB18B177740;
        Thu,  3 Mar 2022 01:06:35 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2238bW04010147;
        Thu, 3 Mar 2022 09:06:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=QuFQDTA26D2Of6Eu//UmrlD3X8f5AYfMsNYJU3vKQgA=;
 b=h3AUCasHq7Egtfu4LQ5xA6KjQvJPucJq7sWuhRofXy51mKZiO0RQnFUchqs4bf3ps3S9
 8nra/Ni52DPf3Dc6OO+mKO+DDM0CwkK25Z1jwer2DVnHb2kTb4TUeXaVJYhV6Uy4xjhr
 K7eD7Q9asZxXgNPB3gKCU/ytJLJTgsSXz9CkKqCollihyHCCjbW7Yf2pYme14mff1ra9
 JygW77hdCvIhkVwJX5RT6QhNO63oCcY6nwybXbG2KUcasm6XzBJ4NU9q6TRBcodM9aKO
 FOAZ+7AXLU1tXc93pSclVHo1Y9S5n84n90JVgptsAwv0bDcvRDgegySMBxmZK9lAVPet sg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ehbk9es4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 09:06:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22390wdn095618;
        Thu, 3 Mar 2022 09:06:14 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by aserp3020.oracle.com with ESMTP id 3efc186vb1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 09:06:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBHLy76Kw6g8V2c9ywts779Uti5HsFlakd1Lpfm1Wxe7HcEViod60JXDMUuZ1DpY3Nb4dgYYF0t+sTqOjXU4CxqiaoifMe86WN1CryLgOG0phmppONDTd3Lsr2aYYlKMPqHPe3vFWCGfI5ZR7HVm9qYXTMXij49+VjRsvOqFT6/rjpBj1glO+IuQ6tli1REQVIKaWO8V4v5P+2jllWIXJC0Jq1B71Ef0feqR56QalXlwmsl/bAR9uDrdLa+X7OhGJ70W69/qL4tHxBQtodWju3VUN6tkN/IgUrlROUF+CL6fC3x1+K3U8Y336HbqSfjr52vYVNujLDH1WJuWe2RyLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QuFQDTA26D2Of6Eu//UmrlD3X8f5AYfMsNYJU3vKQgA=;
 b=jKmBHzNzTCAsRXvu11DL6uD4rQSQbax9+Cr7pzZm3SCqsLiSywS31LKu9TvQQmLZoGiUCeoYDXIeXKZNXSExJF+ZjQoPab1Ybil9L23oYnHB7Iu2oXjpCc0Htf0Stg1dQesrkrbVbRV78zgi/4xRTL4Uz2hJ/sMBZo/j+aDBiR4Dq9hLE9WZzXOB2B/o+yJ9YK/GrXarX2eJWkZufxIQK+iUjiBP6JY/2j351flXLoWyx1R3j2J5Wbr39y13ScQLDTgHYFe9M43QlcmsMlA2dV84L4j5KiAzckxC1n7Nuj+grSdmupJtFcTwdFVxfIRkr53E0Ptu3fAlrxMDDjX8pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QuFQDTA26D2Of6Eu//UmrlD3X8f5AYfMsNYJU3vKQgA=;
 b=a2jumfV+ArIGzehgHMuEUehvdTpZfjiufaJaz12PaDngKalgevpKqfelCr1N0t40hY3u5zDOhlsmpbd2eUf0pFSVOELoNrnq3vWZrMpo1RmBUfx/EK0h1CG/b/mFqfeg4TENKRWS0oX92ssVd1vqUiHvLxFFPBrYUhTTByK3N8w=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY4PR1001MB2134.namprd10.prod.outlook.com
 (2603:10b6:910:49::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 09:06:11 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5017.027; Thu, 3 Mar 2022
 09:06:11 +0000
Date:   Thu, 3 Mar 2022 12:05:50 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Caleb Connolly <caleb.connolly@linaro.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
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
Message-ID: <20220303090549.GM2812@kadam>
References: <20220221220743.541704-1-caleb.connolly@linaro.org>
 <20220221220743.541704-3-caleb.connolly@linaro.org>
 <Yhft4zNcbD3ojN6i@builder.lan>
 <YhiYY/sXMvQ4VCZd@google.com>
 <20220225090452.GP3943@kadam>
 <YhigDPC6r7dTJUXd@google.com>
 <20220225094024.GQ3943@kadam>
 <da96bd50-e346-a20c-de53-561c996e826c@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da96bd50-e346-a20c-de53-561c996e826c@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: CT2P275CA0022.ZAFP275.PROD.OUTLOOK.COM
 (2603:1086:100:b::34) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 833f4702-a720-4425-ba79-08d9fcf50f54
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2134:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1001MB213405A9F869FF34043EE0208E049@CY4PR1001MB2134.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J3z8b9kBUiA/7PpSwxz1pBHwlao8DKdW3UmHp5+hK3jPfyu2xV2XNI9AE7wm+qgHLX5WLsxHqZGUjeVwh60miQPD5AlRTJtEQZsysvJlPnBtDHmaUgsFXD+qITbH8vIVzMtDXKfAvJ74YmXZfl5zbq84pvFj0+aPMfrgeUMSxnu4uPCE8ubdvKHw9SaZSF0vt4k+ov7X+ciEH075RFZ/kVpj2VW6B5eGfYqBKHGbJXGWR1P63wZIM2pwQraGr8NcO0xfivL1kLG16OAamhnm/x/1lF2Agwd1WKj6RK/MxtSxZUd1pDfO1zxVHFRa0lymUNZlD1V1ctLXkJ6X52yWxY07/h057H/c1MUP5v13RPo9sue1Gh6znsCK6ph6qO/UxkkoLhnPw4Un3YZNPk/nwGukMYyCSE+5s70tkz1g+qIZyA/eRRFxfiiHsmnxdRDxJhBWrgHYjojYhbb/KXJbadbNUTLyU/XpB9PJ0N7PQTPgz3qR0/pr19U0rJgQlT88FoL1nvurfD+3H2gw/EScibe3EKhXIGjnf4ICjoPpRMfdVwu0Ipqu0nyLI/Bhb+TV3O8eCGF9qIaZJiqXBvVwEw83M8T7VkpT6Dv/x6JWqWCbLo8/3oUZVwi6NEhja3RE6HJhXqyCurJovK+pEGLscyHo7yzj5F/5rxca5qoOfrZJpiP/puJxBJ1HbowFeEORg91zZYd7FfeM5RBV+D4hfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(86362001)(316002)(8936002)(5660300002)(2906002)(38100700002)(38350700002)(7416002)(44832011)(26005)(186003)(1076003)(54906003)(9686003)(6916009)(33716001)(508600001)(6506007)(6512007)(6666004)(52116002)(53546011)(6486002)(66946007)(66476007)(66556008)(4326008)(8676002)(33656002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iO4bMfalm/pQ4AORGTQ4F/lH09SbPECdrtdKn+gqmdtSXk04RvcJKR5elgK9?=
 =?us-ascii?Q?lDIIj9NcpAj71ORwUijmz7HAipDl66K/x+2C5vbZHpgJSCTkPMAGMF9b21vQ?=
 =?us-ascii?Q?QubHnlajcZZzy+5opGu18jVA5eBT0vZCuKrsPta7wzRp+wgNRqqPvecZ1Hw4?=
 =?us-ascii?Q?LFk+csoyw84uoKsm1+fsX3WtwND0yOHKcqYRcpVRUZz4lEME4tTphwykOcn0?=
 =?us-ascii?Q?zOyHZ47rJ/vPiv24ODpcWAVe0xzh88+zYsldH8rSFARZ7zZIcQpkcRtMtGBp?=
 =?us-ascii?Q?iJFnJCW2xolnfZpeWqGQL8ipc0altupGg8jtfT4S1Uzgl1AlknsfBAEEaJG6?=
 =?us-ascii?Q?ge6yuKG9gFkjZzPFnHv4aq3J47XGAZ8zDeEI5d8GP0uNAbtfR4w84I21kF0m?=
 =?us-ascii?Q?Mq5Tri05z/IjvRV25btqwlEz1OcOcrRzsKD5fBXeHvD32yXL1J9AbO4Zwr6V?=
 =?us-ascii?Q?XUc24S2oQ88ndmiQrITyV0smWrz1XeGC4WuXYmc/Ewy+HkEgUE1lCaSKefip?=
 =?us-ascii?Q?oDCJCMe5CVfqdfIOSlNd2DkigcKnWsg9yPomNB8bOvtX0H9BAdK1Wzd/FVil?=
 =?us-ascii?Q?fJDtw10bet5hI4o2i1l3gJdhkXuZvay9fDWxVDtlrdnvkOiHNoNFbKd/n/Dg?=
 =?us-ascii?Q?u6LzLo6aQYF25SSD0COIa3IvshgBuSxRL6hjPbf/GrHhDSXnNilauocCj8Dv?=
 =?us-ascii?Q?mc9xDWK06RGi1SQKiVj7Nr/xqfls+mULpQpeqdAEOo1JfaEGK0uXJ/9sSgGl?=
 =?us-ascii?Q?7QeCfQcyy2aRcrbg1tvoDTZsN2Yhk+mBhQv7l1HBgNHKLIOsGLyAqunxp6Lw?=
 =?us-ascii?Q?5uAV7vYTPDKX1yzY4np9bmc5oNggKaPT1NjNpVcUYdNKpLWWhzjWyV+umqse?=
 =?us-ascii?Q?9SBwpFmMJnszRQ+eOuK/GpmnaVlSSHYIwQaYEhLPTv+ptXiZOV3pZhQ4rLiK?=
 =?us-ascii?Q?I89wQmZqq4mWTWtBDevCZ8BCO4jqXPh1JF0kwSs2fDMjNV4rRqVcXg9HyyFe?=
 =?us-ascii?Q?WKvvw8dj6G0vSYAKuWt2Y7b8R1xhL7Nr0yl1td3VRnVZADFzOMBFf/Zvcxep?=
 =?us-ascii?Q?t2fYw03RDU1z0UofSjcJ49aiyqWDmFAEsY7rW1M70FiIcG5mc2YRe2Xfj4bn?=
 =?us-ascii?Q?ymaOIeTKLXoSvBJOBbVvSOnHx9Q+zgMHzzBS+hlkQTlfRF5He+3OwwtfEFzB?=
 =?us-ascii?Q?mwpzLI1ix2hr+B1yXVyF9xNdBg2bJzOVRuA6Iobla22R6DsD4xmHdvH3h4bw?=
 =?us-ascii?Q?dfDk+UkMiSQavfgx/gywTObzIEQGkaTHUy5ULJE7lzFvR1dNo/wO3mM/lERM?=
 =?us-ascii?Q?Dy4pAQrWRD3Esc+596a95T6FtIMekC9CZecYtPrtmtwf13JshoQPoHtBn1g7?=
 =?us-ascii?Q?8EGwHz53ilct6t2IW8EetHOzHqeBWOX2IvbywVIGvFNM2M5XFWh4jCc/gU7j?=
 =?us-ascii?Q?R6dyGK8Z6p++zdlFG+BxwGGudUsiTqZaZga8rqRzKobWioiVgV5HXauqEaPT?=
 =?us-ascii?Q?qhpLkHyCH9KHtIOBlEZLnGJRfONakRXbisi/j8rKbZXJLCC8v7p6mud/6wug?=
 =?us-ascii?Q?IbHKKPRD6sBdi6X8YcFUU1FeHsGIigHLdt8QNJZVvSkTFfXBsSWXsvtrXJXs?=
 =?us-ascii?Q?oBGTmJ10hOEji6ili9Y71rHEaEKS/6GvEnOUpoitxgyIQdlADb622CkiyE8n?=
 =?us-ascii?Q?JmV6Fw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 833f4702-a720-4425-ba79-08d9fcf50f54
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 09:06:11.3096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zJfXuCY4HvVHpydXd8d8V3geRfVk+HJJdK/85dLgf96ciKIGpGdLVq67CfGLgor7urJPsQS2oPPdZkYU78LSscEeK2BjltAr2FPBiB0vFEE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2134
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10274 signatures=686787
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203030042
X-Proofpoint-GUID: qhuH2JYnmH1I2XUC2utK3qBM4Yo-3g5V
X-Proofpoint-ORIG-GUID: qhuH2JYnmH1I2XUC2utK3qBM4Yo-3g5V
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Mar 03, 2022 at 02:20:58AM +0000, Caleb Connolly wrote:
> 
> 
> On 25/02/2022 09:40, Dan Carpenter wrote:
> > On Fri, Feb 25, 2022 at 09:23:24AM +0000, Lee Jones wrote:
> > > On Fri, 25 Feb 2022, Dan Carpenter wrote:
> > > 
> > > > On Fri, Feb 25, 2022 at 08:50:43AM +0000, Lee Jones wrote:
> > > > > On Thu, 24 Feb 2022, Bjorn Andersson wrote:
> > > > > 
> > > > > > On Mon 21 Feb 16:07 CST 2022, Caleb Connolly wrote:
> > > > > > 
> > > > > > > Some PMIC functions such as the RRADC need to be aware of the PMIC
> > > > > > > chip revision information to implement errata or otherwise adjust
> > > > > > > behaviour, export the PMIC information to enable this.
> > > > > > > 
> > > > > > > This is specifically required to enable the RRADC to adjust
> > > > > > > coefficients based on which chip fab the PMIC was produced in,
> > > > > > > this can vary per unique device and therefore has to be read at
> > > > > > > runtime.
> > > > > > > 
> > > > > > > [bugs in previous revision]
> > > > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > > > > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > > > > 
> > > > > > This says is that "kernel test robot" and Dan reported that something
> > > > > > needed to be fixed and this patch is the fix for this.
> > > > > > 
> > > > > > So even though their emails asks for you to give them credit like this
> > > > > > you can't do it for new patches.
> > > > > 
> > > > > Right, or else you'd have to give credit to anyone who provided you
> > > > > with a review.  This could potentially grow to quite a long list.
> > > > > 
> > > > 
> > > > I always feel like people who find crashing bugs should get credit but
> > > > no credit for complaining about style.  It's like we reward people for
> > > > reporting bugs after it gets merged but not before.
> > > > 
> > > > We've had this debate before and people don't agree with me or they say
> > > > that it's fine to just include the Reported-by kbuild tags and let
> > > > people figure out from the context that probably kbuild didn't tell
> > > > people to write a new driver.
> > > 
> > > Reviews will often consist of both style and logic recommendations.
> > > If not spotted and remedied, the latter of which would likely result
> > > in undesired behaviour a.k.a. bugs.  So at what point, or what type of
> > > bug would warrant a tag?
> > > 
> > 
> > If it's a crash or memory leak.  Style comments and fixing typos are
> > their own reward.  Basically it's the same rule as Fixes tags.  We
> > shouldn't use Fixes tags for typos.
> 
> Hi Dan,
> 
> How (if at all) would you like me to reference the bug reported by LKP
> in my next revision of this patch? It doesn't seem like a fixed conclusion
> was reached here.
> 
> It seems like Reported-by doesn't really represent things well, perhaps we
> could try for "Bugchecked-by" or something like that?

Just leave it out.  Those are automated emails and I just look them
over and hit forward or delete.

The thing is that I've been arguing for a new Fixes-from: tag since
before the kbuild-bot existed and on the last kernel summit email list
someone said to just use Reported-by so I've been trying to help people
consider that as an option...

regards,
dan carpenter
