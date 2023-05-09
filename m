Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1776FCB41
	for <lists+linux-iio@lfdr.de>; Tue,  9 May 2023 18:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjEIQZg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 May 2023 12:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEIQZf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 May 2023 12:25:35 -0400
X-Greylist: delayed 846 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 09 May 2023 09:25:32 PDT
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764ED4216;
        Tue,  9 May 2023 09:25:32 -0700 (PDT)
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
        by mx0b-00549402.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3498hC95022401;
        Tue, 9 May 2023 16:11:03 GMT
Received: from deu01-fr2-obe.outbound.protection.outlook.com (mail-fr2deu01lp2168.outbound.protection.outlook.com [104.47.11.168])
        by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3qf78mruuy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 May 2023 16:11:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cPssUt87RuXLaFQDrhn2nYTpTIyoJMKjCY5WVJyBdsfF0k7MYPZOcrp0/vdVSOn5mELfMlyPxOrMRqM8zFPqghzhALalzx0qwfWhe+Do2bT4ajDuo+BBQsi3p2enhv+Xq4svR0BNNB31zrEjlSB9T/pMXFcdWGPPm8izEfPQrhTsTYd3R/+skVw3OtNgrK3+RFAlJ3+n6XEPhoH3/3xKhQIUFKBWKzEJ1d5REoTOU4GYkc7GZh7zE5wvrav2d4E8qVPVznvC2zn+NJy12rOCfm1FsB35s3/Hm1R43A6BRVNdHADLEpwRixHWu9bnaZ8uxbyS6jg//71wtL9e2oObzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0jgRSWbEFq3MCJACgbPCNMgEyY72xGFJ2VrXr2hfC4A=;
 b=S8UkvuJNS+V/x21yiuu6xKcr9pyZkbGWKCpIh+24gFEN88AA/1mwJhA7ScWEu3fzXMjvButyGK7rXvWcZ0IBMowxvQRKVDcvc/3gxtGdLl3jfB6oHUtxl95PnB3vXrVmxrjsRicBz6YrdryIc4t/EVduIaFXZEoJaqQkiW+CEOEb399PCX/RirJUqrcqytBqKFDNbiUj0rnbpHfAObbLHZWoBKVMSTK1ixX1IhvtyNMO2q5z2KhVhwT9VeTzlEC6/d5aa7ATB+Lsef7GfSwvcaAheZRV5FdIucvjJNlBKJAGCy21k3jxphsZp76N+wQyyIRxVhOiOEVVsOZAmksocg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jgRSWbEFq3MCJACgbPCNMgEyY72xGFJ2VrXr2hfC4A=;
 b=l2TddwMn97D8g1dc3rh6TBPQKmRwDruW5xeLLg+5CVABFiglmy9VjjzjYB3slpKiP+ur4ktIJIZDErga7CbSV+A0pw+ilmrwAOwhjjctixNy8VhOEe5Hwn2faPUYQVIWOYJIpcxa55DuVZ3TzIO7AEYahw9IGG1S30g74thyq//4OXcZXctQkh/bNTGr1bmdkHAMU1nbPPLMxkA3Tw5EnPPES5+HdjbZstYyOEkNZ4ABt2S8imOK9+dXmPB9TPfvK98y7snPULwN2AKoZdRXB7QxsOr0UcOS9NStskI7x83SwOJbCl6NLS3bC4jxcrl+Q4+lX0ElHkXWNiguhiN7Fw==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR0P281MB1580.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:84::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 16:10:55 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::a30a:5ac8:b5a8:68dc]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::a30a:5ac8:b5a8:68dc%6]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 16:10:55 +0000
From:   Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        INV Git Commit <INV.git-commit@tdk.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: inv_icm42600: fix too big timestamp jitter
Thread-Topic: [PATCH] iio: imu: inv_icm42600: fix too big timestamp jitter
Thread-Index: AQHZfm4qIqt46/VnGkyvck0Y2PLwa69NhZwAgASeCCY=
Date:   Tue, 9 May 2023 16:10:55 +0000
Message-ID: <FR3P281MB1757237FB996B85D1FA41E10CE769@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20230504095204.172715-1-inv.git-commit@tdk.com>
 <20230506183606.2674c7d5@jic23-huawei>
In-Reply-To: <20230506183606.2674c7d5@jic23-huawei>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR0P281MB1580:EE_
x-ms-office365-filtering-correlation-id: fcc96026-dc18-4cb9-ca53-08db50a7f839
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N7osNkjAgD0Mief1iMcndUNWIF/sre3r5yxuuafohjlvRs39pMTgPQ6K5w67ID4lGe5QSZAre1bc+0eh3AqK/T5buvsdUrFcqvTAgmd/QGZUHycglITDuTdYV5moaZpk1wpWv3h0BOcSbahTK6duhTJxxFZ6W0v4OP+M2vdgxRQeB8myZ5/VIH7wUQs5k/E95f1xuUafkYHeJqzikODR82OgF1lJOSVoN3zNAXNPeND2ZymiEWFxcsYZHLyAn68DebkrRXIntN/oKJPb3AW+VP0uuHtKQzIWEeG9rfNvB3YS9OYkVmMpiKuBzKr7kD8Kf5T46XaKBmmCy8C4RZ4aYKzvxOaddMvo3VHpU871HPVGZ5X4VErKSab1v8O1slQj1mtZG4nJJcqNc6Gdzzog1mOQVc+qjALyX7CAHPmvjzOhO7DOmI9ok22JfXMw3VhUMLzEoDiZv6kP7o8Lj87qjA/0Pmo4oXvNbMuTehzrxZUXsoagNvzSnP4Q6mJxlvENdCM4nMGb0XV0TtY+/X5Ja+3ZyAzDtn0E55mfuwWEwNAqznMf0CqNvLqe628p/uePoBFePbKa37SBrOuCncT5VL4S79GMeyzM7B+p7pSzUjEQ858hwjJXBjeNCVtl0pvG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(451199021)(86362001)(33656002)(91956017)(316002)(54906003)(110136005)(76116006)(66556008)(6636002)(478600001)(66446008)(7696005)(66946007)(4326008)(66476007)(64756008)(55016003)(2906002)(8936002)(41300700001)(5660300002)(52536014)(8676002)(38100700002)(38070700005)(122000001)(186003)(53546011)(9686003)(83380400001)(6506007)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bPy1231jIvM9gv5Me0GrrC5JMOvgquptmtoXxKrd7NzQlFwqd7XdFDzgwd?=
 =?iso-8859-1?Q?fzg5KGo2m0LwP1zqLrdOULYgpoFdiGO3pXCs55moBrNpCvS2FxGK6gxRm9?=
 =?iso-8859-1?Q?kwgiqfxgwlA47xi0bTvI+BM/AqzKfcm6CuDv4s4W+0f5kcxvs9c9jfaK0V?=
 =?iso-8859-1?Q?zv0UTrkCfKs9PdLDKjpTffY4roVdw0k6uBsWrTaxMiQD/Yp6bEMCe00tJ4?=
 =?iso-8859-1?Q?/rm0CPKE0WZtSNavutOjGav3N+fOPzvA5Va5MAty5S2OXQpM7xbx7t+k4t?=
 =?iso-8859-1?Q?ePDP+DpAIGMVqhb71fMl9PpwnVzv0dpFIofbK/SpRytizrp1c+V7EeN+Fy?=
 =?iso-8859-1?Q?uOK/ZKhGNoDEONztE01W0pjtj0NWpWllc/43JLzSyC0pFJKnN78EZ3YZ2l?=
 =?iso-8859-1?Q?etCbbQz9P/y3gsfqVZAdbUg+Di9GNf4JDZuXgZEXpKMOocOT9iJriFQkxE?=
 =?iso-8859-1?Q?pgiToL6UCuoiJDM07gwNlQG63zGQdubGLNW/0yxRuxwCymw+2g2CbvNfq0?=
 =?iso-8859-1?Q?NApT2rFcVIm4Cv1JejyrWj4i7kBmycHkyYsdB8YDBdEWihrg5dML7wmj6B?=
 =?iso-8859-1?Q?6jiwOxTcGUy0wxmH43BV/J7Wfgs06lZeaTA8197I6KQfBzBJyyqum8h09I?=
 =?iso-8859-1?Q?xOMgNtuA0bZe0z+P3A5jdNdKq6fmXBf4SNtGyLCfQJBG3JXGbClREMUh7I?=
 =?iso-8859-1?Q?lGGHRsGJstDTzHLNaR01rxHrZXdgaXfgh1JXtBmkEvmGZZm5SVisppUgVd?=
 =?iso-8859-1?Q?rw2iHcRomqgPBRgWDWyFBCJCqgwrFRo00j6cDRNE3lKARWc9Iregz8MILz?=
 =?iso-8859-1?Q?t7nCKqnAAME4IjGfeRUpoXDkKY9mehCmvfr5rOIYc2M/ShUsYyjLhZnf9U?=
 =?iso-8859-1?Q?egQ0ZC5ttiObohKa8CJt0Ljdhsh/g4GXuhiz4tM/TnHKGCr5WTS+/9HF3d?=
 =?iso-8859-1?Q?LokWWPodkkS7/iJxbkPXR6ivxA9WAqwHYGcugHvPrl905k24e5YCvXU1zr?=
 =?iso-8859-1?Q?C3OLjyi7s0xKKJAyVVhqJORm0Xw/LNqqozpz9ZO0Y+10bYM9OITKP3o09x?=
 =?iso-8859-1?Q?E5D7QfR5ipz2+sN2usKeTT2l+UtlPUgkz2fJaRwoUda1QZlDUKHpjD7Mch?=
 =?iso-8859-1?Q?DsHeDVT3s4beWCEjeQhakPtLRQTgqHW6glK8pbUQslP/YV2eAAaJLTZ9KR?=
 =?iso-8859-1?Q?wZFplh1IT8qob5FMPcrI5xvtaEKG3p1MPuJYPEbNk8mp9cq+PKnDRuWlzc?=
 =?iso-8859-1?Q?tO79bXOPiK9x59dEc4RA0f/3lftuyNsFCgGvy51uc7PubMA1DGZP5d4xv7?=
 =?iso-8859-1?Q?9tFhqX2LFS3n6hhHXpwJaCZ3yEz3YXCNckzN28ELYBklBzkC2NAMZj/gJT?=
 =?iso-8859-1?Q?Y6vvHuYsNjeRt9PDpA2DbbrNz5/qI8zuej+UJXpMEMS+UcDOItomqpZ2k/?=
 =?iso-8859-1?Q?ksefLCM0X9nx60Bjnph7gI8TxZ/ggrcoyZMdsAezfMzCs/q5gpSyrNjrdI?=
 =?iso-8859-1?Q?ZBWFzfNU9dkUEX+RUDrT8sIvPz+SWLr23xhyJPD0p2hBgRvtIPV/bvIod7?=
 =?iso-8859-1?Q?M42BFzUYvptlAtqz0jei2hXz1qDq/zhWf+KGBpsOMIdpMXUet3ZLN5Rj1Q?=
 =?iso-8859-1?Q?AVv9ZiiorG8uoIdwVIW/esojfZ+gd0rfPbdqiLkWoyNh9eDhZ8pt6BWJah?=
 =?iso-8859-1?Q?WHriJeQY82ZOVjWNP2eKPLgvACpD/Jala3jd2HBetxcFMMAzAdy2RegEDe?=
 =?iso-8859-1?Q?VQwQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc96026-dc18-4cb9-ca53-08db50a7f839
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 16:10:55.7280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M6NQi+VH7pVSCj8ykvQRLlWzQWP34U3ts+4xJwd4XCUKn5x8L1nxUvTfaQIxelruE/lf81j4raZTfNscmceYZ+eabNB4quOGZIac5T5ubT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB1580
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_09,2023-05-05_01,2023-02-09_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Jonathan,=0A=
=0A=
there are indeed a lot of possibilities for handling that. This way is just=
 one among several that keep it simple with the existing code. That's why I=
 was thinking it may be a good idea to backport it.=0A=
=0A=
Instead of synchronizing every time the data timestamp with the IT timestam=
p, and have system jitter jamming the timestamp, let's just synchronize whe=
n the delta is bigger than the acceptable jitter. And keep synchronization =
at the jitter value.=0A=
=0A=
If you don't feel comfortable backporting it, then I can just issue a stand=
ard patch without the Fixes tag.=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
=0A=
From: Jonathan Cameron <jic23@kernel.org>=0A=
Sent: Saturday, May 6, 2023 19:36=0A=
To: INV Git Commit <INV.git-commit@tdk.com>=0A=
Cc: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; lars@metafoo.de =
<lars@metafoo.de>; Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>;=
 stable@vger.kernel.org <stable@vger.kernel.org>=0A=
Subject: Re: [PATCH] iio: imu: inv_icm42600: fix too big timestamp jitter =
=0A=
=A0=0A=
[CAUTION] This is an EXTERNAL email. Do not click links or open attachments=
 unless you recognize the sender and know the content is safe.=0A=
=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
On Thu,=A0 4 May 2023 09:52:04 +0000=0A=
inv.git-commit@tdk.com wrote:=0A=
=0A=
> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
> =0A=
> We are adjusting timestamp with interrupt every time, leading to=0A=
> a lot of jitter in timestamp values. Now the adjustment is done=0A=
> only when the delta is bigger than the jitter.=0A=
> =0A=
> Refactorize code and delete the unnecessary handling of multiple=0A=
> FIFO data.=0A=
> =0A=
> Fixes: ec74ae9fd37c ("iio: imu: inv_icm42600: add accurate timestamping")=
=0A=
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
> Signed-off-by: <inv.git-commit@tdk.com>=0A=
> Cc: <stable@vger.kernel.org>=0A=
=0A=
Hmm. Whilst this may be an improvement, I'm not totally convinced it's=0A=
something we should backport.=0A=
=0A=
Also, there are a lot of possible solutions to this and I'm not sure why=0A=
or if this is the best option.=0A=
=0A=
Perhaps a simple filter on the jitter adjustment to smooth it out?=0A=
Something as simple as adjusting by only 10% of the measured difference=0A=
if it is small might work for example.=A0 Or carry a moving window of=0A=
recently measured jitter and apply some sort of filtering to that.=0A=
Perhaps that would incorporate a 'reset' approach if the measurement is=0A=
way off to allow faster correction if something has gone wrong.=0A=
=0A=
Hence, I'd like more discussion of why this solution in the patch descripti=
on.=0A=
=0A=
> ---=0A=
>=A0 .../imu/inv_icm42600/inv_icm42600_timestamp.c | 49 ++++++++++---------=
=0A=
>=A0 1 file changed, 26 insertions(+), 23 deletions(-)=0A=
> =0A=
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c b/driv=
ers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c=0A=
> index 7f2dc41f807b..af2e59fb7258 100644=0A=
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c=0A=
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c=0A=
> @@ -93,8 +93,8 @@ static bool inv_validate_period(uint32_t period, uint32=
_t mult)=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return false;=0A=
>=A0 }=0A=
>=A0 =0A=
> -static bool inv_compute_chip_period(struct inv_icm42600_timestamp *ts,=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 uint32_t mult, uint32_t period)=0A=
> +static bool inv_update_chip_period(struct inv_icm42600_timestamp *ts,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 uint32_t mult, uint32_t period)=0A=
>=A0 {=0A=
>=A0=A0=A0=A0=A0=A0=A0 uint32_t new_chip_period;=0A=
>=A0 =0A=
> @@ -104,10 +104,31 @@ static bool inv_compute_chip_period(struct inv_icm4=
2600_timestamp *ts,=0A=
>=A0=A0=A0=A0=A0=A0=A0 /* update chip internal period estimation */=0A=
>=A0=A0=A0=A0=A0=A0=A0 new_chip_period =3D period / mult;=0A=
>=A0=A0=A0=A0=A0=A0=A0 inv_update_acc(&ts->chip_period, new_chip_period);=
=0A=
> +=A0=A0=A0=A0 ts->period =3D ts->mult * ts->chip_period.val;=0A=
>=A0 =0A=
>=A0=A0=A0=A0=A0=A0=A0 return true;=0A=
>=A0 }=0A=
>=A0 =0A=
> +static void inv_align_timestamp_it(struct inv_icm42600_timestamp *ts)=0A=
> +{=0A=
> +=A0=A0=A0=A0 int64_t delta, jitter;=0A=
> +=A0=A0=A0=A0 int64_t adjust;=0A=
> +=0A=
> +=A0=A0=A0=A0 /* delta time between last sample and last interrupt */=0A=
> +=A0=A0=A0=A0 delta =3D ts->it.lo - ts->timestamp;=0A=
> +=0A=
> +=A0=A0=A0=A0 /* adjust timestamp while respecting jitter */=0A=
> +=A0=A0=A0=A0 jitter =3D ((int64_t)ts->period * INV_ICM42600_TIMESTAMP_JI=
TTER) / 100;=0A=
> +=A0=A0=A0=A0 if (delta > jitter)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 adjust =3D jitter;=0A=
> +=A0=A0=A0=A0 else if (delta < -jitter)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 adjust =3D -jitter;=0A=
> +=A0=A0=A0=A0 else=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 adjust =3D 0;=0A=
> +=0A=
> +=A0=A0=A0=A0 ts->timestamp +=3D adjust;=0A=
> +}=0A=
> +=0A=
>=A0 void inv_icm42600_timestamp_interrupt(struct inv_icm42600_timestamp *t=
s,=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 uint32_t fifo_period, size_t fifo_n=
b,=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 size_t sensor_nb, int64_t timestamp=
)=0A=
> @@ -116,7 +137,6 @@ void inv_icm42600_timestamp_interrupt(struct inv_icm4=
2600_timestamp *ts,=0A=
>=A0=A0=A0=A0=A0=A0=A0 int64_t delta, interval;=0A=
>=A0=A0=A0=A0=A0=A0=A0 const uint32_t fifo_mult =3D fifo_period / INV_ICM42=
600_TIMESTAMP_PERIOD;=0A=
>=A0=A0=A0=A0=A0=A0=A0 uint32_t period =3D ts->period;=0A=
> -=A0=A0=A0=A0 int32_t m;=0A=
>=A0=A0=A0=A0=A0=A0=A0 bool valid =3D false;=0A=
>=A0 =0A=
>=A0=A0=A0=A0=A0=A0=A0 if (fifo_nb =3D=3D 0)=0A=
> @@ -130,10 +150,7 @@ void inv_icm42600_timestamp_interrupt(struct inv_icm=
42600_timestamp *ts,=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (it->lo !=3D 0) {=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* compute period: delta tim=
e divided by number of samples */=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 period =3D div_s64(delta, fi=
fo_nb);=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 valid =3D inv_compute_chip_period(t=
s, fifo_mult, period);=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* update sensor period if chip int=
ernal period is updated */=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (valid)=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ts->period =
=3D ts->mult * ts->chip_period.val;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 valid =3D inv_update_chip_period(ts=
, fifo_mult, period);=0A=
>=A0=A0=A0=A0=A0=A0=A0 }=0A=
>=A0 =0A=
>=A0=A0=A0=A0=A0=A0=A0 /* no previous data, compute theoritical value from =
interrupt */=0A=
> @@ -145,22 +162,8 @@ void inv_icm42600_timestamp_interrupt(struct inv_icm=
42600_timestamp *ts,=0A=
>=A0=A0=A0=A0=A0=A0=A0 }=0A=
>=A0 =0A=
>=A0=A0=A0=A0=A0=A0=A0 /* if interrupt interval is valid, sync with interru=
pt timestamp */=0A=
> -=A0=A0=A0=A0 if (valid) {=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* compute measured fifo_period */=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fifo_period =3D fifo_mult * ts->chi=
p_period.val;=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* delta time between last sample a=
nd last interrupt */=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 delta =3D it->lo - ts->timestamp;=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* if there are multiple samples, g=
o back to first one */=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 while (delta >=3D (fifo_period * 3 =
/ 2))=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 delta -=3D =
fifo_period;=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* compute maximal adjustment value=
 */=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 m =3D INV_ICM42600_TIMESTAMP_MAX_PE=
RIOD(ts->period) - ts->period;=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (delta > m)=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 delta =3D m=
;=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 else if (delta < -m)=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 delta =3D -=
m;=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ts->timestamp +=3D delta;=0A=
> -=A0=A0=A0=A0 }=0A=
> +=A0=A0=A0=A0 if (valid)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 inv_align_timestamp_it(ts);=0A=
>=A0 }=0A=
>=A0 =0A=
>=A0 void inv_icm42600_timestamp_apply_odr(struct inv_icm42600_timestamp *t=
s,=0A=
