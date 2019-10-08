Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4452BCF46D
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2019 10:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730467AbfJHICj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Oct 2019 04:02:39 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:53900 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730177AbfJHICj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Oct 2019 04:02:39 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x987wRhU013804;
        Tue, 8 Oct 2019 04:02:37 -0400
Received: from nam01-by2-obe.outbound.protection.outlook.com (mail-by2nam01lp2051.outbound.protection.outlook.com [104.47.34.51])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ver39j1ee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 08 Oct 2019 04:02:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/+6kZoRVSPBULki65R9FpSS1D5z1E/lVKQI/txvGtxYtrFBLM3vy27b1Kbxxtp9moTNN1LR0kuu+WGJoEwg8AcJRblNQD+uXO/AgbsADgtP2k3sl9vgaSTUY3TcZsAdZcJkgBWq4WUrKu5n6wmL5TG056yK9XKKJi1hnqyEdrxXPsA7phfl8lEu3ZRiQ4VJ9f1cMEbi3l2OQdk1H/KIaUF/eZ5gWiQ2lhj5EP+Ec+Gk1AR3fROSvh7hqcxORhY6dnOcefmMbhNJW2BLp9EQyqEzsolBkvW5vyDzsp24HBlmnIEm7GHk8aHqDBvNy7XEJdOjw0eXC7aA5uxwmPDm9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKwYF0gCnboycw+1o/q6clsVui/rwB1N1u4Fzh3JeKk=;
 b=mrZ6NnxMMkmGZJhVRurnUdbSfs6NT+Id8EBiIWcrPHDsX++y/JOlDAwz8Ao535v5Tt/f0SQT76TVPR0FmRzeyl7PLhNjPVip54SMHEawzkS90EL6zRF02Qz0Zbrj1XR1jH3DhMP3tamFts3+48A5cp5cNlAxX2Ykx12XDK4zSZ9YrfWvfPgZpBA7TywDqagRMu89zxqKIsMBifoxinLDcy3TgTSd9oIDA+BqP2JMpAZLAloccVCiyTMC1oKyMAFedYZkFPQ+IEL9lYEABaL/gzWmM3A3hip8Oz0YEdG8rVGIoxG4o+JJupsxy4Z0L5joEhUdG8YlBO2WNNfKkmYNZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKwYF0gCnboycw+1o/q6clsVui/rwB1N1u4Fzh3JeKk=;
 b=m9SmPiSSv8uqXBd6fwUpMyGiJ9pF6fpyqn7x2sOvs1QdXdnuomiPzqTG8RqfHyOW63oHUiwxhQZIaSk/3scKf8bG7FVCQMYDS76+9RFrB3u+LHPwyuK3uk5EvUoJpNkIRPT/FgFawCZN1jNGHQzZuKprhAceQX7OsJMKzl2eg5k=
Received: from DM5PR03CA0053.namprd03.prod.outlook.com (2603:10b6:4:3b::42) by
 CY4PR03MB2791.namprd03.prod.outlook.com (2603:10b6:903:68::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.25; Tue, 8 Oct 2019 08:02:35 +0000
Received: from SN1NAM02FT050.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::200) by DM5PR03CA0053.outlook.office365.com
 (2603:10b6:4:3b::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2327.24 via Frontend
 Transport; Tue, 8 Oct 2019 08:02:35 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT050.mail.protection.outlook.com (10.152.72.128) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2327.21
 via Frontend Transport; Tue, 8 Oct 2019 08:02:34 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x9882YHW014019
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 8 Oct 2019 01:02:34 -0700
Received: from saturn.ad.analog.com (10.48.65.130) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Tue, 8 Oct 2019 04:02:33 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 1/3] iio: imu: adis: add doc-string for `adis` struct
Date:   Tue, 8 Oct 2019 11:02:37 +0300
Message-ID: <20191008080239.23239-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(396003)(39860400002)(199004)(189003)(54906003)(36756003)(70586007)(106002)(70206006)(1076003)(86362001)(14444005)(336012)(426003)(26005)(5660300002)(48376002)(356004)(186003)(316002)(486006)(126002)(476003)(47776003)(305945005)(478600001)(2616005)(107886003)(2870700001)(44832011)(7636002)(50466002)(2351001)(246002)(8676002)(50226002)(8936002)(4326008)(6916009)(2906002)(7696005)(51416003)(81973001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB2791;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4bafbbeb-8b20-4486-2457-08d74bc5e0c1
X-MS-TrafficTypeDiagnostic: CY4PR03MB2791:
X-Microsoft-Antispam-PRVS: <CY4PR03MB2791133AACD26B492F5D93D3F99A0@CY4PR03MB2791.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 01842C458A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MAKOsxCkCuJdp7f59eYlHYQLhydWWKmfPvku3X/IDxLyHD3YHVAF2Am3dNIgtt1WsXiM3jMzOsjgL34OOKD7N3Qw2NqWI9OjzHsnN7F0VDaCT+jFzFPutXodzOELuCP2cVjP5Dx5XI/uIjrxOPG5sToCfiEKB5HNtq05c4rWBTvXQ6RVz3B+1GNes7it/QCCFdQBhLUqIKq7JG+AWC60lDFMw6GkJdHE8aEKHh/SNXd8Ji/xsv3A8nsIfbi/Jju/JLdIGMwkpSq8k9cdaZbrQzbrHzq4wP1+6ICaJH4hZDkoysAASxf9b6bMlXaMwT4jmu24cQiqytJ6AnE4YZ4YZ6obruaYyMg8No7q7bNQRX/A5fCoRrRh9jSNO8LFlVgDxk3jngc8Qr6hm9HC+0edpzhyPBBPsHEnDXIylVev4Wg=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2019 08:02:34.6548
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bafbbeb-8b20-4486-2457-08d74bc5e0c1
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2791
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-08_03:2019-10-07,2019-10-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=920 mlxscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=1
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910080081
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change adds a doc-string for the `adis` struct. It details the fields
and their roles.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 include/linux/iio/imu/adis.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index 48444f28b003..dbdf421d35dd 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -54,6 +54,20 @@ struct adis_data {
 	bool has_paging;
 };
 
+/**
+ * struct adis - ADIS device instance data
+ * @spi: Reference to SPI device which owns this ADIS IIO device
+ * @trig: IIO trigger object data
+ * @data: ADIS chip variant specific data
+ * @burst: ADIS burst transfer information
+ * @state_lock: Lock used by the device to protect state
+ * @msg: SPI message object
+ * @xfer: SPI transfer objects to be used for a @msg
+ * @current_page: Some ADIS devices have registers, this selects current page
+ * @buffer: Data buffer for information read from the device
+ * @tx: Cacheline aligned TX buffer for SPI transfers
+ * @rx: Cacheline aligned RX buffer for SPI transfers
+ */
 struct adis {
 	struct spi_device	*spi;
 	struct iio_trigger	*trig;
-- 
2.20.1

