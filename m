Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364725F1754
	for <lists+linux-iio@lfdr.de>; Sat,  1 Oct 2022 02:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbiJAAZ1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 30 Sep 2022 20:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbiJAAZE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Sep 2022 20:25:04 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240D124952
        for <linux-iio@vger.kernel.org>; Fri, 30 Sep 2022 17:23:01 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id s18so3629673qtx.6
        for <linux-iio@vger.kernel.org>; Fri, 30 Sep 2022 17:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=x4vt+CWV+xG5t7iFXTxxs3JWTPPF+kbcbI8t7m8zKAM=;
        b=qwWkMfemkBcpkXKFVl7TIKmMAEEG2joHouDsM0tjY7J9rsKE8PT/P9n1lu58DOuXpG
         TcEPWogEColr3miARJ0YYjUoQiJKnax+EFD8kV8U2RbkoCjWRZ8I+EKs65NZbwDJtoqT
         eQn2LmZ7NUoRoah7TPUxKykBvz1qcalrYCpjneyyL2HY8jBQIR7LUnEMLRukss2flaz+
         wUA5MnpGXryCFM9TPP6+cxpHjmLe08mEdNFLF2kkdLGT1kffKnt5wxNRQvXw9mn3ealF
         97pX6qFnXPdAlkvmjwil3ML/en9yzDuQpU6hS/dKQjpxrnJUUcqsHEoiT3ZMvv4nBSO3
         Otxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=x4vt+CWV+xG5t7iFXTxxs3JWTPPF+kbcbI8t7m8zKAM=;
        b=ZqqGHGSIg/18Ih4cnNmwbh4Vi5FwNtFX/0tQetraOELD0y+jebB7k7G+Srf5FHDCB9
         ryseBkG+KYqFJrm3l56I1hWqYJHJFiJqXo/vFK3m7aSvo0sfbaZBF72yG/n5/RZ7XB4N
         aQWbcAAUhnXqoR0j9jeHjqVfggvCbFOnKpyMfEaca+OYSz3bSWUKR3LWKgCUexgpU2jG
         r3qeFscmzdXlr379AOzpy3/XZ2aNPakrGbsZo81LgIY/DQRRgoVXNAM6AUVW8RCKpRT7
         Xnj5Wo7ZkZjZQ32+dlqX8aq1kJmkrfhjvruxF13iTkLNtgSds7hoHqRmMKUCpQD2UL+V
         aing==
X-Gm-Message-State: ACrzQf1gcv+Q3T8Je7U3ymBPywLTKxMQyerDQ8avmgTJ8P6JQiCKnDPK
        RDwIeIgbZQaZ0zX+2uVcUP1jlA==
X-Google-Smtp-Source: AMsMyM6aVmmUg051HW0jO80PEl3XY7p07fblFRfwkIhlo6cLpNq3Dz1FBnZtayZAnBPUqtkVeOk8Lw==
X-Received: by 2002:ac8:5cd5:0:b0:35b:bbd1:20ea with SMTP id s21-20020ac85cd5000000b0035bbbd120eamr8949706qta.549.1664583779952;
        Fri, 30 Sep 2022 17:22:59 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id x4-20020a05620a448400b006ceda7a9283sm3872710qkp.48.2022.09.30.17.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 17:22:58 -0700 (PDT)
Date:   Fri, 30 Sep 2022 20:22:56 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH RFC 5/8] counter: Add RZ/G2L MTU3 counter driver
Message-ID: <YzeIYLrZTHGXfcOV@fedora>
References: <20220926132114.60396-1-biju.das.jz@bp.renesas.com>
 <20220926132114.60396-6-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WWAWRr4QfURyjFgV"
Content-Disposition: inline
In-Reply-To: <20220926132114.60396-6-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--WWAWRr4QfURyjFgV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 26, 2022 at 02:21:11PM +0100, Biju Das wrote:
> Add RZ/G2L MTU3 counter driver. Currently it supports 16-bit phase
> counting mode on MTU{1,2} channels.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Hi Biju,

This driver will likely change in your next revision, but I want to give
some feedback anyway on a few things I noticed. See the comments below.

> +struct rzg2l_mtu3_cnt {
> +	struct clk *clk;
> +	void __iomem *mmio;
> +	struct rzg2l_mtu3_channel *ch;
> +};

Add kernel-doc comments to document this structure. It seems that
neither clk nor mmio is access in the code from this structure; what's
the purpose of having them here?

> +static int rzg2l_mtu3_count_read(struct counter_device *counter,
> +				 struct counter_count *count, u64 *val)
> +{
> +	struct rzg2l_mtu3_cnt *const priv =3D counter_priv(counter);
> +	u32 cnt;
> +
> +	cnt =3D rzg2l_mtu3_16bit_ch_read(priv->ch, RZG2L_MTU3_TCNT);
> +	*val =3D cnt;

The rzg2l_mtu3_16bit_ch_read() function returns a u16, so there's no
need for the cnt variable; just return the count via val directly.

> +static int rzg2l_mtu3_count_write(struct counter_device *counter,
> +				  struct counter_count *count, const u64 val)
> +{
> +	struct rzg2l_mtu3_cnt *const priv =3D counter_priv(counter);
> +	u16 ceiling;
> +
> +	ceiling =3D rzg2l_mtu3_16bit_ch_read(priv->ch, RZG2L_MTU3_TGRA);
> +
> +	if (val > ceiling)
> +		return -EINVAL;

Return -ERANGE instead to indicate the request is outside the boundary.

> +
> +	rzg2l_mtu3_16bit_ch_write(priv->ch, RZG2L_MTU3_TCNT, (u16)val);

Remove the explicit cast to u16, it's already implicit in the call. You
probably also need some sort of lock in this function to ensure that
your ceiling value does not change before you write to the register.

> +static int rzg2l_mtu3_count_ceiling_read(struct counter_device *counter,
> +					 struct counter_count *count,
> +					 u64 *ceiling)
> +{
> +	struct rzg2l_mtu3_cnt *const priv =3D counter_priv(counter);
> +	u32 val;
> +
> +	val =3D rzg2l_mtu3_16bit_ch_read(priv->ch, RZG2L_MTU3_TGRA);
> +	*ceiling =3D val;

Same comment as in rzg2l_mtu3_count_read().

> +static int rzg2l_mtu3_count_ceiling_write(struct counter_device *counter,
> +					  struct counter_count *count,
> +					  u64 ceiling)
> +{
> +	struct rzg2l_mtu3_cnt *const priv =3D counter_priv(counter);
> +
> +	if (ceiling > U16_MAX)
> +		return -ERANGE;
> +
> +	rzg2l_mtu3_16bit_ch_write(priv->ch, RZG2L_MTU3_TGRA, (u16)ceiling);
> +	rzg2l_mtu3_8bit_ch_write(priv->ch, RZG2L_MTU3_TCR,
> +				 RZG2L_MTU3_TCR_CCLR_TGRA);

Same comments about cast and lock as in rzg2l_mtu3_count_write().

> +static int rzg2l_mtu3_count_enable_read(struct counter_device *counter,
> +					struct counter_count *count, u8 *enable)
> +{
> +	struct rzg2l_mtu3_cnt *const priv =3D counter_priv(counter);
> +	int ch =3D priv->ch->index;
> +
> +	*enable =3D (rzg2l_mtu3_shared_reg_read(priv->ch, RZG2L_MTU3_TSTRA) &
> +		(0x1 << ch)) >> ch;

A lot of operations happening in a single line; can this be broken down
to clearer distinct steps?

> +static int rzg2l_mtu3_action_read(struct counter_device *counter,
> +				  struct counter_count *count,
> +				  struct counter_synapse *synapse,
> +				  enum counter_synapse_action *action)
> +{
> +	enum counter_function function;
> +	int err;
> +
> +	err =3D rzg2l_mtu3_count_function_read(counter, count, &function);
> +	if (err)
> +		return err;
> +
> +	switch (function) {
> +	case COUNTER_FUNCTION_PULSE_DIRECTION:
> +		/*
> +		 * Rising edges on signal A updates the respective count.
> +		 * The input level of signal B determines direction.
> +		 */
> +		*action =3D COUNTER_SYNAPSE_ACTION_RISING_EDGE;

You need to differentiate between signal A and B here: the Synapse for
signal A will have an action mode of COUNTER_SYNAPSE_ACTION_RING_EDGE,
but the Synapse for Signal B will have an action mode of
COUNTER_SYNAPSE_ACTION_NONE because its not the trigger point for the
respective Count value update.

> +		break;
> +	case COUNTER_FUNCTION_QUADRATURE_X2_B:
> +		/*
> +		 * Any state transition on quadrature pair signal B updates
> +		 * the respective count.
> +		 */
> +		*action =3D COUNTER_SYNAPSE_ACTION_BOTH_EDGES;

Similar to above, you need to differentiate between signal A and B here
as well.

> +static struct counter_count rzg2l_mtu3_counts =3D {
> +	.id =3D 0,

The id member is an optional way for driver authors to identify their
own Counts; it can be set to anything your like, and if you don't use
it in your code then you don't need to set it at all.

> +static int rzg2l_mtu3_cnt_probe(struct platform_device *pdev)
> +{
> +	struct rzg2l_mtu3 *ddata =3D dev_get_drvdata(pdev->dev.parent);
> +	struct device *dev =3D &pdev->dev;
> +	struct counter_device *counter;
> +	struct rzg2l_mtu3_cnt *priv;
> +	int ret;
> +	u32 ch;
> +
> +	if (IS_ERR_OR_NULL(ddata))
> +		return -EINVAL;

Is this actually possible? What situation would cause this, and why is
it not handled before we reach probe()?

> +
> +	counter =3D devm_counter_alloc(dev, sizeof(*priv));
> +	if (!counter)
> +		return -ENOMEM;
> +
> +	priv =3D counter_priv(counter);
> +
> +	ret =3D of_property_read_u32(dev->of_node, "reg", &ch);
> +	if (ret) {
> +		dev_err(dev, "%pOF: No reg property found\n", dev->of_node);
> +		return -EINVAL;
> +	}
> +
> +	if (ch !=3D RZG2L_MTU1 && ch !=3D RZG2L_MTU2) {
> +		dev_err(dev, "%pOF: Invalid channel '%u'\n", dev->of_node, ch);
> +		return -EINVAL;
> +	}
> +
> +	priv->clk =3D ddata->clk;
> +	priv->ch =3D &ddata->channels[ch];
> +	priv->ch->dev =3D dev;
> +
> +	counter->name =3D dev_name(dev);
> +	counter->parent =3D dev;
> +	counter->ops =3D &rzg2l_mtu3_cnt_ops;
> +	counter->counts =3D &rzg2l_mtu3_counts;
> +	counter->num_counts =3D 1;

Even though you only have one Count defined, use ARRAY_SIZE here for
consistency with the other Counter drivers as well as making the
intention of the code clear.

> +	counter->signals =3D rzg2l_mtu3_signals;
> +	counter->num_signals =3D ARRAY_SIZE(rzg2l_mtu3_signals);
> +	platform_set_drvdata(pdev, priv);
> +
> +	/* Register Counter device */
> +	ret =3D devm_counter_add(dev, counter);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to add counter\n");

The Counter driver goes live with the call to devm_counter_add() so move
it to the end after your device initialization code below.

> +
> +	priv->ch->function =3D RZG2L_MTU3_16BIT_PHASE_COUNTING;
> +	ret =3D clk_prepare_enable(ddata->clk);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Phase counting mode 1 will be used as default
> +	 * when initializing counters.
> +	 */
> +	rzg2l_mtu3_8bit_ch_write(priv->ch, RZG2L_MTU3_TMDR1,
> +				 RZG2L_MTU3_TMDR1_PH_CNT_MODE_1);
> +
> +	/* Initialize 16-bit counter max value */
> +	rzg2l_mtu3_8bit_ch_write(priv->ch, RZG2L_MTU3_TCR,
> +				 RZG2L_MTU3_TCR_CCLR_TGRA);
> +	rzg2l_mtu3_16bit_ch_write(priv->ch, RZG2L_MTU3_TGRA, U16_MAX);
> +
> +	clk_disable(ddata->clk);

Should this be moved up near the clk_prepare_enable() call above?

> +MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");
> +MODULE_ALIAS("platform:rzg2l-mtu3-counter");
> +MODULE_DESCRIPTION("Renesas RZ/G2L MTU3a counter driver");
> +MODULE_LICENSE("GPL");

Add MODULE_IMPORT_NS(COUNTER) to import the COUNTER namespace.

Make sure you're based on top of the counter-next branch. You can find
the Counter tree here: https://git.kernel.org/pub/scm/linux/kernel/git/wbg/=
counter.git

William Breathitt Gray

--WWAWRr4QfURyjFgV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYzeIYAAKCRC1SFbKvhIj
K8EfAP9ZBiff/7TzJlbvOLvhigQ7YWhtKlryc3g3B5RqHnYW5wD9Hpr7/VISymx3
lmeGUKCORZvQjtolxLt7e1XHdlcxogA=
=zGnA
-----END PGP SIGNATURE-----

--WWAWRr4QfURyjFgV--
