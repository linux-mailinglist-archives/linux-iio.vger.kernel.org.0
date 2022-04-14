Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC34500B8D
	for <lists+linux-iio@lfdr.de>; Thu, 14 Apr 2022 12:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbiDNKya (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 Apr 2022 06:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbiDNKy3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 Apr 2022 06:54:29 -0400
X-Greylist: delayed 960 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Apr 2022 03:52:04 PDT
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658DC47ADA
        for <linux-iio@vger.kernel.org>; Thu, 14 Apr 2022 03:52:03 -0700 (PDT)
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
        by mx0b-00549402.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23E4HWDl011651;
        Thu, 14 Apr 2022 10:35:55 GMT
Received: from deu01-be0-obe.outbound.protection.outlook.com (mail-be0deu01lp2172.outbound.protection.outlook.com [104.47.7.172])
        by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3fe8uqrh77-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Apr 2022 10:35:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1/SkXKThZqksfakbYraQW2BCP0n7wyg7Ol1794W4zJGCu4R60xzI2KVbj3mnDV18cJ4qae65R/DULSnET9C7AIkxysJglFLl0UKKNFheZprbaPWcJrpCtXbMgbZ01FoxV84J1lAnPS84msC6F0mSrfzSnxQzNyXtOYb6RTfoinJQUOA8/fX8DJb2pvm0XiM62IWjpSDgy4UAfY6q2q7Te5Vdu1eHnu/5FbgAqCTFEkjEPy2Mlbfyfa9RtJZg/Z+ezV3aNyfv1itK+Olhsx5+YIshOMwvixy7DO8Zb6CppWfrYeJwRBo0bHNgJQE368/u6mvUylKmHdOw8+zm8jwhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMn6Z+iE/YmFcyfk+0RPPz/npkvWL0SkP5EEBLIvHLU=;
 b=UlEzx07ipgYn8ZJDj+luySuXo1PbJ8jqvRccNmTZMGY84PwCsw1mUDde9yYtih/DRtVeDEHcn0J4izsb1Rv+O5ARRrxLwONk1S4lCAO9B9/YXvn8cSXX4jlfvZL1wEwXyC5BcNv8ZkKQWeCe1p/A3rCfVckvKcCFi9PLa9XcX8uGKEOH5mkiCDj5VAF4GuguMreTve/523RpPnx2i1vdcu77W7p79IQbEGCAWAzyqYXrtZXjZj2vEFq4Lm2hVKiQXcGslmijwNlPlHXXRMADVFqi9BKFoD+KWfqKXvPqqkRCMUPIjRTeGukK69p80Ag4u9rymIFdq8pmfrtkYb+q2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMn6Z+iE/YmFcyfk+0RPPz/npkvWL0SkP5EEBLIvHLU=;
 b=bjOKKLiu+0w5YQiznFwYs6Ch/Wl6u1Dom+hPFHHtZBemENwyR7Y7F4qGB65ibiWvx0DMPmBDGFW2gb7arVJ8IotcIV4rKE0x5Z02xL8Ciru1r3qZRml7hCIhm56iugKCtM+YM8+ccSo1mTXrBaWjwCn2qP2ht5TW3h097zAFxTZ1ToW/Twiou6ff8GqcvpmYzVLCqAXWk3qyx6WULyeRmI45ZI0nECSRH30nGxDca+KfwXEwAaJGc0nMbeNq/hg6QPLQnZsQQeNyHmLMeOZRM9BYCCrhqr/K+S1AVIJCwoAZfUyt5iUrz2lRDhGTrVwxPEsIQCiALKxRc3VrN6/4Kw==
Received: from FRYP281MB0205.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:6::13) by
 FR2P281MB1669.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:8c::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5164.8; Thu, 14 Apr 2022 10:35:52 +0000
Received: from FRYP281MB0205.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ed93:9357:6e55:fa4f]) by FRYP281MB0205.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ed93:9357:6e55:fa4f%9]) with mapi id 15.20.5186.006; Thu, 14 Apr 2022
 10:35:51 +0000
From:   Fawzi Khaber <Fawzi.Khaber@tdk.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: iio: imu new driver
Thread-Topic: iio: imu new driver
Thread-Index: AQHYT+sf/nEc4mRYxEqmVF3LZpkNeg==
Date:   Thu, 14 Apr 2022 10:35:51 +0000
Message-ID: <FRYP281MB020540A2361C4DCDB9F315A694EF9@FRYP281MB0205.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: en-150, fr-FR, en-US
Content-Language: aa
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12223275-37a3-4cc4-d449-08da1e028c4c
x-ms-traffictypediagnostic: FR2P281MB1669:EE_
x-microsoft-antispam-prvs: <FR2P281MB1669A29128030ED02B54EE1094EF9@FR2P281MB1669.DEUP281.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AFbaGrcdhVeuSGcRbTBnt020faeZj4mdzUUD4T5fYN6u2sA7xnu2EL3mc5BLbWpWbxmwSdkmPXlidxawPNmmzLK5/Nvl8LOanoIKfwGCCAciO26KScFX3qQvkNcsn5A/38qTEZR4Uzo2yoUepFsI1qkVIkh+IzsveDwF2A63QeBbGuC4FPHPynPsDb48LpJtmXYyKValky/uO0X0RwJw5eDLLst9FQfdLLcEV6+m9C+O6Cg4jZGSwUMv0WuAImFEsHn5m9DIhNN4v07koKmo8k9uGWBDMUNgsJ9OOUSQ6ttsEIAhfgDUCsd4YmdV/6aOhbeNNXIbq7AWV7f741bjp+065N8sDdJmTsYRShGKjVb+oRLQOUIWI6JK06QaC9x3zRVAH/8Bh3fsFhfruT+CklaY6b6HPf0rhbLIjmwqLnoQVYXAHVKeupkySKSfh6RyqAdfulUwXsMc94qGnP8K0/hJ/OttS30BVfuRKw16M+040m5e3+TMJ+rKszZgXtCnhjH3tQdwc8MJPKBHS/Gf5fo/EDIjB5fY1LkMIz+fO91swRHCCEFIdZKpN/C3umXF4p62XZdNrhtAj4GzD3JpP4AyaJ/h75DDlO7dLx2w+1+NkvaMhj4cJaD9Fd7QieL7598V24J29+jJcYHyMPRcPt1y/B30FtcOBJNFKd0SkeiZ7Rzofgg0/KjHqLVa1/pZfmVNkLk7dt6iueGrdvVs+w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRYP281MB0205.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(8676002)(66946007)(6506007)(7696005)(64756008)(66476007)(38070700005)(54906003)(76116006)(66446008)(66556008)(508600001)(55016003)(9686003)(33656002)(186003)(2906002)(316002)(71200400001)(6916009)(38100700002)(5660300002)(8936002)(7116003)(91956017)(86362001)(122000001)(52536014)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?taDgEBpMxZWcuwKzLBmFNv6F716HaUkJZLME/F+zDir65WSiDhfFZb12I8?=
 =?iso-8859-1?Q?e4a1LzAOG5HlGR4YKWmmhlFMbjzwyaydQnpio2B98pGuD1b16qIxWy7pop?=
 =?iso-8859-1?Q?SUdTs2E2+lEHY8sUF1A5FaCuGB3EGAuFxJIaggTXPs193xxc/UsfeAbkVf?=
 =?iso-8859-1?Q?/S14B4Gu+x4KX+3XIcCclYfu0L+CqvTT+7iG2Jb/GHWQO/y52JqvvxpspT?=
 =?iso-8859-1?Q?xB1WrX3R6rPGzsTX401wDSM0nGgNe1jVw2UejP4Y7EbdTl8tgXsLnnU8+4?=
 =?iso-8859-1?Q?bP0vGErRwzjsmXvA2KKzApcxsYTZ52p5ARNTbjU40K2CasoTbapQ11m7Nz?=
 =?iso-8859-1?Q?DeMtArA7L1ZJi68NhfkwZDnE36BrdPBY/ZAbdCuBA045mqguWOZF0OnOKh?=
 =?iso-8859-1?Q?peWR311QM5sghfZBC1AIQH7XKGsXby168oYiWTTjoGUqQtBZP+Zs7fxpZj?=
 =?iso-8859-1?Q?3u5Ah4zKJvhO5ScahyEP3POaOfzhnrx15ezBcHR5sOnaer1TxngujscgsC?=
 =?iso-8859-1?Q?LGSHkDDpEKJRvWxvCEPB/l6rbpdYjGsaRvDnYjrsaOg0f0mlqBrAigRfbD?=
 =?iso-8859-1?Q?yuW2yFxKvm058HeZWeMYLq2kKlSYILewhsW0aF1jmXXJA+ADApom5klGcc?=
 =?iso-8859-1?Q?tYf99SQoON35LtJrxPg9EdhhfDzniQoDX1jXQ+rVyWP0O91yIbsGdq02SZ?=
 =?iso-8859-1?Q?dPveC2YKV9z7yOaG/MMJmFb+FHF40KJPR0ioSxiHe9wXnfFNNLAQXFJ8Vs?=
 =?iso-8859-1?Q?24Kye9zDheJ8+6dPtk9LReTo9ipVzXVGYbaI/zncEfx8LLVdaJ8/RPIdoR?=
 =?iso-8859-1?Q?WjJi3fQOfVgMc8GRI5y2J3PTSRptDuqcC3ySZWl0tsKTm/b5PNEzE7P5vH?=
 =?iso-8859-1?Q?gFnG7MpqQsxr8FVPRtXyTEgcN7JUxshHjHPa+NDCFq6gxzqXsUubXqVG/v?=
 =?iso-8859-1?Q?EGgk2OgVEjnUqkNkeDmH03Y8/eUv4qotuWaiGw7YTtrAvm+EawLY96XNJC?=
 =?iso-8859-1?Q?pRajV47lo1kfNT8ZNY76NMc9rGwmrlZmGuO2RqDOuLfEaphAl3YttzW7Zj?=
 =?iso-8859-1?Q?NZZkANmEE5CbZuhCgtDwOp2dryhwLlnjfhKE72xMHQUl2/+lny+V3pfcxF?=
 =?iso-8859-1?Q?gSYEMSLs4DJ9Bqd2LnEnHsEUhNFk8K+ScWjXfIE+GYpEdGuGqviw5vV/b2?=
 =?iso-8859-1?Q?SYd4eaY+rcMnH7faBAecKPM2srgpmfT8fJqNQeea3FFw7dhRbJnwvApHEE?=
 =?iso-8859-1?Q?HOyJiPCoQgV/rjnHdIfR+3L6sbD3pKCatTM8BIslnHbiO7OHDDwo9kWDSJ?=
 =?iso-8859-1?Q?4bH9BQWo2POAuw30tqDT6ipN683UfkiDJaXDZ/mwvUlqy2pK6Q2yI8zJDn?=
 =?iso-8859-1?Q?WHOD0zFl/SDjIteXvvJugFvQWRtFZU1zidQ/CEqQWAsIG1ahKBHXskNmC8?=
 =?iso-8859-1?Q?1C2wLIOSVAVIMYoiNeQ5eL6OnSzbfOyerxxXEQ35VcVg1lsWVhpmLvt6d8?=
 =?iso-8859-1?Q?G7AMShqi+V5YHQGc139txSlWj9bB+9goVa7PaUx7AH/wKUp2hoFARYxVpN?=
 =?iso-8859-1?Q?MPXz7ucELnMAh6Hjj1upprcB1uu9q5UtK3go2kHobFwZ6SpzKtyYpkBB5i?=
 =?iso-8859-1?Q?ELiCiF9dym3TCXMLBzA3Ma5VSPvurMGzOw6sAKR3VlakJiNrZBr4X4D4fI?=
 =?iso-8859-1?Q?GZYLN3eGdKldvPyAR0/+J5TIn/tM3996f0f3rB/Kv6BZtxinGU2+NTBHwx?=
 =?iso-8859-1?Q?bsiCxc6bi5TsQjjCCJCgyqPxl0ezvrOHPG0vMpiM9lAtzot7xG4x7tSy9x?=
 =?iso-8859-1?Q?G5/0HcWn2iw7yWoLbGn8BX/NiFFQwEM57U/oelMUUtNuta3tFLMlPj1mhL?=
 =?iso-8859-1?Q?zu?=
x-ms-exchange-antispam-messagedata-1: 8CVgC2RfDMvjUQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FRYP281MB0205.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 12223275-37a3-4cc4-d449-08da1e028c4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2022 10:35:51.8334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6rkhZ+lygJt86kCZRmwITkY/VYVhYMfh4YZZdlBouKN5wMQe3SlcotIfQzxXXGzfX6gzjzIAzeV/Nk/v17w1ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB1669
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-14_02,2022-04-14_01,2022-02-23_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Jonathan,=0A=
We are currently implementing a new driver for an invensense chip similar=
=A0to=A0=0A=
iio/imu/inv_icm42600. The chip has 2 sensors a gyroscope and an=A0=0A=
accelerometer, and we are wandering if it was better the have two=A0=0A=
IIO devices, one for each sensor, or just one IIO device with two buffers.=
=0A=
=0A=
Best regards,=0A=
=0A=
Fawzi.=0A=
