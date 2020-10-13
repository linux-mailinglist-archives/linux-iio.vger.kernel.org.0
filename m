Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2368D28D474
	for <lists+linux-iio@lfdr.de>; Tue, 13 Oct 2020 21:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgJMT2E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Oct 2020 15:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgJMT2E (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Oct 2020 15:28:04 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB556C0613D0;
        Tue, 13 Oct 2020 12:28:03 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id i22so792621qkn.9;
        Tue, 13 Oct 2020 12:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oH57Aeq7dptpbLJ/Gi2x/xQv7Jn157z+tldkFDsNdQM=;
        b=pNlUsnGhf+deEhFYlFqDY5WR8rb2vOVydQDO8QwSvlS/iLxpD14Hx6AIEABIJxLn0c
         M8s9QGsCktIrZqTduAtjIjKlMWJ7DKouhiwdMZs9Tq1+k1NTgNXXmZB3Zexh2vYaBBlA
         MdsUKxFeSS49DaklCfpQ4PrS66PXsjjGLTEj9JtwZJekjrFh2isHrbeYYNMlDVKl5sHK
         NJ8xe3e5HbVuM9HyevTdl5om3GHXHRPKoqxYSwgQiDQ7EodoRy4KuWDKkq5TTOEggl28
         o10R2OX93CMdmOUws6qi01Iperaqf3lNGaFy2BekOstQ9pb/AN9ye587q0yDa3eZS9+w
         /Unw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oH57Aeq7dptpbLJ/Gi2x/xQv7Jn157z+tldkFDsNdQM=;
        b=ET4149DRX+CEnZEbcFDkxIMd1HJyCGUYEuT76tXVAuzHBVdC8eXUVZKRnZSA9u/UNJ
         /YdYlSoO9XfGoXz0V0je1W2f/YvfOQkC9i7pF/hZbw+IAHyLX9DgXAvdOdPbNgtSRAJg
         kB0348IYv/veJ7N6ZVchbnvWuZ5seIe2WHiETr5GMFnYbzqt7DSyU9h4BXbSS1Zyx/jk
         YQgGGaH3r0+nzI8rFvwBpZv+8vlFZctRf7StCXcLLJQhZQcnO+9gKqjyqmd5Z4x/s+IA
         CxVvF59doz4+V18yLmpuSgfnsVrsEvQeHvT51rvoRmU1fAbl8sdBRyLZECdcx/MM4J9/
         LdAw==
X-Gm-Message-State: AOAM5327gE4pzHCp0uBOh91nKRxndpR+HYVCC/1PF0KphnKTEyOQgYy+
        2Aj3WCLBwxap9NyGr+u4qPY=
X-Google-Smtp-Source: ABdhPJx3RWQ0Ixnkg8H7A0PimPYFPhuFdry/B79ZtoiOA/CSvk9rCJEEn5yfbDMQoseSWKFJdfADhA==
X-Received: by 2002:a37:a8a:: with SMTP id 132mr1582931qkk.199.1602617282945;
        Tue, 13 Oct 2020 12:28:02 -0700 (PDT)
Received: from shinobu (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id s17sm337542qta.26.2020.10.13.12.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 12:28:02 -0700 (PDT)
Date:   Tue, 13 Oct 2020 15:27:43 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     Pavel Machek <pavel@ucw.cz>, jic23@kernel.org,
        kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Subject: Re: [PATCH v5 4/5] docs: counter: Document character device interface
Message-ID: <20201013192743.GA33437@shinobu>
References: <cover.1601170670.git.vilhelm.gray@gmail.com>
 <54190f9875b81b6aa5483a7710b084053a44abb8.1601170670.git.vilhelm.gray@gmail.com>
 <20201008080909.GA31561@amd>
 <20201008122845.GA3314@shinobu>
 <d06d5e47-5776-85ee-0dc5-8b624e36d83d@lechnology.com>
 <20201013185851.GB32722@shinobu>
 <09949c56-19da-1937-418b-99a1a9260c4c@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
In-Reply-To: <09949c56-19da-1937-418b-99a1a9260c4c@lechnology.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2020 at 02:08:45PM -0500, David Lechner wrote:
> On 10/13/20 1:58 PM, William Breathitt Gray wrote:
> > On Mon, Oct 12, 2020 at 12:04:10PM -0500, David Lechner wrote:
> >> On 10/8/20 7:28 AM, William Breathitt Gray wrote:
> >>> On Thu, Oct 08, 2020 at 10:09:09AM +0200, Pavel Machek wrote:
> >>>> Hi!
> >>>>
> >>>>> +        int main(void)
> >>>>> +        {
> >>>>> +                struct pollfd pfd =3D { .events =3D POLLIN };
> >>>>> +                struct counter_event event_data[2];
> >>>>> +
> >>>>> +                pfd.fd =3D open("/dev/counter0", O_RDWR);
> >>>>> +
> >>>>> +                ioctl(pfd.fd, COUNTER_SET_WATCH_IOCTL, watches);
> >>>>> +                ioctl(pfd.fd, COUNTER_SET_WATCH_IOCTL, watches + 1=
);
> >>>>> +                ioctl(pfd.fd, COUNTER_LOAD_WATCHES_IOCTL);
> >>>>> +
> >>>>> +                for (;;) {
> >>>>> +                        poll(&pfd, 1, -1);
> >>>>
> >>>> Why do poll, when you are doing blocking read?
> >>>>
> >>>>> +                        read(pfd.fd, event_data,  sizeof(event_dat=
a));
> >>>>
> >>>> Does your new chrdev always guarantee returning complete buffer?
> >>>>
> >>>> If so, should it behave like that?
> >>>>
> >>>> Best regards,
> >>>> 									Pavel
> >>>> --=20
> >>>> (english) http://www.livejournal.com/~pavelmachek
> >>>> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/hor=
ses/blog.html
> >>>
> >>> I suppose you're right: a poll() should be redundant now with this
> >>> version of the character device implementation because buffers will
> >>> always return complete; so a blocking read() should achieve the same
> >>> behavior that a poll() with read() would.
> >>>
> >>> I'll give some more time for additional feedback to come in for this
> >>> version of the patchset, and then likely remove support for poll() in
> >>> the v6 submission.
> >>>
> >>> William Breathitt Gray
> >>>
> >>
> >> I hope that you mean that you will just remove it from the example
> >> and not from the chardev. Otherwise it won't be possible to
> >> integrate this with an event loop.
> >=20
> > Would you elaborate a bit further on this? My thought process is that
> > because users must set the Counter Events they want to watch, and only
> > those Counter Events show up in the character device node, a blocking
> > read() would effectively behave the same as poll() with read(); if none
> > of the Counter Events occur, the read() just blocks until one does, thus
> > making the use of a poll() call redundant.
> >=20
> > William Breathitt Gray
> >=20
>=20
> If the counter device was the only file descriptor being read, then yes
> it wouldn't matter. But if we are using this in combination with other
> file descriptors, then it is common to poll all of the file descriptors
> using a single syscall to see which one is ready to read rather than
> doing a non-blocking read on all of the file descriptors, which would
> result in many unnecessary syscalls.

Ah, that's a fair point, my original view was somewhat myopic there.
I'll leave poll support in the Counter chrdev then and just simplify the
documentation example code to not use it.

William Breathitt Gray

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl+F/68ACgkQhvpINdm7
VJL09xAAiV4IcrugWkrx2BL3YYZnD8T2DIOs7rpSZAQhOmnCdYi+RkdpcIkL1BiE
m43MgXUDtj+YsRzAVE55mySXUbpDXH3Hp2/ty0p8tzToy+ZI6d2ooRzFwNsxlSdy
4/FIQQQaqCpl6pBBwRwsum2Swe7JrToX+Q+FoN7KZt1STia8FuxlmiWlUC+ZL6L6
rk4/3dMMLcCm8JKGZ4qKqSEJxXyHGKQ/leAm9GTRS4a+RjzNiidBvM4+aNuAy+bC
j7x7vzHHfmxT1egmhT4XeyyuWW8C4rd1mQXG8RllaP6PhABi61Zd+KH1LIfMjV1P
t/9biiBXbdyh5uytVrI6Z04tu0frQGZi1JglSLljGvkNoKRBnvP8f9ay44y2PrG7
jAYAq0lgig9N0zLNql9c/ZMtanGACNlxQShnO/5MjYo1oBjXPy9I8oOn4vI5OvnG
2ccm6NhZRs+bU5f0dRJZy+DsqQFWaekjXVxmqu/HwG45YbcxUpprSY0qZtbLOe1m
U2EuuipT10o/UoJMO+3AlqqgJOfj2cGL2lXMIMSUFb3HQ0TDuHbBq3GPG02Fn9qL
TYHt5XoeQWb82gOmVuL0ynXac8mXuGy9PwGrHBYQryfODVvy6kA3nhSXkFncb52q
ovI9PDQc8Z3jigrxj17nrlvoDNb6FT+2knKdwSujiKgo8ZWdZUc=
=4Gc4
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
