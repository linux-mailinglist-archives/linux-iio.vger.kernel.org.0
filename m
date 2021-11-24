Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3292C45B430
	for <lists+linux-iio@lfdr.de>; Wed, 24 Nov 2021 07:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbhKXGMW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 24 Nov 2021 01:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbhKXGMU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 24 Nov 2021 01:12:20 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69483C061574;
        Tue, 23 Nov 2021 22:09:11 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id iq11so1617378pjb.3;
        Tue, 23 Nov 2021 22:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ez3QVmY1XZw+pekgl/gvhcD1cD5LMLp7Mm2ELoCCbMI=;
        b=h5CEV2+WsUwc8/HreAiVGYTBNHdZJ+zz53f3CxfyoOsAYuJAJxaDQxOPKYKZJbwvzb
         AQvQcBL0hIC5eRbDa7CFXFUGxk0f1KqSDZUlyw8KSJbZPumqyhRei38HNwoqFvs2mc4O
         sPn7UXTN+43PaDxJMQzhprWbRXhBU20um7i9F7hBhg7YuAEWsn6pmDGpBkfWQ0nIO9CK
         qvRQKX6JFS6AtZVPmYVqCkLLIEE+J4G92Jqal7cFeZ9QMhdSfRSHT82frjwUZEHtj2mr
         PpCA6r06L4jGbIfTFjSBHW9TphpigyXPdpRtAUaJnQ2s1CrJb82MkzWPzFZB9o8xGHWi
         7p+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ez3QVmY1XZw+pekgl/gvhcD1cD5LMLp7Mm2ELoCCbMI=;
        b=GOMsyQW1sAWZnmf6VjOQVOIarXJRCWKDZdB/mR29Tf5A0rwlL64j2Jo6u1TqK2lVhK
         3MfATAAzykDbP8ke7mQ13T+aBYHcGZuGng3QmPehih0dOHWofS2zwpx5J2fs+H4dOJ6U
         e9u6UnE6NRprMhcjnuPPe51WauqlG7OsJtrcTSt6baL9RnogNYhHJxMKxY5t10x1AtqQ
         lIZAyYNv+9an+MR9JdbH/TOv7iZUqzriZ5FZ2pOkSm3IV4E+ZhxEyCmvfdJymiPnSv9+
         srzJyGkn8GSBwJlL6i6gZQMEAll0RuCVP+wKhpENQAIiT+W4FCSMqfgL+C4SEUmflhQD
         th8w==
X-Gm-Message-State: AOAM5317iarUPkGWr7etodJD/yLh4T0Azqto9y1R2MbxsxpzaILgKH80
        628IU/wlsMlHMbhKkA8pdZQQRcpIz4YweUKX
X-Google-Smtp-Source: ABdhPJyw/JF5kY8+OyLhjkD8kLe/zEuGlhEXXZQoIR5tyL0Qvk6c9jXAgMZe8x1TknF7rby6pGy7Zg==
X-Received: by 2002:a17:902:c407:b0:142:28fe:668e with SMTP id k7-20020a170902c40700b0014228fe668emr14946555plk.31.1637734151024;
        Tue, 23 Nov 2021 22:09:11 -0800 (PST)
Received: from shinobu ([138.199.21.12])
        by smtp.gmail.com with ESMTPSA id y130sm14122385pfg.202.2021.11.23.22.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 22:09:10 -0800 (PST)
Date:   Wed, 24 Nov 2021 15:09:05 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v1] counter: interrupt-cnt: add counter_push_event()
Message-ID: <YZ3XAeYyfGblfaOi@shinobu>
References: <20211123134540.416695-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="palXCgofjUSCif4g"
Content-Disposition: inline
In-Reply-To: <20211123134540.416695-1-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--palXCgofjUSCif4g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 23, 2021 at 02:45:40PM +0100, Oleksij Rempel wrote:
> Add counter_push_event() to notify user space about new pulses
>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/counter/interrupt-cnt.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-=
cnt.c
> index 8514a87fcbee..b237137b552b 100644
> --- a/drivers/counter/interrupt-cnt.c
> +++ b/drivers/counter/interrupt-cnt.c
> @@ -31,6 +31,8 @@ static irqreturn_t interrupt_cnt_isr(int irq, void *dev=
_id)
> =20
>  	atomic_inc(&priv->count);
> =20
> +	counter_push_event(&priv->counter, COUNTER_EVENT_OVERFLOW, 0);
> +
>  	return IRQ_HANDLED;
>  }
> =20
> --=20
> 2.30.2

Hi Oleksij,

It looks like this is pushing a COUNTER_EVENT_OVERFLOW event every time
an interrupt is handled, which I suspect is not what you want to happen.
The COUNTER_EVENT_OVERFLOW event indicates a count value overflow event,
so you'll need to check for a count value overflow before pushing the
event.

It would be good idea to implement a ceiling extension as well (you can
use the COUNTER_COMP_CEILING() macro) so that users can configure the
particular point where the value overflows.

William Breathitt Gray

--palXCgofjUSCif4g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmGd1vMACgkQhvpINdm7
VJKxmA//bXW8jn5mO+h9K3q21/57hhXT+8CzEcMMflP5qvx/IFqyufr36Ja/P3+Q
gcrhQzriZp28cyNmMNrX6OBE5wnN8pD2pG5+GoOvzfyHDM7qAYPU1F52ISGMIJSv
g1GXywDfe3vZriBMpr+ON5s0Lgp5MpMmII84kx9pVDU/Dp2nceuKAQ3GFcR5VHbW
llvoQapQ44b0FZOPc9yehavUztn/ZJLObyhF5QQiU/kp2ol/smf218nbZj7b0ZJB
/X3p+2rcp9njV3i9TWNR6E15eNrIEeueg29NYN1w8TtgCIhSsHIGkdp798uxFHu8
ddfJA/tfZoHV+aAjC1V32ibCA+BVmXFHhZuCM2pWkC//FtQwVMsKkY2CHULAKM5P
8sLCAWlRMHMkTPtOA1wNOOJwG7B62Ggz28gzQr05qJOyBdbS5kZ0w9lELmZJ3C1h
A07LojlKSeMRHmI51aryw+NxVWnutdsIMwiSJr20pbNH75IadU7/sM+bKbEZzzv2
DxUWl8M7U/P8rzEdxBbVOf7Ep226+iylaYm6uB5XioTK15BMqfPtD3AYQDcfQNjA
0++53y+ZFOdce7V3qDgHnvD0d0/E+Fk2CPOT1ayhRTSB1hVfsFDUCtToSpt6Lv+1
74nUXuHewLYQkCTl0Fmll7zwuhrqVLBI5cdKcK4ZJiCvp89yr6Q=
=2/qt
-----END PGP SIGNATURE-----

--palXCgofjUSCif4g--
