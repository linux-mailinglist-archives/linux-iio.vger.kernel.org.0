Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43983E4B71
	for <lists+linux-iio@lfdr.de>; Fri, 25 Oct 2019 14:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403762AbfJYMpH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Oct 2019 08:45:07 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:13924 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726338AbfJYMpH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Oct 2019 08:45:07 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9PCbfh4002961;
        Fri, 25 Oct 2019 08:44:45 -0400
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2052.outbound.protection.outlook.com [104.47.44.52])
        by mx0b-00128a01.pphosted.com with ESMTP id 2vt9t2btsg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Oct 2019 08:44:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWs+AO8A6k0pC/u7MjwZye5rz0y3mcwCOq81h062tBdTJgLSM1bZBAnDYdrM+C2g5qKJzKoGDQjcqi2N6b9d0/lYfOCEduB4Y4OFzLQvK3iCEflucLVN07Iaj7agcV4+JWsmMYMVCylSBKF5V+XGB+5LNnP9OCPSJ7aUcbp7aLnpjHRMriRuIaDRdzt2WT1ubhYSxF+vyKuNiuQeyz14wQ8VfVGF9Fpdn33IZMjwqsiOCYnDC+bv4av8ETG2DsAxXPsEEA2hq2pp3720JqeLaFE949yYiE+QHUuPlUxt7nsqTuK1YWNvCeodJWhzCQ3FGBW2hl23sHIzYLfsAR3CCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ubdty69p3lfKxwu+v6QmiiWCpK/8p58KYfZhn8svEc=;
 b=P/cLVNooFxW59W4ib7OgVb+id7EMGc28QBgceZtlBA1H1Z+ec9fVYeKW851Fg9jpU8NwuERX3LQq/vTuOhntZLt0qugjuoxswpF37+S9ov5wCaJOpUfUJRNUgazGJ9Y3MZeOCd4c4aYf3QRpzXQ3QNnJnFlRcP2AFz8N9HgXf4ZDOZDKJ052Ri42p0IscSK01JBDp0N2yEKZrFXJX1SaHzY/gCLUxE7yheHJGS52vtcYNK7jGQr4UuF/FWXPY6uUsKcK0yYusTk0nXwA5Ogns8UzqYVCnhsJgnCg68zVN3wx34Dsz0GhZFSqsNArP2m4lAZd8FIaqIgTp6Tov/LDYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=metafoo.de smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ubdty69p3lfKxwu+v6QmiiWCpK/8p58KYfZhn8svEc=;
 b=Oss1IIhc9OSWzVJAkm0qCuU0xv3Rs0mwMeZcsd3u9owHc5bOArj/36I0YRG6BUWM/c2y733wfmDbBXFIVrfqbrOA6kGmn5Sz0cI6T9UvQUNZE7GvCFtJbnYJheb2ZDhPmjVEW09yZakGWRSdTm0YT9QrShnRZ8eIqJlRTKi0O00=
Received: from BN8PR03CA0002.namprd03.prod.outlook.com (2603:10b6:408:94::15)
 by DM6PR03MB4844.namprd03.prod.outlook.com (2603:10b6:5:188::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.20; Fri, 25 Oct
 2019 12:44:44 +0000
Received: from SN1NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by BN8PR03CA0002.outlook.office365.com
 (2603:10b6:408:94::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.20 via Frontend
 Transport; Fri, 25 Oct 2019 12:44:43 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT007.mail.protection.outlook.com (10.152.72.88) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2387.20
 via Frontend Transport; Fri, 25 Oct 2019 12:44:42 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x9PCiZsl020952
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 25 Oct 2019 05:44:35 -0700
Received: from nsa.sphairon.box (10.44.3.90) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 25 Oct
 2019 08:44:42 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH 2/2] iio: adis16480: Add debugfs_reg_access entry
Date:   Fri, 25 Oct 2019 14:45:08 +0200
Message-ID: <20191025124508.166648-2-nuno.sa@analog.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191025124508.166648-1-nuno.sa@analog.com>
References: <20191025124508.166648-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.44.3.90]
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(376002)(346002)(189003)(199004)(50466002)(6666004)(356004)(5660300002)(5820100001)(7736002)(305945005)(7636002)(186003)(16526019)(23676004)(426003)(2351001)(76176011)(53416004)(336012)(6916009)(26005)(47776003)(54906003)(86362001)(446003)(2616005)(316002)(476003)(2870700001)(70586007)(126002)(70206006)(106002)(8676002)(1076003)(4744005)(11346002)(50226002)(5024004)(14444005)(486006)(45776006)(4326008)(3846002)(478600001)(6116002)(2906002)(8936002)(246002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB4844;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ba83783-947f-4c08-d0b9-08d759491bd3
X-MS-TrafficTypeDiagnostic: DM6PR03MB4844:
X-Microsoft-Antispam-PRVS: <DM6PR03MB48444F86F4298526A8BCD80399650@DM6PR03MB4844.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:663;
X-Forefront-PRVS: 02015246A9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ssKMGnUdzcuGI9+RtjbKfoGvfjQWIBWg2NXnAfATM+MKZ6TUFSZCTTlsCIPlqyccAN7CKEtamwP93faCfhzBxrDte1Wp4lbENMTjLGto1poHugq3Rqru2ACoUUTObHZep8yVjOhcs+bpLuyEPV8VY/EsD/7qu19W8wrqVJiXlHDaRRr8F4WWVxujD2nLrNk4Bs9IQ7WSOMzC6PaVQ9HueBOyEZaH19iOVFFYXvh4HoZqqT0tbFjqi9zHQhCCaAYRwwN1d6/XsiIJaYnTVAUJRh5Oir0oW2luOHsD5Yo4+j4QlEzkhzMSo/WF/c+RHQTWMCGX6+T4NLPLqe6EWK1/tkEc02hnK7lItXs0pJRcGQkJ6RuEc53WPpK7aqQrXREEzM41TWBXBHcDZd+PXnWBJ0IscmvuwxXRxqkPuMAJMo3tzYH30elz2T1PiLdJyMAs
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2019 12:44:42.9444
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ba83783-947f-4c08-d0b9-08d759491bd3
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4844
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-25_07:2019-10-25,2019-10-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=1 mlxlogscore=965 phishscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910250121
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The driver is defining debugfs entries by calling
`adis16480_debugfs_init()`. However, those entries are attached to the
iio_dev debugfs entry which won't exist if no debugfs_reg_access
callback is provided.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/imu/adis16480.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index 3b53bbb11bfb..94aa1c57e605 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -921,6 +921,7 @@ static const struct iio_info adis16480_info = {
 	.read_raw = &adis16480_read_raw,
 	.write_raw = &adis16480_write_raw,
 	.update_scan_mode = adis_update_scan_mode,
+	.debugfs_reg_access = adis_debugfs_reg_access,
 };
 
 static int adis16480_stop_device(struct iio_dev *indio_dev)
-- 
2.23.0

