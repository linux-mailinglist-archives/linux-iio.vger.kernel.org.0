Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C905203B29
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jun 2020 17:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbgFVPiq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Jun 2020 11:38:46 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:44290 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729683AbgFVPiM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Jun 2020 11:38:12 -0400
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05MFWuqh005880;
        Mon, 22 Jun 2020 08:38:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=ts7RgAAzhzPOnSMR0uB3yQL4tELJfE/5U3WAV+hW0JY=;
 b=GtCRx8Fk+QVCBEdqXTCy/7v6I050brwq8fTdr6tv09q59hq3jxi7NV+Ul6RTTlDN8RwM
 CL3GVN+vngVlpOscc9BrYswZ+c6DZaZ+9fG2vH+Rf6c+HUBSpSb7qDR8yrEN+B01vwVk
 ZpISumDrHvRTEuBuke2Tw2YfCIQDEmmUiBQqwERvr0G+Bo/UYpr9G6I5spd6aGYrhBTY
 yw8H1Qo71xhKtqFT2TFzxdqmM7q0sPaw+j1bRIdPllGZqgrp9bvLNKZlF84Md368wBHI
 Bb6P1HrjDoz/8Nv7L9aFC4QseJ+0YlgWMTcwRo4SWWbWdmlc6JDgnjM78ahxJho5Pzeb hg== 
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2058.outbound.protection.outlook.com [104.47.44.58])
        by mx0b-00328301.pphosted.com with ESMTP id 31sedp0ukn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Jun 2020 08:38:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPSiXkrZdwu+e8NvvbT4wEzKniLPwvzxZnv6lZyps3QX3sb5RV4l2Gtaq0ynTuIDKSUtp1hO6c5i+Lrn6wVETdt8lif+GEXzf80XCj1fCphBs36ID4GlH82bO+Jf5+H5S/7ICHt+xD3mL4quENmd2imwzSUdTcHjVhrVDWOAUN908PzUabZgyyltLeFTdU9Q6lp7mAeRmMK1T1TXY5GJ1mAEPOqS06HvVKmILdTeC6xF6znBQk6IIrmtKm/MxrLGQMwPdburamFXHir7QGpWkv4JmXO4uBtmAmewxay2tqfKjAcezyBwtYablnu4xrNoT40za7iGEbBdecnF1Pwc8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ts7RgAAzhzPOnSMR0uB3yQL4tELJfE/5U3WAV+hW0JY=;
 b=jVBWf9Oiw1GH3ICG9gDVnwm251xAhvq7hP3jx0cmutRWY1slUTMvXC+JUrb7j0I0wfnU3bm+V4MqABjbpK861Lhdptdf6A2n14H+b6ogx0Dw6g4kinyAWQnnBx2EdfCf9paQJ+yUNmZiiiOqPyAOlxwQiJkbX/OWePStmNZEC3hMP0FpVbxkkqEx/I443CHF79zBhWcDnQC2miV43grqXDet6+vq6Yf5O/AQL8vHHOuIRqny9LkC7DqPoibAutRg/97uApZbQRsYLSiPlVl1iY+7Y4wSZWGd1bJOl/qGB8UKvv6aOCM80kjiz5vf1l+QgFBQZB+wVaEK+/2DdRmnPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ts7RgAAzhzPOnSMR0uB3yQL4tELJfE/5U3WAV+hW0JY=;
 b=cJGkFAPlG7rusPOON8jF9329r3umQ1ak3/U8W0YCEIqB3WCRR0XOmE4278Xs5tebC7xDYjnbt9LMAr63NTbaUh+8+X6GOk6HStgN4KghyqTFKLgVis1P5fz5zZToVDWG4gOwOVQpLZ9Kp2piykvBCC7iLtB12adnetp0N5/KN9I=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB4501.namprd12.prod.outlook.com (2603:10b6:208:269::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Mon, 22 Jun
 2020 15:38:07 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0%7]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 15:38:07 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, robh+dt@kernel.org, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v4 08/13] Documentation: ABI: add specific icm42600 documentation
Date:   Mon, 22 Jun 2020 17:37:24 +0200
Message-Id: <20200622153729.12702-9-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200622153729.12702-1-jmaneyrol@invensense.com>
References: <20200622153729.12702-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0054.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::18) To MN2PR12MB4422.namprd12.prod.outlook.com
 (2603:10b6:208:265::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-buildozer.invcorp.invensense.com (77.157.193.39) by LO2P265CA0054.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:60::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21 via Frontend Transport; Mon, 22 Jun 2020 15:38:06 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f84b97b-0e19-43e0-9465-08d816c242c8
X-MS-TrafficTypeDiagnostic: MN2PR12MB4501:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB45015E1D3086198801133DB9C4970@MN2PR12MB4501.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:337;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hO2pA6KSqcnvPC8SVx1Urx3Mt3cIqf3IEsANz5BLt0I9vPZb1aOxPpge/aIvIqiOBvFUcdVgJpDGtlenm5vJiaZHOEP4p76q8di87NUbmsiI0z5BZ7wxzwxXqdSNCUDJEW2+CszD9/eCMJ9eA/1a+OFtIYwlO2SJmhFcPhCUF+Md1kmZvvVjHNAV7qscnkNKizNyPWk/Kq4J941pWPYT5EEcLsz7XTNGleNJt+yoQ6HSmxS4we/mIgHOA7Wl/CLh84+8QbaP2U48f93IwQaJJ9GBmkqaBpDUy9l58YeWLs9UjbYkWHRAAls+DBY4v94sN1f7u1pyT5U35/r/OkRrcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(39850400004)(136003)(366004)(396003)(4326008)(66946007)(7696005)(52116002)(8676002)(66476007)(66556008)(956004)(2616005)(1076003)(107886003)(86362001)(36756003)(478600001)(6486002)(6666004)(19627235002)(26005)(316002)(8936002)(16526019)(5660300002)(2906002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: YBMRXrfqqh2G0yQGO8eKr5V0LrCYIPUeiguZIxfFy+nzJmLCfqdsR+4dYF7Gl2sMzp6drF/FKTRUJRdSZoesiZNjmdk+EAQ2AxGA66yZJ4W/t9zCqkYhVwYkiozFd5gs/UP5EZDwugLOJoacYGCdvA4GjddMn0ezrJYEPqK2ZcEP+j7IODP+0eGFtb+y+6HjwmsVikuPLKsDvGe0HPZUK3qg8Q4RnfC2QsNg/32unU9SUmNK11pcp1J/TpioMkVir+11jpSS9WX5XaSXO9Vugg1mALo52dmvHX5HeVQSt2+XHHBrG51mLPTMJiErTf5ZdVzo3qjkVQ729D+fGnJxTV0UqI2ja/RdUI/6yasEl01YgHHVr+qg0e5DYPVMWgqqnFyO4pg0rNs2UkYXr2cAi0rIIRv5bonLTLIVWw8fE56IOEZVIF8omrvXL0DIp1Y29vNjLVOO2orOKWVXC/2Wb3jQfLFg1epCSf0iUFRVdRs=
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f84b97b-0e19-43e0-9465-08d816c242c8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 15:38:07.4615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aK6DMhVCcGkXZvUNU8AtMbJcBJXY13zQk3Ru2kUbNpqWQDnkWW7bUO7d0R6sjS5ti9tPWb43SWVcSl0Z4bqd1RmP94K+dWZLkATS+uoF19w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4501
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-22_09:2020-06-22,2020-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 spamscore=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 cotscore=-2147483648
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006220116
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hardware offset available as calibscale sysfs attributes are real
physical values exprimed in SI units.

calibscale_available sysfs attributes represents the range of
acceptable values.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 .../ABI/testing/sysfs-bus-iio-icm42600        | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-icm42600

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-icm42600 b/Documentation/ABI/testing/sysfs-bus-iio-icm42600
new file mode 100644
index 000000000000..0bf1fd4f5bf1
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-icm42600
@@ -0,0 +1,20 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_x_calibbias
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_y_calibbias
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_z_calibbias
+What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_x_calibbias
+What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_y_calibbias
+What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_z_calibbias
+KernelVersion:  5.8
+Contact:        linux-iio@vger.kernel.org
+Description:
+		Hardware applied calibration offset (assumed to fix production
+		inaccuracies). Values represent a real physical offset expressed
+		in SI units (m/s^2 for accelerometer and rad/s for gyroscope).
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_calibbias_available
+What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_calibbias_available
+KernelVersion:  5.8
+Contact:        linux-iio@vger.kernel.org
+Description:
+		Range of available values for hardware offset. Values in SI
+		units (m/s^2 for accelerometer and rad/s for gyroscope).
-- 
2.17.1

