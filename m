Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED87C4EEAF9
	for <lists+linux-iio@lfdr.de>; Fri,  1 Apr 2022 12:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344908AbiDAKIG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 1 Apr 2022 06:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344904AbiDAKIF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 1 Apr 2022 06:08:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508E4186FB6
        for <linux-iio@vger.kernel.org>; Fri,  1 Apr 2022 03:06:16 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2318jOML014841;
        Fri, 1 Apr 2022 10:06:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=2CSiCqM8Rbf+lBNe0SRvTGVVqwvUc6GgP0dAtexQ9BI=;
 b=AKfMM7mKiImxEW3isLKM7zuzU2fEwg1bzppBiFKAyNG8cOaHFYBPQQjqKNVuhMxrW+Jf
 3fp2y5vJTUZjMQsbuUbMqGWORpMKrsrZrabiHf//VfFf4GAd8dn5obfPjXl6CnkGwl4d
 zUixF0dH0SOhWwyYQTyQQPxP230JZ2UTp6Na43lF5BKrs/lUI7uLfFWiVGnPPyiOVEyy
 cfLNdKaae15UKIQoUoIMHM08/zf/bgpIOiTmwdU5HSg5Xy0HW1ylZMzZbQV2RUrfAOqo
 UbiTOaO0JNRTGx9XI+yr3fYjFq1abASXYx4fkXCaKii1gkFy4wmxFwcuetxehqQIgHfe 9g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1sm2pq64-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Apr 2022 10:06:13 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2319pNN8033879;
        Fri, 1 Apr 2022 10:06:12 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2048.outbound.protection.outlook.com [104.47.57.48])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1s95vsnw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Apr 2022 10:06:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UXD+0JOFFETHJkUHHRNsP4L61g7a2oVKconRvNKUqv4DknvSFGFpytPusvhh934Euv5Dg9lB8WBl63gLfDbsHLo7+C84w8TxLo6ZwzN2AaJ69nvAt8G+k/EA9OUAJFyeNXGxv858hLuRRz5S5qbuoR3rCmamsAX0pEvIOiilJMVAYMHLaq7ISSZjDyQ/pn0vmXk0169g/gEDDVEuVEvIUcs0A+sO5DYMjsNf0Q2l6H9Z/ivd/oc7C+fnNz8yMeBa3X3l5zlJPrZ2Klfyw7cVhJYLx8RONy6R/oH5BScYWxAC3eHy9nHgr+HgOS1j04qo5m5Jb/q7ZRTz5z4QZj80Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2CSiCqM8Rbf+lBNe0SRvTGVVqwvUc6GgP0dAtexQ9BI=;
 b=Kyr9VkQbedCd6B5SCfyZOWx59a8wGxcfd1IAtZp+Wqwm9Yx01y3Xc3W2o9TXvPpWoX5dRVkJI6HfergacwFxj/EF/+acIJ9vE3MeQvHcrVWGXxdlGoe7SJrjVMdx7W20eUsKBObKbzDoOfSeVUgs4ncBWyh4TeOIYSCUwS70JjxIuEe5vVCUVoshNqHAlSwjd84CbHfq3kGz0oVLppqWVemGeKfJJeghfTCbRaORMLihzNwyANnUuVt8ErMNCZmgmGUSPRsGd/m4vnXjzCwKlGWc6R1vxxh8lm+1toKQbEwaNEZIj89BRjQ6USP1DPWJF41ZWip/WvOcgo/WKieW5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CSiCqM8Rbf+lBNe0SRvTGVVqwvUc6GgP0dAtexQ9BI=;
 b=B6VzJsC/Nm14WAcmxHgx3Qyftf0OyLdUnBRRszewe+biyCMSgoIgsZUr1wB7UU2dUN9Dj1szFUBVrSX5EnTWldcD6zaizFi1/fO4ZPYflJS7I2M/gwUL9hZKBBXBznakr4Lv/X3qZpAcDJypOy5i+PGn/Ja3rUv9T44l/pXTuJU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN6PR10MB1313.namprd10.prod.outlook.com
 (2603:10b6:404:43::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.26; Fri, 1 Apr
 2022 10:06:10 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.025; Fri, 1 Apr 2022
 10:06:10 +0000
Date:   Fri, 1 Apr 2022 13:06:01 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     mihail.chindris@analog.com
Cc:     linux-iio@vger.kernel.org
Subject: [bug report] drivers:iio:dac: Add AD3552R driver support
Message-ID: <20220401100601.GA29860@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZRAP278CA0014.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::24) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f604d95-57e6-4b44-c7b0-08da13c73f06
X-MS-TrafficTypeDiagnostic: BN6PR10MB1313:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB13134C0C8946FA0CCB539CCE8EE09@BN6PR10MB1313.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mXGywFaVQjab8RibTMUPS9wP9TuMJrOg7g9XogTXR53KU37sLcPlq/9DmJQ+7nLRUAXRzH0/yLcedF68ob6J6d8moLYW5Uq7sqrKo+oe5/FsghEdJCk10lYj8iWi4UUTJR/qghbG3N/IbzhBHmmkYsLBHOZqyjzTXCblksf12Dvj8fYmZnuUWK6fBnvQfATBIOuzSESxYE//yrlNAOQnCBjgS2z+R+Ct3rqRBbVBzMHV3D+WrNkAMvju1LsGsxfeI1JvVsOYZEjdkwdmmAfJJwfZLFL7ApmkFHq0KdinSzom/ATx7FnPA44c46NMMIapjphC9r9n6Jn8ajGvR2HQ+3HFhleUpCqNs3JRWpAaQDCOW8trfnZbtFyNXbaZwSuT69g0EkEu9WHAj9t841UfAvP7s6Fj+ZlmF0xF4feVH8EzlZulsxtFa5p4ddtj9gpxW4CD/lZK97LUp7CPfW/k+wfGtpelmaLJ41rkvXOXYA6mnfqlrDWfTJwsNd+W6jk+z77WQqbirRmCakEaMYbUNGhf/rg6JQ9cp+lWJye+ugVZFx6SN5ih/RopV2ZMxn3+gP2Rz66AMyk6jknX4MBvfjBGx4OUYuhTtI3W7pEF6QMLx38RQGYN8tYmFxkwKa6hZ18EWjLroOJIsGEChBFn1WJ+s5AHlfemrOQL7IGtDE7c00XxuYdHtp1VJxfrAW/8MYeHioJJSUgeKa0QOvW3cA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(44832011)(5660300002)(66476007)(66946007)(8936002)(52116002)(6916009)(66556008)(316002)(2906002)(508600001)(6666004)(9686003)(6512007)(6506007)(6486002)(8676002)(4326008)(33656002)(33716001)(38350700002)(1076003)(186003)(38100700002)(83380400001)(26005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mpqRnPY9VciKey0FxY6xoxEApDKzMH9dmYocIoQBH4QmqW4VXa+WL0gspbRC?=
 =?us-ascii?Q?CjK94Xo5iNHb+MU0fG8RK9DZlGyQDS9c+9CgEc2MzO1Jl/7Gir2JN7AoASqQ?=
 =?us-ascii?Q?MyN/Lu/AryHnHI7NZHAB3EkBtIr7fMOnklvaZtww4NVccAEqJUd3SMW69Zwu?=
 =?us-ascii?Q?6DL5w7BEtLKA3gXYpxlY11s45zdWKi5FDRANm4NlA6inrXnISWku/VIDxgjs?=
 =?us-ascii?Q?Jo5Y023TRE/qU2rDzXxqp3+1u2XH1r3QrCj7ZSPFTKs3u2Dc8h2TBOx5iRf2?=
 =?us-ascii?Q?jHvlkqFxerv99vDxhRJc5lcX4rQVzGpdFmxN1yJWDnZ1iHDz/BwVW3f111nK?=
 =?us-ascii?Q?4tEKieIdFmu29Qu9nC4J63bslqqrHlbMoAnmPvldTnM/kscCQjhgp4eahFnQ?=
 =?us-ascii?Q?LsUYD4ScVbEXBaii2x6vP6bQnrtz9UCSOpb/+9aYRw2CxukQetuMuhotIYQu?=
 =?us-ascii?Q?8eEum0i/F5xUvQseHQeLCYy5wJ6M5nLys9eKlV9S4Y1kFeku5WqArq0tDJTE?=
 =?us-ascii?Q?+ZCZ4mBhuZC0e/QCbMdTkJ9CGme55Qj40u0EUVpgqggx3esn+ydOFSkTYqT2?=
 =?us-ascii?Q?ttQnG8OuHnbSeaM5D1UhAxBi7am7QKTjJOwx9BcLkmdSajySBp9mqfoZcQy5?=
 =?us-ascii?Q?2TC//20Sm7UvG5qBRC6NrzCKFv0WVKmUgoSgTCgMCvBOnAIMybYXGUtGE1kn?=
 =?us-ascii?Q?DH3bXmOzns/pr4w8vMXW7mqqlB7pVSbHqs72leS1sPFpRMLYgsVDk5nWyZ2s?=
 =?us-ascii?Q?GdqsN7ysE0wVKMYfuqfpiBJUf0DuhaSJ+KW9d1oYr1LrRTix2xcxP5cXxNHU?=
 =?us-ascii?Q?AIqrawOio2RHzbTEcYfFkrBIYPgpRWE2QHb7YPNRT02MzuPwDyImEu3Pd0PM?=
 =?us-ascii?Q?qgbaR/VYEIrYpkEwMoRyKYcilJCN5S/5sxHT4sG8DGuUYtZn9awWckbg7tEp?=
 =?us-ascii?Q?R23OG4WFGJ+JKZZiyHaQyTWi1ZJpvsVPlRcLBJTWDeqZRignFjkH5uRD1fc2?=
 =?us-ascii?Q?YPNrojgUQG1gMzjYAyVAkFdvNt/Naq3k3QxjqnCKu+2y7H8nhM9JZRB0zQt5?=
 =?us-ascii?Q?kJhkjTdD3o8XuuX8WZVyHwZig0T3GxNMRnYBZQ3Wg8F2bAzTsdoVLCDIWb7R?=
 =?us-ascii?Q?mLup5z8il3noS9uEIX3zuF41n2PaWcJfWtAmrJXXp4N1l3lXuwQUNEF+eWom?=
 =?us-ascii?Q?WeFKs1D4AbeIg63XF6LwvnyvkEpkujTZOQ3lqaVyVG6OGpXWdSrAP+dHirtu?=
 =?us-ascii?Q?JSkNd9zXh8pDVZ9b0SWBVAmu9pcpAaLahjW2CCtqDo5FEMt8xisj66okZCqC?=
 =?us-ascii?Q?7UfLBbwEnlzhMS4B3yrtkgHaivmtBfYvuRfjjmYGVyFlQSt8S6IGtIvKlFkg?=
 =?us-ascii?Q?dKk90FkUltfkNTiDBmkGwxZxtnnda+4rmYALLf7ppXZfMhaSlNwQSHB98dNh?=
 =?us-ascii?Q?ifwUKAM7faU+T4FxPu1YZtjEUFGlpLavzKTHJoJlYGJ+1RmdYUTOQeLXWoxq?=
 =?us-ascii?Q?/biW3G9V1vYu2AnwNHlBTwYSTgJKNCePcE9yiqC0zOu3rZ3VMdytYImJOpKH?=
 =?us-ascii?Q?bQcJkJWT+VowS5CE6vqAGm/UtMWFhlll71MGbKlx057jZopi0c7KLv48BK2E?=
 =?us-ascii?Q?A3cyUuqdFxsDHxNeTdpOPBIZRlRAoC4CS/TRadC486z19jvo0wERRHtQQP1m?=
 =?us-ascii?Q?ZL9WGbqxjzGuBwX3LT0hQVgJY18+lj1i2r7I+fKpe6uOTqaH8l/eKs07ocbK?=
 =?us-ascii?Q?G6A8OyzaGDOUpQYXGs7DofhMCHcifMc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f604d95-57e6-4b44-c7b0-08da13c73f06
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 10:06:10.6612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HACx+LR4NTMie9c3V1eLlB3p8FbvRch40HvbPB/br2ldWXZDs6cF0DaTW9lGt0a6rLPt1KlDcEON1q4feGdclDdcAV0gGU0Lgu1OGtvehNA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1313
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-01_03:2022-03-30,2022-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=667
 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204010045
X-Proofpoint-ORIG-GUID: PXmtJsNk6Xaghv2GiWo4708FHXy1Q1sQ
X-Proofpoint-GUID: PXmtJsNk6Xaghv2GiWo4708FHXy1Q1sQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Mihail Chindris,

The patch 8f2b54824b28: "drivers:iio:dac: Add AD3552R driver support"
from Dec 13, 2021, leads to the following Smatch static checker
warning:

	drivers/iio/dac/ad3552r.c:812 ad3552r_configure_custom_gain()
	warn: 'gain_child' is not an error pointer

drivers/iio/dac/ad3552r.c
    799 static int ad3552r_configure_custom_gain(struct ad3552r_desc *dac,
    800                                          struct fwnode_handle *child,
    801                                          u32 ch)
    802 {
    803         struct device *dev = &dac->spi->dev;
    804         struct fwnode_handle *gain_child;
    805         u32 val;
    806         int err;
    807         u8 addr;
    808         u16 reg = 0, offset;
    809 
    810         gain_child = fwnode_get_named_child_node(child,
    811                                                  "custom-output-range-config");
--> 812         if (IS_ERR(gain_child)) {

This should probably be a NULL check right?  return -EINVAL;?

    813                 dev_err(dev,
    814                         "mandatory custom-output-range-config property missing\n");
    815                 return PTR_ERR(gain_child);
    816         }
    817 
    818         dac->ch_data[ch].range_override = 1;
    819         reg |= ad3552r_field_prep(1, AD3552R_MASK_CH_RANGE_OVERRIDE);
    820 
    821         err = fwnode_property_read_u32(gain_child, "adi,gain-scaling-p", &val);
    822         if (err) {
    823                 dev_err(dev, "mandatory adi,gain-scaling-p property missing\n");
    824                 goto put_child;
    825         }
    826         reg |= ad3552r_field_prep(val, AD3552R_MASK_CH_GAIN_SCALING_P);
    827         dac->ch_data[ch].p = val;
    828 
    829         err = fwnode_property_read_u32(gain_child, "adi,gain-scaling-n", &val);
    830         if (err) {
    831                 dev_err(dev, "mandatory adi,gain-scaling-n property missing\n");
    832                 goto put_child;
    833         }
    834         reg |= ad3552r_field_prep(val, AD3552R_MASK_CH_GAIN_SCALING_N);
    835         dac->ch_data[ch].n = val;
    836 
    837         err = fwnode_property_read_u32(gain_child, "adi,rfb-ohms", &val);
    838         if (err) {
    839                 dev_err(dev, "mandatory adi,rfb-ohms property missing\n");
    840                 goto put_child;
    841         }
    842         dac->ch_data[ch].rfb = val;
    843 
    844         err = fwnode_property_read_u32(gain_child, "adi,gain-offset", &val);
    845         if (err) {
    846                 dev_err(dev, "mandatory adi,gain-offset property missing\n");
    847                 goto put_child;
    848         }
    849         dac->ch_data[ch].gain_offset = val;
    850 
    851         offset = abs((s32)val);
    852         reg |= ad3552r_field_prep((offset >> 8), AD3552R_MASK_CH_OFFSET_BIT_8);
    853 
    854         reg |= ad3552r_field_prep((s32)val < 0, AD3552R_MASK_CH_OFFSET_POLARITY);
    855         addr = AD3552R_REG_ADDR_CH_GAIN(ch);
    856         err = ad3552r_write_reg(dac, addr,
    857                                 offset & AD3552R_MASK_CH_OFFSET_BITS_0_7);
    858         if (err) {
    859                 dev_err(dev, "Error writing register\n");
    860                 goto put_child;
    861         }
    862 
    863         err = ad3552r_write_reg(dac, addr, reg);
    864         if (err) {
    865                 dev_err(dev, "Error writing register\n");
    866                 goto put_child;
    867         }
    868 
    869 put_child:
    870         fwnode_handle_put(gain_child);
    871 
    872         return err;
    873 }

regards,
dan carpenter
