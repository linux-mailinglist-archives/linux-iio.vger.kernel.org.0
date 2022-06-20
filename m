Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BABD5513D8
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jun 2022 11:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239354AbiFTJPC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jun 2022 05:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238854AbiFTJPB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jun 2022 05:15:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9615BA47E
        for <linux-iio@vger.kernel.org>; Mon, 20 Jun 2022 02:15:00 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25K99epZ005208;
        Mon, 20 Jun 2022 09:14:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=BH+UVc3a5cGQYga9TJFcAWc8A9oR9a+uw/ZNiqCWVa4=;
 b=BdsDsfUlvXNKCz/duU0kFpwKUsdWUPgbfWDqciSnjzzi3gvtIY7+9hT/00Zp4T3aPCJB
 HQMnpnrk9Sb2Hsg9nwEY/tUR5/L9kxdWFrmdZ5cjNubYdqdZaIzrJ2NdQFGN9pziKgIf
 R04W8G0BgqxaiPOc/U/ESkU56qUnoOIArtQyGiNcJZXXm93czS0PHMQw1IfD9BjeOt2s
 RzydATAQ6IUPY/OiMvxEhclsDJcwNPqY0DBciB2ph0VhRPQXBomA3FguUM+TYw95UXVt
 TNYdsPZyjCUV0EyRQg5akPR5Md5irTQkDR/cGz6HO/K5bLVlLybLc9Y0f2Y5y1LBbITS qQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs5a0asms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jun 2022 09:14:26 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25K96Oxa025838;
        Mon, 20 Jun 2022 09:14:26 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gth8v6py3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jun 2022 09:14:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mAIYFPQ/oYoLVkeEOsui0P/ZJArbHZIPJCgLMnjNYNO/H7xSyKtKwOd7uJ7HFG44nnexgmy5oCcK44LC4DpNUpuYqJ95+N6OVIkaaxE4PvnfA/97Xf0aKsFP5X9DTXbhimYUEjCqJGXYwhANYulcQUGNkzLGa5OSlWXNqzWD7SPpH0nXGcf5/V8LTJxWCjV69ZtNfYxez9k/bISu13pJvhE/2XwaCU0aum5pWa4c1jALuHejjGLG/mpFEn/7qEZb/+s+qQ4AsTdE1ucLLtli8mGlVFHpAIxVC6ldX9Axt4KDi84jLRzJ0ais8DZ4eIBBPnmhyAkWsIDL8c1h6hmuYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BH+UVc3a5cGQYga9TJFcAWc8A9oR9a+uw/ZNiqCWVa4=;
 b=XEtQ89gohOZCAyfSnxcbRVafrPo3WNqPan7bhYWQQFFNrVpotoTB8DHYcNAFRRp/ZwOE3byNbh2aYTnVgKp4g3jGddtQS7aDrPKmnStZCIGkuqvCi4e3Zqy9A+MmcKfq7Te8/jadq8rP3AEWocDFG+5kF7n/hbQCVtmFVcWnDXbJwzs5UVI3cWUaKk/Dp2BwLph7yJ8ysaia9x17Kv6kArHf58w0tJ2/lpjwjq9yVWzEaMMzyKHEPaiYzqhNMqCOwsv7fakti9qDmH4bHjdOR5En/NDzSXr/EzANDlcpbQmm+31EI4Dj3ie2zr9s3JxLcnahNoDfqKtEh2n4f9k2BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BH+UVc3a5cGQYga9TJFcAWc8A9oR9a+uw/ZNiqCWVa4=;
 b=IMpaKI7Nq+7losUN9gaXkF843SM6l4EoUGHh1Ex/QRd+iVz+fbite0plcJnMjcDdWQN+UTpg16FAuGYufbY5Van9WBpo/Ol+IyCtrX5qT9ZPd3N9rPQlIwErQXEaNBTHQ8rF0VgY+OsoulWvrx/7W/Ws3Mb0Gf0j6dmlAy7EA7k=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW4PR10MB5702.namprd10.prod.outlook.com
 (2603:10b6:303:18c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Mon, 20 Jun
 2022 09:14:24 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5353.018; Mon, 20 Jun 2022
 09:14:24 +0000
Date:   Mon, 20 Jun 2022 12:14:03 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Merello <andrea.merello@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org,
        linux-staging@lists.linux.dev, Jacopo Mondi <jacopo@jmondi.org>
Subject: Re: [PATCH 2/2] staging: iio: imu: Add CEVA BNO08x driver
Message-ID: <20220620091403.GH16517@kadam>
References: <20220616100006.22045-1-jacopo+renesas@jmondi.org>
 <20220616100006.22045-3-jacopo+renesas@jmondi.org>
 <20220617184941.00001fcb@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617184941.00001fcb@Huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0032.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::20)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ca62128-b485-491f-a2be-08da529d4459
X-MS-TrafficTypeDiagnostic: MW4PR10MB5702:EE_
X-Microsoft-Antispam-PRVS: <MW4PR10MB5702CBF3F49CFD06EA7043228EB09@MW4PR10MB5702.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Ysu+Zd+ZWKNRZu2C6zp36htA6AcUKNHYf1spzPtsuwTnR8KRGB4jo9zCvJCMJXo5wBoiEHVPY4TlNJ1bPXh3RYvc0QJ9zMHlZ5jJ84g1Kg6WMQaj18aEqDmqMaWzDWMf1CBVWY1sDQykI4Y2VuzhD9b+idGmiKOxHwFP8vk588MGGNJIf/C2eGnCzXiSCdOh6QkqrvaCiY//HUMvhqz6wqh0LNOTjWj+gezpsOkaPiZZPmbwnlMq2A/Q4Tk7NlJ731wuUlHF82khYPiw6u3RxjzsyoUAHSCHPCB2b+YmwwXF5UsvJJ4CJenrVtia+7nJyyqG/bOGVymFLrzVB4LgUJxuNpEeJVOLrJzaPXkEEM+jaANgkGPBFfBQx4dN9KByYnC0zHWlis1d8ztdZvj+w0u4sgR0y1yiLDjI8iWjUgyZKLiYPVy4oboCREBARQWHBk2c9YLZzbQuT9yE3X5EeFQ5gP5UI4DJG5nGO/loAExG8/Qi04uqRJ9bFNRCTdkcNSnNMxUu2+3nOKSA+Za7mTnZVFrXwOZfstXkjhe9gtuuq+6rvvD7PqtbmfVtwtPaui1WIkixOZ++0KGV5SERHEcvDU0SggrPaQi/nfiLHPgslr+hfYYpgCr6bTWfQNgnA5zVL0rj3UY5uTDYgkrdlGDEdHuCCvCRQjnWOEIM5eiUGpm2Gf7I9cY4mCV+XIUB1wCLTXsbRrZY2fhmvn0Gg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(396003)(136003)(39860400002)(376002)(346002)(8676002)(5660300002)(7416002)(33716001)(2906002)(52116002)(86362001)(44832011)(478600001)(6506007)(6512007)(26005)(38100700002)(6486002)(9686003)(6666004)(1076003)(33656002)(8936002)(38350700002)(186003)(66476007)(4326008)(41300700001)(66556008)(316002)(54906003)(6916009)(83380400001)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YQLMIEGmXljuYocEFNj2GKXDUQ0DkY9yAZVt2dYzAg7qqR9CjdO5ytk7AQko?=
 =?us-ascii?Q?2DJA6nN0MJs3JOffsMu3GJbjPhiqMt4iPRwGPtf+eIiO27lHuplc5ZwTaEu5?=
 =?us-ascii?Q?z7Ob28JyarNg7IqCoPbO6Isv4N7Y0u8JDLiaBNWWbA17s3VYDJozqnYwLq+a?=
 =?us-ascii?Q?TY21NTn0xMw0q2hhc3QGEkbbRYc3/SD6JTQ4reKapX8zNApZWm73Lt5KtxOn?=
 =?us-ascii?Q?xNV995HoHiwkvlCtoMNh4n6pU3VMpIfticJX6kxQqvlE3X1pwQ1iiLRlrbP+?=
 =?us-ascii?Q?emdKdn6m0sbGSS9FuJEyjZOWek2AWOZFStS6iclkHocuAoxuzS+qwevCXnw7?=
 =?us-ascii?Q?rtXa5azmfkO3ErtRsXAjXnZ7QE91G4Yq0UqJl0YD0mPCUG3WdvI/U59Ka8zB?=
 =?us-ascii?Q?w4vwlV1yf1YjJdvaaZc7jmN0bN32KGogq8IiXRPNV3R7kTEz0CDuPhY1+zdB?=
 =?us-ascii?Q?zbsEIES310xmrEQD8iwZghNTT7XES/PjUQmF6orRW381VU/ZKuKUroUuc/Fv?=
 =?us-ascii?Q?a6TDXMLyCtjXGg97aL8lNmYBDLZZTPHLK9HcBemQty1J5Azo6WycMChuLoO3?=
 =?us-ascii?Q?56nV6kmmxiUAwLR/MfyWT6qR1hEa8f41AKzcW4eJTo19udcTgkQ9dIQV8G60?=
 =?us-ascii?Q?5RQtmpTJuyZpVpts88xq4DznggSzB+ORz1XzteiaM+lp1ZZh9fbv1ikIwJ8Z?=
 =?us-ascii?Q?w9WtrqLqSSVNmh5OaefHsc3ZHaLiUBrAzTHgwel3aJ2QK/mpLs3OuqRmUMOe?=
 =?us-ascii?Q?moYOT8CgMPP9xwXg5keg+21JZ6bYKbKaMyfhRcd8CCkD13toXE+kxEweH9Iu?=
 =?us-ascii?Q?NQvGQXbvFteQzGkry7RAkZJmy8NabdDi5EywA1ws2Q8rgCnHOr2B6Bvj6UW9?=
 =?us-ascii?Q?k75Ci9R1ARrNcfs5MZGLq5rXdwi0K/a2HxrZlRdr1MDXp1azGKQET/LR3Emz?=
 =?us-ascii?Q?x2dCzkBfZrFl3VcVPhxm9qx8rgW2trsnsccTk4/S/mXjfCcsoBu7jSsW6xLy?=
 =?us-ascii?Q?hMgofsM7i0LPteF0DKtEBM0vVD1py2wfP4M9M+mtG0thSdXTLFdg6ivjdozA?=
 =?us-ascii?Q?k+eTMf+hkiJMAYruc95NW23SobFFn+v/AWgJsCNOe8dkwYuI/rIGtF0dNbZE?=
 =?us-ascii?Q?bhyJRpo6Vh8mSGyDeVrFAQ7RMHyn9xYbDE1aXWH391gPM+w8EOifSVOxXLam?=
 =?us-ascii?Q?tVIP8IKe10grCNoHg1ouv90IrpCh11vrnveb+AIeiZTCBUtemuWKOZ3cFgN5?=
 =?us-ascii?Q?66PYACJJgmVYO2x+K6m/A9Lu4FNjSWNqhpfBIagKBDlVoT5pK5mYp05pHeUg?=
 =?us-ascii?Q?obrUx3gDY8QjXArpp2OkOx/dNtQFEr1gy1gozUUkUqvbP4JOrVV6HMqUJT+x?=
 =?us-ascii?Q?K3k00TWzrF31nwO0xSJZmAuGkLyqchugPTnZn+3CEWY3htwXeBuatcNEmZRD?=
 =?us-ascii?Q?fvoeN1fzpbHyMYXV7Y6ljcOgljDaVGSiXCQ6RUkLXupv83eZAdqgUkPM4pKj?=
 =?us-ascii?Q?aSJglEMcpC1J8PCsa7ZfpnwtQoHtujn1SRid/EiBhTcrzkigck92HzBpg870?=
 =?us-ascii?Q?/nPZ3QhrbnwhTT+yKFPEdTT+Wq/D+JJOdA0tabLS7uIrt4NmwY5pZmBMMzct?=
 =?us-ascii?Q?zLztXznd30z4YJmQ+WJzNqgoB506+FODIa/D+Nmyq9jBf4QDyu++sf+R55PF?=
 =?us-ascii?Q?KlHFYu4myce8O3gIls+JWRK+A9J1qAwvHyffTM3hM9uWtIkHuqttGU636Yh1?=
 =?us-ascii?Q?QD7NPvHm6IHmxYUhiWco014bFGVwPqE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ca62128-b485-491f-a2be-08da529d4459
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 09:14:24.0633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NG1KZ/ALCwFgBf+q8mvCI6N5j9Jaxy9p3/OrLr6+fe8iZlU9e1bjLMR6rBS7ep8O+1hBZAnFHJWUquRYN6HHZcejXV+6wHrhr9FKWayA/ac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5702
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-20_04:2022-06-17,2022-06-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=609 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206200043
X-Proofpoint-ORIG-GUID: DWfBDv-38vK6-MS9RCgFEFvBehr34LJw
X-Proofpoint-GUID: DWfBDv-38vK6-MS9RCgFEFvBehr34LJw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jun 17, 2022 at 06:49:41PM +0100, Jonathan Cameron wrote:
> > +static irqreturn_t bno08x_trigger_handler(int irq, void *p)
> > +{
> > +	struct iio_poll_func *pf = p;
> > +	struct iio_dev *iio_dev = pf->indio_dev;
> > +	struct bno08x_dev *bno08x = iio_priv(iio_dev);
> > +	u8 cargo[BNO08x_CARGO_BUFFER_SIZE];
> > +	int ret;
> > +
> > +	ret = bno08x_wait_for_cargo_timeout(bno08x, cargo, BNO08x_CARGO_BUFFER_SIZE);
> > +	if (ret < 0)
> > +		goto done;
> > +
> I'm lazy - if it's less than 0 it's definitely less than 24 so no need for separate
> paths unless you add some dev_dbg/err or similar which might make sense here.
> 

Also 24 is a magic number.  But you have to be a bit careful with
combining conditions.  The two common bugs are forgot to set the error
code and type promotion to unsigned long:

	if (ret < sizeof(buf))
		goto done;

Negative ret values are > sizeof(buf) and for 0 to sizeof - 1 then the
error code isn't set so this made up example would be totally broken.
None of that applies here, of course, but I like breaking the conditions
apart just as a habit.

> > +	if (ret < 24)
> > +		goto done;
> > +

regards,
dan carpenter

