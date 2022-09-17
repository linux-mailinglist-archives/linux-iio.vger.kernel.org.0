Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E8B5BB831
	for <lists+linux-iio@lfdr.de>; Sat, 17 Sep 2022 14:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiIQMae (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 17 Sep 2022 08:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiIQMad (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 17 Sep 2022 08:30:33 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE7F1C90D
        for <linux-iio@vger.kernel.org>; Sat, 17 Sep 2022 05:30:31 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id d15so17573851qka.9
        for <linux-iio@vger.kernel.org>; Sat, 17 Sep 2022 05:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=SoRjgGhFKB6qK5SZ5FRfYbus4A+LpnAUALssenPcRNw=;
        b=DRGeFDWw6ywgFiev+8bR2b/IIF8UK4365Ia9qU1CLMe37wREShyYJu7O9YobuPMtrN
         nUFJpUaptG9Ks8tSsq0PpDYb4etTC+mQKr4F4qsBWR4m+DYbBB+5EkjIgt4OBr8Z/Ba1
         ZLiCXlUoDdQe5vhzwTn+cm/M5EpOsAdQ9IkzmQ+kDoD1yZErQvjsEsozb4Folq7iTbwF
         itDFXQhckBlxtCCkU8jFZjnnK9vlCKP+sSfcVP1Y1idof6rgPsYQgveRAjxd3OuJIQmR
         iPzjxicjXpT5MLk8HF9fncRj3itQf3Et92GTNcUtHepsJnmEqtj2vdddw3D5JRlLqj7p
         yp0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=SoRjgGhFKB6qK5SZ5FRfYbus4A+LpnAUALssenPcRNw=;
        b=H5diaF1vL/wpeK8VYChcoWT8vUp+sED9eTgv4mPhgNHzEBD1IKVnuuLrgvZui6bP+H
         dPkp83xIhlVzkNt33g08ARlO5HJEN01srMZi9UnnO1fxISpDtW4bpyuS2Yj0A8oov3mh
         /wOBPU2BE+atFGV9uQ4l/5Ekr5BVXm9AJ0vQ0KZGnGoGA/amsfzn+11+jABMSJxxJh3f
         aQygYQo8eiSNT2kW1YvHNI+7FKbz1J3G3slHKHF1evRU0BdIjMKiDIDWlTnSU67Zauxe
         +pOxOkacZQfw/wEeBR3U78SuIPOWmQ74ltfu9tTK2I47ePejoSNXiuQ0qNL7TVdL6DWn
         d70Q==
X-Gm-Message-State: ACrzQf0Qp1ZzM3GKUrcHAD7iZCEMRjeGjd6GRPtUdMNexUL9p6pEUfgT
        e0k0xs0uopzh9fGNDWipw6d/oUnVDYyjjA==
X-Google-Smtp-Source: AMsMyM62I/JHP7ishLG4geRsyKFwJEE08kG23mRAOhUB4X5nlJCQMpyjDf4uDQkfGRwpyZ2oCHwmew==
X-Received: by 2002:a05:620a:404d:b0:6be:9818:ea49 with SMTP id i13-20020a05620a404d00b006be9818ea49mr7160919qko.197.1663417830909;
        Sat, 17 Sep 2022 05:30:30 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id x8-20020ac85388000000b0035bafecff78sm6708160qtp.74.2022.09.17.05.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Sep 2022 05:30:30 -0700 (PDT)
Date:   Sat, 17 Sep 2022 08:30:28 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mranostay@ti.com,
        jpanis@baylibre.com, gwendal@chromium.org, bleung@chromium.org,
        groeck@chromium.org, jic23@kernel.org, david@lechnology.com,
        robertcnelson@gmail.com
Subject: Re: [PATCH v2 4/4] counter: Introduce the COUNTER_COMP_ARRAY
 component type
Message-ID: <YyW95IoDkZl70V4a@fedora>
References: <cover.1663372750.git.william.gray@linaro.org>
 <f35ffc511f78148a10eb73b7d8abbe6c5d676973.1663372750.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7cjrr8ZiGM7f26cT"
Content-Disposition: inline
In-Reply-To: <f35ffc511f78148a10eb73b7d8abbe6c5d676973.1663372750.git.william.gray@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--7cjrr8ZiGM7f26cT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 16, 2022 at 08:39:28PM -0400, William Breathitt Gray wrote:
> +static int counter_array_attrs_create(struct device *const dev,
> +				      struct counter_attribute_group *const group,
> +				      const struct counter_comp *const comp,
> +				      const enum counter_scope scope,
> +				      void *const parent, const size_t id)
> +{
> +	const struct counter_array *const array = comp->priv;
> +	struct counter_comp ext = *comp;
> +	struct counter_array *element;
> +	size_t idx;
> +	int err;
> +
> +	/* Create an attribute for each array element */
> +	for (idx = 0; idx < array->length; idx++) {
> +		/* Set index for array element extension */
> +		element = ext.priv;
> +		element->idx = idx;

This is unintentionally overwriting the array length and thus skipping
the subsequent array elements. Instead, element should be a copy of the
array rather than a pointer to it. I'll fix this in a v3 release.

William Breathitt Gray

--7cjrr8ZiGM7f26cT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYyW95AAKCRC1SFbKvhIj
Kzx7AQDEzWxbBm3BxMXg8qMoL0Jgn5Swc8ZTmkDZsypU7P+klwEAl5icUdc8Qbii
gVuh9WqOSMihHfqIY54MxQ02rLbgyQU=
=tWcE
-----END PGP SIGNATURE-----

--7cjrr8ZiGM7f26cT--
