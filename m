Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2E944133B
	for <lists+linux-iio@lfdr.de>; Mon,  1 Nov 2021 06:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhKAFaf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 Nov 2021 01:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhKAFaf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 Nov 2021 01:30:35 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74456C061714;
        Sun, 31 Oct 2021 22:28:02 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id b1so11809064pfm.6;
        Sun, 31 Oct 2021 22:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x97BekPRcHY1pmzWyeSNQW7Yc3qbeRmxf+KXg5Cyt/0=;
        b=DqT0JrGtRGtMuziFBzPP3wjD55ScQ9Ji50JaSqI3p7kLh1b6AqGvZXw+ZWgxBuSs/U
         DEow4ZLYh8N55WdDKbSbDssGi4Ky48fLBNhgeePtCxe/tjYOlglUqA+k3HZWVFJNMtx/
         f6gTKNSXhoPhqzJY1i9ZT7QpySMqG3/7208TIMf3mOYXLvheXsYQil22et0X2HiiB6Ty
         dFtn7Dw07SDJMU0QT7a+1PQcPwBfnnFP63Kcd9Jp8ub7yHAwTSAWw49M6IySPpp7OFnJ
         x21IAq7Qel8nkQEqso6QjRbZNTO4U7MKoso5gjqb9cjN5GbgwoyWoRy+/ttHB+LZBadG
         1X2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x97BekPRcHY1pmzWyeSNQW7Yc3qbeRmxf+KXg5Cyt/0=;
        b=5Jc5Zdh/dW5HmLoIaeghJfhj+TD/Fuqg0tZgTJsMtNRhX8r+XK/WvCgaeG5UU4ncuo
         WqqRriANGFDcdLVKifsxTpRqrboq+Dl88su+sOMGNIV8qMs0phUDLZ9H6r/Tx8W1Bco4
         VI+Sr6UnPVHie6LjrFglKgDvo9dLHQ/6RFPRofIF2yV6JPoYaSmkpBM5DOdyNJG95K6J
         WNAIWCGXvueL6i6JAmAUjVK7f4oxb1eokD2U4qhsYL31kHTng6/UVp19fsSNI3D+D1Of
         CSap+IIKx4jlUMNWqxasLz16KhunpHVFXZQewMgCbSnIz7bJG28gXb1M2FPHsFwzk26t
         FPVg==
X-Gm-Message-State: AOAM530JxA4e2BM5hpze2AGSM3X+OL7jjg9oOSATaaTZu4UBJdn2XtYk
        vXJZyNZ/7mdy8+NKLZ2l89uNbe0Tk34=
X-Google-Smtp-Source: ABdhPJz7eD4dxgV4JE2nPYNZZ6Nl7USsDIw/sfxld/a9HfVCG5JLOzj6x22um5JLAfS2iG7S3sj4Jg==
X-Received: by 2002:aa7:888d:0:b0:47c:128b:ee57 with SMTP id z13-20020aa7888d000000b0047c128bee57mr26724845pfe.81.1635744481602;
        Sun, 31 Oct 2021 22:28:01 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id s2sm13293178pfe.215.2021.10.31.22.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Oct 2021 22:28:00 -0700 (PDT)
Date:   Mon, 1 Nov 2021 14:27:55 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     linux-iio@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] docs: counter: add unit timer sysfs attributes
Message-ID: <YX9620RskHAExvcc@shinobu>
References: <20211017013343.3385923-1-david@lechnology.com>
 <20211017013343.3385923-5-david@lechnology.com>
 <YXj1xc6DdeOrUKjW@shinobu>
 <6e96cdd9-d1f1-6861-59eb-c4e6b9a2ffb9@lechnology.com>
 <YXpYUIUIQe+oxwXK@shinobu>
 <d5d7454b-e0a0-7436-10d7-dcb402885479@lechnology.com>
 <YX9oTuLB1d6CqQOK@shinobu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zDtKk9OJ85v1seA2"
Content-Disposition: inline
In-Reply-To: <YX9oTuLB1d6CqQOK@shinobu>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--zDtKk9OJ85v1seA2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 01, 2021 at 01:08:46PM +0900, William Breathitt Gray wrote:
> On Sat, Oct 30, 2021 at 11:40:27AM -0500, David Lechner wrote:
> > On 10/28/21 2:59 AM, William Breathitt Gray wrote:
> > > On Wed, Oct 27, 2021 at 10:30:36AM -0500, David Lechner wrote:
> > >> On 10/27/21 1:46 AM, William Breathitt Gray wrote:
> > >>> On Sat, Oct 16, 2021 at 08:33:39PM -0500, David Lechner wrote:
> > >>>> This documents new unit timer sysfs attributes for the counter
> > >>>> subsystem.
> > >>>>
> > >>>> Signed-off-by: David Lechner <david@lechnology.com>
> > >>>
> > >>> Hello David,
> > >>>
> > >>> The unit timer is effectively a Count in its own right, so instead =
of
> > >>> introducing new sysfs attributes you can just implement it as anoth=
er
> > >>> Count in the driver. Count 0 is "QPOSCNT", so set the name of this =
new
> > >>> Count 1 as "Unit Timer" (or the datasheet naming if more apt) to
> > >>> differentiate the Counts. You can then provide the "unit_timer_enab=
le",
> > >>> "unit_timer_period", and "unit_timer_time" functionalities as respe=
ctive
> > >>> Count 1 extensions ("enable" and "period") and Count 1 "count".
> > >=20
> > > Actually if the counter function here is COUNTER_FUNCTION_DECREASE, t=
hen
> >=20
> > It is an increasing counter.
> >=20
> > > instead of introducing a new "period" extension, define this as a
> > > "ceiling" extension; that's what ceiling represents in the Counter
> > > interface: "the upper limit for the respective counter", which is the
> > > period of a timer counting down to a timeout.
> >=20
> > In one of the other patches, you made a comment about the semantics
> > of ceiling with relation to the overflow event. We can indeed treat
> > the timer as a counter and the period as the ceiling. However, the
> > unit timer event occurs when the count is equal to the period (ceiling)
> > whereas an overflow event occurs when the count exceeds the ceiling.
> > So what would this event be called in generic counter terms? "timeout"
> > doesn't seem right.
>=20
> Okay, so COUNTER_EVENT_THRESHOLD would be the respective Counter event
> type for this behavior because the event triggers once a threshold is
> reached (ceiling in this case).
>=20
> But implementing the unit timer as a counter might not be the best path
> forward as you've mentioned below.
>=20
> > >=20
> > > William Breathitt Gray
> > >=20
> > >>>
> > >>> If you believe it appropriate, you can provide the raw timer ticks =
via
> > >>> the Count 1 "count" while a nanoseconds interface is provided via a
> > >>> Count 1 extension "timeout" (or something similar).
> > >>>
> >=20
> > One area where this concept of treating a timer as a counter potentially
> > breaks down is the issue of CPU frequency scaling. By treating the unit
> > timer as a timer, then the kernel could take care of any changes in clo=
ck
> > rate internally by automatically adjusting the prescalar and period on
> > rate change events. But if we are just treating it as a counter, then we
> > should probably just have an attribute that provides the clock rate and
> > if we want to support CPU frequency scaling, add an event that indicates
> > that the clock rate changed.
>=20
> You're right, treating the unit timer as a counter might not be the most
> appropriate interface. Because this is a timer afterall, perhaps
> exposing this via the hrtimer API is better. You then have an existing
> interface available designed for timer configuration, and you can
> leverage the struct hrtimer function callback to handle your timeout
> interrupts.
>=20
> William Breathitt Gray

Sorry, I think I meant the clockevents framework, not hrtimers. I'm not
as familiar with timers but perhaps you know more than I do here.

William Breathitt Gray

--zDtKk9OJ85v1seA2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmF/etsACgkQhvpINdm7
VJLFFxAA3gV73WEkluyg0fvOt3hSVOeyc9JvpMpV68yZwFwmJF0k9fBEX7SaaTxO
m8qMbWUxit4cTty3JaX0oOu6NYGS9VVlf8ZeJk2GoafhthQRKp4Dc4HgGDRxr8Gc
2ZLBXeMc34IJAa1h+bJ5Dboh1nqEpWijhcKwsJ/Wk8/JWF/N6xjsiNl2AspFhoxE
+8Yv48sHTswMD6S5de7MU4qpy1QhEQRJPGr9Xg7K9onADTizTN1zdMckl/yJVA8f
lEHU11xbWrMd8AWKG9cGFluIO6hyqky7HNktm+l2YB3VcB9tVrE+QyDyTIYBL2Q9
T7TakUQx58/fDPkzOlTYe5a9RjiF0C8kJ0cxC7yctJhvuo9DZ6a7q2VcgvQal4AW
kGAM+B9FNGI3lLC2Dn126xq3bNGecWFkDWsre4AL/0anUuazZsbJItJgVzB9INAW
wjqfd6Xh7zHgWHlU6d2ntFIHvEoM4YMhlaIFNcRE7JNJkJl0RCeu+cdxIdxf3TE5
qDaYrr2FIaTUPJlxHUNZDf5FOZrROUQHUroVmSdKC2VYUWagp9L3V5mYDkX/Diva
if7ZrFjbFqglm4BZqtJSteBzDoHZQ2XNTqulChFsL8euvveIg8D9y4B+g/MCILOH
Bk/IE58cUwLYwQpriHJuIhsah3FuyI9EuOFpmPyf6thfLvoCpbI=
=kuFj
-----END PGP SIGNATURE-----

--zDtKk9OJ85v1seA2--
