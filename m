Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C80CA43DCC3
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 10:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbhJ1IPJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Oct 2021 04:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbhJ1IPG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Oct 2021 04:15:06 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F38C0613B9;
        Thu, 28 Oct 2021 01:12:40 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id s136so5653540pgs.4;
        Thu, 28 Oct 2021 01:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dKSILrA9SrmuW2Kh7vGWyglLiggejgoMfZiJ4C3uTsY=;
        b=CCSgYFHZTcxqaXy5AFkRkjcjA5dhLYXEGNA233ZBlcqXAmZkUiwEw8dov02JXBPv/z
         XYB4iQ9YgUiLtYTRHUGCWkz/Gv2aQf4nGtYLGUCeM97oebL6ZnnxGVQRCnaPRaR7wYDP
         FjfPRNH/CXVWX0BlPYlaqRNzcvLZFHAtiwQEQpqXswWze25krUs4Yk/zKC15m4wlfZdG
         7JgO4OVGxnS7Q6LLO21wgwhhMk9y/Cy1IT6VqxmWdof0T1hYhPUXyzEjC8Yr48QyjKll
         hMh1SvJ58v1VA2yfnsI5us8JHTxtWk2Uv/iy/epeMUd0rl7FRSdGGOoGc6DPhl6N9jwO
         0NKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dKSILrA9SrmuW2Kh7vGWyglLiggejgoMfZiJ4C3uTsY=;
        b=BIFZxaPltrk934KWp2xmAMrvBhGqO1FsqY0T3nQapYltFeHbO0Jc+1AOAaWnpj/aB1
         F4OJUS0zR8P4J5LzOdckMSslOhFuO+L7FmVMo7F26SlW/0mCdPIdDdO0I79e+ArktlNJ
         qKt1D6ZVOVTBUYUWv+ce755fZ4Gpm4ZZ9vFfL+8WEYiWY6MAxNvUxBjHtJjfUO9RyKSl
         ieG70jQbnGU0ZYjD+k7OttlTRYiAK3XOWyOcXpihWncpnNahu0WxNMOVOZv/XEd34beB
         ezAAm7W3KFAAv6n8VBWxYVhRs6axt2mU3R3qjMsQRKlGIRhJ6v+KPkl5+V7EAc77X2SP
         3avg==
X-Gm-Message-State: AOAM533K1yupz5EGKa6SJ/zratEmKJ18ysYTv18NZRvqcqtlmC+chSru
        x39S/3T66iGZDOekKguQZtBUSHUGFJQ=
X-Google-Smtp-Source: ABdhPJzuaFwl5QyLA2f6q4NBMTtFlUxjhpjFq+84NiHuv2/DdsCo29Pl7473bhKe/RtAU4qV8Jy+TQ==
X-Received: by 2002:a63:3d8c:: with SMTP id k134mr2100645pga.394.1635408759937;
        Thu, 28 Oct 2021 01:12:39 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id h12sm2502732pfv.117.2021.10.28.01.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 01:12:39 -0700 (PDT)
Date:   Thu, 28 Oct 2021 17:12:35 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     linux-iio@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] counter/ti-eqep: add support for latched position
Message-ID: <YXpbc61WAKgN0DgU@shinobu>
References: <20211017013343.3385923-1-david@lechnology.com>
 <20211017013343.3385923-6-david@lechnology.com>
 <YXkDT2gaFfdIsgTQ@shinobu>
 <444960b4-1120-26fa-bd00-dfbe3c13cf23@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k9Jnbqt0PQC5h0Qc"
Content-Disposition: inline
In-Reply-To: <444960b4-1120-26fa-bd00-dfbe3c13cf23@lechnology.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--k9Jnbqt0PQC5h0Qc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 27, 2021 at 10:40:15AM -0500, David Lechner wrote:
> On 10/27/21 2:44 AM, William Breathitt Gray wrote:
> > On Sat, Oct 16, 2021 at 08:33:40PM -0500, David Lechner wrote:
> >> This adds support to the TI eQEP counter driver for a latched position.
> >> This is a new extension that gets the counter count that was recorded
> >> when an event was triggered. A new device-level latch_mode attribute is
> >> added to select the trigger. Edge capture unit support will be needed
> >> to make full use of this, but "Unit timeout" mode can already be used
> >> to calculate high speeds.
> >>
> >> The unit timer could also have attributes for latched_time and
> >> latched_period that use the same trigger. However this is not a use
> >> case at this time, so they can be added later if needed.
> >=20
> > I see that "latched_count" holds the captured counter count; would this
> > "latched_time" hold the captured unit timer time? If so, does that mean
> > setting the latch mode to "Unit timeout" always results in a
> > "latched_time" equal to 0 (assuming that's when the timeout event
> > triggers)?
> >=20
>=20
> Some `latched_*` attributes will only be useful for one `latched_mode`
> selection but not the other.
>=20
> These latched registers are used to measure speed. There are two ways
> to do this. A) measuring the change in position over a fixed time and
> B) measuring the change in time for a fixed change in position. So for
> A) latched_mode would be set to trigger on timeout and we would use
> the latched_position for the measurement. For B) we would set the
> latched_mode to trigger on reading the count register and use the
> latched_time as the measurement.
>=20
> ...
>=20
> >>   static struct counter_comp ti_eqep_device_ext[] =3D {
> >> +	COUNTER_COMP_DEVICE_ENUM("latch_mode", ti_eqep_latch_mode_read,
> >> +				ti_eqep_latch_mode_write, ti_eqep_latch_modes),
> >=20
> > It seems more appropriate to move this alongside "latched_count" as
> > Count extension because this is setting the trigger mode to latch the
> > respective Count's count. Or does this particular extension also affect
> > the "latched_time" capture for the unit timer?
> >=20
>=20
> In hardware, there are at least 3 registers that get latched that I
> recall. They are in different subsystems (main count, unit timer,
> edge capture). So as you have guessed, that is the reason for having
> the trigger selection at the device level.

Ah, I see what's going on now. I think supporting these latch registers
will involve some further considerations. I'll continue my reply in the
respective docs patch where you've gone more in depth about the
hardware.

William Breathitt Gray

--k9Jnbqt0PQC5h0Qc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmF6W3MACgkQhvpINdm7
VJJ8Gg/+Jq2nEP9P/wcHD/LVa98CSKJST4B861rtYxFy+q3PDz2ZGrCCB8E0v/HB
RLiSoCdlPSRUkwO2KLVaIPNvhS59izkFeKzK2hm8ihFdNXo8lFa7TAhuQ0dqk/+3
rPEOtCgeYpR6g9SNaiU72hGjIPubcWHS7ZEEJk0ZSNoVScuT9cz56IljInpJ85ub
fvUGDCDwOYgLzHZuSoLmnWaXTk/5tmjx4OF8pdBE9qeRrYkvzEby374y7BuUPiI2
fEo4wQ30gtcpKZ4CCUVZNEJ5YO2fw8YF9TLhlqBPheU6FG3fKTztTPdK3ipIrtca
uRMVPqNk4GvrlRn08zOhytc/6YAw4PfEdqG2yG7l0uw42GeQRCir2zAfpoaTFEuh
1I4grzshGUhdLg4qZkq3mvtcH5QmWfLBavmfyf8p69LUYit5q5gFklI2NNdS9jBf
7Rs2FnuB2C67fqoitD1j0MJePV/yHB8T+VC+NEa2tVO6WfV1gf3hRUyC7Vw0HLG2
LsOgRkz8mhv4qGuOc7XmazQ5aZy2xqE75a2Yg0QEKz4PctwUixT9czg68WUq581G
melUOyjYRnNsBgUJWRe9EtWmoJ1LhGhxosLpqwB4gXKnAJ6evYq5LuQY4AP0/azT
4TOgHyGRQs025wKN5lyM2nmQscRdS7hQH38Mtf10eyAVtszpriU=
=v9A/
-----END PGP SIGNATURE-----

--k9Jnbqt0PQC5h0Qc--
