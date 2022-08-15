Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16FF592E13
	for <lists+linux-iio@lfdr.de>; Mon, 15 Aug 2022 13:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbiHOLUr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Aug 2022 07:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbiHOLUq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Aug 2022 07:20:46 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B076440
        for <linux-iio@vger.kernel.org>; Mon, 15 Aug 2022 04:20:45 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id y18so5198297qtv.5
        for <linux-iio@vger.kernel.org>; Mon, 15 Aug 2022 04:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=bJIP1g+hM09ON1k9gg6gh/O38Wa2udi8wQnWVY2ihvc=;
        b=df+rQmaCa/dDyhG2nv+cI1HBd1c962nhrgGBa+PujJ6Kh909sF4JHBvuiNrCITJl9q
         46IQR81rpbeGKpyQC8/40DoTp5eKsChnFFEdOGMaglFLMXl/cX6NWkfNiJ/XEYXuj1Fy
         VhokwlfDO7m3+p13ki78qU7lAs6JltwPt+FK0wS8bQMxDDn00r8BNBDnK+n9GXZxyCV4
         wfwRYz7hEY9Tg7/BwJWoRfFW/eSMGYodoOCMq4+9xqXq97m6OnsE2ru7de3v38SUDQYp
         US46t29f0L/fX4PN0pp6wNeO6euIlZi5KAVrQ0Oh6Bi6ycVFT+HPpKZVlKF3mcw9Wr9p
         qayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=bJIP1g+hM09ON1k9gg6gh/O38Wa2udi8wQnWVY2ihvc=;
        b=VMJAt49mZCxrehGuaMsEz0leF/DI8d7gARQImvjk/yiCUuYP9NWmy+qyh6s0C4Ux5N
         9mRmRR7TLIkOjor4GH3yJE/TsS75Si8/9sZr1SzaLB8IPhBiqrlK7EH8oz0gtbmzgv2k
         UrsroHLCmWqBmg+cy1W9cdDTqM3tIOL8jBRBz11PButN8obYpvYd7XAwfzbLP6HHf5ej
         AEN1djAYs69m68lhWHGUQE2phUYwOcyw94PwFe2ySwvZfakjYxJ7YFOsZEDRqs2DVh2V
         H4VbF34HDJlgIjnNgF8sxTfJrkAZ9/Muna1UWx0CuJ+Viy+HPw8HRpl1usVGFTjLX2Ry
         SuxA==
X-Gm-Message-State: ACgBeo1HGFDpJH1/rohHD4xcIXr5tCn4AMFsWbIPkycW/Ient01yRgw7
        osvnePIWf7gqi6r2HrYgEpDSJA==
X-Google-Smtp-Source: AA6agR6Uo4gOQmYOHVKq6A4bRccs3tlswCW1D9T7mB39zGFLyLZbdz/TCQRBVlIlo+IetyP5h2iAbg==
X-Received: by 2002:ac8:5d8b:0:b0:31e:ed61:b5a7 with SMTP id d11-20020ac85d8b000000b0031eed61b5a7mr13086482qtx.259.1660562444404;
        Mon, 15 Aug 2022 04:20:44 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id v3-20020a05620a440300b006b945519488sm6524983qkp.88.2022.08.15.04.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 04:20:43 -0700 (PDT)
Date:   Mon, 15 Aug 2022 07:20:41 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Julien Panis <jpanis@baylibre.com>
Cc:     vilhelm.gray@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mranostay@ti.com
Subject: Re: [PATCH v4 3/3] counter: capture-tiecap: capture driver support
 for ECAP
Message-ID: <YvosCeuntEKXJz+e@fedora>
References: <20220810140724.182389-1-jpanis@baylibre.com>
 <20220810140724.182389-4-jpanis@baylibre.com>
 <Yvkq9Hy+hxAPQd8J@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="31ldM9lRLLqWjxLp"
Content-Disposition: inline
In-Reply-To: <Yvkq9Hy+hxAPQd8J@fedora>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--31ldM9lRLLqWjxLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 14, 2022 at 01:03:48PM -0400, William Breathitt Gray wrote:
> On Wed, Aug 10, 2022 at 04:07:24PM +0200, Julien Panis wrote:
> > +static int ecap_cnt_function_read(struct counter_device *counter,
> > +				  struct counter_count *count,
> > +				  enum counter_function *function)
> > +{
> > +	*function =3D COUNTER_FUNCTION_INCREASE;
> > +
> > +	return 0;
> > +}
> > +
> > +static int ecap_cnt_action_read(struct counter_device *counter,
> > +				struct counter_count *count,
> > +				struct counter_synapse *synapse,
> > +				enum counter_synapse_action *action)
> > +{
> > +	*action =3D COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
> > +
> > +	return 0;
> > +}
>=20
> Right now you have a Signal defined for the ECAPSIG line, but there is
> at least one more relevant Signal to define: the clock updating ECAPCNT.
> The Synapse action of COUNTER_SYNAPSE_ACTION_BOTH_EDGES is for that
> clock Signal, but for the ECAPSIG Signal you will need to report a
> Synapse action based on the polarity of the next capture (i.e. whether
> high or low).

I need to make a correction here. IIUC, the ECAPSIG signal doesn't
affect the count value of ECAPCNT (ECAPSIG only triggers the captures),
so the Synapse action for ECAPSIG should always be
COUNTER_SYNAPSE_ACTION_NONE. You don't need to account for the capture
polarities because they're not relevant in this particular situation:
ECAPSIG doesn't trigger the ECAPCNT count function.

William Breathitt Gray

--31ldM9lRLLqWjxLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYvosCQAKCRC1SFbKvhIj
K6snAQCnHLXtaeFz7kheVRLMBzRZFRj428itPpXaS1E++G1YzQEA2He0P9PTIO3Z
/8rNAGJz0tq11HR2c//Aw5ROzM5DWQw=
=zMXK
-----END PGP SIGNATURE-----

--31ldM9lRLLqWjxLp--
