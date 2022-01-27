Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66FF249DC44
	for <lists+linux-iio@lfdr.de>; Thu, 27 Jan 2022 09:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiA0IL2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Jan 2022 03:11:28 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:24914 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229752AbiA0IL2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Jan 2022 03:11:28 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20R0GVn8015482
        for <linux-iio@vger.kernel.org>; Thu, 27 Jan 2022 03:11:27 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3du77wjeu0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-iio@vger.kernel.org>; Thu, 27 Jan 2022 03:11:27 -0500
Received: from m0167091.ppops.net (m0167091.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 20R8BQvK000661
        for <linux-iio@vger.kernel.org>; Thu, 27 Jan 2022 03:11:26 -0500
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2043.outbound.protection.outlook.com [104.47.56.43])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3du77wjetw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 03:11:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AE3wPVkgyY/VUd0f0qOCxrkLHyHJ+2vNE3AKK5dtbJfqFmUxV0UdBfokSgEEl4FOpXcHx2z53LM/sL9LxEnqu3c0WCmcHvNxF0N6uOvuPcXHhtH5PKbBr379XH+3cmSkzXkU7OiGayI5uKEP7na7Ky51Q45irehb0kcAFEmzdSxeAQjge+WhAOYGvu9SrOK3xc9oNIOxMqPBOD0hPZUsG/X++IWH3QZhrskK1OpHE5mV1K13AfzKjXBRCHwmcdm8eWEntz4Qx869O5M9rWDKBUahtS4biVBBhXf2ZHZL8sa8EzvEVWHFyav76JLTIBME3vR/bCy+AXrW76Y4LZpljQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCGPk71kJCGrIdBJtK9Pdon+aWoXbAPcRBarE9ZOJCQ=;
 b=a2HnbxiW6W9irUGRP0t4x5m7xoNQyYQ2XUE8yAv2TqpCzLsJ6UbKLEn8Unwl29tPCtxVmvxZQPXEcd9+cm3m6Gv75cufR87p+NP1HWMa0kUz/CH7d+Xn3dcNelYyNkvdX4BkAS9QyMAjL9OYK9EOjd+sG31N0E1hTQWstcBtKh69wC1xPnB7MLrzlGrrONWIlCVGFhOPDeHjzf/WYd4DlvtOaBPRlAImrvGA3hoAvhUGE4nrrM11YA5J6GBlmeBD9VAUSd0G5AXyLtdXxfEK9CEh+zs9zTj0P9NaVAzDUMYIeqiCIAze6k8XPiEAZpQjJfHYXf90rd7IF3GQXAU9/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCGPk71kJCGrIdBJtK9Pdon+aWoXbAPcRBarE9ZOJCQ=;
 b=QErAr3Zo88G3P4Zyb8Rabrl3mnJ0m4CYdGBqP+xU0kTOpdkrykoGvDRnGiOsZKY3YB8JZXp/JxUSv3qZnasiHcPyqYO8/1LMoYMBHWUADkJE77ISLdLvkB8Ty9U8j9s3Ob2S0brUN9ykZtetQ5myqpSUGRAk+VLaGDRV1sNEcYI=
Received: from BYAPR03MB4647.namprd03.prod.outlook.com (2603:10b6:a03:12e::16)
 by CO6PR03MB6244.namprd03.prod.outlook.com (2603:10b6:303:139::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Thu, 27 Jan
 2022 08:11:24 +0000
Received: from BYAPR03MB4647.namprd03.prod.outlook.com
 ([fe80::f102:d589:b31b:80db]) by BYAPR03MB4647.namprd03.prod.outlook.com
 ([fe80::f102:d589:b31b:80db%5]) with mapi id 15.20.4909.019; Thu, 27 Jan 2022
 08:11:24 +0000
From:   "Hegbeli, Ciprian" <Ciprian.Hegbeli@analog.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: iio_trigger_poll from IRQ thread
Thread-Topic: iio_trigger_poll from IRQ thread
Thread-Index: AdgSwu2LN9BE7QAqSIuVEToB3G7eQwAJj0gAABrk7CA=
Date:   Thu, 27 Jan 2022 08:11:24 +0000
Message-ID: <BYAPR03MB4647F1427060AFBA12E2E49897219@BYAPR03MB4647.namprd03.prod.outlook.com>
References: <BYAPR03MB46473D8DDED835EDBDB20A8297209@BYAPR03MB4647.namprd03.prod.outlook.com>
 <20220126191606.00003f37@Huawei.com>
In-Reply-To: <20220126191606.00003f37@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY2hlZ2JlbGlcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy04NGYyN2I4ZS03ZjQ4LTExZWMtYjZmMi00MTU2NDUwMDAwMzBcYW1lLXRlc3RcODRmMjdiOTAtN2Y0OC0xMWVjLWI2ZjItNDE1NjQ1MDAwMDMwYm9keS50eHQiIHN6PSIzMjk2IiB0PSIxMzI4Nzc0NDU5OTY4MDU1NjEiIGg9ImxnN2FvNTFYUnNZa25YbjBGY2R5dEVYQ1E0ND0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f90b95b-21e4-40f7-5a27-08d9e16c9c8e
x-ms-traffictypediagnostic: CO6PR03MB6244:EE_
x-microsoft-antispam-prvs: <CO6PR03MB624479C1C335EE722406E91697219@CO6PR03MB6244.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jBI4ucGpdcOjN0GsvjWG9KCTGLx32tgTUiwCpyNUuNM4ZLsGHd/Nnv3VJZ/3A8yq7PS3BPc497oocRSGMaFdj0BIMy4ifTnZtsoE8XklxQaf/33OUi/gA0kMeVy+shyB0yZobF4oNxg0mOxJ8wv7XcaaEzeugs2kfilqxXLq+GxhEHeKAZgcSfnk7TfDttI9KeID3M1B85E26WWAkVAQKphcYDsXy33FnNAMgGzzRa1evUSpD1+NpREkhDkTQdfwJqAeu3UYGjh0Jzi2TiKcRhocUV89EpT+OgqO/CaH3giAuTCOEPz6gH6OtIH2lxKE+Qx1kjm69u0rX66lRVElhYiMapVeSRu4AQTCVGmsZ49Psh2nFHHez62DHxl2wQ/3s5VU2qR9J/hTfa073Hg8Ync1xy4DS+TKPiRgGrW+ycIleTij4uMLDWJqVitYW4CwCV3cKXMkRrGuGVyBGInFrDqHxEmsQ5IuJeTNR+Mz4J+zTmJ0l5TTy5GPe57N0wAspAZvFqPDimkUoYW2TgFoenyZoGYK+dtv131flyOEOd5Kd2XGtF/JuQf7JYXq8vDCsqFWxLU7ecozNye2SG9/1e+nAXIlxOEupEDQM9ATIBJvkFnI9wVbCBuSqac2zYn0PFrYHbs1HeAGjXlbN3O7t/xCxx/JpXFp+MKInBtI6aYMF31TOBEQz/mIKe84ezZOHD1mv4as1OAMpwK6kQ+scw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB4647.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(45080400002)(316002)(508600001)(6916009)(6506007)(7696005)(53546011)(86362001)(83380400001)(33656002)(5660300002)(71200400001)(2906002)(9686003)(52536014)(64756008)(66446008)(66476007)(66556008)(66946007)(8676002)(8936002)(4326008)(76116006)(26005)(186003)(38100700002)(55016003)(38070700005)(122000001)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nkSSgDGWV6JAXPaSyFqpSTywZvqMxGc9Ji9gaeY2BKoxNeASdlRbhlOcYSSK?=
 =?us-ascii?Q?rLsVbru0MQqNdo7/Rh2u1BclX4QamQ4xbcKjtbJtz1Nxw41U11Ye2N2vJlzd?=
 =?us-ascii?Q?yyp40Ay5Zy4H+mqILn9jUfNWAOOR3ZHAnMDT1/7/cxbG5bZMl/00NAxePXf5?=
 =?us-ascii?Q?P1HUYVHHODDe9T1c5t9LuksGRr9mG1JYKBWQ/eF5tj9eb9P3Rtp7Ivg5AobD?=
 =?us-ascii?Q?Nc6bDpFlI6Yyxk1dSkliP5aV5BlWz+0f4OtEGfwWNa2PTNpA9z/7a9MjEzav?=
 =?us-ascii?Q?SFXGCF4g2rHfGcB/2WgkIpEhrCGDGZnNjh51+AsyKKeecFtyjvW+VMUV/jRm?=
 =?us-ascii?Q?1dCmj0no3wwlGaFkl/u+7pgP90TuFstMEM+Wj3uA9KNITjGj3E4Pu2mfBEwg?=
 =?us-ascii?Q?r0pE6hRLpYePX0bUIY2lijO3vaKRNxvYAFuIS9usKBpzlocQYN9QzQ7XafBC?=
 =?us-ascii?Q?OujlYoakk2jC9ghYyXqYfo9/mQ8tRCp36mXnB3lLGFx7UM3YUGf5xaleGt4z?=
 =?us-ascii?Q?mhzHaZ1ASgWCHbXKSz3b4Yg4wb1L3lqwn50D6qqwvQhrxlf5ByfkvfcBBFs/?=
 =?us-ascii?Q?Texw1TQ40wgdo7f1JEiUii+VgbqavU+BOjCn9Kw+5v1MUvM5e8wY7FNcj2hB?=
 =?us-ascii?Q?ZibQfCCclfHEapL81xInEAesSz6MVZ6vadyxLjrlEQx1WlgedZNIa72K+3cT?=
 =?us-ascii?Q?fAIcyZboQbkAhASAVzwKgvMCGZPaDIpl/b61cC8QDTUYPhMLiWbf8qBqQyTt?=
 =?us-ascii?Q?4IdTr1I7Y9KzpXBrQiB2LQf8jsSyU7EQg+P7M9Vm1jF0tgt8KdBnKWAipqgd?=
 =?us-ascii?Q?J1d7Tu+CRBgQJDTL4CWDB2DPlTHnuUe81qrZTHbyEHW2m9xmA9uImr9/XsAT?=
 =?us-ascii?Q?jsCrEMYSaaJuFI3bqftocJ4BtX3ghYnpS5rIT8IL8uCCbLOGlTL2TIB++nW9?=
 =?us-ascii?Q?awouLDjwGQKIzg3x9hxNMi/Ic/sXa6jSoktuzgKU8Sd0ldm+1nSIcfoVc/YX?=
 =?us-ascii?Q?om7E4OmyQVHTyWc5EXggzTvlsxeGWijUKDFcz7wl04Hy78AbPIOv+R5DpoRt?=
 =?us-ascii?Q?9SLgO19XhuyTy0dDgHvN8X+7wLHsMP/dp+/qgAyde9cOBUw5I8LRr77xmFkW?=
 =?us-ascii?Q?uG9mA90kCYuFXUdMLLB7+hbRHgTmbPmNzTdUu4AhSPWu0PE4/O9yve7vudqz?=
 =?us-ascii?Q?hETk3fth6E4JPnG8xvHIz5fQVExHH7D0DUq76hPwmrwUaVuTcPA4FiyquoUy?=
 =?us-ascii?Q?ZvAYZcSvQdshsom0gH9mvLi8wTssEYvAiAglBCo74FWXi/+zjmbyHoPaIZU6?=
 =?us-ascii?Q?0+0Pa8YNtnyxIM4C5FBOPjWt3/nGdiDWo5VPk2pJN9nS6YsYnEEx19XNnbiV?=
 =?us-ascii?Q?LncGGv9Y2xe2+i/WduX2Whbnffd95ZmELCFnyf5uhqG+Pl9dKLU4seb7GHQx?=
 =?us-ascii?Q?g/q2xr3ZLXOeIcuveioWTg2Pr5pfEOjWZCeRFzg72L/Po8a5+aLY4iyE8Xwo?=
 =?us-ascii?Q?DhNTfxLQl4fsTZr1JcgvDJ8ccPvFme9hVjPspvEL/qxe7gXVurhloDyRpjvq?=
 =?us-ascii?Q?/zdleAA2zpPrVVF/IqLaQ6ojhrqOhAkeboJggyOA8OW7/V53yIKFiJu5EiwS?=
 =?us-ascii?Q?kiDq0ePQakMpQAFPfcNjhzUgdUoZEqm8sNI14U8yUTVQkRYmdcd5kzQrCfxd?=
 =?us-ascii?Q?7Ll8EQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB4647.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f90b95b-21e4-40f7-5a27-08d9e16c9c8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 08:11:24.8303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WcOTsObf3O8thSY9i8vi+VJSdiHez5yHDB7lRAL7KbsUYDXbysNtZLYj+eLm/jWAuzFGx8r289yDKYWtWa+mvIsgpE0ETpD8MIRwkoAVX/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR03MB6244
X-Proofpoint-ORIG-GUID: UTQ0VnHA7HpwkgohqG8h4yppMg6WvjUj
X-Proofpoint-GUID: OS2rrGhU6D0slirVnik7ZOlVA-05pn4o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_02,2022-01-26_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 phishscore=0
 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201270048
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Thank you for the input.=20

Interesting point you bring up with the no trigger setup in this case. I wi=
ll be both easier and more convenient if I can give up on the trigger funct=
ionality altogether for my driver. I will ask around and see if that is acc=
eptable.=20

-Ciprian=20

-----Original Message-----
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>=20
Sent: Wednesday, January 26, 2022 9:16 PM
To: Hegbeli, Ciprian <Ciprian.Hegbeli@analog.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: iio_trigger_poll from IRQ thread

[External]

On Wed, 26 Jan 2022 14:43:45 +0000
"Hegbeli, Ciprian" <Ciprian.Hegbeli@analog.com> wrote:

> Hi,
>=20
> I'm currently trying to call iio_trigger_poll from the bottom-half of=20
> an interrupt handler and get the following waring;
>=20
> [  101.814234] WARNING: CPU: 0 PID: 1204 at kernel/irq/handle.c:152=20
> __handle_irq_event_percpu+0x234/0x238
> [  101.814255] irq 60 handler irq_default_primary_handler+0x0/0x1c=20
> enabled interrupts [  101.814268] Modules linked in: ade9078 cmac rfcomm =
bnep hci_uart btbcm bluetooth ecdh_generic ecc fuse 8021q garp brcmfmac brc=
mutil cfg80211 v3d rfkill spi_bcm2835 gpu_sched raspberrypi_hwmon bcm2835_c=
odec(C) snd_bcm2835(C) bcm2835_v4l2(C) bcm2835_isp(C) v4l2_mem2mem bcm2835_=
mmal_vchiq(C) vc_sm_cma(C) rpivid_mem vc4 uio_pdrv_genirq uio i2c_dev ip_ta=
bles x_tables
> [  101.814452] CPU: 0 PID: 1204 Comm: irq/58-ade9078 Tainted: G         C=
        5.4.83-v7l+ #7
>=20
> This warning occurs only once, the first time it goes through this scenar=
io, on a second passing through it I get no warning.
> After reading online about it, the problem is related to disabling the in=
terrupts prior to entering the IIO Handler.=20
> By doing this manually I don't get any Warnings, but it has been pointed =
out to me that this might not be a good solution.
>=20
> I'm using the bottom-half of the handler because the interrupt requires r=
eading the status register of the IC, which can be slow.
> Unfortunately there is no way to insert the iio_trigger_poll in the top-h=
alf because all the checks are done in the bottom-half.
>=20
> The trigger_handler reads the samples from an internal FIFO in the IC, I'=
m not sure if this detail is relevant or not.=20

If in bottom half, call iio_trigger_poll_chained().

It's a bit of a hack in the sense that it will only run the bottom half of =
the pollfuncs which isn't always what is wanted (can miss timestamps being =
stored for example) but mostly works.

Not well named either which I've been meaning to fix for a very long time :=
(

However, if there is a fifo involved, is it useful to use the trigger frame=
work at all?  That only normally makes sense if there is one 'trigger' per =
'scan'.  If your fifo is working on the basis of a watermark interrupt for =
when the buffer has N scans of data in it then it's normally better to just=
 not use a trigger at all and fill the buffer directly from the interrupt b=
ottom half.
Things can get a bit fiddly if you also want to support other triggers but =
there are drivers that do that.  No trigger means fill directly, trigger me=
ans grabbing data via a path not using the fifo (or with fifo depth set to =
1 scan)

Jonathan

>=20
> Regards,
> Ciprian

