Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64357C90AA
	for <lists+linux-iio@lfdr.de>; Sat, 14 Oct 2023 00:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbjJMWtF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Oct 2023 18:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbjJMWsz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Oct 2023 18:48:55 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D9EF4
        for <linux-iio@vger.kernel.org>; Fri, 13 Oct 2023 15:48:43 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-7b0ec7417bdso937448241.2
        for <linux-iio@vger.kernel.org>; Fri, 13 Oct 2023 15:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697237322; x=1697842122; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M7+2V0YlS8ZDKtKvIbNHqNSalMBU1GrhT1IpSjeCQTw=;
        b=UNQVJSsxI8ctH20b3lEKDbATUeA6G5VtwrsLCnQVx2NVrdkKw0Zx+CWWg+v6UP+4VY
         fUrK6LhAKnWHZi0ONqbG1+3AGe66E6ppdjCNS1DKeNOhF3ory8yj1P9iNCFAEYHk8yaL
         bzPHw+3fYwOIrTEQLfoWeCIclS0hvdzr9dvRi6EZA24CuxseF9MbmkxGgsKtMJzGJr8O
         vF/GWU65CN/VDVDWZ6nThLaBnqnW2Wp7EuP28hOV41eU4GJiDkc/Ls0uGdp7WFk56yxi
         9L02ByyyEuicIdAD1do/aRhd1Km6Rrr1/m3MaN/1UYg9tsig6CwZ/LCzDRC/IP9SXV5f
         n5Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697237322; x=1697842122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7+2V0YlS8ZDKtKvIbNHqNSalMBU1GrhT1IpSjeCQTw=;
        b=ZGWqMnGorrTu2i/xO3AtbQwF3QFP20/xl9VhwOpYIFyWzhVqxQL8/2cTihfA2w5l5Q
         Z9uG2ipiX8CdBC8jQtR48XVOsgcyiXC3S4Q8Uw/lSDM61fvKy29B4yge8uf6520q6Bal
         tQSclAggUqTo8oR/OybzpQp/KE3IG2PEOPEOcSyyQ12RHxJ6b+fpZ7eVBp9l6R/9VHgO
         jER8lIESZlqSIqFxGHvB+l6F/62FiOzvtrHcvQ3R8Vd1m5knx2y8K03/8supjPYLKBN5
         sBbPQQWdm+O9+F2HO3+ryLK6q6g98cMB9Ro8pDjmg5DIFxxkuj6yErZthyq3xi56XQfa
         FG0w==
X-Gm-Message-State: AOJu0Yw8dZRzH+Iou/QTq0nOLXCP4WnHyeWz4CkBuV9fD4PUXwZpujub
        Ts/EYxYDbkM2LCT8UfcqPfzcTg==
X-Google-Smtp-Source: AGHT+IF7jx2I05oes/GMbZo7J3cDYSck7gV+oLZiWc5TQCd+sjI62q0d0Zzk234dBluUdpibqgZoIA==
X-Received: by 2002:a67:f4d3:0:b0:452:66a7:1ac with SMTP id s19-20020a67f4d3000000b0045266a701acmr27391344vsn.6.1697237322128;
        Fri, 13 Oct 2023 15:48:42 -0700 (PDT)
Received: from fedora (072-189-067-006.res.spectrum.com. [72.189.67.6])
        by smtp.gmail.com with ESMTPSA id bi6-20020a05610234e600b0045255981807sm551389vsb.0.2023.10.13.15.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 15:48:41 -0700 (PDT)
Date:   Fri, 13 Oct 2023 18:48:39 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     lee@kernel.org, alexandre.torgue@foss.st.com,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] counter: stm32-timer-cnt: populate capture
 channels and check encoder
Message-ID: <ZSnJR2yfYsBNHu/4@fedora>
References: <20230922143920.3144249-1-fabrice.gasnier@foss.st.com>
 <20230922143920.3144249-6-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DOR58DHOIf3n8XuL"
Content-Disposition: inline
In-Reply-To: <20230922143920.3144249-6-fabrice.gasnier@foss.st.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--DOR58DHOIf3n8XuL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 22, 2023 at 04:39:19PM +0200, Fabrice Gasnier wrote:
> This is a precursor patch to support capture channels on all possible
> channels and stm32 timer types. Original driver was intended to be used
> only as quadrature encoder and simple counter on internal clock.
>=20
> So, add ch3 and ch4 definition. Also add a check on encoder capability,
> so the driver may be probed for timer instances without encoder feature.
> This way, all timers may be used as simple counter on internal clock,
> starting from here.

Hi Fabrice,

Let's split the encoder capability probing code, detect number of
channels code, and channel introduction code to their own patches in
order to simplify things.

> Encoder capability is retrieved by using the timer index (originally in
> stm32-timer-trigger driver and dt-bindings). The need to keep backward
> compatibility with existing device tree lead to parse aside trigger node.
> Add diversity as STM32 timers with capture feature may have either 4, 2,
> 1 or no cc (capture/compare) channels.
>=20
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

I think this patch is more complicated than it needs to be.

> @@ -400,13 +558,47 @@ static int stm32_timer_cnt_probe(struct platform_de=
vice *pdev)
>  	priv->clk =3D ddata->clk;
>  	priv->max_arr =3D ddata->max_arr;
> =20
> +	ret =3D stm32_timer_cnt_probe_encoder(pdev, priv);
> +	if (ret)
> +		return ret;
> +
> +	stm32_timer_cnt_detect_channels(pdev, priv);
> +
>  	counter->name =3D dev_name(dev);
>  	counter->parent =3D dev;
>  	counter->ops =3D &stm32_timer_cnt_ops;
> -	counter->counts =3D &stm32_counts;
>  	counter->num_counts =3D 1;
> -	counter->signals =3D stm32_signals;
> -	counter->num_signals =3D ARRAY_SIZE(stm32_signals);

Keep this the same.

> +
> +	/*
> +	 * Handle diversity for stm32 timers features. For now encoder is found=
 with
> +	 * advanced timers or gp timers with 4 channels. Timers with less chann=
els
> +	 * doesn't support encoder.
> +	 */
> +	switch (priv->nchannels) {
> +	case 4:
> +		if (priv->has_encoder)
> +			counter->counts =3D &stm32_counts_enc_4ch;
> +		else
> +			counter->counts =3D &stm32_counts_4ch;
> +		counter->signals =3D stm32_signals;
> +		counter->num_signals =3D ARRAY_SIZE(stm32_signals);
> +		break;
> +	case 2:
> +		counter->counts =3D &stm32_counts_2ch;
> +		counter->signals =3D stm32_signals;
> +		counter->num_signals =3D 3; /* clock, ch1 and ch2 */
> +		break;
> +	case 1:
> +		counter->counts =3D &stm32_counts_1ch;
> +		counter->signals =3D stm32_signals;
> +		counter->num_signals =3D 2; /* clock, ch1 */
> +		break;
> +	default:
> +		counter->counts =3D &stm32_counts;
> +		counter->signals =3D stm32_signals;
> +		counter->num_signals =3D 1; /* clock */
> +		break;
> +	}

Rather than adjusting the number of counts and signals, keep the
configuration static and use a single stm32_counts array. The reason is
that in the Counter subsystem paradigm Signals do not necessary
correlate to specific hardware signals but are rather an abstract
representation of the device behavior at a high level. In other words, a
Synapse with an action mode set to COUNTER_SYNAPSE_ACTION_NONE can be
viewed as representing a Signal that does not affect the Count (i.e. in
this case equivalent to an unconnected line).

What you'll need to do instead is check priv->nchannels during
stm32_action_read and stm32_count_function_read calls in order to return
the correct synapse action and count function for the particular
channels configuration you have. In stm32_count_function_write you would
return an -EINVAL (maybe -EOPNOTSUPP would be better?) when the channels
configuration does not support a particular count function.

William Breathitt Gray

--DOR58DHOIf3n8XuL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZSnJRwAKCRC1SFbKvhIj
K0moAQD7wGvZVP3oXlqW7ObHpexVDKnM0MGwBchWQQSXSCVj9QEApHtanCqbJLLZ
mWbFf52y1xmscsdAdL7XhWiNLieTCQM=
=2nuH
-----END PGP SIGNATURE-----

--DOR58DHOIf3n8XuL--
