Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAEE4C41A4
	for <lists+linux-iio@lfdr.de>; Fri, 25 Feb 2022 10:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238419AbiBYJlj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Feb 2022 04:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233715AbiBYJli (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Feb 2022 04:41:38 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF202399C5;
        Fri, 25 Feb 2022 01:41:01 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21P9a305028596;
        Fri, 25 Feb 2022 09:40:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=vwytLZqCooqlX8I5duJk+54Fj6fvgWWTbN004L21BDw=;
 b=rVQAL9RdJIIaphHsrQ+xhpQahiqt+VkLMqPqocJ+8X/QkyqUi9A9Nv3s2b/I/Z5rIYHT
 ZoGfKDieZAAuHRY1OKzTbf3ch+h8LoTv3pgZC+drqGTLvgp/Fjwv92FEp6PWDQvXKoG6
 D7XnbVD/45fS4cpaqeAiOkOcdeLFXXkiUW+RAAWhZmu5L/zW60kX5FzzLtVKT0ys5RRa
 ibxpkvEu/yrxPCGA+2ZGdnn6uQy4ByhmOYozhRGxmUjzJb7IyUQfysZHgoRMeVyJeXhL
 kjHTnfm4AoLYb7nna3Q36DiybfOjT9wb7KI1ipy3sUUthfLxuToA2R4HDCxTCA2BgC37 pg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ecvar9a5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 09:40:42 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21P9ebF0063224;
        Fri, 25 Feb 2022 09:40:41 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by aserp3020.oracle.com with ESMTP id 3eb484kec4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 09:40:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j72UvHIhvrfvG1qdmJTSh/ImaXwVJLyZsf3obVmUiUOvyWm310Va5v9d9uKQ4Tga6P+z5uURlpOYEZ4B98CXmUKGnVXHEoQrtQIryc//Z8bPR/+VS/vrFP/VKv3GXxwkrskYSyko20WqOJbC2AP9Z5Fok+n/NeOuPv3cIwQCw+pHkni65AajhG7WnuMkHUUmtKEXzCntM05XBODV2QVXbRL+WFpbVeCNgztLImdeqW2u4/zOcFcR9pyZg+s1be/XlGAW1ohAVOQt5ieYJRzPwbqovfLaZbjmiQvfOnzkLz1dcTrBPwkWrNrp08IMZYPdOCsPXuxmuibYtN3fyrfpeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwytLZqCooqlX8I5duJk+54Fj6fvgWWTbN004L21BDw=;
 b=JGgXEzsmjU5uAfH7DP/VBNj2G2EJQuUz/tBsdeZGQ3WtCZQ++AFyn0qHH5AwOP2tmrQaCqLMtHi+g7ZKNN67m37abKw/vYTCElv9gXkRtaGPOr6JuEfSVaizyGr35oGrYHP6t2QrFTrZXTFU/d8eur+JBDPG1RZI/fzWBrKGgiCsujVlKLFr5Bdf1gx3s1oj/LtPyHTjMKlU0/bJ7khypyleKOtMD8Fz4MfFCo343yydNv622n87YdyDlkx0N3fsV2wmWvyTHAfCoiuJ0p15ozTk6DFbVUCx/bGiD/T0qzMBwnbz2hOlYHv7trEAsLyH45aYBurIbwOEUkIlHpApqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwytLZqCooqlX8I5duJk+54Fj6fvgWWTbN004L21BDw=;
 b=WQoMwlLGfNlOJ8e3TtFA7WqvwTfnCJ5WR/adAhvRG2qrz8xhuICqW8PTbh+Pir6jBTebBWqlyvEKRxn/dWgYofkHyqfuQbiT913bN+LiLF6iY5swkSRQ3UcZcjowY0kTLaLzig/s8QwyQeKj8RjqlzfwA6R2rtdlcGCQ3KoL4Wc=
Received: from BN6PR1001MB2354.namprd10.prod.outlook.com
 (2603:10b6:405:31::21) by BN8PR10MB3731.namprd10.prod.outlook.com
 (2603:10b6:408:b7::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Fri, 25 Feb
 2022 09:40:39 +0000
Received: from BN6PR1001MB2354.namprd10.prod.outlook.com
 ([fe80::54d3:796a:b63a:2582]) by BN6PR1001MB2354.namprd10.prod.outlook.com
 ([fe80::54d3:796a:b63a:2582%7]) with mapi id 15.20.5017.024; Fri, 25 Feb 2022
 09:40:38 +0000
Date:   Fri, 25 Feb 2022 12:40:24 +0300
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
Message-ID: <20220225094024.GQ3943@kadam>
References: <20220221220743.541704-1-caleb.connolly@linaro.org>
 <20220221220743.541704-3-caleb.connolly@linaro.org>
 <Yhft4zNcbD3ojN6i@builder.lan>
 <YhiYY/sXMvQ4VCZd@google.com>
 <20220225090452.GP3943@kadam>
 <YhigDPC6r7dTJUXd@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhigDPC6r7dTJUXd@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0129.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:51::17) To BN6PR1001MB2354.namprd10.prod.outlook.com
 (2603:10b6:405:31::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee57e432-9657-4cb5-6a67-08d9f842e16a
X-MS-TrafficTypeDiagnostic: BN8PR10MB3731:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB3731FEA4842027EA5A4931588E3E9@BN8PR10MB3731.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Grtr4G9dGO8O0l84YGGLA9Ds4B1wXmm9t8IHVcws2vqgFWGiKBRMbL8lywVjMEAbtZ434aRPbbeR0b5lUUdx5WpT1AjdtoY1MAIe2qwLkFwck+UPhnDeQV/GGr6llj52m/sMzz0JJuWEcbDioDDRguSXyFyUSZ0+wfLeFmRXoAHMqM4ZdqSgH42TLrrTiBgkJbu8GkTDym+Df/3HTpCUUexpyKuqO3N4L3E/ZvvYRTvEv+aLC6ln9q8yeA2MfLjY+jeZUVbWHJYGkdAafFUAce7TVIWd1FTFart9lnBBUCaichzlmCJqcoboP3dWgpk7/KCJ67mlQJ2BWNNjbnoMWj8gL9+YaWpENo650SWbAvAPd4w2TyZPwa6SFMbqdrcX5bzOcblrqT5tyJuicKHExxtTXvh2kXmJNvFzFtxOJymN1iXwZMFhYylxFp0XdPn8KxaBzs43/zl5J231eCCuk24LmIhZOSbJrN5lQEWWhzOSUyh4JwFTCkBtpZtm7TyO/HzP+9J+/RKwJMGKBzfntKNVHtH27T16ZtddmqidvK134haJW9y3fQq52Z0Swu9pzJrfAUlckfgJ+l+Qr+zhY7slbd3GErePT8EEff0Cp/k7IPfu6yWfSozyNVOaI2I1jt6zjG0hQK3xRfjq2brO3oAwxvOaSqt+Twg+YEyvNCGAFzv0f1G3GxtBPiXQpx+L68nhfdchSSL4VwDdvDGq3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1001MB2354.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(1076003)(38350700002)(316002)(38100700002)(26005)(2906002)(8676002)(66556008)(186003)(86362001)(4326008)(66946007)(66476007)(33716001)(33656002)(6666004)(44832011)(7416002)(5660300002)(6916009)(6506007)(54906003)(508600001)(52116002)(6512007)(6486002)(9686003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u0UCalVNmO3Z4N4Vqu/bdJYss5kgepC41ztV9/n0ZE3dpr+Jx/9NeHXKnyLk?=
 =?us-ascii?Q?9n8R/ItYz7lImWpY50+rcwKWddY3La2kFMOsKXrgMLeO4ec7HGXjdAk0KGJu?=
 =?us-ascii?Q?OB8rIVPL3xiC2CGVLztMTy4Zif7isxyyACNpVvtORHXeZzrA3BpI3GzF2dmH?=
 =?us-ascii?Q?iYvWFsy3w44k+d8k0gz7VyHYGYi9lHfx44eHUa9JfHwfk6mBhQUNmBGSV2vw?=
 =?us-ascii?Q?fI5HoJm2Kq1zf/6wVvOv11zVCpvzHBu3lPQHSKN210NdC0c0lpCinmUIbesW?=
 =?us-ascii?Q?732ylcQuiuKIGksBCglrzPv2Pwf9rT49RvNEdGrQ0wTKIVBrnINY7bUmBzuy?=
 =?us-ascii?Q?9MG6jKGxuYvbG0AKGERzWvQf4eI7pgZcCNBZkLmjsWPWgBIzHhebvVnR3rR+?=
 =?us-ascii?Q?tkXqSMd9FS2eIn+Vxh6sfZFq3AwdfoY6rq+CYC99tgaxbj348Rt+Dg9ZLxbD?=
 =?us-ascii?Q?iePQ0Qpd98o8Bjl5THDn6Jdzi4O8o/S0Cqu69QAjvx7X7Yoe/FHn0y4u9dUx?=
 =?us-ascii?Q?d9FclZW9jXu6ZkDzis/oIQVNyk1JxnKZHVwa0Q3Zp5yuk0QcYbAWJWCK0xd9?=
 =?us-ascii?Q?1h3n4u2FflgU1Df3fi6Qt2VHS9Pj5xZpVG1cv2GhHqeN/bSYCQo8zTFIurDh?=
 =?us-ascii?Q?UPSeMotW1PftX3soMxDslG7u3W+iaB39DNVUUgsppiAAYhcQnpsdvYE6HUpP?=
 =?us-ascii?Q?yj1clg0Y6zsKS8HgYr0Y+Vsy2i3rTO2siElMMdkZpyOfAhdXVhxgLt8HEOxv?=
 =?us-ascii?Q?2Q8O9CHz0f0AzcjgEbvVLxCbHofCIUBDBAhgfvXTB29O4BWWAOj3OQO0xstQ?=
 =?us-ascii?Q?VPU3JTZMGRl8cZoQfw3RJW8227R7wKFQFrhKvS/DvODeRti7rWMgDT2lLaB/?=
 =?us-ascii?Q?A6/H5S8dmWKu4oGm3q88BYnpGS56ym1labEKh169sjQTVnHDHaO3Okdu505+?=
 =?us-ascii?Q?7/N2rg+tYNIPmW319lRJ8gAfIs9dW16dzjFornZN+xQNriVb85WGlncjIFp8?=
 =?us-ascii?Q?+ep1/FDdowuj6mjATzG9f5FFJyYCHp0sRmd5nVg0wETTObZ4jnrkYnufE1nO?=
 =?us-ascii?Q?va1fBl4/wZtUnZTTMKqVM3wL1FsLr/L4SYVfvllwcvXnWFOT8d83IKLlpj7O?=
 =?us-ascii?Q?EqOMCwo6mv0V0FDXXU6BLEVv3JWwkjAJ1IjGDlpL6wUlgdLlitysa45sWELb?=
 =?us-ascii?Q?vqwvi72AmFJtV4nmEBTMdLYKcI3sJyIG1DEGIe0W4uIZQC+g8Ehm99fKIGeu?=
 =?us-ascii?Q?tvSexDQuFA/Rp55fvFfqQAPZLRpeBLSXFMZ4o2+xCkoHyu0NMk2woxWI2BWk?=
 =?us-ascii?Q?0A3lpH5nz1PS9okLQN2/tTeTgZ3ycCeP2eckxDRah8XRwnNKiXHM2KVKtMwd?=
 =?us-ascii?Q?N2w8I6n7iM21H5k5N1Vcke8jXqsftMo/YOOq0MmXtDe4RHpUKMT7aPbpF4jx?=
 =?us-ascii?Q?TXxTLwUYleb5/udbD70uGL6uTi+M5j61LpxZtD4EN4qdw1FRF4FRe84E1Kws?=
 =?us-ascii?Q?+SLdv0aZWnl5yst5eAmh2S3DuvMVmuCqpmYasWZJk9KX1zkjvNkV26aN4Ok1?=
 =?us-ascii?Q?NWLbddDZcBMgwns6NEFqlGRv+x7tGlOHgpQPWfccagFoy3XZPtf9Say6/L+y?=
 =?us-ascii?Q?fPdTsUF6oxZMITANljxOYBvkAR8g8Uq5j/lqKdmrXiJpalqL3RjQUe+X0C9i?=
 =?us-ascii?Q?K6Y/Aw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee57e432-9657-4cb5-6a67-08d9f842e16a
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1001MB2354.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 09:40:38.6919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6adKBnkV1LwC9YzCktZ3W4tAwXtYjht4yV7TiZ/apbLfRDxKZGZjfX+jRtvcJaewQ79LIkkzVW7Kw3WmMezeIdu9tJjIJTkQJDEG47AGnRI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3731
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10268 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202250050
X-Proofpoint-GUID: SfPsZhElMX0IOi4YDmx2GrKUqvBaL88W
X-Proofpoint-ORIG-GUID: SfPsZhElMX0IOi4YDmx2GrKUqvBaL88W
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Feb 25, 2022 at 09:23:24AM +0000, Lee Jones wrote:
> On Fri, 25 Feb 2022, Dan Carpenter wrote:
> 
> > On Fri, Feb 25, 2022 at 08:50:43AM +0000, Lee Jones wrote:
> > > On Thu, 24 Feb 2022, Bjorn Andersson wrote:
> > > 
> > > > On Mon 21 Feb 16:07 CST 2022, Caleb Connolly wrote:
> > > > 
> > > > > Some PMIC functions such as the RRADC need to be aware of the PMIC
> > > > > chip revision information to implement errata or otherwise adjust
> > > > > behaviour, export the PMIC information to enable this.
> > > > > 
> > > > > This is specifically required to enable the RRADC to adjust
> > > > > coefficients based on which chip fab the PMIC was produced in,
> > > > > this can vary per unique device and therefore has to be read at
> > > > > runtime.
> > > > > 
> > > > > [bugs in previous revision]
> > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > > 
> > > > This says is that "kernel test robot" and Dan reported that something
> > > > needed to be fixed and this patch is the fix for this.
> > > > 
> > > > So even though their emails asks for you to give them credit like this
> > > > you can't do it for new patches.
> > > 
> > > Right, or else you'd have to give credit to anyone who provided you
> > > with a review.  This could potentially grow to quite a long list.
> > > 
> > 
> > I always feel like people who find crashing bugs should get credit but
> > no credit for complaining about style.  It's like we reward people for
> > reporting bugs after it gets merged but not before.
> > 
> > We've had this debate before and people don't agree with me or they say
> > that it's fine to just include the Reported-by kbuild tags and let
> > people figure out from the context that probably kbuild didn't tell
> > people to write a new driver.
> 
> Reviews will often consist of both style and logic recommendations.
> If not spotted and remedied, the latter of which would likely result
> in undesired behaviour a.k.a. bugs.  So at what point, or what type of
> bug would warrant a tag?
> 

If it's a crash or memory leak.  Style comments and fixing typos are
their own reward.  Basically it's the same rule as Fixes tags.  We
shouldn't use Fixes tags for typos.

regards,
dan carpenter

