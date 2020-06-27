Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4D2520C374
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jun 2020 20:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgF0SSG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Jun 2020 14:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgF0SSG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 27 Jun 2020 14:18:06 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F401CC061794;
        Sat, 27 Jun 2020 11:18:04 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id m9so5958054qvx.5;
        Sat, 27 Jun 2020 11:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZfS1zQEXxVr5pDKOKLlkhLbHYnS+buWmBwUy/Xrx/Oc=;
        b=qu6vSC1jPfgHL/kV3nJFd5+olf7eZKNmjbYU0fJa1IPH8AxS/ZUX/2wraYWI9Kb2ms
         9Z4+5PDUboqbXOUl4wIJFt2wIEw0lAKftDi58QttIO7NhJb9VvpG36vh2DpAb17mLCen
         oSWct2KXoEYkp7FODSeUDpNfg42A01s37GDHJmkCPyXHnVVCM4ftSqFala09wf1llGrG
         1sglbZr7hbHa4jayiLzxcCan3DdTmZdBUbI3knR3Xs4AmJg+x4qR9KNQqqnEiV7+cK89
         b0IRVHbDtZ0mGk0OfGYi4VS/kvdp15b+dsGQDVdbKd9MO3aqZt9d0GQk58BLaeG5oMNX
         H0Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZfS1zQEXxVr5pDKOKLlkhLbHYnS+buWmBwUy/Xrx/Oc=;
        b=NX7hE/sj1cca9l9fB2gqe/mtdkOFA5v59reWFv5lBbr5jUQ+k1OSV8Ndg9ZCb2hkKb
         wYY781wWz6LN4NZf6E6P20mvx4+TCmWzFT4RP23oilXD4JbnC8RSK7l08JbYvaV8nSKv
         7WsiDXATv4it3bUU1hOpMh3BA/JvjYkaheaHgIeyI/8jGKzCmufHiD5jxYmMGlY2Jjs1
         Anav3irTz0Ttd6SiZJOQ6qxEP23RtEmOXK9OKMmHOKJfNEqiHch0fMLt8fJ24+SheB4Z
         mmBq9sYMDIhmT6yqhKtTICmRAmX69kojWESYHgcRdff6NgqsnyY/sz3sOsSMUnYrMeyS
         cGxw==
X-Gm-Message-State: AOAM530TofCic/j81Y9gqdZpA6iq7Q876DKC19mfH4DnZ31VAdchCvfs
        J5Hw9lgqZU255TY013f3EK8=
X-Google-Smtp-Source: ABdhPJx01oRpIQIb8KuN+kaIF5K7gUAF7wqHvbJFPlNJV6vCemc2pGIggoC1p7UfEgH0kZZlDSFKkg==
X-Received: by 2002:ad4:57b2:: with SMTP id g18mr8452730qvx.207.1593281883789;
        Sat, 27 Jun 2020 11:18:03 -0700 (PDT)
Received: from shinobu (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id q47sm13053073qta.16.2020.06.27.11.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2020 11:18:02 -0700 (PDT)
Date:   Sat, 27 Jun 2020 14:17:48 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     jic23@kernel.org, kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Subject: Re: [PATCH v3 3/4] counter: Add character device interface
Message-ID: <20200627181748.GA8254@shinobu>
References: <cover.1592341702.git.vilhelm.gray@gmail.com>
 <afe40ef2e24ecaca44fc229f7983cf4cde3374a8.1592341702.git.vilhelm.gray@gmail.com>
 <8fae0659-56df-c0b5-7c0d-220feefed2b4@lechnology.com>
 <20200621195347.GA59797@shinobu>
 <47ad15e7-05ce-d463-b6af-406365b3c3b4@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <47ad15e7-05ce-d463-b6af-406365b3c3b4@lechnology.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2020 at 09:08:48AM -0500, David Lechner wrote:
> On 6/21/20 2:53 PM, William Breathitt Gray wrote:
> > For example, in the dual-axes positioning table scenario, a user
> > application would likely want to know the exact X and Y position at the
> > time of a given event -- that means an event should provide two Count
> > values (and possibly associated device flags) when it occurs. I'm not
> > sure yet how the struct counter_event should be defined in order to
> > support this; we will need to indicate the format of data as well as
> > provide the data itself. Perhaps, we can handle this by providing an
> > unique id field so that only a single datum (e.g. a single count value)
> > is provided via the value field, but subsequent struct counter_event
> > items share the same id so that the user knows that a particular datum
> > is part of a larger group of data for a specific event.
>=20
> The timestamp could act as the "id" to correlate multiple values of a
> single event.

Okay, I see how that can work. So the /dev/counterX character nodes
would return a stream of data structures that look something like this:

struct counter_event {
	/**
	 * Best approximation of when event occurred in nanoseconds.
	 * Same timestamp value indicates data is part of same event.
	 */
	struct timeval time;
	/**
	 * Type of event that triggered. This would correlate with the
	 * IRQ set up for the device.
	 */
	__u16 type;
	/**
	 * Type of data represented by the value member. This enables
	 * the user to extract the right datatype from the value field.
	 */
	__u16 code;
	/** The value recorded when the event fired. */
	__u64 value;
};

In fact, this data structure looks a lot like struct input_event; would
it make sense to use that for this? I suppose we can't because we need
to support 64-bit value for our use cases.

Userspace also requires a way to enable the events and configure them to
report the data it wants. So perhaps the following sysfs attributes
would accomplish such:

* /sys/bus/devices/counterX/eventY_enable:
  Users can enable/disable event Y.
* /sys/bus/devices/counterX/eventY_config:
  Data to get when event Y is triggered (e.g. Counts, extensions, etc.).

Here's another concern for latency-sensitive applications: should we
handle writing data to the devices? While we have real-life examples of
latency-sensitive read operations, I'm not sure if a user will ever need
to write to a counter device within some realtime critical deadline --
I think write operations are primarily done for the purpose of
configuring the device for operation rather than during it. So perhaps
we don't need to worry about this use case because users can write data
via the existing sysfs interface.

William Breathitt Gray

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl73jUQACgkQhvpINdm7
VJI+5Q/9F+iiZdKk+/Rbp7+DBs4MIahPcIfm80GiTAS9+CB5A6gewetdkCiG9NtJ
kFdOjw9wRUSdB+ah+o0t0zGLC1v4q069zwrbns6giE6KsbMHItihk/pEZ1A8mel2
+Mo56yo+7n5EkkQkmnYZLRwTm0P+bRpSHGN4p0JrTaiGfsZQYnZuJuyYDwFV3EoJ
QQQwlx+OmvpNXISugKy/t/BRJzcjWNKIIuxQC3ejk1y0LUqEkU5yh8g3z3foktWw
2vQJJtTVBQNpMncSbjCysK51oF9QE3W6merHqj8nzeMKBW336cqzySFD3pOagPe8
AolVMd7YnUQ1uylD5t1/ysYPiihGkvWNO+YED2JuU12Y8oldYjI7ELpjSNUBzvie
FeHu8v7w4fcQ1SY0xm1Y5XWdKJx0WOPjfqxmcSN2t9zb1Cc4Z4/7bpM4CvErusjR
PQEukMibjwj/T5BsfdutwhIX5GHT5SVYVUKoLhe0gI4n+y3lxn4jfS638lnDBhGg
NPwhHUVksRHEh/RXyleNz2Mopt/f3cUg48O1vQA8tLcZ7nxTU1GKDOvaZ8AevVa3
H+K8URgeKInEyhkt0px9H2x83aqEk921Czcxm15qE7RY4bfIU86lZEITRE4INnmy
Qd3Nf8tIjV6Pk5F7ZKjiFAUbhrcdFsCiXM5doYGkKcfLrZuVh1I=
=sQ+8
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
