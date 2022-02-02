Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA18A4A6F2B
	for <lists+linux-iio@lfdr.de>; Wed,  2 Feb 2022 11:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiBBKs4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Feb 2022 05:48:56 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:10448 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229629AbiBBKsz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Feb 2022 05:48:55 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2120hbld012774
        for <linux-iio@vger.kernel.org>; Wed, 2 Feb 2022 05:48:55 -0500
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3dxdaf682r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-iio@vger.kernel.org>; Wed, 02 Feb 2022 05:48:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGPiBrrErpmSoyjcgww6IGjOIl5joqP8FKaTqGz9s30DrxLm04Iugo7tdE7PWBHwWEH2V4Ym2NltASC9aQP9JqTn2k/1onbHhK8Smj829xyzXcMVhVwxDvw30Yb/sWJEl0AFk2zdkb8TzP7XaQwn9/KXfDx8dA5hsGys5f5oh4l0tCoZNkU5twux+V/2zipOtX3odtonfC1rYbd4mHyJQl/X/qEz2KPa+Hsi2oMbachTe0bkMY64857uETiBlO4wpkiepRT6oEQSFD+pTliKhIiF1etxZ1Vf5up5as37BM+ekjRlEfm1hI9Bz2ENPySoBm0Ba2C0w06q20213/hL4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15EPsSOFZ1ZcjGjvY+jsF/lC9RcA5CfeTZ4IzTxmxjo=;
 b=kjgEXgfhMHG4Uu94gBGilnxBz982uNnG8+NWW+L4/1le3lr9VNuSklYHZMh2HEb7ZpvIqGaOVTA24fNj/eGr7saVPfdnv7tZQ3MI9cy0QrlhhIbO0GPx6NwfsmsES7Fe3N5ruEpuDrCGiMPvdIwXlZUfuQMXAk3enrxYbwZXQ3XoSI8pEIi40wggBx6qBY/TgQ08Ee35rizqLZdtRlkrDl5jF3ZFB85Y0os5oFTILivOhQbJsmF3IyJ7klz0kuYUYERSxbPNxNokyhS0ZuQzNzrpx0FXsM2I1vYE+eVyIk7xVhuLUFRiEF6F1Eriayk8St90bq4OmY9xdx+2L+zwCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15EPsSOFZ1ZcjGjvY+jsF/lC9RcA5CfeTZ4IzTxmxjo=;
 b=FEmD0EX5DPvlkme6APcXnDQnHt2ybBLVhhnSFHQv+mZhsOJrDvjwPeIKZwirzeUa/RlJdtp9RUAlZULA1mTUUrg1cWJSmbR/vF3TC3IooOrojMWD9jkqtAJFHRnacjZ9H4LhrQGbtGAglkdbFwtF0boJmE8xcIY5cZPVAJ9QOrM=
Received: from BYAPR03MB4647.namprd03.prod.outlook.com (2603:10b6:a03:12e::16)
 by CY4PR03MB2565.namprd03.prod.outlook.com (2603:10b6:903:69::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Wed, 2 Feb
 2022 10:48:52 +0000
Received: from BYAPR03MB4647.namprd03.prod.outlook.com
 ([fe80::4c2b:db85:7b4:d97]) by BYAPR03MB4647.namprd03.prod.outlook.com
 ([fe80::4c2b:db85:7b4:d97%6]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 10:48:51 +0000
From:   "Hegbeli, Ciprian" <Ciprian.Hegbeli@analog.com>
To:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: CHECK: Macro argument reuse
Thread-Topic: CHECK: Macro argument reuse
Thread-Index: AdgYIYt25BMYYScDTHe+gXdX/WJ/uA==
Date:   Wed, 2 Feb 2022 10:48:51 +0000
Message-ID: <BYAPR03MB46478624466527B5263B83FF97279@BYAPR03MB4647.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY2hlZ2JlbGlcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy04MDZlMzk5Zi04NDE1LTExZWMtYjZmNS00MTU2NDUwMDAwMzBcYW1lLXRlc3RcODA2ZTM5YTAtODQxNS0xMWVjLWI2ZjUtNDE1NjQ1MDAwMDMwYm9keS50eHQiIHN6PSI4NjIiIHQ9IjEzMjg4MjcyNDQzNjkyNzc2MiIgaD0iVGk1Y2xUaUNTVU50dEp1b3Y3bnlTTkx6dTN3PSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3c7e35c-c2b0-404c-5aa4-08d9e63999f8
x-ms-traffictypediagnostic: CY4PR03MB2565:EE_
x-microsoft-antispam-prvs: <CY4PR03MB2565618B7D51D0168A04651297279@CY4PR03MB2565.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UMJgD+ZT0XwhQONkC9ulnQsSdQ96ZvumxZca2qQAWRLAJiEJ6VvyzzxOkGrE1y4b4QSgj2pRJFcQw+RzQDq53TVnYZweB6rqqWy41iCtmRuOlwDPNy91IEVvYMn1pcGK1b9Bt/NwEztzpBu11jjMO+Vx1edlqDAE3rOIW4BcWGZ+5PZT+gb+5lawmLWvbq8x3L259Pcnd8oGi1rFxEB99O2V8TzvDfb1VizGle17AQIrxYOgzAN5yf/WLB2xH+LJ2lg5/f8EFBm5n3zax1FBroXeGsbhT3mr+oeTLB9IPCcYTDlcU+TQgvRok0p+TiOQQg/3iBa/5y3oo2I7+QqsmjSpFW+bBlKvqJ2ZuRq3AgrRdU5603FfsDaH3QdNE9t1VxQm5hXmBFh/cfKr0GlgK7PLWPfLKduUYNdqI/6OdfWA5Nh08REPI5P13b5ydo9A12Pomd4kEvgpOE1fBew26lfsM1CTcgUynbKnRrWaeBANymnT3oWyIKtEAwNlBsvue5PoApnJCs8NijBixCUwLBeSXbi+CBRYtTCySzfmFyIv3v3RHkDeueSRHAAuv4uifJ8F9J8vwukQEvsRmX3rxgOGvEEckzbIDbEWMAmHNOSACk/fqDO8eKDFc9XH5hYsAqJHfTSZGPVRUJqdvVFBEIIzdyKEOQkrKnITTgcHhE2P1xLckjQmmro7XGuhuFiywHt2RbZvkO0BlqH1FXgMuQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB4647.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(55016003)(66946007)(508600001)(38100700002)(71200400001)(6506007)(33656002)(86362001)(66556008)(64756008)(76116006)(8936002)(66446008)(8676002)(66476007)(7696005)(52536014)(5660300002)(9686003)(122000001)(6916009)(186003)(316002)(2906002)(4744005)(83380400001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?taL0bhuncb6imZS/2Ok5N595dtTJ8yL3sBjYcDvxQUNk6YpzPsDio5nepwTN?=
 =?us-ascii?Q?sCTKFexF9xIf/irjrV9TLrhprsn/BaRe1Aytsx3eLW1gqWAuErq/rQH7L5pG?=
 =?us-ascii?Q?xkhcKefetamJ4qd6LbpcWjXB4aai9DGP0SJM5JyCmwIgxeWsDrlxmDk3GiD4?=
 =?us-ascii?Q?XBr9DrFIMkCKCuYUlNGURYAHBXZCxnz+NPz6V4pC56qd38S4ObQl8IxzfPGT?=
 =?us-ascii?Q?Tpu7Dn/CYe91Wjxkr2PCGd5sYK5N/8MonX32/gWGef/JOMJY+HLoWJpsE5X4?=
 =?us-ascii?Q?8crAZCAyiQgnYRJJajGMgTR9P1Yhbgp3H+aGcIWutv0+qCHPz24F9PLTXhHJ?=
 =?us-ascii?Q?sJbmKmiObzHwsBkDcjf1SX77MxfmH7wXxSSnasEgno2kCqSX25BYQTYXePwa?=
 =?us-ascii?Q?jMNE4gCi8p7KFLrM8vJkp0yrzXheyE+8sUYj86uPqdJZnFTNPY6G0dhHGwrG?=
 =?us-ascii?Q?AAcXU/JBSCoIRv2KWgmMFkfMXxAMIijyNAcTMHbaKrZuTK/xa3e4ec4h3Rrp?=
 =?us-ascii?Q?gdTpvTSzCfXLVm4WFQAugnTSPV5MaD0lLsfZhW605LmjF5d2citAloS2eel0?=
 =?us-ascii?Q?W/7Y/Tty5WOSLB57niAu6jBAPXWdDw0WxZBAN03HwlPcghjuzXNQKNOc1NGP?=
 =?us-ascii?Q?0T6M/GiWa0s1xBqvDlHXHFujL3PegPkVaPNyZL+uumuHE5/ed0dFbTR+4f2x?=
 =?us-ascii?Q?wcqcEj2WsD/NQ57k6enNX2K98SvtsLFvnhERrnYuBXnBYxZ43H4GE5jo6XS3?=
 =?us-ascii?Q?oRZa1wq8D3jgQrtq4Kwy8C1MeOOwvhJXbxOUWrbjdpvTFJF7VRTQ+KQYY02B?=
 =?us-ascii?Q?SuplT2q6nuSIySYqe2pYVdB4BuTrDmT3scvEvxfUo4pqkZD58ZVaPndM8qh4?=
 =?us-ascii?Q?DtrjWJDHaRKLBKcluOIBxNEFK7hOq5ScmALlsUy6nJjyonF43DB4NFzupbsn?=
 =?us-ascii?Q?BTO4tYEHbeXLhL/J8AfD7vKJJ5asDjKJL2I/oYoTSKaAU/XMktgugicHtUf9?=
 =?us-ascii?Q?JQl8Opz3WV5BqBF0YJZzOoAU3owg8o7U4qksi/l/+QbtFT7lvlQI8uqO/3o0?=
 =?us-ascii?Q?FakzsLUF7IDm0RHUTBUZwkmH61vvHokKmy1oE1mHXQE7ScpSLs5P/K1gbsQ3?=
 =?us-ascii?Q?a5haQCOLkTtdUu6Ev2ZgaUQnhz+wMmV0/HX0YCV84bvJdboTnfsbP6tOtxWg?=
 =?us-ascii?Q?jBzCB8izpvK6ybNo9KFwLNt7Eo0e4xlXv0lp7gPBP7+i4/FnzK5cjsmkq1I/?=
 =?us-ascii?Q?0OHIJdK2yl1T7OgOULsSZNN5UC7A+9fhdwDvZVuBiLLt0IvVli0oEvFFH7P+?=
 =?us-ascii?Q?Gqmj3gM/HChpX02m6J1pSoPDBXzqQ3xgbs8NLWheHpeg5dSlr73pKSR4x3Ye?=
 =?us-ascii?Q?8+EniU/a9gOIfnTA+U/Y26QzVSZ8n4b/fpNJDqzrAGyBfH8FmHgd51q5gx8F?=
 =?us-ascii?Q?t1njfT2GChP3LH8D+uB1hcTS0PSG9zrKuvI84lZyWdpwTMBkK4Y4uuYNw058?=
 =?us-ascii?Q?Xu6sBE3GqAmVVVzkuwl5OZWcoq+r7pdlgNsewaS6+HcMI77pAjcCL/U1cIlh?=
 =?us-ascii?Q?BlUoznv4TRAYrMcJZdFfc0c+Tr2wQdlAS/1lFLw70OUsgqtULaPObn0ARVqD?=
 =?us-ascii?Q?TJU6PKi9oQxWztTUH5rYD988nHuhAl13GSrRYf7fnSReG/Hatcw1u7Dlj6Ni?=
 =?us-ascii?Q?8ZlEVQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB4647.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c7e35c-c2b0-404c-5aa4-08d9e63999f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 10:48:51.8319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +4aek2bkV3MA9QEToGKeMDLjQsqjudkIO0spKc0TfoTyTFgWt9DDRYY8N1kGenAhu6PHqqvQQqEEiEgjbzFlgZtTyPMvNhTs7DbrHOpobAI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2565
X-Proofpoint-GUID: XWzjN2JIfZ9l1mCouNLON-cgl2ZV5hVO
X-Proofpoint-ORIG-GUID: XWzjN2JIfZ9l1mCouNLON-cgl2ZV5hVO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-02_05,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=673
 priorityscore=1501 mlxscore=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020057
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

The driver I'm working on has channels which can be configured similarly bu=
t with small changes. In order to simplify the code, I used macros with arg=
uments for the parts that are different.
Unfortunately this leads to warnings during the checkpatch with --strict .

CHECK: Macro argument reuse 'num' - possible side-effects?
+#define ADE9078_POWER_FACTOR_CHANNEL(num, name) {		\
+	.type =3D IIO_POWER,						\
+	.channel =3D num,							\
+	.address =3D ADE9078_ADDR_ADJUST(ADE9078_REG_APF, num),	\
+	.extend_name =3D name "_factor",				\
+	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |		\
+			             BIT(IIO_CHAN_INFO_SCALE),		\
+	.scan_index =3D -1						\
+}

Is there any way to fix this warning without adding more arguments?
In this case, can it be ignored?

Regards,
Ciprian

