Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9764F1A2839
	for <lists+linux-iio@lfdr.de>; Wed,  8 Apr 2020 20:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbgDHSDG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Apr 2020 14:03:06 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]:39727 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729150AbgDHSDG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Apr 2020 14:03:06 -0400
Received: by mail-qk1-f170.google.com with SMTP id b62so1173431qkf.6
        for <linux-iio@vger.kernel.org>; Wed, 08 Apr 2020 11:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CsOEXG0rnAUF9xGOtTjsaqqpAGI638ATTP57xnW3Iks=;
        b=g+9mYrUSGlOvAFXUG/TTP2qeezFGuaaougYYVkqfh+RHJRtr9gfPtUoAr622wNaGGO
         R5VBUaOr3S+D00ycVurc/gA8Hr4ZPme4YMXuqE1cUHrQbpXngK3nzaB8WJv5SAh7vTF+
         5chCTRD/8mnpGtBdkiq31WwKP++l79yqHwNw9ZV2obyPJJLlu0+jVDNHyEK5rf52Rg+E
         FVkgkcJo75qYyE0AZNXf4GSLNFcF5wuDxFc3xdzXV5M4GfAq/haNWJbJ2hjphlv7oG4H
         SRFVx2u/Xo/fEn62UX3rUWiJ9b5Q7MxUgZZW0BnIduM/cbp4zXya9hqjEs2evdlOtdcX
         +2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CsOEXG0rnAUF9xGOtTjsaqqpAGI638ATTP57xnW3Iks=;
        b=OOQcQ+7dsn4e65GbrUWkMFCRFm8+htGBKLwQGD0wBON2ROnEnWp4Trw6qkbz8J+ij/
         X0U/dlhR8pCtIBLk2nF+L+7jVGBoeLt7HwXR6UdAIcNzrX0UQASCCFvq+XWiVQ7vF8TL
         oADlaSCe3JlWgqeTpcnyr6Z4ucMe0kf8YoWkPvKnguBLeYoKN1dVpB1Vwea3SDenURbP
         1tFtibPmSdtmWHyujMdsRL1guTNrlE4BWr2KDCPIhrjBi7KzN50tlkQt2dQThAJzPF0T
         KH/WvrWOryc7V41CdLDCUBFhFzPD6HhLQyXcpXiuonx/UZq3l+Zb4Wnv07W+szcxMn1g
         dSbg==
X-Gm-Message-State: AGi0Puaj4W8ZSYUz6Y1+ywghVilgbU/YkBqRQpxzFJf+s0EWTMz0REos
        CAWzqKlLCpui0FrF3q/cCKA=
X-Google-Smtp-Source: APiQypIIFDuHO0Ry2/2YY5fe8lda/p+hhZqD7mBD3V7HWHzHDDRbS4mAOjLdb9HwPJRlqYd4qgYBbQ==
X-Received: by 2002:ae9:c00b:: with SMTP id u11mr999088qkk.473.1586368984445;
        Wed, 08 Apr 2020 11:03:04 -0700 (PDT)
Received: from icarus (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id u13sm19204415qku.92.2020.04.08.11.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 11:03:03 -0700 (PDT)
Date:   Wed, 8 Apr 2020 14:02:56 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>
Subject: Re: RFC: Present Screen rotation as counter
Message-ID: <20200408180256.GB25871@icarus>
References: <CAPUE2uuL8AU8ps=aLGgkqDR3FVxeWCOoMhj+OruZ6YT5Jn+m0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Content-Disposition: inline
In-Reply-To: <CAPUE2uuL8AU8ps=aLGgkqDR3FVxeWCOoMhj+OruZ6YT5Jn+m0Q@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 08, 2020 at 12:22:10AM -0700, Gwendal Grignou wrote:
> Today, on chromebook, to detect screen orientation (portrait,
> landscape, inverted portrait, inverted landscape), chrome is polling
> lid accelerometer data and calculating the orientation.
> To save power, I want the embedded controller (EC) to forward an event
> when the lid acceleration detects an orientation change.
> To convey that information, I would like to define a rotary encoder
> with 4 regions, the counter increases when the screen is rotated
> clockwise, (decreases when rotated counter-clockwise) and would
> increment by 4 on a full rotation.
> The EC knows the accelerometer placement relative to the screen, so we
> can define landscape as count % 4 equals to 0.
> Would such a counter fit into the counter subsystem?
>=20
> Regards,
> Gwendal.

The Counter subsystem is capable of representing this using a design
that looks something like this:

        Count                Synapse        Signal
        -----                -------        ------
+---------------------+
| Data: Orientation   |     EC Event       _______________
| Function: Rotate    |  <-------------   / Accelerometer \
|                     |                  ___________________
+---------------------+

Note: I'm calling the function "Rotate" here just to represent the
increase/decrease behavior of a rotary device, but perhaps a more
generic name for this function would be better here for other devices as
well.

Essentially, within the Generic Counter paradigm, the Signal in this
case is the accelerometer data. The Synapse is the EC event
(clockwise/counter-clockwise movement detected) that fires when the EC
notices the accelerometer placement changed relative to the screen.
Finally, the Count is the orientation of the screen.

We can have the Count value be an unsigned integer (0-4) to represent
each orientation, or an angle (90 degrees, 180 degrees, etc.) if you
want it to be more abstract -- it's up to you.

By the way, although I'm labeling the Signal and Synapses here as
Accelerometer and EC Event respectively, the counter driver you write
does not need to actually present these raw data values to the user --
I'm just including it here in the drawing to exemplify the paradigm; the
user of this counter driver will likely only care about the Count: the
current orientation value of the screen.

William Breathitt Gray

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl6OEasACgkQhvpINdm7
VJI3hA/+Jt/udfMpuNEDKYw4Rz8mKPhKC7xcdU2QWActZUOd8E1Xr5mSDenBES5B
0rSMiSbT/G1bU48r/pWnFJa1DW0Tkr+1AWZTOBuhxOLDdoD8boyEhB5J2xQbBXIA
MKG8VBGAa8o0Tdh56Yn6RDhNI9Fmzq3ifM6C5Y+OPzahYySq7GrtuA7f/lJ6n/V/
LbzhdK7cnKiEH6BHXadazG2f49Ogj0cyFCdcFJjkOiBNIrOZBvBFZPucNvJouRFW
inadb39pSPojrHhgtAoFljefbJfl0TpAivAmAaczK9R9wvebGCNn3icp8ftbQDDB
hL/Rh22C52u2aDSYFfq76s9saIJmGYIf2UAdzrygfwuTNRQ3otmhllYHAJBoy/zO
YmXZbkVs6TIkDksmTTybeFTEUUm2XphvDbEY1bzHPO2EayNqSc8tYirbwQvhKiOp
aUNrENQT96+SXBwedP8ncTv8Og2Cjxwlcc3Q6F01zaFyQkKW67GtEYPvsJs8ZHbD
q7VIcJ3adbGN9ZdOQQCaFlOhXBvXAMrmmcDP1i0oRyo2LfGUiNYmWHhjW2rHxsde
G0sRRIE4Ap0yJdwyRLAxYHSP6zoddUKDYbo1pWYBn4uVcoJ1ovxYhNayI+sxfKXk
pMoTbUIN2u0j2E7wzAO8WHyrHS2hcgKkKdMYEPktDCqt7T6E9l8=
=h9Fe
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--
