Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F337C49E926
	for <lists+linux-iio@lfdr.de>; Thu, 27 Jan 2022 18:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244679AbiA0RgL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Jan 2022 12:36:11 -0500
Received: from mx0c-0054df01.pphosted.com ([67.231.159.91]:13689 "EHLO
        mx0c-0054df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244676AbiA0RgK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Jan 2022 12:36:10 -0500
Received: from pps.filterd (m0208999.ppops.net [127.0.0.1])
        by mx0c-0054df01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20RCIlZM006794;
        Thu, 27 Jan 2022 12:35:49 -0500
Received: from can01-qb1-obe.outbound.protection.outlook.com (mail-qb1can01lp2054.outbound.protection.outlook.com [104.47.60.54])
        by mx0c-0054df01.pphosted.com (PPS) with ESMTPS id 3duu8kr833-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 12:35:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BS6gl7Kogu6oBqXjm+opL3yoJJWXhXXtWdPr9j8xFKQFRTzjS0q/aTE8zrFYUq9s7M5GD31I2n26nLwsQZp+YkeBrALJIA5B2EqEWHFLRkeV69Ep5tdMgTGxEqlDENdlW2u7p4AxgGNCrRQft0wPh2nngLBzvZGa/+BJgEsMzQxfTUUdIK3SmQmvWYEeqyPvAMJ11HqroUt8iBXiSO7stbnCMaf7l7OL22rwWvchpwZFlwPWXB7QaFKi6qcMZ8Eu8rdodqNQykZfojgcrlURnpndyeeSaEDwfb26qVkSZJwRET0vAkoDJK7PUzy05Rg6cUWfBrpXNZ0hmcIR7gs61A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wL/iR3YAGsAgTqsClA4N74Dqd0pPKnvY+nPWyO8YLfo=;
 b=Q+WUznyemZ9wsH2/yGkmdGThhV7Dcfi3wI3zs5rJ28Nd8hVefl4YrWJaxOi5bbS0X+TJY+J9LEeMCdSyWLNlgEJTBukUuc7aT0nKUdFXuhuBno/FeXN7TT97FdwCKXdJIYbAk/JXy3koH+2vEe7S+OSA9FYbPwq4IMJzA24lBRomecKh2wDWdnBpfOif73hHdUQYBSCfZeZ3RBMZPxS88fpfBRQtXyLR/UyXl1xC2hYCDILxCcFh2eN5CrehJ1Tpn3Jz2CHacUDrNP06CJaH3vT6ec6RFZbCq7RAb3jZTwVcXY9Kusr9KPX0jlqp1Qs36CdgB6F6KKuX2hF994j75A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wL/iR3YAGsAgTqsClA4N74Dqd0pPKnvY+nPWyO8YLfo=;
 b=vDepCbGVYu4TPh13YYVJYJMcCKFQeNYmQ+v0t9cmxa0VWJEcWO9dHFO34UUpp2AVDqCygm7sLKSQTQTmAL4HMyPLW1ZFyeI7igqcwC0QmbRIUulAhjueYxnsV3zD/AwA9l2K7uZHeynr8m0J0YOTB9f2z//SJgI0UcIaq4Dagg8=
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:6a::19)
 by YT2PR01MB9665.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:df::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 17:35:48 +0000
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6929:c39f:d893:b6c8]) by YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6929:c39f:d893:b6c8%2]) with mapi id 15.20.4888.020; Thu, 27 Jan 2022
 17:35:48 +0000
From:   Robert Hancock <robert.hancock@calian.com>
To:     linux-iio@vger.kernel.org
Cc:     anand.ashok.dumbre@xilinx.com, jic23@kernel.org, lars@metafoo.de,
        robh+dt@kernel.org, michal.simek@xilinx.com,
        manish.narani@xilinx.com, devicetree@vger.kernel.org,
        Robert Hancock <robert.hancock@calian.com>,
        Michael Tretter <m.tretter@pengutronix.de>
Subject: [PATCH v2 2/4] iio: adc: xilinx-ams: Fixed missing PS channels
Date:   Thu, 27 Jan 2022 11:34:48 -0600
Message-Id: <20220127173450.3684318-3-robert.hancock@calian.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220127173450.3684318-1-robert.hancock@calian.com>
References: <20220127173450.3684318-1-robert.hancock@calian.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR08CA0011.namprd08.prod.outlook.com
 (2603:10b6:610:33::16) To YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:6a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2eae544-21bf-4f73-536c-08d9e1bb749d
X-MS-TrafficTypeDiagnostic: YT2PR01MB9665:EE_
X-Microsoft-Antispam-PRVS: <YT2PR01MB9665697ACDBE9DF9879F0E8BEC219@YT2PR01MB9665.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UdheU+BhwlfDfLaWOzEoS+aEy9ggQgiqb+wJ+GtKawdG3+HVbWgyjLknieiO9aphXSOBCxtS8w4ZKjsjqVT4a/pii+zji7g7Uy8uZ4fvG0rf7VJ7eEsnuRohIWDcnqmXstbFMdr831+gK1sG2zTwEBEd0hHRfJX1lhYXeq8bkWz2p1ZRzDYIDwOiMjp4eQYs7/G2Sq0x9IJPubSGCzm2NZAcRLAG4EA5DGGtZ46y5ZVUtLpL624MekNK875jUPuhXYKammFVkOWN5p79RN8o3cG5on6a0BVtUu86GQqHoJI0wQ2p07ps8aGsx7xru0hfoyL2kh3EgH7TreWdE6dKdetT3llgbRCv/FNKZ8NSXNiXINxDwkbrR6iQVYjzBDLv+ufQ+3pmoz6eyfr+GI48NE1desI2OUaE33dIQZ2ROCfj0PPyb8IPsjxMIAgrXNKYj0vhQizZd4RDuMHJ9jH35Hsw7EeZQFw7BfHcDt5qNI+5b7LNUJIEd0sU83b/F+egiGp7h6CHzpILYKAzA31ie3oWATLSBB4npYHSzH6SOBw/BYnKNmsNthvNkfh3wpIjpYgT96sg42jraOt2NuUnmACUBNjz5rdjY6HaHHciYZgUsPtCtUGQOe+Jplkl+LbvpT7iN8nLmCxNTS+c6pyK7IFJgY9k5pW60JUanjxcxhPROtvb0CUw8HfqkegUasy/0wtVN/p2NGp8+0rNE5ujGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(8676002)(86362001)(4326008)(6486002)(66946007)(66476007)(8936002)(4744005)(44832011)(6916009)(5660300002)(2906002)(26005)(6512007)(54906003)(1076003)(186003)(2616005)(52116002)(316002)(36756003)(38100700002)(6506007)(38350700002)(508600001)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AmsfCu3i4P0MqyUKVXuK/G4G7TI3FqbV174qvNNHlA9EDWRkhGEFDJBmDwmH?=
 =?us-ascii?Q?LsZchunPKlDIDLcyb31UXn4r0NHrsnJ3QbrSaPfNpXMyZK9ka+w7JvmvhQhj?=
 =?us-ascii?Q?26UrGyA+P7YFf3VQcZ8SSlNentwvzj4/QxA3uCZAd51xuXh9bo9ImrocvJXc?=
 =?us-ascii?Q?qGhi3P9DrPzKXZR+VKxPiWrafkG6/Cnw1+yYieXfVSrMg7UNfZbtyVx8Y1rw?=
 =?us-ascii?Q?D04KWtPv4BLVvzfzGnqGs5DAN1WaQIMXa8pf2qhsNfACo1zYjGUdtdUqeOPK?=
 =?us-ascii?Q?cBnfrQqkSI979hm0OmQIVz32tLx21RDmRVpzvmqJvzH/2eIM+n4ec8nVocUG?=
 =?us-ascii?Q?lQ3j/JPtXHzRPTeMEHVaFnQIoOtdwfL/dLDJdcOUzLS00xCsOij8dEg3IY2m?=
 =?us-ascii?Q?Tez0Z/RnLoi2EQZmp1ZTauDJCqTc4QMqxr8M1Nso8m5y0Y7uuIzKK1Qj10Rn?=
 =?us-ascii?Q?tLsd/AeJzRj+Aex9/KWFdyRNC/7S9wlDQL+l2GJTYEgIXMta55JrkpRYU4qH?=
 =?us-ascii?Q?ngAnHOkt1RhaoYLvV0+4zdNvsEl5ZIgK7CYXR5FfKzYzz4FaGE8BYbgIanEK?=
 =?us-ascii?Q?x5OINhZIPaKQCyMfM/Xa9SryDlwITLd6VfkUZCS3p3bsjwbYASxsV5LsvYGj?=
 =?us-ascii?Q?a94AKKevnSouNJ6OmXnaD41aZ4eZJxHC4rwsiCYgDl0Uoo2z9wDeN4BaNvar?=
 =?us-ascii?Q?k2CGYwlYkD8sT8CKJ+GO9k18i10vSzxXHUsCIIE2ZmM9iSuUs08OHnl44kcE?=
 =?us-ascii?Q?eZQFpaKb9666KhKjsvdGXGbqgRS6QOX20aQkVxc49soEBU2zJ3WpJIwaZ4H3?=
 =?us-ascii?Q?UB3JJaL/aRMtWNuGqbt5j5w28L7C+gwJFG/oZKJuNZvkndCJ5dQu+jduretw?=
 =?us-ascii?Q?SJLw3KhniX2/k2Ft73KeDqj2RtpxdrvMxss2TdG9s/TIc46kyVZ8Ikl64yBm?=
 =?us-ascii?Q?ViYZzPDAICKJtrr0Zcvmx0AYpaBh2VhtTSOD8+hvAwtjy4Aq08T38dvFaNpv?=
 =?us-ascii?Q?reEFPFYackw9XS44EkxlIu9JVPgl9KqxR4Tmtj06DTpuKUlxnlK6LlammkEy?=
 =?us-ascii?Q?OWiFwuoMYwl8jFru4CYYS5WnVGeo9x6w7sqeKZ0o6JaGh72WmVkBRYanJnrM?=
 =?us-ascii?Q?FRms9e8tAzgJxAlHRdZPJJkDvbXqztbXuOTuC0iwORRmZLZBFXjqUqylGcsH?=
 =?us-ascii?Q?L8KolOKPpjn/SpYs6Vbjce1jA31T7a3SUGILy5xqSvey7JQzpuV6QigtjBxk?=
 =?us-ascii?Q?qK5zMLGkYZznrl7DOfMV0CRNbdIbD3ayKhL7+TWRRfoFLJJW3sKDUZIbHQyQ?=
 =?us-ascii?Q?XFkP1POGibTSahd52Rh2ib0EUyxSh+zWOcucq4OmhUUU4xsyswjuIN0En1Wv?=
 =?us-ascii?Q?qIXtlIvCo//YqvY62hQ4e1rhv31j4KShMS4DKjBjj7SZoVRb55ejFao30j8m?=
 =?us-ascii?Q?G4h7SdVlusX6TnJdUXfffJijhPnTZXzJedVkQ8R00Vl0lDzLNLpGscXRylWF?=
 =?us-ascii?Q?C0HnBh9hS0CZ84L+uSyho3aXEs0Lf1TkUMZnFwuwTs3UQwR/chNUTl7ZCm/8?=
 =?us-ascii?Q?agVYe7hzhXA7vPknhsF7Wdy+y4vh3CGa+TPutaOdC9qcgHwzZv8p8944Rypf?=
 =?us-ascii?Q?+Wzxo67MAJvtxeKjb0RnL6/dYGsHhOixpaRP1rBl0ou4Sg9d5RjKlMC9sDJF?=
 =?us-ascii?Q?PNv8pUP0yNOmJ27EnHvWOT+4V60=3D?=
X-OriginatorOrg: calian.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2eae544-21bf-4f73-536c-08d9e1bb749d
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 17:35:48.2487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 23b57807-562f-49ad-92c4-3bb0f07a1fdf
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6fvz9iUGPqQdRQnn6DHcnYQwrLr2r3/uNoGH8+tvTVwIom0VujRM5KadzwM10Jjv8Vsojf/iW0TPWnteqdVNJGbNnb3krN/WWNfsuNxrHvE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB9665
X-Proofpoint-GUID: o8Sj35fI0SmZY4ofcUsXqlf4Wx6E2L7U
X-Proofpoint-ORIG-GUID: o8Sj35fI0SmZY4ofcUsXqlf4Wx6E2L7U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_03,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=736 malwarescore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201270102
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The code forgot to increment num_channels for the PS channel inputs,
resulting in them not being enabled as they should.

Fixes: d5c70627a794 ("iio: adc: Add Xilinx AMS driver")
Signed-off-by: Robert Hancock <robert.hancock@calian.com>
Reviewed-by: Michael Tretter <m.tretter@pengutronix.de>
---
 drivers/iio/adc/xilinx-ams.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
index 8343c5f74121..b93864362dac 100644
--- a/drivers/iio/adc/xilinx-ams.c
+++ b/drivers/iio/adc/xilinx-ams.c
@@ -1224,6 +1224,7 @@ static int ams_init_module(struct iio_dev *indio_dev,
 
 		/* add PS channels to iio device channels */
 		memcpy(channels, ams_ps_channels, sizeof(ams_ps_channels));
+		num_channels = ARRAY_SIZE(ams_ps_channels);
 	} else if (fwnode_property_match_string(fwnode, "compatible",
 						"xlnx,zynqmp-ams-pl") == 0) {
 		ams->pl_base = fwnode_iomap(fwnode, 0);
-- 
2.31.1

