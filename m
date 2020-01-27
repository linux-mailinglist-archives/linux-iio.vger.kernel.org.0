Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4722D14A5A0
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2020 15:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgA0OCH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Jan 2020 09:02:07 -0500
Received: from mail.andi.de1.cc ([85.214.55.253]:35176 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727177AbgA0OCH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 27 Jan 2020 09:02:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LQaQHhSfH+sdElaYG2t4bwuZkno397hqKjUJr+Nywhc=; b=FYZZT5KIWLuwe4lfQSfO73bGe
        hvlKQKtQk3udLJjRRhOELpAITa8OIkXy5c/hXlYC8c9suhPUnSJ4AEnUVZMsatemtSvzI7iyf2NYt
        tW+4H990JTXdA8gspRMYjRUgqwToHu04XYeDx5yhO/tfzDPSNOEkDAqc+XoBerBhkN7WU=;
Received: from [2a02:790:ff:1019:7ee9:d3ff:fe1f:a246] (helo=localhost)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1iw4xg-0000LB-0N; Mon, 27 Jan 2020 15:01:57 +0100
Received: from [::1] (helo=localhost)
        by eeepc with esmtp (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1iw2MQ-0007E3-54; Mon, 27 Jan 2020 12:15:18 +0100
Date:   Mon, 27 Jan 2020 12:15:11 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, b.galvani@gmail.com, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        phh@phh.me, stefan@agner.ch, letux-kernel@openphoenux.org
Subject: Re: [PATCH 2/5] mfd: rn5t618: add ADC subdevice for RC5T619
Message-ID: <20200127121422.66f4f3e8@kemnade.info>
In-Reply-To: <20200127092815.GA3548@dell>
References: <20200117215926.15194-1-andreas@kemnade.info>
        <20200117215926.15194-3-andreas@kemnade.info>
        <20200120084934.GZ15507@dell>
        <20200124162818.0697f551@kemnade.info>
        <20200127092815.GA3548@dell>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/AnyB9TPe_XHn_KVZv1oPKe_"; protocol="application/pgp-signature"
X-Spam-Score: -1.0 (-)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

--Sig_/AnyB9TPe_XHn_KVZv1oPKe_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Jan 2020 09:28:15 +0000
Lee Jones <lee.jones@linaro.org> wrote:

> On Fri, 24 Jan 2020, Andreas Kemnade wrote:
> > hmm, I cannot find this in any branch/repo I know of and not in linux-n=
ext,
> > just wondering...
> > I guess the iio part is something to go towards 5.7 unless 5.5
> > is delayed mucch. =20
>=20
> Oh, it looks like there was a conflict.  Could you collect any Acks
> (including mine) rebase and resend please?
>=20
on what? It is based on top of my RTC v5 patch series. The ADC series
as a whole depends on that build-time and runtime as documented in
the cover letter. Maybe I should have put it into the patches itself.
I have hopefully addressed every comment in the v5 series.

Regards,
Andreas

--Sig_/AnyB9TPe_XHn_KVZv1oPKe_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAl4uxj8ACgkQl4jFM1s/
ye9Trg/8DZtbTzYhniGrVYebXsC7fhf62BAwRTbAFR/7TnyrgurRe2CZT01DFIYJ
gO0ZlaH0A+ouoxen85wdKyNIZfEvRJjZFjg3XNfXCQ1xk7oz0Zn7abzTDsoJFNFC
iOnSYVSmBehBsRtza0vodN4KadAFqLKiPYca/3/TnzCBdnWJukOzYgmSRvjHKqqo
h99XAKlr6Sw1oYjxUwyTt4Gl0ynvf7CaLSJoHcKsVaAeSONAcsyq/hQjDGf5Fygy
Fm1RNTvUtf1jXnYiskLgKreHulRy7b303N6CW8KdWbe/NF1UTULloaudmneCcsrJ
PvtNQW5U6JxOHNARJe+6J5X+VaT13hnVjxwzSUYA/l7qF30y94b5YrUkV6AVkgGn
Qxhhk9bnY8/S1d25KQqBzQRur++d6sdr3yB7WA0jF7zB+u0CU7xY+Z5wtKHHbvBU
UUBkC7HfCRLIh6WH3PuU1XR6zQA+IFDH2RScYr9fYWgQHzHbGHaGTycs2xjj304j
mjHgn+06tB40lE8Ixw9aNMURU+wdNJPYSJLKTHsoI2HZHxMAAODSgZk1czYV/xkz
WpkBoQ6AzmxptY61PhMgR1YB/Hu2tNJyR9I5Z9NuJro7exYeVEU77T5qUCSgHY8D
FWmJA4LmlWNZ1lqhZUbQVE+w7UZQjHqDVOlyjdbh889RhrcWUZE=
=Ssrt
-----END PGP SIGNATURE-----

--Sig_/AnyB9TPe_XHn_KVZv1oPKe_--
