Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A12722F5D
	for <lists+linux-iio@lfdr.de>; Mon,  5 Jun 2023 21:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234966AbjFETKO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Jun 2023 15:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234995AbjFETKN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Jun 2023 15:10:13 -0400
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFECA10A
        for <linux-iio@vger.kernel.org>; Mon,  5 Jun 2023 12:10:10 -0700 (PDT)
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
        by mx0b-00549402.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3559F2w6002165;
        Mon, 5 Jun 2023 19:09:55 GMT
Received: from deu01-be0-obe.outbound.protection.outlook.com (mail-be0deu01lp2172.outbound.protection.outlook.com [104.47.7.172])
        by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3qyuvwsdwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jun 2023 19:09:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8fvkcs1hhw0K5XEB92ipHhXUuGGTZESWSErCg8FBJUqcUaYAe+ExEb8cj0kqGZkkhur3u5xPesrFyksRKNcfPDcQLnSFM/OcT9sMeUeVgWKG8GzdrQ4jn8rpClAYbIQRKaxrmfk8cRp2ly+k2xybI6YHMgR4X/DSQ1j/4NEBJYNtqr5aITGYjcurjpYHgqWPNYqiy24WYE5IK65feO+dUCkE0xoJBwsDaPUT2I+KRZfkK5qBD6+MuZ7blm+9gCrOUkbhfy5E3HF3IUMEsgoxZV+Iw46vjYxw45ZOIqaiHcxxQadccIslOw0LoAqWDkKawMsfq4pW5V0Nw70IijD3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qh09tqxrDiAcSVjnEcHvMYEayFzEv5/mg80boBMmi08=;
 b=AUOHnMNrkTfY2mQFWn2HJ6I3uQl50zkK0UZ+914MiQCxZHv9ieeyQ8D2SvTIAc+D1E3agKeoS2agOV9w3psTKbY67sHZFSJ4rT8JhB0N+hJimjPsB6QfJDFzJPpgjSlZ5dkfCgx5tNTYW3rSaS34ij8VN67OvEEHjK6Z8GDMdVnIfTvnDLKuyjKHtUFXC4ADOmSziYIyh97Ww6+WxfsRrZ5MAntueUj7X3eV64+9znGplziiksm/DPqnMnPNxpFzLvLR4Di5lytYqnUKpZX+RsQYoFLVmq8VFK7Genqxb1zBxzJ1FTSpUq1L5px0p1n0HKnEDJIPWIPDLqYThG8HnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qh09tqxrDiAcSVjnEcHvMYEayFzEv5/mg80boBMmi08=;
 b=Y0UXFIwASnU4IKy/haDIZtXU4Tvwnds4fxWTsENGLxIutuVNC02kW95RPt4fSBhfuZQEMp0PTnm9FeaVEPy2JxCLBjjvN/4b0z1paunBY2fMrpoZNZtF/vI4L11svUt5ubDwL0KnQ2Bi8+aZ9nvmeOuvwenEDnvg43C9WLTMCiv+Sx790L13j/EOpxP+9AJvpmQbHtQYDLH0icRoLfSEw7OCB267Q803pNsP58YDHJe/wmKZe4R5ea93BqjbFVrRfWIAMePFDz0YMh21feHoLskrsFtITOoXrZ+wuG+bGbNhQsPXhxUWvgdZgiRugfYP4+W3CdvoSZ4FNIDHpR3IJQ==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FRYP281MB0143.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 19:09:51 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::c434:2e16:6b03:478d]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::c434:2e16:6b03:478d%6]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 19:09:51 +0000
From:   Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        INV Git Commit <INV.git-commit@tdk.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH 4/4] iio: imu: inv_mpu6050: use the common inv_sensors
 timestamp module
Thread-Topic: [PATCH 4/4] iio: imu: inv_mpu6050: use the common inv_sensors
 timestamp module
Thread-Index: AQHZk8vOrn3HsTG/70qfydVPTfmWqK96ghoAgAIYVIM=
Date:   Mon, 5 Jun 2023 19:09:51 +0000
Message-ID: <FR3P281MB1757DAD04BEEDB322391DB83CE4DA@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20230531142513.48507-1-inv.git-commit@tdk.com>
        <20230531142513.48507-5-inv.git-commit@tdk.com>
 <20230604120810.087ae732@jic23-huawei>
In-Reply-To: <20230604120810.087ae732@jic23-huawei>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FRYP281MB0143:EE_
x-ms-office365-filtering-correlation-id: eedea1c5-ff41-4998-d4ef-08db65f87079
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dVTAw9MAIY8ctibTwGTj6Z++bt3NMajC2E6hk/1a68yI2lfR/xOfEC6bRl4UB8O+P37gdw8iy2TQgDj3m0ONv9db3tFwuC/t9WkRSDLoTjEauui9wf85u0p6VXsmZAYJG4iM4U+TJuK7sMlcApxecFcK6mcqudrt9AejstTjqograWSDBN+5J3Kc/JZ3SbbshG9JfiTVC+QZ1Auq5SRfqfEzoINcMzAtzK4S2xcmbEpDm+iuTCGi5KSj/Oraa0jHHB43siwTLmoyJSdFCkCUke9yQODHRJOGkxjae85k9C1kC7K7DjR8av0qC0sAVfeJM8fCwSEzZO+KXxH87+PQMfzJ2bTv6w8eWHYCWi26mfyvv1Afpt4JyH1I74217ebng7FWeOIrGX/8/ptRUMw7qyETGZqThFVMY8An0qX87jzGigc1iMqbibCa4Np+tul7JlSuihVlm1ZffPviAXnwgfVJzN9Oq4ULjRT7vNs66rPsAqg8DJVfTH81vjpZG7BXu8JGc+eU/8tFpAP1yp6FOHcS3bayy6OxwXmktEHgqYETY3ZLjbjxBr7KncmXCYXDZlZhIbF/M7+V/hsdoBYw1u4M13c2dYlguC9mYQvoeZHvioBW+2ImlbFwO87I67Fc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(451199021)(2906002)(38070700005)(33656002)(86362001)(5660300002)(52536014)(55016003)(71200400001)(7696005)(186003)(6506007)(9686003)(53546011)(91956017)(478600001)(110136005)(54906003)(76116006)(66446008)(66476007)(64756008)(66556008)(316002)(38100700002)(6636002)(4326008)(66946007)(122000001)(41300700001)(8936002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?YlMMs/1Cy969oXf0o4FryLDbaJHFFx5TFbX4LU4qcucgJX8UKo7ehpCd+o?=
 =?iso-8859-1?Q?h/rKawUalZ1OtNVsCnJtg6xm2Tgd8YvedLhCihFFmF54brjM6BOv8HXBjg?=
 =?iso-8859-1?Q?X59AwlGehq1SBdfxSPgtXuXJ1O7HJZBwZg6Q2S9PrgBSZpCIxxjmQbdcCg?=
 =?iso-8859-1?Q?/S+ksec+KBcwR18R02tHl1vNJ/i+ET1FRFQvgj8GXVCIrvb3rcXgft6sw2?=
 =?iso-8859-1?Q?nK0CSK3mlw0Bhqf6/NgL90KZSZ4vnV1GxZqrEU7Cn8reK5vbQ4LY2SZAgx?=
 =?iso-8859-1?Q?1L5lJYeg9+X4vgFKB1HzK+lqGi1h5zQirxOhHMNYSQA/ja8r0fMCNOggmy?=
 =?iso-8859-1?Q?QUHZER1+qqgBnkq7tmyG4dGf4mBWCbzmpQOc/V6WFgY1/oG5aRzKdkX4Dy?=
 =?iso-8859-1?Q?4mJpnoW/huBwfG34PmBQyc1xUrNT4C0v3T6Cni8x/YTS1IzVTlXe1sPNub?=
 =?iso-8859-1?Q?Ex23xD7n861pVgUQI6ZlabDFRnraAscdQknuNUYayHrBkJnYhFoPuEpz59?=
 =?iso-8859-1?Q?t/Dofp4o5xj0U+dvhLwGJQhfIqUQL+5MBTjTtEBE6LOZtMh1xnYEs4NGGl?=
 =?iso-8859-1?Q?wYyAl0WU8exGx38jfQUPUGM1N3LrwSjMkg2C3nvz73OlCk7/MkEpTY7RFb?=
 =?iso-8859-1?Q?rrWCzik3FgKRWZXG8q2wkqNVogA9l+qLJDyFEWI8Xquj6rVfDiNkQXknPU?=
 =?iso-8859-1?Q?Fo6Fm9R40WwSz3VPi+QYC8tNL8iLPOld+wXYEeMjQ2kzi/SNH5ES8w8B3F?=
 =?iso-8859-1?Q?PBLieuj9IpH3ycVHkDZtsyTlDUKWjVPzOO2V2zb01CJbVtb99wNWaLrDgn?=
 =?iso-8859-1?Q?/oy2kGnt36IPaiW+e5i/XW15/rdjXt91t5bp4rtfmmL0oq/8q/nV5ulzcn?=
 =?iso-8859-1?Q?yt9tvvXwPcYplnqPxS1pxTSpZNbp7QA2gR6Nm34ahbTZ5ZK+9PKLF1AOee?=
 =?iso-8859-1?Q?5jgKzFmpBFIKi3np1ZR5zlDfClaJw+M71uQk4zIQCuQ4Qq23L13eTB7cXy?=
 =?iso-8859-1?Q?XLcHb237VLPtP8IFJGVVsBq1Z7acDRPwb/jPvP7hE4J7FIgMPrbNIIkpQW?=
 =?iso-8859-1?Q?Vx7R928TvhpVXsLxLIqm9R8HtNqgR2MaPG1iqlYLMl8uPAl94+9LWI6w1x?=
 =?iso-8859-1?Q?INlblXcr+5jhY1KLHSl/lYfYM5vhZrN98pLgG/iXV9k569vEBlzCWS++tR?=
 =?iso-8859-1?Q?rhERSY/SHU7D+kVY+vsR2rIJ4LxpGL2Ih7qycG1+l/jUdF44fB/OqmJAl3?=
 =?iso-8859-1?Q?/PN+D1MII1BP3dSQv91bUeLtqtMiItCbxsxBMTEqU4eGrST7ZLf50Zcf9h?=
 =?iso-8859-1?Q?jyXRWaWSTpPc0o20f14ynHAnJvgzxJIHXSl/vW1r0fUblwnVCBln2vT86d?=
 =?iso-8859-1?Q?bU+wLJitcWqAmNf3tBlPdu56rgdTH7OduCemj5IRUPKmhjeEJpd4Q9a1q+?=
 =?iso-8859-1?Q?ZQSFzPEUjoXGuQnmQrg8NDvDuqiWcCuH+mgclP1oJg/r91D+bT/kKQPLvx?=
 =?iso-8859-1?Q?5tZir4pwNwjhZFPeRRkBmzIjdBvswvhS11Qv282W4X1O64U/WW49s2iymu?=
 =?iso-8859-1?Q?tOyZdKTDEWxAYkQxkzalOKNSRja/Xl42ODwLxBt3rhsxeZFNFHgk16he0p?=
 =?iso-8859-1?Q?lj4xS73RuvLcidn1bTt3/E35oKPz+OZo28L9LrBc2HtSh0gONBNGTOBYmv?=
 =?iso-8859-1?Q?0Wg6z8Xik0HzFCdJluKdnYhLZVxvYobyl20PcjvsVqyHRDxVwdzwEFlrJH?=
 =?iso-8859-1?Q?ABxA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: eedea1c5-ff41-4998-d4ef-08db65f87079
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 19:09:51.6071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iy/IWlppC3C2mcsO7WsNEANoKzzh5PC57nYI9tfazg0kW1i+v6AARD52DijBP46UqbpjduH9ftxIjni6vH42QbIZDcxe5gpT7eyqNKdK1vk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB0143
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-05_31,2023-06-02_02,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,=0A=
=0A=
the 2 algorithms are very similar, but the new one in module is better (les=
s jitter, better average value using a moving window, ...).=0A=
=0A=
So switching to the new one will lead to better timestamping, while keeping=
 a very similar approach.=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
=0A=
From: Jonathan Cameron <jic23@kernel.org>=0A=
Sent: Sunday, June 4, 2023 13:08=0A=
To: INV Git Commit <INV.git-commit@tdk.com>=0A=
Cc: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; lars@metafoo.de =
<lars@metafoo.de>; Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>=
=0A=
Subject: Re: [PATCH 4/4] iio: imu: inv_mpu6050: use the common inv_sensors =
timestamp module =0A=
=A0=0A=
[CAUTION] This is an EXTERNAL email. Do not click links or open attachments=
 unless you recognize the sender and know the content is safe.=0A=
=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
On Wed, 31 May 2023 14:25:13 +0000=0A=
inv.git-commit@tdk.com wrote:=0A=
=0A=
> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
> =0A=
> Replace timestamping by the new common inv_sensors timestamp=0A=
> module.=0A=
Are there functional changes as a result of this, or were the two=0A=
algorithms identical?=0A=
=0A=
I don't mind changes, but should call out if there are any when=0A=
unifying code like this,=0A=
=0A=
Jonathan=0A=
=0A=
> =0A=
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=
