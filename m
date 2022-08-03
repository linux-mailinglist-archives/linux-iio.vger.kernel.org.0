Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5707D5891F5
	for <lists+linux-iio@lfdr.de>; Wed,  3 Aug 2022 19:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiHCR6o (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Aug 2022 13:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237137AbiHCR62 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 Aug 2022 13:58:28 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BBB5926D
        for <linux-iio@vger.kernel.org>; Wed,  3 Aug 2022 10:58:26 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id tk8so32803095ejc.7
        for <linux-iio@vger.kernel.org>; Wed, 03 Aug 2022 10:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ZRcfunu99w+EwGoL27A051YusA1LmvLUYabUbW7svPo=;
        b=PkLgxVH9E2lHpbprtXMuAwlbL4A4d7RRbGjUNt0nwV0bRwLUPQesyLmMK3pY7/J++0
         eTZWNcfuYbQSBW7XAy+YF8cqhynb1b/yCurhHcgRlGEqKeGoRWNJTrcL+ZoPDxdV5CW/
         7glg/eSP+TuzlpiQx0/IeDoFyaE2IZRLlmNEYlkZ05A5LUVL5+DBF6ySm3Xq4Of/eEUE
         fJQpO+L7bFEPEbDA771OqH8DHh/yiHjjF7mZtmr4rI7swWkUxc38lkvt8EBfgpkp8KbH
         UIlI7J6v1w92LjkVDDx6CCWJeVtUYD0fSdKj1FX802+XCfNdnZXGnliz/MhXkCEJhvbk
         knbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ZRcfunu99w+EwGoL27A051YusA1LmvLUYabUbW7svPo=;
        b=g8DCcIKXVdaCw3caWGiLn2HrIzptvVAieIe5cZeZPeNLjzXUeWnx5WmnX2z3c8sTsM
         IX0Wfv6nGYv8ThH1Ad4ecMlfHVCchtFG1nbgb99EmzrbYqqe8h/W2AYpg14njAewmV6n
         Npl9MA0g/tNrnGYAksKinDxj05jfGeSvRwx2lMnfFsjXEzyWQq5P3QrwwZEIyRU9D0Ry
         6nHcDvBmNAyy5YDTBav5NlBR+me4R9KWzuaWeaZXBNQRY1j+123LavfK0xFgaA4dEKO2
         v0peyHbvliDWzcWZWk654NdmrndnrG8Vmdmh0NequR0fWtTvHYKU4Ag5N0q7SV7+SZ7G
         ZDSA==
X-Gm-Message-State: ACgBeo3/8FePOzFLg+dqL4A1LhbIorTkvfrJ1s0Vt2EgY9l+zrEI9lWR
        9iqm32GN8SXzFi4FIEr20Wads2Kx78ONMC2ebEULvggsCr+lBA==
X-Google-Smtp-Source: AA6agR6VHND53cW1/+rBOSDfb2r3Zlk5pzJ8Us6bKvd0zhFBU9Lktn+aGaHhchro9DjaL34Dd0bEO2uZs4Ipvv9HK2E=
X-Received: by 2002:a17:906:e8f:b0:730:9480:9728 with SMTP id
 p15-20020a1709060e8f00b0073094809728mr10210956ejf.99.1659549505100; Wed, 03
 Aug 2022 10:58:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220803115720.89848-1-matt.ranostay@konsulko.com>
In-Reply-To: <20220803115720.89848-1-matt.ranostay@konsulko.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 3 Aug 2022 19:57:45 +0200
Message-ID: <CAHp75VeBSxHK_Nf+PSvRtACeszGeomUyK8Cx1V1FpFiSS013Cw@mail.gmail.com>
Subject: Re: [PATCH] iio: add NULL pointer checks to iio device additional/removal
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Aug 3, 2022 at 2:04 PM Matt Ranostay <matt.ranostay@konsulko.com> wrote:
>
> Check if __iio_device_register and iio_device_unregister indio_dev
> parameter isn't a NULL pointer.

We refer to functions as func() in the text.

...

>  int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
>  {
> -       struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> +       struct iio_dev_opaque *iio_dev_opaque;
>         struct fwnode_handle *fwnode;
>         int ret;
>
> -       if (!indio_dev->info)
> +       if (!indio_dev || !indio_dev->info)
>                 return -EINVAL;
>
> +       iio_dev_opaque = to_iio_dev_opaque(indio_dev);

Not sure we need this one. All callers check for indio_dev from the
allocator, otherwise I don't see a clean workflow when indio_dev is
NULL when calling register(). The other part is good.

-- 
With Best Regards,
Andy Shevchenko
