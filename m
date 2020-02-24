Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 840D816B0FD
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2020 21:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbgBXUdK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Feb 2020 15:33:10 -0500
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:44108 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727168AbgBXUdK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Feb 2020 15:33:10 -0500
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01OKX6A5024223;
        Mon, 24 Feb 2020 12:33:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=Ld5MKbS8hZ8h0TnSWMTcgToJASYZOMYGvGuAaBZdBEs=;
 b=QUok2s4F5bZuOoA6o3YUGDM3TPBnNV5gUxNf0AQE2YIyIGzLWRdryhQ3Libxft9jS9nm
 ATfqNLEVUf5vJhaL/1xl5THTXdi0d6EOSx2cFgyfOIcOFRs3W9qpLhIdFk8MrRNdQxk2
 NTXV/vtpxMOMVIwM9aXg3YnglOIjrRAXA9yRFX4Z7JhHcOiM+yKh1ljpg/jxCwgLQtf8
 zKzg9ah7eMpzqqTgu9+wfhGsRM95DBz+ZmregT71raUVwQhu4srvsbLRKdkN9oLn2vKk
 2PGR7IEa/roKWYeBYlm5DyB6GfNS6KoIZdqFSC3xYlH4ZtBTR+RJRs/vQQhbUT7hgxat Cg== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx0a-00328301.pphosted.com with ESMTP id 2yb0nrrw41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Feb 2020 12:33:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NyOdRJlGuvCY8OmZhs1DF6AHo/1x3N9UNZoSuZOSmP9IUfTR17tR0lvJVb1Ryh3n2A1IxuxW4F4Nb86J/hLq1AquBENpqV9bbMDs5NOnj2j4M8OVYZCCY2hFXn4cij2RagTnWKBaBW8gm84Lrel/7PlgZisoysTaEsZ3vN5TvcYTZmx49b//KDptsVYDP1TSodGDHO3Oo4jx0St6Bqmc73/CM8aV8r4Y4AgSATNRgTcGHrlMP0RouSfq67QZWNFPcdkab3got57TurDrjWkhy0qPFR9LqagDernBXlJecofF1NBcijh6bwO4WPvOwHS1ArjU/6tdJQMjKDo5tkVZZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ld5MKbS8hZ8h0TnSWMTcgToJASYZOMYGvGuAaBZdBEs=;
 b=f+1MgFwv5DATa9ncKNfMBVqpzPiIOshHn4iQHqNMR+a+riXX1gPJfLrbVgRU+aKsxgeiQFCUtInvn7Pq+kucLt75qLNodz62sCBykLhiOK6uKaXqDPf2GOWBFrb3Hp0xRHp1CeQLetYsmmeTeLolhi/JEAxhnfOQFU48XgIVcbJo3I7vgtCr/NOBbWeuM8FzrQcqL/N3ExZWMsbk/fYZSUzfpf36cERr2Gmbyuzmmqjm/uvIptUSBuGXmrcr/COk53ePcdtOdw5knZovNA4lqL3Sm7wnACYnQ6UltR8sFcZMp0KjLwdtPgLipHJY1vPiO0wjG5n/KAf96W8qXdu5dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ld5MKbS8hZ8h0TnSWMTcgToJASYZOMYGvGuAaBZdBEs=;
 b=dqfIipmDxXGseL48Vy3QVDtTPFni3RC96OS8jHxTTVQS2icnQ5gdxUfdU9DmW/vM1OChzJHqcpS403boWPaWwr4kS7Qh6F+HlH2RPYoFGTnhYmnCz9DzKyo3JyAWUhE4gmvS8BxpSudr2950gg6OfhQxj2u/qOXmp+6tepR5JyE=
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 by CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17; Mon, 24 Feb
 2020 20:33:02 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340%5]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 20:33:02 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Rohit Sarkar <rohitsarkar5398@gmail.com>,
        "dragos.bogdan@analog.com" <dragos.bogdan@analog.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jic123@kernel.org" <jic123@kernel.org>
Subject: Re: GSOC 2020 with IIO
Thread-Topic: GSOC 2020 with IIO
Thread-Index: AQHV6K7676Ye0/MCjECnUd9RWMy8hKgqz7Y8
Date:   Mon, 24 Feb 2020 20:33:02 +0000
Message-ID: <CH2PR12MB418155EF17E449E7EF2FDC92C4EC0@CH2PR12MB4181.namprd12.prod.outlook.com>
References: <20200221120335.GA4296@SARKAR>
In-Reply-To: <20200221120335.GA4296@SARKAR>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2a01:e0a:393:a700:bdf5:2891:5afb:8b26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd1096f1-9573-4856-6e58-08d7b968bebd
x-ms-traffictypediagnostic: CH2PR12MB3895:
x-microsoft-antispam-prvs: <CH2PR12MB389501A06ADBD76A8CCCF417C4EC0@CH2PR12MB3895.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 032334F434
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39850400004)(366004)(136003)(346002)(199004)(189003)(54906003)(2906002)(7116003)(33656002)(52536014)(5660300002)(71200400001)(7696005)(55016002)(110136005)(316002)(9686003)(966005)(186003)(4326008)(478600001)(81156014)(53546011)(81166006)(6506007)(8936002)(66446008)(64756008)(91956017)(66946007)(66476007)(76116006)(8676002)(86362001)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR12MB3895;H:CH2PR12MB4181.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jzWfqyUhuvVS0Q20j9cA91nxkY1S5Btp5Knyc/nkk0C3O8Oub7PcmpPjcpXlSk+Y5hnI4m16fyaRflO0EFUmHcehwWmzU52bFTSHl0er6mt6A1RAwe8dlo9Car4bFy6DYKAFifvM8GUMZWZDCwEz/WhaktmPfLJa0IGUCu+8AuAcNF5PcuSYnS0LCKuAXG/P9FE4r+/kgbgxE3ddzh3wIveG4vcg5nWrFg2Bc4UgZTTYPamc8uUWAOWlQeAvsPM4NsMn+fys6KRXc4YfAtdn+mRiAWeBfUHhRnwvoOw9MrrP0yjtUpvcmC0qYvoNz8qHU6n70Z+eQxd71HbjJG5vjqBcdwFABfUgl5HkbI0AoffbhBANJxmNArMT5KTC+lX3qIkdJOA06EZhR/wz+Nt4Doe2npk9YS3KH4Bk6rBCxnAWE36eHUGZ/I66CLiG9X8J3h/JMQy0yYCAj4Ne5C5EKMkcLE+E5A1oclJce2CqcdxF/NUxRIkqoAhjN7R/pfzkmykZDLv3o0hYtpC/2FO5ZQ==
x-ms-exchange-antispam-messagedata: VtMVMHlALeQzosa8sGq8Ul4pepajCpKDhlCeDYOEQHTbmfJhqgDYQlXL+WRqGNWpfzN3Nal6T5YhAi0T6gCaqnXRJW5w3y2a3vpvof16tJdBIAFF2hPfpmbg7VUTUjX1UtubFo8UgttA6euBnHQshErqslUt6/r/jbDC2bZr9AxoYXbNipyIvlcMVtuKFAAKD+QsLgG3RT5AGaMMD0vfSA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd1096f1-9573-4856-6e58-08d7b968bebd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2020 20:33:02.2812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PWjA+Dhpj0yWxJ+ixF79dgSklEXn9KreAEFf+FpPFkQxdRdfSHrV15dvUozazdt+nt6iAQ5OJyCaU0h6/1ahmSoZ9hg6+ufkC0OZlPrTFS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3895
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-24_10:2020-02-21,2020-02-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 clxscore=1011 impostorscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240150
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Rohit,=0A=
=0A=
if you are interested to work on the MPU6050 linux driver (drivers/iio/imu/=
inv_mpu6050), there are still some cleanup work to do there.=0A=
I have been doing major reworks lastly on this old driver. It is now much m=
ore up to date.=0A=
=0A=
But there are still a few interesting things missing.=0A=
I see the following tasks:=0A=
* debugfs register read interface=0A=
* use of update_scan_mask callback instead of messing directly with iio int=
ernals=0A=
* use the available callback instead of hardcoded attributes (like for scal=
e available)=0A=
* fix for reading/setting calibbias data that should be broken on newer chi=
ps=0A=
* support of hardware FIFO for newer chips (icm20602/icm20690)=0A=
=0A=
If you are interested, you can send the patches on the list and I will revi=
ew them.=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
=0A=
From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org> on =
behalf of Rohit Sarkar <rohitsarkar5398@gmail.com>=0A=
=0A=
Sent: Friday, February 21, 2020 13:03=0A=
=0A=
To: dragos.bogdan@analog.com <dragos.bogdan@analog.com>=0A=
=0A=
Cc: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; jic123@kernel.or=
g <jic123@kernel.org>=0A=
=0A=
Subject: GSOC 2020 with IIO=0A=
=0A=
=A0=0A=
=0A=
=0A=
=A0CAUTION: This email originated from outside of the organization. Please =
make sure the sender is who they say they are and do not click links or ope=
n attachments unless you recognize the sender and know the content is safe.=
=0A=
=0A=
=0A=
=0A=
Hey IIO!,=0A=
=0A=
I am interested in working on the IIO subsystem for GSOC.=0A=
=0A=
I have always been keen on writing code for the linux kernel.=0A=
=0A=
=0A=
=0A=
Here are the reasons I think I would be a good fit for this task:=0A=
=0A=
- I was part of a Satellite team in my college as a member of the =0A=
=0A=
Onboard Data Handling Subsystem (ODHS) We worked on various=0A=
=0A=
microcontrollers like MSP430, STM32F2/F4 and sensors: MPU6050, HMC583.=0A=
=0A=
- I have contributed a few small patches to the linux kernel and am=0A=
=0A=
=A0 familiar with the development cycle.[1],[2] and [3] =0A=
=0A=
- I am currently working on the Eudyptula challenge as a hobby and am=0A=
=0A=
=A0 halfway through it.=0A=
=0A=
=0A=
=0A=
I would love to help with any tasks in the subsystem in the meantime.=0A=
=0A=
=0A=
=0A=
Thanks,=0A=
=0A=
Rohit=0A=
=0A=
=0A=
=0A=
[1] : =0A=
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__marc.info_-3Fl-3Dlin=
ux-2Dkernel-26m-3D154152860128914-26w-3D2&d=3DDwIBAg&c=3DWoJWtq5JV8YrKnzRxv=
D8NxmTP_1wxfE0prPmo0NeZwg&r=3D4jiDX_1brsSWfCjfA6Ovj1d4h9MF8q7Xk5aBwG28mVk&m=
=3Dlo7N4Dk6_HJZ3G8RNTdUrTrpLkei992088mdt_iSu3I&s=3DRJfjgZT_DRuKqKth-XoniKZZ=
tqi2XsD2iVeifDNT8jE&e=3D=A0=0A=
 and =0A=
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__marc.info_-3Fl-3Dlin=
ux-2Ddriver-2Ddevel-26m-3D156768975515975-26w-3D2&d=3DDwIBAg&c=3DWoJWtq5JV8=
YrKnzRxvD8NxmTP_1wxfE0prPmo0NeZwg&r=3D4jiDX_1brsSWfCjfA6Ovj1d4h9MF8q7Xk5aBw=
G28mVk&m=3Dlo7N4Dk6_HJZ3G8RNTdUrTrpLkei992088mdt_iSu3I&s=3Dfp1ZR0dpPfiTxJnW=
WMR1jV70OPJMrjYPeigDS3fsbfs&e=3D=0A=
=0A=
=0A=
[2] : =0A=
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__marc.info_-3Fl-3Dlin=
ux-2Dkernel-26m-3D154158381210936-26w-3D2&d=3DDwIBAg&c=3DWoJWtq5JV8YrKnzRxv=
D8NxmTP_1wxfE0prPmo0NeZwg&r=3D4jiDX_1brsSWfCjfA6Ovj1d4h9MF8q7Xk5aBwG28mVk&m=
=3Dlo7N4Dk6_HJZ3G8RNTdUrTrpLkei992088mdt_iSu3I&s=3Dl1MHuKvJL8paRsMgpq96S_fK=
OhZv27pr9QRlk-EIB1U&e=3D=0A=
=0A=
=0A=
[3] : =0A=
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__www.spinics.net_list=
s_linux-2Ddriver-2Ddevel_msg128998.html&d=3DDwIBAg&c=3DWoJWtq5JV8YrKnzRxvD8=
NxmTP_1wxfE0prPmo0NeZwg&r=3D4jiDX_1brsSWfCjfA6Ovj1d4h9MF8q7Xk5aBwG28mVk&m=
=3Dlo7N4Dk6_HJZ3G8RNTdUrTrpLkei992088mdt_iSu3I&s=3DzJ23-Sm9_UNl9vKceTRBR1HC=
QEiPdESzk4acRttAVCo&e=3D=0A=
=0A=
=0A=
