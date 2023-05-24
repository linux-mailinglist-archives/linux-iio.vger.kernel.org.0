Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02E670F7FE
	for <lists+linux-iio@lfdr.de>; Wed, 24 May 2023 15:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234293AbjEXNsa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 24 May 2023 09:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjEXNs3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 24 May 2023 09:48:29 -0400
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AE4D8
        for <linux-iio@vger.kernel.org>; Wed, 24 May 2023 06:48:26 -0700 (PDT)
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
        by mx0b-00549402.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34O5H1hm011722;
        Wed, 24 May 2023 13:48:16 GMT
Received: from deu01-be0-obe.outbound.protection.outlook.com (mail-be0deu01lp2168.outbound.protection.outlook.com [104.47.7.168])
        by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3qpqjgk2r2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 13:48:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2UZ4Fp2VvRZ7gHnkP624320MBC7XqfKkDa73sVFQTgQVKohqInDGo2dggaEMCSxI4tw4Bvs1io2fVB4uQ9Z9rNltn9vUkEK2yLzZ/R4tkQVcmfL+JPkjcwCWYzpQkfCZSxhPXJ7D8uA+JBfGqec1RqoSQKOeA13sqHdomqJTYUsdlcVpM6Vx6EIlxtGKkRRwoIhKOTi3Q+8ZkAWwF5KoZYNtYqjJHbXEUKC6fT+bqrwPldS4tPjhax/WrzrjebWClp/H059n3hvQzOHUJ3J0Ly1LHX5Hq+HZZavdTM2J2qmzppIc7oZCvhGPjU7nzeH5xA1H7dV5inDbUgG6ssBaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hpr1OMGq+di7HaSx098jV0r5IcXcFnKCXLCETFz3kks=;
 b=NOoZ4HmJYoIummxOO0QH2o9uqfTVaw1mRc9R4PwU3qjtLXj9rZ3WsYAQFT09VN/qr3hLby3rAY79zWQohPZuEtnbyltc9tqB6+Og7uw0ToE6NJ99QOoq60vWJ1AjyXF1PqynotKkFenSe7+7T/TdLEogGar74IkGJ763UaDVG2udld5bmXFwmrkIwiWg26oIkvOv7TOEm6ZK7nfzp20ExURKefKNI2pxCHIFwGbdrocEy/hsx58m4sBwt0OBfgzpdBT7WQCWl13T2l2yn/c5dtH0kuFpSMu3PlS8SXeNB2oaD71dt0oCDU3vWhDUOYOzv0CHLiuTI1xWKQXug5vsVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpr1OMGq+di7HaSx098jV0r5IcXcFnKCXLCETFz3kks=;
 b=dmEGcM2emislN5iTz5R7K4HOqvwqd+gbHDcJI1MZ2LALhj9oOyu0DTLte5ZThomlEDujexmB9haFlABx/wIn3i78qBYBcFhJ1VXCmeissxy/wqzZNGQ+cZTmAwxOCvbQqD+G5LZvu5m1NlzuwtTVNN2qTPgNuDA5SRTQeq4g31YhrA9TAFIzVhtENCwMl1sQtWvgYz0oFIbN4Iv3mrE2hbmq+7qEKaEUJycwNyH8UZdfeEcllrpjLgUUc+1ZNi2t9cSoqfqdN25I904a5CMzDjAprreKKZMkEesh8PCp+8JpHGm78eu706CHvqoe65/JOg/UqGEKM10qo27LLFDNfg==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR0P281MB3084.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:53::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Wed, 24 May
 2023 13:48:07 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::a30a:5ac8:b5a8:68dc]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::a30a:5ac8:b5a8:68dc%6]) with mapi id 15.20.6411.029; Wed, 24 May 2023
 13:48:04 +0000
From:   Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     linux-iio <linux-iio@vger.kernel.org>
Subject: Upcoming patches for invensense sensors
Thread-Topic: Upcoming patches for invensense sensors
Thread-Index: AQHZjkXUYj0TvzzCZECi3PDQuSPE4Q==
Date:   Wed, 24 May 2023 13:48:04 +0000
Message-ID: <FR3P281MB1757168932252EB79484912ACE419@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR0P281MB3084:EE_
x-ms-office365-filtering-correlation-id: 20bf0239-c8c2-48bd-e049-08db5c5d7f76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: amMll2eDpRtDpTSV0Y3bQbySyR/O25wrOYPl+lSPvT1y3MXAjQ8S3Nt0l8ifXsCOTCClmpsSqnVXeg/Yj1dEhTSpKHjDezyN0K2Qxhl49+ubk3M/pHV8rlGqx6DqMGFN0FutEPCY8qqRXjl7DS5mAlIXFFLmpgEgNSVRyoI8KdY/VqDmiMWZiOuY/eRH5q/eRAMQoVqrzXfjVgts8yl8ZN8uBzF/NxmvyxDtGfLLIzLK83Hr07hDb4Vx1fZ+80mP9mPKNbILwcObpiFw4qVmqypx5SNd+nBW3J2CC3Hl9Viwa2T64+qBO67lelrtviML9oZ9/5rGd/mRpWH3En61rHJyV6hOk3oiav0NkZnUQXB7VNIbEo4u1CMr3Ly2Ko0utPD8UYa97sRwKXiWRCHsWmU5pBrl5F6O2Hv5EH1RY3XL4UwkTKKRs51xf2xJArkoXhPfdFOpDcYpC5MF/Z/zzoKRWlZY1CyuZ1nilTVkco+YRSRKsZTiDbIixiCBvaI03aPQqHiVCQptwGsav5IMOijsbF31uxE7ejp7WWeMrqn6hdV/ypF12rCyBHvajuFJkMs4K7BoJttzGEOpLsEr3zvfPks3lMyki71kaYviyn0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(396003)(39860400002)(346002)(451199021)(8676002)(8936002)(5660300002)(52536014)(122000001)(186003)(2906002)(4744005)(86362001)(33656002)(9686003)(6506007)(55016003)(316002)(4326008)(71200400001)(478600001)(66446008)(66476007)(66556008)(6916009)(91956017)(76116006)(66946007)(64756008)(38100700002)(7696005)(38070700005)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3wxRGFN5dTZvzeo5Gbof33NRQQHw0XXm7RFWhKxjrGeA8PyuG5I4Lr1gl+?=
 =?iso-8859-1?Q?daJtvv2v5IIyB+twAXNdgH6++NxI5dptTR9TwxiTN1JCwCaKyVhYaj8V3Y?=
 =?iso-8859-1?Q?b8WQScj9lYBQ50decPhtfdApI2Qa8G6Soa/JjXdoKYT5bLx6cr5GCxEUSl?=
 =?iso-8859-1?Q?Zw4/PzK483iF6iuO81/f9pDHbF2hVd4f9EjYTlBEyCfl8GBdOrCl31j5/r?=
 =?iso-8859-1?Q?jsiFAjL+PbAWbjKZGV64PJLrAlnrdM5Fxr70qzL+AnVck6GdVSCTglhB46?=
 =?iso-8859-1?Q?yzfWnIzixue3IAI19C8p2s4isjFx/MNv1uzsNkWSBtnMdKk/9pKv6WWpGH?=
 =?iso-8859-1?Q?Ife5Tc0mvCQDFYF+GIFjNTaJx8hZbkfTI+Dix5hKCpsltSgAHTPBOml+nq?=
 =?iso-8859-1?Q?Nd9w+2CI29gf/PglWtZ6JfMSnUDSU/RgTY2mBB6XRPCFGL82o5/AJzeaCJ?=
 =?iso-8859-1?Q?P25BxmrI4c3GtWu30L3wntM+0uppR6zoNJxgzt3tFqM/KPk6ZPlOaqeKJM?=
 =?iso-8859-1?Q?WFO3ejv02fPYxTBaBDxzyvE1G1WO8j+O47dOFoLfA1XbtezuPpBMqMMpTh?=
 =?iso-8859-1?Q?tVkshtipjG5sRegZLBagu1jvmGJOz0rYcLK9n2PvCFT6OHyGCgZWPX7ooo?=
 =?iso-8859-1?Q?fT3IFy8nHxW067pCzgCt1mD8b9ddmzBrN3LnpitXYD0ubEwdzTAdQjEjeQ?=
 =?iso-8859-1?Q?dQ4KQiguzYr/Niy39ae36DjrHaDmo7wzn/PK0KMKA2160hMOfpMwQkotza?=
 =?iso-8859-1?Q?/DcF6uyAcGWifYAgxEZoP/zvAPOkpNkLRIqG+h99W9FbHEoyXq0C1+RxdM?=
 =?iso-8859-1?Q?AfRwZ5EonA1SjmJIjMBPLGp9WPsyR8Qlz6vDIfpxp82nY8FJlYxDiyeAbT?=
 =?iso-8859-1?Q?XO8gLis/Z8gbPxYbUDQasbUOw+f+BSezPuMfZQa0V4ers4ISbqlUO1v05D?=
 =?iso-8859-1?Q?r7ydWmxeEncpv+0cHPfxdwu9GzzTDMhop25SzwXw2EoPePEP6qJCOnkdrg?=
 =?iso-8859-1?Q?/jlKSjWV43qa2FC57uOd4ezlzwyP+SFbmScxjH0iiTZ3LhCtUKhYitfT6Q?=
 =?iso-8859-1?Q?MXSGexk5VQA7bzv1rcU0gKm7ACjjQ0gHTDEQXEKpVlQRjDNNAjarDe6FPV?=
 =?iso-8859-1?Q?jHXbL0JZu73MTUPVMCJIsLNCi8YMKJ4YcHbb2e9OQsZnQmkZi1FXcLL8n2?=
 =?iso-8859-1?Q?iO63mCyPX4dxzITfxH3/0jdhdyIooI55zQlmIN1CE4ZAFZeNbksrKIeTQi?=
 =?iso-8859-1?Q?jwXeicHRebeQMeK+/upzbCjVCuSe1/Sf1vKmqyQU/ElGR2resMNyrNqdND?=
 =?iso-8859-1?Q?iZ9lYE+6jyfu45w7ccateS3KeeRvDTO8Ja91uzVsC43zL3zG0SGhRxnf01?=
 =?iso-8859-1?Q?ljw9BQKQtnnk03ABw1D7OKBdchi4oQeAm5pI/3R4f4fTpY434Dc//PliNF?=
 =?iso-8859-1?Q?DMZO/0eeXD6AscSOsFsGP1QFAZOMWA13PMvd2PV4JwM5dLs6L/LKwrx+CW?=
 =?iso-8859-1?Q?C5xbbXSDQ5amkGZwXtN2swx08Z5Gopu901F8Av0iyXavRN/nalYpYv5J1t?=
 =?iso-8859-1?Q?c5YUStY6Tw0S8m7ykZYyPr9gFhgk7n5kQGRG8DLJpGgeBtpWBO6a0Ybpg1?=
 =?iso-8859-1?Q?8j1tAM1n/U6Cz1x+npMPj9cme0/7itkW1TODLrZeRQEehNgR/f7rSNWeIV?=
 =?iso-8859-1?Q?O0LLXqAiug2VIkWCq2rloygmMAqvmslE/M7CCyXwCrnVnbYwM4mN7qGjY8?=
 =?iso-8859-1?Q?EU7A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 20bf0239-c8c2-48bd-e049-08db5c5d7f76
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 13:48:04.2698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GMj2KpC5fNhFGOcuvLsYARK5j5tx5A6r4OVpZ3S+dS349ydrxARIzr5QTlvqJH1XAgM9KPm4Hk9Hm6xPWCUKxawSuePQPzw5M5h8Q263ybw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB3084
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_09,2023-05-24_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,=0A=
=0A=
I'm planning to send patches for a refactorization of timestamp computation=
 for our 2 drivers (inv_mpu6050, inv_icm42600).=0A=
=0A=
The idea is to take out timestamping of inv_icm42600 into a separate common=
 module, and use it for both inv_icm42600 and inv_mpu6050 drivers.=0A=
=0A=
For that, I would need the last 2 patches of inv_icm42600 driver (fix times=
tamp reset & avoid frequent timestamp jitter) in a branch. And 1st=A0one is=
 in fixes-togreg branch while the other sit in testing branch.=0A=
=0A=
Is it possible to get the fix timestamp reset patch inside the testing bran=
ch, so I can send my series?=0A=
=0A=
Thanks for your help,=0A=
JB=
