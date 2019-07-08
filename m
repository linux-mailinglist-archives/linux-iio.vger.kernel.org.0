Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3802E61C51
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2019 11:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbfGHJVa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Jul 2019 05:21:30 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:4176 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725897AbfGHJVa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Jul 2019 05:21:30 -0400
X-Greylist: delayed 379 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Jul 2019 05:21:29 EDT
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x689F7JY007705;
        Mon, 8 Jul 2019 02:15:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfpt1; bh=AUZKTn1XC6qXjy8I4sIbOjGOyVFTcxnR4+9T5FeMF/I=;
 b=dg1vLkrIxwa+10+aCJuQu9HXV4M+9exKCY/lWBGk/8GM5dq3kDzWxn3XVQAWg7o9ooB2
 pXKhWYQsVIME+07fGcAMrWw277fL4t9CNE6az95Q1e+EACPS8ROq6+BmISeY2i0Tp8V2
 eHBYAkTDIynAlzl7CkW2ZA5hnftYsi3CkWbAqSMhQXUtoLQ6uaBM0Ep8Ro6zel//cZVS
 MEeiySfHhVBh+1qcBHVtTdXx86ua9K3roySxosn8N2vrQgdwjXV/41iGm+XmcejpvY6a
 3gGVXuHRLGn2+TXS/dSiJ5+EdASRpzeil+hdWLeSkFZPAAb/uP5wSp8wb7443DrCJXmf BA== 
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2053.outbound.protection.outlook.com [104.47.33.53])
        by mx0b-00328301.pphosted.com with ESMTP id 2tjqkj8wym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 08 Jul 2019 02:15:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector1-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUZKTn1XC6qXjy8I4sIbOjGOyVFTcxnR4+9T5FeMF/I=;
 b=ebbSs89MY1g91RscUDCORpnR+B8v8zapusepg+L7gZc8XDQio4LtV1dUeXgOoacKL0zRaW2ewuM9K+Pxj+pL7G2pFo5gkS1qTlrTkwrvh7yh2fpDtRYEN77+VzgI0Iy+BVPZPPY+y+nfz77Nw0vcjExA/mvJI2/QvbB4CeQwlC0=
Received: from MN2PR12MB3373.namprd12.prod.outlook.com (20.178.242.33) by
 MN2PR12MB3053.namprd12.prod.outlook.com (20.178.241.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Mon, 8 Jul 2019 09:15:05 +0000
Received: from MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::78a3:9bd8:53e2:f112]) by MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::78a3:9bd8:53e2:f112%7]) with mapi id 15.20.2052.020; Mon, 8 Jul 2019
 09:15:05 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Subject: Patch ping?
Thread-Topic: Patch ping?
Thread-Index: AQHVNW1htOz76jybFUm9sclyHSrQ9w==
Date:   Mon, 8 Jul 2019 09:15:04 +0000
Message-ID: <MN2PR12MB337379F97BD39449A32DC2D8C4F60@MN2PR12MB3373.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [77.157.193.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b260fb12-876a-4820-ad79-08d70384c3b8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR12MB3053;
x-ms-traffictypediagnostic: MN2PR12MB3053:
x-microsoft-antispam-prvs: <MN2PR12MB305334DE49B94F118322A790C4F60@MN2PR12MB3053.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 00922518D8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(376002)(346002)(396003)(136003)(366004)(199004)(189003)(486006)(476003)(74316002)(305945005)(7736002)(66066001)(86362001)(102836004)(8936002)(81156014)(81166006)(8676002)(5660300002)(71200400001)(71190400001)(26005)(110136005)(6506007)(186003)(76116006)(91956017)(64756008)(55016002)(66556008)(52536014)(73956011)(14454004)(9686003)(66946007)(558084003)(66476007)(3480700005)(6116002)(478600001)(68736007)(3846002)(316002)(72206003)(2906002)(7696005)(80792005)(33656002)(7116003)(99286004)(66446008)(6436002)(53936002)(25786009)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3053;H:MN2PR12MB3373.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WSMMs1hCa+9erP5zsAl7dAXKFd6QKXc11nuWCawOK8JxLTt5PLGJZLUOSxNPS52LBtLQkZfUzVmIeV+6zN1jvz4VbTzla9NH18ip7ZC1OzPaEjRYDC+m4UbUW+r8MCljlWJe/vxgHNr5fpCz/hSSUvXFFfcDSGwO3OYzq5IngfSswvYRMAp964VywQC5465ILsD4Y54MJlabtmxMZcDor/iR429OR2ZxuEbTiRNedFwn/rFlD15KLNm7Zlk+scqNqbIEgviMTOZ47WndDrCCPAVirqiC5I04oABI8GistiNIT1id6ZRBxNaY09YJGlPbm0OLp5IRTpiTuoAGGWrIJcggemzUv5/UphmKdvXyFx6E6y+yVLtHK9FXZIo2pu1oySdaUQfY4Q5eyQMt/xXaaRHh+JjaXdBUNi9dIe8lmZU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b260fb12-876a-4820-ad79-08d70384c3b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2019 09:15:04.8811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JManeyrol@invensense.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3053
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-07-08_02:2019-07-05,2019-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 bulkscore=0 mlxlogscore=614 lowpriorityscore=0 phishscore=0 spamscore=0
 suspectscore=0 malwarescore=0 impostorscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1904300001
 definitions=main-1907080122
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,=0A=
=0A=
just a ping about my patch to add correct available scan masks to inv_mpu60=
50 driver.=0A=
=0A=
Title is: [PATCH v2] iio: imu: mpu6050: add missing available scan masks=0A=
=0A=
Thanks for your feedback.=0A=
=0A=
Best regards,=0A=
JB=
