Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C4C502E76
	for <lists+linux-iio@lfdr.de>; Fri, 15 Apr 2022 19:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343970AbiDORzz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Apr 2022 13:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244359AbiDORzy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Apr 2022 13:55:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8178CDAFFC
        for <linux-iio@vger.kernel.org>; Fri, 15 Apr 2022 10:53:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D19A622FD
        for <linux-iio@vger.kernel.org>; Fri, 15 Apr 2022 17:53:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45F8C385A5;
        Fri, 15 Apr 2022 17:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650045204;
        bh=5+IEmpSS1GjiVuIKakf9YP/oN2rx7cw3sbeO4zyGZfE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D14O2ra5AQN39+R5kynBOQTCqClD2V3c3Q1JAhOybpmqMicj0j1qVFNgmC6JDfzoA
         B4BJU5odhDYF/y4A+CreWes+zdNVebPS6ad4zDNQx5KHots5xeriyfNlmZFRnSJ+mG
         FFp6rt6shAcvE6uM4KZe3Xoi/QX54BYlrZcAhCbJgtm8ICDc9DFxVLpb/hwmlqId3O
         Gysrez2VrlUkH/NcjdA6kNpZA4e9CrhXz6/r+Z1PSahHgGzPu0kW6aXt09AZ1BxNmo
         0z6SDHXCVvSLAO6jaw9htAJjXGNtvtcLw/JZ4s4p5N3lBhdDeiUNRO3Jg9XS/LvsoT
         jlskYtYqZE4WA==
Date:   Fri, 15 Apr 2022 19:01:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Fawzi Khaber <Fawzi.Khaber@tdk.com>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: iio: imu new driver
Message-ID: <20220415190122.0c36b6d7@jic23-huawei>
In-Reply-To: <FR3P281MB175790BCD24EC802E3B22EC8CEEF9@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <FRYP281MB020540A2361C4DCDB9F315A694EF9@FRYP281MB0205.DEUP281.PROD.OUTLOOK.COM>
        <89c89115-334b-27ae-413c-73b3006d3ffa@metafoo.de>
        <FR3P281MB175790BCD24EC802E3B22EC8CEEF9@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
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

On Thu, 14 Apr 2022 13:03:28 +0000
Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:

> Hello,
>=20
> accel and gyro are synchronized and are outputting data inside the same h=
ardware FIFO, as inv_icm42600 is doing. The issue is that the sensors have =
different frequencies, using a header for signaling data availability, thus=
 demultiplexing from userspace is not possible in a standard way.
>=20
> Solution found for inv_icm42600 was to use 2 devices with each one a buff=
er. FIFO is read, data demultiplexed, and sent in each device. Now that we =
can have 2 buffers for 1 device, is it simpler to use this solution rather =
than 2 devices?
>=20

yes.  I'd go with two buffers, one device now we have the option to do that.
You 'could' do something special to allow the case where the sampling rates=
 are
equal if that is sufficiently interesting but so far I don't think we have
any drivers doing that sort of thing.

Roughly speaking it would mean two buffers:
1) Buffer A: All channels present - but you could only enable them all
   if the sampling frequencies match.
2) Buffer B: Other channels with separate sampling frequencies.

Then a user could in theory pick the best of all possible worlds.
I'm assuming that there are truely synchronised modes, but there
are device out there where the sensors are independently clocked
and just push into a common front end buffer. If it's one of those
then this trick wouldn't work.

Note I wouldn't enable this initially in the drive anyway as its
going to be complex - start off with two buffers and get that upstream
first.

Thanks,

Jonathan

> Thanks for your advice,
> JB
>=20
>=20
> From: Lars-Peter Clausen <lars@metafoo.de>
> Sent: Thursday, April 14, 2022 13:19
> To: Fawzi Khaber <Fawzi.Khaber@tdk.com>; jic23@kernel.org <jic23@kernel.o=
rg>
> Cc: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>; linux-iio <l=
inux-iio@vger.kernel.org>
> Subject: Re: iio: imu new driver=20
> =C2=A0
> [CAUTION] This is EXTERNAL email. Do not click any links or open attachme=
nts unless you recognize the sender and know the content is safe.
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> On 4/14/22 12:35, Fawzi Khaber wrote:
> > Hello Jonathan,
> > We are currently implementing a new driver for an invensense chip simil=
ar=C2=A0to
> > iio/imu/inv_icm42600. The chip has 2 sensors a gyroscope and an
> > accelerometer, and we are wandering if it was better the have two
> > IIO devices, one for each sensor, or just one IIO device with two buffe=
rs. =20
>=20
> Are these two completely independent sensors that only sit in the same=20
> package or do they share a common clock and the data acquisition can be=20
> synchronized?
>=20
> If it is the latter the best might be to have a single device with a=20
> single buffer.
>=20
> Typical algorithms that process IMU data, like odometry, want to process=
=20
> the accelerator and gyroscope data jointly. If the data gets=20
> artificially separated into two buffers it first has to be re-aligned,=20
> which might be tricky to do.
>=20
> - Lars

