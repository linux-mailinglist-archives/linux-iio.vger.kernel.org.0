Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31D1E358279
	for <lists+linux-iio@lfdr.de>; Thu,  8 Apr 2021 13:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhDHLw4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 8 Apr 2021 07:52:56 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:47303 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230434AbhDHLwz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 8 Apr 2021 07:52:55 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4FGKQ32Ny4z9sWX;
        Thu,  8 Apr 2021 21:52:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1617882763;
        bh=vaVOaNQUQA4jBhdsNmiMbje2bWk/8F6Ax4uWZzUwNAE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O8Z6ToB06cWzCRd/AI45KorAMQL/d2brIkbrp2t3kZkMwynjxKa3YsYFilCk97P4a
         KJipo98rSMf+VUdriYJOCZyS9BftaC9fldNRGV0ndYQHBqcHbyvKLn/qn1VS3PnoNy
         Weg7Qwy+0mztxN0L9IMAkw2ZrEA9tJBjLkEIrsukqnFO+jFQOir9MuuHDiL096aYqU
         x0gDWxai9ruBfg5qFQI1JJO+TgFD6jgGbrE51CKR4ZLl1+yXmOgtpWQcodv1QoTZuF
         RaGNI+fJ7a5TV8lcwxwU7voPmr6rIwEs6m6dWdAqTDFrREGhd/SlfRSzJBytzJznNV
         xSzk4O+doiT9Q==
Date:   Thu, 8 Apr 2021 21:52:42 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>
Subject: Re: Add IIO trees to linux-next
Message-ID: <20210408215242.2d5744ad@canb.auug.org.au>
In-Reply-To: <20210407140523.00004a70@Huawei.com>
References: <20210407140523.00004a70@Huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/v9pU7tOPwO7UmPWvnS=99Pq";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

--Sig_/v9pU7tOPwO7UmPWvnS=99Pq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Wed, 7 Apr 2021 14:05:23 +0100 Jonathan Cameron <Jonathan.Cameron@Huawei=
.com> wrote:
>
> I would like to request adding the following two branches to linux-next.
> Both normally merge through Greg's staging tree.
>=20
> IIO fixes branch which merges through Greg's staging-linus branch.
> git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git#fixes-togreg
>=20
> IIO stuff for next merge window which merges through Greg's staging-next =
branch.
> git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git#togreg
>=20
> Both are the same as the staging trees today as Greg accepted
> a pull request earlier today and I just rebased before sending this.

Added from tomorrow.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/v9pU7tOPwO7UmPWvnS=99Pq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmBu7ooACgkQAVBC80lX
0GwFzggAlhvVpf/jBzgVA+4rVAvem4Q8apFUwgEwTFs2N15wyl0++h8i/yevsRCt
JAnFUY/vKY0dZDfaW7H3dUl/P3dqt3Jwr95LpRBhywu2iFMBxEdvTSK0f2lGkTV2
+PS5QTF/tqGQrVnArvK38+S6zfHXdAvIkQVO78p2KGU4aB4rXxinalplxljYdeo2
yIi1y1NLBLZIZHjb9ivVa+mcRrzjzD+DswC/Omn5M3T28um1jOl83H3cFsxjus1+
3y9Co7kJKccJboP03YsHLOqviiYra/KGF8lynTfEso4BRcvDqDzF1jBx4gofgeMG
gfNo/JbXdd/bwf+PBKX6V83nK8oM8w==
=Gr7n
-----END PGP SIGNATURE-----

--Sig_/v9pU7tOPwO7UmPWvnS=99Pq--
