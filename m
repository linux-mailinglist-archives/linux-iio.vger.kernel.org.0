Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6E3600F88
	for <lists+linux-iio@lfdr.de>; Mon, 17 Oct 2022 14:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiJQMxY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Oct 2022 08:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiJQMxX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Oct 2022 08:53:23 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA13517E23
        for <linux-iio@vger.kernel.org>; Mon, 17 Oct 2022 05:53:22 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-131dda37dddso13168307fac.0
        for <linux-iio@vger.kernel.org>; Mon, 17 Oct 2022 05:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4F0B10iYi/PAmKuXgFf/stv8m99ECrYKKtefF1hT5os=;
        b=eo2JUGl2hPoZu5dBni4n3mNMdmOxwRHFvIZ7NPZY3bH306icrrtwwF+sfHJwedZ9iQ
         LE5wP1zJq8bo1Vd6aCHC/DvVOyVRl6qXZGIUAyBo2TzHowFOUOWyujFOA+51NjPYWTLq
         p6rxuFtOE8fOYGUMN0s9uPoBEsgVk6Q5AT1YCfbiIV2qJdDvimCo4nysoO2cSjrzijdQ
         uMdq+S0sjZmKZpHIW+tw8K/jXhYhubfJIUHT8qxGpjC3wk7dg0kVjZcf4bTDbhWKfOfD
         RlbGH6TUHZBJDJYC4fJu7yQVJkaerlTL6/gpw4IidQVkRXkzrfyr0gx7vsqS+HrzXKme
         CRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4F0B10iYi/PAmKuXgFf/stv8m99ECrYKKtefF1hT5os=;
        b=MgpMxjfJ/xfuYk8SwfRUpTf865lJbMIaV0uoU9ZW5uvrG4PorzZYbSyKTLcwR6uMkL
         EhzYKtA+YvqqXR4edC5La4XCGIj+csw8EjzKTvOeSeuAUm7iszBm5U/kPyIeTYVwp6EW
         KzRQ6cTZg7KTpZOBybiLEOFYgpBlEZSQw11QYda/TWhAFZdSoLAX0unIwBFl6l1vYg/P
         KzdSTv/53i+2YXyu+KDYI2FKnputVLrXC+iJbrh2f9wJ/2x8c41xjiIJZn/3zs8f2z2Z
         23LMkfx7u8S08xOpJyGzyMwolDncB3W6iDuvCtfj88kbcZICbFa95fAwpBnI3qeypB6c
         67aA==
X-Gm-Message-State: ACrzQf21OIVQaNdnj4zwUqsXi7sDXWwzv6oSLtngDe4CHCZ0IG4x3IBY
        OOf3bccHp+XcRTjP7vAPXTizfPOTPNEXLA==
X-Google-Smtp-Source: AMsMyM6djjkZEiLuZYR1fI5LcYTxnMzuOWyu7y08HSUl00ijIcJn5B4YtbIYEIlGWdzCV3nYXtA9FQ==
X-Received: by 2002:a05:6870:d591:b0:131:690d:eee1 with SMTP id u17-20020a056870d59100b00131690deee1mr5643510oao.16.1666011201948;
        Mon, 17 Oct 2022 05:53:21 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id j5-20020a544805000000b00342ded07a75sm4241933oij.18.2022.10.17.05.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 05:53:20 -0700 (PDT)
Date:   Mon, 17 Oct 2022 08:53:18 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Subject: Re: Handling Signal1 in microchip-tcb-capture
Message-ID: <Y01QPkE0E+HR7dat@fedora>
References: <Y0q7Gzh95nFdqdYK@fedora>
 <Y00nidri3TRYARiu@kb-xps>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TCvW1xSFv1qkcvL+"
Content-Disposition: inline
In-Reply-To: <Y00nidri3TRYARiu@kb-xps>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--TCvW1xSFv1qkcvL+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 17, 2022 at 11:59:37AM +0200, Kamel Bouhara wrote:
> On Sat, Oct 15, 2022 at 09:52:27AM -0400, William Breathitt Gray wrote:
> > I was looking over the microchip-tcb-capture driver recently and noticed
> > that the code doesn't seem to account for Signal1. In particular, it
> > appears that mchp_tc_count_signal_read() and mchp_tc_count_action_read()
> > don't check the Signal id at all and just assume they are handling
> > Signal0. This creates a situation where the information returned for the
> > Signal1 sysfs attributes are just duplicated reports of Signal0.
> >
> > What exactly is the relationship of Signal0 ("Channel A") and Signal1
> > ("Channel B"); is SignalB only relevant when the counter device is
> > configured for quadrature mode?
>=20
> Indeed both signals are required when in quadrature mode, where the
> signal0 is representing the speed and signal1 the revolution or number
> of rotation.
>=20
> We have described all availables modes in details in the following blog p=
ost: https://bootlin.com/blog/timer-counters-linux-microchip/
>=20
> Regards,
> Kamel

Thank you for the link, the block diagram helps illustrate how the
signals correlate to the TCB channels.

Let me check if I understand correctly. In microchip-tcb-capture.c,
mchp_tc_count_signals[0] is TIOA0 while mchp_tc_count_signals[1] is
TIOB0? In quadrature mode, are TIOA and TIOB the two phases of a
quadrature encoder? You mentioned one signal is speed while the other is
the number of rotations; does this mean one signal serves as the
position incrementation from a rotary wheel while the other signal is
the index (z-phase) indicate for each full rotation?

In particular, I'm having trouble understanding
mchp_tc_count_signal_read(). I suspect it is unintentionally always
returning the signal status for TIOA::

    regmap_read(priv->regmap, ATMEL_TC_REG(priv->channel[0], SR), &sr);
   =20
    if (priv->trig_inverted)
            sigstatus =3D (sr & ATMEL_TC_MTIOB);
    else
            sigstatus =3D (sr & ATMEL_TC_MTIOA);
   =20
    *lvl =3D sigstatus ? COUNTER_SIGNAL_LEVEL_HIGH : COUNTER_SIGNAL_LEVEL_L=
OW;

Here we read the status register for channel 0, select between TIOA and
TIOB based on priv->trig_inverted, and then return the signal level.

I don't see priv->trig_inverted referenced anywhere else so it appears
that priv->trig_inverted will always be 0, thus resulting in
mchp_tc_count_signal_read() always returning the TIOA status. I think
the intended behavior is to return the status of the selected signal::

    if (signal->id =3D=3D 1)
            sigstatus =3D (sr & ATMEL_TC_MTIOB);
    else
            sigstatus =3D (sr & ATMEL_TC_MTIOA);

As for mchp_tc_count_action_read(), we have a similar problem: no
distinction is made for the Synapse requested. The channel mode register
for channel 0 is read and then masked against ATMEL_TC_ETRGEDG to
determine the action mode. It appears that this code is always assuming
the Synapse for TIOA is requested, but the Synapse for TIOB could be
passed. You can determine which corresponding Signal you have by
checking synapse->signal->id before deciding what action mode to return.

To clarify, in COUNTER_FUNCTION_INCREASE mode, does the Count value
increment based on the edge of TIOA and not TIOB? In
COUNTER_FUNCTION_QUADRATURE_X4 mode, does the Count value increment
based on both edges of TIOA and TIOB serving as quadrature encoding
phase A and B signals?

The fixes for this issue are trivial enough that I can submit a patch
for them later, but I want to make sure I'm understanding the nature of
these signals correctly before I do so.

Thanks,

William Breathitt Gray

--TCvW1xSFv1qkcvL+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY01QPgAKCRC1SFbKvhIj
Kwy9AQDaqMYkC6xjsgKVdlnkA9ANd48JCEvS59uSWOc2NeHIjQD/eF5scHW7K3Tv
qAZtfsXw7R8kZeIDbsoOGxeVvMo8gQ0=
=4A+E
-----END PGP SIGNATURE-----

--TCvW1xSFv1qkcvL+--
