Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31AE714276D
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jan 2020 10:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgATJht (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jan 2020 04:37:49 -0500
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:44910 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725872AbgATJht (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jan 2020 04:37:49 -0500
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00K9Tq6Q007127;
        Mon, 20 Jan 2020 01:36:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version; s=pfpt1;
 bh=efg4E8sA10U7ZuodkAumcMRsRiBnRXHgE5k0csJHjrY=;
 b=nFNVxvDuwSFy6VhvlAM6a7/6PqAjBrs4Pof57/UM/MHrhbfazD9MmzoVrmrOPPM4wr23
 sRhSLsrk6M8HiXY76H2/qgX4foz+MiVCQZLjK31FDronfqGBLB7KCpLJrmb7JkFyTU3J
 XlD+bnIfRDl6Su7ODR9wYhNFN0F4EZ7OTznI8H7PmhWnyJ8DZiFXg5YjSjpTjzVuOjIJ
 2huMXooe8ugThO7qdPIj2WKADfhqHM3lHbC3XbzZ9fn2eUXUdIb0LK3NjQC542CuC0lV
 qrcYNhSG7r9B6lWMLP7xLK+R1MGrmtIuaUdSADAKyaxqGX1eKeP/2SQAjVcqmaPd5BNr Zg== 
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2057.outbound.protection.outlook.com [104.47.46.57])
        by mx0a-00328301.pphosted.com with ESMTP id 2xm1gqrmsu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jan 2020 01:36:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RxKWlszgpO8UpWnoGnGd5hxVZy1I+1XQFoQcjljaQv+O6d0C7/I+72XbokJ0m9jmxeeTrZnT3/hIBxPSib+iSRF5rVNKCpxFwBgkLwvK8mBtMiyfCuQfSugk4zfDZ4xREdp0r89++oK08ZSdtg7KVvVx/RXmIqJeMRy/dTKwZOsO804NHI6OVGwKkmAopedV1ajfaKiQuRkThmtquX0+muRw/L5ywMU37J0OAvkeJ2MoUmcK+cwOfAf68MEpBFvQVAoKI4FRINGmG0J2yb0dv6OstZpn8enCjMjnL23u7x2w4qxJrHf8hmDMhtZmd1cllteir9Hpb1JO+Nr3gTcsNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efg4E8sA10U7ZuodkAumcMRsRiBnRXHgE5k0csJHjrY=;
 b=lFYxb+ScENoCFMJazxa40+mUzonTmsbmvGMEiNC279vNkvQCiKSxyOntfz7oMJoTdHt1GeKSD/IsblVj+t8Wub97/8hZmkmp26idBq+JkSiHIoCjnocz0bbBteBklu4RrMET24UZtj0Y9ni4hRTkh0cDZGXQuNb48txf6h8yQ63q3YDD0amavK04wCFFgTWKBeyS1Zuwq/O36TcqGuJLEdN3fjHlSPVPjJJBquJJVPaLoMKPR2GzDITlrktJ67gGvplTPHu68uIzjfynKyAKuoy65eWVnQTM+UrSSanK4j0eF7oqE7ecUH/Poywg+qV85MfYYVUEsVvDcuZBxpkjMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efg4E8sA10U7ZuodkAumcMRsRiBnRXHgE5k0csJHjrY=;
 b=NfU0KeQilYBa+/sfUwT7WyX9ioBTXJrioRfORX5NbCCu6EcuHv/7zMIyIHTpqibluFaE3mtudpwxU2TB0LzyrXrJ9j3TvbpH5eJqO63AcB6IT01uDYbxRe6dqp/DDnLttmWc+EFdcrfLMhL4axeCu8XBo7QlzFOnxeDhqAyMEE4=
Received: from MN2PR12MB3373.namprd12.prod.outlook.com (20.178.242.33) by
 MN2PR12MB3183.namprd12.prod.outlook.com (20.179.82.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Mon, 20 Jan 2020 09:36:42 +0000
Received: from MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::4028:892b:b405:59fa]) by MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::4028:892b:b405:59fa%6]) with mapi id 15.20.2644.024; Mon, 20 Jan 2020
 09:36:42 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH 0/9] Add support of similar chips
Date:   Mon, 20 Jan 2020 10:36:11 +0100
Message-Id: <20200120093620.9681-1-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0146.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::14) To MN2PR12MB3373.namprd12.prod.outlook.com
 (2603:10b6:208:c8::33)
MIME-Version: 1.0
Received: from frgnb-12nlpn2.invcorp.invensense.com (77.157.193.39) by LO2P265CA0146.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:9::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend Transport; Mon, 20 Jan 2020 09:36:39 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1bc8355a-a036-42f8-cb5a-08d79d8c41ad
X-MS-TrafficTypeDiagnostic: MN2PR12MB3183:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3183F25A553FE4EF0396B852C4320@MN2PR12MB3183.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 0288CD37D9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39840400004)(396003)(376002)(346002)(136003)(366004)(199004)(189003)(7696005)(52116002)(6666004)(8936002)(478600001)(186003)(16526019)(8676002)(86362001)(2906002)(26005)(316002)(81156014)(81166006)(54906003)(956004)(107886003)(2616005)(6486002)(1076003)(66946007)(36756003)(5660300002)(66556008)(4326008)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3183;H:MN2PR12MB3373.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Obk+NrZjriUXO5BaRypVrZx3UvS91k3lzLkeVDFaE3VgRT5srXKCBfh3Ykg5pgOA9OJ9uqHxikfVrk5jEN8lxUdsJBVYVacdSgSir0j/whJZfkx7l7ftA2YK3Zg1dxdPJEp7zVKnAHYeTBfxefdH3+LwnYNEvSPmbMHYkgOhTQzWyKt/frwI0r9LL/jyCXfA0FZfeiiVpQe5BJX79nl4fxiAg2svEN0Dq7O8e2KpM8Jtt71x+wz5L5MdHD+Zq3j1zELRidF4lKOHMAw2fdVQ+qnLjvYwlc0CT2/PvAU73WcVXCsn6o2pM8iMV44FFM4AwmAih34UtI+KDSvZv+mJDazRaPDRtz4oWKkkFtXlyYVJTAAhV671fJbfIukSF3ZMd5rMdbs/GEKwsaDBbLxKcfeTFMmjuwgI4b4TzTDOIcnfByPcBma9etzYfrJa7+s
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc8355a-a036-42f8-cb5a-08d79d8c41ad
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2020 09:36:42.2913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +zIrsHm6WB50lnt8w70mmmKZ7mcn1zGfTmmUryOxelyHWf6Wr4YC8VaYaC5jTvN8YefRv7hnlsHeUXu8zdj0NA8oxt2GN62RUf/2kUIdp30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3183
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-20_01:2020-01-16,2020-01-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 bulkscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001200083
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This series add support of new chips that are similar to the ones already
supported.

Add correct OF support for spi and modify low-pass filter settings to
support correctly all the chips.

Jean-Baptiste Maneyrol (9):
  dt-bindings: iio: imu: inv_mpu6050: add missing entry for mpu6000
  iio: imu: inv_mpu6050: cleanup spi support
  iio: imu: inv_mpu6050: add support of ICM20609 & ICM20689
  dt-bindings: add description for icm20609 and icm20689
  iio: imu: inv_mpu6050: add support of IAM20680
  dt-bindings: add description for iam20680
  iio: imu: inv_mpu6050: add support of ICM20690
  dt-bindings: add description for icm20690
  iio: imu: inv_mpu6050: fix LPF bandwidth setting

 .../bindings/iio/imu/inv_mpu6050.txt          |   5 +
 drivers/iio/imu/inv_mpu6050/Kconfig           |  12 +--
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 100 ++++++++++++++----
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c     |  23 ++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  20 +++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c     |  55 ++++++++++
 6 files changed, 181 insertions(+), 34 deletions(-)

-- 
2.17.1

