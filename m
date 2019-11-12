Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEBEF903D
	for <lists+linux-iio@lfdr.de>; Tue, 12 Nov 2019 14:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfKLNKk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 Nov 2019 08:10:40 -0500
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:46190 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725919AbfKLNKk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Nov 2019 08:10:40 -0500
X-Greylist: delayed 1003 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Nov 2019 08:10:39 EST
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xACCrdjj015668;
        Tue, 12 Nov 2019 04:53:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfpt1; bh=uBL9hTcany6mc7zUAMvpK03K+wqFuh9c/qZdyTIWAyo=;
 b=qKCK1EaGzbciurXR56pqjXO+yaLW1p0PkSUqlyughdJjULXUl3Vx8LRsG/CDzOVMk/ec
 cDwqg9RazEou41F/OaokXz1LW6IsEbDjvRy7Z9sjp0QCaNFkZVNbkXaiBtiON17mesXY
 3kVr1Ok1cGTt5h4LgHt5LEbAzTglRcE5FssA0DFqr0iWaJJz/EerTkFNypa3QLPRDZVR
 qtPRcChm5Nqeu1cOq9SKoShtZgBhqwV4bPsFQW0eP5yhHa+2KJdwHH7nSlve6ryZEhsI
 GReDAzIY0/ae9MoTOB41GyDbGcitgzLAAimpKtUZERYJf4IyXd3X62ImRt1ykot6rED9 Pg== 
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2055.outbound.protection.outlook.com [104.47.32.55])
        by mx0b-00328301.pphosted.com with ESMTP id 2w5vkhsbdw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Nov 2019 04:53:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QWsIqNNbgfijviSv/HH8gQZxgni+EZ3rWVMDB1ib6xsk7DdoIHEAUB+Yr/CxWTf9A57sJFE8j3MOJqZ7w/VGYeToGqzymUYpdYpwRBMshrbauS7cI3TIozBvG4CMHjd7cEdi6G8dCwHdHhRXVMbvhnCPPTK6hs29kG8qawOUBsh4tqG/wvmMPtZEMe5Z5swlUwb6S9X4ujAjFHSRTbeIzcNjHB+qKwy0e1WIZ+pGWhB34bqNs4buBd1KT99xfi2R7jO9mVMCtc8j3j5CIrMhfPPC+D/8HbZbHjRhs0jU17Z0kRWxmk8far+oKgMgUEW8Bl1rSzEPLuPG3wfvHjJYhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBL9hTcany6mc7zUAMvpK03K+wqFuh9c/qZdyTIWAyo=;
 b=GolViWUWHgd+Rnw0ZR39r52sd47pfWW89TgCEwxoWRKyzu1SwNmReTTXJUgpji6xRufF/NLWEWSXSckN/9NjRAEHMIfjR0Zs/RLCta0oZ8sEp7fHho3hJ7fvvn+n5AyiYIDUaCzDAeeEgY+ycKMvqG3lfgv9JXsBdNe9RM+9+Wxp1pp2woyXLb5juxQ5SVMlnnnN3az66Vf5d3o3DJkc4B2/JlQS4pWzCoMVdCR409HqdpgSM+gYwaD9Hv0XAjcVQA8x3csXhIl4IuQZUPsMZXXUgqh3Pj6hc0M06e046rnRAIUkfZ0nLyUKk72joUV2kjT93wk+jA9usW+FSKy+mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBL9hTcany6mc7zUAMvpK03K+wqFuh9c/qZdyTIWAyo=;
 b=WMhSvrW3vzfhN/vbwVGiWMDjMwEhxs8Mxs1rpzcCUWA9JyM0jEvhSb6DEqH10YBA8Q+ks8ox22dfcsD7QM101pi+wYRgKzxjwwalf63Sl6TH8/yCpV1d/mqPGuMum1sf9Fgdy4E2IoJB11fn2yU0rvTPkXZDD519ZIxjmNOdkXY=
Received: from MN2PR12MB3373.namprd12.prod.outlook.com (20.178.242.33) by
 MN2PR12MB3838.namprd12.prod.outlook.com (10.255.238.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.22; Tue, 12 Nov 2019 12:53:52 +0000
Received: from MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::95a9:35cd:3e40:8ed3]) by MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::95a9:35cd:3e40:8ed3%3]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 12:53:52 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     linux-iio <linux-iio@vger.kernel.org>
Subject: Testing branch lacking fix patch
Thread-Topic: Testing branch lacking fix patch
Thread-Index: AQHVmVgPkiEBWm1uS06NEue1Hdj5EQ==
Date:   Tue, 12 Nov 2019 12:53:52 +0000
Message-ID: <MN2PR12MB3373790C6E13D3FB360B17C6C4770@MN2PR12MB3373.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [77.157.193.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d635ab29-856d-496c-39c1-08d7676f5e95
x-ms-traffictypediagnostic: MN2PR12MB3838:
x-microsoft-antispam-prvs: <MN2PR12MB3838F83D4B716B87C4F07272C4770@MN2PR12MB3838.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39850400004)(136003)(366004)(346002)(376002)(199004)(189003)(40764003)(80792005)(4326008)(91956017)(33656002)(76116006)(66946007)(6436002)(478600001)(55016002)(14454004)(9686003)(476003)(486006)(6916009)(66066001)(7736002)(8936002)(74316002)(316002)(25786009)(305945005)(52536014)(8676002)(81156014)(81166006)(86362001)(26005)(102836004)(5660300002)(6506007)(186003)(7696005)(256004)(71190400001)(4744005)(99286004)(3846002)(6116002)(66476007)(71200400001)(66556008)(64756008)(66446008)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3838;H:MN2PR12MB3373.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0gcIW49A2QLgpcy/OqxGrpMwi5CcS1uNIR2jmsILJDPUMfRUcTtOmRR1v1R/+KC56iZK9nn7EJdrTVYwc17vRMilGIU3D24QlECFNL8camvpB9hFj3wYiNjkSNUO5OG9cRvRPi8bbtQ4hrAiergQMz1+W2MGMO0gH/5Ut6iSc7sgcqOkWwJn0sjFa2YU4GwhELh2aVpe/vZ+0yIfvFvfqHS4zc/9K+qTEMXdQRirqiVTUIQLwH8LuNyWvSyPxbJXqe3C7tSatVK6c/m259PFhvHWXXE02/H37YvyjhcwWo0bw4eyuUIk6GxMvvc7l6SW8c3JtAWsPD5EsJvD7FYKes542FY4AxnCyVMk1jxIDzOed8K5hC5cvJR4rxsahL5bCzC8+aOSgX9LmtR3/mLeADvLROjqYI+oZPfScEyn79tN8stqVjponU9yQ4AUj9BK
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d635ab29-856d-496c-39c1-08d7676f5e95
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 12:53:52.0344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D/LQw/VEdbSt5G2hEng9unje1cDqLDcBoe/nuH9rmK/QxM7RlXUWYjh+j18D74EGHpZguvE9G6ozl1L64gX7XF+PkQX/i55vsIGg5rBF5IY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3838
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-12_03:2019-11-11,2019-11-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=875 spamscore=0
 adultscore=0 clxscore=1015 mlxscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911120115
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,=0A=
=0A=
I am planning to send new patches for the inv_mpu6050 driver, but the actua=
l testing branch is lacking the fix patch present in fixes-togreg branch an=
d already sent upstream: iio: imu: inv_mpu6050: fix no data on MPU6050=0A=
=0A=
The issue is that these new patches require the last development from the t=
esting branch, but also this fix. Is there a plan to merge both of them at =
some point?=0A=
=0A=
Thanks for your help.=0A=
JB=
