Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C29AD239C1D
	for <lists+linux-iio@lfdr.de>; Sun,  2 Aug 2020 23:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgHBVLq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Aug 2020 17:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgHBVLq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Aug 2020 17:11:46 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0803DC06174A;
        Sun,  2 Aug 2020 14:11:46 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id c12so17898834qtn.9;
        Sun, 02 Aug 2020 14:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Fb/5Z4B9XTfuOtDzpHUsVEiu68aR/8vaP+1Ul+5zysY=;
        b=A/40hBU26L6V8L9Q9KC9iqoc+cuwy+OeTq6dxy+WtYDAgzmFhIOILnphkvgPpsmI15
         CMOr74ofUFFqh2JwgrbhUe2SJlwBxN+il7sjtV9TOd2/0+agZ+DUK/vn4DOsVD15GVRF
         1U/WHc6SI9XHVvVZq/UTkf67ANDtINQvYqewjRmYdnx1vs9zugBK4LNQXyHI/ATiZZ3E
         P1ghMB2RnKSu/fsYiPEj4/Bd9X/Iq/VMeERH2QzXxqpxzWudnafHWmMjV3+8raxQySBw
         oiHfkKafR0RJJpZz5XKgqQ/SbwG17N+Q6irN+ohboHPFmy0dqrDPcH9GylHU37+F6++p
         0EiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fb/5Z4B9XTfuOtDzpHUsVEiu68aR/8vaP+1Ul+5zysY=;
        b=sM14ULRbadwQa9CRujYIEIFvx5T8GYGjjZ5YtspGfG43jMnAZmK5RQJsBoTS8ej9KV
         7iEcLt9l3fKrsxlDE+VzGykSKiIpfQ2KdYqV8zD3HtR4xnn66LXDUm4X5ylgACZukwcb
         VUDePESLbyiqennrnrfvct3tWYj5dj3s9XzCjKvBlbNbJzrWf0xC/JEO4h5EHhj0Jewk
         4KnV6+iOiHYm3//u4i/M/Szv0r0tUiU6ibvl2u8QQKUH11VP8gZjVaZ+7/nnRA0JTxC9
         n4PPlWdPrfIWkmw3/s7I8LK4Ant4WbXihNCKyrIW5WHb+3vOTwusqGAFiTe9X6OllQFM
         MuHw==
X-Gm-Message-State: AOAM5307k22P/Xof1+hiFydMNH46QR/ma/HFyYACnbqRMK3zNnx66Rnv
        91YLGSeUCt83RCTt153nKN0=
X-Google-Smtp-Source: ABdhPJxJoXweorg+JFUfS6GWb438JSRsl1RcLLbLR+eW5jhNlDZUf5HAuHFcCAZNWdq1qNGO/6FrqQ==
X-Received: by 2002:ac8:24d:: with SMTP id o13mr13596339qtg.154.1596402705134;
        Sun, 02 Aug 2020 14:11:45 -0700 (PDT)
Received: from shinobu (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id q68sm17443130qke.123.2020.08.02.14.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 14:11:44 -0700 (PDT)
Date:   Sun, 2 Aug 2020 17:11:42 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     jic23@kernel.org, kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Subject: Re: [PATCH v4 3/5] counter: Add character device interface
Message-ID: <20200802211142.GB606173@shinobu>
References: <cover.1595358237.git.vilhelm.gray@gmail.com>
 <08b3ac7349a59ba7fa5cd438bbe78360842ccd11.1595358237.git.vilhelm.gray@gmail.com>
 <415ee9ad-255e-cee7-22a6-ffa977999691@lechnology.com>
 <a287770b-c263-f1db-bcc4-d901d3ff3c7c@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NDin8bjvE/0mNLFQ"
Content-Disposition: inline
In-Reply-To: <a287770b-c263-f1db-bcc4-d901d3ff3c7c@lechnology.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2020 at 05:49:37PM -0500, David Lechner wrote:
> On 7/28/20 7:20 PM, David Lechner wrote:
> > On 7/21/20 2:35 PM, William Breathitt Gray wrote:
> >> This patch introduces a character device interface for the Counter
> >> subsystem. Device data is exposed through standard character device re=
ad
> >> operations. Device data is gathered when a Counter event is pushed by
> >> the respective Counter device driver. Configuration is handled via ioc=
tl
> >> operations on the respective Counter character device node.
> >=20
> > This sounds similar to triggers and buffers in the iio subsystem. And
> > I can see how it might be useful in some cases. But I think it would not
> > give the desired results when performance is important.
> >=20
>=20
> By the way, I really appreciate the work you have done here. When reviewi=
ng
> code, it is easy to point out what is wrong or we don't like and to not
> mention all the parts that are good. And there is a lot of really good wo=
rk
> here already.
>=20
> I've been working on this all week to try out some of my suggestions and
> I'm not getting very far. This is a very difficult problem to solve!
>=20
> I just wanted to mention this since I responded to this patch series
> already but I am still learning and trying things. So I may have more/
> different feedback in the future and I may decide some of my suggestions
> are not so good. :-)
>=20
> And one more thing, there was a nice talk at the Embedded Linux
> Conference last month about lessons learned from designing a userspace
> API for the GPIO subsystem [1]. Unfortunately, there is no video yet,
> but the slides might have some helpful ideas about mistakes to avoid.
>=20
> [1]: https://elinux.org/ELC_2020_Presentations

Thanks! I appreciate the words of encouragement. :-)

This is a big endeavor so I'm expecting a lot of mistakes and changes
along the way. Since we're designing a new userspace interface as well,
I want to make sure it's correct before we commit it, because when it's
finally introduced we're basically stuck with it. So I'm happy when
mistakes are found because it saves me from having to live with those
later after the interface is live.

I'll respond to your PATCH 3/5 review later this week or coming weekend
when I get the chance.

Thanks again,

William Breathitt Gray

--NDin8bjvE/0mNLFQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl8nLA0ACgkQhvpINdm7
VJInMhAAqVGmbjhms6aBJfCZ+LH6WB9U1RvePeF1nw9cH70V1Wiw0/OLYGMYm1YX
zuhQrO8cc20cSWVQgrdl2m6ykbhShMGK1BzJiMW+ehYVdUZWOygKrNJRxxzGyo2m
DLHJox16JauHPhwZhxCx+ZDmzDbC0P99H16CsGYccxlFkbGb4MZgOtG1xtw/wM3h
1ctob4WXoRdwZcHzFAsDZoLjrdkSPcArMDcLeNcThdcsex33WPT+Toexlo6ILnPi
aWalbYwymW7jybV6OsN9T+ENN+6gIPGIHcJlLvL26slXgvrxfZXL4gHY0yOgsmew
1b63J9MfIFNrZOYT4kXR1iMPCloeTqLzwbNuNI+rPjzIVLAiAEUp6WruCsEY37l0
+wcq+L38ZnC1fWqP3DdnsYhTFbU0cuqbDhQpyvLMCV0kRCKcd8ifoe4BcUdhcHRe
edgLdRPmqu/rp9EpNPQ1UFWcmQ1brSXWH5J4nWlx1Ay31Fqu6lgJvGfIq/LphT5Q
kJ+uPq4sUFnttPYwolNcnRHjXPTdn8/a4KdrNm7k1uGXek2NgQhy6gBkR68Ii4hX
dpD/Os7d5WP3AZY7sVsIpJ2vDR37+s1s/MOWoFz5z9cLsItiErt9EgNclNagwXzS
0KHohQrPWLr5MTPzG7ELJpfZVks8ej5AlY9TONpIcqahGvWuWMo=
=g0cP
-----END PGP SIGNATURE-----

--NDin8bjvE/0mNLFQ--
