Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F421F0982
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jun 2020 06:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbgFGEJX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Jun 2020 00:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgFGEJW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Jun 2020 00:09:22 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524AEC08C5C2;
        Sat,  6 Jun 2020 21:09:22 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id c12so14043431qkk.13;
        Sat, 06 Jun 2020 21:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oqsQ9AVre3jShAtAztK5T2TncsoqvRGLWPR8pg5lSVM=;
        b=BHDrA9r9VfMp3dIJb15MTUvmIH+tWy6Wf7Q8x2wrgFuq4FmTHA7fmGLBIdtNhh71ZR
         1KL82S/y6ADbuSh+qPIfm0fazj/oLtDTUAPPsZ7Jyv14QGB0hIqU/UuNGDKK4e0xSRzA
         hywshPyJIaoDDtVWBOAOhYK2dl61zi+uogj5cCA4MuNmW6Xu+Mo16IJF7BBZV4JqrzKq
         tJFkujUbGnvhz/qcUYnigZZi03R19BiulEkoNTkNBdB6q3QXPpVwWeFVVwz//t5yUMSQ
         Lb4mGPmui5bfGWYpKoL8IyT5KjXo/VImSiSUdNB2DrKV9g2AVcwllCJarqeuTYq+zpnx
         XiIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oqsQ9AVre3jShAtAztK5T2TncsoqvRGLWPR8pg5lSVM=;
        b=M+XIWs6ADHdaqoiPDjLf7Kz8+eRnDdKvtd+4oVyBxWRnjq1cn+lzjW52EKXCeAYvgQ
         bTOz9NODlz1QPZBSYNx2VCSTcK7yz6WdWNpoInDyEGsD8BgELy+X4k7g7k5Ck9f4Ebqm
         NpU5+zZKiZFA641t5IU/Fdz7Vb3aFK6XTX5YT6MFmJDVg+mvuGkigzrFFfGkhDSCAy1t
         iXoQ1E1wze8Gg8I2fC4N5hGgl90N1G/bdhsot7FmPPoqmmV/n3KITvCxhhpZncOtzqPO
         yEyJPk3+MVNEoLGDWbXcdsM9THauWcqo8toK455HyY0tN91N0+XvJXwyCkQUzS8eY29y
         HajA==
X-Gm-Message-State: AOAM532n6u8TL9JlkKf38od/KCSYIiAHbIBw0IGGC/ohBg20mcfBBGIb
        yAkHEidMQXYTtAr8GlrMjp4=
X-Google-Smtp-Source: ABdhPJyse1JEUX+WxMchZGnT1Qz0LUAyGkfhMOBhuJMJhrYkzrfi0wwLEldWTGJ8fsTDG1LbAkGxVw==
X-Received: by 2002:a37:ab01:: with SMTP id u1mr16677913qke.90.1591502961211;
        Sat, 06 Jun 2020 21:09:21 -0700 (PDT)
Received: from shinobu (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id d140sm3960381qkc.22.2020.06.06.21.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2020 21:09:20 -0700 (PDT)
Date:   Sun, 7 Jun 2020 00:09:05 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Syed Nayyar Waris <syednwaris@gmail.com>
Cc:     linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/3] counter: 104-quad-8: Add lock guards - generic
 interface
Message-ID: <20200607040850.GA80713@shinobu>
References: <20200316124929.GA389@syed.domain.name>
 <20200318020506.GA45571@icarus>
 <20200322175831.74e10aa7@archlinux>
 <CACG_h5qctM0S2buQHHNnJ_qVY6YY2wYruj9aTKH9RiJ=9_LfoQ@mail.gmail.com>
 <20200404150633.2421decd@archlinux>
 <CACG_h5o=V_y33krqojmANnqG+Uf7FJmOVmkY-MGZ+zLJR+Q2YQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vGgW1X5XWziG23Ko"
Content-Disposition: inline
In-Reply-To: <CACG_h5o=V_y33krqojmANnqG+Uf7FJmOVmkY-MGZ+zLJR+Q2YQ@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 07, 2020 at 09:28:40AM +0530, Syed Nayyar Waris wrote:
> On Sat, Apr 4, 2020 at 7:36 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Mon, 30 Mar 2020 23:54:32 +0530
> > Syed Nayyar Waris <syednwaris@gmail.com> wrote:
> >
> > > Hi Jonathan
> > >
> > > >Looks good.  I'm not sure right now which tree I'll take this through
> > > >(depends on whether it looks like we'll get an rc8 and hence I can s=
neak
> > > >it in for the coming merge window or not).
> > > >
> > > >So poke me if I seem to have forgotten to apply this in a week or so.
> > >
> > > Gentle Reminder.
> > > Thanks !
> > > Syed Nayyar Waris
> >
> > Thanks.  I've applied it to the fixes-togreg branch of iio.git which wi=
ll go
> > upstream after the merge window closes.
> >
> > Thanks,
> >
> > Jonathan
> >
>=20
> HI Jonathan,
>=20
> I think only the patch [1/3] has been applied. Patches [2/3] and [3/3] ha=
ve not.
>=20
> The three patches were:
> https://lore.kernel.org/patchwork/patch/1210135/
> https://lore.kernel.org/patchwork/patch/1210136/
> https://lore.kernel.org/patchwork/patch/1210137/
>=20
> The last 2 patches need to be applied, I think.
>=20
> Regards
> Syed Nayyar Waris

Just a heads-up: the relevant bugs are present in the 5.7 release so it
would be prudent to tag those two patches with respective Fixes lines.

William Breathitt Gray

--vGgW1X5XWziG23Ko
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl7caGEACgkQhvpINdm7
VJLyFA//blkv50WV1lBKwyeP/xwK9HjUc6TPgUkedMEE3XzOlqEPc7LdLhOJn9Y5
AWIPd0th2o1lykYVisNtZsrJ+K8NR2GIY9Q3hlJprdyMllZ6ARL9kC0HFd6aMGEC
zKnhz4m+FzbAcPTkrKbNOZdyscsN5hKunygIGsXZI46S2xQpG14dRFFEq+22CWWC
epxvD3Ir4e725Kw17+vMaLjFrNd0D/YpFd0j5bPuPo4gtX9z1r23awgzaE3B+VF1
EWegk+n+RcJcyUWc0Wfby1GWdx0PcRm7tdJU29gUaBg2VHsNUqGGpKB8BJZG01l+
GIKgC3L2i5laKCUTRGmQjXjwl3qKlCiTr03YHXhNLNWIydpA8xNry0Sxbj8IEgZ+
3VXdktLZhkE3n6yndOxHbHNW3fyQugp2Bf2E/dG3OUvah7ua4KgPtcBhFg06z6XJ
HeaPNaGwRrFDwh00MDQwQYQBr760r8ZcNCof4mSXTOhc6WvyQCL3UhQe9+sutCPu
2GZ5PwBFaj9ejq7FTfgvi/wox+1y3W7Rxf1ncHUskoz/7CbajJIA92zqa6Jhz+Pm
rS5LOiE5hL2/GrEvV9iQtybHp1G0xJN06LaFZurghmMcLQ5PSlM/uiiAEM9sVB6n
08TIDvwqmLQiP7PxkVM409feRT9LwercvxgIkYnMw+nhNeW5U6k=
=1EAz
-----END PGP SIGNATURE-----

--vGgW1X5XWziG23Ko--
