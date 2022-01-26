Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD6B49CC94
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jan 2022 15:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242292AbiAZOnt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Jan 2022 09:43:49 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:41672 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234426AbiAZOns (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 Jan 2022 09:43:48 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20Q8W9II007327
        for <linux-iio@vger.kernel.org>; Wed, 26 Jan 2022 09:43:48 -0500
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3dtr97j9wg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-iio@vger.kernel.org>; Wed, 26 Jan 2022 09:43:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ctP1KtdcZ8iOUWRb5lf9YBM9GYRUBu+JbG9t+OMfEwwBG3kVCsMgvXWAraDD8DH/nizn4gX1Lu6XOEL0luSu3gUiFJP+mkv+HS8w86UHlfQccrbfcB8NHtAbm+j71r8TjfMfdHI3r/5biueMh+oCYWQZ2+RVePAaFMYswHQKkCYONOY999BNY9L3bXeIGXB6JE909mfYRs9om0lh7nvvkadD3v9bwfzP0+rulVpuOZHKnFBFTdF6mzKV25PPiweoipm7ZlSa9bmIbMZ5k/rqryhzN2oWiSItldQFQa5B3RZcLs912zpwZ4In/s5+SV7Qd+d8khlsYV9op6Ul+VEXmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=seUeeLTe+ynhMedqFI3zI/tZ8PuFgA30FSLnVfo5K6g=;
 b=HPzsKzGneSic0K0ch+gTLSoBF8KKzjss4xvC54BN8DQVNSiJdksIE/av1zvY1BHm4reoH+mpLpAva96Jg88DpVMBkg8ODNM2VANCvYoNbAP5yqCDl+wcMoaDwjrjHQU+5tSBKKEhtOhuCK2LGd9e/Wbp0aBzDz0blPcFUIkC6xqBNpZgzog1uOwO4YVhAq3iGQ/gMTl+WcQdxG2z9iK3luqLapE+jRzw7IqYrca3VHJ1XaHyEeDsCdN9JgFe3vELWzdzYDNZZdrY0JAlc3cK4sNaQxx8r9gyyz/PO0c+dsVj++kEWmCbI12alIBxCa3c0oATzxwz7WQWkRzqguAp9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=seUeeLTe+ynhMedqFI3zI/tZ8PuFgA30FSLnVfo5K6g=;
 b=eyt6bpHXUVGRwm7i7vs1dzrTgn4wjltH+F4qAsDYX01c99cyP+5sVx+QVZEkgMeBRmKX5L36MYRzZWRftAbuZ2gfAfujdoIFFH52l9RozMxp/9OuoCkKjogJhScd1s9gQak9kFShZ2TqDoAZxGfNTy8zjykbNhjZjr+3gvLrhiA=
Received: from BYAPR03MB4647.namprd03.prod.outlook.com (2603:10b6:a03:12e::16)
 by BN6PR03MB2866.namprd03.prod.outlook.com (2603:10b6:404:111::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.14; Wed, 26 Jan
 2022 14:43:45 +0000
Received: from BYAPR03MB4647.namprd03.prod.outlook.com
 ([fe80::f102:d589:b31b:80db]) by BYAPR03MB4647.namprd03.prod.outlook.com
 ([fe80::f102:d589:b31b:80db%5]) with mapi id 15.20.4909.017; Wed, 26 Jan 2022
 14:43:45 +0000
From:   "Hegbeli, Ciprian" <Ciprian.Hegbeli@analog.com>
To:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: iio_trigger_poll from IRQ thread
Thread-Topic: iio_trigger_poll from IRQ thread
Thread-Index: AdgSwu2LN9BE7QAqSIuVEToB3G7eQw==
Date:   Wed, 26 Jan 2022 14:43:45 +0000
Message-ID: <BYAPR03MB46473D8DDED835EDBDB20A8297209@BYAPR03MB4647.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY2hlZ2JlbGlcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy0yYjQwNTc3Mi03ZWI2LTExZWMtYjZmMS00MTU2NDUwMDAwMzBcYW1lLXRlc3RcMmI0MDU3NzQtN2ViNi0xMWVjLWI2ZjEtNDE1NjQ1MDAwMDMwYm9keS50eHQiIHN6PSIxNjMzIiB0PSIxMzI4NzY4MTc0MjY3NDQ1ODAiIGg9Im96YzlqcVlMdWlvVXRMKzNXcldMZXpaMXBFcz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e6e283e-ab5c-467d-40af-08d9e0da419a
x-ms-traffictypediagnostic: BN6PR03MB2866:EE_
x-microsoft-antispam-prvs: <BN6PR03MB28664AC0AC8FB0748434E51597209@BN6PR03MB2866.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QBFq507wMI0uYNGe39ctCSGzBvmrfeYIv3qlQcnPIcVGiSfTj4k5200HXnl9tHhkfe6DnfXdZx32zaY4dmngxqEr71QRjKbXehBxW6y/IBkUGB6qvpcosda16i/AR3g8XBFFJOgC9Iv7eVIj18ZRhkY8MC+nY+ciqDe983n3biqn6kQjsxdaE3yXRwFw6epXlOr6wM19o9YnPfU/sCOtHl4KG/0axHA+VFH95XyoEyh6B77qMLvy3o7yHPNxVd8iPKZ2kj3K9XJrdZfXFac8ds6T353+95CnK443rEZ2m6y4uGQd9z2LOqgO0snahxAEdt7w+xjRdvU3iiPVb7R302ZyUHrYAy1EpKaO3hhcWrlDUpVZ4asb+Kqp2DGb5cgrPdFFoQbUfeYPOWjtC4ROdKSca3c3PGMVKUNe75eTQX5M7NEPPngRYFcxOZriWR48JVjgdA40Q6DJ9tB2IKWoGimuAbamaLH4S0+99QVPOxjSmo+PtPIQsuA6PthnhvoeFFpxzuY1HKuBjgr9j8yBq/8jQhUgkLNda1ONvtYs/yI3Hy7GRLCARTsuWePFthOmozo+S/kZkNdIxH4vgg0/a7OpOQ3k3P53D+EqiYy8+BjBz+GX87Wjkgz1y4nJqg4QmXsKA/ABcMv9+31XuweEbQIRv97kZzmcX5CHCCh1u04B0FaoUV7SWoHDoCm9G/2uCrAIOQ1CHBo6gompiQdUwA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB4647.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52536014)(9686003)(86362001)(8936002)(33656002)(316002)(45080400002)(26005)(186003)(2906002)(122000001)(508600001)(6916009)(64756008)(5660300002)(66946007)(66556008)(66476007)(76116006)(66446008)(83380400001)(38070700005)(8676002)(6506007)(71200400001)(7696005)(55016003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m/ONeDWWYAfoEotRIBGRnFpCsZZ9ORmaPd0xgPYZR0fVnWBTQwbOhjnTkCf5?=
 =?us-ascii?Q?Pkf2Vr3eYpjMXIwKDO+C2ybr5qZifB7OHtpL2fsqU+eFTP/j7dbBNFfa0PhN?=
 =?us-ascii?Q?AMRRr2M24gsaleYFueYs3jAskJj6/hAUbW4nw/Wxtb+W9e/5rNuPVbVwJ6gB?=
 =?us-ascii?Q?DfI9XvFpI7IK8O7b+eECzb8dVgR7s3pG96QAv2oeZMtZpcKmygkvEVi8UOWV?=
 =?us-ascii?Q?pu6tKHXQ/dBqp8K5GCRmbtqqvNOsToaLYqei/sDnbVotr3TfSGR+1NlM4v58?=
 =?us-ascii?Q?iszSgnLL9bkGtzYeIA28pdsGNWR3VvyIeTOoInTDISf8i8vTqbQjd2DS7mri?=
 =?us-ascii?Q?b8vRfI7S6HlchoCPX9RMJ4Rvuag4GoPNRxSVQeCzaYQjuNQRc/ZL1yraSZfo?=
 =?us-ascii?Q?XKI4XkRLHZqt+bWhzrqxZw6jxzNTVP5mSLthY9/3NALu+Qd+JL7GiP55QM3h?=
 =?us-ascii?Q?AUG0p/HJHNv9YF8FX4CdN7GTeEVFzFSjV9q+W2rZlwul5v57U91WFhLVWaxo?=
 =?us-ascii?Q?Hj6Qk+0Gxvz94DT6D0ZdB1FMD0dsll7Il6g0W7AWMqlTcsC1pwoS6PFzbjTy?=
 =?us-ascii?Q?ynhRPVo9Wb7hCMLqJQ/g7T7v/4TEZbrjnxHCgHc/9w2mF/azUsA5o85Rp/+L?=
 =?us-ascii?Q?eoO8QafUbZgw2WGyPG7GMfkA6GS1EZYMd7PlYPa3myWoZo8tIII1TcDh6HAq?=
 =?us-ascii?Q?heCIaOPm4B9B3F0j68bspKk4XMcpOxmREizNQckqgKw05BQMu0PmM75LB5Bv?=
 =?us-ascii?Q?Zr5eeQF2a0dTpaugHvsRxfgdZPsS6a5hOLb7bii1/df2FL8ijWz+3eTIPJyc?=
 =?us-ascii?Q?iIMi4M/hROA7vn2wUL8CxLZ6gUye3SUHzgGSSw2QMTAYADLEEoAtkl6jgCXI?=
 =?us-ascii?Q?MnT39uvbV8Nj0RHYGfT4n2NANxZn/zRQdrdVSewCnGsrXlWS8Fsc3akoAKNu?=
 =?us-ascii?Q?Q8rM2nkHDBAQ/psotBXmkVHThhaSjszso5ATfMf7tq0+u2uAVv4i54ant1X5?=
 =?us-ascii?Q?6xqN/kGP4INszqfqvclDcHrlL/Kkt9XhUJr9ASJVLPs/5dUVpTZoUWrf3zm9?=
 =?us-ascii?Q?cwXwn85mB3LsMRQ57tMnffleNhEYet4VgiZqchYi+M3hdkvsTEkjff9m2h5o?=
 =?us-ascii?Q?GhmQYIWCu7iym6uETBExPMzDUvPn2YCpMOUqoDrVsnagbWNHluaebw1VTMC8?=
 =?us-ascii?Q?Bwr2Q14Iuv66vnGTijTRjNuDa1eq9fEWjJmhAqLpttsEKhz87Kce0VZZHCy+?=
 =?us-ascii?Q?DsYF+drdxNP6zXY8QUo1fqCqomSCOi9MBaU2NhlXBA1+N99GqGiB0ZIlbFkK?=
 =?us-ascii?Q?h/aAPZaynre108JfjtAfxB2SQgRD2rdQNgZ+pqpAP//RPkbUSh9pej2s06B/?=
 =?us-ascii?Q?EQVvMTH/D8a+HBDnNA3p811MpW4qakkdV5wPlpK5EHq62vuuVg/L6VB4vZMF?=
 =?us-ascii?Q?t1nbnT8iJwpTPYx9jpK4q58XpStlisHrrvNzUgloe/cgqaPOSfRs9Ujr4tih?=
 =?us-ascii?Q?2WRi7q9Q4LiThJ8+K8ALOGj3HzQ8XaUsfU+k3JsjN0qKbsigXS+F8gLT4MGh?=
 =?us-ascii?Q?tqITo4A8ZNcB3tcE87XNAkVf6AbfeZUd9aK7tNQsAIfoAciEwNkLrmTrHHdB?=
 =?us-ascii?Q?dzAwAXyf4yHFEtHzjw3vuBUKh3CI6fVUVo3NcZYUyKk18qtJPs4z3Vdk6YZw?=
 =?us-ascii?Q?M9kJEQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB4647.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e6e283e-ab5c-467d-40af-08d9e0da419a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 14:43:45.6350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: up2QtWPQ7H6I8Inq+CvcqV1WjsKs5uX3pzRW5wSly6BVkIhe7de9SxkbZdUpTjiVnRp3rEydfewOb+2UIPWzr53goLZdDnjID+0wlxd277o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2866
X-Proofpoint-ORIG-GUID: 4Eu42kMTu8pKXFsUo10UkDNNLjqSjjjU
X-Proofpoint-GUID: 4Eu42kMTu8pKXFsUo10UkDNNLjqSjjjU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-26_04,2022-01-26_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 mlxlogscore=482
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201260091
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,=20

I'm currently trying to call iio_trigger_poll from the bottom-half of an in=
terrupt handler and get the following waring;

[  101.814234] WARNING: CPU: 0 PID: 1204 at kernel/irq/handle.c:152 __handl=
e_irq_event_percpu+0x234/0x238
[  101.814255] irq 60 handler irq_default_primary_handler+0x0/0x1c enabled =
interrupts
[  101.814268] Modules linked in: ade9078 cmac rfcomm bnep hci_uart btbcm b=
luetooth ecdh_generic ecc fuse 8021q garp brcmfmac brcmutil cfg80211 v3d rf=
kill spi_bcm2835 gpu_sched raspberrypi_hwmon bcm2835_codec(C) snd_bcm2835(C=
) bcm2835_v4l2(C) bcm2835_isp(C) v4l2_mem2mem bcm2835_mmal_vchiq(C) vc_sm_c=
ma(C) rpivid_mem vc4 uio_pdrv_genirq uio i2c_dev ip_tables x_tables
[  101.814452] CPU: 0 PID: 1204 Comm: irq/58-ade9078 Tainted: G         C  =
      5.4.83-v7l+ #7

This warning occurs only once, the first time it goes through this scenario=
, on a second passing through it I get no warning.
After reading online about it, the problem is related to disabling the inte=
rrupts prior to entering the IIO Handler.=20
By doing this manually I don't get any Warnings, but it has been pointed ou=
t to me that this might not be a good solution.

I'm using the bottom-half of the handler because the interrupt requires rea=
ding the status register of the IC, which can be slow.
Unfortunately there is no way to insert the iio_trigger_poll in the top-hal=
f because all the checks are done in the bottom-half.

The trigger_handler reads the samples from an internal FIFO in the IC, I'm =
not sure if this detail is relevant or not.=20

Regards,
Ciprian
