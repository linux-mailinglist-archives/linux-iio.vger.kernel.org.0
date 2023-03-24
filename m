Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595A96C7EBC
	for <lists+linux-iio@lfdr.de>; Fri, 24 Mar 2023 14:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjCXN0c (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Mar 2023 09:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbjCXN02 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Mar 2023 09:26:28 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B011C7E3
        for <linux-iio@vger.kernel.org>; Fri, 24 Mar 2023 06:26:17 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-544f7c176easo32489177b3.9
        for <linux-iio@vger.kernel.org>; Fri, 24 Mar 2023 06:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679664377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/4+hgYW6apNidWZ2eWxndApVq4c9LGlZUgQ8HGnG/YM=;
        b=wIxqgZulTguPL2eBnY7KKFTiLFfWsB5DxTGHxGyzaJDvUiT32yMYu6zbYRKhmPU+UF
         dReG9qGEJJSCXjVLX+j35LEn1tnjyzTCG3ayZO07kVHhGJuxO3BBvoWW22h4XKLywkc5
         F24YZ1VBvBuDeKm0ehW+fJV0vSBEY4AtR+AXwx8Rm4JVvj2MFZqS1oMlBS5ajplr93yS
         VI88s/iEkqLRh57LholqpmYHqa7jz4wgSoP7+AvgJ12j7eGHZMrFgfs12Aqgv2r8HiJG
         HaqIEYIgi9TRyP3t8AIYF/k9K6nY13mvLODxXVpAraVXhTnH0ngBaEQdZdtk3pfHANKV
         Sdng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679664377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4+hgYW6apNidWZ2eWxndApVq4c9LGlZUgQ8HGnG/YM=;
        b=5ZXmoeanh/SOPb4fTeslAsQUF7bxMpbK78z6bHPH1kOiwAxqX0jHDXMp63iBTOjb3h
         1a8B1lyMp9QF4JDepvTWxB0vOc4aETVOrn5cXBDZcxtU0A31V6D6dCN26RbvjDvJ7L1C
         XzydOEuSRuhDkqYRl5Ym56eecbO3bxIcaAprV8BXD1U0rjzEcE+KMfmFC7XRPtOmnvpn
         +jt3wxGMi4i/QJinOBMm5fUxftT1OXolOdXldvYHuykcN1INL7R5kbCGD/jQo/qvAo+9
         l8/s4bs6z5FOokOGI8PZfi3B/gyM5kCXTyphIlmUHhV9ev9m116h8AR10QgQvepQ/jRT
         lePQ==
X-Gm-Message-State: AAQBX9eZc+rqKMwp08+g3rLa0qIqe/mSabGeBqdsa1s2n8Sa0oZue7tb
        rmzf48JeKsLGM1thnv0M+/Dhb9glORm9o/GdhZxQiQ==
X-Google-Smtp-Source: AKy350a+oQQcX2Rv3Fysb0IwdJWRYo/W9Xhr2WxWZ8stfA1Ib+ZJCeVkiOatLvDRHmdDAcW/3Vcnfg==
X-Received: by 2002:a81:d348:0:b0:539:4475:ff64 with SMTP id d8-20020a81d348000000b005394475ff64mr2203598ywl.40.1679664376892;
        Fri, 24 Mar 2023 06:26:16 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id b2-20020a81bc42000000b00545a08184a7sm402507ywl.55.2023.03.24.06.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 06:26:16 -0700 (PDT)
Date:   Fri, 24 Mar 2023 09:26:14 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] counter: 104-quad-8: Refactor to buffer states
 for CMR, IOR, and IDR
Message-ID: <ZB2k9m7rL7Hpy/zU@fedora>
References: <cover.1679605919.git.william.gray@linaro.org>
 <c5adb13b4b0887beb1df40b34d2ef03d63a2860d.1679605919.git.william.gray@linaro.org>
 <ZB2OG4zZXsqqyN8v@smile.fi.intel.com>
 <ZB2Ob9VGe3GoEVko@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a1iK5qxqblY7GTai"
Content-Disposition: inline
In-Reply-To: <ZB2Ob9VGe3GoEVko@smile.fi.intel.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--a1iK5qxqblY7GTai
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 24, 2023 at 01:50:07PM +0200, Andy Shevchenko wrote:
> On Fri, Mar 24, 2023 at 01:48:43PM +0200, Andy Shevchenko wrote:
> > On Thu, Mar 23, 2023 at 05:25:28PM -0400, William Breathitt Gray wrote:
>=20
> ...
>=20
> > > +static void quad8_control_register_update(struct quad8 *const priv, =
u8 *const buf,
> > > +					  const size_t channel, const u8 val, const u8 field)
> > > +{
> > > +	u8p_replace_bits(&buf[channel], val, field);
> > > +	iowrite8(buf[channel], &priv->reg->channel[channel].control);
> > > +}
> >=20
> > How did you compile this?
> > Due to nature of *_replace_bits() this may only be a macro.
> >=20
> > That's what LKP is telling about I think.
>=20
> Ah, no, that's because the last parameter is not constant in the last pat=
ch in
> the series.
>=20
> --=20
> With Best Regards,
> Andy Shevchenko

I'm having trouble cross-compiling for riscv, but I'm unable to recreate
the build error when I compile for x86_64. However, I'd like to
understand this error so I can fix it properly.

Is the problem here due to the "const u8 field" parameter? Instead of a
constant variable, does this need to be a constant literal value for
u8p_replace_bits()? I don't think that parameter changed in the last
patch of the series, so why is the build error occurring for the last
patch and not this penultimate patch here? Would qualifying the
quad8_control_register_update() function with "__always_inline" resolve
this issue?

William Breathitt Gray

--a1iK5qxqblY7GTai
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZB2k9gAKCRC1SFbKvhIj
K41wAPwOf8OqdfF6dz3HKHzBtD3U1U1Ro93BWneFPEE7DoA5HAEAz2MYQ+iTfAXb
8emsDRSyFLpKXsQo0etP8qqlqS85sQc=
=7y20
-----END PGP SIGNATURE-----

--a1iK5qxqblY7GTai--
