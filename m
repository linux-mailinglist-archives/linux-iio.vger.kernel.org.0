Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38565395FDB
	for <lists+linux-iio@lfdr.de>; Mon, 31 May 2021 16:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbhEaOQt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 May 2021 10:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233631AbhEaOOf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 31 May 2021 10:14:35 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21455C061574;
        Mon, 31 May 2021 06:41:26 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id c124so6445315qkd.8;
        Mon, 31 May 2021 06:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:from:to:cc
         :subject:references:in-reply-to;
        bh=XnIBaAJk34SkGPoBRAYrEmSzR77d9Lb1dvFbEISw98E=;
        b=RaqoFaQs26hbcut6UFNR3n7Y8G5hnJJ9ifDHdcFfkZIiY/NoKJCoaO5yvf90dyE/60
         CTF12bT3oTfR8L6g0zLO0ZP5hb+LK27eVWmpcxABMU8a3yVGQYtyv7FgBn18MvNwJ3XM
         wgtAn0V0zuEcMXqzkoxOVjZ48KZaoSJmQ4hkl1DzzwlDxbQlJb2lL3HF9GMqjrW8tG9u
         YfGiD6uT+ovoYOjk+kWlu0bq5NKswn0p/xdSiAHRHwoGojN3U60vBIHyVIBVe6Zp+uw/
         I5xLoOwoKAuPaKLpJaj6OvMfDZHrvrxMP4bKCDVE5KE2lfoNntaRJCtOdIiFOoFraBxp
         Kbug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:from:to:cc:subject:references:in-reply-to;
        bh=XnIBaAJk34SkGPoBRAYrEmSzR77d9Lb1dvFbEISw98E=;
        b=g+UgO1FtBSMdi2yl5caiV9TeZ7A/9MR9TPuVmI9QhDnfTjEd0mgMSOZ5DCcVLLrVFf
         MVQqgjjmArBgzkTOpR4GprDj13S7vT9hvXnwVdetMER1HS82lhbECRSDRjnxx/7QzTrQ
         fYqVFSF0clrR+GbcEeq5l27AwO3Z9x2/pSA5pRmH7jIdlpK9+fqKjpbxmpnsJuqbbQwc
         akpkptpGxuVR9VkFj/AyyICbs77ZPlEHmzsyHwYI9uy4TZoOoDKp/GPYsaQFRx1WSvM4
         O3aksEtAJmtLPLOSFYALp7oseXw9B2zxlFeGAH19rke+mP7N4xojCnAZXRzVYCTqhqZ2
         SBpw==
X-Gm-Message-State: AOAM530A2/ZXh4/VA568igfr4o6YJmFQfL4UNQLOmH5G1v5h1nrR6n2k
        w33t7FOofPhHUyJJrzWQ/tg=
X-Google-Smtp-Source: ABdhPJyBkCtf73OguHkU1IGu+i8ZUpuogY4xTBiCsmDv7zS2uScmDJWndQ33sLV71HFky6UbXd18Cw==
X-Received: by 2002:a05:620a:240c:: with SMTP id d12mr16704188qkn.190.1622468485359;
        Mon, 31 May 2021 06:41:25 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id f15sm8488007qtg.25.2021.05.31.06.41.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 06:41:24 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 31 May 2021 09:41:24 -0400
Message-Id: <CBRH2RWDHKFD.20XDGCMHA282F@shaak>
From:   "Liam Beguin" <liambeguin@gmail.com>
To:     "Peter Rosin" <peda@axentia.se>, <jic23@kernel.org>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v1 8/9] dt-bindings: iio: afe: add binding for
 temperature-sense-current
References: <20210530005917.20953-1-liambeguin@gmail.com>
 <20210530005917.20953-9-liambeguin@gmail.com>
 <9f38ad0a-0a08-458d-b721-f4d424cecc6d@axentia.se>
 <fe79916e-8ea8-5059-fd68-0e0ec621a2e1@axentia.se>
In-Reply-To: <fe79916e-8ea8-5059-fd68-0e0ec621a2e1@axentia.se>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Peter,

On Mon May 31, 2021 at 4:58 AM EDT, Peter Rosin wrote:
>
>
> On 2021-05-31 09:28, Peter Rosin wrote:
> >> +  use-kelvin-scale:
> >> +    type: boolean
> >> +    description: |
> >> +      Boolean indicating if alpha uses Kelvin degrees instead of Cels=
ius.
> >=20
> > It's "kelvin", not "Kelvin degrees", and it's "degrees Celsius".

I'll rephrase the description base on your comment.

I also thought of using alpha-micro-amps-per-degree-celsius and
alpha-micro-amps-kelvin instead. I don't know if that would be better.

Thanks,
Liam

> >=20
> > But what exactly is this property for? We always want degrees Celsius, =
don't we,
> > and any offset can be handled...with an offset. No?
>
> Ahh, I hit send too soon. I now see that you calculate the offset in the
> driver
> instead of requiring the devicetree author to do it "by hand".
>
> Cheers,
> Peter

