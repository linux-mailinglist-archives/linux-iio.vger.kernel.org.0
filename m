Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A9E54DFCF
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jun 2022 13:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiFPLNV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Jun 2022 07:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiFPLNS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jun 2022 07:13:18 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574145B3F4
        for <linux-iio@vger.kernel.org>; Thu, 16 Jun 2022 04:13:16 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25G8iZhR026656;
        Thu, 16 Jun 2022 11:12:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=4664nHjAK1+U5mDNfSGm2jT45+zbAj4I1OzBoiu8x1g=;
 b=A9/rB5106kwPhYv8yt91SPloHe7r6IG4Vw+k6s6Vm366dR6O0ZmE9kjye80zeNopF+Js
 EinwnP06lcvwJhm6j/Rj82+R1AVT/m1yLq6FHy26CkO6/C8pfDHGPeBC08bt0zbGyruz
 bd6ufZvSCnzFMqCdZ0Nvpj8Q4elo8kKTt/igukClp75vlpseVHgX3SatdiodTFAnclO9
 hhvGFmJfF3nHr41CZc8F9slDY8NOrJbwyaE+8LmSygt9SGxe7xWbrl8f+TrdAMK3JdtT
 +UgH8jIA1RQTvW3zcGYVpfdE8cJGX/Zl8gXeHpyRJPDqnEWkcwDmWz9vxzmzty5OP1aw Aw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhn0k0mq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jun 2022 11:12:48 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25GB9wWP034732;
        Thu, 16 Jun 2022 11:12:47 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpr7pygfy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jun 2022 11:12:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSWyb2p2De0wqsDzGowHsR2zzemQjUOVMcqwAZnA+PaZt9UI/dPw+FSpghFDCTTsvv38rGu2dZYqRWDtMD6d+1QZ/dguSYgOhC0ifL6aYuAvaQ5S1IiAZ5wsAVwEbFxwa8ZF2q7I7AvBffe2j8ijk/Da3ev/fy5O0Ss+MTAC9W/YuGJtFPnILrARFaB+8E9wC+h5hQOMhp3ImhzQt57FPmRpwZblM+IDA4ryAV6cDRexZvzwbnAHA4aJbcsWRVOSY0ZyJXgZNJiJr8p46pgQVkm7ZoX+Ktqu4b0EaPtp5qFa8uEi0VNdfHlLDrqchQmbEM5iiBKZaMZDWXebyYdhZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4664nHjAK1+U5mDNfSGm2jT45+zbAj4I1OzBoiu8x1g=;
 b=H91V0/xVecYliHHWFOEjyrJDMiYQfGCh/b6wV7kNcUKBlAPfqV7IU1daabNfeJBJg9wCaJPEQpehLm7RIEsX2XJ/Ro150D7ybKxHX2k4BSoE+GrwpURbQLVC3LTXh2WwnTOUervf2D4nPjQd6M6aZcx4NqCIWibsE1r9TmmdehfHMoUXLHQ4rA7Ox0Hb5WLeF+hq2xZjRosQrnpOqSLd1hnat+MK9fCJY15U4FU/vglcTPtR/m8lDO6dkBJmmJjhmtV6uo43XWPqdUqUGaxoqua4INgh8Jsbk3fnHqBOvTv6k6tRalue/a862VIBq/WdZgx9Rhz5835i0YVxCUoAPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4664nHjAK1+U5mDNfSGm2jT45+zbAj4I1OzBoiu8x1g=;
 b=n9nekSOFVjtbfXj7C/7cdGFLE/YtfWzPwkWJDd+PVSs0CT5Lx3uBpy0aMQIUrRKdz9q5GO6pEDYoWw+si8Ey0VGxL2G2bqN1ITEpyNKKxd2Y5SCgmVXaX5zYziYyLvFjrdnrXjT6XeenkslTtEQWdUx2s6KlXQc+kDQQBYi2OZw=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN8PR10MB3235.namprd10.prod.outlook.com
 (2603:10b6:408:c3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16; Thu, 16 Jun
 2022 11:12:43 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5332.020; Thu, 16 Jun 2022
 11:12:43 +0000
Date:   Thu, 16 Jun 2022 14:12:24 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Merello <andrea.merello@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org,
        linux-staging@lists.linux.dev, Jacopo Mondi <jacopo@jmondi.org>
Subject: Re: [PATCH 2/2] staging: iio: imu: Add CEVA BNO08x driver
Message-ID: <20220616111224.GC16517@kadam>
References: <20220616100006.22045-1-jacopo+renesas@jmondi.org>
 <20220616100006.22045-3-jacopo+renesas@jmondi.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616100006.22045-3-jacopo+renesas@jmondi.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0068.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::16)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c4cea56-4fdc-4776-bafe-08da4f892211
X-MS-TrafficTypeDiagnostic: BN8PR10MB3235:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB32359655AA6BD4304EFF421D8EAC9@BN8PR10MB3235.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PAuGSS9hI+Xy7H+UDiaIwTz6DHrDn+bhHfWQM4KcfjP6cQl6nrZBv8pUfdkzNen53E59brwAt1vYa8SDPjzJSSAIcZTpxn4R5aXrg/qrpG9DhcRgGk7MQiqW4nPDC0XCpcFcE6P16mRDQYZQ3ZEu9MWHKrPxhSpx46MtAOxkAv/Wb1Bp/W6Ddn5EVtdpZIZvm0el1UmvUS2W+nG3A27Gh1hhm5PzMeNZaHFHfHpj3k4DUb3DfnRx5CgAJW3dNHazxuglNqCCixn5MRt6ry+f447Awnwxu/kBaahq4FHMXCowRuZTy8yjcnPcnGM3iWslSHg24YUX3dy5NoSys9/gS+N/11XEct/3bGHh/rUcUYjDdVrxk9lCtkHuiUqn9nhgNKDWBnH4qPEfbwleIH8ak0TNIK70+Yc6H7OsKJR49va+jxhzzPdHS0uo5WSvKEvcS84DASUO7xiB1/LZJ1fskbQhK+YOP+0Pvg2A2d1jnvh6sn8bVoIgicQt5DYp7R2r0Dar/vpQ/95tDEZQtG4h0IWjf7obqnWd3Km4cK5+vq68Qw5Fg3PNklwRX0yoDulbCNILI0WU7SvVwU2fUwCpn9gu6fqL9HYbq1+yuwcgW1RcxsIijxycKTRCIyu0M6/5tYiezmccuFn10Yz02xvIvLvXPqIMDuv8h431jTd3VH1AMtQ6YiIjSx/JA6A4i2xxpdsC561CeD9sxmlyG3StQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(83380400001)(33716001)(1076003)(6666004)(6506007)(38100700002)(38350700002)(8676002)(26005)(9686003)(186003)(54906003)(316002)(6512007)(5660300002)(4326008)(6486002)(2906002)(30864003)(44832011)(66946007)(8936002)(66556008)(86362001)(52116002)(33656002)(508600001)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iLDl7GZSsUvx6VThWUnjlmDcDEqLgGR1eP1I5qnzIlxz6j9gfa2ojvcoR8JI?=
 =?us-ascii?Q?fYFZhLscOkTb4WsHuQyNKt+cf11ugo/VgrHNfEVCz/7wLiF6FRo+Rke7D9Kd?=
 =?us-ascii?Q?CnYhxTZdWzNMBRdX6/Ft2vDN78Hz/pIsnlYsgaQJoVx1MrO+hc9SA/3BaqZt?=
 =?us-ascii?Q?mJWzVyqk6bh/eaeYtHXPnO14Ged+y0mtqqJ+THn+4m3G83jd4CBnQpFeaxnx?=
 =?us-ascii?Q?mO7KTqYObX1j0ZzQuq8tJQXBKk+7pshPfW/EOE2Zq0R/yaHl04SmLGyAm0OS?=
 =?us-ascii?Q?aNhXOJZfe0364eKcBGU4++l6ez4ohb+FqjBfpaIrjZismM4TsugIWqUAUtLk?=
 =?us-ascii?Q?EO4pBhzuP9X7Ho9BwiUVC/JM0zEvK082p+VKQyEE3moSjKNnr1Tl8VxedPNE?=
 =?us-ascii?Q?lqPfSOx2Ciw4BfIkekFdcNez6LvQHjFmgwDXAioSap2T5r1EKPDUa5KgWD2D?=
 =?us-ascii?Q?9pC9ybaD23IPABUcDVSlUxv1EdhTtLOyOS62AjW9fNAGAVfRHun/TL/oW5Xj?=
 =?us-ascii?Q?e0t8yojRG/Ptv+YEYqhT7GPmOgBQpMB5pxg9jdl72GDweG9aJTYyKOOM0AD0?=
 =?us-ascii?Q?9nOCKSNiFsMjqjdD90bNJIz1FvC4ET6thNl27UYTXgiDpg9P05ncWpglYbY4?=
 =?us-ascii?Q?NIIP0uSsENdBg87oxizhaSMO33BLQQIX2r8+6HG6ak7hHk8d8tCpc8vQ9nhV?=
 =?us-ascii?Q?DoIpN0SLa9ZE1akahxPdl4at+WlFmhrXBDmtpwP/HFwzkRm8J5tcTmw7FtJM?=
 =?us-ascii?Q?Q4/3MlNZ2On/MxMLcXOPTQTisdwgIbFA3odVfrvXLSPxoZNOkkSljc86LbD+?=
 =?us-ascii?Q?AKsSXHGcVPL4V1sltEV3eD9Ea40PzLBReS62GkrYWKFDHhFOoC5nBeZP+zTK?=
 =?us-ascii?Q?DoYUS52gJYY8ocnr8xWoruxYvE71WmvoRiDAjz4kJLb6I0qNvWs8kYbDCvZX?=
 =?us-ascii?Q?es+m4C2Qo1ldbGU5aZmwLk+PMy/iEIwdAeo/ILMU2eGkqcTa/GCASTukFlwn?=
 =?us-ascii?Q?I+kjMC/zUHMpaAzIkJiZUj3KGLzNczxEjyN7XhDSFRgoaAwiVR7zSPZtAmdd?=
 =?us-ascii?Q?BUaKr8aJ8aY/jZjB6IVfYMNFWMLItD1yv0ynS/z6SkPej1t3C+1W6lKvrw1/?=
 =?us-ascii?Q?AfE+Xk4DGKNDIMiPeiGrhLQdQuSUs9n87fHRM7DMZlRY38ib8Nz/+4VRjslT?=
 =?us-ascii?Q?z1dRFReZr0rQibn0oZX8ymAGGfbOPSt5w4ceQKhMFHQafD3CvWlVuw2Eg5iE?=
 =?us-ascii?Q?nEZLmMWWK8floJgl7WiPGF8f2DOYVU6mrMuf70UpaAMs3P5RUcqSCGaL7wcY?=
 =?us-ascii?Q?FR6Dn9MHqPTp6Uz89eC1yZJhQTj97Br0jMr7S3ToQxCJIm56biRbqN548uMV?=
 =?us-ascii?Q?1v37YuO83G2AFiAvtYsqZkwF/iMjIMeL3pkRodgZlNYer/v5UiJQJipJ5HTm?=
 =?us-ascii?Q?tqQnBd68G3UvMlZ9vLSl/6wzMl35fNZXdRyK06cAORQoi0uK6Z9nKv4ZBqwm?=
 =?us-ascii?Q?4rL9blhbmGq1v4NFk8nyKyxshctQ8LX93d/Zb5dNHFLMrB9fUHrn7hkY9S2N?=
 =?us-ascii?Q?avNjDIFj+4+mBvP/TYgpLU7SMhY4L/TcaM1QJ6p7Xtl5mTg7wFGmZB32vhBG?=
 =?us-ascii?Q?RHjyuZUmMH/3dEjwTH6ix2Ac5MCPTKb5tK5r6aYenyUgl0hYpkN4CxDVHeSs?=
 =?us-ascii?Q?JTQ/8uvm/ia0TLDWDx2b6U5rdvpfQCmxVl+vTVS2giDLLqVpwzwzdRa8yz+c?=
 =?us-ascii?Q?lG2nR4b5jkl93KTT9PeR9/OzaIJWuvI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c4cea56-4fdc-4776-bafe-08da4f892211
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 11:12:43.5484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5afEEkjCdW7alUpVAFP9NF9iiiuYtwLPCokSaTZV7SSJDg6SRfuokJhNQpDVoj/NKwRTJPI9Pai5wwWUBPArLKsGRcKOOiveQI2gcTG/DQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3235
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-16_07:2022-06-16,2022-06-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206160045
X-Proofpoint-GUID: 62B6NGKucJVKwHiP9v-TWkx164m49pfD
X-Proofpoint-ORIG-GUID: 62B6NGKucJVKwHiP9v-TWkx164m49pfD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

TLDR: One bug and some nits.

On Thu, Jun 16, 2022 at 12:00:06PM +0200, Jacopo Mondi wrote:
> +static irqreturn_t bno08x_dump_cargo(int irq, void *dev_id)
> +{
> +	struct iio_dev *iio_dev = dev_id;
> +	struct bno08x_dev *bno08x = iio_priv(iio_dev);
> +	struct i2c_client *client = bno08x->client;
> +	u8 *cargo = bno08x->cargo.buffer;
> +	size_t to_read;
> +	size_t len;
> +	int ret;
> +
> +	mutex_lock(&bno08x->cargo.mutex);
> +
> +	/* Read only the header first to know how many bytes we expect to receive. */
> +	ret = i2c_master_recv(client, bno08x->cargo.buffer, BNO08x_SHTP_HDR_SIZE);
> +	if (ret != BNO08x_SHTP_HDR_SIZE)
> +		goto out_unlock;
> +
> +	/*
> +	 * Clear the top bit: it means a cargo is a continuation of the last one.
> +	 * Ignore it for now.
> +	 */
> +	len = (cargo[BNO08x_SHTP_HDR_LEN_MSB] << 8 |
> +	       cargo[BNO08x_SHTP_HDR_LEN_LSB]) & ~BIT(15);
> +
> +	if (len == 0)
> +		goto out_complete;
> +
> +	if (len > BNO08x_CARGO_BUFFER_SIZE)
> +		dev_warn(&client->dev,
> +			 "Cargo size exceeds buffer: content will be unusable\n");
> +
> +	/*
> +	 * Read the full cargo now that we know its length.
> +	 *
> +	 * If the reported length exceeds the max transfer size, read the cargo
> +	 * in chunks. Its content will be unusable though.
> +	 */
> +	to_read = len;
> +	len = min(len, BNO08x_CARGO_BUFFER_SIZE);
> +	while (to_read) {

This exit condition doesn't work.  The min() needs to be done inside the
loop.  Otherise if len is set to BNO08x_CARGO_BUFFER_SIZE + 1 then the
second iteration should receive 1 byte but it instead recieves
BNO08x_CARGO_BUFFER_SIZE bytes.  The to_read will go into negative
numbers and keep looping until something breaks.

> +		memset(bno08x->cargo.buffer, 0, len);
> +
> +		ret = i2c_master_recv(client, bno08x->cargo.buffer, len);
> +		if (ret != len) {
> +			dev_err(&client->dev,
> +				"Failed to read cargo of size %lu: %d\n",
> +				len, ret);
> +			goto out_complete;
> +		}
> +
> +		to_read -= len;
> +	}
> +
> +	bno08x->cargo.len = len;

This should be been the original len instead of min() value.

> +
> +out_complete:
> +	if (atomic_read(&bno08x->cargo.waiters) == 0)
> +		goto out_unlock;
> +
> +	/*
> +	 * Wake up all waiters and let them read the cargo buffer.
> +	 *
> +	 * Unlock the cargo mutex only after all waiters are done, to avoid
> +	 * this interrupt handler re-writing the buffer content with the next
> +	 * cargo before waiters have read it.
> +	 */
> +	complete_all(&bno08x->cargo_ready);
> +
> +	wait_for_completion(&bno08x->waiters_done);
> +	reinit_completion(&bno08x->waiters_done);
> +
> +out_unlock:
> +	mutex_unlock(&bno08x->cargo.mutex);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int bno08x_write_cargo(struct bno08x_dev *bno08x,
> +			      enum bno08x_shtp_channels channel,
> +			      u8 *cargo, u16 length)
> +{
> +	u16 cargo_length = length + BNO08x_SHTP_HDR_SIZE;
> +	struct i2c_client *client = bno08x->client;
> +	int ret;
> +
> +	/* Assemble header */
> +	cargo[BNO08x_SHTP_HDR_LEN_LSB] = cargo_length & 0xff;
> +	cargo[BNO08x_SHTP_HDR_LEN_MSB] = cargo_length >> 8;
> +	cargo[BNO08x_SHTP_HDR_CHAN] = channel;
> +	cargo[BNO08x_SHTP_HDR_SEQ] = bno08x->seq_num[channel]++;
> +
> +	ret = i2c_master_send(client, cargo, cargo_length);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Failed to write cargo to channel %u: %d\n",
> +			channel, ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int bno08x_wait_for_cargo_timeout(struct bno08x_dev *bno08x, u8 *cargo,
> +					 size_t len)
> +{
> +	static const unsigned long complete_timeout = 500; /* msecs */
> +	struct i2c_client *client = bno08x->client;
> +	int ret = 0;
> +
> +	atomic_inc(&bno08x->cargo.waiters);
> +
> +	if (!wait_for_completion_timeout(&bno08x->cargo_ready,
> +					 msecs_to_jiffies(complete_timeout))) {
> +		dev_dbg(&client->dev, "Wait for chip interrupt timeout.\n");
> +		ret = -EIO;
> +		goto out_unlock;
> +	}
> +
> +	/* The caller is not interested in the data. */
> +	if (!len)
> +		goto out_unlock;
> +
> +	/*
> +	 * Multiple readers might want to inspect the cargo content in response
> +	 * to the complete_all(cargo_ready) signal.
> +	 *
> +	 * Copy data into the caller buffer to allow multiple threads to
> +	 * access the cargo content independently.
> +	 */
> +	ret = min(len, bno08x->cargo.len);
> +	memcpy(cargo, bno08x->cargo.buffer, ret);
> +
> +out_unlock:
> +	/* The last waiter unlocks the cargo read routine. */
> +	if (atomic_dec_return(&bno08x->cargo.waiters) == 0) {
> +		reinit_completion(&bno08x->cargo_ready);
> +		complete(&bno08x->waiters_done);
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct iio_chan_spec bno08x_iio_channels[] = {
> +	{
> +		.type = IIO_ROT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index = BNO08x_ROT_SCAN_INDEX,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 16,
> +			.storagebits = 16,
> +			.shift = 0,
> +			.endianness = IIO_LE,
> +		},
> +	},
> +};
> +
> +static int bno08x_enable_feature_report(struct bno08x_dev *bno08x, u8 report_id)
> +{
> +	struct i2c_client *client = bno08x->client;
> +	/* Reporting interval hardcoded to 5 msec. */
> +	unsigned int report_interval_usec = 5000;
> +	u8 cargo[BNO08x_SHTP_MAX_SIZE] = {};
> +	u8 *data = cargo + BNO08x_SHTP_HDR_SIZE;
> +	unsigned int max_attempts = 50;
> +	int ret;
> +
> +	if (bno08x->enabled_reports_mask & BIT(report_id))
> +		return 0;
> +
> +	/*
> +	 * Enable reporting the requested feature. The full "feature set
> +	 * request" package size is 17 bytes.
> +	 */
> +	data[0] = BNO08x_SHTP_SET_FEATURE_CMD;
> +	data[1] = report_id;
> +
> +	data[5] = (report_interval_usec >> 0);
> +	data[6] = (report_interval_usec >> 8);
> +	data[7] = (report_interval_usec >> 16);
> +	data[8] = (report_interval_usec >> 24);
> +
> +	ret = bno08x_write_cargo(bno08x, BNO08x_SHTP_CONTROL_CHAN, cargo, 17);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Verify the requested feature is enabled inspecting the
> +	 * 'feature request status" response cargo.
> +	 */
> +	memset(cargo, 0, BNO08x_SHTP_MAX_SIZE);
> +	data[0] = BNO08x_SHTP_GET_FEATURE_REQ;
> +	data[1] = report_id;
> +
> +	ret = bno08x_write_cargo(bno08x, BNO08x_SHTP_CONTROL_CHAN, cargo, 2);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Wait for a "get feature response". The datasheet says it will "arrive
> +	 * some time in the future". Read up to 10 packets then give up.
> +	 */
> +	while (--max_attempts) {
> +		memset(cargo, 0, 5);
> +		ret = bno08x_wait_for_cargo_timeout(bno08x, cargo, 5);
> +		if (ret < 0)
> +			continue;
> +
> +		if (ret < 5)
> +			continue;
> +
> +		if (data[0] == BNO08x_SHTP_GET_FEATURE_RESP ||
> +		    data[1] == report_id)
> +			break;
> +	}
> +	if (!max_attempts) {
> +		dev_err(&client->dev,
> +			"Failed to parse GET_FEATURE_RESPONSE: bad header\n");
> +		return -EINVAL;
> +	}
> +
> +	bno08x->enabled_reports_mask |= BIT(report_id);
> +	dev_dbg(&client->dev, "Reporting of feature %x enabled!\n", report_id);
> +
> +	return 0;
> +}
> +
> +static int bno08x_read_raw_rotation(struct bno08x_dev *bno08x, int *vals,
> +				    int *val_len, int max_len)
> +{
> +	struct i2c_client *client = bno08x->client;
> +	unsigned int max_attempts = 50;
> +	u8 cargo[24];
> +	int ret;
> +
> +	if (max_len < 3)
> +		return -EINVAL;
> +
> +	ret = bno08x_enable_feature_report(bno08x, BNO08x_REPORTID_ROTATION_VEC);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Read the rotation vector in I, J and K quaternions.
> +	 *
> +	 * We're going to receive several other cargos before an actual rotation
> +	 * vector input report, so we parse the cargo fields and only proceed
> +	 * with a cargo that refers to the rotation vector report id.
> +	 *
> +	 * Use a sentinel to avoid looping forever, unfortunately we can't
> +	 * really know how many cargos we have to discard before receiving the
> +	 * 'right' one.
> +	 */
> +	while (--max_attempts) {
> +		ret = bno08x_wait_for_cargo_timeout(bno08x, cargo, 24);
> +		if (ret < 0)
> +			continue;
> +
> +		if (ret != 24)
> +			continue;
> +
> +		/*
> +		 * Parse the cargo content to make sure it's a well-formed input
> +		 * report containing rotation vector information.
> +		 *
> +		 * The layout of an input report cargo is reported by Figure 5.2
> +		 * of "BNO080/85/86 Datasheet 1000-3927 v.1.11".
> +		 *
> +		 * The rotation vector input report is 24 bytes long.
> +		 */
> +		if (cargo[2] == BNO08x_SHTP_REPORTS_CHAN &&
> +		    cargo[4] == BNO08x_REPORTID_TIMESTAMP_BASE &&
> +		    cargo[9] == BNO08x_REPORTID_ROTATION_VEC)
> +			break;
> +	}
> +	if (!max_attempts) {
> +		dev_err(&client->dev, "Failed to receive the correct input report\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Read the I, J, K quaternions. */
> +	vals[0] = cargo[13] | (cargo[14] << 8);
> +	vals[1] = cargo[15] | (cargo[16] << 8);
> +	vals[2] = cargo[17] | (cargo[18] << 8);
> +	*val_len = 3;
> +
> +	return IIO_VAL_INT_MULTIPLE;
> +}
> +
> +static int bno08x_read_raw_multi(struct iio_dev *indio_dev,
> +				 struct iio_chan_spec const *chan, int max_len,
> +				 int *vals, int *val_len, long mask)
> +{
> +	struct bno08x_dev *bno08x = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		return bno08x_read_raw_rotation(bno08x, vals, val_len, max_len);
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		vals[0] = 0;
> +		return IIO_VAL_INT;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct iio_info bno08x_iio_info = {
> +	.read_raw_multi = bno08x_read_raw_multi,
> +};
> +
> +static int bno08x_data_rdy_trigger_set_state(struct iio_trigger *trig,
> +					     bool enable)
> +{
> +	struct iio_dev *iio_dev = iio_trigger_get_drvdata(trig);
> +	struct bno08x_dev *bno08x = iio_priv(iio_dev);
> +	int ret;
> +
> +	if (!enable)
> +		return 0;
> +
> +	ret = bno08x_enable_feature_report(bno08x, BNO08x_REPORTID_ROTATION_VEC);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static const struct iio_trigger_ops bno08x_trigger_ops = {
> +	.set_trigger_state = &bno08x_data_rdy_trigger_set_state,
> +};
> +
> +static irqreturn_t bno08x_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *iio_dev = pf->indio_dev;
> +	struct bno08x_dev *bno08x = iio_priv(iio_dev);
> +	u8 cargo[BNO08x_CARGO_BUFFER_SIZE];
> +	int ret;
> +
> +	ret = bno08x_wait_for_cargo_timeout(bno08x, cargo, BNO08x_CARGO_BUFFER_SIZE);
> +	if (ret < 0)
> +		goto done;
> +
> +	if (ret < 24)
> +		goto done;
> +
> +	/* Make sure the cargo matches the active scan channel. */
> +	if (*iio_dev->active_scan_mask & BIT(BNO08x_ROT_SCAN_INDEX) &&
> +	    cargo[2] == BNO08x_SHTP_REPORTS_CHAN &&
> +	    cargo[4] == BNO08x_REPORTID_TIMESTAMP_BASE &&
> +	    cargo[9] == BNO08x_REPORTID_ROTATION_VEC) {
> +		u16 data;
> +
> +		/* Unit quaternion I component. */
> +		data = le16_to_cpu(cargo[13]);
> +		iio_push_to_buffers_with_timestamp(iio_dev, &data, pf->timestamp);
> +
> +		/* Unit quaternion J component. */
> +		data = le16_to_cpu(cargo[15]);
> +		iio_push_to_buffers_with_timestamp(iio_dev, &data, pf->timestamp);
> +
> +		/* Unit quaternion K component. */
> +		data = le16_to_cpu(cargo[17]);
> +		iio_push_to_buffers_with_timestamp(iio_dev, &data, pf->timestamp);
> +	}
> +
> +done:
> +	iio_trigger_notify_done(iio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int bno08x_check_prod_id(struct bno08x_dev *bno08x)
> +{
> +	struct i2c_client *client = bno08x->client;
> +	u8 cargo[BNO08x_SHTP_MAX_SIZE] = {};
> +	u8 *data = cargo + BNO08x_SHTP_HDR_SIZE;
> +	int ret;
> +
> +	data[0] = BNO08x_SHTP_PROD_ID_REQ;
> +	ret = bno08x_write_cargo(bno08x, BNO08x_SHTP_CONTROL_CHAN, cargo, 2);
> +	if (ret)
> +		return ret;
> +
> +	while (true) {
> +		ret = bno08x_wait_for_cargo_timeout(bno08x, cargo, 20);
> +		if (ret < 0) {
> +			dev_dbg(&client->dev, "Failed to read PROD_ID: %d\n", ret);
> +			return ret;
> +		}
> +
> +		if (ret >= 20 && data[0] == BNO08x_SHTP_PROD_ID)

Instead of >= 20 it's clearer to say == 20.


> +			break;
> +	}
> +
> +	dev_dbg(&client->dev, "FW version: 0x%x.%x\n", data[2], data[3]);
> +
> +	return 0;
> +}
> +
> +static int bno08x_soft_reset(struct bno08x_dev *bno08x)
> +{
> +	struct i2c_client *client = bno08x->client;
> +	u8 cargo[20] = {};
> +	int ret;
> +
> +	/* Soft reset the device: write 0x01 to EXECUTABLE channel. */
> +	cargo[BNO08x_SHTP_HDR_SIZE] = BNO08x_SHTP_SOFT_RESET;
> +	ret = bno08x_write_cargo(bno08x, BNO08x_SHTP_EXECTUABLE_CHAN, cargo, 1);
> +	if (ret) {
> +		dev_err(&client->dev, "Failed to soft-reset BNO08x\n");
> +		return ret;
> +	}
> +
> +	/*
> +	 * Now read the all the channel advertisments packets.
> +	 * We don't care about the content.
> +	 */
> +	do {
> +		ret = bno08x_wait_for_cargo_timeout(bno08x, cargo, 0);
> +		if (ret < 0) {
> +			dev_dbg(&client->dev,
> +				"Failed to read channel advertisments: %d\n", ret);
> +			return ret;
> +		}
> +	} while (ret != 0);

This condition can never be true so the loop can be deleted.

> +
> +	/*
> +	 * Give the chip some time to stabilize. There's no mention of any
> +	 * delay required after startup in the manual, but this makes operation
> +	 * stable through module load/unload.
> +	 */
> +	usleep_range(15000, 20000);
> +
> +	return 0;
> +}
> +
> +static int bno08x_probe(struct i2c_client *client)
> +{
> +	struct bno08x_dev *bno08x;
> +	struct iio_dev *iio_dev;
> +	int ret;
> +
> +	iio_dev = devm_iio_device_alloc(&client->dev, sizeof(*bno08x));
> +	if (!iio_dev)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(&client->dev, iio_dev);
> +
> +	bno08x = iio_priv(iio_dev);
> +	bno08x->client = client;
> +
> +	mutex_init(&bno08x->cargo.mutex);
> +	init_completion(&bno08x->cargo_ready);
> +	init_completion(&bno08x->waiters_done);
> +
> +	iio_dev->info = &bno08x_iio_info;
> +	iio_dev->name = DRIVER_NAME;
> +	iio_dev->channels = bno08x_iio_channels;
> +	iio_dev->num_channels = ARRAY_SIZE(bno08x_iio_channels);
> +	iio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_TRIGGERED;
> +
> +	ret = devm_iio_triggered_buffer_setup(&client->dev, iio_dev,
> +					      iio_pollfunc_store_time,
> +					      bno08x_trigger_handler, NULL);
> +	if (ret)
> +		return ret;
> +
> +	bno08x->trig = devm_iio_trigger_alloc(&client->dev, "%s-dev%d",
> +					      DRIVER_NAME,
> +					      iio_device_id(iio_dev));
> +	if (!bno08x->trig)
> +		return -ENOMEM;
> +
> +	if (client->irq > 0) {
> +		ret = devm_request_threaded_irq(&client->dev, client->irq,
> +						bno08x_interrupt,
> +						bno08x_dump_cargo,
> +						IRQF_TRIGGER_FALLING,
> +						iio_dev->name, iio_dev);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	bno08x->trig->dev.parent = &client->dev;
> +	bno08x->trig->ops = &bno08x_trigger_ops;
> +	iio_trigger_set_drvdata(bno08x->trig, iio_dev);
> +
> +	ret = devm_iio_trigger_register(&client->dev, bno08x->trig);
> +	if (ret)
> +		return ret;
> +
> +	iio_dev->trig = iio_trigger_get(bno08x->trig);
> +
> +	ret = bno08x_soft_reset(bno08x);
> +	if (ret)
> +		return ret;
> +
> +	bno08x_check_prod_id(bno08x);

Check the return value from this?

> +
> +	return devm_iio_device_register(&client->dev, iio_dev);
> +}

regards,
dan carpenter

