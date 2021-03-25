Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84D723497B9
	for <lists+linux-iio@lfdr.de>; Thu, 25 Mar 2021 18:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbhCYRSO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Mar 2021 13:18:14 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:29446 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229940AbhCYRRv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Mar 2021 13:17:51 -0400
X-Greylist: delayed 507 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Mar 2021 13:17:50 EDT
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12PH8NUt012501;
        Thu, 25 Mar 2021 10:09:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=NO0HjJSlhE+MmaiVA0B0BUtth3uuV0wUqZT1NNIr4UU=;
 b=ZNcuWLZLGIu6R5mbOZAtK58+EDvgBDqpLUGIp+4+8tKoTjEhqH73JaayxN/3FzXTLptP
 4SHcOQXfcR/87elhugYYsHQSdCD613RbexGTr8+Lwqp1+uTuPk4NAsdKnl0fhAVyTlql
 Cqky6z9GlGgtHsYwTs6lkDg51FxC3qYVpmqCRUiQTXCOC818dHuH+WHDKZLhYZWRkH8I
 DxPDoL8OXDW+qOW6XBVZJvTfG12mnIioSeGEi8pjK+LOmiH1a2ejt/+4QwGIoeZxeiK4
 z9WImmOYhzOigdDpy+nEZ1TfnwN2xJFb/8vjbNHFAqOQY7BbCPl196L43bvd16L126n0 IQ== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by mx0b-00328301.pphosted.com with ESMTP id 37dd0nbck5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Mar 2021 10:09:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H4tDQYlB8aKdcbHTXZsnvo+AkadS70dbW3VpTKJxHiohL5nFQg+uDaJqGMAx9E1pYZ+xsC7fu1hAg7V+CeVY9yGUm+nZR3g+7F0UuUu7U3IlXExYkeT5xBQfg1BqPWiID3U54VpDg6uuJBATzYSS1sopdyoKygnO1piq4sQe3pZvQqYM/6pPjQuh6iaa7nQR3bKj6W/2d/ZN5/C7RrkYZwNL2zjpgBban0itCoC3dZDEKxYaClA9L0VpAVdOjMn2objNSQB506mkSjPGWQEAPlYZMaOvhZi/2fzWGUpYY/q3M607E+HJ9r8PCDCpM4IViaRXPPCodcOKewNuDU09Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NO0HjJSlhE+MmaiVA0B0BUtth3uuV0wUqZT1NNIr4UU=;
 b=XZylnlgCsLzC0S/sCfZbYvjLy7WIwQKIVTi9jdp/06UOEw4XFwsz4p+/z5DHdVJpHw5QXbeaHn5Bun954xlR3ROoe3i7vs01fSNNO54kIi1WsZSg8PPE8Hy/jEZtHLaN7CM5mOv1I3Bbh15ZbKTj1ODR3SAgNHZEGc2NPSaYoZlJazu95Y22whEDMUX8YAUme57MYcIu5RVr6YlTTEig1s5Rzl7gnKvvrwAWxJMjWzy6R22XvoboSABm7FL3djUgjULwtIZqzPYPbi0Z6uZi0cihSUeY+5NX/h6LSlyG7kYLKlQx/zfVWt8BH9wX0r4b5dnj3ahaxVOK4B/F0n4QEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NO0HjJSlhE+MmaiVA0B0BUtth3uuV0wUqZT1NNIr4UU=;
 b=Pi+y2F3aYjXtBuPRiaZMpF08yChE1FWEXyesv/3ilTNdkoTLuMUWdFZRkKjF8H/VrDMyBdjMiTdu7OGEEnLIqxGpNiuBLcloGPDWTslwnSedsd6EGnfLf61I5lkYTKgiaK/gIH/GnPRjIbOFH0wH51WfzoMh0cPGo2Qg2T9S2Bg=
Received: from BL0PR12MB5011.namprd12.prod.outlook.com (2603:10b6:208:1c9::17)
 by BL0PR12MB2529.namprd12.prod.outlook.com (2603:10b6:207:4e::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 25 Mar
 2021 17:09:03 +0000
Received: from BL0PR12MB5011.namprd12.prod.outlook.com
 ([fe80::a408:8724:ea62:dd38]) by BL0PR12MB5011.namprd12.prod.outlook.com
 ([fe80::a408:8724:ea62:dd38%4]) with mapi id 15.20.3977.024; Thu, 25 Mar 2021
 17:09:03 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Guoqing chi <chi962464zy@163.com>,
        "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chiguoqing@yulong.com" <chiguoqing@yulong.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH V4] iio:imu:mpu6050: Modify matricies to matrices
Thread-Topic: [PATCH V4] iio:imu:mpu6050: Modify matricies to matrices
Thread-Index: AQHXHrsykrQH3Bkz+0etnLE4HK43+aqU9YJ+
Date:   Thu, 25 Mar 2021 17:09:03 +0000
Message-ID: <BL0PR12MB501163EAE5EA0B022B645044C4629@BL0PR12MB5011.namprd12.prod.outlook.com>
References: <20210322013024.1849-1-chi962464zy@163.com>
In-Reply-To: <20210322013024.1849-1-chi962464zy@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: 163.com; dkim=none (message not signed)
 header.d=none;163.com; dmarc=none action=none header.from=invensense.com;
x-originating-ip: [91.174.78.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8845a5b9-169d-4c40-f8b2-08d8efb0b0fa
x-ms-traffictypediagnostic: BL0PR12MB2529:
x-microsoft-antispam-prvs: <BL0PR12MB252921088EAB37E5C20BD3D0C4629@BL0PR12MB2529.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +lgnC1rDELzEDYiGgTwlJKGuKkQntENHHHLrtswf6Ycmm4bCnNhCS7XfXWBJsW34rTIoeRjqFlQTLCh2dHrMt6YAr0JPVO2wLFi5W6LFpGbLw0edxh3uL2D+8g1RRN92h40/voIzv1p7apR3EUC88OQ47InrhK7vVoGxYidRf7DMjkMzFf2nqaEEHdoXcHwl+x9fpxYWu6p1laEVD1gO8h+CAX1LJMOeWlWwS/E0hD37LhK35Q4Finww1ZB/agVEm6Qn16VOxjYG/27l1cR0KzDxt5eDq1phSgxE1tqcY2pBhzXZfVym503rQXbucbIRYHN+2QmN7cxv2YyarNFBVCm4z2XOHRcsu7QZPx3oAWaTDGZWSbJ7sjgQeFL1177149NE9tvaYhAI9nT/2T9L7M69kqENtAI+lk1NufdYAEePMUyUwno6CMPqhQLhO0RCWowL/o7WQtmtI5kMYyJGBnOTblWrsbuGSOGgUGmPlKXMWSOKuafTDd8a2Chqr8JLj+ohooVmYlvI+UGbANsTs3wdVgNZbnoQ2SpPw+2KXjDquZ7UWBlmaPNDcm4EsNY+c7DqsAJ3BJrKy4GSVMTC7zWk1SjyvWThv0ZZZk0gFif31JCfKzwZsD7eS07Eiux+FmKpInjNCadK0cQ4T4ekFTkV1MrK4T/imOjOS+GuIwA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5011.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39850400004)(396003)(366004)(346002)(376002)(66946007)(9686003)(26005)(66476007)(4326008)(8676002)(76116006)(66446008)(71200400001)(6506007)(86362001)(316002)(66556008)(110136005)(55016002)(54906003)(53546011)(52536014)(38100700001)(186003)(478600001)(91956017)(33656002)(83380400001)(7696005)(5660300002)(8936002)(64756008)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?sPRKIkX+QKm4HtoaXWSSHSfPdt6VrEGfwNUtIRm3okCE6a+hH1hgkfuh7a?=
 =?iso-8859-1?Q?SwmH1n894NPVOGo4+KC7sC0oneRagyXW0utU7HfUXXBnjPqnUUar6TQlg9?=
 =?iso-8859-1?Q?M8Bg4CK5MMdkxAbd+vHToY3U9Nwf2ji+kC3xOFafNdD7aAEmT/ZubkRoK5?=
 =?iso-8859-1?Q?Sxd+I3KPI/IkD9c5+790XMs4s6PgoHFz7gAefYgbr52+8af4gu6d8yVvIg?=
 =?iso-8859-1?Q?M7l3oE4qiH0sv/8UYqsPqNENFYPq7aB/zDpNZSeRcPy2LMiIyphwAI57y3?=
 =?iso-8859-1?Q?rABgNj3MWXZQv5+bS/Sqw7zoL9nxC0pOria534qX79lxUWusBKqMOKAmaC?=
 =?iso-8859-1?Q?JDYq+L/ds3IMeLLDJIJ3khuY/5PWVMOG/bv74MuLbC/ybztQbJjFQeeuZG?=
 =?iso-8859-1?Q?31LtulZWZlv65Et+EQttpaU/Y+YFD2YevISIoRHz/wWUlAuMwnOtoYvHO0?=
 =?iso-8859-1?Q?RckuXfqoI7s+eZdW5Lrc4euZGYEyc5GqJaE3qcnc6c4JipslgaXcUMq05M?=
 =?iso-8859-1?Q?W3wkL5GWpArxa+2n/5fQXh2lb+DiqHgwvxLvrCG9+W3Vhxh4bMrXnpBqjf?=
 =?iso-8859-1?Q?ygAG1C8bqAfbUbCh1iiq0NM9/21BN5kTsLeSuojfGH1R6sguAMT0relDt/?=
 =?iso-8859-1?Q?ogHABYTHBdPl2oEn9JH2rWFvkAwxEeS3rNWnhpvhjBvQR8iOgI5zqiOqw4?=
 =?iso-8859-1?Q?BZXBqKuOhIVHNACYMaKkN9dBT5nA8CwnhEokMkTBOUloWabpQr9IOPyJVz?=
 =?iso-8859-1?Q?bV8dk1tufteoH+xwY61sQxKW8UZm8GKaBKhvUZi2JOqptex84HhBSIHFSh?=
 =?iso-8859-1?Q?QQun08Ha0Uf+BIqF8ZQfSnl8rLS5VXV2mNsGJAdRZ1IShqYKxBgnqQGayZ?=
 =?iso-8859-1?Q?njv/OTFgJE7z8nFZjGVoVA9J+Sw7l7uvFjijgPAsXALBT0jr4Yt7eZOBE4?=
 =?iso-8859-1?Q?XMO2PLW77+KsOhUAmixsdiltv2RFrt71ne77dmpUHDq+qv9w2TLz/SaEak?=
 =?iso-8859-1?Q?bFguM7AfevxKCZ7kA3CpMguOnBhZc3h2GtPnZEvJEpLOdo7BMdRbPp2ffy?=
 =?iso-8859-1?Q?ik0UcbN1BD8VoHReX2Lgy9aHSe6+mt1AA01feM1b+XysNZx25JfkT9Uc1o?=
 =?iso-8859-1?Q?9kDblLxxzO1SP1TEtu40IxmN8h2DfnpF/I1SubfeOuv4pJsZmRSKHryzB4?=
 =?iso-8859-1?Q?PhxCFla+nSHRjlS1rfPNqighjF/iR0DUw+hREeJIINQqxgBQfRASVQsGPJ?=
 =?iso-8859-1?Q?BifjsSfk+HtKUX8Pd+UC6MwKY/R1WJPl9yxzigu+1gobhy3lXGezVgd+85?=
 =?iso-8859-1?Q?HUACTL0IigVwTahbx+lcPFLmFpjnJVGRpjIL0xSGZz8JpgE=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5011.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8845a5b9-169d-4c40-f8b2-08d8efb0b0fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2021 17:09:03.4668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bWVAMsB8iUkRUu/OIS3zo5PSjGbuKwnpA3vKwwFoY6o0xqk2hicjDnCwz44H6GxAIm2xP5G3OZmozU7CmFpYs6/SHnSUnAfBJ0Dy63Q8d5o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2529
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-25_05:2021-03-24,2021-03-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 spamscore=0
 suspectscore=0 adultscore=0 clxscore=1011 bulkscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103250124
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,=0A=
=0A=
thanks for the patch,=0A=
JB=0A=
=0A=
Acked-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>=0A=
=0A=
=0A=
From: Guoqing chi <chi962464zy@163.com>=0A=
Sent: Monday, March 22, 2021 02:30=0A=
To: jic23@kernel.org <jic23@kernel.org>=0A=
Cc: linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; chiguoqing=
@yulong.com <chiguoqing@yulong.com>; rdunlap@infradead.org <rdunlap@infrade=
ad.org>; linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; chi962464zy=
@163.com <chi962464zy@163.com>=0A=
Subject: [PATCH V4] iio:imu:mpu6050: Modify matricies to matrices =0A=
=A0=0A=
=A0CAUTION: This email originated from outside of the organization. Please =
make sure the sender is who they say they are and do not click links or ope=
n attachments unless you recognize the sender and know the content is safe.=
=0A=
=0A=
From: Guoqing Chi <chiguoqing@yulong.com>=0A=
=0A=
The plural of "matrix" is "matrices".=0A=
=0A=
Signed-off-by: Guoqing Chi <chiguoqing@yulong.com>=0A=
Acked-by: Randy Dunlap <rdunlap@infradead.org>=0A=
---=0A=
V4:adding linux-iio@vger.kernel.org.=0A=
=0A=
=A0include/linux/platform_data/invensense_mpu6050.h | 2 +-=0A=
=A01 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/include/linux/platform_data/invensense_mpu6050.h b/include/lin=
ux/platform_data/invensense_mpu6050.h=0A=
index 93974f4cfba1..f05b37521f67 100644=0A=
--- a/include/linux/platform_data/invensense_mpu6050.h=0A=
+++ b/include/linux/platform_data/invensense_mpu6050.h=0A=
@@ -12,7 +12,7 @@=0A=
=A0 *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mounting =
matrix retrieved from device-tree)=0A=
=A0 *=0A=
=A0 * Contains platform specific information on how to configure the MPU605=
0 to=0A=
- * work on this platform.=A0 The orientation matricies are 3x3 rotation ma=
tricies=0A=
+ * work on this platform.=A0 The orientation matrices are 3x3 rotation mat=
rices=0A=
=A0 * that are applied to the data to rotate from the mounting orientation =
to the=0A=
=A0 * platform orientation.=A0 The values must be one of 0, 1, or -1 and ea=
ch row and=0A=
=A0 * column should have exactly 1 non-zero value.=0A=
-- =0A=
2.17.1=0A=
=0A=
