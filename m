Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDEC84412B2
	for <lists+linux-iio@lfdr.de>; Mon,  1 Nov 2021 05:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbhKAELZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 Nov 2021 00:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhKAELY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 Nov 2021 00:11:24 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F14C061714;
        Sun, 31 Oct 2021 21:08:52 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id n18so10748666plc.2;
        Sun, 31 Oct 2021 21:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rwgwN91I4/J0E0DoPkvloH4GFLRcFMUvocfcO0UjozQ=;
        b=l6vfXRn+vaacMSIVlK2gWX1rNaXCVvABOfNQtXFDeBqjQrSNjY7UeOafM377GiLvJP
         bQpV0Fa86NZrbMunPagFx8c9jIEgtYR2xoPWyKCPgpvK37Wa6yP69e6bPaqJXxnNP4qO
         t0Ex4Yn7+aJj67Sn2gUfvLBS+xqIizKRsm/otj931qdRZ7nNf+cYrvfnAakTX+XNGPjx
         jwnJG9RV50MJK5o4UF01X7PXLwBlf6Dz15NDeWnfnlq8p8ToVWZCKBbI0EjrrcgHJjau
         F+giR3Ejg4hY76e5p+XSI2Tg5Fjux7PuhUpIrX7LvtiUXemI8KJ7kYn0bov/UsDrnlk4
         6+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rwgwN91I4/J0E0DoPkvloH4GFLRcFMUvocfcO0UjozQ=;
        b=dF7fH4is9m0OT48V+okchY2zN8pWD29ZK0KgMPHYe98QX3/eD6pIVXg0iHmTrrmik5
         DDYO1pyUXTXufF5rcz7aPuxsdaUznxgMUN0fnaFzsb02bgFV9ssnhA2PqF+odDVZsRlb
         wP8TECHU+HkUhPyEiE7op8Bt3GItQmNZkS1mMpruOTuoyr7ENRN9VxbkM7hy+ZU58m6W
         tHLXZMdvQsVxWf9G5kG3PnT3BxH1ePs1kHfV602/TMVyUXxx4KH8c+D6yYtB3HFEySc3
         aX55odJLbosFeKFBuPgkvu8Tb+nNqwMfi5Riy84g9l8o17S0RuB8Y0qTXCJ5rGrGZ6oE
         6ncg==
X-Gm-Message-State: AOAM531r6AO7GdMIuerOOf5BXaV79buitNekEn8sDTRWpF+nENWZ4Hwt
        5KlE5bf8YCaOmoaFWktznhDsCc8NAZY=
X-Google-Smtp-Source: ABdhPJx4hiitc2MpyG3yZOOsgm1TiPgOYiZlt40MbfxokXG6TQ3lRoTQoQuOEj4bNslgytTlYdFzxA==
X-Received: by 2002:a17:90a:4b85:: with SMTP id i5mr35905829pjh.25.1635739731494;
        Sun, 31 Oct 2021 21:08:51 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id f203sm13453894pfa.112.2021.10.31.21.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Oct 2021 21:08:50 -0700 (PDT)
Date:   Mon, 1 Nov 2021 13:08:46 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     linux-iio@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] docs: counter: add unit timer sysfs attributes
Message-ID: <YX9oTuLB1d6CqQOK@shinobu>
References: <20211017013343.3385923-1-david@lechnology.com>
 <20211017013343.3385923-5-david@lechnology.com>
 <YXj1xc6DdeOrUKjW@shinobu>
 <6e96cdd9-d1f1-6861-59eb-c4e6b9a2ffb9@lechnology.com>
 <YXpYUIUIQe+oxwXK@shinobu>
 <d5d7454b-e0a0-7436-10d7-dcb402885479@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kY20/FUsvPi7ncKt"
Content-Disposition: inline
In-Reply-To: <d5d7454b-e0a0-7436-10d7-dcb402885479@lechnology.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--kY20/FUsvPi7ncKt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 30, 2021 at 11:40:27AM -0500, David Lechner wrote:
> On 10/28/21 2:59 AM, William Breathitt Gray wrote:
> > On Wed, Oct 27, 2021 at 10:30:36AM -0500, David Lechner wrote:
> >> On 10/27/21 1:46 AM, William Breathitt Gray wrote:
> >>> On Sat, Oct 16, 2021 at 08:33:39PM -0500, David Lechner wrote:
> >>>> This documents new unit timer sysfs attributes for the counter
> >>>> subsystem.
> >>>>
> >>>> Signed-off-by: David Lechner <david@lechnology.com>
> >>>
> >>> Hello David,
> >>>
> >>> The unit timer is effectively a Count in its own right, so instead of
> >>> introducing new sysfs attributes you can just implement it as another
> >>> Count in the driver. Count 0 is "QPOSCNT", so set the name of this new
> >>> Count 1 as "Unit Timer" (or the datasheet naming if more apt) to
> >>> differentiate the Counts. You can then provide the "unit_timer_enable=
",
> >>> "unit_timer_period", and "unit_timer_time" functionalities as respect=
ive
> >>> Count 1 extensions ("enable" and "period") and Count 1 "count".
> >=20
> > Actually if the counter function here is COUNTER_FUNCTION_DECREASE, then
>=20
> It is an increasing counter.
>=20
> > instead of introducing a new "period" extension, define this as a
> > "ceiling" extension; that's what ceiling represents in the Counter
> > interface: "the upper limit for the respective counter", which is the
> > period of a timer counting down to a timeout.
>=20
> In one of the other patches, you made a comment about the semantics
> of ceiling with relation to the overflow event. We can indeed treat
> the timer as a counter and the period as the ceiling. However, the
> unit timer event occurs when the count is equal to the period (ceiling)
> whereas an overflow event occurs when the count exceeds the ceiling.
> So what would this event be called in generic counter terms? "timeout"
> doesn't seem right.

Okay, so COUNTER_EVENT_THRESHOLD would be the respective Counter event
type for this behavior because the event triggers once a threshold is
reached (ceiling in this case).

But implementing the unit timer as a counter might not be the best path
forward as you've mentioned below.

> >=20
> > William Breathitt Gray
> >=20
> >>>
> >>> If you believe it appropriate, you can provide the raw timer ticks via
> >>> the Count 1 "count" while a nanoseconds interface is provided via a
> >>> Count 1 extension "timeout" (or something similar).
> >>>
>=20
> One area where this concept of treating a timer as a counter potentially
> breaks down is the issue of CPU frequency scaling. By treating the unit
> timer as a timer, then the kernel could take care of any changes in clock
> rate internally by automatically adjusting the prescalar and period on
> rate change events. But if we are just treating it as a counter, then we
> should probably just have an attribute that provides the clock rate and
> if we want to support CPU frequency scaling, add an event that indicates
> that the clock rate changed.

You're right, treating the unit timer as a counter might not be the most
appropriate interface. Because this is a timer afterall, perhaps
exposing this via the hrtimer API is better. You then have an existing
interface available designed for timer configuration, and you can
leverage the struct hrtimer function callback to handle your timeout
interrupts.

William Breathitt Gray

--kY20/FUsvPi7ncKt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmF/aD4ACgkQhvpINdm7
VJLt+w//WPFfS0I1IQIhFv8J+VvJmmGFdjqjit3+LI/Y8VpGIwgH06xZqavlrSzV
sS+0GEHQjNjP6kRQvEQh13LZHMnmCjqo39QWsnKB2S3HrmUfOGNARd7nC0OA4ijP
shXkwLvNNKSN35QlXuzbMBZNnprhpvuLuytSqypL27C2JLNdmlwHqs1bJ4SNcs7O
tFy7pAwnUvERhfrDL8tJoU52ehsU42z0rYh+NWycLaZJi/p/sMZZslNOd+2Tk2Qr
bXLTkBRwzqmAKEZ+1uLW71Xcch1P+aZyjcv0tInicDPvrocQnynxow3PFjOYaZm5
+8V/lOW+UKJYU0u3fb1waOi1LieRUAWD5akpFG9R7TdhlCI1yd9ZF0a1ax0+RpUv
1N87dab7+910ABd218pCKN9retUPY7w/lRqqMM+vC90heOTJd24ESA0KGTXbEknM
VnoAa8W75KGA+sCmC8gQXbSeRjtM8+puGkPDAM1JqEr6YEVabl5BRjQowaerhj7I
OZjKj66kiP14m24iccY8WKMTpmu2es0m/WiIpun8nYzbHVPJYb9aEiny7b9nHAUj
YRy5pZPyUz2fnduElAOWvdkQE9YGvUpuiWOyLpsxP+DynDKA/2sGtpSFMQyiHuNc
G2ySYNbywBUtpNZnQNyMQr7mh1LKd8jn19xXyeWm9KfGFxsOjyM=
=GXPm
-----END PGP SIGNATURE-----

--kY20/FUsvPi7ncKt--
