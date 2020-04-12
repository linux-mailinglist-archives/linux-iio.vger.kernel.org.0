Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3E0E1A5BDE
	for <lists+linux-iio@lfdr.de>; Sun, 12 Apr 2020 03:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgDLBtI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Apr 2020 21:49:08 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34188 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbgDLBtI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Apr 2020 21:49:08 -0400
Received: by mail-qk1-f193.google.com with SMTP id t3so2405430qkg.1;
        Sat, 11 Apr 2020 18:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+9Y3dV2Xtqku3qCrqdtglCwXhbHqnJgBuqt5KN+/kvg=;
        b=YBZbJcc2LD98dHyVKU3N1vQhlEmAYnA3UYBtOP15S1lZNBAIEm0GTF7xL3d23wT/NQ
         DgrhZAlFsfSSRh+eCWgoyQUqHKFF+ZC0rfE3H4wo65JXU8/KSHNTTieZthVhaaZR+dYI
         0GA8ymh5pR1f9cMrllMX5O8AtqIct+/ipWZBTRaQrh/XvJvfxYnhGjjyfuctNyvUB8hH
         bAZQ6IozBklxpY234SyPCL/bHiepyiwWAiPpDDHECXeTk+esu7gTE4ofDRAO42O8d2RA
         f4JyAODQP7TdOdadjz8RgOrB7uFLUPghKUHbb14waASLjvMJRJTJMuE97Ei35S/5c0nV
         cHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+9Y3dV2Xtqku3qCrqdtglCwXhbHqnJgBuqt5KN+/kvg=;
        b=Ry5gDsPBP1UbLjXgE+v70l1nGxTtRQjlGcKQNn0dLrWbWBUCwJBqBcGwM2E3V7Z/t4
         b0EN4uqb0Nah9yh/Q2gnMchVwD9qDZhcHcaylbV68DlbqN08m7WPCwY/WeKTgEEQiOWr
         mTkiVH3vzIOQtLtbw/rkK/zQ34jSS159wBEdQuCUcMNkVPhDMCrrI+FIu+DJwqsTgfa0
         gdFInIxs7Anq/nTfFx+MLs8Ugj7fuFloHE3UFVuovBa2av8DzRNm9kHxST6HBi74ZRtv
         qxlDt/aSo2v/11oBvsNuC1oTd6t5Y0oWagAHN9uzwX5PiGLbY3S1pVmioWD9aVyRU2Ic
         bhNw==
X-Gm-Message-State: AGi0PuaGOY04DQmEFEUpXiG9nM99KU1v41OZzCZRUsRBQAfC2PpU0cZ0
        zWwyc3oQRNbJspCLkWxRi2s=
X-Google-Smtp-Source: APiQypKmffyrA28h99L9u2AYaxmu/LUn4aSf8as55IdDhJF1wTNt/ElTINEknk5ayr3tVCyCCXPd5g==
X-Received: by 2002:a37:317:: with SMTP id 23mr10488030qkd.233.1586656145392;
        Sat, 11 Apr 2020 18:49:05 -0700 (PDT)
Received: from icarus (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id l7sm4979378qkb.47.2020.04.11.18.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2020 18:49:04 -0700 (PDT)
Date:   Sat, 11 Apr 2020 21:48:48 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Kamel Bouhara <kamel.bouhara@bootlin.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/3] Introduce a counter inkernel API
Message-ID: <20200412014848.GA108143@icarus>
References: <20200406155806.1295169-1-kamel.bouhara@bootlin.com>
 <20200411172259.GB95806@icarus>
 <20200411233145.GC3628@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
In-Reply-To: <20200411233145.GC3628@piout.net>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 12, 2020 at 01:31:45AM +0200, Alexandre Belloni wrote:
> Hi,
>=20
> On 11/04/2020 13:22:59-0400, William Breathitt Gray wrote:
> > I'm not inherently opposed to adding an in-kernel API for the Counter
> > subsystem, but I'm not sure yet if it's necessary for this particular
> > situation.
> >=20
> > Is the purpose of this driver to allow users to poll on the rotary
> > encoder position value? If so, perhaps instead of an in-kernel API, the
> > polling functionality should be added as part of the Counter subsystem;
> > I can see this being a useful feature for many counter devices, and
> > it'll keep the code contained to a single subsystem.
> >=20
> > By the way, I'm going to be submitting a major update to the Counter
> > subsystem code in the next couple weeks that isolates the sysfs code
> > from the rest of the subsystem -- it'll likely affect the interface and
> > code here -- so I'll probably wait to decide for certain until that
> > patch lands; I anticipate it making things easier for you here after
> > it's merged.
> >=20
> > For now, I want to get a better high-level understanding about how users
> > would interact with this driver to use the device (input_setup_polling
> > is a new call for me). That should help me understand whether an
> > in-kernel API is the best choice here.
> >=20
>=20
> Well, the goal is not really polling the counters but mainly exposing
> the correct userspace interface for the rotary encoders that are
> connected to quadrature decoders.
>=20
> The input driver is using polling because this reduces the complexity of
> the patches but the ultimate goal is to also have interrupts working.

Okay, I think understand now. Interrupt support is another feature I
want to get working for counters too, so that development will probably
overlap with this driver as well. Hopefully with interrupts working
you'll be able to signal to the input driver whenever data is ready,
rather than just polling periodically to check.

> I'm pretty sure the in-kernel interface can also have other usages like
> for example iio triggers. I could envision having to read an ADC after x
> turns of a motor to check for the torque.

That's an interesting use case. I can see how an in-kernel interface
would be helpful here.

> I also think that having the sysfs code separate would help as it could
> be considered as one of the in-kernel interface user.
>=20
> BTW, do you have plans to add a character device interface?

Yes, actually a character device interface (and the timestamp feature)
is the primary motivation for this refactoring: sysfs code is separated
so that it can share a common core of functionality with the character
device code.

Implementing an in-kernel API should be trivial after these changes
since it will be just a matter of codifying the shared code that forms
the new core of the Counter subsystem. So perhaps this patchset should
wait until the Counter subsystem is updated, since it may be easier to
interact with counter devices once that is complete.

If you're curious about this patch, it's available on my personal iio
tree in the counter_chardev branch:
https://gitlab.com/vilhelmgray/iio/-/commits/counter_chardev/

I still need to add the character device code and respective userspace
API, but I expect to have it completed in the next couple weeks,
assuming no major issues or delays arise.

William Breathitt Gray

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl6Sc3MACgkQhvpINdm7
VJI6mRAA0IuuWWCtufHeMdtLn9J/o04q1ZcvE5YsY8vDHCdSvnRTGp0HvjEmd5jO
GZFU7ljEwqRf1FwPjmn3SkoQfoMMpbyp6TWDTNzAKV+rOEu+iOR6VJwnjzmwmYNV
PtHErMSFSAbB36jr2mKODi9eUPmFIQmrOXpnmXDKwxTHgq+i76a3T4z7WSDSoX2u
1rVjFav0cyT2BZPEaBb2YO8BlGqSUTk5EcG7ORiuXGoR87BOXpilHp95c9WZZpbY
gZ3N8Q9Kpll6ZC/SVFo9ZKwxR2wEV1NV/+Shl8wauQ6oB4Oljy6iOY+r7aSsUXmM
R9DmWrvwzIeYa+LRcIfcdrENUfqqgXjCDHtKJbBd+ux88KI/zzohcoPw6hO0uRe+
ZH16nqYrHhlWmn6N9OptrC7yinm3AC+68E64L/9I898rPFHbOpJW/0yfeGXIWq+U
Er1AkqmsZngFr8wmfehBNMc12gL/+Fy4xo0DvozxfmZkqCI/UzQW0qAqUxiyYbEQ
AKmodl8jENNjGMkvFAO+q0MIg9R2kNKRc4B+ekRnA47m0MopIR+kpwvzagW4Razs
LlNK/7napsnNiOP1ETUJeqlKQI6kgaxcsrYbtjD5XWj8LuqYQeuN3+xgVAsqjHP/
OO+VzX1USpVNKc29yn9uzqVfyajwEBFCWoJdXi7alCpwI/LCXxI=
=Xd2U
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
