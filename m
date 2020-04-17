Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 926021ADEE1
	for <lists+linux-iio@lfdr.de>; Fri, 17 Apr 2020 15:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730769AbgDQN6Z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Apr 2020 09:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730563AbgDQN6Y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Apr 2020 09:58:24 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B887C061A0C;
        Fri, 17 Apr 2020 06:58:24 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id v7so2463663qkc.0;
        Fri, 17 Apr 2020 06:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r8S2kr+1qqUEZmx89jm+Cng1XtsvEmNd5bR0TB0uIJE=;
        b=iotocs2RNeI49d3mnbUlyAa5zwoDWCGA0757Yxah/0qc/j0AXXBLIPdxm09p9H3Ir/
         ptEt4ci5MW89V7TZlQs31KRvTGMk8ozPnpLACN8LIOOr/WKfYDTBrX1F83DukeJXi9xS
         6ttqPRpMBj1/RlCpXob8wDDKXyBK+3cIPxDok6r8TrctMVcEQVXnSCpmXegLDLwsetmh
         5chGVw6tndImMDtEC4XJhTDad+TBkL4bq7fFdL6rHr/LVgscNOV9lGHEx9j+cWZ3tDyp
         0DVE2cbOpa4b1IpjbWK4vjYT6BqkdS0Nz9jr56kzWrokadZjKXEOw3+it++I1LGTXkzH
         eGVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r8S2kr+1qqUEZmx89jm+Cng1XtsvEmNd5bR0TB0uIJE=;
        b=kUAug7oTP+pzvuV4S2ABQiJ5Y+QR/DLBAmet0nXDNct1nugGXH395W0bvHhWbqJlUO
         NSW6YyUK6YVhXPkpRe5TQpAvXe/7J0oCX57idAguqAiLuaX4pc63YjyVvNv/4bNQmtab
         a1pnFqRHoV0piabNbGOaVcVxR2nhoqisCtWUi5bpn/LPCp6+gMaNZ5ZG+wmoYaRKX/xv
         NM6LcYbhefmN7yNbvU1lNUQui7MwIHUtbABuXniY/eIv/qi10gA3BXeQHgu7VvG/4f6e
         D05c9fk7z9aFgbtWgai3MH1W9KRCZCmCxAWz71RGGbyVZoZjP1g4ak5X22PpMXdsJEwv
         kz5g==
X-Gm-Message-State: AGi0PuZn6xnOIKGK1gFyrc2R7x0khVMHRDcrCFw/AiMNJuK4lIf0Ay0Y
        qg/A5SP+66dtvQ2T2/u97F4=
X-Google-Smtp-Source: APiQypLycIbxKLBQBj/VxBvwEctnJBVu08QReewXgY6W5HGc4qa7J3lYp+camisa7kG+4/t0wN902Q==
X-Received: by 2002:a37:63d1:: with SMTP id x200mr3442405qkb.144.1587131903728;
        Fri, 17 Apr 2020 06:58:23 -0700 (PDT)
Received: from icarus (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id y6sm8991279qky.133.2020.04.17.06.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 06:58:22 -0700 (PDT)
Date:   Fri, 17 Apr 2020 09:58:20 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Kamel Bouhara <kamel.bouhara@bootlin.com>, jic23@kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: counter: microchip-tcb-capture
 counter
Message-ID: <20200417135820.GB94725@icarus>
References: <20200415130455.2222019-1-kamel.bouhara@bootlin.com>
 <20200415130455.2222019-3-kamel.bouhara@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Content-Disposition: inline
In-Reply-To: <20200415130455.2222019-3-kamel.bouhara@bootlin.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2020 at 03:04:54PM +0200, Kamel Bouhara wrote:
> Describe the devicetree binding for the Microchip TCB module.
> Each counter blocks exposes three independent counters.
>=20
> However, when configured in quadrature decoder, both channel <0> and <1>
> are required for speed/position and rotation capture (yet only the
> position is captured).
>=20
> Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

> ---
> Changes from v3:
>  - Updated the brand name: s/atmel/microchip/.
>=20
> Changes from v2:
>  - Fixed errors reported by dt_binding_check
>=20
>  .../counter/microchip-tcb-capture.yaml        | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/counter/microchip-t=
cb-capture.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/counter/microchip-tcb-capt=
ure.yaml b/Documentation/devicetree/bindings/counter/microchip-tcb-capture.=
yaml
> new file mode 100644
> index 000000000000..183e9ee4c049
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/counter/microchip-tcb-capture.yaml
> @@ -0,0 +1,33 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/counter/microchip-tcb-capture.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip TCB Counter
> +
> +maintainers:
> +  - Kamel Bouhara <kamel.bouhara@bootlin.com>
> +
> +properties:
> +  compatible:
> +    const: "microchip,tcb-capture"
> +
> +  reg:
> +    description: TCB capture channel to register as counter device.
> +      Each channel is independent therefore only one channel is
> +      registered by default execpt for the QDEC mode where both TCB0's
> +      channels <0> and  <1> are required.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    tcb0: timer@f800c000 {
> +        compatible =3D "microchip,tcb-capture";
> +        reg =3D <0>, <1>;
> +    };
> --=20
> 2.25.0
>=20

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl6ZtfwACgkQhvpINdm7
VJJyFg//WHsXZYH0on+vZZkrMR5ZzW8MOCpE+wrxZiS8hKDnCyQZV6iLxv9ySQi/
BmWiyF2rMpE7Jt35ALYT82NwfljVPD4JCrqUjESxREF5N6TxtsaHyjjyo9elPG6x
2vG0aUHWSZecCgt/IhALWE7i3A39oADcsIKf4DDrM/Sg1syaOYmds8F3YtR8uygl
x+2YZISXhYreGwfipfs3qp2LtbgvXahytEZE01EQAmpZOptcZS3pRL2Ke/zYQmbr
/yMKknNB82sDFGFty1A28zZ9guz767p+7cilZwTqkWxBOHR40G6ieIQ2wHYYktm6
yc4AL1/nfdRpXBIlPL2FcxyftrdnV+DG6hyXm58o56JFoESPI3gMoOwEqFFYhNn8
W1hszb+C6N9pKszPABb9K1eLHwQQfj4sbi+DdeH4mME/ItpIKeF/hJ/K/62yvGyu
XSg9utS00CYB2YKB832S5v8/wanuO69g+8kMes25QBeiUiIXd/ne2UUsHx64akkc
Gx3lWSKJmNPNDJuciTCW+r7ax3wLjn9nQjZV887GK6oNiuo4qbrrU1p+71OMBnHc
N7ezTozJG8dWWoN2DDPU6D2rw4mcFxmls24ryA8OVv0Nrvvg9R/5wh8Hg1BXN7VU
6E4lGrFc40Q//KgHIsnc0BO6I4eaq/JIEDA73cqLBe7kXxiUDfc=
=yr/6
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--
