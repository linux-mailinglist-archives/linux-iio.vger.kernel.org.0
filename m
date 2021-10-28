Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2656143DC94
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 09:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhJ1IBo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Oct 2021 04:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbhJ1IBo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Oct 2021 04:01:44 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE6BC061570;
        Thu, 28 Oct 2021 00:59:17 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id n11-20020a17090a2bcb00b001a1e7a0a6a6so7351530pje.0;
        Thu, 28 Oct 2021 00:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WAuGYNbo/AA6GA7SUHxxtP8LSZF8idLZrI6kORizGFk=;
        b=K0CRhciV+Fa4xYa652bhU2Qbrcq2efo/uHMWjBWGdMUVJd0F8KCwPIMQ7E93PcmCaU
         wjI30s5I6Bo4TDFol5YqHP2+EU+O3lQ0mzRShq048VYjI9+Yh2BxFOTRLFzrJLBz3wCD
         eETTh9AHYlM0k85GWwIWWvsYqYWEOXJajXVUsuTVDDQOY1yCDrp225tAMj74hvysd94+
         1hKfaxEzxILsOSMoCeF1BXneOtGuImyNaeCy/S8r5pbDHEmPdnpuqgZPQvSpIGUqOvUK
         X7PM+xQW2sRpVWgH1PR6fgKW/2WbjMfHUMFPl7oT0DLumEKaGBBp0rfQsFdWMt217y0p
         lCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WAuGYNbo/AA6GA7SUHxxtP8LSZF8idLZrI6kORizGFk=;
        b=RuSqwiGidAWOnHqeMAjZnI7qmizBdG3IWXjCg0AUcVmW9qbBv4jHUJnkjYpjcuw/ii
         23ftcEyfRxuuwdE4zanCjoH57fRrkwdZJw6DG18xKaVQtiv7ag0CY4TUAvChMGUhT/PV
         brFyVcPN3xzrM8OzxJBsqVrqCq3yvqP1tbMHpx+x+sRk24nkLSL/6kx0pmnsDb/4tCNI
         fiQv0ZrKS1cijbsB0gm9NpNSuJ+pDFXkHhbkNOc9QTd2sq6lN3GGvsgUaTrtA8C+qyfx
         YD9sjOL9H3YNkLwUsHw4MZ+x5a6M8idnHkxPS+U93IU4T78XgF/kCT9KaeLpD19jGhOD
         W/tQ==
X-Gm-Message-State: AOAM5303AYp/cTGvMuKn5iY9hgRCKPh8SpJBJKPKTuDwjSeqrRYg+9cX
        EiN/35JIv3DAUHrLSAS8Dk4j8FC72qg=
X-Google-Smtp-Source: ABdhPJxW308wutNNZsfzuUxliY4SLoyiVzFbHVwefJZ+PIE14lMcCb6ekAgSpwfDR+MjiJZRigehmA==
X-Received: by 2002:a17:90b:3b52:: with SMTP id ot18mr11056313pjb.77.1635407957405;
        Thu, 28 Oct 2021 00:59:17 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id f21sm2828759pfc.89.2021.10.28.00.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 00:59:16 -0700 (PDT)
Date:   Thu, 28 Oct 2021 16:59:12 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     linux-iio@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] docs: counter: add unit timer sysfs attributes
Message-ID: <YXpYUIUIQe+oxwXK@shinobu>
References: <20211017013343.3385923-1-david@lechnology.com>
 <20211017013343.3385923-5-david@lechnology.com>
 <YXj1xc6DdeOrUKjW@shinobu>
 <6e96cdd9-d1f1-6861-59eb-c4e6b9a2ffb9@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="79xH+X/itCG/Y5or"
Content-Disposition: inline
In-Reply-To: <6e96cdd9-d1f1-6861-59eb-c4e6b9a2ffb9@lechnology.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--79xH+X/itCG/Y5or
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 27, 2021 at 10:30:36AM -0500, David Lechner wrote:
> On 10/27/21 1:46 AM, William Breathitt Gray wrote:
> > On Sat, Oct 16, 2021 at 08:33:39PM -0500, David Lechner wrote:
> >> This documents new unit timer sysfs attributes for the counter
> >> subsystem.
> >>
> >> Signed-off-by: David Lechner <david@lechnology.com>
> >=20
> > Hello David,
> >=20
> > The unit timer is effectively a Count in its own right, so instead of
> > introducing new sysfs attributes you can just implement it as another
> > Count in the driver. Count 0 is "QPOSCNT", so set the name of this new
> > Count 1 as "Unit Timer" (or the datasheet naming if more apt) to
> > differentiate the Counts. You can then provide the "unit_timer_enable",
> > "unit_timer_period", and "unit_timer_time" functionalities as respective
> > Count 1 extensions ("enable" and "period") and Count 1 "count".

Actually if the counter function here is COUNTER_FUNCTION_DECREASE, then
instead of introducing a new "period" extension, define this as a
"ceiling" extension; that's what ceiling represents in the Counter
interface: "the upper limit for the respective counter", which is the
period of a timer counting down to a timeout.

William Breathitt Gray

> >=20
> > If you believe it appropriate, you can provide the raw timer ticks via
> > the Count 1 "count" while a nanoseconds interface is provided via a
> > Count 1 extension "timeout" (or something similar).
> >=20
>=20
> Sounds reasonable.
>=20

--79xH+X/itCG/Y5or
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmF6WFAACgkQhvpINdm7
VJJGaw/9FMQQqedX6WSzBBOZ4Rdrp6CWG/0QpTwrcCh//QK6p6xnOKWl/E0ra83Z
HALAoo6k5KN+8Cq+6mYd/XGuKKacpeXREtnE9dy/Sbsa2RNHmYwODVKB+gQiC0BR
QD6b+8eFEfW3h9x3vW7lvzwjV9UmCO83uqeHsZu2KU0jRUHjcxIiWeoWaMhaTNRx
qltz1gGLi4BHoXNiA66AnqUc7QZUhmEjUU7N0fQ65hBC4NQEUNzSN1l+o6SrdBxu
8MKipszR4Kz1SlPAMU4h/LZKUgOPuth1x/ptd1GpiSqrd2OaKT3seRnGUC4/Zkl7
U03EZkzrJvodq75KeTq+ITansSDYABz1DcB7VYt2JdBIcjC4O8GBV/phivybeYHs
Gopj2A4JmfjUbibQItFZiezEmTOkJ2icpZ+YNPnZRQMPKmpdNqtWS1PoPXLCzAYi
yV49oUPD/BPISA7LrMU/cMyKrdkptrsek74ECa3N79eCWFbYzm6tLaTzI/mVjK/D
crQbceWAAGftLPCVtYEIYdLwB24/vPW+CtcvulRXfnbJy/vo3Ouu7P5uXrYVISz/
4CHqfneiC0UNdf/xtnMe+H5YRUGZpAvdGOcb95xFz0nJWIkeEpl/Nb5QKw9bhp1f
ZLyvfvEvaz+lmbyWqZ5p/+0fiZdtzvZijfIdAaUPUPJrHNUav5w=
=izg9
-----END PGP SIGNATURE-----

--79xH+X/itCG/Y5or--
