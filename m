Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3377C9124
	for <lists+linux-iio@lfdr.de>; Sat, 14 Oct 2023 01:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbjJMXDd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Oct 2023 19:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjJMXDd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Oct 2023 19:03:33 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9A2BE
        for <linux-iio@vger.kernel.org>; Fri, 13 Oct 2023 16:03:31 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-7b625d782b9so1081712241.2
        for <linux-iio@vger.kernel.org>; Fri, 13 Oct 2023 16:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697238210; x=1697843010; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rcn85z62MW6ga0naGLzuTjsyYsLiQwr0ThT4Anw3LQg=;
        b=BQsNjhkMDfJskhnmNfWzaus27gbDoaDZ9uSIIYaJCGO0RXPm3WooZ5HgabWmNIbOAK
         Mmkm/AbDjQVee3KVfu3/KBVYcimxsAJ2ZquZU4fwOFAPb+CUpX6Woxyofv0K1M8XmpVQ
         q7r+YLMa2d1KfTq9PKUoS/stmKNgPMLz0KX99i5N9u1twYjPQMzrznAVuOeRwVZiPB8I
         XbefDsEZYUOV9Zcgbx01MeO8LQRmiDI/6lngutx3wvWWgj+Sjx0CnHPsrnmrjbzhcnft
         Xop1tArTQHBIUoddJd/RiGT2VVK81Ad8BXc2yUzp1RDvYf/VNKSUo/EcTBrF08z6bqTY
         P3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697238210; x=1697843010;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rcn85z62MW6ga0naGLzuTjsyYsLiQwr0ThT4Anw3LQg=;
        b=jBcdK2gNS/Cn3qLoOICQH+JFbXohseO5/nwz/LN5i01j69hBDSQC3+d6BOSGD+1Gxm
         3jNdkxaCcRnvoqcU1UEDUEqhqHVxR+4UK+YfTqO4OQ/E8UeOcm114o+epYCXF6lbX/xI
         1GbW9iZnEi5GeFIYYeZdjaqMyjlVzAhMOLUuio/jBHE15BbSfN2BWEcgPah1hhL+7xtP
         vque7HlRZQIXm7XGbakDIoDPD1BZEG7QBQuFXfv9i+hnqeUjwG3+osyJSJmD4V0F6Id7
         iu5OegIsu+ciSrQJyR6/8Yg1dPB+clVha7Osw8P0plz3FHzfNQMAInbHfsxQefPVPPM7
         9hiA==
X-Gm-Message-State: AOJu0YwKy0Z9KscOb0QhZtvOLJWJ3BR/IDXwBIYRJHQUVvTF7Hxa4295
        rYlTOW0Wid4SAzG1rG6nE/LaqA==
X-Google-Smtp-Source: AGHT+IESShPQpD+fP8oD44dOFdRAXvUyePnVcWCuKhsxWqQa7Q51s71AiV0cNscNwQFJMSB6GIsyvA==
X-Received: by 2002:a67:ec53:0:b0:452:7617:a757 with SMTP id z19-20020a67ec53000000b004527617a757mr27797924vso.26.1697238210704;
        Fri, 13 Oct 2023 16:03:30 -0700 (PDT)
Received: from fedora (072-189-067-006.res.spectrum.com. [72.189.67.6])
        by smtp.gmail.com with ESMTPSA id c12-20020ab0694c000000b0078cc4e0d7e3sm551678uas.27.2023.10.13.16.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 16:03:30 -0700 (PDT)
Date:   Fri, 13 Oct 2023 19:03:06 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     lee@kernel.org, alexandre.torgue@foss.st.com,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] counter: stm32-timer-cnt: add support for events
Message-ID: <ZSnMqienA28Phx6b@fedora>
References: <20230922143920.3144249-1-fabrice.gasnier@foss.st.com>
 <20230922143920.3144249-7-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pxeJ7ygJWhyBF1Hz"
Content-Disposition: inline
In-Reply-To: <20230922143920.3144249-7-fabrice.gasnier@foss.st.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--pxeJ7ygJWhyBF1Hz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 22, 2023 at 04:39:20PM +0200, Fabrice Gasnier wrote:
> Add support for capture and overflow events. Also add the related
> validation and configuration. Captured counter value can be retrieved
> through CCRx register. Register and enable interrupts to push events.
>=20
> Acked-by: Lee Jones <lee@kernel.org>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Hi Fabrice,

Please split the capture and overflow events code to their own patches.

I think there will be some changes to this patch anyway due to the
changes you'll make in the precursor patches, so I'll hold off until v3
to review.

William Breathitt Gray

--pxeJ7ygJWhyBF1Hz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZSnMqgAKCRC1SFbKvhIj
K6CGAP9OtP4qcJ/aIPKgrEecjHFXVX6zX1mOr8ftEiECf8/tVAD/cjbV86RlHwaQ
f/v03XJrz5ibiBFz53tKPk1+KnZ76AQ=
=cWtK
-----END PGP SIGNATURE-----

--pxeJ7ygJWhyBF1Hz--
