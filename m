Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC62A70188F
	for <lists+linux-iio@lfdr.de>; Sat, 13 May 2023 19:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbjEMRlF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 May 2023 13:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbjEMRlE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 13 May 2023 13:41:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0A010C7;
        Sat, 13 May 2023 10:41:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE1C96160D;
        Sat, 13 May 2023 17:41:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51773C433EF;
        Sat, 13 May 2023 17:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683999661;
        bh=LrUsMWUMg80WTFGGtYzC64Xgm247F7HE4c3L76q1UTs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eB6xoEPPRnerTMZGULsr/aPpMRbHx41Xmo6wW29OQEUkH0n4dgyq4XXyiRBKnZ5Dw
         KXQfX8rd8/Yo8Mqx+jfyJldVG/mPBKTXFL8rAC5N8niAUIDcn2IZm0n+y2DIFWpe/w
         uEB7J70OZ2lddtmiTw3eSwXNt+wGSUbfgpl/6prqfw1ceEkpMmkXiCIrX4SPhfFWYo
         MmabZMKgt5ScHEL5/04WMD2AyqIqHpWvkjZoEuIFAr/nBgmDkf+Cmitqpnu1mp3C/j
         qQo7wmTtBuupkQmfVEaQLjfBQ3NB39FF53y/9WWciljSLPocY+ISVyAV7n7ZPpCDJl
         PbCFgEk6e7fhA==
Date:   Sat, 13 May 2023 18:57:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc:     INV Git Commit <INV.git-commit@tdk.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: inv_icm42600: fix too big timestamp jitter
Message-ID: <20230513185702.76621e40@jic23-huawei>
In-Reply-To: <FR3P281MB1757237FB996B85D1FA41E10CE769@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20230504095204.172715-1-inv.git-commit@tdk.com>
        <20230506183606.2674c7d5@jic23-huawei>
        <FR3P281MB1757237FB996B85D1FA41E10CE769@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 9 May 2023 16:10:55 +0000
Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:

> Hello Jonathan,
>=20
> there are indeed a lot of possibilities for handling that. This way is ju=
st one among several that keep it simple with the existing code. That's why=
 I was thinking it may be a good idea to backport it.
>=20
> Instead of synchronizing every time the data timestamp with the IT timest=
amp, and have system jitter jamming the timestamp, let's just synchronize w=
hen the delta is bigger than the acceptable jitter. And keep synchronizatio=
n at the jitter value.
>=20
> If you don't feel comfortable backporting it, then I can just issue a sta=
ndard patch without the Fixes tag.
Let's let it soak for a while without the fixes tag / backport and rename
to=20
iio..: Avoid frequent timestamp jitter
(if you leave fix in there it will get picked up anyway).

Then if it looks good after it is in mainline we can request a later backpo=
rt.

Also add some of your explanation above on the reasoning to the patch descr=
iption
(simplicity etc). Plus maybe an example of timestamp jitter before and afte=
r.

Jonathan

>=20
> Thanks,
> JB
>=20
>=20
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Saturday, May 6, 2023 19:36
> To: INV Git Commit <INV.git-commit@tdk.com>
> Cc: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; lars@metafoo.d=
e <lars@metafoo.de>; Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com=
>; stable@vger.kernel.org <stable@vger.kernel.org>
> Subject: Re: [PATCH] iio: imu: inv_icm42600: fix too big timestamp jitter=
=20
> =C2=A0
> [CAUTION] This is an EXTERNAL email. Do not click links or open attachmen=
ts unless you recognize the sender and know the content is safe.
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> On Thu,=C2=A0 4 May 2023 09:52:04 +0000
> inv.git-commit@tdk.com wrote:
>=20
> > From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> >=20
> > We are adjusting timestamp with interrupt every time, leading to
> > a lot of jitter in timestamp values. Now the adjustment is done
> > only when the delta is bigger than the jitter.
> >=20
> > Refactorize code and delete the unnecessary handling of multiple
> > FIFO data.
> >=20
> > Fixes: ec74ae9fd37c ("iio: imu: inv_icm42600: add accurate timestamping=
")
> > Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> > Signed-off-by: <inv.git-commit@tdk.com>
> > Cc: <stable@vger.kernel.org> =20
>=20
> Hmm. Whilst this may be an improvement, I'm not totally convinced it's
> something we should backport.
>=20
> Also, there are a lot of possible solutions to this and I'm not sure why
> or if this is the best option.
>=20
> Perhaps a simple filter on the jitter adjustment to smooth it out?
> Something as simple as adjusting by only 10% of the measured difference
> if it is small might work for example.=C2=A0 Or carry a moving window of
> recently measured jitter and apply some sort of filtering to that.
> Perhaps that would incorporate a 'reset' approach if the measurement is
> way off to allow faster correction if something has gone wrong.
>=20
> Hence, I'd like more discussion of why this solution in the patch descrip=
tion.
>=20
> > ---
> >=C2=A0 .../imu/inv_icm42600/inv_icm42600_timestamp.c | 49 ++++++++++----=
-----
> >=C2=A0 1 file changed, 26 insertions(+), 23 deletions(-)
> >=20
> > diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c b/dr=
ivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c
> > index 7f2dc41f807b..af2e59fb7258 100644
> > --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c
> > +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c
> > @@ -93,8 +93,8 @@ static bool inv_validate_period(uint32_t period, uint=
32_t mult)
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return false;
> >=C2=A0 }
> >=C2=A0=20
> > -static bool inv_compute_chip_period(struct inv_icm42600_timestamp *ts,
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t mult, uint32_t pe=
riod)
> > +static bool inv_update_chip_period(struct inv_icm42600_timestamp *ts,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t mult, uint32_t period)
> >=C2=A0 {
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t new_chip_period;
> >=C2=A0=20
> > @@ -104,10 +104,31 @@ static bool inv_compute_chip_period(struct inv_ic=
m42600_timestamp *ts,
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* update chip internal perio=
d estimation */
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 new_chip_period =3D period / =
mult;
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inv_update_acc(&ts->chip_peri=
od, new_chip_period);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ts->period =3D ts->mult * ts->chip_period.val;
> >=C2=A0=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
> >=C2=A0 }
> >=C2=A0=20
> > +static void inv_align_timestamp_it(struct inv_icm42600_timestamp *ts)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int64_t delta, jitter;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int64_t adjust;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* delta time between last sample and last in=
terrupt */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 delta =3D ts->it.lo - ts->timestamp;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* adjust timestamp while respecting jitter */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 jitter =3D ((int64_t)ts->period * INV_ICM4260=
0_TIMESTAMP_JITTER) / 100;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (delta > jitter)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 adjust =3D jitter;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 else if (delta < -jitter)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 adjust =3D -jitter;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 else
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 adjust =3D 0;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ts->timestamp +=3D adjust;
> > +}
> > +
> >=C2=A0 void inv_icm42600_timestamp_interrupt(struct inv_icm42600_timesta=
mp *ts,
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 uint32_t fifo_period, size_t fifo_nb,
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 size_t sensor_nb, int64_t timestamp)
> > @@ -116,7 +137,6 @@ void inv_icm42600_timestamp_interrupt(struct inv_ic=
m42600_timestamp *ts,
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t delta, interval;
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const uint32_t fifo_mult =3D =
fifo_period / INV_ICM42600_TIMESTAMP_PERIOD;
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t period =3D ts->perio=
d;
> > -=C2=A0=C2=A0=C2=A0=C2=A0 int32_t m;
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool valid =3D false;
> >=C2=A0=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (fifo_nb =3D=3D 0)
> > @@ -130,10 +150,7 @@ void inv_icm42600_timestamp_interrupt(struct inv_i=
cm42600_timestamp *ts,
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (it->lo !=3D 0) {
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /* compute period: delta time divided by number of sampl=
es */
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 period =3D div_s64(delta, fifo_nb);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 valid =3D inv_compute_chip_period(ts, fifo_mult, period);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* update sensor period if chip internal period is updated */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (valid)
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ts->period =3D ts->mult=
 * ts->chip_period.val;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 valid =3D inv_update_chip_period(ts, fifo_mult, period);
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >=C2=A0=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* no previous data, compute =
theoritical value from interrupt */
> > @@ -145,22 +162,8 @@ void inv_icm42600_timestamp_interrupt(struct inv_i=
cm42600_timestamp *ts,
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >=C2=A0=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* if interrupt interval is v=
alid, sync with interrupt timestamp */
> > -=C2=A0=C2=A0=C2=A0=C2=A0 if (valid) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* compute measured fifo_period */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 fifo_period =3D fifo_mult * ts->chip_period.val;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* delta time between last sample and last interrupt */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 delta =3D it->lo - ts->timestamp;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* if there are multiple samples, go back to first one */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 while (delta >=3D (fifo_period * 3 / 2))
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 delta -=3D fifo_period;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* compute maximal adjustment value */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 m =3D INV_ICM42600_TIMESTAMP_MAX_PERIOD(ts->period) - ts->period;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (delta > m)
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 delta =3D m;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 else if (delta < -m)
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 delta =3D -m;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ts->timestamp +=3D delta;
> > -=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (valid)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 inv_align_timestamp_it(ts);
> >=C2=A0 }
> >=C2=A0=20
> >=C2=A0 void inv_icm42600_timestamp_apply_odr(struct inv_icm42600_timesta=
mp *ts, =20

