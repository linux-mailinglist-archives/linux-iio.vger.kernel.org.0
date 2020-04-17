Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5213E1ADED1
	for <lists+linux-iio@lfdr.de>; Fri, 17 Apr 2020 15:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730714AbgDQN5G (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Apr 2020 09:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730691AbgDQN5G (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Apr 2020 09:57:06 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E91C061A0C;
        Fri, 17 Apr 2020 06:57:05 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id bu9so872040qvb.13;
        Fri, 17 Apr 2020 06:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oqcTP4i+a7YGi21w2c2gncPHzEaLd+RyksgvDG1LlGQ=;
        b=nkL7/2UwuToC9Qt2i6kcBIZYANeglyiEJgWOvtfpq4CAtzTk8zAzGzjSbhyG5yIke6
         KxE5LoodWN5XEKHKMjhMDp86xkGpMNypr4Bzx3u2ATA4iJ7Jb8YJldfTGpt9Y+Ci07Bo
         M4SlUWnmNlNBz/3Nk5rRLPh3a3tskzCNw9gefdLV32J4FVJed4gkMGBhfLouR+KAcqwv
         Hjz77TBwDuzNqzR8TRVMb2zH9Gjj8p0o7KhDbdXJvo0wkW/jnEfv7yRyCFsxNmiTMv8P
         kpX1+99eQeajo6XQsWCYZPqVXdsDpBF2GssNE1UxgK11+hpfsijVHnij9ARtEpzjQDr4
         rrTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oqcTP4i+a7YGi21w2c2gncPHzEaLd+RyksgvDG1LlGQ=;
        b=TdAccyl4dLAO6kbap9CmJfbk/+/DTywY3GSDVo2ZNaqYqaNpKz+ARbIauKLsQgQsEI
         v4uNLMuMJ1BR4ZIfdIv0oBJ6WNOk6dxbPHPy2gA+JdB4w8cqlAF8fQZWJjq9iNSkJiZP
         GIJAqJD44XWnifKTVcvC6dWv4HTO3rSA+8vtkuske4AoeezupilJq2vL1Cnlmn3TJV0M
         CgjaOpDKX5pRJB2ROHHVTvw7XeikqGSD1NTa7L0GSMUwE/C/fPjYQZzbH8zE4bL7diAc
         dU84BOSI+lbmTwXSk5ovkkL1hyY3JSduAzn+cDjCz2ZVCVINJE2QOfFPYAdQOkujqLac
         8mzg==
X-Gm-Message-State: AGi0PuZasHFS4rj3xA50dgpcegxYazs4qZ5Rg8f4zbMsmojbFIgm+bvy
        jU0448gMO5i+SdrqZRz8CXU=
X-Google-Smtp-Source: APiQypJ8JrKJ3vHc/mky7+x34T8yXzxIAA4sFNSJhjCHLPgr3v5dwnzrf21iZm9GgH2AV8+9/WiOoQ==
X-Received: by 2002:ad4:4744:: with SMTP id c4mr2857740qvx.203.1587131825006;
        Fri, 17 Apr 2020 06:57:05 -0700 (PDT)
Received: from icarus (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id s18sm6143621qkg.53.2020.04.17.06.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 06:57:03 -0700 (PDT)
Date:   Fri, 17 Apr 2020 09:56:35 -0400
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
Subject: Re: [PATCH v3 1/3] ARM: at91: add atmel tcb capabilities
Message-ID: <20200417135635.GA94725@icarus>
References: <20200415130455.2222019-1-kamel.bouhara@bootlin.com>
 <20200415130455.2222019-2-kamel.bouhara@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <20200415130455.2222019-2-kamel.bouhara@bootlin.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2020 at 03:04:53PM +0200, Kamel Bouhara wrote:
> Some atmel socs have extra tcb capabilities that allow using a generic
> clock source or enabling a quadrature decoder.
>=20
> Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

> ---
> Changes from v3:
>  - Added missing kernel doc for new elements introduced in structure
>    atmel_tcb_config.
>=20
> Changes from v2:
>  - Fixed first patch not applying on mainline
>=20
>  include/soc/at91/atmel_tcb.h | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/include/soc/at91/atmel_tcb.h b/include/soc/at91/atmel_tcb.h
> index c3c7200ce151..1d7071dc0bca 100644
> --- a/include/soc/at91/atmel_tcb.h
> +++ b/include/soc/at91/atmel_tcb.h
> @@ -36,9 +36,14 @@ struct clk;
>  /**
>   * struct atmel_tcb_config - SoC data for a Timer/Counter Block
>   * @counter_width: size in bits of a timer counter register
> + * @has_gclk: boolean indicating if a timer counter has a generic clock
> + * @has_qdec: boolean indicating if a timer counter has a quadrature
> + * decoder.
>   */
>  struct atmel_tcb_config {
>  	size_t	counter_width;
> +	bool    has_gclk;
> +	bool    has_qdec;
>  };
> =20
>  /**
> --=20
> 2.25.0
>=20

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl6ZtX0ACgkQhvpINdm7
VJJsmg//ZzvO1iZZuwiC/V4qTReyr1hNkDABRiGVHOtaLLWCoDyPqxgZ+03mUfjz
nOHOaS4wHv52thU/N9zcgqT9gLTpStioyU7TTVdQONnINc1N9ObHfwX3+OYbtsAF
8ebes1Drz/cx13tJo/UR8IkyExUn9x18447s1cfUrzYVfTYLZUrbD6IweqL0NKgd
vNpOFWF0hNPy65DKp7qtmbURpAJjUOCTXPjJQcGdwcBtkYIDyFDcc1vO4f5QrM3d
uk7OWGdaLgyqp0rUkvXEWZT11CRP4OvuK0BLYrNgucE1hkU5vtzcA8pa1JJlCBer
fkbrLDUvazavSf1buTJZoxZbAfRtmTnBS1U5np/THmggu3kbNl0LDrSYcrjFJEr5
JmT5GCKyZy3C8vLHBKPOMkQ6MnQXRtpB+NtNCne4/6SFJRBC0LC73cwma04/hSm0
DTrxc+nVoDfrxXQEvlQ+neAoADJJx4gGh0BLdj09dO8jJHV9g2tm9/NUDur0U9wm
aJRxAB8WrXHup1lVaXC1pqd5sLNoeChLjL5SKOjUPqEnxfXlbZnFVSlhDo63aziN
YyJFpOxEh99s0HxfMMlibjGbUV1tL76Cb+wNAO1+DbjCgtFqbEzIwpKnriMEdy6q
E9bnkPrkRz/OexR1od28QEROZo5Uvl9PuhMyPcL8k83RzMW5/2Y=
=G8zt
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
