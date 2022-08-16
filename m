Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF66595EEB
	for <lists+linux-iio@lfdr.de>; Tue, 16 Aug 2022 17:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236088AbiHPPWy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Aug 2022 11:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236077AbiHPPWx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Aug 2022 11:22:53 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2DE82D10
        for <linux-iio@vger.kernel.org>; Tue, 16 Aug 2022 08:22:51 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id j6so8330867qkl.10
        for <linux-iio@vger.kernel.org>; Tue, 16 Aug 2022 08:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=jT6iuOkP/KCXgNgpKbeKBLLjw+3KLDIzLYKXQZiNLYs=;
        b=MiDRnXjwdBKgIi27CYdBNeS5oDJfFwAd2TBir5Ho8jleWQdN0Ap6ezN9+AHlOE2+Qr
         7x30r4gzLKCnth/jkAO66P9EAT3CyPnTPKt2/ksS3wgcgScs7tTd6S/1oVau/Gc5R0o/
         dsenaC5o/iC6GztkI3eQ6oA5FVxqTbZ1uV9+NcjEtIDXWekgYPkz/mx8/qD3fzZefhKZ
         TTdHDEMkvwnQNKkA04NB1GCv8T2kpo0Gjvleiltk3T4rgsyYdv+eFuEFJGmlRvyycAiR
         ZZxZh0HQDAv1LNY6uwvN6xoQYLkutC73klWNLVf9w/k44pRn967zmI0qLdAXGQEN3C5E
         7t3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=jT6iuOkP/KCXgNgpKbeKBLLjw+3KLDIzLYKXQZiNLYs=;
        b=AzbEE5iNokeJO06ICXm2SmGWfChdGYq7+Gs5yr/D589h+sUUAq5//Oi+6Yo9C+cZyO
         74ILMfL5LkUV3orZ9xGICLq3mUviNBzOSfsm73xuHi0JeHwcqJq62xRGUpOuQd9m7ayy
         0lVn8mXpHycHqLbBzfE7TYfgraSrzN7Qm3F0sD6SqnGtziZqFngdG8VEZSVMlnT4U7wV
         RcnTEChkmovq71zPrtwq8/nbnqWlJjkaHxmeu6+CmWNHAcFHoM/JDGz5sH8Oh/NyKZOn
         PcIHhnu+U0jBqIMZ9O3M5K4uzVqjSHXeE4ToPdzmqXQOTLG/BU6EBZsZv2UJYQRzqLXA
         SMQg==
X-Gm-Message-State: ACgBeo0Z86MKe9uvz/k+WYWoNNFtEAvPt1aJXi6E3oB53RfT4tNtzVdW
        jcpOkBL2DA7u+qqNY33yAYqy9Q==
X-Google-Smtp-Source: AA6agR5DT8IuYw0mAD2K36WSO8rzZ7Hkyf6rxMM9+v0nWk5fHU2EhOkFFG6BkRrCB09Z4KG4dJZ7QA==
X-Received: by 2002:a05:620a:1a9b:b0:6a6:d3f6:5c97 with SMTP id bl27-20020a05620a1a9b00b006a6d3f65c97mr15175583qkb.225.1660663370607;
        Tue, 16 Aug 2022 08:22:50 -0700 (PDT)
Received: from fedora ([23.82.142.208])
        by smtp.gmail.com with ESMTPSA id v3-20020a05620a440300b006b945519488sm9623161qkp.88.2022.08.16.08.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 08:22:50 -0700 (PDT)
Date:   Tue, 16 Aug 2022 11:22:48 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Julien Panis <jpanis@baylibre.com>
Cc:     vilhelm.gray@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mranostay@ti.com
Subject: Re: [PATCH v4 3/3] counter: capture-tiecap: capture driver support
 for ECAP
Message-ID: <Yvu2SFKy6efHa+r3@fedora>
References: <20220810140724.182389-1-jpanis@baylibre.com>
 <20220810140724.182389-4-jpanis@baylibre.com>
 <Yvkq9Hy+hxAPQd8J@fedora>
 <YvosCeuntEKXJz+e@fedora>
 <0730c493-b49f-02f5-c0e7-999d5871dc4a@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="joL9fFR8nEuznmrQ"
Content-Disposition: inline
In-Reply-To: <0730c493-b49f-02f5-c0e7-999d5871dc4a@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--joL9fFR8nEuznmrQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 16, 2022 at 10:11:35AM +0200, Julien Panis wrote:
> On 15/08/2022 13:20, William Breathitt Gray wrote:
> > On Sun, Aug 14, 2022 at 01:03:48PM -0400, William Breathitt Gray wrote:
> > > On Wed, Aug 10, 2022 at 04:07:24PM +0200, Julien Panis wrote:
> > > > +static int ecap_cnt_function_read(struct counter_device *counter,
> > > > +				  struct counter_count *count,
> > > > +				  enum counter_function *function)
> > > > +{
> > > > +	*function =3D COUNTER_FUNCTION_INCREASE;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int ecap_cnt_action_read(struct counter_device *counter,
> > > > +				struct counter_count *count,
> > > > +				struct counter_synapse *synapse,
> > > > +				enum counter_synapse_action *action)
> > > > +{
> > > > +	*action =3D COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
> > > > +
> > > > +	return 0;
> > > > +}
> > > Right now you have a Signal defined for the ECAPSIG line, but there is
> > > at least one more relevant Signal to define: the clock updating ECAPC=
NT.
> > > The Synapse action of COUNTER_SYNAPSE_ACTION_BOTH_EDGES is for that
> > > clock Signal, but for the ECAPSIG Signal you will need to report a
> > > Synapse action based on the polarity of the next capture (i.e. whether
> > > high or low).
> > I need to make a correction here. IIUC, the ECAPSIG signal doesn't
> > affect the count value of ECAPCNT (ECAPSIG only triggers the captures),
> > so the Synapse action for ECAPSIG should always be
> > COUNTER_SYNAPSE_ACTION_NONE. You don't need to account for the capture
> > polarities because they're not relevant in this particular situation:
> > ECAPSIG doesn't trigger the ECAPCNT count function.
> >=20
> > William Breathitt Gray
>=20
> It appears to me that you spoke about TSCNT register content (32 bits). S=
o,
> you were
> not talking about the Mod4 counter (2 bits).
> Do you confirm that ?

Yes, I meant the TSCNT register. Sorry about that!

The Counter subsystem is providing an abstraction for users, so although
the ECAP pin signal is serving physically on the device as a clock for
the Mod4 counter, it also serves the TSCNT counter in an abstract sense
as the trigger signal to capture the TSCNT value. The Counter subsystem
paradigm allows you to define these abstract relationships between
Counts and Signals as Synapses.

William Breathitt Gray

--joL9fFR8nEuznmrQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYvu2SAAKCRC1SFbKvhIj
KzqtAQDggpFX/Wl1JrWkKSL6rjcqDHr/JKzg+czwZHsmvq/3jAEAtHTNxOOtJCDs
yDgJcJb8m2mnG3KOYttsRGkFaiZM3Qk=
=Aa8N
-----END PGP SIGNATURE-----

--joL9fFR8nEuznmrQ--
