Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D58989945
	for <lists+linux-iio@lfdr.de>; Mon, 12 Aug 2019 11:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfHLJEO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Aug 2019 05:04:14 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:31670 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727231AbfHLJEO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Aug 2019 05:04:14 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7C92eor003188;
        Mon, 12 Aug 2019 05:03:54 -0400
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2051.outbound.protection.outlook.com [104.47.40.51])
        by mx0b-00128a01.pphosted.com with ESMTP id 2u9tj5vug4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Aug 2019 05:03:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIMEEx1si4sXOTWXJrIqYrGUu+9VIkXrJOHUnOZWBRMY5mHP3R9tv+bUEDUpXtbG8ARMTjITOTjoIyYJ0pRHb0zv7aAkE72TusW2jzjmMR6JPogLc2/CpY6TEZwTY7KsjayqxfAP+EBlhwibZhPJgoONe6Ijwm0HiPDIb3L6eTw07cbJKxWvDhn3LqAifm1OtiDUQfDRz9dRbTBe2Ow58YyN16/sn6Y9E1j7riS6QZtRZuoNDMSBPjTTsw5QKBlzfI2JIeldk65uzIhqZOTp38qYhhl5McD21nreWFEiGjiS9pBlHO6Ru1OqABJt7cqUJLZyOEQFV+SjhjIrivTHKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ti4UzTz/gGJ6yPEV/pPkBY9KrqLpNfdiRcV/7XgyElM=;
 b=K5OnFoQUiSloTFffBxsWOwC+AY9+oYLG6jhyFAsg0hsD/DcQVzzRPWZFeZT2vi2nu3Qs1MvwMIpY6BhtuyMEDbl0COnKLb8c8knORwr3sOk4xkKDPp/aAh2Es+bSJ8ZfPioCyGYfaRdaSUKBeI+2qo+GyNOzc7Uk73GqcoZp79CW4Jqd/wjNgq5RqeoxaE+SrqoQ9WwM6745YIQihJGn7sx8vfrwj27GcnAswks7TysETYRNc0olQwJKrPa2oXhXCMNGLouh32TNfLeELMIE/iAKnE9h4jbgYE3nRXkrWSMKodwjbinZzpUuQh3/RG9Ek5hm4wjW0m6xRbxJhORUhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=metafoo.de smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ti4UzTz/gGJ6yPEV/pPkBY9KrqLpNfdiRcV/7XgyElM=;
 b=8N3brcwxE6uiNXSY2fH11Ex7xXGYf9iSKOQ3YNwPbsSKu3CpHj771baDo4qnNYA+fGQeWUKt8Bg0MOpxsZN6Aqr+nqzAGaHIvM8bAhfHlCfVgsVjje6pXswEitxVP7eQSlSt9C9a9cbRwwO8WLUAgepr5MoVTrZ5vIjr7mEnYnk=
Received: from BN6PR03CA0062.namprd03.prod.outlook.com (2603:10b6:404:4c::24)
 by CY4PR03MB3287.namprd03.prod.outlook.com (2603:10b6:910:55::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.20; Mon, 12 Aug
 2019 09:03:52 +0000
Received: from CY1NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::202) by BN6PR03CA0062.outlook.office365.com
 (2603:10b6:404:4c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.14 via Frontend
 Transport; Mon, 12 Aug 2019 09:03:51 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT011.mail.protection.outlook.com (10.152.75.156) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2157.15
 via Frontend Transport; Mon, 12 Aug 2019 09:03:50 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x7C93mvB009049
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 12 Aug 2019 02:03:48 -0700
Received: from mircea-Latitude-E6540.ad.analog.com (10.48.65.115) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Mon, 12 Aug 2019 05:03:48 -0400
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH 2/4] iio: adc: ad_sigma_delta: Export ad_sd_calibrate
Date:   Mon, 12 Aug 2019 12:03:39 +0300
Message-ID: <20190812090341.27183-2-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190812090341.27183-1-mircea.caprioru@analog.com>
References: <20190812090341.27183-1-mircea.caprioru@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(136003)(376002)(39860400002)(2980300002)(189003)(199004)(50226002)(5660300002)(47776003)(70206006)(26005)(70586007)(305945005)(48376002)(478600001)(6916009)(316002)(486006)(44832011)(8936002)(50466002)(16586007)(7636002)(7696005)(51416003)(76176011)(8676002)(11346002)(54906003)(126002)(476003)(426003)(336012)(2616005)(2906002)(446003)(2351001)(4326008)(86362001)(186003)(107886003)(14444005)(106002)(246002)(1076003)(356004)(6666004)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB3287;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffccb986-8f99-4248-49f7-08d71f03fe91
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(4709080)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:CY4PR03MB3287;
X-MS-TrafficTypeDiagnostic: CY4PR03MB3287:
X-Microsoft-Antispam-PRVS: <CY4PR03MB32871F0017C776A3581F8F5E81D30@CY4PR03MB3287.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 012792EC17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: lSR5oSBaRX3Zj4B6j+Ih8/Tomw4vZp3J7pmawGCt71xg04NuXhpn3wP444nokfNfI2lL/Q4cnaUGa/f8du9wF4S71a8w7t7LXa9vePko8anpUkvYUtlxk5w4ip9o6fLwslRKbWwQpLhxIPzzNa93XOtvhk/yR1fx6NlkaIXB58RtWe61wlIWBevnA85iB2QDWrA5SCBKqX0dxe3n3uKn9poBHv7xib4cjhzLUdvEirmyMwjdv99Zg4QEIomnVqnpZ+nKp07HY3Yl6xAdLoQHTdwI1h7LlGF8BkNdIv7BlfH3Matph3X/snG27hb/V/+xS+VxrGwF4SXqTPP+EtAYzD8U3g/0nQo/1V7kWOV9mFCrqWss3MVpuoC+gRl7tHQ5B6MpYScaTz1Zxv5XFV965l2DgI3eB7WKFF5q+trPNaQ=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2019 09:03:50.7848
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffccb986-8f99-4248-49f7-08d71f03fe91
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3287
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-12_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908120102
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch exports the ad_sd_calibrate function in order to be able to
call it from outside ad_sigma_delta.

There are cases where the option to calibrate one channel at a time is
necessary (ex. system calibration for zero scale and full scale).

Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
---
 drivers/iio/adc/ad_sigma_delta.c       | 3 ++-
 include/linux/iio/adc/ad_sigma_delta.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 2640b75fb774..8ba90486c787 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -205,7 +205,7 @@ int ad_sd_reset(struct ad_sigma_delta *sigma_delta,
 }
 EXPORT_SYMBOL_GPL(ad_sd_reset);
 
-static int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
+int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
 	unsigned int mode, unsigned int channel)
 {
 	int ret;
@@ -242,6 +242,7 @@ static int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(ad_sd_calibrate);
 
 /**
  * ad_sd_calibrate_all() - Performs channel calibration
diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index 7716fa0c9fce..8a4e25a7080c 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -119,6 +119,8 @@ int ad_sd_reset(struct ad_sigma_delta *sigma_delta,
 
 int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
 	const struct iio_chan_spec *chan, int *val);
+int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
+	unsigned int mode, unsigned int channel);
 int ad_sd_calibrate_all(struct ad_sigma_delta *sigma_delta,
 	const struct ad_sd_calib_data *cd, unsigned int n);
 int ad_sd_init(struct ad_sigma_delta *sigma_delta, struct iio_dev *indio_dev,
-- 
2.17.1

