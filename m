Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79EA9722FC7
	for <lists+linux-iio@lfdr.de>; Mon,  5 Jun 2023 21:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjFET0D (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Jun 2023 15:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235014AbjFET0B (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Jun 2023 15:26:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EAFA7
        for <linux-iio@vger.kernel.org>; Mon,  5 Jun 2023 12:26:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0254D62992
        for <linux-iio@vger.kernel.org>; Mon,  5 Jun 2023 19:26:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77DC8C433EF;
        Mon,  5 Jun 2023 19:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685993159;
        bh=Yy9kjeAVSmKRIUabWoAwMIUl7gCQLYlWA/5Vddo3Pu0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=isexQFdd6lbaK+f5QDCszCToz4ijrMks5LEA2uPDYPec1IohjOSA4y8DQ5k495L0+
         gtCTDqYHc0PSvd8y+X28xcLCMdUWk/y8shaS+K62ae0/cQ0RKNEhYyHoc47ZFH/jTh
         InLMac8v3lKL2PTU8JkTT7pvTC3U06Wh6LquueKPN2GNJQKEJV/7D8jeS6WJ8fVT3D
         epZoxFj/8YvilAW7KqGwjNtH0gPNCLsfQ+wefbkrsHcc+qJH9pNbk1nETdx89WkpTC
         iIlSzbdq05ZEkbeHocz63j1IV59YbeUw2umSBVDGnUFvvm0sOUDZy9AGvFph7YTkCI
         HG6PjF2l601Vg==
Date:   Mon, 5 Jun 2023 20:25:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc:     INV Git Commit <INV.git-commit@tdk.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH 4/4] iio: imu: inv_mpu6050: use the common inv_sensors
 timestamp module
Message-ID: <20230605202557.39fadde1@jic23-huawei>
In-Reply-To: <FR3P281MB1757DAD04BEEDB322391DB83CE4DA@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20230531142513.48507-1-inv.git-commit@tdk.com>
        <20230531142513.48507-5-inv.git-commit@tdk.com>
        <20230604120810.087ae732@jic23-huawei>
        <FR3P281MB1757DAD04BEEDB322391DB83CE4DA@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
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

On Mon, 5 Jun 2023 19:09:51 +0000
Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:

> Hi Jonathan,
>=20
> the 2 algorithms are very similar, but the new one in module is better (l=
ess jitter, better average value using a moving window, ...).
>=20
> So switching to the new one will lead to better timestamping, while keepi=
ng a very similar approach.
That's fine. Add this info to the patch description for next version.

Thanks,

Jonathan

>=20
> Thanks,
> JB
>=20
>=20
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Sunday, June 4, 2023 13:08
> To: INV Git Commit <INV.git-commit@tdk.com>
> Cc: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; lars@metafoo.d=
e <lars@metafoo.de>; Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
> Subject: Re: [PATCH 4/4] iio: imu: inv_mpu6050: use the common inv_sensor=
s timestamp module=20
> =C2=A0
> [CAUTION] This is an EXTERNAL email. Do not click links or open attachmen=
ts unless you recognize the sender and know the content is safe.
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> On Wed, 31 May 2023 14:25:13 +0000
> inv.git-commit@tdk.com wrote:
>=20
> > From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> >=20
> > Replace timestamping by the new common inv_sensors timestamp
> > module. =20
> Are there functional changes as a result of this, or were the two
> algorithms identical?
>=20
> I don't mind changes, but should call out if there are any when
> unifying code like this,
>=20
> Jonathan
>=20
> >=20
> > Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com =
=20

