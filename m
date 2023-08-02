Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81FA976CCD2
	for <lists+linux-iio@lfdr.de>; Wed,  2 Aug 2023 14:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234500AbjHBMhS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Aug 2023 08:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjHBMhR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Aug 2023 08:37:17 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A108270F
        for <linux-iio@vger.kernel.org>; Wed,  2 Aug 2023 05:37:15 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fe0c566788so11355228e87.0
        for <linux-iio@vger.kernel.org>; Wed, 02 Aug 2023 05:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1690979834; x=1691584634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NbOtrbuAbCVZChFvcVrSuATOys/C2fprGpeUD9URBHg=;
        b=QRO9Nxa1SiODUkYydluq+gWpZ7lZ4XtHwTuzFSmZAxcvSEOXaPNKSd0GU9Xf8+SG/+
         5jHKrezoWOdT8A59vVUo/48L1hVgSbYcSBkDf/IjVovPMZp5WW5oSMcl6ULsMEaKFhXI
         5r36JgkUedq4jVrtbcLTjUtCFLZXqEiMQ+hq1Yo9JkCBfArXgXMitEiCxmpI9DJnFMxM
         0KZPyDGh6ei2tbkA2duXrB5Sf7utXuFg8CazYqjnLCU1fY2A6mMAbNcgGMtzrkcvH19+
         BKBu8/hfAxmkDKwoMb5W2JxkPFhuNhhJAet7izdaXPJXFFC/DFb4Iv+NvGOdGtTYQ0U0
         HYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690979834; x=1691584634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NbOtrbuAbCVZChFvcVrSuATOys/C2fprGpeUD9URBHg=;
        b=kG6VNYMCy8zweOQ1aRtJ7K1gxwNdxIl4fHK6DGYnzKfs2okJPpQ0aDr98Kw0EtqkPr
         Ln9E4Xw9l3NUTr1vdRmkO9/g05sZLbemN5deyedIb8yAexvfGCipY/3/JSaj4bd8WOpN
         BSa6V1/otCo/u9i6EJsLCdKKNLKomsoKToGnTQPVHj2VbtZIf8Yqelo10U4nilxBd4qB
         VN8ItdZigcOw06nEJt95pK9tuQJv+IOzmEHLzrZN+FczoybNTTteS8ehXR6906iAEs7V
         plXp5DYOzOM9Nynn0wPtHF7v+nW0dwTG2V8HdAl61MPgsZyRyTeEkC9Jf/AIeav7IGFN
         LeQQ==
X-Gm-Message-State: ABy/qLbOY7djyEhPlCqoD/myqsxvChttku7xd7Xw/HQxNWSrPPlUSDcw
        Z0z65CfKckJ5yQmmMSAOLHgnrz3iN4o71cv44Ce2JQ==
X-Google-Smtp-Source: APBJJlGPcZH9vNmqB+R7XZfYsW3LGvr8Ed/uiifd4Mh50scxNI/J+i41X6mfphDAdRHRWKO0PLYVyMZqq/CNNewyYpg=
X-Received: by 2002:a05:6512:70b:b0:4f8:6833:b13c with SMTP id
 b11-20020a056512070b00b004f86833b13cmr4141389lfs.14.1690979833551; Wed, 02
 Aug 2023 05:37:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230802120915.25631-1-aboutphysycs@gmail.com>
In-Reply-To: <20230802120915.25631-1-aboutphysycs@gmail.com>
From:   Alexandru Ardelean <alex@shruggie.ro>
Date:   Wed, 2 Aug 2023 15:37:02 +0300
Message-ID: <CAH3L5QpuoDYU6qvWH7_z5Yx0cW2qPMbCA8AFEYAPsiEkSzCiwQ@mail.gmail.com>
Subject: Re: [PATCH] iio: trigger: stm32-lptimer-trigger: remove unneeded platform_set_drvdata()
To:     Andrei Coardos <aboutphysycs@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-iio@vger.kernel.org, alexandre.torgue@foss.st.com,
        mcoquelin.stm32@gmail.com, lars@metafoo.de, jic23@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Aug 2, 2023 at 3:09=E2=80=AFPM Andrei Coardos <aboutphysycs@gmail.c=
om> wrote:
>
> This function call was found to be unnecessary as there is no equivalent
> platform_get_drvdata() call to access the private data of the driver. Als=
o,
> the private data is defined in this driver, so there is no risk of it bei=
ng
> accessed outside of this driver file.
>
> Reviewed-by: Alexandru Ardelean <alex@shruggie.ro>
> Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
> ---
>  drivers/iio/trigger/stm32-lptimer-trigger.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/iio/trigger/stm32-lptimer-trigger.c b/drivers/iio/tr=
igger/stm32-lptimer-trigger.c
> index 2e447a3f047d..df2416e33375 100644
> --- a/drivers/iio/trigger/stm32-lptimer-trigger.c
> +++ b/drivers/iio/trigger/stm32-lptimer-trigger.c
> @@ -92,8 +92,6 @@ static int stm32_lptim_trigger_probe(struct platform_de=
vice *pdev)
>         if (ret)
>                 return ret;

this can become now:

            return stm32_lptim_setup_trig(priv);


>
> -       platform_set_drvdata(pdev, priv);
> -
>         return 0;
>  }
>
> --
> 2.34.1
>
