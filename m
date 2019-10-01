Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3915C2F3F
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2019 10:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbfJAIuN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Oct 2019 04:50:13 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:34584 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727361AbfJAIuN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Oct 2019 04:50:13 -0400
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x918hPWH025808;
        Tue, 1 Oct 2019 01:50:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfpt1; bh=NQW2iCcUEehtnEhYsT1seS3QdlQ/srfbVnDKlXqWC2M=;
 b=CPhG0XScZUldGX0wvLxxP3WGWm/JYhLtVJs8fVBFWycFPeNx//Yc88WCBMONahdypyu6
 ezEa9VDW3PIDfekicRkagRRKwMelLJRFy/gc7je3vsjH0/j+TDFArTxKOepLwzO6CyKj
 joxSbUuFjcP8EFY3pHQonHJEbZOj660wcTyABkmExKVwmNrPTaLgohQ6Rc8EeJ5/2h64
 P+SVcc9EoxmsfOZ/P5WV2WxNklrOOIpOaXlTe9h9oAicbFg92X0igEr86Q5lKaE+UtWN
 QSnRlLjy103nXFPZtpKssjEY/LSbnyvqzbsOBAzztxCHzpB8MnNPsPfB056UfUTR5/Y9 KA== 
Received: from nam03-by2-obe.outbound.protection.outlook.com (mail-by2nam03lp2052.outbound.protection.outlook.com [104.47.42.52])
        by mx0a-00328301.pphosted.com with ESMTP id 2va30ss782-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 01 Oct 2019 01:50:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tm7zxpVSIJ2rwZBCktfb3bRW4sm9DoZkb5j383b/pH2mPXJwFyb1PtE+UIeMb/La0pBce9JJdEjJFi9QHx+44+ST5aufei61ryY9Fglbup8DCpeDMcUU3mIg7rRXVBRdSCijmUf1QrHQlVmfHQNeWLpKRVqIRp4TaW+P8xH8Z1dLdkDzvoxsHGqghax0C37IJYXvPRmbalJLCNnD+Yc/VZAQ5P3iLZRXbx4jxWNMQ10mwsLMsV0RshcbLp294C456oDLQBhGEmLBC1gi6ErD9G0Zd0qkU03010l25a1pBfj2gcvN55M9FMKhNeOvjejT+g4XL4k2pS2GfyxL6zUfJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQW2iCcUEehtnEhYsT1seS3QdlQ/srfbVnDKlXqWC2M=;
 b=NHo7TasA3LpwKuVe6CKKmK0nnvl+99bVa+1m8uXcQ+AUYg0CohUlTF7NWQImw7O3oZC9o6lQ2wEu+RGUGOwsF6NFw4ro+Eg2EWrQoGGAyuqpCE+VkCEbcN/3lK3GXK0dnsQtyNHMyhbG9Al7LudEGbd7sNobSLy2TpLoUyaFzH/iimYj0Rjp5A3iIaJdMud872RD3cTf4aEcr3QgTnqy6NOsUcmSR1CbdYQoWdk+vRM0LgJZby8K3bF7nVrqMEiHyDREePihYn0gHEE+1XOClCcyZ6MqzzKvjPuuHLfHDpTnYmtylGVGcTck2xTUSu+jM8srTdyQEV2dfUWjNqWB2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQW2iCcUEehtnEhYsT1seS3QdlQ/srfbVnDKlXqWC2M=;
 b=BrIkz/3Aq3a/RZMoAQzRLTqsBpj08nyCOZNerMer74Pb0iS2EgEho14lPL4eMPfya7yY+vHT7qOJ2WN7niLiONWm86y90jRr8TnbPc4+8W3MRNR6kCb8YCEYtt6kvHlDEHN5LU3yUrCmdjCW8OhuS9hefxII5Sqze7SKcsKtR3U=
Received: from MN2PR12MB3373.namprd12.prod.outlook.com (20.178.242.33) by
 MN2PR12MB2912.namprd12.prod.outlook.com (20.179.81.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Tue, 1 Oct 2019 08:50:09 +0000
Received: from MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::6848:adab:f1a6:ed5c]) by MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::6848:adab:f1a6:ed5c%7]) with mapi id 15.20.2305.017; Tue, 1 Oct 2019
 08:50:09 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     linux-iio <linux-iio@vger.kernel.org>
Subject: Patch ping
Thread-Topic: Patch ping
Thread-Index: AQHVeDUTg5oFYUhVW0O3As1gX6W+wA==
Date:   Tue, 1 Oct 2019 08:50:08 +0000
Message-ID: <MN2PR12MB337384FCC2C028F7384978E2C49D0@MN2PR12MB3373.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [77.157.193.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 943299e4-0a1e-497c-17f9-08d7464c5d29
x-ms-traffictypediagnostic: MN2PR12MB2912:
x-microsoft-antispam-prvs: <MN2PR12MB2912111EAEDABA05EED8D199C49D0@MN2PR12MB2912.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 0177904E6B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(346002)(376002)(39850400004)(396003)(199004)(189003)(186003)(81156014)(33656002)(8676002)(80792005)(86362001)(476003)(8936002)(7696005)(2906002)(221733001)(99286004)(81166006)(486006)(256004)(7116003)(102836004)(66066001)(26005)(14454004)(6506007)(76116006)(91956017)(9686003)(6436002)(305945005)(3480700005)(25786009)(558084003)(5660300002)(74316002)(55016002)(6916009)(66476007)(66446008)(66946007)(71190400001)(52536014)(316002)(71200400001)(64756008)(66556008)(478600001)(4326008)(6116002)(3846002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB2912;H:MN2PR12MB3373.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mg/UnGV9O7QhB5O5N41QyKBM1gsv/eLGccIoWbFCMl1mXCvBdKjM05A+G0dqAt4BxHxaktPFbxgeIZFswdww+42Vde7PZkvBuxwTt2mO5FbmRpuqVjca6IUMeOJWwF/auO8ZRlOQGZdhcFZnRRLWXN9d1QnOofBMh+8AJ3tD9GeTrBolkLL3uz2Enaenc7k2brjBhaTzuGkPwPLYw8qRXjhXCoI51lt2cVkNPaoqKIg9ou2afqxVIeoS1BEeP9S2RVQI9lwPbyrD35sutHEHEnLMeWQTVyLfzlOIo++ddZYlXI2lm7C+u1NfQ/VcG2AQu2pz+Sgbss/spSF7zmFiYud4VuGbcFM7DADffrjXIxOqAdAKFBoeMmCCDuP7vEcS79cz8lLxtzh6b/iyBvAynnCNPe/zUQr+SxqZbLiszKA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 943299e4-0a1e-497c-17f9-08d7464c5d29
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2019 08:50:08.9808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oSfBzU0pnvkVi/KZd4Y7EHdts3VovFWlsN+uvH2GxUI9zhQw5v1T3B7K90yDZltOy5h/chY+rFNqNVfY1ZnQ7cbIe4r29UJ2tI/8US4Htp4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2912
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-01_04:2019-10-01,2019-10-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 mlxlogscore=604 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910010083
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Jonathan,=0A=
=0A=
just a kindly remember about my magnetometer support series for inv_mpu6050=
 still waiting for approval and merge.=0A=
=0A=
Thanks.=0A=
=0A=
Best regards,=0A=
JB=
