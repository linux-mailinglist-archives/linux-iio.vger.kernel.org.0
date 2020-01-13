Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19D3C138EF7
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2020 11:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbgAMK1P (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jan 2020 05:27:15 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:7340 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726001AbgAMK1O (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jan 2020 05:27:14 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00DAQjZ8023068;
        Mon, 13 Jan 2020 05:27:12 -0500
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by mx0b-00128a01.pphosted.com with ESMTP id 2xf90ev3au-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jan 2020 05:27:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENwGasky8XnAeFY4jLLHC3kV0eOXGNIfItliC+XP2rpFozQKEwIQMgQ8HhPUaP6ZZXACIlVY46KHlugJsHmlxL8v+8r1unPVZTyzS/z2Vqodh8FthAWlcx52qivszrjGHc1LQhW3gsGVKIfsXVkP5+Sq/Xj8GJ9uvi9yjM9eBoTDNOyJv9w/NTwOlAgEqFmDMooDLWcVldrcQkQbL/CpOvTifXqwzLd8dxVF78tLDyRGgMAEUfzeh2N2Gphg4HX4tkNtFvTFTIWcGFYQhOIP/a8ds8OpXvsurSRfzwCL4jWgcsLMO+7IvCUi+XgR7GTRBC1bvCpYQDisB0dbdPSBZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oaw4VMpsN5Z8u5wwjLXGRIdvwO43wZIXBjMlMfIfGH0=;
 b=ebLZJ4s8DBJ7en3BfPBU3/tUcoXDUvjQqZqTuHeDXTCkW6MxcEDuNBrTb8X8DoVad0M2eBjyRH/e9u18Nm/xFW8Qb5FiBAcMcbSLOdSjkVv0ROU91FwlfShPHJIsLf8X+bV4nOv7bl1dW09USucThnjyYETMnAIjsZICsW4x2d/G9ftuZSa+LrpDJCmpmrq01X+b0PsoyufU51jSQFk6u8UUIURRVzQZyazI1E6wkHViKxhKh8XkLKNncElfF7qFOBhlDi4QLoZW6nc606HDpaDnKvTTC6wL0lbWWe3E51CmhQ5MkKT1SG3Rda0oiy7e/U4JcrIqRRmmTXWKd7c/Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oaw4VMpsN5Z8u5wwjLXGRIdvwO43wZIXBjMlMfIfGH0=;
 b=zueL538ALly7T7Fj6HC1kvSxIZfBL3aP1b4mCC20xmjRC6e/B9PW6HK8uKuqsOvPpaGDyWQFAbpnJQuLLBd9AeXnOm0/VhTBP4krTfCVGRhIKVj83C0JqeyHs/If6uQh4zq1yx9BybrPEFracvAsjQgmWg3bWi3IffkV2/oZgGA=
Received: from CY1PR03CA0004.namprd03.prod.outlook.com (2603:10b6:600::14) by
 DM6PR03MB4219.namprd03.prod.outlook.com (2603:10b6:5:5f::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Mon, 13 Jan 2020 10:27:09 +0000
Received: from SN1NAM02FT048.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::203) by CY1PR03CA0004.outlook.office365.com
 (2603:10b6:600::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.10 via Frontend
 Transport; Mon, 13 Jan 2020 10:27:09 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT048.mail.protection.outlook.com (10.152.72.202) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2623.9
 via Frontend Transport; Mon, 13 Jan 2020 10:27:09 +0000
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id 00DAR8GI008733
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 13 Jan 2020 02:27:08 -0800
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 13 Jan
 2020 02:27:06 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 13 Jan 2020 05:27:06 -0500
Received: from tachici-Precision-5530.ad.analog.com ([10.48.65.175])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 00DAR3HP000879;
        Mon, 13 Jan 2020 05:27:03 -0500
From:   Alexandru Tachici <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH 0/2 V3] iio: adc: ad7124 fix wrong irq flag
Date:   Mon, 13 Jan 2020 12:26:51 +0200
Message-ID: <20200113102653.20900-1-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200111112317.1cf2d878@archlinux>
References: <20200111112317.1cf2d878@archlinux>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(39860400002)(199004)(189003)(86362001)(54906003)(5660300002)(4744005)(316002)(110136005)(44832011)(4326008)(478600001)(26005)(6666004)(7636002)(356004)(2906002)(186003)(2616005)(246002)(1076003)(107886003)(8676002)(36756003)(8936002)(70586007)(70206006)(426003)(7696005)(336012);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB4219;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f578f10-18f2-4032-dc30-08d79813256f
X-MS-TrafficTypeDiagnostic: DM6PR03MB4219:
X-Microsoft-Antispam-PRVS: <DM6PR03MB421997A93D12F7B355BFEC8090350@DM6PR03MB4219.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 028166BF91
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WXb/3l1o7EwEZ75yM7tEwyv/Zx3v1bHkipwTVdwaYzPqtWDLHiYEiEtOt1VBZomogEuK4k7FvEW845Y+cL7hEVotOZ+o2rkklmk7tEijf1d/vm2KxC9RzSMX3lpCf+siRGxHqjCzL3TkQbKLaEQYl+qnsvXDOrtr6Bp8PhVfAnjUnwRBm2c6AWILo4GmFHMAYQDaHR8HWTxb2HgegsnKEtXKUXbsmslSyy4tshQA6CuQWObDuQSR6991UXoLCuDz6VVnRrdS3xHoZ1jGmtC/EU0/snlJHNld4FGxPZP6u8Dn092lZiq+0RYpTDlrEiLKB4LBdNL5dWH+h60DFV6hcMeHurxOA7njl5vlF6N+GMOgg1BEj6t6wG6ys7ODY8rjWArm8f4ego3BWjLTVZCJRssuuPOTj3HOo0pNFb9qMtDPKrT1wsyQKFIYH4p/27RO
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2020 10:27:09.4992
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f578f10-18f2-4032-dc30-08d79813256f
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4219
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-13_02:2020-01-13,2020-01-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 mlxlogscore=682 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001130089
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Before these patches the ad7124 driver used a wrong irq flag
because it is using the ad-sigma-delta layer which hardcoded
the used irq flag. This caused an early read of the
data register when ad7124 was set on continous mode giving
a bad conversion.

This V3 series fixes the above explained unwanted behaviour.

1. Allow drivers to set their own irq flag for the iio
triggered buffer.

2. Set the right irq flag in the ad_sigma_delta_info
in ad7124 driver.

Alexandru Tachici (2):
  iio: adc: ad-sigma-delta: Allow custom IRQ flags
  iio: adc: ad7124: Set IRQ type to falling

 drivers/iio/adc/ad7124.c               | 2 ++
 drivers/iio/adc/ad7780.c               | 1 +
 drivers/iio/adc/ad7791.c               | 1 +
 drivers/iio/adc/ad7793.c               | 1 +
 drivers/iio/adc/ad_sigma_delta.c       | 2 +-
 include/linux/iio/adc/ad_sigma_delta.h | 2 ++
 6 files changed, 8 insertions(+), 1 deletion(-)

-- 
2.20.1

