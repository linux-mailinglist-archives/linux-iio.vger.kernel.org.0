Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 452AC162A3A
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2020 17:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgBRQSC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Feb 2020 11:18:02 -0500
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:1638 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726422AbgBRQSC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 Feb 2020 11:18:02 -0500
X-Greylist: delayed 1110 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Feb 2020 11:18:01 EST
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01IFxUkQ002156
        for <linux-iio@vger.kernel.org>; Tue, 18 Feb 2020 07:59:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfpt1; bh=9CsFrb3NmEiJa8X5v6z9F2eBJsXTn5FzApD8DjM7LTA=;
 b=xQ++QJ5p8AiBjAZ518qZLMI7p2LI1KGTdLumK/RDTunCg7Sdj6EryqyYkuWO/VsoY2CT
 elrr17yHLbTrzG7ECp+xd2JuxtMy3S30ydah+juByH+G42/eBtsxScOREa6e1IqBuu24
 oniUwbENYFiGj2iIfiG0Ns176cUW7asioI8ZN7CEyOAbOzE9fy+cYqvQiGDYl48FbGhE
 WCHEp2iTM4WzxR2d21gjGXmMRscUWc+5i+FYpordgB3NNCf/1sbX0OlLC6/oWiZmfGPh
 Y4v78gWj9LpZGPL911wL+EHWoB+3IvXrnP/G2P6Mk2QETcESDbsjAStI6Z21C7aT2+My TQ== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by mx0b-00328301.pphosted.com with ESMTP id 2y6dfss8d9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-iio@vger.kernel.org>; Tue, 18 Feb 2020 07:59:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ECVOKwCepFaG3je+0AmD1vkDV92lohYS/uDuweS8TiF9numg2LJWmUOjqjp8dBCapAG+1/iZ7mQGs/Zr8v5qjBYAvBkec1FYzvxB8cV4xeO8sUuQfnS/RjJwrnneKr4DEr0dwwTWiYDnFDHGa8VYbH5+Vml+NnWn98epsFi5cF2xZJ73rMD2in6rT15yGZhRkVwlz+ymo1ut5PdiDlqHJ21Y0a1+FSXa6FgGIOyB5NUMSkttQyv6wjqCiS57f5p2+b9lQd/sz/5Pv0HJa9XUpTKz6xyAzYMUpq+COh07j8jqWHfSCcV4cp4gc370VAKCRdSkoLJtbXLx7swGNC2S7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9CsFrb3NmEiJa8X5v6z9F2eBJsXTn5FzApD8DjM7LTA=;
 b=Nlk15ekii0iJ0PQ+HG4oOQCaBBNJYATF0N1KrEWwKSazw3xkFFR8bD/1JKv4db1FOYr/x8Qq2XYqmaiI+/ftpmxzRIeDoYlmuPeQmeCt4td2+vscgJ04ua20Zm1wwkKSECpiIxmL1Q42Pu/XHmCqi68eM0enamFPK6fBQtJbcWx6yw52xVIvBABrw0TJewzVw9eB3oA7Dj9TRx/ZjXcpXFgnbhCecWiLVq2n1mKTyuFQ79k8cdZ5+tEtuiK8ehV5qiaxCdRoPdr7sH4IUU2k69bjKa0JLRS5uItnv5+Rv5lPOXrUFsdOH0I4j80shoGfFaBM1iCJyxyb5tQa3ePXgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9CsFrb3NmEiJa8X5v6z9F2eBJsXTn5FzApD8DjM7LTA=;
 b=H/4dYbPx5RdcscO5PxR+G7kZDR7HCmWQ7aHL7d5AOxVHIaskGgV9iExOSjbEaQayNSU4+TDNW5zd41pmwVTLb4hLftrJuoV0K9hw3Rhq6oD3heQWbI58KBe0v3o6BCRqfzuGyW3KrhGXJYuhNI9f3MVHNQYMbfG/VSV8g8EMBoo=
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (20.180.6.144) by
 CH2PR12MB4055.namprd12.prod.outlook.com (20.180.16.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Tue, 18 Feb 2020 15:59:26 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340%5]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 15:59:26 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     linux-iio <linux-iio@vger.kernel.org>
Subject: Question about pressure sensor driver data processing
Thread-Topic: Question about pressure sensor driver data processing
Thread-Index: AQHV5nRAH9e9vCtKIkulKysIFzksHQ==
Date:   Tue, 18 Feb 2020 15:59:26 +0000
Message-ID: <CH2PR12MB4181730FBF2DAE98E17ADBA9C4110@CH2PR12MB4181.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [77.157.193.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d99e43e7-6d86-4727-32a3-08d7b48b876e
x-ms-traffictypediagnostic: CH2PR12MB4055:
x-microsoft-antispam-prvs: <CH2PR12MB4055881E30D8CD95BF19557AC4110@CH2PR12MB4055.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 031763BCAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(39850400004)(346002)(376002)(199004)(189003)(71200400001)(186003)(66446008)(66946007)(52536014)(5660300002)(64756008)(86362001)(316002)(66476007)(76116006)(91956017)(478600001)(66556008)(81156014)(8676002)(4744005)(8936002)(9686003)(55016002)(26005)(2906002)(6506007)(6916009)(33656002)(7696005)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR12MB4055;H:CH2PR12MB4181.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iKwOlDWSwLhzUAKEdrCG5tf7ujqHyKmNwrdAJ1ppljCYDdK+OFXi8a4poGNVBX9tM7ofpVizCq0mBIccZP8aoh3CkiYNECCSy0Zpb8rxyb6wk//gEJzmP+dL+UcJK1VjYmskMoOhOPSeGiPH1aQ+Rp5PsYTKepWDv4dicWwz844ioKhUIfDwWMrAeaR7PZGLxwfXz6BbPhWX6v83VLzi9TpNkyJeBwQIzYDjKvTQh1LS/ZQw70XbuNMSF5DFMhR490L/bNRcw1BT/5Xhfb6pt+1RCRX1BRfZaqzpUvixpQZMytqnH8JDROYA5T2I+oIC2qskzOa1ZFstDb68fRCr07UVVpomT1h8yo6uqCme1K5XJiqF/xNal2PEJoNUiWxeSgS/Hzbzqqmj6DXzMXi1gwYntT7X+WFRrTEZMqt+LHhfjV7L4VthHSMcX4yng0Du
x-ms-exchange-antispam-messagedata: LC5+sgOvIzrl7VD36WlpCrjiQ02Eir5dXcipTL5fxKrZRww3zfNbWbYkJwJDXsQJ7joOvNMR5RhxzjLafXakl76oKbmqv6Kevb3BWXpDZL/ZKYv7ctVknsXHHf2PAj2Vjq/xCyzaWCwJDcx3fkGQHQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d99e43e7-6d86-4727-32a3-08d7b48b876e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2020 15:59:26.0241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J2/vzUtb2AK2fgQPoPmTo556/3m6eWGVUlA62sA+A6aUFS09qxwjZlNvitGLEPI6++fWfyPLvEa62p3Hnwe5q6CTrnYif68ISF+rZqr6ykQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4055
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-18_04:2020-02-18,2020-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0
 suspectscore=0 clxscore=1031 adultscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002180120
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,=0A=
=0A=
I have a question concerning a pressure sensor driver I am currently writin=
g.=0A=
=0A=
The formula to get the real pressure in Pa for this sensor is quite complex=
. It depends on the measured temperature and would be far better done in fl=
oats rather than in integers.=0A=
=0A=
The formula is too complex to be expressed with only scale and offset facto=
rs. And the factors are not fixed since it depends on the temperature.=0A=
=0A=
Would it be acceptable to have a driver than returns the raw data without p=
rocessing? Meaning data that have no unit and require a processing done in =
userspace? That would be much more efficient for sure, but it would not out=
put really useful data without the processing.=0A=
=0A=
Or a driver that return an input processed data and a raw data that have no=
 unit and requires the processing? If we can return raw data, we should be =
able also to add buffer/trigger support to the driver. Otherwise that would=
 be quite tricky to return the processed data in the buffer.=0A=
=0A=
Thanks for your feedback.=0A=
JB=
