Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51D6C15AF03
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2020 18:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbgBLRqh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 Feb 2020 12:46:37 -0500
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:62646 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728753AbgBLRqh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Feb 2020 12:46:37 -0500
X-Greylist: delayed 315 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Feb 2020 12:46:35 EST
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01CHGiKH003685;
        Wed, 12 Feb 2020 09:41:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version; s=pfpt1;
 bh=gXWOuxd2B8E9uMsk/GzmZer2ow1CykdKYklb/lcuF+I=;
 b=nmCsaHg2P0+JfsWRRTfSUYtf/bDwDw/bqjhshpafKUXFhhuC+sZghYaTGicksxmtajRM
 3U0fyT8v+CLnJbWSlOvABx0n61deLPCQULt95DgsoABt5gT4lDjqmfEHlR9Gqh/gtbCl
 ilVf+72yebQygQlBDzNvR8jVfkUKsaOvzYaJhdJeDf6IULudERfPjGECnpBzKH8ZSz/n
 PDwXT5pIsrxYQqbrFz96CGj0CPKsIA1BONTX0SLpomN8VP3aA0ZlGvC6hl1JnpWBC86D
 tzz5nvWmON2Mpej0HfGdacEarw8iDC2KkzGVpJ3jAFSTrrwmpMaTfOZs3tRsyOp7S7f8 Xw== 
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2053.outbound.protection.outlook.com [104.47.44.53])
        by mx0b-00328301.pphosted.com with ESMTP id 2y47mwrcyn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Feb 2020 09:41:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ozs9vE52nX92xKBYXTmOI61ZTIxDWHNZ8xEKoMmQLzAyDAHA/0ykqOHkGZeXPPKdjnds5TJz11C3T+3Re7j9nY6XVj84evYydLKalll1dpAS5thNmYFF/WtTl6qJ+YM13SCx657wHCGZApoMrt04gpqwSnYLS56PO/1yRNpFp5dk/vxegWhDMhqApOwCp0zdAovJ8+IS/ME+SDTyq0DLrtWWcZ4a0fiqrmnCJeH+5q8FBYo5wIstyECB3pisaFLZ5yjkmEmgxMm3xr4NBi9SE7LfLG5D71sogQ+a8PlWOI9qiLf4CHRHQ+/yaVvtypmjzH33DJ7QFlQXCu7T6mBgwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXWOuxd2B8E9uMsk/GzmZer2ow1CykdKYklb/lcuF+I=;
 b=DcNxZ6ANw8Pjtvl1GjNey5Xy0sjMyyWsGYqEsbL0YoteP8VI6laWzgiuACeSFGLPbFxJIf7v8qPsWNjb12w1CtstDuCO5W/UAeaRCG25xEwKRkREXGzUTNto6woEVVoNp8Xl4LGSyEpsDTY7VenITaHtsLD2J9HnjIW8txQehsJARGDa9LwqcL0CZU5pjhiIn8s/DbNdJ4xydpwrkdBMdtsrloDn2/qv99QGZMsyrHexkdNp2OVuCcz2LFOqm/5Bn9AdIsxOVKxhPbljD7/NslM2SjFrTx4I3Gvf/wz+upEyk3mF+PnqD8qIdYAjM/YNwuRZlKk1xyhCOMmYUKeh0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXWOuxd2B8E9uMsk/GzmZer2ow1CykdKYklb/lcuF+I=;
 b=GBqA/iwGX+98puXIhz/LJV6d65kl8tHzOohjYgz6uBpnckyuuaCH5q/M4ZMS2lKbS2IPi7BDDp1+7bUfJWpxpkZNPig2TNQCdvzbeUuk+f6JkZQolsl9xnoi9ECCPyVox7jtTquOo3+azlk+cwmtMrlMedRJ9v1/KuRVE7dNcUw=
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (20.180.6.144) by
 CH2PR12MB4070.namprd12.prod.outlook.com (20.180.16.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Wed, 12 Feb 2020 17:41:16 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340%5]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 17:41:16 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, linux-iio@vger.kernel.org
Cc:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH 00/13] Rework sensors engines and power management
Date:   Wed, 12 Feb 2020 18:40:35 +0100
Message-Id: <20200212174048.1034-1-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0050.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::27) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
Received: from frgnb-12nlpn2.invcorp.invensense.com (77.157.193.39) by BYAPR06CA0050.namprd06.prod.outlook.com (2603:10b6:a03:14b::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.23 via Frontend Transport; Wed, 12 Feb 2020 17:41:14 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b6dbe6a-4541-4c5f-ca49-08d7afe2c286
X-MS-TrafficTypeDiagnostic: CH2PR12MB4070:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB40703DAD88C97C9C50E170D7C41B0@CH2PR12MB4070.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0311124FA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(396003)(39850400004)(346002)(199004)(189003)(6666004)(1076003)(2616005)(81166006)(81156014)(186003)(16526019)(8676002)(956004)(316002)(478600001)(36756003)(86362001)(2906002)(5660300002)(6486002)(26005)(107886003)(66946007)(66476007)(66556008)(8936002)(52116002)(4326008)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR12MB4070;H:CH2PR12MB4181.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ng0ALkmymyeP24G+NONGTJW/hYiaQytw/eXdzTScdS8tegsGGVtkrLWLP4NyC5ZK9zBO+FCKQ8O7FSBIEEVPQkYhYORzMKEIoHZsxgrcZSdmduHL3fgiur5YQ5yx9sPCO9u5V4ZXAaE5MIJpPnrO1jHdB0bqF7A5fGs6tyoivE2hkYQjLN3Fi1EJbXRZStgUcMC6Mpi8Mtik5OeDcRIqpH66EiDZn4CzA8kYGG3ojA8E5moX2szhwLXU7O6Q7llmJMHNoiFXMOcqxNtUvc7TDnZ7SDZMw2oPFnFxcOymrSxE8MVpmLlmNUvlD8U7UL/44mH7avsOHpoof04wrAc4T5y8xjVqou5j9zI1/vmTDWisooxMFtjM3vNncDzU6dYOHix8wtmgXlps7QTVnGRDzn+hhTVx8jhsLzngj9sUPpDviYd30aqn9/LCiSg/Q/i0
X-MS-Exchange-AntiSpam-MessageData: HCrr+dazTJMR5FWnGjQByn60nPFEfk6U2/5Rkyzu0qJOrKREajc5Asxi+NbDzhLOXaULpazat+GRJAe3KiIF5rsHQ2F53IeN/2H0a69eHeez9zHCiNU3KDLkfybyZ6NlXbTdcud74DG8wItpBgI/xg==
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b6dbe6a-4541-4c5f-ca49-08d7afe2c286
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2020 17:41:16.1409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mzvOIlij6R9CBzRPAfIbPYsmuxDRfFTQ0mTQ9eDtL+ecltlXRsN2znUVa/7fqfYxB4a2e4PGbTOeevCYQct6mISxzx6+8CRtmCq/Zq0RYZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4070
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-12_08:2020-02-12,2020-02-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002120130
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The goal of this series is to rework sensors engines and power
management using runtime power with autosuspend. By reducing power
on/off it enables correct usage of the polling interface at low
frequencies. It also simplifies a lot of things inside the driver,
making it much more simpler and easier to read.

The series also include several reworks required to have the
implementation working.

Jean-Baptiste Maneyrol (13):
  iio: imu: inv_mpu6050: enable i2c aux mux bypass only once
  iio: imu: inv_mpu6050: delete useless check
  iio: imu: inv_mpu6050: set power on/off only once during all init
  iio: imu: inv_mpu6050: simplify polling magnetometer
  iio: imu: inv_mpu6050: early init of chip_config for use at setup
  iio: imu: inv_mpu6050: add all signal path resets at init
  iio: imu: inv_mpu6050: fix sleep time when turning regulators on
  iio: imu: inv_mpu6050: rewrite power and engine management
  iio: imu: inv_mpu6050: fix data polling interface
  iio: imu: inv_mpu6050: factorize fifo enable/disable
  iio: imu: inv_mpu6050: dynamic sampling rate change
  iio: imu: inv_mpu6050: use runtime pm with autosuspend
  iio: imu: inv_mpu6050: temperature only work with accel/gyro

 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 560 +++++++++++++-----
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c     |  62 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  38 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c    |  49 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h    |   5 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    |  57 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c     |  10 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 156 ++---
 8 files changed, 568 insertions(+), 369 deletions(-)

-- 
2.17.1

