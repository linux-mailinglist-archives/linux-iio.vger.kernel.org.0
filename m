Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A0C725A63
	for <lists+linux-iio@lfdr.de>; Wed,  7 Jun 2023 11:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239013AbjFGJ2j (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Jun 2023 05:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238078AbjFGJ2g (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Jun 2023 05:28:36 -0400
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACAAAA
        for <linux-iio@vger.kernel.org>; Wed,  7 Jun 2023 02:28:33 -0700 (PDT)
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
        by mx0b-00549402.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3579BpR9024981;
        Wed, 7 Jun 2023 09:28:17 GMT
Received: from deu01-be0-obe.outbound.protection.outlook.com (mail-be0deu01lp2169.outbound.protection.outlook.com [104.47.7.169])
        by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3r2afw0kny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jun 2023 09:28:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4iOxJqmud3eP42f+sy3jR/YzwYV0SSIHe4huYrb8elprv/qoQE8gvxyrYCH0BnJOyVWm18m3kIVIKPL8cf8DhHmuq0WyZrFUACWP5lZy/cDwJtS+1zBXngtnjm2dbyp+LKQW4264ZJaLK1zXPdsRTAOv6Q5wfHLZXqBXK/AWlb9Br/Q+QLae7fRrvmJK0IJbDN8OIZKtru5fpiUTT3gvCm4gbY8C22+d6+USHaQME6NjVxoH2Ic26FqARTfClOyNHSEf+ZbGp1WjguxZhJHHIFrXZ+nsmDymjp2q1cua3EuLpCw5hfuJuqnx1bWFFzFg60CkRk8zvNM2kGFw9Tg6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=re1+U/KDRi/8QTOb/w9gFLh7szYzWonfxYfkUFtKqR4=;
 b=MbxzkoNAK0yQSNMk5vJV+Udqg1ccERRMBLSqZZR6XSbJ94rzt/zTMHE9AdGsAZhKc5xF43Uw2sjULSxFwH/AzCm8K7FFk0RiNiM/IlSZOdUa4CI4lEUDihKj10VY5tROIQQBELxoq7a44MP5PgKROVcEwn8pAZO5k4NyQBrPgPkOJl9M4sHXRq0GK9Iapvn0Jrgx+izHOJxzhR9pp3KoECKFdjfAeni6z1ieYnpcAibrGfhUxrKeL5rdK31nyblTIaInXfgtVj0LXbhrqJbjwxmF5klnid87VBw7Y8mGKW6OxPpB+2u/E/0L2UfvN407Vzz9Ph22dmJxOWMTfwagcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=re1+U/KDRi/8QTOb/w9gFLh7szYzWonfxYfkUFtKqR4=;
 b=ikFqGkd3nS/TnRZEfJsBLqDAelrigsKsn+NKtJ2qpWkS5nftDHtrW4637SskwpiEH6XdtFFB1W6EDv3wST7kxHxHPUtgHoU+5wbqTAD6tMigI8/alPd88YXdhmxLKOddzurmpOv16VZIMgBoLUooL4Oex+2pxCL6p1RrSGuztwTUns1gWPrWAhroim72Nnf3MG09Tw6ZPXwjCkydvYynEnPXNH+R7JbPgVnfTOwIxZ+Xhy0snj6gL8snUqyQxf+r08PA/bQMG+hNjmL4sxNTTXBVftCP33mgaz/1w+UQpAFU3zdren+rtx1QsAhIthgrlqXVBLd5u6UPt2LZMnwhNw==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR2P281MB3344.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:67::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 09:28:12 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::c434:2e16:6b03:478d]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::c434:2e16:6b03:478d%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 09:28:12 +0000
From:   Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        INV Git Commit <INV.git-commit@tdk.com>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH v2 0/4] Factorize timestamp module
Thread-Topic: [PATCH v2 0/4] Factorize timestamp module
Thread-Index: AQHZmJMUPtZxqrDqZkSeRph3ZiWta69+4NUAgAAx1sQ=
Date:   Wed, 7 Jun 2023 09:28:12 +0000
Message-ID: <FR3P281MB17572FE25C24840A4030315ACE53A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20230606162147.79667-1-inv.git-commit@tdk.com>
 <ZIAjFMhJbnndgL-G@surfacebook>
In-Reply-To: <ZIAjFMhJbnndgL-G@surfacebook>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR2P281MB3344:EE_
x-ms-office365-filtering-correlation-id: 46f45d1a-82ff-4e07-ed26-08db673983c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GwZzsS9eFDjaTiaDVtPw1a7CGVY6+AbZD/Mtx/2Kv5nStzMgcLTMLsJLAqGGNAaJw+uaE+h2/TBySw+yK76lJAwRw7OgUfoQmAOulAUakJu0qAWF3aGfmf4HcTUj8/UcMFJ9mwiBRsuz9hy8nUgtfhLIiSsHhpBXWXP+BbA5u/o3JYbOQ6Ow29BE3WLl6f+OXJKBjGcRdLR+CPCxRTgK9122P3MiEUgl47mVWcBPrG8BCRfezle+yI5DKnycirgCXGWsf4PBx0o89IYyLdbk+DFsWrYla5r8Olq5gxLyhZT4ulyaypopV3QZRe4KDlyE0chOLSbNP2bfeCWmmiTIeN3ckvV/IbTMCLFCAjouoQOvL5Op7oJFmZpE4DjIuYPluY3z7nU29krV2PNlXUDa2Up/IlMcwse1PIDHFlGhr/WekAuyUfMndckV435bsar/LnzOUC3VhKEUM9Z9SDYPdTQ5p39zLI7EKeLiXZSl0HK3r15DBitlBYOpiwoef8zD38w9144L9d9zrWKaGwXXBY9Ul8DaFgPRtgBsvljsTeL5RiqU7GungZbKd/Lk40UkQP2SHFcZ3GC+hGymC3key2UgNBi8rkoyGEXrmcSucMluh66juMCpDaqIDf9kWa3a
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(39850400004)(136003)(346002)(451199021)(53546011)(9686003)(6506007)(38100700002)(41300700001)(7696005)(186003)(83380400001)(71200400001)(478600001)(110136005)(54906003)(66446008)(91956017)(6636002)(66556008)(64756008)(66476007)(55016003)(76116006)(66946007)(316002)(122000001)(2906002)(8676002)(52536014)(8936002)(5660300002)(4326008)(86362001)(33656002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NjxjJ7mcovRtGBxOSraQ+SQhGHQlR3S0EQPGHC4MMSnftYKN/gb32iA734?=
 =?iso-8859-1?Q?SowRrhyEQfrncMD23aV4l/NolUBzo7JQj2Q4SZ0Da7dIu5CXIjSIyXHO0L?=
 =?iso-8859-1?Q?2Bil2NudDhfAMe3GIaiHdMIaVvuQxEYCuzDD48TTSAeqaNLpLrgbZ9coxo?=
 =?iso-8859-1?Q?WcV4dRMBGY8FitLLqth0y6ncaj+Bu2zv/vZHE4AHCAs9pbvDKUk3YR2ubp?=
 =?iso-8859-1?Q?gCZ0EZqsGQuseNhMDDznrGBdDOkylSHDqp9PGr9EoYv8pbIPUoW5SrHsyM?=
 =?iso-8859-1?Q?ItxgcIpGhyuNbq4n8MyCO/aooiC2ZdW2XnTUo3JpTn+H2SQF0nWvcnB5E9?=
 =?iso-8859-1?Q?GCM+2a34c6eF9EL2DFbugOIzCanEQuHNCh9bhEghZxNZp2N3SxRinXuC3f?=
 =?iso-8859-1?Q?fuK8CspsCv9ppjPRLjln0REijln7pN1KccTrgjT5xc3Ee7HPuJs+gX7aq2?=
 =?iso-8859-1?Q?nlRhMKoyjAhc+OETiMNi1GNICrTkqIFKaoFY8lwUAGo9v4m+M5euhDn8o5?=
 =?iso-8859-1?Q?E9Y+rQOt5ObZMxz4oiVikJTltJDvq9oQtAXowCnbPW2rwlRLWgZxtAoT9K?=
 =?iso-8859-1?Q?4IKw+7LjVMVm9Bb9WDFgFRZ6thFvHIjevinZ2r0qWV5Am5CwKdtdVHNT/P?=
 =?iso-8859-1?Q?Dfi6M/bSEJ/OsmW3cm1bJYkW0D2n2+SHht5dJ/qOJ7Uc2oTeBgToKxQ84J?=
 =?iso-8859-1?Q?nYkpwW9vZZCNHwL6u0QhvWJOGbxevpqEMeR95o/rygR6mP90YFo6yEW58s?=
 =?iso-8859-1?Q?JpG7m//XkGJLpv84pPYn+bWOGXJuXJdbLlUcEBoVQVYHflNWRsgotPg4KI?=
 =?iso-8859-1?Q?Y9z1u130GgmHNIe6AAciMroyPsYFKo5lS0mC0I34ommkfB6JQZniNItUig?=
 =?iso-8859-1?Q?OqjThJ89rJjycfBmcidFVS0TlAOK6SL5jTYQtP7fVLQdJgb2zJr3eTO1cz?=
 =?iso-8859-1?Q?M1DVawVIiv7Lpa99L2L0Da+KGyXQddYGzMcCkd1nLLQHvbF3MpEZfO1Wlz?=
 =?iso-8859-1?Q?ugnCiZH4VnO3bZC4znBySdS1sk5Z8tVofKVDAfjZugY7Z9FqW4qkUVwvbL?=
 =?iso-8859-1?Q?4VyriS4T7XOGRnzawBfvw21yh/dVeGSqb0cxZ7WfgddQflUoXfytyJmztQ?=
 =?iso-8859-1?Q?dk4wCTHE1vVD1pcJzsFS722R1ctgUznTflQLiCvtWQbwReEyB1cquAJ1TL?=
 =?iso-8859-1?Q?Cdpm3qRXXXiP35FgHvEKa0d5Zpflwm6M/zR/Y4kiVkZpMJkIrewR8+4Wt7?=
 =?iso-8859-1?Q?k4jVqJd2jP5pG16A8KVstdrmNXqrSVFA4EC8g4qU94Qoly8inMYJMd3uLa?=
 =?iso-8859-1?Q?69V1oTX/n7upqmrUPkwoBbAiHngNI4kkF5H6+bru9F00Xle1QHfw2KV2bo?=
 =?iso-8859-1?Q?yraxtMoMGDtYy7+SrCw0Kbl4rmwOPSGkeusCmmmi8Rs+uJUF0CaBFDCRcN?=
 =?iso-8859-1?Q?/hb4rtu9svxwpfSQo0CYrkzpK+QmOqqXf1DAnLMvN+fu10H5qhizyFw9Cb?=
 =?iso-8859-1?Q?isAClNr69yrQrUuMgnY18kims8ffgalGhQiHySgmagUqQPKupdW5SZ/ykJ?=
 =?iso-8859-1?Q?XUkhTGK65+k14JGihycFNM/4BIGu3CuLmsq0NUuiS5ze7/P2jAkb7yHHsc?=
 =?iso-8859-1?Q?F8p3H3vCu2CUiuFvGdJxhThR1z5RA3PDXS39AdRf9NMq/Xyy3cqZut47yq?=
 =?iso-8859-1?Q?paIy8sJe1x3AcaxPJdYx5K6Oi2E01/Jlu6XB2H8lCXBOp/B+wW7l/2R27D?=
 =?iso-8859-1?Q?Xs6A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f45d1a-82ff-4e07-ed26-08db673983c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 09:28:12.4127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J/o/36VuJdtA3KkgPb85g+1BlsP6n1unuZolQCmD0WavcHsEgjM1TNxe/bJ0Wg16BdBgwIq/WT+IXn9kj7K1CIr9oAtdkE3jfGcwAmKn+aA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB3344
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_06,2023-06-06_02,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Andy,=0A=
=0A=
really sorry, I forgot to do that. I'm still not very familiar with all the=
 details of the process, sorry.=0A=
=0A=
I will send a new v3 with the Reviewed-by tag. Is it OK like this?=0A=
=0A=
Thanks a lot, and sorry again.=0A=
JB=0A=
=0A=
=0A=
From: andy.shevchenko@gmail.com <andy.shevchenko@gmail.com>=0A=
Sent: Wednesday, June 7, 2023 08:26=0A=
To: INV Git Commit <INV.git-commit@tdk.com>=0A=
Cc: jic23@kernel.org <jic23@kernel.org>; linux-iio@vger.kernel.org <linux-i=
io@vger.kernel.org>; lars@metafoo.de <lars@metafoo.de>; Jean-Baptiste Maney=
rol <Jean-Baptiste.Maneyrol@tdk.com>=0A=
Subject: Re: [PATCH v2 0/4] Factorize timestamp module =0A=
=A0=0A=
[CAUTION] This is an EXTERNAL email. Do not click links or open attachments=
 unless you recognize the sender and know the content is safe.=0A=
=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
Tue, Jun 06, 2023 at 04:21:43PM +0000, inv.git-commit@tdk.com kirjoitti:=0A=
> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
> =0A=
> The purpose if this series is to make timestamping from=0A=
> inv_icm42600 driver an independent module and use it for both=0A=
> inv_icm42600 and inv_mpu6050 drivers.=0A=
> =0A=
> Create a new inv_sensors_timestamp common module based on=0A=
> inv_icm42600 driver and use it in the 2 drivers.=0A=
> =0A=
> WARNING: this patch requires following commit in fixes-togreg=0A=
> bbaae0c79ebd ("iio: imu: inv_icm42600: fix timestamp reset")=0A=
=0A=
> Changelog=0A=
> - v2: do some headers cleanup and add some justifications in=0A=
>=A0=A0=A0=A0=A0=A0 the patches descriptions.=0A=
=0A=
What I haven't noticed is my tag. It's your responsibility to add given tag=
 and=0A=
it's polite to Cc to the reviewers (but this will imply by the tag anyway i=
n=0A=
this case).=0A=
=0A=
Any explanation why did you do so?=0A=
=0A=
-- =0A=
With Best Regards,=0A=
Andy Shevchenko=0A=
=0A=
